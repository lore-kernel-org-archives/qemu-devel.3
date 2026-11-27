Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F995606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Nkd4fkWb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoz9-0005A6-CW; Fri, 27 Nov 2026 00:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoyz-0004mp-7V; Fri, 27 Nov 2026 00:58:54 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoys-0006IO-B5; Fri, 27 Nov 2026 00:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=+8H2bQdpluRxlagkHA4omJNWUDBPRKMlAzcKh1utdaw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Nkd4fkWbHSIT8UUC7q+rWXXAeYiEYvBAw/s75mqxy7CxhGhxr2v3B74M0ztUTjI7Q
 vdKK2vup7QGnRB6Yb+8N5sCLfBoWyNLC2OC2/Qt064IR/7cFeB5ebl2dI5huDG1Ujk
 FIrN8cWLPvGq7/fG+Lhve9eQFwbqtafeML5EmOqvBL5gWeU0042qoLrbzhmDH01hOg
 Qnp13q8UTSiCqf0QR1513bwi1D5svsR4ubxP2fYWMi3AOSsD8u6bXfynsaX+csfDU7
 Tt6ADf6y3ycRmdp/oCyAczq17UPwHezERmDIIoB9NbcKv2uHy1+Zi5gqr8gNJmM/wH
 mvwNy3r91Tk1w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D74D81EA2F5;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D4F9B469930;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B0687CF26C; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 107/140] hw/scsi: validate IU buffer bounds in
 vscsi_preprocess_desc()
Date: Fri, 27 Nov 2026 08:53:33 +0300
Message-ID: <20261127055421.39015-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
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

cdb_offset and local_desc values are dependent on the guest. If the value
is large enough, it can lead to an out-of-bounds read in vscsi_fetch_desc().

Add an 'avail' constant in vscsi_preprocess_desc() representing the number of
bytes available in srp_cmd.add_data[] and use it to prevent out-of-bound reads.

Make all callers of vscsi_preprocess_desc() check its return value and
handle failure accordingly.

Fixes: CVE-2026-132127
Fixes: 8ca8a17c9a16 (pseries: rework PAPR virtual SCSI)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4162
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260819095855.115823-1-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
(cherry picked from commit 8a91c8327cc8ffe0291af8f7d2970b7e2d6239ed)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 60efcca9570..76b87a6464b 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -484,6 +484,8 @@ static int data_out_desc_size(struct srp_cmd *cmd)
 static int vscsi_preprocess_desc(vscsi_req *req)
 {
     struct srp_cmd *cmd = &req_iu(req)->srp.cmd;
+    /* bytes available for descriptors behind srp_cmd.add_data */
+    const unsigned avail = SRP_MAX_IU_LEN - offsetof(struct srp_cmd, add_data);
 
     req->cdb_offset = cmd->add_cdb_len & ~3;
 
@@ -498,16 +500,35 @@ static int vscsi_preprocess_desc(vscsi_req *req)
     case SRP_NO_DATA_DESC:
         break;
     case SRP_DATA_DESC_DIRECT:
+        if (req->cdb_offset + sizeof(struct srp_direct_buf) > avail) {
+            fprintf(stderr,
+                    "vscsi_preprocess_desc: direct desc out of bounds\n");
+            return -1;
+        }
         req->total_desc = req->local_desc = 1;
         break;
     case SRP_DATA_DESC_INDIRECT: {
-        struct srp_indirect_buf *ind_tmp = (struct srp_indirect_buf *)
-                (cmd->add_data + req->cdb_offset);
+        struct srp_indirect_buf *ind_tmp;
+
+        if (req->cdb_offset + sizeof(struct srp_indirect_buf) > avail) {
+            fprintf(stderr,
+                    "vscsi_preprocess_desc: indirect desc out of bounds\n");
+            return -1;
+        }
+        ind_tmp = (struct srp_indirect_buf *)(cmd->add_data + req->cdb_offset);
 
         req->total_desc = be32_to_cpu(ind_tmp->table_desc.len) /
                           sizeof(struct srp_direct_buf);
         req->local_desc = req->writing ? cmd->data_out_desc_cnt :
                           cmd->data_in_desc_cnt;
+
+        /* desc_list[] entries must also fit inside the IU buffer */
+        if (req->local_desc * sizeof(struct srp_direct_buf) >
+            avail - req->cdb_offset - sizeof(struct srp_indirect_buf)) {
+            fprintf(stderr,
+                    "vscsi_preprocess_desc: local_desc out of bounds\n");
+            return -1;
+        }
         break;
     }
     default:
@@ -717,7 +738,11 @@ static void vscsi_inquiry_no_target(VSCSIState *s, vscsi_req *req)
     memcpy(&resp_data[8], "QEMU    ", 8);
 
     req->writing = 0;
-    vscsi_preprocess_desc(req);
+    if (vscsi_preprocess_desc(req) < 0) {
+        vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
+        vscsi_send_rsp(s, req, CHECK_CONDITION, 0, 0);
+        return;
+    }
     rc = vscsi_srp_transfer_data(s, req, 0, resp_data, len);
     if (rc < 0) {
         vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
@@ -767,7 +792,12 @@ static void vscsi_report_luns(VSCSIState *s, vscsi_req *req)
         i += 8;
     }
 
-    vscsi_preprocess_desc(req);
+    if (vscsi_preprocess_desc(req) < 0) {
+        g_free(resp_data);
+        vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
+        vscsi_send_rsp(s, req, CHECK_CONDITION, 0, 0);
+        return;
+    }
     rc = vscsi_srp_transfer_data(s, req, 0, resp_data, len);
     g_free(resp_data);
     if (rc < 0) {
@@ -815,7 +845,10 @@ static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *req)
         req->writing = (n < 1);
 
         /* Preprocess RDMA descriptors */
-        vscsi_preprocess_desc(req);
+        if (vscsi_preprocess_desc(req) < 0) {
+            scsi_req_cancel(req->sreq);
+            return 1;
+        }
 
         /* Get transfer direction and initiate transfer */
         if (n > 0) {
-- 
2.47.3


