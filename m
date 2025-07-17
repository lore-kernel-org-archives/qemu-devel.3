Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4486DC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgJY-00084A-DP; Fri, 18 Jul 2025 04:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ayush.m55@samsung.com>)
 id 1ucgJP-0007uz-GK
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:19:23 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ayush.m55@samsung.com>)
 id 1ucgJI-0001Wi-ID
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:19:20 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20250718081912epoutp037c6d28e046929076f1ff79a99069596f~TSqUJs4O-0973009730epoutp03d
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 08:19:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20250718081912epoutp037c6d28e046929076f1ff79a99069596f~TSqUJs4O-0973009730epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1752826752;
 bh=q8mgLEDBBtLwWuVqQ1Q1XlIqR7uiPwGux7yAlfkaMvg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FJs0AFf1l9UESrP1Ru4cuhi0k6VDxxBMlSUTz/ZFY3edvRp1sFzf1/Dt1T1yoaloi
 Bx+8QUMNCi21jyE2mDGbLpwCaGO/0MsOcWVI53KAPBb8OxKZuIxukcQZPyPp2Hy1Jj
 rEfvz9DFWv8z1GVtBo0zdm/9p04/OYctIHQ2WoAE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20250718081912epcas5p447d56262b0369463902efdd5a861fd39~TSqTmcOAV2466224662epcas5p4S;
 Fri, 18 Jul 2025 08:19:12 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.86]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4bk2kl2Yn0z2SSKq; Fri, 18 Jul
 2025 08:19:11 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20250717114157epcas5p230c17abfb2d0e9f83258b90187eaf9b1~TByDsNm2P2755427554epcas5p2W;
 Thu, 17 Jul 2025 11:41:57 +0000 (GMT)
Received: from test-X570-AORUS-ULTRA.samsungds.net (unknown [107.99.41.42])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250717114157epsmtip2deed623bbc5be5dad1990a30cc6cfcb4~TByC4u1oO1310113101epsmtip2f;
 Thu, 17 Jul 2025 11:41:56 +0000 (GMT)
From: Ayush Mishra <ayush.m55@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, Ayush Mishra
 <ayush.m55@samsung.com>
Subject: [PATCH 1/2] hw/nvme: Adding support for LID 0x00- Supported Log Pages
Date: Thu, 17 Jul 2025 16:50:28 +0530
Message-ID: <20250717112029.28242-2-ayush.m55@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717112029.28242-1-ayush.m55@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250717114157epcas5p230c17abfb2d0e9f83258b90187eaf9b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250717114157epcas5p230c17abfb2d0e9f83258b90187eaf9b1
References: <20250717112029.28242-1-ayush.m55@samsung.com>
 <CGME20250717114157epcas5p230c17abfb2d0e9f83258b90187eaf9b1@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=ayush.m55@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Ayush Mishra <ayush.m55@samsung.com>
---
 hw/nvme/ctrl.c       | 32 ++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h       |  2 ++
 include/block/nvme.h | 11 +++++++++++
 3 files changed, 45 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e62c6a3588..93c950b5b2 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5105,6 +5105,22 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
     return nvme_c2h(n, (uint8_t *) &fw_log + off, trans_len, req);
 }
 
