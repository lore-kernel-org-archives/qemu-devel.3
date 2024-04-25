Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DE0C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWg-0002Q4-7v; Thu, 25 Apr 2024 06:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWb-0002CN-P9
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:21 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWZ-0007Fl-Fj
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:21 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-344047ac7e4so1079364f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041618; x=1714646418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aqhmr43kxAUE3aXSGOVdjdHBPZAAakdUFpdCdVtyDcA=;
 b=p/Vu7unf0XwmPjgo+QOsPHhf9rywL052+KjZ8D6p1cleVl+BRVDjjhRAYDAsLS9Dak
 I53v4osYNN5wU8wIsZGsoPR1w9FnufKmzTOnMJfuZoF9dzYtC90iteGpzLB246VUWcUs
 pyqCX3znGcw7q0q5pSnENFwXynklHGHvrTxFW/luU89YAuj19QKvInux8iB5aG+MWL3D
 Tez+xmoBrhsy2StjUmPGEvPe1wePhL+TF6T+cCA96I65opGzEL4vZ7S1CsDC6ef2+6F1
 WntRVgpw4Ru5uGRd8+X7CnE+3AAzLwfHj1Ksbdq6LEIkYJYjBZQUIafE1H+unJ5OZwe+
 6bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041618; x=1714646418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqhmr43kxAUE3aXSGOVdjdHBPZAAakdUFpdCdVtyDcA=;
 b=YKa+H5d8c2qT3rEcooJeb3cS/oRdGlP+hHdiSzBq8wijh0pa19oWRJL9iABYrYv/w1
 b7oQZEKBDRntrIKx8awEDlD515vgtQo5psPgXTg26NdF4UYmKzlKig49WZOJFIe5rNMi
 0JHNQY4/kGzMln1Rna8zgJ8qmEYqyMWgs/lCM9DfLwS7cvsPCikRWp0N8dmnzJPt3eqQ
 2A4icJi7kXRD/fsNtHmE0cwPYo1byARADc3ufLqaiwTZxmvHK3vb5E/UQIzHQdWKE22I
 ZCf+JFnNwvBp69ZVVIxi29keMHfWyFAnfox0b2AVmD+6q5YVAaKgnD0V8n37xT5I4X86
 Z0Kg==
X-Gm-Message-State: AOJu0YyGS9hOMBWG7Igze8bfaMoE1mf0dRnXqvOVwo3kmtXbZN+tURYY
 vC+pEoFpAt+HrpEs0LhwRgjtDPeOWARJUAApNzh5cV55IneZdFlWYpoeo8Yq7T9faN6FVtYGedA
 5
X-Google-Smtp-Source: AGHT+IHvLMm6ev0mifo0T/OuAlFFBLGxQ9ir69sBNUS7aPa+DUmWdvufRU0IQX2GSsHqKeohh59sBw==
X-Received: by 2002:a05:6000:1243:b0:33e:6ef3:b68e with SMTP id
 j3-20020a056000124300b0033e6ef3b68emr1623866wrx.34.1714041617962; 
 Thu, 25 Apr 2024 03:40:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/37] hw/char/stm32l4x5_usart: Enable serial read and write
Date: Thu, 25 Apr 2024 11:39:55 +0100
Message-Id: <20240425103958.3237225-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Arnaud Minier <arnaud.minier@telecom-paris.fr>

Implement the ability to read and write characters to the
usart using the serial port.

The character transmission is based on the
cmsdk-apb-uart implementation.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240329174402.60382-3-arnaud.minier@telecom-paris.fr
[PMM: fixed a few checkpatch nits]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/stm32l4x5_usart.h |   1 +
 hw/char/stm32l4x5_usart.c         | 143 ++++++++++++++++++++++++++++++
 hw/char/trace-events              |   7 ++
 3 files changed, 151 insertions(+)

