Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3484606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUGUiN1r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP5zz-0004AX-G7; Thu, 05 Nov 2026 17:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5zg-00047j-St
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:44 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5ze-0002Kv-Mv
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:40 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0CB6860147;
 Thu,  5 Nov 2026 22:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA651F0089F;
 Thu,  5 Nov 2026 22:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793917897;
 bh=ugpCripawDnPW7/5LyS4u61J+bLvNUU4B1Gn4/eLTVQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hUGUiN1rC6UTNHv30hNKpFx3J2QBhiXQ3GCpNSKvcFrhRI72hb+zK9zBmJgxkLJZl
 36XOIHILhXltYdwRzlEQcdgV/ZFrRWvlZ3SgNxOtPIHLWRXbX9QjdbLh2C/WoABTIG
 YTePGzvf54OOEtjWpUwXPjL7eQA0xuFuYZe6hBWiQfY4f0WrU37q5zaEl19R/ZjHRZ
 1rsUxm8Yd6XiORVX52LWi1z9BTLX4hdN/coh3GHUaTjHMgVFibhK/YV9+BtLxaGtXL
 5YFWkN3hPg28BAKJQBejM49mdMRwPJeXLPwxIrMYrSNokMgDLKeKFcg0Sw3VM0h4NC
 zPjJmAHxI0J1Q==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL v2 8/8] i82596: Various send- and transmit fixes for 715
Date: Thu,  5 Nov 2026 23:31:22 +0100
Message-ID: <20261105223122.8729-9-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105223122.8729-1-deller@kernel.org>
References: <20261105223122.8729-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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

When transmitting, send the TCB data that precedes the TBDs in flexible mode,
and interrupt when the CU leaves the active state.  When receiving, keep the
RBD and RFD pointers in the chip (loaded at RU start; the SCB RFA field is
never written back), report only the RFD's own bytes in its actual count and
report every completed frame.  In the SCB, do not update the RU status with the
link state, as it's not part of it.
This fixes networking with HP-UX 9.05, HP-UX 10.20, Debian and NetBSD 9.4/10.1
on the 715 machine.

