Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1B3C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1n-0003ty-AW; Fri, 17 Jan 2025 13:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1k-0003tE-Up
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:04 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1i-0007dg-9K
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:04 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21644aca3a0so58940615ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138300; x=1737743100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GPj/dHv/OtqEUrzEcxJI0azKZQpu1Wxa2/jDsuCpfY=;
 b=oWabex41/VOF8Du7aS8F5zWsbjiirmJqos6u6nIp5XcHrQ9Ce7/Ii1ijiOY/nO4HBZ
 xEJ6V7Jm1rWYE/1hOOiEKnD3BwB7OCjBgUx3wAIS7UPoykK+FM2374Tb2fhbC5oUsmSn
 HoFM9B688fv6bT9nfv0epBGfHS5cM12fzdh1oUcftF+BXIZOQRFd8miJSP5K0pgH3jZ/
 pzbXrP22bO03PzX1a3XtgnwReJ1EbMItEVfeFBXaLG8QNtcdzWrPy9IRTHD51IbRk85r
 UwYK62zryYkBpdPursR+NDSmKle6NqzYklrlAD1KwxU2hIxUmpIN5rwfLqikq1BhKbie
 9Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138300; x=1737743100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3GPj/dHv/OtqEUrzEcxJI0azKZQpu1Wxa2/jDsuCpfY=;
 b=TB2Uh9VOUwLRwoVQcxtGq7pkgZsEyAx/y668D5uVGJUIh7gGCFiUacKLft/2GMeEOH
 kYHl37zZDrzhbR6pXLr8vd9zmgdYH7w+g4UJXCI4b4A27RyK+hkKpM2YZLZ0zxrGkvbo
 u+54YNx04W1Nt5+em5+1vdG8+1XvpDIWfj+qtIno5zvbZzyRZTltTja8pvunXqqtoVlq
 HEh8vRny7QdsmMBEU7tkAL0142OTHKhIHJpt6qy4J109IRY68TtiLX+UrHVr+mwuPd+c
 7ifkzwygJ4tAIiJxeGOaattsISpNw4/trvPp+d5JYkPxSpUZZpTEsw+7I3HDbaDGKcwi
 D5ZA==
X-Gm-Message-State: AOJu0YzDJq4hpk51nl8QBUkBw0WVZaR7/2Wftl4MJwut9XDnRY2nwI5N
 lnlPn26Eg9wDLqFjzdurHzLXfK8c8xVZXic9sNknWQiv3Tku8o4QYaxZdwUABhxLu+otz9JseLN
 S
X-Gm-Gg: ASbGncvFVy1InpcCpl+l6+zqh4PijMM/YJqAlyYQa9W6HcekXzAUlZW1RynTCm4ZMGQ
 OV3BZatPb1DFbZ0SckzYuf1jbozjnopaY80zQbCOlJLRr+R0Hc+PX0n+YI86xi+Ul2mardAfPPt
 Bqjg2b5DmzjBPqvYfcRZKetG3X5yC+mRY6OmStpYLlkAOmo4jiSjccw4PmzPQWQqIklPnnX+oaN
 Kh69/lAq4FAoDqch2EddO5MOLklaFdmd3XqXPNyLD0g2bvgCctz/KpsIvKNNfFEYeLUxwIlMjtJ
 KWkBST6QSDfUpUw=
X-Google-Smtp-Source: AGHT+IFtpkkYmG4YLvfh+sWqgXFGWFSlXJkRLSo9O5EreaNB2zIytjGgrpXC4xwH0vr+Djpjh5X0QQ==
X-Received: by 2002:a17:902:e802:b0:212:615f:c1 with SMTP id
 d9443c01a7336-21c3540a0admr66480735ad.14.1737138299662; 
 Fri, 17 Jan 2025 10:24:59 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:24:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/68] tcg: Move call abi parameters from tcg-target.h to
 tcg-target.c.inc
Date: Fri, 17 Jan 2025 10:23:50 -0800
Message-ID: <20250117182456.2077110-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

