Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE2ACA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgCJ-00037x-Ah; Thu, 28 Aug 2025 13:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVn-0007fB-HU
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:54 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVj-0008EB-02
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:48 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-248c7f955a2so8134465ad.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383225; x=1756988025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERLV6kpirnkz5HKBU0xee2cpCb7A4GeGx0VqhmBDmVs=;
 b=wonQceuW58ZQdrMJEqPd2IWEITHAcrtBygmT2N6yBuShDr26VcCFuQ5+WfFNMqU5Id
 ACdFIi0NXQJHY6I7sc6tw3iDgq6JABCXkZLAcDlAsqPfTx+zEzmADVFtOzXpXlfttwbM
 3oZ5BnHDOZkEWtCVCZk8IhnjX0hx4XQclQkKFtOkK8k8NHXVJQ2QR5IdCrMPD5g2UT0e
 TBw5FREDD8oh7tGLyDSXJ5wDQ/4ttnJof5lwVioBKFL7FfJ1gqcFg8rargC1eZzYWNP+
 Qx76T06oTaj5BS7FcXFN3qx1WUUrFdEtcMjwIbGCg7mXLUKSe5ViirpsXyM88xaHx5Ex
 sAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383225; x=1756988025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ERLV6kpirnkz5HKBU0xee2cpCb7A4GeGx0VqhmBDmVs=;
 b=FTY6MvHaMuXbjRACPQEQSb+91PoXazF6369BTSr0oAboOHbp8828MAMnC/CrIfhGfD
 gFaX8QqXDZoR+9lnuDGEYp1a08e5y8MRKInS/UpGaKdIGaKe38Y9g8Yg7aq+wMMwhiFi
 7M/V6YQZogoVa2Z3xk6zLGQ12Fqn0OiKeEODCJIlzL7YaKeKt3QtbLFfB32OEObytEbv
 NV9OU367vCGuqWTrxfjuWXU6NiOOaJPeiH06AQdXZ4DXb/oVfgMmpqX27p2xg8Gq7478
 xreIE9sGISCrLoTKN2fHzYnplozQPrOZYbtCyvClpst+lRc62GncXRMJLkFehxcAWPNK
 mRIg==
X-Gm-Message-State: AOJu0Ywmen4JQb8QbW+n9oWKivhZIQF399KSgMwKTBI4/H3U607PbUJD
 w6TzZtUvnkcuDP68gF9e5JwxZ5zDgbTLtxQM59wY92abVhDhNf18kj+di5GzXu8Jngz9GS/Px0a
 SVvjcWBE=
X-Gm-Gg: ASbGncsPwWWoEavVKNOqw7vNfEyqzi569kdx8FpTwUKwfeLAvwAsPTVeMr+736hj2l9
 6+clsmRfgN9LuFebtV+vlO3GfY46bwFiPZmWUcjKUT/4pPPILQWPPLO00BwOoQipbM1JcLXGbaD
 rx6taXzvrS2329TwYIfKnTYllhAhv94AJHOj4NbJOVhGYTZlN/J50moN5OiLwaGIAnCb47M2Rf1
 ERvqCwb0oZy6JU3ZqeXPe8WhzubO021j71qXVfhI3MXsdCQg8BorII6c9/9THIcyDQ1udnGCwvu
 7KN8V3KLUa9FbiedxzoyO+ny55y1r/OZdNDSwuKaDl5WOhYNyfmtemyQR9SGC0pcfCv8pQ5Hhre
 KtMS4x5CZUFvEJzKsiAdOj2gzye0dyHQkEt/K
X-Google-Smtp-Source: AGHT+IFPu0cVs9+5+TNPcbkSyZCX3Gpgjt3sPmfHXqy6D2G0s/R6On7KMHsMt8P/JLqhGY6XMyaf+g==
X-Received: by 2002:a17:902:e74a:b0:248:8d0a:b4c4 with SMTP id
 d9443c01a7336-2488d0ab7a5mr102249115ad.47.1756383224905; 
 Thu, 28 Aug 2025 05:13:44 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:13:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 46/87] linux-user/mips: Use target_ulong for
 target_elf_greg_t
