Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA917C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 15:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk2nN-0005JZ-FO; Thu, 07 Aug 2025 11:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1uk2n3-0005DQ-Mq
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 11:44:35 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1uk2mz-0003zV-Kt
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 11:44:25 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4byWc81jnCz6L5Ky;
 Thu,  7 Aug 2025 23:41:44 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 4DD681402FE;
 Thu,  7 Aug 2025 23:44:06 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.37) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Aug 2025 17:44:05 +0200
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <armbru@redhat.com>, 
 <jonathan.cameron@huawei.com>, <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v5 1/7] hw/cxl/events: Update for rev3.2 common event record
 format
Date: Thu, 7 Aug 2025 16:43:40 +0100
Message-ID: <20250807154346.2209-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250807154346.2209-1-shiju.jose@huawei.com>
References: <20250807154346.2209-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.170.37]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500007.china.huawei.com (7.182.85.172)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  <shiju.jose@huawei.com>
From: shiju.jose--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
format has updated with optional Maintenance Operation Subclass,
LD ID and ID of the device head information.

Add updates for the above optional parameters in the related
CXL events reporting and in the QMP commands to inject CXL events.

In qapi/cxl.json added fields of Common Event Record to a common
structure CXLCommonEventBase.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-events.c         |   3 +-
 hw/cxl/cxl-mailbox-utils.c  |   3 +-
 hw/mem/cxl_type3.c          |  70 ++++++++++++++++---
 hw/mem/cxl_type3_stubs.c    |  24 ++++++-
 include/hw/cxl/cxl_device.h |   7 +-
 include/hw/cxl/cxl_events.h |  15 +++-
 qapi/cxl.json               | 136 +++++++++++++++++++++++-------------
 7 files changed, 194 insertions(+), 64 deletions(-)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 724055f2cf..673154db29 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -273,7 +273,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
                             &dynamic_capacity_uuid,
                             (1 << CXL_EVENT_TYPE_INFO),
                             sizeof(event_rec),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            0, 0, 0, 0, 0, 0, 0, 0);
     event_rec.type = type;
     event_rec.validity_flags = 1;
     event_rec.host_id = 0;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 43a0d503aa..8f62ea9b54 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3457,7 +3457,8 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
                             &dynamic_capacity_uuid,
                             (1 << CXL_EVENT_TYPE_INFO),
                             sizeof(dcEvent),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            0, 0, 0, 0, 0, 0, 0, 0);
     dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
     dcEvent.validity_flags = 1;
     dcEvent.host_id = 0;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 7676d785c2..aa6e5c1a08 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1592,12 +1592,39 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
 
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
-                             uint8_t length, uint64_t timestamp)
+                             uint8_t length, uint64_t timestamp,
+                             bool has_maint_op_class, uint8_t maint_op_class,
+                             bool has_maint_op_subclass,
+                             uint8_t maint_op_subclass,
+                             bool has_ld_id, uint16_t ld_id,
+                             bool has_head_id, uint8_t head_id)
 {
-    st24_le_p(&hdr->flags, flags);
     hdr->length = length;
     memcpy(&hdr->id, uuid, sizeof(hdr->id));
     stq_le_p(&hdr->timestamp, timestamp);
+
+    if (has_maint_op_class) {
+        hdr->maint_op_class = maint_op_class;
+    } else {
+        hdr->maint_op_class = 0;
+    }
+
+    if (has_maint_op_subclass) {
+        flags |= CXL_EVENT_REC_FLAGS_MAINT_OP_SUBCLASS_VALID;
+        hdr->maint_op_subclass = maint_op_subclass;
+    }
+
+    if (has_ld_id) {
+        flags |= CXL_EVENT_REC_FLAGS_LD_ID_VALID;
+        stw_le_p(&hdr->ld_id, ld_id);
+    }
+
+    if (has_head_id) {
+        flags |= CXL_EVENT_REC_FLAGS_HEAD_ID_VALID;
+        hdr->head_id = head_id;
+    }
+
+    st24_le_p(&hdr->flags, flags);
 }
 
 static const QemuUUID gen_media_uuid = {
@@ -1637,7 +1664,13 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
 }
 /* Component ID is device specific.  Define this as a string. */
 void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint64_t dpa,
