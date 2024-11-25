Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD1CD59D6A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFI-0005B9-I9; Mon, 25 Nov 2024 14:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFE-00057Y-5M
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:40 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF7-0004of-Ie
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:39 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4349e4e252dso14143545e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564771; x=1733169571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVDgLJZAGkfB+8H1cL/Q3uYqegohVBa+MtPvms4CCZc=;
 b=UCtL3JwmdrieI5FheeyJF5KI/caoRzLSBP7aYd+d8UjoRQNTpTTDhU0n47A+JLTdTy
 VYKnwfpebHgLSL9hC2RgWtHhhdZ8qoa8h2Nv5QUKcWJ2f4e9inKBBi/GG086xHgfUIpB
 SMX4XIpKt58TIZWwCQ4lfYk02YQjD6HipChpg7w2ZdfNjlakDzm/C3bQcFLrGtUFFl1/
 JsEEeBDKnIzKZqwIi0Z73UHCVlycWnN8ilgKYZs70kkLklrmJP8vfG67Gt+5KvGWmPrW
 4DCiv2dVabZ0jahXOyQk4wlBmboht2f5eFGmUJGEwXknxFSnkTgNGUcoAq11f+QJzTJa
 zjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564771; x=1733169571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVDgLJZAGkfB+8H1cL/Q3uYqegohVBa+MtPvms4CCZc=;
 b=v77+6oiL+1YeIJ3W5ZJdov9Sv9nYTTjxxtNlKG24zaAO2uczLVPHldn35niPwiQLtg
 CMhfv2vzzpq7F0/1yTW5jWyLyFreEnQ4/7AIZMs7b01JmQA3l3IyYIOxl+Ta+jNWrpqx
 yfioL1690XCqQTs7fdssoME7yDz+uLLfPVkHgNmObHQ1fjRTu2ooJCPG0OA3aMhSgd+s
 wtEeHAbqVHdQOt4ievFcWsZExCa+8EOdWR27nEGtZ40lQE4BnwVlAg0QxZLo0Z+xUGRC
 ZhD2OhpkbmZsvs076Mou2o67KoXLyndP16oP573S+4fD9Uw3vzCNEmcvf0hkKZ3oJVJW
 KBig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyWBnlDrFXxRR8ShpueWjaE0Kh0oe5R+e90Jr+NCh6KUktDWCAvA6C5/rW122vAf1wZcbkxLAxJuDF@nongnu.org
X-Gm-Message-State: AOJu0YxK9J1zVJh3JjNV0IkC0c22OSvYifQshUZZ0ccUgT38gymSDUoP
 iETi4JyYVRKkYOnI/MU9N0BnI5aUpotxNz85lLhJ7v+9Hy7W83cDxYyWNbs2OyE=
X-Gm-Gg: ASbGncuNoNTSOp1b502C1AN2ksPJ69pCq6G4UdfTgKYyaKoFjjrJYJhImjbthFmGWSU
 am4NwJyAw32pM3z40x92TSw9Rqt46auZ1aJrd4kimYewT+yaobRVrPQecDJGNn/qQKj9hvMoBW6
 0cniEd6IJk1Kgmwk6rz+90Kx8oM7OKjZb6njaOlkdtsa0ImWqkRoiJVh0xAqgbpSgqU11iJn6R+
 ESn6haCeY//ul5/rPmoES5zLRZ2RDDIAgW2MsxEmjpdPOrxXNo/VmWLdafPFN2YXami
X-Google-Smtp-Source: AGHT+IEaC1ttBSm2FtMlk4y0oHvFOQX7SKISqb0ItjMzkK9PFyhTNsAw3VpBr4qH7Z44KcuwSkVF0w==
X-Received: by 2002:a05:600c:510b:b0:431:1d97:2b0a with SMTP id
 5b1f17b1804b1-433ce42875cmr136065045e9.15.1732564771511; 
 Mon, 25 Nov 2024 11:59:31 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:31 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 12/26] target/arm/cpu: Set number of breakpoints and
 watchpoints in KVM
Date: Mon, 25 Nov 2024 19:56:11 +0000
Message-ID: <20241125195626.856992-14-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32e.google.com
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

Add "num-breakpoints" and "num-watchpoints" CPU parameters to configure
the debug features that KVM presents to the guest. The KVM vCPU
configuration is modified by calling SET_ONE_REG on the ID register.

