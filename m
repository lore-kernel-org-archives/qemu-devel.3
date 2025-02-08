Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0649C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 16:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgnrf-00011w-EQ; Sat, 08 Feb 2025 11:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnrd-00011S-VC
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:30 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnrb-0008OM-CW
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:29 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so1431778f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 08:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739032765; x=1739637565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AcA7adOksZJD+UONQiU8US0WrcIGd+kxe3T2X7yAEcA=;
 b=BreY4QpU6wt+wCY+rpCPDIgJJ92jJfy3T16UwQCWhAwxkOTfEITVV6EPXsp0Ur2I+j
 VqCfJgKQMtS5reTd5jrhyU6LlqYTY19cSOOcRirt+yNDMJeTWOEpjCjuJB7S4SeNtoKZ
 poinmkvPXwLBgepH2KAKkA6dU0O4nGeHMK2x3labuIKRY1eP85+jAnuWyNu84FcZ3kid
 1BHmLSddcKNBzweCyKow/vijE0EkNI3tVHHgRbElqz4vM7meZNsAwqk9hvXA9dudZix9
 1bqkSbUI9SLsBKx5kd+HiM4F0OFrPhQVlSRnPuh6E8tw/irlM43RosRszT9CL3PSDlNu
 NBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739032765; x=1739637565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AcA7adOksZJD+UONQiU8US0WrcIGd+kxe3T2X7yAEcA=;
 b=uvGEFsAFlnfORfZxFhhzFhIULEXS8Z8Eld7t/m99Fg4cLrkgxE9+quGK8cfaB+KNFC
 sq+C/uiJICm+OogcQCvowCsvunodZcZUgY6bZQpBUi/3MqM+muAsXqIinGwwVWgEcdwb
 LowGdlvgCQJetG6GECbTDmr7XRPMB46YeQctRmxTehPCQ7yCEVehPRUHheiDC5qMLjD5
 AWcogNfJAja3jzIzm4V4bNcn13DwSdFnF9Gq6hKkNEL46GQ+wGCwx2CgdFbtNBaKlDgK
 usnpmErlkMjgcItwRJCFjGAXHCoBRGjMfrktA92qIOSLE/yoRbI+DiTV1YmDsQXMrX5F
 FzOg==
X-Gm-Message-State: AOJu0YyeI4JKROj9lkydHrDQq5zDblyCdW5Va5Oxi9vpzt+HGzq4i+Gk
 PIBmlE3h2rqxIV2OB/K9c56y/5sNPoDEM1sgasJUbIQQ8O1SrnZma8Do0LTTShOJkqikD4ZBYCx
 OQs8=
X-Gm-Gg: ASbGncvJkL+xpTDWS1nyGr9qv1c39Czuy9ZF2EoOgrQ1avilGgQ+4ryNQt75ZkSQwRc
 vLKh5YN1QgHcTvLe3kvzMMm3g17v46C/EreHF2aPxjy5f23BUoILtWO+izKQXmSqa/bYDAmMnRT
 BuiIG0No7YCFRh9896l3qerumyDdKQw3wbP+K02NHbinbLHlMXVLGpJUvKfnScczi10L27K3oi0
 3Ovubx4BXiVrIGdXYQcQi4O2KlHhf7LOUzj/JXjAnAOg1FqdUiLPD5Jr2pqip40X201Vhu0vCUs
 +8qbgaDBs7V2yr5fv89q1yeuRYeAi14dPkG4X1hl54KKwuR4zKi7nQfW/J72maVL5g==
X-Google-Smtp-Source: AGHT+IEdTgs0/7BmFE/lYXZS9m5FuUhqNVoPpaW8JwjPjKIKOJi1em2pZpdtO0n7teZaA1euLiI3sw==
X-Received: by 2002:adf:efc4:0:b0:38a:4b8b:c57a with SMTP id
 ffacd0b85a97d-38dc93509damr5335898f8f.44.1739032765467; 
 Sat, 08 Feb 2025 08:39:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf4480sm125465305e9.27.2025.02.08.08.39.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Feb 2025 08:39:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 2/7] hw/char/pl011: Add transmit FIFO to PL011State
Date: Sat,  8 Feb 2025 17:39:06 +0100
Message-ID: <20250208163911.54522-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250208163911.54522-1-philmd@linaro.org>
References: <20250208163911.54522-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 60cea1d9a16..807fcdee50b 100644
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
@@ -553,6 +555,24 @@ static const VMStateDescription vmstate_pl011_clock = {
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
@@ -607,7 +627,11 @@ static const VMStateDescription vmstate_pl011 = {
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
@@ -621,6 +645,7 @@ static void pl011_init(Object *obj)
     PL011State *s = PL011(obj);
     int i;
 
+    fifo8_create(&s->xmit_fifo, PL011_FIFO_DEPTH);
     memory_region_init_io(&s->iomem, OBJECT(s), &pl011_ops, s, "pl011", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
@@ -633,6 +658,13 @@ static void pl011_init(Object *obj)
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
@@ -676,6 +708,7 @@ static const TypeInfo pl011_arm_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(PL011State),
     .instance_init = pl011_init,
+    .instance_finalize = pl011_finalize,
     .class_init    = pl011_class_init,
 };
 
-- 
2.47.1


