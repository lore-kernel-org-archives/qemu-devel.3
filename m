Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49883D232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56n-0004Zo-Np; Fri, 09 Jan 2026 00:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56j-0004MV-8y
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:21 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56g-0003il-FP
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:20 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34c30f0f12eso2312658a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936737; x=1768541537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vSEho0Y68LtAAtpg5jLEdlGVKtAu9LgbZNDJhk9B18=;
 b=Ey0zjtftMAbO/vpdEz2BluqULIB35gfhRLpEIspGbsGCbKXbyt+O0iRGUSqvBpmuDd
 +VZGd8IMTToWfUXRF+bm46UFvKqVTLTNkNXFTw4FT1ig51Q555Mt+UgSgkS7KnrS65aO
 6DzlNwsegl5O+B3ILhmqgV772qcKaDSfNgcBDq0KgL2nLgUljKBeBb26/zwEszEtk7DJ
 GFD9CbVgp5V5PV9Ku8WWhiHV+sH4pGuEWHkp1wh1cfMmdAcNzgF4Ai/ioI0e6LRWzqOq
 A7iEgVdLY/YwI/7e5uj5pTZ1+kSLtGyXp7V8RmV0LsPv+ZrJY354l0TS3Jz0xlOUBRyM
 sFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936737; x=1768541537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2vSEho0Y68LtAAtpg5jLEdlGVKtAu9LgbZNDJhk9B18=;
 b=mTMTrCCoFe4SeZi1iUSKBLUDqHojVPFB4cNzmu6Xjz9Rj77X2CI11NzlMIH73ejk77
 K4zxRICT6TjBp1GEyL/fmIQZVi+rJH9nCNjemRz5cY3kvlzDbnuzXI+A8Y1nazmFCwLU
 8HK2kXIrsCfY2U2pIUsuk7niDONK7J1FM3LWZmXLYroKDdB3lG3FhzMRVTGZTjrm7uKd
 XdtaSL4D00+aGxxwi0FRvv5w2CEYLnDz4msbkVYg5AEnQqFxdEBKSV12zXr8NL4tonNY
 g7t4dEUmh318UeGNKZMEMFHgdoTgYxtr2+EUo6fEuwTXp8Ps8nyFSVrSecfJME3wjBcM
 rAug==
X-Gm-Message-State: AOJu0YwgZqlOfrfcE2BPS5gs13tXp2qvzRIFEfg9CaGphRayXB79A44I
 gEe3ASxjF25ngcDE8ZedHyZcMk/V9PcU32oj1+ciElP48/L1NIDpj5dfQNKaNBgJBbE/e4KEWgX
 9ydZ7
X-Gm-Gg: AY/fxX504CvAiVkmGzHEa1DvCZg5KWjqu0UWWD4NNiwKXArjsmOdCROCScevIwBjI+o
 NEOUxIesSIzn1PE23gl7Orc7kkWMuYthx2st9MoS1tINpXYG2eppxvB8+aGNzLC1v6GxqjtSG8Z
 HqNLbsddZJhA4JYBlApmtnx+evacM+Ufrp5h6VHdcb+K5wQM2QMmLp08Qoz+1A1jQhbiBMWKq3f
 Y0VlETCdiIgdmV7yFUtg1xf9amPravymSaID8/wadOVfpFzv7IqvPSs2p6s2uYxeiHB9+DSKUmk
 +vQJ3zKiX4Rprl2TwSDlDf1SmG+rvpOgVuUktVQd1lhwIU96hfvBMA0y2NBXAs3Zx2Bb6BwWZH/
 4mPzBUmCfZwRzYY7UMEVDakKJnhyHwKwn20yD/jPej00oYCCjFZl7I60rekCK7DWTf4xvzfS3xp
 +IEQqah7cM5NMp72RZWKjsd4D3XjFw8XTjg0rAxKD0CCN1ft0LRqTQYLW6tfpd/ickjNLUh3v7g
 I8=
X-Google-Smtp-Source: AGHT+IEgrDgZwaT8HyDskX08D8CTY8KsglmPBP4zBXHGj7cQ8GgvIkjMLGLmv/dh7AOZEeTLxlFRGQ==
X-Received: by 2002:a17:90b:570c:b0:340:c60b:f362 with SMTP id
 98e67ed59e1d1-34f68b4e728mr8104767a91.6.1767936736960; 
 Thu, 08 Jan 2026 21:32:16 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 13/29] include/tcg/tcg-op.h: eradicate
 TARGET_INSN_START_EXTRA_WORDS
