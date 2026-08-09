Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955C8C5AD2C
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 01:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wssQJ-0000QS-GM; Sat, 08 Aug 2026 21:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQI-0000Pz-H5
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:58 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQG-0002OH-IM
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:58 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so787907a91.3
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 18:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786239235; x=1786844035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vP07yqpkjRyDv/S/nnmckw5rlPZxwQxqznXafIp0aFM=;
 b=q9rMHV8EwNicDKSG9UiV0GMEho+kIbWgyDrnWyivBMwKoK6EtHq44Gf0XWK9Ve9K+D
 SaHC4+EfNA+bT4EntoYu7rqgKOSAjMG1Yo2HHjDR53V6ex4HvPFTC9fcTs1a4sTx/1Ly
 JJPQveI/r+j1em6edgFBfcVQHP2xxrvqMdVhKeZ93j8d3wUORMmmHaeYUXuFjGqwge1M
 nLSRfW+FPFbivLCI/k0NTBkx4+5XYZz7/wqZxGXk2WyqxGdiEJPm3CzIJ4orPEkvFl/7
 LK7Wi31gaT5kbFoWSRlLmZKYYN4gxeD7OAkaWXMBUic+rV4MZ6JSFBaYqLaq0l71yUfc
 RiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786239235; x=1786844035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vP07yqpkjRyDv/S/nnmckw5rlPZxwQxqznXafIp0aFM=;
 b=mWaIO2gwfovtgfb/+eHR/OoM/izx2mVU98yw51yLeJ5s1/pAowueVWvVC5jsBnfLCW
 edkFOiwETTD/5TE7wzGj8JXecIMiDv7EfVwHyG2FxZGk5GlwZwpt6WkeZdY5wYqNANd7
 gjND88JICJHVkUplBqL+cLiWrqs2V6/YLccW+9n43BMsV/ZagFOhEs/YJG92UONO4FsB
 0kBR6mYhe38smDjMuVXWVy9WwW+ItQ1YiRHSKQiW5zklZ6aa/xk4hizy2pvfkoC9mhbx
 +Miuxk4yAHnDpEF7wKVB36dbN0+qpgY3eLcJUXt8Gc4WQpEOTcimlj9QmBEl36F1sKy0
 6XpQ==
X-Gm-Message-State: AOJu0YyWSGBE+2//S0ynSnnkdZTTV8IFRNRXh2GWVnqfRY9NDG9EZdzE
 rkX7Ia+/0pDt5OeY7hGeyTUZMaWt5jAUC3EW6CFvFfGeCtJByS4HHcUSuG9LfMdYTOqukZ20C6l
 ofqTc
X-Gm-Gg: AR+sD106xMjLVTNF0CEVHwS8/96UMaBfOd+buh6pFb4tiolVltEr82PCygtg2le1FTR
 jPZCukG8tXuAwksl5+pIOaq+Aw7AwvSZrrB51EcSCmuUiDizYAaTmgmdwaYJ89Asaf5TnIwTrcL
 yqG+NRoUZuNF0pvcOSpC+Co5Yuc59o8EgIykcnR2BMjPWLieMG7/gxzeBRXj8i9B2F9RVs302Y5
 TQTnOqWXprClNDqSTg1RJvSOjbn3yNMdQYBij3+hNPM5zDs0B+oCTK8e3p72yYRcna5AMPy9oFH
 Ik8EfDCZAqg/Sn9AEy4r6pECH2X2KJhy+E2CsTD04toagu6pngUTTK130rYy6LlOKpDHbK1bU/M
 6xtLyjsCAaztzblakQc82/d/cGordqK6DmP5agqueIAL8dO83D2N3LuDlY4MVM8QHM9FHCppB1z
 grKWfngChDGdnkC008Ux3kdDdJNsV0B8P38Jjc/ebav6c0IfhLQW8LhYO+H4qJxFuVvCfgELZ09
 Xyptv/70o+tPeZr9NSI
X-Received: by 2002:a17:90b:28cf:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-3903c53496dmr38916550a91.3.1786239235124; 
 Sat, 08 Aug 2026 18:33:55 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085de8ddcsm10067927a91.6.2026.08.08.18.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 18:33:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 8/9] target/m68k: Enable disassembly via capstone
Date: Sat,  8 Aug 2026 18:33:42 -0700
Message-ID: <20260809013343.664966-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809013343.664966-1-richard.henderson@linaro.org>
References: <20260809013343.664966-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/capstone.h | 20 +++++++++++++
 target/m68k/cpu.c        | 65 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index 87f8f6181f..3d6f90d816 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -14,6 +14,7 @@
 
 #define CS_ARCH_ARM     -1
 #define CS_ARCH_ARM64   -1
+#define CS_ARCH_M68K    -1
 #define CS_ARCH_MIPS    -1
 #define CS_ARCH_X86     -1
 #define CS_ARCH_PPC     -1
@@ -28,6 +29,12 @@
 #define CS_MODE_THUMB            0
 #define CS_MODE_MCLASS           0
 #define CS_MODE_V8               0
