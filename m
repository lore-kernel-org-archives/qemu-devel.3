Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381BBC369BD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4luX-0008S1-9q; Tue, 15 Apr 2025 15:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luP-0008OP-EX
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:25 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luK-0007vC-Tq
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:25 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7376e311086so7825578b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745119; x=1745349919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkRoVrkAaVcTr4xgQe02YL64VffsMTkyxwPbx+CW914=;
 b=V8sJtod3DE9jz6b2TAo0Ka2VBm9egHeyc+qhpe9h84DewNtWAn5jT7cTj2xsz0CcY/
 FulHCykiS4TpkzvJyqa5JBfQ+5AaSMdj28swegRrS1Z2qJzn/MyS4DZ3V3o1ujl5L4Hd
 HBbqib0NsKqKiF8s/x7YNLZHG5NSk8nzlpsMAbhdQRFzQIcyNBF7TB+LAHnJrhNw8aca
 sbcF4ZIR/JZiZNrTrKMkhdAZz2A8nVd2dB3MfrksItPAZ73WFwlMhAhzVsI8tUVDWwkb
 qgiqRkeltvXT+Cu40TFBx1G+ae8gVeOemiIoBymBOvGwQ73X12q3y1PDGXV4R0N3M/WK
 1/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745119; x=1745349919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FkRoVrkAaVcTr4xgQe02YL64VffsMTkyxwPbx+CW914=;
 b=RjVluR5CzlmmlI/QuWBsV4uxTLHbHmGevgV3EeaGw6q704snoCaKurIjlWQOUddsnA
 jCO0QqNk4Dm6EbmSWkQGb+YpyYRw8RREOCpobqRm+9OH8VTauckKQ9yjUUtQqfk9bFB6
 NSnFhDIp2nzKehoF7w/bKLmQOBJf8rXREpUv77eEoZTtK7bCka/Xf3IZuV0sYKXV4PDW
 ki6sUoHee0qQVyO+V7KCWHalJwYpeidkkLTHkOtYuC6Qf6cJU7RXxYyenJzDnwmYmKga
 41zYIsw/HzinoJ9bQcWEqXOE9mF72sXTxoVM/q2mAFKhtSJd+lngzoEm3Raa0XyMG7dz
 dFKQ==
X-Gm-Message-State: AOJu0Yx4+hrwKYO3M+jSAVjSLLjc3GZbnaOTak6LqjLmmc7bBY1HOEG/
 rKwqlxCk0koR4CJjDo+V9NFXQbvn3USJE0odJtX4/NdYAb27sHtBpR35kNub4LOz5fh5YnC7nSL
 P
X-Gm-Gg: ASbGncvLBHcEkHQonOQ6o6JrZzf5F5mCiqqX+u09yj/2nHpX7hyRqUCbOploT66ieMB
 /ZFG7cSZJNa4EIkj0r0nZTq2i2EvstPo/HlNLGbNyfH7lJsFuqddNJHJyKyWmmu2yQrQ+Zq/vCt
 7UufOVtQU5xM5U5H3NPvJDSYym/cTShzSbtkMo/cUPO4GM63W5Gm+5HQGHF02eTauRgrHCpEenH
 30YRJqDJaeSEjV04U+YcmmeFeWDnwrYyrxAdpwRaM5Wno5Zwbj8oosi8L8riTqrc0m9MMIMM+fH
 psEqZVnkUpqcMpEO2KnaZiEIhb1Ada4lqofUyC4BQYHevJyDsyRVNi54AKZYPZfHEeGop14fZ5w
 =
X-Google-Smtp-Source: AGHT+IH1XnQulKkscoonWGWCe7xA0ymGup5pud2HnIcusR3uiPtUUMwc3LYaOO+tAuSjHmU5eMChqg==
X-Received: by 2002:a05:6a00:181c:b0:736:ab49:a6e4 with SMTP id
 d2e1a72fcca58-73c1f8c6c74mr797614b3a.1.1744745118848; 
 Tue, 15 Apr 2025 12:25:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 003/163] tcg: Remove INDEX_op_ext{8,16,32}*
