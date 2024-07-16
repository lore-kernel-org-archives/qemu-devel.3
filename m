Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEC6C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 19:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTnjk-0004P0-HI; Tue, 16 Jul 2024 15:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1sTnjh-0004Nl-EJ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 15:21:17 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1sTnja-0007eu-0j
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 15:21:17 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240716192053epoutp02e6f346efcca15454ca53c2e06aaff128~ix8RklaOW3133331333epoutp02C
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 19:20:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240716192053epoutp02e6f346efcca15454ca53c2e06aaff128~ix8RklaOW3133331333epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1721157653;
 bh=KFBmnMpZBrj+uUx188rYlSukkAuhe+fKjlkUF5hSvBI=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Ijo1zW4X7F6Msf4fuLHlcq9c+zoJa3sRL93YRnALkBniWFnZx17sGNAuEKhMKNMlb
 kI4FS4bqR4rZKiTQbEH6NxOTUwn+lwVYjvLHW8n63UQOLMb+cKAxXFVnvZftsqc3Db
 OtG8IDAVbSUu3BbN6mTEiIYpkGLt9pmwrdYOM6as=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20240716192052epcas5p4c47b9e13848762a76a8a04fcc448a779~ix8P9A3n20256402564epcas5p4G;
 Tue, 16 Jul 2024 19:20:52 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4WNpnb024Mz4x9Pp; Tue, 16 Jul
 2024 19:20:51 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B0.18.09989.218C6966; Wed, 17 Jul 2024 04:20:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20240716132257epcas5p2528015d52067d84cedd62fb32bef797a~itDwTHzrQ1368713687epcas5p26;
 Tue, 16 Jul 2024 13:22:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240716132257epsmtrp22c4c7a5b88858475e5df9753e92a4cad~itDwSewgT0776907769epsmtrp2P;
 Tue, 16 Jul 2024 13:22:57 +0000 (GMT)
X-AuditID: b6c32a4a-e57f970000002705-e3-6696c812f18d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 71.DC.19057.13476966; Tue, 16 Jul 2024 22:22:57 +0900 (KST)
Received: from localhost.sa.corp.samsungelectronics.net (unknown
 [107.99.41.223]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240716132256epsmtip21a24675f4aecdd64ad6cb5c67c4c7117~itDvcL0os0791507915epsmtip21;
 Tue, 16 Jul 2024 13:22:56 +0000 (GMT)
From: Arun Kumar <arun.kka@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, Arun Kumar
 <arun.kka@samsung.com>
Subject: [PATCH] hw/nvme: MDTS Enhancement
Date: Tue, 16 Jul 2024 13:23:34 +0530
Message-ID: <20240716075334.2932985-1-arun.kka@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmlq7QiWlpBo8PmFnMuW9hcWJKmMX+
 g99YLSYdusZocbx3B4sDq8eUadfYPc7tOM/usWlVJ5vHk2ubmTz6tqxiDGCNyrbJSE1MSS1S
 SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqtpFCWmFMKFApILC5W
 0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO+N97lbXgkFTF
 w+XzWBoYV4p0MXJySAiYSCz+cZ+9i5GLQ0hgN6PEmokzGCGcT4wS19b9Y4NwvjFKLD61lgWm
 5cuPtVAtexklPi+9BFXVxiQxe/t+NpAqNgF1ibUzdzCB2CICkhK/u04zg9jMAvES3xYtBZrE
 wSEsoCWx/I8BSJhFQFXiyYRVjCA2r4C1xOIZv6CWyUss3rGcGSIuKHFy5hMWiDHyEs1bZzOD
 7JUQ2Mcu8efDVVaIBheJ7kufmCBsYYlXx7ewQ9hSEp/f7WWDsOslzszcA1XTwSjx9DtUjb3E
 xT1/mUBuYxbQlFi/Sx8iLCsx9dQ6Joi9fBK9v59AtfJK7JgHYytJ3Nv6E2qMhMScK98ZQcZI
 CHhIzOxIBQkLCcRKzDv3gmUCo/wsJN/MQvLNLITFCxiZVzFKphYU56anFpsWGOWllsPjNTk/
 dxMjOAVqee1gfPjgg94hRiYOxkOMEhzMSiK8ExinpQnxpiRWVqUW5ccXleakFh9iNAUG8URm
 KdHkfGASziuJNzSxNDAxMzMzsTQ2M1QS533dOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgWndJkHP
 5ZO/aGzYtU9HKPvC1Wrt5/JpOx46nGVIi1p0g2vydz+paxI/QufOu+552rf13hIPqdnTPb6s
 W/bbRXH3RZWZc73TOHa7TeW6+Ft10y6jqfn8V84yvRDff3DhHpmA/C1rZmz7m99ygVc17bPS
 a0uVbjnmRTvPzlFctOQyK3MDf1hsuJBeYJ3JwtNsTc8Y9TU+ad6tduj9I2b8dMqEZ4GsM04e
 sLZc6Hd5b1LzQYffrVd0moU0o/S67rH1fV1++0Ash3qHskTidvP2IMvohx8nsi1xtvlfljJJ
 4ai4xtzgjQ9nz+erWnj846o3i9Urs4JvnsyS3/um/tP5poyQ1gWP576YMivX7F/pDYsKJZbi
 jERDLeai4kQAqrorSQoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSvK5hybQ0g1c71Czm3LewODElzGL/
 wW+sFpMOXWO0ON67g8WB1WPKtGvsHud2nGf32LSqk83jybXNTB59W1YxBrBGcdmkpOZklqUW
 6dslcGX8773KWnBIquLh8nksDYwrRboYOTkkBEwkvvxYy97FyMUhJLCbUeLs3QXsEAkJiR9f
 vjFC2MISK/89hypqYZI4s34mE0iCTUBdYu3MHWC2iICkxO+u08xdjBwczALJEq9/+IKYwgJa
 Esv/GIBUsAioSjyZsApsJK+AtcTiGb9YIMbLSyzesZwZIi4ocXLmE7A4M1C8eets5gmMfLOQ
 pGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcjFpaOxj3rPqgd4iRiYPx
 EKMEB7OSCO8ExmlpQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgsky
 cXBKNTBdZZ+s5aB107Lu1d0e2b2z3ml4as8tdQpIeFfWLxP2t8tU/WHzX9ZKbW2pSdXcHDtO
 mPnK+WYFr19zP/ha79fcN3J7JpretDrfuWVu5y1vjZtX4g4G2nKwXSi422WkJ/jyjUvmg/O/
 dSpmLVgW+vKn9v/NnR7q3glLW5j2J3DeO3dl7np2y+7N17uaeG408zY59i+Zvj7bykaT1ejh
 XY2C7zu32L1bPbPSUGLTtn3qIeuSTlxuki7+FnvAO3xGfK3IpHWPY941WcTGurxxa/7wxiFt
 6iWW6By9KtU+T7tj7psvlF1tyDRhy78ZP8X6rtSHkm2GGYvOOm8S4Z0TV7WJT5Flfn/SnLDF
 8w7mflJiKc5INNRiLipOBAC00j3otQIAAA==
X-CMS-MailID: 20240716132257epcas5p2528015d52067d84cedd62fb32bef797a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240716132257epcas5p2528015d52067d84cedd62fb32bef797a
References: <CGME20240716132257epcas5p2528015d52067d84cedd62fb32bef797a@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.25; envelope-from=arun.kka@samsung.com;
 helo=mailout2.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Updated mdts field to only include interleaved metadata if metadata is
interleaved and MEM bit is cleared to 0

Signed-off-by: Arun Kumar <arun.kka@samsung.com>
---
 hw/nvme/ctrl.c       | 19 ++++++++++++++-----
 include/block/nvme.h |  3 +++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..2cf95051ff 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2641,6 +2641,7 @@ static uint16_t nvme_verify(NvmeCtrl *n, NvmeRequest *req)
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb = le16_to_cpu(rw->nlb) + 1;
     size_t len = nvme_l2b(ns, nlb);
+    size_t data_len = len;
     int64_t offset = nvme_l2b(ns, slba);
     uint8_t prinfo = NVME_RW_PRINFO(le16_to_cpu(rw->control));
     uint32_t reftag = le32_to_cpu(rw->reftag);
@@ -2660,7 +2661,11 @@ static uint16_t nvme_verify(NvmeCtrl *n, NvmeRequest *req)
         }
     }
 
