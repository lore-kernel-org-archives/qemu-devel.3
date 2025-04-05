Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957E6C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16A2-0000mL-Re; Sat, 05 Apr 2025 12:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16A0-0000l1-9c
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:20 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169x-0005HJ-1H
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:19 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso2268296f8f.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869653; x=1744474453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbeIlrtLd2jXBN6pnVLjy0Ez8TgEHAsNX4HbXOjA0NA=;
 b=TStlkklcur2WhzvrAm09KOSH3QGmtUmPiqXgbCcBBXIR88P15AQVnRcct4guuwMtwN
 uAJM0ZHmrfk50Nsho33iF7Wmw/Tnnociu41HoSTwH8qn+sKlj5yEyWpP4vjIf/wbcFUU
 NUGbq+XN9735QbSCx2divFjiML+ALxFMkTpyR6c9dQdTyzBkKMhJNEeBcEJmG7vJSuGz
 kpQU4tay2Sr2FT/P+uCHayQo4uWJS9tMjmgMeShX8/ssgu8Ld7BUsiOLUEfqxcx1B0mA
 sWu5ttmcITfwuertavBipbvA/7rWs+M1slCugX9CpOBcI+sOaibnyHbZVKf4v6l9z6UR
 6nIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869653; x=1744474453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbeIlrtLd2jXBN6pnVLjy0Ez8TgEHAsNX4HbXOjA0NA=;
 b=rF5qU9qBhT//jDdWISJpfOIucZ0fiafIDDCzUMmFnweXFr+KFnVpj9XDNVquQ2Z2FG
 s+sEU+jdNgAYte2usllBLmMPnq+U2TOVGttAm2dJsYMwjqudqAa92fGo+OgcH34+IBGF
 lY4Bi0J6QKegzuoqvLn6TK/7EdidnCiqu117PMNxBeD6yYhMj8a91s65C+2HsCIsMRVp
 Kmkm3ckNARVm5jYMnssgj4kCIzAEMcRw94vZjTThuLEwmCZBQPhQfBs6xwAREfLzfiOi
 rKlA7nR3xEdPl2Is+WkdLCkrLaIMvjI2jI4O2xrP0Q4y1ui0c63a/23eEUcw7UnAmAKx
 ospA==
X-Gm-Message-State: AOJu0Yz4REipN7ZZuhuviZ0x+PVwKSGfhUUa4LJKM7UpeyDZa0OftFFZ
 Y98OEGYcyB3uQin0wWqHL0PbuJ1Y5Sn/MVEZcmiI1rVn7/iripIAo+ey8gD4OXIy/H8jFFxdoe4
 N
X-Gm-Gg: ASbGncvfO9Efuou1xvTNNqyJqxwXXZ6JKg6pzNeLyZwE7fYXggiTR83mctypJmo9xUk
 o58S8pSAu1qoMwj/Crguj54eb5om0fkG2tgN253IsY/fNy0V8BFFtkBJ6ROarwHVTUoM1Is9f36
 BgbQJavf6SjimHMDLYuPzr2fCzPPkz+4D0YJ7uUverrR8zNSC1mgWiR9WRiEa7Dm+g5jAI7OEkV
 uHZ9UP9Y+fTu+Z1FtpceLU3QXDZFJa+xeZl9goDyGSvkWI/jQuOJ7EG/rt5L4QAuIbfqjankHsW
 bu1KZLIBGZdmcEHKrPcO76RquZzLReWebvsZ7BxHtH9BAPlttBS/kghmyGQbBDPRk78Yhqdih/U
 bfquDp4C5zmWWxvbuXRLowiCC
X-Google-Smtp-Source: AGHT+IHHjnnxoPodz2qZ5ct0NJEfF/gFBdfF5BgtE7F26QUsTeYyaTjFgCHvCf5dfUVKj2UJPaTTew==
X-Received: by 2002:a05:6000:40c9:b0:391:43cb:43e6 with SMTP id
 ffacd0b85a97d-39d6fd022a6mr2573819f8f.51.1743869653372; 
 Sat, 05 Apr 2025 09:14:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d938sm7329692f8f.65.2025.04.05.09.14.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:14:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v4 11/16] tcg: Remove the TCG_GUEST_DEFAULT_MO
 definition globally
Date: Sat,  5 Apr 2025 18:13:15 +0200
Message-ID: <20250405161320.76854-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

By directly using TCGCPUOps::guest_default_memory_order,
we don't need the TCG_GUEST_DEFAULT_MO definition anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/multi-thread-tcg.rst |  4 ++--
 include/exec/poison.h           |  1 -
 target/alpha/cpu-param.h        |  3 ---
 target/arm/cpu-param.h          |  3 ---
 target/avr/cpu-param.h          |  2 --
 target/hexagon/cpu-param.h      |  5 -----
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
 target/hexagon/cpu.c            |  5 ++++-
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
 41 files changed, 68 insertions(+), 104 deletions(-)

diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index b0f473961dd..14a2a9dc7b5 100644
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
diff --git a/include/exec/poison.h b/include/exec/poison.h
index a09e0c12631..0f336cdc618 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -37,7 +37,6 @@
 #pragma GCC poison TARGET_NAME
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_BIG_ENDIAN
-#pragma GCC poison TCG_GUEST_DEFAULT_MO
 #pragma GCC poison TARGET_HAS_PRECISE_SMC
 
 #pragma GCC poison TARGET_LONG_BITS
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index dd44feb1793..a799f42db31 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -26,7 +26,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* Alpha processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 2cee4be6938..5c5bc8a009e 100644
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
index 9d37848d97d..f74bfc25804 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -27,6 +27,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 22bffa78816..635d509e743 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -25,9 +25,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/*
- * Hexagon processors have a strong memory model.
- */
-#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL)
-
 #endif
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 68ed84e84af..9bf7ac76d0c 100644
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
index 0c8efce8619..ebb844bcc83 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -24,7 +24,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* The x86 has a strong memory model with some store-after-load re-ordering */
-#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
 #endif
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index dbe414bb35a..58cc45a377e 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -15,6 +15,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 10a8d74bfa9..256a2b5f8b2 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -19,7 +19,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index 5d55e0e3c4a..e0a37945136 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -29,7 +29,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* MicroBlaze is always in-order. */
-#define TCG_GUEST_DEFAULT_MO  TCG_MO_ALL
-
 #endif
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 99ca8d1684c..58f450827f7 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -22,6 +22,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index 7ea0ecb55a6..b4f57bbe692 100644
--- a/target/openrisc/cpu-param.h
+++ b/target/openrisc/cpu-param.h
@@ -14,6 +14,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index d0651d2ac89..e4ed9080ee9 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -39,6 +39,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index ff4ba81965a..cfdc67c258c 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -34,6 +34,4 @@
  *  - M mode HLV/HLVX/HSV 0b111
  */
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index fe39a77ca38..84934f3bcaf 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -26,7 +26,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index a8a4377f4ff..abfae3bedfb 100644
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
index acdf2397495..f328715ee86 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -18,7 +18,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 62d47b804bb..45eea9d6bac 100644
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
index 45fde756b6a..eb33a67c419 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -14,7 +14,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index e7cb747aaae..7a0c22c9005 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -18,7 +18,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* Xtensa processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 6f931117a25..eeaf3a81c1a 100644
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
index 3f20e258fd0..3e9760b5518 100644
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
index 4553fe9de07..89d4e4b4a2f 100644
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
index 67918684faf..8f79cf4c08b 100644
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
index b12e0dccd09..e54f10c2294 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -325,7 +325,10 @@ static void hexagon_cpu_init(Object *obj)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps hexagon_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /*
+     * Hexagon processors have a strong memory model.
+     */
+    .guest_default_memory_order = TCG_MO_ALL,
     .initialize = hexagon_translate_init,
     .translate_code = hexagon_translate_code,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index ac4560febea..dfbd9330565 100644
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
index e58084b12f6..5295fcea5c3 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -125,7 +125,10 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 #include "accel/tcg/cpu-ops.h"
 
 const TCGCPUOps x86_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /*
+     * The x86 has a strong memory model with some store-after-load re-ordering
+     */
+    .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
 
     .initialize = tcg_x86_init,
     .translate_code = x86_translate_code,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ee74509a664..f5b8ef29ab0 100644
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
index bfde9b85948..b2d8c8f1dea 100644
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
index e46863574c6..4efba0dddb2 100644
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
index 860ec398229..010773405a8 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -550,7 +550,7 @@ static const Property mips_cpu_properties[] = {
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
 static const TCGCPUOps mips_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
     .initialize = mips_tcg_init,
     .translate_code = mips_translate_code,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index e62c698a407..87fe779042c 100644
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
index 57565c9a2f2..8300fa5777e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7478,7 +7478,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps ppc_tcg_ops = {
-  .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+  .guest_default_memory_order = 0,
   .initialize = ppc_translate_init,
   .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 832a5172ee9..e146c76e6aa 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -140,7 +140,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
 }
 
 const TCGCPUOps riscv_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
     .initialize = riscv_translate_init,
     .translate_code = riscv_translate_code,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index d7eac551fd4..f073fe8fc98 100644
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
index f232d82fa34..1e101b5afeb 100644
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
index 29f4be7ba9c..7a05301c6ff 100644
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
index ef04efcb183..56d9417ae3f 100644
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
index 3bf399335ac..c68954b4096 100644
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
index 23471064957..2cbf4e30108 100644
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
-- 
2.47.1


