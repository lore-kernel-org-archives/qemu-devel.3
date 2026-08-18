Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFF8C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwND3-0007nG-HO; Tue, 18 Aug 2026 13:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwND1-0007mK-Es
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:43 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCz-0004uV-PZ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:43 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso23534a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072560; x=1787677360; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MIArda1Mmt88XEzYwt/OrbYMMCnRwSt7ese98CCkdYQ=;
 b=jfO7mpRR76x1yPphcQG7ILbq6O3Zf7BBceVZvFsiHGHwIm3IiL8cGTG0XYCMLlpXoB
 HtRsL0xkGinwsWtZ2wcFbCwlgiQvAhCaTt13cliwPM+cAzmQtEQ9lzE9XUMEAiM2NHC7
 wgfk28jNp4a2phc1jCJrmFS2qWBJuhhdbyaBII8nJbKWHnKTs/Q72MzhbMyKpNqsoNce
 mg7paTZcmnLHjdMGGZwT/AHyfZiCWWz37fTAoeFevIfccNflinZS+tMy7aBjqcXD/nwy
 X9YUc6wPrcBuHtcHaeRXqsN3QnM/rjCteg9+sHzdlOenwB3pRZ7JCy0hhJMtZ/Dxep7D
 pNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072560; x=1787677360;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MIArda1Mmt88XEzYwt/OrbYMMCnRwSt7ese98CCkdYQ=;
 b=OLWfmpmS12Cm70XB3YBDGbqqXbOZeNwf+Z1af2iRzOAlTdMPuC5VvcMyhG6+OhKctB
 MVbCbmpmU6hB8InRsOExmP/1GaR6x74nlK0+WDkVKqh7j9PdB6/SxgQL4wtQZOjlwbMJ
 jdQ8jclneXZx7h81SL7617yVR8wT/FxgO1XJYN15vulfmruTMcp3FEIyxclWQQDeU41Y
 qcj9lNbZ8SyC0Ym47CSRra8XYhac6LXZRuZ34GDuzFzdXkT+tegTi0333GT+CvZvISjV
 5kiOOgCV/1HXIPpB4RKK4/52WJo9GHe3cvy4YiVVs5xwuRSTmcWxrri9KcfZbEHKJYg3
 rUzg==
X-Gm-Message-State: AOJu0YzBetzSQLFdymGNL2QrC4DpvfzmqPvXHB8M+FJKa/szFbBaJ59h
 JiLwv/rKFECWt+3DHAI9esxj8UNfNDf5g0ci3WearW/+RHEVbyWHewGvnnTcSEIuZ1lknIkdPdq
 i6cESlQM=
X-Gm-Gg: AR+sD13GG9MyjhDwzDVy/jolp38ZxOdW9+iICZ08E2aFOgcHJAVhkQso2kxQEULpfOe
 RTv2MjQQ3LHxox2ZFc3nLyj0FmeqP0gMtW24s3INbMa+e5wtsMiuXE4w6Sz8FwnGlSkvpz35vMy
 OC983jiI1SHO/LWksjL0vPCkKnFN3yktPDK6IhpfwnHWFYt+qJ4urU8BLGp+d2hIeM56mWmdXdM
 P8tTuETjFhFvEIDHioJTvjWt0s/2+Dg5S8e3h7KioB9TUJ1OcP+xqKYQa3oWntmdsgMLGB12g8W
 o8At1BjR412lr0VwbCQHRCamZaLwT33qWkb4Cq4uth+GOMObLBOgzXCMF6BLiIh0AWEmNePpnx7
 Iwbso0Aa+g/q2BbJKcHCZFHUH0+dlSnnwklGmaA2A9smiAj/NsBpaXzjmSW1pSgGlflkSDp1+hg
 PKGBdCzHtu0yTN552dZK8b10MLHEyGK/BU7vQ6qVE0Ea30FM7N5bBK1HK245Z1193hOS+E0rRdS
 aiVwYx8cf8FSB8KTGYwBWcCIH5Gp0qIwgs=
X-Received: by 2002:a05:6a00:1947:b0:842:2419:6c0b with SMTP id
 d2e1a72fcca58-84fde3cca20mr35550359b3a.10.1787072559829; 
 Tue, 18 Aug 2026 10:02:39 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 37/38] target/m68k: Enable disassembly via capstone
Date: Tue, 18 Aug 2026 10:01:54 -0700
Message-ID: <20260818170155.1907006-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
index ce2707dee5..6012dc3186 100644
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


