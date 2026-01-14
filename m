Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39762D37E33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 14:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg1st-0001B8-GE; Wed, 14 Jan 2026 09:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vg1sg-0001Ae-LG
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 09:29:54 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vg1se-0006pw-Fi
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 09:29:54 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drpQx1G3jzHnGjt;
 Wed, 14 Jan 2026 22:29:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 41A2040539;
 Wed, 14 Jan 2026 22:29:49 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 14 Jan 2026 14:29:48 +0000
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
 <shiju.jose@huawei.com>, <armbru@redhat.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
 <venkataravis@micron.com>
Subject: [PATCH qemu v3 5/5] hw/cxl/events: Updates for rev3.2 memory module
 event record
Date: Wed, 14 Jan 2026 14:27:13 +0000
Message-ID: <20260114142713.617806-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260114142713.617806-1-Jonathan.Cameron@huawei.com>
References: <20260114142713.617806-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-50, memory module
event record has updated with following new fields.
1. Validity Flags
2. Component Identifier
3. Device Event Sub-Type

Add updates for the above spec changes in the CXL memory module
event reporting and QMP command to inject memory module event.

Updated all references for this command to the CXL r3.2
specification.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
V3: Update spec references for whole command (Markus)
---
 qapi/cxl.json               | 26 ++++++++++++++++++--------
 include/hw/cxl/cxl_events.h |  7 +++++--
 hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  4 ++++
 4 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 630c37d64eed..fc2ff2e080b4 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -214,20 +214,20 @@
 ##
 # @CXLMemModuleEvent:
 #
-# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
+# Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
 #
-# @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
+# @type: Device Event Type.  See CXL r3.2 Table 8-59 Memory Module
 #     Event Record for bit definitions for bit definiions.
 #
-# @health-status: Overall health summary bitmap.  See CXL r3.0 Table
-#     8-100 Get Health Info Output Payload, Health Status for bit
+# @health-status: Overall health summary bitmap.  See CXL r3.2 Table
+#     8-148 Get Health Info Output Payload, Health Status for bit
 #     definitions.
 #
-# @media-status: Overall media health summary.  See CXL r3.0 Table
-#     8-100 Get Health Info Output Payload, Media Status for bit
+# @media-status: Overall media health summary.  See CXL r3.2 Table
+#     8-148 Get Health Info Output Payload, Media Status for bit
 #     definitions.
 #
-# @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
+# @additional-status: See CXL r3.2 Table 8-148 Get Health Info Output
 #     Payload, Additional Status for subfield definitions.
 #
 # @life-used: Percentage (0-100) of factory expected life span.
@@ -243,6 +243,14 @@
 # @corrected-persistent-error-count: Total number of correctable
 #     errors in persistent memory
 #
+# @component-id: Device specific component identifier for the event.
+#     May describe a field replaceable sub-component of the device.
+#
+# @is-comp-id-pldm: This flag specifies whether the device-specific
+#     component identifier format follows PLDM.
+#
+# @sub-type: Device event sub-type.
+#
 # Since: 8.1
 ##
 { 'struct': 'CXLMemModuleEvent',
@@ -252,7 +260,9 @@
             'life-used': 'uint8', 'temperature' : 'int16',
             'dirty-shutdown-count': 'uint32',
             'corrected-volatile-error-count': 'uint32',
-            'corrected-persistent-error-count': 'uint32'
+            'corrected-persistent-error-count': 'uint32',
+            '*component-id': 'str', '*is-comp-id-pldm':'bool',
+            'sub-type':'uint8'
             }}
 
 ##
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index a3c5f2ec20e6..4a7836ad7227 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -166,7 +166,7 @@ typedef struct CXLEventDram {
 
 /*
  * Memory Module Event Record
- * CXL r3.1 Section 8.2.9.2.1.3: Table 8-47
+ * CXL r3.2 Section 8.2.10.2.1.3: Table 8-59
  * All fields little endian.
  */
 typedef struct CXLEventMemoryModule {
@@ -180,7 +180,10 @@ typedef struct CXLEventMemoryModule {
     uint32_t dirty_shutdown_count;
     uint32_t corrected_volatile_error_count;
     uint32_t corrected_persistent_error_count;
-    uint8_t reserved[0x3d];
+    uint16_t validity_flags;
+    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t sub_type;
+    uint8_t reserved[0x2a];
 } QEMU_PACKED CXLEventMemoryModule;
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 1000bb46f701..50f8fa948688 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1946,6 +1946,9 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
     }
 }
 
+#define CXL_MMER_VALID_COMPONENT                        BIT(0)
+#define CXL_MMER_VALID_COMPONENT_ID_FORMAT              BIT(1)
+
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t flags, bool has_maint_op_class,
                                         uint8_t maint_op_class,
@@ -1962,11 +1965,16 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t dirty_shutdown_count,
                                         uint32_t corrected_volatile_error_count,
                                         uint32_t corrected_persist_error_count,
+                                        const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
+                                        uint8_t sub_type,
                                         Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
     CXLEventMemoryModule module;
     CXLEventRecordHdr *hdr = &module.hdr;
+    uint16_t valid_flags = 0;
     CXLDeviceState *cxlds;
     CXLType3Dev *ct3d;
     uint8_t enc_log;
@@ -2009,6 +2017,18 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     stl_le_p(&module.corrected_persistent_error_count,
              corrected_persist_error_count);
 
+    if (component_id) {
+        strncpy((char *)module.component_id, component_id,
+                sizeof(module.component_id) - 1);
+        valid_flags |= CXL_MMER_VALID_COMPONENT;
+        if (has_comp_id_pldm && is_comp_id_pldm) {
+            valid_flags |= CXL_MMER_VALID_COMPONENT_ID_FORMAT;
+        }
+    }
+    module.sub_type = sub_type;
+
+    stw_le_p(&module.validity_flags, valid_flags);
+
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) {
         cxl_event_irq_assert(ct3d);
     }
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 231dda263fa4..98292a931c16 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -78,6 +78,10 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t dirty_shutdown_count,
                                         uint32_t corrected_volatile_error_count,
                                         uint32_t corrected_persist_error_count,
+                                        const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
+                                        uint8_t sub_type,
                                         Error **errp) {}
 
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
-- 
2.48.1


