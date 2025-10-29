Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD63ECCF9F6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 14:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE75q-0006AY-Cj; Wed, 29 Oct 2025 10:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vE75d-00067V-PC
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:23:53 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vE75R-0008Km-H4
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:23:52 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-427007b1fe5so6096197f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761747809; x=1762352609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SL5WE5vdewXMVdhY/PLS7jCW38uhVLJye8u2JKMVFMs=;
 b=O4eQmGAJ16McXyPyHhE/hiI/Iha9bqKVQ3+0igVpREdFiqj01eUmNPptWzlK/+t97Z
 rb4P1fYB/Z7m17Gx+z4Fv1vw7yCKdeYgyZs9dHT86paf440F1jt3Z2XPwI+Nvy7Kms5O
 C3/a9lRxIOulTT7Grqj+7cjTsJe6E+Quxxw1hkL47+NBhcVeuWdedqiZIql8zWE5dInX
 Li1Zj65D9IzbJweJBErW/001mr6sRug3Yd8rv3xiGMTZcVDIuxPRjw4F+a7Tj5e+8SaA
 rNWmiWtIePxr3xOOkLa6kk+QswHM/HHTId+4aPDOfmg0bAENVGicIqRS5GbvtZ68ck64
 zNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761747809; x=1762352609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SL5WE5vdewXMVdhY/PLS7jCW38uhVLJye8u2JKMVFMs=;
 b=DtnUyESo4z7CDdgYKnNOC5e9FHSVC4uCCAHd5WQiQynpmWPtPtFfwTPK7GL6e22jVN
 0CDPdrRB2wwlDj2D4gP87kR4zeuwDuDjmqAnbyfvpWkmlspiiz3mqC9U8c1U/fUXKkMA
 u3i77aszs7v9l3sG7Gfx7crCtD08pyoclehZhPESg2G8ZKUxPnps0spbKZRk0eEbkNU5
 2ulQzCPRV7l+BoPWLla3XIlkdLs7klKgThvInCDC8bPxcUVL7DYqDbOSgKp3ipI65T76
 p1UoG8Lszj53jVKiXwt/kI33m/unQOGGGNRJBwk46WzZljBeB+nNmBIXK33FsGLOE8Ea
 TxGA==
X-Gm-Message-State: AOJu0YwD/KFby1aG0IHGxyrn03SFG3C08+PJxix+TcSvpXO7YCI2YwPh
 sL7grRKVLT0GNwth148r5dcWVDG1uQdEmdRl09KKriMiXlcMM+a/GOZMoTFyvw==
X-Gm-Gg: ASbGncuNR3ML2K9W9UhTWJqI8wVNPSMGvGAgHlb4EFRnGu150ygwgfowFlwwvo4FyRy
 jr9E7iJHd8PT+rh/AMM6n2whpaXRzggZt7IFac/Km9C5PwuPBHQ7gN0AamVmNdjCuT9/IVie/ve
 AIOL8zlicZuTCZn3N6dHpQLUlsH3wFEOvoGhAGyz5auLVkveeSwhqH8uHz7ROrq3//G+8Q5pdJU
 gL3nGAfTWxtPozp0teXLoBPVYvTrBrksJIwqYDUrfgt0ffTZhyObJMn2KQofnhB3c86vwN7cp3T
 aQdJ4AF1yn9DM7Iy7RE0NX6orMwUupJIalEOuww/Cu4UFc8kRBmjXeqKUXPx9EZYr3jYqvXYjQw
 8RFVmuWMNUCstZNvVljyIHWHgd82Su0ofPo4Zah+SQFuyBMUkSHzrLIVnpmNQJL992C99u+cMrv
 JWiUjwXj8c5l9bFeqU6ODirtekdPXAO965bJbeMeBzizw=
X-Google-Smtp-Source: AGHT+IG9d7OyR3uSsi2chHaHUnIyjxim7arAczZua+bZaeQLM/INVGMUK9HzdajKdzDWfeBxcmPs0A==
X-Received: by 2002:a05:6000:4715:b0:429:b1e4:1f74 with SMTP id
 ffacd0b85a97d-429b1e42275mr1771292f8f.20.1761747809283; 
 Wed, 29 Oct 2025 07:23:29 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952ca569sm26038747f8f.12.2025.10.29.07.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 07:23:28 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 1/2] hw/arm/imx8mp-evk: Add KVM support
Date: Wed, 29 Oct 2025 15:23:10 +0100
Message-ID: <20251029142311.2986-2-shentey@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029142311.2986-1-shentey@gmail.com>
References: <20251029142311.2986-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Allows the imx8mp-evk machine to run guests with KVM acceleration.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst | 18 ++++++++++++++++++
 hw/arm/fsl-imx8mp.c            | 33 ++++++++++++++++++++++++++++-----
 hw/arm/imx8mp-evk.c            | 12 ++++++++++++
 hw/arm/Kconfig                 |  3 ++-
 4 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index b2f7d29ade..ccf81381b1 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -60,3 +60,21 @@ Now that everything is prepared the machine can be started as follows:
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
+* Unlike other machines with KVM support, the ``imx8mp-evk`` machine makes no
+  attempt to protect itself from malicious guests. If you don't trust your
+  guests and you're relying on QEMU to be the security boundary, you want to
+  choose another machine such as ``virt``.
+* Rather than Cortex-A53 CPUs, the same CPU type as the host's will be used.
+  This is a limitation of KVM and may not work with guests with a tight
+  dependency on Cortex-A53.
+* No EL2 and EL3 exception levels are available which is also a KVM limitation.
+  Direct kernel boot should work but running U-Boot, TF-A, etc. won't succeed.
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
index b3082fa60d..80036f8589 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -12,6 +12,7 @@
 #include "hw/arm/fsl-imx8mp.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
+#include "system/kvm.h"
 #include "system/qtest.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -93,11 +94,22 @@ static void imx8mp_evk_init(MachineState *machine)
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
+
 DEFINE_MACHINE("imx8mp-evk", imx8mp_evk_machine_init)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b44b85f436..0cdeb60f1f 100644
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
2.51.2


