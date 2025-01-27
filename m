Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFC8C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMKp-00027J-6K; Mon, 27 Jan 2025 05:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKn-00025J-Tq
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:27:13 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKk-00021P-Sc
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:27:13 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so29363065e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973629; x=1738578429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1d6GEdB7lAJOa4wOJPlMuA83RtA5O50buKaoS5o522A=;
 b=OnSOyEaej6hcF3p89GStX5Vhj/TXUtlKgnukwwzG0EagDwZJNne2yLiAOibvOrTxfU
 VxVpvBYHEfa2jAgcL07f9OErgmszP7WXaGRPnmSgOg1YHJqOgoxlC1QM9INN07B1IZcq
 twEyE0x1ucEXZ2+u/8xTv7Vxykhgffs/R6Q6HJF0/M0QQp7tkdFhQ+4e85jOzBPw3dpq
 +jKpTjN9GR0y+fy5QvaHyvJAwGIfxURNmFA0tG4QTHphPUQSMiC10Y54iFgQS+1QcwAe
 BjxgfKFnJPYCMUdW6g+h3YN9RUwQU0X2mjQ1rwOsf4xad5mlFbZQySB1Az+yg4sn1KtL
 FUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973629; x=1738578429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1d6GEdB7lAJOa4wOJPlMuA83RtA5O50buKaoS5o522A=;
 b=JfrfaoRZx/Tzv3QlI41ENjWptS4EVu3HHnv/MeBWKYlSSygRAnxkbUiMEU6xsqT1gY
 jqOjdQm0sMKjEUBce+ANuiHInpRvzbqPNko275WhY/dBsdY3MbErE0Axl3R+HyYwCBfl
 pkDKJjziVeja71bClN/gKdEo92aG1PRDfD+wHnImDTIGcGOpcvUSFQmPai9Lihtabv9t
 bUvRw8mXZ3x6ehXjMnoMWdbRS0zekCuF9cp42AjGVUD7D4NukEOJwQosaguuUAedKXui
 6Lm9aEkYBCvHYxztEwq5hpRiZe0WQy2OeTLLTo+rXuiLwjF/XhwiaihPASDZC3dsK7/S
 +RQA==
X-Gm-Message-State: AOJu0YzLUszK9ZevqPyYstti0uLiBPNZYh/ImU7++C7+zNlHKfJ4IBe8
 NHGD/6na/X6NztgJhRP1D/MrGtKjxTZW95fmz3ECzXhb8IWjo9g0qAQxvQww0K+y1gxS51p8Rtf
 NB6k=
X-Gm-Gg: ASbGnct1J1nF+2XIxKVejeBZHEJ3LefT7UEHgvsOfxXOLgncsC/UMAsmBMCcsx6K5sp
 oP/JT77YooLojdoTngXiC6uwlX9Tj8mt4dBNPSKGqacBNM1+AEHTFCax2PJUbVC142/4mIMwkVe
 6P9MvMU5nZpVP8mUfVWLYT6cZ5y0rBnByTQa+kCtdNAN9Pcuhfi2LvpftWKX+YSuZQYRyuu/62G
 UglP7DiNCw8wjcDvlm6Zoam+RDnCI2+N77KXWWljYk33K/64UF8ScLb/nYyLdyAwQOg4rR4ZQ9g
 xBpKXINQRDDHEbqJd+RqS6wPb0VW3TQw7p/Tvc0xpZ3nDfk6OgcNC40=
X-Google-Smtp-Source: AGHT+IFRbgpUckgelXJc4vXcDRMyUtx90IthuaaTMb4Zdo4gw04oR+hvFt34IodgdetT1LpQSHalRg==
X-Received: by 2002:a5d:6da1:0:b0:385:e411:c894 with SMTP id
 ffacd0b85a97d-38bf57a6844mr37776084f8f.43.1737973628926; 
 Mon, 27 Jan 2025 02:27:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d697sm10458453f8f.29.2025.01.27.02.27.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:27:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/15] target/ppc: Restrict ppc_tcg_hv_emu() to TCG
