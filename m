Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B99C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbiib-00076l-HG; Sat, 25 Jan 2025 11:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbih4-0005B4-P7
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:38 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbih1-0000oN-Uk
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:34 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38634c35129so2771233f8f.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821247; x=1738426047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvyBSQXbzbGPZHAiCl001qEBhi2s4blv2wiDqu84MNg=;
 b=QAiWdEmEI6T2fjhMShEMOkvl3HoL7+Mkc0bGhgcroxRXWWtmNY2SO2SDFQ/913gVzM
 71xE4crFl2dNAIzVM49WkTeh6IyRtSYi1XfMsjEBrRjnnN+hYrQNRLh2qjOG3LCwEiR3
 g9gtZvaxPSA3ao5+Jww/bpxCrHopK2Jxy/b4iNeMNB+W+5zPm4HUQnv3JauO/712q0SX
 xuMxwgBHbP6WXhNJRSGSPmwRlDuIA/MHhM7gkpZcPPSSKOIVT57TM/OqAV9ufJEZHkcF
 Id06py8raLO2VqPdil9Z7eZP5iM1eVmFMYUmB4U6Z2KZCg2bgk/c6A5HJHgPpqn7TWBs
 c+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821247; x=1738426047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvyBSQXbzbGPZHAiCl001qEBhi2s4blv2wiDqu84MNg=;
 b=vZcox9lRR1UHLVJkMaM3IJSTbr+kg0JDaYSh/Flykd/ECWfshXg0qXeIA29A1EN0oy
 FDrhD6F+NTxrPqJy+uHlmbdCz9HtAZ3cM9yhV9kbl04QrjZMQGr5WeyG71pIeL5LBzo7
 muEdNXe4wtLWqOr7XrzxOvhEQbDmcpfbqkI7PuNmp70rcKqOG+xoSNKsUmCA38jK1gz7
 YLEJlETjPhCMRnrASAcXss0+zGZRQH2aWq1R84/zS5zBkaLXDO7+5mMHnbns1Djq3NSG
 CxFjfrwJtHtFm4wIvJz7x+qRLXIVXAuLXRR8KBLDKzVUNXxcSnG8QP5gGe2MGWSE6pYp
 0qwg==
X-Gm-Message-State: AOJu0YzzNLKnypm170es4YrjD0e7oJx0XzsVCHs+LUaWNXYTK1uGoi6g
 iTSAJgCzC9WoQ3DTfa4x5AaUlLbjzdpa/qc9I0MFiycfKy715ASb6Sc8L8yjtenZPTd02dELviE
 Q6BE=
X-Gm-Gg: ASbGnct8w8U8dgrmpJgwsJ0ZNpAC1/X4byfQpZw4md1isli9wwkS2BpXeIaM5vaqqJd
 T8/q+uaGlNmJaA5ElOIuo9w1Dc1SjtXrsIoT4Axcs97RBnF4qnzsLMYOP+EjNB+glWr0ls2HQ6X
 QXSg79pFx0/CyrY/JdHcfvW29JRThYLjo23RgebcKc9XxELkBFvXCOO9KWwcDPMallkGuHyXxCU
 Sc2LsJfklpiLxikq8OVeTSkJq+ptQ3zqJe+2/39ni0LmlCPscdUDER/+DjdJXX/8bdjHh7+S/bE
 tvjTjMbMVOl0jokBskTyu1xGOZDpXVgZLnhKWT9DaW2kOleKhDF+v9bV3jBL
X-Google-Smtp-Source: AGHT+IE9mfMSP7xYzxXtZf3mC4ApZLSH4ZnW32HQaiV4P8mWmyDzkfa71ppTnXGfMPbT8F4BYnud4w==
X-Received: by 2002:a05:6000:188c:b0:38a:8d32:2741 with SMTP id
 ffacd0b85a97d-38bf5784a95mr29584300f8f.19.1737821246761; 
 Sat, 25 Jan 2025 08:07:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188fd0sm6060157f8f.58.2025.01.25.08.07.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:07:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 19/24] target/s390x: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:47 +0100
