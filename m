Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA3FD59D67
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFF-00058Y-Jy; Mon, 25 Nov 2024 14:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFB-00054c-S4
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:37 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF4-0004ly-0o
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:37 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3824446d2bcso4300921f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564768; x=1733169568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1yqlpej3WjW1JQDA6ksx54DWAhTx2FxYXSqrclmH28=;
 b=VfZ9MnM1GfBL5TzHBhsMp8SFlKTnEpX8aq8uZ/3GQRcL+9zU+vVfEKkizT0hS/3R0t
 yEbSBNATrlZyK9xTEIvxzLSriAM1EztFG8s0NJ3eTCJiWm/OvRFXtxaGkSqtMXWmA6ks
 gmP9rs5whUBQ++Bho4mBvgUtCVOsxca49FRPs5nlwqzUTEI4CG3coZqm7Ynz/SkJOvnE
 OSiFgbBE28lBkuxSmHymx0neYSI7tQDNSAagiK+Av+9rcr8Lns/QmOqaaLFlHyCipfx1
 WGznofsvreDHtRRE0q6v8OWx5OyzC1FPUMtIx6Zj+t3gvbXjE6OOT1KsWTOiHrppZ4V+
 cJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564768; x=1733169568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1yqlpej3WjW1JQDA6ksx54DWAhTx2FxYXSqrclmH28=;
 b=qOa8Ss5MuZJUNn+G5FuiURzjgn+62ndE77NWEJ/UNXCVrtr13ELspsHDgacj15xmzp
 B/7OrWibsUxh32/97LwBIxEymm6n5CsweRPavuoaTLxjkzwNOXREw16kQhgxL8BjGsXa
 JtFpt/vSdPy2GG/T7Pz4ap1kRWXmw9v3nxWQTqJtXzTI9ID9RAiOQkBSiL//eI6oUn2e
 yZITrlgKnWCeEgmFD4x1Lmay0jonUJ+BOnTND81yExL5cV2c/Ean1/dHTgebhU9N5GDF
 SPTt1gAmhdnCm9A/aI5uprQlxXIDWw+cgaBeZyR4mItVlQXyrj/c7vj8NLahnIT91t7m
 hGkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUqnHYHp0yXtrRBcUcVDozIkGBYJ0CZpAQEHANdeIfRm+ncrYFf7LGJ88zLo6rvqecWxg4jD8ErG/z@nongnu.org
X-Gm-Message-State: AOJu0Yxd/Jy6vE/dhLMvUQn44MRz0tjVReC7exh0NZb4Bbh826F+/tXC
 Kr6UzJsNlvByW+QrvbUjlwecXqrAJw3CfNhq1mwAgs6mqU/KYF4jm3V27p5clJo=
X-Gm-Gg: ASbGncs/VU/AZ9kUXpf3RJpYYcRfxEbUg1a0t9zmPoB9sUiRDsHa4DHgxLMGXLT74uV
 NLe6noOTddAGg2IMDIYq7aW+VbgWUBRE2bt2msHgVi2GGdoC/AlQKJYo2ofoYwVSQLWd9Y+yOMm
 dq9WFy/YORbgMP+OurUR+0J/7UDVsTntZBErrocDkWrLyx+kSNGm/njg5/o9tRC/lx+5Y9Ju3/l
 34m+MOXpryL0Uk7KK/6TQP0fA2iUl2TJ/IP8M/7mmWrsKk/zRET6mScUWVyISx8h5j0
X-Google-Smtp-Source: AGHT+IFsIzPEH/whkFkArGEmVc/nnWnbFUS8SKjy/3ZNik9sJI/dbV0ygS/lbB2p3m1K4Zl/8as48w==
X-Received: by 2002:a5d:47cc:0:b0:382:506b:f627 with SMTP id
 ffacd0b85a97d-38260bea7a0mr17079479f8f.57.1732564766896; 
 Mon, 25 Nov 2024 11:59:26 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:26 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 04/26] target/arm/kvm-rme: Initialize realm
Date: Mon, 25 Nov 2024 19:56:03 +0000
Message-ID: <20241125195626.856992-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The machine code calls kvm_arm_rme_vm_type() to get the VM flag and KVM
calls kvm_arm_rme_init() to prepare for launching a Realm. Once VM
creation is complete, create the Realm:

* Create the realm descriptor,
* load images into Realm RAM (in another patch),
* finalize the REC (vCPU) after the registers are reset,
* activate the realm, at which point the realm is sealed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2->v3:
* Cleaner error handling
---
 target/arm/kvm_arm.h |  39 ++++++++++++++++
 target/arm/kvm-rme.c | 106 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c     |   9 +++-
 3 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 2e6b49bf13..9d6a89f9b1 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -153,6 +153,14 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
  */
 void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
 
