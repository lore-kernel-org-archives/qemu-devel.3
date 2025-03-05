Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9D9C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpl32-0003qY-Ip; Wed, 05 Mar 2025 04:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tpl30-0003q6-UO
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:28:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tpl2x-0001nu-Il
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:28:14 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z76Yv19Nxz6L54Y;
 Wed,  5 Mar 2025 17:24:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 0711D140A34;
 Wed,  5 Mar 2025 17:28:09 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 10:28:08 +0100
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>, Arpit Kumar <arpit1.kumar@samsung.com>,
 Sweta Kumari <s5.kumari@samsung.com>, Vinayak Holikatti
 <vinayak.kh@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi
 <ajay.opensrc@micron.com>
Subject: [PATCH qemu 6/8] hw/cxl/cxl-mailbox-utils: CXL CCI Get/Set alert
 config commands
Date: Wed, 5 Mar 2025 09:24:57 +0000
Message-ID: <20250305092501.191929-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Sweta Kumari <s5.kumari@samsung.com>

1) get alert configuration(Opcode 4201h)
2) set alert configuration(Opcode 4202h)

Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  15 ++++++
 hw/cxl/cxl-mailbox-utils.c  | 105 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  14 +++++
 3 files changed, 134 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 3ec7be3809..ed6cd50c67 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -542,6 +542,19 @@ typedef struct CXLSetFeatureInfo {
 
 struct CXLSanitizeInfo;
 
+typedef struct CXLAlertConfig {
+    uint8_t valid_alerts;
+    uint8_t enable_alerts;
+    uint8_t life_used_crit_alert_thresh;
+    uint8_t life_used_warn_thresh;
+    uint16_t over_temp_crit_alert_thresh;
+    uint16_t under_temp_crit_alert_thresh;
+    uint16_t over_temp_warn_thresh;
+    uint16_t under_temp_warn_thresh;
+    uint16_t cor_vmem_err_warn_thresh;
+    uint16_t cor_pmem_err_warn_thresh;
+} QEMU_PACKED CXLAlertConfig;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -563,6 +576,8 @@ struct CXLType3Dev {
     CXLCCI vdm_fm_owned_ld_mctp_cci;
     CXLCCI ld0_cci;
 
+    CXLAlertConfig alert_config;
+
     /* PCIe link characteristics */
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2c6db70e5f..299f232f26 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -28,6 +28,11 @@
 #define CXL_DC_EVENT_LOG_SIZE 8
 #define CXL_NUM_EXTENTS_SUPPORTED 512
 #define CXL_NUM_TAGS_SUPPORTED 0
+#define CXL_ALERTS_LIFE_USED_WARN_THRESH (1 << 0)
+#define CXL_ALERTS_OVER_TEMP_WARN_THRESH (1 << 1)
+#define CXL_ALERTS_UNDER_TEMP_WARN_THRESH (1 << 2)
+#define CXL_ALERTS_COR_VMEM_ERR_WARN_THRESH (1 << 3)
+#define CXL_ALERTS_COR_PMEM_ERR_WARN_THRESH (1 << 4)
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -86,6 +91,9 @@ enum {
         #define GET_PARTITION_INFO     0x0
         #define GET_LSA       0x2
         #define SET_LSA       0x3
+    HEALTH_INFO_ALERTS = 0x42,
+        #define GET_ALERT_CONFIG 0x1
+        #define SET_ALERT_CONFIG 0x2
     SANITIZE    = 0x44,
         #define OVERWRITE     0x0
         #define SECURE_ERASE  0x1
@@ -1610,6 +1618,97 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 Section 8.2.10.9.3.2 Get Alert Configuration (Opcode 4201h) */
+static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLAlertConfig *out = (CXLAlertConfig *)payload_out;
+
+    memcpy(out, &ct3d->alert_config, sizeof(ct3d->alert_config));
+    *len_out = sizeof(ct3d->alert_config);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.2 Section 8.2.10.9.3.3 Set Alert Configuration (Opcode 4202h) */
+static CXLRetCode cmd_set_alert_config(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLAlertConfig *alert_config = &ct3d->alert_config;
+    struct {
+        uint8_t valid_alert_actions;
+        uint8_t enable_alert_actions;
+        uint8_t life_used_warn_thresh;
+        uint8_t rsvd;
+        uint16_t over_temp_warn_thresh;
+        uint16_t under_temp_warn_thresh;
+        uint16_t cor_vmem_err_warn_thresh;
+        uint16_t cor_pmem_err_warn_thresh;
+    } QEMU_PACKED *in = (void *)payload_in;
+
+    if (in->valid_alert_actions & CXL_ALERTS_LIFE_USED_WARN_THRESH) {
+        /*
+         * CXL r3.2 Table 8-149 The life used warning threshold shall be
+         * less than the life used critical alert value.
+         */
+        if (in->life_used_warn_thresh >=
+            alert_config->life_used_crit_alert_thresh) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        alert_config->life_used_warn_thresh = in->life_used_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_LIFE_USED_WARN_THRESH;
+    }
+
+    if (in->valid_alert_actions & CXL_ALERTS_OVER_TEMP_WARN_THRESH) {
+        /*
+         * CXL r3.2 Table 8-149 The Device Over-Temperature Warning Threshold
+         * shall be less than the the Device Over-Temperature Critical
+         * Alert Threshold.
+         */
+        if (in->over_temp_warn_thresh >=
+            alert_config->over_temp_crit_alert_thresh) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        alert_config->over_temp_warn_thresh = in->over_temp_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_OVER_TEMP_WARN_THRESH;
+    }
+
+    if (in->valid_alert_actions & CXL_ALERTS_UNDER_TEMP_WARN_THRESH) {
+        /*
+         * CXL r3.2 Table 8-149 The Device Under-Temperature Warning Threshold
+         * shall be higher than the the Device Under-Temperature Critical
+         * Alert Threshold.
+         */
+        if (in->under_temp_warn_thresh <=
+            alert_config->under_temp_crit_alert_thresh) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        alert_config->under_temp_warn_thresh = in->under_temp_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_UNDER_TEMP_WARN_THRESH;
+    }
+
+    if (in->valid_alert_actions & CXL_ALERTS_COR_VMEM_ERR_WARN_THRESH) {
+        alert_config->cor_vmem_err_warn_thresh = in->cor_vmem_err_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_COR_VMEM_ERR_WARN_THRESH;
+    }
+
+    if (in->valid_alert_actions & CXL_ALERTS_COR_PMEM_ERR_WARN_THRESH) {
+        alert_config->cor_pmem_err_warn_thresh = in->cor_pmem_err_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_COR_PMEM_ERR_WARN_THRESH;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 /* Perform the actual device zeroing */
 static void __do_sanitization(CXLType3Dev *ct3d)
 {
@@ -3173,6 +3272,12 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
         ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
+    [HEALTH_INFO_ALERTS][GET_ALERT_CONFIG] = {
+        "HEALTH_INFO_ALERTS_GET_ALERT_CONFIG",
+        cmd_get_alert_config, 0, 0 },
+    [HEALTH_INFO_ALERTS][SET_ALERT_CONFIG] = {
+        "HEALTH_INFO_ALERTS_SET_ALERT_CONFIG",
+        cmd_set_alert_config, 12, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
         (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
          CXL_MBOX_SECURITY_STATE_CHANGE |
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index be670ae3f3..73845dd50d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -843,6 +843,19 @@ static DOEProtocol doe_cdat_prot[] = {
     { }
 };
 
+/* Initialize CXL device alerts with default threshold values. */
+static void init_alert_config(CXLType3Dev *ct3d)
+{
+    ct3d->alert_config = (CXLAlertConfig) {
+        .life_used_crit_alert_thresh = 75,
+        .life_used_warn_thresh = 40,
+        .over_temp_crit_alert_thresh = 35,
+        .under_temp_crit_alert_thresh = 10,
+        .over_temp_warn_thresh = 25,
+        .under_temp_warn_thresh = 20
+    };
+}
+
 static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -910,6 +923,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         goto err_msix_uninit;
     }
 
+    init_alert_config(ct3d);
     pcie_cap_deverr_init(pci_dev);
     /* Leave a bit of room for expansion */
     rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, errp);
-- 
2.43.0