-    if (len > n->page_size << n->params.vsl) {
+    if (nvme_ns_ext(ns) && !(NVME_ID_CTRL_CTRATT_MEM(n->id_ctrl.ctratt))) {
+        data_len += nvme_m2b(ns, nlb);
+    }
+
+    if (data_len > (n->page_size << n->params.vsl)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -3233,7 +3238,11 @@ static uint16_t nvme_compare(NvmeCtrl *n, NvmeRequest *req)
         len += nvme_m2b(ns, nlb);
     }
 
-    status = nvme_check_mdts(n, len);
+    if (NVME_ID_CTRL_CTRATT_MEM(n->id_ctrl.ctratt)) {
+        status = nvme_check_mdts(n, data_len);
+    } else {
+        status = nvme_check_mdts(n, len);
+    }
     if (status) {
         return status;
     }
@@ -3410,7 +3419,7 @@ static uint16_t nvme_read(NvmeCtrl *n, NvmeRequest *req)
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
-    if (nvme_ns_ext(ns)) {
+    if (nvme_ns_ext(ns) && !(NVME_ID_CTRL_CTRATT_MEM(n->id_ctrl.ctratt))) {
         mapped_size += nvme_m2b(ns, nlb);
 
         if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
@@ -3522,7 +3531,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
-    if (nvme_ns_ext(ns)) {
+    if (nvme_ns_ext(ns) && !(NVME_ID_CTRL_CTRATT_MEM(n->id_ctrl.ctratt))) {
         mapped_size += nvme_m2b(ns, nlb);
 
         if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
@@ -8202,7 +8211,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->cntlid = cpu_to_le16(n->cntlid);
 
     id->oaes = cpu_to_le32(NVME_OAES_NS_ATTR);
-    ctratt = NVME_CTRATT_ELBAS;
+    ctratt = NVME_CTRATT_ELBAS | NVME_CTRATT_MEM;
 
     id->rab = 6;
 
diff --git a/include/block/nvme.h b/include/block/nvme.h
index bb231d0b9a..4ba565241e 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1172,6 +1172,7 @@ enum NvmeIdCtrlOaes {
 enum NvmeIdCtrlCtratt {
     NVME_CTRATT_ENDGRPS = 1 <<  4,
     NVME_CTRATT_ELBAS   = 1 << 15,
+    NVME_CTRATT_MEM     = 1 << 16,
     NVME_CTRATT_FDPS    = 1 << 19,
 };
 
@@ -1271,6 +1272,8 @@ enum NvmeNsAttachmentOperation {
 #define NVME_ERR_REC_TLER(err_rec)  (err_rec & 0xffff)
 #define NVME_ERR_REC_DULBE(err_rec) (err_rec & 0x10000)
 
+#define NVME_ID_CTRL_CTRATT_MEM(ctratt) (ctratt & NVME_CTRATT_MEM)
+
 enum NvmeFeatureIds {
     NVME_ARBITRATION                = 0x1,
     NVME_POWER_MANAGEMENT           = 0x2,
-- 
2.43.0