Date: Mon, 27 Jan 2025 11:26:14 +0100
Message-ID: <20250127102620.39159-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
References: <20250127102620.39159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Make is_prefix_insn_excp() prototype but have it guarded by
a tcg_enabled() check. Inline part of it in powerpc_excp_books().

Extract POWERPC_EXCP_HV_EMU handling code to ppc_tcg_hv_emu(),
also exposing its prototype in "internal.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/internal.h        |   6 +++
 target/ppc/excp_helper.c     | 101 +++++------------------------------
 target/ppc/tcg-excp_helper.c |  75 ++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 89 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 62186bc1e61..0e66b29ec68 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -291,6 +291,12 @@ bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
 bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
 G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason);
+
+#if defined(TARGET_PPC64)
+bool is_prefix_insn_excp(CPUPPCState *env, int excp);
+void ppc_tcg_hv_emu(CPUPPCState *env, target_ulong *new_msr,
+                    int *srr0, int *srr1);
+#endif /* TARGET_PPC64 */
 #endif /* !CONFIG_USER_ONLY */
 
 FIELD(GER_MSK, XMSK, 0, 4)
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 6a12402b23a..56a56148a40 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "system/kvm.h"
 #include "system/tcg.h"
 #include "system/system.h"
 #include "system/runstate.h"
@@ -1194,81 +1195,6 @@ static bool books_vhyp_handles_hv_excp(PowerPCCPU *cpu)
     return false;
 }
 
-#ifdef CONFIG_TCG
-static bool is_prefix_insn(CPUPPCState *env, uint32_t insn)
-{
-    if (!(env->insns_flags2 & PPC2_ISA310)) {
-        return false;
-    }
-    return ((insn & 0xfc000000) == 0x04000000);
-}
-
-static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
-{
-    CPUPPCState *env = &cpu->env;
-
-    if (!(env->insns_flags2 & PPC2_ISA310)) {
-        return false;
-    }
-
-    if (!tcg_enabled()) {
-        /*
-         * This does not load instructions and set the prefix bit correctly
-         * for injected interrupts with KVM. That may have to be discovered
-         * and set by the KVM layer before injecting.
-         */
-        return false;
-    }
-
-    switch (excp) {
-    case POWERPC_EXCP_MCHECK:
-        if (!(env->error_code & PPC_BIT(42))) {
-            /*
-             * Fetch attempt caused a machine check, so attempting to fetch
-             * again would cause a recursive machine check.
-             */
-            return false;
-        }
-        break;
-    case POWERPC_EXCP_HDSI:
-        /* HDSI PRTABLE_FAULT has the originating access type in error_code */
-        if ((env->spr[SPR_HDSISR] & DSISR_PRTABLE_FAULT) &&
-            (env->error_code == MMU_INST_FETCH)) {
-            /*
-             * Fetch failed due to partition scope translation, so prefix
-             * indication is not relevant (and attempting to load the
-             * instruction at NIP would cause recursive faults with the same
-             * translation).
-             */
-            return false;
-        }
-        break;
-
-    case POWERPC_EXCP_DSI:
-    case POWERPC_EXCP_DSEG:
-    case POWERPC_EXCP_ALIGN:
-    case POWERPC_EXCP_PROGRAM:
-    case POWERPC_EXCP_FPU:
-    case POWERPC_EXCP_TRACE:
-    case POWERPC_EXCP_HV_EMU:
-    case POWERPC_EXCP_VPU:
-    case POWERPC_EXCP_VSXU:
-    case POWERPC_EXCP_FU:
-    case POWERPC_EXCP_HV_FU:
-        break;
-    default:
-        return false;
-    }
-
-    return is_prefix_insn(env, ppc_ldl_code(env, env->nip));
-}
-#else
-static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
-{
-    return false;
-}
-#endif
-
 static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
@@ -1310,7 +1236,15 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     }
     vector |= env->excp_prefix;
 