Date: Tue, 15 Apr 2025 12:22:34 -0700
Message-ID: <20250415192515.232910-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Use the fully general extract opcodes instead.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  10 -
 tcg/aarch64/tcg-target-has.h     |  10 -
 tcg/arm/tcg-target-has.h         |   4 -
 tcg/i386/tcg-target-has.h        |  10 -
 tcg/loongarch64/tcg-target-has.h |  10 -
 tcg/mips/tcg-target-has.h        |  13 -
 tcg/ppc/tcg-target-has.h         |  12 -
 tcg/riscv/tcg-target-has.h       |  10 -
 tcg/s390x/tcg-target-has.h       |  10 -
 tcg/sparc64/tcg-target-has.h     |  10 -
 tcg/tcg-has.h                    |   6 -
 tcg/tci/tcg-target-has.h         |  10 -
 tcg/optimize.c                   |  61 +----
 tcg/tcg-op.c                     | 414 +++++++------------------------
 tcg/tcg.c                        |  46 ----
 tcg/tci.c                        |  36 ---
 docs/devel/tcg-ops.rst           |  14 --
 tcg/aarch64/tcg-target.c.inc     |  22 +-
 tcg/arm/tcg-target.c.inc         |   7 -
 tcg/i386/tcg-target.c.inc        |  24 +-
 tcg/loongarch64/tcg-target.c.inc |  22 +-
 tcg/mips/tcg-target.c.inc        |  20 +-
 tcg/ppc/tcg-target.c.inc         |  17 +-
 tcg/riscv/tcg-target.c.inc       |  22 +-
 tcg/s390x/tcg-target.c.inc       |  22 +-
 tcg/sparc64/tcg-target.c.inc     |  14 +-
 tcg/tci/tcg-target.c.inc         | 102 +++-----
 27 files changed, 135 insertions(+), 823 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 5bf78b0764..c26cffaa3f 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -85,10 +85,6 @@ DEF(mulsh_i32, 1, 2, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
-DEF(ext8s_i32, 1, 1, 0, 0)
-DEF(ext16s_i32, 1, 1, 0, 0)
-DEF(ext8u_i32, 1, 1, 0, 0)
-DEF(ext16u_i32, 1, 1, 0, 0)
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
@@ -149,12 +145,6 @@ DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
 DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
-DEF(ext8s_i64, 1, 1, 0, 0)
-DEF(ext16s_i64, 1, 1, 0, 0)
-DEF(ext32s_i64, 1, 1, 0, 0)
-DEF(ext8u_i64, 1, 1, 0, 0)
-DEF(ext16u_i64, 1, 1, 0, 0)
-DEF(ext32u_i64, 1, 1, 0, 0)
 DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 39f01c14cd..bfd587c0fc 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -15,10 +15,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
@@ -44,12 +40,6 @@
 
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index e3510a8f7a..8398c80c8e 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -24,10 +24,6 @@ extern bool use_neon_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        0 /* and r0, r1, #0xff */
-#define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 63768ff058..bbf55c86b6 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -28,10 +28,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_div2_i32         1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
@@ -57,12 +53,6 @@
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_div2_i64         1
 #define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 188b00799f..166c9d7e41 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -22,10 +22,6 @@
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
@@ -47,12 +43,6 @@
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index df6960fe9a..fd96905484 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -80,8 +80,6 @@ extern bool use_mips32r2_instructions;
 
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
-#define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
 #define TCG_TARGET_HAS_rot_i32          use_mips32r2_instructions
 #define TCG_TARGET_HAS_clz_i32          use_mips32r2_instructions
 #define TCG_TARGET_HAS_ctz_i32          0
@@ -93,23 +91,12 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
-#define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
 #define TCG_TARGET_HAS_rot_i64          use_mips32r2_instructions
 #define TCG_TARGET_HAS_clz_i64          use_mips32r2_instructions
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
 #endif
 
-/* optional instructions automatically implemented */
-#define TCG_TARGET_HAS_ext8u_i32        0 /* andi rt, rs, 0xff   */
-#define TCG_TARGET_HAS_ext16u_i32       0 /* andi rt, rs, 0xffff */
-
-#if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_ext8u_i64        0 /* andi rt, rs, 0xff   */
-#define TCG_TARGET_HAS_ext16u_i64       0 /* andi rt, rs, 0xffff */
-#endif
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              0
 
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 6db91f78ce..9acfc574c5 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -16,16 +16,10 @@
 #define have_altivec   (cpuinfo & CPUINFO_ALTIVEC)
 #define have_vsx       (cpuinfo & CPUINFO_VSX)
 
-/* optional instructions automatically implemented */
-#define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
-#define TCG_TARGET_HAS_ext16u_i32       0
-
 /* optional instructions */
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          have_isa_3_00
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
@@ -52,12 +46,6 @@
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          have_isa_3_00
 #define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        0
-#define TCG_TARGET_HAS_ext16u_i64       0
-#define TCG_TARGET_HAS_ext32u_i64       0
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 98081084f2..fc62049c78 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -22,10 +22,6 @@
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_not_i32          1
@@ -46,12 +42,6 @@
 #define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index e99e671642..aea805455f 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -31,10 +31,6 @@ extern uint64_t s390_facilities[3];
 /* optional instructions */
 #define TCG_TARGET_HAS_div2_i32       1
 #define TCG_TARGET_HAS_rot_i32        1
-#define TCG_TARGET_HAS_ext8s_i32      1
-#define TCG_TARGET_HAS_ext16s_i32     1
-#define TCG_TARGET_HAS_ext8u_i32      1
-#define TCG_TARGET_HAS_ext16u_i32     1
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
 #define TCG_TARGET_HAS_not_i32        HAVE_FACILITY(MISC_INSN_EXT3)
@@ -59,12 +55,6 @@ extern uint64_t s390_facilities[3];
 
 #define TCG_TARGET_HAS_div2_i64       1
 #define TCG_TARGET_HAS_rot_i64        1
-#define TCG_TARGET_HAS_ext8s_i64      1
-#define TCG_TARGET_HAS_ext16s_i64     1
-#define TCG_TARGET_HAS_ext32s_i64     1
-#define TCG_TARGET_HAS_ext8u_i64      1
-#define TCG_TARGET_HAS_ext16u_i64     1
-#define TCG_TARGET_HAS_ext32u_i64     1
 #define TCG_TARGET_HAS_bswap16_i64    1
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 2f46df8c61..ad6f35da17 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -17,10 +17,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_div_i32		1
 #define TCG_TARGET_HAS_rem_i32		0
 #define TCG_TARGET_HAS_rot_i32          0
-#define TCG_TARGET_HAS_ext8s_i32        0
-#define TCG_TARGET_HAS_ext16s_i32       0
-#define TCG_TARGET_HAS_ext8u_i32        0
-#define TCG_TARGET_HAS_ext16u_i32       0
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
 #define TCG_TARGET_HAS_not_i32          1
@@ -46,12 +42,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          0
 #define TCG_TARGET_HAS_rot_i64          0
-#define TCG_TARGET_HAS_ext8s_i64        0
-#define TCG_TARGET_HAS_ext16s_i64       0
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        0
-#define TCG_TARGET_HAS_ext16u_i64       0
-#define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 418e4673eb..4ccdc6bbee 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -16,12 +16,6 @@
 #define TCG_TARGET_HAS_rem_i64          0
 #define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          0
-#define TCG_TARGET_HAS_ext8s_i64        0
-#define TCG_TARGET_HAS_ext16s_i64       0
-#define TCG_TARGET_HAS_ext32s_i64       0
-#define TCG_TARGET_HAS_ext8u_i64        0
-#define TCG_TARGET_HAS_ext16u_i64       0
-#define TCG_TARGET_HAS_ext32u_i64       0
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index c8785ca8dc..cb0964c3d4 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -11,10 +11,6 @@
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_eqv_i32          1
@@ -40,12 +36,6 @@
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_eqv_i64          1
 #define TCG_TARGET_HAS_nand_i64         1
diff --git a/tcg/optimize.c b/tcg/optimize.c
index f922f86a1d..250bc7de2b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -501,18 +501,6 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_ctpop_i64:
         return ctpop64(x);
 
-    CASE_OP_32_64(ext8s):
-        return (int8_t)x;
-
-    CASE_OP_32_64(ext16s):
-        return (int16_t)x;
-
-    CASE_OP_32_64(ext8u):
-        return (uint8_t)x;
-
-    CASE_OP_32_64(ext16u):
-        return (uint16_t)x;
-
     CASE_OP_32_64(bswap16):
         x = bswap16(x);
         return y & TCG_BSWAP_OS ? (int16_t)x : x;
@@ -525,12 +513,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
         return bswap64(x);
 
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_ext32s_i64:
         return (int32_t)x;
 
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
-    case INDEX_op_ext32u_i64:
         return (uint32_t)x;
 
     case INDEX_op_extrh_i64_i32:
@@ -1857,8 +1843,7 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask_old, s_mask, z_mask;
-    bool type_change = false;
+    uint64_t s_mask, z_mask;
     TempOptInfo *t1;
 
     if (fold_const1(ctx, op)) {
@@ -1868,72 +1853,38 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
     t1 = arg_info(op->args[1]);
     z_mask = t1->z_mask;
     s_mask = t1->s_mask;
-    s_mask_old = s_mask;
 
     switch (op->opc) {
-    CASE_OP_32_64(ext8s):
-        s_mask |= INT8_MIN;
-        z_mask = (int8_t)z_mask;
-        break;
-    CASE_OP_32_64(ext16s):
-        s_mask |= INT16_MIN;
-        z_mask = (int16_t)z_mask;
-        break;
     case INDEX_op_ext_i32_i64:
-        type_change = true;
-        QEMU_FALLTHROUGH;
-    case INDEX_op_ext32s_i64:
         s_mask |= INT32_MIN;
         z_mask = (int32_t)z_mask;
         break;
     default:
         g_assert_not_reached();
     }
-
-    if (!type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
-        return true;
-    }
-
     return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_extu(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask_old, z_mask;
-    bool type_change = false;
+    uint64_t z_mask;
 
     if (fold_const1(ctx, op)) {
         return true;
     }
 
-    z_mask_old = z_mask = arg_info(op->args[1])->z_mask;
-
+    z_mask = arg_info(op->args[1])->z_mask;
     switch (op->opc) {
-    CASE_OP_32_64(ext8u):
-        z_mask = (uint8_t)z_mask;
-        break;
-    CASE_OP_32_64(ext16u):
-        z_mask = (uint16_t)z_mask;
-        break;
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extu_i32_i64:
-        type_change = true;
-        QEMU_FALLTHROUGH;
-    case INDEX_op_ext32u_i64:
         z_mask = (uint32_t)z_mask;
         break;
     case INDEX_op_extrh_i64_i32:
-        type_change = true;
         z_mask >>= 32;
         break;
     default:
         g_assert_not_reached();
     }
-
-    if (!type_change && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
-        return true;
-    }
-
     return fold_masks_z(ctx, op, z_mask);
 }
 
@@ -2936,15 +2887,9 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(extract2):
             done = fold_extract2(&ctx, op);
             break;
-        CASE_OP_32_64(ext8s):
-        CASE_OP_32_64(ext16s):
-        case INDEX_op_ext32s_i64:
         case INDEX_op_ext_i32_i64:
             done = fold_exts(&ctx, op);
             break;
-        CASE_OP_32_64(ext8u):
-        CASE_OP_32_64(ext16u):
-        case INDEX_op_ext32u_i64:
         case INDEX_op_extu_i32_i64:
         case INDEX_op_extrl_i64_i32:
         case INDEX_op_extrh_i64_i32:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f68c4f9702..48793ed439 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -414,17 +414,19 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     case -1:
         tcg_gen_mov_i32(ret, arg1);
         return;
-    case 0xff:
-        /* Don't recurse with tcg_gen_ext8u_i32.  */
-        if (TCG_TARGET_HAS_ext8u_i32) {
-            tcg_gen_op2_i32(INDEX_op_ext8u_i32, ret, arg1);
-            return;
-        }
-        break;
-    case 0xffff:
-        if (TCG_TARGET_HAS_ext16u_i32) {
-            tcg_gen_op2_i32(INDEX_op_ext16u_i32, ret, arg1);
-            return;
+    default:
+        /*
+         * Canonicalize on extract, if valid.  This aids x86 with its
+         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
+         * which does not require matching operands.  Other backends can
+         * trivially expand the extract to AND during code generation.
+         */
+        if (!(arg2 & (arg2 + 1))) {
+            unsigned len = ctz32(~arg2);
+            if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len)) {
+                tcg_gen_extract_i32(ret, arg1, 0, len);
+                return;
+            }
         }
         break;
     }
