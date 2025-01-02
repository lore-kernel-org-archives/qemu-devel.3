Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1388AE77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbf-00079e-Sj; Thu, 02 Jan 2025 13:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbL-00070J-OH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:19 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbH-00059W-0B
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:18 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2163dc5155fso155961435ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841232; x=1736446032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/5rxQ1giXHNMosbVBEUF3r89OsXO2G8VmGp554uBDRA=;
 b=F360BQe7493AN5CP4zOc9L2qRdNaftv+BjeZhBNhH7EUdtqW1GO0leXQxNtknQ9auF
 LzTyS4qprxXu6/qV0TCqqdHHwecXNRAnly/D5wZO1g3YxDFb+gm4k1uW3eUH3byX/2Kl
 rm+7LzCp383lUCqy5tMFheHNt1BGUqVFzU0kYHqivp6IcbMC8JtOBPLW60gpQe4J/Wss
 y2wR8Zs8G+zv6EAqE+3YN1b41qEJSyADVQYSs2NJeEPB9+OSqrvCraedyWM+VXzPaLYy
 SX9b5CRQIQFi1Tnf2PJWwfzZkb6YsKMXNUNSe69xzgIpuTbXO34h2IxyRJix12hnJPmF
 aWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841232; x=1736446032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5rxQ1giXHNMosbVBEUF3r89OsXO2G8VmGp554uBDRA=;
 b=sJYTQ6JiodYBGwk0UwCuHOAO5SD3P5kW8nI5ET0hnGQjofyj2fPEHab94+JstAGtA+
 8lA7McX5n1WBC7ISsgFSbsW8Q7l1y/qhOX3wZ36IuziQK8zdaVkgEMXnz4fxpGCNos+z
 WYYl8V/39UoeHoQeUKoE+owF0DyFdFtupUgWm+C9mcXPREMqcRqGvMx77X4UVXrqVFjs
 WJzh2jCYDtnCxDsMIDsVCGRKw0n859iwUzX6aWfjfM72Sxs8lAiMVdkzB+hAQW5MFdgi
 B9A/4iY5ZcKrR6ZZAuWABnDAj3VlBWRpS9t2ExBxSSpV0Vibg/Ua22yvzpD6NRNBlwey
 7iJg==
X-Gm-Message-State: AOJu0YxwaIgQ7QQ4VwogR/9GLDRkJ9A+C8IY5WXcg++QrjO5lZ1yn7PD
 wWX40zXvGpzgs+L4IhQuHhN7hX9BVwvqjOm/DCUaHM5DMxZpZb7Bhhq55PkOIykbn2aPncSIvFG
 2
X-Gm-Gg: ASbGnctgIwiIPBlafiv1/lx8tSS4GrZF69zAncdSllZfUlg/9ce8qL37S84nDU4GBhd
 tP5nJP0pb71fJnztomACsxTj9Dh4/xz/8YZbgg1riEWoFa5MUSLAfwE2YtR7HRexYyt1W0ewLE2
 BU/YTr9fuAUVqALIdqG+8C1KIISeGjrP450ATpb+og5QQYPS7erWaxUV/lZmkWcupNn95tACwZr
 CQmztIlu4n2JZDg8nuV8GH/X4J/F+LOhQbHeiIeM0YA4I/1SXs3q9HrY6fn0w==
X-Google-Smtp-Source: AGHT+IERaJH8DkfvAmM4op3vdOe+zPFfVpa2/GuHC8n4Xh5WofvWbPJBasV5Stn70b82pR3pb7qZuA==
X-Received: by 2002:a05:6a21:7187:b0:1e5:f930:c6e8 with SMTP id
 adf61e73a8af0-1e5f930c7efmr52550025637.4.1735841231931; 
 Thu, 02 Jan 2025 10:07:11 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/73] tcg: Merge TCG_TARGET_HAS_{div,rem,div2}
