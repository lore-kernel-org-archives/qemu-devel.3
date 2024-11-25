Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CA6D59D69
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFC-00054n-6a; Mon, 25 Nov 2024 14:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFA-00053U-NP
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:36 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF3-0004lm-Ik
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:36 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4315c1c7392so44908285e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564768; x=1733169568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQShuah4RPH85LfDxttMiyLaDhN+5oe8+p7fsP3yrqw=;
 b=Hjp7ITOh5IP7JhGktCFoYf8vNtdYeQvOA2ogi7mXb/j0OvTQMWuYU4d1dfE70beTo8
 43iLzcixST38wZV3y38WpWKvL2WeJ7CvqcbvgNL5mjz/MlgCOY+UafU3DIosbBC4otG7
 HhSLs50Otuw+YDNhC2TjpaokCBkBcpQhLfduSDkY2QwFvnou/XVJNjDAAtnSnKH5dsKt
 u2ytpZUL90bzF5R6cF2AEfJFmBKM9acrnM63XKPJcDOUKKpDVzMkELxgUm3snijplE+r
 thdXhzwKRC3BI+JlItupjcaUS+iQzKd9/SWNYeQYG8LoX5nDUw/3tx/Xqb3WzGiVsDkL
 xU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564768; x=1733169568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQShuah4RPH85LfDxttMiyLaDhN+5oe8+p7fsP3yrqw=;
 b=ki+tB4pcK2rDce2h1z1OjaKbR3sG1Nz2WXJ2Co/6x26NFDow0f36KYseoB0RSjTOZY
 sNpKPrHJDeHgFFQhncuGo/DjiuXnhjbLZIwP6pH1ctt1/9Hn9hUllRCRVS6ovOAuaB2L
 OhC7j0aA3fkVk7L1yUXxfuTFGrqdCMoHdaZvVQkFYL8NX0LBFCzd9rghnIqyhNxr4iBT
 Gy0z338iOANVM3JSDiQRToNtYe+dBgTuNjjs2rErXTJjfve5bxkUjKLUzgHc6wZ8wSYh
 ZMoJl29m5pyJ8drqGGiZ45HWvciJAvX84XNv+YHrxNyi7tsQG5bM9VWDlhcY7NKJLau7
 cp4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgTHmeE/O9M+PAlyvnuEXnYteOUOyupp6NSzBL6mRfIEFgcbVUmgUaST6iMgZzYgJo8Jtwp3EaB5JJ@nongnu.org
X-Gm-Message-State: AOJu0Yx+KI6NmQHyOMkdF8a0NaSpqaAfAgceuDxeGOxxqpG/eTrld8Ei
 HDwelQ1fEjT09MCqbLaJSAxlyhIFZ78pDw2i1eiqgZlZzegYDKhGTJyb65drx7A=
X-Gm-Gg: ASbGncu/g8WtU6uIDouTo5EWvpvykxVjL+bl0fdJi5sfEXStMyICFWpBLtzU74jAHHo
 2nL4DbfR+Zl3f31kX519/oKuIGC+CePUFE2CKzDkVtKlkosofWHiljTs6DbYqDIdRvz6htPwvIY
 /IcpdQ01cMrZ/aq3O3gqqmHnwMh09ZQ6YUl3iMkepBh+J+F5HgohWcIdxMhk6hPRB2PM/Io/bfj
 pe1/Wmrpel/vkTPnPHxo5rh9B6sT53xsj8p5mZrk2yLeXvJwvFXfkLW53BUBnvUaafr
X-Google-Smtp-Source: AGHT+IHu0epn53EoPbJ5rBYNXd0hSz17fN6MkrV+SiPxv6AdYWmai7LEbVLtwK/yGBV3nNkYp1vi2g==
X-Received: by 2002:a05:6000:1f82:b0:37d:5364:d738 with SMTP id
 ffacd0b85a97d-38260bcc4cemr12792210f8f.45.1732564768083; 
 Mon, 25 Nov 2024 11:59:28 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:27 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 06/26] target/arm/kvm-rme: Initialize vCPU
Date: Mon, 25 Nov 2024 19:56:05 +0000
Message-ID: <20241125195626.856992-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32b.google.com
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

