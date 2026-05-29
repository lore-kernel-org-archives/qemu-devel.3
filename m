Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD97ACD6E54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3E1-0006Eb-LI; Fri, 29 May 2026 15:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3Dz-0006BK-EL
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:50:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3Dx-0004gB-5a
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:50:31 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so147875025e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780084228; x=1780689028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cbtD0a+QduPKTnykEYf324+8lIDbZ8T/QVOG7u6Zyl4=;
 b=bByajw95KaxenCVXKloFuD9xktHuuLdQWUNYBpOZF1yX4BQbagLZQL2er0v7ARbPTm
 VLkJ/Lp56IWYdSZV/uI995FC8dsUIoLdiy+5nJ+T1BGRFujlsi2OuNl9/gVy7yptljZ8
 jD0Rs/5gSOYZnVnaW2wnT8WUvWvAZhqDJKRE8aaQqrXeqEtIdADsSv56/MpEz4fNZpoD
 8HaOiDjWtDFunHmxLhGFLxGVettRY70VNzHKd9Y7FJF6Kei4HJWhi+eo69IWn4vvaqi7
 9K8VML8OGg5jwxltBPWY4SUeAR9ag9rCIgBtBYckRg/6LZTc8Gw6P8FOm/KlZTjVrlWp
 bwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084228; x=1780689028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cbtD0a+QduPKTnykEYf324+8lIDbZ8T/QVOG7u6Zyl4=;
 b=He1Hx8H5dIANImiCiipxpjYvnS12PwJr50JYs1j1zED3HfIrOyPe24j6O6C9+Bn8ET
 EA9CbNdfjwAXM3IN4Oj61UXe4HEXjuaAmIXXmW5MbQDxEKSyDI5lSrmbuPbU7TA7IDWQ
 4LfVN8rAB8g6ByCI0T4bCZ7KbyBLjDy9cI3wzwS0nRtxaOe9XIo2DAgM/I+EEciBuTEp
 59AxKYSA1cX5MsjeMgXUGFsmNRIXKFv8k0atFzYwzikrx/gdTBQipT8GRfK0wDHcVaZa
 CnvYE05OlH8US+bd6AyISs0fZWnZaeERnJJYb0OaTTnVN93WPKuteijDLKlxW4WHOekh
 /6Sg==
X-Gm-Message-State: AOJu0YzBiq8FupOGYCmTMXRwO0W5WyO93YOq0w9J0IBohpf5KZ0Ul2Ed
 mNdR1z93nss0Q6mrZkAgqYlp3MN84/G5OYKjCL1vxhqllda7AYkBojfiqte9gVJ3ROemZNKOjCF
 uRxQvNy6faQ==
X-Gm-Gg: Acq92OExjr5r0DU6vLef6w8plaLOZumjarbb6+38IgZVOYcg2HY2ua5/LBgcIR05rrX
 s04i9+uXQYr0/huUH6Rf6kjDbIESb3up3INWT07odsL2qnWDtgRFyird4I/r0iZ00Y6vsFjV6kA
 El1/3EzTTKzVnfPgZI1Rwpr1w26tz37UB4ywpRUC6XOHbOEdy2qmJRGlrxCu91BZcnjTJKmMWcs
 dvqRfVn25WoPFjlDj+mt6We1P4OLkkyqevkcJODmw9aIGPt5FbZpFYnjBsE0yqarUoTXxYs+Pv5
 LjAtT80J5IHIOu4/TzmyUhZcnBq5CIHj5t06t4+4Mji4jL8V5UylewgCZywG4FBgSExOCXK96JT
 MkVyK2rOrBZfg6tJYNibL+G/NVr3fks7YrGPlPcQrsNROu6HEwWBBReP7EuK9EAGy16BRFLkms1
 cKfnM0IXrD2xjy3d5Z1L0qjhHTUweUbeMsd0FG5gUusnFoNZ7x+1TLgdpsOBfkGSNZMw==
X-Received: by 2002:a05:600c:c108:b0:490:50c5:8153 with SMTP id
 5b1f17b1804b1-490a290de68mr14778405e9.2.1780084227615; 
 Fri, 29 May 2026 12:50:27 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c104920sm20387615e9.21.2026.05.29.12.50.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 12:50:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, David Hildenbrand <david@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anton Johansson <anjo@rev.ng>, Claudio Fontana <cfontana@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Reinoud Zandijk <reinoud@netbsd.org>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/17] accel/kvm: Remove need for AccelCPUClass::cpu_realize
