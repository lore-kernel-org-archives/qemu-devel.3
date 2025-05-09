Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B907C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 17:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDRgg-0006dK-52; Fri, 09 May 2025 13:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1uDRga-0006bd-DC
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:39:00 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1uDRgV-000837-2x
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:38:59 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZvG3Q03pCz6L5Kj;
 Sat, 10 May 2025 01:20:18 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 021081402EC;
 Sat, 10 May 2025 01:22:52 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.35.8) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 May 2025 19:22:51 +0200
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
 <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 1/7] hw/cxl/events: Update for rev3.2 common event record
 format
Date: Fri, 9 May 2025 18:22:23 +0100
Message-ID: <20250509172229.726-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250509172229.726-1-shiju.jose@huawei.com>
References: <20250509172229.726-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.195.35.8]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500007.china.huawei.com (7.182.85.172)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
format has updated with Maintenance Operation Subclass, LD ID and
ID of the device head information.

Add updates for the above spec changes in the related CXL events
reporting and QMP command to inject CXL events.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/mem/cxl_type3.c          | 30 +++++++++++++++++++-------
 hw/mem/cxl_type3_stubs.c    | 10 +++++++--
 include/hw/cxl/cxl_events.h | 15 ++++++++++---
 qapi/cxl.json               | 42 +++++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 12 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 11c38a9292..841d04d925 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1683,12 +1683,18 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
 
 static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                                     const QemuUUID *uuid, uint32_t flags,
-                                    uint8_t length, uint64_t timestamp)
+                                    uint8_t length, uint64_t timestamp,
+                                    uint8_t maint_class, uint8_t maint_subclass,
+                                    uint16_t ld_id, uint8_t head_id)
 {
     st24_le_p(&hdr->flags, flags);
     hdr->length = length;
     memcpy(&hdr->id, uuid, sizeof(hdr->id));
     stq_le_p(&hdr->timestamp, timestamp);
+    hdr->maint_op_class = maint_class;
+    hdr->maint_op_subclass = maint_subclass;
+    hdr->ld_id = ld_id;
+    hdr->head_id = head_id;
 }
 
 static const QemuUUID gen_media_uuid = {
@@ -1728,7 +1734,9 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
 }
 /* Component ID is device specific.  Define this as a string. */
 void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint64_t dpa,
+                                        uint8_t flags, uint8_t class,
+                                        uint8_t subclass, uint16_t ld_id,
+                                        uint8_t head_id, uint64_t dpa,
                                         uint8_t descriptor, uint8_t type,
                                         uint8_t transaction_type,
                                         bool has_channel, uint8_t channel,
@@ -1766,7 +1774,8 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
 
     memset(&gem, 0, sizeof(gem));
     cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            class, subclass, ld_id, head_id);
 
     stq_le_p(&gem.phys_addr, dpa);
     gem.descriptor = descriptor;
@@ -1811,6 +1820,8 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
 #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
 
 void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+                               uint8_t class, uint8_t subclass,
+                               uint16_t ld_id, uint8_t head_id,
                                uint64_t dpa, uint8_t descriptor,
                                uint8_t type, uint8_t transaction_type,
                                bool has_channel, uint8_t channel,
@@ -1853,7 +1864,8 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
 
     memset(&dram, 0, sizeof(dram));
     cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            class, subclass, ld_id, head_id);
     stq_le_p(&dram.phys_addr, dpa);
     dram.descriptor = descriptor;
     dram.type = type;
@@ -1914,7 +1926,9 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
 }
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint8_t type,
+                                        uint8_t flags, uint8_t class,
+                                        uint8_t subclass, uint16_t ld_id,
+                                        uint8_t head_id, uint8_t type,
                                         uint8_t health_status,
                                         uint8_t media_status,
                                         uint8_t additional_status,
