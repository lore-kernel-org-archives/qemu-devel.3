Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF139C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwND3-0007nL-LA; Tue, 18 Aug 2026 13:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwND1-0007mU-VB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:43 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwND0-0004uu-A5
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:43 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so7959a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072561; x=1787677361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oeddzaUhKMxufvZlehk99Q+yzXw/oIr+pmQ26YJiCqw=;
 b=QEsS7/trR0Rs//ljTA0RUsf0yU9b5toGZKcrVAOLzKAMOdRC98myVFtG4z8dtoLazv
 jc8jD6svw15GzomEnrcKZjhAf5xihaocH4YsKFTdbODGIRceXH2Lnai4+G5NwTsEX4kB
 Pcvlm+6NBJifACFe8nX+ocynSxSe3rz2/MiVJqT9tm63e91eeqEEbcE89VFhygg5N/4S
 IJSd4EbPg4QROs4/H1estVS/35jkVxtCJHlCAg0HYjq+vF5kANWcmysjiI0MQaovTnI1
 iJfCpA3YiR9uOCh2x7dGzzy2f3cw50e53ZCjN1Iq8tELk3bWr7a1JvM2tRRmLZ1LRLnS
 ehgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072561; x=1787677361;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oeddzaUhKMxufvZlehk99Q+yzXw/oIr+pmQ26YJiCqw=;
 b=BrnOjoBxsjeXkr67Aomi77ZrLRBiiid/NTV4X/AjnOiPo1KmV4F5twJXssP0W1miUO
 5PnKJRTzTOIym788u0Wa803zE1zMNChFZ229rc8pQU6rICGFlzDZ1d8lWXbKFWZxO5W+
 DSieTaGENLyYMhsRPVNhPsHTHRpJcPtTFhixes6RahIdsyWD6p8gIxd0X2zPevLe0Oru
 5Iljjgc07Wc0acC/+7tnfbgSj9S5EFnAutgRVhi6vBDiywysK3YhGwY22ghrEfVm7S7W
 e9M3FROTGQVgfiZs8+qZJT3zpBidiuHDvGbieii2n4dgHTp37F2PNpBYRABqye9Nto7J
 trsQ==
X-Gm-Message-State: AOJu0YyO2I6JAXvfX2yWoLI2X08jC+Fp6r2Oxb/UffcxgQ+FVg5wnb1r
 ZD/nsy4REQwJxugnnenkXMpoXohWb6y1rJI+Oisq0ZHmSqwlcSlBjmbpSbniTdJn0H7o/tPYvvi
 wMZJnalI=
X-Gm-Gg: AR+sD114+qKzTvF6L7VTEC+w1vp7VBNJV1HGqkU9xbbC9o0nsZuPPNGm/NoSICbsJg7
 Nue3veE/JJPQOo7TZump/HdxXGOYD0xM9x3HxtjVDjBmZRhSpWj+T05nl9pQOlgorefstw6IOPh
 eZiQf6qP9bRgKgB9DGoE7h05vE7L+y7jEK6eWiCzz+DlFQS3yXzt/0o+P/qZRn+aI/0K9KZo+qZ
 I5Id71GUEeyd0Zp2sYoIBGKfYWH2toU6UySu5NLhi/Cg9gFMHEeK63lMW+xCE6QNKU6+b6DBrED
 WPt2oBOE8O7zp8mXuv12R1hsaekc4lqhJGd4JpgPOXoHLJXeQJQn/tVMydF64RrVLBiGND71tF8
 dEgv79Yf4juyALO9K0Dlk8KF91WTk4YqTQd83OG2Ov4xmO3f2FRHeU/yOg9+72X8U9z52uDx9x1
 cp/oGzFZ+PN6POREv8JsEvEY3jACX30ubJkAQ6uM3ZMXVhNQ4LcMOO/fiv0JRGUuFYxwNf0CcoY
 vEIdaBopLkRbgW6y16z3PLOsQsQ4Aet2w0=
X-Received: by 2002:a05:6a00:2c97:b0:848:62ab:7b7 with SMTP id
 d2e1a72fcca58-84fde1af5b9mr39625468b3a.16.1787072560730; 
 Tue, 18 Aug 2026 10:02:40 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 38/38] target/mips: Enable disassembly via capstone
Date: Tue, 18 Aug 2026 10:01:55 -0700
Message-ID: <20260818170155.1907006-39-richard.henderson@linaro.org>
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
 include/disas/capstone.h | 24 ++++++++++++++--
 target/mips/cpu.c        | 60 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index 3d6f90d816..e72faf8179 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -29,6 +29,7 @@
 #define CS_MODE_THUMB            0
 #define CS_MODE_MCLASS           0
 #define CS_MODE_V8               0
+#define CS_MODE_V9               0
 #define CS_MODE_M68K_000         0
 #define CS_MODE_M68K_010         0
 #define CS_MODE_M68K_020         0
@@ -36,11 +37,10 @@
 #define CS_MODE_M68K_040         0
 #define CS_MODE_M68K_060         0
 #define CS_MODE_MICRO            0
+#define CS_MODE_MIPS2            0
 #define CS_MODE_MIPS3            0
