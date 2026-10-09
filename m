Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0BDCA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFCb5-0002ET-A9; Fri, 09 Oct 2026 11:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCZ7-0001SS-2L
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCZ5-00081G-J6
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791559878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IA704wAeoDB8vavu6DoaN71Zbtw9BZUbE43n3y+Elro=;
 b=eBw7uytq/RniXHnxiJasL0nact1iLwegeLLu4yy8W/WtrJMqfZabD5cQd3FCoSRuWbn1Jw
 u31KLs/KKPRseSILpUJv2K6N74fG8TSYd3CJ4f/LmpT8mYVJMP8ak843KEke5bZyn7/0QV
 dr7c2oXxtwlIgtjBBhhwkPAVCuQj4H8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53--B6uBTZRMO6K0r5r_4cvUw-1; Fri,
 9 Oct 2026 15:31:09 +0000
X-MC-Unique: -B6uBTZRMO6K0r5r_4cvUw-1
X-Mimecast-MFC-AGG-ID: -B6uBTZRMO6K0r5r_4cvUw_1791559868
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38EB219541AA; Fri,  9 Oct 2026 15:31:08 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87CCC471; Fri,  9 Oct 2026 15:31:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: akalenyu@redhat.com, <qemu-block@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 5/8] pr-manager-helper: add PR_HELPER_CLEANUP command support
Date: Fri,  9 Oct 2026 11:30:55 -0400
Message-ID: <20261009153058.1089786-6-stefanha@redhat.com>
In-Reply-To: <20261009153058.1089786-1-stefanha@redhat.com>
References: <20261009153058.1089786-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

qemu-pr-helper now supports the vendor-specific PR_HELPER_CLEANUP SCSI
command. Add support to the client side.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scsi/pr-manager-helper.c | 20 ++++++++++++++++----
 scsi/utils.c             |  3 +++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 26ef3876f0e..fa6611ed676 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -38,6 +38,8 @@ struct PRManagerHelper {
 
     QemuMutex lock;
     QIOChannel *ioc;
+
+    uint32_t proto_flags; /* flags negotiated with pr-helper */
 };
 
 static void pr_manager_send_status_changed_event(PRManagerHelper *pr_mgr)
@@ -129,8 +131,9 @@ static int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,
         goto out_close;
     }
 
-    flags = 0;
-    r = pr_manager_helper_write(pr_mgr, -1, &flags, sizeof(flags), errp);
+    pr_mgr->proto_flags = flags & PR_HELPER_FEATURE_CLEANUP;
+    r = pr_manager_helper_write(pr_mgr, -1, &pr_mgr->proto_flags,
+                                sizeof(pr_mgr->proto_flags), errp);
     if (r < 0) {
         goto out_close;
     }
@@ -160,10 +163,19 @@ static int pr_manager_helper_run(PRManager *p,
         return -EINVAL;
     }
 
+    /* The command is only available when pr-helper supports it */
+    if (cdb[0] == PR_HELPER_CLEANUP &&
+        !(pr_mgr->proto_flags & PR_HELPER_FEATURE_CLEANUP)) {
+        return -ENOTSUP;
+    }
+
     memcpy(cdb, io_hdr->cmdp, io_hdr->cmd_len);
-    assert(cdb[0] == PERSISTENT_RESERVE_OUT || cdb[0] == PERSISTENT_RESERVE_IN);
+    assert(cdb[0] == PERSISTENT_RESERVE_OUT ||
+           cdb[0] == PERSISTENT_RESERVE_IN ||
+           cdb[0] == PR_HELPER_CLEANUP);
     expected_dir =
-        (cdb[0] == PERSISTENT_RESERVE_OUT ? SG_DXFER_TO_DEV : SG_DXFER_FROM_DEV);
+        (cdb[0] == PERSISTENT_RESERVE_IN ?
+         SG_DXFER_FROM_DEV : SG_DXFER_TO_DEV);
     if (io_hdr->dxfer_direction != expected_dir) {
         return -EINVAL;
     }
diff --git a/scsi/utils.c b/scsi/utils.c
index daee90ecf0e..1ee68e68221 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -29,6 +29,9 @@ uint32_t scsi_data_cdb_xfer(uint8_t *buf)
 
 uint32_t scsi_cdb_xfer(uint8_t *buf)
 {
+    if (buf[0] == PR_HELPER_CLEANUP) {
+        return 0;
+    }
     switch (buf[0] >> 5) {
     case 0:
         return buf[4];
-- 
2.56.0


