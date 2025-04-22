Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BE8C369D8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSw-0005dp-EO; Tue, 22 Apr 2025 15:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSN-0004Ke-KF
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:39:02 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSI-0007Mz-8r
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:58 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-225df540edcso2926905ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350732; x=1745955532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYHQtuGiuymmjGUHHCn+9yiZGa5qUf/qG4Dwvjes2M8=;
 b=mWmWGYmtTKYJrPuHG4TDrt21tsiCcaVUk6yYAB9lmSlt0lWB9rtAhj7UyxwfpDufQQ
 /DWeHEUGS5T4U2sgEX5jDnBEBYgMyMV3jKTP6SWQ5jMpVHYp/OzE/J8CFRQUUp6jZSUZ
 4eOzio1uXRt+nKeuFvCyW+iy1k4jBQHAIqqJvrTPXq4FVM2eqmLVGR6h0AEnH9J2ji4r
 O/OUWM/1UqNZIENFp4Y+xDBainvNcztEn/IenhhSCcE2AoZwf1XVE2Um/bbNKNSq0qx9
 oUc1751UghCSWeMQxf2Y4sEt7lStqiOvKm1N8FWLBkoOJhurps8+OI4qiQQon9262UnP
 8+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350732; x=1745955532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYHQtuGiuymmjGUHHCn+9yiZGa5qUf/qG4Dwvjes2M8=;
 b=MR5Yk4AqcEEVQBnbsPW05J+nuNK2GIbiZAt8dacRBjQKdnHa19d4DJKRkUFl0qK/WM
 M5nf/Xfzu63P6vvgxZY8iYQjnTJvvk1nCtYQrWhnUM/PGQ7q0m02bwmzbOfWOOnhxJq7
 h5bL7axs5mBu9cF+hgp2VDr+17GHymxjbnzys6xt9FwmD42KbvpjXlPMVk+hYy55Pynj
 GsHifVIS9J8lLKmaghEibwTUsErHlPwjMdm/60UrnYc34Nfl/jdZIPeb68cuNX/loKIX
 Sb05p+OkFgImBNYaMNyLEMgfF/41U/HNIBUGUuhmaLbFYr1abR9+J64wZ2fdsmaRfSL6
 vAgA==
X-Gm-Message-State: AOJu0YxxNOlvLsdiscAGmxuBp4OBA0/E1C9uSo9mIAXrqlp6SaoxQZ9v
 YqtBVJnFoLHyYURvgfLW6uDNYUjRzfIQ4Ft7XPw4XTrTWSS/Gtq+Pup3WUnLdRYVylSaMV49Iu5
 y
X-Gm-Gg: ASbGncsHsoZZXp3LNMDVvtswMVGOrj5ur7fJ3DTP/0TcKQF55pPRG4YiIXoyKBkJKGh
 2dP7Kg1I5NljLWd9cReyxjbc/z/1Yu5PN7/4UhtwFfxgADCuBso5l6X0RcuBeE4j8rpRCH42uLW
 Ti0vjtuRoh89+gMxifN0sGMAlBYY8eqIxSyff0+dIQ3mn/gXuWhyxFtcAXeuWKXnUsbS2JNIDFu
 ibU36pA5JgJsaAEgxFHaT2mYyNvP1f9CYhCLaI8zCn+QqYfmJey2bL+J73KAvVF//cZBCS6nE+w
 dfrpC/aKyqmMfcgzN3OvX1VicnRIqwzNN2/yoATOV/DFbOmMLgCCgS3v3BImA3LiD6Ew0a1n3H4
 =
X-Google-Smtp-Source: AGHT+IGcQLtbxyx2uOMoqKIoGGIuTmfPcp67/Mr5G0QviRRI/ceiPa2EG9v4wGc5Qh9TOhGbbJT1pg==
X-Received: by 2002:a17:902:ce8c:b0:221:8568:c00f with SMTP id
 d9443c01a7336-22da303cf77mr3954985ad.0.1745350732238; 
 Tue, 22 Apr 2025 12:38:52 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 138/147] tcg: Remove the TCG_GUEST_DEFAULT_MO definition
 globally
Date: Tue, 22 Apr 2025 12:28:07 -0700
Message-ID: <20250422192819.302784-139-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

