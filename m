Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9137AC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 09:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdRP2-0002k4-B0; Fri, 23 Feb 2024 03:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1rdRP0-0002jj-W5
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:59:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1rdROs-0002uw-Mm
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:59:30 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Th3kT3NVPz6K9VN;
 Fri, 23 Feb 2024 16:55:29 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id 3114B140DAF;
 Fri, 23 Feb 2024 16:59:08 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 08:59:07 +0000
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <fan.ni@samsung.com>, <jonathan.cameron@huawei.com>, 
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
 <shiju.jose@huawei.com>
Subject: [PATCH v5 3/3] hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control
 feature
Date: Fri, 23 Feb 2024 16:59:02 +0800
Message-ID: <20240223085902.1549-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240223085902.1549-1-shiju.jose@huawei.com>
References: <20240223085902.1549-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  <shiju.jose@huawei.com>
From: shiju.jose--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
control feature.

The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
Specification (JESD79-5) and allows the DRAM to internally read, correct
single-bit errors, and write back corrected data bits to the DRAM array
while providing transparency to error counts. The ECS control feature
allows the request to configure ECS input configurations during system
boot or at run-time.

The ECS control allows the requester to change the log entry type, the ECS
threshold count provided that the request is within the definition
specified in DDR5 mode registers, change mode between codeword mode and
row count mode, and reset the ECS counter.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 70 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 14 ++++++++
 include/hw/cxl/cxl_device.h | 24 +++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b6734c37ea..8e4bf27a62 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1023,6 +1023,7 @@ typedef struct CXLSupportedFeatureEntry {
 
 enum CXL_SUPPORTED_FEATURES_LIST {
     CXL_FEATURE_PATROL_SCRUB = 0,
+    CXL_FEATURE_ECS,
     CXL_FEATURE_MAX
 };
 
@@ -1075,6 +1076,20 @@ typedef struct CXLMemPatrolScrubSetFeature {
         CXLMemPatrolScrubWriteAttrs feat_data;
 } QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
 
+/*
+ * CXL r3.1 section 8.2.9.9.11.2:
+ * DDR5 Error Check Scrub (ECS) Control Feature
+ */
+static const QemuUUID ecs_uuid = {
+    .data = UUID(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba,
+                 0xb9, 0x69, 0x1e, 0x89, 0x33, 0x86)
+};
+
+typedef struct CXLMemECSSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemECSWriteAttrs feat_data[];
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemECSSetFeature;
+
 /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
 static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -1128,6 +1143,23 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                     CXL_FEAT_ENTRY_SFE_CEL_VALID,
             };
             break;
