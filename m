Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B9AE77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbq-0007eK-Rp; Thu, 02 Jan 2025 13:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbP-00070v-7Q
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:26 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbK-0005Ae-60
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:21 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2166022c5caso139850415ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841237; x=1736446037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q3nAV3q09h0xlGJ7EiDcWqW40ibpyfcW35rWOgfARGc=;
 b=d52HLfay1BXsk8iiptANNJT9aK0CVPA8fzsh997Hfiu1lUFRFGcCDgckVv7gNfzq5z
 ifwj4iCUrsnBVTzpaNIlUetb/oCva0m23REfeNXRzR4Y1ebqOEfAEcNP55dR8S6bbevP
 f8wlc6/QKSMPBjiSm8qoSEUL6ZYStwW82oY/5BlPn0HbrNNRze1ZImrQpLQmKTHYH2O5
 QYDgQgU0GZMMg6373qjhlqxQ6nLolb5z08JVbduKYiKguWrFayJf/ChywxZxcIe/nmaU
 iKL8J/U8SlbsOCpiTFC0q6TP+9ls/9uEzYx0QkUQFx8l1h+vwKIwxPRvPxX275NqE53M
 b6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841237; x=1736446037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3nAV3q09h0xlGJ7EiDcWqW40ibpyfcW35rWOgfARGc=;
 b=lxKyWFOcaop/IEI9IzeSOSd04ryzLTMS3A29pXI1Cpf60xzW+yf/r72mxxpQl4QGNz
 8I0nm8EW5OGAMd02ZeJgmGFo12EOvSr1bMn2OeXEhOOHrnX+6E7EjYCyThtUDx2/Xa8J
 g1rcNBQitok7jsHSJs0PlRHQrQTg9ceGjBjTkqFVpJPeG7TGea4a0afdhtx7O9tgWAk3
 PvJHwDe22v2I2f4IidZ2VLXtZiLSoVDer+l5rubVa83NkS6yPJFojNSzra9OVZIki7zx
 tVhA/eE29jklzS023jPr+LvmgBpJegxvX75fjME15ZR+m3xm6ZNOjezkTLLnmyVvolYw
 o7tw==
X-Gm-Message-State: AOJu0YwechT92vkPl0Rb29tW8A8bSLCTFdbViM0PmFo7XWup2nL8D8AK
 njBFjUlk49nh0986uax4G9yyIm+6pj1yCPWHXoVAtzt6RH7j8urHGpaRpVh8NNzI+6WAI4WnEFA
 p
X-Gm-Gg: ASbGncuDkz1KcBY6E+iC1mfETRZPy4Hbnf/cD9TSSt4NhLjy+f3hHJQbfaLEuDCejFo
 PBuPhcuYRWpcrzTt4VtsQ8DIVH/TrBitn4OwO/nQ2iJ8z6RrRlGg06S4SaloAoRgme3PHcDdBwH
 rsFxWZXKgweIqTGbJpmnQzrh1wxt4ewGQsIgjHMdik42vmVaE7++Qqd6nfKNhLPQwD46mZDH3uY
 TDTcgwhTU/FvXTXAdKApOyARcYPLxnUdfexy+kbctZzPgYiLTBqnzDnD3lrWQ==
X-Google-Smtp-Source: AGHT+IFdollbEp1BDfNgGpmP2/Zs26f8dIdGhyAEHdgrgEXwAQ9kvJNKYyaZh+OhZDdtGKY5taIzOg==
X-Received: by 2002:a05:6a20:c88f:b0:1d5:10d6:92b9 with SMTP id
 adf61e73a8af0-1e5e07f88demr70402613637.30.1735841236627; 
 Thu, 02 Jan 2025 10:07:16 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/73] tcg: Merge TCG_TARGET_HAS_{muls2,mulu2,mulsh,muluh}
