Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210B6C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPkK7-0004kL-RW; Thu, 12 Jun 2025 11:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uPkK6-0004k1-5X
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:58:38 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uPkK2-0003MN-Ae
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:58:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ6XG4wpDz6K5xK;
 Thu, 12 Jun 2025 23:54:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 9C39D1400D3;
 Thu, 12 Jun 2025 23:58:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 17:58:27 +0200
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, <fan.ni@samsung.com>,
 <qemu-devel@nongnu.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, Bowman Terry <terry.bowman@amd.com>
CC: <linuxarm@huawei.com>, <rientjes@google.com>, <dave@stgolabs.net>,
 <joshua.hahnjy@gmail.com>, <rkodsara@amd.com>, <sj@kernel.org>,
 <xuezhengchu@huawei.com>, <yiannis@zptcorp.com>, <ziy@nvidia.com>,
 <weixugc@google.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v2 QEMU 2/4] hw/cxl: Add emulation of a CXL Hotness
 Monitoring Unit (CHMU)
Date: Thu, 12 Jun 2025 16:57:22 +0100
Message-ID: <20250612155724.1887266-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250612155724.1887266-1-Jonathan.Cameron@huawei.com>
References: <20250612155724.1887266-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

CXL r3.2 defines a CXL Hotness Monitoring Unit. This allows for a CXL
device to do on device estimation of which 'granuals' of data are 'hot'
- that is accessed a lot. For a typical application hot data on a CXL
device both wastes potentially limited bandwidth and many have latency
impacts. Access counts are therefore a measurable proxy on which to base
memory placement decisions.

Typical use cases include:
1 - Establishing which data to move to faster RAM in a tiered memory
    system. Discussions on how to do this in Linux are ongoing so likely
    use case 2 will happen first.
2 - Provide detailed data (at low overhead) on what memory in an
    application is hot, allowing for optimization of initial data
    placement on future runs fo the application.

The focus of this emulation is providing a way to capture 'real' data
in order to help us develop and tune the kernel stack.

This emulated device will be fed with data from a QEMU plugin. That
plugin is responsible for the actual tracking and counting part of
hotness tracking. This device simply provides a timebase (epoch end
point) along with configuration and data retrieval.

The connection to the QEMU plugin providing the data is via a sockets.
Supply the cxl-type3 device parameter chmu-port=4443 to specify the
network port as 4443 and ensure the plugin is loaded (see later patch).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl.h        |   1 +
 include/hw/cxl/cxl_chmu.h   | 187 +++++++++++++
 include/hw/cxl/cxl_device.h |  24 +-
 include/hw/cxl/cxl_pci.h    |   3 +
 hw/cxl/cxl-chmu.c           | 516 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 103 ++++++-
 hw/cxl/meson.build          |   1 +
 7 files changed, 831 insertions(+), 4 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index de66ab8c35..12844d3418 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -16,6 +16,7 @@
 #include "hw/pci/pci_host.h"
 #include "cxl_pci.h"
 #include "cxl_component.h"
+#include "cxl_chmu.h"
 #include "cxl_device.h"
 
 #define CXL_CACHE_LINE_SIZE 64
