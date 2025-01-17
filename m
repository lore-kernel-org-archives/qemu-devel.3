Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C72FC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr69-0007sZ-LJ; Fri, 17 Jan 2025 13:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5s-0006m0-5z
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:20 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5k-0000Jm-B2
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:19 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ee46851b5eso3432125a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138551; x=1737743351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVPleuy3Xsse7THT0N581o16Rcnrx3xvtx6X2aKOq/I=;
 b=z4mq+VYGdKuQcbfEe2m27gRMZO3HO2hBHEshozy20tzFzMPeER9AGWbLle6t+fgQvw
 e7gfS0HY/G4sXQ1k4rcojlOoKtuRP/hS+VuBfQLZYBnFO7zq5N6MMp5pWVSuMxLEiQqf
 uyh4KFIr5hUiBH2hnY2MZ7EJdyMMJ8V3P8RVtVDWecPs9q55GVrCwwv44a/rV7+PNRp2
 8TJd/EAybCBahCPEthajLW11t/a7VugRa+DSz1oyOfMdKLM61HQ82eoyxpGsVWX1E3nG
 FV62ZcwdyKBNrIZSxH0lMv8bbyFrv8XxLi4cUbJSIu6jVt6uADk3uKTCkUSB+PkQa3//
 YIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138551; x=1737743351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVPleuy3Xsse7THT0N581o16Rcnrx3xvtx6X2aKOq/I=;
 b=ajn8gWny7auw62K86y0Ni4ghpSM2DhDkg8bWFh1+LRg5IyvOudNrqC4IkoIfVa5ToH
 HvyMdnXcTQmOwyTO2j5fTAfLjU+mxaUhSuDHEiiM/SbmNWOECzVrjsmNzjt0aij90WZb
 VwrRk53YUeSsp+Qtv1ZIxUCKcXHzYsG3soOeWSehZmxOW6ZhSXozRMkK3snc1UwaHPyx
 Mqpg9gTrmzoQegoC1IM34uxLoLS//MtymRBMvkBhzr1ZilXxZm9Qd0gYhckMY1tmPU0/
 jWnVC0rWfAFuvwxXVaLje/IgZHD4YebkzZ9hU8y1VIUdYjkspHodF7QhWrKKp/v+bD75
 yqtg==
X-Gm-Message-State: AOJu0YwL1NKK2dk3Y71DtDZCvOwCnAScAWyrCG9MvOjncKo1W2GGQ3PP
 hwA9GChQwLnCdpW89YhPDaFabN2u8tHctYoW6ompnvZWvsjxn2LyOgS2xn7R5G8PbPrUp2JEVC7
 6
X-Gm-Gg: ASbGncsJA6Bun4LCcj1LhE0KbG7F8XFtIzE1/RMkYlbmggesAPovqqxZGprKVvSKOq1
 EHMcRCTayLt8pQbXQasjp1nPs4jtcgdQF1ruZjpynvHe8hrZxb/7dbXSVnWKA9JsZ7LrwamXqdC
 +c4hqzmHiojjOF6puHVy/XenezNYVVnxOLJBFPFhilvs/oIg2z6nsZklITsTSFyoU+WF/10KU4F
 /JlZB5+H537Ve3DKHisN1gOkg88ID5oAZFah1kfXMlM7kbE404RBjQv8v/CZDFaoKIVFp/a/6KT
 CdFjqaZKbNU66Ag=
X-Google-Smtp-Source: AGHT+IH+8vmr1RS5Z/NQzMhK764jNSsXYw+fway1gwv87Mzx56x1qYG4IVOnapmnGJ0Ar5C19HEiSA==
X-Received: by 2002:a17:90b:2b87:b0:2ee:a127:ba96 with SMTP id
 98e67ed59e1d1-2f782d36030mr4315540a91.23.1737138550680; 
 Fri, 17 Jan 2025 10:29:10 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 62/68] tcg: Remove TCG_TARGET_HAS_deposit_{i32,i64}