Date: Thu,  2 Jan 2025 10:06:01 -0800
Message-ID: <20250102180654.1420056-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Pass a type parameter to the macros; this is unused with these opcodes,
but will be used with others, so keep it for uniformity.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  24 +++---
 tcg/aarch64/tcg-target-has.h     |   9 +-
 tcg/arm/tcg-target-has.h         |   7 +-
 tcg/i386/tcg-target-has.h        |   6 +-
 tcg/loongarch64/tcg-target-has.h |  11 +--
 tcg/mips/tcg-target-has.h        |   9 +-
 tcg/ppc/tcg-target-has.h         |   9 +-
 tcg/riscv/tcg-target-has.h       |  11 +--
 tcg/s390x/tcg-target-has.h       |   6 +-
 tcg/sparc64/tcg-target-has.h     |   9 +-
 tcg/tcg-has.h                    |  19 ++---
 tcg/tci/tcg-target-has.h         |   8 +-
 tcg/tcg-op.c                     | 136 ++++++++++++++++++-------------
 tcg/tcg.c                        |  12 +--
 14 files changed, 139 insertions(+), 137 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 14aff6e7f9..ac110efb74 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -61,12 +61,12 @@ DEF(st_i32, 0, 2, 1, 0)
 DEF(add_i32, 1, 2, 0, 0)
 DEF(sub_i32, 1, 2, 0, 0)
 DEF(mul_i32, 1, 2, 0, 0)
-DEF(div_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_div_i32))
-DEF(divu_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_div_i32))
-DEF(rem_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rem_i32))
-DEF(remu_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rem_i32))
-DEF(div2_i32, 2, 3, 0, IMPL(TCG_TARGET_HAS_div2_i32))
-DEF(divu2_i32, 2, 3, 0, IMPL(TCG_TARGET_HAS_div2_i32))
+DEF(div_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_div(TCG_TYPE_I32)))
+DEF(divu_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_div(TCG_TYPE_I32)))
+DEF(rem_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rem(TCG_TYPE_I32)))
+DEF(remu_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rem(TCG_TYPE_I32)))
+DEF(div2_i32, 2, 3, 0, IMPL(TCG_TARGET_HAS_div2(TCG_TYPE_I32)))
+DEF(divu2_i32, 2, 3, 0, IMPL(TCG_TARGET_HAS_div2(TCG_TYPE_I32)))
 DEF(and_i32, 1, 2, 0, 0)
 DEF(or_i32, 1, 2, 0, 0)
 DEF(xor_i32, 1, 2, 0, 0)
@@ -130,12 +130,12 @@ DEF(st_i64, 0, 2, 1, IMPL64)
 DEF(add_i64, 1, 2, 0, IMPL64)
 DEF(sub_i64, 1, 2, 0, IMPL64)
 DEF(mul_i64, 1, 2, 0, IMPL64)
-DEF(div_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div_i64))
-DEF(divu_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div_i64))
-DEF(rem_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rem_i64))
-DEF(remu_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rem_i64))
-DEF(div2_i64, 2, 3, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div2_i64))
-DEF(divu2_i64, 2, 3, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div2_i64))
+DEF(div_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div(TCG_TYPE_I64)))
+DEF(divu_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div(TCG_TYPE_I64)))
+DEF(rem_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rem(TCG_TYPE_I64)))
+DEF(remu_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rem(TCG_TYPE_I64)))
+DEF(div2_i64, 2, 3, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div2(TCG_TYPE_I64)))
+DEF(divu2_i64, 2, 3, 0, IMPL64 | IMPL(TCG_TARGET_HAS_div2(TCG_TYPE_I64)))
 DEF(and_i64, 1, 2, 0, IMPL64)
 DEF(or_i64, 1, 2, 0, IMPL64)
 DEF(xor_i64, 1, 2, 0, IMPL64)
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 0e79e01266..856cb4020b 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -12,9 +12,10 @@
 #define have_lse    (cpuinfo & CPUINFO_LSE)
 #define have_lse2   (cpuinfo & CPUINFO_LSE2)
 
-/* optional instructions */
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          1
+/* optional integer instructions */
+#define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_rem(T)           1
+
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
@@ -45,8 +46,6 @@
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 316185500d..392fc6d704 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -23,7 +23,10 @@ extern bool use_idiv_instructions;
 extern bool use_neon_instructions;
 #endif
 
-/* optional instructions */
+/* optional integer instructions */
+#define TCG_TARGET_HAS_div(T)           use_idiv_instructions
+#define TCG_TARGET_HAS_rem(T)           0
+
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        0 /* and r0, r1, #0xff */
@@ -49,8 +52,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_div_i32          use_idiv_instructions
-#define TCG_TARGET_HAS_rem_i32          0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 3ea2eab807..f60ffbe984 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -25,8 +25,9 @@
 #define have_avx512dq     ((cpuinfo & CPUINFO_AVX512DQ) && have_avx512vl)
 #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
