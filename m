Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECA7D10F3A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 23:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCoGH-0008D9-T4; Sun, 17 Nov 2024 18:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCw-0007iX-9m
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:30 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCu-0002tG-NL
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:30 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso11661425e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 14:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731884247; x=1732489047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOg4Uf9LmZCDp34QTwcMrfKO0WCHbSBpZDm8O0Hzx0A=;
 b=fh+MLzusEFYM7Eq3cyjcHjbI/Nwxt+Pld2kin2eNYdCT3zqPNFqfQIQcAuPX7A9v/y
 l85ybr11oI9py/D8n+0VmrH3Sz21mAGS80Lw2QQRnY+4XgVYDaAfFLhqaWNn6MnWAGRj
 0wsnV1YGt+6Mgw/+lEJ/8L2s+VtTKsEMeimUF3mdAk/ymqsVajNSVvXi8lSsPU9wYJs1
 5tASmXJvipde5GTn39ESXryIv/OGasQDDVI7MWu/LWw2k7jzqJWvjLlH+/qpGUA8qVE5
 eYCT8f15W7VaDtLsYv55f+WmqxplLdur99hAuw8lSGmlFVUnGXiQMnJsGaeQMC8YT0Ai
 Qa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731884247; x=1732489047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOg4Uf9LmZCDp34QTwcMrfKO0WCHbSBpZDm8O0Hzx0A=;
 b=NVVEoybGhpSd+5ooG0oCOQoDCqfu/Ry2dRlFlQfS13clOiTxPQ6FkyAv38B80TfrjM
 mGNBUFePjFgKOd7UZSUO7CwpDmMc3067Fcn/EYL8qmOx39L2B2Ubtpt/L8bNtiVggqs5
 b+2xDxbr5mK3qfypI65zYhyR6/KuD2bKmY32YdkruYX1agaO6KWq+3OJzVI7FgGcq0Pa
 wIwLXBVDIWuLH2PkjBKzsn2bI29QwRC1enBBlmzqa4MMoanxdM+b5Jm9QfizmLKhMSjD
 N29HqfLtU42D7Bskh3KypY7LuML8T8yCiYRPtU/ZJoksLBAMwQ9YP73+PkWcmjRToxRw
 LDJQ==
X-Gm-Message-State: AOJu0YzqnHunpDr8iq0CLApMoP7m05/KC58X+uslKezjYP+5irMEC4Ti
 uyO+pthnw3M/X+DG4olcpQg30bYQjUKnd5/NZ8oeDSLfBjHvpHHe96D1b3aErmH1kg==
X-Google-Smtp-Source: AGHT+IF4Hxm68QnBptJuwowUfHAoqP/jHKPZsuVqasgx4hRyj5frtBnt7j7vKc8KFK0GEzDvSA5C6Q==
X-Received: by 2002:a05:6000:2ca:b0:382:43ee:9f70 with SMTP id
 ffacd0b85a97d-38243eea2b2mr1734246f8f.22.1731884247275; 
 Sun, 17 Nov 2024 14:57:27 -0800 (PST)
Received: from asus-xubuntu.. ([82.78.167.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da2800absm136351505e9.25.2024.11.17.14.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 14:57:26 -0800 (PST)
From: "=?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?="
 <jean.christian.cirstea@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
Subject: [PATCH 7/7] [BCM2835 AUX 7/7] STAT OVERRUN & IDLE
Date: Mon, 18 Nov 2024 00:56:43 +0200
Message-Id: <20241117225643.768322-7-ioan-cristian.cirstea@tutanota.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
References: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_ALL_CAPS=0.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 17 Nov 2024 18:00:54 -0500
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

This commit implements the required logic for receiver overrun and idle
bitfields in the STAT register. Currently, the receiver is always
reported as idle.

Signed-off-by: Ioan-Cristian CÎRSTEA <ioan-cristian.cirstea@tutanota.com>
---
 hw/char/bcm2835_aux.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 577d9a9be3..c9bce7d7d3 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -29,7 +29,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 
-/* TODO: These constants need to be unsigned */
 #define AUX_IRQ         0x0U
 #define AUX_ENABLES     0x4U
 #define AUX_MU_IO_REG   0x40U
@@ -50,11 +49,8 @@
 
 /* Mask for TX-related bits */
 #define MASK_AUX_MU_STAT_REG_TX 0xF00032AU
-/*
- * Mask for RX-related bits.
- * XXX: It does not include receiver IDLE and receiver overrun for now.
- */
-#define MASK_AUX_MU_STAT_REG_RX 0xF0001U
+/* Mask for RX-related bits */
+#define MASK_AUX_MU_STAT_REG_RX 0xF0015U
 
 /* Mask for TX-related bits */
 #define MASK_AUX_MU_LSR_REG_TX 0x60U
@@ -70,6 +66,7 @@
 
 /* bits in LSR register */
 #define LSR_OVERRUN 0x2U
+#define LSR_OVERRUN_OFFSET 0x1U
 
 /* bits in CNTL register */
 #define CNTL_RX_ENABLE 0x1U
@@ -77,6 +74,8 @@
 
 /* bits in STAT register */
 #define STAT_TRANSMITTER_DONE 0x200U
+#define STAT_OVERRUN 0x10U
+#define STAT_RECEIVER_IDLE 0x4U
 
 /* FIFOs length */
 #define BCM2835_AUX_RX_FIFO_LEN 8U
@@ -90,12 +89,12 @@
                   ##__VA_ARGS__ \
                   )
 
-static void bcm2835_aux_clear_overrun_bits(BCM2835AuxState *s)
+static void bcm2835_aux_clear_overrun_bit(BCM2835AuxState *s)
 {
     s->lsr &= ~LSR_OVERRUN;
 }
 
-static void bcm2835_aux_set_overrun_bits(BCM2835AuxState *s)
+static void bcm2835_aux_set_overrun_bit(BCM2835AuxState *s)
 {
     s->lsr |= LSR_OVERRUN;
 }
@@ -134,10 +133,17 @@ static void bcm2835_aux_rx_stat_update(BCM2835AuxState *s)
 {
     Fifo8 *rx_fifo = &s->rx_fifo;
     const bool rx_symbol_available = !fifo8_is_empty(rx_fifo);
+    const bool rx_overrun = (s->lsr & LSR_OVERRUN) >> LSR_OVERRUN_OFFSET;
     const uint32_t rx_fifo_level = fifo8_num_used(rx_fifo);
 
     s->stat &= ~MASK_AUX_MU_STAT_REG_RX;
+    /*
+     * Receiver overrun bit is set separately in bcm2835_aux_set_overrun_bit
+     * Receiver is always marked as idle.
+     */
     s->stat |= (rx_fifo_level << 16) |
+               (rx_overrun << 4) |
+               STAT_RECEIVER_IDLE |
                (rx_symbol_available << 0);
 }
 
@@ -340,7 +346,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
     case AUX_MU_LSR_REG:
         res = s->lsr;
         /* Overrun bit is self-clearing */
-        bcm2835_aux_clear_overrun_bits(s);
+        bcm2835_aux_clear_overrun_bit(s);
         return res;
 
     case AUX_MU_MSR_REG:
@@ -441,7 +447,7 @@ static int bcm2835_aux_can_receive(void *opaque)
     const bool is_rx_enabled = bcm2835_aux_is_rx_enabled(s);
 
     if (is_rx_fifo_full && is_rx_enabled) {
-        bcm2835_aux_set_overrun_bits(s);
+        bcm2835_aux_set_overrun_bit(s);
     }
 
     return !is_rx_fifo_full;
-- 
2.34.1


