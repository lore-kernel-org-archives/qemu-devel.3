Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E36C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5Co-0005bi-5P; Thu, 23 Jan 2025 16:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5CG-00057R-7Y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:08 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5CD-0002qo-5A
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:07 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so1389031f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669423; x=1738274223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/s+egRhxN6zM3AeA9IUXU+DNXqnyBTll7yI3vCEboM=;
 b=p/1Es+RDSVpBnyLg5qeJbSTzlC1hwwkoDGOCTstOcSi7guApRsdMGSLuRWQomVouoI
 y6RCtQyu8RuNxYz06xRukKPvNxy5UjYEtVtECVBxszvuLwv5sQMhyeF1k1nS4RCOlurq
 YUSquSZVftOojD3Uj8mPaxfWTN+x1UKHrpcnVFsFpjxqG9yijQjwIz5T5TuLNIpiqiMS
 qNmiJCNTFwLSGlMFneNn4SFNQ+gHeyA43CmtKbHKlY7mlNRUgeJ3G3nfCuTrtYoieGek
 e42BWz4g0jXK6I2zDPhe5LmICDNg/D2o0Hvx6NEEkbYS7/nVmBSiIBsDhkoj17NjDego
 KETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669423; x=1738274223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/s+egRhxN6zM3AeA9IUXU+DNXqnyBTll7yI3vCEboM=;
 b=w87Rv0J7qrLWOryYkJB8D1UXY4c+uVihTq+pMeih75oJgvuotDiRI/SzdyhqlJrrGf
 EkPZ4hdRHyhXitc6swqyWseQWaIayoFgIHQnzoHS2cZGhT5IR1vDShkHxwGDwKhZmJ/R
 S7mnhKQHFXu0lE3nMwB2Tj2jq4X8wjApawiEWKgAs4uUtiF2033Slfz3RLB9RXc3kzJS
 jnkvb36WWPIUUnBmhYMl39TqKgFgV9fXPaVG7M/ILUkVb9jc+PJZmRnwU6gVTr12MuHW
 G+1r5us0TCSiPRG8zEW7ZNeFHbtG2WNKsm2lfufEy3HT6ncJTQ6+PakDqOmYUXclllz1
 9jyg==
X-Gm-Message-State: AOJu0YxEw+ID9VSUfgxResrsCwOSAUbiiypyD+XF8LTe7UKoKBrDkV99
 zcWtrwI+iNwrnwL4x+LF/Xolx/JZVSwlEArPMTkfGTQBKm++jZx6tFaD9SXonBv/XbE7MYX8S2F
 0Hwo=
X-Gm-Gg: ASbGncsDNxh5M0oyubYjwKY3o3imK3OMIqJMzH0vh5iiChIEe09zOtyBAucFoh6BpDJ
 I75zc3LhUjsuW0siWJsxfpEQTIdf32yTiFX4z/IWBhdfgj7bXDlLBwlzqZctXWNitjtJnHmQfSh
 oKiwKWlhKu5feApA1iwstXMnagWPltmuiqgE9VnLQiI4dnZNzEFcL7bMOt8n8S05iRgaCm1vmli
 fmVJ3rwf04tGaSrF7v3bD5GNHNlLKwQWZTmL4TYSZVHBXUT2w1S7YEtGyQ9tQxpy/8xq72Qy0Zh
 lYvg2Sc7KtQkJFQYNwHeXK34R8VCHR9HFCjaUmbtQksU5abE4C36NMU=
X-Google-Smtp-Source: AGHT+IGFtKMFQk+rFfpJR8HRwmvQ0n4eqyl0/MoL934TlFuj/D3aq71RyR+SeaUwIhCwGnueb0R8/w==
X-Received: by 2002:a5d:64a1:0:b0:38a:8ace:85e8 with SMTP id
 ffacd0b85a97d-38bf57a98fdmr30215746f8f.44.1737669422872; 
 Thu, 23 Jan 2025 13:57:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c42b4sm791232f8f.99.2025.01.23.13.57.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:57:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/15] target/ppc: Restrict ppc_tcg_hv_emu() to TCG
Date: Thu, 23 Jan 2025 22:56:04 +0100
Message-ID: <20250123215609.30432-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
 target/ppc/internal.h        |   3 ++
 target/ppc/excp_helper.c     | 101 +++++------------------------------
 target/ppc/tcg-excp_helper.c |  71 ++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 89 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 42e33be496f..3f9dc6f514e 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -291,6 +291,9 @@ bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
 bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
 G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason);
+bool is_prefix_insn_excp(CPUPPCState *env, int excp);
+void ppc_tcg_hv_emu(CPUPPCState *env, target_ulong *new_msr,
+                    int *srr0, int *srr1);
 #endif
 
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
index 268a1614597..ecc9e4de8ba 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -283,4 +283,75 @@ uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
     return insn;
 }
 
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
 #endif /* !CONFIG_USER_ONLY */
-- 
2.47.1


