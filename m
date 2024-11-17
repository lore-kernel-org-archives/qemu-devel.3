Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A78D10F38
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 23:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCoGO-0008Ee-3Y; Sun, 17 Nov 2024 18:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCp-0007gs-L8
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:23 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCn-0002rx-WC
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:23 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so21914835e9.2
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 14:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731884240; x=1732489040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=18E/3zGs9HMVV32crijwYqItWb76EfGhA7NDcdf18zI=;
 b=ZY2ie++C3qDnao3snaSM/v2tuJBRVuMbnSmBk1zEzfJDZ1dCt6w8slSzUU0UIlJPWO
 MPiXGGVd6LFnl8phdRrKj+WWnRCSpll/7nqflIovwkQzB4Ks6R0YTZKQUI6adkGhQ3do
 GHdzAg3GC07Tj66uTSOCEdXiLgSMpZW2j025ejBU7wYzxZh7981BsKUfNjvU3neqrNWl
 J+vVxKYp8O1LKqiTxgYwuB54cxLPASWTRAhYrGN241ZAsXGzUZtvo4OFMta+y40JcAh2
 d1+n6kLNUWLTObD7eKNfQaoVEh7MTuLOiS4G8jhJL0ZSS6Ah7S/uLI2t7CJ3wDyl0S/0
 E9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731884240; x=1732489040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18E/3zGs9HMVV32crijwYqItWb76EfGhA7NDcdf18zI=;
 b=C7Ze6E75CIjnOjIJMzmpiN3FrucmrZwdQl/D9dumNcm3GTknwSdQ5MHA1YYpF8pvpp
 fpPQWbaK2L2pBExLi4Ic9mJ2P4LR6ybLuinbRNwo++CkdaQpI8pqSxg8oHh274zvgeO0
 DlNR0AAXn9U14YLQ3djfFF4PKEiaa6b9KEEFbjumHv2vKMt2CN16egZv9Nkfd4LPQMvC
 wfVEK4VhTYVHzmec2huP+wP6cIj9Pdl/O2Z7koc2VxDJpuZvQZD3gwoegxL/9iTR2TLD
 Oh97N1hViOQaf163eWNc1oD4b90kYB0dt3OCiRVo5zZ3g5lBKrgrs3G8wtdlJMwyIhb8
 gkvw==
X-Gm-Message-State: AOJu0Yw87o+SzNRIYLPMZe3zO+zUKNyzICsN7KYGc93tc4AQHpST/+BH
 FfHuV5TjpcuvVfFK6XQkQtP97MMDwL/UNeaDxujjGMW5rvRPFxGv+el7HqVqXuclnQ==
X-Google-Smtp-Source: AGHT+IHLc6Sm+j9iQX+jKzbrHRuFIBpPEfgrjZQYK0sgcCONCFBIN1qTQNe5lmRmmMZCPooj8R7N+A==
X-Received: by 2002:a05:6000:186e:b0:382:442c:2c54 with SMTP id
 ffacd0b85a97d-382442c2f00mr1758432f8f.28.1731884240294; 
 Sun, 17 Nov 2024 14:57:20 -0800 (PST)
