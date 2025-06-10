Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88321C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyXG-0006ac-2m; Tue, 10 Jun 2025 08:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyX3-0006Y9-6d
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:56:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyX0-0002YL-Qq
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:56:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-453066fad06so19507525e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560204; x=1750165004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Z+F9XmQmU87AVbjZbrQLCllEUIvwWYDtRqjIX6YXKQ=;
 b=lQw5qI2dNPRPls8X8mah+MqyRWPR/SsITx7hSvX6AMtYYuwVHwXuin7O/kKSqhJJ6h
 cFLxFBtWt8s4qaAFmpKvmxPmthqCjnWu919bHHrxNig9fPcgwqtN0er3IPe/tmqlWN21
 kL1pl2UohEsnaw3xhoYy4NhxtgAkAQ84GDl/d8WMXRXQGMfSnoG/tY94mNymvIYTQZ2R
 qKVi04Oo3bygw2wqdKwkWD1Iuq4aE1ujHxpDnCW2+5P4q+gOy/2des3sf/lwCPv2DmBm
 R7CGBOfTL0OQPURhXuTUVUAZ+QXVuwIWbLX/4C3xvQQ4YkARhGkfLnRJAfZHquR0ybg9
 A/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560204; x=1750165004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Z+F9XmQmU87AVbjZbrQLCllEUIvwWYDtRqjIX6YXKQ=;
 b=Rr4nvub9ocyEOoY5Ub/Cd4fbTjqiTo7aJy5jZ1VWyx+S4szQh8auM88vBTJewbE/64
 si8+IbCVdDJFR6ciF+eYn/JzXnkVbPlsrtTbsUX9mWhob+7Q/A+5fFBG6t7fLLN0u56e
 Fz4DRABiIkOdcKh6mZVLyAyrr+FABI9e3RUpgRf40vb+RDWtXz/Fe0CCN1AwUttyie0m
 BK5g9Dg4Yj3AR8rdNrKaD+ESODdyoNz3hJPwkN44njT/k14/FJviAbWb7B+sp3PDlbhO
 QHVGntfWa14A1t5y7blOj5y23A43mCVREU5tzioja4l9tS5wx0NPEuqxwK9R6n/hNFON
 yN6Q==
X-Gm-Message-State: AOJu0YwrVHO/G/XoL0TsQYnObEInKJmXnO/cXX9qA0kd9I4UyYOWngKW
 deOctlp2Vv+t0XpNmvxVDL89ES9Uh5yxLQatjOMBJUSr24+1T5t2ppBRSZ6djNd4ua1Wr9b+jYo
 +PlqmRcI=
X-Gm-Gg: ASbGncukQ8a7Cl87hxkGuDHNkrDK0W7+ZIxferL5MJjTmCKt1wBvFaPLzZsD461yed9
 p+9PMF9rudD12qZwXjSYw++FrxAhcW+NpMqnGFbWpUywzZkwt5YP58Ri7WKlvIpWUakPLK5vIN3
 tL9LbF6/mjm8keVPH0TFFOzuVN7vZe28bhzfXYG2tYXb/qYuaTowxaDzaGOGMXKH4rl2udFlGe5
 LmdYrszqNVv9pTqHU8RycfHNCSf4MaOgr0E+q3yS7NJ6ZdTp5KrE4HwisNXakNDmSlUAuIZDxZX
 EUKaaRF8dfKlhaltqKQkG3rgIAokSGmhDDbED0KyUXQoSnmZA9lUWPuDupt/PzA1Cfq/UkU+6bH
 UHCqczyrVMlsnfyAx9oltA60OgRsPVnEOV0Z/jbhJbw==
X-Google-Smtp-Source: AGHT+IHpNGsL5t2pi/phCL8ghVtAcRgc6McDZe0NX6CxXkiiex/9ahceZpFZiT8xxm7WeB1Qa8kh1Q==
X-Received: by 2002:a05:600c:4f8a:b0:453:b44:eb71 with SMTP id
 5b1f17b1804b1-4530b44efb3mr73427365e9.19.1749560204409; 
 Tue, 10 Jun 2025 05:56:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d15asm12581969f8f.66.2025.06.10.05.56.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:56:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/24] hw/char/sh_serial: Convert to TypeInfo
Date: Tue, 10 Jun 2025 14:56:11 +0200
Message-ID: <20250610125633.24411-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

QOM types are now registered using as TypeInfo via DEFINE_TYPES()
or type_init(). Update TYPE_SH_SERIAL, removing the empty QOM
instance_init/finalize handlers.

This was definitely wrong, because OBJECT_DEFINE_TYPE() is only
for cases where the class needs its own virtual methods or some
other per-class state in its own class struct.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20250124175053.74461-3-philmd@linaro.org>
---
 hw/char/sh_serial.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index cdaeac7b709..30447fa018a 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -78,10 +78,6 @@ struct SHSerialState {
     qemu_irq bri;
 };
 
-typedef struct {} SHSerialStateClass;
-
-OBJECT_DEFINE_TYPE(SHSerialState, sh_serial, SH_SERIAL, SYS_BUS_DEVICE)
-
 static void sh_serial_clear_fifo(SHSerialState *s)
 {
     memset(s->rx_fifo, 0, SH_RX_FIFO_LENGTH);
@@ -441,14 +437,6 @@ static void sh_serial_unrealize(DeviceState *dev)
     timer_del(&s->fifo_timeout_timer);
 }
 
-static void sh_serial_init(Object *obj)
-{
-}
-
-static void sh_serial_finalize(Object *obj)
-{
-}
-
 static const Property sh_serial_properties[] = {
     DEFINE_PROP_CHR("chardev", SHSerialState, chr),
     DEFINE_PROP_UINT8("features", SHSerialState, feat, 0),
@@ -465,3 +453,14 @@ static void sh_serial_class_init(ObjectClass *oc, const void *data)
     /* Reason: part of SuperH CPU/SoC, needs to be wired up */
     dc->user_creatable = false;
 }
+
+static const TypeInfo sh_serial_types[] = {
+    {
+        .name           = TYPE_SH_SERIAL,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(SHSerialState),
+        .class_init     = sh_serial_class_init,
+    },
+};
+
+DEFINE_TYPES(sh_serial_types)
-- 
2.49.0


