Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E854DC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpmur-0007s8-UJ; Thu, 28 Mar 2024 06:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rpmul-0007hS-DV
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rpmuk-0007re-1h
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711621397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=acVh+/q6KY41u8ad+OHkKnZLq8ZGC8P1uBZmJsqBzzg=;
 b=Zo+Rnlbf9eQh9Gq1OhKC1OpOQ25cLaJ7bVcbrJEoMQA4MKvapaMdCoQKo7hK12k9w6lg+f
 ln++iAvlASgEq+gCwkayRB96RVCeguY3wv+ItcJZwfrn4J0ixYBXdVfiM6aeLP1XWPo7Xy
 6B0TEhX97Aq5gti8jBYNKR2MRbNzr0Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-vAnWjIWyPIOl2o7vc8gn7w-1; Thu,
 28 Mar 2024 06:23:13 -0400
X-MC-Unique: vAnWjIWyPIOl2o7vc8gn7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6151F3815EF6;
 Thu, 28 Mar 2024 10:23:12 +0000 (UTC)
Received: from localhost (unknown [10.39.208.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 368B01121306;
 Thu, 28 Mar 2024 10:23:09 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 12/19] migration: fix -Werror=maybe-uninitialized
 false-positives
Date: Thu, 28 Mar 2024 14:20:45 +0400
Message-ID: <20240328102052.3499331-13-marcandre.lureau@redhat.com>
In-Reply-To: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../migration/dirtyrate.c:186:5: error: ‘records’ may be used uninitialized [-Werror=maybe-uninitialized]
../migration/dirtyrate.c:168:12: error: ‘gen_id’ may be used uninitialized [-Werror=maybe-uninitialized]
../migration/migration.c:2273:5: error: ‘file’ may be used uninitialized [-Werror=maybe-uninitialized]

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/dirtyrate.c | 4 ++--
 migration/migration.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 1d2e85746f..22dd22922c 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -144,12 +144,12 @@ int64_t vcpu_calculate_dirtyrate(int64_t calc_time_ms,
                                  unsigned int flag,
                                  bool one_shot)
 {
-    DirtyPageRecord *records;
+    DirtyPageRecord *records = NULL;
     int64_t init_time_ms;
     int64_t duration;
     int64_t dirtyrate;
     int i = 0;
-    unsigned int gen_id;
+    unsigned int gen_id = 0;
 
 retry:
     init_time_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
diff --git a/migration/migration.c b/migration/migration.c
index 9fe8fd2afd..412138ea94 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2247,7 +2247,7 @@ static bool migrate_handle_rp_resume_ack(MigrationState *s,
  */
 static void migration_release_dst_files(MigrationState *ms)
 {
-    QEMUFile *file;
+    QEMUFile *file = NULL;
 
     WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
         /*
-- 
2.44.0