diff --git a/include/hw/char/stm32l4x5_usart.h b/include/hw/char/stm32l4x5_usart.h
index 8d38a85a6e6..dd3866682a3 100644
--- a/include/hw/char/stm32l4x5_usart.h
+++ b/include/hw/char/stm32l4x5_usart.h
@@ -55,6 +55,7 @@ struct Stm32l4x5UsartBaseState {
     Clock *clk;
     CharBackend chr;
     qemu_irq irq;
+    guint watch_tag;
 };
 
 struct Stm32l4x5UsartBaseClass {
diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 62957ec3e59..755fc0bb5a3 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -154,6 +154,123 @@ REG32(RDR, 0x24)
 REG32(TDR, 0x28)
     FIELD(TDR, TDR, 0, 9)
 
+static void stm32l4x5_update_irq(Stm32l4x5UsartBaseState *s)
+{
+    if (((s->isr & R_ISR_WUF_MASK) && (s->cr3 & R_CR3_WUFIE_MASK))        ||
+        ((s->isr & R_ISR_CMF_MASK) && (s->cr1 & R_CR1_CMIE_MASK))         ||
+        ((s->isr & R_ISR_ABRF_MASK) && (s->cr1 & R_CR1_RXNEIE_MASK))      ||
+        ((s->isr & R_ISR_EOBF_MASK) && (s->cr1 & R_CR1_EOBIE_MASK))       ||
+        ((s->isr & R_ISR_RTOF_MASK) && (s->cr1 & R_CR1_RTOIE_MASK))       ||
+        ((s->isr & R_ISR_CTSIF_MASK) && (s->cr3 & R_CR3_CTSIE_MASK))      ||
+        ((s->isr & R_ISR_LBDF_MASK) && (s->cr2 & R_CR2_LBDIE_MASK))       ||
+        ((s->isr & R_ISR_TXE_MASK) && (s->cr1 & R_CR1_TXEIE_MASK))        ||
+        ((s->isr & R_ISR_TC_MASK) && (s->cr1 & R_CR1_TCIE_MASK))          ||
+        ((s->isr & R_ISR_RXNE_MASK) && (s->cr1 & R_CR1_RXNEIE_MASK))      ||
+        ((s->isr & R_ISR_IDLE_MASK) && (s->cr1 & R_CR1_IDLEIE_MASK))      ||
+        ((s->isr & R_ISR_ORE_MASK) &&
+            ((s->cr1 & R_CR1_RXNEIE_MASK) || (s->cr3 & R_CR3_EIE_MASK)))  ||
+        /* TODO: Handle NF ? */
+        ((s->isr & R_ISR_FE_MASK) && (s->cr3 & R_CR3_EIE_MASK))           ||
+        ((s->isr & R_ISR_PE_MASK) && (s->cr1 & R_CR1_PEIE_MASK))) {
+        qemu_irq_raise(s->irq);
+        trace_stm32l4x5_usart_irq_raised(s->isr);
+    } else {
+        qemu_irq_lower(s->irq);
+        trace_stm32l4x5_usart_irq_lowered();
+    }
+}
+
+static int stm32l4x5_usart_base_can_receive(void *opaque)
+{
+    Stm32l4x5UsartBaseState *s = opaque;
+
+    if (!(s->isr & R_ISR_RXNE_MASK)) {
+        return 1;
+    }
+
+    return 0;
+}
+
+static void stm32l4x5_usart_base_receive(void *opaque, const uint8_t *buf,
+                                         int size)
+{
+    Stm32l4x5UsartBaseState *s = opaque;
+
+    if (!((s->cr1 & R_CR1_UE_MASK) && (s->cr1 & R_CR1_RE_MASK))) {
+        trace_stm32l4x5_usart_receiver_not_enabled(
+            FIELD_EX32(s->cr1, CR1, UE), FIELD_EX32(s->cr1, CR1, RE));
+        return;
+    }
+
+    /* Check if overrun detection is enabled and if there is an overrun */
+    if (!(s->cr3 & R_CR3_OVRDIS_MASK) && (s->isr & R_ISR_RXNE_MASK)) {
+        /*
+         * A character has been received while
+         * the previous has not been read = Overrun.
+         */
+        s->isr |= R_ISR_ORE_MASK;
+        trace_stm32l4x5_usart_overrun_detected(s->rdr, *buf);
+    } else {
+        /* No overrun */
+        s->rdr = *buf;
+        s->isr |= R_ISR_RXNE_MASK;
+        trace_stm32l4x5_usart_rx(s->rdr);
+    }
+
+    stm32l4x5_update_irq(s);
+}
+
+/*
+ * Try to send tx data, and arrange to be called back later if
+ * we can't (ie the char backend is busy/blocking).
+ */
+static gboolean usart_transmit(void *do_not_use, GIOCondition cond,
+                               void *opaque)
+{
+    Stm32l4x5UsartBaseState *s = STM32L4X5_USART_BASE(opaque);
+    int ret;
+    /* TODO: Handle 9 bits transmission */
+    uint8_t ch = s->tdr;
+
+    s->watch_tag = 0;
+
+    if (!(s->cr1 & R_CR1_TE_MASK) || (s->isr & R_ISR_TXE_MASK)) {
+        return G_SOURCE_REMOVE;
+    }
+
+    ret = qemu_chr_fe_write(&s->chr, &ch, 1);
+    if (ret <= 0) {
+        s->watch_tag = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                                             usart_transmit, s);
+        if (!s->watch_tag) {
+            /*
+             * Most common reason to be here is "no chardev backend":
+             * just insta-drain the buffer, so the serial output
+             * goes into a void, rather than blocking the guest.
+             */
+            goto buffer_drained;
+        }
+        /* Transmit pending */
+        trace_stm32l4x5_usart_tx_pending();
+        return G_SOURCE_REMOVE;
+    }
+
+buffer_drained:
+    /* Character successfully sent */
+    trace_stm32l4x5_usart_tx(ch);
+    s->isr |= R_ISR_TC_MASK | R_ISR_TXE_MASK;
+    stm32l4x5_update_irq(s);
+    return G_SOURCE_REMOVE;
+}
+
+static void usart_cancel_transmit(Stm32l4x5UsartBaseState *s)
+{
+    if (s->watch_tag) {
+        g_source_remove(s->watch_tag);
+        s->watch_tag = 0;
+    }
+}
+
 static void stm32l4x5_usart_base_reset_hold(Object *obj, ResetType type)
 {
     Stm32l4x5UsartBaseState *s = STM32L4X5_USART_BASE(obj);
@@ -167,6 +284,22 @@ static void stm32l4x5_usart_base_reset_hold(Object *obj, ResetType type)
     s->isr = 0x020000C0;
     s->rdr = 0x00000000;
     s->tdr = 0x00000000;
+
+    usart_cancel_transmit(s);
+    stm32l4x5_update_irq(s);
+}
+
+static void usart_update_rqr(Stm32l4x5UsartBaseState *s, uint32_t value)
+{
+    /* TXFRQ */
+    /* Reset RXNE flag */
+    if (value & R_RQR_RXFRQ_MASK) {
+        s->isr &= ~R_ISR_RXNE_MASK;
+    }
+    /* MMRQ */
+    /* SBKRQ */
+    /* ABRRQ */
+    stm32l4x5_update_irq(s);
 }
 
 static uint64_t stm32l4x5_usart_base_read(void *opaque, hwaddr addr,
@@ -209,6 +342,7 @@ static uint64_t stm32l4x5_usart_base_read(void *opaque, hwaddr addr,
         retvalue = FIELD_EX32(s->rdr, RDR, RDR);
         /* Reset RXNE flag */
         s->isr &= ~R_ISR_RXNE_MASK;
+        stm32l4x5_update_irq(s);
         break;
     case A_TDR:
         retvalue = FIELD_EX32(s->tdr, TDR, TDR);
@@ -235,6 +369,7 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
     switch (addr) {
     case A_CR1:
         s->cr1 = value;
+        stm32l4x5_update_irq(s);
         return;
     case A_CR2:
         s->cr2 = value;
@@ -252,6 +387,7 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
         s->rtor = value;
         return;
     case A_RQR:
+        usart_update_rqr(s, value);
         return;
     case A_ISR:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -260,6 +396,7 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
     case A_ICR:
         /* Clear the status flags */
         s->isr &= ~value;
+        stm32l4x5_update_irq(s);
         return;
     case A_RDR:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -267,6 +404,8 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
         return;
     case A_TDR:
         s->tdr = value;
+        s->isr &= ~R_ISR_TXE_MASK;
+        usart_transmit(NULL, G_IO_OUT, s);
         return;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -336,6 +475,10 @@ static void stm32l4x5_usart_base_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "USART clock must be wired up by SoC code");
         return;
     }
+
+    qemu_chr_fe_set_handlers(&s->chr, stm32l4x5_usart_base_can_receive,
+                             stm32l4x5_usart_base_receive, NULL, NULL,
+                             s, NULL, true);
 }
 
 static void stm32l4x5_usart_base_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 689bed9e025..f22f0ee2bc5 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -109,6 +109,13 @@ sh_serial_write(char *id, unsigned size, uint64_t offs, uint64_t val) "%s size %
 # stm32l4x5_usart.c
 stm32l4x5_usart_read(uint64_t addr, uint32_t data) "USART: Read <0x%" PRIx64 "> -> 0x%" PRIx32 ""
 stm32l4x5_usart_write(uint64_t addr, uint32_t data) "USART: Write <0x%" PRIx64 "> <- 0x%" PRIx32 ""
+stm32l4x5_usart_rx(uint8_t c) "USART: got character 0x%x from backend"
+stm32l4x5_usart_tx(uint8_t c) "USART: character 0x%x sent to backend"
+stm32l4x5_usart_tx_pending(void) "USART: character send to backend pending"
+stm32l4x5_usart_irq_raised(uint32_t reg) "USART: IRQ raised: 0x%08"PRIx32
+stm32l4x5_usart_irq_lowered(void) "USART: IRQ lowered"
+stm32l4x5_usart_overrun_detected(uint8_t current, uint8_t received) "USART: Overrun detected, RDR='0x%x', received 0x%x"
+stm32l4x5_usart_receiver_not_enabled(uint8_t ue_bit, uint8_t re_bit) "USART: Receiver not enabled, UE=0x%x, RE=0x%x"
 
 # xen_console.c
 xen_console_connect(unsigned int idx, unsigned int ring_ref, unsigned int port, unsigned int limit) "idx %u ring_ref %u port %u limit %u"
-- 
2.34.1