+static uint16_t nvme_supp_log_page(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
+    uint64_t off, NvmeRequest *req)
+{
+    uint32_t supplogpagesize = sizeof(n->supplogpage);
+    uint32_t trans_len;
+
+    if (off >= supplogpagesize) {
+        trace_pci_nvme_err_invalid_log_page_offset(off, supplogpagesize);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len = MIN(supplogpagesize - off, buf_len);
+
+    return nvme_c2h(n, ((uint8_t *)n->supplogpage) + off, trans_len, req);
+}
+
 static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                                 uint64_t off, NvmeRequest *req)
 {
@@ -5474,6 +5490,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
     }
 
     switch (lid) {
+    case NVME_SUPP_LOG_PAGE:
+        return nvme_supp_log_page(n, rae, len, off, req);
     case NVME_LOG_ERROR_INFO:
         return nvme_error_info(n, rae, len, off, req);
     case NVME_LOG_SMART_INFO:
@@ -8904,6 +8922,20 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     if (pci_is_vf(pci_dev) && !sctrl->scs) {
         stl_le_p(&n->bar.csts, NVME_CSTS_FAILED);
     }
+
+    n->supplogpage[NVME_SUPP_LOG_PAGE].lsupp_ios = NVME_LID_SUPP;
+    n->supplogpage[NVME_LOG_ERROR_INFO].lsupp_ios = NVME_LID_SUPP;
+    n->supplogpage[NVME_LOG_SMART_INFO].lsupp_ios = NVME_LID_SUPP;
+    n->supplogpage[NVME_LOG_FW_SLOT_INFO].lsupp_ios = NVME_LID_SUPP;
+    n->supplogpage[NVME_LOG_CHANGED_NSLIST].lsupp_ios = NVME_LID_SUPP;
+    n->supplogpage[NVME_LOG_CMD_EFFECTS].lsupp_ios = NVME_LID_SUPP;
+    n->supplogpage[NVME_LOG_ENDGRP].lsupp_ios = NVME_LID_SUPP;
+    n->supplogpage[NVME_LOG_FDP_CONFS].lsupp_ios = NVME_LID_SUPP;
+    n->supplogpage[NVME_LOG_FDP_RUH_USAGE].lsupp_ios = NVME_LID_SUPP;
+    n->supplogpage[NVME_LOG_FDP_STATS].lsupp_ios = NVME_LID_SUPP;
+    n->supplogpage[NVME_LOG_FDP_EVENTS].lsupp_ios = NVME_LID_SUPP;
+    n->supplogpage[NVME_LOG_VENDOR_START].lsupp_ios = NVME_LID_SUPP;
+    n->supplogpage[NVME_LOG_VENDOR_END].lsupp_ios = NVME_LID_SUPP;
 }
 
 static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 6f782ba188..660420c95a 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -26,6 +26,7 @@
 
 #define NVME_MAX_CONTROLLERS 256
 #define NVME_MAX_NAMESPACES  256
+#define NVME_MAX_LOG_PAGES  256
 #define NVME_EUI64_DEFAULT ((uint64_t)0x5254000000000000)
 #define NVME_FDP_MAX_EVENTS 63
 #define NVME_FDP_MAXPIDS 128
@@ -625,6 +626,7 @@ typedef struct NvmeCtrl {
     NvmeSQueue      admin_sq;
     NvmeCQueue      admin_cq;
     NvmeIdCtrl      id_ctrl;
+    NvmeSuppLogpage supplogpage[NVME_MAX_LOG_PAGES];
 
     struct {
         struct {
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 358e516e38..c38422b38d 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1079,6 +1079,7 @@ enum {
 };
 
 enum NvmeLogIdentifier {
+    NVME_SUPP_LOG_PAGE                  = 0x00,
     NVME_LOG_ERROR_INFO                 = 0x01,
     NVME_LOG_SMART_INFO                 = 0x02,
     NVME_LOG_FW_SLOT_INFO               = 0x03,
@@ -1705,6 +1706,16 @@ typedef enum NvmeZoneState {
     NVME_ZONE_STATE_OFFLINE          = 0x0f,
 } NvmeZoneState;
 
+enum {
+    NVME_LID_SUPP        = 1 << 0,
+    NVME_INDEX_OFF_SUPP  = 1 << 1,
+};
+
+typedef struct QEMU_PACKED NvmeSuppLogpage {
+    uint16_t lsupp_ios;
+    uint16_t lidspec;
+} NvmeSuppLogpage;
+
 typedef struct QEMU_PACKED NvmePriCtrlCap {
     uint16_t    cntlid;
     uint16_t    portid;
-- 
2.43.0