Date: Fri, 17 Jan 2025 10:24:50 -0800
Message-ID: <20250117182456.2077110-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Make deposit "unconditional" in the sense that the opcode is
always present.  Rely instead on TCG_TARGET_deposit_valid,
now always defined.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h     |  3 +--
 tcg/arm/tcg-target-has.h         |  2 +-
 tcg/i386/tcg-target-has.h        |  5 +----
 tcg/loongarch64/tcg-target-has.h |  3 +--
 tcg/mips/tcg-target-has.h        |  3 +--
 tcg/ppc/tcg-target-has.h         |  3 +--
 tcg/riscv/tcg-target-has.h       |  4 ++--
 tcg/s390x/tcg-target-has.h       |  3 +--
 tcg/sparc64/tcg-target-has.h     |  4 ++--
 tcg/tcg-has.h                    |  8 --------
 tcg/tci/tcg-target-has.h         |  3 +--
 tcg/tcg-op.c                     | 22 +++++++++++-----------
 tcg/tcg.c                        | 31 +++++++++++--------------------
 tcg/tci.c                        |  4 ----
 tcg/tci/tcg-target.c.inc         |  2 +-
 15 files changed, 35 insertions(+), 65 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 43eaa2287c..39f01c14cd 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -31,7 +31,6 @@
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
-#define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
@@ -64,7 +63,6 @@
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
-#define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
@@ -114,5 +112,6 @@
 
 #define TCG_TARGET_extract_valid(type, ofs, len)   1
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
+#define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
 #endif
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 7152dd6f5e..e3510a8f7a 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -40,7 +40,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
 #define TCG_TARGET_HAS_ctpop_i32        0
-#define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        1
@@ -96,5 +95,6 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
 
 #define TCG_TARGET_extract_valid   tcg_target_extract_valid
 #define TCG_TARGET_sextract_valid  tcg_target_extract_valid
+#define TCG_TARGET_deposit_valid(type, ofs, len)  use_armv7_instructions
 
 #endif
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 833ccc411a..63768ff058 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -43,7 +43,6 @@
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        have_popcnt
-#define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
@@ -76,7 +75,6 @@
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        have_popcnt
-#define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
@@ -121,10 +119,9 @@
 #define TCG_TARGET_HAS_cmpsel_vec       1
 #define TCG_TARGET_HAS_tst_vec          have_avx512bw
 
-#define TCG_TARGET_deposit_i32_valid(ofs, len) \
+#define TCG_TARGET_deposit_valid(type, ofs, len) \
     (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
      (TCG_TARGET_REG_BITS == 32 && (ofs) == 8 && (len) == 8))
-#define TCG_TARGET_deposit_i64_valid    TCG_TARGET_deposit_i32_valid
 
 /*
  * Check for the possibility of low byte/word extraction, high-byte extraction
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index a15ab9cc28..ac88522eef 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -15,7 +15,6 @@
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_div2_i32         0
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
@@ -48,7 +47,6 @@
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
@@ -106,6 +104,7 @@
 #define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
 static inline bool
 tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 1bc14f65dd..df6960fe9a 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -79,7 +79,6 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions detected at runtime */
-#define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
@@ -93,7 +92,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
@@ -116,6 +114,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_tst              0
 
 #define TCG_TARGET_extract_valid(type, ofs, len)  use_mips32r2_instructions
+#define TCG_TARGET_deposit_valid(type, ofs, len)  use_mips32r2_instructions
 
 static inline bool
 tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index fa9275264c..6db91f78ce 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -37,7 +37,6 @@
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
-#define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        0
@@ -71,7 +70,6 @@
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
-#define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
@@ -118,6 +116,7 @@
 #define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
 static inline bool
 tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 5a39720ea9..0f9cc04f8c 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -15,7 +15,6 @@
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_div2_i32         0
 #define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_deposit_i32      0
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -47,7 +46,6 @@
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
@@ -126,4 +124,6 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
+#define TCG_TARGET_deposit_valid(type, ofs, len)  0
+
 #endif
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index f3965c7df5..e99e671642 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -46,7 +46,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_clz_i32        0
 #define TCG_TARGET_HAS_ctz_i32        0
 #define TCG_TARGET_HAS_ctpop_i32      1
