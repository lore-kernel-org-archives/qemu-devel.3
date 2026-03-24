Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93424D58CCA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w514w-0007kx-VA; Tue, 24 Mar 2026 08:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w514v-0007kc-Gc
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w514t-0001RJ-AX
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774356106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cecl9XI/y7lX1FiyMQR0Bz9vVcLYG01E0igKXYF2NNI=;
 b=PRTmLzuPetAel8UPwAyb8zHKnUAp2vHB97bH7HMJqRuV4RpPETvy6ILBZMTG835bG3vZtw
 UL+urnnjN2l75iOBSWP6XTlMvt97GDJ2z5TFsyVAK8HJg8W/hBl33bDbMWyxHJ85NsjsDA
 o+yVRppc5qmcwIdvscfA9jqOuGxEcS0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-arrkIVO1OkunRKQqzc5N2w-1; Tue,
 24 Mar 2026 08:41:44 -0400
X-MC-Unique: arrkIVO1OkunRKQqzc5N2w-1
X-Mimecast-MFC-AGG-ID: arrkIVO1OkunRKQqzc5N2w_1774356103
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1791D18005B0; Tue, 24 Mar 2026 12:41:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B1471954102; Tue, 24 Mar 2026 12:41:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/5] hw/i2c/aspeed: fix lost interrupts on back-to-back commands
Date: Tue, 24 Mar 2026 13:41:27 +0100
Message-ID: <20260324124131.1053711-2-clg@redhat.com>
In-Reply-To: <20260324124131.1053711-1-clg@redhat.com>
References: <20260324124131.1053711-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>

QEMU executes I2C commands synchronously inside the CMD register write
handler. On real hardware each command takes time on the bus, so the
ISR can clear the previous interrupt status before the next completion
arrives. In QEMU, when the guest ISR handles a TX_ACK and immediately
issues the next command by writing to CMD, that command completes
instantly — before the ISR returns to W1C-clear the first TX_ACK.
Since the bit is already set, setting it again is a no-op. The ISR
then clears it, wiping both completions at once. No interrupt fires
for the second command and the driver stalls.

This affects any multi-step I2C transaction: register reads, SMBus
word reads, and PMBus device probes all fail ("Error: Read failed"
from i2cget, -ETIMEDOUT from kernel drivers).

The issue is exposed when the guest kernel includes commit "i2c:
aspeed: Acknowledge Tx done with and without ACK irq late" [1] which
defers W1C acknowledgment of TX_ACK until after the ISR has issued
the next command. This means the old TX_ACK is still set when the
next command completes synchronously, and the subsequent W1C wipes
both completions at once.

The trace below shows `i2cget -y 15 0x50 0x00` (read EEPROM register
0x00) failing without the fix. The first START+TX sets TX_ACK. The
ISR handles it and issues a second TX to send the register address.
That TX completes synchronously while TX_ACK is still set:

  aspeed_i2c_bus_cmd cmd=0x3 start|tx| intr=0x0    # START+TX, clean
  aspeed_i2c_bus_raise_interrupt intr=0x1 ack|      # TX_ACK set
  aspeed_i2c_bus_read  0x10: 0x1                    # ISR reads TX_ACK
  aspeed_i2c_bus_write 0x14: 0x2                    # ISR issues TX cmd
  aspeed_i2c_bus_cmd cmd=0x400002 tx| intr=0x1      # TX runs, TX_ACK already set!
  aspeed_i2c_bus_raise_interrupt intr=0x1 ack|      # re-set is no-op
  aspeed_i2c_bus_write 0x10: 0x1                    # ISR W1C clears TX_ACK
  aspeed_i2c_bus_read  0x10: 0x0                    # LOST — both ACKs wiped

The driver sees INTR_STS=0 and never proceeds to the read phase.

Fix this by tracking interrupt bits that collide with already-pending
bits. Before calling aspeed_i2c_bus_handle_cmd(), save and clear
INTR_STS so that only freshly set bits are visible after the call.
Any overlap between the old and new bits is saved in pending_intr_sts.
When the ISR later W1C-clears the old bits, re-apply the saved
pending bits so the ISR sees them on its next loop iteration.

With the fix, the same operation completes successfully:

  aspeed_i2c_bus_cmd cmd=0x3 start|tx| intr=0x0    # START+TX, clean
  aspeed_i2c_bus_raise_interrupt intr=0x1 ack|      # TX_ACK set
  aspeed_i2c_bus_read  0x10: 0x1                    # ISR reads TX_ACK
  aspeed_i2c_bus_write 0x14: 0x2                    # ISR issues TX cmd
  aspeed_i2c_bus_cmd cmd=0x400002 tx| intr=0x0      # INTR_STS cleared first
  aspeed_i2c_bus_raise_interrupt intr=0x1 ack|      # TX_ACK freshly set
  aspeed_i2c_bus_write 0x10: 0x1                    # ISR W1C clears TX_ACK
  aspeed_i2c_bus_read  0x10: 0x1                    # RE-DELIVERED from pending
  aspeed_i2c_bus_write 0x14: 0x1b                   # ISR proceeds: START+RX
  aspeed_i2c_bus_cmd cmd=0x40001b start|tx|rx|last| # read phase completes
  i2c_recv recv(addr:0x50) data:0x00                # data received

