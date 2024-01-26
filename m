Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE13C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUJb-0007PX-7U; Fri, 26 Jan 2024 17:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJZ-0007Nv-6R
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:45 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJW-0003WW-Ex
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:44 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a3122b70439so121977066b.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 14:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706306681; x=1706911481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gp6DeXIBN6rItUvSYJmDDzKmD7zwVKQwnsgLGcelMOw=;
 b=VWFi4+5kUjuhgaYVrAyoAtphWF8Npe8oFRVRH1qukCZTmQkb56v9Svch73vI5hR9cx
 FCHZV6XRv0hCDE1xdZkwr2kRia7aImQVOMXZDwkXFcPr0w7zUZ1StWB++LkufD9rRXQ9
 z9XILXdvhsODuqOkdsXKX+24tlIrq3FvpKRtl5Rc68VPKFB+fqxAWnx01IkqC9YyqKHT
 4UNmg7ZyilHBY4WQO+pjjWsYhnEgXOnmLz4N3Lppvz3J8FMPMuQ5Sot1Gw+/uqwpo1nV
 0Zd7Zq1TBTQmqZdNBEiRpjP7d3F5ezX0l7eJYZ+0MQpFP9pRulVEP2zJ3iFlE2GHteLR
 hKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706306681; x=1706911481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gp6DeXIBN6rItUvSYJmDDzKmD7zwVKQwnsgLGcelMOw=;
 b=vRncKWSq110oonP0ndIHnbbFTjAi4MuQg+BvJER61nJTxudel2k/njMUVPuwd11H4N
 Lmkez1fhJL+3ZoVdSM2xIbK6uM+wStt3sWKhoh+YdB0eRgY8/91Tu2nzKvoKL/ptHfrF
 pQAg//7291LHiqKpdx2npE18VtqPFxhenkGw85oQro/jYuvGpMnUZCiY4pndMA+D746N
 VnluL7iZPpmV2HlTZqWEcrNnprNYLBqbr6FIyEZegHw+7sDy6WKdeRGdyzZfr6WXXkhH
 D9jY/nl27Mp8xVcLtlEDcfXrRvqzfaGiamZW0dzb6ljR8rK5GX/yXqqic3oBGblix9eb
 XIdw==
X-Gm-Message-State: AOJu0YwcGTTlvNzanLHirAgcqvWLs+4VlHXnArGfN7pAYIZMes+HCSU6
 WeGF1SSnTfQJJXLo5G2oiyL2kGJHikudUlWVEp4ygP+GoWR+DeLzxA0a1oQXvTafIZO0QATGTN1
 c
X-Google-Smtp-Source: AGHT+IG2UFJF/DHmCLVHGidwqpa4bW5tblCDTCxKG8kjUEapwEiqAT3tnzoWhQ5lLj+4IuvY3q++IA==
X-Received: by 2002:a17:906:3c59:b0:a34:9a5e:e15e with SMTP id
 i25-20020a1709063c5900b00a349a5ee15emr400769ejg.28.1706306680752; 
 Fri, 26 Jan 2024 14:04:40 -0800 (PST)
Received: from m1x-phil.lan ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 kq19-20020a170906abd300b00a29db9e8c84sm1051034ejb.220.2024.01.26.14.04.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Jan 2024 14:04:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH v2 05/23] target/arm: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Fri, 26 Jan 2024 23:03:47 +0100
Message-ID: <20240126220407.95022-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126220407.95022-1-philmd@linaro.org>
References: <20240126220407.95022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/arm_gicv3_cpuif_common.c |  5 +----
 target/arm/cpu.c                 | 19 +++++--------------
 target/arm/debug_helper.c        |  8 ++------
 target/arm/gdbstub.c             |  6 ++----
 target/arm/gdbstub64.c           |  6 ++----
 target/arm/helper.c              |  9 +++------
 target/arm/hvf/hvf.c             | 12 ++++--------
 target/arm/kvm.c                 |  3 +--
 target/arm/ptw.c                 |  3 +--
 target/arm/tcg/cpu32.c           |  3 +--
 10 files changed, 22 insertions(+), 52 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif_common.c b/hw/intc/arm_gicv3_cpuif_common.c
index ff1239f65d..bab3c3cdbd 100644
--- a/hw/intc/arm_gicv3_cpuif_common.c
+++ b/hw/intc/arm_gicv3_cpuif_common.c
@@ -15,8 +15,5 @@
 
 void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
 {
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    CPUARMState *env = &arm_cpu->env;
-
-    env->gicv3state = (void *)s;
+    cpu_env(cpu)->gicv3state = (void *)s;
 };
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 593695b424..3970223f33 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -51,8 +51,7 @@
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
 
     if (is_a64(env)) {
         env->pc = value;
@@ -65,8 +64,7 @@ static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 
 static vaddr arm_cpu_get_pc(CPUState *cs)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
 
     if (is_a64(env)) {
         return env->pc;
@@ -994,19 +992,15 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq, int level)
 
 static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-
     cpu_synchronize_state(cs);
-    return arm_cpu_data_is_big_endian(env);
+    return arm_cpu_data_is_big_endian(cpu_env(cs));
 }
 
 #endif
 
 static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
