Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B0F606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYqga01n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP5zz-0004AS-ED; Thu, 05 Nov 2026 17:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5ze-00047Y-NQ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:42 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5zZ-0002KE-Ve
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:37 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3D6C41690;
 Thu,  5 Nov 2026 22:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0F91F0089F;
 Thu,  5 Nov 2026 22:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793917891;
 bh=kudm29ukDRr5tqYLUfyp7kUt1vJjYaALNoSOdjnYewU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bYqga01nnz9LH8NqCfK5ygYPyiq2gpUDX90pFxwwAobhxqkMXW6Nd4KIpWD6eikvx
 y2NXE2Ac4oqNQScLzfX/m4iZIrPNsiRKhyp7YBkK9NG9ayTHdUknAPTP3t8TgVgMHU
 Czf11/NxLN0EU/jSlEncWHgkrXRsH8ngtaTt8gAMQKiVPLGdi9/0Xlzw2YUnpnEzE1
 IzOvzz5sds+86mmoTkdjhP5boccOqTSBTmtt0WU82IP7NeyCcy7zg0iHkdguXsiF6g
 loduxT3PPxsQobkh/V+rF+d1pDbZr1IRQIM2D8f6WSuo/y3ZVZXKU3AOhzxEjZsZjP
 u1y/CUpjNuAHQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL v2 4/8] i82596: Implement 82596CA big-endian mode (SYSBUS bit 7)
Date: Thu,  5 Nov 2026 23:31:18 +0100
Message-ID: <20261105223122.8729-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105223122.8729-1-deller@kernel.org>
References: <20261105223122.8729-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

NetBSD runs the 82596CA chip in big-endian mode, which means the SYSBUS bit #7
is set, and pointers need to be read as big-endian 32-bit pointer values.
Increment the error counters at offsets 12-32 of the SCB live in memory.

Noticed-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/net/i82596.c | 118 +++++++++++++++++++++++++++++-------------------
 hw/net/i82596.h |   3 ++
 2 files changed, 74 insertions(+), 47 deletions(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 37ce20efb1..a518aa7696 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -221,39 +221,78 @@ static void set_uint32(uint32_t addr, uint32_t val)
     set_uint16(addr + 2, val >> 16);
 }
 
+/*
+ * Address fields of the SCB, command blocks and RX/TX descriptors.  In
+ * big-endian mode (SYSBUS BE, 82596CA) the chip reads them as 32-bit
+ * big-endian words; otherwise as two 16-bit halves, low half first.  The
+ * ISCP and SCB addresses and the SCB counters are always two halves.
+ */
+#define I596_SYSBUS_BE  0x80
+
+static uint32_t get_addr(I82596State *s, uint32_t addr)
+{
+    if (s->sysbus & I596_SYSBUS_BE) {
+        return ldl_be_phys(&address_space_memory, addr);
+    }
+    return get_uint32(addr);
+}
+
+static void set_addr(I82596State *s, uint32_t addr, uint32_t val)
+{
+    if (s->sysbus & I596_SYSBUS_BE) {
+        stl_be_phys(&address_space_memory, addr, val);
+    } else {
+        set_uint32(addr, val);
+    }
+}
+
+/* SCB error counters (linear mode), counted in memory like the chip does */
+#define SCB_CRC_ERRS        12
+#define SCB_ALIGN_ERRS      16
+#define SCB_RESOURCE_ERRS   20
+#define SCB_OVERRUN_ERRS    24
+#define SCB_RCVCDT_ERRS     28
+#define SCB_SHORT_ERRS      32
+
+static void i82596_count_error(I82596State *s, int offset)
+{
+    if (s->scb) {
+        set_uint32(s->scb + offset, get_uint32(s->scb + offset) + 1);
+    }
+}
+
 /* Centralized error detection and update mechanism */
 static void i82596_record_error(I82596State *s, uint16_t error_type, bool is_tx)
 {
     if (is_tx) {
         if (error_type & TX_ABORTED_ERRORS) {
             s->tx_aborted_errors++;
-            set_uint32(s->scb + 28, s->tx_aborted_errors);
         }
     } else {
         if (error_type & RX_CRC_ERRORS) {
             s->crc_err++;
-            set_uint32(s->scb + 16, s->crc_err);
+            i82596_count_error(s, SCB_CRC_ERRS);
         }
 
         if (error_type & (RX_LENGTH_ERRORS | RX_LENGTH_ERRORS_ALT |
                           RX_FRAME_ERRORS)) {
             s->align_err++;
-            set_uint32(s->scb + 18, s->align_err);
+            i82596_count_error(s, SCB_ALIGN_ERRS);
         }
 
         if (error_type & RFD_STATUS_NOBUFS) {
             s->resource_err++;
-            set_uint32(s->scb + 20, s->resource_err);
+            i82596_count_error(s, SCB_RESOURCE_ERRS);
         }
 
         if (error_type & (RX_OVER_ERRORS | RX_FIFO_ERRORS)) {
             s->over_err++;
-            set_uint32(s->scb + 22, s->over_err);
+            i82596_count_error(s, SCB_OVERRUN_ERRS);
         }
 
         if (error_type & RFD_STATUS_TRUNC) {
             s->short_fr_error++;
-            set_uint32(s->scb + 26, s->short_fr_error);
+            i82596_count_error(s, SCB_SHORT_ERRS);
         }
     }
 }
