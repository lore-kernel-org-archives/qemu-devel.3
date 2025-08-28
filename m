Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE65CA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgI5-00065J-5x; Thu, 28 Aug 2025 13:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWN-00086t-IK
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:33 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWB-0008JZ-NQ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:18 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso831147b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383253; x=1756988053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udROh7IxyCPMaBQMSkwhMc7r8ev3r6iqORdDf9N+B/Y=;
 b=NwLOdTlWjrOZBLiuo++MfIFh0NMpf9mAV0iLJgrNU8oi5UGTSz5SQxEU+Bh0waxwOB
 8uvL8n/QJ33yAWO53lbldczfVnhYxWOvr6+905dWOTr+wr5Sq9A/sjJs03u161zByp6b
 lpR5u7Saps5tNa1kqJWL0u882SgI5bj+pvUpjynuJdlIrYfb7BqBR29D1+l/BeMgyck3
 +AwHWYG8ggoNkKee6dSwY9gJPlyF0SnznBF6tU7zPOkkG94de/aOR5Uz1mCSpVLBX5DQ
 AA3uecUYCY8kluGmZ0c4V1WzrbdbNK26y9uTSIRhM/H5UvfnL+dlzSqUkkhzmR+i5I2x
 FyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383253; x=1756988053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=udROh7IxyCPMaBQMSkwhMc7r8ev3r6iqORdDf9N+B/Y=;
 b=pqsKnFN74gnl/YVD2T/+S19D/sQ+xzsr88TXifzdJgsFLUelPyl+zTX3SiXYTCIXMh
 Qbcn0we7858wYrcpCA3l0n18lwtj1zVjNuXlfbAh36v7wzOE1cB7YS2PoQu5xJtZcfO3
 AmPL8XzVbz1nAIGqia9U22Fyo5MkbNHH/qM0k5vqi9+Xjsiubtk1BapiI7o9w3ceRZZY
 qRj9Ac95rlPXN7erJtrW57PjDGRbfsyEDWNKoHWYT1s+QNyaOWijLdAzIyzG8lA597pn
 q9nd3g/TguqHVP5yk2gn7c99vcZ0SicZuvLukKpSsPwTOWygr6UPQ8RjjhIYNgU2RyKu
 q/+w==
X-Gm-Message-State: AOJu0YxUN7Ylz1MCSxebRhZ41RlzcvOE5SQ969Q8lPtFYHE38UQgKVaQ
 bzAUWu+StfZ5eojunhq/gAIvjgyhZyxNkr3jOF1rNUbnHOyJKIwIak5gANAZ4NTY9wR76xqvC4y
 erE9FHMk=
X-Gm-Gg: ASbGncsVik2mtCXC/UJVBMacEHI1MnVliDhCBkJGDGnbYj/42CPl0WqBVlF7CuHLswl
 we8eDfWfCodPcVLNxaiX1Jh84kE2tKtJh0u7SYsLaCpZPdNPFSm2cy1JX2gQbM0VQgnAWZ8s0Oe
 RtSYe6mKQ2gw4z4sapg2DyblpsteLJJCoHPGcElRdPAHW4hhERZ4k1vKvmnWLUvjJylsf9E2gG5
 dSn4r8hZEgmegbDOZ/qRoHerTUQfepqOx3dVFQp/N4zgBApfeTmopgrxWkqZ4rdLCLXopEZVc6g
 SmqLh1Y6hxu9IACKhcdZQxaBkVU9ysJeVFsL0fCK/0zfDNArObQJiPexkA6ctQIxAcA9lLrOwyE
 yQdRV7m1WIRq0fi1DFpQFuk+NRKBijE9gId4s
X-Google-Smtp-Source: AGHT+IGegd23sX3UCoRDGeERtKI3Q/TlDFvrhae4RzI2VXQ2TWy7ey7wibadeU46Xnvi/FUXu8ifxg==
X-Received: by 2002:a17:902:e888:b0:23f:df56:c74c with SMTP id
 d9443c01a7336-2462ee38734mr276878115ad.14.1756383253194; 
 Thu, 28 Aug 2025 05:14:13 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 56/87] linux-user/xtensa: Expand target_elf_gregset_t
Date: Thu, 28 Aug 2025 22:08:05 +1000
Message-ID: <20250828120836.195358-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/xtensa/target_elf.h | 12 ++++++-----
 linux-user/xtensa/elfload.c    | 39 +++++++++++-----------------------
 2 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index 43e241aac1..850a7206a5 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -8,14 +8,16 @@
 #ifndef XTENSA_TARGET_ELF_H
 #define XTENSA_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-/* See linux kernel: arch/xtensa/include/asm/elf.h.  */
-#define ELF_NREG                128
+/*
+ * See linux kernel: arch/xtensa/include/asm/elf.h, where elf_gregset_t
+ * is mapped to struct user_pt_regs via typedef and sizeof.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_user_pt_regs pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/xtensa/elfload.c b/linux-user/xtensa/elfload.c
index 49e709a094..68aeed855f 100644
--- a/linux-user/xtensa/elfload.c
+++ b/linux-user/xtensa/elfload.c
@@ -11,36 +11,21 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return XTENSA_DEFAULT_CPU_MODEL;
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
-enum {
-    TARGET_REG_PC,
-    TARGET_REG_PS,
-    TARGET_REG_LBEG,
-    TARGET_REG_LEND,
-    TARGET_REG_LCOUNT,
-    TARGET_REG_SAR,
-    TARGET_REG_WINDOWSTART,
-    TARGET_REG_WINDOWBASE,
-    TARGET_REG_THREADPTR,
-    TARGET_REG_AR0 = 64,
-};
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUXtensaState *env)
 {
-    unsigned i;
+    r->pt.pc = tswap32(env->pc);
+    r->pt.ps = tswap32(env->sregs[PS] & ~PS_EXCM);
+    r->pt.lbeg = tswap32(env->sregs[LBEG]);
+    r->pt.lend = tswap32(env->sregs[LEND]);
+    r->pt.lcount = tswap32(env->sregs[LCOUNT]);
+    r->pt.sar = tswap32(env->sregs[SAR]);
+    r->pt.windowstart = tswap32(env->sregs[WINDOW_START]);
+    r->pt.windowbase = tswap32(env->sregs[WINDOW_BASE]);
+    r->pt.threadptr = tswap32(env->uregs[THREADPTR]);
 
-    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
-    r->regs[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
-    r->regs[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
-    r->regs[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
-    r->regs[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
-    r->regs[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
-    r->regs[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
-    r->regs[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
-    r->regs[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
     xtensa_sync_phys_from_window((CPUXtensaState *)env);
-    for (i = 0; i < env->config->nareg; ++i) {
-        r->regs[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
+
+    for (unsigned i = 0; i < env->config->nareg; ++i) {
+        r->pt.a[i] = tswap32(env->phys_regs[i]);
     }
 }
-- 
2.43.0


