Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B576DC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JE-000756-7X; Thu, 20 Feb 2025 11:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JC-000734-OE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:54 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JA-0008E0-WE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:54 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f2cb1ba55so925909f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068511; x=1740673311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=opo/VbCWAt6C9nedTKj6phlEP8OT20gT2thgOlL0CK8=;
 b=AiEcP6hvs4ErkKNHAM6RNOj80kX+M+Weczi9O2+u0xWzGLNpPC/HhpHQ07aP915sAQ
 pVYEgWXDStjsfyRGn3BypfkTsX93w8BMVAIf8IJTnRCtc/AaeDo9eum2ObHB3PI4yGPz
 PIWNh4VyeNTWLzSlg5x+9oGChDnhZnyJPhcKKp2d79B+gERsH/7XguLwBmxLW4hTOVzj
 RM4kZTE83z7Zd1HUl9Fecy15tqQ93sps6dWiVvroRxZHAxJFnBVWD4RX+vYSQOGv7XMR
 FN+6tWG7r/CPz1XFVUtAVPa4c/KhKdtaiHEE+J6fsWJNUwzdOXDX6nKfBVD8mrEI+Fv4
 yKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068511; x=1740673311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opo/VbCWAt6C9nedTKj6phlEP8OT20gT2thgOlL0CK8=;
 b=F2D1W2PULFPqxbtFOf+rTR6Ke5reRoyNZ5T4SGNX7eml1UbfUNE5MpA8R7nc95io0I
 pzOB83cIWgHTAMhOb/Y2RyIW0ulsr517Mqx2Z1s1lezv00cS/Li6bjr0S23Lt5urxAGP
 F9S4rZFlu7VZ06Ai9Q+944Ng1mdvg8gHKYsbP0QPXtjHb/m0udviOoCR637DLOPa+p7d
 QJeH777msmguNyrs+8E/R4XKVGhSPXGOcM7wz+IWDd7HRuArAQ0TcBa3qBCDTt+z4zsI
 djvWPKWUBeJkfl1zC43hSDoDJ62CdaIAAB7w7RQGKDfI48kgf7NQAV8puOxLdMe9Wjjs
 r5/Q==
X-Gm-Message-State: AOJu0YxXYVBg59wq4oAH9zKJ2EVF6rqXBJrpohvv36oj2ZyR/6qyP9f5
 8n4NTFx0KhpEtTlUSZXhSuuYuvkdnZ7Zl8dl16Y2aLPbFCTDKlj1PY0rK/x9i2kVtcQ8XkIvxa+
 v
X-Gm-Gg: ASbGncvcMjNj27KS066/UbR/W8lcUMKoaHWv6ziRifrHWQ5b2n9HdTMOXSQ5KNb0Ir6
 gkBlXuWDJZ6iZ22aY6pDgywwey6ZLR44gmVtACulmYr0E5UvrEFWE8xzOMvmWk464Vb9bPFaPqF
 0BfKu6rVMxSnRKVvUWxI9s+yC/JXcLVkDTc3wXWV0kagP2ERgfCySwdDFsqC2ACAsvwa4cInzbS
 U/ji9wgLwe/dCbR4jpqb33sMenPh7xdj9O2rHrnYXrMQ++YyRd90TqU2PlIYU11kFP3zTkRif0U
 F0W8fim/NYY+waJLnbodXg==
X-Google-Smtp-Source: AGHT+IEVYP+L2Tqrx++zuMfZ6tyhHK1j13yMBg3Dj4x3f+t544W2snF7w5+DPMAx0u8MHVWiG9/0Ug==
X-Received: by 2002:a5d:6c68:0:b0:38f:4acd:975c with SMTP id
 ffacd0b85a97d-38f58795a45mr8216866f8f.27.1740068511263; 
 Thu, 20 Feb 2025 08:21:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/41] hw/arm/highbank: Specify explicitly the GIC has 128
 external IRQs
Date: Thu, 20 Feb 2025 16:21:02 +0000
Message-ID: <20250220162123.626941-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
The Caldexa Highbank board however expects a fixed set of 128
interrupts (see the fixed IRQ length when this board was added in
commit 2488514cef2 ("arm: SoC model for Calxeda Highbank"). Add the
GIC_EXT_IRQS definition (with a comment) to make that explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250212154333.28644-8-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