@@ -955,40 +957,20 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, zero, arg, ofs, len);
     } else {
-        /* To help two-operand hosts we prefer to zero-extend first,
-           which allows ARG to stay live.  */
-        switch (len) {
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i32) {
-                tcg_gen_ext16u_i32(ret, arg);
-                tcg_gen_shli_i32(ret, ret, ofs);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i32) {
-                tcg_gen_ext8u_i32(ret, arg);
-                tcg_gen_shli_i32(ret, ret, ofs);
-                return;
-            }
-            break;
+        /*
+         * To help two-operand hosts we prefer to zero-extend first,
+         * which allows ARG to stay live.
+         */
+        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len)) {
+            tcg_gen_extract_i32(ret, arg, 0, len);
+            tcg_gen_shli_i32(ret, ret, ofs);
+            return;
         }
         /* Otherwise prefer zero-extension over AND for code size.  */
-        switch (ofs + len) {
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i32) {
-                tcg_gen_shli_i32(ret, arg, ofs);
-                tcg_gen_ext16u_i32(ret, ret);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i32) {
-                tcg_gen_shli_i32(ret, arg, ofs);
-                tcg_gen_ext8u_i32(ret, ret);
-                return;
-            }
-            break;
+        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
+            tcg_gen_shli_i32(ret, arg, ofs);
+            tcg_gen_extract_i32(ret, ret, 0, ofs + len);
+            return;
         }
         tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
         tcg_gen_shli_i32(ret, ret, ofs);
