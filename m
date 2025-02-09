Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE40FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 03:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgy43-0005rM-DB; Sat, 08 Feb 2025 22:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tgy3t-0005pU-7u; Sat, 08 Feb 2025 22:32:49 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tgy3p-0001QE-LD; Sat, 08 Feb 2025 22:32:48 -0500
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2f9bd7c480eso6096426a91.1; 
 Sat, 08 Feb 2025 19:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739071963; x=1739676763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVpRSsG7WNoH4YtghwZkR3dBDTVbuBw688Dyz1Cfbrw=;
 b=DiTysRERxC3scjRkvy3pBVGMZfOseCDzs5d1IytOyC8vc5drcioBhY7nWWpfts6bgs
 IlA0yN1QffLLM3ZktiNB0B9g2mzyuh0yWJfcvnFXPHHcM6XBjvYC+CWaKILD3C1QH1+D
 LbAEyoM+XrE4CqKxuWN9M5OCveZbfT3vUSLhFdCS+iTlZw1YfV+T/6BHNhjUJF3QW2J5
 MCGhHPvlo7dasDPk9rHzxYKKO4mQEpVE5IMovncB8/Yck5hbjSCwVkVD1r0sUdV9ghR1
 pk9qVVLagUozsaei1+dLj8wFAO7KKi0JGootzCD8Csp3PZF8832D4MmOi2bzaiWqwUst
 VMgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD4zKD+cTRiBIkaAIa6YbspVu8kWQ40PvZotcxfknIISE7B/iiBPKYwjA+vViWfTOsLdlZiPS/ww==@nongnu.org
X-Gm-Message-State: AOJu0YyTrcATNDCslLzn0O216F9O+aRXv1D9RS3AqKJFrebUznubgZzY
 1BOh3Ou9wEJFTl2iJo46im2V1Z3qHg0AV4UGLC34WS+X0B5PnLCNTNw6wkZy
X-Gm-Gg: ASbGnctjmWyKmYmUvSL58DzB8FwDEJXS4tQvmXJqwXIx+8gTCe4MZWX3RNER5xIwOtB
 KPh5L+6nzeNiq13xd8ps07FcZw4llwGsRD1IoMJOybrja6qmTCvcnb2hhI4AmWiSOqHT0uFQx67
 acY46LViRZZy8YY8LdTiBdIhTE6hBTUV2wv+9dIHeV5sBUJl7HwMnGLHr+SARYXBYhU/rs5Zjy7
 hRpoghWj1/9URNjchGU0LIMyLgcuizHO/Lwpc3D8+/nkXqphDxHIylI1qQTBqZ3gsfw2UjGR0i4
 FcTbnt4o+7HG4QhBHp5SK24vNGkkMqrKvGbNXO/42AvJhgQ=
X-Google-Smtp-Source: AGHT+IEmGKSVrTEgSHkKyXXQHTg7buaGlh9O0VWAYxnTQ6X/tb4JA5vaGTh76Rt68SswGpVUEx1RCw==
X-Received: by 2002:a17:90b:4d81:b0:2fa:1f1b:3db7 with SMTP id
 98e67ed59e1d1-2fa24272512mr16390106a91.18.1739071962841; 
 Sat, 08 Feb 2025 19:32:42 -0800 (PST)
Received: from localhost.localdomain
 ([2607:fb90:9e97:4903:dc10:4530:8a3f:fdb6])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad5453e2366sm1333610a12.47.2025.02.08.19.32.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Feb 2025 19:32:42 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH RFC 3/4] hvf: arm: emulate instruction when ISV=0
Date: Sat,  8 Feb 2025 19:32:32 -0800
Message-ID: <20250209033233.53853-4-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20250209033233.53853-1-j@getutm.app>
References: <20250209033233.53853-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.48; envelope-from=osy86dev@gmail.com;
 helo=mail-pj1-f48.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.07, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On a data abort, the processor will try to decode the faulting instruction