+                                        uint32_t flags, bool has_maint_op_class,
+                                        uint8_t maint_op_class,
+                                        bool has_maint_op_subclass,
+                                        uint8_t maint_op_subclass,
+                                        bool has_ld_id, uint16_t ld_id,
+                                        bool has_head_id, uint8_t head_id,
+                                        uint64_t dpa,
                                         uint8_t descriptor, uint8_t type,
                                         uint8_t transaction_type,
                                         bool has_channel, uint8_t channel,
@@ -1675,7 +1708,10 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
 
     memset(&gem, 0, sizeof(gem));
     cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            has_maint_op_class, maint_op_class,
+                            has_maint_op_subclass, maint_op_subclass,
+                            has_ld_id, ld_id, has_head_id, head_id);
 
     stq_le_p(&gem.phys_addr, dpa);
     gem.descriptor = descriptor;
@@ -1719,7 +1755,13 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
 #define CXL_DRAM_VALID_COLUMN                           BIT(6)
 #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
 
-void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
+                               uint32_t flags,
+                               bool has_maint_op_class, uint8_t maint_op_class,
+                               bool has_maint_op_subclass,
+                               uint8_t maint_op_subclass,
+                               bool has_ld_id, uint16_t ld_id,
+                               bool has_head_id, uint8_t head_id,
                                uint64_t dpa, uint8_t descriptor,
                                uint8_t type, uint8_t transaction_type,
                                bool has_channel, uint8_t channel,
@@ -1762,7 +1804,10 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
 
     memset(&dram, 0, sizeof(dram));
     cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            has_maint_op_class, maint_op_class,
+                            has_maint_op_subclass, maint_op_subclass,
+                            has_ld_id, ld_id, has_head_id, head_id);
     stq_le_p(&dram.phys_addr, dpa);
     dram.descriptor = descriptor;
     dram.type = type;
@@ -1822,7 +1867,13 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
 }
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint8_t type,
+                                        uint32_t flags, bool has_maint_op_class,
+                                        uint8_t maint_op_class,
+                                        bool has_maint_op_subclass,
+                                        uint8_t maint_op_subclass,
+                                        bool has_ld_id, uint16_t ld_id,
+                                        bool has_head_id, uint8_t head_id,
+                                        uint8_t type,
                                         uint8_t health_status,
                                         uint8_t media_status,
                                         uint8_t additional_status,
@@ -1861,7 +1912,10 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
 
     memset(&module, 0, sizeof(module));
     cxl_assign_event_header(hdr, &memory_module_uuid, flags, sizeof(module),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            has_maint_op_class, maint_op_class,
+                            has_maint_op_subclass, maint_op_subclass,
+                            has_ld_id, ld_id, has_head_id, head_id);
 
     module.type = type;
     module.health_status = health_status;
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index c1a5e4a7c1..91b1478114 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -14,7 +14,13 @@
 #include "qapi/qapi-commands-cxl.h"
 
 void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint64_t dpa,
+                                        uint32_t flags, bool has_maint_op_class,
+                                        uint8_t maint_op_class,
+                                        bool has_maint_op_subclass,
+                                        uint8_t maint_op_subclass,
+                                        bool has_ld_id, uint16_t ld_id,
+                                        bool has_head_id, uint8_t head_id,
+                                        uint64_t dpa,
                                         uint8_t descriptor, uint8_t type,
                                         uint8_t transaction_type,
                                         bool has_channel, uint8_t channel,
@@ -23,7 +29,13 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         const char *component_id,
                                         Error **errp) {}
 
-void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
+                               uint32_t flags,
+                               bool has_maint_op_class, uint8_t maint_op_class,
+                               bool has_maint_op_subclass,
+                               uint8_t maint_op_subclass,
+                               bool has_ld_id, uint16_t ld_id,
+                               bool has_head_id, uint8_t head_id,
                                uint64_t dpa, uint8_t descriptor,
                                uint8_t type, uint8_t transaction_type,
                                bool has_channel, uint8_t channel,
@@ -38,7 +50,13 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
                                Error **errp) {}
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint8_t type,
+                                        uint32_t flags, bool has_maint_op_class,
+                                        uint8_t maint_op_class,
+                                        bool has_maint_op_subclass,
+                                        uint8_t maint_op_subclass,
+                                        bool has_ld_id, uint16_t ld_id,
+                                        bool has_head_id, uint8_t head_id,
+                                        uint8_t type,
                                         uint8_t health_status,
                                         uint8_t media_status,
                                         uint8_t additional_status,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index fdee60b977..b77b6b2499 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -723,7 +723,12 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