Date: Thu,  8 Jan 2026 21:31:42 -0800
Message-ID: <20260109053158.2800705-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

We simply define the 3 variants and call the correct one per arch.
Since all arch have a single call site (in translate.c), this is as
good documentation as having a single define.

The notable exception is target/arm, which has two different translate
files for 32/64 bits. Since it's the only one, we accept to have two
call sites for this.

This is much simpler and safer than trying to define a common functions
with variadic or unused parameters. The only risk is calling two
different variants for a single arch, but as mentioned in first
paragraph, there is no real reason for this to happen.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/tcg/tcg-op.h             | 16 ++++++----------
 target/alpha/cpu-param.h         |  2 --
 target/arm/cpu-param.h           |  7 -------
 target/avr/cpu-param.h           |  2 --
 target/hexagon/cpu-param.h       |  2 --
 target/hppa/cpu-param.h          |  2 --
 target/i386/cpu-param.h          |  2 --
 target/loongarch/cpu-param.h     |  2 --
 target/m68k/cpu-param.h          |  2 --
 target/microblaze/cpu-param.h    |  2 --
 target/mips/cpu-param.h          |  2 --
 target/openrisc/cpu-param.h      |  2 --
 target/ppc/cpu-param.h           |  2 --
 target/riscv/cpu-param.h         |  7 -------
 target/rx/cpu-param.h            |  2 --
 target/s390x/cpu-param.h         |  2 --
 target/sh4/cpu-param.h           |  2 --
 target/sparc/cpu-param.h         |  2 --
 target/tricore/cpu-param.h       |  2 --
 target/xtensa/cpu-param.h        |  2 --
 target/alpha/translate.c         |  4 ++--
 target/arm/tcg/translate-a64.c   |  2 +-
 target/arm/tcg/translate.c       |  2 +-
 target/avr/translate.c           |  2 +-
 target/hexagon/translate.c       |  2 +-
 target/hppa/translate.c          |  2 +-
 target/i386/tcg/translate.c      |  2 +-
 target/loongarch/tcg/translate.c |  2 +-
 target/m68k/translate.c          |  2 +-
 target/microblaze/translate.c    |  2 +-
 target/mips/tcg/translate.c      |  4 ++--
 target/openrisc/translate.c      |  4 ++--
 target/ppc/translate.c           |  2 +-
 target/riscv/translate.c         |  2 +-
 target/rx/translate.c            |  2 +-
 target/s390x/tcg/translate.c     |  2 +-
 target/sh4/translate.c           |  4 ++--
 target/sparc/translate.c         |  2 +-
 target/tricore/translate.c       |  2 +-
 target/xtensa/translate.c        |  2 +-
 40 files changed, 30 insertions(+), 82 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index f3fe2d9386a..bf76749d1c5 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -28,8 +28,7 @@
 # error Mismatch with insn-start-words.h
 #endif
 
-#if TARGET_INSN_START_EXTRA_WORDS == 0
-static inline void tcg_gen_insn_start(uint64_t pc)
+static inline void tcg_gen_insn_start0(uint64_t pc)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
                             INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
@@ -37,8 +36,8 @@ static inline void tcg_gen_insn_start(uint64_t pc)
     tcg_set_insn_start_param(op, 1, 0);
     tcg_set_insn_start_param(op, 2, 0);
 }
-#elif TARGET_INSN_START_EXTRA_WORDS == 1
-static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
+
+static inline void tcg_gen_insn_start1(uint64_t pc, uint64_t a1)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
                             INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
@@ -46,9 +45,9 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
     tcg_set_insn_start_param(op, 1, a1);
     tcg_set_insn_start_param(op, 2, 0);
 }
-#elif TARGET_INSN_START_EXTRA_WORDS == 2
-static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1,
-                                      uint64_t a2)
+
+static inline void tcg_gen_insn_start2(uint64_t pc, uint64_t a1,
+                                       uint64_t a2)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
                             INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
@@ -56,9 +55,6 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1,
     tcg_set_insn_start_param(op, 1, a1);
     tcg_set_insn_start_param(op, 2, a2);
 }
-#else
-#error Unhandled TARGET_INSN_START_EXTRA_WORDS value
-#endif
 
 #if TARGET_LONG_BITS == 32
 typedef TCGv_i32 TCGv;
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index a799f42db31..c9da620ab3e 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -24,6 +24,4 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
 #endif
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 8b46c7c5708..7de0099cbfa 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -32,11 +32,4 @@
 # define TARGET_PAGE_BITS_LEGACY 10
 #endif /* !CONFIG_USER_ONLY */
 
