Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C86C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZIN-0002O8-D7; Tue, 17 Jun 2025 12:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZGC-0000mJ-Re
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZG2-0000dd-0G
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:02 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a35c894313so6707317f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750178036; x=1750782836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbBMXE6agkH4y/ezmub6pqd0ynNZ26J7iJ0lGND0r7M=;
 b=UEiSHrVyH7ktfqk3LQ7oQjSUP5c0umM+t2HKVzd0hRRdgEkkRRYnGnkUHNzyJpvDY2
 e1vNCUeOjDAhrU63aYFuwjuOKaK7Nz4LJrmxQBO5vFbLHZcVzzjPHiSb3glgbOmEx9mp
 TrYI/nrOFQaQOxXKR5YC5Soycn+QYHwE/lCw/ozqx7TuqYf6hPAfRgsQPk12u4/sA88O
 Jql8uxaXBBozxmZdvsIJZa2UWIfBlC/11z8obfVw/ShdVeKW3EUIUC+Qej1acwwG1v14
 0PMoiFlfXRYLjszJokzTiq2o5MSMFvEPVQnBLHh/G3jfgP6DznwIHJIBOKLinuf2DU2y
 dPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750178036; x=1750782836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbBMXE6agkH4y/ezmub6pqd0ynNZ26J7iJ0lGND0r7M=;
 b=xDeoy+TRjOYLp3sU9tn2G4aMJUBSCLpLiJwEOX0Gl0CYjADGqtb84nI/ER9GksLJhA
 awvW1HoEtmON7RD5xKPLKiYTrwS7iNUtCht9sjKb6AvDzaoqSp2pcYScrjZayStBJJcC
 PuRuHXWx4SWQDI0fysZLQyaxVlNBo9kU9cN5ZclSI2oX9gEAFbAjlfPX2GWlUd8bQr7w
 b8+0FLMFgv/pJWUwnpna/CifpYMO1i5KjEmVIMfi9kXoLuybrP1kSHUOyhDdjRSKU0lz
 gBkn56DRTJUDo+/a1dGfGD8k8pemCiewP8/uDz4t/V3vHbj90/MgtWYPHrkTVBjmf22g
 nzFw==
X-Gm-Message-State: AOJu0YxDiU9URDoqYh+9NANTA+u08fwPmnvhNA/SgqP5v1LWm769YAe4
 LaMrIAXZITVPVnb8storq6dmvaBvmxVJgT+U1Xddib7fNZFBjlgBoSckrQD35Q4i+ak=
X-Gm-Gg: ASbGncv2wccL1TUw3FlNdq9zlhFVWRVUWuU+6PYDOgYdl5LAHQ7wpTu+MvpH9k/lT1c
 lLk60iNG5kNiJOnn/vZ42Pt/Ci2TdzXmKJddvGPrjfw1PHLmiUTJIyJAUlRWpLd30i1eYSQ8Eam
 +E+iwCxYUOi5Q1l07MTj5h5cxZkNE1UHakUi8+UbMGgwcsr021Fh5wSPhH3VnIqFTsWVwBHnyVu
 Vu6JaZQQBD6sTILHWmYKIRqHNOBG+jhRxbd5trYKhL0sshn1ZTaWpZDHP5AUEPqjPEQCV5n9ril
 oDNl1K8XtcUT+Uri071gdnfhSLZgUQBjZ2C6XSNI+8DnjxX7c4Z6h3Jl05CI3DU=
X-Google-Smtp-Source: AGHT+IHa+tTRhzZC5JgvxX7eaDorwkAI71UFHvcJbR60AGJdJK9kAKmeytdmd5ysTcE1li+eFVBMhw==
X-Received: by 2002:a05:6000:2507:b0:3a4:efc0:c90b with SMTP id
 ffacd0b85a97d-3a5723974e2mr12693214f8f.15.1750178036481; 
 Tue, 17 Jun 2025 09:33:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a54d1fsm14265133f8f.2.2025.06.17.09.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 09:33:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 77B535F90B;
 Tue, 17 Jun 2025 17:33:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <graf@amazon.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 06/11] kvm/arm: allow out-of kernel GICv3 to work with KVM