-/* optional instructions */
-#define TCG_TARGET_HAS_div2_i32         1
+/* optional integer instructions */
+#define TCG_TARGET_HAS_div2(T)          1
+
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
@@ -58,7 +59,6 @@
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_div2_i64         1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index e4333c36c6..5eedfc1926 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -9,11 +9,11 @@
 
 #include "host/cpuinfo.h"
 
-/* optional instructions */
+/* optional integer instructions */
+#define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_rem(T)           1
+
 #define TCG_TARGET_HAS_negsetcond_i32   0
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_div2_i32         0
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
@@ -46,9 +46,6 @@
 
 /* 64-bit operations */
 #define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 5dbc63cef6..37a68dace8 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -38,9 +38,10 @@ extern bool use_mips32r2_instructions;
 #define use_mips32r6_instructions  0
 #endif
 
-/* optional instructions */
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          1
+/* optional integer instructions */
+#define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_rem(T)           1
+
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_andc_i32         0
@@ -58,8 +59,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_andc_i64         0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index a6c7cdba5d..6734fd63e7 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -16,13 +16,14 @@
 #define have_altivec   (cpuinfo & CPUINFO_ALTIVEC)
 #define have_vsx       (cpuinfo & CPUINFO_VSX)
 
+/* optional integer instructions */
+#define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_rem(T)           1
+
 /* optional instructions automatically implemented */
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
 #define TCG_TARGET_HAS_ext16u_i32       0
 
-/* optional instructions */
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          have_isa_3_00
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
@@ -52,8 +53,6 @@
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          have_isa_3_00
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index ddc759a533..309673d74a 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -9,11 +9,11 @@
 
 #include "host/cpuinfo.h"
 
-/* optional instructions */
+/* optional integer instructions */
+#define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_rem(T)           1
+
 #define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_div2_i32         0
 #define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_deposit_i32      0
 #define TCG_TARGET_HAS_extract_i32      0
@@ -45,9 +45,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract_i64      0
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 4992d74f12..3473b39991 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -28,8 +28,9 @@ extern uint64_t s390_facilities[3];
 #define HAVE_FACILITY(X) \
     ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
 
-/* optional instructions */
-#define TCG_TARGET_HAS_div2_i32       1
+/* optional integer instructions */
+#define TCG_TARGET_HAS_div2(T)        1
+
 #define TCG_TARGET_HAS_rot_i32        1
 #define TCG_TARGET_HAS_ext8s_i32      1
 #define TCG_TARGET_HAS_ext16s_i32     1
@@ -60,7 +61,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
-#define TCG_TARGET_HAS_div2_i64       1
 #define TCG_TARGET_HAS_rot_i64        1
 #define TCG_TARGET_HAS_ext8s_i64      1
 #define TCG_TARGET_HAS_ext16s_i64     1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index d9ca14cc3d..17db925241 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -13,9 +13,10 @@
 extern bool use_vis3_instructions;
 #endif
 
-/* optional instructions */
-#define TCG_TARGET_HAS_div_i32		1
-#define TCG_TARGET_HAS_rem_i32		0
+/* optional integer instructions */
+#define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_rem(T)           0
+
 #define TCG_TARGET_HAS_rot_i32          0
 #define TCG_TARGET_HAS_ext8s_i32        0
 #define TCG_TARGET_HAS_ext16s_i32       0
@@ -46,8 +47,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          0
 #define TCG_TARGET_HAS_rot_i64          0
 #define TCG_TARGET_HAS_ext8s_i64        0
 #define TCG_TARGET_HAS_ext16s_i64       0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 65b6a0b0cf..649168b001 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -12,9 +12,6 @@
 #if TCG_TARGET_REG_BITS == 32
 /* Turn some undef macros into false macros.  */
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_div_i64          0
-#define TCG_TARGET_HAS_rem_i64          0
-#define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          0
 #define TCG_TARGET_HAS_ext8s_i64        0
 #define TCG_TARGET_HAS_ext16s_i64       0
@@ -64,17 +61,11 @@
 #endif
 
 /* Only one of DIV or DIV2 should be defined.  */
