Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEB9CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwm8-0005B4-JU; Mon, 03 Nov 2025 10:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFwm6-00059j-13
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:47:18 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFwlw-0002iB-7f
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:47:17 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-429b895458cso3012076f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 07:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762184824; x=1762789624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xo8vYVMOLAyP8tcdONTB90bL71Gp6mSGWGYbDD5ZgmU=;
 b=hrmrsDavVtZ6ghEBzhdHSh1vQlJwM/4/FWibQfQu9yt7gCZaUCJYDENSk1HKGNFYCW
 I26FybxYEwX1rxbJoatkKhKJNgPc02w735omH40wa4lDhIII9fSSjNuIEKimwX7vjlCK
 VQJ5f/MPAOpGcVSv6Lrhtl17c5tswspnhI3yPye3KTgXfur5f+Wd9GntKieiNngC/h1w
 L799rL+SkilKf8Fz2MCMtvBISF9yqxpoEJZvPRhPbnlTpWpZ+OVWcEMJDoJDlvCVZpUr
 uPV2QD5kjtxwqYNH5Mj+2sIQj89iTuZM6dxPD1ZLLngbrQYm/qGP1v5hE04DwLX7DOzv
 E8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762184824; x=1762789624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xo8vYVMOLAyP8tcdONTB90bL71Gp6mSGWGYbDD5ZgmU=;
 b=SPKQY0s4Y4k2fBX+mq6c6VLurE5SW7HRSGiHvZl/qJTQS2ZPecTbcqQb5J5mGVxtKe
 mXk/dM9gNm5dMTLKNwa5ZjEJQeK4ohlRvrPr1w4foN7WLT88FzUG4QShlcOHnXvu90i4
 9CUODXzXT1bkQCUtty+q20ax+htDFB3jXZe0ZgDDyNM8zza/IafOvluKk5SI1a0cOehX
 ++9vjYP5RCKWWEMW5KWGvoDWd+tLT1Iz0im1Qk2vcyu7TxeFV2Wg+sxr3NssWiRce9FD
 G5O2AEKQWPyps2xCWm2IMvY3W0wyX8TnxV873HSetcTS7PoQ11yOevAZBIsQbvttwf4H
 25oA==
X-Gm-Message-State: AOJu0YwGzKuqumleH7JDUbYDv1HaU17hQaUgLDrbSHOzX3073gEImV8P
 UbBPWP40xrnHUgw8W1PssJFYVl2Sgd+UrN/BMRoZ40a9Wg1X3QZaOeakubZ7L+xMxOp8tnWVfEB
 YDurF
X-Gm-Gg: ASbGncsQbjLgxfxTd3sxf09PFCAWbpMAXyS68jezM0gUwycQW1+dpk5CdzcjZMV8B7Q
 qiqnCpbsHs+xSPeKmJRG9aMEVwcy9b40AuBR3zQdQYUqziWxxzIdCTpuKAfbBR20qk3lau+5eER
 TsDb4XyK7fsAjEnlPqtqsr8t/VFKQUSFJJja20s5V2NzH/+zNHe9InQ3iPZzSKL2ZGCsnpKNqMH
 BT4FxqOeKtZa9SfA4rDlRac8n3PuWuVCfceQFbp3JkTt9LdfvSEcGqiVJc+l1iP7WMVyPXEhGjB
 QLM2/VhZj5vCT85gZA40nVmFxxjvE1p1SsmD66yZU/BbLIrm6XboPU2qwj2Uqqy8BfuRmgFivPe
 GHX1G+LqR+EqqfK9KI5d4JwnhIC0IKAywoK1YE85CjQyhAFcqTOePsQCBJQWver/CMAHxOIczSv
 xjkFRPQEhI2HKJRQx/
X-Google-Smtp-Source: AGHT+IED9qRBPP12owHxO2x5AYraDH/+5qRqOeKc4seoqVOXBQV1DTztbT7Ou4f3vJ8vjZFe8eYBeA==
X-Received: by 2002:a05:6000:2382:b0:427:7ac:528f with SMTP id
 ffacd0b85a97d-429bd69912emr12166164f8f.33.1762184823387; 
 Mon, 03 Nov 2025 07:47:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429ce6b0c16sm10504156f8f.38.2025.11.03.07.47.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 07:47:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] hw/arm/imx8mp-evk: Add KVM support
