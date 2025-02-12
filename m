Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E11FC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEuP-0004ip-OP; Wed, 12 Feb 2025 10:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEuM-0004h5-Iy
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:44:14 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEuK-0006yK-Sr
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:44:14 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38dd0dc21b2so2981266f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375050; x=1739979850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ToV0u5DP1HroTkKU9qlfVC69qypn9I2Owu2OBYKzM4=;
 b=ma81nPyhbvEZsE6X/Ol9x0JxdvtMOqlF/Zyxf2IpT2XW0Mk/ClxoZ38JNHSLzG2GvR
 x5F28FFJj+Co65ImoH0lZbHg6q+TbgICQCsL2FFJeYRL4K/YsITVCRVwfy1qf5QLVDvF
 dLeiGcE7TiOAkeQvG3qwduwYupiszTPlM/hCSvax7QTCjS+sKKspX31ZOum4ukqB1Q4G
 naYYGzO/HVQ0tPkmzuZV2yqAlGfyZCv5sY6xVKs25R9aNKjr9eJfqXDOsAOZlvunIO3q
 PnvI1p0ne+irUtDv6EfktbZHwIJHjay3MJYy2VBt4G8r1IBz2ZnWMhZsqiouJLfB4eek
 utjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375050; x=1739979850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ToV0u5DP1HroTkKU9qlfVC69qypn9I2Owu2OBYKzM4=;
 b=b/VsQ/zR4Mpuzk8+FBPdGRj8KHMyuRxt6q8wFswW1UX7P7qC8f4dpLKoRkurzf8HGf
 +yPb3S7Ke3RiywXJ2Fifmk+sati1NCI8BF/Sq777EbC8Wn+6yZ5bZW6C0hn6xeU6KHfJ
 ywAQcPESPbmE3Jvfzgf8Gg6ttWFudcuU+893CPsbeiqjlWCwk0FfBQJr/MoLlj++q29J
 Hh6Q49qEp2vydejJKnkIsBFSjwPt02HKDvMjLJATxgvbb4Ye0CcScW5q/12XVSoOvh65
 /dPMj7ZSQTlTPlVNDORyYGaCA8rpVeLJ/v2ejPLUBUn2hQj1eYR0b3XAWSwVwIpbL8rm
 qStQ==
X-Gm-Message-State: AOJu0Yw0Rg8LeUhzcwB61BHajc4h7/dvbOPo1CgpBEDRkCggIwktXuql
 w/cxUWhK/hFgLBS3yJ9RAJ8OlouOMLonsY1Ux2CbBU3RAULmvvmMgRxhw4d0zcmEXKsPf48SBJA
 jq8k=
X-Gm-Gg: ASbGncuKchJTD53a+pcWvKVVkjNvGwxKtakUd+a8SgKtyKdpv5T0czbBo0x7e4tuHtr
 XuwpNCG/yVfgwcntE5jKuGnmJkG0pdWs5umVky7eu2pSscVvb1ZapqNVGKgOatSGp6rRY+bFstI
 V/uNBYjJqexIACyYZhTbdD9J8VafADjm9EhQaeVt9qK4wJ9XotjelYO1iJtDLOfglip/eRjgAPt
 wmJiny/gsBXxfFsjBQZdc5ODlRAxWJq1mwjVebFd35Z/pNSKCJt7ehjKnaJCYqpLW9ocuctcobR
 Jv4ocyT5yBy7pabzW6S0KJ7oxXGlqfO4EyD/2M7hKZJgYmx+HkRY/MtInsHi3N+s51hogZk=
X-Google-Smtp-Source: AGHT+IEYmf0jrjgUwUDAsfolPQnImXWycIU5uNkq2nRizuac0O7Aor7xiDe1QsltIpiNeDcuv6GVow==
X-Received: by 2002:a05:6000:1541:b0:38d:b57e:71e0 with SMTP id
 ffacd0b85a97d-38dea250f4cmr2560745f8f.4.1739375050418; 
 Wed, 12 Feb 2025 07:44:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a0558e2sm23185625e9.11.2025.02.12.07.44.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 07:44:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/8] hw/arm/highbank: Specify explicitly the GIC has 128
 external IRQs
Date: Wed, 12 Feb 2025 16:43:32 +0100
Message-ID: <20250212154333.28644-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212154333.28644-1-philmd@linaro.org>
References: <20250212154333.28644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
IRQs, (see commit a32134aad89 "arm:make the number of GIC interrupts
configurable"), and Cortex-15MP to 128 (see commit  528622421eb
"hw/cpu/a15mpcore: Correct default value for num-irq").
The Caldexa Highbank board however expects a fixed set of 128
interrupts (see the fixed IRQ length when this board was added in
commit 2488514cef2 ("arm: SoC model for Calxeda Highbank"). Add the
GIC_EXT_IRQS definition (with a comment) to make that explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/highbank.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 495704d9726..0f3c207d548 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -45,7 +45,7 @@
 #define MVBAR_ADDR              0x200
 #define BOARD_SETUP_ADDR        (MVBAR_ADDR + 8 * sizeof(uint32_t))
 
-#define NIRQ_GIC                160
+#define GIC_EXT_IRQS            128 /* EnergyCore ECX-1000 & ECX-2000 */
 
 /* Board init.  */
 
@@ -180,7 +180,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
 {
     DeviceState *dev = NULL;
     SysBusDevice *busdev;
-    qemu_irq pic[128];
+    qemu_irq pic[GIC_EXT_IRQS];
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
     qemu_irq cpu_irq[4];
@@ -260,7 +260,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         break;
     }
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
-    qdev_prop_set_uint32(dev, "num-irq", NIRQ_GIC);
+    qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
@@ -271,7 +271,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         sysbus_connect_irq(busdev, n + 3 * smp_cpus, cpu_vfiq[n]);
     }
 
-    for (n = 0; n < 128; n++) {
+    for (n = 0; n < GIC_EXT_IRQS; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-- 
2.47.1