-    if (is_prefix_insn_excp(cpu, excp)) {
+    if (env->insns_flags2 & PPC2_ISA310) {
+        /* nothing to do */
+    } else if (kvm_enabled()) {
+        /*
+         * This does not load instructions and set the prefix bit correctly
+         * for injected interrupts with KVM. That may have to be discovered
+         * and set by the KVM layer before injecting.
+         */
+    } else if (tcg_enabled() && is_prefix_insn_excp(env, excp)) {
         msr |= PPC_BIT(34);
     }
 
@@ -1484,20 +1418,9 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
         break;
 #ifdef CONFIG_TCG
-    case POWERPC_EXCP_HV_EMU: {
-        uint32_t insn = ppc_ldl_code(env, env->nip);
-        env->spr[SPR_HEIR] = insn;
-        if (is_prefix_insn(env, insn)) {
-            uint32_t insn2 = ppc_ldl_code(env, env->nip + 4);
-            env->spr[SPR_HEIR] <<= 32;
-            env->spr[SPR_HEIR] |= insn2;
-        }
-        srr0 = SPR_HSRR0;
-        srr1 = SPR_HSRR1;
-        new_msr |= (target_ulong)MSR_HVB;
-        new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
+    case POWERPC_EXCP_HV_EMU:
+        ppc_tcg_hv_emu(env, &new_msr, &srr0, &srr1);
         break;
-    }
 #endif
     case POWERPC_EXCP_VPU:       /* Vector unavailable exception             */
     case POWERPC_EXCP_VSXU:       /* VSX unavailable exception               */
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 268a1614597..dc5601a4577 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -283,4 +283,79 @@ uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
     return insn;
 }
 
+#if defined(TARGET_PPC64)
+
+static bool is_prefix_insn(CPUPPCState *env, uint32_t insn)
+{
+    if (!(env->insns_flags2 & PPC2_ISA310)) {
+        return false;
+    }
+    return ((insn & 0xfc000000) == 0x04000000);
+}
+
+bool is_prefix_insn_excp(CPUPPCState *env, int excp)
+{
+    switch (excp) {
+    case POWERPC_EXCP_MCHECK:
+        if (!(env->error_code & PPC_BIT(42))) {
+            /*
+             * Fetch attempt caused a machine check, so attempting to fetch
+             * again would cause a recursive machine check.
+             */
+            return false;
+        }
+        break;
+    case POWERPC_EXCP_HDSI:
+        /* HDSI PRTABLE_FAULT has the originating access type in error_code */
+        if ((env->spr[SPR_HDSISR] & DSISR_PRTABLE_FAULT) &&
+            (env->error_code == MMU_INST_FETCH)) {
+            /*
+             * Fetch failed due to partition scope translation, so prefix
+             * indication is not relevant (and attempting to load the
+             * instruction at NIP would cause recursive faults with the same
+             * translation).
+             */
+            return false;
+        }
+        break;
+
+    case POWERPC_EXCP_DSI:
+    case POWERPC_EXCP_DSEG:
+    case POWERPC_EXCP_ALIGN:
+    case POWERPC_EXCP_PROGRAM:
+    case POWERPC_EXCP_FPU:
+    case POWERPC_EXCP_TRACE:
+    case POWERPC_EXCP_HV_EMU:
+    case POWERPC_EXCP_VPU:
+    case POWERPC_EXCP_VSXU:
+    case POWERPC_EXCP_FU:
+    case POWERPC_EXCP_HV_FU:
+        break;
+    default:
+        return false;
+    }
+
+    return is_prefix_insn(env, ppc_ldl_code(env, env->nip));
+}
+
+void ppc_tcg_hv_emu(CPUPPCState *env, target_ulong *new_msr,
+                    int *srr0, int *srr1)
+{
+    uint32_t insn = ppc_ldl_code(env, env->nip);
+
+    env->spr[SPR_HEIR] = insn;
+    if (is_prefix_insn(env, insn)) {
+        uint32_t insn2 = ppc_ldl_code(env, env->nip + 4);
+
+        env->spr[SPR_HEIR] <<= 32;
+        env->spr[SPR_HEIR] |= insn2;
+    }
+    *srr0 = SPR_HSRR0;
+    *srr1 = SPR_HSRR1;
+    *new_msr |= (target_ulong)MSR_HVB;
+    *new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
+}
+
+#endif /* TARGET_PPC64 */
+
 #endif /* !CONFIG_USER_ONLY */
-- 
2.47.1


