Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095EACCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8SE-0004I5-Fu; Wed, 29 Oct 2025 11:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S9-0004A9-7C
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:15 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Rx-0002tG-GM
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:11 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b6d855ca585so8309866b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753056; x=1762357856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qIODdnohFbYXb1XCHQq9SFU/QmlMM/ak2DXbJVzwyRg=;
 b=gHiLX0J35QbIMJBdFRVQOWwkzhB2T1soIvLBrLr2FDge5PdcTBHrJbCu2zuipeVGa1
 GGPPZVvLr2LSzsVaoRde/Z9JxaU5YpgsDxS9/048yzywbmTpNkpaPhi6hxh2K4ybUIxW
 yV4SgLXQf02J4zD66BEcsmRH2M4SR5+2xGwehxkTpfWC45b/lcaISXXqphGUscfEJ/jw
 zbTEwbKA0MU9oA8RoZWrzCFH0r2HvPgAKBykP57/KDQIA+kQ/BoDUNs+kN2wR04vsrjM
 OrdNwb/rol7zuwhZTp9E26EemPMHmB3pb8aB6NfaigVYpI2deHBOWXbCiLokqVhI1fCO
 gzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753056; x=1762357856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qIODdnohFbYXb1XCHQq9SFU/QmlMM/ak2DXbJVzwyRg=;
 b=jdYrQqd7ixV+fIOoBL+7JXWjQ3WvRwNkQpeOF+a4kw9c93TdALNlhXPyBl9/4aSJu3
 tY89tr5YLNZCoiuowzrbHi5viV1tES++RdAd7v3vuKSPLywdWC4E2ybffC2Aadreie7z
 1OAEiCMiqfSBJBNhNzKTFZgATBTnxu6jQkkfYDJyuiLOpRhERlTMwjNi531MzUW71Y3L
 yonhjbWlArZoVBpwBz8TY5vtfAIFQ6/uHVJRq2lfkx7AM45Qji6y21SWgH+Ur2LAQfoZ
 TeZyHkaX3DW8/jwPgBlD8HDXtOYZ1xxbvrEUxyr9/BN/SiBWvk0u+7OXIpsunaAoZikR
 Xi6g==
X-Gm-Message-State: AOJu0Yznvu4U6JyGyYGn93uw3zognBDfpEVY5E7U8Yq2TtCdSdt/tLNX
 Hk1+tmXelQE47CL1HnZzjT87OxP8fQLsDK2+PEMoKN1UZEGqR2L9o01GhoUxDB8op6BaERsEfJp
 uqlb50B4=
X-Gm-Gg: ASbGnctgy1xIPuDQJH1CjM7FKHyB23Bbp0eqTLIhB7nqQszzZNXhFMf6PSK1dTuOAnl
 7XKS6G0Al8a5lS6woEGLaKi0IgSIXwCECdS8E/zIAihG/8bOQt8v5BjQVBgud9q0Mp277r1zcJn
 cijnYMQqhKWt5Kd6eykwkDiSTlW7Xk4bAZjtlWc9R6JDSqBSnElhOql2BMu/9F2bkECEIhu6I/v
 +oumBZMKG5vcyZZ+zrfiu+uyygLuUtDXMSmxf3G4TAd8lvsPW0LmlIJkwjTeBJ3kP6S9G5d2pGU
 hXigK1FkVWRuz1Bdwu/uw8My6IcxNeEoRnbkNrTO0/khc+C7ljHa7ckJItAcpBE2hpwfV5VSSFD
 D/VWL0Yv+aT/lX/V3ko6VyY70eX9cL9svSBh0uBP/FiQmI5gthHh+1txnZcCs/vP6N1pCvoBi01
 ZK
