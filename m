Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFD6C28B2F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 01:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trRwg-0003xQ-P1; Sun, 09 Mar 2025 21:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRwc-0003vq-Dv
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:28:39 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRwa-0006QI-Lv
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:28:38 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1712383f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 18:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741570115; x=1742174915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EpcO+5mNfJW3uTvL4p/FId4A1a70cqj1/QCXsX8nNCE=;
 b=hnTV5Eu6Lr3w+CozjWAwpatY+HltEdhREPXD4e4RE9GTDfR4q/j4Mr7CNXyBuSrsTX
 wr/0ZiRFuHymdT1HP76EGMubh26DxObrcIXcHfs/ny4Fem6TetRZq6hOrA1/1LYoA5JB
 iAmn+64XKCbikEv7vHV80kSC95fFY0e1g69vFxs1YFrYA9xTm/qTmRZju0YK/372Obuw
 F0bKSa4FP5jWdfIYwD0ZDRW7iKp0usa+LkKFrn6pdIWMu0UteEfXxQ6yBBvjqjtb4Cv8
 0C0l9Uf8c8PQolIyUW9pWLrtdy1xyBipLy3dACbpxZCl8tLsL5YSrwyZL/VZHnUFf73j
 whwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741570115; x=1742174915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EpcO+5mNfJW3uTvL4p/FId4A1a70cqj1/QCXsX8nNCE=;
 b=b93VJD47vdG/TopCXh93jeMnA/jbTxt5lqxrELmQwWXrIdINrALzs1Ei5fLbBsZ8Ij
 p9NpptF3ZMWSzlOc6eWLtFXGno7lXRn5+lMFvMch5LZB/nIGX/DUh2cF+oUUuryihzB1
 cwdIpUGrWqcqMqAwxD/d0stwnqa60NdYAjj+mlnkzf4R4wayuF5dr7Wr5hSN8VQbYxy7
 Vol+Xtzhq1ytottC1rgJuYUwJaFmo9ap0MYHsszjeaW7JsGCjQ0leNFmVM3CBFj2IycJ
 j8tqhQMFlkR1r8JLzeh1D0KPLQgsGntAcrumWVFSLlnt149ZNkW/k8FVoX3V+LnT7hoh
 MFVQ==
X-Gm-Message-State: AOJu0Yxe+O133S/kKIRQTGxvcwavg14MmVnzv0zd+J3j1bcRIXBIhMgw
 nMKUqBLJCIwsaHY8CPWl2w0WRgClxQhtmNRa4zkXJWUNaDxWXL6vRi7bENl7cADh/DMpKdOjFyT
 TWMQ=
X-Gm-Gg: ASbGncsoe9xqZyq7ilrY9tKX8Hih/T/77+C5H7rcxIMxiz7qxB+hMOtYxZj3piJpesj
 6hjKK/tPtGHpimmD94lIurjbVgJhRKBzk29x+vVNJvXHWh3pZj7qZWSLA9r/hcUud56c18gDX1V
 R/VKstZd/GfouqcKoQmL+sZY2wwJBGWn+ldY3i+IV0FgZP1i828BUd3cC1+cA7egxNnn7yo0DAl
 n/fNgNdhywODsSn23JXVJKgO9HcwatVwipxJjGKsRefLfEA6fCA/JBK1PAyOS45fgynph14/qYf
 5hbsl4WKVO+Bi/4fyD62y54F6akZ2tsYSa6eRk1UsLZIrRYwDr+ae5sb2Lddd784PuslorE3AsK
 s+xA3ENz7eLiji34syfKp2d01ckvcUg==
X-Google-Smtp-Source: AGHT+IH5muMIhBM+Y6yNUoVlIeL0HObPTqaKEqPGBd/JMLnGJQrO5JihMRRlzQ98F/y0itjeTq2Zmg==
X-Received: by 2002:a5d:6d0a:0:b0:391:41fb:89ff with SMTP id
 ffacd0b85a97d-39141fb8c49mr2550978f8f.27.1741570114827; 
 Sun, 09 Mar 2025 18:28:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01ebddsm13618110f8f.60.2025.03.09.18.28.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 18:28:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 1/7] hw/char/pl011: Add transmit FIFO to PL011State