-                             uint8_t length, uint64_t timestamp);
+                             uint8_t length, uint64_t timestamp,
+                             bool has_maint_op_class, uint8_t maint_op_class,
+                             bool has_maint_op_subclass,
+                             uint8_t maint_op_subclass,
+                             bool has_ld_id, uint16_t ld_id,
+                             bool has_head_id, uint8_t head_id);
 void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
                                              CXLDCEventType type,
                                              CXLDCExtentRaw extents[],
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 758b075a64..4d9cfdb621 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -29,9 +29,15 @@ typedef enum CXLEventLogType {
 
 /*
  * Common Event Record Format
- * CXL r3.1 section 8.2.9.2.1: Event Records; Table 8-43
+ * CXL r3.2 section 8.2.10.2.1: Event Records; Table 8-55
  */
-#define CXL_EVENT_REC_HDR_RES_LEN 0xf
+#define CXL_EVENT_REC_FLAGS_PERMANENT_COND BIT(2)
+#define CXL_EVENT_REC_FLAGS_MAINT_NEEDED   BIT(3)
+#define CXL_EVENT_REC_FLAGS_PERF_DEGRADED  BIT(4)
+#define CXL_EVENT_REC_FLAGS_HW_REPLACEMENT_NEEDED BIT(5)
+#define CXL_EVENT_REC_FLAGS_MAINT_OP_SUBCLASS_VALID BIT(6)
+#define CXL_EVENT_REC_FLAGS_LD_ID_VALID BIT(7)
+#define CXL_EVENT_REC_FLAGS_HEAD_ID_VALID BIT(8)
 typedef struct CXLEventRecordHdr {
     QemuUUID id;
     uint8_t length;
@@ -40,7 +46,10 @@ typedef struct CXLEventRecordHdr {
     uint16_t related_handle;
     uint64_t timestamp;
     uint8_t maint_op_class;
-    uint8_t reserved[CXL_EVENT_REC_HDR_RES_LEN];
+    uint8_t maint_op_subclass;
+    uint16_t ld_id;
+    uint8_t head_id;
+    uint8_t reserved[0xb];
 } QEMU_PACKED CXLEventRecordHdr;
 
 #define CXL_EVENT_RECORD_DATA_LENGTH 0x50
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 8f2e9237b1..a9a1d99de3 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -29,33 +29,53 @@
  }
 
 ##
-# @cxl-inject-general-media-event:
+# @CXLCommonEventBase:
 #
-# Inject an event record for a General Media Event (CXL r3.0
-# 8.2.9.2.1.1).  This event type is reported via one of the event logs
-# specified via the log parameter.
+# Common event record for a CXL Event (CXL r3.2 8.2.10.2.1
+# Table 8-55 Common Event Record Format).
 #
 # @path: CXL type 3 device canonical QOM path
 #
 # @log: event log to add the event to
 #
-# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
-#     Record Format, Event Record Flags for subfield definitions.
+# @flags: Event Record Flags.
+#
+# @maint-op-class: Maintenance operation class the device requests to
+#     initiate.
+#
+# @maint-op-subclass: Maintenance operation subclass the device
+#     requests to initiate.
+#
+# @ld-id: LD ID of LD from where the event originated.
+#
+# @head-id: ID of the device head from where the event originated.
+#
+# Since: 8.1
+##
+{ 'struct': 'CXLCommonEventBase',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
+            '*maint-op-class':'uint8', '*maint-op-subclass':'uint8',
+            '*ld-id':'uint16', '*head-id':'uint8' } }
+
+##
+# @CXLGeneralMediaEvent:
+#
+# Event record for CXL General Media Event (CXL r3.2 8.2.10.2.1.1).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
-#     lower bits include some flags.  See CXL r3.0 Table 8-43 General
+#     lower bits include some flags.  See CXL r3.2 Table 8-57 General
 #     Media Event Record, Physical Address.
 #
 # @descriptor: Memory Event Descriptor with additional memory event
-#     information.  See CXL r3.0 Table 8-43 General Media Event
+#     information.  See CXL r3.2 Table 8-57 General Media Event
 #     Record, Memory Event Descriptor for bit definitions.
 #
-# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-43
+# @type: Type of memory event that occurred.  See CXL r3.2 Table 8-57
 #     General Media Event Record, Memory Event Type for possible
 #     values.
 #
 # @transaction-type: Type of first transaction that caused the event