The target code calls kvm_arm_vcpu_init() to mark the vCPU as part of a
Realm. For a Realm vCPU, only x0-x7 can be set at runtime. Before boot,
the PC can also be set, and is ignored at runtime. KVM also accepts a
few system register changes during initial configuration, as returned by
KVM_GET_REG_LIST.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/cpu.h     |  3 +++
 target/arm/kvm_arm.h | 15 +++++++++++
 target/arm/kvm-rme.c | 10 ++++++++
 target/arm/kvm.c     | 61 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d86e641280..f617591921 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -961,6 +961,9 @@ struct ArchCPU {
     OnOffAuto kvm_steal_time;
 #endif /* CONFIG_KVM */
 
+    /* Realm Management Extension */
+    bool kvm_rme;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 9d6a89f9b1..8b52a881b0 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -245,6 +245,16 @@ int kvm_arm_rme_init(MachineState *ms);
  */
 int kvm_arm_rme_vm_type(MachineState *ms);
 
+/**
+ * kvm_arm_rme_vcpu_init
+ * @cs: the CPU
+ *
+ * If the user requested a Realm, setup the given vCPU accordingly. Realm vCPUs
+ * behave a little differently, for example most of their register state is
+ * hidden from the host.
+ */
+int kvm_arm_rme_vcpu_init(CPUState *cs);
+
 #else
 
 /*
@@ -339,6 +349,11 @@ static inline int kvm_arm_rme_vm_type(MachineState *ms)
     g_assert_not_reached();
 }
 
+static inline int kvm_arm_rme_vcpu_init(CPUState *cs)
+{
+    g_assert_not_reached();
+}
+
 #endif
 
 #endif
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 60d967a842..e3cc37538a 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -137,6 +137,16 @@ int kvm_arm_rme_init(MachineState *ms)
     return 0;
 }
 
+int kvm_arm_rme_vcpu_init(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    if (rme_guest) {
+        cpu->kvm_rme = true;
+    }
+    return 0;
+}
+
 int kvm_arm_rme_vm_type(MachineState *ms)
 {
     if (rme_guest) {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0c80992f7c..a0de2efc41 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1926,6 +1926,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
 
+    ret = kvm_arm_rme_vcpu_init(cs);
+    if (ret) {
+        return ret;
+    }
+
     if (cpu_isar_feature(aa64_sve, cpu)) {
         ret = kvm_arm_sve_set_vls(cpu);
         if (ret) {
@@ -2062,6 +2067,35 @@ static int kvm_arch_put_sve(CPUState *cs)
     return 0;
 }
 
+static int kvm_arm_rme_put_core_regs(CPUState *cs, Error **errp)
+{
+    int i, ret;
+    struct kvm_one_reg reg;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    /*
+     * The RME ABI only allows us to set 8 GPRs and the PC
+     */
+    for (i = 0; i < 8; i++) {
+        reg.id = AARCH64_CORE_REG(regs.regs[i]);
+        reg.addr = (uintptr_t) &env->xregs[i];
+        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    reg.id = AARCH64_CORE_REG(regs.pc);
+    reg.addr = (uintptr_t) &env->pc;
+    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static int kvm_arm_put_core_regs(CPUState *cs, int level, Error **errp)
 {
     uint64_t val;
@@ -2072,6 +2106,10 @@ static int kvm_arm_put_core_regs(CPUState *cs, int level, Error **errp)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
+    if (cpu->kvm_rme) {
+        return kvm_arm_rme_put_core_regs(cs, errp);
+    }
+
     /* If we are in AArch32 mode then we need to copy the AArch32 regs to the
      * AArch64 registers before pushing them out to 64-bit KVM.
      */
@@ -2259,6 +2297,25 @@ static int kvm_arch_get_sve(CPUState *cs)
     return 0;
 }
 
+static int kvm_arm_rme_get_core_regs(CPUState *cs, Error **errp)
+{
+    int i, ret;
+    struct kvm_one_reg reg;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    for (i = 0; i < 8; i++) {
+        reg.id = AARCH64_CORE_REG(regs.regs[i]);
+        reg.addr = (uintptr_t) &env->xregs[i];
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
@@ -2269,6 +2326,10 @@ static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
+    if (cpu->kvm_rme) {
+        return kvm_arm_rme_get_core_regs(cs, errp);
+    }
+
     for (i = 0; i < 31; i++) {
         ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
                               &env->xregs[i]);
-- 
2.47.0


