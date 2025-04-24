Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8F7C369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 19:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u82Zk-0003Ix-Ba; Thu, 24 Apr 2025 15:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u82Zg-0003I2-1y
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:49:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u82Zd-0001QD-Rq
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:49:31 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso10196815e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745524168; x=1746128968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6MHsagVrqyo1MkchqPZdtIsPpAZ18U1GCmD5yai5a4k=;
 b=yLq4DvyNRlE9eL1056Tz8NP8LzYxWIvguw9LdaMjMAkuhpoAT0uD/VWb8r3huxNbmH
 9Hwq5rMqg5LZxlbAVsxz0ZO5UJ9xRYC4hZMDrYoc2jHOTOpi1Oq+jOGRpaVvJiTWxQwN
 tNKSWqa3NOJN3aTp+7JqM34dBJqgWuMDqNG2/CqUrcCDeBePunjJ8W8nd1OCrM7QYWvA
 UkyLQhRGdt5lAhQuV7/58R4gNPgjFag+Ub1D4MkG9VlzQZ7tHrePvXuBh0lHuiaiCpxB
 fRNjRgzmD6Y6IvdswLenvM33/BuBPfYCsmqbUfezWw45nC8bZ9MpTDtpgwzQlfe9aP66
 UL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745524168; x=1746128968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6MHsagVrqyo1MkchqPZdtIsPpAZ18U1GCmD5yai5a4k=;
 b=vIE5zfGZK6b9X5kr61hjlMAa5ndYEFG3QEoXntOiCbi8srijWqytWUds8CdGsVMKd/
 7VbF1SO/5pdjSobo+ekA92DI9mLTe6rdPknQusajqgd3dCv26YxRyN7SH+3FJhnrKaoQ
 XU+3ZrOk8yDX/P+kPsMNvG8mweCcTLQ+ooQJkvIQCaiDfjQYGOhdvrURANcJcBZ6s0Kq
 +0qrPTgUIazJTcAFBtQAaSEMCG+gY+pqdQVNMYQA9IJVJARs9qVAJFhGV0eQuzB6F6G5
 54/cx79SciLMKBQZFz9pNEAeCoxjQ1WQV5WxgAg7Z295VCcy5NW0qyXA2ZVvQLUJ53Bx
 p5GQ==
X-Gm-Message-State: AOJu0YywITomRZIyzhA041X49OXf3pfJ1XZm4CrRMSZLPOPnR3SLKb7N
 lySU+oQ6V2M148yER4Yoy66Sk1F+m5awA8vu9r0Exgv8XcCzVMGy15thKUw4cjZofDop+khzUcn
 p
X-Gm-Gg: ASbGnct+Xd5ZRj93CLwrVjzYjasDEw/9uG9Rn87udNUIslcvWS8OCQ98z+9OV4rVS66
 FpWS3+8X8/DUXqTH8f8SY33P9wm70VM9vr/BnPWGORu/Unx/1fiykVKZRHX5DnLuJsS4ROt0wFZ
 1OHvUVbHrHtWjKno3FxZFlgvaRIqhswmi+lFfUHROuvSJEKDUQL3vFcRWXZxcK2cth80evbOihi
 3c18V0f0fwmEMkh9RH96slB/PdxATJPZQUR3O7to0+KGzK81akDZkb+W7c0p/gk7rUj0CyGwi27
 aSt/wkz1ZdwF0jbExOE5MsDTjKT21rxzzz1BNrZfS4pBEsoFmnjY89f9YxiwX9nvC0EgKbSV+Fv
 /tSss2G+GFJd6SLU=
X-Google-Smtp-Source: AGHT+IHSOMJ/QEwBXAbpz9Fk2ODvHU1Wrp7V/XegSmabxshThE2T54loRR7urG5gADUYz9DQcDWtfg==
X-Received: by 2002:a05:600c:4454:b0:43c:f597:d584 with SMTP id
 5b1f17b1804b1-440a31c1491mr6558585e9.29.1745524167923; 
 Thu, 24 Apr 2025 12:49:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2b892asm31738175e9.32.2025.04.24.12.49.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 12:49:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 4/6] qom: Constify TypeInfo::class_data
Date: Thu, 24 Apr 2025 21:49:03 +0200
Message-ID: <20250424194905.82506-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424194905.82506-1-philmd@linaro.org>
References: <20250424194905.82506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