-#define CS_MODE_MIPS32R6         0
-#define CS_MODE_MIPSGP64         0
-#define CS_MODE_V9               0
 #define CS_MODE_MIPS32           0
+#define CS_MODE_MIPS32R6         0
 #define CS_MODE_MIPS64           0
 
 #endif /* CONFIG_CAPSTONE */
@@ -64,6 +64,24 @@
 #define CS_MODE_M68K_CF_FPU      0
 #endif
 
+#if CS_API_MAJOR < 6
+#define CS_MODE_MIPS16           0
+#define CS_MODE_MIPS1            0
+#define CS_MODE_MIPS32R2         0
+#define CS_MODE_MIPS32R3         0
+#define CS_MODE_MIPS32R5         0
+#define CS_MODE_MIPS4            0
+#define CS_MODE_MIPS5            0
+#define CS_MODE_MIPS64R2         0
+#define CS_MODE_MIPS64R3         0
+#define CS_MODE_MIPS64R5         0
+#define CS_MODE_MIPS64R6         0
+#define CS_MODE_OCTEON           0
+#define CS_MODE_OCTEONP          0
+#define CS_MODE_NANOMIPS         0
+#define CS_MODE_MIPS_PTR64       0
+#endif
+
 #if CS_API_MAJOR < 5
 #define CS_ARCH_RISCV           -1
 #define CS_MODE_RISCV32          0
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 669c7d99bb..0fead20d65 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -30,6 +30,7 @@
 #include "system/qtest.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
+#include "disas/capstone.h"
 #include "fpu_helper.h"
 #ifndef CONFIG_USER_ONLY
 #include "semihosting/semihost.h"
@@ -488,15 +489,66 @@ static void mips_cpu_disas_set_info(const CPUState *cs, disassemble_info *info)
 {
     const MIPSCPU *cpu = MIPS_CPU(cs);
     const CPUMIPSState *env = &cpu->env;
+    bool is64 = env->hflags & MIPS_HFLAG_64;
+    int cap_mode = 0;
 
-    if (!(env->insn_flags & ISA_NANOMIPS32)) {
+    if (env->insn_flags & ISA_NANOMIPS32) {
+        info->print_insn = print_insn_nanomips;
+        info->endian = BFD_ENDIAN_LITTLE;
+        /* nanomips has 16, 32 and 48-bit insns */
+        info->cap_insn_unit = 2;
+        info->cap_insn_split = 6;
+        cap_mode = CS_MODE_NANOMIPS;
+    } else {
         info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
                                          : BFD_ENDIAN_LITTLE;
         info->print_insn = TARGET_BIG_ENDIAN ? print_insn_big_mips
                                              : print_insn_little_mips;
-    } else {
-        info->print_insn = print_insn_nanomips;
-        info->endian = BFD_ENDIAN_LITTLE;
+
+        if (env->hflags & MIPS_HFLAG_M16) {
+            cap_mode = (env->insn_flags & ASE_MICROMIPS
+                        ? CS_MODE_MICRO : CS_MODE_MIPS16);
+            /* Beware unsupported capstone mode */
+            if (cap_mode == 0) {
+                return;
+            }
+            info->cap_insn_unit = 2;
+        } else {
+            info->cap_insn_unit = 4;
+        }
+        info->cap_insn_split = 4;
+
+        cap_mode |= is64 ? CS_MODE_MIPS64 : CS_MODE_MIPS32;
+        if (env->insn_flags & ISA_MIPS_R6) {
+            cap_mode |= is64 ? CS_MODE_MIPS64R6 : CS_MODE_MIPS32R6;
+        } else if (env->insn_flags & ISA_MIPS_R5) {
+            cap_mode |= is64 ? CS_MODE_MIPS64R5 : CS_MODE_MIPS32R5;
+        } else if (env->insn_flags & ISA_MIPS_R3) {
+            cap_mode |= is64 ? CS_MODE_MIPS64R3 : CS_MODE_MIPS32R3;
+        } else if (env->insn_flags & ISA_MIPS_R2) {
+            cap_mode |= is64 ? CS_MODE_MIPS64R2 : CS_MODE_MIPS32R2;
+        } else if (env->insn_flags & ISA_MIPS5) {
+            cap_mode |= CS_MODE_MIPS5;
+        } else if (env->insn_flags & ISA_MIPS4) {
+            cap_mode |= CS_MODE_MIPS4;
+        } else if (env->insn_flags & ISA_MIPS3) {
+            cap_mode |= CS_MODE_MIPS3;
+        } else if (env->insn_flags & ISA_MIPS2) {
+            cap_mode |= CS_MODE_MIPS2;
+        } else if (env->insn_flags & ISA_MIPS1) {
+            cap_mode |= CS_MODE_MIPS1;
+        }
+        if (env->insn_flags & INSN_OCTEON) {
+            cap_mode |= CS_MODE_OCTEON | CS_MODE_OCTEONP;
+        }
+        if (is64 && !(env->hflags & MIPS_HFLAG_AWRAP)) {
+            cap_mode |= CS_MODE_MIPS_PTR64;
+        }
+    }
+    /* Beware unsupported capstone mode */
+    if (cap_mode) {
+        info->cap_arch = CS_ARCH_MIPS;
+        info->cap_mode = cap_mode;
     }
 }
 
-- 
2.43.0