Date: Thu,  2 Jan 2025 10:06:07 -0800
Message-ID: <20250102180654.1420056-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  16 ++---
 tcg/aarch64/tcg-target-has.h     |  12 ++--
 tcg/arm/tcg-target-has.h         |   8 +--
 tcg/i386/tcg-target-has.h        |  12 ++--
 tcg/loongarch64/tcg-target-has.h |  12 ++--
 tcg/mips/tcg-target-has.h        |  12 ++--
 tcg/ppc/tcg-target-has.h         |  12 ++--
 tcg/riscv/tcg-target-has.h       |  12 ++--
 tcg/s390x/tcg-target-has.h       |  12 ++--
 tcg/sparc64/tcg-target-has.h     |  12 ++--
 tcg/tcg-has.h                    |   4 --
 tcg/tci/tcg-target-has.h         |  14 ++--
 tcg/tcg-op.c                     | 115 +++++++++++++++++--------------
 tcg/tcg.c                        |  24 +++----
 tcg/tci.c                        |   8 ---
 15 files changed, 125 insertions(+), 160 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 8d8fda39f8..fbd759764c 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -85,10 +85,10 @@ DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 
 DEF(add2_i32, 2, 4, 0, IMPL(TCG_TARGET_HAS_add2_i32))
 DEF(sub2_i32, 2, 4, 0, IMPL(TCG_TARGET_HAS_sub2_i32))
-DEF(mulu2_i32, 2, 2, 0, IMPL(TCG_TARGET_HAS_mulu2_i32))
-DEF(muls2_i32, 2, 2, 0, IMPL(TCG_TARGET_HAS_muls2_i32))
-DEF(muluh_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_muluh_i32))
-DEF(mulsh_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_mulsh_i32))
+DEF(mulu2_i32, 2, 2, 0, IMPL(TCG_TARGET_HAS_mulu2(TCG_TYPE_I32)))
+DEF(muls2_i32, 2, 2, 0, IMPL(TCG_TARGET_HAS_muls2(TCG_TYPE_I32)))
+DEF(muluh_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_muluh(TCG_TYPE_I32)))
+DEF(mulsh_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_mulsh(TCG_TYPE_I32)))
 DEF(brcond2_i32, 0, 4, 2,
     TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | IMPL(TCG_TARGET_REG_BITS == 32))
 DEF(setcond2_i32, 1, 4, 1, IMPL(TCG_TARGET_REG_BITS == 32))
@@ -183,10 +183,10 @@ DEF(ctpop_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctpop(TCG_TYPE_I64)))
 
 DEF(add2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_add2_i64))
 DEF(sub2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_sub2_i64))
-DEF(mulu2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulu2_i64))
-DEF(muls2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muls2_i64))
-DEF(muluh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muluh_i64))
-DEF(mulsh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulsh_i64))
+DEF(mulu2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulu2(TCG_TYPE_I64)))
+DEF(muls2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muls2(TCG_TYPE_I64)))
+DEF(muluh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muluh(TCG_TYPE_I64)))
+DEF(mulsh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulsh(TCG_TYPE_I64)))
 
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 247bf3e358..53182cca6a 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -18,6 +18,10 @@
 #define TCG_TARGET_HAS_ctpop(T)         0
 #define TCG_TARGET_HAS_ctz(T)           1
 #define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_muls2(T)         0
+#define TCG_TARGET_HAS_mulu2(T)         0
+#define TCG_TARGET_HAS_mulsh(T)         (T == TCG_TYPE_I64)
+#define TCG_TARGET_HAS_muluh(T)         (T == TCG_TYPE_I64)
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
 
@@ -40,10 +44,6 @@
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -60,10 +60,6 @@
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        1
 
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 29405706a4..1352d3c25a 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -29,6 +29,10 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_ctpop(T)         0
 #define TCG_TARGET_HAS_ctz(T)           use_armv7_instructions
 #define TCG_TARGET_HAS_div(T)           use_idiv_instructions
+#define TCG_TARGET_HAS_muls2(T)         1
+#define TCG_TARGET_HAS_mulu2(T)         1
+#define TCG_TARGET_HAS_mulsh(T)         0
+#define TCG_TARGET_HAS_muluh(T)         0
 #define TCG_TARGET_HAS_rem(T)           0
 #define TCG_TARGET_HAS_rot(T)           1
 
@@ -49,10 +53,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_mulu2_i32        1
-#define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index a60e13616c..fc6bd85ba2 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -31,6 +31,10 @@
 #define TCG_TARGET_HAS_ctpop(T)         have_popcnt
 #define TCG_TARGET_HAS_ctz(T)           1
 #define TCG_TARGET_HAS_div2(T)          1