All callers now correctly expect a const class data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/object.h                                | 2 +-
 hw/arm/armsse.c                                     | 2 +-
 hw/block/m25p80.c                                   | 2 +-
 hw/isa/vt82c686.c                                   | 4 ++--
 hw/net/e1000.c                                      | 2 +-
 hw/ppc/spapr_cpu_core.c                             | 2 +-
 hw/scsi/megasas.c                                   | 2 +-
 hw/sensor/tmp421.c                                  | 2 +-
 hw/virtio/virtio-pci.c                              | 4 ++--
 qom/object.c                                        | 2 +-
 target/arm/cpu.c                                    | 2 +-
 target/arm/cpu64.c                                  | 2 +-
 target/mips/cpu.c                                   | 2 +-
 target/s390x/cpu_models.c                           | 4 ++--
 target/sparc/cpu.c                                  | 2 +-
 target/xtensa/helper.c                              | 2 +-
 rust/qemu-api/src/qom.rs                            | 2 +-
 scripts/codeconverter/codeconverter/test_regexps.py | 2 +-
 18 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 2fb86f00a68..42b75d10a43 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -488,7 +488,7 @@ struct TypeInfo
 
     void (*class_init)(ObjectClass *klass, const void *data);
     void (*class_base_init)(ObjectClass *klass, const void *data);
-    void *class_data;
+    const void *class_data;
 
     InterfaceInfo *interfaces;
 };
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index d65a46b8d8d..9403b65ddb5 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1730,7 +1730,7 @@ static void armsse_register_types(void)
             .name = armsse_variants[i].name,
             .parent = TYPE_ARM_SSE,
             .class_init = armsse_class_init,
-            .class_data = (void *)&armsse_variants[i],
+            .class_data = &armsse_variants[i],
         };
         type_register_static(&ti);
     }
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 75b9d712518..a5336d92ff9 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1893,7 +1893,7 @@ static void m25p80_register_types(void)
             .name       = known_devices[i].part_name,
             .parent     = TYPE_M25P80,
             .class_init = m25p80_class_init,
-            .class_data = (void *)&known_devices[i],
+            .class_data = &known_devices[i],
         };
         type_register_static(&ti);
     }
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 80366aaf647..c62afc907b2 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -259,7 +259,7 @@ static const TypeInfo vt82c686b_pm_info = {
     .name          = TYPE_VT82C686B_PM,
     .parent        = TYPE_VIA_PM,
     .class_init    = via_pm_class_init,
-    .class_data    = (void *)&vt82c686b_pm_init_info,
+    .class_data    = &vt82c686b_pm_init_info,
 };
 
 static const ViaPMInitInfo vt8231_pm_init_info = {
@@ -272,7 +272,7 @@ static const TypeInfo vt8231_pm_info = {
     .name          = TYPE_VT8231_PM,
     .parent        = TYPE_VIA_PM,
     .class_init    = via_pm_class_init,
-    .class_data    = (void *)&vt8231_pm_init_info,
+    .class_data    = &vt8231_pm_init_info,
 };
 
 
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index d49730f4ad4..13814e84d18 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1770,7 +1770,7 @@ static void e1000_register_types(void)
 
         type_info.name = info->name;
         type_info.parent = TYPE_E1000_BASE;
-        type_info.class_data = (void *)info;
+        type_info.class_data = info;
         type_info.class_init = e1000_class_init;
 
         type_register_static(&type_info);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index b4b926d759a..4952f9bd2cf 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -388,7 +388,7 @@ static void spapr_cpu_core_class_init(ObjectClass *oc, const void *data)
 #define DEFINE_SPAPR_CPU_CORE_TYPE(cpu_model) \
     {                                                   \
         .parent = TYPE_SPAPR_CPU_CORE,                  \
-        .class_data = (void *) POWERPC_CPU_TYPE_NAME(cpu_model), \
+        .class_data = POWERPC_CPU_TYPE_NAME(cpu_model), \
         .class_init = spapr_cpu_core_class_init,        \
         .name = SPAPR_CPU_CORE_TYPE_NAME(cpu_model),    \
     }
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index cfa5516b96c..6104d4202aa 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2573,7 +2573,7 @@ static void megasas_register_types(void)
 
         type_info.name = info->name;
         type_info.parent = TYPE_MEGASAS_BASE;
-        type_info.class_data = (void *)info;
+        type_info.class_data = info;
         type_info.class_init = megasas_class_init;
         type_info.interfaces = info->interfaces;
 
diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 263bfa1bbda..3421c440869 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -382,7 +382,7 @@ static void tmp421_register_types(void)
             .name       = devices[i].name,
             .parent     = TYPE_TMP421,
             .class_init = tmp421_class_init,
-            .class_data = (void *) &devices[i],
+            .class_data = &devices[i],
         };
         type_register_static(&ti);
     }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c0fd3db0630..95bf7ddd972 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2497,13 +2497,13 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
 
         generic_type_info.parent = base_name;
         generic_type_info.class_init = virtio_pci_base_class_init;