Date: Mon,  3 Nov 2025 15:46:58 +0000
Message-ID: <20251103154700.4126379-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103154700.4126379-1-peter.maydell@linaro.org>
References: <20251103154700.4126379-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Allows the imx8mp-evk machine to run guests with KVM acceleration.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20251101120130.236721-2-shentey@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/imx8mp-evk.rst | 19 +++++++++++++++++++
 hw/arm/fsl-imx8mp.c            | 34 +++++++++++++++++++++++++++++-----
 hw/arm/imx8mp-evk.c            | 11 +++++++++++
 hw/arm/Kconfig                 |  3 ++-
 4 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index b2f7d29ade5..75c8fbd3668 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -60,3 +60,22 @@ Now that everything is prepared the machine can be started as follows:
       -dtb imx8mp-evk.dtb \
       -append "root=/dev/mmcblk2p2" \
       -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
+
+
+KVM Acceleration
+----------------
+
+To enable hardware-assisted acceleration via KVM, append
+``-accel kvm -cpu host`` to the command line. While this speeds up performance
+significantly, be aware of the following limitations:
+
+* The ``imx8mp-evk`` machine is not included under the "virtualization use case"
+  of :doc:`QEMU's security policy </system/security>`. This means that you
+  should not trust that it can contain malicious guests, whether it is run
+  using TCG or KVM. If you don't trust your guests and you're relying on QEMU to
+  be the security boundary, you want to choose another machine such as ``virt``.
+* Rather than Cortex-A53 CPUs, the same CPU type as the host's will be used.
+  This is a limitation of KVM and may not work with guests with a tight
+  dependency on Cortex-A53.
+* No EL2 and EL3 exception levels are available which is also a KVM limitation.
+  Direct kernel boot should work but running U-Boot, TF-A, etc. won't succeed.
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 866f4d1d740..ee6f3e42d23 100644
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
 
@@ -193,15 +195,15 @@ static void fsl_imx8mp_init(Object *obj)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     FslImx8mpState *s = FSL_IMX8MP(obj);
+    const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
     int i;
 
     for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX8MP_NUM_CPUS); i++) {
         g_autofree char *name = g_strdup_printf("cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i],
-                                ARM_CPU_TYPE_NAME("cortex-a53"));
+        object_initialize_child(obj, name, &s->cpu[i], cpu_type);
     }
 
-    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
+    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
 
@@ -274,7 +276,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     /* CPUs */
     for (i = 0; i < ms->smp.cpus; i++) {
         /* On uniprocessor, the CBAR is set to 0 */
-        if (ms->smp.cpus > 1) {
+        if (ms->smp.cpus > 1 &&
+                object_property_find(OBJECT(&s->cpu[i]), "reset-cbar")) {
             object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
                                     fsl_imx8mp_memmap[FSL_IMX8MP_GIC_DIST].addr,
                                     &error_abort);
@@ -286,6 +289,16 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
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
@@ -304,6 +317,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     {
         SysBusDevice *gicsbd = SYS_BUS_DEVICE(&s->gic);
         QList *redist_region_count;
+        bool pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
 
         qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp.cpus);
         qdev_prop_set_uint32(gicdev, "num-irq",
@@ -360,6 +374,16 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
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
index fc880a1d44b..3ddcf1af5ac 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -13,6 +13,7 @@
 #include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
+#include "system/kvm.h"
 #include "system/qtest.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -94,12 +95,22 @@ static void imx8mp_evk_init(MachineState *machine)
     }
 }
 
+static const char *imx8mp_evk_get_default_cpu_type(const MachineState *ms)
+{
+    if (kvm_enabled()) {
+        return ARM_CPU_TYPE_NAME("host");
+    }
+
+    return ARM_CPU_TYPE_NAME("cortex-a53");
+}
+
 static void imx8mp_evk_machine_init(MachineClass *mc)
 {
     mc->desc = "NXP i.MX 8M Plus EVK Board";
     mc->init = imx8mp_evk_init;
     mc->max_cpus = FSL_IMX8MP_NUM_CPUS;
     mc->default_ram_id = "imx8mp-evk.ram";
+    mc->get_default_cpu_type = imx8mp_evk_get_default_cpu_type;
 }
 
 DEFINE_MACHINE_AARCH64("imx8mp-evk", imx8mp_evk_machine_init)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b44b85f4361..0cdeb60f1f2 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -622,7 +622,8 @@ config FSL_IMX8MP
 config FSL_IMX8MP_EVK
     bool
     default y
-    depends on TCG && AARCH64
+    depends on AARCH64
+    depends on TCG || KVM
     select FSL_IMX8MP
 
 config ARM_SMMUV3
-- 
2.43.0


