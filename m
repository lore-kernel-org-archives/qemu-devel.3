Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923F9C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6P0-0003oe-PT; Tue, 25 Mar 2025 11:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6Oy-0003o2-4x
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6Ou-00046l-FL
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so53877155e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742917270; x=1743522070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9EcvePMMiziHxvQ+1Uv0hWd3cavq64til709QLPVTs=;
 b=Gt4d5ZxdsOyWr5a01vlFwq9CFfwHxjTGoDXCLshNR2/whoLCc4pKLLOUs+zrDl1Aa2
 AkbyLhd305lpxVoyeYazb9C0I2SNUnuh0zmIvii/kVNkbhGiRx/tCCcBWP6yPNfkJAuW
 4zc/cmi9tXnMBRRIMxMQnusX0xo1NbyIaX+8B19GrPgU7kDIi7MqnLmBB+R4ToHaDmn9
 6jrIHWlsyf0sr8OCWv/kXcxIzY9l3lx5NGacS8JD8LnmBFzGmqV3fKelOAwzw4ssaza1
 267RMHMht7sgQIlKKBx3E8pxM1Zlo1xpCYXuGCXnb5Fp4eKfQcqFJIM6ozvrgHUqHFRx
 qEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742917270; x=1743522070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9EcvePMMiziHxvQ+1Uv0hWd3cavq64til709QLPVTs=;
 b=ne+AKGyjAktMHpK+dPfOL9GtI9nrZ0RPW1TmmM3MYE71pvRzLqdbO+J88Blm/6x1wa
 LEdbkMTIlH1ffT71jbeHqNiRlpMa0aFxF4S9KDApAjSjpimmeU71ljSQBUTAJdT5XoEq
 vOOEd/s3nuy5ESIizYsdF9HGmYy8abDECobbzRcsvo/s2mSAG054Ne6w98XzBq4o1l4m
 9ro9cbg2be95F9128Udk3MayVQTV5JPYOXlHZT8tSreUNSW0k79o1PxE+wsyQd2hqNI5
 psYRX2MEcnju7r6keSv7el8U0Xsa2C90aIfEaugMaV4zzmJOS30tdlv3hAPxw8hrWD9R
 HnPA==
X-Gm-Message-State: AOJu0YyUIccSL1zl0ZAnidbJVM4eKgTexz9tRghJDerjdb8dxn0cj5Fr
 TOCqQhI95+Qmlh1CGRropwXmd9HUIcvc74sMOOzs0XHBsl1CMiOTpjqmMXy5r5E66E4PXuIL5MK
 8
X-Gm-Gg: ASbGncvUB/a+y/tnDyYah6msT52NCnGaLkMDDl7vqV3lXSxE3i3nY2CVXOoxxsCY5Um
 wOjasAhJ6WbJ3SCZjT8/5eN2yIrjkIoE1FXEgQdE58HKLEEo6R0Kp170CxkTN+2m57ZrZhseSWq
 ig9XYVH2lJoKxO0hoBZDPKOSAgj0Njk8DJFVaUU6lgb3c6CQluHGM/P+D8sbLj3PNGz4GqOA2Gu
 sDruj/514l/kZtfEtdoPJr5eTQpzdUrI0kfR/MEE1yZ/OCPaEoZdz5j2wlR9vbEPdW4R8i1dDIh
 tqyzuHQ0/y/DhS4AtunK15dbBOBsnhH0BfV7jUM84MQiyqXU9EY3v4uz2QuanzGTgWNEkvW2QKS
 VqV4JIDq1eO0cd+dXQ9g=
X-Google-Smtp-Source: AGHT+IFVn8V1/KX8LHz5TKfTH3Bq1V1p3NnDxQEWWA7VWJ3gnAhAlsXB06IaaBMapFZmlBoN0CetNw==
X-Received: by 2002:a05:6000:4188:b0:391:487f:27e7 with SMTP id
 ffacd0b85a97d-3997f947b9dmr11810016f8f.55.1742917270166; 
 Tue, 25 Mar 2025 08:41:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9955c0sm13861946f8f.3.2025.03.25.08.41.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 08:41:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.1 2/8] target/mips: Declare CPU QOM types using
 DEFINE_TYPES() macro
Date: Tue, 25 Mar 2025 16:40:52 +0100
Message-ID: <20250325154058.92735-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325154058.92735-1-philmd@linaro.org>
References: <20250325154058.92735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

In few commits we are going to add more types, so replace
the type_register_static() to ease further reviews.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index b207106dd79..097554fd8ae 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -597,17 +597,21 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
 #endif /* CONFIG_TCG */
 }
 
-static const TypeInfo mips_cpu_type_info = {
-    .name = TYPE_MIPS_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(MIPSCPU),
-    .instance_align = __alignof(MIPSCPU),
-    .instance_init = mips_cpu_initfn,
-    .abstract = true,
-    .class_size = sizeof(MIPSCPUClass),
-    .class_init = mips_cpu_class_init,
+static const TypeInfo mips_cpu_types[] = {
+    {
+        .name           = TYPE_MIPS_CPU,
+        .parent         = TYPE_CPU,
+        .instance_size  = sizeof(MIPSCPU),
+        .instance_align = __alignof(MIPSCPU),
+        .instance_init  = mips_cpu_initfn,
+        .abstract       = true,
+        .class_size     = sizeof(MIPSCPUClass),
+        .class_init     = mips_cpu_class_init,
+    }
 };
 
+DEFINE_TYPES(mips_cpu_types)
+
 static void mips_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
     MIPSCPUClass *mcc = MIPS_CPU_CLASS(oc);
@@ -632,7 +636,6 @@ static void mips_cpu_register_types(void)
 {
     int i;
 
-    type_register_static(&mips_cpu_type_info);
     for (i = 0; i < mips_defs_number; i++) {
         mips_register_cpudef_type(&mips_defs[i]);
     }
-- 
2.47.1


