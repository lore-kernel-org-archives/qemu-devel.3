Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4099E7FDDC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn176-00078I-8T; Mon, 02 Feb 2026 16:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn175-00077B-D4; Mon, 02 Feb 2026 16:05:39 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn173-0005H8-Oo; Mon, 02 Feb 2026 16:05:39 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2A5A61851D3;
 Mon, 02 Feb 2026 23:57:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E99BA35B34A;
 Mon, 02 Feb 2026 23:58:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 71/74] hw/ufs: fix CQE endianness and UPIU length
Date: Mon,  2 Feb 2026 23:58:22 +0300
Message-ID: <20260202205833.941615-71-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

Round-trip UTRD fields through cpu_to_le/ le_to_cpu when building MCQ CQEs to
keep BE hosts correct. Also avoid double BE conversion of response
data_segment_length and document the LE round-trip.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
(cherry picked from commit ed621cc8e2a6dab2663ffb02e875f896f521bee2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 2d8ffd72c5..3f3c9589ce 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -53,8 +53,7 @@ static void ufs_build_scsi_response_upiu(UfsRequest *req, uint8_t *sense,
         response = UFS_COMMAND_RESULT_FAIL;
     }
 
-    data_segment_length =
-        cpu_to_be16(sense_len + sizeof(req->rsp_upiu.sr.sense_data_len));
+    data_segment_length = sense_len + sizeof(req->rsp_upiu.sr.sense_data_len);
     ufs_build_upiu_header(req, UFS_UPIU_TRANSACTION_RESPONSE, flags, response,
                           status, data_segment_length);
 }
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 58099a554e..128e2b1ea8 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -449,15 +449,24 @@ static void ufs_mcq_process_cq(void *opaque)
     {
         ufs_dma_write_rsp_upiu(req);
 
-        req->cqe.utp_addr =
-            ((uint64_t)req->utrd.command_desc_base_addr_hi << 32ULL) |
-            req->utrd.command_desc_base_addr_lo;
-        req->cqe.utp_addr |= req->sq->sqid;
-        req->cqe.resp_len = req->utrd.response_upiu_length;
-        req->cqe.resp_off = req->utrd.response_upiu_offset;
-        req->cqe.prdt_len = req->utrd.prd_table_length;
-        req->cqe.prdt_off = req->utrd.prd_table_offset;
-        req->cqe.status = req->utrd.header.dword_2 & 0xf;
+        /* UTRD/CQE are LE; round-trip through host to keep BE correct. */
+        uint64_t ucdba =
+            ((uint64_t)le32_to_cpu(req->utrd.command_desc_base_addr_hi)
+             << 32ULL) |
+            le32_to_cpu(req->utrd.command_desc_base_addr_lo);
+        uint16_t resp_len = le16_to_cpu(req->utrd.response_upiu_length);
+        uint16_t resp_off = le16_to_cpu(req->utrd.response_upiu_offset);
+        uint16_t prdt_len = le16_to_cpu(req->utrd.prd_table_length);
+        uint16_t prdt_off = le16_to_cpu(req->utrd.prd_table_offset);
+        uint8_t status = le32_to_cpu(req->utrd.header.dword_2) & UFS_MASK_OCS;
+
+        ucdba |= req->sq->sqid;
+        req->cqe.utp_addr = cpu_to_le64(ucdba);
+        req->cqe.resp_len = cpu_to_le16(resp_len);
+        req->cqe.resp_off = cpu_to_le16(resp_off);
+        req->cqe.prdt_len = cpu_to_le16(prdt_len);
+        req->cqe.prdt_off = cpu_to_le16(prdt_off);
+        req->cqe.status = status;
         req->cqe.error = 0;
 
         ret = ufs_addr_write(u, cq->addr + tail, &req->cqe, sizeof(req->cqe));
diff --git a/include/block/ufs.h b/include/block/ufs.h
index a3ee62b027..22dc379eaa 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -645,7 +645,7 @@ enum UtpOcsCodes {
 };
 
 enum {
-    UFS_MASK_OCS = 0x0F,
+    UFS_MASK_OCS = 0xFF,
 };
 
 /*
-- 
2.47.3


