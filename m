Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29802FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITrS-0007qA-TZ; Thu, 30 Apr 2026 12:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITrI-0007Vx-9T; Thu, 30 Apr 2026 12:03:24 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITrC-00078x-8S; Thu, 30 Apr 2026 12:03:23 -0400
DKIM-Signature: a=rsa-sha256; bh=ywww7Nv5Qiuj7CAJWTkw1HmYKvkxUnqP3gKISLYCA3I=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1777564993; v=1;
 b=p6UWgn57Zlq//5wvy1aNHLraPrvq7c76HFHRyTje2Og8CPbiBDZWczt81riwt23EhWPN5C7S
 4ELKdoKhWeB0E4EYYtNV6F8iurBT6n8EkpyF5ptKnl68h3CTrhh6yLhQ91iAYamcEAO2Ggfkfsu
 ArSQOXOXUt5K3uLARMHeG9MQrh18pTsQjJuHuR4jKY6OjppOlK77P0ZN1BL7hNbx/uV7DbnCdZD
 pJC1cDIu+JebKjrHngo5yolLnc+TdVJj9PTVlEOAFANVG93/RCIDaDkNBY6zFEJ0fKIlzLBpVL0
 1xl9hl0jexdzpHT+XFAKval5OVdbSqxo4tLZ+xhT/kM5g==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 548E920C7B;
 Thu, 30 Apr 2026 16:03:13 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Mon, 13 Apr 2026 17:27:19 +0100
Subject: [PATCH qemu v4 5/9] ot_uart: gather similar behaviours togeter in
 register read and write
Message-ID: <177756498815.8917.12449488721849651971-5@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177756498815.8917.12449488721849651971-0@git.sr.ht>
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
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
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

the register read and write functions are each a large switch statement with
many similar behaviours in, this is mostly for enabling the use of specific
register names inside of log messages. this commit adds a lookup table for
register names and uses that instead, allowing much of the code in the regist=
er
read and write functions to be deduplicated.

the write function was also missing a switch case for R_ALERT_TEST, so I added
that in this commit since it has a very simple implementation for now

Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
---
 hw/char/ot_uart.c | 103 ++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 50 deletions(-)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index 62c182cbed..2247db7110 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -109,6 +109,26 @@ REG32(TIMEOUT_CTRL, 0x30)
 #define R_LAST_REG (R_TIMEOUT_CTRL)
 #define REGS_COUNT (R_LAST_REG + 1u)
 #define REGS_SIZE  (REGS_COUNT * sizeof(uint32_t))
+#define REG_NAME(_reg_) \
+    ((((_reg_) < REGS_COUNT) && REG_NAMES[_reg_]) ? REG_NAMES[_reg_] : "?")
+
+#define REG_NAME_ENTRY(_reg_) [R_##_reg_] =3D stringify(_reg_)
+static const char *REG_NAMES[REGS_COUNT] =3D {
+    REG_NAME_ENTRY(INTR_STATE),
+    REG_NAME_ENTRY(INTR_ENABLE),
+    REG_NAME_ENTRY(INTR_TEST),
+    REG_NAME_ENTRY(ALERT_TEST),
+    REG_NAME_ENTRY(CTRL),
+    REG_NAME_ENTRY(STATUS),
+    REG_NAME_ENTRY(RDATA),
+    REG_NAME_ENTRY(WDATA),
+    REG_NAME_ENTRY(FIFO_CTRL),
+    REG_NAME_ENTRY(FIFO_STATUS),
+    REG_NAME_ENTRY(OVRD),
+    REG_NAME_ENTRY(VAL),
+    REG_NAME_ENTRY(TIMEOUT_CTRL),
+};
+#undef REG_NAME_ENTRY
=20
 static void ot_uart_update_irqs(OtUARTState *s)
 {
@@ -301,23 +321,14 @@ static uint64_t ot_uart_read(void *opaque, hwaddr addr,=
 unsigned int size)
     OtUARTState *s =3D opaque;
     uint64_t retvalue =3D 0;
=20
-    switch (addr >> 2) {
+    hwaddr reg =3D R32_OFF(addr);
+    switch (reg) {
     case R_INTR_STATE:
-        retvalue =3D s->regs[R_INTR_STATE];
-        break;
     case R_INTR_ENABLE:
-        retvalue =3D s->regs[R_INTR_ENABLE];
-        break;
-    case R_INTR_TEST:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: wdata is write only\n", __func__);
-        break;
-
     case R_CTRL:
-        retvalue =3D s->regs[R_CTRL];
-        break;
+    case R_FIFO_CTRL:
     case R_STATUS:
-        retvalue =3D s->regs[R_STATUS];
+        retvalue =3D s->regs[reg];
         break;
=20
     case R_RDATA:
@@ -333,14 +344,7 @@ static uint64_t ot_uart_read(void *opaque, hwaddr addr, =
unsigned int size)
             }
         }
         break;
-    case R_WDATA:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: wdata is write only\n", __func__);
-        break;
=20
-    case R_FIFO_CTRL:
-        retvalue =3D s->regs[R_FIFO_CTRL];
-        break;
     case R_FIFO_STATUS:
         retvalue =3D s->regs[R_FIFO_STATUS];
=20
@@ -351,21 +355,21 @@ static uint64_t ot_uart_read(void *opaque, hwaddr addr,=
 unsigned int size)
                       "%s: RX fifos are not supported\n", __func__);
         break;
