Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B129C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqUR-0004M7-6w; Thu, 22 Jan 2026 03:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqUL-0003wD-Vy
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:56:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqUK-0006MY-10
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:56:25 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801ea9bafdso2699675e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072182; x=1769676982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UlYQhM307T6PicxGrT5ytshKgfYODSEDN2EV8KGcc6I=;
 b=WfDVmOUwunVGBl1VdejnmltBcJjh8IDccw/dpLpSbFGTOtRtQ0NAUW5zBfPGWE0xN5
 pRqHBoqxMFAI8xtKNQp6sm9mD9ng4kN84JL51ZVPQMUQ3bv9gUSNPy5FjF//XfbS6xl8
 mhg8aRQvEcdahsa53yAwr+3J/vIIhWXNi2+tZnFw8/Jp17ly1L1sRag37f+KhsDN8YGM
 q/eu8yey0rsH4LuG5aCDXK60hfn3i3K/D6pFRH2kPe5rwY3ZjSa1iOg3HN00xrOG2f39
 AojrcA+sJYEpFj76H76Az8oYKULKkGvOAZNwBNm5LckqqTbq//IITSkTeOABb6Vn5Z+u
 sudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072182; x=1769676982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UlYQhM307T6PicxGrT5ytshKgfYODSEDN2EV8KGcc6I=;
 b=dL0lxDNR0GE2OKb7DQ6pbFvJaAFRN1qbB2djXvECRQrIWjszvpPDfnauq/XPWU0Veg
 ENg1QyXoZGtEd7QUOj6pDnMgLSl4la0VPjxvvAIZIzhvHHrZyVGlcYMbB91AUVZA2Dlj
 4KY8FyLuiXNv8BbYPPbGW8vUZtl8KD8mpySxcoDmZIa7JCqHDoWXiVFU86tZqDPsOHGy
 3vgZr7c2pW6S6Ueo9OOJleicl29jPqgk6S6ZxnxSzUikbXHvAUSd70tXMoHO98KPFPHe
 rEpfu59HV+NP1ShXQyW2xy2px5ZKD/IstgvDnvVYw3rb0A8qhXYhGkCEPxtquj5jlXWu
 7bwg==
X-Gm-Message-State: AOJu0Yy2e2VODy6qRaMROVf7u6OC8B5vh7U87jTg6CyLRJcr89z6HfQJ
 4aPsEspETm/Z8QaVgkVMjBQOtMCmHn3Yag87mSK+PPuEkaplo2YshoUuBoFZ1ECCAwBsLDWX/ab
 AWdj+H2M=
X-Gm-Gg: AZuq6aLiULSyzLWHC2cmFgS44l2xAQpH77t4OWxku0jfQpdxtHMlQKR7DSxRSGtcKOp
 UtnryZ4mQhlO6sd/+pebXNmZyoJeJXuPbfLJx8xg9WtFEetLa7KngeWyD7fdvf+a/XbN1AdSRrr
 77qqJkZZAG6WBTY0MMqyycU4AFMV4ChG+kniWKzWNAmC5BuQrPispBKPUqwTBpkNTnicKRX+e1E
 /Vpl2RMqbEJ1OoE9J7j5kwYS0KCAIHdahbxrFHYJYQ6PJzpOb86E3/FeK4Sw97EUEQqLS8wFUFZ
 3eUC/qtXNGuOwDBGC5RPFFiyJNZIgW59hsJmUpOrL70rDDQnIo+jUGeZcXiHQcnwvCLzQo7nXK4
 0JfuDuYB7bqAaOOQ6Pg1QlmNSS2i6wVE0Yc0WRdbvEdqWTpC4V+gz3kH5xzmDuGBYNtzry7A9MQ
 GMEtc1RrJ5JsgFy45TMYxbfmAS4wmTq7eDIWfYo/0XGa/dZufGz7oe8EYEHm4dHaBq6K8aOJU=
X-Received: by 2002:a05:600c:8b27:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-48022668fd4mr279349775e9.7.1769072181958; 
 Thu, 22 Jan 2026 00:56:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48048b49880sm38355065e9.11.2026.01.22.00.56.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:56:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/31] cpus: Allocate maximum number of ASes supported by the
 arch
Date: Thu, 22 Jan 2026 09:52:54 +0100
Message-ID: <20260122085255.95035-32-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Instead of computing the number of address spaces used for a given
architecture, machine, and CPU configuration, simplify the code by
always allocating the maximum number of CPUAddressSpaces supported
by the architecture.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260116185814.108560-5-gustavo.romero@linaro.org>
---
 include/exec/cpu-common.h        |  4 ----
 include/hw/core/cpu.h            |  7 +++++--
 hw/core/cpu-common.c             |  1 -
 hw/core/cpu-system.c             |  2 +-
 system/cpus.c                    |  1 -
 system/physmem.c                 |  8 ++++----
 target/arm/cpu.c                 | 11 +----------
 target/i386/cpu.c                |  1 +
 target/i386/kvm/kvm-cpu.c        |  1 -
 target/i386/tcg/system/tcg-cpu.c |  1 -
 10 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b2e02c60d4a..1eb28734601 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -51,10 +51,6 @@ void tcg_iommu_free_notifier_list(CPUState *cpu);
  * The target-specific code which registers ASes is responsible
  * for defining what semantics address space 0, 1, 2, etc have.
  *
