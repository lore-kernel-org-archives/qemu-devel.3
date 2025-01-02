Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4295BE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbf-000791-HP; Thu, 02 Jan 2025 13:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbM-00070c-8z
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:23 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbH-00059p-Ef
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:20 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21631789fcdso118435705ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841233; x=1736446033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yWL9sRuqNBq/l/7isu6+GfK/YTzjO+m/NEpz5mcQAL0=;
 b=MaZqxKIjVpI08RQoWcdKKBIkb2qYPYTWbpenoqJBdQoENcoLE+sNMd3q4Zsa3nKr9N
 dGkL7WbtHQa+4Cf6VQzv/J/WLcXMyM4t774dFiJFGFsl74VhR2IASw77PHvIFomS01Ha
 vblwVyaQ3bpkp+a3FcQM4MezAoosu1iCFYF0LkPRd/Mv3OEcNrV0FwkYE0tQYLowBYRo
 dJ4HRs++Z4BTNwPreb2KMIQYylHfOvC81Nhr6GxYe2gVWmsVHBID7dcH22xjVInWCt/v
 UnbbA0nVBj8RL+jXHphElRKoZsaP+XpdGnTFBxOdHKApZFQW+d/29/mp/vV89yttrKYy
 Jh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841233; x=1736446033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWL9sRuqNBq/l/7isu6+GfK/YTzjO+m/NEpz5mcQAL0=;
 b=JzDUfkNlwc0/bfZDDSyuWnynChgjLFyu7xtGgytLmwWRPUAsb6llft1gcg2XpBeIEF
 3yKJvTw6RTrThBb49trkUZE49pr+NvKDlBwDyMoEAaBiyGUjFqQbMPAONZlPQ1IsrTj+
 /QJYg5o1b+ID3gzp2vE0Txaoy/Q8c3+nD+EezT19xA2Qjn00kVSfPVirY3QvyOn1UyT4
 t5v18XnlmJGyQSa8skVKMbr8HtMeBhjcIBzN2szlc7LTGyH0ZTrQCHL5Yzbj1mwN/TEK
 lcmpL5lUDvoumS6sRyHG7umxs06Y9xbo3m3RdMOEsQc2Epps6sSaCvzSfzCpomr+sb/F
 F19A==
X-Gm-Message-State: AOJu0YxEcbtG9wvsSXQPVisZAS1doya6uJIKcSjKvwpXwaZ7ltwiKROL
 dzxsNM88zafURNF89Ftj/9IDe6+A6JCvAzO6pAuTnouslh75kpSEP+jQZQ00/I++tKCBkTUioLz
 L
X-Gm-Gg: ASbGncv0AhlI4RgbPT1gm0nZrFEQ2LwpGzsZ+q5iFw+6KPIT2VLXl/bARZy2NCFsDIn
 dN99aP48exBh+LRS49ZcKpJ9RGKDWjFvTnMbc7QJ1G0dspbFUx3OrdLSc5w/f7W6XC5G37FYgNK
 e0Zilr3ePYjq5E9GggaSmbjO6e3xbADn29tzkJq+nUIonNucSY2ZT7pSc7Rs3oXDgNadlf1l+XE
 wy5wFLRtjiIhE/pvGg3zGrl/mL0OxxVFHpY2ZZsfnegq+9Ybzwq+DJHZM331Q==
X-Google-Smtp-Source: AGHT+IH4KBhzKOkwsy8JIum/ZcnvY0TrhebPqMsK6ehOjnHthqfA+8PvrlfsDcDjEBhwmdtbnoedkA==
X-Received: by 2002:a05:6a21:32a8:b0:1e0:d5be:bf75 with SMTP id
 adf61e73a8af0-1e5e1f56862mr51063395637.17.1735841232701; 
 Thu, 02 Jan 2025 10:07:12 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/73] tcg: Merge TCG_TARGET_HAS_{andc,orc,nand,nor,eqv,not}
