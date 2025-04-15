Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87062C369BD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lvs-00011T-Oc; Tue, 15 Apr 2025 15:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lv2-0000Bo-I0
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:26:09 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luq-00085c-20
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:26:00 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso7920929b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745150; x=1745349950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHAiESMW4JxfB9z+Oj0ZyER0x6GHaMGVyStGUMijdB0=;
 b=Zyc/0SNJuPe5TtBiGJhPWkyUdYW+qEfovLY6ZkIjW64+00Xg2dkaAaVpl5yADpfxFF
 +qq+DQzt5+kznXgzgVGVvBYJdDFQ5zBwj1jzd8DYrugo2ty8sTpklgEYC2HOsQOQMAOV
 NO335UMggsSPncDHhT/2AP8g8OfDhFPzU0EDE59zFPoKj3PL8F3/tjF4F9cNe9Mm4eVG
 B46kZpcB+Apk5MJRqeXEX5Mia924qFFr0HS9QlTmVNR1o7pf0zYfCcJYHUmAjxpDMQLp
 okKMJiuTZl0BOfD0y4DqFzhnW5f5y24UlDbd5BZb9mA94cBzmzg5U6PfXCrdqBI2eRLP
 fUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745150; x=1745349950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHAiESMW4JxfB9z+Oj0ZyER0x6GHaMGVyStGUMijdB0=;
 b=Zvizze6MkWCgEtfLVWw4njeLBMMghhKF05B0cm9l67cpTt/cEYdzvD/Tj5MxuHRZxV
 bzjWJX4mf0tz1Meo8bAbDFdxzreOfl1IDyYsqwfRxSwcANgOFvVlSchDKim99e7fzH6l
 zntjVSrdP8fVcCLLbnNENW1QG29/7uGJBeZ+6hXQtgBlwMRwaNRyoqEJq02V+7DAiKHO
 4Y2s+aSITRpI769hWxbaunK+/sEstZ9AiM27NUVfKYzUnuhEsbmLgIRC7canWpVwQ83e
 5bDV1ARQaL2b6c07ErF6CjYWhHBbt1vxQolPg4HAhF/SOPkEqMB7UycVi28xRqeTBNVB
 sc0w==
X-Gm-Message-State: AOJu0YwA8qcJ9G68ayM9teyYjNO72rOpKXNp4WA0XvX/eWkTS4giOaaf
 kyAONQkUow9NqL9A6fMPZFfGRldfdQz7ycCUggucVrPxOSFS66sgxCtsTxRELAwaG6JkdXjeNMl
 l
X-Gm-Gg: ASbGncsFJ/VAHh4rCyknrIwAjQJaLPwjvcpDWhx8UuIG0xdkyFp23GUkcqv+N/CZmY8
 axyWyBsVbG80zyoA0/+nAzzWg81Ii8c+tQldLvVdkmIUS8yfCOm8yFTnhsihXY3/3jdQklUefsr
 6glw5pBlXfa8BU7jH1NpoA0qjvvKdCfoIDlLKqLrYRvJYIMHiBoq01gRULBDOeySsz+9DrWrkA/
 NS84Bm3+FFsCJqKUipEdJNo4Y/Ak7XWNMpJEEYORJNZUb7lNwhbQps9nhByzIehvKssg7zu45WF
 ulVrw+EstH7/YiK2RFMX2YJy0GH+OwPqXaq8VkZqCi/2F2S4UScQvXECMT49PzF0bfZ2DLzUI4g
 =
X-Google-Smtp-Source: AGHT+IG3n29Ht6Ge2cfZQ8eVolinLeOTRvG1wnmNOcaX+1UQLOGC7dP4Il8nY6lAe0LMHCdekrHYxQ==
X-Received: by 2002:a05:6a00:b56:b0:730:9752:d02a with SMTP id
 d2e1a72fcca58-73c1f8dff26mr955082b3a.4.1744745149465; 
 Tue, 15 Apr 2025 12:25:49 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 037/163] tcg: Convert muluh to TCGOutOpBinary
