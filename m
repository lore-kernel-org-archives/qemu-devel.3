Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FAFC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs5u-0008Mk-3r; Fri, 19 Jul 2024 14:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs5N-0005V1-9Y
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:12:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs5L-0003zG-C9
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:12:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-427db004e36so251075e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412721; x=1722017521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sc6hQLwehuuiEKoTJDdG/35Ecq31WpA7x5boBSd7PGs=;
 b=rhlE/7xWSjDrR2tviEFUxz6yrqRC5LzHu+NNlP6cmptjtK8jvqEa5aQyehTzAWFmIr
 iLEpTaPEjC1iaf+OcTBO52I0mh4tAU6MUhWvGc0Jqer5thPLOnMrA6tDLyklraAAj8qD
 iGYVBa52tinFQwoHdL0cwW1+ro9Ojm0CeNWKbViN3cCHZSo2aNZUplfbXOYNXvAoi/RG
 LyZuJYEgV4CzJf2RZMTfLHSWmXl602/e2BYiFj5/CAn8+FPkO9vOhF4/P/qGnznB6MV6
 7FozfmDPVB68b3+ywIqCza85bXK3gsSbuLxiqX522nA4n6mr/xa+bLIkCvSGzXRVmHXa
 gILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412721; x=1722017521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sc6hQLwehuuiEKoTJDdG/35Ecq31WpA7x5boBSd7PGs=;
 b=HZFkXk7ZAJ1SH4iiOE1LHhsWTkuNA/4YjMvCawYlM/e7B2ULY1BDx9K+4v6aCzifXy
 hdf5lXiWOllDpZUGvYZR1GxI3JCbC3iUAMlmjZO6tF3WluNqdQ3qMeK/4yTWzVjRAcm2
 VgbGisJyRSuTIIlpApr8GmOczlSIl6lKyGSCvfV3Lr4XgFFkg0lUkgQW1eQdul51nQ8d
 /tRUnEXnOnDYrlYxKs9orYj7cGXiO6frm+rRIw0NPB/JMRwM1chmzUk3BcyXumfEWSsb
 BE0MYs/FUHzIYaAWplgHNq0movfqFwzszqAl1KbbCi4Z9obnwRxepeiZWMgui8btsRq1
 /+6w==
X-Gm-Message-State: AOJu0Yzw38kqTZD6VmcXJidi+lZ8sqjvgo8HXG2Nb9NQZOqbq3bdD45u
 04JtalNSHDbr2XgZ0KL6jK2/3EsQKCD9nu4D6VkR3Q8ajkTXu0yvRME3VZYT6/9GMiNs4n8n3xZ
 6
X-Google-Smtp-Source: AGHT+IFqxR7HobyUTGqt0aMlYycIb+Cj1q8ENdx9vfgd/9viTmyN3OeId5STij24Ev6E8ABelSymvg==
X-Received: by 2002:adf:e6c2:0:b0:367:97e7:879a with SMTP id
 ffacd0b85a97d-368317c0425mr6182998f8f.65.1721412721673; 
 Fri, 19 Jul 2024 11:12:01 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684230sm2257427f8f.17.2024.07.19.11.11.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:12:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 12/16] hw/char/pl011: Add transmit FIFO to PL011State
Date: Fri, 19 Jul 2024 20:10:37 +0200
Message-ID: <20240719181041.49545-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
index 4fcaf3d7d3..e8d95961f6 100644
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
index c42c6d1ac2..6519340b50 100644
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
@@ -545,6 +547,24 @@ static const VMStateDescription vmstate_pl011_clock = {
     }
 };
 
+static bool pl011_xmit_fifo_state_needed(void *opaque)
+{
+    PL011State* s = opaque;
+
+    return (s->lcr & LCR_FEN) && !fifo8_is_empty(&s->xmit_fifo);
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
@@ -599,7 +619,11 @@ static const VMStateDescription vmstate_pl011 = {
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
 
 static Property pl011_properties[] = {
@@ -614,6 +638,7 @@ static void pl011_init(Object *obj)
     PL011State *s = PL011(obj);
     int i;
 
+    fifo8_create(&s->xmit_fifo, PL011_FIFO_DEPTH);
     memory_region_init_io(&s->iomem, OBJECT(s), &pl011_ops, s, "pl011", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
@@ -626,6 +651,13 @@ static void pl011_init(Object *obj)
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
@@ -669,6 +701,7 @@ static const TypeInfo pl011_arm_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(PL011State),
     .instance_init = pl011_init,
+    .instance_finalize = pl011_finalize,
     .class_init    = pl011_class_init,
 };
 
-- 
2.41.0