By directly using TCGCPUOps::guest_default_memory_order,
we don't need the TCG_GUEST_DEFAULT_MO definition anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu-param.h        |  3 ---
 target/arm/cpu-param.h          |  3 ---
 target/avr/cpu-param.h          |  2 --
 target/hexagon/cpu-param.h      |  3 ---
 target/hppa/cpu-param.h         |  8 --------
 target/i386/cpu-param.h         |  3 ---
 target/loongarch/cpu-param.h    |  2 --
 target/m68k/cpu-param.h         |  3 ---
 target/microblaze/cpu-param.h   |  3 ---
 target/mips/cpu-param.h         |  2 --
 target/openrisc/cpu-param.h     |  2 --
 target/ppc/cpu-param.h          |  2 --
 target/riscv/cpu-param.h        |  2 --
 target/rx/cpu-param.h           |  3 ---
 target/s390x/cpu-param.h        |  6 ------
 target/sh4/cpu-param.h          |  3 ---
 target/sparc/cpu-param.h        | 23 -----------------------
 target/tricore/cpu-param.h      |  3 ---
 target/xtensa/cpu-param.h       |  3 ---
 target/alpha/cpu.c              |  3 ++-
 target/arm/cpu.c                |  3 ++-
 target/arm/tcg/cpu-v7m.c        |  3 ++-
 target/avr/cpu.c                |  2 +-
 target/hexagon/cpu.c            |  3 ++-
 target/hppa/cpu.c               |  8 +++++++-
 target/i386/tcg/tcg-cpu.c       |  5 ++++-
 target/loongarch/cpu.c          |  2 +-
 target/m68k/cpu.c               |  3 ++-
 target/microblaze/cpu.c         |  3 ++-
 target/mips/cpu.c               |  2 +-
 target/openrisc/cpu.c           |  2 +-
 target/ppc/cpu_init.c           |  2 +-
 target/riscv/tcg/tcg-cpu.c      |  2 +-
 target/rx/cpu.c                 |  3 ++-
 target/s390x/cpu.c              |  6 +++++-
 target/sh4/cpu.c                |  3 ++-
 target/sparc/cpu.c              | 23 ++++++++++++++++++++++-
 target/tricore/cpu.c            |  3 ++-
 target/xtensa/cpu.c             |  3 ++-
 docs/devel/multi-thread-tcg.rst |  4 ++--
 40 files changed, 66 insertions(+), 101 deletions(-)

diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index dd44feb179..a799f42db3 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -26,7 +26,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* Alpha processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 2cee4be693..5c5bc8a009 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -44,7 +44,4 @@
  */
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
-/* ARM processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index 9d37848d97..f74bfc2580 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -27,6 +27,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 7cc63a01d4..635d509e74 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -25,7 +25,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 68ed84e84a..9bf7ac76d0 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -21,12 +21,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
-/* PA-RISC 1.x processors have a strong memory model.  */
-/*
- * ??? While we do not yet implement PA-RISC 2.0, those processors have
- * a weak memory model, but with TLB bits that force ordering on a per-page
- * basis.  It's probably easier to fall back to a strong memory model.
- */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index 0c8efce861..ebb844bcc8 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -24,7 +24,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* The x86 has a strong memory model with some store-after-load re-ordering */
-#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
 #endif
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index dbe414bb35..58cc45a377 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -15,6 +15,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 10a8d74bfa..256a2b5f8b 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -19,7 +19,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index 5d55e0e3c4..e0a3794513 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -29,7 +29,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* MicroBlaze is always in-order. */
-#define TCG_GUEST_DEFAULT_MO  TCG_MO_ALL
-
 #endif
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 99ca8d1684..58f450827f 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -22,6 +22,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index 7ea0ecb55a..b4f57bbe69 100644
--- a/target/openrisc/cpu-param.h
+++ b/target/openrisc/cpu-param.h
@@ -14,6 +14,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index d0651d2ac8..e4ed9080ee 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -39,6 +39,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index ff4ba81965..cfdc67c258 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -34,6 +34,4 @@
  *  - M mode HLV/HLVX/HSV 0b111
  */
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index fe39a77ca3..84934f3bca 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -26,7 +26,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index a8a4377f4f..abfae3bedf 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -14,10 +14,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
-/*
- * The z/Architecture has a strong memory model with some
- * store-after-load re-ordering.
- */
-#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index acdf239749..f328715ee8 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -18,7 +18,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 62d47b804b..45eea9d6ba 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -23,27 +23,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/*
- * From Oracle SPARC Architecture 2015:
- *
- *   Compatibility notes: The PSO memory model described in SPARC V8 and
- *   SPARC V9 compatibility architecture specifications was never implemented
- *   in a SPARC V9 implementation and is not included in the Oracle SPARC
- *   Architecture specification.
- *
- *   The RMO memory model described in the SPARC V9 specification was
- *   implemented in some non-Sun SPARC V9 implementations, but is not
- *   directly supported in Oracle SPARC Architecture 2015 implementations.
- *
- * Therefore always use TSO in QEMU.
- *
- * D.5 Specification of Partial Store Order (PSO)
- *   ... [loads] are followed by an implied MEMBAR #LoadLoad | #LoadStore.
- *
- * D.6 Specification of Total Store Order (TSO)
- *   ... PSO with the additional requirement that all [stores] are followed
- *   by an implied MEMBAR #StoreStore.
- */
-#define TCG_GUEST_DEFAULT_MO  (TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST)
-
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index 45fde756b6..eb33a67c41 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -14,7 +14,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index e7cb747aaa..7a0c22c900 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -18,7 +18,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* Xtensa processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 6f931117a2..eeaf3a81c1 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -235,7 +235,8 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps alpha_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* Alpha processors have a weak memory model */
+    .guest_default_memory_order = 0,
 
     .initialize = alpha_translate_init,
     .translate_code = alpha_translate_code,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3f20e258fd..3e9760b551 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2671,7 +2671,8 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
 
 #ifdef CONFIG_TCG
 static const TCGCPUOps arm_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* ARM processors have a weak memory model */
+    .guest_default_memory_order = 0,
 
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 4553fe9de0..89d4e4b4a2 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -232,7 +232,8 @@ static void cortex_m55_initfn(Object *obj)
 }
 
 static const TCGCPUOps arm_v7m_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* ARM processors have a weak memory model */
+    .guest_default_memory_order = 0,
 
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 67918684fa..8f79cf4c08 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -224,7 +224,7 @@ static const struct SysemuCPUOps avr_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps avr_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
     .initialize = avr_cpu_tcg_init,
     .translate_code = avr_cpu_translate_code,
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index b12e0dccd0..3d14e5cc6a 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -325,7 +325,8 @@ static void hexagon_cpu_init(Object *obj)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps hexagon_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
     .initialize = hexagon_translate_init,
     .translate_code = hexagon_translate_code,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index ac4560febe..dfbd933056 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -253,7 +253,13 @@ static const struct SysemuCPUOps hppa_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps hppa_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* PA-RISC 1.x processors have a strong memory model.  */
+    /*
+     * ??? While we do not yet implement PA-RISC 2.0, those processors have
+     * a weak memory model, but with TLB bits that force ordering on a per-page
+     * basis.  It's probably easier to fall back to a strong memory model.
+     */
+    .guest_default_memory_order = TCG_MO_ALL,
 
     .initialize = hppa_translate_init,
     .translate_code = hppa_translate_code,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 3e1b315340..d941df0956 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -125,7 +125,10 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps x86_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /*
+     * The x86 has a strong memory model with some store-after-load re-ordering
+     */
+    .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
     .initialize = tcg_x86_init,
     .translate_code = x86_translate_code,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ee74509a66..f5b8ef29ab 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -864,7 +864,7 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps loongarch_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
     .initialize = loongarch_translate_init,
     .translate_code = loongarch_translate_code,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index bfde9b8594..b2d8c8f1de 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -589,7 +589,8 @@ static const struct SysemuCPUOps m68k_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps m68k_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 
     .initialize = m68k_tcg_init,
     .translate_code = m68k_translate_code,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index e46863574c..4efba0dddb 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -427,7 +427,8 @@ static const struct SysemuCPUOps mb_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps mb_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MicroBlaze is always in-order. */