Date: Thu,  2 Jan 2025 10:06:02 -0800
Message-ID: <20250102180654.1420056-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 include/tcg/tcg-opc.h            | 36 ++++++++++++++++----------------
 tcg/aarch64/tcg-target-has.h     | 26 +++++++----------------
 tcg/arm/tcg-target-has.h         | 20 +++++++-----------
 tcg/i386/tcg-target-has.h        | 26 +++++++----------------
 tcg/loongarch64/tcg-target-has.h | 26 +++++++----------------
 tcg/mips/tcg-target-has.h        | 20 +++++++-----------
 tcg/ppc/tcg-target-has.h         | 26 +++++++----------------
 tcg/riscv/tcg-target-has.h       | 26 +++++++----------------
 tcg/s390x/tcg-target-has.h       | 26 +++++++----------------
 tcg/sparc64/tcg-target-has.h     | 20 +++++++-----------
 tcg/tcg-has.h                    | 12 -----------
 tcg/tci/tcg-target-has.h         | 20 +++++++-----------
 tcg/optimize.c                   | 12 +++++------
 tcg/tcg-op-vec.c                 | 30 ++++++++++++++++++++------
 tcg/tcg-op.c                     | 28 ++++++++++++-------------
 tcg/tcg.c                        | 36 ++++++++++++++++----------------
 tcg/tci.c                        | 12 -----------
 tcg/s390x/tcg-target.c.inc       |  2 +-
 18 files changed, 161 insertions(+), 243 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index ac110efb74..f1330e5828 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -99,13 +99,13 @@ DEF(ext8u_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext8u_i32))
 DEF(ext16u_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext16u_i32))
 DEF(bswap16_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap16_i32))
 DEF(bswap32_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap32_i32))
-DEF(not_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_not_i32))
+DEF(not_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_not(TCG_TYPE_I32)))
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(andc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_andc_i32))
-DEF(orc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_orc_i32))
-DEF(eqv_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_eqv_i32))
-DEF(nand_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nand_i32))
-DEF(nor_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nor_i32))
+DEF(andc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_andc(TCG_TYPE_I32)))
+DEF(orc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_orc(TCG_TYPE_I32)))
+DEF(eqv_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_eqv(TCG_TYPE_I32)))
+DEF(nand_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nand(TCG_TYPE_I32)))
+DEF(nor_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nor(TCG_TYPE_I32)))
 DEF(clz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_clz_i32))
 DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz_i32))
 DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop_i32))
@@ -170,13 +170,13 @@ DEF(ext32u_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext32u_i64))
 DEF(bswap16_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap16_i64))
 DEF(bswap32_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap32_i64))
 DEF(bswap64_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap64_i64))
-DEF(not_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_not_i64))
+DEF(not_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_not(TCG_TYPE_I64)))
 DEF(neg_i64, 1, 1, 0, IMPL64)
-DEF(andc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_andc_i64))
-DEF(orc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_orc_i64))
-DEF(eqv_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_eqv_i64))
-DEF(nand_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nand_i64))
-DEF(nor_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nor_i64))
+DEF(andc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_andc(TCG_TYPE_I64)))
+DEF(orc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_orc(TCG_TYPE_I64)))
+DEF(eqv_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_eqv(TCG_TYPE_I64)))
+DEF(nand_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nand(TCG_TYPE_I64)))
+DEF(nor_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nor(TCG_TYPE_I64)))
 DEF(clz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_clz_i64))
 DEF(ctz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctz_i64))
 DEF(ctpop_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctpop_i64))
@@ -271,12 +271,12 @@ DEF(umax_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_minmax_vec))
 DEF(and_vec, 1, 2, 0, IMPLVEC)
 DEF(or_vec, 1, 2, 0, IMPLVEC)
 DEF(xor_vec, 1, 2, 0, IMPLVEC)
