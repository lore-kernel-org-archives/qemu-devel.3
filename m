Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE1FC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEuK-0004e8-4p; Wed, 12 Feb 2025 10:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEuE-0004W7-Pz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:44:08 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEuC-0006wW-Ac
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:44:06 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4395817a7f2so7664505e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375040; x=1739979840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKFgzzj/z0innOIGEpKf0ZON0tQHn0YVUlggdFE5dm8=;
 b=slQiwaCWvUdLyJOvJFYQuqL8XKe1FwEDtmCRehtMgUhqVnOJC9dqvNA/J2jsO+q0dF
 uDq1E2u/UfV+lrAg+AElPf27kbc0S+SnXThrLIL2HxI+9t4GdAvOTtvGSmCVRZRP99Dd
 atHw4UuKAMl+kAp89d0XB1bLeFDrFpIYlx3LaVgnxVhxQGI8T4rQ5TTGiHiUZO6NJihZ
 NL99KhCoeqwcgbC8yKwWen5KFOYLiimVlzw/3yT3BylDLghkNyB4QXRmTuOknzaD9HMK
 Q9rhs8a0cVafFRkmkGBogS1grIWCYjuj9bBom6a0sZqalsskdb9SFgJBdDGLKsvaLSYH
 WTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375040; x=1739979840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKFgzzj/z0innOIGEpKf0ZON0tQHn0YVUlggdFE5dm8=;
 b=V0amDbPPqfiH6ngMmhf/9dAqhNQjLEsyNCacM2LVEwcSXY+5kwPJHm5AxcKXUx4uEE
 66oU5eunjmlOP34v4I5N/BkGcy60YQsRgHOv6e38HVSF3pexPOigWdrfE6uGLpyw74qa
 QkJGhIZbc3vc6XVx/VPfj0+0agnPpcXrP9q0xrUG1iEeotVnLctBQNYGCXsCUrKKwoXA
 entFwpD7got01wkMLu4UotoxHsPcIZKqfK3as8AvuC9lUbDq+uN4+FpRJ2vksrrRvSKu
 YbTWLd5NLQiMSMRZbhPcue6THMA3xP+JhhI59GHQ71J4/oYfgRMVfuSgSUNJwDK1El3y
 0tFQ==
X-Gm-Message-State: AOJu0Ywx3dpkR+XaVePJ4kHS27bJuXpzbGicPXYeafjAklnoqRpLoMGo
 IjsFPEBWV1J1iLqWxANOcgjQ+hIjxvYT9SLbfbBQIDanOMMEJA9TmI0eG4j7cD5tnfXSNmOy2Tg
 iJd8=
X-Gm-Gg: ASbGncskhcTs7VnjQvgiKPzKwewSua0QP3XICLd1xYzaChDqGESFjpp05pBRekHVgtf
 /+C44zCG2f14sFj8TO/g5RNZiFfw+LAJUJr5F/NpG9CdWzd89RYMgaAkOM9SSV7VEiONv5uqBH9
 SLsTezzx/583wHAbcbqrAd+UseFz/Sh5wmBjBYl5qDScYBuU5UJrD9XSL2dRWZhDCpBOpkewZgJ
 ocwvFpyhrCtiR9hQEGiaKK7W8b9UKide5S39xOaXts255FIY/DsZjyCVvGgaH1vaFIBPfBKhnX/
 owTyQ4W8XWq6yE+SbNZlCXAwT9irPH+AaSE5W4ssonqQ3tHB7FCXc+gCnwsBbUpFhjxIg6s=
X-Google-Smtp-Source: AGHT+IGhG2ikBiSKu7kkvwpVbVrk5BczJ6YcTzx8rJIjvRK12+0KbdSgE4CWvdsiAoQ7QBnboWhVJw==
X-Received: by 2002:a05:6000:d83:b0:38d:a879:4778 with SMTP id
 ffacd0b85a97d-38dea286d93mr3133322f8f.33.1739375040517; 
 Wed, 12 Feb 2025 07:44:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04cd53sm23549755e9.6.2025.02.12.07.43.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 07:43:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/8] hw/arm/xilinx_zynq: Specify explicitly the GIC has 64
 external IRQs
Date: Wed, 12 Feb 2025 16:43:30 +0100
Message-ID: <20250212154333.28644-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212154333.28644-1-philmd@linaro.org>
References: <20250212154333.28644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Looking at the Zynq 7000 SoC Technical Reference Manual (UG585 v1.14)
on Appendix A: Register Details, the mpcore Interrupt Controller Type
Register (ICDICTR) has the IT_Lines_Number field read-only with value
0x2, described as:

  IT_Lines_Number

          b00010 = the distributor provides 96 interrupts,
                   64 external interrupt lines.

Add a GIC_EXT_IRQS definition (with a comment) to make the number of
GIC external IRQs explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xilinx_zynq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 18051458945..3d7c4f04974 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -57,6 +57,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
 #define MPCORE_PERIPHBASE 0xF8F00000
 #define ZYNQ_BOARD_MIDR 0x413FC090
 
+#define GIC_EXT_IRQS 64 /* Zynq 7000 SoC */
+
 static const int dma_irqs[8] = {
     46, 47, 48, 49, 72, 73, 74, 75
 };
@@ -205,7 +207,7 @@ static void zynq_init(MachineState *machine)
     MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
     DeviceState *dev, *slcr;
     SysBusDevice *busdev;
-    qemu_irq pic[64];
+    qemu_irq pic[GIC_EXT_IRQS];
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
 
@@ -261,6 +263,7 @@ static void zynq_init(MachineState *machine)
 
     dev = qdev_new(TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
+    qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
@@ -275,7 +278,7 @@ static void zynq_init(MachineState *machine)
                            qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
     }
 
-    for (n = 0; n < 64; n++) {
+    for (n = 0; n < GIC_EXT_IRQS; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
@@ -458,7 +461,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     };
     MachineClass *mc = MACHINE_CLASS(oc);
     ObjectProperty *prop;
-    mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
+    mc->desc = "Xilinx Zynq 7000 Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
     mc->max_cpus = ZYNQ_MAX_CPUS;
     mc->no_sdcard = 1;
-- 
2.47.1