diff --git a/include/hw/cxl/cxl_chmu.h b/include/hw/cxl/cxl_chmu.h
new file mode 100644
index 0000000000..2186e11a31
--- /dev/null
+++ b/include/hw/cxl/cxl_chmu.h
@@ -0,0 +1,187 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU CXL Hotness Monitoring Unit
+ *
+ * Copyright (c) 2025 Huawei
+ */
+
+#include "hw/register.h"
+
+#ifndef _CXL_CHMU_H_
+#define _CXL_CHMU_H_
+
+/* Emulated parameters - arbitrary choices */
+#define CXL_CHMU_INSTANCES_PER_BLOCK 1
+#define CXL_HOTLIST_ENTRIES 1024
+
+/* 1TB - should be enough for anyone, right? */
+#define CXL_MAX_DRAM_CAPACITY 0x10000000000UL
+
+/* Relative to per instance base address */
+#define CXL_CHMU_HL_START (0x70 + (CXL_MAX_DRAM_CAPACITY / (0x10000000UL * 8)))
+#define CXL_CHMU_INSTANCE_SIZE (CXL_CHMU_HL_START + CXL_HOTLIST_ENTRIES * 8)
+#define CXL_CHMU_SIZE \
+    (0x10 + CXL_CHMU_INSTANCE_SIZE * CXL_CHMU_INSTANCES_PER_BLOCK)
+
+/*
+ * Many of these registers are documented as being a multiple of 64 bits long.
+ * Reading then can only be done in 64 bit chunks though so specify them here
+ * as multiple registers.
+ */
+REG64(CXL_CHMU_COMMON_CAP0, 0x0)
+    FIELD(CXL_CHMU_COMMON_CAP0, VERSION, 0, 4)
+    FIELD(CXL_CHMU_COMMON_CAP0, NUM_INSTANCES, 8, 8)
+REG64(CXL_CHMU_COMMON_CAP1, 0x8)
+    FIELD(CXL_CHMU_COMMON_CAP1, INSTANCE_LENGTH, 0, 16)
+
+/* Per instance registers for instance 0 in CHMU main address space */
+REG64(CXL_CHMU0_CAP0, 0x10)
+    FIELD(CXL_CHMU0_CAP0, MSI_N, 0, 4)
+    FIELD(CXL_CHMU0_CAP0, OVERFLOW_INT, 4, 1)
+    FIELD(CXL_CHMU0_CAP0, LEVEL_INT, 5, 1)
+    FIELD(CXL_CHMU0_CAP0, EPOCH_TYPE, 6, 2)
+#define CXL_CHMU0_CAP0_EPOCH_TYPE_GLOBAL 0
+#define CXL_CHMU0_CAP0_EPOCH_TYPE_PERCNT 1
+    /* Break up the Tracked M2S Request field into flags */
+    FIELD(CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_R, 8, 1)
+    FIELD(CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_W, 9, 1)
+    FIELD(CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_RW, 10, 1)
+    FIELD(CXL_CHMU0_CAP0, TRACKED_M2S_REQ_ALL_R, 11, 1)
+    FIELD(CXL_CHMU0_CAP0, TRACKED_M2S_REQ_ALL_W, 12, 1)
+    FIELD(CXL_CHMU0_CAP0, TRACKED_M2S_REQ_ALL_RW, 13, 1)
+
+    FIELD(CXL_CHMU0_CAP0, MAX_EPOCH_LENGTH_SCALE, 16, 4)
+#define CXL_CHMU_EPOCH_LENGTH_SCALE_100USEC 1
+#define CXL_CHMU_EPOCH_LENGTH_SCALE_1MSEC 2
+#define CXL_CHMU_EPOCH_LENGTH_SCALE_10MSEC 3
+#define CXL_CHMU_EPOCH_LENGTH_SCALE_100MSEC 4
+#define CXL_CHMU_EPOCH_LENGTH_SCALE_1SEC 5
+    FIELD(CXL_CHMU0_CAP0, MAX_EPOCH_LENGTH_VAL, 20, 12)
+    FIELD(CXL_CHMU0_CAP0, MIN_EPOCH_LENGTH_SCALE, 32, 4)
+    FIELD(CXL_CHMU0_CAP0, MIN_EPOCH_LENGTH_VAL, 36, 12)
+    FIELD(CXL_CHMU0_CAP0, HOTLIST_SIZE, 48, 16)
+REG64(CXL_CHMU0_CAP1, 0x18)
+    FIELD(CXL_CHMU0_CAP1, UNIT_SIZES, 0, 32)
+    FIELD(CXL_CHMU0_CAP1, DOWN_SAMPLING_FACTORS, 32, 16)
+    /* Split up Flags */
+    FIELD(CXL_CHMU0_CAP1, FLAGS_EPOCH_BASED, 48, 1)
+    FIELD(CXL_CHMU0_CAP1, FLAGS_ALWAYS_ON, 49, 1)
+    FIELD(CXL_CHMU0_CAP1, FLAGS_RANDOMIZED_DOWN_SAMPLING, 50, 1)
+    FIELD(CXL_CHMU0_CAP1, FLAGS_OVERLAPPING_ADDRESS_RANGES, 51, 1)
+    FIELD(CXL_CHMU0_CAP1, FLAGS_INSERT_AFTER_CLEAR, 52, 1)
+REG64(CXL_CHMU0_CAP2, 0x20)
+    FIELD(CXL_CHMU0_CAP2, BITMAP_REG_OFFSET, 0, 64)
+REG64(CXL_CHMU0_CAP3, 0x28)
+    FIELD(CXL_CHMU0_CAP3, HOTLIST_REG_OFFSET, 0, 64)
+
+REG64(CXL_CHMU0_CONF0, 0x50)
+    FIELD(CXL_CHMU0_CONF0, M2S_REQ_TO_TRACK, 0, 8)
+    FIELD(CXL_CHMU0_CONF0, FLAGS_RANDOMIZE_DOWNSAMPLING, 8, 1)
+    FIELD(CXL_CHMU0_CONF0, FLAGS_INT_ON_OVERFLOW, 9, 1)
+    FIELD(CXL_CHMU0_CONF0, FLAGS_INT_ON_FILL_THRESH, 10, 1)
+    FIELD(CXL_CHMU0_CONF0, CONTROL_ENABLE, 16, 1)
+    FIELD(CXL_CHMU0_CONF0, CONTROL_RESET, 17, 1)
+    FIELD(CXL_CHMU0_CONF0, HOTNESS_THRESHOLD, 32, 32)
+REG64(CXL_CHMU0_CONF1, 0x58)
+    FIELD(CXL_CHMU0_CONF1, UNIT_SIZE, 0, 32)
+    FIELD(CXL_CHMU0_CONF1, DOWN_SAMPLING_FACTOR, 32, 8)
+    FIELD(CXL_CHMU0_CONF1, REPORTING_MODE, 40, 8)
+    FIELD(CXL_CHMU0_CONF1, EPOCH_LENGTH_SCALE, 48, 4)
+    FIELD(CXL_CHMU0_CONF1, EPOCH_LENGTH_VAL, 52, 12)
+REG64(CXL_CHMU0_CONF2, 0x60)
+    FIELD(CXL_CHMU0_CONF2, NOTIFICATION_THRESHOLD, 0, 16)
+
+REG64(CXL_CHMU0_STATUS, 0x70)
+    /* Break up status field into separate flags */
+    FIELD(CXL_CHMU0_STATUS, STATUS_ENABLED, 0, 1)
+    FIELD(CXL_CHMU0_STATUS, OPERATION_IN_PROG, 16, 16)
+    FIELD(CXL_CHMU0_STATUS, COUNTER_WIDTH, 32, 8)
+    /* Break up oddly named overflow interrupt stats */
+    FIELD(CXL_CHMU0_STATUS, OVERFLOW_INT, 40, 1)
+    FIELD(CXL_CHMU0_STATUS, LEVEL_INT, 41, 1)
+
+REG16(CXL_CHMU0_HEAD, 0x78)
+REG16(CXL_CHMU0_TAIL, 0x7A)
+
+/* Provide first few of these so we can calculate the size */
+REG64(CXL_CHMU0_RANGE_CONFIG_BITMAP0, 0x80)
+REG64(CXL_CHMU0_RANGE_CONFIG_BITMAP1, 0x88)
+
+REG64(CXL_CHMU0_HOTLIST0, CXL_CHMU_HL_START + 0x10)
+REG64(CXL_CHMU0_HOTLIST1, CXL_CHMU_HL_START + 0x10)
+
+REG64(CXL_CHMU1_CAP0, 0x10 + CXL_CHMU_INSTANCE_SIZE)
+
+typedef struct CHMUState CHMUState;
+
+/*
+ * Each device may have multiple CHMUs (CHMUState) with each CHMU having
+ * multiple hotness tracker instances (CHMUInstance).
+ */
+typedef struct CHMUInstance {
+    /* The reference to the PCIDevice is needed for MSI */
+    Object *private;
+    /* Number of counts in an epoch to be considered hot */
+    uint32_t hotness_thresh;
+    /* Tracking unit in bytes of DPA space as power of 2 */
+    uint32_t unit_size;
+    /*
+     * Ring buffer pointers
+     * - head is the offset in the ring of the oldest hot unit
+     * - tail is the offset in the ring of where the next hot unit will be
+     *   saved.
+     *
+     * Ring empty if head == tail.
+     * Ring full if (tail + 1) % length == head
+     */
+    uint16_t head, tail;
+    /* Ring buffer event threshold. Interrupt of first exceeding */
+    uint16_t fill_thresh;
+    /* Down sampling factor */
+    uint8_t ds_factor;
+    /* Type of request to track */
+    uint8_t what;
+
+    /* Interrupt controls and status */
+    bool int_on_overflow;
+    bool int_on_fill_thresh;
+    bool overflow_set;
+    bool fill_thresh_set;
+    uint8_t msi_n;
+
+    bool enabled;
+    uint64_t hotlist[CXL_HOTLIST_ENTRIES];
+    QEMUTimer *timer;
+    uint32_t epoch_ms;
+    uint8_t epoch_scale;
+    uint16_t epoch_val;
+    /* Reference needed for timer */
+    CHMUState *parent;
+} CHMUInstance;
+
+typedef struct CHMUState {
+    CHMUInstance inst[CXL_CHMU_INSTANCES_PER_BLOCK];
+    int socket;
+    /* Hack updated on first HDM decoder only */
+    uint16_t port;
+
+    /*
+     * Routing of accesses depends on interleave settings of the
+     * relevant memory range. That must be passed to the cache plugin.
+     */
+    struct {
+        uint64_t base;
+        uint64_t size;
+        uint64_t dpa_base;
+        uint16_t interleave_gran;
+        uint8_t ways;
+        uint8_t way;
+    } decoder[CXL_HDM_DECODER_COUNT];
+} CHMUState;
+
+typedef struct cxl_device_state CXLDeviceState;
+int cxl_chmu_register_block_init(Object *obj, CXLDeviceState *cxl_dstte,
+                                 int id, uint8_t msi_n, Error **errp);
+
+#endif /* _CXL_CHMU_H_ */
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9cc08da4cf..c4c092d77e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -13,6 +13,7 @@
 #include "hw/cxl/cxl_component.h"
 #include "hw/pci/pci_device.h"
 #include "hw/register.h"