Message-ID: <20250125160552.20546-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Move has_work() from CPUClass to SysemuCPUOps, move
s390_cpu_has_work() to cpu-system.c so it is only build
for system emulation binaries, restrict functions not
used anymore on user emulation in interrupt.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/s390x-internal.h |  3 +++
 target/s390x/cpu-system.c     | 18 ++++++++++++++++++
 target/s390x/cpu.c            | 18 ------------------
 target/s390x/interrupt.c      |  8 ++------
 4 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 6e2c98de97a..a4ba6227ab4 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -245,6 +245,7 @@ bool s390_cpu_system_realize(DeviceState *dev, Error **errp);
 void s390_cpu_finalize(Object *obj);
 void s390_cpu_system_class_init(CPUClass *cc);
 void s390_cpu_machine_reset_cb(void *opaque);
+bool s390_cpu_has_work(CPUState *cs);
 
 #else
 static inline unsigned int s390_cpu_halt(S390CPU *cpu)
@@ -341,6 +342,7 @@ void cpu_unmap_lowcore(LowCore *lowcore);
 
 /* interrupt.c */
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code);
+#ifndef CONFIG_USER_ONLY
 void cpu_inject_clock_comparator(S390CPU *cpu);
 void cpu_inject_cpu_timer(S390CPU *cpu);
 void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
@@ -353,6 +355,7 @@ bool s390_cpu_has_restart_int(S390CPU *cpu);
 bool s390_cpu_has_stop_int(S390CPU *cpu);
 void cpu_inject_restart(S390CPU *cpu);
 void cpu_inject_stop(S390CPU *cpu);
+#endif /* CONFIG_USER_ONLY */
 
 
 /* ioinst.c */
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index e9f8e7cc72f..9b380e343c2 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -39,6 +39,23 @@
 #include "system/tcg.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
+bool s390_cpu_has_work(CPUState *cs)
+{
+    S390CPU *cpu = S390_CPU(cs);
+
+    /* STOPPED cpus can never wake up */
+    if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
+        s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING) {
+        return false;
+    }
+
+    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        return false;
+    }
+
+    return s390_cpu_has_int(cpu);
+}
+
 /* S390CPUClass::load_normal() */
 static void s390_cpu_load_normal(CPUState *s)
 {
@@ -158,6 +175,7 @@ void s390_cpu_finalize(Object *obj)
 }
 
 static const struct SysemuCPUOps s390_sysemu_ops = {
+    .has_work = s390_cpu_has_work,
     .get_phys_page_debug = s390_cpu_get_phys_page_debug,
     .get_crash_info = s390_cpu_get_crash_info,
     .write_elf64_note = s390_cpu_write_elf64_note,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 97d41c23de7..eb2c6650989 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -126,23 +126,6 @@ static vaddr s390_cpu_get_pc(CPUState *cs)
     return cpu->env.psw.addr;
 }
 
-static bool s390_cpu_has_work(CPUState *cs)
-{
-    S390CPU *cpu = S390_CPU(cs);
-
-    /* STOPPED cpus can never wake up */
-    if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
-        s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING) {
-        return false;
-    }
-
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
-        return false;
-    }
-
-    return s390_cpu_has_int(cpu);
-}
-
 static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     return s390x_env_mmu_index(cpu_env(cs), ifetch);
@@ -394,7 +377,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name,
-    cc->has_work = s390_cpu_has_work;
     cc->mmu_index = s390x_cpu_mmu_index;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index d68d8955b1a..4ae6e2ddeaa 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -30,6 +30,7 @@ void trigger_pgm_exception(CPUS390XState *env, uint32_t code)
     /* env->int_pgm_ilen is already set, or will be set during unwinding */
 }
 
+#if !defined(CONFIG_USER_ONLY)
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra)
 {
     if (kvm_enabled()) {
@@ -41,7 +42,6 @@ void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra)
     }
 }
 
-#if !defined(CONFIG_USER_ONLY)
 void cpu_inject_clock_comparator(S390CPU *cpu)
 {
     CPUS390XState *env = &cpu->env;
@@ -225,11 +225,9 @@ bool s390_cpu_has_stop_int(S390CPU *cpu)
 
     return env->pending_int & INTERRUPT_STOP;
 }
-#endif
 
 bool s390_cpu_has_int(S390CPU *cpu)
 {
-#ifndef CONFIG_USER_ONLY
     if (!tcg_enabled()) {
         return false;
     }
@@ -238,7 +236,5 @@ bool s390_cpu_has_int(S390CPU *cpu)
            s390_cpu_has_io_int(cpu) ||
            s390_cpu_has_restart_int(cpu) ||
            s390_cpu_has_stop_int(cpu);
-#else
-    return false;
-#endif
 }
+#endif /* !CONFIG_USER_ONLY */
-- 
2.47.1