@@ -1008,32 +990,21 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_shri_i32(ret, arg, 32 - len);
         return;
     }
-    if (ofs == 0) {
-        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
-        return;
-    }
 
     if (TCG_TARGET_extract_valid(TCG_TYPE_I32, ofs, len)) {
         tcg_gen_op4ii_i32(INDEX_op_extract_i32, ret, arg, ofs, len);
         return;
     }
+    if (ofs == 0) {
+        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
+        return;
+    }
 
     /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    switch (ofs + len) {
-    case 16:
-        if (TCG_TARGET_HAS_ext16u_i32) {
-            tcg_gen_ext16u_i32(ret, arg);
-            tcg_gen_shri_i32(ret, ret, ofs);
-            return;
-        }
-        break;
-    case 8:
-        if (TCG_TARGET_HAS_ext8u_i32) {
-            tcg_gen_ext8u_i32(ret, arg);
-            tcg_gen_shri_i32(ret, ret, ofs);
-            return;
-        }
-        break;
+    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
+        tcg_gen_op4ii_i32(INDEX_op_extract_i32, ret, arg, 0, ofs + len);
+        tcg_gen_shri_i32(ret, ret, ofs);
+        return;
     }
 
     /* ??? Ideally we'd know what values are available for immediate AND.
@@ -1064,16 +1035,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_sari_i32(ret, arg, 32 - len);
         return;
     }
-    if (ofs == 0) {
-        switch (len) {
-        case 16:
-            tcg_gen_ext16s_i32(ret, arg);
-            return;
-        case 8:
-            tcg_gen_ext8s_i32(ret, arg);
-            return;
-        }
-    }
 
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, ofs, len)) {
         tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, ofs, len);
@@ -1081,37 +1042,15 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 
     /* Assume that sign-extension, if available, is cheaper than a shift.  */
-    switch (ofs + len) {
-    case 16:
-        if (TCG_TARGET_HAS_ext16s_i32) {
-            tcg_gen_ext16s_i32(ret, arg);
-            tcg_gen_sari_i32(ret, ret, ofs);
-            return;
-        }
-        break;
-    case 8:
-        if (TCG_TARGET_HAS_ext8s_i32) {
-            tcg_gen_ext8s_i32(ret, arg);
-            tcg_gen_sari_i32(ret, ret, ofs);
-            return;
-        }
-        break;
+    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, ofs + len)) {
+        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, 0, ofs + len);
+        tcg_gen_sari_i32(ret, ret, ofs);
+        return;
     }
-    switch (len) {
-    case 16:
-        if (TCG_TARGET_HAS_ext16s_i32) {
-            tcg_gen_shri_i32(ret, arg, ofs);
-            tcg_gen_ext16s_i32(ret, ret);
-            return;
-        }
-        break;
-    case 8:
-        if (TCG_TARGET_HAS_ext8s_i32) {
-            tcg_gen_shri_i32(ret, arg, ofs);
-            tcg_gen_ext8s_i32(ret, ret);
-            return;
-        }
-        break;
+    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, len)) {
+        tcg_gen_shri_i32(ret, arg, ofs);
+        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, ret, 0, len);
+        return;
     }
 
     tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