Date: Tue, 17 Jun 2025 17:33:46 +0100
Message-ID: <20250617163351.2640572-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617163351.2640572-1-alex.bennee@linaro.org>
References: <20250617163351.2640572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Previously we suppressed this option as KVM would get confused if it
started trapping GIC system registers without a GIC configured.
However if we know we are trapping harder we can allow it much like we
do for HVF.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/kvm_arm.h       |  8 ++++++++
 hw/arm/virt.c              | 11 +++++++++--
 hw/intc/arm_gicv3_common.c |  4 ----
 target/arm/cpu.c           |  2 +-
 target/arm/kvm.c           |  6 ++++++
 hw/intc/Kconfig            |  2 +-
 6 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index a4f68e14cb..008a72ccd4 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -200,6 +200,14 @@ bool kvm_arm_mte_supported(void);
  */
 int kvm_arm_get_type(MachineState *ms);
 
+/**
+ * kvm_arm_is_trapping_harder: return true if trapping harder
+ * @ms: Machine state handle
+ *
+ * return true if trapping harder
+ */
+bool kvm_arm_is_trapping_harder(MachineState *ms);
+
 /**
  * kvm_arm_get_max_vm_ipa_size:
  * @ms: Machine state handle
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 55433f8fce..e117433cc7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1998,9 +1998,16 @@ static void finalize_gic_version(VirtMachineState *vms)
             gics_supported |= VIRT_GIC_VERSION_3_MASK;
         }
     } else if (kvm_enabled() && !kvm_irqchip_in_kernel()) {
-        /* KVM w/o kernel irqchip can only deal with GICv2 */
+        MachineState *ms = MACHINE(vms);
         gics_supported |= VIRT_GIC_VERSION_2_MASK;
-        accel_name = "KVM with kernel-irqchip=off";
+        if (kvm_arm_is_trapping_harder(ms) &&
+            module_object_class_by_name("arm-gicv3")) {
+            gics_supported |= VIRT_GIC_VERSION_3_MASK;
+            accel_name = "TMH KVM with kernel-irqchip=off";
+        } else {
+            /* KVM w/o kernel irqchip can only deal with GICv2 */
+            accel_name = "KVM with kernel-irqchip=off";
+        }
     } else if (tcg_enabled() || hvf_enabled() || qtest_enabled())  {
         gics_supported |= VIRT_GIC_VERSION_2_MASK;
         if (module_object_class_by_name("arm-gicv3")) {
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 1cee68193c..9a46afaa0d 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -662,10 +662,6 @@ const char *gicv3_class_name(void)
     if (kvm_irqchip_in_kernel()) {
         return "kvm-arm-gicv3";
     } else {
-        if (kvm_enabled()) {
-            error_report("Userspace GICv3 is not supported with KVM");
-            exit(1);
-        }
         return "arm-gicv3";
     }
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e025e241ed..f7618a3038 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1463,7 +1463,7 @@ static void arm_cpu_initfn(Object *obj)
 # endif
 #else
     /* Our inbound IRQ and FIQ lines */
-    if (kvm_enabled()) {
+    if (kvm_enabled() && kvm_irqchip_in_kernel()) {
         /*
          * VIRQ, VFIQ, NMI, VINMI are unused with KVM but we add
          * them to maintain the same interface as non-KVM CPUs.
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ed0f6024d6..c5374d12cf 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -522,6 +522,12 @@ int kvm_arm_get_type(MachineState *ms)
     return s->trap_harder ? KVM_VM_TYPE_ARM_TRAP_ALL : 0;
 }
 
+bool kvm_arm_is_trapping_harder(MachineState *ms)
+{
+    KVMState *s = KVM_STATE(ms->accelerator);
+    return s->trap_harder;
+}
+
 int kvm_arch_get_default_type(MachineState *ms)
 {
     bool fixed_ipa;
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 7547528f2c..0eb37364a7 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -23,7 +23,7 @@ config APIC
 
 config ARM_GIC
     bool
-    select ARM_GICV3 if TCG
+    select ARM_GICV3 # can be used by TCG, HVF or KVM
     select ARM_GIC_KVM if KVM
     select MSI_NONBROKEN
 
-- 
2.47.2


