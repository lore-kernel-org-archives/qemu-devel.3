Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B09C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 18:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKsa-0003Ji-38; Sun, 09 Mar 2025 13:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrO-0000kF-23
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrL-00056X-8F
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so137644f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542881; x=1742147681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6DpQiHTDHBmFHiftaaWk+jex1GHY7T8B9mFbWzo90uk=;
 b=iKl/0SV/YiWdVH7FT1NZa7Y2pdovZoR2VryQ7RItC29Xbou3jK2SY3aEn1AaoO9ZvS
 ZZR+jrWPHPsFU3h9aWTY3a5r49BnTnZBrPJu5dk3qOzDS+XTOtBJfdHTjEyeJEO9yIFm
 rsDsJR6v9WzwXTGl1EtPzBekoGhMX29O8djZjH7fsr5fVVjdR1BsLM3FYK3nxM7tOtxr
 Lp5AWEZN99oamM9glXy1ZKDzMJ97wcjM0/LBgDYGOE3Ww+NMEkLKOQbn+bcQtMAllDGK
 HVgFbOQIjnNVfcp1Rp4w8fNOF2XOyr46pQhd9s2S5SPM5P3jMJLSoseiCd1v3RbuIM6z
 C8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542881; x=1742147681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DpQiHTDHBmFHiftaaWk+jex1GHY7T8B9mFbWzo90uk=;
 b=Wt+0kNwIi/3SKlNkT5c+QvjbdgWhTUCezzyDeNSREOtYUYmOKGR90J/SKBZuFtcLp1
 maCdfRfeEJ28IJ3sk1j8fFJ+Cv9aFWidsZ8GxI8GcQZrBOgDqU5n9u6wM0Dx79EUgyBj
 uKX2GgdcsfjMvHavz1akuqsob0atm3OciDbajclyTRtYZHs3GsuqoJJ+3qi/Py39VGKn
 Ozq/1n5p9wSmeumGdPzo9CcFi3pHxHzDTFRF2x8cfSXZKRBcMxDRXDiJE/eGLuFyGWF+
 0czzQuy4gLDzaffvfTpOssWXJIAC8VrCBMJvTzQj6W61B6mItnbv3dW/CjxWlHtFZhRP
 3FBw==
X-Gm-Message-State: AOJu0YwTj4QzGX9OA7z4Iibn414gNqeUXDeCwqyUCQK+X6cC1ABpXV3r
 dVfkp/GZPVLE+aQmtupaY9pReiSpIvmoaieRTABKqmp7/ftpv2en8yq7B7G11wbnbFBuBGdK8bx
 2f/c=
X-Gm-Gg: ASbGncu/33/U8sOLj0tPn38mNVU1rszPVyZfTzNqK2g68mwuc1U7wL+r+zoE1Lk/S64
 O+3qoX6T/LuZYcSH+8/HzBoeBAXhFu0hZ8lZ2TMJ0zrSvc7Dh4+NUDDMV7ubaD2sLvg2j+Tvunh
 8pyoCRHK0jfQ0kW7bT+or20HxPbJhNWYKBdWk1PN8ZxRMi43Vp/KVf4gNxrcr8+MY1ULhKzIMiI
 0PvzZQEm81TcB9G5s3+K0B40wyM6pZYCamLWklRthEqbjfFh2aj+4fFT42CBGhC/unsqCLV1eSY
 yXpiddY9mcfqtsdJn1c4SAiNkcNLKD1E28Xr8VGBj4fVFdGk6Ed1+TORPetAOlZM6maYVqSIhJW
 yLx+tBk6ITAjyZzTEcEY=
X-Google-Smtp-Source: AGHT+IEK6yLenSGyCBpdnYcMi7RnHkMN4Sd+aFrpxbqdeoHpPndgasHAwrqHnEwheATg1POqOosZGg==
X-Received: by 2002:a05:6000:144d:b0:385:faaa:9d1d with SMTP id
 ffacd0b85a97d-39132d98bc3mr8314571f8f.35.1741542881349; 
 Sun, 09 Mar 2025 10:54:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ceeb34904sm39220605e9.30.2025.03.09.10.54.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:54:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/38] target/s390x: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sun,  9 Mar 2025 18:52:01 +0100
Message-ID: <20250309175207.43828-33-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Move has_work() from CPUClass to SysemuCPUOps, move
s390_cpu_has_work() to cpu-system.c so it is only build
for system emulation binaries, restrict functions not
used anymore on user emulation in interrupt.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-20-philmd@linaro.org>
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
index 972d265478d..d73142600bf 100644
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
@@ -395,7 +378,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
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