Date: Mon, 10 Mar 2025 02:28:19 +0100
Message-ID: <20250310012825.79614-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310012825.79614-1-philmd@linaro.org>
References: <20250310012825.79614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

In order to make the next commit easier to review,
introduce the transmit FIFO, but do not yet use it.

We only migrate the TX FIFO if it is in use.

When migrating from new to old VM:
- if the fifo is empty, migration will still work because
   of the subsection.
- if the fifo is not empty, the subsection will be ignored,
  with the only consequence being that some characters will
  be dropped.

Since the FIFO is created empty, we don't need a migration
pre_load() handler.

Uninline pl011_reset_tx_fifo().

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/char/pl011.h |  2 ++
 hw/char/pl011.c         | 37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 4fcaf3d7d30..e8d95961f66 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -18,6 +18,7 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
+#include "qemu/fifo8.h"
 
 #define TYPE_PL011 "pl011"
 OBJECT_DECLARE_SIMPLE_TYPE(PL011State, PL011)
@@ -52,6 +53,7 @@ struct PL011State {
     Clock *clk;
     bool migrate_clk;
     const unsigned char *id;
+    Fifo8 xmit_fifo;
 };
 
 DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr);
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 23a9db8c57c..0e9ad5d5d90 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -167,11 +167,13 @@ static inline void pl011_reset_rx_fifo(PL011State *s)
     s->flags |= PL011_FLAG_RXFE;
 }
 
-static inline void pl011_reset_tx_fifo(PL011State *s)
+static void pl011_reset_tx_fifo(PL011State *s)
 {
     /* Reset FIFO flags */
     s->flags &= ~PL011_FLAG_TXFF;
     s->flags |= PL011_FLAG_TXFE;
+
+    fifo8_reset(&s->xmit_fifo);
 }
 
 static void pl011_fifo_rx_put(void *opaque, uint32_t value)
@@ -560,6 +562,24 @@ static const VMStateDescription vmstate_pl011_clock = {
     }
 };
 
+static bool pl011_xmit_fifo_state_needed(void *opaque)
+{
+    PL011State* s = opaque;
+
+    return pl011_is_fifo_enabled(s) && !fifo8_is_empty(&s->xmit_fifo);
+}
+
+static const VMStateDescription vmstate_pl011_xmit_fifo = {
+    .name = "pl011/xmit_fifo",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pl011_xmit_fifo_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_FIFO8(xmit_fifo, PL011State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static int pl011_post_load(void *opaque, int version_id)
 {
     PL011State* s = opaque;
@@ -614,7 +634,11 @@ static const VMStateDescription vmstate_pl011 = {
     .subsections = (const VMStateDescription * const []) {
         &vmstate_pl011_clock,
         NULL
-    }
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_pl011_xmit_fifo,
+        NULL
+    },
 };
 
 static const Property pl011_properties[] = {
@@ -628,6 +652,7 @@ static void pl011_init(Object *obj)
     PL011State *s = PL011(obj);
     int i;
 
+    fifo8_create(&s->xmit_fifo, PL011_FIFO_DEPTH);
     memory_region_init_io(&s->iomem, OBJECT(s), &pl011_ops, s, "pl011", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
@@ -640,6 +665,13 @@ static void pl011_init(Object *obj)
     s->id = pl011_id_arm;
 }
 
+static void pl011_finalize(Object *obj)
+{
+    PL011State *s = PL011(obj);
+
+    fifo8_destroy(&s->xmit_fifo);
+}
+
 static void pl011_realize(DeviceState *dev, Error **errp)
 {
     PL011State *s = PL011(dev);
@@ -683,6 +715,7 @@ static const TypeInfo pl011_arm_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(PL011State),
     .instance_init = pl011_init,
+    .instance_finalize = pl011_finalize,
     .class_init    = pl011_class_init,
 };
 
-- 
2.47.1