@@ -1281,40 +1220,22 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_ext8s_i32) {
-        tcg_gen_op2_i32(INDEX_op_ext8s_i32, ret, arg);
-    } else {
-        tcg_gen_shli_i32(ret, arg, 24);
-        tcg_gen_sari_i32(ret, ret, 24);
-    }
+    tcg_gen_sextract_i32(ret, arg, 0, 8);
 }
 
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_ext16s_i32) {
-        tcg_gen_op2_i32(INDEX_op_ext16s_i32, ret, arg);
-    } else {
-        tcg_gen_shli_i32(ret, arg, 16);
-        tcg_gen_sari_i32(ret, ret, 16);
-    }
+    tcg_gen_sextract_i32(ret, arg, 0, 16);
 }
 
 void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_ext8u_i32) {
-        tcg_gen_op2_i32(INDEX_op_ext8u_i32, ret, arg);
-    } else {
-        tcg_gen_andi_i32(ret, arg, 0xffu);
-    }
+    tcg_gen_extract_i32(ret, arg, 0, 8);
 }
 
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_ext16u_i32) {
-        tcg_gen_op2_i32(INDEX_op_ext16u_i32, ret, arg);
-    } else {
-        tcg_gen_andi_i32(ret, arg, 0xffffu);
-    }
+    tcg_gen_extract_i32(ret, arg, 0, 16);
 }
 
 /*
@@ -1794,23 +1715,19 @@ void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     case -1:
         tcg_gen_mov_i64(ret, arg1);
         return;
-    case 0xff:
-        /* Don't recurse with tcg_gen_ext8u_i64.  */
-        if (TCG_TARGET_HAS_ext8u_i64) {
-            tcg_gen_op2_i64(INDEX_op_ext8u_i64, ret, arg1);
-            return;
-        }
-        break;
-    case 0xffff:
-        if (TCG_TARGET_HAS_ext16u_i64) {
-            tcg_gen_op2_i64(INDEX_op_ext16u_i64, ret, arg1);
-            return;
-        }
-        break;
-    case 0xffffffffu:
-        if (TCG_TARGET_HAS_ext32u_i64) {
-            tcg_gen_op2_i64(INDEX_op_ext32u_i64, ret, arg1);
-            return;
+    default:
+        /*
+         * Canonicalize on extract, if valid.  This aids x86 with its
+         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
+         * which does not require matching operands.  Other backends can
+         * trivially expand the extract to AND during code generation.
+         */
+        if (!(arg2 & (arg2 + 1))) {
+            unsigned len = ctz64(~arg2);
+            if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len)) {
+                tcg_gen_extract_i64(ret, arg1, 0, len);
+                return;
+            }
         }
         break;
     }
@@ -2118,77 +2035,32 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_ext8s_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
-    } else if (TCG_TARGET_HAS_ext8s_i64) {
-        tcg_gen_op2_i64(INDEX_op_ext8s_i64, ret, arg);
-    } else {
-        tcg_gen_shli_i64(ret, arg, 56);
-        tcg_gen_sari_i64(ret, ret, 56);
-    }
+    tcg_gen_sextract_i64(ret, arg, 0, 8);
 }
 
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_ext16s_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
-    } else if (TCG_TARGET_HAS_ext16s_i64) {
-        tcg_gen_op2_i64(INDEX_op_ext16s_i64, ret, arg);
-    } else {
-        tcg_gen_shli_i64(ret, arg, 48);
-        tcg_gen_sari_i64(ret, ret, 48);
-    }
+    tcg_gen_sextract_i64(ret, arg, 0, 16);
 }
 
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
-    } else if (TCG_TARGET_HAS_ext32s_i64) {
-        tcg_gen_op2_i64(INDEX_op_ext32s_i64, ret, arg);
-    } else {
-        tcg_gen_shli_i64(ret, arg, 32);
-        tcg_gen_sari_i64(ret, ret, 32);
-    }
+    tcg_gen_sextract_i64(ret, arg, 0, 32);
 }
 
 void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_ext8u_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-    } else if (TCG_TARGET_HAS_ext8u_i64) {
-        tcg_gen_op2_i64(INDEX_op_ext8u_i64, ret, arg);
-    } else {
-        tcg_gen_andi_i64(ret, arg, 0xffu);
-    }
+    tcg_gen_extract_i64(ret, arg, 0, 8);
 }
 
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_ext16u_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-    } else if (TCG_TARGET_HAS_ext16u_i64) {
-        tcg_gen_op2_i64(INDEX_op_ext16u_i64, ret, arg);
-    } else {
-        tcg_gen_andi_i64(ret, arg, 0xffffu);
-    }
+    tcg_gen_extract_i64(ret, arg, 0, 16);
 }
 
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-    } else if (TCG_TARGET_HAS_ext32u_i64) {
-        tcg_gen_op2_i64(INDEX_op_ext32u_i64, ret, arg);
-    } else {
-        tcg_gen_andi_i64(ret, arg, 0xffffffffu);
-    }
+    tcg_gen_extract_i64(ret, arg, 0, 32);
 }
 
 /*
@@ -2720,54 +2592,20 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                 return;
             }
         }
-        /* To help two-operand hosts we prefer to zero-extend first,
-           which allows ARG to stay live.  */
-        switch (len) {
-        case 32:
-            if (TCG_TARGET_HAS_ext32u_i64) {
-                tcg_gen_ext32u_i64(ret, arg);
-                tcg_gen_shli_i64(ret, ret, ofs);
-                return;
-            }
-            break;
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i64) {
-                tcg_gen_ext16u_i64(ret, arg);
-                tcg_gen_shli_i64(ret, ret, ofs);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i64) {
-                tcg_gen_ext8u_i64(ret, arg);
-                tcg_gen_shli_i64(ret, ret, ofs);
-                return;
-            }
-            break;
+        /*
+         * To help two-operand hosts we prefer to zero-extend first,
+         * which allows ARG to stay live.
+         */
+        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len)) {
+            tcg_gen_extract_i64(ret, arg, 0, len);
+            tcg_gen_shli_i64(ret, ret, ofs);
+            return;
         }
         /* Otherwise prefer zero-extension over AND for code size.  */
