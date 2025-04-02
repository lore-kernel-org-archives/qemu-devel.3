Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BF6C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05G3-0004PK-8d; Wed, 02 Apr 2025 17:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05G0-0004OJ-P9
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:21 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Fy-0006AW-T7
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso1191675e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627857; x=1744232657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5k4RcvyvIMMN5CGCZGZkVn13Th0CV3ydKqT2MG/pVB0=;
 b=sYy4FZyHnE/gqBC5S+n6a3wg9UXSZJj0minM+40XM5d2E5NH1f5aqlq9o1khVpnUvZ
 FHhwU6wrn2X2aK8oEmHpHHGozr1yKfPihL28BdE71XW8vLsQU4hgjUxV0EXCFPZV2Wtx
 mGgo3FG/i+Mw8oQ8oKMSbS0fG5tIcbVUqywCSNLXSgPTEPHFwABY+RNrRZvzck+Kn05q
 H0lsDNAk64fWCJDfLkvYvV3Aj/ss2mfFUZ4EjVrFe7BOJ/fLAQy62MBtJWfmoHIuahwH
 Xe2ZZ7aUu2BfWSUwBnPTaFWVkjTHrXZnG28wCHWE8RShQE2xVHYZv9yUCcLSUxkdbNRL
 nB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627857; x=1744232657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5k4RcvyvIMMN5CGCZGZkVn13Th0CV3ydKqT2MG/pVB0=;
 b=CXVQttMbDCIrkJIo4UaoaaPLSqcMFgr7F9TTdwxqapHAT+R1CaB5AAeFInuZ7YyhIn
 UNzYrZX1i8+JumjjM052BDXoHWV4HZNhoKxeXXZQC/OUZVrJcf84/4ZQj6Ra5xAWBKKG
 fkdXXK7jQoLP0ZFeijTXuLp2bFnXSusMLvk2M1xdjPZ/K5kdxIU6lE69Lb9gkpuhTEcu
 KbsuyoJNYVNyplqok9qIUtR7CXFCwDGYESu9HW6HNFQnsXeOm54c82vI2Iy3CMjrOBmL
 S9r6AsBhcV/r04KlU/opoVWdwXj7CM3srAC1QXL5vnobbptJeCknAks3DEaNfduHt4jv
 kxpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuZVtbxCwmGdFA3TZ1T7LzxVzSmQ9KNb/pC6+5t4s1ASgbUKfHwaBj5DFWAAAxH9NawOnhnUC4YmB5@nongnu.org
X-Gm-Message-State: AOJu0Yy2w8F/q5N0zHILD1q/BmLVqr+gq15ZVjIh24czd24HZ/E9gDLA
 nCPntOxyzeXtsMKSqF2bj6oVwRFyM949nHVhRwjYYapJJ1zll7FUxeNBdkWzB3Fg4GHLXAeorWw
 s
X-Gm-Gg: ASbGnctoh3f8hXnp9zrqMu4blPQ0tOwAqnBd1rsPHrMIUJ97851NcoR2z4aXQYXMjt9
 a7uMEuVMiBF2HsAbToaWa1r4CG2OAyopRWTZp6CKYKQerJ+o386P/OoWCiUCppYd942naXVOeVN
 ZjpnuLAUcMOiCkfYQOorhbYT57VloK7RulmDfJLjB4EFZh5CRoFAuEXKFRZcwY+Zxd8soMg/22w
 cZN+FA+RQYmsapNWLHlELj0F3985Q4Emy+i6X6Va9ufEkgIpZ3GiyFp4+r5neL6+5BUCKTzYIec
 Mc6vOSsaWdJR6ssamolp4TJ4ROLe3k1O7Qno4S3FyfH9YbnevpQBwmDlX07P8xCrSuKghZpiLYT
 E6N+wmQZxyBk8rJ18nx8=
X-Google-Smtp-Source: AGHT+IFzuCLVM/tXtjNeI2w19MT+PoQRF9KprjtLI28Mgj+Drx3zwAjISXhjpe4qwhK3GPmq2GdReg==
X-Received: by 2002:a05:600c:34c6:b0:43c:eeee:b706 with SMTP id
 5b1f17b1804b1-43ec14d7fb8mr1883245e9.24.1743627857326; 
 Wed, 02 Apr 2025 14:04:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec24ed28csm53205e9.16.2025.04.02.14.04.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:04:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 10/43] target/i386: Restrict cpu_mmu_index_kernel()
 to TCG
Date: Wed,  2 Apr 2025 23:02:55 +0200
Message-ID: <20250402210328.52897-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Move cpu_mmu_index_kernel() to seg_helper.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h            |  1 -
 target/i386/tcg/seg_helper.h |  4 ++++
 target/i386/cpu.c            | 16 ----------------
 target/i386/tcg/seg_helper.c | 16 ++++++++++++++++
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ad14e22224e..a557dccf3e2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2596,7 +2596,6 @@ static inline bool is_mmu_index_32(int mmu_index)
 }
 
 int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
-int cpu_mmu_index_kernel(CPUX86State *env);
 
 #define CC_DST  (env->cc_dst)
 #define CC_SRC  (env->cc_src)
diff --git a/target/i386/tcg/seg_helper.h b/target/i386/tcg/seg_helper.h
index 6b8606cd6d8..ea98e1a98ed 100644
--- a/target/i386/tcg/seg_helper.h
+++ b/target/i386/tcg/seg_helper.h
@@ -20,6 +20,8 @@
 #ifndef SEG_HELPER_H
 #define SEG_HELPER_H
 
+#include "cpu.h"
+
 //#define DEBUG_PCALL
 
 #ifdef DEBUG_PCALL
@@ -31,6 +33,8 @@
 # define LOG_PCALL_STATE(cpu) do { } while (0)
 #endif
 
+int cpu_mmu_index_kernel(CPUX86State *env);
+
 /*
  * TODO: Convert callers to compute cpu_mmu_index_kernel once
  * and use *_mmuidx_ra directly.
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index af46c7a392a..0b74b9a3754 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8669,22 +8669,6 @@ static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
     return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
 }
 
-static int x86_mmu_index_kernel_pl(CPUX86State *env, unsigned pl)
-{
-    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 0 : 1;
-    int mmu_index_base =
-        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
-        (pl < 3 && (env->eflags & AC_MASK)
-         ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX);
-
-    return mmu_index_base + mmu_index_32;
-}
-
-int cpu_mmu_index_kernel(CPUX86State *env)
-{
-    return x86_mmu_index_kernel_pl(env, env->hflags & HF_CPL_MASK);
-}
-
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     X86CPU *cpu = X86_CPU(cs);
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 71962113fb8..f4370202fed 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -128,6 +128,22 @@ int get_pg_mode(CPUX86State *env)
     return pg_mode;
 }
 
+static int x86_mmu_index_kernel_pl(CPUX86State *env, unsigned pl)
+{
+    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 0 : 1;
+    int mmu_index_base =
+        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
+        (pl < 3 && (env->eflags & AC_MASK)
+         ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX);
+
+    return mmu_index_base + mmu_index_32;
+}
+
+int cpu_mmu_index_kernel(CPUX86State *env)
+{
+    return x86_mmu_index_kernel_pl(env, env->hflags & HF_CPL_MASK);
+}
+
 /* return non zero if error */
 static inline int load_segment_ra(CPUX86State *env, uint32_t *e1_ptr,
                                uint32_t *e2_ptr, int selector,
-- 
2.47.1


