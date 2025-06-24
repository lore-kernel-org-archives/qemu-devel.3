Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD10C7EE3A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 01:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTsJf-0000ak-Gq; Mon, 23 Jun 2025 21:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJc-0000aR-Vx
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:13 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJT-0005n3-Hh
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:12 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b31f0ef5f7aso2418852a12.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 18:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750727942; x=1751332742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMQJXl2PRvKJ1Yoqc6SMhgXR/CsZqd9Hm7ziqyjccoM=;
 b=PGGiJ+ucQIf9NvU0U5nRa8xONLZxCYPT+Ni7UjO/JJqQl+i5YdzFEucyNfsXNu5xk/
 Y7wE6tsb4W3YcEgsMVe/89QWLS5gdVOj0RD3J2m8LOgcQB5SmU7C1qqemZjYt4C4uMmW
 nW9TEYZ0PGl/zi/vngdcsg813uxBnazFZsAhJ5FH2uu7mOGa/CqYcWzIRiLiLqtkfdOa
 uQB1bfMqbXq9CrshIyJliMIzZebHKlhOi2nUC6b87rCpQ6Vf295RfV9zjRJ2iZSVrKlB
 HYHz3DOgI3of0NamLZSTi9zP6SIu6PYrhPGpZXs5i9LgK0+nHgKVgc1dg76j7zoGoc5w
 YXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750727942; x=1751332742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMQJXl2PRvKJ1Yoqc6SMhgXR/CsZqd9Hm7ziqyjccoM=;
 b=kYc2ykPvihGkKNXSg8VhX4VQFteeCgW3vGYQpeXTmkYD7wDGh/czqApfAh5vuW+Qr9
 tgax5TmMPHfXODrJb76YpeyBc1PoJjFyywEqqZZ+jnHWtk4Raw0KsJLrwCdXc85+oLKW
 yZH+8jIWbobJqyXwQ8vUlhTpX+AoK03MNMcTGN58onprPSYhsNd7Oy3Q0/dRSshH8s6R
 zV7N1unshNe07nwVYYgn+KAE4jLj+yprCP6d9QBqRnc0UVmHnQmH8f5/1EdttHSMqU1J
 wUC7BktNPKXgaIwthoopSjKhaWNLFTxDqfcWy7NaH4rRDg/sqCIZ9pwBTgfQpfQbnPCt
 /qXw==
X-Gm-Message-State: AOJu0Yzt8pLBX9zJMWbZJ9faC+cguukz7rA5B3Z7mkZGbjmHKgGve/Ix
 dk+h5OGyjWuNSXz2fgEJ8hGiPIs9yAmi7YtuEnBqX4kVvTLZ3IlXnM+wWfl8AH9dHzoAZQqgbYw
 G3dcJ6/c=
X-Gm-Gg: ASbGncv8Nqd4AU5AeIchkuF09iQKy90C1yftV7VmStpFE/ype1mThKUV4ybBRs6mdzm
 iNKQd5Ns5zuqZshZPsEqEsTGBBfP2fORqO9dLrYXIRVU4jG8Z5Y4fLMEpLBYmciAT0u8ux7gvjX
 0JwHFkpMpM9RysNzqCeXkoC3PwNhOgYDtgwgtrvgmsdZ198WuRo66kFtAhKXUytHstNgD0IwoHs
 0HXDVFYya700EloqQxxZW17mHLfVpteuLZvEhWSl5XbfkM3fs13UvJTTrf2/jXZEuPKflvzqp0H
 8hIulsvbhRbEcjd4nQeTNW0OU55Wx4Tddr5xzHk1yn/MnRyyDwWNFYpVpep3QNQGxH/MBoIMiaP
 LHvILhXGob+pyixuTrf+C
X-Google-Smtp-Source: AGHT+IEfFqf58Wb3i3IBQtiZuvdLeIigqsRHbbLHBjWUEjBAjqKeokfXll35pcekbX718lVkpagq5A==
X-Received: by 2002:a05:6a20:c90d:b0:220:6a40:eab with SMTP id
 adf61e73a8af0-2206a40125fmr3113334637.32.1750727942034; 
 Mon, 23 Jun 2025 18:19:02 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d28sm412080b3a.28.2025.06.23.18.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 18:19:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/11] tcg: Add dbase argument to do_dup
Date: Mon, 23 Jun 2025 18:18:50 -0700
Message-ID: <20250624011859.112010-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624011859.112010-1-richard.henderson@linaro.org>
References: <20250624011859.112010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 1aad7b0864..b100dd66ab 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -530,13 +530,14 @@ static void do_dup_store(TCGType type, TCGv_ptr dbase, uint32_t dofs,
     }
 }
 
-/* Set OPRSZ bytes at DOFS to replications of IN_32, IN_64 or IN_C.
+/*
+ * Set OPRSZ bytes at DBASE + DOFS to replications of IN_32, IN_64 or IN_C.
  * Only one of IN_32 or IN_64 may be set;
  * IN_C is used if IN_32 and IN_64 are unset.
  */
