Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B8BC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEuG-0004XW-IZ; Wed, 12 Feb 2025 10:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEu2-0004Rr-6m
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:43:55 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEu0-0006uI-L8
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:43:53 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394820123dso21816245e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375030; x=1739979830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UKvpyBheJZs4xo26Id8y6y+sGte9Qefez9+pLdOdy9I=;
 b=ialgzR/Zcd6TcnLT0ox+tvRECh+rmymBU541eZ628aUPhx+0db8oOrsB684bLuvmtG
 kMbNuPgJ0Qhlca2ldcjL97+P+NcoRU1GwTPSckbi0UzexADUAPtxJvo0qbT4AxoPQisg
 rzvv+KJP3AafKYHca1LqtiYATlDyiBoUKAhai/z4tHua1ZV5bMf4/APF4ZM5A43uhPTU
 9LeG4zc+kpR3SGD6ObsunyWkJznWun38iXUpnQe8Zsh4g9D9SBQqhw+fXXqOiyaXJaq/
 9DsGXGxxC4ImHSKtEbMuT5DIVnQHAmXTsbUgX9pcbjNJ4/Tz//1CXVeYcUOOjff9smWg
 yR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375030; x=1739979830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UKvpyBheJZs4xo26Id8y6y+sGte9Qefez9+pLdOdy9I=;
 b=mwUIIn4gyJ5H0RCGYfVBQrohY2w7+Ob9pmrzRuPIAdlesmhlvln6zpyBE0sqnSV9Gw
 VJltmVtgjJ7NrqtyN2NK0i8DU3+kU7GupUpPK8WOWH0CYd107MVNAMcC0YuN6sCgCw5o
 ajYg0Y5ZDkjm7fVrCunK3X8Zl/BbD4kaI4v9wZ2UVooXX6K8ETpjZC473ivg0u7dPquR
 b7Y+J9MvYNm46i5Fgj0dfniyMx44P/kA54Li19YNi3U6bfTw9CbXjXnUCkUWB0yXuaA2
 IciNadd5F4Sl8CbiuFrl/iyPjA7mmJRP6doHMUuBlsPVp8WhlB4aaVRXuis3PTnzSy52
 TzFw==
X-Gm-Message-State: AOJu0YyuyL71sN8Q1Xp8mOSSbFf8QGGXvuJDBCiYWgmQSL+G36Ne/s05
 nHru1t4BjrXQr/rVKFMV6A2Jzx7UtJYdxOFpn7oI2P2cw1n3VeJO+Ab4Di4h7ogJzzPo7F9690K
 6nEA=
X-Gm-Gg: ASbGncu7R8mo1i5N9vPt5E77J4/ObsPDdSkEOznF8ZHnEoGLzBftZ5Qxgw8chZDODV0
 tRpoig5Gq6L437mCfx6BeFMhCahIw0F2NPcejldEHy+n7lpaMd2awmpgqaOmK3hrF+sviZUH1/9
 3eb+Y2U1yEWIZohD4Aos/GopEe0yetdpWctGTgaH59xOcm1Ke4UHUNOg9Wj8K2LKpZc1+Obl/K+
 +1v1djP3iSNBeT5uSYFEOfoK515Xl6x6n8Qne3NBUYVuIvO0dTYdeMxyZS+jXnOIWHi8CUm/EGy
 UJ8O/9UxCDRaistnrIymXRNrea0vDirMVdQI2pbyqrgM8NDOOUvLB8q0aFvao6eF00Uc1s0=
X-Google-Smtp-Source: AGHT+IH5Zp6HksmPDIRghHF8talJ6aR8Up1VX5nqLH0wm5z6hz0OKDjzvUL+3/RYZw+YAMCr0VCGKw==
X-Received: by 2002:a05:6000:4014:b0:38d:e092:3ced with SMTP id
 ffacd0b85a97d-38dea251738mr2972459f8f.7.1739375030528; 
 Wed, 12 Feb 2025 07:43:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd9c48173sm10137892f8f.37.2025.02.12.07.43.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 07:43:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/8] hw/arm/realview: Specify explicitly the GIC has 64
 external IRQs
Date: Wed, 12 Feb 2025 16:43:28 +0100
Message-ID: <20250212154333.28644-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212154333.28644-1-philmd@linaro.org>
References: <20250212154333.28644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

When not specified, Cortex-A9MP configures its GIC with 64 external
IRQs (see commit a32134aad89 "arm:make the number of GIC interrupts
configurable"). Add the GIC_EXT_IRQS definition (with a comment)
to make that explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/realview.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 9900a98f3b8..e50f687227c 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -35,6 +35,8 @@
 #define SMP_BOOT_ADDR 0xe0000000
 #define SMP_BOOTREG_ADDR 0x10000030
 
+#define GIC_EXT_IRQS 64 /* Realview PBX-A9 development board */
+
 /* Board init.  */
 
 static struct arm_boot_info realview_binfo = {
@@ -185,7 +187,12 @@ static void realview_init(MachineState *machine,
     sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, 0x10000000);
 
     if (is_mpcore) {
-        dev = qdev_new(is_pb ? TYPE_A9MPCORE_PRIV : "realview_mpcore");
+        if (is_pb) {
+            dev = qdev_new(TYPE_A9MPCORE_PRIV);
+            qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
+        } else {
+            dev = qdev_new("realview_mpcore");
+        }
         qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(busdev, &error_fatal);
@@ -201,7 +208,7 @@ static void realview_init(MachineState *machine,
         /* For now just create the nIRQ GIC, and ignore the others.  */
         dev = sysbus_create_simple(TYPE_REALVIEW_GIC, gic_addr, cpu_irq[0]);
     }
-    for (n = 0; n < 64; n++) {
+    for (n = 0; n < GIC_EXT_IRQS; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-- 
2.47.1


