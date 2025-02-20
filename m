Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEACCC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JG-000760-2r; Thu, 20 Feb 2025 11:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JB-00070s-Qf
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:53 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JA-0008Dt-23
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:53 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4398738217aso9972295e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068510; x=1740673310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SYcSBjiSJfFe7ji/p5h+aB/WJAJaMBERE8TX+MuUUeE=;
 b=XM7MhztznmTkxP0W+ZLRTvzmOKgZ3dXXvBF4+hxzAtnpq5VRflRWOnDyZdMG3tOHsI
 5ia2xLjJL+LDNTUl8Gig15Wr8WiVtI9Tj9XuJ2b+hLcZhx+4Btz9iMRl0xXlshGxeIj0
 nWWT0b2d11zBRFddjDQ6XQuvyO+6Di2gp0maAHaMSFshFbTF0VntoxUzaGLJzvw8tHeZ
 JTFrT8pgZTWjThh5m9e7uAPBf9J0uXdFoD9sLSHbsHLCnMLPxTzFB/yFh9Cls7Mu7LXF
 pM9R0a2ocN6plFVA6a+rURTWhWedzo0qfb2C1c2D+nXQ2L8CoZkJxl/Zo0K41XQQ6lqZ
 e6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068510; x=1740673310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYcSBjiSJfFe7ji/p5h+aB/WJAJaMBERE8TX+MuUUeE=;
 b=fV6fcnTpo1afHjZny/6oT2jpQrL83qjlubL915RelrkmxX1RvCq8p4/oxT4WRqFIxg
 cI+6swLVdznzONYNi7bYlA8fUpQc+I4oPTYIwlqk0RpPdfuE5Zx9ZG3m671IBtZAsuUI
 VwQdkYhNX0cjhF09YoRgNpxcPI6+/5i7G/LsFvuiM8EjOqfbG+TmPOhgOjA03bs/sy0g
 Jo2lE6CbcGSyRscxIL/jXcnuDMDYrBhT29FtRtQUESzXHlnDG+g8I4DnIgjzoW5lRyzG
 F9wei7qAkl8vdTwMskSPkzo5C/G5INZ+1f8llkco/yl1hiFSr47pvJO51hrdXfnUcFJT
 UJ3w==
X-Gm-Message-State: AOJu0YxvgmLsrpru1GTJM83FbTjrTPT8fuCBJ1ji8vbxKcvmIWTdNSAU
 iSCcgL8T+6VuBjbgTIJ0sei4A4cLXvwnGzhPgb1IU8JW3qvrMXlV0pZhVaNkp9iD1CSRjX4PNbt
 P
X-Gm-Gg: ASbGncs6EZQTpdb4XrxLE83r81AgO7OWw/DMtTDbPRXutx57gkj8DSUTqPR0Nfq8kIU
 HkgHJB6kn119934NocQ5cVrXaLS30Qs4Dw74nL2NDUXJTkG5BjZEVwkp1GeVAg+0TMHYFafCRTv
 mttXBnrtB/0b1qCmONtyfHarF5nydUMpI1TLQVCPwrkG8/tMivtO2YsuJNKzjBcM1ss5WBgTBwG
 aDBxGf42WCZPg3+u981afwhvNp2sIu1ufUmxtfcYrCGKT02izmXq8M9Dhh1jT3w4vjLUztkXu4a
 po2xEMac+g4yK9oDQfqIpw==
X-Google-Smtp-Source: AGHT+IFgxKBmAt48EdkiiGzHBOqUpSsNRxrPaURQMY07xkbeus+CzSk3kp/V+GgyoAN6x4VdApuAaA==
X-Received: by 2002:a05:600c:3508:b0:439:689b:99eb with SMTP id
 5b1f17b1804b1-43999d89710mr88503135e9.7.1740068510434; 
 Thu, 20 Feb 2025 08:21:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/41] hw/arm/vexpress: Specify explicitly the GIC has 64
 external IRQs
Date: Thu, 20 Feb 2025 16:21:01 +0000
Message-ID: <20250220162123.626941-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When not specified, Cortex-A9MP configures its GIC with 64 external
IRQs, (see commit a32134aad89 "arm:make the number of GIC interrupts
configurable"), and Cortex-15MP to 128 (see commit  528622421eb
"hw/cpu/a15mpcore: Correct default value for num-irq").
The Versatile Express board however expects a fixed set of 64
interrupts (see the fixed IRQ length when this board was added in
commit 2055283bcc8 ("hw/vexpress: Add model of ARM Versatile Express
board"). Add the GIC_EXT_IRQS definition (with a comment) to make
that explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250212154333.28644-7-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/vexpress.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 48e18a49d54..76c6107766c 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -51,6 +51,8 @@
 #define VEXPRESS_FLASH_SIZE (64 * 1024 * 1024)
 #define VEXPRESS_FLASH_SECT_SIZE (256 * 1024)
 
+#define GIC_EXT_IRQS 64 /* Versatile Express A9 development board */
+
 /* Number of virtio transports to create (0..8; limited by
  * number of available IRQ lines).
  */
@@ -241,6 +243,7 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
      */
     dev = qdev_new(privdev);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
+    qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, periphbase);
@@ -251,7 +254,7 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
      * external interrupts starting from 32 (because there
      * are internal interrupts 0..31).
      */
-    for (n = 0; n < 64; n++) {
+    for (n = 0; n < GIC_EXT_IRQS; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
@@ -543,7 +546,7 @@ static void vexpress_common_init(MachineState *machine)
     VexpressMachineClass *vmc = VEXPRESS_MACHINE_GET_CLASS(machine);
     VEDBoardInfo *daughterboard = vmc->daughterboard;
     DeviceState *dev, *sysctl, *pl041;
-    qemu_irq pic[64];
+    qemu_irq pic[GIC_EXT_IRQS];
     uint32_t sys_id;
     DriveInfo *dinfo;
     PFlashCFI01 *pflash0;
-- 
2.43.0