-DEF(andc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_andc_vec))
-DEF(orc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_orc_vec))
-DEF(nand_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_nand_vec))
-DEF(nor_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_nor_vec))
-DEF(eqv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_eqv_vec))
-DEF(not_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_not_vec))
+DEF(andc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_andc(TCG_TYPE_V64)))
+DEF(orc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_orc(TCG_TYPE_V64)))
+DEF(nand_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_nand(TCG_TYPE_V64)))
+DEF(nor_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_nor(TCG_TYPE_V64)))
+DEF(eqv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_eqv(TCG_TYPE_V64)))
+DEF(not_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_not(TCG_TYPE_V64)))
 
 DEF(shli_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
 DEF(shri_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 856cb4020b..e25c08d2ee 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -16,19 +16,21 @@
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 
+/* optional integer and vector instructions */
+#define TCG_TARGET_HAS_andc(T)          1
+#define TCG_TARGET_HAS_eqv(T)           (T <= TCG_TYPE_REG)
+#define TCG_TARGET_HAS_nand(T)          0
+#define TCG_TARGET_HAS_nor(T)           0
+#define TCG_TARGET_HAS_not(T)           1
+#define TCG_TARGET_HAS_orc(T)           1
+
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_orc_i32          1
-#define TCG_TARGET_HAS_eqv_i32          1
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -55,13 +57,7 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_andc_i64         1
-#define TCG_TARGET_HAS_orc_i64          1
-#define TCG_TARGET_HAS_eqv_i64          1
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
@@ -94,12 +90,6 @@
 #define TCG_TARGET_HAS_v128             1
 #define TCG_TARGET_HAS_v256             0
 
-#define TCG_TARGET_HAS_andc_vec         1
-#define TCG_TARGET_HAS_orc_vec          1
-#define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          0
-#define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 392fc6d704..4e76720fc1 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -27,19 +27,21 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_div(T)           use_idiv_instructions
 #define TCG_TARGET_HAS_rem(T)           0
 
+/* optional integer and vector instructions */
+#define TCG_TARGET_HAS_andc(T)          1
+#define TCG_TARGET_HAS_eqv(T)           0
+#define TCG_TARGET_HAS_nand(T)          0
+#define TCG_TARGET_HAS_nor(T)           0
+#define TCG_TARGET_HAS_not(T)           1
+#define TCG_TARGET_HAS_orc(T)           (T >= TCG_TYPE_V64)
+
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        0 /* and r0, r1, #0xff */
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_orc_i32          0
-#define TCG_TARGET_HAS_eqv_i32          0
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -62,12 +64,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_v128             use_neon_instructions
 #define TCG_TARGET_HAS_v256             0
 
-#define TCG_TARGET_HAS_andc_vec         1
-#define TCG_TARGET_HAS_orc_vec          1
-#define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          0
-#define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index f60ffbe984..bdd2a6d65a 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -28,6 +28,14 @@
 /* optional integer instructions */
 #define TCG_TARGET_HAS_div2(T)          1
 
+/* optional integer and vector instructions */
+#define TCG_TARGET_HAS_andc(T)          (T >= TCG_TYPE_V64 || have_bmi1)
+#define TCG_TARGET_HAS_eqv(T)           (T >= TCG_TYPE_V64 && have_avx512vl)
+#define TCG_TARGET_HAS_nand(T)          (T >= TCG_TYPE_V64 && have_avx512vl)
+#define TCG_TARGET_HAS_nor(T)           (T >= TCG_TYPE_V64 && have_avx512vl)
+#define TCG_TARGET_HAS_not(T)           (T <= TCG_TYPE_REG || have_avx512vl)
+#define TCG_TARGET_HAS_orc(T)           (T >= TCG_TYPE_V64 && have_avx512vl)
+
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
@@ -35,12 +43,6 @@
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         have_bmi1
-#define TCG_TARGET_HAS_orc_i32          0
-#define TCG_TARGET_HAS_eqv_i32          0
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        have_popcnt
@@ -69,12 +71,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         have_bmi1
-#define TCG_TARGET_HAS_orc_i64          0
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        have_popcnt
@@ -104,12 +100,6 @@
 #define TCG_TARGET_HAS_v128             have_avx1
 #define TCG_TARGET_HAS_v256             have_avx2
 
-#define TCG_TARGET_HAS_andc_vec         1
-#define TCG_TARGET_HAS_orc_vec          have_avx512vl
-#define TCG_TARGET_HAS_nand_vec         have_avx512vl
-#define TCG_TARGET_HAS_nor_vec          have_avx512vl
-#define TCG_TARGET_HAS_eqv_vec          have_avx512vl
-#define TCG_TARGET_HAS_not_vec          have_avx512vl
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_roti_vec         have_avx512vl
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 5eedfc1926..581d96dbfc 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -13,6 +13,14 @@
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 
+/* optional integer and vector instructions */
+#define TCG_TARGET_HAS_andc(T)          1
+#define TCG_TARGET_HAS_eqv(T)           0
+#define TCG_TARGET_HAS_nand(T)          0
+#define TCG_TARGET_HAS_nor(T)           1
+#define TCG_TARGET_HAS_not(T)           1
+#define TCG_TARGET_HAS_orc(T)           1
+
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_deposit_i32      1
@@ -31,12 +39,6 @@
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_orc_i32          1
-#define TCG_TARGET_HAS_eqv_i32          0
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -61,12 +63,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         1
-#define TCG_TARGET_HAS_orc_i64          1
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
@@ -85,14 +81,8 @@
 #define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
 #define TCG_TARGET_HAS_v256             (cpuinfo & CPUINFO_LASX)
 
-#define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          0
-#define TCG_TARGET_HAS_andc_vec         1
-#define TCG_TARGET_HAS_orc_vec          1
-#define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          1
-#define TCG_TARGET_HAS_eqv_vec          0
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 37a68dace8..a934f86e30 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -42,12 +42,14 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_nor_i32          1
-#define TCG_TARGET_HAS_andc_i32         0
-#define TCG_TARGET_HAS_orc_i32          0
-#define TCG_TARGET_HAS_eqv_i32          0
-#define TCG_TARGET_HAS_nand_i32         0
+/* optional integer and vector instructions */
+#define TCG_TARGET_HAS_andc(T)          0
+#define TCG_TARGET_HAS_eqv(T)           0
+#define TCG_TARGET_HAS_nand(T)          0
+#define TCG_TARGET_HAS_nor(T)           1
+#define TCG_TARGET_HAS_not(T)           1
+#define TCG_TARGET_HAS_orc(T)           0
+
 #define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muluh_i32        1
@@ -59,12 +61,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_nor_i64          1
-#define TCG_TARGET_HAS_andc_i64         0
-#define TCG_TARGET_HAS_orc_i64          0
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 6734fd63e7..1f3ba6ed89 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -20,6 +20,14 @@
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 
+/* optional integer and vector instructions */
+#define TCG_TARGET_HAS_andc(T)          1
+#define TCG_TARGET_HAS_eqv(T)           (T <= TCG_TYPE_REG || have_isa_2_07)
+#define TCG_TARGET_HAS_nand(T)          (T <= TCG_TYPE_REG || have_isa_2_07)
+#define TCG_TARGET_HAS_nor(T)           1
+#define TCG_TARGET_HAS_not(T)           1
+#define TCG_TARGET_HAS_orc(T)           (T <= TCG_TYPE_REG || have_isa_2_07)
+
 /* optional instructions automatically implemented */
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
 #define TCG_TARGET_HAS_ext16u_i32       0
@@ -29,12 +37,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_orc_i32          1
-#define TCG_TARGET_HAS_eqv_i32          1
-#define TCG_TARGET_HAS_nand_i32         1
-#define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
@@ -63,12 +65,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         1
-#define TCG_TARGET_HAS_orc_i64          1
-#define TCG_TARGET_HAS_eqv_i64          1
-#define TCG_TARGET_HAS_nand_i64         1
-#define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
@@ -99,12 +95,6 @@
 #define TCG_TARGET_HAS_v128             have_altivec
 #define TCG_TARGET_HAS_v256             0
 
-#define TCG_TARGET_HAS_andc_vec         1
-#define TCG_TARGET_HAS_orc_vec          have_isa_2_07
-#define TCG_TARGET_HAS_nand_vec         have_isa_2_07
-#define TCG_TARGET_HAS_nor_vec          1
-#define TCG_TARGET_HAS_eqv_vec          have_isa_2_07
-#define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          have_isa_3_00
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 309673d74a..96380b5729 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -13,6 +13,14 @@
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 
+/* optional integer and vector instructions */
+#define TCG_TARGET_HAS_andc(T)          (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
+#define TCG_TARGET_HAS_eqv(T)           (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
+#define TCG_TARGET_HAS_nand(T)          0
+#define TCG_TARGET_HAS_nor(T)           0
+#define TCG_TARGET_HAS_not(T)           1
+#define TCG_TARGET_HAS_orc(T)           (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
+
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_deposit_i32      0
@@ -31,12 +39,6 @@
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_orc_i32          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_eqv_i32          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
@@ -60,12 +62,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_orc_i64          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_eqv_i64          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
@@ -84,12 +80,6 @@
 #define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_ZVE64X)
 #define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_ZVE64X)
 #define TCG_TARGET_HAS_v256             (cpuinfo & CPUINFO_ZVE64X)
-#define TCG_TARGET_HAS_andc_vec         0
-#define TCG_TARGET_HAS_orc_vec          0
-#define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          0
-#define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         1
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 3473b39991..8cb5da1a3d 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -31,6 +31,14 @@ extern uint64_t s390_facilities[3];
 /* optional integer instructions */
 #define TCG_TARGET_HAS_div2(T)        1
 
+/* optional integer and vector instructions */
+#define TCG_TARGET_HAS_andc(T)        (T >= TCG_TYPE_V64 || HAVE_FACILITY(MISC_INSN_EXT3))
+#define TCG_TARGET_HAS_eqv(T)         (T >= TCG_TYPE_V64 ? HAVE_FACILITY(VECTOR_ENH1) : HAVE_FACILITY(MISC_INSN_EXT3))
+#define TCG_TARGET_HAS_nand(T)        (T >= TCG_TYPE_V64 ? HAVE_FACILITY(VECTOR_ENH1) : HAVE_FACILITY(MISC_INSN_EXT3))
+#define TCG_TARGET_HAS_nor(T)         (T >= TCG_TYPE_V64 || HAVE_FACILITY(MISC_INSN_EXT3))
+#define TCG_TARGET_HAS_not(T)         (T >= TCG_TYPE_V64 || HAVE_FACILITY(MISC_INSN_EXT3))
+#define TCG_TARGET_HAS_orc(T)         (T >= TCG_TYPE_V64 ? HAVE_FACILITY(VECTOR_ENH1) : HAVE_FACILITY(MISC_INSN_EXT3))
+
 #define TCG_TARGET_HAS_rot_i32        1
 #define TCG_TARGET_HAS_ext8s_i32      1
 #define TCG_TARGET_HAS_ext16s_i32     1
@@ -38,12 +46,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext16u_i32     1
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
-#define TCG_TARGET_HAS_not_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_andc_i32       HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_orc_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_eqv_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_nand_i32       HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_nor_i32        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_clz_i32        0
 #define TCG_TARGET_HAS_ctz_i32        0
 #define TCG_TARGET_HAS_ctpop_i32      1
@@ -71,12 +73,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i64    1
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
-#define TCG_TARGET_HAS_not_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_andc_i64       HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_orc_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_eqv_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_nand_i64       HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_nor_i64        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_clz_i64        1
 #define TCG_TARGET_HAS_ctz_i64        0
 #define TCG_TARGET_HAS_ctpop_i64      1
@@ -100,12 +96,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_v128           HAVE_FACILITY(VECTOR)
 #define TCG_TARGET_HAS_v256           0
 
-#define TCG_TARGET_HAS_andc_vec       1
-#define TCG_TARGET_HAS_orc_vec        HAVE_FACILITY(VECTOR_ENH1)
-#define TCG_TARGET_HAS_nand_vec       HAVE_FACILITY(VECTOR_ENH1)
-#define TCG_TARGET_HAS_nor_vec        1
-#define TCG_TARGET_HAS_eqv_vec        HAVE_FACILITY(VECTOR_ENH1)
-#define TCG_TARGET_HAS_not_vec        1
 #define TCG_TARGET_HAS_neg_vec        1
 #define TCG_TARGET_HAS_abs_vec        1
 #define TCG_TARGET_HAS_roti_vec       1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 17db925241..a0dbfea13f 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -17,6 +17,14 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           0
 
+/* optional integer and vector instructions */
+#define TCG_TARGET_HAS_andc(T)          1
+#define TCG_TARGET_HAS_eqv(T)           0
+#define TCG_TARGET_HAS_nand(T)          0
+#define TCG_TARGET_HAS_nor(T)           0
+#define TCG_TARGET_HAS_not(T)           1
+#define TCG_TARGET_HAS_orc(T)           1
+
 #define TCG_TARGET_HAS_rot_i32          0
 #define TCG_TARGET_HAS_ext8s_i32        0
 #define TCG_TARGET_HAS_ext16s_i32       0
@@ -24,12 +32,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext16u_i32       0
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_orc_i32          1
-#define TCG_TARGET_HAS_eqv_i32          0
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          0
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -57,12 +59,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         1
-#define TCG_TARGET_HAS_orc_i64          1
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 649168b001..801aa5090c 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -22,12 +22,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_not_i64          0
-#define TCG_TARGET_HAS_andc_i64         0
-#define TCG_TARGET_HAS_orc_i64          0
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
@@ -74,12 +68,6 @@
 #define TCG_TARGET_MAYBE_vec            0
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_neg_vec          0
-#define TCG_TARGET_HAS_not_vec          0
-#define TCG_TARGET_HAS_andc_vec         0
-#define TCG_TARGET_HAS_orc_vec          0
-#define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          0
-#define TCG_TARGET_HAS_eqv_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 89f8288e4e..2642450b08 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -11,25 +11,27 @@
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 
+/* optional integer and vector instructions */
+#define TCG_TARGET_HAS_andc(T)          1
+#define TCG_TARGET_HAS_eqv(T)           1
+#define TCG_TARGET_HAS_nand(T)          1
+#define TCG_TARGET_HAS_nor(T)           1
+#define TCG_TARGET_HAS_not(T)           1
+#define TCG_TARGET_HAS_orc(T)           1
+
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_eqv_i32          1
-#define TCG_TARGET_HAS_nand_i32         1
-#define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_muls2_i32        1
@@ -52,15 +54,9 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_andc_i64         1
-#define TCG_TARGET_HAS_eqv_i64          1
-#define TCG_TARGET_HAS_nand_i64         1
-#define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        1
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_muls2_i64        1
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9c40916569..8e3141eb77 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1101,17 +1101,17 @@ static bool fold_to_not(OptContext *ctx, TCGOp *op, int idx)
     switch (ctx->type) {
     case TCG_TYPE_I32:
         not_op = INDEX_op_not_i32;
-        have_not = TCG_TARGET_HAS_not_i32;
+        have_not = TCG_TARGET_HAS_not(TCG_TYPE_I32);
         break;
     case TCG_TYPE_I64:
         not_op = INDEX_op_not_i64;
-        have_not = TCG_TARGET_HAS_not_i64;
+        have_not = TCG_TARGET_HAS_not(TCG_TYPE_I64);
         break;
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
         not_op = INDEX_op_not_vec;
-        have_not = TCG_TARGET_HAS_not_vec;
+        have_not = TCG_TARGET_HAS_not(ctx->type);
         break;
     default:
         g_assert_not_reached();
@@ -1378,7 +1378,7 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
             return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
         }
         if (tv == 0 && fv == -1) {
-            if (TCG_TARGET_HAS_not_vec) {
+            if (TCG_TARGET_HAS_not(op->type)) {
                 op->opc = INDEX_op_not_vec;
                 return fold_not(ctx, op);
             } else {
@@ -1395,7 +1395,7 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
             op->args[2] = op->args[3];
             return fold_or(ctx, op);
         }
-        if (tv == 0 && TCG_TARGET_HAS_andc_vec) {
+        if (tv == 0 && TCG_TARGET_HAS_andc(op->type)) {
             op->opc = INDEX_op_andc_vec;
             op->args[2] = op->args[1];
             op->args[1] = op->args[3];
@@ -1408,7 +1408,7 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
             op->opc = INDEX_op_and_vec;
             return fold_and(ctx, op);
         }
-        if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
+        if (fv == -1 && TCG_TARGET_HAS_orc(op->type)) {
             op->opc = INDEX_op_orc_vec;
             op->args[2] = op->args[1];
             op->args[1] = op->args[3];
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 118ed43dd6..26652bb88c 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -310,7 +310,10 @@ void tcg_gen_xor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 
 void tcg_gen_andc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    if (TCG_TARGET_HAS_andc_vec) {
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGType type __attribute__((unused)) = rt->base_type;
+
+    if (TCG_TARGET_HAS_andc(type)) {
         vec_gen_op3(INDEX_op_andc_vec, 0, r, a, b);
     } else {
         TCGv_vec t = tcg_temp_new_vec_matching(r);
@@ -322,7 +325,10 @@ void tcg_gen_andc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 
 void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    if (TCG_TARGET_HAS_orc_vec) {
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGType type __attribute__((unused)) = rt->base_type;
+
+    if (TCG_TARGET_HAS_orc(type)) {
         vec_gen_op3(INDEX_op_orc_vec, 0, r, a, b);
     } else {
         TCGv_vec t = tcg_temp_new_vec_matching(r);
@@ -334,7 +340,10 @@ void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 
 void tcg_gen_nand_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    if (TCG_TARGET_HAS_nand_vec) {
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGType type __attribute__((unused)) = rt->base_type;
+
+    if (TCG_TARGET_HAS_nand(type)) {
         vec_gen_op3(INDEX_op_nand_vec, 0, r, a, b);
     } else {
         tcg_gen_and_vec(0, r, a, b);
@@ -344,7 +353,10 @@ void tcg_gen_nand_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 
 void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    if (TCG_TARGET_HAS_nor_vec) {
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGType type __attribute__((unused)) = rt->base_type;
+
+    if (TCG_TARGET_HAS_nor(type)) {
         vec_gen_op3(INDEX_op_nor_vec, 0, r, a, b);
     } else {
         tcg_gen_or_vec(0, r, a, b);
@@ -354,7 +366,10 @@ void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 
 void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    if (TCG_TARGET_HAS_eqv_vec) {
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGType type __attribute__((unused)) = rt->base_type;
+
+    if (TCG_TARGET_HAS_eqv(type)) {
         vec_gen_op3(INDEX_op_eqv_vec, 0, r, a, b);
     } else {
         tcg_gen_xor_vec(0, r, a, b);
@@ -388,7 +403,10 @@ static bool do_op2(unsigned vece, TCGv_vec r, TCGv_vec a, TCGOpcode opc)
 
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 {
-    if (TCG_TARGET_HAS_not_vec) {
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGType type __attribute__((unused)) = rt->base_type;
+
+    if (TCG_TARGET_HAS_not(type)) {
         vec_gen_op2(INDEX_op_not_vec, 0, r, a);
     } else {
         tcg_gen_xor_vec(0, r, a, tcg_constant_vec_matching(r, 0, -1));
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a919682679..42104d3612 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -453,7 +453,7 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     /* Some cases can be optimized here.  */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
-    } else if (arg2 == -1 && TCG_TARGET_HAS_not_i32) {
+    } else if (arg2 == -1 && TCG_TARGET_HAS_not(TCG_TYPE_I32)) {
         /* Don't recurse with tcg_gen_not_i32.  */
         tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg1);
     } else {
@@ -463,7 +463,7 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_not_i32) {
+    if (TCG_TARGET_HAS_not(TCG_TYPE_I32)) {
         tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg);
     } else {
         tcg_gen_xori_i32(ret, arg, -1);
@@ -660,7 +660,7 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_andc_i32) {
+    if (TCG_TARGET_HAS_andc(TCG_TYPE_I32)) {
         tcg_gen_op3_i32(INDEX_op_andc_i32, ret, arg1, arg2);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -672,7 +672,7 @@ void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_eqv_i32) {
+    if (TCG_TARGET_HAS_eqv(TCG_TYPE_I32)) {
         tcg_gen_op3_i32(INDEX_op_eqv_i32, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i32(ret, arg1, arg2);
@@ -682,7 +682,7 @@ void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_nand_i32) {
+    if (TCG_TARGET_HAS_nand(TCG_TYPE_I32)) {
         tcg_gen_op3_i32(INDEX_op_nand_i32, ret, arg1, arg2);
     } else {
         tcg_gen_and_i32(ret, arg1, arg2);
@@ -692,7 +692,7 @@ void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_nor_i32) {
+    if (TCG_TARGET_HAS_nor(TCG_TYPE_I32)) {
         tcg_gen_op3_i32(INDEX_op_nor_i32, ret, arg1, arg2);
     } else {
         tcg_gen_or_i32(ret, arg1, arg2);
@@ -702,7 +702,7 @@ void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_orc_i32) {
+    if (TCG_TARGET_HAS_orc(TCG_TYPE_I32)) {
         tcg_gen_op3_i32(INDEX_op_orc_i32, ret, arg1, arg2);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -1842,7 +1842,7 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     /* Some cases can be optimized here.  */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
-    } else if (arg2 == -1 && TCG_TARGET_HAS_not_i64) {
+    } else if (arg2 == -1 && TCG_TARGET_HAS_not(TCG_TYPE_I64)) {
         /* Don't recurse with tcg_gen_not_i64.  */
         tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg1);
     } else {
@@ -2397,7 +2397,7 @@ void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_not_i32(TCGV_LOW(ret), TCGV_LOW(arg));
         tcg_gen_not_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
-    } else if (TCG_TARGET_HAS_not_i64) {
+    } else if (TCG_TARGET_HAS_not(TCG_TYPE_I64)) {
         tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg);
     } else {
         tcg_gen_xori_i64(ret, arg, -1);
@@ -2409,7 +2409,7 @@ void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_andc_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_andc_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (TCG_TARGET_HAS_andc_i64) {
+    } else if (TCG_TARGET_HAS_andc(TCG_TYPE_I64)) {
         tcg_gen_op3_i64(INDEX_op_andc_i64, ret, arg1, arg2);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -2424,7 +2424,7 @@ void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_eqv_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_eqv_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (TCG_TARGET_HAS_eqv_i64) {
+    } else if (TCG_TARGET_HAS_eqv(TCG_TYPE_I64)) {
         tcg_gen_op3_i64(INDEX_op_eqv_i64, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i64(ret, arg1, arg2);
@@ -2437,7 +2437,7 @@ void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_nand_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_nand_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (TCG_TARGET_HAS_nand_i64) {
+    } else if (TCG_TARGET_HAS_nand(TCG_TYPE_I64)) {
         tcg_gen_op3_i64(INDEX_op_nand_i64, ret, arg1, arg2);
     } else {
         tcg_gen_and_i64(ret, arg1, arg2);
@@ -2450,7 +2450,7 @@ void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_nor_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_nor_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (TCG_TARGET_HAS_nor_i64) {
+    } else if (TCG_TARGET_HAS_nor(TCG_TYPE_I64)) {
         tcg_gen_op3_i64(INDEX_op_nor_i64, ret, arg1, arg2);
     } else {
         tcg_gen_or_i64(ret, arg1, arg2);
@@ -2463,7 +2463,7 @@ void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_orc_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_orc_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (TCG_TARGET_HAS_orc_i64) {
+    } else if (TCG_TARGET_HAS_orc(TCG_TYPE_I64)) {
         tcg_gen_op3_i64(INDEX_op_orc_i64, ret, arg1, arg2);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e98920d377..ee2701d100 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2255,17 +2255,17 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_bswap32_i32:
         return TCG_TARGET_HAS_bswap32_i32;
     case INDEX_op_not_i32:
-        return TCG_TARGET_HAS_not_i32;
+        return TCG_TARGET_HAS_not(TCG_TYPE_I32);
     case INDEX_op_andc_i32:
-        return TCG_TARGET_HAS_andc_i32;
+        return TCG_TARGET_HAS_andc(TCG_TYPE_I32);
     case INDEX_op_orc_i32:
-        return TCG_TARGET_HAS_orc_i32;
+        return TCG_TARGET_HAS_orc(TCG_TYPE_I32);
     case INDEX_op_eqv_i32:
-        return TCG_TARGET_HAS_eqv_i32;
+        return TCG_TARGET_HAS_eqv(TCG_TYPE_I32);
     case INDEX_op_nand_i32:
-        return TCG_TARGET_HAS_nand_i32;
+        return TCG_TARGET_HAS_nand(TCG_TYPE_I32);
     case INDEX_op_nor_i32:
-        return TCG_TARGET_HAS_nor_i32;
+        return TCG_TARGET_HAS_nor(TCG_TYPE_I32);
     case INDEX_op_clz_i32:
         return TCG_TARGET_HAS_clz_i32;
     case INDEX_op_ctz_i32:
@@ -2350,17 +2350,17 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_bswap64_i64:
         return TCG_TARGET_HAS_bswap64_i64;
     case INDEX_op_not_i64:
-        return TCG_TARGET_HAS_not_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_not(TCG_TYPE_I64);
     case INDEX_op_andc_i64:
-        return TCG_TARGET_HAS_andc_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_andc(TCG_TYPE_I64);
     case INDEX_op_orc_i64:
-        return TCG_TARGET_HAS_orc_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_orc(TCG_TYPE_I64);
     case INDEX_op_eqv_i64:
-        return TCG_TARGET_HAS_eqv_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_eqv(TCG_TYPE_I64);
     case INDEX_op_nand_i64:
-        return TCG_TARGET_HAS_nand_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_nand(TCG_TYPE_I64);
     case INDEX_op_nor_i64:
-        return TCG_TARGET_HAS_nor_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_nor(TCG_TYPE_I64);
     case INDEX_op_clz_i64:
         return TCG_TARGET_HAS_clz_i64;
     case INDEX_op_ctz_i64:
@@ -2395,21 +2395,21 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_dup2_vec:
         return have_vec && TCG_TARGET_REG_BITS == 32;
     case INDEX_op_not_vec:
-        return have_vec && TCG_TARGET_HAS_not_vec;
+        return have_vec && TCG_TARGET_HAS_not(type);
     case INDEX_op_neg_vec:
         return have_vec && TCG_TARGET_HAS_neg_vec;
     case INDEX_op_abs_vec:
         return have_vec && TCG_TARGET_HAS_abs_vec;
     case INDEX_op_andc_vec:
-        return have_vec && TCG_TARGET_HAS_andc_vec;
+        return have_vec && TCG_TARGET_HAS_andc(type);
     case INDEX_op_orc_vec:
-        return have_vec && TCG_TARGET_HAS_orc_vec;
+        return have_vec && TCG_TARGET_HAS_orc(type);
     case INDEX_op_nand_vec:
-        return have_vec && TCG_TARGET_HAS_nand_vec;
+        return have_vec && TCG_TARGET_HAS_nand(type);
     case INDEX_op_nor_vec:
-        return have_vec && TCG_TARGET_HAS_nor_vec;
+        return have_vec && TCG_TARGET_HAS_nor(type);
     case INDEX_op_eqv_vec:
-        return have_vec && TCG_TARGET_HAS_eqv_vec;
+        return have_vec && TCG_TARGET_HAS_eqv(type);
     case INDEX_op_mul_vec:
         return have_vec && TCG_TARGET_HAS_mul_vec;
     case INDEX_op_shli_vec:
diff --git a/tcg/tci.c b/tcg/tci.c
index 39a68db287..783cb7e3ab 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -557,36 +557,26 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ^ regs[r2];
             break;
-#if TCG_TARGET_HAS_andc_i32 || TCG_TARGET_HAS_andc_i64
         CASE_32_64(andc)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & ~regs[r2];
             break;
-#endif
-#if TCG_TARGET_HAS_orc_i32 || TCG_TARGET_HAS_orc_i64
         CASE_32_64(orc)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | ~regs[r2];
             break;
-#endif
-#if TCG_TARGET_HAS_eqv_i32 || TCG_TARGET_HAS_eqv_i64
         CASE_32_64(eqv)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] ^ regs[r2]);
             break;
-#endif
-#if TCG_TARGET_HAS_nand_i32 || TCG_TARGET_HAS_nand_i64
         CASE_32_64(nand)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] & regs[r2]);
             break;
-#endif
-#if TCG_TARGET_HAS_nor_i32 || TCG_TARGET_HAS_nor_i64
         CASE_32_64(nor)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] | regs[r2]);
             break;
-#endif
 
             /* Arithmetic operations (32 bit). */
 
@@ -742,12 +732,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = bswap32(regs[r1]);
             break;
 #endif
-#if TCG_TARGET_HAS_not_i32 || TCG_TARGET_HAS_not_i64
         CASE_32_64(not)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ~regs[r1];
             break;
-#endif
         CASE_32_64(neg)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = -regs[r1];
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fdf57c0b07..db8dec845b 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3422,7 +3422,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bitsel_vec:
         return C_O1_I3(v, v, v, v);
     case INDEX_op_cmpsel_vec:
-        return (TCG_TARGET_HAS_orc_vec
+        return (HAVE_FACILITY(VECTOR_ENH1)
                 ? C_O1_I4(v, v, v, vZM, v)
                 : C_O1_I4(v, v, v, vZ, v));
 
-- 
2.43.0