-#define TCG_TARGET_HAS_deposit_i32    1
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_negsetcond_i32 1
 #define TCG_TARGET_HAS_add2_i32       1
@@ -78,7 +77,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_clz_i64        1
 #define TCG_TARGET_HAS_ctz_i64        0
 #define TCG_TARGET_HAS_ctpop_i64      1
-#define TCG_TARGET_HAS_deposit_i64    1
 #define TCG_TARGET_HAS_extract2_i64   0
 #define TCG_TARGET_HAS_negsetcond_i64 1
 #define TCG_TARGET_HAS_add2_i64       1
@@ -118,6 +116,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_tst_vec        0
 
 #define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
 static inline bool
 tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 4a621313b7..2f46df8c61 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -32,7 +32,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_clz_i32          0
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
-#define TCG_TARGET_HAS_deposit_i32      0
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
@@ -65,7 +64,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
-#define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
@@ -84,4 +82,6 @@ extern bool use_vis3_instructions;
 
 #define TCG_TARGET_sextract_valid  TCG_TARGET_extract_valid
 
+#define TCG_TARGET_deposit_valid(type, ofs, len) 0
+
 #endif
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index c93a98fb86..418e4673eb 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -34,7 +34,6 @@
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
-#define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_add2_i64         0
@@ -48,13 +47,6 @@
 #define TCG_TARGET_HAS_sub2_i32         1
 #endif
 
-#ifndef TCG_TARGET_deposit_i32_valid
-#define TCG_TARGET_deposit_i32_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_deposit_i64_valid
-#define TCG_TARGET_deposit_i64_valid(ofs, len) 1
-#endif
-
 /* Only one of DIV or DIV2 should be defined.  */
 #if defined(TCG_TARGET_HAS_div_i32)
 #define TCG_TARGET_HAS_div2_i32         0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 7a176b1fe5..c8785ca8dc 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -16,7 +16,6 @@
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_eqv_i32          1
 #define TCG_TARGET_HAS_nand_i32         1
@@ -38,7 +37,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
@@ -78,5 +76,6 @@
 
 #define TCG_TARGET_extract_valid(type, ofs, len)   1
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
+#define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
 #endif
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d813a7f44e..fec6d678a2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -906,7 +906,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
         tcg_gen_mov_i32(ret, arg2);
         return;
     }
-    if (TCG_TARGET_HAS_deposit_i32 && TCG_TARGET_deposit_i32_valid(ofs, len)) {
+    if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
         tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, arg1, arg2, ofs, len);
         return;
     }
@@ -951,8 +951,7 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_shli_i32(ret, arg, ofs);
     } else if (ofs == 0) {
         tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
-    } else if (TCG_TARGET_HAS_deposit_i32
-               && TCG_TARGET_deposit_i32_valid(ofs, len)) {
+    } else if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, zero, arg, ofs, len);
     } else {
@@ -2642,12 +2641,13 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
         tcg_gen_mov_i64(ret, arg2);
         return;
     }
-    if (TCG_TARGET_HAS_deposit_i64 && TCG_TARGET_deposit_i64_valid(ofs, len)) {
-        tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, arg1, arg2, ofs, len);
-        return;
-    }
 
-    if (TCG_TARGET_REG_BITS == 32) {
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
+            tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, arg1, arg2, ofs, len);
+            return;
+        }
+    } else {
         if (ofs >= 32) {
             tcg_gen_deposit_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1),
                                 TCGV_LOW(arg2), ofs - 32, len);
@@ -2702,8 +2702,8 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_shli_i64(ret, arg, ofs);
     } else if (ofs == 0) {
         tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-    } else if (TCG_TARGET_HAS_deposit_i64
-               && TCG_TARGET_deposit_i64_valid(ofs, len)) {
+    } else if (TCG_TARGET_REG_BITS == 64 &&
+               TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
         TCGv_i64 zero = tcg_constant_i64(0);
         tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, zero, arg, ofs, len);
     } else {
@@ -3226,7 +3226,7 @@ void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high)
     tcg_gen_extu_i32_i64(dest, low);
     /* If deposit is available, use it.  Otherwise use the extra
        knowledge that we have of the zero-extensions above.  */