-/*
- * ARM-specific extra insn start words:
- * 1: Conditional execution bits
- * 2: Partial exception syndrome for data aborts
- */
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 #endif
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index f74bfc25804..ea7887919a7 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -25,6 +25,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 635d509e743..45ee7b46409 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -23,6 +23,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 9bf7ac76d0c..e0b2c7c9157 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -19,6 +19,4 @@
 
 #define TARGET_PAGE_BITS 12
 
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 #endif
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index ebb844bcc83..909bc027923 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -22,6 +22,4 @@
 #endif
 #define TARGET_PAGE_BITS 12
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 #endif
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 58cc45a377e..071567712b3 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -13,6 +13,4 @@
 
 #define TARGET_PAGE_BITS 12
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 256a2b5f8b2..7afbf6d302d 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -17,6 +17,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 #endif
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index e0a37945136..6a0714bb3d7 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -27,6 +27,4 @@
 /* FIXME: MB uses variable pages down to 1K but linux only uses 4k.  */
 #define TARGET_PAGE_BITS 12
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 #endif
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 58f450827f7..a71e7383d24 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -20,6 +20,4 @@
 #endif
 #define TARGET_PAGE_BITS 12
 
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 #endif
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index b4f57bbe692..3011bf5fcca 100644
--- a/target/openrisc/cpu-param.h
+++ b/target/openrisc/cpu-param.h
@@ -12,6 +12,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index e4ed9080ee9..ca7602d8983 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -37,6 +37,4 @@
 # define TARGET_PAGE_BITS 12
 #endif
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index cfdc67c258c..039e877891a 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -17,13 +17,6 @@
 #endif
 #define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
 