- * Before the first call to this function, the caller must set
- * cpu->num_ases to the total number of address spaces it needs
- * to support.
- *
  * Note that with KVM only one address space is supported.
  */
 void cpu_address_space_init(CPUState *cpu, int asidx,
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index f6f17df9e64..61da2ea4331 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -145,6 +145,9 @@ struct SysemuCPUOps;
  * address before attempting to match it against watchpoints.
  * @deprecation_note: If this CPUClass is deprecated, this field provides
  *                    related information.
+ * @max_as: Maximum valid index used to refer to the address spaces supported by
+ *          the architecture, i.e., to refer to CPUAddressSpaces in
+ *          CPUState::cpu_ases.
  *
  * Represents a CPU family or model.
  */
@@ -195,6 +198,8 @@ struct CPUClass {
     int reset_dump_flags;
     int gdb_num_core_regs;
     bool gdb_stop_before_watchpoint;
+
+    int max_as;
 };
 
 /*
@@ -443,7 +448,6 @@ struct qemu_work_item;
  * @icount_extra: Instructions until next timer event.
  * @cpu_ases: Pointer to array of CPUAddressSpaces (which define the
  *            AddressSpaces this CPU has)
- * @num_ases: number of CPUAddressSpaces in @cpu_ases
  * @as: Pointer to the first AddressSpace, for the convenience of targets which
  *      only have a single AddressSpace
  * @gdb_regs: Additional GDB registers.
@@ -516,7 +520,6 @@ struct CPUState {
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     struct CPUAddressSpace *cpu_ases;
-    int num_ases;
     AddressSpace *as;
     MemoryRegion *memory;
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 6d54c12a778..e314f916f84 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -310,7 +310,6 @@ static void cpu_common_initfn(Object *obj)
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
     cpu->as = NULL;
-    cpu->num_ases = 0;
     /* user-mode doesn't have configurable SMP topology */
     /* the default value is changed by qemu_init_vcpu() for system-mode */
     cpu->nr_threads = 1;
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 48c8ddf4b15..4a91c3e8ece 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -86,7 +86,7 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
 
     if (cpu->cc->sysemu_ops->asidx_from_attrs) {
         ret = cpu->cc->sysemu_ops->asidx_from_attrs(cpu, attrs);
-        assert(ret < cpu->num_ases && ret >= 0);
+        assert(ret <= cpu->cc->max_as && ret >= 0);
     }
     return ret;
 }
diff --git a/system/cpus.c b/system/cpus.c
index 49deeb9468a..bded87feb1c 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -718,7 +718,6 @@ void qemu_init_vcpu(CPUState *cpu)
         /* If the target cpu hasn't set up any address spaces itself,
          * give it the default one.
          */
-        cpu->num_ases = 1;
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
diff --git a/system/physmem.c b/system/physmem.c
index 9a7aba9521d..b0311f45312 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -786,8 +786,8 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     address_space_init(as, mr, as_name);
     g_free(as_name);
 
-    /* Target code should have set num_ases before calling us */
-    assert(asidx < cpu->num_ases);
+    /* Target code should have set max_as before calling us */
+    assert(asidx <= cpu->cc->max_as);
 
     if (asidx == 0) {
         /* address space 0 gets the convenience alias */
@@ -795,7 +795,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     }
 
     if (!cpu->cpu_ases) {
-        cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
+        cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->cc->max_as + 1);
     }
 
     newas = &cpu->cpu_ases[asidx];
@@ -819,7 +819,7 @@ void cpu_destroy_address_spaces(CPUState *cpu)
     /* convenience alias just points to some cpu_ases[n] */
     cpu->as = NULL;
 
-    for (asidx = 0; asidx < cpu->num_ases; asidx++) {
+    for (asidx = 0; asidx <= cpu->cc->max_as; asidx++) {
         cpuas = &cpu->cpu_ases[asidx];
         if (!cpuas->as) {
             /* This index was never initialized; no deinit needed */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8d5987397ad..6e1cbf3d614 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2149,16 +2149,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     unsigned int smp_cpus = ms->smp.cpus;
     bool has_secure = cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY);
 
-    /*
-     * We must set cs->num_ases to the final value before
-     * the first call to cpu_address_space_init.
-     */
-    if (cpu->tag_memory != NULL) {
-        cs->num_ases = 3 + has_secure;
-    } else {
-        cs->num_ases = 1 + has_secure;
-    }
-
     cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
 
     if (has_secure) {
@@ -2392,6 +2382,7 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
     cc->gdb_read_register = arm_cpu_gdb_read_register;
     cc->gdb_write_register = arm_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
+    cc->max_as = ARMASIdx_MAX;
     cc->sysemu_ops = &arm_sysemu_ops;
 #endif
     cc->gdb_arch_name = arm_gdb_arch_name;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0b8cca7cecf..45f0b80deb0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10616,6 +10616,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
     cc->get_arch_id = x86_cpu_get_arch_id;
 
 #ifndef CONFIG_USER_ONLY
+    cc->max_as = X86ASIdx_MAX;
     cc->sysemu_ops = &i386_sysemu_ops;
 #endif /* !CONFIG_USER_ONLY */
 #ifdef CONFIG_TCG
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 33a8c26bc27..c34d9f15c7e 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -98,7 +98,6 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      * Only initialize address space 0 here, the second one for SMM is
      * initialized at register_smram_listener() after machine init done.
      */
-    cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
     cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
 
     return true;
diff --git a/target/i386/tcg/system/tcg-cpu.c b/target/i386/tcg/system/tcg-cpu.c
index 7255862c244..b74e025b3e7 100644
--- a/target/i386/tcg/system/tcg-cpu.c
+++ b/target/i386/tcg/system/tcg-cpu.c
@@ -73,7 +73,6 @@ bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
     memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, cpu->cpu_as_mem, 0);
     memory_region_set_enabled(cpu->cpu_as_mem, true);
 
-    cs->num_ases = 2;
     cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
     cpu_address_space_init(cs, X86ASIdx_SMM, "cpu-smm", cpu->cpu_as_root);
 
-- 
2.52.0


