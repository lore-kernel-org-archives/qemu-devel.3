Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CE4C7EE39
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Jun 2025 20:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVyxY-0003fr-7d; Sun, 29 Jun 2025 16:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uVyxW-0003f1-OH; Sun, 29 Jun 2025 16:49:06 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uVyxU-0000Rs-By; Sun, 29 Jun 2025 16:49:06 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ad574992fcaso246731666b.1; 
 Sun, 29 Jun 2025 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751230142; x=1751834942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ZwtYW+m6w4oQmOf8ZPSw+Fz8ib8szmgXYuwZPtcG1c=;
 b=CMK6iZTkbf8lLL+hRjHdIgCUuiUEFbqTK+qseOAkz54Lmo/084LnGp7g+McWo/ImHj
 n5u2dPjZgfIAYm67ALJ/h1CvJKobSQQXlNVfNkTmerivrgLpngUBvlNuk8/CfaFUkxc+
 BvFmZR/7eVuZQJpH7J6OX0tmo9XMaU/XYzBuVAdhHUQKtRQTWBMFUPB/PLX7CVimnDYj
 sqvi8Od4tNcRjNhYLFNnRzvqhofvHt1J/u+WiPAn/s86IfdrTVpFc0wG/ujsw818HXHu
 Ae6KrWEa42Rx4751Ioa5g2lr5+z2+Chiuif2kf2j0ry3WovPgGhYfoVe3wTC9WlUZxv+
 28BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751230142; x=1751834942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ZwtYW+m6w4oQmOf8ZPSw+Fz8ib8szmgXYuwZPtcG1c=;
 b=xII6Ab657BcuBBALHU8QbE/06rKGkFPPvfeH2i3bsHXq+s/NoqudyfvsBOTf1lVhAL
 VXBFap5nu8Io95KkSmIXJ6XOV7cvVUTMacLul89Og+pio77XwPh83nZqYyedPZNqiK/Q
 I51QpKCpPikjghAZXjthahiAFJYImcR2WGQD9I1cYjIkIthiXwt65nVZbwLosUKReyvY
 8n0GVWQ7QY6QNOVKVjtmcHu13mwsdvmzpB+Qaqp/J17q5iOk6wuS6rbYrwvpSrSK1jiZ
 3X7aPszbBtoyiVikf97rl3gPu93AliaMIJ8sWtAdxM2T+yMJJp1ObSeDlrYNfebJTU8f
 JAMw==
X-Gm-Message-State: AOJu0YyPRwF1Z8l2xmYuG4pVF/LNgQY1B788es85LVYwJg+oRTdOZ75T
 +N0HoQLLublqZxc2hkmfbo4P3nBBAr3ii6GTUPoVp2e7fJyK5pqOnLJDerjvYA==
X-Gm-Gg: ASbGnctzpgk+6bhUtTTtYChlhq2vFxtdK1hq7CrbyP75n87cnmxBetpScfPS8AyQtOA
 WxA3A+yokCJj+yefO/JkY3PrWF8Y1FkvYfPFkhbmHXtzruhE4VMcJLdaOvYF15K08RIHqvv3k66
 PVZD9rqrMu0eyeBnlG6xm3qWvGk9j2ZeudoffUvI5PL2v53U12Xg0vgJTFYcIom+wsYQzSgbWw2
 8pPo0zwwYdo/4IW2fuL25ueDHbA8kggzdZxdeKu9+MDZWQmQBynLRWcEc5hfi5pErTymMJDPIvA
 1AIPdN30Qnr6AQEjxcguBwnInYv73bt3LApA/pHT2RorDXTWkDnu8QRvuc9m4X1hvho5Q+brNnD
 IB39d+DujP2zKWVcgOoN6jmd2UkXQtcA3VU9oMIvnCjKAzBV9oFiOYywfa/UPFEk1xQ==
X-Google-Smtp-Source: AGHT+IGOKjC8J/uC/oucGHcGtp6vbIJkNsADCG8KvjfUamwbZIRXrnnBRgtfw1sL/NOgPPsIYrtE1A==
X-Received: by 2002:a17:907:9603:b0:ae0:cf36:ea81 with SMTP id
 a640c23a62f3a-ae34fd1837fmr957999566b.5.1751230141999; 
 Sun, 29 Jun 2025 13:49:01 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-2f97-a200-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2f97:a200:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353659e06sm535709566b.44.2025.06.29.13.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 13:49:01 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