Date: Fri, 29 May 2026 21:49:27 +0200
Message-ID: <20260529194940.97143-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

accel_cpu_common_realize() first calls accel_cpu->cpu_realize
then ops->cpu_realize.

Rather than having one handler for each host architecture, use a
single host-specific method (prefixed with kvm_arch_* like other
similar KVM methods). Register it once as AccelOpsClass
cpu_realize handler. Add stubs for when a host lacks such method.

PPC's ACCEL_CPU_NAME("kvm") TypeInfo is  now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/kvm.h       |  2 ++
 accel/kvm/kvm-accel-ops.c  |  1 +
 target/arm/kvm.c           |  5 +++++
 target/i386/kvm/kvm-cpu.c  |  3 +--
 target/loongarch/kvm/kvm.c |  5 +++++
 target/ppc/kvm.c           | 23 +----------------------
 target/riscv/kvm/kvm-cpu.c | 10 +---------
 target/s390x/kvm/kvm.c     |  5 +++++
 8 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda3..cb077d6d863 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -223,6 +223,8 @@ void kvm_irqchip_add_change_notifier(Notifier *n);
 void kvm_irqchip_remove_change_notifier(Notifier *n);
 void kvm_irqchip_change_notify(void);
 
+bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
+
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
 
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 6d9140e549f..4e7e3039208 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -97,6 +97,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
     ops->create_vcpu_thread = kvm_start_vcpu_thread;
+    ops->cpu_realize = kvm_arch_cpu_realize;
     ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
     ops->cpus_are_resettable = kvm_cpus_are_resettable;
     ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7d194ea112b..22bd924a399 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1783,6 +1783,11 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
         "Eager Page Split chunk size for hugepages. (default: 0, disabled)");
 }
 
+bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
+{
+    return true;
+}
+
 int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index c34d9f15c7e..36634ec8929 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -39,7 +39,7 @@ static void kvm_set_guest_phys_bits(CPUState *cs)
     }
 }
 
-static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
+bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
@@ -237,7 +237,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
-    acc->cpu_target_realize = kvm_cpu_realizefn;
     acc->cpu_instance_init = kvm_cpu_instance_init;
 }
 static const TypeInfo kvm_cpu_accel_type_info = {
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 9d844c4905a..ec4c05006c6 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1495,3 +1495,8 @@ int kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
+
+bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
+{
+    return true;
+}
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b94c2997a07..013f5e852e1 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -49,7 +49,6 @@
 #include "elf.h"
 #include "system/kvm_int.h"
 #include "system/kvm.h"
-#include "accel/accel-cpu-target.h"
 
 #include CONFIG_DEVICES
 
@@ -2353,7 +2352,7 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
     }
 }
 
-static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
+bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
 {
     int ret;
     const char *vcpu_str = (cs->parent_obj.hotplugged == true) ?
@@ -2995,23 +2994,3 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
-
-static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_target_realize = kvmppc_cpu_realize;
-}
-
-static const TypeInfo kvm_cpu_accel_type_info = {
-    .name = ACCEL_CPU_NAME("kvm"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = kvm_cpu_accel_class_init,
-    .abstract = true,
-};
-static void kvm_cpu_accel_register_types(void)
-{
-    type_register_static(&kvm_cpu_accel_type_info);
-}
-type_init(kvm_cpu_accel_register_types);
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 17ba38403a3..7c4440d0025 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1990,14 +1990,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
     kvm_riscv_add_cpu_user_properties(obj);
 }
 
-/*
- * We'll get here via the following path:
- *
- * riscv_cpu_realize()
- *   -> cpu_exec_realizefn()
- *      -> kvm_cpu_realize() (via accel_cpu_common_realize())
- */
-static bool kvm_cpu_realize(CPUState *cs, Error **errp)
+bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     int ret;
@@ -2120,7 +2113,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
     acc->cpu_instance_init = kvm_cpu_instance_init;
-    acc->cpu_target_realize = kvm_cpu_realize;
 }
 
 static const TypeInfo kvm_cpu_accel_type_info = {
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 2e4f435c537..1c259652925 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2611,3 +2611,8 @@ int kvm_s390_topology_set_mtcr(uint64_t attr)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
+
+bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
+{
+    return true;
+}
-- 
2.53.0


