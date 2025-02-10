Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21369C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTwR-0002Dz-OM; Mon, 10 Feb 2025 08:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtq-0000CE-Ge
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:44 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtn-0006E7-U6
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:34 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso7152265e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739194349; x=1739799149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpzvwCiYjHOBEAgs3JW+S7i+d1yECBR+UnRxUIJFJtU=;
 b=erlFc7ZB+jABWDf1CoQL5MWiopubymkNdf7TA4H49zAB9aR0CfZsYH/LdlrtpGQcaZ
 NWDLUbdDsegdmmZ7ElaHqV4S37fMTXvqFdq/NDOPFY0aR0Vk9MS4khZZTjy2SLLc+vti
 DTvqpLbRlLcHL1ihWtRZqGCATffpkZOal4JjUOdhQ06vWRcd6bjGqOJldh4m+5W+73ii
 WkNweQ3UpA4ETsFyMam2DoOP+mxHCItN+a5PH++6j7MeR9eN9IXzNhOoRUpR3zitIBs5
 woMDg3CdvEHtq92WYOVLeWB7esC4S/kadIVnX0eT5VrPwRQqWJfTS9xmfmGdRA+kDP2o
 4oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739194349; x=1739799149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FpzvwCiYjHOBEAgs3JW+S7i+d1yECBR+UnRxUIJFJtU=;
 b=pS8cWdw/gYgLh9e+jTLEFugkT4ok7ywF7Wip/LtQXweXJ6irjnk5VFtKBmMU5iPZ5B
 vIkahiu7uEycpIu0S+/zMRjbIRx4NDJriaLUgxInk2b7RV6wGkOKxK2PX86PaqKlsaBP
 yUVttjzq+/fRbLpR0qk7lNFRobkxnF33PpYwkqI4FHxrkMwQbxRsqLLzsDZ0onkhJBKt
 u8XxHInloZQChUFVkQgfQEFiJM070ueXahLl1bFrbUjoLEmfnkfD0TtnWmmYe2qPmUrE
 9O/YuXFr5sjjF+bnGAxSpfi/bkwIEVTkyWm47c+W02yypUy3Bd8cA3abAy7fhhKG0FFh
 d+KQ==
X-Gm-Message-State: AOJu0YzI+GC2aoTo+YzRxVz705G/kesLQuVeAtPBeBE0/NwPlMj4oU4t
 PCFcVv0A2ziUof6r19ARUILJ3oXkHi/SC8aDou+pJV8EbsNeJ8QESp/juICe6k64LkVX2O3bOTe
 SDFc=
X-Gm-Gg: ASbGnctMTJYgti7RstvT3lPHQDToeelqXWk9dIS/eb2mNMwbgIm6naHrsnm6T5AI4ys
 zk9OkcAGigolhwaUUnJIC/0SgQ3b0qxV5Abl0U3TnYt2VONclxHIdDAQ4P2VssLi7LWXTJLDspY
 Bi2EmdmAhYonOEZAoRjlsFoEudkxmAVLxKGgY6Qqy1ZQA4vvH+ajRvHCKQJ/4+qZqnaqMbPoBKH
 nptPVuuWr/XBev4rhourHCLH0eMz2j8Aa+44G1yqGnz7/SmdURpViL37aWr2kkXcfcfKCi05ot0
 9us/hnpxW1f0J/G8ASz0rhO8aFN2mEHbgBQOtJOLdb7Ye1TAAh2EBJVdsdlfVkpVwfGzkFQ=
X-Google-Smtp-Source: AGHT+IHRlvaKHtFBiH2VBq7Y18OAa6sfJYXSQF3lWfi5qjEQrZbcYvOrgFKFn4I8x/Sw10bvTE3Qwg==
X-Received: by 2002:a05:600c:1d14:b0:439:31e0:d9a5 with SMTP id
 5b1f17b1804b1-43931e0e028mr62949395e9.22.1739194348632; 
 Mon, 10 Feb 2025 05:32:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43947a5be1bsm19329445e9.8.2025.02.10.05.32.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 05:32:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/11] qom: Constify TypeInfo::class_data
Date: Mon, 10 Feb 2025 14:31:33 +0100
Message-ID: <20250210133134.90879-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210133134.90879-1-philmd@linaro.org>
References: <20250210133134.90879-1-philmd@linaro.org>
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

All callers now correctly expect a const class data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 236fa798c34..eee7bedd6b3 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1891,7 +1891,7 @@ static void m25p80_register_types(void)
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
index c1964d3dc8a..e1929a546a3 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -380,7 +380,7 @@ static void spapr_cpu_core_class_init(ObjectClass *oc, const void *data)
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
index acb49a6a330..48082445bc6 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2500,13 +2500,13 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
 
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
index 55db0d2a3e8..254d7d4f7e5 100644
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
index 6ee5e335771..872ea3cd1b6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2766,7 +2766,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
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
index 9a45adb3ec5..a7abaf9b286 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -619,7 +619,7 @@ static void mips_register_cpudef_type(const struct mips_def_t *def)
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
index f46600249bd..d140fb948e3 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1074,7 +1074,7 @@ static void sparc_register_cpudef_type(const struct sparc_def_t *def)
         .name = typename,
         .parent = TYPE_SPARC_CPU,
         .class_init = sparc_cpu_cpudef_class_init,
-        .class_data = (void *)def,
+        .class_data = def,
     };
 
     type_register_static(&ti);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 75bb00ee246..1ca6f37562c 100644
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
index b39dba829d4..b007f089153 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -496,7 +496,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
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