These defines are not required outside of tcg/tcg.c,
which includes tcg-target.c.inc before use.
Reduces the exported symbol set of tcg-target.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h         | 13 -------------
 tcg/arm/tcg-target.h             |  8 --------
 tcg/i386/tcg-target.h            | 20 --------------------
 tcg/loongarch64/tcg-target.h     |  9 ---------
 tcg/mips/tcg-target.h            | 14 --------------
 tcg/riscv/tcg-target.h           |  9 ---------
 tcg/s390x/tcg-target.h           |  8 --------
 tcg/sparc64/tcg-target.h         | 11 -----------
 tcg/tci/tcg-target.h             | 14 --------------
 tcg/aarch64/tcg-target.c.inc     | 13 +++++++++++++
 tcg/arm/tcg-target.c.inc         |  8 ++++++++
 tcg/i386/tcg-target.c.inc        | 20 ++++++++++++++++++++
 tcg/loongarch64/tcg-target.c.inc |  9 +++++++++
 tcg/mips/tcg-target.c.inc        | 14 ++++++++++++++
 tcg/riscv/tcg-target.c.inc       |  9 +++++++++
 tcg/s390x/tcg-target.c.inc       |  8 ++++++++
 tcg/sparc64/tcg-target.c.inc     | 10 ++++++++++
 tcg/tci/tcg-target.c.inc         | 14 ++++++++++++++
 18 files changed, 105 insertions(+), 106 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 8bd9e6a5eb..cb24c0d276 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -49,19 +49,6 @@ typedef enum {
 
 #define TCG_TARGET_NB_REGS 64
 
-/* used for function call generation */
-#define TCG_REG_CALL_STACK              TCG_REG_SP
-#define TCG_TARGET_STACK_ALIGN          16
-#define TCG_TARGET_CALL_STACK_OFFSET    0
-#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
-#ifdef CONFIG_DARWIN
-# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_NORMAL
-#else
-# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_EVEN
-#endif
-#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
-
 #define have_lse    (cpuinfo & CPUINFO_LSE)
 #define have_lse2   (cpuinfo & CPUINFO_LSE2)
 
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index fb7261499b..8abf15aef4 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -85,14 +85,6 @@ extern bool use_idiv_instructions;
 extern bool use_neon_instructions;
 #endif
 
-/* used for function call generation */
-#define TCG_TARGET_STACK_ALIGN		8
-#define TCG_TARGET_CALL_STACK_OFFSET	0
-#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_EVEN
-#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_EVEN
-#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_BY_REF
-
 /* optional instructions */
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index c68ac023d8..c81d509f1c 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -90,26 +90,6 @@ typedef enum {
     TCG_REG_CALL_STACK = TCG_REG_ESP
 } TCGReg;
 
-/* used for function call generation */
-#define TCG_TARGET_STACK_ALIGN 16
-#if defined(_WIN64)
-#define TCG_TARGET_CALL_STACK_OFFSET 32
-#else
-#define TCG_TARGET_CALL_STACK_OFFSET 0
-#endif
-#define TCG_TARGET_CALL_ARG_I32      TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_NORMAL
-#if defined(_WIN64)
-# define TCG_TARGET_CALL_ARG_I128    TCG_CALL_ARG_BY_REF
-# define TCG_TARGET_CALL_RET_I128    TCG_CALL_RET_BY_VEC
-#elif TCG_TARGET_REG_BITS == 64
-# define TCG_TARGET_CALL_ARG_I128    TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_RET_I128    TCG_CALL_RET_NORMAL
-#else
-# define TCG_TARGET_CALL_ARG_I128    TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_RET_I128    TCG_CALL_RET_BY_REF
-#endif
-
 #define have_bmi1         (cpuinfo & CPUINFO_BMI1)
 #define have_popcnt       (cpuinfo & CPUINFO_POPCNT)
 #define have_avx1         (cpuinfo & CPUINFO_AVX1)
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 58bd7d258e..7811530c8a 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -87,15 +87,6 @@ typedef enum {
     TCG_VEC_TMP0 = TCG_REG_V23,
 } TCGReg;
 
-/* used for function call generation */
-#define TCG_REG_CALL_STACK              TCG_REG_SP
-#define TCG_TARGET_STACK_ALIGN          16
-#define TCG_TARGET_CALL_STACK_OFFSET    0
-#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
-
 /* optional instructions */
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_div_i32          1
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index a996aa171d..d9b9f6a965 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -70,20 +70,6 @@ typedef enum {
     TCG_AREG0 = TCG_REG_S8,
 } TCGReg;
 
-/* used for function call generation */
-#define TCG_TARGET_STACK_ALIGN        16
-#if _MIPS_SIM == _ABIO32
-# define TCG_TARGET_CALL_STACK_OFFSET 16
-# define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_EVEN
-# define TCG_TARGET_CALL_RET_I128     TCG_CALL_RET_BY_REF
-#else
-# define TCG_TARGET_CALL_STACK_OFFSET 0
-# define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_RET_I128     TCG_CALL_RET_NORMAL
-#endif
-#define TCG_TARGET_CALL_ARG_I32       TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_ARG_I128      TCG_CALL_ARG_EVEN
-
 /* MOVN/MOVZ instructions detection */
 #if (defined(__mips_isa_rev) && (__mips_isa_rev >= 1)) || \
     defined(_MIPS_ARCH_LOONGSON2E) || defined(_MIPS_ARCH_LOONGSON2F) || \
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 334c37cbe6..d23306738a 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -59,15 +59,6 @@ typedef enum {
     TCG_REG_TMP2       = TCG_REG_T4,
 } TCGReg;
 
-/* used for function call generation */
-#define TCG_REG_CALL_STACK              TCG_REG_SP
-#define TCG_TARGET_STACK_ALIGN          16
-#define TCG_TARGET_CALL_STACK_OFFSET    0
-#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
-
 /* optional instructions */
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_div_i32          1
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 86aeca166f..7e0bf687b9 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -165,14 +165,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_cmpsel_vec     1
 #define TCG_TARGET_HAS_tst_vec        0
 
-/* used for function call generation */
-#define TCG_TARGET_STACK_ALIGN		8
-#define TCG_TARGET_CALL_STACK_OFFSET	160
-#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_EXTEND
-#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_BY_REF
-#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_BY_REF
-
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
 #define TCG_TARGET_NEED_LDST_LABELS
 #define TCG_TARGET_NEED_POOL_LABELS
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index a18906a14e..0705308951 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -64,17 +64,6 @@ typedef enum {
     TCG_REG_I7,
 } TCGReg;
 
-/* used for function call generation */
-#define TCG_REG_CALL_STACK TCG_REG_O6
-
-#define TCG_TARGET_STACK_BIAS           2047
-#define TCG_TARGET_STACK_ALIGN          16
-#define TCG_TARGET_CALL_STACK_OFFSET    (128 + 6*8 + TCG_TARGET_STACK_BIAS)
-#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_EXTEND
-#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
-
 #if defined(__VIS__) && __VIS__ >= 0x300
 #define use_vis3_instructions  1
 #else
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index a076f401d2..d7650343a3 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -146,20 +146,6 @@ typedef enum {
     TCG_REG_CALL_STACK = TCG_REG_R15,
 } TCGReg;
 
-/* Used for function call generation. */
-#define TCG_TARGET_CALL_STACK_OFFSET    0
-#define TCG_TARGET_STACK_ALIGN          8
-#if TCG_TARGET_REG_BITS == 32
-# define TCG_TARGET_CALL_ARG_I32        TCG_CALL_ARG_EVEN
-# define TCG_TARGET_CALL_ARG_I64        TCG_CALL_ARG_EVEN
-# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_EVEN
-#else
-# define TCG_TARGET_CALL_ARG_I32        TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_ARG_I64        TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_NORMAL
-#endif
-#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
-
 #define HAVE_TCG_QEMU_TB_EXEC
 #define TCG_TARGET_NEED_POOL_LABELS
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index ffa8a3e519..0b018d3247 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -14,6 +14,19 @@
 #include "../tcg-pool.c.inc"
 #include "qemu/bitops.h"
 
+/* Used for function call generation. */
+#define TCG_REG_CALL_STACK              TCG_REG_SP
+#define TCG_TARGET_STACK_ALIGN          16
+#define TCG_TARGET_CALL_STACK_OFFSET    0
+#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
+#ifdef CONFIG_DARWIN
+# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_NORMAL
+#else
+# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_EVEN
+#endif
+#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
+
 /* We're going to re-use TCGType in setting of the SF bit, which controls
    the size of the operation performed.  If we know the values match, it
    makes things much cleaner.  */
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 56072d89a2..f0674f23a5 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -35,6 +35,14 @@ bool use_idiv_instructions;
 bool use_neon_instructions;
 #endif
 
+/* Used for function call generation. */
+#define TCG_TARGET_STACK_ALIGN          8
+#define TCG_TARGET_CALL_STACK_OFFSET    0
+#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_EVEN
+#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_EVEN
+#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_BY_REF
+
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
     "%r0",  "%r1",  "%r2",  "%r3",  "%r4",  "%r5",  "%r6",  "%r7",
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 1bf50f1f62..aaf6107284 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -25,6 +25,26 @@
 #include "../tcg-ldst.c.inc"
 #include "../tcg-pool.c.inc"
 
+/* Used for function call generation. */
+#define TCG_TARGET_STACK_ALIGN 16
+#if defined(_WIN64)
+#define TCG_TARGET_CALL_STACK_OFFSET 32
+#else
+#define TCG_TARGET_CALL_STACK_OFFSET 0
+#endif
+#define TCG_TARGET_CALL_ARG_I32      TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_NORMAL
+#if defined(_WIN64)
+# define TCG_TARGET_CALL_ARG_I128    TCG_CALL_ARG_BY_REF
+# define TCG_TARGET_CALL_RET_I128    TCG_CALL_RET_BY_VEC
+#elif TCG_TARGET_REG_BITS == 64
+# define TCG_TARGET_CALL_ARG_I128    TCG_CALL_ARG_NORMAL
+# define TCG_TARGET_CALL_RET_I128    TCG_CALL_RET_NORMAL
+#else
+# define TCG_TARGET_CALL_ARG_I128    TCG_CALL_ARG_NORMAL
+# define TCG_TARGET_CALL_RET_I128    TCG_CALL_RET_BY_REF
+#endif
+
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #if TCG_TARGET_REG_BITS == 64
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 973601aec3..8ae561bfc0 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -32,6 +32,15 @@
 #include "../tcg-ldst.c.inc"
 #include <asm/hwcap.h>
 
+/* used for function call generation */
+#define TCG_REG_CALL_STACK              TCG_REG_SP
+#define TCG_TARGET_STACK_ALIGN          16
+#define TCG_TARGET_CALL_STACK_OFFSET    0
+#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
+
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
     "zero",
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 3b5b5c6d5b..ed41cd7f1b 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -27,6 +27,20 @@
 #include "../tcg-ldst.c.inc"
 #include "../tcg-pool.c.inc"
 
+/* used for function call generation */
+#define TCG_TARGET_STACK_ALIGN        16
+#if _MIPS_SIM == _ABIO32
+# define TCG_TARGET_CALL_STACK_OFFSET 16
+# define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_EVEN
+# define TCG_TARGET_CALL_RET_I128     TCG_CALL_RET_BY_REF
+#else
+# define TCG_TARGET_CALL_STACK_OFFSET 0
+# define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_NORMAL
+# define TCG_TARGET_CALL_RET_I128     TCG_CALL_RET_NORMAL
+#endif
+#define TCG_TARGET_CALL_ARG_I32       TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I128      TCG_CALL_ARG_EVEN
+
 #if TCG_TARGET_REG_BITS == 32
 # define LO_OFF  (HOST_BIG_ENDIAN * 4)
 # define HI_OFF  (4 - LO_OFF)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 96f9a7e348..34402fee2a 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -30,6 +30,15 @@
 #include "../tcg-ldst.c.inc"
 #include "../tcg-pool.c.inc"
 
+/* Used for function call generation. */
+#define TCG_REG_CALL_STACK              TCG_REG_SP
+#define TCG_TARGET_STACK_ALIGN          16
+#define TCG_TARGET_CALL_STACK_OFFSET    0
+#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
+
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
     "zero", "ra",  "sp",  "gp",  "tp",  "t0",  "t1",  "t2",
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 27bccc14e5..b1188525b2 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -28,6 +28,14 @@
 #include "../tcg-pool.c.inc"
 #include "elf.h"
 
+/* Used for function call generation. */
+#define TCG_TARGET_STACK_ALIGN          8
+#define TCG_TARGET_CALL_STACK_OFFSET    160
+#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_EXTEND
+#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_BY_REF
+#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_BY_REF
+
 #define TCG_CT_CONST_S16        (1 << 8)
 #define TCG_CT_CONST_S32        (1 << 9)
 #define TCG_CT_CONST_U32        (1 << 10)
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 32f9ec24b5..c9d105c35a 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -30,6 +30,16 @@
 #include "../tcg-ldst.c.inc"
 #include "../tcg-pool.c.inc"
 
+/* Used for function call generation. */
+#define TCG_REG_CALL_STACK              TCG_REG_O6
+#define TCG_TARGET_STACK_BIAS           2047
+#define TCG_TARGET_STACK_ALIGN          16
+#define TCG_TARGET_CALL_STACK_OFFSET    (128 + 6 * 8 + TCG_TARGET_STACK_BIAS)
+#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_EXTEND
+#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
+
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
     "%g0",
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index c740864b96..e6c97e8153 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -24,6 +24,20 @@
 
 #include "../tcg-pool.c.inc"
 
+/* Used for function call generation. */
+#define TCG_TARGET_CALL_STACK_OFFSET    0
+#define TCG_TARGET_STACK_ALIGN          8
+#if TCG_TARGET_REG_BITS == 32
+# define TCG_TARGET_CALL_ARG_I32        TCG_CALL_ARG_EVEN
+# define TCG_TARGET_CALL_ARG_I64        TCG_CALL_ARG_EVEN
+# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_EVEN
+#else
+# define TCG_TARGET_CALL_ARG_I32        TCG_CALL_ARG_NORMAL
+# define TCG_TARGET_CALL_ARG_I64        TCG_CALL_ARG_NORMAL
+# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_NORMAL
+#endif
+#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
+
 static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 {
     switch (op) {
-- 
2.43.0


