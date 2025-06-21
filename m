Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5105FC7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7yw-00050v-Iu; Sat, 21 Jun 2025 19:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yu-0004zx-Gg
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7ys-0004Qa-F1
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so2272919b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549841; x=1751154641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lGhhjzHgdaB2j6jJXVcSFxfC86zQCbWbwi8vUso1KsA=;
 b=NXYC2SigMMEmqrM65FOJp/B427AP3SrkKG8BsN282VP+xJIRS9d2XJjo7UCAFFH5Fj
 L3D8q1l5iBfPM0MZyc8sh+G2zJHOwYwD4MtJJNqVDsvxnTcPBlklZWeVdyhTwuRlGojm
 Erd2UbD2Tz72iRmdV1LYoUTlNgWr58DQzQmNge+rZyvMgVKpcnNv4APuLpQ0n7ArWWQI
 8ulL7u3Osvcd6JNK22lH5hGIUdT0ZUsmLT5fr0x2WluArysJAvRIgTKspeBL3SUQPIL1
 2LnSeU5dpbTQ8GouNR94lS5lsmBfRXoWuC6zxTYdTYzreNclbWxp5vBa6ISP4TneVgIe
 JTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549841; x=1751154641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lGhhjzHgdaB2j6jJXVcSFxfC86zQCbWbwi8vUso1KsA=;
 b=EHPOpVCzjew0dvhP+DsjGIrz1sTfhEbM4JYpOomFjuLBQkxWWL2FnbuiL7Ce98gGJb
 a7ydodnFDgJHl4gHtuvgrKoozk03aEAl9h+966x9LzIx8zgdbjmgjKr9WKnDC2Npxt+E
 4pcBgSqzLCYBv0upAmH/4Ch7kEongtvO0phFfXX98FZKD2Ir5NcJqvJVaDCJZd1ZMmCg
 ywZhGQLPxe0rOS5NDuQsLejrFTzFmMC8WwrQ8hfVUqMdL4y1E6HI7suJJD1Lk7lHvxyI
 N9jpDYj2Dn6/bghynbHf2MQ/qIfaXJ2Jk3cPUt7y7lxqyZHMYEjO4q8fO4jKcszsLClc
 e3/w==
X-Gm-Message-State: AOJu0YzXK0vCIR43++6+zuRqs1S4wixg+JQsLLaxjwiehr9ec/n65rDa
 DE86x1Crr6HqR4IXei1H/jcsle4fF+FG+6gQkKFEHVSVuXkIEMKPSEui/oJBvswrCIEQSGZ+Ge2
 96ace
X-Gm-Gg: ASbGncsJKWRUe+B2a59iE/oHuFHi4EFNPAHOwDHe2jcfXScnHvpHpne89qwtR3zvcEv
 W9FV/b/rMiFwRnouWMcAICkYsGBAXrWhNrp1t2dc7i2p/pWSVRQSquudJVIcAVMqZgeQ9t3E698
 j7Vt2KBAmsQpGDOoQkbNFXmcYwzon40hQtx9wLWL/pGvdkS+o0Zr5Non55flyfpISY4JANWhA9o
 HvEZTO3jJLQAGh1uR3CiiCnR/7zv/up2wJ/ua46RlN8wP/vcLKreveuijTHpiLgUUq2FE4RBWS1
 Td76JBGyd4dB55qQGJLoU1Ds9CwULMTtfLFgrk9/zHE+3UqjjyZLtQUaMe2mA80Wdmld0WEPU9w
 wY/9uAaYcGbs0AFzDyc0KY6E7eN0xP10=
X-Google-Smtp-Source: AGHT+IHmloiy8LA010NIyMAIOhpiTzZbot+xgp0xyqU/TtZie/WP7p3z4iCtOHZhatRmuQUb9d31Ag==
X-Received: by 2002:a05:6a00:4fce:b0:746:25d1:b712 with SMTP id
 d2e1a72fcca58-7490f5487b8mr10044719b3a.7.1750549840924; 
 Sat, 21 Jun 2025 16:50:40 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 003/101] tcg: Add dbase argument to expand_clr
Date: Sat, 21 Jun 2025 16:48:59 -0700
Message-ID: <20250621235037.74091-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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


