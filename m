Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40199C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg807-0007A0-Du; Thu, 06 Feb 2025 14:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg802-00076Y-Ms
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:22 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg800-0000RH-Fb
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:22 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21661be2c2dso25999155ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871839; x=1739476639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGhhjzHgdaB2j6jJXVcSFxfC86zQCbWbwi8vUso1KsA=;
 b=RfW81hvVnhYZRj88K0U70Xy0H5f6VVU4l33p2vPXigV7hRpt3vLPQIcxfIsCMbEy9H
 5Tj8VjwleFoyJIyXYIBfbCCcHihQIiNguarUcrAsECK8cdOjYb3WTL69Z7dAFaefuKBF
 wBB3So0dpO+YgSv5igL3+ZEzroDZDtGeAZqf3+0T5/1qHBdqKEKQxuFP6xBC8fivL6CY
 PVEaYk/9vKIF00hEfAKQWCLS+tal+0iWGKVOfkRIOuJ9z+MDSSikLrf2TU8tugaLV4n7
 5EIygKdFr7RFM2/JCb16smTRGowtLARYJjQegnR8jtp3JXqHICs8fRZgUNdo5AIga/C0
 bkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871839; x=1739476639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lGhhjzHgdaB2j6jJXVcSFxfC86zQCbWbwi8vUso1KsA=;
 b=GCDmrB0i3UOnb+q/LdA2tPK7W9tT07SxrrJr7IKzwT7Z1MmN8Sqi0E7E4QtmMaEfmS
 Jit+vZO1KF73NdFe0IG7dSRLb1+LDhCbLvs2M1xSogxvka79R0ICwzb9MmmaKm9UwE+4
 E01nh6b6vlvXe7W5JWKLdo4FcWfRRHgsvAx/yfV+HTZ8MMvI0pSuYdrUydk42qL7//sk
 /3QUwTDXRvipUPDQj+v5FmhRldS129xxkrBrk3Z6me5mtECXFU91muJZvFjSP9LPEEdw
 wVb2M/sB9J42+2ad0ozVv5HnM2Cbh/GlE66v5RAj1kvgu4esHci7jZ8cqEzSSxJqsho5
 MWFQ==
X-Gm-Message-State: AOJu0YzVYDc/3FU/mISilsFvbTCMGvRXXefs6h7LcXcAHS1USh27Cjk+
 YcCp/cJSh+iQ8TFFg7nQMiDqt7mX1BUhDCg4a+UTl7J+Sw2eKshNevTVQcEnLZOGBmVmxl/lP2H
 3
X-Gm-Gg: ASbGncuFCh39XG5RwnJShhVNIxWd8lkUgi7PuD0LCofUKCAyme6Ko8d4G61g1m67KUK
 g5uAMe4g1XwPrgz1oPqmXQ+wlNlsC6vHvnqenNznXhYNi25wUtpgeEOH3P6Yt7fEfbsAyXCv2qb
 3jMkscP9rADYhBkyqPQAhfy2kim7jdC5p5XX3Z2BmLrIYYOciJWY5tGgxsgXCxNlqEaJ16cUuGn
 CUlxoCKXDUDERxMa0VI+vphzjnffdVwBgWac6+bdOsCSbAehLwXQiSUkcHzKkJdPvApymsIiY6N
 0XYrrqzzG+c0XyGKudemEZTtlTGNDP+nt1gjFh6JOF0d9eQ=
X-Google-Smtp-Source: AGHT+IHdd4BNQ5318PitYz2BS02gdYee2AnPhRL7+hqmvbCDpMZ3u+r3EDFipGz/IwN7b6+HO3hiEg==
X-Received: by 2002:a05:6a20:c706:b0:1e1:af74:a235 with SMTP id
 adf61e73a8af0-1ee03a6b2d6mr1145133637.24.1738871838918; 
 Thu, 06 Feb 2025 11:57:18 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 03/61] tcg: Add dbase argument to expand_clr
Date: Thu,  6 Feb 2025 11:56:17 -0800
Message-ID: <20250206195715.2150758-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 tcg/tcg-op-gvec.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 451091753d..c26cfb24cc 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -380,7 +380,7 @@ static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
     return q <= MAX_UNROLL;
 }
 
-static void expand_clr(uint32_t dofs, uint32_t maxsz);
+static void expand_clr(TCGv_ptr dbase, uint32_t dofs, uint32_t maxsz);
 
 /* Duplicate C as per VECE.  */
 uint64_t (dup_const)(unsigned vece, uint64_t c)
@@ -526,7 +526,7 @@ static void do_dup_store(TCGType type, TCGv_ptr dbase, uint32_t dofs,
     }
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(dbase, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -703,14 +703,14 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
 
  done:
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(dbase, dofs + oprsz, maxsz - oprsz);
     }
 }
 
 /* Likewise, but with zero.  */
-static void expand_clr(uint32_t dofs, uint32_t maxsz)
+static void expand_clr(TCGv_ptr dbase, uint32_t dofs, uint32_t maxsz)
 {
-    do_dup(MO_8, tcg_env, dofs, maxsz, maxsz, NULL, NULL, 0);
+    do_dup(MO_8, dbase, dofs, maxsz, maxsz, NULL, NULL, 0);
 }
 
 /* Expand OPSZ bytes worth of two-operand operations using i32 elements.  */
@@ -1255,7 +1255,7 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1324,7 +1324,7 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1401,7 +1401,7 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     }
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1467,7 +1467,7 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1536,7 +1536,7 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1605,7 +1605,7 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1674,7 +1674,7 @@ void tcg_gen_gvec_4i(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1701,7 +1701,7 @@ void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
     } else {
         check_size_align(oprsz, maxsz, dofs);
         if (oprsz < maxsz) {
-            expand_clr(dofs + oprsz, maxsz - oprsz);
+            expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
         }
     }
 }
@@ -1779,7 +1779,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             tcg_temp_free_i64(in1);
         }
         if (oprsz < maxsz) {
-            expand_clr(dofs + oprsz, maxsz - oprsz);
+            expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
         }
     } else if (vece == 5) {
         /* 256-bit duplicate.  */
@@ -1822,7 +1822,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             }
         }
         if (oprsz < maxsz) {
-            expand_clr(dofs + oprsz, maxsz - oprsz);
+            expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
         }
     } else {
         g_assert_not_reached();
@@ -3255,7 +3255,7 @@ do_gvec_shifts(unsigned vece, uint32_t dofs, uint32_t aofs, TCGv_i32 shift,
 
  clear_tail:
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -3834,7 +3834,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -3975,7 +3975,7 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
     }
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
-- 
2.43.0