@@ -1953,7 +1967,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
 
     memset(&module, 0, sizeof(module));
     cxl_assign_event_header(hdr, &memory_module_uuid, flags, sizeof(module),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            class, subclass, ld_id, head_id);
 
     module.type = type;
     module.health_status = health_status;
@@ -2202,7 +2217,8 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
      * Event Log.
      */
     cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
-                            cxl_device_get_timestamp(&dcd->cxl_dstate));
+                            cxl_device_get_timestamp(&dcd->cxl_dstate),
+                            0, 0, 0, 0);
 
     dCap.type = type;
     /* FIXME: for now, validity flag is cleared */
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index c1a5e4a7c1..9f95e4e6ec 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -14,7 +14,9 @@
 #include "qapi/qapi-commands-cxl.h"
 
 void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint64_t dpa,
+                                        uint8_t flags, uint8_t class,
+                                        uint8_t subclass, uint16_t ld_id,
+                                        uint8_t head_id, uint64_t dpa,
                                         uint8_t descriptor, uint8_t type,
                                         uint8_t transaction_type,
                                         bool has_channel, uint8_t channel,
@@ -24,6 +26,8 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         Error **errp) {}
 
 void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+                               uint8_t class, uint8_t subclass,
+                               uint16_t ld_id, uint8_t head_id,
                                uint64_t dpa, uint8_t descriptor,
                                uint8_t type, uint8_t transaction_type,
                                bool has_channel, uint8_t channel,
@@ -38,7 +42,9 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
                                Error **errp) {}
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint8_t type,
+                                        uint8_t flags, uint8_t class,
+                                        uint8_t subclass, uint16_t ld_id,
+                                        uint8_t head_id, uint8_t type,
                                         uint8_t health_status,
                                         uint8_t media_status,
                                         uint8_t additional_status,
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 38cadaa0f3..79a40f88bb 100644
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
index dd947d3bbc..2518d3d32a 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -42,6 +42,18 @@
 # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
 #     Record Format, Event Record Flags for subfield definitions.
 #
+# @class: Maintenance operation class the device requests to initiate.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @subclass: Maintenance operation subclass the device requests to
+#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @ld-id: LD ID of LD from where the event originated.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @head-id: ID of the device head from where the event originated.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
 #     Media Event Record, Physical Address.
@@ -74,6 +86,8 @@
 ##
 { 'command': 'cxl-inject-general-media-event',
   'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
+	    'class':'uint8', 'subclass':'uint8',
+	    'ld-id':'uint16', 'head-id':'uint8',
             'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8',
@@ -93,6 +107,18 @@
 # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
 #     Record Format, Event Record Flags for subfield definitions.
 #
+# @class: Maintenance operation class the device requests to initiate.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @subclass: Maintenance operation subclass the device requests to
+#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @ld-id: LD ID of LD from where the event originated.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @head-id: ID of the device head from where the event originated.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
 #     Event Record, Physical Address.
@@ -133,6 +159,8 @@
 ##
 { 'command': 'cxl-inject-dram-event',
   'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
+	    'class':'uint8', 'subclass':'uint8',
+	    'ld-id':'uint16', 'head-id':'uint8',
             'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
@@ -154,6 +182,18 @@
 # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
 #     Record Format, Event Record Flags for subfield definitions.
 #
+# @class: Maintenance operation class the device requests to initiate.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @subclass: Maintenance operation subclass the device requests to
+#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @ld-id: LD ID of LD from where the event originated.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @head-id: ID of the device head from where the event originated.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
 # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
 #     Event Record for bit definitions for bit definiions.
 #
@@ -185,6 +225,8 @@
 ##
 { 'command': 'cxl-inject-memory-module-event',
   'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
+	    'class':'uint8', 'subclass':'uint8',
+	    'ld-id':'uint16', 'head-id':'uint8',
             'type': 'uint8', 'health-status': 'uint8',
             'media-status': 'uint8', 'additional-status': 'uint8',
             'life-used': 'uint8', 'temperature' : 'int16',
-- 
2.43.0


