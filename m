Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89192CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 16:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8ZV-000620-Rr; Wed, 29 Oct 2025 11:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Ys-0005nP-4G
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:11 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8YR-0003YS-Tp
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:06 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-63c3d7e2217so13853632a12.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753455; x=1762358255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVNbDVVHMFokssKdvhxJv3BzMGLnbgSkMxsQpkTlVCE=;
 b=YvS94LAm85I8w0LzkwVHyLEbDQWvTLVuhx1kZsqak5n1KEi84d3xoHPRO0suwSzMuf
 Q/tIv60hn7U0fJDVEYM8diV1MTDIR0BYZGIoc4Bo82PqM1OCj3xnNiyfrounjUdf21eL
 EMBlvpyfxXA96bQ5idexAhNgwH+YFp7QHtOsquCT7Je25mu/BJqygaRqjiQ1RX3n/U85
 WEncHTqWtvZavaCAIUZ1SeJQBHoLxMrf31RF+2E1PHK8bm+FMy1SkdCK22cdlm4mslsq
 yeJspTPIjrQsklp1PnApAI0E/ySP1pG19HrxYcbC4dMIc35LZasCunOoKP/PceX65Fsy
 AG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753455; x=1762358255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UVNbDVVHMFokssKdvhxJv3BzMGLnbgSkMxsQpkTlVCE=;
 b=q4/rcHXbqhTyQ/XfK3KVeojP7KSgJci39bNtqp8vDQLXL9XNHRbNbRhVCKHyC+j3R5
 H5CmqeZxEOPPyR0X2sm31RoW8oEKtv2ce+9Rd5FvBNVozxeF+0LI3k2jg8bUOe7GbbyW
 dExO5nQ6+SCISO8ntAUB7EHyfHeBMxjkl3/SWy0HiaY1YWrZMnO11RMl2vXGR8/pp7X4
 OK7mq5/8GnjrDRRDh965iPxD/Kz+BJNRpO0e7h40B/+54aQWN8j+GeM/mJA2xE66aoR1
 VKMQSHYrIdTuzsmbb8ADzUnwqorhRzCvx3jV4Rp5RrolvtTsei7ziFKOrd6DrQvBIw+2
 pDbg==
X-Gm-Message-State: AOJu0YxaWDGNd+xXd74l/XCM0xcaMRD5h3JsVbYdxIkoysvMqqbyqfiH
 wRrSN8fV2QF7ISyUhg391zBxpO185MYfvWEZS/72fyVvBCy9DHVzfW6WNpd5tATJH/TakmpEUOU
 rrAhoEjY=
X-Gm-Gg: ASbGncuhu8/A+CuMCR/08tJJvjTqh1ZU9Ngi4id280GvHf6Xvyz4S8bZ/3xcWXMj9TW
 oExUo7CZcO9upr2dWZ8z9fQs2lR+QrkGLyJ4YymVvTaYT1QcTm9n5/z66JNtNdCx00Ffup0t19m
 rsD+wB5ZylZ0dWnqnuWB85IAvUjr6oCeK7XA2tPRJHBC5YYV7aoEzBVDzUFHv56S5iImdL/+FkW
 frsjqZ0xQsmwqjHOPzIT7UqP4sVfKQFaRpJqtLefXaopeljCJuDAy6DhVFpEBjR8JaRDP6gCcQG
 C2sKr+FeUCC+4aWedteZOx604WQrHlc+FyfvUtD2NIwXsDitHf2pTQfGbs3FZXCE5TUhpaeAduD
 jTAeZva0Yo/AgoHvlzPyI4p10bIabmgm0Vw9sG0RrSXEVMd7KZvhlyU4YZkm+o14G9H9+Wfkdm/
 q9
X-Google-Smtp-Source: AGHT+IEAgy0LRBuIJfK18+KnU6cJDe7thUa3O4FdR7CHMtexbdMjrMzZR4P1APkWJIQAPRHgU3+qpw==
X-Received: by 2002:a05:6402:2690:b0:639:4c9:9c9c with SMTP id
 4fb4d7f45d1cf-64044375aacmr2889442a12.27.1761753455212; 
 Wed, 29 Oct 2025 08:57:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7efd0c1fsm12326567a12.37.2025.10.29.08.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:57:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E77505F909;
 Wed, 29 Oct 2025 15:50:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PULL 21/35] target/ppc: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:30 +0000
Message-ID: <20251029155045.257802-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This change places hooks for Power PC targets.

Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-22-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index d8bca19fff5..6d05b865058 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -27,6 +27,7 @@
 #include "internal.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
+#include "qemu/plugin.h"
 
 #include "trace.h"
 
@@ -404,11 +405,31 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
     powerpc_checkstop(env, "machine check with MSR[ME]=0");
 }
 
+static void powerpc_do_plugin_vcpu_interrupt_cb(CPUState *cs, int excp,
+                                                uint64_t from)
+{
+    switch (excp) {
+    case POWERPC_EXCP_NONE:
+        break;
+    case POWERPC_EXCP_FIT:
+    case POWERPC_EXCP_WDT:
+    case POWERPC_EXCP_PIT:
+    case POWERPC_EXCP_SMI:
+    case POWERPC_EXCP_PERFM:
+    case POWERPC_EXCP_THERM:
+        qemu_plugin_vcpu_interrupt_cb(cs, from);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, from);
+    }
+}
+
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0 = SPR_SRR0, srr1 = SPR_SRR1;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -456,6 +477,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             env->spr[SPR_40x_ESR] = ESR_FP;
@@ -510,12 +532,14 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
     env->spr[srr0] = env->nip;
     env->spr[srr1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -567,6 +591,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -653,12 +678,14 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
     env->spr[SPR_SRR0] = env->nip;
     env->spr[SPR_SRR1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -708,6 +735,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -758,6 +786,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         if (lev == 1 && cpu->vhyp) {
             cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
+            qemu_plugin_vcpu_hostcall_cb(env_cpu(env), last_pc);
             return;
         }
 
@@ -803,12 +832,14 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     env->spr[SPR_SRR0] = env->nip;
     env->spr[SPR_SRR1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -858,6 +889,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -908,6 +940,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         if (lev == 1 && cpu->vhyp) {
             cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
+            qemu_plugin_vcpu_hostcall_cb(env_cpu(env), last_pc);
             return;
         }
 
@@ -947,6 +980,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     env->spr[SPR_SRR0] = env->nip;
     env->spr[SPR_SRR1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 static void powerpc_excp_ppe42(PowerPCCPU *cpu, int excp)
@@ -1073,6 +1107,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0 = SPR_SRR0, srr1 = SPR_SRR1;
+    uint64_t last_pc = env->nip;
 
     /*
      * Book E does not play games with certain bits of xSRR1 being MSR save
@@ -1144,6 +1179,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -1252,6 +1288,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
     env->spr[srr0] = env->nip;
     env->spr[srr1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 /*
@@ -1373,6 +1410,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0 = SPR_SRR0, srr1 = SPR_SRR1, lev = -1;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -1472,6 +1510,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -1516,6 +1555,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         if (lev == 1 && books_vhyp_handles_hcall(cpu)) {
             cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
+            qemu_plugin_vcpu_hostcall_cb(env_cpu(env), last_pc);
             return;
         }
         if (env->insns_flags2 & PPC2_ISA310) {
@@ -1662,6 +1702,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         ppc_excp_apply_ail(cpu, excp, msr, &new_msr, &vector);
         powerpc_set_excp_state(cpu, vector, new_msr);
     }
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 #else
 static inline void powerpc_excp_books(PowerPCCPU *cpu, int excp)
-- 
2.47.3


