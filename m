Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FBCCF319C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svurz-00025P-08; Wed, 02 Oct 2024 04:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svurq-00020z-Ai
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svurn-0005kJ-Kp
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727858271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8dGE0A38f5VTr5H+JPJ+JEIz9Dt2fSH4V7WEzu6LPU=;
 b=hYyPoRaMbGCut+ODGZ4PRoflrtlnYJcVaYn7+4dNEVpLMhWmeA39Bao+yvozf9b3PND9+L
 oucM1TJIqBlquM/hlY4JLlxEvME0iVAlQ2a7SD2KsIAJZCBjFHTHPkXJ9PwGMgCytYeC1v
 5yXmq3fLREYhMMF/qESZaSD0CAZPmbc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-VpFDo23YONS-wzo8d0dvXw-1; Wed,
 02 Oct 2024 04:37:48 -0400
X-MC-Unique: VpFDo23YONS-wzo8d0dvXw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5971B1955F0D; Wed,  2 Oct 2024 08:37:46 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 224CB19560A2; Wed,  2 Oct 2024 08:37:44 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 12/22] migration: fix -Werror=maybe-uninitialized
 false-positives
Date: Wed,  2 Oct 2024 12:36:35 +0400
Message-ID: <20241002083646.2893078-13-marcandre.lureau@redhat.com>
In-Reply-To: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
References: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