@@ -439,8 +478,8 @@ static void i82596_tx_tfd_read(I82596State *s, hwaddr addr,
 {
     desc->status_bits = get_uint16(addr + 0);
     desc->command = get_uint16(addr + 2);
-    desc->link_addr = get_uint32(addr + 4);
-    desc->tbd_addr = get_uint32(addr + 8);
+    desc->link_addr = get_addr(s, addr + 4);
+    desc->tbd_addr = get_addr(s, addr + 8);
     desc->tcb_count = get_uint16(addr + 12);
     address_space_read(&address_space_memory, addr + 14,
                       MEMTXATTRS_UNSPECIFIED, desc->dest_addr, 6);
@@ -452,8 +491,8 @@ static void i82596_tx_tfd_write(I82596State *s, hwaddr addr,
 {
     set_uint16(addr + 0, desc->status_bits);
     set_uint16(addr + 2, desc->command);
-    set_uint32(addr + 4, desc->link_addr);
-    set_uint32(addr + 8, desc->tbd_addr);
+    set_addr(s, addr + 4, desc->link_addr);
+    set_addr(s, addr + 8, desc->tbd_addr);
     set_uint16(addr + 12, desc->tcb_count);
     address_space_write(&address_space_memory, addr + 14,
                        MEMTXATTRS_UNSPECIFIED, desc->dest_addr, 6);
@@ -464,8 +503,8 @@ static void i82596_tbd_read(I82596State *s, hwaddr addr,
                             struct i82596_tx_buffer_desc *tbd)
 {
     tbd->size = get_uint16(addr + 0);
-    tbd->link = get_uint32(addr + 4);
-    tbd->buffer = get_uint32(addr + 8);
+    tbd->link = get_addr(s, addr + 4);
+    tbd->buffer = get_addr(s, addr + 8);
 }
 
 static void i82596_rx_rfd_read(I82596State *s, hwaddr addr,
@@ -473,8 +512,8 @@ static void i82596_rx_rfd_read(I82596State *s, hwaddr addr,
 {
     desc->status_bits = get_uint16(addr + 0x0);
     desc->command = get_uint16(addr + 0x2);
-    desc->link = get_uint32(addr + 0x4);
-    desc->rbd_addr = get_uint32(addr + 0x8);
+    desc->link = get_addr(s, addr + 0x4);
+    desc->rbd_addr = get_addr(s, addr + 0x8);
     desc->actual_count = get_uint16(addr + 0xC);
     desc->size = get_uint16(addr + 0xE);
 
@@ -494,8 +533,8 @@ static void i82596_rx_desc_write(I82596State *s, hwaddr addr,
 
     if (write_full) {
         set_uint16(addr + 0x2, desc->command);
-        set_uint32(addr + 0x4, desc->link);
-        set_uint32(addr + 0x8, desc->rbd_addr);
+        set_addr(s, addr + 0x4, desc->link);
+        set_addr(s, addr + 0x8, desc->rbd_addr);
         set_uint16(addr + 0xE, desc->size);
 
         address_space_write(&address_space_memory, addr + 0x10,
@@ -510,8 +549,8 @@ static void i82596_rbd_read(I82596State *s, hwaddr addr,
                             struct i82596_rx_buffer_desc *rbd)
 {
     rbd->actual_count = get_uint16(addr + 0x0);
-    rbd->next_rbd_addr = get_uint32(addr + 0x4);
-    rbd->buffer_addr = get_uint32(addr + 0x8);
+    rbd->next_rbd_addr = get_addr(s, addr + 0x4);
+    rbd->buffer_addr = get_addr(s, addr + 0x8);
     rbd->size = get_uint16(addr + 0xC);
 }
 
@@ -519,8 +558,8 @@ static void i82596_rbd_write(I82596State *s, hwaddr addr,
                              struct i82596_rx_buffer_desc *rbd)
 {
     set_uint16(addr + 0x0, rbd->actual_count);
-    set_uint32(addr + 0x4, rbd->next_rbd_addr);
-    set_uint32(addr + 0x8, rbd->buffer_addr);
+    set_addr(s, addr + 0x4, rbd->next_rbd_addr);
+    set_addr(s, addr + 0x8, rbd->buffer_addr);
     set_uint16(addr + 0xC, rbd->size);
 }
 
@@ -1008,7 +1047,7 @@ static ssize_t i82596_receive_packet(I82596State *s, const uint8_t *buf,
     }
 
 
-    rfd_addr = get_uint32(s->scb + 8);
+    rfd_addr = s->rfd_p;
 
     if (rfd_addr == 0 || rfd_addr == I596_NULL) {
         i82596_update_rx_state(s, RX_NO_RESOURCES);
@@ -1383,23 +1422,19 @@ static void i82596_update_statistics(I82596State *s, bool is_tx,
             s->tx_collisions += collision_count;
             s->collision_events++;
             s->total_collisions += collision_count;
-            set_uint32(s->scb + 32, s->tx_collisions);
         }
         if (error_flags) {
             i82596_record_error(s, error_flags, true);
         }
         if (!(error_flags & (TX_ABORTED_ERRORS | TX_CARRIER_ERRORS))) {
             s->tx_good_frames++;
-            set_uint32(s->scb + 36, s->tx_good_frames);
         }
     } else {
         s->total_frames++;
-        set_uint32(s->scb + 40, s->total_frames);
         if (error_flags) {
             i82596_record_error(s, error_flags, false);
         } else {
             s->total_good_frames++;
-            set_uint32(s->scb + 44, s->total_good_frames);
         }
     }
 }
@@ -1557,7 +1592,7 @@ static void i82596_command_dump(I82596State *s, uint32_t cmd_addr)
     uint16_t cmd = get_uint16(cmd_addr + 2);
     uint16_t status;
 
-    dump_addr = get_uint32(cmd_addr + 8);
+    dump_addr = get_addr(s, cmd_addr + 8);
 
     i82596_init_dump_area(s, dump_buffer);
     address_space_write(&address_space_memory, dump_addr,
@@ -1648,19 +1683,8 @@ static void i82596_update_cu_status(I82596State *s, uint16_t cmd_status,
 static void update_scb_status(I82596State *s)
 {
     s->scb_status = (s->scb_status & 0xf000)
-        | (s->cu_status << 8) | (s->rx_status << 4) | (s->lnkst >> 8);
+        | (s->cu_status << 8) | (s->rx_status << 4);
     set_uint16(s->scb, s->scb_status);
-
-    set_uint32(s->scb + 28, s->tx_aborted_errors);
-    set_uint32(s->scb + 32, s->tx_collisions);
-    set_uint32(s->scb + 36, s->tx_good_frames);
-
-    set_uint32(s->scb + 16, s->crc_err);
-    set_uint32(s->scb + 18, s->align_err);
-    set_uint32(s->scb + 20, s->resource_err);
-    set_uint32(s->scb + 22, s->over_err);
-    set_uint32(s->scb + 24, s->rcvdt_err);
-    set_uint32(s->scb + 26, s->short_fr_error);
 }
 
 static void command_loop(I82596State *s)
@@ -1669,11 +1693,12 @@ static void command_loop(I82596State *s)
            s->cmd_p != 0) {
         uint16_t status = get_uint16(s->cmd_p);
         if (status & (STAT_C | STAT_B)) {
-            uint32_t next = get_uint32(s->cmd_p + 4);
+            uint32_t next = get_addr(s, s->cmd_p + 4);
             if (next == 0 || next == s->cmd_p) {
                 s->cmd_p = I596_NULL;
                 s->cu_status = CU_IDLE;
                 s->scb_status |= SCB_STATUS_CNA;
+                s->send_irq = 1;
                 break;
             }
             s->cmd_p = i82596_translate_address(s, next, false);
@@ -1681,7 +1706,7 @@ static void command_loop(I82596State *s)
         }
         set_uint16(s->cmd_p, STAT_B);
         uint16_t cmd = get_uint16(s->cmd_p + 2);
-        uint32_t next_addr = get_uint32(s->cmd_p + 4);
+        uint32_t next_addr = get_addr(s, s->cmd_p + 4);
         next_addr = (next_addr == 0) ? I596_NULL :
                     i82596_translate_address(s, next_addr, false);
         switch (cmd & CMD_MASK) {
@@ -1784,7 +1809,7 @@ static void examine_scb(I82596State *s)
         break;
 
     case SCB_CUC_START: {
-        uint32_t cmd_ptr = get_uint32(s->scb + 4);
+        uint32_t cmd_ptr = get_addr(s, s->scb + 4);
         s->cmd_p = i82596_translate_address(s, cmd_ptr, false);
         s->cu_status = CU_ACTIVE;
         break;
@@ -1823,7 +1848,7 @@ static void examine_scb(I82596State *s)
         break;
 
     case SCB_RUC_START: {
-        uint32_t rfd_log = get_uint32(s->scb + 8);
+        uint32_t rfd_log = get_addr(s, s->scb + 8);
         hwaddr rfd = i82596_translate_address(s, rfd_log, false);
 
         if (rfd == 0 || rfd == I596_NULL) {
@@ -1862,12 +1887,11 @@ static void examine_scb(I82596State *s)
         if (found) {
             s->current_rx_desc = first_usable_rfd;
             s->last_good_rfa = first_usable_rfd_log;
+            s->rbd_p = i82596_translate_address(s, test_rfd.rbd_addr, false);
+            s->rx_take_el = false;
+            s->rfd_p = first_usable_rfd;
             i82596_update_rx_state(s, RX_READY);
 
-            if (first_usable_rfd != rfd) {
-                set_uint32(s->scb + 8, first_usable_rfd_log);
-            }
-
             if (s->queue_count > 0) {
                 trace_i82596_flush_queue(s->queue_count);
                 i82596_flush_packet_queue(s);
@@ -1909,7 +1933,7 @@ static void examine_scb(I82596State *s)
     }
     if (s->cu_status == CU_ACTIVE) {
         if (s->cmd_p == I596_NULL) {
-            s->cmd_p = get_uint32(s->scb + 4);
+            s->cmd_p = get_addr(s, s->scb + 4);
         }
         update_scb_status(s);
         command_loop(s);
diff --git a/hw/net/i82596.h b/hw/net/i82596.h
index 67b18f957a..ec0b6a75ba 100644
--- a/hw/net/i82596.h
+++ b/hw/net/i82596.h
@@ -75,6 +75,9 @@ struct I82596State_st {
     hwaddr current_tx_desc;
     hwaddr current_rx_desc;
     uint32_t last_good_rfa;
+    uint32_t rbd_p;         /* next free RBD, loaded from the first RFD at RU start */
+    bool rx_take_el;        /* hold timed out: fill the EL RBD like the chip does */
+    uint32_t rfd_p;         /* next RFD, loaded from the SCB at RU start */
     uint8_t packet_queue[PACKET_QUEUE_SIZE][PKT_BUF_SZ];
     size_t packet_queue_len[PACKET_QUEUE_SIZE];
     int queue_head;
-- 
2.54.0


