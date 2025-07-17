Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7C0C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgJY-00082i-57; Fri, 18 Jul 2025 04:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ayush.m55@samsung.com>)
 id 1ucgJT-00080L-N2
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:19:27 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ayush.m55@samsung.com>)
 id 1ucgJQ-0001Xs-Nq
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:19:27 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20250718081918epoutp016c88d6a94be698780273a8416b888938~TSqZZpJbJ2589525895epoutp019
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 08:19:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20250718081918epoutp016c88d6a94be698780273a8416b888938~TSqZZpJbJ2589525895epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1752826758;
 bh=Gkbrm8sGB+prOA674568G6OepPeer9uYT3iqQ6wN8tY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ya53r+CMrLybkIkEUvBCpaDmy6yE2ROzTBWFe+hWZ/Xs23Aff5KYABskF7xeNzArI
 o8n3B0ZB0mykPWAINPaX1CCl428z8q3AYqn2s4OG2E9KnqI+l6vcMSfEpKP0pON75L
 ds57D2DRyFlklEkHM+AQyDGAUNNal7Bp8sjGBjM8=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20250718081917epcas5p28734c00465365253f9ff7cf3593a5194~TSqY5vU761086610866epcas5p2A;
 Fri, 18 Jul 2025 08:19:17 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4bk2ks0b33z3hhT3; Fri, 18 Jul
 2025 08:19:17 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20250717114200epcas5p1324853eb5e30cbcf38b6bfb4defe597b~TByGcLGB23025730257epcas5p1w;
 Thu, 17 Jul 2025 11:42:00 +0000 (GMT)
Received: from test-X570-AORUS-ULTRA.samsungds.net (unknown [107.99.41.42])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250717114159epsmtip2b697ba2b971f3087466414db218f318c~TByFiwJna1309013090epsmtip2Z;
 Thu, 17 Jul 2025 11:41:59 +0000 (GMT)
From: Ayush Mishra <ayush.m55@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, Ayush Mishra
 <ayush.m55@samsung.com>
Subject: [PATCH 2/2] hw/nvme: Adding Support for Feature Identifiers
 Supported and Effects (Log Identifier 12h)
Date: Thu, 17 Jul 2025 16:50:29 +0530
Message-ID: <20250717112029.28242-3-ayush.m55@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717112029.28242-1-ayush.m55@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250717114200epcas5p1324853eb5e30cbcf38b6bfb4defe597b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250717114200epcas5p1324853eb5e30cbcf38b6bfb4defe597b
References: <20250717112029.28242-1-ayush.m55@samsung.com>
 <CGME20250717114200epcas5p1324853eb5e30cbcf38b6bfb4defe597b@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=ayush.m55@samsung.com; helo=mailout1.samsung.com
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
 hw/nvme/ctrl.c       | 63 ++++++++++++++++++++++++++++++++++++++++++++
 include/block/nvme.h | 21 +++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 93c950b5b2..5ef2282fd2 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -252,6 +252,24 @@ static const bool nvme_feature_support[NVME_FID_MAX] = {
     [NVME_FDP_EVENTS]               = true,
 };
 
+static const uint32_t nvme_fid_supp_effects[NVME_FID_MAX] = {
+    [NVME_ARBITRATION]             = NVME_EFFECTS_CSUPP | NVME_CTRL_SCOPE,
+    [NVME_POWER_MANAGEMENT]        = NVME_EFFECTS_CSUPP | NVME_CTRL_SCOPE,
+    [NVME_TEMPERATURE_THRESHOLD]   = NVME_EFFECTS_CSUPP | NVME_CTRL_SCOPE,
+    [NVME_ERROR_RECOVERY]          = NVME_EFFECTS_CSUPP | NVME_NMSP_SCOPE,
+    [NVME_VOLATILE_WRITE_CACHE]    = NVME_EFFECTS_CSUPP | NVME_CTRL_SCOPE,
+    [NVME_NUMBER_OF_QUEUES]        = NVME_EFFECTS_CSUPP | NVME_CTRL_SCOPE,
+    [NVME_INTERRUPT_COALESCING]    = NVME_EFFECTS_CSUPP | NVME_CTRL_SCOPE,
+    [NVME_INTERRUPT_VECTOR_CONF]   = NVME_EFFECTS_CSUPP | NVME_CTRL_SCOPE,
+    [NVME_WRITE_ATOMICITY]         = NVME_EFFECTS_CSUPP | NVME_CTRL_SCOPE,
+    [NVME_ASYNCHRONOUS_EVENT_CONF] = NVME_EFFECTS_CSUPP | NVME_CTRL_SCOPE,
+    [NVME_TIMESTAMP]               = NVME_EFFECTS_CSUPP | NVME_CTRL_SCOPE,
+    [NVME_HOST_BEHAVIOR_SUPPORT]   = NVME_EFFECTS_CSUPP | NVME_CTRL_SCOPE,
+    [NVME_COMMAND_SET_PROFILE]     = NVME_EFFECTS_CSUPP | NVME_CTRL_SCOPE,
+    [NVME_FDP_MODE]                = NVME_EFFECTS_CSUPP | NVME_ENDURANCE_SCOPE,
+    [NVME_FDP_EVENTS]              = NVME_EFFECTS_CSUPP,
+};
+
 static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
     [NVME_TEMPERATURE_THRESHOLD]    = NVME_FEAT_CAP_CHANGE,
     [NVME_ERROR_RECOVERY]           = NVME_FEAT_CAP_CHANGE | NVME_FEAT_CAP_NS,