+    .guest_default_memory_order = TCG_MO_ALL,
 
     .initialize = mb_tcg_init,
     .translate_code = mb_translate_code,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 67a8550cc1..2ae7ba4407 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -551,7 +551,7 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
 }
 
 static const TCGCPUOps mips_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
     .initialize = mips_tcg_init,
     .translate_code = mips_translate_code,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index e62c698a40..87fe779042 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -243,7 +243,7 @@ static const struct SysemuCPUOps openrisc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps openrisc_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
     .initialize = openrisc_translate_init,
     .translate_code = openrisc_translate_code,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 1cf18e0dae..9ba775971a 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7479,7 +7479,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps ppc_tcg_ops = {
-  .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+  .guest_default_memory_order = 0,
   .initialize = ppc_translate_init,
   .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ded2d68ad7..50e81b2e52 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -140,7 +140,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
 }
 
 static const TCGCPUOps riscv_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
     .initialize = riscv_translate_init,
     .translate_code = riscv_translate_code,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index d7eac551fd..f073fe8fc9 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -204,7 +204,8 @@ static const struct SysemuCPUOps rx_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps rx_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 
     .initialize = rx_translate_init,
     .translate_code = rx_translate_code,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index f232d82fa3..1e101b5afe 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -345,7 +345,11 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 }
 
 static const TCGCPUOps s390_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /*
+     * The z/Architecture has a strong memory model with some
+     * store-after-load re-ordering.
+     */
+    .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
 
     .initialize = s390x_translate_init,
     .translate_code = s390x_translate_code,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 29f4be7ba9..7a05301c6f 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -262,7 +262,8 @@ static const struct SysemuCPUOps sh4_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps superh_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 
     .initialize = sh4_translate_init,
     .translate_code = sh4_translate_code,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ef04efcb18..56d9417ae3 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1001,7 +1001,28 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps sparc_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /*
+     * From Oracle SPARC Architecture 2015:
+     *
+     *   Compatibility notes: The PSO memory model described in SPARC V8 and
+     *   SPARC V9 compatibility architecture specifications was never
+     *   implemented in a SPARC V9 implementation and is not included in the
+     *   Oracle SPARC Architecture specification.
+     *
+     *   The RMO memory model described in the SPARC V9 specification was
+     *   implemented in some non-Sun SPARC V9 implementations, but is not
+     *   directly supported in Oracle SPARC Architecture 2015 implementations.
+     *
+     * Therefore always use TSO in QEMU.
+     *
+     * D.5 Specification of Partial Store Order (PSO)
+     *   ... [loads] are followed by an implied MEMBAR #LoadLoad | #LoadStore.
+     *
+     * D.6 Specification of Total Store Order (TSO)
+     *   ... PSO with the additional requirement that all [stores] are followed
+     *   by an implied MEMBAR #StoreStore.
+     */
+    .guest_default_memory_order = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST,
 
     .initialize = sparc_tcg_init,
     .translate_code = sparc_translate_code,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 3bf399335a..c68954b409 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -172,7 +172,8 @@ static const struct SysemuCPUOps tricore_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps tricore_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
     .initialize = tricore_tcg_init,
     .translate_code = tricore_translate_code,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 2347106495..2cbf4e3010 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -232,7 +232,8 @@ static const struct SysemuCPUOps xtensa_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps xtensa_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* Xtensa processors have a weak memory model */
+    .guest_default_memory_order = 0,
 
     .initialize = xtensa_translate_init,
     .translate_code = xtensa_translate_code,
diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index b0f473961d..14a2a9dc7b 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -28,8 +28,8 @@ vCPU Scheduling
 We introduce a new running mode where each vCPU will run on its own
 user-space thread. This is enabled by default for all FE/BE
 combinations where the host memory model is able to accommodate the
-guest (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO is zero) and the
-guest has had the required work done to support this safely
+guest (TCGCPUOps::guest_default_memory_order & ~TCG_TARGET_DEFAULT_MO is zero)
+and the guest has had the required work done to support this safely
 (TARGET_SUPPORTS_MTTCG).
 
 System emulation will fall back to the original round robin approach
-- 
2.43.0


