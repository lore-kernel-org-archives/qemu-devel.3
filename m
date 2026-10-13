Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C92CCC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGh4m-0006xB-75; Tue, 13 Oct 2026 14:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGh4k-0006wE-En
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 14:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGh4i-00014D-Gd
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 14:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791915487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e2FszP+j+LJd9q+6jyCBEoMTLUNHgvd+OqVEeBa43Yk=;
 b=PWpg1bXI0v4GMi1Wwrx08s40LUvOMB1qwLDoRPRv+StJSES/26d6nGwpheEugIOtFXjEvq
 J41hSfCPSX4Y1Nyf56vArXvrKnvbwOzCM46ywgZL+A29yc0hynR2+qEcEVEKsWRc4RjwSk
 e5Tvvzbepo/AOej+W18sAQNkM/ZoRbo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-fnaGemL-MRWSaaXKQSY-mA-1; Tue,
 13 Oct 2026 18:18:05 +0000
X-MC-Unique: fnaGemL-MRWSaaXKQSY-mA-1
X-Mimecast-MFC-AGG-ID: fnaGemL-MRWSaaXKQSY-mA_1791915483
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E93F19352EB; Tue, 13 Oct 2026 18:18:03 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32AC2180057E; Tue, 13 Oct 2026 18:18:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 akalenyu@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 5/8] pr-manager-helper: add PR_HELPER_CLEANUP command
 support
Date: Tue, 13 Oct 2026 14:17:49 -0400
Message-ID: <20261013181752.1299456-6-stefanha@redhat.com>
In-Reply-To: <20261013181752.1299456-1-stefanha@redhat.com>
References: <20261013181752.1299456-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

pr_manager_helper_run() uses scsi_cdb_xfer() to determine the number of
bytes to transfer. Extend scsi_cdb_xfer() to know that this
vendor-specific command does not transfer any bytes.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
- Move cdb[0] check after copy from io_hdr
- Add missing endianness conversion for protocol flags
---
 scsi/pr-manager-helper.c | 20 +++++++++++++++++---
 scsi/utils.c             |  3 +++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 26ef3876f0e..e7162e21ff0 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -38,6 +38,8 @@ struct PRManagerHelper {
 
     QemuMutex lock;
     QIOChannel *ioc;
+
+    uint32_t proto_flags; /* flags negotiated with pr-helper */
 };
 
 static void pr_manager_send_status_changed_event(PRManagerHelper *pr_mgr)
@@ -129,7 +131,9 @@ static int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,
         goto out_close;
     }
 
-    flags = 0;
+    pr_mgr->proto_flags = be32_to_cpu(flags) & PR_HELPER_FEATURE_CLEANUP;
+
+    flags = cpu_to_be32(pr_mgr->proto_flags);
     r = pr_manager_helper_write(pr_mgr, -1, &flags, sizeof(flags), errp);
     if (r < 0) {
         goto out_close;
@@ -161,9 +165,19 @@ static int pr_manager_helper_run(PRManager *p,
     }
 
     memcpy(cdb, io_hdr->cmdp, io_hdr->cmd_len);
-    assert(cdb[0] == PERSISTENT_RESERVE_OUT || cdb[0] == PERSISTENT_RESERVE_IN);
+    assert(cdb[0] == PERSISTENT_RESERVE_OUT ||
+           cdb[0] == PERSISTENT_RESERVE_IN ||
+           cdb[0] == PR_HELPER_CLEANUP);
+
+    /* The command is only available when pr-helper supports it */
+    if (cdb[0] == PR_HELPER_CLEANUP &&
+        !(pr_mgr->proto_flags & PR_HELPER_FEATURE_CLEANUP)) {
+        return -ENOTSUP;
+    }
+
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


