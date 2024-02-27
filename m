Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC53C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaq-0000vG-N5; Tue, 27 Feb 2024 08:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaO-0000kh-Nz
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:33 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaM-0002tM-A5
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:32 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33de64c91abso799118f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040807; x=1709645607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nhQiuyLJpAq1vLwFSWusjZL3a6cFkvxC3fYX6R+2IFw=;
 b=jUWCzlVJfa1h6uqgdvpaCbJEU375/pEZthQ7bBCeuencVsqrvquVMxKt3KZ9gLtQdx
 zzg0xTavRe0Q9QoqLaCN4logge1a9PGiifoXRpJcaYJ4EBJ8/lazf1fME3rZ1uo0NPc3
 m5MtZHUkJeQKLykze7eMFvSJr2oOUbTQ2Mm+F9NxY//azCZvDYarvmkRZWJYxMaSBNti
 Wa8GAKF9GfY4gqrjRFA+r2PmgUM3R3zv27hbLcJee8UvHfZeGQOVwej1ndki/O0W8jVt
 hM8RrDuIVD3cQCOhwIMVg0rh2w8Jwlp4/P/Gf4SkXUzFS8uy77YJkA4cJp+bYHKL4tQ6
 ShxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040807; x=1709645607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nhQiuyLJpAq1vLwFSWusjZL3a6cFkvxC3fYX6R+2IFw=;
 b=JteZViazJuGTstZmv6kFmv6BhlqaPBeOfApZCiGwppIegdO6pKata4y8Z+FMYBURIg
 DDEHbPix/vrIkDdJT6Fo7BLN7iVDQHRNg8eWlOssk/WPCju3l91Zjb/iIp8bYvthEzEO
 9pHWDzY6SoaYZTcWGp0VkKSIHyWOSWiFkO+XbMKApn17eHNjuJ8BzPVfjpludUkYhqGO
 cpVM9Gyphcea0mIraHOootM+9Y1faTulBd3LEnXc8lXPa1P3EaikIDX/VGbeO8PA5zhX
 cmXFycAVuR+AClXaP3cfgvhz4pXQIyjR59zkbZZfJDh9Qsg2m3eDlKM9p/PZRU+gtcGk
 UPgQ==
X-Gm-Message-State: AOJu0YxnoSZlPyRrdWqkk8qxFKWtjj7veWI7zwN9Q2NWjm/6Kq1aGLKa
 uyy8QYIi6F5iHjSY6L0JMJQ7fNTCx/WV/Iqorm/rNJIHfzD0itx9e568NEiFj37qG6VL0FEHZp5
 o
X-Google-Smtp-Source: AGHT+IFCl9EAKebFYqx3itQha4PODqh/HXX3Uu4cFkqQ3i07c3v8xDYLo6pxqBIN6/bxuJhDK3cViQ==
X-Received: by 2002:adf:f891:0:b0:33d:82c5:3b76 with SMTP id
 u17-20020adff891000000b0033d82c53b76mr7233100wrp.14.1709040807097; 
 Tue, 27 Feb 2024 05:33:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/45] hw/arm/bcm2836: Split out common part of BCM283X classes
Date: Tue, 27 Feb 2024 13:32:50 +0000
Message-Id: <20240227133314.1721857-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Sergey Kambalin <serg.oker@gmail.com>

Pre setup for BCM2838 introduction

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240226000259.2752893-2-sergey.kambalin@auriga.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2836.h |  26 +++++++++-
 hw/arm/bcm2836.c         | 103 ++++++++++++++++++++++-----------------
 hw/arm/raspi.c           |   2 +-
 3 files changed, 84 insertions(+), 47 deletions(-)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 6f90cabfa3a..5a6717ca91e 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -17,8 +17,10 @@
 #include "target/arm/cpu.h"
 #include "qom/object.h"
 
+#define TYPE_BCM283X_BASE "bcm283x-base"
+OBJECT_DECLARE_TYPE(BCM283XBaseState, BCM283XBaseClass, BCM283X_BASE)
 #define TYPE_BCM283X "bcm283x"
-OBJECT_DECLARE_TYPE(BCM283XState, BCM283XClass, BCM283X)
+OBJECT_DECLARE_SIMPLE_TYPE(BCM283XState, BCM283X)
 
 #define BCM283X_NCPUS 4
 
@@ -30,7 +32,7 @@ OBJECT_DECLARE_TYPE(BCM283XState, BCM283XClass, BCM283X)
 #define TYPE_BCM2836 "bcm2836"
 #define TYPE_BCM2837 "bcm2837"
 
