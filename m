Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32183C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPa0-00076R-BT; Tue, 23 Jan 2024 17:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPZz-00075u-0u
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:49:15 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPZw-0004NV-Uv
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:49:14 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e7065b692so52804615e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706050151; x=1706654951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVA2TB5jlLxfwdfpPKM9Ir1x2nVtKMiRhoeFlp+qdMA=;
 b=p/CCwyenYnj4u7HsD86X/w8RptMN69gzHA+23yrUfVMH3Cj+xcJjbTK9DzbJjEK0Cq
 zhyzAmGhRNoHSuho7664bkH2MVwpx+TUaEhAXz2TmYPaPCZi0XELlu1gHIPf3XBZXpmE
 W3ridjtMeK8LURQ832K9HgpmtKexMHGJDjtB77OVgrgTXhjRBVcGW5qeomuXrc0d0TEp
 Zs/NYXV0pnqXUjSuaOTtatpXxI1vppVywNJe1Ccq0S0Ailkf011gJmmfQLUfOP6i4j4W
 AIW7XKcyUg3G3sj5PLOQIhZp0Jpj5XZoVCUR9+hzjZ2qdK7+swJDnhQU9eM+zYbbyt1h
 9M1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706050151; x=1706654951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVA2TB5jlLxfwdfpPKM9Ir1x2nVtKMiRhoeFlp+qdMA=;
 b=JG0pZx3l/Zqhrr9K/AL8H6RyERApkq+EMtLQeBWcDdlHkB1jxTyJUSz8ce7sAl1yWE
 4aNrf+oCfFcjfb/lGGeRf3ktpvchB/+2KIhlfbIQ6zbQbEpzLN3fVuHlPadrlLlcQe82
 S0pe/ez1abcQtaFCOeR7eN5//vWhXHoXkzBInYb5tx6pAn+Hgvt3/6XIIo23M17/tZr0
 eSP9gsNiMqUKynzQQ/jBOU5QQ4hQfgdg0DhEMaPtgqhavx7EbPTjdS0HITZpD043MaJv
 hs9aexmapUaW5ifbhiZic3Hw2QIjJfi1FGcyuKlanqCMg8YYZXdU5qMWzcJrfZ9Yvbmq
 Xu8Q==
X-Gm-Message-State: AOJu0YyFeoueB6qGpm0n9Tbfju4tmYN0STSEjgtjL2VGtYfpxOgVc1WH
 ekPVRL6Ew96cZuZC+EnlLAo3vhFjikGxYr7RTr1gezZbrbyc/2sHb1EjhTWp38FfBVsP6sXpk3T
 V
X-Google-Smtp-Source: AGHT+IGt72FO/G46G1DIXbue0X02VFGreSB9BCCHLahtHxKVu8ksOxv+ZAigbr2GBriKegwIyWUlqA==
X-Received: by 2002:a05:600c:4750:b0:40e:bfbf:f332 with SMTP id
 w16-20020a05600c475000b0040ebfbff332mr540385wmo.27.1706050151410; 
 Tue, 23 Jan 2024 14:49:11 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c4ece00b0040ebf340759sm3043862wmq.21.2024.01.23.14.49.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 14:49:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/5] hw/arm/aspeed: Check for CPU types in
 machine_run_board_init()
Date: Tue, 23 Jan 2024 23:48:42 +0100
Message-ID: <20240123224842.18485-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240123224842.18485-1-philmd@linaro.org>
References: <20240123224842.18485-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Aspeed SoCs use a single CPU type (set as AspeedSoCClass::cpu_type).
Convert it to a NULL-terminated array (of a single non-NULL element).

Set MachineClass::valid_cpu_types[] to use the common machine code
to provide hints when the requested CPU is invalid (see commit
e702cbc19e ("machine: Improve is_cpu_type_supported()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  3 ++-
 hw/arm/aspeed.c             |  1 +
 hw/arm/aspeed_ast10x0.c     |  6 +++++-
 hw/arm/aspeed_ast2400.c     | 12 ++++++++++--
 hw/arm/aspeed_ast2600.c     |  6 +++++-
 hw/arm/aspeed_soc_common.c  |  5 ++++-
 6 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index a060a59918..0db5a41e71 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -128,7 +128,8 @@ struct AspeedSoCClass {
     DeviceClass parent_class;
 
     const char *name;
-    const char *cpu_type;
+    /** valid_cpu_types: NULL terminated array of a single CPU type. */
+    const char * const *valid_cpu_types;
     uint32_t silicon_rev;
     uint64_t sram_size;
     uint64_t secsram_size;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 636a6269aa..1be3b6bcae 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1149,6 +1149,7 @@ static void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
     mc->default_cpus = mc->min_cpus
                      = mc->max_cpus
                      = sc->num_cpus;
+    mc->valid_cpu_types = sc->valid_cpu_types;
 }
 
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index dca601a3f9..c3b5116a6a 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -417,13 +417,17 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
 
 static void aspeed_soc_ast1030_class_init(ObjectClass *klass, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */
+        NULL
+    };
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
 
     dc->realize = aspeed_soc_ast1030_realize;
 
     sc->name = "ast1030-a1";
-    sc->cpu_type = ARM_CPU_TYPE_NAME("cortex-m4"); /* TODO cortex-m4f */
+    sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev = AST1030_A1_SILICON_REV;
     sc->sram_size = 0xc0000;
     sc->secsram_size = 0x40000; /* 256 * KiB */
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 3baf95916d..8829561bb6 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -503,6 +503,10 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
 
 static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("arm926"),
+        NULL
+    };
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -511,7 +515,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
 
     sc->name         = "ast2400-a1";
-    sc->cpu_type     = ARM_CPU_TYPE_NAME("arm926");
+    sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2400_A1_SILICON_REV;
     sc->sram_size    = 0x8000;
     sc->spis_num     = 1;
@@ -527,6 +531,10 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
 
 static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("arm1176"),
+        NULL
+    };
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -535,7 +543,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
 
     sc->name         = "ast2500-a1";
-    sc->cpu_type     = ARM_CPU_TYPE_NAME("arm1176");
+    sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2500_A1_SILICON_REV;
     sc->sram_size    = 0x9000;
     sc->spis_num     = 2;
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index b264433cf0..46baba0e41 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -629,13 +629,17 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
 static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a7"),
+        NULL
+    };
     DeviceClass *dc = DEVICE_CLASS(oc);
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
 
     dc->realize      = aspeed_soc_ast2600_realize;
 
     sc->name         = "ast2600-a3";
-    sc->cpu_type     = ARM_CPU_TYPE_NAME("cortex-a7");
+    sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2600_A3_SILICON_REV;
     sc->sram_size    = 0x16400;
     sc->spis_num     = 2;
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 36ca189ce9..123a0c432c 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -20,7 +20,10 @@
 
 const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
 {
-    return sc->cpu_type;
+    assert(sc->valid_cpu_types);
+    assert(sc->valid_cpu_types[0]);
+    assert(!sc->valid_cpu_types[1]);
+    return sc->valid_cpu_types[0];
 }
 
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev)
-- 
2.41.0


