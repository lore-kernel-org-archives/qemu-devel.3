Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D68C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9J9-000709-V8; Thu, 20 Feb 2025 11:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J8-0006tf-7s
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:50 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J6-0008DB-Kx
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:49 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43937cf2131so8106425e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068507; x=1740673307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zk2Wwmj50vab5H1dzXTziBrSoLjKSd8C4jY0u7/h7Jk=;
 b=Y/FH3fcg+ZbQbkL2gUlSsC9tkK62oy7O1hYPUD5O+j7CKXxXOhRD5LmPe0gRJF7I09
 XHbGhwi8Mwz1e40wvv39yQd21EL2e8ySlSmBPR1YZyA+fS2mEsNivleRhIcKl5W3wECi
 vCp7O2yTasTSFZu7/4HdD4akokFbEy+pSeS4z64qu8cqJuOem8EFW2A3nbePbIvfdP4O
 KN24C1D3wWeDPRBll1Oorc4IsOxSSlR/oAg5qd5gFv3vgJRuOkJl8V8Hdwc15X3uLF6B
 uEhOu+6x2jr/jxb+UB+LxuBimHV3dPkO8uBjCR+ntrrUOO+p4cSspIEBXzx0VKKTFYvY
 WWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068507; x=1740673307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zk2Wwmj50vab5H1dzXTziBrSoLjKSd8C4jY0u7/h7Jk=;
 b=UVDhyzG6h4Fk9kZSQLLTElawPCOqMFqYcOAQGgZqNzTk9UZFVAl6my4/GrbQzy0J7o
 9hErLRzbFzjUlx4duABLku/2er/Bs9uiqkadLSfToLB/eUgJ8KIzMFpCWMmGIEa5wF7Q
 1mdYRQP/4ckTdT3uaiINMLLJDkPDwZhqgghFzWM1kDfKuvXISWeKtrQyleun81HUP20F
 TcCHjQxXKTPmHUp8wE9MCQTHnr4xxSOObY3q6ilwDXog8G1CywZGSZgWcKAHB2ZCfRdY
 UCoUbbarsFP+gOXNzRNYRInYW3exw9eY/e+jlkFzsvJagQxviYlTuhvFutmxFSgXo3cY
 utsg==
X-Gm-Message-State: AOJu0Yx/iiyZQh0hsPk29lwJhLjkimC24Kj6zohCipsIOSaVsyvcUgp4
 Rs9MbeTo0EANh2ZRNMpQIS1SSm0X/68aOu3d3CACfRk8wtVyKeQ3w1OcAE00F/n7VXWBF1LGAfn
 J
X-Gm-Gg: ASbGncv7Ow7e42fPjM0da1pe9o9QxlfwCzwNH97ZkclFpFuucBSs1CHk+9OmpUViCw1
 77VKeg0yF94iHbeZZ5WwHQ74XRbNhW0Cb24Q8ZOOlaM25yoXSwp9YqhiGwLicuiaiXr4uKUL26X
 9uD787a9R+P+eyC7/lbssUAKIjrVjJkGILfMXe/x1n+z4rwDcc7/yZcb39Ugb0GxORrgXyPHWNY
 Wo3uupWfmTvsAKQ+IarTuHOaB7dihS2ThOxy4I2mrxrTPacbybXtOHXyCGe/UCFaYCrX67CEeIp
 GIMcMQ9RjDiPOzV8QaI2dQ==
X-Google-Smtp-Source: AGHT+IG+KQerkKSmFYWIzUk7v9AemI0FugGSWJgPmR5TKaBvnNx8C9doghAMmt8Db/Ic8AA9BXVHYg==
X-Received: by 2002:a05:600c:4510:b0:439:a25b:e7d3 with SMTP id
 5b1f17b1804b1-439a4ac4534mr31066075e9.14.1740068507203; 
 Thu, 20 Feb 2025 08:21:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/41] hw/arm/realview: Specify explicitly the GIC has 64
 external IRQs
Date: Thu, 20 Feb 2025 16:20:58 +0000
Message-ID: <20250220162123.626941-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
IRQs (see commit a32134aad89 "arm:make the number of GIC interrupts
configurable"). Add the GIC_EXT_IRQS definition (with a comment)
to make that explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250212154333.28644-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/realview.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 436eef816ed..008eeaf049a 100644
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
2.43.0