-#     to occur.  See CXL r3.0 Table 8-43 General Media Event Record,
+#     to occur.  See CXL r3.2 Table 8-57 General Media Event Record,
 #     Transaction Type for possible values.
 #
 # @channel: The channel of the memory event location.  A channel is an
@@ -72,40 +92,45 @@
 #
 # Since: 8.1
 ##
-{ 'command': 'cxl-inject-general-media-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
-            'dpa': 'uint64', 'descriptor': 'uint8',
+{ 'struct': 'CXLGeneralMediaEvent',
+  'base': 'CXLCommonEventBase',
+  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8',
             '*device': 'uint32', '*component-id': 'str' } }
 
 ##
-# @cxl-inject-dram-event:
-#
-# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
-# This event type is reported via one of the event logs specified via
-# the log parameter.
+# @cxl-inject-general-media-event:
 #
-# @path: CXL type 3 device canonical QOM path
+# Inject an event record for a General Media Event (CXL r3.2
+# 8.2.10.2.1.1).  This event type is reported via one of the event
+# logs specified via the log parameter.
 #
-# @log: Event log to add the event to
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-general-media-event',
+  'data': 'CXLGeneralMediaEvent' }
+
+##
+# @CXLDRAMEvent:
 #
-# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
-#     Record Format, Event Record Flags for subfield definitions.
+# Inject an event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
+# This event type is reported via one of the event logs specified via
+# the log parameter.
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
-#     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
+#     lower bits include some flags.  See CXL r3.2 Table 8-58 DRAM
 #     Event Record, Physical Address.
 #
 # @descriptor: Memory Event Descriptor with additional memory event
-#     information.  See CXL r3.0 Table 8-44 DRAM Event Record, Memory
+#     information.  See CXL r3.2 Table 8-58 DRAM Event Record, Memory
 #     Event Descriptor for bit definitions.
 #
-# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-44
+# @type: Type of memory event that occurred.  See CXL r3.2 Table 8-58
 #     DRAM Event Record, Memory Event Type for possible values.
 #
 # @transaction-type: Type of first transaction that caused the event
-#     to occur.  See CXL r3.0 Table 8-44 DRAM Event Record,
+#     to occur.  See CXL r3.2 Table 8-58 DRAM Event Record,
 #     Transaction Type for possible values.
 #
 # @channel: The channel of the memory event location.  A channel is an
@@ -131,9 +156,9 @@
 #
 # Since: 8.1
 ##
-{ 'command': 'cxl-inject-dram-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
-            'dpa': 'uint64', 'descriptor': 'uint8',
+{ 'struct': 'CXLDRAMEvent',
+  'base': 'CXLCommonEventBase',
+  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
             '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
@@ -141,31 +166,36 @@
            }}
 
 ##
-# @cxl-inject-memory-module-event:
-#
-# Inject an event record for a Memory Module Event (CXL r3.0
-# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
-# at the time of the event.
+# @cxl-inject-dram-event:
 #
-# @path: CXL type 3 device canonical QOM path
+# Inject an event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
+# This event type is reported via one of the event logs
+# specified via the log parameter.
 #
-# @log: Event Log to add the event to
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-dram-event',
+  'data': 'CXLDRAMEvent' }
+
+##
+# @CXLMemModuleEvent:
 #
-# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
-#     Record Format, Event Record Flags for subfield definitions.
+# Inject an event record for a Memory Module Event (CXL r3.2
+# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
+# at the time of the event.
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
@@ -183,9 +213,9 @@
 #
 # Since: 8.1
 ##
-{ 'command': 'cxl-inject-memory-module-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
-            'type': 'uint8', 'health-status': 'uint8',
+{ 'struct': 'CXLMemModuleEvent',
+  'base': 'CXLCommonEventBase',
+  'data': { 'type': 'uint8', 'health-status': 'uint8',
             'media-status': 'uint8', 'additional-status': 'uint8',
             'life-used': 'uint8', 'temperature' : 'int16',
             'dirty-shutdown-count': 'uint32',
@@ -193,6 +223,18 @@
             'corrected-persistent-error-count': 'uint32'
             }}
 
+##
+# @cxl-inject-memory-module-event:
+#
+# Inject an event record for a DRAM Event (CXL r3.2 8.2.10.2.1.3)
+# This event type is reported via one of the event logs
+# specified via the log parameter.
+#
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-memory-module-event',
+  'data': 'CXLMemModuleEvent' }
+
 ##
 # @cxl-inject-poison:
 #
-- 
2.43.0