+#define CS_MODE_M68K_000         0
+#define CS_MODE_M68K_010         0
+#define CS_MODE_M68K_020         0
+#define CS_MODE_M68K_030         0
+#define CS_MODE_M68K_040         0
+#define CS_MODE_M68K_060         0
 #define CS_MODE_MICRO            0
 #define CS_MODE_MIPS3            0
 #define CS_MODE_MIPS32R6         0
@@ -44,6 +51,19 @@
 #define CS_MODE_LOONGARCH64      0
 #endif
 
+#if CS_API_MAJOR < 6
+#define CS_MODE_M68K_CF_ISA_A    0
+#define CS_MODE_M68K_CF_ISA_A_PLUS 0
+#define CS_MODE_M68K_CF_ISA_B    0
+#define CS_MODE_M68K_CF_ISA_C    0
+#define CS_MODE_M68K_CF_USP      0
+#define CS_MODE_M68K_CF_DIV      0
+#define CS_MODE_M68K_CF_MAC      0
+#define CS_MODE_M68K_CF_EMAC     0
+#define CS_MODE_M68K_CF_EMAC_B   0
+#define CS_MODE_M68K_CF_FPU      0
+#endif
+
 #if CS_API_MAJOR < 5
 #define CS_ARCH_RISCV           -1
 #define CS_MODE_RISCV32          0
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9ad3057d91..6acf23b29b 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -22,7 +22,7 @@
 #include "accel/tcg/cpu-ops.h"
 #include "fpu/softfloat.h"
 #include "qapi/error.h"
-
+#include "disas/capstone.h"
 #ifndef CONFIG_USER_ONLY
 #include "migration/vmstate.h"
 #include "monitor/hmp.h"
@@ -182,9 +182,72 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
 
 static void m68k_cpu_disas_set_info(const CPUState *cs, disassemble_info *info)
 {
+    CPUM68KState *env = cpu_env((CPUState *)cs);
+    int cap_mode = 0;
+
     info->print_insn = print_insn_m68k;
     info->endian = BFD_ENDIAN_BIG;
     info->mach = 0;
+
+    /* m68k support in capstone prior to v6 is unusably bad */
+    if (CS_API_MAJOR < 6) {
+        return;
+    }
+
+    info->cap_arch = CS_ARCH_M68K;
+    info->cap_insn_unit = 2;
+
+    if (m68k_feature(env, M68K_FEATURE_M68K)) {
+        /*
+         * m68k insns may have up to 11 words, and 5 words are common.
+         * Choosing 12 bytes splits after 6 words and disassembly
+         * uses no more than 2 lines.
+         */
+        info->cap_insn_split = 12;
+        if (m68k_feature(env, M68K_FEATURE_M68060)) {
+            cap_mode = CS_MODE_M68K_060;
+        } else if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            cap_mode = CS_MODE_M68K_040;
+        } else if (m68k_feature(env, M68K_FEATURE_M68030)) {
+            cap_mode = CS_MODE_M68K_030;
+        } else if (m68k_feature(env, M68K_FEATURE_M68020)) {
+            cap_mode = CS_MODE_M68K_020;
+        } else if (m68k_feature(env, M68K_FEATURE_M68010)) {
+            cap_mode = CS_MODE_M68K_010;
+        } else {
+            cap_mode = CS_MODE_M68K_000;
+        }
+    } else {
+        /* ColdFire insns may have up to 3 words. */
+        info->cap_insn_split = 6;
+        if (m68k_feature(env, M68K_FEATURE_CF_ISA_A)) {
+            cap_mode |= CS_MODE_M68K_CF_ISA_A;
+            cap_mode |= CS_MODE_M68K_CF_DIV;
+        }
+        if (m68k_feature(env, M68K_FEATURE_CF_ISA_B)) {
+            cap_mode |= CS_MODE_M68K_CF_ISA_B;
+        }
+        if (m68k_feature(env, M68K_FEATURE_CF_ISA_APLUSC)) {
+            cap_mode |= CS_MODE_M68K_CF_ISA_A_PLUS;
+            cap_mode |= CS_MODE_M68K_CF_ISA_C;
+        }
+        if (m68k_feature(env, M68K_FEATURE_USP)) {
+            cap_mode |= CS_MODE_M68K_CF_USP;
+        }
+        if (m68k_feature(env, M68K_FEATURE_CF_FPU)) {
+            cap_mode |= CS_MODE_M68K_CF_FPU;
+        }
+        if (m68k_feature(env, M68K_FEATURE_CF_MAC)) {
+            cap_mode |= CS_MODE_M68K_CF_MAC;
+        }
+        if (m68k_feature(env, M68K_FEATURE_CF_EMAC)) {
+            cap_mode |= CS_MODE_M68K_CF_EMAC;
+        }
+        if (m68k_feature(env, M68K_FEATURE_CF_EMAC_B)) {
+            cap_mode |= CS_MODE_M68K_CF_EMAC_B;
+        }
+    }
+    info->cap_mode = cap_mode;
 }
 
 /* CPU models */
-- 
2.43.0