Noticed-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/net/i82596.c | 190 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 154 insertions(+), 36 deletions(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 19e1bf47db..cd7bd0f7fe 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -589,6 +589,17 @@ static int i82596_tx_copy_buffers(I82596State *s, hwaddr tfd_addr,
         total_len = frame_len;
 
     } else {
+        uint16_t tcb_len = desc->tcb_count & SIZE_MASK;
+
+        if (tcb_len > sizeof(s->tx_buffer)) {
+            return -1;
+        }
+        if (tcb_len) {
+            address_space_read(&address_space_memory, tfd_addr + 16,
+                              MEMTXATTRS_UNSPECIFIED, s->tx_buffer, tcb_len);
+            total_len = tcb_len;
+        }
+
         tbd_addr = desc->tbd_addr;
         while (tbd_addr != I596_NULL && tbd_addr != 0) {
             uint16_t buf_size;
@@ -756,6 +767,91 @@ tx_complete:
     }
 }
 
+/*
+ * The RBD the RU fills next, or I596_NULL if none is free.  An RBD with EL
+ * set is the driver's last free buffer: leave it until the driver hands
+ * another one back, which moves EL on.  The chip would fill it and stop
+ * with no resources, which at QEMU speed keeps drivers in their overrun
+ * recovery (NetBSD iee marks every RBD EL there).
+ */
+static uint32_t i82596_next_rbd(I82596State *s)
+{
+    uint32_t rbd = s->rbd_p;
+
+    if (rbd == I596_NULL || rbd == 0) {
+        return I596_NULL;
+    }
+    if (!s->rx_take_el && (get_uint16(rbd + 0xC) & CMD_EOL)) {
+        return I596_NULL;
+    }
+    return rbd;
+}
+
+/* The next RFD (and, unless the RFD holds a whole frame, an RBD) is free. */
+static bool i82596_rx_ring_free(I82596State *s)
+{
+    uint32_t rbd;
+
+    if (s->rfd_p == I596_NULL || s->rfd_p == 0) {
+        return false;
+    }
+    if (get_uint16(s->rfd_p) & (STAT_C | STAT_B)) {
+        return false;           /* the driver has not handed it back yet */
+    }
+    if (!(get_uint16(s->rfd_p + 2) & CMD_FLEX) ||
+        (get_uint16(s->rfd_p + 0xE) & SIZE_MASK) >= PKT_BUF_SZ) {
+        return true;
+    }
+    rbd = i82596_next_rbd(s);
+    return rbd != I596_NULL && rbd != 0;
+}
+
+static bool i82596_rx_buffers_free(I82596State *s)
+{
+    if (i82596_rx_ring_free(s)) {
+        s->rx_hold_start = 0;
+        return true;
+    }
+    return false;
+}
+
+static void i82596_update_rx_state(I82596State *s, int new_state);
+
+/* Hold incoming frames while the ring is full; retry every 500 us. */
+static void i82596_rx_hold(I82596State *s)
+{
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if (!s->rx_hold_start) {
+        s->rx_hold_start = now;
+    }
+    timer_mod(s->rx_retry_timer, now + 500 * SCALE_US);
+}
+
+static void i82596_rx_retry(void *opaque)
+{
+    I82596State *s = opaque;
+
+    /*
+     * The driver has not handed a buffer back within 20 ms: behave like the
+     * chip.  Fill the last (EL) RBD if that is all that is left, otherwise
+     * report RU out of resources so the driver can rebuild its ring.
+     */
+    if (s->rx_hold_start && s->rx_status == RX_READY &&
+        !i82596_rx_buffers_free(s) &&
+        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->rx_hold_start >
+            20 * SCALE_MS) {
+        s->rx_hold_start = 0;
+        s->rx_take_el = true;
+        if (!i82596_rx_buffers_free(s)) {
+            s->rx_take_el = false;
+            i82596_update_rx_state(s, RX_NO_RESOURCES);
+            i82596_update_scb_irq(s, true);
+        }
+    }
+    qemu_flush_queued_packets(qemu_get_queue(s->nic));
+}
+
 bool i82596_can_receive(NetClientState *nc)
 {
     I82596State *s = qemu_get_nic_opaque(nc);
@@ -769,6 +865,15 @@ bool i82596_can_receive(NetClientState *nc)
         return true;
     }
 
+    /*
+     * A real 82596 cannot be overrun this fast at 10 Mbit/s; hold frames in
+     * the net queue while the driver catches up instead of dropping them.
+     */
+    if (s->rx_status == RX_READY && !i82596_rx_buffers_free(s)) {
+        i82596_rx_hold(s);
+        return false;
+    }
+
     if (!s->throttle_state && !I596_FULL_DUPLEX) {
         return (s->queue_count < PACKET_QUEUE_SIZE);
     }
@@ -1038,6 +1143,8 @@ static ssize_t i82596_receive_packet(I82596State *s, const uint8_t *buf,
     size_t bytes_copied = 0;
     const uint8_t *packet_data = buf;
     bool out_of_resources = false;
+    bool rbds_exhausted = false;
+    size_t rfd_data_len = 0;
     size_t crc_size = i82596_get_crc_size(s);
 
     trace_i82596_receive_packet(buf, size);
@@ -1127,16 +1234,18 @@ static ssize_t i82596_receive_packet(I82596State *s, const uint8_t *buf,
                                     packet_data + bytes_copied,
                                     rfd_frame_size);
                 bytes_copied += rfd_frame_size;
+                rfd_data_len += rfd_frame_size;
             }
 
             if (bytes_copied < payload_size) {
                 size_t remaining = payload_size - bytes_copied;
-                rbd_addr = i82596_translate_address(s, rfd.rbd_addr, false);
+                rbd_addr = i82596_next_rbd(s);
 
                 if (rbd_addr == I596_NULL || rbd_addr == 0) {
                     rx_status |= RFD_STATUS_TRUNC | RFD_STATUS_NOBUFS;
                     i82596_record_error(s, RFD_STATUS_NOBUFS, false);
                     packet_completed = true;
+                    rbds_exhausted = true;
                     break;
                 } else {
                     hwaddr remaining_rbd = I596_NULL;
@@ -1148,22 +1257,18 @@ static ssize_t i82596_receive_packet(I82596State *s, const uint8_t *buf,
                                             &remaining_rbd);
                     bytes_copied += rbd_bytes;
 
-                    uint32_t next_rfd = i82596_translate_address(s, rfd.link,
-                                                                  false);
-                    if (next_rfd != I596_NULL && next_rfd != 0) {
-                        if (remaining_rbd != I596_NULL && remaining_rbd != 0) {
-                            trace_i82596_rx_rfd_update(next_rfd, remaining_rbd);
-                            set_uint32(next_rfd + 8, remaining_rbd);
-                        } else {
-                            set_uint32(next_rfd + 8, I596_NULL);
-                        }
-                    }
+                    /* the RFD points at the first RBD holding its data */
+                    trace_i82596_rx_rfd_update(rfd_addr, rbd_addr);
+                    set_addr(s, rfd_addr + 8, rbd_addr);
+                    s->rbd_p = remaining_rbd;
+                    s->rx_take_el = false;
 
                     if (out_of_resources) {
                         trace_i82596_rx_out_of_rbds();
                         i82596_record_error(s, RFD_STATUS_NOBUFS, false);
                         rx_status |= RFD_STATUS_TRUNC | RFD_STATUS_NOBUFS;
                         packet_completed = true;
+                        rbds_exhausted = true;
                         break;
                     }
 
@@ -1211,30 +1316,31 @@ rx_complete:
     }
 
     rfd.status_bits = rx_status & ~STAT_B;
-    rfd.actual_count = (bytes_copied & 0x3FFF) | 0x4000;
-    if (packet_completed) {
-        rfd.actual_count |= I596_EOF;
+    if (simplified_mode) {
+        rfd.actual_count = (bytes_copied & 0x3FFF) | 0x4000;
+        if (packet_completed) {
+            rfd.actual_count |= I596_EOF;
+        }
+    } else {
+        /* the RBDs carry their own counts and the EOF of a split frame */
+        rfd.actual_count = (rfd_data_len & 0x3FFF) | 0x4000;
+        if (packet_completed && rfd_data_len == bytes_copied) {
+            rfd.actual_count |= I596_EOF;
+        }
     }
 
     i82596_rx_desc_write(s, rfd_addr, &rfd, (simplified_mode || I596_LOOPBACK));
 
-    if (rfd.command & CMD_SUSP) {
-        i82596_update_rx_state(s, RX_SUSPENDED);
-        return size;
+    if (packet_completed) {
+        s->rfd_p = i82596_translate_address(s, rfd.link, false);
+        s->scb_status |= SCB_STATUS_FR;
     }
-
-    if (rfd.command & CMD_EOL) {
+    if (rfd.command & (CMD_SUSP | CMD_EOL)) {
         i82596_update_rx_state(s, RX_SUSPENDED);
-        return size;
+    } else if (rbds_exhausted) {
+        i82596_update_rx_state(s, RX_NO_RESOURCES);
     }
-
-    if (packet_completed && s->rx_status == RX_READY) {
-        uint32_t next_rfd_addr = i82596_translate_address(s, rfd.link, false);
-        if (next_rfd_addr != 0 && next_rfd_addr != I596_NULL) {
-            set_uint32(s->scb + 8, next_rfd_addr);
-        }
-
-        s->scb_status |= SCB_STATUS_FR;
+    if (packet_completed || rbds_exhausted) {
         i82596_update_scb_irq(s, true);
     }
     trace_i82596_rx_complete(s->crc_err, s->align_err, s->resource_err);
@@ -1256,8 +1362,6 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     if (s->rx_status != RX_READY) {
         if (s->queue_count >= PACKET_QUEUE_SIZE) {
             trace_i82596_receive_queue_full();
-            s->over_err++;
-            set_uint32(s->scb + 22, s->over_err);
             i82596_record_error(s, RX_OVER_ERRORS, false);
             return size;
         }
@@ -1271,6 +1375,11 @@ queue_packet:
         return size;
     }
 
+    if (!i82596_rx_buffers_free(s)) {
+        i82596_rx_hold(s);
+        return 0;
+    }
+
     return i82596_receive_packet(s, buf, size, false);
 }
 
@@ -1363,11 +1472,6 @@ static bool i82596_check_medium_status(I82596State *s)
         return false;
     }
 
-    if (!I596_LOOPBACK && (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) % 100 < 5)) {
-        s->collision_events++;
-        return false;
-    }
-
     return true;
 }
 
@@ -1740,6 +1844,7 @@ skip_status_update:
         if (cmd & CMD_SUSP) {
             s->cu_status = CU_SUSPENDED;
             s->scb_status |= SCB_STATUS_CNA;
+            s->send_irq = 1;
             stop = true;
         }
 
@@ -1747,6 +1852,7 @@ skip_status_update:
             s->cmd_p = I596_NULL;
             s->cu_status = CU_IDLE;
             s->scb_status |= SCB_STATUS_CNA;
+            s->send_irq = 1;
             stop = true;
         } else if (!stop) {
             if (next_addr == 0 || next_addr == I596_NULL ||
@@ -1754,6 +1860,7 @@ skip_status_update:
                 s->cmd_p = I596_NULL;
                 s->cu_status = CU_IDLE;
                 s->scb_status |= SCB_STATUS_CNA;
+                s->send_irq = 1;
                 stop = true;
             } else {
                 s->cmd_p = next_addr;
@@ -2061,7 +2168,7 @@ void i82596_poll(NetClientState *nc, bool enable)
 
 const VMStateDescription vmstate_i82596 = {
     .name = "i82596",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_UINT8(mode, I82596State),
@@ -2101,6 +2208,8 @@ const VMStateDescription vmstate_i82596 = {
         VMSTATE_UINT32(total_good_frames, I82596State),
         VMSTATE_BUFFER(rx_buffer, I82596State),
         VMSTATE_UINT16(tx_frame_len, I82596State),
+        VMSTATE_UINT32_V(rbd_p, I82596State, 2),
+        VMSTATE_UINT32_V(rfd_p, I82596State, 2),
         VMSTATE_UINT16(rx_frame_len, I82596State),
         VMSTATE_UINT64(current_tx_desc, I82596State),
         VMSTATE_UINT64(current_rx_desc, I82596State),
@@ -2127,6 +2236,13 @@ static int i82596_flush_packet_queue(I82596State *s)
         int tail = s->queue_tail;
         size_t len = s->packet_queue_len[tail];
 
+        if (s->rx_status == RX_READY && !i82596_rx_buffers_free(s)) {
+            i82596_rx_hold(s);
+            timer_mod(s->flush_queue_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500 * SCALE_US);
+            break;
+        }
+
         ssize_t ret = i82596_receive_packet(s, s->packet_queue[tail], len,
                                              true);
 
@@ -2174,6 +2290,8 @@ void i82596_common_init(DeviceState *dev, I82596State *s, NetClientInfo *info)
                 dev->id, &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
+    s->rx_retry_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, i82596_rx_retry, s);
+
     if (USE_TIMER) {
         if (!s->flush_queue_timer) {
             s->flush_queue_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-- 
2.54.0