+#define TCG_TARGET_HAS_muls2(T)         1
+#define TCG_TARGET_HAS_mulu2(T)         1
+#define TCG_TARGET_HAS_mulsh(T)         0
+#define TCG_TARGET_HAS_muluh(T)         0
 #define TCG_TARGET_HAS_rot(T)           1
 
 /* optional integer and vector instructions */
@@ -52,10 +56,6 @@
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_mulu2_i32        1
-#define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
 
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
@@ -73,10 +73,6 @@
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        1
-#define TCG_TARGET_HAS_muls2_i64        1
-#define TCG_TARGET_HAS_muluh_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index b634baec4f..932acac497 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -15,6 +15,10 @@
 #define TCG_TARGET_HAS_ctpop(T)         0
 #define TCG_TARGET_HAS_ctz(T)           1
 #define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_muls2(T)         0
+#define TCG_TARGET_HAS_mulu2(T)         0
+#define TCG_TARGET_HAS_mulsh(T)         1
+#define TCG_TARGET_HAS_muluh(T)         1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
 
@@ -33,10 +37,6 @@
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
-#define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        1
-#define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
@@ -60,10 +60,6 @@
 #define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
 
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 91ea0b56d5..f81218178e 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -44,6 +44,10 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_ctpop(T)         0
 #define TCG_TARGET_HAS_ctz(T)           0
 #define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_muls2(T)         (!use_mips32r6_instructions)
+#define TCG_TARGET_HAS_mulu2(T)         (!use_mips32r6_instructions)
+#define TCG_TARGET_HAS_mulsh(T)         1
+#define TCG_TARGET_HAS_muluh(T)         1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           use_mips32r2_instructions
 
@@ -55,10 +59,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           0
 
-#define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_muluh_i32        1
-#define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -67,10 +67,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
-#define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_muls2_i64        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_muluh_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        1
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_negsetcond_i64   0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index b593cd3308..60da23a66a 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -22,6 +22,10 @@
 #define TCG_TARGET_HAS_ctpop(T)         have_isa_2_06
 #define TCG_TARGET_HAS_ctz(T)           have_isa_3_00
 #define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_muls2(T)         0
+#define TCG_TARGET_HAS_mulu2(T)         0
+#define TCG_TARGET_HAS_mulsh(T)         1
+#define TCG_TARGET_HAS_muluh(T)         1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
 
@@ -44,10 +48,6 @@
 #define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        1
-#define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -67,10 +67,6 @@
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        1
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 81f81787c0..00eee4cafb 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -15,6 +15,10 @@
 #define TCG_TARGET_HAS_ctpop(T)         (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz(T)           (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_muls2(T)         0
+#define TCG_TARGET_HAS_mulu2(T)         0
+#define TCG_TARGET_HAS_mulsh(T)         (T == TCG_TYPE_I64)
+#define TCG_TARGET_HAS_muluh(T)         (T == TCG_TYPE_I64)
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           (cpuinfo & CPUINFO_ZBB)
 
@@ -33,10 +37,6 @@
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
@@ -59,10 +59,6 @@
 #define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index c954a4c03e..7c0d4708c9 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -34,6 +34,10 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ctpop(T)       1
 #define TCG_TARGET_HAS_ctz(T)         0
 #define TCG_TARGET_HAS_div2(T)        1
+#define TCG_TARGET_HAS_muls2(T)       (T == TCG_TYPE_I64 && HAVE_FACILITY(MISC_INSN_EXT2))
+#define TCG_TARGET_HAS_mulu2(T)       (T == TCG_TYPE_I64)
+#define TCG_TARGET_HAS_mulsh(T)       0
+#define TCG_TARGET_HAS_muluh(T)       0
 #define TCG_TARGET_HAS_rot(T)         1
 
 /* optional integer and vector instructions */
@@ -55,10 +59,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_negsetcond_i32 1
 #define TCG_TARGET_HAS_add2_i32       1
 #define TCG_TARGET_HAS_sub2_i32       1
-#define TCG_TARGET_HAS_mulu2_i32      0
-#define TCG_TARGET_HAS_muls2_i32      0
-#define TCG_TARGET_HAS_muluh_i32      0
-#define TCG_TARGET_HAS_mulsh_i32      0
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
@@ -75,10 +75,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_negsetcond_i64 1
 #define TCG_TARGET_HAS_add2_i64       1
 #define TCG_TARGET_HAS_sub2_i64       1