-struct BCM283XState {
+struct BCM283XBaseState {
     /*< private >*/
     DeviceState parent_obj;
     /*< public >*/
@@ -41,7 +43,27 @@ struct BCM283XState {
         ARMCPU core;
     } cpu[BCM283X_NCPUS];
     BCM2836ControlState control;
+};
+
+struct BCM283XBaseClass {
+    /*< private >*/
+    DeviceClass parent_class;
+    /*< public >*/
+    const char *name;
+    const char *cpu_type;
+    unsigned core_count;
+    hwaddr peri_base; /* Peripheral base address seen by the CPU */
+    hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
+    int clusterid;
+};
+
+struct BCM283XState {
+    /*< private >*/
+    BCM283XBaseState parent_obj;
+    /*< public >*/
     BCM2835PeripheralState peripherals;
 };
 
+bool bcm283x_common_realize(DeviceState *dev, Error **errp);
+
 #endif /* BCM2836_H */
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index e3ba18a8ec1..e9768f2ab96 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -31,12 +31,12 @@ struct BCM283XClass {
 };
 
 static Property bcm2836_enabled_cores_property =
-    DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus, 0);
+    DEFINE_PROP_UINT32("enabled-cpus", BCM283XBaseState, enabled_cpus, 0);
 
-static void bcm2836_init(Object *obj)
+static void bcm283x_base_init(Object *obj)
 {
-    BCM283XState *s = BCM283X(obj);
-    BCM283XClass *bc = BCM283X_GET_CLASS(obj);
+    BCM283XBaseState *s = BCM283X_BASE(obj);
+    BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(obj);
     int n;
 
     for (n = 0; n < bc->core_count; n++) {
@@ -52,6 +52,11 @@ static void bcm2836_init(Object *obj)
         object_initialize_child(obj, "control", &s->control,
                                 TYPE_BCM2836_CONTROL);
     }
+}
+
+static void bcm283x_init(Object *obj)
+{
+    BCM283XState *s = BCM283X(obj);
 
     object_initialize_child(obj, "peripherals", &s->peripherals,
                             TYPE_BCM2835_PERIPHERALS);
@@ -63,10 +68,11 @@ static void bcm2836_init(Object *obj)
                               "vcram-size");
 }
 
-static bool bcm283x_common_realize(DeviceState *dev, Error **errp)
+bool bcm283x_common_realize(DeviceState *dev, Error **errp)
 {
     BCM283XState *s = BCM283X(dev);
-    BCM283XClass *bc = BCM283X_GET_CLASS(dev);
+    BCM283XBaseState *s_base = BCM283X_BASE(dev);
+    BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(dev);
     Object *obj;
 
     /* common peripherals from bcm2835 */
@@ -79,90 +85,93 @@ static bool bcm283x_common_realize(DeviceState *dev, Error **errp)
         return false;
     }
 
-    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->peripherals),
-                              "sd-bus");
+    object_property_add_alias(OBJECT(s_base), "sd-bus",
+                              OBJECT(&s->peripherals), "sd-bus");
 