so the hypervisor can emulate the read/write. However, it is not always
able to do this and ISV=0 whenever the instruction is not decoded. This is
the case for example if the faulting instruction is SIMD or a LDP/STP.

When this happens, we can use TCG to emulate the faulting instruction.
This is needed if the processor uses one of these instructions to access
memory that is currently unmapped such as with VGA VRAM.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/system/hvf_int.h  |   2 +-
 target/arm/hvf_arm.h      |   5 ++
 accel/hvf/hvf-accel-ops.c |   2 +-
 system/physmem.c          |   2 +-
 target/arm/hvf/hvf.c      | 100 ++++++++++++++++++++++++++++++++++++--
 target/i386/hvf/hvf.c     |   2 +-
 6 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 42ae18433f..7b85dbc495 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -64,7 +64,7 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
                         const char *exp);
 #define assert_hvf_ok(EX) assert_hvf_ok_impl((EX), __FILE__, __LINE__, #EX)
 const char *hvf_return_string(hv_return_t ret);
-int hvf_arch_init(void);
+int hvf_arch_init(MachineState *ms);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
 int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 26c717b382..6ebef31390 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -41,4 +41,9 @@ static inline uint32_t hvf_arm_get_max_ipa_bit_size(void)
 
 #endif
 
+/**
+ * hvf_arm_init_emulator() - initialize TCG emulator
+ */
+void hvf_arm_init_emulator(int splitwx, unsigned max_cpus);
+
 #endif
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 945ba72051..1caf713118 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -346,7 +346,7 @@ static int hvf_accel_init(MachineState *ms)
     hvf_state = s;
     memory_listener_register(&hvf_memory_listener, &address_space_memory);
 
-    return hvf_arch_init();
+    return hvf_arch_init(ms);
 }
 
 static inline int hvf_gdbstub_sstep_flags(void)
diff --git a/system/physmem.c b/system/physmem.c
index 4bb2976646..950cac5971 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -771,7 +771,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     newas = &cpu->cpu_ases[asidx];
     newas->cpu = cpu;
     newas->as = as;
-    if (tcg_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         newas->tcg_as_listener.log_global_after_sync = tcg_log_global_after_sync;
         newas->tcg_as_listener.commit = tcg_commit;
         newas->tcg_as_listener.name = "tcg";
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 28886970c9..2c70e691fb 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -37,6 +37,17 @@
 
 #include "gdbstub/enums.h"
 
+#if defined(CONFIG_TCG)
+#include "accel/tcg/internal-common.h"
+#include "accel/tcg/tcg-accel-ops.h"
+#include "exec/tb-flush.h"
+#include "hw/core/cpu.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
+#include "system/tcg.h"
+#include "tcg/startup.h"
+#endif /* defined(CONFIG_TCG) */
+
 #define MDSCR_EL1_SS_SHIFT  0
 #define MDSCR_EL1_MDE_SHIFT 15
 
@@ -150,6 +161,17 @@ void hvf_arm_init_debug(void)
         g_array_sized_new(true, true, sizeof(HWWatchpoint), max_hw_wps);
 }
 
+#if defined(CONFIG_TCG)
+void hvf_arm_init_emulator(int splitwx, unsigned max_cpus)
+{
+    mttcg_enabled = true;
+    page_init();
+    tb_htable_init();
+    tcg_init(64 * MiB, splitwx, max_cpus);
+    tcg_prologue_init();
+}
+#endif /* defined(CONFIG_TCG) */
+
 #define HVF_SYSREG(crn, crm, op0, op1, op2) \
         ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
 
@@ -968,6 +990,9 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
 
 void hvf_arch_vcpu_destroy(CPUState *cpu)
 {
+#if defined(CONFIG_TCG)
+    tcg_exec_unrealizefn(cpu);
+#endif
 }
 
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
@@ -1060,13 +1085,26 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->isar.id_aa64mmfr0);
     assert_hvf_ok(ret);
 