Date: Tue, 15 Apr 2025 12:23:08 -0700
Message-ID: <20250415192515.232910-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Remove unreachable mul[su]h_i32 leftovers from commit aeb6326ec5e
("tcg/riscv: Require TCG_TARGET_REG_BITS == 64").

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h     |  2 --
 tcg/arm/tcg-target-has.h         |  1 -
 tcg/i386/tcg-target-has.h        |  2 --
 tcg/loongarch64/tcg-target-has.h |  2 --
 tcg/mips/tcg-target-has.h        |  2 --
 tcg/ppc/tcg-target-has.h         |  2 --
 tcg/riscv/tcg-target-has.h       |  2 --
 tcg/s390x/tcg-target-has.h       |  2 --
 tcg/sparc64/tcg-target-has.h     |  2 --
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  2 --
 tcg/tcg-op.c                     |  7 ++++---
 tcg/tcg.c                        | 16 ++++++---------
 tcg/aarch64/tcg-target.c.inc     | 21 ++++++++++++++++----
 tcg/arm/tcg-target.c.inc         |  4 ++++
 tcg/i386/tcg-target.c.inc        |  4 ++++
 tcg/loongarch64/tcg-target.c.inc | 24 +++++++++++++---------
 tcg/mips/tcg-target.c.inc        | 34 +++++++++++++++++---------------
 tcg/ppc/tcg-target.c.inc         | 20 +++++++++++--------
 tcg/riscv/tcg-target.c.inc       | 24 +++++++++++++++-------
 tcg/s390x/tcg-target.c.inc       |  4 ++++
 tcg/sparc64/tcg-target.c.inc     | 23 ++++++++++++++++-----
 tcg/tci/tcg-target.c.inc         |  4 ++++
 23 files changed, 123 insertions(+), 82 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 7f18727686..207a85ed61 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -27,7 +27,6 @@
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        0
 #define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -47,7 +46,6 @@
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
 #define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
 
 /*
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index e766c6d628..d6b06e96bf 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -34,7 +34,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_div_i32          use_idiv_instructions
 #define TCG_TARGET_HAS_rem_i32          0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 3d36fe58f2..f4487ac1fc 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -39,7 +39,6 @@
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -59,7 +58,6 @@
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        1
 #define TCG_TARGET_HAS_muls2_i64        1
-#define TCG_TARGET_HAS_muluh_i64        0
 #define TCG_TARGET_HAS_mulsh_i64        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index ffacb41e80..53335b2cdb 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -20,7 +20,6 @@
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_mulu2_i32        0
 #define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
@@ -47,7 +46,6 @@
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        0
 #define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 9d8e0fb8df..b559ab3846 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -43,7 +43,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
@@ -59,7 +58,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muls2_i64        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 7ebcb49a19..18ec573f7e 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -29,7 +29,6 @@
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        0
 #define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -52,7 +51,6 @@
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
 #define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
 #endif
 
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index e3018717ea..453942a6a5 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -20,7 +20,6 @@
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        0
 #define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
@@ -46,7 +45,6 @@
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
 #define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index e5c132cf12..ac808e21e5 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -42,7 +42,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_sub2_i32       1
 #define TCG_TARGET_HAS_mulu2_i32      0
 #define TCG_TARGET_HAS_muls2_i32      0
-#define TCG_TARGET_HAS_muluh_i32      0
 #define TCG_TARGET_HAS_mulsh_i32      0
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
@@ -61,7 +60,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_sub2_i64       1
 #define TCG_TARGET_HAS_mulu2_i64      1
 #define TCG_TARGET_HAS_muls2_i64      HAVE_FACILITY(MISC_INSN_EXT2)
-#define TCG_TARGET_HAS_muluh_i64      0
 #define TCG_TARGET_HAS_mulsh_i64      0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index df87249df2..093de87a1d 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -28,7 +28,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -48,7 +47,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
 #define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        use_vis3_instructions
 #define TCG_TARGET_HAS_mulsh_i64        0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index a84ed1313a..7f3ef73f2e 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -28,7 +28,6 @@
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        0
 #define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        0
 #define TCG_TARGET_HAS_mulsh_i64        0
 /* Turn some undef macros into true macros.  */
 #define TCG_TARGET_HAS_add2_i32         1
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index f147da5c0e..b99b12c24c 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -18,7 +18,6 @@
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -42,7 +41,6 @@
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        1
-#define TCG_TARGET_HAS_muluh_i64        0
 #define TCG_TARGET_HAS_mulsh_i64        0
 #else
 #define TCG_TARGET_HAS_mulu2_i32        1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 76d5b67fba..39581465f2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1132,7 +1132,7 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_mulu2_i32) {
         tcg_gen_op4_i32(INDEX_op_mulu2_i32, rl, rh, arg1, arg2);