-/*
- * RISC-V-specific extra insn start words:
- * 1: Original instruction opcode
- * 2: more information about instruction
- */
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 /*
  * The current MMU Modes are:
  *  - U mode 0b000
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index 84934f3bcaf..ef1970a09e9 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -24,6 +24,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index abfae3bedfb..a5f798eeae7 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -12,6 +12,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
 
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index f328715ee86..2b6e11dd0ac 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -16,6 +16,4 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 #endif
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 45eea9d6bac..6e8e2a51469 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -21,6 +21,4 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index eb33a67c419..790242ef3d2 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -12,6 +12,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index 7a0c22c9005..06d85218b84 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -16,6 +16,4 @@
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index b1d8a4eb80a..75808795e52 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2895,9 +2895,9 @@ static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     if (ctx->pcrel) {
-        tcg_gen_insn_start(dcbase->pc_next & ~TARGET_PAGE_MASK);
+        tcg_gen_insn_start0(dcbase->pc_next & ~TARGET_PAGE_MASK);
     } else {
-        tcg_gen_insn_start(dcbase->pc_next);
+        tcg_gen_insn_start0(dcbase->pc_next);
     }
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b066da37891..b7a8e94b937 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10764,7 +10764,7 @@ static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
     }
-    tcg_gen_insn_start(pc_arg, 0, 0);
+    tcg_gen_insn_start2(pc_arg, 0, 0);
     dc->insn_start_updated = false;
 }
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 79b111a228b..5c496f42c55 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6453,7 +6453,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     } else {
         condexec_bits = (dc->condexec_cond << 4) | (dc->condexec_mask >> 1);
     }
-    tcg_gen_insn_start(pc_arg, condexec_bits, 0);
+    tcg_gen_insn_start2(pc_arg, condexec_bits, 0);
     dc->insn_start_updated = false;
 }
 
diff --git a/target/avr/translate.c b/target/avr/translate.c
index ef6f655a458..29de249342e 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2689,7 +2689,7 @@ static void avr_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->npc);
+    tcg_gen_insn_start0(ctx->npc);
 }
 
 static void avr_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 3762faec4d8..c61ddc85b6f 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -977,7 +977,7 @@ static void hexagon_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next);
+    tcg_gen_insn_start0(ctx->base.pc_next);
 }
 
 static bool pkt_crosses_page(CPUHexagonState *env, DisasContext *ctx)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 853cba2ba4f..2a9eafacda7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4716,7 +4716,7 @@ static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
         tcg_debug_assert(diff != INT32_MIN);
     }
 
-    tcg_gen_insn_start(iaoq_f & ~TARGET_PAGE_MASK, diff, 0);
+    tcg_gen_insn_start2(iaoq_f & ~TARGET_PAGE_MASK, diff, 0);
     ctx->insn_start_updated = false;
 }
 
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7c444d5006d..207cd541152 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3527,7 +3527,7 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
     }
-    tcg_gen_insn_start(pc_arg, dc->cc_op);
+    tcg_gen_insn_start1(pc_arg, dc->cc_op);
 }
 
 static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 055f6fb6046..120411eda1e 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -159,7 +159,7 @@ static void loongarch_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next);
+    tcg_gen_insn_start0(ctx->base.pc_next);
 }
 
 /*
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index eb1ba150745..2abcbae879b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6028,7 +6028,7 @@ static void m68k_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
 static void m68k_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
+    tcg_gen_insn_start1(dc->base.pc_next, dc->cc_op);
 }
 
 static void m68k_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index fefe5cb552a..3407cfbdb1d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1630,7 +1630,7 @@ static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
 
-    tcg_gen_insn_start(dc->base.pc_next, dc->tb_flags & ~MSR_TB_MASK);
+    tcg_gen_insn_start1(dc->base.pc_next, dc->tb_flags & ~MSR_TB_MASK);
 }
 
 static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 54849e9ff1a..3000e09e241 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15133,8 +15133,8 @@ static void mips_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next, ctx->hflags & MIPS_HFLAG_BMASK,
-                       ctx->btarget);
+    tcg_gen_insn_start2(ctx->base.pc_next, ctx->hflags & MIPS_HFLAG_BMASK,
+                        ctx->btarget);
 }
 
 static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 6fa4d6cfa70..7c2d6979bc6 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1551,8 +1551,8 @@ static void openrisc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(dc->base.pc_next, (dc->delayed_branch ? 1 : 0)
-                       | (dc->base.num_insns > 1 ? 2 : 0));
+    tcg_gen_insn_start1(dc->base.pc_next, (dc->delayed_branch ? 1 : 0)
+                        | (dc->base.num_insns > 1 ? 2 : 0));
 }
 
 static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 17e6d07c8c2..9eca4043daa 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6574,7 +6574,7 @@ static void ppc_tr_tb_start(DisasContextBase *db, CPUState *cs)
 
 static void ppc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
-    tcg_gen_insn_start(dcbase->pc_next);
+    tcg_gen_insn_start0(dcbase->pc_next);
 }
 
 static bool is_prefix_insn(DisasContext *ctx, uint32_t insn)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e1f4dc5ffd0..da3e6606871 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1351,7 +1351,7 @@ static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
         pc_next &= ~TARGET_PAGE_MASK;
     }
 
-    tcg_gen_insn_start(pc_next, 0, 0);
+    tcg_gen_insn_start2(pc_next, 0, 0);
     ctx->insn_start_updated = false;
 }
 
diff --git a/target/rx/translate.c b/target/rx/translate.c
index ef865f14bf5..1a4ed4de31b 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2215,7 +2215,7 @@ static void rx_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next);
+    tcg_gen_insn_start0(ctx->base.pc_next);
 }
 
 static void rx_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index e38607ee18c..111a5e2cb54 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6402,7 +6402,7 @@ static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     /* Delay the set of ilen until we've read the insn. */
-    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 0);
+    tcg_gen_insn_start2(dc->base.pc_next, dc->cc_op, 0);
 }
 
 static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index b3ae0a3814c..78f606f4a4f 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2181,7 +2181,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
      * tb->icount * insn_start.
      */
     for (i = 1; i < max_insns; ++i) {
-        tcg_gen_insn_start(pc + i * 2, ctx->envflags);
+        tcg_gen_insn_start1(pc + i * 2, ctx->envflags);
         ctx->base.insn_start = tcg_last_op();
     }
 }
@@ -2241,7 +2241,7 @@ static void sh4_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next, ctx->envflags);
+    tcg_gen_insn_start1(ctx->base.pc_next, ctx->envflags);
 }
 
 static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d6b599b71fe..bca9c7a0c1e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5735,7 +5735,7 @@ static void sparc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
             g_assert_not_reached();
         }
     }
-    tcg_gen_insn_start(dc->pc, npc);
+    tcg_gen_insn_start1(dc->pc, npc);
 }
 
 static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index fbe05a93a8a..cee7fedc9db 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8410,7 +8410,7 @@ static void tricore_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next);
+    tcg_gen_insn_start0(ctx->base.pc_next);
 }
 
 static bool insn_crosses_page(DisasContext *ctx, CPUTriCoreState *env)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index bb8d2ed86cf..7851a5f0371 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1159,7 +1159,7 @@ static void xtensa_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
 
 static void xtensa_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
-    tcg_gen_insn_start(dcbase->pc_next);
+    tcg_gen_insn_start0(dcbase->pc_next);
 }
 
 static void xtensa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.47.3