+        case  CXL_FEATURE_ECS:
+            /* Fill supported feature entry for device DDR5 ECS control */
+            get_feats_out->feat_entries[entry++] =
+                         (struct CXLSupportedFeatureEntry) {
+                .uuid = ecs_uuid,
+                .feat_index = index,
+                .get_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
+                                    sizeof(CXLMemECSReadAttrs),
+                .set_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
+                                    sizeof(CXLMemECSWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE,
+                .get_feat_version = CXL_ECS_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_ECS_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
         default:
             __builtin_unreachable();
         }
@@ -1187,6 +1219,18 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         memcpy(payload_out,
                (uint8_t *)&ct3d->patrol_scrub_attrs + get_feature->offset,
                bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &ecs_uuid)) {
+        if (get_feature->offset >=  CXL_ECS_NUM_MEDIA_FRUS *
+                                sizeof(CXLMemECSReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = CXL_ECS_NUM_MEDIA_FRUS *
+                        sizeof(CXLMemECSReadAttrs) -
+                            get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->ecs_attrs + get_feature->offset,
+               bytes_to_copy);
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1207,10 +1251,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
     CXLMemPatrolScrubWriteAttrs *ps_write_attrs;
     CXLMemPatrolScrubSetFeature *ps_set_feature;
+    CXLMemECSWriteAttrs *ecs_write_attrs;
+    CXLMemECSSetFeature *ecs_set_feature;
     CXLSetFeatureInfo *set_feat_info;
     uint16_t bytes_to_copy = 0;
     uint8_t data_transfer_flag;
     CXLType3Dev *ct3d;
+    uint16_t count;
 
 
     if (!object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
@@ -1260,6 +1307,28 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             ct3d->patrol_scrub_attrs.scrub_flags |=
                           ct3d->patrol_scrub_wr_attrs.scrub_flags & 0x1;
         }
+    } else if (qemu_uuid_is_equal(&hdr->uuid,
+                                  &ecs_uuid)) {
+        if (hdr->version != CXL_ECS_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        ecs_set_feature = (void *)payload_in;
+        ecs_write_attrs = ecs_set_feature->feat_data;
+        memcpy((uint8_t *)ct3d->ecs_wr_attrs + hdr->offset,
+               ecs_write_attrs,
+               bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
+                ct3d->ecs_attrs[count].ecs_log_cap =
+                                  ct3d->ecs_wr_attrs[count].ecs_log_cap;
+                ct3d->ecs_attrs[count].ecs_config =
+                                  ct3d->ecs_wr_attrs[count].ecs_config & 0x1F;
+            }
+        }
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1269,6 +1338,7 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         data_transfer_flag ==  CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER) {
         memset(&set_feat_info->uuid, 0, sizeof(QemuUUID));
         memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
+        memset(ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;
         set_feat_info->data_offset = 0;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 2b00007953..d0e7b352ac 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -955,6 +955,7 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
     uint8_t *pci_conf = pci_dev->config;
     unsigned short msix_num = 10;
     int i, rc;
+    uint16_t count;
 
     QTAILQ_INIT(&ct3d->error_list);
 
@@ -1039,6 +1040,19 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
                            CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
                            (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
     ct3d->patrol_scrub_attrs.scrub_flags = CXL_MEMDEV_PS_ENABLE_DEFAULT;
+
+    /* Set default value for DDR5 ECS read attributes */
+    for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
+        ct3d->ecs_attrs[count].ecs_log_cap =
+                            CXL_ECS_LOG_ENTRY_TYPE_DEFAULT;
+        ct3d->ecs_attrs[count].ecs_cap =
+                            CXL_ECS_REALTIME_REPORT_CAP_DEFAULT;
+        ct3d->ecs_attrs[count].ecs_config =
+                            CXL_ECS_THRESHOLD_COUNT_DEFAULT |
+                            (CXL_ECS_MODE_DEFAULT << 3);
+        /* Reserved */
+        ct3d->ecs_attrs[count].ecs_flags = 0;
+    }
     return;
 
 err_release_cdat:
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1181b1b8a3..d1fac96e62 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -478,6 +478,27 @@ typedef struct CXLMemPatrolScrubWriteAttrs {
 #define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
 #define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
 
+/* CXL memory device DDR5 ECS control attributes */
+typedef struct CXLMemECSReadAttrs {
+        uint8_t ecs_log_cap;
+        uint8_t ecs_cap;
+        uint16_t ecs_config;
+        uint8_t ecs_flags;
+} QEMU_PACKED CXLMemECSReadAttrs;
+
+typedef struct CXLMemECSWriteAttrs {
+    uint8_t ecs_log_cap;
+    uint16_t ecs_config;
+} QEMU_PACKED CXLMemECSWriteAttrs;
+
+#define CXL_ECS_GET_FEATURE_VERSION    0x01
+#define CXL_ECS_SET_FEATURE_VERSION    0x01
+#define CXL_ECS_LOG_ENTRY_TYPE_DEFAULT    0x01
+#define CXL_ECS_REALTIME_REPORT_CAP_DEFAULT    1
+#define CXL_ECS_THRESHOLD_COUNT_DEFAULT    3 /* 3: 256, 4: 1024, 5: 4096 */
+#define CXL_ECS_MODE_DEFAULT    0
+#define CXL_ECS_NUM_MEDIA_FRUS   3 /* Default */
+
 #define DCD_MAX_REGION_NUM 8
 
 typedef struct CXLDCDExtentRaw {
@@ -574,6 +595,9 @@ struct CXLType3Dev {
     /* Patrol scrub control attributes */
     CXLMemPatrolScrubReadAttrs patrol_scrub_attrs;
     CXLMemPatrolScrubWriteAttrs patrol_scrub_wr_attrs;
+    /* ECS control attributes */
+    CXLMemECSReadAttrs ecs_attrs[CXL_ECS_NUM_MEDIA_FRUS];
+    CXLMemECSWriteAttrs ecs_wr_attrs[CXL_ECS_NUM_MEDIA_FRUS];
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
-- 
2.34.1


