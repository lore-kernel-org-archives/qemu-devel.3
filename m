Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183E3C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 12:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPi6Q-0004Yv-SU; Fri, 05 Jul 2024 08:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPi6P-0004Is-1x
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:31:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPi6M-0007sy-BK
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:31:48 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFtBM0gR2z6K98c;
 Fri,  5 Jul 2024 20:29:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id B8F4B140A30;
 Fri,  5 Jul 2024 20:31:42 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:31:40 +0100
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <shiju.jose@huawei.com>, Gregory Price <gregory.price@memverge.com>,
 <linuxarm@huawei.com>
Subject: [PATCH v6 2/4] hw/cxl/cxl-mailbox-utils: Add support for feature
 commands (8.2.9.6)
Date: Fri, 5 Jul 2024 13:30:36 +0100
Message-ID: <20240705123039.963781-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705123039.963781-1-Jonathan.Cameron@huawei.com>
References: <20240705123039.963781-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
Get Supported Features retrieves the list of supported device specific
features. The settings of a feature can be retrieved using Get Feature and
optionally modified using Set Feature.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Link: https://lore.kernel.org/r/20240223085902.1549-2-shiju.jose@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  10 ++
 hw/cxl/cxl-mailbox-utils.c  | 258 ++++++++++++++++++++++++++++++++++++
 2 files changed, 268 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cc98553583..48ed0d9240 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -464,6 +464,14 @@ typedef struct CXLDCRegion {
     unsigned long *blk_bitmap;
 } CXLDCRegion;
 
