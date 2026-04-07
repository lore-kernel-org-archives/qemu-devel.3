Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D83F9D0EB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wChSa-00061S-6t; Tue, 14 Apr 2026 13:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wChSY-00060m-Ct; Tue, 14 Apr 2026 13:21:58 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wChSW-0007LI-Ks; Tue, 14 Apr 2026 13:21:58 -0400
DKIM-Signature: a=rsa-sha256; bh=9Kniq8FRhqulospfv3oew3dMKhVcy/wDzgbPCpJAV3k=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1776187286; v=1;
 b=TfH4BReaEuw7JvG36OdP/16JYcvxw9FhXFOyDe9P/t+rqvTapO3kdlScz8/CIwHXgopSHEif
 8O5igK7UfTmdvrXW29rnHpvWrAODittNo1wY9FpjpeQWfyxzAqKiP270pujNWTeXN0XRO+acppu
 TWLokM6I0AX7SdvcG0trDvp57bWZJHL14W7Pd9HyFGxL6ENbu6G8qMwrMrLiQBNt0xKcmtJvOam
 V8PwbH7dC2AlD+Cj9gKhm2KRxUU8mFERrt9orjNPhEa0ywkyC10EMgjHmy3aKSs9hMFmpYXuy0P
 qgkKDQKjeRmCUOoXVt1BcO6/7Ov24fpuslGEvRXGDb2SQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id CD3DE20A3E;
 Tue, 14 Apr 2026 17:21:26 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Tue, 07 Apr 2026 10:47:17 +0100
Subject: [PATCH qemu v3 10/10] ot_uart: switch from clock driven transmission
 to reg R/W driven transmission
Message-ID: <177618728515.4917.14466194789826252277-10@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177618728515.4917.14466194789826252277-0@git.sr.ht>
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Lex Bailey <lex.bailey@lowrisc.org>

this commit removes the need for the timer by instead transmitting from the TX
fifo any time it has data in it and it is enabled. This case can only arise
from a write to one of the registers in the UART, so the device will still wo=
rk
fully without the timer.

Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
---
 hw/char/ot_uart.c         | 91 ++++++++++++++++-----------------------
 hw/char/trace-events      |  2 +-
 include/hw/char/ot_uart.h | 15 ++-----
 3 files changed, 40 insertions(+), 68 deletions(-)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index 910bef00f2..af0cf9ee1a 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -20,9 +20,10 @@
 #include "qemu/osdep.h"
 #include "hw/char/ot_uart.h"
 #include "qemu/fifo8.h"
+#include "qapi/error.h"
+#include "chardev/char-fe.h"
 #include "hw/core/cpu.h"
 #include "hw/core/irq.h"
-#include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/core/registerfields.h"
@@ -152,6 +153,18 @@ static bool ot_uart_is_rx_enabled(const OtUARTState *s)
     return FIELD_EX32(s->regs[R_CTRL], CTRL, RX);
 }
