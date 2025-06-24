Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8ACAC7EE33
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 01:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTsJY-0000YF-KI; Mon, 23 Jun 2025 21:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJW-0000XW-Is
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:06 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJU-0005n9-4G
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:06 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b31d8dd18cbso5219246a12.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 18:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750727942; x=1751332742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmYH1WddXU4bWR5PssEGHGwYJIjgJGXWoY5n/9icTwA=;
 b=jABvRRjUPvoRcVBIXJCZsjlBpEh3cip6XNjDZlXFO9wCPvLWcBkubny6fEMUwibjKx
 FuvtSuom75DyE4t7rI5Z+6jJqndXC5cn8GbILma89+HviKKPKoOBDLj8jQjbp3nKPYMn
 t2tM9Cro/09iEbxsg69YmoGRgHEfOhx7YArPWL4W5Nf15bR4CqIorWXURfsOurD/sMb5
 c2PrKDjojbLi+2x6o3/y2SoDjHtM44QgqwcVM3bSBzgyUEbjTJ2d9zhaiQdIbQ1x1NCM
 H8oVZnT3De/IcOSIlowlVCavV0pV97iliL21Ad5u3nAlLoPYA1oGabb86YnoDR7kcyLs
 vn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750727942; x=1751332742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmYH1WddXU4bWR5PssEGHGwYJIjgJGXWoY5n/9icTwA=;
 b=bU4cUAA+xmSlAM7fwNjUVNgm1LxVOWjy74jnL3NhR0r/K0yoj63dBit/g4rct9Jubg
 so9dxum8t3Q9UH3gV4iQOYbDlIbudmgNjcY7Hl8M9yycwwhfOi4ABkqTdRkraexKcbWI
 WmVinefV0vyYcAAqbdgP+PWzAEgFdjmKULe8noSxbsI3bPKM/oDp1QQ5KNJjF45OoKZR
 RhJ0gZYAcMryWroBwnPsdFOaX3S7HyOUdkjEz4sIkc+/OP0rEHoAf2ZARE9QsTTm+dXw
 4/149s8AG6lvpPmUAhtwA3Wr5bLH0DDWWo/NLy3oeU9QHWSIdRuJrh0D3Fnlcsajn+8D
 pPlw==
X-Gm-Message-State: AOJu0YzJBOjE4Ecpzlm2x4DvFT4EAQSk4ZN6DU2dEKPefQ8a6E7m3pj/
 JVrmmWjnkCdRA76whkOworGTiBF8J3IDEw80kXNGdX6Lamu9uojiMbBHUNjti94AkGwRGxD2Jr6
 wcUlxHPU=
X-Gm-Gg: ASbGncvf0NwIbyFeovlVq44gmClrnmxIgRJI5q39q9767eMgMNaHMTODbqchYtAy255
 R7D1dwqqs+IsEWkNFa658KKkEsng1RupSp3X4Bd5vO24yjTZOOPamazSOUiQZxoVueiETP9yGmm
 XO8TlqP7RHsY773bnBBy55j/nGQufJ0Ax1N/vrbkI1AXRCPFfIOo11kyofMHh0+6vRkGm/eayV6
 HUnET/uB9wi6BSnCfK+85m4on0mIxpFM7UI9SpP6QKb1l9DZWLw0/BrAVfOSqgyvAMOugvO67Cd
 AqP0MEMhRxcNCI8qwkXQY+p8kdD1n8GTF5oxSEXH8zc8peA03oL2Yy8dBtJGrj6aia6tJw+yMu8
 2R3/riXIbQAiN5QM0m2/mgREg3d8ARQk=
X-Google-Smtp-Source: AGHT+IE/aInwLQGz5EHcQU364Yq/Cl7D+fqGANqaxk5sKmjJ3h44iQlIfPOWhgJzUPmSbqMsFv3A9w==
X-Received: by 2002:a05:6a21:6d90:b0:21a:ede2:2ea3 with SMTP id
 adf61e73a8af0-22026da21ddmr21945563637.17.1750727942628; 
 Mon, 23 Jun 2025 18:19:02 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d28sm412080b3a.28.2025.06.23.18.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 18:19:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/11] tcg: Add dbase argument to expand_clr
Date: Mon, 23 Jun 2025 18:18:51 -0700
Message-ID: <20250624011859.112010-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624011859.112010-1-richard.henderson@linaro.org>
References: <20250624011859.112010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
 tcg/tcg-op-gvec.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index b100dd66ab..f5edadb992 100644
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
 
@@ -704,14 +704,14 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
 
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
@@ -1256,7 +1256,7 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1325,7 +1325,7 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1402,7 +1402,7 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     }
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1468,7 +1468,7 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1537,7 +1537,7 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1606,7 +1606,7 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1675,7 +1675,7 @@ void tcg_gen_gvec_4i(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -1702,7 +1702,7 @@ void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
     } else {
         check_size_align(oprsz, maxsz, dofs);
         if (oprsz < maxsz) {
-            expand_clr(dofs + oprsz, maxsz - oprsz);
+            expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
         }
     }
 }
@@ -1780,7 +1780,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             tcg_temp_free_i64(in1);
         }
         if (oprsz < maxsz) {
-            expand_clr(dofs + oprsz, maxsz - oprsz);
+            expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
         }
     } else if (vece == 5) {
         /* 256-bit duplicate.  */
@@ -1823,7 +1823,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             }
         }
         if (oprsz < maxsz) {
-            expand_clr(dofs + oprsz, maxsz - oprsz);
+            expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
         }
     } else {
         g_assert_not_reached();
@@ -3256,7 +3256,7 @@ do_gvec_shifts(unsigned vece, uint32_t dofs, uint32_t aofs, TCGv_i32 shift,
 
  clear_tail:
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -3835,7 +3835,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
@@ -3976,7 +3976,7 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
     }
 
     if (oprsz < maxsz) {
-        expand_clr(dofs + oprsz, maxsz - oprsz);
+        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
     }
 }
 
-- 
2.43.0