@@ -5086,6 +5104,47 @@ static uint16_t nvme_endgrp_info(NvmeCtrl *n,  uint8_t rae, uint32_t buf_len,
     return nvme_c2h(n, (uint8_t *)&info + off, buf_len, req);
 }
 
+static uint16_t nvme_log_fid_supp_effects_log(NvmeCtrl *n, uint8_t csi,
+                uint32_t buf_len, uint64_t off, NvmeRequest *req)
+{
+    NvmeFidSuppLog log = {};
+    const uint32_t *supp_fid = NULL;
+    uint32_t trans_len;
+    bool ot = le32_to_cpu(req->cmd.cdw14) >> 23;
+
+    if (off >= sizeof(log) || (ot == 1 && (off * 4 >= sizeof(log)))) {
+        trace_pci_nvme_err_invalid_log_page_offset(off, sizeof(log));
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    switch (NVME_CC_CSS(ldl_le_p(&n->bar.cc))) {
+    case NVME_CC_CSS_NVM:
+        supp_fid = nvme_fid_supp_effects;
+        /* fall through */
+    case NVME_CC_CSS_ADMIN_ONLY:
+        break;
+    case NVME_CC_CSS_ALL:
+        switch (csi) {
+        case NVME_CSI_NVM:
+            supp_fid = nvme_fid_supp_effects;
+            break;
+        case NVME_CSI_ZONED:
+            break;
+        }
+    }
+
+    if (ot == 1) {
+        off *= 4;
+    }
+
+    if (supp_fid) {
+        memcpy(log.fis, supp_fid, sizeof(log.fis));
+    }
+
+    trans_len = MIN(sizeof(log) - off, buf_len);
+
+    return nvme_c2h(n, ((uint8_t *)&log) + off, trans_len, req);
+}
 
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
                                  NvmeRequest *req)
@@ -5506,6 +5565,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
         return nvme_cmd_effects(n, csi, len, off, req);
     case NVME_LOG_ENDGRP:
         return nvme_endgrp_info(n, rae, len, off, req);
+    case NVME_LOG_FID_SUPP_EFFECTS:
+        return nvme_log_fid_supp_effects_log(n, csi, len, off, req);
     case NVME_LOG_FDP_CONFS:
         return nvme_fdp_confs(n, lspi, len, off, req);
     case NVME_LOG_FDP_RUH_USAGE:
@@ -8930,6 +8991,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     n->supplogpage[NVME_LOG_CHANGED_NSLIST].lsupp_ios = NVME_LID_SUPP;
     n->supplogpage[NVME_LOG_CMD_EFFECTS].lsupp_ios = NVME_LID_SUPP;
     n->supplogpage[NVME_LOG_ENDGRP].lsupp_ios = NVME_LID_SUPP;
+    n->supplogpage[NVME_LOG_FID_SUPP_EFFECTS].lsupp_ios = NVME_LID_SUPP
+                                                        | NVME_INDEX_OFF_SUPP;
     n->supplogpage[NVME_LOG_FDP_CONFS].lsupp_ios = NVME_LID_SUPP;
     n->supplogpage[NVME_LOG_FDP_RUH_USAGE].lsupp_ios = NVME_LID_SUPP;
     n->supplogpage[NVME_LOG_FDP_STATS].lsupp_ios = NVME_LID_SUPP;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index c38422b38d..0ba69477a0 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1068,6 +1068,10 @@ typedef struct NvmeEffectsLog {
     uint8_t     resv[2048];
 } NvmeEffectsLog;
 
+typedef struct NvmeFidSuppLog {
+    uint32_t    fis[256];
+} NvmeFidSuppLog;
+
 enum {
     NVME_CMD_EFF_CSUPP      = 1 << 0,
     NVME_CMD_EFF_LBCC       = 1 << 1,
@@ -1086,6 +1090,7 @@ enum NvmeLogIdentifier {
     NVME_LOG_CHANGED_NSLIST             = 0x04,
     NVME_LOG_CMD_EFFECTS                = 0x05,
     NVME_LOG_ENDGRP                     = 0x09,
+    NVME_LOG_FID_SUPP_EFFECTS           = 0x12,
     NVME_LOG_FDP_CONFS                  = 0x20,
     NVME_LOG_FDP_RUH_USAGE              = 0x21,
     NVME_LOG_FDP_STATS                  = 0x22,
@@ -1364,6 +1369,22 @@ typedef enum NvmeFeatureCap {
     NVME_FEAT_CAP_CHANGE    = 1 << 2,
 } NvmeFeatureCap;
 
+typedef enum NvmeFidSuppEffects {
+    NVME_EFFECTS_CSUPP      = 1 <<  0,
+    NVME_EFFECTS_UDCC       = 1 <<  1,
+    NVME_EFFECTS_NCC        = 1 <<  2,
+    NVME_EFFECTS_NIC        = 1 <<  3,
+    NVME_EFFECTS_CCC        = 1 <<  4,
+    NVME_EFFECTS_UUID_SEL   = 1 << 19,
+    NVME_NMSP_SCOPE         = 1 << 20,
+    NVME_CTRL_SCOPE         = 1 << 21,
+    NVME_NVM_SET_SCOPE      = 1 << 22,
+    NVME_ENDURANCE_SCOPE    = 1 << 23,
+    NVME_DOMAIN_SCOPE       = 1 << 24,
+    NVME_SUBSYSTEM_SCOPE    = 1 << 25,
+    NVME_CTRL_DATA_QUEUE    = 1 << 26,
+} NvmeFidSuppEffects;
+
 typedef enum NvmeGetFeatureSelect {
     NVME_GETFEAT_SELECT_CURRENT = 0x0,
     NVME_GETFEAT_SELECT_DEFAULT = 0x1,
-- 
2.43.0