-#define TCG_TARGET_HAS_mulu2_i64      1
-#define TCG_TARGET_HAS_muls2_i64      HAVE_FACILITY(MISC_INSN_EXT2)
-#define TCG_TARGET_HAS_muluh_i64      0
-#define TCG_TARGET_HAS_mulsh_i64      0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index eaca708478..86b109fc6d 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -19,6 +19,10 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ctpop(T)         0
 #define TCG_TARGET_HAS_ctz(T)           0
 #define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_muls2(T)         (T == TCG_TYPE_I32)
+#define TCG_TARGET_HAS_mulu2(T)         (T == TCG_TYPE_I32)
+#define TCG_TARGET_HAS_mulsh(T)         0
+#define TCG_TARGET_HAS_muluh(T)         (T == TCG_TYPE_I64 && use_vis3_instructions)
 #define TCG_TARGET_HAS_rem(T)           0
 #define TCG_TARGET_HAS_rot(T)           0
 
@@ -41,10 +45,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_mulu2_i32        1
-#define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
@@ -61,10 +61,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        use_vis3_instructions
-#define TCG_TARGET_HAS_mulsh_i64        0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index b2f2cbf2ad..199facbe37 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -25,10 +25,6 @@
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        0
 /* Turn some undef macros into true macros.  */
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 957ed9e2b3..e0bf8b14bd 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -13,6 +13,10 @@
 #define TCG_TARGET_HAS_ctpop(T)         1
 #define TCG_TARGET_HAS_ctz(T)           1
 #define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_muls2(T)         1
+#define TCG_TARGET_HAS_mulu2(T)         1
+#define TCG_TARGET_HAS_mulsh(T)         0
+#define TCG_TARGET_HAS_muluh(T)         0
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
 
@@ -33,9 +37,6 @@
 #define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   0