-        switch (ofs + len) {
-        case 32:
-            if (TCG_TARGET_HAS_ext32u_i64) {
-                tcg_gen_shli_i64(ret, arg, ofs);
-                tcg_gen_ext32u_i64(ret, ret);
-                return;
-            }
-            break;
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i64) {
-                tcg_gen_shli_i64(ret, arg, ofs);
-                tcg_gen_ext16u_i64(ret, ret);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i64) {
-                tcg_gen_shli_i64(ret, arg, ofs);
-                tcg_gen_ext8u_i64(ret, ret);
-                return;
-            }
-            break;
+        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
+            tcg_gen_shli_i64(ret, arg, ofs);
+            tcg_gen_extract_i64(ret, ret, 0, ofs + len);
+            return;
         }
         tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
         tcg_gen_shli_i64(ret, ret, ofs);
@@ -2787,10 +2625,6 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_shri_i64(ret, arg, 64 - len);
         return;
     }
-    if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-        return;
-    }
 
     if (TCG_TARGET_REG_BITS == 32) {
         /* Look for a 32-bit extract within one of the two words.  */
@@ -2822,30 +2656,16 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, ofs, len);
         return;
     }
+    if (ofs == 0) {
+        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
+        return;
+    }
 
     /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    switch (ofs + len) {
-    case 32:
-        if (TCG_TARGET_HAS_ext32u_i64) {
-            tcg_gen_ext32u_i64(ret, arg);
-            tcg_gen_shri_i64(ret, ret, ofs);
-            return;
-        }
-        break;
-    case 16:
-        if (TCG_TARGET_HAS_ext16u_i64) {
-            tcg_gen_ext16u_i64(ret, arg);
-            tcg_gen_shri_i64(ret, ret, ofs);
-            return;
-        }
-        break;
-    case 8:
-        if (TCG_TARGET_HAS_ext8u_i64) {
-            tcg_gen_ext8u_i64(ret, arg);
-            tcg_gen_shri_i64(ret, ret, ofs);
-            return;
-        }
-        break;
+    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
+        tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, 0, ofs + len);
+        tcg_gen_shri_i64(ret, ret, ofs);
+        return;
     }
 
     /* ??? Ideally we'd know what values are available for immediate AND.
@@ -2876,19 +2696,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_sari_i64(ret, arg, 64 - len);
         return;
     }
-    if (ofs == 0) {
-        switch (len) {
-        case 32:
-            tcg_gen_ext32s_i64(ret, arg);
-            return;
-        case 16:
-            tcg_gen_ext16s_i64(ret, arg);
-            return;
-        case 8:
-            tcg_gen_ext8s_i64(ret, arg);
-            return;
-        }
-    }
 
     if (TCG_TARGET_REG_BITS == 32) {
         /* Look for a 32-bit extract within one of the two words.  */
@@ -2928,52 +2735,17 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 
     /* Assume that sign-extension, if available, is cheaper than a shift.  */
-    switch (ofs + len) {
-    case 32:
-        if (TCG_TARGET_HAS_ext32s_i64) {
-            tcg_gen_ext32s_i64(ret, arg);
-            tcg_gen_sari_i64(ret, ret, ofs);
-            return;
-        }
-        break;
-    case 16:
-        if (TCG_TARGET_HAS_ext16s_i64) {
-            tcg_gen_ext16s_i64(ret, arg);
-            tcg_gen_sari_i64(ret, ret, ofs);
-            return;
-        }
-        break;
-    case 8:
-        if (TCG_TARGET_HAS_ext8s_i64) {
-            tcg_gen_ext8s_i64(ret, arg);
-            tcg_gen_sari_i64(ret, ret, ofs);
-            return;
-        }
-        break;
+    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, ofs + len)) {
+        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, arg, 0, ofs + len);
+        tcg_gen_sari_i64(ret, ret, ofs);
+        return;
     }
-    switch (len) {
-    case 32:
-        if (TCG_TARGET_HAS_ext32s_i64) {
-            tcg_gen_shri_i64(ret, arg, ofs);
-            tcg_gen_ext32s_i64(ret, ret);
-            return;
-        }
-        break;
-    case 16:
-        if (TCG_TARGET_HAS_ext16s_i64) {
-            tcg_gen_shri_i64(ret, arg, ofs);
-            tcg_gen_ext16s_i64(ret, ret);
-            return;
-        }
-        break;
-    case 8:
-        if (TCG_TARGET_HAS_ext8s_i64) {
-            tcg_gen_shri_i64(ret, arg, ofs);
-            tcg_gen_ext8s_i64(ret, ret);
-            return;
-        }
-        break;
+    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, len)) {
+        tcg_gen_shri_i64(ret, arg, ofs);
+        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, ret, 0, len);
+        return;
     }
+
     tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
     tcg_gen_sari_i64(ret, ret, 64 - len);
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ae98ca325e..b2441da3ab 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2242,14 +2242,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_muluh_i32;
     case INDEX_op_mulsh_i32:
         return TCG_TARGET_HAS_mulsh_i32;
-    case INDEX_op_ext8s_i32:
-        return TCG_TARGET_HAS_ext8s_i32;
-    case INDEX_op_ext16s_i32:
-        return TCG_TARGET_HAS_ext16s_i32;
-    case INDEX_op_ext8u_i32:
-        return TCG_TARGET_HAS_ext8u_i32;
-    case INDEX_op_ext16u_i32:
-        return TCG_TARGET_HAS_ext16u_i32;
     case INDEX_op_bswap16_i32:
         return TCG_TARGET_HAS_bswap16_i32;
     case INDEX_op_bswap32_i32:
@@ -2328,18 +2320,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return TCG_TARGET_HAS_extr_i64_i32;
-    case INDEX_op_ext8s_i64:
-        return TCG_TARGET_HAS_ext8s_i64;
-    case INDEX_op_ext16s_i64:
-        return TCG_TARGET_HAS_ext16s_i64;
-    case INDEX_op_ext32s_i64:
-        return TCG_TARGET_HAS_ext32s_i64;
-    case INDEX_op_ext8u_i64:
-        return TCG_TARGET_HAS_ext8u_i64;
-    case INDEX_op_ext16u_i64:
-        return TCG_TARGET_HAS_ext16u_i64;
-    case INDEX_op_ext32u_i64:
-        return TCG_TARGET_HAS_ext32u_i64;
     case INDEX_op_bswap16_i64:
         return TCG_TARGET_HAS_bswap16_i64;
     case INDEX_op_bswap32_i64:
@@ -5427,32 +5407,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
     /* emit instruction */
     switch (op->opc) {
-    case INDEX_op_ext8s_i32:
-        tcg_out_ext8s(s, TCG_TYPE_I32, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext8s_i64:
-        tcg_out_ext8s(s, TCG_TYPE_I64, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-        tcg_out_ext8u(s, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext16s_i32:
-        tcg_out_ext16s(s, TCG_TYPE_I32, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext16s_i64:
-        tcg_out_ext16s(s, TCG_TYPE_I64, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-        tcg_out_ext16u(s, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext32s_i64:
-        tcg_out_ext32s(s, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext32u_i64:
-        tcg_out_ext32u(s, new_args[0], new_args[1]);
-        break;
     case INDEX_op_ext_i32_i64:
         tcg_out_exts_i32_i64(s, new_args[0], new_args[1]);
         break;
diff --git a/tcg/tci.c b/tcg/tci.c
index d223258efe..531cd83aae 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -689,31 +689,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_write_reg64(regs, r1, r0, tmp64);
             break;
 #endif
-#if TCG_TARGET_HAS_ext8s_i32 || TCG_TARGET_HAS_ext8s_i64
-        CASE_32_64(ext8s)
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = (int8_t)regs[r1];
-            break;
-#endif
-#if TCG_TARGET_HAS_ext16s_i32 || TCG_TARGET_HAS_ext16s_i64 || \
-    TCG_TARGET_HAS_bswap16_i32 || TCG_TARGET_HAS_bswap16_i64
-        CASE_32_64(ext16s)
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = (int16_t)regs[r1];
-            break;
-#endif
-#if TCG_TARGET_HAS_ext8u_i32 || TCG_TARGET_HAS_ext8u_i64
-        CASE_32_64(ext8u)
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = (uint8_t)regs[r1];
-            break;
-#endif
-#if TCG_TARGET_HAS_ext16u_i32 || TCG_TARGET_HAS_ext16u_i64
-        CASE_32_64(ext16u)
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = (uint16_t)regs[r1];
-            break;
-#endif
 #if TCG_TARGET_HAS_bswap16_i32 || TCG_TARGET_HAS_bswap16_i64
         CASE_32_64(bswap16)
             tci_args_rr(insn, &r0, &r1);
@@ -864,12 +839,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 tb_ptr = ptr;
             }
             break;
-        case INDEX_op_ext32s_i64:
         case INDEX_op_ext_i32_i64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (int32_t)regs[r1];
             break;
-        case INDEX_op_ext32u_i64:
         case INDEX_op_extu_i32_i64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (uint32_t)regs[r1];
@@ -1092,15 +1065,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
 
     case INDEX_op_mov_i32:
     case INDEX_op_mov_i64:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 688984fd39..3db7b81637 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -396,20 +396,6 @@ Misc
      - | *t0* = *t1*
        | Move *t1* to *t0* (both operands must have the same type).
 
-   * - ext8s_i32/i64 *t0*, *t1*
-
-       ext8u_i32/i64 *t0*, *t1*
-
-       ext16s_i32/i64 *t0*, *t1*
-
-       ext16u_i32/i64 *t0*, *t1*
-
-       ext32s_i64 *t0*, *t1*
-
-       ext32u_i64 *t0*, *t1*
-
-     - | 8, 16 or 32 bit sign/zero extension (both operands must have the same type)
-
    * - bswap16_i32/i64 *t0*, *t1*, *flags*
 
      - | 16 bit byte swap on the low bits of a 32/64 bit input.
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 4645242d85..b8b26c1c93 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2493,17 +2493,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2979,16 +2969,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index cec3d761d4..0e48f790f9 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2113,10 +2113,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16u_i32:
     default:
         g_assert_not_reached();
     }
@@ -2138,9 +2134,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16u_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
         return C_O1_I1(r, r);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 33d303a123..02024018cb 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3016,17 +3016,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -3663,18 +3653,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
 
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-        return C_O1_I1(r, q);
-
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index cbd7642b58..c15314e1c8 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1695,17 +1695,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2237,16 +2227,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_brcond_i64:
         return C_O0_I2(rz, rz);
 
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index f8c105ba37..f77159bdc7 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -647,7 +647,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
-    tcg_debug_assert(TCG_TARGET_HAS_ext8s_i32);
+    tcg_debug_assert(use_mips32r2_instructions);
     tcg_out_opc_reg(s, OPC_SEB, rd, TCG_REG_ZERO, rs);
 }
 
@@ -658,7 +658,7 @@ static void tcg_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
 
 static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
-    tcg_debug_assert(TCG_TARGET_HAS_ext16s_i32);
+    tcg_debug_assert(use_mips32r2_instructions);
     tcg_out_opc_reg(s, OPC_SEH, rd, TCG_REG_ZERO, rs);
 }
 
@@ -2106,15 +2106,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2138,8 +2130,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext16s_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
@@ -2154,10 +2144,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 822925a19b..e10c1c5162 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3473,17 +3473,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -4109,8 +4099,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ctpop_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext16s_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
@@ -4125,9 +4113,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ctpop_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_not_i64:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext32s_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index f7e1ca5a56..d525df4e1d 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2385,17 +2385,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2643,17 +2633,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_not_i64:
     case INDEX_op_neg_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext32s_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index b2e1cd60ff..8421320928 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2781,17 +2781,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -3340,16 +3330,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 7c722f59a8..787e0d896c 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1517,17 +1517,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     default:
         g_assert_not_reached();
@@ -1557,8 +1547,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i64:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 36e018dd19..6f8f1dd8ae 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -59,16 +59,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_not_i64:
     case INDEX_op_neg_i32:
     case INDEX_op_neg_i64:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
@@ -535,76 +525,54 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     }
 }
 
+static void tcg_out_extract(TCGContext *s, TCGType type, TCGReg rd,
+                            TCGReg rs, unsigned pos, unsigned len)
+{
+    TCGOpcode opc = type == TCG_TYPE_I32 ?
+                    INDEX_op_extract_i32 :
+                    INDEX_op_extract_i64;
+    tcg_out_op_rrbb(s, opc, rd, rs, pos, len);
+}
+
+static void tcg_out_sextract(TCGContext *s, TCGType type, TCGReg rd,
+                             TCGReg rs, unsigned pos, unsigned len)
+{
+    TCGOpcode opc = type == TCG_TYPE_I32 ?
+                    INDEX_op_sextract_i32 :
+                    INDEX_op_sextract_i64;
+    tcg_out_op_rrbb(s, opc, rd, rs, pos, len);
+}
+
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
-    switch (type) {
-    case TCG_TYPE_I32:
-        tcg_debug_assert(TCG_TARGET_HAS_ext8s_i32);
-        tcg_out_op_rr(s, INDEX_op_ext8s_i32, rd, rs);
-        break;
-#if TCG_TARGET_REG_BITS == 64
-    case TCG_TYPE_I64:
-        tcg_debug_assert(TCG_TARGET_HAS_ext8s_i64);
-        tcg_out_op_rr(s, INDEX_op_ext8s_i64, rd, rs);
-        break;
-#endif
-    default:
-        g_assert_not_reached();
-    }
+    tcg_out_sextract(s, type, rd, rs, 0, 8);
 }
 
 static void tcg_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_debug_assert(TCG_TARGET_HAS_ext8u_i64);
-        tcg_out_op_rr(s, INDEX_op_ext8u_i64, rd, rs);
-    } else {
-        tcg_debug_assert(TCG_TARGET_HAS_ext8u_i32);
-        tcg_out_op_rr(s, INDEX_op_ext8u_i32, rd, rs);
-    }
+    tcg_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 8);
 }
 
 static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