-static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
-                   uint32_t maxsz, TCGv_i32 in_32, TCGv_i64 in_64,
-                   uint64_t in_c)
+static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                   uint32_t oprsz, uint32_t maxsz,
+                   TCGv_i32 in_32, TCGv_i64 in_64, uint64_t in_c)
 {
     TCGType type;
     TCGv_i64 t_64;
@@ -574,7 +575,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
         } else {
             tcg_gen_dupi_vec(vece, t_vec, in_c);
         }
-        do_dup_store(type, tcg_env, dofs, oprsz, maxsz, t_vec);
+        do_dup_store(type, dbase, dofs, oprsz, maxsz, t_vec);
         return;
     }
 
@@ -618,14 +619,14 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
         /* Implement inline if we picked an implementation size above.  */
         if (t_32) {
             for (i = 0; i < oprsz; i += 4) {
-                tcg_gen_st_i32(t_32, tcg_env, dofs + i);
+                tcg_gen_st_i32(t_32, dbase, dofs + i);
             }
             tcg_temp_free_i32(t_32);
             goto done;
         }
         if (t_64) {
             for (i = 0; i < oprsz; i += 8) {
-                tcg_gen_st_i64(t_64, tcg_env, dofs + i);
+                tcg_gen_st_i64(t_64, dbase, dofs + i);
             }
             tcg_temp_free_i64(t_64);
             goto done;
@@ -634,7 +635,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
 
     /* Otherwise implement out of line.  */
     t_ptr = tcg_temp_ebb_new_ptr();
-    tcg_gen_addi_ptr(t_ptr, tcg_env, dofs);
+    tcg_gen_addi_ptr(t_ptr, dbase, dofs);
 
     /*
      * This may be expand_clr for the tail of an operation, e.g.
@@ -710,7 +711,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
 /* Likewise, but with zero.  */
 static void expand_clr(uint32_t dofs, uint32_t maxsz)
 {
-    do_dup(MO_8, dofs, maxsz, maxsz, NULL, NULL, 0);
+    do_dup(MO_8, tcg_env, dofs, maxsz, maxsz, NULL, NULL, 0);
 }
 
 /* Expand OPSZ bytes worth of two-operand operations using i32 elements.  */
@@ -1711,7 +1712,7 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t oprsz,
 {
     check_size_align(oprsz, maxsz, dofs);
     tcg_debug_assert(vece <= MO_32);
-    do_dup(vece, dofs, oprsz, maxsz, in, NULL, 0);
+    do_dup(vece, tcg_env, dofs, oprsz, maxsz, in, NULL, 0);
 }
 
 void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t oprsz,
@@ -1719,7 +1720,7 @@ void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t oprsz,
 {
     check_size_align(oprsz, maxsz, dofs);
     tcg_debug_assert(vece <= MO_64);
-    do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
+    do_dup(vece, tcg_env, dofs, oprsz, maxsz, NULL, in, 0);
 }
 
 void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -1745,12 +1746,12 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
                 tcg_gen_ld_i32(in, tcg_env, aofs);
                 break;
             }
-            do_dup(vece, dofs, oprsz, maxsz, in, NULL, 0);
+            do_dup(vece, tcg_env, dofs, oprsz, maxsz, in, NULL, 0);
             tcg_temp_free_i32(in);
         } else {
             TCGv_i64 in = tcg_temp_ebb_new_i64();
             tcg_gen_ld_i64(in, tcg_env, aofs);
-            do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
+            do_dup(vece, tcg_env, dofs, oprsz, maxsz, NULL, in, 0);
             tcg_temp_free_i64(in);
         }
     } else if (vece == 4) {
@@ -1833,7 +1834,7 @@ void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
                           uint32_t maxsz, uint64_t x)
 {
     check_size_align(oprsz, maxsz, dofs);
-    do_dup(vece, dofs, oprsz, maxsz, NULL, NULL, x);
+    do_dup(vece, tcg_env, dofs, oprsz, maxsz, NULL, NULL, x);
 }
 
 void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -3772,7 +3773,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
     check_overlap_3(dofs, aofs, bofs, maxsz);
 
     if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
-        do_dup(MO_8, dofs, oprsz, maxsz,
+        do_dup(MO_8, tcg_env, dofs, oprsz, maxsz,
                NULL, NULL, -(cond == TCG_COND_ALWAYS));
         return;
     }
@@ -3892,7 +3893,7 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
     check_overlap_2(dofs, aofs, maxsz);
 
     if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
-        do_dup(MO_8, dofs, oprsz, maxsz,
+        do_dup(MO_8, tcg_env, dofs, oprsz, maxsz,
                NULL, NULL, -(cond == TCG_COND_ALWAYS));
         return;
     }
-- 
2.43.0