+#include "hw/cxl/cxl_chmu.h"
 #include "hw/cxl/cxl_events.h"
 
 /*
@@ -91,9 +92,21 @@
     (CXL_MAILBOX_REGISTERS_OFFSET + CXL_MAILBOX_REGISTERS_LENGTH)
 #define CXL_MEMORY_DEVICE_REGISTERS_LENGTH 0x8
 
+#define CXL_NUM_CHMU_INSTANCES 1
+#define CXL_CHMU_OFFSET(x)                                               \
+    QEMU_ALIGN_UP(CXL_MEMORY_DEVICE_REGISTERS_OFFSET +                  \
+                  CXL_MEMORY_DEVICE_REGISTERS_LENGTH +                  \
+                  (x) * QEMU_ALIGN_UP(CXL_CHMU_SIZE, 1 << 16),          \
+                  1 << 16)
+
 #define CXL_MMIO_SIZE                                                   \
-    (CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_STATUS_REGISTERS_LENGTH +     \
-     CXL_MAILBOX_REGISTERS_LENGTH + CXL_MEMORY_DEVICE_REGISTERS_LENGTH)
+    QEMU_ALIGN_UP(CXL_DEVICE_CAP_REG_SIZE +                             \
+                  CXL_DEVICE_STATUS_REGISTERS_LENGTH +                  \
+                  CXL_MAILBOX_REGISTERS_LENGTH +                        \
+                  CXL_MEMORY_DEVICE_REGISTERS_LENGTH +                  \
+                  CXL_NUM_CHMU_INSTANCES *                              \
+                  QEMU_ALIGN_UP(CXL_CHMU_SIZE, 1 << 16),                \
+                  (1 << 16))
 
 /* CXL r3.1 Table 8-34: Command Return Codes */
 typedef enum {
@@ -236,6 +249,7 @@ typedef struct CXLCCI {
 
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
+    MemoryRegion chmu_registers[1];
 
     /* CXL r3.1 Section 8.2.8.3: Device Status Registers */
     struct {
@@ -285,6 +299,7 @@ typedef struct cxl_device_state {
     uint64_t vmem_size;
 
     const struct cxl_cmd (*cxl_cmd_set)[256];
+    CHMUState chmu[1];
     CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
 } CXLDeviceState;
 
@@ -698,6 +713,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs);
 
+bool cxl_type3_get_hdm_interleave_props(CXLType3Dev *ct3d, int which,
+                                        uint64_t *hpa_base, uint16_t *granual,
+                                        uint8_t *ways);
+void cxl_type3_set_hdm_isp(CXLType3Dev *ctrd, int which, uint8_t isp);
+
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
 
 void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num);
diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index 00a0335d55..5af10e8ce0 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -165,6 +165,7 @@ QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortFlexBus) != 0x20);
 enum register_locator_indicies {
     REG_LOC_IDX_COMPONENT,
     REG_LOC_IDX_DEVICE,
+    REG_LOC_IDX_CHMU0,
     NR_REG_LOC_IDX
 };
 /*
@@ -193,5 +194,7 @@ typedef struct CXLDVSECRegisterLocator {
 #define RBI_COMPONENT_REG  (1 << 8)
 #define RBI_BAR_VIRT_ACL   (2 << 8)
 #define RBI_CXL_DEVICE_REG (3 << 8)
+#define RBI_CXL_CPMU_REG   (4 << 8)
+#define RBI_CXL_CHMU_REG   (5 << 8)
 
 #endif
diff --git a/hw/cxl/cxl-chmu.c b/hw/cxl/cxl-chmu.c
new file mode 100644
index 0000000000..2e50eff5f8
--- /dev/null
+++ b/hw/cxl/cxl-chmu.c
@@ -0,0 +1,516 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * CXL Hotness Monitoring Unit
+ *
+ * Copyright(C) 2025 Huawei
+ *
+ * TODO:
+ * - Support bitmap of 256MiB ranges to track.
+ * - Downsampling
+ * - Multiple instances per block (CXL_CHMU_INSTANCES_PER_BLOCK > 1)
+ * - Read / Write only filtering
+ * - Cleanup error logging.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/guest-random.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_chmu.h"
+
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+
+#define CHMU_HOTLIST_LENGTH 1024
+
+/* Must match enum in plugin */
+enum chmu_consumer_request {
+    QUERY_TAIL,
+    QUERY_HEAD,
+    SET_THRESHOLD,
+    SET_HEAD,
+    SET_HOTLIST_SIZE,
+    QUERY_HOTLIST_ENTRY,
+    SIGNAL_EPOCH_END,
+    SET_ENABLED,
+    SET_GRANUAL_SIZE,
+    SET_HPA_BASE,
+    SET_HPA_SIZE,
+    SET_DPA_BASE,
+    SET_INTERLEAVE_WAYS,
+    SET_INTERLEAVE_WAY,
+    SET_INTERLEAVE_GRAN,
+};
+
+static int chmu_send(CHMUState *chmu, uint64_t instance,
+                     enum chmu_consumer_request command,
+                     uint64_t param, uint64_t param2, uint64_t *response)
+{
+    uint64_t request[4] = { instance, command, param, param2 };
+    uint64_t temp;
+    uint64_t *reply = response ?: &temp;
+
+    send(chmu->socket, request, sizeof(request), 0);
+    if (recv(chmu->socket, reply, sizeof(*reply), 0) < sizeof(reply)) {
+        return -1;
+    }
+    return 0;
+}
+
+static uint64_t chmu_read(void *opaque, hwaddr offset, unsigned size)
+{
+    const hwaddr chmu_stride = A_CXL_CHMU1_CAP0 - A_CXL_CHMU0_CAP0;
+    CHMUState *chmu = opaque;
+    CHMUInstance *chmui;
+    uint64_t val = 0;
+    int instance = 0;
+    int rc;
+
+    if (offset >= A_CXL_CHMU0_CAP0) {
+        instance = (offset - A_CXL_CHMU0_CAP0) / chmu_stride;
+        /*
+         * Offset allows register defs for CHMU instance 0 to be used
+         * for all instances. Includes COMMON_CAP.
+         */
+        offset -= chmu_stride * instance;
+    }
+
+    if (instance >= CXL_CHMU_INSTANCES_PER_BLOCK) {
+        return 0;
+    }
+
+    chmui = &chmu->inst[instance];
+    switch (offset) {
+    case A_CXL_CHMU_COMMON_CAP0:
+        val = FIELD_DP64(val, CXL_CHMU_COMMON_CAP0, VERSION, 1);
+        val = FIELD_DP64(val, CXL_CHMU_COMMON_CAP0, NUM_INSTANCES,
+                         CXL_CHMU_INSTANCES_PER_BLOCK);
+        break;
+    case A_CXL_CHMU_COMMON_CAP1:
+        val = FIELD_DP64(val, CXL_CHMU_COMMON_CAP1, INSTANCE_LENGTH,
+                         A_CXL_CHMU1_CAP0 - A_CXL_CHMU0_CAP0);
+        break;
+    case A_CXL_CHMU0_CAP0:
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MSI_N, chmui->msi_n);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, OVERFLOW_INT, 1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, LEVEL_INT, 1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, EPOCH_TYPE,
+                         CXL_CHMU0_CAP0_EPOCH_TYPE_GLOBAL);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_R, 1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_W, 1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_RW, 1);
+        /* No emulation of TEE modes yet so don't pretend to support them */
+
+        /* Epoch length from 100 milliseconds to 100 second */
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MAX_EPOCH_LENGTH_SCALE,
+                         CXL_CHMU_EPOCH_LENGTH_SCALE_1SEC);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MAX_EPOCH_LENGTH_VAL, 100);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MIN_EPOCH_LENGTH_SCALE,
+                         CXL_CHMU_EPOCH_LENGTH_SCALE_100MSEC);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MIN_EPOCH_LENGTH_VAL, 1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP0, HOTLIST_SIZE,
+                         CXL_HOTLIST_ENTRIES);
+        break;
+    case A_CXL_CHMU0_CAP1:
+        /* 4KiB and 8KiB only - 2^N * 256 for each bit set */
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, UNIT_SIZES, BIT(4) | BIT(5));
+        /* No downsampling  - 2^(N - 1) for each bit set */
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, DOWN_SAMPLING_FACTORS, BIT(1));
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_EPOCH_BASED, 1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_ALWAYS_ON, 0);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_RANDOMIZED_DOWN_SAMPLING,
+                         1);
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_OVERLAPPING_ADDRESS_RANGES,
+                         1);
+        /*
+         * Feature to enable a backlog of entries that immediately fill the list
+         * once space is available. Only relevant if reading list infrequently
+         * and concerned about stale data. (Not implemented)
+         */
+        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_INSERT_AFTER_CLEAR, 0);
+        break;
+    case A_CXL_CHMU0_CAP2:
+        val = FIELD_DP64(val, CXL_CHMU0_CAP2, BITMAP_REG_OFFSET,
+                         A_CXL_CHMU0_RANGE_CONFIG_BITMAP0 - A_CXL_CHMU0_CAP0);
+        break;
+    case A_CXL_CHMU0_CAP3:
+        val = FIELD_DP64(val, CXL_CHMU0_CAP3, HOTLIST_REG_OFFSET,
+                         A_CXL_CHMU0_HOTLIST0 - A_CXL_CHMU0_CAP0);
+        break;
+    case A_CXL_CHMU0_STATUS:
+        val = FIELD_DP64(val, CXL_CHMU0_STATUS, STATUS_ENABLED,
+                         chmui->enabled ? 1 : 0);
+        val = FIELD_DP64(val, CXL_CHMU0_STATUS, OPERATION_IN_PROG,
+                         0); /* All operations effectively instantaneous */
+        val = FIELD_DP64(val, CXL_CHMU0_STATUS, COUNTER_WIDTH, 16);
+        val = FIELD_DP64(val, CXL_CHMU0_STATUS, OVERFLOW_INT,
+                         chmui->overflow_set ? 1 : 0);
+        val = FIELD_DP64(val, CXL_CHMU0_STATUS, LEVEL_INT,
+                         chmui->fill_thresh_set ? 1 : 0);
+        break;
+    case A_CXL_CHMU0_CONF0:
+        val = FIELD_DP64(val, CXL_CHMU0_CONF0, M2S_REQ_TO_TRACK, chmui->what);
+        val = FIELD_DP64(val, CXL_CHMU0_CONF0, FLAGS_RANDOMIZE_DOWNSAMPLING, 0);
+        val = FIELD_DP64(val, CXL_CHMU0_CONF0, FLAGS_INT_ON_OVERFLOW,
+                         chmui->int_on_overflow);
+        val = FIELD_DP64(val, CXL_CHMU0_CONF0, FLAGS_INT_ON_FILL_THRESH,
+                         chmui->int_on_fill_thresh);
+        val = FIELD_DP64(val, CXL_CHMU0_CONF0, CONTROL_ENABLE,
+                         chmui->enabled);
+        val = FIELD_DP64(val, CXL_CHMU0_CONF0, CONTROL_RESET, 0);
+        val = FIELD_DP64(val, CXL_CHMU0_CONF0, HOTNESS_THRESHOLD,
+                         chmui->hotness_thresh);
+        break;
+    case A_CXL_CHMU0_CONF1:
+        val = FIELD_DP64(val, CXL_CHMU0_CONF1, UNIT_SIZE,
+                         chmui->unit_size);
+        val = FIELD_DP64(val, CXL_CHMU0_CONF1, DOWN_SAMPLING_FACTOR, 0);
+        val = FIELD_DP64(val, CXL_CHMU0_CONF1, REPORTING_MODE, 0);
+        val = FIELD_DP64(val, CXL_CHMU0_CONF1, EPOCH_LENGTH_SCALE,
+                         chmui->epoch_scale);
+        val = FIELD_DP64(val, CXL_CHMU0_CONF1, EPOCH_LENGTH_VAL,
+                         chmui->epoch_val);
+        break;
+    case A_CXL_CHMU0_CONF2:
+        val = FIELD_DP64(val, CXL_CHMU0_CONF2, NOTIFICATION_THRESHOLD,
+                         chmui->fill_thresh);
+        break;
+    case A_CXL_CHMU0_TAIL:
+        if (chmu->socket) {
+            rc = chmu_send(chmu, instance, QUERY_TAIL, 0, 0, &val);
+            if (rc < 0) {
+                printf("Failed to read tail\n");
+                return 0;
+            }
+        } else {
+            val = chmui->tail;
+        }
+        break;
+    case A_CXL_CHMU0_HEAD:
+        if (chmu->socket) {
+            rc = chmu_send(chmu, instance, QUERY_HEAD, 0, 0, &val);
+            if (rc < 0) {
+                printf("Failed to read head\n");
+                return 0;
+            }
+        } else {
+            val = chmui->head;
+        }
+        break;
+    case A_CXL_CHMU0_HOTLIST0...(8 * (A_CXL_CHMU0_HOTLIST0 +
+                                      CHMU_HOTLIST_LENGTH)):
+        if (chmu->socket) {
+            rc = chmu_send(chmu, instance, QUERY_HOTLIST_ENTRY,
+                           (offset - A_CXL_CHMU0_HOTLIST0) / 8, 0, &val);
+            if (rc < 0) {
+                printf("Failed to read a hotlist entry\n");
+                return 0;
+            }
+        } else {
+            val = chmui->hotlist[(offset - A_CXL_CHMU0_HOTLIST0) / 8];
+        }
+        break;
+    }
+    return val;
+}
+
+static void chmu_write(void *opaque, hwaddr offset, uint64_t value,
+                       unsigned size)
+{
+    CHMUState *chmu = opaque;
+    CHMUInstance *chmui;
+    hwaddr chmu_stride = A_CXL_CHMU1_CAP0 - A_CXL_CHMU0_CAP0;
+    int instance = 0;
+    int i, rc;
+
+    if (offset >= A_CXL_CHMU0_CAP0) {
+        instance = (offset - A_CXL_CHMU0_CAP0) / chmu_stride;
+        /* offset as if in chmu0 so includes the common caps */
+        offset -= chmu_stride * instance;
+    }
+    if (instance >= CXL_CHMU_INSTANCES_PER_BLOCK) {
+        return;
+    }
+
+    chmui = &chmu->inst[instance];
+
+    switch (offset) {
+    case A_CXL_CHMU0_STATUS:
+        /* The interrupt fields are RW12C */
+        if (FIELD_EX64(value, CXL_CHMU0_STATUS, OVERFLOW_INT)) {
+            chmui->overflow_set = false;
+        }
+        if (FIELD_EX64(value, CXL_CHMU0_STATUS, LEVEL_INT)) {
+            chmui->fill_thresh_set = false;
+        }
+        break;
+    case A_CXL_CHMU0_RANGE_CONFIG_BITMAP0...(A_CXL_CHMU0_HOTLIST0 - 8):
+        /* TODO - wire this up */
+        printf("Bitmap write %lx %lx\n",
+               offset - A_CXL_CHMU0_RANGE_CONFIG_BITMAP0, value);
+        break;
+    case A_CXL_CHMU0_CONF0:
+        if (FIELD_EX64(value, CXL_CHMU0_CONF0, CONTROL_ENABLE)) {
+            chmui->enabled = true;
+            timer_mod(chmui->timer,
+                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + chmui->epoch_ms);
+        } else {
+            timer_del(chmui->timer);
+            chmui->enabled = false;
+        }
+        if (chmu->socket) {
+            bool enabled = FIELD_EX64(value, CXL_CHMU0_CONF0, CONTROL_ENABLE);
+
+            if (enabled) {
+                int d;
+                for (d = 0; d < CXL_HDM_DECODER_COUNT; d++) {
+                    /* Should loop over ranges + the base addresses */
+
+                    rc = chmu_send(chmu, instance, SET_HPA_BASE,
+                                   chmu->decoder[d].base, d, NULL);
+                    if (rc < 0) {
+                        printf("Failed to set base\n");
+                    }
+                    rc = chmu_send(chmu, instance, SET_HPA_SIZE,
+                                   chmu->decoder[d].size, d, NULL);
+                    if (rc < 0) {
+                        printf("Failed to set size\n");
+                    }
+                    rc = chmu_send(chmu, instance, SET_DPA_BASE,
+                                   chmu->decoder[d].dpa_base, d, NULL);
+                    if (rc < 0) {
+                        printf("Failed to set base\n");
+                    }
+
+                    rc = chmu_send(chmu, instance, SET_INTERLEAVE_WAYS,
+                                   chmu->decoder[d].ways, d, NULL);
+                    if (rc < 0) {
+                        printf("Failed to set ways\n");
+                    }
+                    rc = chmu_send(chmu, instance, SET_INTERLEAVE_WAY,
+                                   chmu->decoder[d].way, d, NULL);
+                    if (rc < 0) {
+                        printf("Failed to set ways\n");
+                    }
+                    rc = chmu_send(chmu, instance, SET_INTERLEAVE_GRAN,
+                                   chmu->decoder[d].interleave_gran, d, NULL);
+                    if (rc < 0) {
+                        printf("Failed to set ways\n");
+                    }
+                }
+            }
+            rc = chmu_send(chmu, instance, SET_THRESHOLD,
+                           FIELD_EX64(value, CXL_CHMU0_CONF0,
+                                      HOTNESS_THRESHOLD),
+                           0, NULL);
+            if (rc < 0) {
+                printf("failed to set threshold\n");
+            }
+            rc = chmu_send(chmu, instance, SET_ENABLED, enabled ? 1 : 0, 0,
+                           NULL);
+            if (rc < 0) {
+                printf("Failed to set enabled\n");
+            }
+        }
+
+        if (FIELD_EX64(value, CXL_CHMU0_CONF0, CONTROL_RESET)) {
+            chmui->head = 0;
+            chmui->tail = 0;
+            for (i = 0; i < CXL_HOTLIST_ENTRIES; i++) {
+                chmui->hotlist[i] = 0;
+            }
+        }
+        chmui->what = FIELD_EX64(value, CXL_CHMU0_CONF0, M2S_REQ_TO_TRACK);
+        chmui->int_on_overflow =
+            FIELD_EX64(value, CXL_CHMU0_CONF0, FLAGS_INT_ON_OVERFLOW);
+        chmui->int_on_fill_thresh =
+            FIELD_EX64(value, CXL_CHMU0_CONF0, FLAGS_INT_ON_FILL_THRESH);
+        chmui->hotness_thresh =
+            FIELD_EX64(value, CXL_CHMU0_CONF0, HOTNESS_THRESHOLD);
+        break;
+    case A_CXL_CHMU0_CONF1: {
+        chmui->unit_size = FIELD_EX64(value, CXL_CHMU0_CONF1, UNIT_SIZE);
+        chmui->ds_factor =
+            FIELD_EX64(value, CXL_CHMU0_CONF1, DOWN_SAMPLING_FACTOR);
+
+        /* TODO: Sanity check value in supported range */
+        chmui->epoch_scale =
+            FIELD_EX64(value, CXL_CHMU0_CONF1, EPOCH_LENGTH_SCALE);
+        chmui->epoch_val = FIELD_EX64(value, CXL_CHMU0_CONF1, EPOCH_LENGTH_VAL);
+        switch (chmui->epoch_scale) {
+            /* TODO: Implement maths, not lookup */
+        case 1: /* 100usec */
+            chmui->epoch_ms = chmui->epoch_val / 10;
+            break;
+        case 2:
+            chmui->epoch_ms = chmui->epoch_val;
+            break;
+        case 3:
+            chmui->epoch_ms = chmui->epoch_val * 10;
+            break;
+        case 4:
+            chmui->epoch_ms = chmui->epoch_val * 100;
+            break;
+        case 5:
+            chmui->epoch_ms = chmui->epoch_val * 1000;
+            break;
+        default:
+            /* Unknown value so ignore */
+            break;
+        }
+        break;
+    }
+    case A_CXL_CHMU0_CONF2:
+        chmui->fill_thresh = FIELD_EX64(value, CXL_CHMU0_CONF2,
+                                        NOTIFICATION_THRESHOLD);
+        break;
+    case A_CXL_CHMU0_HEAD:
+        chmui->head = value;
+        if (chmu->socket) {
+            rc = chmu_send(chmu, instance, SET_HEAD, value, 0, NULL);
+            if (rc < 0) {
+                printf("Failed to set head pointer\n");
+            }
+        }
+        break;
+    case A_CXL_CHMU0_TAIL: /* Not sure why this is writeable! */
+        chmui->tail = value;
+        break;
+    }
+}
+
+static const MemoryRegionOps chmu_ops = {
+    .read = chmu_read,
+    .write = chmu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+static void chmu_timer_update(void *opaque)
+{
+    CHMUInstance *chmui = opaque;
+    PCIDevice *pdev = PCI_DEVICE(chmui->private);
+    bool interrupt_needed = false;
+    uint64_t reply;
+    int rc;
+
+    timer_del(chmui->timer);
+
+    /* FIXME: instance always 0! */
+    rc = chmu_send(chmui->parent, 0, SIGNAL_EPOCH_END, 0, 0, &reply);
+    if (rc < 0) {
+        error_setg(&error_fatal, "Epoch signalling failed");
+        return;
+    }
+
+    rc = chmu_send(chmui->parent, 0, QUERY_TAIL, 0, 0, &reply);
+    if (rc < 0) {
+        error_setg(&error_fatal, "Tail read failed");
+        return;
+    }
+    chmui->tail = reply;
+    printf("After epoch tail is %x\n", chmui->tail);
+
+    /* All interrupt code is kept in here whatever the data source */
+    if (chmui->int_on_fill_thresh && !chmui->fill_thresh_set) {
+        if (((chmui->tail > chmui->head) &&
+             (chmui->tail - chmui->head > chmui->fill_thresh)) |
+            ((chmui->tail < chmui->head) &&
+             (CXL_HOTLIST_ENTRIES - chmui->head + chmui->tail >
+              chmui->fill_thresh))) {
+            chmui->fill_thresh_set = true;
+            interrupt_needed = true;
+        }
+    }
+    if (chmui->int_on_overflow && !chmui->overflow_set) {
+        if ((chmui->tail + 1) % CXL_HOTLIST_ENTRIES == chmui->head) {
+            chmui->overflow_set = true;
+            interrupt_needed = true;
+        }
+    }
+
+    if (interrupt_needed) {
+        if (msix_enabled(pdev)) {
+            msix_notify(pdev, chmui->msi_n);
+        } else if (msi_enabled(pdev)) {
+            msi_notify(pdev, chmui->msi_n);
+        }
+    }
+
+    timer_mod(chmui->timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + chmui->epoch_ms);
+}
+
+int cxl_chmu_register_block_init(Object *obj, CXLDeviceState *cxl_dstate,
+                                 int id, uint8_t msi_n, Error **errp)
+{
+    CHMUState *chmu = &cxl_dstate->chmu[id];
+    MemoryRegion *registers = &cxl_dstate->chmu_registers[id];
+    g_autofree gchar *name = g_strdup_printf("chmu%d-registers", id);
+    int i;
+
+    memory_region_init_io(registers, obj, &chmu_ops, chmu, name,
+                          pow2ceil(CXL_CHMU_SIZE));
+    memory_region_add_subregion(&cxl_dstate->device_registers,
+                                CXL_CHMU_OFFSET(id), registers);
+
+    for (i = 0; i < CXL_CHMU_INSTANCES_PER_BLOCK; i++) {
+        CHMUInstance *chmui = &chmu->inst[i];
+
+        chmui->parent = chmu; /* Back reference needed for timer */
+        chmui->private = obj; /* Reference to PCIDevice needed for MSI/MSI-x */
+        chmui->msi_n = msi_n + i;
+        chmui->timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, chmu_timer_update,
+                                    chmui);
+    }
+
+    /* No port means fake non funtional hardware only */
+    if (chmu->port) {
+        struct sockaddr_in server_addr = {};
+
+        chmu->socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+        if (chmu->socket < 0) {
+            error_setg(errp, "Failed to create a socket");
+            return -1;
+        }
+
+        server_addr.sin_family = AF_INET;
+        server_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+        server_addr.sin_port = htons(chmu->port);
+        if (connect(chmu->socket, (struct sockaddr *)&server_addr,
+                    sizeof(server_addr)) < 0) {
+            close(chmu->socket);
+            error_setg(errp, "Socket connect failed");
+            return -1;
+        }
+
+        for (i = 0; i < CXL_CHMU_INSTANCES_PER_BLOCK; i++) {
+            uint64_t granual_size = (1 << chmu->inst[i].unit_size);
+            int rc;
+
+            rc = chmu_send(chmu, i, SET_HOTLIST_SIZE, CHMU_HOTLIST_LENGTH, 0,
+                           NULL);
+            if (rc) {
+                error_setg(errp, "Failed to set hotlist size");
+                return rc;
+            }
+
+            rc = chmu_send(chmu, i, SET_GRANUAL_SIZE, granual_size, 0, NULL);
+            if (rc) {
+                error_setg(errp, "Failed to set granual size");
+                return rc;
+            }
+        }
+    }
+
+    return 0;
+}
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index dcefd41088..43f4cd8023 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -36,7 +36,10 @@ enum CXL_T3_MSIX_VECTOR {
     CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS = 0,
     CXL_T3_MSIX_EVENT_START = 2,
     CXL_T3_MSIX_MBOX = CXL_T3_MSIX_EVENT_START + CXL_EVENT_TYPE_MAX,
-    CXL_T3_MSIX_VECTOR_NR
+    CXL_T3_MSIX_CHMU0_BASE,
+    /* One interrupt per CMUH instance in the block */
+    CXL_T3_MSIX_VECTOR_NR =
+        CXL_T3_MSIX_CHMU0_BASE + CXL_CHMU_INSTANCES_PER_BLOCK,
 };
 
 #define DWORD_BYTE 4