-    ARMCPU *ac = ARM_CPU(cpu);
-    CPUARMState *env = &ac->env;
+    CPUARMState *env = cpu_env(cpu);
     bool sctlr_b;
 
     if (is_a64(env)) {
@@ -2428,10 +2422,7 @@ static Property arm_cpu_properties[] = {
 
 static const gchar *arm_gdb_arch_name(CPUState *cs)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-
-    if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
+    if (arm_feature(cpu_env(cs), ARM_FEATURE_IWMMXT)) {
         return "iwmmxt";
     }
     return "arm";
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 7d856acddf..7bd5467414 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -468,8 +468,7 @@ void arm_debug_excp_handler(CPUState *cs)
      * Called by core code when a watchpoint or breakpoint fires;
      * need to check which one and raise the appropriate exception.
      */
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
     CPUWatchpoint *wp_hit = cs->watchpoint_hit;
 
     if (wp_hit) {
@@ -757,9 +756,6 @@ void hw_breakpoint_update_all(ARMCPU *cpu)
 
 vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-
     /*
      * In BE32 system mode, target memory is stored byteswapped (on a
      * little-endian host system), and by the time we reach here (via an
@@ -767,7 +763,7 @@ vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
      * to account for that, which means that watchpoints will not match.
      * Undo the adjustment here.
      */
-    if (arm_sctlr_b(env)) {
+    if (arm_sctlr_b(cpu_env(cs))) {
         if (len == 1) {
             addr ^= 3;
         } else if (len == 2) {
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 28f546a5ff..dc6c29669c 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -40,8 +40,7 @@ typedef struct RegisterSysregXmlParam {
 
 int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
 
     if (n < 16) {
         /* Core integer register.  */
@@ -61,8 +60,7 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
     uint32_t tmp;
 
     tmp = ldl_p(mem_buf);
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index d7b79a6589..b9f29b0a60 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -24,8 +24,7 @@
 
 int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
 
     if (n < 31) {
         /* Core integer register.  */
@@ -45,8 +44,7 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int aarch64_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
     uint64_t tmp;
 
     tmp = ldq_p(mem_buf);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e068d35383..a504ed0612 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10900,8 +10900,7 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
      * PSTATE A/I/F masks are set based only on the SCR.EA/IRQ/FIQ values.
      */
     uint32_t addr, mask;
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
 
     switch (cs->exception_index) {
     case EXCP_UDEF:
@@ -10979,8 +10978,7 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
 
 static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
     uint32_t addr;
     uint32_t mask;
     int new_mode;
@@ -11479,8 +11477,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
 #ifdef CONFIG_TCG
 static void tcg_handle_semihosting(CPUState *cs)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
 
     if (is_a64(env)) {
         qemu_log_mask(CPU_LOG_INT,
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a537a5bc94..69211d0a60 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1004,8 +1004,7 @@ void hvf_kick_vcpu_thread(CPUState *cpu)
 static void hvf_raise_exception(CPUState *cpu, uint32_t excp,
                                 uint32_t syndrome)
 {
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    CPUARMState *env = &arm_cpu->env;
+    CPUARMState *env = cpu_env(cpu);
 
     cpu->exception_index = excp;
     env->exception.target_el = 1;
@@ -1483,8 +1482,7 @@ static bool hvf_sysreg_write_cp(CPUState *cpu, uint32_t reg, uint64_t val)
 
 static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
 {
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    CPUARMState *env = &arm_cpu->env;
+    CPUARMState *env = cpu_env(cpu);
 
     trace_hvf_sysreg_write(reg,
                            SYSREG_OP0(reg),
@@ -2150,8 +2148,7 @@ static void hvf_put_gdbstub_debug_registers(CPUState *cpu)
  */
 static void hvf_put_guest_debug_registers(CPUState *cpu)
 {
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    CPUARMState *env = &arm_cpu->env;
+    CPUARMState *env = cpu_env(cpu);
     hv_return_t r = HV_SUCCESS;
     int i;
 
@@ -2205,8 +2202,7 @@ static void hvf_arch_set_traps(void)
 
 void hvf_arch_update_guest_debug(CPUState *cpu)
 {
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    CPUARMState *env = &arm_cpu->env;
+    CPUARMState *env = cpu_env(cpu);
 
     /* Check whether guest debugging is enabled */
     cpu->accel->guest_debug_enabled = cpu->singlestep_enabled ||
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8f52b211f9..9e97c847b3 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1957,8 +1957,7 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
 /* Callers must hold the iothread mutex lock */
 static void kvm_inject_arm_sea(CPUState *c)
 {
-    ARMCPU *cpu = ARM_CPU(c);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(c);
     uint32_t esr;
     bool same_el;
 
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5eb3577bcd..57a761ad68 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3528,8 +3528,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
                                          MemTxAttrs *attrs)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
     ARMSecuritySpace ss = arm_security_space(env);
     S1Translate ptw = {
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index d9e0e2a4dd..c11c5c85c4 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -102,8 +102,7 @@ void aa32_max_features(ARMCPU *cpu)
 static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUClass *cc = CPU_GET_CLASS(cs);
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
     bool ret = false;
 
     /*
-- 
2.41.0