-    if (TCG_TARGET_HAS_deposit_i64 && TCG_TARGET_deposit_i64_valid(32, 32)) {
+    if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, 32, 32)) {
         tcg_gen_deposit_i64(dest, dest, tmp, 32, 32);
     } else {
         tcg_gen_shli_i64(tmp, tmp, 32);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c584ca034f..43b6712286 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2197,6 +2197,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sar_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
+    case INDEX_op_deposit_i32:
         return true;
 
     case INDEX_op_negsetcond_i32:
@@ -2213,8 +2214,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
         return TCG_TARGET_HAS_rot_i32;
-    case INDEX_op_deposit_i32:
-        return TCG_TARGET_HAS_deposit_i32;
     case INDEX_op_extract2_i32:
         return TCG_TARGET_HAS_extract2_i32;
     case INDEX_op_add2_i32:
@@ -2293,6 +2292,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i64:
+    case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
     case INDEX_op_negsetcond_i64:
@@ -2309,8 +2309,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
         return TCG_TARGET_HAS_rot_i64;
-    case INDEX_op_deposit_i64:
-        return TCG_TARGET_HAS_deposit_i64;
     case INDEX_op_extract2_i64:
         return TCG_TARGET_HAS_extract2_i64;
     case INDEX_op_extrl_i64_i32:
@@ -2439,23 +2437,16 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 
 bool tcg_op_deposit_valid(TCGType type, unsigned ofs, unsigned len)
 {
+    unsigned width;
+
+    tcg_debug_assert(type == TCG_TYPE_I32 || type == TCG_TYPE_I64);
+    width = (type == TCG_TYPE_I32 ? 32 : 64);
+
+    tcg_debug_assert(ofs < width);
     tcg_debug_assert(len > 0);
-    switch (type) {
-    case TCG_TYPE_I32:
-        tcg_debug_assert(ofs < 32);
-        tcg_debug_assert(len <= 32);
-        tcg_debug_assert(ofs + len <= 32);
-        return TCG_TARGET_HAS_deposit_i32 &&
-               TCG_TARGET_deposit_i32_valid(ofs, len);
-    case TCG_TYPE_I64:
-        tcg_debug_assert(ofs < 64);
-        tcg_debug_assert(len <= 64);
-        tcg_debug_assert(ofs + len <= 64);
-        return TCG_TARGET_HAS_deposit_i64 &&
-               TCG_TARGET_deposit_i64_valid(ofs, len);
-    default:
-        g_assert_not_reached();
-    }
+    tcg_debug_assert(len <= width - ofs);
+
+    return TCG_TARGET_deposit_valid(type, ofs, len);
 }
 
 static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs);
diff --git a/tcg/tci.c b/tcg/tci.c
index 30d912d75d..8c1c53424d 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -651,12 +651,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = ror32(regs[r1], regs[r2] & 31);
             break;
 #endif
-#if TCG_TARGET_HAS_deposit_i32
         case INDEX_op_deposit_i32:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit32(regs[r1], pos, len, regs[r2]);
             break;
-#endif
         case INDEX_op_extract_i32:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = extract32(regs[r1], pos, len);
@@ -858,12 +856,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = ror64(regs[r1], regs[r2] & 63);
             break;
 #endif
-#if TCG_TARGET_HAS_deposit_i64
         case INDEX_op_deposit_i64:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
             break;
-#endif
         case INDEX_op_extract_i64:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = extract64(regs[r1], pos, len);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 8dedddce5f..d6c77325a3 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -774,7 +774,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rrr(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(deposit)  /* Optional (TCG_TARGET_HAS_deposit_*). */
+    CASE_32_64(deposit)
         tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], args[3], args[4]);
         break;
 
-- 
2.43.0