Date: Sun, 29 Jun 2025 22:48:51 +0200
Message-ID: <20250629204851.1778-3-shentey@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250629204851.1778-1-shentey@gmail.com>
References: <20250629204851.1778-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Allows the imx8mp-evk machine to be run with KVM acceleration as a guest.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  7 +++++++
 hw/arm/fsl-imx8mp.c            | 33 ++++++++++++++++++++++++++++-----
 hw/arm/imx8mp-evk.c            | 11 +++++++++++
 hw/arm/Kconfig                 |  3 ++-
 hw/arm/meson.build             |  2 +-
 5 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index b2f7d29ade..1399820163 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -60,3 +60,10 @@ Now that everything is prepared the machine can be started as follows:
       -dtb imx8mp-evk.dtb \
       -append "root=/dev/mmcblk2p2" \
       -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
+
+
+KVM Virtualization
+------------------
+
+To enable hardware-assisted acceleration via KVM, append
+``-accel kvm -cpu host`` to the command line.
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 866f4d1d74..7e61392abb 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -12,11 +12,13 @@
 #include "system/address-spaces.h"
 #include "hw/arm/bsa.h"
 #include "hw/arm/fsl-imx8mp.h"
-#include "hw/intc/arm_gicv3.h"
 #include "hw/misc/unimp.h"
 #include "hw/boards.h"
+#include "system/kvm.h"
 #include "system/system.h"
+#include "target/arm/cpu.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/kvm_arm.h"
 #include "qapi/error.h"
 #include "qobject/qlist.h"
 
@@ -197,11 +199,10 @@ static void fsl_imx8mp_init(Object *obj)
 
     for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX8MP_NUM_CPUS); i++) {
         g_autofree char *name = g_strdup_printf("cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i],
-                                ARM_CPU_TYPE_NAME("cortex-a53"));
+        object_initialize_child(obj, name, &s->cpu[i], ms->cpu_type);
     }
 
-    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
+    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
 
@@ -274,7 +275,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     /* CPUs */
     for (i = 0; i < ms->smp.cpus; i++) {
         /* On uniprocessor, the CBAR is set to 0 */
-        if (ms->smp.cpus > 1) {
+        if (ms->smp.cpus > 1 &&
+                object_property_find(OBJECT(&s->cpu[i]), "reset-cbar")) {
             object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
                                     fsl_imx8mp_memmap[FSL_IMX8MP_GIC_DIST].addr,
                                     &error_abort);
@@ -286,6 +288,16 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
                                 &error_abort);
 
+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el2")) {
+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el2",
+                                     !kvm_enabled(), &error_abort);
+        }
+
+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
+                                     !kvm_enabled(), &error_abort);
+        }
+
         if (i) {
             /*
              * Secondary CPUs start in powered-down state (and can be
@@ -304,6 +316,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     {
         SysBusDevice *gicsbd = SYS_BUS_DEVICE(&s->gic);
         QList *redist_region_count;
+        bool pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
 
         qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp.cpus);
         qdev_prop_set_uint32(gicdev, "num-irq",
@@ -360,6 +373,16 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                                qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
             sysbus_connect_irq(gicsbd, i + 3 * ms->smp.cpus,
                                qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+
+            if (kvm_enabled()) {
+                if (pmu) {
+                    assert(arm_feature(&s->cpu[i].env, ARM_FEATURE_PMU));
+                    if (kvm_irqchip_in_kernel()) {
+                        kvm_arm_pmu_set_irq(&s->cpu[i], VIRTUAL_PMU_IRQ);
+                    }
+                    kvm_arm_pmu_init(&s->cpu[i]);
+                }
+            }
         }
     }
 
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index b3082fa60d..30eb57318d 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -95,9 +95,20 @@ static void imx8mp_evk_init(MachineState *machine)
 
 static void imx8mp_evk_machine_init(MachineClass *mc)
 {
+    static const char *const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a53"),
+#ifdef CONFIG_KVM
+        ARM_CPU_TYPE_NAME("host"),
+#endif /* CONFIG_KVM */
+        NULL
+    };
+
     mc->desc = "NXP i.MX 8M Plus EVK Board";
     mc->init = imx8mp_evk_init;
     mc->max_cpus = FSL_IMX8MP_NUM_CPUS;
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->default_cpu_type = mc->valid_cpu_types[0];
     mc->default_ram_id = "imx8mp-evk.ram";
 }
+
 DEFINE_MACHINE("imx8mp-evk", imx8mp_evk_machine_init)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f543d944c3..d35f41331f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -604,7 +604,8 @@ config FSL_IMX8MP
 config FSL_IMX8MP_EVK
     bool
     default y
-    depends on TCG && AARCH64
+    depends on AARCH64
+    depends on TCG || KVM
     select FSL_IMX8MP
 
 config ARM_SMMUV3
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index d90be8f4c9..a4212a6ab2 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -59,7 +59,7 @@ arm_common_ss.add(when: 'CONFIG_MUSCA', if_true: files('musca.c'))
 arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
-arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
+arm_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
-- 
2.50.0


