Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F333CCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuUP-0004FE-5j; Mon, 03 Nov 2025 08:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vFuUK-0004Ei-Gc
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:20:48 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vFuUD-0001RL-Vs
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:20:48 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9AD734080F;
 Mon,  3 Nov 2025 13:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1EAC113D0;
 Mon,  3 Nov 2025 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762176036;
 bh=FAvK/z5ri6qiLZatvY6moYiJ+zjQMC+ul2Qox/y/z+8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o00Hjkh4RSr7mLm+ONNmw1ciuxVKECljl6qgO0otASYdPdAQ9m+HBeO1HhFwscyTW
 dMQKQ/NA7biF8VYmeIYLPKHbeFxjUuUOpobjHgVHDRHaq6/2krjOeo5ya6Y4uQpken
 qYGRaY6OI4CIHA3+QrRStwkQdKksDZAqSTn3sg/pSq8OybdWMa/7PVTNai1fbN0aZZ
 iwcLr4j92oLYuoYtJ0sAddjHgXCHUsWKpKWupQc6jCeJG9jD1mgXHX1urUzP2UCX3b
 OXPCch4scJmQ4EOd5Xrt1+Lsh+XnvXTNStE4o1o+AjK3I4zhzQPmuyjcWAyCa/RjKk
 XSQ2r+GejMJfQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 2/3] i82596: Added core infrastructure and helper functions
Date: Mon,  3 Nov 2025 14:20:28 +0100
Message-ID: <20251103132029.6725-3-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103132029.6725-1-deller@kernel.org>
References: <20251103132029.6725-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

As a part of GSOC 2025 I have done a massive rewrite of what was the
82596 NIC. This has been done to add the missing functionality according
to the 82596 Manual and making the code production ready.

This patch adds:
- comprehensive 82596 constants and configuration macros
- address translation for segmented/linear memory modes
- error recording and statistics tracking infrastructure
- CRC-16/32 calculation and appending functions
- CSMA/CD collision detection and backoff logic
- bus throttle timer framework
- enhanced reset with full state initialization
- receive_iov and polling support functions
- updated VMState for migration of all new fields

