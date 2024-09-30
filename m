Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43449CF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBbE-0007sF-Eh; Mon, 30 Sep 2024 04:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svBaB-0004dV-PO
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svBa9-0005qG-1C
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727684196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8dGE0A38f5VTr5H+JPJ+JEIz9Dt2fSH4V7WEzu6LPU=;
 b=COaj88y/I5Q5S0mNdwqxHu+aw6i6OzHzckvxBZNxFNshKIb2ldc+ig2DnhZ0ZHfntWhlA7
 JSZlPqCSzOnKpwtvQRjlDYK6rzqbrAv8UstjcAFfnKPE+hOskZFBfRFQkdnj4bsa0T1d8a
 mrBybZDcJYHRoC5mWc3AzWyA7hrzlBE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-leZvvJVBOCydAAzUohkKSg-1; Mon,
 30 Sep 2024 04:16:32 -0400
X-MC-Unique: leZvvJVBOCydAAzUohkKSg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D71661933140; Mon, 30 Sep 2024 08:16:29 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D10F91955DC7; Mon, 30 Sep 2024 08:16:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-block@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 12/22] migration: fix -Werror=maybe-uninitialized
 false-positives
Date: Mon, 30 Sep 2024 12:14:47 +0400
Message-ID: <20240930081458.1926382-13-marcandre.lureau@redhat.com>
In-Reply-To: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/dirtyrate.c | 4 ++--
 migration/migration.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 5478d58de3..233acb0855 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -149,12 +149,12 @@ int64_t vcpu_calculate_dirtyrate(int64_t calc_time_ms,
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
index ae2be31557..021faee2f3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2278,7 +2278,7 @@ static bool migrate_handle_rp_resume_ack(MigrationState *s,
  */
 static void migration_release_dst_files(MigrationState *ms)
 {
-    QEMUFile *file;
+    QEMUFile *file = NULL;
 
     WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
         /*
-- 
2.45.2.827.g557ae147e6