@@ -394,7 +397,13 @@ static void build_dvsecs(CXLType3Dev *ct3d)
             .lo = RBI_CXL_DEVICE_REG | CXL_DEVICE_REG_BAR_IDX,
             .hi = 0,
         },
+        .reg_base[REG_LOC_IDX_CHMU0] = {
+            .lo = CXL_CHMU_OFFSET(0) | RBI_CXL_CHMU_REG |
+            CXL_DEVICE_REG_BAR_IDX,
+            .hi = 0,
+        },
     };
+
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
                                REG_LOC_DVSEC_REVID, dvsec);
@@ -418,19 +427,101 @@ static void build_dvsecs(CXLType3Dev *ct3d)
                                PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
 }
 
+bool cxl_type3_get_hdm_interleave_props(CXLType3Dev *ct3d, int which,
+                                        uint64_t *hpa_base, uint16_t *granual,
+                                        uint8_t *ways)
+{
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
+    ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
+    uint32_t *cache_mem = cregs->cache_mem_registers;
+    uint32_t ctrl, low, high;
+
+    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
+    /* TODO: Sanity checks that the decoder is possible */
+    if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
+        return false;
+    }
+
+    *granual = cxl_decode_ig(FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG));
+    *ways = cxl_interleave_ways_dec(FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW),
+                                    NULL);
+    low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + which * hdm_inc);
+    high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + which * hdm_inc);
+    *hpa_base = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+    return true;
+}
+
+/* Only the CHMU needs to know the way */
+void cxl_type3_set_hdm_isp(CXLType3Dev *ct3d, int which, uint8_t isp)
+{
+    ct3d->cxl_dstate.chmu[0].decoder[which].way = isp;
+}
+
 static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
 {
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
     uint32_t *cache_mem = cregs->cache_mem_registers;
-    uint32_t ctrl;
+    uint32_t ctrl, low, high;
+    uint64_t dpa_base = 0;
+    uint8_t iws;
+    uint16_t ig;
+    int d;
 
     ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
     /* TODO: Sanity checks that the decoder is possible */
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
 
+    /* Get interleave details for chmu */
+    ig = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
+    ct3d->cxl_dstate.chmu[0].decoder[which].interleave_gran = cxl_decode_ig(ig);
+
+    iws = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
+    ct3d->cxl_dstate.chmu[0].decoder[which].ways =
+        cxl_interleave_ways_dec(iws, NULL);
+
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
+
+    low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + which * hdm_inc);
+    high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + which * hdm_inc);
+    ct3d->cxl_dstate.chmu[0].decoder[which].base =
+        ((uint64_t)high << 32) | (low & 0xf0000000);
+
+    low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + which * hdm_inc);
+    high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + which * hdm_inc);
+    ct3d->cxl_dstate.chmu[0].decoder[which].size =
+        ((uint64_t)high << 32) | (low & 0xf0000000);
+
+    /*
+     * To figure out the DPA start, Add size / ways + skip for all earlier
+     * decoders + skip for the current one.
+     */
+    for (d = 0; d < which; d++) {
+        ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + d * hdm_inc);
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO
+                       + d * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI
+                        + d * hdm_inc);
+        dpa_base += ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        iws = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + d * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + d * hdm_inc);
+        /* DPA space used is size / ways */
+        dpa_base += (((uint64_t)high << 32) | (low & 0xf0000000)) /
+            cxl_interleave_ways_dec(iws, NULL);
+    }
+    low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
+                   which * hdm_inc);
+    high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
+                    which * hdm_inc);
+    dpa_base += ((uint64_t)high << 32) | (low & 0xf0000000);
+
+
+    ct3d->cxl_dstate.chmu[0].decoder[which].dpa_base = dpa_base;
 }
 
 static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
@@ -913,6 +1004,13 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
     cxl_device_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate,
                                    &ct3d->cci);
+
+    rc = cxl_chmu_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate,
+                                      0, CXL_T3_MSIX_CHMU0_BASE, errp);
+    if (rc) {
+        goto err_free_special_ops;
+    }
+
     pci_register_bar(pci_dev, CXL_DEVICE_REG_BAR_IDX,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                          PCI_BASE_ADDRESS_MEM_TYPE_64,
@@ -1288,6 +1386,7 @@ static const Property ct3_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
 };
 
 static uint64_t get_lsa_size(CXLType3Dev *ct3d)
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index 3e375f61a9..e3abb49d27 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -6,6 +6,7 @@ system_ss.add(when: 'CONFIG_CXL',
                    'cxl-host.c',
                    'cxl-cdat.c',
                    'cxl-events.c',
+                   'cxl-chmu.c',
                    'switch-mailbox-cci.c',
                ),
                if_false: files(
-- 
2.48.1