Note:
This patch primarily includes placeholder code.
To achieve full 82596 emulation, the complete 82596 patch series is
required.  Nevertheless, QEMU is able to load and boot successfully with
this patch.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/net/i82596.c      | 667 ++++++++++++++++++++++++++++++++++++++-----
 hw/net/i82596.h      |  74 ++++-
 hw/net/lasi_i82596.c |   6 +
 3 files changed, 655 insertions(+), 92 deletions(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index c1ff3e6c56..859cc88b2e 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -2,10 +2,38 @@
  * QEMU Intel i82596 (Apricot) emulation
  *
  * Copyright (c) 2019 Helge Deller <deller@gmx.de>
- * This work is licensed under the GNU GPL license version 2 or later.
  *
+ * Additional functionality added by:
+ * Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
+ * During GSOC 2025 under mentorship of Helge Deller.
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
  * This software was written to be compatible with the specification:
  * https://parisc.docs.kernel.org/en/latest/_downloads/96672be0650d9fc046bbcea40b92482f/82596CA.pdf
+ *
+ * INDEX:
+ * 1.  Reset
+ * 2.  Address Translation
+ * 3.  Transmit functions
+ * 4.  Receive Helper functions
+ * 5.  Receive functions
+ * 6.  Misc Functionality Functions
+ * 6.1 Individual Address
+ * 6.2 Multicast Address List
+ * 6.3 Link Status
+ * 6.4 CSMA/CD functions
+ * 6.5 Unified CRC Calculation
+ * 6.6 Unified Statistics Update
+ * 7.  Bus Throttling Timer
+ * 8.  Dump functions
+ * 9.  Configure
+ * 10. Command Loop
+ * 11. Examine SCB
+ * 12. Channel attention (CA)
+ * 13. LASI interface
+ * 14. Polling functions
+ * 15. QOM and interface functions
+ *
  */
 
 #include "qemu/osdep.h"
@@ -21,50 +49,90 @@
 #include "i82596.h"
 #include <zlib.h> /* for crc32 */
 
+#define ENABLE_DEBUG 0
+
 #if defined(ENABLE_DEBUG)
 #define DBG(x)          x
 #else
 #define DBG(x)          do { } while (0)
 #endif
 
-#define USE_TIMER       0
-
-#define BITS(n, m) (((0xffffffffU << (31 - n)) >> (31 - n + m)) << m)
+#define USE_TIMER       1
 
-#define PKT_BUF_SZ      1536
 #define MAX_MC_CNT      64
-
-#define ISCP_BUSY       0x0001
-
 #define I596_NULL       ((uint32_t)0xffffffff)
-
-#define SCB_STATUS_CX   0x8000 /* CU finished command with I bit */
-#define SCB_STATUS_FR   0x4000 /* RU finished receiving a frame */
-#define SCB_STATUS_CNA  0x2000 /* CU left active state */
-#define SCB_STATUS_RNR  0x1000 /* RU left active state */
-
-#define SCB_COMMAND_ACK_MASK \
-        (SCB_STATUS_CX | SCB_STATUS_FR | SCB_STATUS_CNA | SCB_STATUS_RNR)
-
+#define BITS(n, m)      (((0xffffffffU << (31 - n)) >> (31 - n + m)) << m)
+
+#define SCB_STATUS_CX   0x8000  /* CU finished command with I bit */
+#define SCB_STATUS_FR   0x4000  /* RU finished receiving a frame */
+#define SCB_STATUS_CNA  0x2000  /* CU left active state */
+#define SCB_STATUS_RNR  0x1000  /* RU left active state */
+#define SCB_ACK_MASK    0xF000  /* All interrupt acknowledge bits */
+
+/* 82596 Operational Modes */
+#define I82586_MODE                 0x00
+#define I82596_MODE_SEGMENTED       0x01
+#define I82596_MODE_LINEAR          0x02
+
+/* Monitor Options */
+#define MONITOR_NORMAL      0x00
+#define MONITOR_FILTERED    0x01
+#define MONITOR_ALL         0x02
+#define MONITOR_DISABLED    0x03
+
+/* Operation mode flags from SYSBUS byte */
+#define SYSBUS_LOCK_EN         0x08
+#define SYSBUS_INT_ACTIVE_LOW  0x10
+#define SYSBUS_BIG_ENDIAN_32   0x80
+#define SYSBUS_THROTTLE_MASK   0x60
+
+/* SCB commands - Command Unit (CU) */
+#define SCB_CUC_NOP            0x00
+#define SCB_CUC_START          0x01
+#define SCB_CUC_RESUME         0x02
+#define SCB_CUC_SUSPEND        0x03
+#define SCB_CUC_ABORT          0x04
+#define SCB_CUC_LOAD_THROTTLE  0x05
+#define SCB_CUC_LOAD_START     0x06
+
+/* SCB commands - Receive Unit (RU) */
+#define SCB_RUC_NOP            0x00
+#define SCB_RUC_START          0x01
+#define SCB_RUC_RESUME         0x02
+#define SCB_RUC_SUSPEND        0x03
+#define SCB_RUC_ABORT          0x04
+
+/* SCB statuses - Command Unit (CU) */
 #define CU_IDLE         0
 #define CU_SUSPENDED    1
 #define CU_ACTIVE       2
 
-#define RX_IDLE         0
-#define RX_SUSPENDED    1
-#define RX_READY        4
+/* SCB statuses - Receive Unit (RU) */
+#define RX_IDLE         0x00
+#define RX_SUSPENDED    0x01
+#define RX_NO_RESOURCES 0x02
+#define RX_READY        0x04
+#define RX_NO_RESO_RBD  0x0A
+#define RX_NO_MORE_RBD  0x0C
+
+#define CMD_FLEX        0x0008
+#define CMD_MASK        0x0007
+
+#define CMD_EOL         0x8000
+#define CMD_SUSP        0x4000
+#define CMD_INTR        0x2000
 
-#define CMD_EOL         0x8000  /* The last command of the list, stop. */
-#define CMD_SUSP        0x4000  /* Suspend after doing cmd. */
-#define CMD_INTR        0x2000  /* Interrupt after doing cmd. */
+#define ISCP_BUSY                   0x01
+#define NANOSECONDS_PER_MICROSECOND 1000
 
-#define CMD_FLEX        0x0008  /* Enable flexible memory model */
+#define DUMP_BUF_SZ                 304
 
 enum commands {
         CmdNOp = 0, CmdSASetup = 1, CmdConfigure = 2, CmdMulticastList = 3,
         CmdTx = 4, CmdTDR = 5, CmdDump = 6, CmdDiagnose = 7
 };
 
+
 #define STAT_C          0x8000  /* Set to 0 after execution */
 #define STAT_B          0x4000  /* Command being executed */
 #define STAT_OK         0x2000  /* Command executed ok */
@@ -73,15 +141,60 @@ enum commands {
 #define I596_EOF        0x8000
 #define SIZE_MASK       0x3fff
 
-/* various flags in the chip config registers */
-#define I596_PREFETCH   (s->config[0] & 0x80)
-#define I596_PROMISC    (s->config[8] & 0x01)
-#define I596_BC_DISABLE (s->config[8] & 0x02) /* broadcast disable */
-#define I596_NOCRC_INS  (s->config[8] & 0x08)
-#define I596_CRCINM     (s->config[11] & 0x04) /* CRC appended */
-#define I596_MC_ALL     (s->config[11] & 0x20)
-#define I596_MULTIIA    (s->config[13] & 0x40)
-
+#define CSMA_SLOT_TIME         51
+#define CSMA_MAX_RETRIES       16
+#define CSMA_BACKOFF_LIMIT     10
+
+/* Global Flags fetched from config bytes */
+#define I596_PREFETCH       (s->config[0] & 0x80)
+#define SAVE_BAD_FRAMES     (s->config[2] & 0x80)
+#define I596_NO_SRC_ADD_IN  (s->config[3] & 0x08)
+#define I596_LOOPBACK       (s->config[3] >> 6)
+#define I596_PROMISC        (s->config[8] & 0x01)
+#define I596_BC_DISABLE     (s->config[8] & 0x02)
+#define I596_NOCRC_INS      (s->config[8] & 0x08)
+#define I596_CRC16_32       (s->config[8] & 0x10)
+#define I596_PADDING        (s->config[8] & 0x80)
+#define I596_MIN_FRAME_LEN  (s->config[10])
+#define I596_CRCINM         (s->config[11] & 0x04)
+#define I596_MONITOR_MODE   ((s->config[11] >> 6) & 0x03)
+#define I596_MC_ALL         (s->config[11] & 0x20)
+#define I596_FULL_DUPLEX    (s->config[12] & 0x40)
+#define I596_MULTIIA        (s->config[13] & 0x40)
+
+/* RX Error flags */
+#define RX_COLLISIONS         0x0001
+#define RX_LENGTH_ERRORS      0x0080
+#define RX_OVER_ERRORS        0x0100
+#define RX_FIFO_ERRORS        0x0400
+#define RX_FRAME_ERRORS       0x0800
+#define RX_CRC_ERRORS         0x1000
+#define RX_LENGTH_ERRORS_ALT  0x2000
+#define RFD_STATUS_TRUNC      0x0020
+#define RFD_STATUS_NOBUFS     0x0200
+
+/* TX Error flags */
+#define TX_COLLISIONS       0x0020
+#define TX_HEARTBEAT_ERRORS 0x0040
+#define TX_CARRIER_ERRORS   0x0400
+#define TX_COLLISIONS_ALT   0x0800
+#define TX_ABORTED_ERRORS   0x1000
+
+static void i82596_update_scb_irq(I82596State *s, bool trigger);
+static void i82596_update_cu_status(I82596State *s, uint16_t cmd_status,
+                                     bool generate_interrupt);
+static void update_scb_status(I82596State *s);
+static void examine_scb(I82596State *s);
+static bool i82596_check_medium_status(I82596State *s);
+static int i82596_csma_backoff(I82596State *s, int retry_count);
+static uint16_t i82596_calculate_crc16(const uint8_t *data, size_t len);
+static size_t i82596_append_crc(I82596State *s, uint8_t *buffer, size_t len);
+static void i82596_bus_throttle_timer(void *opaque);
+static void i82596_flush_queue_timer(void *opaque);
+static int i82596_flush_packet_queue(I82596State *s);
+static void i82596_update_statistics(I82596State *s, bool is_tx,
+                                      uint16_t error_flags,
+                                      uint16_t collision_count);
 
 static uint8_t get_byte(uint32_t addr)
 {
@@ -116,7 +229,44 @@ static void set_uint32(uint32_t addr, uint32_t val)
     set_uint16(addr + 2, val >> 16);
 }
 
+/* Centralized error detection and update mechanism */
+static void i82596_record_error(I82596State *s, uint16_t error_type, bool is_tx)
+{
+    if (is_tx) {
+        if (error_type & TX_ABORTED_ERRORS) {
+            s->tx_aborted_errors++;
+            set_uint32(s->scb + 28, s->tx_aborted_errors);
+        }
+    } else {
+        if (error_type & RX_CRC_ERRORS) {
+            s->crc_err++;
+            set_uint32(s->scb + 16, s->crc_err);
+        }
 
+        if (error_type & (RX_LENGTH_ERRORS | RX_LENGTH_ERRORS_ALT |
+                          RX_FRAME_ERRORS)) {
+            s->align_err++;
+            set_uint32(s->scb + 18, s->align_err);
+        }
+
+        if (error_type & RFD_STATUS_NOBUFS) {
+            s->resource_err++;
+            set_uint32(s->scb + 20, s->resource_err);
+        }
+
+        if (error_type & (RX_OVER_ERRORS | RX_FIFO_ERRORS)) {
+            s->over_err++;
+            set_uint32(s->scb + 22, s->over_err);
+        }
+
+        if (error_type & RFD_STATUS_TRUNC) {
+            s->short_fr_error++;
+            set_uint32(s->scb + 26, s->short_fr_error);
+        }
+    }
+}
+
+/* Packet Header Debugger */
 struct qemu_ether_header {
     uint8_t ether_dhost[6];
     uint8_t ether_shost[6];
@@ -124,12 +274,122 @@ struct qemu_ether_header {
 };
 
 #define PRINT_PKTHDR(txt, BUF) do {                  \
-    struct qemu_ether_header *hdr = (void *)(BUF); \
-    printf(txt ": packet dhost=" MAC_FMT ", shost=" MAC_FMT ", type=0x%04x\n",\
-           MAC_ARG(hdr->ether_dhost), MAC_ARG(hdr->ether_shost),        \
-           be16_to_cpu(hdr->ether_type));       \
 } while (0)
 
+static void i82596_cleanup(I82596State *s)
+{
+    if (s->throttle_timer) {
+        timer_del(s->throttle_timer);
+    }
+    if (s->flush_queue_timer) {
+        timer_del(s->flush_queue_timer);
+    }
+    s->queue_head = 0;
+    s->queue_tail = 0;
+    s->queue_count = 0;
+}
+
+static void i82596_s_reset(I82596State *s)
+{
+    trace_i82596_s_reset(s);
+    i82596_cleanup(s);
+
+    /* Clearing config bits */
+    memset(s->config, 0, sizeof(s->config));
+    s->scp = 0x00FFFFF4;
+    s->scb = 0;
+    s->scb_base = 0;
+    s->scb_status = 0;
+    s->cu_status = CU_IDLE;
+    s->rx_status = RX_IDLE;
+    s->cmd_p = I596_NULL;
+    s->lnkst = 0x8000;
+    s->ca = s->ca_active = 0;
+    s->send_irq = 0;
+
+    /* Statistical Counters */
+    s->crc_err = 0;
+    s->align_err = 0;
+    s->resource_err = 0;
+    s->over_err = 0;
+    s->rcvdt_err = 0;
+    s->short_fr_error = 0;
+    s->total_frames = 0;
+    s->total_good_frames = 0;
+    s->collision_events = 0;
+    s->total_collisions = 0;
+    s->tx_good_frames = 0;
+    s->tx_collisions = 0;
+    s->tx_aborted_errors = 0;
+    s->last_tx_len = 0;
+
+    s->last_good_rfa = 0;
+    s->current_rx_desc = 0;
+    s->current_tx_desc = 0;
+    s->tx_retry_addr = 0;
+    s->tx_retry_count = 0;
+
+    s->rnr_signaled = false;
+    s->flushing_queue = false;
+
+    memset(s->tx_buffer, 0, sizeof(s->tx_buffer));
+    memset(s->rx_buffer, 0, sizeof(s->rx_buffer));
+    s->tx_frame_len = 0;
+    s->rx_frame_len = 0;
+}
+
+void i82596_h_reset(void *opaque)
+{
+    I82596State *s = opaque;
+
+    i82596_s_reset(s);
+}
+
+/*
+ * Address Translation Implementation
+ * Handles segmented and linear memory modes for i82596.
+ * Returns physical address for DMA operations.
+ * Returns I596_NULL (0xffffffff) on invalid addresses.
+ */
+static inline uint32_t i82596_translate_address(I82596State *s,
+                                                 uint32_t logical_addr,
+                                                 bool is_data_buffer)
+{
+    if (logical_addr == I596_NULL || logical_addr == 0) {
+        return logical_addr;
+    }
+
+    switch (s->mode) {
+    case I82596_MODE_LINEAR:
+        return logical_addr;
+
+    case I82596_MODE_SEGMENTED: {
+        uint32_t base = (logical_addr >> 16) & 0xFFFF;
+        uint32_t offset = logical_addr & 0xFFFF;
+
+        if (is_data_buffer) {
+            return (base << 4) + offset;
+        } else {
+            if (base == 0xFFFF && offset == 0xFFFF) {
+                return I596_NULL;
+            }
+            return s->scb_base + ((base << 4) + offset);
+        }
+    }
+
+    case I82586_MODE:
+    default:
+        if (is_data_buffer) {
+            return logical_addr;
+        } else {
+            if ((logical_addr & 0xFFFF0000) == 0xFFFF0000) {
+                return I596_NULL;
+            }
+            return s->scb_base + logical_addr;
+        }
+    }
+}
+
 static void i82596_transmit(I82596State *s, uint32_t addr)
 {
     uint32_t tdb_p; /* Transmit Buffer Descriptor */
@@ -223,32 +483,198 @@ static void set_multicast_list(I82596State *s, uint32_t addr)
 
 void i82596_set_link_status(NetClientState *nc)
 {
-    I82596State *d = qemu_get_nic_opaque(nc);
+    I82596State *s = qemu_get_nic_opaque(nc);
+    bool was_up = s->lnkst != 0;
+
+    s->lnkst = nc->link_down ? 0 : 0x8000;
+    bool is_up = s->lnkst != 0;
 
-    d->lnkst = nc->link_down ? 0 : 0x8000;
+    if (!was_up && is_up && s->rx_status == RX_READY) {
+        qemu_flush_queued_packets(qemu_get_queue(s->nic));
+    }
 }
 
-static void update_scb_status(I82596State *s)
+static bool G_GNUC_UNUSED i82596_check_medium_status(I82596State *s)
 {
-    s->scb_status = (s->scb_status & 0xf000)
-        | (s->cu_status << 8) | (s->rx_status << 4);
-    set_uint16(s->scb, s->scb_status);
+    if (I596_FULL_DUPLEX) {
+        return true;
+    }
+
+    if (!s->throttle_state) {
+        return false;
+    }
+
+    if (!I596_LOOPBACK && (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) % 100 < 5)) {
+        s->collision_events++;
+        return false;
+    }
+
+    return true;
 }
 
+static int G_GNUC_UNUSED i82596_csma_backoff(I82596State *s, int retry_count)
+{
+    int backoff_factor, slot_count, backoff_time;
+
+    backoff_factor = MIN(retry_count + 1, CSMA_BACKOFF_LIMIT);
+    slot_count = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) % (1 << backoff_factor);
+    backoff_time = slot_count * CSMA_SLOT_TIME;
 
-static void i82596_s_reset(I82596State *s)
+    return backoff_time;
+}
+
+static uint16_t i82596_calculate_crc16(const uint8_t *data, size_t len)
 {
-    trace_i82596_s_reset(s);
-    s->scp = 0;
-    s->scb_status = 0;
-    s->cu_status = CU_IDLE;
-    s->rx_status = RX_SUSPENDED;
-    s->cmd_p = I596_NULL;
-    s->lnkst = 0x8000; /* initial link state: up */
-    s->ca = s->ca_active = 0;
-    s->send_irq = 0;
+    uint16_t crc = 0xFFFF;
+    size_t i, j;
+
+    for (i = 0; i < len; i++) {
+        crc ^= data[i] << 8;
+        for (j = 0; j < 8; j++) {
+            if (crc & 0x8000) {
+                crc = (crc << 1) ^ 0x1021;
+            } else {
+                crc <<= 1;
+            }
+        }
+    }
+    return crc;
+}
+
+static size_t G_GNUC_UNUSED i82596_append_crc(I82596State *s, uint8_t *buffer, size_t len)
+{
+    if (len + 4 > PKT_BUF_SZ) {
+        return len;
+    }
+
+    if (I596_CRC16_32) {
+        uint32_t crc = crc32(~0, buffer, len);
+        crc = cpu_to_be32(crc);
+        memcpy(&buffer[len], &crc, sizeof(crc));
+        return len + sizeof(crc);
+    } else {
+        uint16_t crc = i82596_calculate_crc16(buffer, len);
+        crc = cpu_to_be16(crc);
+        memcpy(&buffer[len], &crc, sizeof(crc));
+        return len + sizeof(crc);
+    }
+}
+
+static void G_GNUC_UNUSED i82596_update_statistics(I82596State *s, bool is_tx,
+                                      uint16_t error_flags,
+                                      uint16_t collision_count)
+{
+    if (is_tx) {
+        if (collision_count > 0) {
+            s->tx_collisions += collision_count;
+            s->collision_events++;
+            s->total_collisions += collision_count;
+            set_uint32(s->scb + 32, s->tx_collisions);
+        }
+        if (error_flags) {
+            i82596_record_error(s, error_flags, true);
+        }
+        if (!(error_flags & (TX_ABORTED_ERRORS | TX_CARRIER_ERRORS))) {
+            s->tx_good_frames++;
+            set_uint32(s->scb + 36, s->tx_good_frames);
+        }
+    } else {
+        s->total_frames++;
+        set_uint32(s->scb + 40, s->total_frames);
+        if (error_flags) {
+            i82596_record_error(s, error_flags, false);
+        } else {
+            s->total_good_frames++;
+            set_uint32(s->scb + 44, s->total_good_frames);
+        }
+    }
+}
+
+/* Bus Throttle Functionality */
+static void G_GNUC_UNUSED i82596_bus_throttle_timer(void *opaque)
+{
+    I82596State *s = opaque;
+
+    if (s->throttle_state) {
+        s->throttle_state = false;
+        if (s->t_off > 0) {
+            timer_mod(s->throttle_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                      (s->t_off * NANOSECONDS_PER_MICROSECOND));
+        }
+    } else {
+        s->throttle_state = true;
+        if (s->t_on > 0) {
+            timer_mod(s->throttle_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                      (s->t_on * NANOSECONDS_PER_MICROSECOND));
+        }
+
+        if (s->cu_status == CU_ACTIVE || s->rx_status == RX_READY) {
+            examine_scb(s);
+        }
+    }
+}
+
+static int G_GNUC_UNUSED i82596_flush_packet_queue(I82596State *s)
+{
+    /* Stub for now - will be implemented in Patch 2 */
+    return 0;
+}
+
+static void G_GNUC_UNUSED i82596_flush_queue_timer(void *opaque)
+{
+    /* Stub for now - will be implemented in Patch 2 */
+}
+
+static void i82596_update_scb_irq(I82596State *s, bool trigger)
+{
+    if (trigger) {
+        s->send_irq = 1;
+        qemu_set_irq(s->irq, 1);
+    }
+}
+
+static void G_GNUC_UNUSED i82596_update_cu_status(I82596State *s, uint16_t cmd_status,
+                                     bool generate_interrupt)
+{
+    if (cmd_status & STAT_C) {
+        if (cmd_status & STAT_OK) {
+            if (s->cu_status == CU_ACTIVE && s->cmd_p == I596_NULL) {
+                s->cu_status = CU_IDLE;
+                s->scb_status |= SCB_STATUS_CNA;
+            }
+        } else {
+            s->cu_status = CU_IDLE;
+            s->scb_status |= SCB_STATUS_CNA;
+        }
+
+        if (generate_interrupt) {
+            s->scb_status |= SCB_STATUS_CX;
+            i82596_update_scb_irq(s, true);
+        }
+    }
+
+    update_scb_status(s);
 }
 
+static void update_scb_status(I82596State *s)
+{
+    s->scb_status = (s->scb_status & 0xf000)
+        | (s->cu_status << 8) | (s->rx_status << 4) | (s->lnkst >> 8);
+    set_uint16(s->scb, s->scb_status);
+
+    set_uint32(s->scb + 28, s->tx_aborted_errors);
+    set_uint32(s->scb + 32, s->tx_collisions);
+    set_uint32(s->scb + 36, s->tx_good_frames);
+
+    set_uint32(s->scb + 16, s->crc_err);
+    set_uint32(s->scb + 18, s->align_err);
+    set_uint32(s->scb + 20, s->resource_err);
+    set_uint32(s->scb + 22, s->over_err);
+    set_uint32(s->scb + 24, s->rcvdt_err);
+    set_uint32(s->scb + 26, s->short_fr_error);
+}
 
 static void command_loop(I82596State *s)
 {
@@ -330,17 +756,6 @@ static void command_loop(I82596State *s)
     qemu_flush_queued_packets(qemu_get_queue(s->nic));
 }
 
-static void i82596_flush_queue_timer(void *opaque)
-{
-    I82596State *s = opaque;
-    if (0) {
-        timer_del(s->flush_queue_timer);
-        qemu_flush_queued_packets(qemu_get_queue(s->nic));
-        timer_mod(s->flush_queue_timer,
-              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
-    }
-}
-
 static void examine_scb(I82596State *s)
 {
     uint16_t command, cuc, ruc;
@@ -353,7 +768,7 @@ static void examine_scb(I82596State *s)
     /* and clear the scb command word */
     set_uint16(s->scb + 2, 0);
 
-    s->scb_status &= ~(command & SCB_COMMAND_ACK_MASK);
+    s->scb_status &= ~(command & SCB_ACK_MASK);
 
     switch (cuc) {
     case 0:     /* no change */
@@ -465,13 +880,6 @@ uint32_t i82596_ioport_readw(void *opaque, uint32_t addr)
     return -1;
 }
 
-void i82596_h_reset(void *opaque)
-{
-    I82596State *s = opaque;
-
-    i82596_s_reset(s);
-}
-
 bool i82596_can_receive(NetClientState *nc)
 {
     I82596State *s = qemu_get_nic_opaque(nc);
@@ -595,7 +1003,6 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
     rbd = get_uint32(rfd_p + 8);
     assert(rbd && rbd != I596_NULL);
 
-    trace_i82596_receive_packet(len);
     /* PRINT_PKTHDR("Receive", buf); */
 
     while (len) {
@@ -714,14 +1121,113 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
     return sz;
 }
 
+ssize_t i82596_receive_iov(NetClientState *nc, const struct iovec *iov,
+                            int iovcnt)
+{
+    size_t sz = 0;
+    uint8_t *buf;
+    int i;
+    for (i = 0; i < iovcnt; i++) {
+        sz += iov[i].iov_len;
+    }
+    if (sz == 0) {
+        return -1;
+    }
+    buf = g_malloc(sz);
+    if (!buf) {
+        return -1;
+    }
+    size_t offset = 0;
+    for (i = 0; i < iovcnt; i++) {
+        if (iov[i].iov_base == NULL) {
+            g_free(buf);
+            return -1;
+        }
+        memcpy(buf + offset, iov[i].iov_base, iov[i].iov_len);
+        offset += iov[i].iov_len;
+    }
+    DBG(PRINT_PKTHDR("Receive IOV:", buf));
+    i82596_receive(nc, buf, sz);
+    g_free(buf);
+    return sz;
+}
+
+void i82596_poll(NetClientState *nc, bool enable)
+{
+    I82596State *s = qemu_get_nic_opaque(nc);
+
+    if (!enable) {
+        return;
+    }
+
+    if (s->send_irq) {
+        qemu_set_irq(s->irq, 1);
+    }
+
+    if (s->rx_status == RX_NO_RESOURCES) {
+        if (s->cmd_p != I596_NULL) {
+            s->rx_status = RX_READY;
+            update_scb_status(s);
+        }
+    }
+
+    if (s->cu_status == CU_ACTIVE && s->cmd_p != I596_NULL) {
+        examine_scb(s);
+    }
+    qemu_set_irq(s->irq, 0);
+}
 
 const VMStateDescription vmstate_i82596 = {
     .name = "i82596",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(mode, I82596State),
+        VMSTATE_UINT16(t_on, I82596State),
+        VMSTATE_UINT16(t_off, I82596State),
+        VMSTATE_BOOL(throttle_state, I82596State),
+        VMSTATE_UINT32(iscp, I82596State),
+        VMSTATE_UINT8(sysbus, I82596State),
+        VMSTATE_UINT32(scb, I82596State),
+        VMSTATE_UINT32(scb_base, I82596State),
+        VMSTATE_UINT16(scb_status, I82596State),
+        VMSTATE_UINT8(cu_status, I82596State),
+        VMSTATE_UINT8(rx_status, I82596State),
         VMSTATE_UINT16(lnkst, I82596State),
-        VMSTATE_TIMER_PTR(flush_queue_timer, I82596State),
+        VMSTATE_UINT32(cmd_p, I82596State),
+        VMSTATE_INT32(ca, I82596State),
+        VMSTATE_INT32(ca_active, I82596State),
+        VMSTATE_INT32(send_irq, I82596State),
+        VMSTATE_BUFFER(mult, I82596State),
+        VMSTATE_BUFFER(config, I82596State),
+        VMSTATE_BUFFER(tx_buffer, I82596State),
+        VMSTATE_UINT32(tx_retry_addr, I82596State),
+        VMSTATE_INT32(tx_retry_count, I82596State),
+        VMSTATE_UINT32(tx_good_frames, I82596State),
+        VMSTATE_UINT32(tx_collisions, I82596State),
+        VMSTATE_UINT32(tx_aborted_errors, I82596State),
+        VMSTATE_UINT32(last_tx_len, I82596State),
+        VMSTATE_UINT32(collision_events, I82596State),
+        VMSTATE_UINT32(total_collisions, I82596State),
+        VMSTATE_UINT32(crc_err, I82596State),
+        VMSTATE_UINT32(align_err, I82596State),
+        VMSTATE_UINT32(resource_err, I82596State),
+        VMSTATE_UINT32(over_err, I82596State),
+        VMSTATE_UINT32(rcvdt_err, I82596State),
+        VMSTATE_UINT32(short_fr_error, I82596State),
+        VMSTATE_UINT32(total_frames, I82596State),
+        VMSTATE_UINT32(total_good_frames, I82596State),
+        VMSTATE_BUFFER(rx_buffer, I82596State),
+        VMSTATE_UINT16(tx_frame_len, I82596State),
+        VMSTATE_UINT16(rx_frame_len, I82596State),
+        VMSTATE_UINT64(current_tx_desc, I82596State),
+        VMSTATE_UINT64(current_rx_desc, I82596State),
+        VMSTATE_UINT32(last_good_rfa, I82596State),
+        VMSTATE_INT32(queue_head, I82596State),
+        VMSTATE_INT32(queue_tail, I82596State),
+        VMSTATE_INT32(queue_count, I82596State),
+        VMSTATE_BOOL(rnr_signaled, I82596State),
+        VMSTATE_BOOL(flushing_queue, I82596State),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -736,8 +1242,15 @@ void i82596_common_init(DeviceState *dev, I82596State *s, NetClientInfo *info)
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     if (USE_TIMER) {
-        s->flush_queue_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                    i82596_flush_queue_timer, s);
+        if (!s->flush_queue_timer) {
+            s->flush_queue_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                        i82596_flush_queue_timer, s);
+        }
+        if (!s->throttle_timer) {
+            s->throttle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                        i82596_bus_throttle_timer, s);
+        }
     }
+
     s->lnkst = 0x8000; /* initial link state: up */
 }
diff --git a/hw/net/i82596.h b/hw/net/i82596.h
index dc1fa1a1dc..67b18f957a 100644
--- a/hw/net/i82596.h
+++ b/hw/net/i82596.h
@@ -6,11 +6,15 @@
 #include "system/memory.h"
 #include "system/address-spaces.h"
 
-#define PORT_RESET              0x00    /* reset 82596 */
-#define PORT_SELFTEST           0x01    /* selftest */
-#define PORT_ALTSCP             0x02    /* alternate SCB address */
-#define PORT_ALTDUMP            0x03    /* Alternate DUMP address */
-#define PORT_CA                 0x10    /* QEMU-internal CA signal */
+#define PACKET_QUEUE_SIZE 64
+#define RX_RING_SIZE    16
+#define PKT_BUF_SZ      1536
+
+#define PORT_RESET              0x00
+#define PORT_SELFTEST           0x01
+#define PORT_ALTSCP             0x02
+#define PORT_ALTDUMP            0x03
+#define PORT_CA                 0x10
 
 typedef struct I82596State_st I82596State;
 
@@ -21,35 +25,75 @@ struct I82596State_st {
     NICState *nic;
     NICConf conf;
     QEMUTimer *flush_queue_timer;
+    uint8_t mode;
+
+    QEMUTimer *throttle_timer;
+    uint16_t t_on;
+    uint16_t t_off;
+    bool throttle_state;
 
-    hwaddr scp;         /* pointer to SCP */
+    hwaddr scp;
+    uint32_t iscp;
     uint8_t sysbus;
-    uint32_t scb;       /* SCB */
+    uint32_t scb;
+    uint32_t scb_base;
     uint16_t scb_status;
     uint8_t cu_status, rx_status;
     uint16_t lnkst;
+    uint32_t last_tx_len;
+    uint32_t collision_events;
+    uint32_t total_collisions;
+
+    uint32_t tx_retry_addr;
+    int tx_retry_count;
+    uint32_t tx_good_frames;
+    uint32_t tx_collisions;
+    uint32_t tx_aborted_errors;
 
-    uint32_t cmd_p;     /* addr of current command */
+    uint32_t cmd_p;
     int ca;
     int ca_active;
     int send_irq;
 
-    /* Hash register (multicast mask array, multiple individual addresses). */
     uint8_t mult[8];
-    uint8_t config[14]; /* config bytes from CONFIGURE command */
+    uint8_t config[14];
+
+    uint32_t crc_err;
+    uint32_t align_err;
+    uint32_t resource_err;
+    uint32_t over_err;
+    uint32_t rcvdt_err;
+    uint32_t short_fr_error;
+    uint32_t total_frames;
+    uint32_t total_good_frames;
+
+    uint8_t tx_buffer[PKT_BUF_SZ];
+    uint8_t rx_buffer[PKT_BUF_SZ];
+    uint16_t tx_frame_len;
+    uint16_t rx_frame_len;
 
-    uint8_t tx_buffer[0x4000];
+    hwaddr current_tx_desc;
+    hwaddr current_rx_desc;
+    uint32_t last_good_rfa;
+    uint8_t packet_queue[PACKET_QUEUE_SIZE][PKT_BUF_SZ];
+    size_t packet_queue_len[PACKET_QUEUE_SIZE];
+    int queue_head;
+    int queue_tail;
+    int queue_count;
+    bool rnr_signaled;
+    bool flushing_queue;
 };
 
 void i82596_h_reset(void *opaque);
 void i82596_ioport_writew(void *opaque, uint32_t addr, uint32_t val);
 uint32_t i82596_ioport_readw(void *opaque, uint32_t addr);
-void i82596_ioport_writel(void *opaque, uint32_t addr, uint32_t val);
-uint32_t i82596_ioport_readl(void *opaque, uint32_t addr);
-uint32_t i82596_bcr_readw(I82596State *s, uint32_t rap);
 ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t size_);
+ssize_t i82596_receive_iov(NetClientState *nc, const struct iovec *iov,
+                           int iovcnt);
 bool i82596_can_receive(NetClientState *nc);
 void i82596_set_link_status(NetClientState *nc);
-void i82596_common_init(DeviceState *dev, I82596State *s, NetClientInfo *info);
+void i82596_poll(NetClientState *nc, bool enable);
+void i82596_common_init(DeviceState *dev, I82596State *s,
+                        NetClientInfo *info);
 extern const VMStateDescription vmstate_i82596;
 #endif
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index b87cea411a..2f212a7ed3 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -86,6 +86,10 @@ static const MemoryRegionOps lasi_82596_mem_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
 };
 
 static NetClientInfo net_lasi_82596_info = {
@@ -93,6 +97,8 @@ static NetClientInfo net_lasi_82596_info = {
     .size = sizeof(NICState),
     .can_receive = i82596_can_receive,
     .receive = i82596_receive,
+    .receive_iov = i82596_receive_iov,
+    .poll = i82596_poll,
     .link_status_changed = i82596_set_link_status,
 };
 
-- 
2.51.0