-#define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -51,17 +52,10 @@
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_muls2_i64        1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        1
-#define TCG_TARGET_HAS_muluh_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        0
-#else
-#define TCG_TARGET_HAS_mulu2_i32        1
 #endif /* TCG_TARGET_REG_BITS == 64 */
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2fb4ce90dc..8786aa5903 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1191,9 +1191,9 @@ void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
 
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_mulu2_i32) {
+    if (TCG_TARGET_HAS_mulu2(TCG_TYPE_I32)) {
         tcg_gen_op4_i32(INDEX_op_mulu2_i32, rl, rh, arg1, arg2);
-    } else if (TCG_TARGET_HAS_muluh_i32) {
+    } else if (TCG_TARGET_HAS_muluh(TCG_TYPE_I32)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_mul_i32, t, arg1, arg2);
         tcg_gen_op3_i32(INDEX_op_muluh_i32, rh, arg1, arg2);
@@ -1215,9 +1215,9 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_muls2_i32) {
+    if (TCG_TARGET_HAS_muls2(TCG_TYPE_I32)) {
         tcg_gen_op4_i32(INDEX_op_muls2_i32, rl, rh, arg1, arg2);
-    } else if (TCG_TARGET_HAS_mulsh_i32) {
+    } else if (TCG_TARGET_HAS_mulsh(TCG_TYPE_I32)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_mul_i32, t, arg1, arg2);
         tcg_gen_op3_i32(INDEX_op_mulsh_i32, rh, arg1, arg2);
@@ -3099,58 +3099,73 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
 
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_mulu2_i64) {
-        tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
-    } else if (TCG_TARGET_HAS_muluh_i64) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_muluh_i64, rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t);
-        tcg_temp_free_i64(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_mul_i64(t0, arg1, arg2);
-        gen_helper_muluh_i64(rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
+    TCGv_i64 t;
+
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (TCG_TARGET_HAS_mulu2(TCG_TYPE_I64)) {
+            tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
+            return;
+        }
+        if (TCG_TARGET_HAS_muluh(TCG_TYPE_I64)) {
+            t = tcg_temp_ebb_new_i64();
+            tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
+            tcg_gen_op3_i64(INDEX_op_muluh_i64, rh, arg1, arg2);
+            tcg_gen_mov_i64(rl, t);
+            tcg_temp_free_i64(t);
+            return;
+        }
     }
+    t = tcg_temp_ebb_new_i64();
+    tcg_gen_mul_i64(t, arg1, arg2);
+    gen_helper_muluh_i64(rh, arg1, arg2);
+    tcg_gen_mov_i64(rl, t);
+    tcg_temp_free_i64(t);
 }
 
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_muls2_i64) {
-        tcg_gen_op4_i64(INDEX_op_muls2_i64, rl, rh, arg1, arg2);
-    } else if (TCG_TARGET_HAS_mulsh_i64) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_mulsh_i64, rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t);
-        tcg_temp_free_i64(t);
-    } else if (TCG_TARGET_HAS_mulu2_i64 || TCG_TARGET_HAS_muluh_i64) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t3 = tcg_temp_ebb_new_i64();
-        tcg_gen_mulu2_i64(t0, t1, arg1, arg2);
-        /* Adjust for negative inputs.  */
-        tcg_gen_sari_i64(t2, arg1, 63);
-        tcg_gen_sari_i64(t3, arg2, 63);
-        tcg_gen_and_i64(t2, t2, arg2);
-        tcg_gen_and_i64(t3, t3, arg1);
-        tcg_gen_sub_i64(rh, t1, t2);
-        tcg_gen_sub_i64(rh, rh, t3);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
-        tcg_temp_free_i64(t3);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_mul_i64(t0, arg1, arg2);
-        gen_helper_mulsh_i64(rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
+    TCGv_i64 t;
+
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (TCG_TARGET_HAS_muls2(TCG_TYPE_I64)) {
+            tcg_gen_op4_i64(INDEX_op_muls2_i64, rl, rh, arg1, arg2);
+            return;
+        }
+        if (TCG_TARGET_HAS_mulsh(TCG_TYPE_I64)) {
+            t = tcg_temp_ebb_new_i64();
+            tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
+            tcg_gen_op3_i64(INDEX_op_mulsh_i64, rh, arg1, arg2);
+            tcg_gen_mov_i64(rl, t);
+            tcg_temp_free_i64(t);
+            return;
+        }
+        if (TCG_TARGET_HAS_mulu2(TCG_TYPE_I64) ||
+            TCG_TARGET_HAS_muluh(TCG_TYPE_I64)) {
+            TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+            TCGv_i64 t1 = tcg_temp_ebb_new_i64();
+            TCGv_i64 t2 = tcg_temp_ebb_new_i64();
+            TCGv_i64 t3 = tcg_temp_ebb_new_i64();
+            tcg_gen_mulu2_i64(t0, t1, arg1, arg2);
+            /* Adjust for negative inputs.  */
+            tcg_gen_sari_i64(t2, arg1, 63);
+            tcg_gen_sari_i64(t3, arg2, 63);
+            tcg_gen_and_i64(t2, t2, arg2);
+            tcg_gen_and_i64(t3, t3, arg1);
+            tcg_gen_sub_i64(rh, t1, t2);
+            tcg_gen_sub_i64(rh, rh, t3);
+            tcg_gen_mov_i64(rl, t0);
+            tcg_temp_free_i64(t0);
+            tcg_temp_free_i64(t1);
+            tcg_temp_free_i64(t2);
+            tcg_temp_free_i64(t3);
+            return;
+        }
     }
+    t = tcg_temp_ebb_new_i64();
+    tcg_gen_mul_i64(t, arg1, arg2);
+    gen_helper_mulsh_i64(rh, arg1, arg2);
+    tcg_gen_mov_i64(rl, t);
+    tcg_temp_free_i64(t);
 }
 
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index de22bdab85..1befe0c4d7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2235,13 +2235,13 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_sub2_i32:
         return TCG_TARGET_HAS_sub2_i32;
     case INDEX_op_mulu2_i32:
-        return TCG_TARGET_HAS_mulu2_i32;
+        return TCG_TARGET_HAS_mulu2(TCG_TYPE_I32);
     case INDEX_op_muls2_i32:
-        return TCG_TARGET_HAS_muls2_i32;
+        return TCG_TARGET_HAS_muls2(TCG_TYPE_I32);
     case INDEX_op_muluh_i32:
-        return TCG_TARGET_HAS_muluh_i32;
+        return TCG_TARGET_HAS_muluh(TCG_TYPE_I32);
     case INDEX_op_mulsh_i32:
-        return TCG_TARGET_HAS_mulsh_i32;
+        return TCG_TARGET_HAS_mulsh(TCG_TYPE_I32);
     case INDEX_op_ext8s_i32:
         return TCG_TARGET_HAS_ext8s_i32;
     case INDEX_op_ext16s_i32:
@@ -2369,13 +2369,13 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_sub2_i64:
         return TCG_TARGET_HAS_sub2_i64;
     case INDEX_op_mulu2_i64:
-        return TCG_TARGET_HAS_mulu2_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_mulu2(TCG_TYPE_I64);
     case INDEX_op_muls2_i64:
-        return TCG_TARGET_HAS_muls2_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_muls2(TCG_TYPE_I64);
     case INDEX_op_muluh_i64:
-        return TCG_TARGET_HAS_muluh_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_muluh(TCG_TYPE_I64);
     case INDEX_op_mulsh_i64:
-        return TCG_TARGET_HAS_mulsh_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_mulsh(TCG_TYPE_I64);
 
     case INDEX_op_mov_vec:
     case INDEX_op_dup_vec:
@@ -4013,22 +4013,22 @@ liveness_pass_1(TCGContext *s)
         case INDEX_op_mulu2_i32:
             opc_new = INDEX_op_mul_i32;
             opc_new2 = INDEX_op_muluh_i32;
-            have_opc_new2 = TCG_TARGET_HAS_muluh_i32;
+            have_opc_new2 = TCG_TARGET_HAS_muluh(TCG_TYPE_I32);
             goto do_mul2;
         case INDEX_op_muls2_i32:
             opc_new = INDEX_op_mul_i32;
             opc_new2 = INDEX_op_mulsh_i32;
-            have_opc_new2 = TCG_TARGET_HAS_mulsh_i32;
+            have_opc_new2 = TCG_TARGET_HAS_mulsh(TCG_TYPE_I32);
             goto do_mul2;
         case INDEX_op_mulu2_i64:
             opc_new = INDEX_op_mul_i64;
             opc_new2 = INDEX_op_muluh_i64;
-            have_opc_new2 = TCG_TARGET_HAS_muluh_i64;
+            have_opc_new2 = TCG_TARGET_HAS_muluh(TCG_TYPE_I64);
             goto do_mul2;
         case INDEX_op_muls2_i64:
             opc_new = INDEX_op_mul_i64;
             opc_new2 = INDEX_op_mulsh_i64;
-            have_opc_new2 = TCG_TARGET_HAS_mulsh_i64;
+            have_opc_new2 = TCG_TARGET_HAS_mulsh(TCG_TYPE_I64);
             goto do_mul2;
         do_mul2:
             nb_iargs = 2;
diff --git a/tcg/tci.c b/tcg/tci.c
index eeea2a9094..e71bf82c41 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -673,20 +673,16 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_write_reg64(regs, r1, r0, T1 - T2);
             break;
 #endif
-#if TCG_TARGET_HAS_mulu2_i32
         case INDEX_op_mulu2_i32:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
             tmp64 = (uint64_t)(uint32_t)regs[r2] * (uint32_t)regs[r3];
             tci_write_reg64(regs, r1, r0, tmp64);
             break;
-#endif
-#if TCG_TARGET_HAS_muls2_i32
         case INDEX_op_muls2_i32:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
             tmp64 = (int64_t)(int32_t)regs[r2] * (int32_t)regs[r3];
             tci_write_reg64(regs, r1, r0, tmp64);
             break;
-#endif
 #if TCG_TARGET_HAS_ext8s_i32 || TCG_TARGET_HAS_ext8s_i64
         CASE_32_64(ext8s)
             tci_args_rr(insn, &r0, &r1);
@@ -774,18 +770,14 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ctpop64(regs[r1]);
             break;
-#if TCG_TARGET_HAS_mulu2_i64
         case INDEX_op_mulu2_i64:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
             mulu64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
             break;
-#endif
-#if TCG_TARGET_HAS_muls2_i64
         case INDEX_op_muls2_i64:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
             muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
             break;
-#endif
 #if TCG_TARGET_HAS_add2_i64
         case INDEX_op_add2_i64:
             tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-- 
2.43.0