=20
-    case R_OVRD:
-        retvalue =3D s->regs[R_OVRD];
-        qemu_log_mask(LOG_UNIMP,
-                      "%s: ovrd is not supported\n", __func__);
-        break;
     case R_VAL:
-        retvalue =3D s->regs[R_VAL];
-        qemu_log_mask(LOG_UNIMP,
-                      "%s: val is not supported\n", __func__);
-        break;
+    case R_OVRD:
     case R_TIMEOUT_CTRL:
-        retvalue =3D s->regs[R_TIMEOUT_CTRL];
+        retvalue =3D s->regs[reg];
         qemu_log_mask(LOG_UNIMP,
-                      "%s: timeout_ctrl is not supported\n", __func__);
+                      "%s: %s is not supported\n", __func__, REG_NAME(reg));
+        break;
+
+    case R_ALERT_TEST:
+    case R_INTR_TEST:
+    case R_WDATA:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: %s is write only\n", __func__, REG_NAME(reg));
         break;
+
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
@@ -381,7 +385,9 @@ static void ot_uart_write(void *opaque, hwaddr addr, uint=
64_t val64,
     OtUARTState *s =3D opaque;
     uint32_t value =3D val64;
=20
-    switch (addr >> 2) {
+    hwaddr reg =3D R32_OFF(addr);
+
+    switch (reg) {
     case R_INTR_STATE:
         /* Write 1 clear */
         value &=3D INTR_MASK;
@@ -398,7 +404,11 @@ static void ot_uart_write(void *opaque, hwaddr addr, uin=
t64_t val64,
         s->regs[R_INTR_STATE] |=3D value;
         ot_uart_update_irqs(s);
         break;
-
+    case R_ALERT_TEST:
+        value &=3D R_ALERT_TEST_FATAL_FAULT_MASK;
+        s->regs[reg] =3D value;
+        /* This will also set an IRQ once the alert handler is added */
+        break;
     case R_CTRL:
         s->regs[R_CTRL] =3D value;
=20
@@ -434,15 +444,6 @@ static void ot_uart_write(void *opaque, hwaddr addr, uin=
t64_t val64,
             s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
         }
         break;
-    case R_STATUS:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: status is read only\n", __func__);
-        break;
-
-    case R_RDATA:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: rdata is read only\n", __func__);
-        break;
     case R_WDATA:
         uart_write_tx_fifo(s, value);
         break;
@@ -459,10 +460,6 @@ static void ot_uart_write(void *opaque, hwaddr addr, uin=
t64_t val64,
             s->tx_level =3D 0;
         }
         break;
-    case R_FIFO_STATUS:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: fifo_status is read only\n", __func__);
-        break;
     case R_OVRD:
         if (value & R_OVRD_TXEN_MASK) {
             qemu_log_mask(LOG_UNIMP, "%s: OVRD.TXEN is not supported\n",
@@ -470,16 +467,22 @@ static void ot_uart_write(void *opaque, hwaddr addr, ui=
nt64_t val64,
         }
         s->regs[R_OVRD] =3D value & R_OVRD_TXVAL_MASK;
         break;
-    case R_VAL:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: val is read only\n", __func__);
-        break;
+
     case R_TIMEOUT_CTRL:
         s->regs[R_TIMEOUT_CTRL] =3D
             value & (R_TIMEOUT_CTRL_EN_MASK | R_TIMEOUT_CTRL_VAL_MASK);
         qemu_log_mask(LOG_UNIMP,
                       "%s: timeout_ctrl is not supported\n", __func__);
         break;
+
+    case R_STATUS:
+    case R_RDATA:
+    case R_FIFO_STATUS:
+    case R_VAL:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: %s is read only\n", __func__, REG_NAME(reg));
+        break;
+
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
--=20
2.49.1