+    /* enable TCG emulator */
+#if defined(CONFIG_TCG)
+    tcg_register_thread();
+    tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
+    tcg_exec_realizefn(cpu, &error_fatal);
+#endif
+
     return 0;
 }
 
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
-    cpus_kick_thread(cpu);
-    hv_vcpus_exit(&cpu->accel->fd, 1);
+    if (cpu->emulation_enabled) {
+        cpu_exit(cpu);
+    } else {
+        cpus_kick_thread(cpu);
+        if (cpu->accel) {
+            hv_vcpus_exit(&cpu->accel->fd, 1);
+        }
+    }
 }
 
 static void hvf_raise_exception(CPUState *cpu, uint32_t excp,
@@ -1881,6 +1919,50 @@ static inline uint64_t sign_extend(uint64_t value, uint32_t bits)
     return (uint64_t)((int64_t)(value << (64 - bits)) >> (64 - bits));
 }
 
+#if defined(CONFIG_TCG)
+static int emulate_single_instruction(CPUState *cpu)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    int prev_ss_enable = cpu->singlestep_enabled;
+    int ret;
+
+    cpu_synchronize_state(cpu);
+    arm_rebuild_hflags(env);
+    cpu_emulate(cpu, true);
+    cpu_single_step(cpu, SSTEP_NODEBUG | SSTEP_ENABLE);
+    do {
+        if (cpu_can_run(cpu)) {
+            bql_unlock();
+            ret = tcg_cpu_exec(cpu);
+            bql_lock();
+            if (ret == EXCP_ATOMIC) {
+                bql_unlock();
+                cpu_exec_step_atomic(cpu);
+                bql_lock();
+                ret = 0;
+            }
+            /* retry if we got an interrupt */
+            if (ret != EXCP_INTERRUPT) {
+                break;
+            }
+        }
+
+        qatomic_set_mb(&cpu->exit_request, 0);
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+    cpu_single_step(cpu, prev_ss_enable);
+    cpu_emulate(cpu, false);
+    cpu->accel->dirty = true;
+    flush_cpu_state(cpu);
+    if (!ret && prev_ss_enable) {
+        /* if single-stepping, always return EXCP_DEBUG */
+        ret = EXCP_DEBUG;
+    }
+    return ret;
+}
+#endif
+
 int hvf_vcpu_exec(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
@@ -1993,7 +2075,15 @@ int hvf_vcpu_exec(CPUState *cpu)
             break;
         }
 
+#if defined(CONFIG_TCG)
+        if (unlikely(!isv)) {
+            ret = emulate_single_instruction(cpu);
+            advance_pc = false;
+            break;
+        }
+#else
         assert(isv);
+#endif
 
         if (iswrite) {
             val = hvf_get_reg(cpu, srt);
@@ -2124,7 +2214,7 @@ static void hvf_vm_state_change(void *opaque, bool running, RunState state)
     }
 }
 
-int hvf_arch_init(void)
+int hvf_arch_init(MachineState *ms)
 {
     hvf_state->vtimer_offset = mach_absolute_time();
     vmstate_register(NULL, 0, &vmstate_hvf_vtimer, &vtimer);
@@ -2132,6 +2222,10 @@ int hvf_arch_init(void)
 
     hvf_arm_init_debug();
 
+#if defined(CONFIG_TCG)
+    hvf_arm_init_emulator(0, ms->smp.max_cpus);
+#endif
+
     return 0;
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index ca08f0753f..bcf9433d33 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -218,7 +218,7 @@ void hvf_kick_vcpu_thread(CPUState *cpu)
     hv_vcpu_interrupt(&cpu->accel->fd, 1);
 }
 
-int hvf_arch_init(void)
+int hvf_arch_init(MachineState *ms)
 {
     return 0;
 }
-- 
2.41.0