-        generic_type_info.class_data = (void *)t;
+        generic_type_info.class_data = t;
 
         assert(!t->non_transitional_name);
         assert(!t->transitional_name);
     } else {
         base_type_info.class_init = virtio_pci_base_class_init;
-        base_type_info.class_data = (void *)t;
+        base_type_info.class_data = t;
     }
 
     type_register_static(&base_type_info);
diff --git a/qom/object.c b/qom/object.c
index 06d7367032e..425ee2f0ee8 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -57,7 +57,7 @@ struct TypeImpl
     void (*class_init)(ObjectClass *klass, const void *data);
     void (*class_base_init)(ObjectClass *klass, const void *data);
 
-    void *class_data;
+    const void *class_data;
 
     void (*instance_init)(Object *obj);
     void (*instance_post_init)(Object *obj);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4120f05892a..92669532d74 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2752,7 +2752,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
         .parent = TYPE_ARM_CPU,
         .instance_init = arm_cpu_instance_init,
         .class_init = info->class_init ?: cpu_register_class_init,
-        .class_data = (void *)info,
+        .class_data = info,
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1184c92b4c0..eaf5705cdc2 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -855,7 +855,7 @@ void aarch64_cpu_register(const ARMCPUInfo *info)
         .parent = TYPE_AARCH64_CPU,
         .instance_init = aarch64_cpu_instance_init,
         .class_init = info->class_init ?: cpu_register_class_init,
-        .class_data = (void *)info,
+        .class_data = info,
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 4fe845305ce..1d157a7cec3 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -621,7 +621,7 @@ static void mips_register_cpudef_type(const struct mips_def_t *def)
         .name = typename,
         .parent = TYPE_MIPS_CPU,
         .class_init = mips_cpu_cpudef_class_init,
-        .class_data = (void *)def,
+        .class_data = def,
     };
 
     type_register_static(&ti);
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 972a99236f0..4afef45c72f 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -1073,7 +1073,7 @@ static void register_types(void)
             .instance_init = s390_cpu_model_initfn,
             .instance_finalize = s390_cpu_model_finalize,
             .class_init = s390_base_cpu_model_class_init,
-            .class_data = (void *) &s390_cpu_defs[i],
+            .class_data = &s390_cpu_defs[i],
         };
         char *name = s390_cpu_type_name(s390_cpu_defs[i].name);
         TypeInfo ti = {
@@ -1082,7 +1082,7 @@ static void register_types(void)
             .instance_init = s390_cpu_model_initfn,
             .instance_finalize = s390_cpu_model_finalize,
             .class_init = s390_cpu_model_class_init,
-            .class_data = (void *) &s390_cpu_defs[i],
+            .class_data = &s390_cpu_defs[i],
         };
 
         type_register_static(&ti_base);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index a2da455e2ca..024b93ef482 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1078,7 +1078,7 @@ static void sparc_register_cpudef_type(const struct sparc_def_t *def)
         .name = typename,
         .parent = TYPE_SPARC_CPU,
         .class_init = sparc_cpu_cpudef_class_init,
-        .class_data = (void *)def,
+        .class_data = def,
     };
 
     type_register_static(&ti);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 649a2e0f913..8f4e12d5c44 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -191,7 +191,7 @@ void xtensa_register_core(XtensaConfigList *node)
     TypeInfo type = {
         .parent = TYPE_XTENSA_CPU,
         .class_init = xtensa_core_class_init,
-        .class_data = (void *)node->config,
+        .class_data = node->config,
     };
 
     xtensa_finalize_config(node->config);
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index f385cb72753..f0a79f96d5e 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -513,7 +513,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
         class_size: core::mem::size_of::<Self::Class>(),
         class_init: Some(rust_class_init::<Self>),
         class_base_init: Self::CLASS_BASE_INIT,
-        class_data: core::ptr::null_mut(),
+        class_data: core::ptr::null(),
         interfaces: core::ptr::null_mut(),
     };
 
diff --git a/scripts/codeconverter/codeconverter/test_regexps.py b/scripts/codeconverter/codeconverter/test_regexps.py
index 72113927960..08857c5008d 100644
--- a/scripts/codeconverter/codeconverter/test_regexps.py
+++ b/scripts/codeconverter/codeconverter/test_regexps.py
@@ -70,7 +70,7 @@ def fullmatch(regexp, s):
             .name = armsse_variants[i].name,
             .parent = TYPE_ARMSSE,
             .class_init = armsse_class_init,
-            .class_data = (void *)&armsse_variants[i],
+            .class_data = &armsse_variants[i],
         };''', re.MULTILINE)
 
     print(RE_ARRAY_ITEM)
-- 
2.47.1