This is needed for Realm VMs, whose parameters include breakpoints and
watchpoints, and influence the Realm Initial Measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/cpu.h          |  4 ++
 target/arm/kvm_arm.h      |  2 +
 target/arm/arm-qmp-cmds.c |  1 +
 target/arm/cpu64.c        | 77 +++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c          | 56 +++++++++++++++++++++++++++-
 5 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f617591921..5cef43a8d2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1109,6 +1109,10 @@ struct ArchCPU {
 
     /* Generic timer counter frequency, in Hz */
     uint64_t gt_cntfrq_hz;
+
+    /* Allows to override the default configuration */
+    uint8_t num_bps;
+    uint8_t num_wps;
 };
 
 typedef struct ARMCPUInfo {
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 67db09a424..28ebec8580 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -16,6 +16,8 @@
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
 
+#define KVM_REG_ARM_ID_AA64DFR0_EL1     ARM64_SYS_REG(3, 0, 0, 5, 0)
+
 /**
  * kvm_arm_register_device:
  * @mr: memory region for this device
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 3cc8cc738b..0f574bb1dd 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -95,6 +95,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
     "pauth", "pauth-impdef", "pauth-qarma3",
+    "num-breakpoints", "num-watchpoints",
     NULL
 };
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 458d1cee01..1d4f4c134d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -576,6 +576,82 @@ void aarch64_add_pauth_properties(Object *obj)
     }
 }
 
+#if defined(CONFIG_KVM)
+static void arm_cpu_get_num_wps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    val = cpu->num_wps;
+    if (val == 0) {
+        val = FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, WRPS) + 1;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_wps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_wps = FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, WRPS) + 1;
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val < 2 || val > max_wps) {
+        error_setg(errp, "invalid number of watchpoints");
+        return;
+    }
+
+    cpu->num_wps = val;
+}
+
+static void arm_cpu_get_num_bps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    val = cpu->num_bps;
+    if (val == 0) {
+        val = FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, BRPS) + 1;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_bps = FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, BRPS) + 1;
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val < 2 || val > max_bps) {
+        error_setg(errp, "invalid number of breakpoints");
+        return;
+    }
+
+    cpu->num_bps = val;
+}
+
+static void aarch64_add_kvm_writable_properties(Object *obj)
+{
+    object_property_add(obj, "num-breakpoints", "uint8", arm_cpu_get_num_bps,
+                        arm_cpu_set_num_bps, NULL, NULL);
+    object_property_add(obj, "num-watchpoints", "uint8", arm_cpu_get_num_wps,
+                        arm_cpu_set_num_wps, NULL, NULL);
+}
+#endif /* CONFIG_KVM */
+
 void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 {
     uint64_t t;
@@ -726,6 +802,7 @@ static void aarch64_host_initfn(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
         aarch64_add_pauth_properties(obj);
+        aarch64_add_kvm_writable_properties(obj);
     }
 #elif defined(CONFIG_HVF)
     ARMCPU *cpu = ARM_CPU(obj);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 870f51bf02..f6d45476b4 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -336,7 +336,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64smfr0,
                               ARM64_SYS_REG(3, 0, 0, 4, 5));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr0,
-                              ARM64_SYS_REG(3, 0, 0, 5, 0));
+                              KVM_REG_ARM_ID_AA64DFR0_EL1);
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr1,
                               ARM64_SYS_REG(3, 0, 0, 5, 1));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar0,
@@ -887,6 +887,54 @@ out:
     return ret;
 }
 
+static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
+{
+    int ret;
+    uint64_t val, newval;
+    CPUState *cs = CPU(cpu);
+
+    if (!cpu->num_bps && !cpu->num_wps) {
+        return;
+    }
+
+    newval = cpu->isar.id_aa64dfr0;
+    if (cpu->num_bps) {
+        uint64_t ctx_cmps = FIELD_EX64(newval, ID_AA64DFR0, CTX_CMPS);
+
+        /* CTX_CMPs is never greater than BRPs */
+        ctx_cmps = MIN(ctx_cmps, cpu->num_bps - 1);
+        newval = FIELD_DP64(newval, ID_AA64DFR0, BRPS, cpu->num_bps - 1);
+        newval = FIELD_DP64(newval, ID_AA64DFR0, CTX_CMPS, ctx_cmps);
+    }
+    if (cpu->num_wps) {
+        newval = FIELD_DP64(newval, ID_AA64DFR0, WRPS, cpu->num_wps - 1);
+    }
+    ret = kvm_set_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &newval);
+    if (ret) {
+        error_report("Failed to set KVM_REG_ARM_ID_AA64DFR0_EL1");
+        return;
+    }
+
+    /*
+     * Check if the write succeeded. KVM does offer the writable mask for this
+     * register, but this way we also check if the value we wrote was sane.
+     */
+    ret = kvm_get_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &val);
+    if (ret) {
+        error_report("Failed to get KVM_REG_ARM_ID_AA64DFR0_EL1");
+        return;
+    }
+
+    if (val != newval) {
+        error_report("Failed to update KVM_REG_ARM_ID_AA64DFR0_EL1");
+    }
+}
+
+static void kvm_arm_configure_vcpu_regs(ARMCPU *cpu)
+{
+    kvm_arm_configure_aa64dfr0(cpu);
+}
+
 /**
  * kvm_arm_cpreg_level:
  * @regidx: KVM register index
@@ -1006,6 +1054,12 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
         fprintf(stderr, "kvm_arm_vcpu_init failed: %s\n", strerror(-ret));
         abort();
     }
+
+    /*
+     * Before loading the KVM values into CPUState, update the KVM configuration
+     */
+    kvm_arm_configure_vcpu_regs(cpu);
+
     if (!write_kvmstate_to_list(cpu)) {
         fprintf(stderr, "write_kvmstate_to_list failed\n");
         abort();
-- 
2.47.0


