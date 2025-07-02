Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45776C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 16:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX008-0001nI-Bw; Wed, 02 Jul 2025 12:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWzzD-0001Fm-La
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:07:04 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWzzB-0008OU-3Q
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:07:03 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXPrp5cjWz6M4fv;
 Thu,  3 Jul 2025 00:06:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 92B291400D4;
 Thu,  3 Jul 2025 00:06:58 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Jul 2025 18:06:58 +0200
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 09/11] hw/cxl: Create helper function to create DC Event
 Records from extents
Date: Wed, 2 Jul 2025 17:02:15 +0100
Message-ID: <20250702160219.989731-10-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anisa Su <anisa.su@samsung.com>

Prepatory patch for following FMAPI Add/Release Patches. Refactors part
of qmp_cxl_process_dynamic_capacity_prescriptive() into a helper
function to create DC Event Records and insert in the event log.

Moves definition for CXL_NUM_EXTENTS_SUPPORTED to cxl.h so it can be
accessed by cxl-mailbox-utils.c and cxl-events.c, where the helper
function is defined.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl.h        |  1 +
 include/hw/cxl/cxl_device.h |  4 ++++
 hw/cxl/cxl-events.c         | 38 +++++++++++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  |  1 -
 hw/mem/cxl_type3.c          | 37 +-----------------------------------
 5 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e47b6864..3ae4303383 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -23,6 +23,7 @@
 #define CXL_DEVICE_REG_BAR_IDX 2
 
 #define CXL_WINDOW_MAX 10
+#define CXL_NUM_EXTENTS_SUPPORTED 512
 
 typedef struct PXBCXLDev PXBCXLDev;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 76af75d2d0..ed91e5387e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -724,4 +724,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
                              uint8_t length, uint64_t timestamp);
+void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
+                                             CXLDCEventType type,
+                                             CXLDCExtentRaw extents[],
+                                             uint32_t ext_count);
 #endif
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 12dee2e467..724055f2cf 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -260,3 +260,41 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d)
         }
     }
 }
+
+void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
+                                             CXLDCEventType type,
+                                             CXLDCExtentRaw extents[],
+                                             uint32_t ext_count)
+{
+    CXLEventDynamicCapacity event_rec = {};
+    int i;
+
+    cxl_assign_event_header(&event_rec.hdr,
+                            &dynamic_capacity_uuid,
+                            (1 << CXL_EVENT_TYPE_INFO),
+                            sizeof(event_rec),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+    event_rec.type = type;
+    event_rec.validity_flags = 1;
+    event_rec.host_id = 0;
+    event_rec.updated_region_id = 0;
+    event_rec.extents_avail = CXL_NUM_EXTENTS_SUPPORTED -
+                              ct3d->dc.total_extent_count;
+
+    for (i = 0; i < ext_count; i++) {
+        memcpy(&event_rec.dynamic_capacity_extent,
+               &extents[i],
+               sizeof(CXLDCExtentRaw));
+        event_rec.flags = 0;
+        if (i < ext_count - 1) {
+            /* Set "More" flag */
+            event_rec.flags |= BIT(0);
+        }
+
+        if (cxl_event_insert(&ct3d->cxl_dstate,
+                             CXL_EVENT_TYPE_DYNAMIC_CAP,
+                             (CXLEventRecordRaw *)&event_rec)) {
+            cxl_event_irq_assert(ct3d);
+        }
+    }
+}
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 24e4ba0200..d0a1d63582 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -27,7 +27,6 @@
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
-#define CXL_NUM_EXTENTS_SUPPORTED 512
 #define CXL_NUM_TAGS_SUPPORTED 0
 #define CXL_ALERTS_LIFE_USED_WARN_THRESH (1 << 0)
 #define CXL_ALERTS_OVER_TEMP_WARN_THRESH (1 << 1)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ee554a77be..9c2b9d197b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1957,15 +1957,11 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         CxlDynamicCapacityExtentList *records, Error **errp)
 {
     Object *obj;
-    CXLEventDynamicCapacity dCap = {};
-    CXLEventRecordHdr *hdr = &dCap.hdr;
     CXLType3Dev *dcd;
-    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
     uint32_t num_extents = 0;
     CxlDynamicCapacityExtentList *list;
     CXLDCExtentGroup *group = NULL;
     g_autofree CXLDCExtentRaw *extents = NULL;
-    uint8_t enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP;
     uint64_t dpa, offset, len, block_size;
     g_autofree unsigned long *blk_bitmap = NULL;
     int i;
@@ -2078,38 +2074,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         dcd->dc.total_extent_count += num_extents;
     }
 
-    /*
-     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
-     *
-     * All Dynamic Capacity event records shall set the Event Record Severity
-     * field in the Common Event Record Format to Informational Event. All
-     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
-     * Event Log.
-     */
-    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
-                            cxl_device_get_timestamp(&dcd->cxl_dstate));
-
-    dCap.type = type;
-    /* FIXME: for now, validity flag is cleared */
-    dCap.validity_flags = 0;
-    stw_le_p(&dCap.host_id, hid);
-    /* only valid for DC_REGION_CONFIG_UPDATED event */
-    dCap.updated_region_id = 0;
-    for (i = 0; i < num_extents; i++) {
-        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
-               sizeof(CXLDCExtentRaw));
-
-        dCap.flags = 0;
-        if (i < num_extents - 1) {
-            /* Set "More" flag */
-            dCap.flags |= BIT(0);
-        }
-
-        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
-                             (CXLEventRecordRaw *)&dCap)) {
-            cxl_event_irq_assert(dcd);
-        }
-    }
+    cxl_create_dc_event_records_for_extents(dcd, type, extents, num_extents);
 }
 
 void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
-- 
2.48.1