X-Google-Smtp-Source: AGHT+IFCWeSvhoYvfENgzQIjctgQyyRRSeGsIdurd/PASyGDzgk4V/SYVKDEiQUQP47LkhwCuowwRg==
X-Received: by 2002:a17:907:728c:b0:b63:2000:72c8 with SMTP id
 a640c23a62f3a-b703d5f7bb1mr363351066b.62.1761753055607; 
 Wed, 29 Oct 2025 08:50:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64043e05a5esm2512798a12.4.2025.10.29.08.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C6DB609B7;
 Wed, 29 Oct 2025 15:50:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 12/35] target/arm: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:21 +0000
Message-ID: <20251029155045.257802-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for ARM (and Aarch64) targets. We decided to
treat the (V)IRQ, (VI/VF)NMI, (V)FIQ and VSERR exceptions as interrupts
since they are, presumably, async in nature.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-13-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f86f421a3db..6fbf7e1ca49 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -375,6 +375,7 @@ static inline int r14_bank_number(int mode)
 
 void arm_cpu_register(const ARMCPUInfo *info);
 
+void arm_do_plugin_vcpu_discon_cb(CPUState *cs, uint64_t from);
 void register_cp_regs_for_features(ARMCPU *cpu);
 void init_cpreg_list(ARMCPU *cpu);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2ef9c178147..ef6435c3efb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -34,6 +34,7 @@
 #endif
 #include "cpregs.h"
 #include "target/arm/gtimer.h"
+#include "qemu/plugin.h"
 
 #define HELPER_H "tcg/helper.h"
 #include "exec/helper-proto.h.inc"
@@ -8783,6 +8784,24 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     }
 }
 
+void arm_do_plugin_vcpu_discon_cb(CPUState *cs, uint64_t from)
+{
+    switch (cs->exception_index) {
+    case EXCP_IRQ:
+    case EXCP_VIRQ:
+    case EXCP_NMI:
+    case EXCP_VINMI:
+    case EXCP_FIQ:
+    case EXCP_VFIQ:
+    case EXCP_VFNMI:
+    case EXCP_VSERR:
+        qemu_plugin_vcpu_interrupt_cb(cs, from);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, from);
+    }
+}
+
 static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
 {
     /*
@@ -9473,6 +9492,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
+    uint64_t last_pc = cs->cc->get_pc(cs);
 
     assert(!arm_feature(env, ARM_FEATURE_M));
 
@@ -9489,6 +9509,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (tcg_enabled() && arm_is_psci_call(cpu, cs->exception_index)) {
         arm_handle_psci_call(cpu);
         qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
         return;
     }
 
@@ -9500,6 +9521,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
 #ifdef CONFIG_TCG
     if (cs->exception_index == EXCP_SEMIHOST) {
         tcg_handle_semihosting(cs);
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
         return;
     }
 #endif
@@ -9525,6 +9547,8 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (!kvm_enabled()) {
         cpu_set_interrupt(cs, CPU_INTERRUPT_EXITTB);
     }
+
+    arm_do_plugin_vcpu_discon_cb(cs, last_pc);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index d856e3bc8e2..3fb24c77900 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -23,6 +23,7 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/intc/armv7m_nvic.h"
 #endif
+#include "qemu/plugin.h"
 
 static void v7m_msr_xpsr(CPUARMState *env, uint32_t mask,
                          uint32_t reg, uint32_t val)
@@ -2194,6 +2195,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     CPUARMState *env = &cpu->env;
     uint32_t lr;
     bool ignore_stackfaults;
+    uint64_t last_pc = env->regs[15];
 
     arm_log_exception(cs);
 
@@ -2361,6 +2363,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         g_assert_not_reached();
 #endif
         env->regs[15] += env->thumb ? 2 : 4;
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
         return;
     case EXCP_BKPT:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG, false);
@@ -2427,6 +2430,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
 
     ignore_stackfaults = v7m_push_stack(cpu);
     v7m_exception_taken(cpu, lr, false, ignore_stackfaults);
+
+    arm_do_plugin_vcpu_discon_cb(cs, last_pc);
 }
 
 uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
-- 
2.47.3


