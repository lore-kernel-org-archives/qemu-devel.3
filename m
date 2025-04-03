Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3F7C36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0USr-0005Au-4b; Thu, 03 Apr 2025 19:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USo-0004zT-F1
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USm-0002Wr-Ot
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so9568595e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724751; x=1744329551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nk82sPbCU65CifIvDQtlnTBY33DI4NNrcma392a9X2I=;
 b=EpY5f3QKztiMzv1OrBUkqE4oJ4K/JXnFh9618xZdoiozzghAHw+Kv+BMRBftXQLBev
 su2B74bS0pGt80iIciyOGxfbpA4n9bYK53vT+U76tMAzGukBCJiAoSzrcn1+3WRmGYCn
 92F8zhM86KHj/9jCN9nulcPaGUbV+9Vxj6pX7yy8OLRL2fAUC90nSw7zZWBpKQBq0K1I
 SoYn/1UVhzsLWt/2sVXq1a1jgIl9m+6UttdGLiYCcdSBM+OPtrmKrkTKCpla2+meZNot
 IVnco3VlVFZCaVomgy9xuTp862KO1LWUL57JHTO5PfiZlKj53Fk5AW2Xpky5wKadX8G8
 kchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724751; x=1744329551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nk82sPbCU65CifIvDQtlnTBY33DI4NNrcma392a9X2I=;
 b=NHo0XUTieRqYCDcNOgKM5pnCuwpwwfg5QEMwJLXUQfBv9payknkqTptwZgsrz/HZzZ
 1wRzCEPITNDHq/BsXLRtDhJ2sthGeu098BfTxQaeQh5cmc39craWRUAF/cZnbaTc8rA6
 xA/hhkNs0U6jqppPJe4Ay7g6dtNvD3TH9IG1iD+FmuOWabxjkNE7/S1+riDQpvhePXq/
 p9fzmKUhczZAtG8gu4N4RtiUx0DA5pxocmSJn85x7Aym61lvWm3Ri7K0QNrTvgSOOOSR
 FBTz8a8a8k/Tca5JmeNDn3gvHqfbeyIhoktHaB4PtnhFKhClG1eWwqae3I4NDYEFuHnQ
 VzYg==
X-Gm-Message-State: AOJu0YzY0FsevxcPEt/K+HSdTNWRtK+Z7fO0qW9/ZhBb1EgBtxl6+kfh
 zq9rsEmminTZARxDH4AcLKSQRsF79Rhj+X1tC7VIaGuzNJvPxnR/RsrpRYSe1ytKy2bCBHYpSAm
 T
X-Gm-Gg: ASbGnctIOkX3/GFGdByAA/sM1iAHSymPg1uFr7HThDHHQneD/g3o0MjOR5HsSeXu8Bz
 J6sgS/EjXRewBmaNakdw6YIF1AGlW8vM9n7v6ymbfiMQ7iqwDvHZARQUFkWtqG3tVXKfZ4yszZM
 ua7SOIxAsB18djsRxzrDPna9T81RgTq3ivIaheglxnIpoPXIio5c6lFQu42Vp2V/ZD+ho40d+7X
 Kq5t0p4md/3zSWjA1liWMcxaTH2FYeTwbKr/W8WHOlmgLj1qhdtAPaCb7EvFw9lUi2SgzBp1I8e
 X9gZ/1UgC4L3u5aChCxsgy7rgfkd9A7ZPk8NE6rMHwNTPT4QSLbPhexqSZC2uRv9cj4G3qyk/eL
 YN7NyKJad5OpYG9VKNKI=
X-Google-Smtp-Source: AGHT+IEGZvrxJykkSwIdunXj+T/NlWrZAKhyYGBgipK/+Idqxz2mL3v78Fr9HlnnxbXWC7ZEFcqCSg==
X-Received: by 2002:a05:600c:5843:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-43ed0f87ebfmr4271615e9.18.1743724750878; 
 Thu, 03 Apr 2025 16:59:10 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec36691b3sm31259035e9.34.2025.04.03.16.59.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:59:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 07/39] hw/arm/raspi: Filter machine types for
 binary
Date: Fri,  4 Apr 2025 01:57:49 +0200
Message-ID: <20250403235821.9909-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/bcm2836.c | 4 ----
 hw/arm/raspi.c   | 9 +++++----
 hw/arm/raspi4b.c | 1 +
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 95e16806fa1..7dd81e8e0f9 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -195,7 +195,6 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
     dc->realize = bcm2836_realize;
 };
 
-#ifdef TARGET_AARCH64
 static void bcm2837_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -208,7 +207,6 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
     bc->clusterid = 0x0;
     dc->realize = bcm2836_realize;
 };
-#endif
 
 static const TypeInfo bcm283x_types[] = {
     {
@@ -219,12 +217,10 @@ static const TypeInfo bcm283x_types[] = {
         .name           = TYPE_BCM2836,
         .parent         = TYPE_BCM283X,
         .class_init     = bcm2836_class_init,
-#ifdef TARGET_AARCH64
     }, {
         .name           = TYPE_BCM2837,
         .parent         = TYPE_BCM283X,
         .class_init     = bcm2837_class_init,
-#endif
     }, {
         .name           = TYPE_BCM283X,
         .parent         = TYPE_BCM283X_BASE,
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index dce35ca11aa..b049c6035d4 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -367,7 +367,6 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
     raspi_machine_class_init(mc, rmc->board_rev);
 };
 
-#ifdef TARGET_AARCH64
 static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -387,31 +386,33 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     rmc->board_rev = 0xa02082;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
-#endif /* TARGET_AARCH64 */
 
 static const TypeInfo raspi_machine_types[] = {
     {
         .name           = MACHINE_TYPE_NAME("raspi0"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi0_machine_class_init,
+        .interfaces     = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi1ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi1ap_machine_class_init,
+        .interfaces     = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
-#ifdef TARGET_AARCH64
+        .interfaces     = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
+        .interfaces     = LEGACY_BINARY_QEMU_SYSTEM_AARCH64_INTERFACE,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
-#endif
+        .interfaces     = LEGACY_BINARY_QEMU_SYSTEM_AARCH64_INTERFACE,
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index f6de103a3e1..12c7ed42ced 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -127,6 +127,7 @@ static const TypeInfo raspi4b_machine_type = {
     .parent         = TYPE_RASPI_BASE_MACHINE,
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
+    .interfaces     = LEGACY_BINARY_QEMU_SYSTEM_AARCH64_INTERFACE,
 };
 
 static void raspi4b_machine_register_type(void)
-- 
2.47.1