+/**
+ * @cpu: The CPU object to finalize
+ * @feature: a KVM_ARM_VCPU_* feature
+ *
+ * Finalize the configuration of the given vcpu feature.
+ */
+int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature);
+
 /**
  * kvm_arm_steal_time_finalize:
  * @cpu: ARMCPU for which to finalize kvm-steal-time
@@ -221,6 +229,22 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
 
+/**
+ * kvm_arm_rme_init
+ * @ms: the machine state
+ *
+ * Prepare the machine to be a Realm, if the user enabled it.
+ */
+int kvm_arm_rme_init(MachineState *ms);
+
+/**
+ * kvm_arm_rme_vm_type
+ * @ms: the machine state
+ *
+ * Returns the Realm KVM VM type if the user requested a Realm, 0 otherwise.
+ */
+int kvm_arm_rme_vm_type(MachineState *ms);
+
 #else
 
 /*
@@ -260,6 +284,11 @@ static inline void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
     g_assert_not_reached();
 }
 
+static inline int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature)
+{
+    g_assert_not_reached();
+}
+
 static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
 {
     g_assert_not_reached();
@@ -300,6 +329,16 @@ static inline void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
     g_assert_not_reached();
 }
 
+static inline int kvm_arm_rme_init(MachineState *ms)
+{
+    g_assert_not_reached();
+}
+
+static inline int kvm_arm_rme_vm_type(MachineState *ms)
+{
+    g_assert_not_reached();
+}
+
 #endif
 
 #endif
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 67909349c1..60d967a842 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -12,6 +12,7 @@
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
@@ -27,14 +28,119 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
                                           CONFIDENTIAL_GUEST_SUPPORT,
                                           { TYPE_USER_CREATABLE }, { })
 
+static RmeGuest *rme_guest;
+
+static int rme_init_cpus(Error **errp)
+{
+    int ret;
+    CPUState *cs;
+
+    /*
+     * Now that do_cpu_reset() initialized the boot PC and
+     * kvm_cpu_synchronize_post_reset() registered it, we can finalize the REC.
+     */
+    CPU_FOREACH(cs) {
+        ret = kvm_arm_vcpu_finalize(ARM_CPU(cs), KVM_ARM_VCPU_REC);
+        if (ret) {
+            error_setg_errno(errp, -ret, "failed to finalize vCPU");
+            return ret;
+        }
+    }
+    return 0;
+}
+
+static int rme_create_realm(Error **errp)
+{
+    int ret;
+
+    ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
+                            KVM_CAP_ARM_RME_CREATE_RD);
+    if (ret) {
+        error_setg_errno(errp, -ret, "failed to create Realm Descriptor");
+        return -1;
+    }
+
+    if (rme_init_cpus(errp)) {
+        return -1;
+    }
+
+    ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
+                            KVM_CAP_ARM_RME_ACTIVATE_REALM);
+    if (ret) {
+        error_setg_errno(errp, -ret, "failed to activate realm");
+        return -1;
+    }
+
+    kvm_mark_guest_state_protected();
+    return 0;
+}
+
+static void rme_vm_state_change(void *opaque, bool running, RunState state)
+{
+    Error *err = NULL;
+
+    if (!running) {
+        return;
+    }
+
+    if (rme_create_realm(&err)) {
+        error_propagate_prepend(&error_fatal, err, "RME: ");
+    }
+}
+
 static void rme_guest_class_init(ObjectClass *oc, void *data)
 {
 }
 
 static void rme_guest_init(Object *obj)
 {
+    if (rme_guest) {
+        error_report("a single instance of RmeGuest is supported");
+        exit(1);
+    }
+    rme_guest = RME_GUEST(obj);
 }
 
 static void rme_guest_finalize(Object *obj)
 {
 }
+
+int kvm_arm_rme_init(MachineState *ms)
+{
+    static Error *rme_mig_blocker;
+    ConfidentialGuestSupport *cgs = ms->cgs;
+
+    if (!rme_guest) {
+        return 0;
+    }
+
+    if (!cgs) {
+        error_report("missing -machine confidential-guest-support parameter");
+        return -EINVAL;
+    }
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_ARM_RME)) {
+        return -ENODEV;
+    }
+
+    error_setg(&rme_mig_blocker, "RME: migration is not implemented");
+    migrate_add_blocker(&rme_mig_blocker, &error_fatal);
+
+    /*
+     * The realm activation is done last, when the VM starts, after all images
+     * have been loaded and all vcpus finalized.
+     */
+    qemu_add_vm_change_state_handler(rme_vm_state_change, NULL);
+
+    cgs->require_guest_memfd = true;
+    cgs->ready = true;
+    return 0;
+}
+
+int kvm_arm_rme_vm_type(MachineState *ms)
+{
+    if (rme_guest) {
+        return KVM_VM_TYPE_ARM_REALM;
+    }
+    return 0;
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 95bcecf804..440c3ac8c6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -95,7 +95,7 @@ static int kvm_arm_vcpu_init(ARMCPU *cpu)
  *
  * Returns: 0 if success else < 0 error code
  */
-static int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature)
+int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature)
 {
     return kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_VCPU_FINALIZE, &feature);
 }
@@ -627,7 +627,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return 0;
+    ret = kvm_arm_rme_init(ms);
+    if (ret) {
+        error_report("Failed to enable RME: %s", strerror(-ret));
+    }
+
+    return ret;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-- 
2.47.0