Date: Thu, 28 Aug 2025 22:07:55 +1000
Message-ID: <20250828120836.195358-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Make use of the fact that target_elf_gregset_t is a proper structure.
The target_ulong type matches the abi_ulong/abi_ullong
selection within mips64/target_elf.h.

Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mips/target_elf.h   | 10 ++++---
 linux-user/mips64/target_elf.h | 14 +++++-----
 linux-user/mips/elfload.c      | 48 +++++++---------------------------
 3 files changed, 22 insertions(+), 50 deletions(-)

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index f767767eaa..a4b7fadbd6 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -8,16 +8,18 @@
 #ifndef MIPS_TARGET_ELF_H
 #define MIPS_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_BASE_PLATFORM  1
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
 /* See linux kernel: arch/mips/include/asm/elf.h.  */
-#define ELF_NREG                45
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    union {
+        abi_ulong reserved[45];
+        struct target_pt_regs pt;
+    };
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 046a165eef..67bc963134 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -8,20 +8,18 @@
 #ifndef MIPS64_TARGET_ELF_H
 #define MIPS64_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_BASE_PLATFORM  1
 #define HAVE_ELF_CORE_DUMP      1
 
-#ifdef TARGET_ABI_MIPSN32
-typedef abi_ullong target_elf_greg_t;
-#else
-typedef abi_ulong target_elf_greg_t;
-#endif
-
 /* See linux kernel: arch/mips/include/asm/elf.h.  */
-#define ELF_NREG                45
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    union {
+        target_ulong reserved[45];
+        struct target_pt_regs pt;
+    };
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index 6e884911af..e0c50f50ed 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -124,47 +124,19 @@ const char *get_elf_base_platform(CPUState *cs)
 
 #undef MATCH_PLATFORM_INSN
 
-#ifdef TARGET_ABI_MIPSN32
-#define tswapreg(ptr)   tswap64(ptr)
-#else
-#define tswapreg(ptr)   tswapal(ptr)
-#endif
-
-/* See linux kernel: arch/mips/include/asm/reg.h.  */
-enum {
-#ifdef TARGET_MIPS64
-    TARGET_EF_R0 = 0,
-#else
-    TARGET_EF_R0 = 6,
-#endif
-    TARGET_EF_R26 = TARGET_EF_R0 + 26,
-    TARGET_EF_R27 = TARGET_EF_R0 + 27,
-    TARGET_EF_LO = TARGET_EF_R0 + 32,
-    TARGET_EF_HI = TARGET_EF_R0 + 33,
-    TARGET_EF_CP0_EPC = TARGET_EF_R0 + 34,
-    TARGET_EF_CP0_BADVADDR = TARGET_EF_R0 + 35,
-    TARGET_EF_CP0_STATUS = TARGET_EF_R0 + 36,
-    TARGET_EF_CP0_CAUSE = TARGET_EF_R0 + 37
-};
-
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 {
-    int i;
-
-    for (i = 0; i <= TARGET_EF_R0; i++) {
-        r->regs[i] = 0;
-    }
-    for (i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
-        r->regs[TARGET_EF_R0 + i] = tswapreg(env->active_tc.gpr[i]);
+    for (int i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
+        r->pt.regs[i] = tswapl(env->active_tc.gpr[i]);
     }
 
-    r->regs[TARGET_EF_R26] = 0;
-    r->regs[TARGET_EF_R27] = 0;
-    r->regs[TARGET_EF_LO] = tswapreg(env->active_tc.LO[0]);
-    r->regs[TARGET_EF_HI] = tswapreg(env->active_tc.HI[0]);
-    r->regs[TARGET_EF_CP0_EPC] = tswapreg(env->active_tc.PC);
-    r->regs[TARGET_EF_CP0_BADVADDR] = tswapreg(env->CP0_BadVAddr);
-    r->regs[TARGET_EF_CP0_STATUS] = tswapreg(env->CP0_Status);
-    r->regs[TARGET_EF_CP0_CAUSE] = tswapreg(env->CP0_Cause);
+    r->pt.regs[26] = 0;
+    r->pt.regs[27] = 0;
+    r->pt.lo = tswapl(env->active_tc.LO[0]);
+    r->pt.hi = tswapl(env->active_tc.HI[0]);
+    r->pt.cp0_epc = tswapl(env->active_tc.PC);
+    r->pt.cp0_badvaddr = tswapl(env->CP0_BadVAddr);
+    r->pt.cp0_status = tswapl(env->CP0_Status);
+    r->pt.cp0_cause = tswapl(env->CP0_Cause);
 }
-- 
2.43.0