-#if defined(TCG_TARGET_HAS_div_i32)
-#define TCG_TARGET_HAS_div2_i32         0
-#elif defined(TCG_TARGET_HAS_div2_i32)
-#define TCG_TARGET_HAS_div_i32          0
-#define TCG_TARGET_HAS_rem_i32          0
-#endif
-#if defined(TCG_TARGET_HAS_div_i64)
-#define TCG_TARGET_HAS_div2_i64         0
-#elif defined(TCG_TARGET_HAS_div2_i64)
-#define TCG_TARGET_HAS_div_i64          0
-#define TCG_TARGET_HAS_rem_i64          0
+#if defined(TCG_TARGET_HAS_div)
+#define TCG_TARGET_HAS_div2(T)          0
+#elif defined(TCG_TARGET_HAS_div2)
+#define TCG_TARGET_HAS_div(T)           0
+#define TCG_TARGET_HAS_rem(T)           0
 #endif
 
 #if !defined(TCG_TARGET_HAS_v64) \
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 3397403910..89f8288e4e 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -7,10 +7,12 @@
 #ifndef TCG_TARGET_HAS_H
 #define TCG_TARGET_HAS_H
 
+/* optional integer instructions */
+#define TCG_TARGET_HAS_div(T)           1
+#define TCG_TARGET_HAS_rem(T)           1
+
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
@@ -44,8 +46,6 @@
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c2d0558f60..a919682679 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -592,9 +592,9 @@ void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_div_i32) {
+    if (TCG_TARGET_HAS_div(TCG_TYPE_I32)) {
         tcg_gen_op3_i32(INDEX_op_div_i32, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div2_i32) {
+    } else if (TCG_TARGET_HAS_div2(TCG_TYPE_I32)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t0, arg1, 31);
         tcg_gen_op5_i32(INDEX_op_div2_i32, ret, t0, arg1, t0, arg2);
@@ -606,15 +606,15 @@ void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_rem_i32) {
+    if (TCG_TARGET_HAS_rem(TCG_TYPE_I32)) {
         tcg_gen_op3_i32(INDEX_op_rem_i32, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div_i32) {
+    } else if (TCG_TARGET_HAS_div(TCG_TYPE_I32)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_div_i32, t0, arg1, arg2);
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
-    } else if (TCG_TARGET_HAS_div2_i32) {
+    } else if (TCG_TARGET_HAS_div2(TCG_TYPE_I32)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t0, arg1, 31);
         tcg_gen_op5_i32(INDEX_op_div2_i32, t0, ret, arg1, t0, arg2);
@@ -626,9 +626,9 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_div_i32) {
+    if (TCG_TARGET_HAS_div(TCG_TYPE_I32)) {
         tcg_gen_op3_i32(INDEX_op_divu_i32, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div2_i32) {
+    } else if (TCG_TARGET_HAS_div2(TCG_TYPE_I32)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5_i32(INDEX_op_divu2_i32, ret, t0, arg1, zero, arg2);
@@ -640,15 +640,15 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_rem_i32) {
+    if (TCG_TARGET_HAS_rem(TCG_TYPE_I32)) {
         tcg_gen_op3_i32(INDEX_op_remu_i32, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div_i32) {
+    } else if (TCG_TARGET_HAS_div(TCG_TYPE_I32)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_divu_i32, t0, arg1, arg2);
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
-    } else if (TCG_TARGET_HAS_div2_i32) {
+    } else if (TCG_TARGET_HAS_div2(TCG_TYPE_I32)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5_i32(INDEX_op_divu2_i32, t0, ret, arg1, zero, arg2);
@@ -2047,70 +2047,90 @@ void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_div_i64) {
-        tcg_gen_op3_i64(INDEX_op_div_i64, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div2_i64) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_div2_i64, ret, t0, arg1, t0, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        gen_helper_div_i64(ret, arg1, arg2);
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (TCG_TARGET_HAS_div(TCG_TYPE_I64)) {
+            tcg_gen_op3_i64(INDEX_op_div_i64, ret, arg1, arg2);
+            return;
+        }
+        if (TCG_TARGET_HAS_div2(TCG_TYPE_I64)) {
+            TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+            tcg_gen_sari_i64(t0, arg1, 63);
+            tcg_gen_op5_i64(INDEX_op_div2_i64, ret, t0, arg1, t0, arg2);
+            tcg_temp_free_i64(t0);
+            return;
+        }
     }
+    gen_helper_div_i64(ret, arg1, arg2);
 }
 
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_rem_i64) {
-        tcg_gen_op3_i64(INDEX_op_rem_i64, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div_i64) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_div_i64, t0, arg1, arg2);
-        tcg_gen_mul_i64(t0, t0, arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else if (TCG_TARGET_HAS_div2_i64) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_div2_i64, t0, ret, arg1, t0, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        gen_helper_rem_i64(ret, arg1, arg2);
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (TCG_TARGET_HAS_rem(TCG_TYPE_I64)) {
+            tcg_gen_op3_i64(INDEX_op_rem_i64, ret, arg1, arg2);
+            return;
+        }
+        if (TCG_TARGET_HAS_div(TCG_TYPE_I64)) {
+            TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+            tcg_gen_op3_i64(INDEX_op_div_i64, t0, arg1, arg2);
+            tcg_gen_mul_i64(t0, t0, arg2);
+            tcg_gen_sub_i64(ret, arg1, t0);
+            tcg_temp_free_i64(t0);
+            return;
+        }
+        if (TCG_TARGET_HAS_div2(TCG_TYPE_I64)) {
+            TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+            tcg_gen_sari_i64(t0, arg1, 63);
+            tcg_gen_op5_i64(INDEX_op_div2_i64, t0, ret, arg1, t0, arg2);
+            tcg_temp_free_i64(t0);
+            return;
+        }
     }
+    gen_helper_rem_i64(ret, arg1, arg2);
 }
 
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_div_i64) {
-        tcg_gen_op3_i64(INDEX_op_divu_i64, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div2_i64) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2_i64, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        gen_helper_divu_i64(ret, arg1, arg2);
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (TCG_TARGET_HAS_div(TCG_TYPE_I64)) {
+            tcg_gen_op3_i64(INDEX_op_divu_i64, ret, arg1, arg2);
+            return;
+        }
+        if (TCG_TARGET_HAS_div2(TCG_TYPE_I64)) {
+            TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+            TCGv_i64 zero = tcg_constant_i64(0);
+            tcg_gen_op5_i64(INDEX_op_divu2_i64, ret, t0, arg1, zero, arg2);
+            tcg_temp_free_i64(t0);
+            return;
+        }
     }