-    switch (type) {
-    case TCG_TYPE_I32:
-        tcg_debug_assert(TCG_TARGET_HAS_ext16s_i32);
-        tcg_out_op_rr(s, INDEX_op_ext16s_i32, rd, rs);
-        break;
-#if TCG_TARGET_REG_BITS == 64
-    case TCG_TYPE_I64:
-        tcg_debug_assert(TCG_TARGET_HAS_ext16s_i64);
-        tcg_out_op_rr(s, INDEX_op_ext16s_i64, rd, rs);
-        break;
-#endif
-    default:
-        g_assert_not_reached();
-    }
+    tcg_out_sextract(s, type, rd, rs, 0, 16);
 }
 
 static void tcg_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_debug_assert(TCG_TARGET_HAS_ext16u_i64);
-        tcg_out_op_rr(s, INDEX_op_ext16u_i64, rd, rs);
-    } else {
-        tcg_debug_assert(TCG_TARGET_HAS_ext16u_i32);
-        tcg_out_op_rr(s, INDEX_op_ext16u_i32, rd, rs);
-    }
+    tcg_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 16);
 }
 
 static void tcg_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-    tcg_debug_assert(TCG_TARGET_HAS_ext32s_i64);
-    tcg_out_op_rr(s, INDEX_op_ext32s_i64, rd, rs);
+    tcg_out_sextract(s, TCG_TYPE_I64, rd, rs, 0, 32);
 }
 
 static void tcg_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-    tcg_debug_assert(TCG_TARGET_HAS_ext32u_i64);
-    tcg_out_op_rr(s, INDEX_op_ext32u_i64, rd, rs);
+    tcg_out_extract(s, TCG_TYPE_I64, rd, rs, 0, 32);
 }
 
 static void tcg_out_exts_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
@@ -690,7 +658,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGOpcode exts;
+    int width;
 
     switch (opc) {
     case INDEX_op_goto_ptr:
@@ -777,18 +745,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_bswap16_i32: /* Optional (TCG_TARGET_HAS_bswap16_i32). */
-        exts = INDEX_op_ext16s_i32;
-        goto do_bswap;
     case INDEX_op_bswap16_i64: /* Optional (TCG_TARGET_HAS_bswap16_i64). */
-        exts = INDEX_op_ext16s_i64;
+        width = 16;
         goto do_bswap;
     case INDEX_op_bswap32_i64: /* Optional (TCG_TARGET_HAS_bswap32_i64). */
-        exts = INDEX_op_ext32s_i64;
+        width = 32;
     do_bswap:
         /* The base tci bswaps zero-extend, and ignore high bits. */
         tcg_out_op_rr(s, opc, args[0], args[1]);
         if (args[2] & TCG_BSWAP_OS) {
-            tcg_out_op_rr(s, exts, args[0], args[0]);
+            tcg_out_sextract(s, TCG_TYPE_REG, args[0], args[0], 0, width);
         }
         break;
 
@@ -838,17 +804,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
-- 
2.43.0