-    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
-                            bc->peri_base, 1);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals),
+                            0, bc->peri_base, 1);
     return true;
 }
 
 static void bcm2835_realize(DeviceState *dev, Error **errp)
 {
     BCM283XState *s = BCM283X(dev);
+    BCM283XBaseState *s_base = BCM283X_BASE(dev);
 
     if (!bcm283x_common_realize(dev, errp)) {
         return;
     }
 
-    if (!qdev_realize(DEVICE(&s->cpu[0].core), NULL, errp)) {
+    if (!qdev_realize(DEVICE(&s_base->cpu[0].core), NULL, errp)) {
         return;
     }
 
     /* Connect irq/fiq outputs from the interrupt controller. */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
-            qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_IRQ));
+            qdev_get_gpio_in(DEVICE(&s_base->cpu[0].core), ARM_CPU_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
-            qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_FIQ));
+            qdev_get_gpio_in(DEVICE(&s_base->cpu[0].core), ARM_CPU_FIQ));
 }
 
 static void bcm2836_realize(DeviceState *dev, Error **errp)
 {
-    BCM283XState *s = BCM283X(dev);
-    BCM283XClass *bc = BCM283X_GET_CLASS(dev);
     int n;
+    BCM283XState *s = BCM283X(dev);
+    BCM283XBaseState *s_base = BCM283X_BASE(dev);
+    BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(dev);
 
     if (!bcm283x_common_realize(dev, errp)) {
         return;
     }
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->control), errp)) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s_base->control), errp)) {
         return;
     }
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, bc->ctrl_base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s_base->control), 0, bc->ctrl_base);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
-        qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
+        qdev_get_gpio_in_named(DEVICE(&s_base->control), "gpu-irq", 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
-        qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
+        qdev_get_gpio_in_named(DEVICE(&s_base->control), "gpu-fiq", 0));
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
-        object_property_set_int(OBJECT(&s->cpu[n].core), "mp-affinity",
+        object_property_set_int(OBJECT(&s_base->cpu[n].core), "mp-affinity",
                                 (bc->clusterid << 8) | n, &error_abort);
 
         /* set periphbase/CBAR value for CPU-local registers */
-        object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
+        object_property_set_int(OBJECT(&s_base->cpu[n].core), "reset-cbar",
                                 bc->peri_base, &error_abort);
 
         /* start powered off if not enabled */
-        object_property_set_bool(OBJECT(&s->cpu[n].core), "start-powered-off",
-                                 n >= s->enabled_cpus, &error_abort);
+        object_property_set_bool(OBJECT(&s_base->cpu[n].core),
+                                 "start-powered-off",
+                                 n >= s_base->enabled_cpus, &error_abort);
 
-        if (!qdev_realize(DEVICE(&s->cpu[n].core), NULL, errp)) {
+        if (!qdev_realize(DEVICE(&s_base->cpu[n].core), NULL, errp)) {
             return;
         }
 
         /* Connect irq/fiq outputs from the interrupt controller. */
-        qdev_connect_gpio_out_named(DEVICE(&s->control), "irq", n,
-                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_IRQ));
-        qdev_connect_gpio_out_named(DEVICE(&s->control), "fiq", n,
-                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_FIQ));
+        qdev_connect_gpio_out_named(DEVICE(&s_base->control), "irq", n,
+            qdev_get_gpio_in(DEVICE(&s_base->cpu[n].core), ARM_CPU_IRQ));
+        qdev_connect_gpio_out_named(DEVICE(&s_base->control), "fiq", n,
+            qdev_get_gpio_in(DEVICE(&s_base->cpu[n].core), ARM_CPU_FIQ));
 
         /* Connect timers from the CPU to the interrupt controller */
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_PHYS,
-                qdev_get_gpio_in_named(DEVICE(&s->control), "cntpnsirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_VIRT,
-                qdev_get_gpio_in_named(DEVICE(&s->control), "cntvirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_HYP,
-                qdev_get_gpio_in_named(DEVICE(&s->control), "cnthpirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_SEC,
-                qdev_get_gpio_in_named(DEVICE(&s->control), "cntpsirq", n));
+        qdev_connect_gpio_out(DEVICE(&s_base->cpu[n].core), GTIMER_PHYS,
+            qdev_get_gpio_in_named(DEVICE(&s_base->control), "cntpnsirq", n));
+        qdev_connect_gpio_out(DEVICE(&s_base->cpu[n].core), GTIMER_VIRT,
+            qdev_get_gpio_in_named(DEVICE(&s_base->control), "cntvirq", n));
+        qdev_connect_gpio_out(DEVICE(&s_base->cpu[n].core), GTIMER_HYP,
+            qdev_get_gpio_in_named(DEVICE(&s_base->control), "cnthpirq", n));
+        qdev_connect_gpio_out(DEVICE(&s_base->cpu[n].core), GTIMER_SEC,
+            qdev_get_gpio_in_named(DEVICE(&s_base->control), "cntpsirq", n));
     }
 }
 
-static void bcm283x_class_init(ObjectClass *oc, void *data)
+static void bcm283x_base_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -173,7 +182,7 @@ static void bcm283x_class_init(ObjectClass *oc, void *data)
 static void bcm2835_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    BCM283XClass *bc = BCM283X_CLASS(oc);
+    BCM283XBaseClass *bc = BCM283X_BASE_CLASS(oc);
 
     bc->cpu_type = ARM_CPU_TYPE_NAME("arm1176");
     bc->core_count = 1;
@@ -184,7 +193,7 @@ static void bcm2835_class_init(ObjectClass *oc, void *data)
 static void bcm2836_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    BCM283XClass *bc = BCM283X_CLASS(oc);
+    BCM283XBaseClass *bc = BCM283X_BASE_CLASS(oc);
 
     bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
     bc->core_count = BCM283X_NCPUS;
@@ -198,7 +207,7 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
 static void bcm2837_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    BCM283XClass *bc = BCM283X_CLASS(oc);
+    BCM283XBaseClass *bc = BCM283X_BASE_CLASS(oc);
 
     bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
     bc->core_count = BCM283X_NCPUS;
@@ -226,11 +235,17 @@ static const TypeInfo bcm283x_types[] = {
 #endif
     }, {
         .name           = TYPE_BCM283X,
-        .parent         = TYPE_DEVICE,
+        .parent         = TYPE_BCM283X_BASE,
         .instance_size  = sizeof(BCM283XState),
-        .instance_init  = bcm2836_init,
-        .class_size     = sizeof(BCM283XClass),
-        .class_init     = bcm283x_class_init,
+        .instance_init  = bcm283x_init,
+        .abstract       = true,
+    }, {
+        .name           = TYPE_BCM283X_BASE,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(BCM283XBaseState),
+        .instance_init  = bcm283x_base_init,
+        .class_size     = sizeof(BCM283XBaseClass),
+        .class_init     = bcm283x_base_class_init,
         .abstract       = true,
     }
 };
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index cc4c4ec9bfc..af866ebce29 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -252,7 +252,7 @@ static void setup_boot(MachineState *machine, RaspiProcessorId processor_id,
         s->binfo.firmware_loaded = true;
     }
 
-    arm_load_kernel(&s->soc.cpu[0].core, machine, &s->binfo);
+    arm_load_kernel(&s->soc.parent_obj.cpu[0].core, machine, &s->binfo);
 }
 
 static void raspi_machine_init(MachineState *machine)
-- 
2.34.1