+    gen_helper_divu_i64(ret, arg1, arg2);
 }
 
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_rem_i64) {
-        tcg_gen_op3_i64(INDEX_op_remu_i64, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div_i64) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divu_i64, t0, arg1, arg2);
-        tcg_gen_mul_i64(t0, t0, arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else if (TCG_TARGET_HAS_div2_i64) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2_i64, t0, ret, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        gen_helper_remu_i64(ret, arg1, arg2);
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (TCG_TARGET_HAS_rem(TCG_TYPE_I64)) {
+            tcg_gen_op3_i64(INDEX_op_remu_i64, ret, arg1, arg2);
+            return;
+        }
+        if (TCG_TARGET_HAS_div(TCG_TYPE_I64)) {
+            TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+            tcg_gen_op3_i64(INDEX_op_divu_i64, t0, arg1, arg2);
+            tcg_gen_mul_i64(t0, t0, arg2);
+            tcg_gen_sub_i64(ret, arg1, t0);
+            tcg_temp_free_i64(t0);
+            return;
+        }
+        if (TCG_TARGET_HAS_div2(TCG_TYPE_I64)) {
+            TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+            TCGv_i64 zero = tcg_constant_i64(0);
+            tcg_gen_op5_i64(INDEX_op_divu2_i64, t0, ret, arg1, zero, arg2);
+            tcg_temp_free_i64(t0);
+            return;
+        }
     }
+    gen_helper_remu_i64(ret, arg1, arg2);
 }
 
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index bd6922a141..e98920d377 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2212,13 +2212,13 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return TCG_TARGET_HAS_negsetcond_i32;
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
-        return TCG_TARGET_HAS_div_i32;
+        return TCG_TARGET_HAS_div(TCG_TYPE_I32);
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-        return TCG_TARGET_HAS_rem_i32;
+        return TCG_TARGET_HAS_rem(TCG_TYPE_I32);
     case INDEX_op_div2_i32:
     case INDEX_op_divu2_i32:
-        return TCG_TARGET_HAS_div2_i32;
+        return TCG_TARGET_HAS_div2(TCG_TYPE_I32);
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
         return TCG_TARGET_HAS_rot_i32;
@@ -2310,13 +2310,13 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return TCG_TARGET_HAS_negsetcond_i64;
     case INDEX_op_div_i64:
     case INDEX_op_divu_i64:
-        return TCG_TARGET_HAS_div_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_div(TCG_TYPE_I64);
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
-        return TCG_TARGET_HAS_rem_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_rem(TCG_TYPE_I64);
     case INDEX_op_div2_i64:
     case INDEX_op_divu2_i64:
-        return TCG_TARGET_HAS_div2_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_div2(TCG_TYPE_I64);
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
         return TCG_TARGET_HAS_rot_i64;
-- 
2.43.0