-    } else if (TCG_TARGET_HAS_muluh_i32) {
+    } else if (tcg_op_supported(INDEX_op_muluh_i32, TCG_TYPE_I32, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
         tcg_gen_op3_i32(INDEX_op_muluh_i32, rh, arg1, arg2);
@@ -2842,7 +2842,7 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_mulu2_i64) {
         tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
-    } else if (TCG_TARGET_HAS_muluh_i64) {
+    } else if (tcg_op_supported(INDEX_op_muluh_i64, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
         tcg_gen_op3_i64(INDEX_op_muluh_i64, rh, arg1, arg2);
@@ -2867,7 +2867,8 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op3_i64(INDEX_op_mulsh_i64, rh, arg1, arg2);
         tcg_gen_mov_i64(rl, t);
         tcg_temp_free_i64(t);
-    } else if (TCG_TARGET_HAS_mulu2_i64 || TCG_TARGET_HAS_muluh_i64) {
+    } else if (TCG_TARGET_HAS_mulu2_i64 ||
+               tcg_op_supported(INDEX_op_muluh_i64, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 85aaf971e7..ea0d06e6ef 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1022,6 +1022,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
+    OUTOP(INDEX_op_muluh_i32, TCGOutOpBinary, outop_muluh),
+    OUTOP(INDEX_op_muluh_i64, TCGOutOpBinary, outop_muluh),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
@@ -2280,8 +2282,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_mulu2_i32;
     case INDEX_op_muls2_i32:
         return TCG_TARGET_HAS_muls2_i32;
-    case INDEX_op_muluh_i32:
-        return TCG_TARGET_HAS_muluh_i32;
     case INDEX_op_mulsh_i32:
         return TCG_TARGET_HAS_mulsh_i32;
     case INDEX_op_bswap16_i32:
@@ -2362,8 +2362,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_mulu2_i64;
     case INDEX_op_muls2_i64:
         return TCG_TARGET_HAS_muls2_i64;
-    case INDEX_op_muluh_i64:
-        return TCG_TARGET_HAS_muluh_i64;
     case INDEX_op_mulsh_i64:
         return TCG_TARGET_HAS_mulsh_i64;
 
@@ -3876,7 +3874,6 @@ liveness_pass_1(TCGContext *s)
     QTAILQ_FOREACH_REVERSE_SAFE(op, &s->ops, link, op_prev) {
         int nb_iargs, nb_oargs;
         TCGOpcode opc_new, opc_new2;
-        bool have_opc_new2;
         TCGLifeData arg_life = 0;
         TCGTemp *ts;
         TCGOpcode opc = op->opc;
@@ -4036,22 +4033,18 @@ liveness_pass_1(TCGContext *s)
         case INDEX_op_mulu2_i32:
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_muluh_i32;
-            have_opc_new2 = TCG_TARGET_HAS_muluh_i32;
             goto do_mul2;
         case INDEX_op_muls2_i32:
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_mulsh_i32;
-            have_opc_new2 = TCG_TARGET_HAS_mulsh_i32;
             goto do_mul2;
         case INDEX_op_mulu2_i64:
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_muluh_i64;
-            have_opc_new2 = TCG_TARGET_HAS_muluh_i64;
             goto do_mul2;
         case INDEX_op_muls2_i64:
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_mulsh_i64;
-            have_opc_new2 = TCG_TARGET_HAS_mulsh_i64;
             goto do_mul2;
         do_mul2:
             nb_iargs = 2;
@@ -4065,7 +4058,8 @@ liveness_pass_1(TCGContext *s)
                 op->opc = opc = opc_new;
                 op->args[1] = op->args[2];
                 op->args[2] = op->args[3];
-            } else if (arg_temp(op->args[0])->state == TS_DEAD && have_opc_new2) {
+            } else if (arg_temp(op->args[0])->state == TS_DEAD &&
+                       tcg_op_supported(opc_new2, TCGOP_TYPE(op), 0)) {
                 /* The low part of the operation is dead; generate the high. */
                 op->opc = opc = opc_new2;
                 op->args[0] = op->args[1];
@@ -5433,6 +5427,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_andc:
     case INDEX_op_eqv:
     case INDEX_op_mul:
+    case INDEX_op_muluh_i32:
+    case INDEX_op_muluh_i64:
     case INDEX_op_nand:
     case INDEX_op_nor:
     case INDEX_op_or:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 4513140f58..bd0b7938c8 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2179,6 +2179,23 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static TCGConstraintSetIndex cset_mulh(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_I64 ? C_O1_I2(r, r, r) : C_NotImplemented;
+}
+
+static void tgen_muluh(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3508, UMULH, TCG_TYPE_I64, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_muluh = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_mulh,
+    .out_rrr = tgen_muluh,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2526,9 +2543,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                         args[5], const_args[4], const_args[5], true);
         break;
 
-    case INDEX_op_muluh_i64:
-        tcg_out_insn(s, 3508, UMULH, TCG_TYPE_I64, a0, a1, a2);
-        break;
     case INDEX_op_mulsh_i64:
         tcg_out_insn(s, 3508, SMULH, TCG_TYPE_I64, a0, a1, a2);
         break;
@@ -3043,7 +3057,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
-    case INDEX_op_muluh_i64:
     case INDEX_op_mulsh_i64:
         return C_O1_I2(r, r, r);
 
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 93e5c70ae3..b08e23d0dc 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1890,6 +1890,10 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static const TCGOutOpBinary outop_muluh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 4abe89d06e..5fdca05c9d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2664,6 +2664,10 @@ static const TCGOutOpBinary outop_mul = {
     .out_rri = tgen_muli,
 };
 
+static const TCGOutOpBinary outop_muluh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 944107b668..d65e5db98b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1335,6 +1335,21 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static void tgen_muluh(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_mulh_wu(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_mulh_du(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_muluh = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_muluh,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -1636,13 +1651,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_mulh_d(s, a0, a1, a2);
         break;
 
-    case INDEX_op_muluh_i32:
-        tcg_out_opc_mulh_wu(s, a0, a1, a2);
-        break;
-    case INDEX_op_muluh_i64:
-        tcg_out_opc_mulh_du(s, a0, a1, a2);
-        break;
-
     case INDEX_op_div_i32:
         tcg_out_opc_div_w(s, a0, a1, a2);
         break;
@@ -2337,8 +2345,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_mulsh_i32:
     case INDEX_op_mulsh_i64:
-    case INDEX_op_muluh_i32:
-    case INDEX_op_muluh_i64:
     case INDEX_op_div_i32:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 95c2645226..24f8184c33 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1743,6 +1743,24 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static void tgen_muluh(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (use_mips32r6_instructions) {
+        MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_MUHU : OPC_DMUHU;
+        tcg_out_opc_reg(s, insn, a0, a1, a2);
+    } else {
+        MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_MULTU : OPC_DMULTU;
+        tcg_out_opc_reg(s, insn, 0, a1, a2);
+        tcg_out_opc_reg(s, OPC_MFHI, a0, 0, 0);
+    }
+}
+
+static const TCGOutOpBinary outop_muluh = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_muluh,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -1910,13 +1928,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         i1 = OPC_MULT, i2 = OPC_MFHI;
         goto do_hilo1;
-    case INDEX_op_muluh_i32:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_MUHU, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_MULTU, i2 = OPC_MFHI;
-        goto do_hilo1;
     case INDEX_op_div_i32:
         if (use_mips32r6_instructions) {
             tcg_out_opc_reg(s, OPC_DIV_R6, a0, a1, a2);
@@ -1952,13 +1963,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         i1 = OPC_DMULT, i2 = OPC_MFHI;
         goto do_hilo1;
-    case INDEX_op_muluh_i64:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DMUHU, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DMULTU, i2 = OPC_MFHI;
-        goto do_hilo1;
     case INDEX_op_div_i64:
         if (use_mips32r6_instructions) {
             tcg_out_opc_reg(s, OPC_DDIV_R6, a0, a1, a2);
@@ -2246,14 +2250,12 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O0_I2(rz, r);
 
     case INDEX_op_mulsh_i32:
-    case INDEX_op_muluh_i32:
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
     case INDEX_op_setcond_i32:
     case INDEX_op_mulsh_i64:
-    case INDEX_op_muluh_i64:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index a7cc9d0bc7..06a7abf2ba 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2984,6 +2984,18 @@ static const TCGOutOpBinary outop_mul = {
     .out_rri = tgen_muli,
 };
 
+static void tgen_muluh(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? MULHWU : MULHDU;
+    tcg_out32(s, insn | TAB(a0, a1, a2));
+}
+
+static const TCGOutOpBinary outop_muluh = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_muluh,
+};
+
 static void tgen_nand(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3487,15 +3499,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_muluh_i32:
-        tcg_out32(s, MULHWU | TAB(args[0], args[1], args[2]));
-        break;
     case INDEX_op_mulsh_i32:
         tcg_out32(s, MULHW | TAB(args[0], args[1], args[2]));
         break;
-    case INDEX_op_muluh_i64:
-        tcg_out32(s, MULHDU | TAB(args[0], args[1], args[2]));
-        break;
     case INDEX_op_mulsh_i64:
         tcg_out32(s, MULHD | TAB(args[0], args[1], args[2]));
         break;
@@ -4177,14 +4183,12 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_muluh_i32:
     case INDEX_op_mulsh_i32:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
     case INDEX_op_mulsh_i64:
-    case INDEX_op_muluh_i64:
         return C_O1_I2(r, r, r);
 
     case INDEX_op_clz_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index ff685037d7..65246cc450 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2021,6 +2021,23 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static TCGConstraintSetIndex cset_mulh(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_I32 ? C_NotImplemented : C_O1_I2(r, r, r);
+}
+
+static void tgen_muluh(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_MULHU, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_muluh = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_mulh,
+    .out_rrr = tgen_muluh,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2379,11 +2396,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_reg(s, OPC_MULH, a0, a1, a2);
         break;
 
-    case INDEX_op_muluh_i32:
-    case INDEX_op_muluh_i64:
-        tcg_out_opc_reg(s, OPC_MULHU, a0, a1, a2);
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -2712,13 +2724,11 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O1_I2(r, r, rI);
 
     case INDEX_op_mulsh_i32:
-    case INDEX_op_muluh_i32:
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
     case INDEX_op_mulsh_i64:
-    case INDEX_op_muluh_i64:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 1ba9741fdd..e3d70ca236 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2309,6 +2309,10 @@ static const TCGOutOpBinary outop_mul = {
     .out_rri = tgen_muli,
 };
 
+static const TCGOutOpBinary outop_muluh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_nand(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 0a13a91166..31bdaecafa 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1357,6 +1357,24 @@ static const TCGOutOpBinary outop_mul = {
     .out_rri = tgen_muli,
 };
 
+static void tgen_muluh(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_UMULXHI);
+}
+
+static TCGConstraintSetIndex cset_muluh(TCGType type, unsigned flags)
+{
+    return (type == TCG_TYPE_I64 && use_vis3_instructions
+            ? C_O1_I2(r, r, r) : C_NotImplemented);
+}
+
+static const TCGOutOpBinary outop_muluh = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_muluh,
+    .out_rrr = tgen_muluh,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -1612,9 +1630,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_addsub2_i64(s, args[0], args[1], args[2], args[3], args[4],
                             const_args[4], args[5], const_args[5], true);
         break;
-    case INDEX_op_muluh_i64:
-        tcg_out_arith(s, args[0], args[1], args[2], ARITH_UMULXHI);
-        break;
 
     gen_arith:
         tcg_out_arithc(s, a0, a1, a2, c2, c);
@@ -1711,8 +1726,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_mulu2_i32:
     case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, rz, rJ);
-    case INDEX_op_muluh_i64:
-        return C_O1_I2(r, r, r);
 
     default:
         return C_NotImplemented;
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index ffc8654427..e4a2b171df 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -670,6 +670,10 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static const TCGOutOpBinary outop_muluh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_nand(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-- 
2.43.0