[1] https://lore.kernel.org/all/20231211102217.2436294-3-quan@os.amperecomputing.com/

Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Fixes: 1602001195dc ("i2c: add aspeed i2c controller")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260311023712.2730185-1-jithu.joseph@oss.qualcomm.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i2c/aspeed_i2c.h |  1 +
 hw/i2c/aspeed_i2c.c         | 46 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 53a9dba71b07..d42cb4865aa5 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -256,6 +256,7 @@ struct AspeedI2CBus {
     qemu_irq irq;
 
     uint32_t regs[ASPEED_I2C_NEW_NUM_REG];
+    uint32_t pending_intr_sts;
     uint8_t pool[ASPEED_I2C_BUS_POOL_SIZE];
     uint64_t dma_dram_offset;
 };
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 8022938f3478..ad6342bec0d4 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -628,6 +628,8 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
     bool handle_rx;
     bool w1t;
+    uint32_t old_intr;
+    uint32_t cmd_intr;
 
     trace_aspeed_i2c_bus_write(bus->id, offset, size, value);
 
@@ -665,6 +667,17 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
             break;
         }
         bus->regs[R_I2CM_INTR_STS] &= ~(value & 0xf007f07f);
+        /*
+         * Re-apply interrupts lost due to synchronous command completion.
+         * When a command completes instantly during an MMIO write, the new
+         * interrupt status bits collide with already-pending bits. After
+         * the ISR clears them, re-apply the saved bits so the ISR can
+         * process the new completion.
+         */
+        if (bus->pending_intr_sts) {
+            bus->regs[R_I2CM_INTR_STS] |= bus->pending_intr_sts;
+            bus->pending_intr_sts = 0;
+        }
         if (!bus->regs[R_I2CM_INTR_STS]) {
             bus->controller->intr_status &= ~(1 << bus->id);
             qemu_irq_lower(aic->bus_get_irq(bus));
@@ -708,7 +721,17 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
             bus->regs[R_I2CM_CMD] = value;
         }
 
+        old_intr = bus->regs[R_I2CM_INTR_STS];
+        bus->regs[R_I2CM_INTR_STS] = 0;
         aspeed_i2c_bus_handle_cmd(bus, value);
+        /*
+         * cmd_intr has only the bits handle_cmd freshly set.
+         * Overlap with old_intr means the same bit was re-fired
+         * and would be lost when the ISR W1C-clears the old one.
+         */
+        cmd_intr = bus->regs[R_I2CM_INTR_STS];
+        bus->regs[R_I2CM_INTR_STS] = cmd_intr | old_intr;
+        bus->pending_intr_sts |= old_intr & cmd_intr;
         aspeed_i2c_bus_raise_interrupt(bus);
         break;
     case A_I2CM_DMA_TX_ADDR:
@@ -845,6 +868,8 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
 {
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
     bool handle_rx;
+    uint32_t old_intr;
+    uint32_t cmd_intr;
 
     trace_aspeed_i2c_bus_write(bus->id, offset, size, value);
 
@@ -868,6 +893,17 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
         handle_rx = SHARED_ARRAY_FIELD_EX32(bus->regs, R_I2CD_INTR_STS, RX_DONE)
                     && SHARED_FIELD_EX32(value, RX_DONE);
         bus->regs[R_I2CD_INTR_STS] &= ~(value & 0x7FFF);
+        /*
+         * Re-apply interrupts lost due to synchronous command completion.
+         * When a command completes instantly during an MMIO write, the new
+         * interrupt status bits collide with already-pending bits. After
+         * the ISR clears them, re-apply the saved bits so the ISR can
+         * process the new completion.
+         */
+        if (bus->pending_intr_sts) {
+            bus->regs[R_I2CD_INTR_STS] |= bus->pending_intr_sts;
+            bus->pending_intr_sts = 0;
+        }
         if (!bus->regs[R_I2CD_INTR_STS]) {
             bus->controller->intr_status &= ~(1 << bus->id);
             qemu_irq_lower(aic->bus_get_irq(bus));
@@ -915,7 +951,17 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
         bus->regs[R_I2CD_CMD] &= ~0xFFFF;
         bus->regs[R_I2CD_CMD] |= value & 0xFFFF;
 
+        old_intr = bus->regs[R_I2CD_INTR_STS];
+        bus->regs[R_I2CD_INTR_STS] = 0;
         aspeed_i2c_bus_handle_cmd(bus, value);
+        /*
+         * cmd_intr has only the bits handle_cmd freshly set.
+         * Overlap with old_intr means the same bit was re-fired
+         * and would be lost when the ISR W1C-clears the old one.
+         */
+        cmd_intr = bus->regs[R_I2CD_INTR_STS];
+        bus->regs[R_I2CD_INTR_STS] = cmd_intr | old_intr;
+        bus->pending_intr_sts |= old_intr & cmd_intr;
         aspeed_i2c_bus_raise_interrupt(bus);
         break;
     case A_I2CD_DMA_ADDR:
-- 
2.53.0