=20
+static void ot_uart_check_baudrate(const OtUARTState *s)
+{
+    uint32_t nco =3D FIELD_EX32(s->regs[R_CTRL], CTRL, NCO);
+
+    unsigned baudrate =3D (unsigned)(((uint64_t)nco * (uint64_t)s->pclk) >>
+                                   (R_CTRL_NCO_LENGTH + 4));
+
+    if (baudrate) {
+        trace_ot_uart_check_baudrate(s->ot_id, s->pclk, baudrate);
+    }
+}
+
 static int ot_uart_can_receive(void *opaque)
 {
     OtUARTState *s =3D opaque;
@@ -284,7 +297,6 @@ static void ot_uart_xmit(OtUARTState *s)
=20
 static void uart_write_tx_fifo(OtUARTState *s, uint8_t val)
 {
-    uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     if (fifo8_is_full(&s->tx_fifo)) {
         qemu_log_mask(LOG_GUEST_ERROR, "ot_uart: TX FIFO overflow");
         return;
@@ -305,9 +317,6 @@ static void uart_write_tx_fifo(OtUARTState *s, uint8_t va=
l)
     if (ot_uart_is_tx_enabled(s)) {
         ot_uart_xmit(s);
     }
-
-    timer_mod(s->fifo_trigger_handle, current_time +
-              (s->char_tx_time * 4));
 }
=20
 static void ot_uart_reset_enter(Object *obj, ResetType type)
@@ -328,11 +337,6 @@ static void ot_uart_reset_enter(Object *obj, ResetType t=
ype)
     ot_uart_reset_tx_fifo(s);
     ot_uart_reset_rx_fifo(s);
=20
-    s->tx_level =3D 0;
-    s->rx_level =3D 0;
-
-    s->char_tx_time =3D (NANOSECONDS_PER_SECOND / 230400) * 10;
-
     /*
      * do not reset `s->in_break`, as that tracks whether we are currently
      * receiving a break condition over UART RX from some device talking
@@ -399,19 +403,16 @@ static gboolean ot_uart_watch_cb(void *do_not_use, GIOC=
ondition cond,
     return FALSE;
 }
=20
-static uint64_t ot_uart_get_baud(OtUARTState *s)
+static void ot_uart_clock_input(void *opaque, int irq, int level)
 {
-    uint64_t baud;
+    OtUARTState *s =3D opaque;
=20
-    baud =3D ((s->regs[R_CTRL] & R_CTRL_NCO_MASK) >> 16);
-    baud *=3D clock_get_hz(s->f_clk);
-    baud >>=3D 20;
+    g_assert(irq =3D=3D 0);
=20
-    if (baud) {
-        trace_ot_uart_check_baudrate(s->ot_id, baud);
-    }
+    s->pclk =3D (unsigned)level;
=20
-    return baud;
+    /* TODO: disable UART transfer when PCLK is 0 */
+    ot_uart_check_baudrate(s);
 }
=20
 static uint64_t ot_uart_read(void *opaque, hwaddr addr, unsigned int size)
@@ -553,8 +554,6 @@ static void ot_uart_write(void *opaque, hwaddr addr, uint=
64_t val64,
         /* This will also set an IRQ once the alert handler is added */
         break;
     case R_CTRL:
-        s->regs[R_CTRL] =3D value;
-
         if (value & R_CTRL_NF_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_NF is not supported\n", __func__);
@@ -577,10 +576,19 @@ static void ot_uart_write(void *opaque, hwaddr addr, ui=
nt64_t val64,
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_RXBLVL is not supported\n", __func_=
_);
         }
-        if (value & R_CTRL_NCO_MASK) {
-            uint64_t baud =3D ot_uart_get_baud(s);
-
-            s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
+        uint32_t prev =3D s->regs[R_CTRL];
+        s->regs[R_CTRL] =3D value & CTRL_MASK;
+        uint32_t change =3D prev ^ s->regs[R_CTRL];
+        if (change & R_CTRL_NCO_MASK) {
+            ot_uart_check_baudrate(s);
+        }
+        if ((change & R_CTRL_RX_MASK) && ot_uart_is_rx_enabled(s) &&
+            !ot_uart_is_sys_loopack_enabled(s)) {
+            qemu_chr_fe_accept_input(&s->chr);
+        }
+        if ((change & R_CTRL_TX_MASK) && ot_uart_is_tx_enabled(s)) {
+            /* try sending pending data from TX FIFO if any */
+            ot_uart_xmit(s);
         }
         break;
     case R_WDATA:
@@ -628,25 +636,6 @@ static void ot_uart_write(void *opaque, hwaddr addr, uin=
t64_t val64,
     }
 }
=20
-static void ot_uart_clk_update(void *opaque, ClockEvent event)
-{
-    OtUARTState *s =3D opaque;
-
-    /* recompute uart's speed on clock change */
-    uint64_t baud =3D ot_uart_get_baud(s);
-
-    s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
-}
-
-static void fifo_trigger_update(void *opaque)
-{
-    OtUARTState *s =3D opaque;
-
-    if (s->regs[R_CTRL] & R_CTRL_TX_MASK) {
-        ot_uart_xmit(s);
-    }
-}
-
 static const MemoryRegionOps ot_uart_ops =3D {
     .read =3D ot_uart_read,
     .write =3D ot_uart_write,
@@ -665,15 +654,12 @@ static int ot_uart_post_load(void *opaque, int version_=
id)
=20
 static const VMStateDescription vmstate_ot_uart =3D {
     .name =3D TYPE_OT_UART,
-    .version_id =3D 2,
-    .minimum_version_id =3D 2,
+    .version_id =3D 3,
+    .minimum_version_id =3D 3,
     .post_load =3D ot_uart_post_load,
     .fields =3D (const VMStateField[]) {
         VMSTATE_STRUCT(tx_fifo, OtUARTState, 1, vmstate_fifo8, Fifo8),
         VMSTATE_STRUCT(rx_fifo, OtUARTState, 1, vmstate_fifo8, Fifo8),
-        VMSTATE_UINT32(tx_level, OtUARTState),
-        VMSTATE_UINT64(char_tx_time, OtUARTState),
-        VMSTATE_TIMER_PTR(fifo_trigger_handle, OtUARTState),
         VMSTATE_ARRAY(regs, OtUARTState, REGS_COUNT, 1, vmstate_info_uint32,
                       uint32_t),
         VMSTATE_END_OF_LIST()
@@ -708,10 +694,6 @@ static void ot_uart_init(Object *obj)
 {
     OtUARTState *s =3D OT_UART(obj);
=20
-    s->f_clk =3D qdev_init_clock_in(DEVICE(obj), "f_clock",
-                                  ot_uart_clk_update, s, ClockUpdate);
-    clock_set_hz(s->f_clk, OT_UART_CLOCK);
-
     for (unsigned index =3D 0; index < OT_UART_IRQ_NUM; index++) {
         sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irqs[index]);
     }
@@ -735,8 +717,7 @@ static void ot_uart_realize(DeviceState *dev, Error **err=
p)
=20
     g_assert(s->ot_id);
=20
-    s->fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                          fifo_trigger_update, s);
+    qdev_init_gpio_in_named(DEVICE(s), &ot_uart_clock_input, "clock-in", 1);
=20
     fifo8_create(&s->tx_fifo, OT_UART_TX_FIFO_SIZE);
     fifo8_create(&s->rx_fifo, OT_UART_RX_FIFO_SIZE);
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 17cc9ad2d5..c859d8af4e 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -143,7 +143,7 @@ htif_uart_write_to_host(uint8_t device, uint8_t cmd, uint=
64_t payload) "device:
 htif_uart_unknown_device_command(uint8_t device, uint8_t cmd, uint64_t paylo=
ad) "device: %u cmd: %02u payload: %016" PRIx64
=20
 # ot_uart.c
-ot_uart_check_baudrate(const char *id, unsigned baud) "%s: %u bps"
+ot_uart_check_baudrate(const char *id, unsigned pclk, unsigned baud) "%s: @ =
%u Hz: %u bps"
 ot_uart_connect_input_clock(const char *id, const char * srcname) "%s: %s"
 ot_uart_debug(const char *id, const char *msg) "%s: %s"
 ot_uart_io_read_out(const char *id, uint32_t addr, const char *regname, uint=
32_t val, uint32_t pc) "%s: addr=3D0x%02x (%s), val=3D0x%x, pc=3D0x%x"
diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
index 2f538e1f6f..7c2b5f3457 100644
--- a/include/hw/char/ot_uart.h
+++ b/include/hw/char/ot_uart.h
@@ -23,11 +23,8 @@
 #include "hw/core/sysbus.h"
 #include "qemu/fifo8.h"
 #include "chardev/char-fe.h"
-#include "qemu/timer.h"
 #include "qom/object.h"
=20
-#define OT_UART_CLOCK 50000000 /* 50MHz clock */
-
 #define TYPE_OT_UART "ot-uart"
 OBJECT_DECLARE_TYPE(OtUARTState, OtUARTClass, OT_UART)
=20
@@ -39,13 +36,6 @@ struct OtUARTState {
     MemoryRegion mmio;
     qemu_irq irqs[9];
=20
-    uint32_t tx_level;
-
-    uint32_t rx_level;
-
-    QEMUTimer *fifo_trigger_handle;
-    uint64_t char_tx_time;
-
     uint32_t regs[13]; /* Length must be updated if regs added or removed */
=20
     Fifo8 tx_fifo;
@@ -53,10 +43,11 @@ struct OtUARTState {
     uint32_t tx_watermark_level;
     bool in_break;
     guint watch_tag;
+    unsigned pclk; /* Current input clock */
+    const char *clock_src_name; /* IRQ name once connected */
=20
     char *ot_id;
-    Clock *f_clk;
-
+    DeviceState *clock_src;
     CharFrontend chr;
     bool oversample_break; /* Should mock break in the oversampled VAL reg? =
*/
     bool toggle_break; /* Are incoming breaks temporary or toggled? */
--=20
2.49.1