Received: from asus-xubuntu.. ([82.78.167.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da2800absm136351505e9.25.2024.11.17.14.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 14:57:19 -0800 (PST)
From: "=?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?="
 <jean.christian.cirstea@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
Subject: [PATCH 2/7] [BCM2835 AUX 2/7] Add basic support for CNTL register
Date: Mon, 18 Nov 2024 00:56:38 +0200
Message-Id: <20241117225643.768322-2-ioan-cristian.cirstea@tutanota.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
References: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit allows software to enable/disable both the receiver and the
transmitter through the CNTL register.

Signed-off-by: Ioan-Cristian CÎRSTEA <ioan-cristian.cirstea@tutanota.com>
---
 hw/char/bcm2835_aux.c         | 50 +++++++++++++++++++++++++++++------
 include/hw/char/bcm2835_aux.h |  3 ++-
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 540cb30872..ebc7f5ade5 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -29,6 +29,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 
+/* TODO: These constants need to be unsigned */
 #define AUX_IRQ         0x0
 #define AUX_ENABLES     0x4
 #define AUX_MU_IO_REG   0x40
@@ -43,10 +44,17 @@
 #define AUX_MU_STAT_REG 0x64
 #define AUX_MU_BAUD_REG 0x68
 
+/* Register masks */
+#define MASK_AUX_MU_CNTL_REG 0x3
+
 /* bits in IER/IIR registers */
 #define RX_INT  0x1
 #define TX_INT  0x2
 
+/* bits in CNTL register */
+#define RX_ENABLE 0x1
+#define TX_ENABLE 0x2
+
 /* FIFOs length */
 #define BCM2835_AUX_RX_FIFO_LEN 8
 #define BCM2835_AUX_TX_FIOF_LEN 8
@@ -72,13 +80,27 @@ static void bcm2835_aux_update(BCM2835AuxState *s)
     qemu_set_irq(s->irq, s->iir != 0);
 }
 
+static bool bcm2835_aux_is_tx_enabled(BCM2835AuxState *s)
+{
+    return (s->cntl & TX_ENABLE) != 0;
+}
+
+static bool bcm2835_aux_is_rx_enabled(BCM2835AuxState *s)
+{
+    return (s->cntl & RX_ENABLE) != 0;
+}
+
 static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
 {
     BCM2835AuxState *s = opaque;
     Fifo8 *rx_fifo = &s->rx_fifo;
     const bool is_rx_fifo_not_empty = !fifo8_is_empty(rx_fifo);
     const uint32_t rx_fifo_fill_level = fifo8_num_used(rx_fifo);
-    uint32_t c = 0, res;
+    /*
+     * 0xFF trashes terminal output, so device driver bugs can be found quickly
+     * in case the RX_FIFO is read while empty
+     */
+    uint32_t c = 0xFF, res;
 
     switch (offset) {
     case AUX_IRQ:
@@ -140,7 +162,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
         return 0;
 
     case AUX_MU_CNTL_REG:
-        return 0x3; /* tx, rx enabled */
+        return s->cntl;
 
     case AUX_MU_STAT_REG:
         res = 0x30e; /* space in the output buffer, empty tx fifo, idle tx/rx */
@@ -183,7 +205,9 @@ static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
         ch = value;
         /* XXX this blocks entire thread. Rewrite to use
          * qemu_chr_fe_write and background I/O callbacks */
-        qemu_chr_fe_write_all(&s->chr, &ch, 1);
+        if (bcm2835_aux_is_tx_enabled(s)) {
+            qemu_chr_fe_write_all(&s->chr, &ch, 1);
+        }
         break;
 
     case AUX_MU_IER_REG:
@@ -211,7 +235,12 @@ static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
         break;
 
     case AUX_MU_CNTL_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_CNTL_REG unsupported\n", __func__);
+        if (value & ~MASK_AUX_MU_CNTL_REG) {
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: auto flow control not supported\n",
+                          __func__);
+        }
+        s->cntl = value & MASK_AUX_MU_CNTL_REG;
         break;
 
     case AUX_MU_BAUD_REG:
@@ -233,7 +262,7 @@ static int bcm2835_aux_can_receive(void *opaque)
     return !fifo8_is_full(&s->rx_fifo);
 }
 
-static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
+static void bcm2835_aux_put_fifo(BCM2835AuxState *s, uint8_t value)
 {
     BCM2835AuxState *s = opaque;
     Fifo8 *rx_fifo = &s->rx_fifo;
@@ -246,7 +275,11 @@ static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
 
 static void bcm2835_aux_receive(void *opaque, const uint8_t *buf, int size)
 {
-    bcm2835_aux_put_fifo(opaque, *buf);
+    BCM2835AuxState *s = opaque;
+
+    if (bcm2835_aux_is_rx_enabled(s)) {
+        bcm2835_aux_put_fifo(opaque, *buf);
+    }
 }
 
 static const MemoryRegionOps bcm2835_aux_ops = {
@@ -266,8 +299,9 @@ static const VMStateDescription vmstate_bcm2835_aux = {
     .fields = (const VMStateField[]) {
         VMSTATE_FIFO8(rx_fifo, BCM2835AuxState),
         VMSTATE_FIFO8(_tx_fifo, BCM2835AuxState),
-        VMSTATE_UINT8(ier, BCM2835AuxState),
-        VMSTATE_UINT8(iir, BCM2835AuxState),
+        VMSTATE_UINT32(ier, BCM2835AuxState),
+        VMSTATE_UINT32(iir, BCM2835AuxState),
+        VMSTATE_UINT32(cntl, BCM2835AuxState),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.h
index cb1a824994..feaedc9e2f 100644
--- a/include/hw/char/bcm2835_aux.h
+++ b/include/hw/char/bcm2835_aux.h
@@ -29,7 +29,8 @@ struct BCM2835AuxState {
     Fifo8 rx_fifo;
     /* Unused for now */
     Fifo8 _tx_fifo;
-    uint8_t ier, iir;
+    /* Registers */
+    uint32_t ier, iir, cntl;
 };
 
 #endif
-- 
2.34.1