+typedef struct CXLSetFeatureInfo {
+    QemuUUID uuid;
+    uint8_t data_transfer_flag;
+    bool data_saved_across_reset;
+    uint16_t data_offset;
+    size_t data_size;
+} CXLSetFeatureInfo;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -501,6 +509,8 @@ struct CXLType3Dev {
     CXLPoisonList scan_media_results;
     bool scan_media_hasrun;
 
+    CXLSetFeatureInfo set_feat_info;
+
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2e72148118..5c4424d8fe 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -69,6 +69,10 @@ enum {
     LOGS        = 0x04,
         #define GET_SUPPORTED 0x0
         #define GET_LOG       0x1
+    FEATURES    = 0x05,
+        #define GET_SUPPORTED 0x0
+        #define GET_FEATURE   0x1
+        #define SET_FEATURE   0x2
     IDENTIFY    = 0x40,
         #define MEMORY_DEVICE 0x0
     CCLS        = 0x41,
@@ -772,6 +776,248 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 section 8.2.9.6: Features */
+/*
+ * Get Supported Features output payload
+ * CXL r3.1 section 8.2.9.6.1 Table 8-96
+ */
+typedef struct CXLSupportedFeatureHeader {
+    uint16_t entries;
+    uint16_t nsuppfeats_dev;
+    uint32_t reserved;
+} QEMU_PACKED CXLSupportedFeatureHeader;
+
+/*
+ * Get Supported Features Supported Feature Entry
+ * CXL r3.1 section 8.2.9.6.1 Table 8-97
+ */
+typedef struct CXLSupportedFeatureEntry {
+    QemuUUID uuid;
+    uint16_t feat_index;
+    uint16_t get_feat_size;
+    uint16_t set_feat_size;
+    uint32_t attr_flags;
+    uint8_t get_feat_version;
+    uint8_t set_feat_version;
+    uint16_t set_feat_effects;
+    uint8_t rsvd[18];
+} QEMU_PACKED CXLSupportedFeatureEntry;
+
+/*
+ * Get Supported Features Supported Feature Entry
+ * CXL rev 3.1 section 8.2.9.6.1 Table 8-97
+ */
+/* Supported Feature Entry : attribute flags */
+#define CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE BIT(0)
+#define CXL_FEAT_ENTRY_ATTR_FLAG_DEEPEST_RESET_PERSISTENCE_MASK GENMASK(3, 1)
+#define CXL_FEAT_ENTRY_ATTR_FLAG_PERSIST_ACROSS_FIRMWARE_UPDATE BIT(4)
+#define CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SELECTION BIT(5)
+#define CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_SAVED_SELECTION BIT(6)
+
+/* Supported Feature Entry : set feature effects */
+#define CXL_FEAT_ENTRY_SFE_CONFIG_CHANGE_COLD_RESET BIT(0)
+#define CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE BIT(1)
+#define CXL_FEAT_ENTRY_SFE_IMMEDIATE_DATA_CHANGE BIT(2)
+#define CXL_FEAT_ENTRY_SFE_IMMEDIATE_POLICY_CHANGE BIT(3)
+#define CXL_FEAT_ENTRY_SFE_IMMEDIATE_LOG_CHANGE BIT(4)
+#define CXL_FEAT_ENTRY_SFE_SECURITY_STATE_CHANGE BIT(5)
+#define CXL_FEAT_ENTRY_SFE_BACKGROUND_OPERATION BIT(6)
+#define CXL_FEAT_ENTRY_SFE_SUPPORT_SECONDARY_MAILBOX BIT(7)
+#define CXL_FEAT_ENTRY_SFE_SUPPORT_ABORT_BACKGROUND_OPERATION BIT(8)
+#define CXL_FEAT_ENTRY_SFE_CEL_VALID BIT(9)
+#define CXL_FEAT_ENTRY_SFE_CONFIG_CHANGE_CONV_RESET BIT(10)
+#define CXL_FEAT_ENTRY_SFE_CONFIG_CHANGE_CXL_RESET BIT(11)
+
+enum CXL_SUPPORTED_FEATURES_LIST {
+    CXL_FEATURE_MAX
+};
+
+/* Get Feature CXL 3.1 Spec 8.2.9.6.2 */
+/*
+ * Get Feature input payload
+ * CXL r3.1 section 8.2.9.6.2 Table 8-99
+ */
+/* Get Feature : Payload in selection */
+enum CXL_GET_FEATURE_SELECTION {
+    CXL_GET_FEATURE_SEL_CURRENT_VALUE,
+    CXL_GET_FEATURE_SEL_DEFAULT_VALUE,
+    CXL_GET_FEATURE_SEL_SAVED_VALUE,
+    CXL_GET_FEATURE_SEL_MAX
+};
+
+/* Set Feature CXL 3.1 Spec 8.2.9.6.3 */
+/*
+ * Set Feature input payload
+ * CXL r3.1 section 8.2.9.6.3 Table 8-101
+ */
+typedef struct CXLSetFeatureInHeader {
+        QemuUUID uuid;
+        uint32_t flags;
+        uint16_t offset;
+        uint8_t version;
+        uint8_t rsvd[9];
+} QEMU_PACKED QEMU_ALIGNED(16) CXLSetFeatureInHeader;
+
+/* Set Feature : Payload in flags */
+#define CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK   0x7
+enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
+    CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
+};
+#define CXL_SET_FEAT_DATA_SAVED_ACROSS_RESET BIT(3)
+
+/* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
+static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint32_t count;
+        uint16_t start_index;
+        uint16_t reserved;
+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_in = (void *)payload_in;
+
+    struct {
+        CXLSupportedFeatureHeader hdr;
+        CXLSupportedFeatureEntry feat_entries[];
+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out = (void *)payload_out;
+    uint16_t index, req_entries;
+    uint16_t entry;
+
+    if (!object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
+        /*
+         * Temporary: suppress compiler error due to unsigned
+         * comparioson to zero.
+         */
+        true /*get_feats_in->start_index >= CXL_FEATURE_MAX*/) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    req_entries = (get_feats_in->count -
+                   sizeof(CXLSupportedFeatureHeader)) /
+                   sizeof(CXLSupportedFeatureEntry);
+    req_entries = MIN(req_entries,
+                      (CXL_FEATURE_MAX - get_feats_in->start_index));
+
+    for (entry = 0, index = get_feats_in->start_index;
+         entry < req_entries; index++) {
+        switch (index) {
+        default:
+            __builtin_unreachable();
+        }
+    }
+    get_feats_out->hdr.nsuppfeats_dev = CXL_FEATURE_MAX;
+    get_feats_out->hdr.entries = req_entries;
+    *len_out = sizeof(CXLSupportedFeatureHeader) +
+                      req_entries * sizeof(CXLSupportedFeatureEntry);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.1 section 8.2.9.6.2: Get Feature (Opcode 0501h) */
+static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
+                                           uint8_t *payload_in,
+                                           size_t len_in,
+                                           uint8_t *payload_out,
+                                           size_t *len_out,
+                                           CXLCCI *cci)
+{
+    struct {
+        QemuUUID uuid;
+        uint16_t offset;
+        uint16_t count;
+        uint8_t selection;
+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feature;
+    uint16_t bytes_to_copy = 0;
+    CXLType3Dev *ct3d;
+    CXLSetFeatureInfo *set_feat_info;
+
+    if (!object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    ct3d = CXL_TYPE3(cci->d);
+    get_feature = (void *)payload_in;
+
+    set_feat_info = &ct3d->set_feat_info;
+    if (qemu_uuid_is_equal(&get_feature->uuid, &set_feat_info->uuid)) {
+        return CXL_MBOX_FEATURE_TRANSFER_IN_PROGRESS;
+    }
+
+    if (get_feature->selection != CXL_GET_FEATURE_SEL_CURRENT_VALUE) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    if (get_feature->offset + get_feature->count > cci->payload_max) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    *len_out = bytes_to_copy;
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.1 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
+static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
+                                           uint8_t *payload_in,
+                                           size_t len_in,
+                                           uint8_t *payload_out,
+                                           size_t *len_out,
+                                           CXLCCI *cci)
+{
+    CXLSetFeatureInHeader *hdr = (void *)payload_in;
+    CXLSetFeatureInfo *set_feat_info;
+    uint8_t data_transfer_flag;
+    CXLType3Dev *ct3d;
+
+
+    if (!object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    ct3d = CXL_TYPE3(cci->d);
+    set_feat_info = &ct3d->set_feat_info;
+
+    if (!qemu_uuid_is_null(&set_feat_info->uuid) &&
+        !qemu_uuid_is_equal(&hdr->uuid, &set_feat_info->uuid)) {
+        return CXL_MBOX_FEATURE_TRANSFER_IN_PROGRESS;
+    }
+    if (hdr->flags & CXL_SET_FEAT_DATA_SAVED_ACROSS_RESET) {
+        set_feat_info->data_saved_across_reset = true;
+    } else {
+        set_feat_info->data_saved_across_reset = false;
+    }
+
+    data_transfer_flag =
+              hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK;
+    if (data_transfer_flag == CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER) {
+        set_feat_info->uuid = hdr->uuid;
+        set_feat_info->data_size = 0;
+    }
+    set_feat_info->data_transfer_flag = data_transfer_flag;
+    set_feat_info->data_offset = hdr->offset;
+
+    if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+        data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER ||
+        data_transfer_flag ==  CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER) {
+        memset(&set_feat_info->uuid, 0, sizeof(QemuUUID));
+        set_feat_info->data_transfer_flag = 0;
+        set_feat_info->data_saved_across_reset = false;
+        set_feat_info->data_offset = 0;
+        set_feat_info->data_size = 0;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 Section 8.2.9.9.1.1: Identify Memory Device (Opcode 4000h) */
 static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -2121,6 +2367,18 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
                               0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
+                                  cmd_features_get_supported, 0x8, 0 },
+    [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
+                                cmd_features_get_feature, 0x15, 0 },
+    [FEATURES][SET_FEATURE] = { "FEATURES_SET_FEATURE",
+                                cmd_features_set_feature,
+                                ~0,
+                                (CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+                                 CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+                                 CXL_MBOX_IMMEDIATE_POLICY_CHANGE |
+                                 CXL_MBOX_IMMEDIATE_LOG_CHANGE |
+                                 CXL_MBOX_SECURITY_STATE_CHANGE)},
     [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
         cmd_identify_memory_device, 0, 0 },
     [CCLS][GET_PARTITION_INFO] = { "CCLS_GET_PARTITION_INFO",
-- 
2.43.0


