Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2253A606A332
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=NR/qfosy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3OH-00048I-4n; Mon, 16 Nov 2026 15:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3NH-0002NR-Co; Mon, 16 Nov 2026 15:32:25 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3ND-0004uF-RP; Mon, 16 Nov 2026 15:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860768; bh=nrUtHJNCt2EEtnQRM6xZInrtOQPJWtR8pqVWFRyNxRM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NR/qfosyWNa8KM2nDGTTkK5B4u4UrL5vHj9TgIowxeGNfKA5yuII+jinhKVduVBV/
 wgbWckptO7pn3lLzi9o1rBlyFOH26CK9L3CPNQwMekkQrWMOnKCq6+qwOH5LEOVxxq
 quzdc/TRaI1wVGmpW92foPGbhdTgSY+zVvAaqrqsoO2VjQ9aBZEODp7L+EwybunXXy
 U/8uyKiAT9UveOTOg8ixu8iAROze04n7q+42k9m68FCBIX1Dh65Qb45HPKO8ej0Wrm
 pYVrR7E43BCX6QfmWO2XXqTtqwQtPL7UqrScFMffTXmhmXz1ZFtw9GAvn0tos7jLjY
 cPzjLE7PAQjFw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 14B671E71CF;
 Mon, 16 Nov 2026 23:26:08 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 11AD345FBFA;
 Mon, 16 Nov 2026 23:26:08 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id F2894B8EB8; Mon, 16 Nov 2026 23:26:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Guthrie McAfee Armstrong <git@gmarmstrong.dev>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 57/63] spapr-vscsi: clamp adapter info DMA write
 length to struct size
Date: Mon, 16 Nov 2026 23:25:36 +0300
Message-ID: <20261116202554.535325-57-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chinmay Rath <rathc@linux.ibm.com>

vscsi_send_adapter_info() used the guest-supplied common.length
field directly as the size argument to spapr_vio_dma_write().
Since common.length is controlled by the guest, a value larger
than sizeof(struct mad_adapter_info_data) (148 bytes) caused
dma_memory_write() to read past the end of the stack-allocated info
struct, leaking arbitrary host stack contents into guest memory.

Fix this by clamping the write length to sizeof(info), then using
spapr_vio_dma_set() to zero-fill any remaining bytes the guest
requested beyond that size. This mirrors the existing pattern in
vscsi_send_capabilities().

Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4626
Reported-by: Guthrie McAfee Armstrong <git@gmarmstrong.dev>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261007144434.374749-1-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
(cherry picked from commit 74e68729ca8ee576bef823798ffc80589b1edd63)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index b4c8f94d22a..7ec780da79e 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -966,6 +966,8 @@ static int vscsi_send_adapter_info(VSCSIState *s, vscsi_req *req)
 {
     struct viosrp_adapter_info *sinfo;
     struct mad_adapter_info_data info;
+    uint16_t len, req_len;
+    uint64_t buffer;
     int rc;
 
     sinfo = &req_iu(req)->mad.adapter_info;
@@ -985,11 +987,23 @@ static int vscsi_send_adapter_info(VSCSIState *s, vscsi_req *req)
     info.os_type = cpu_to_be32(2);
     info.port_max_txu[0] = cpu_to_be32(VSCSI_MAX_SECTORS << 9);
 
-    rc = spapr_vio_dma_write(&s->vdev, be64_to_cpu(sinfo->buffer),
-                             &info, be16_to_cpu(sinfo->common.length));
+    req_len = len = be16_to_cpu(sinfo->common.length);
+    buffer = be64_to_cpu(sinfo->buffer);
+    if (len > sizeof(info)) {
+        fprintf(stderr, "vscsi_send_adapter_info: adapter info size mismatch !\n");
+        /*
+         * Just read and populate the structure that is known.
+         * Zero rest of the structure.
+         */
+        len = sizeof(info);
+    }
+    rc = spapr_vio_dma_write(&s->vdev, buffer, &info, len);
     if (rc)  {
         fprintf(stderr, "vscsi_send_adapter_info: DMA write failure !\n");
     }
+    if (req_len > len) {
+        spapr_vio_dma_set(&s->vdev, (buffer + len), 0, (req_len - len));
+    }
 
     sinfo->common.status = rc ? cpu_to_be32(1) : 0;
 
-- 
2.47.3


