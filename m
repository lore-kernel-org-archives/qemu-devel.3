Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B07C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg806-00079l-Uk; Thu, 06 Feb 2025 14:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg802-00076H-El
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:22 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg7zz-0000RB-Li
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:22 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso1886484a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871838; x=1739476638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdvwNl7JiFORoJKfG82WHoJWKQvzz977qK5CdHrmdQk=;
 b=bYNmus+A/tGnDLhFYxZglXmMieUUR14Fkg2KZ+LjsYl6rDs46iB1O44+6ugKlDlWss
 ijadoSO3AvLGCHLx3sZY06PRs2pDlfr+7Zi2YoS/abz/sCdIdIfDCOKBMWjNKEW3+bhV
 wAMOauCNLsnE9nYsjbpgJwZDivdJYPbk5ekeh3jV1RyrPEQUf70ZsJNbM/NSaBJNQl1P
 nwXGErettlmykLtMyceR3x5R78BFQUFwdmtr+zo6V2kJDhqXuqE0bj05baF3KEfqjLCh
 RBfC0RUSu0L8wZS2Zc89XRduM4Lp1tZED7IPOOVv2aL5JvEBXVL4OkWqB45O28szCUyp
 nvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871838; x=1739476638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdvwNl7JiFORoJKfG82WHoJWKQvzz977qK5CdHrmdQk=;
 b=gNAwCMIKAD1K9WElUX1pnnZAXHLaexxs98SkE2jf2iqPIrlRwBTM3oIKvFy6GyFGPL
 Dy9a1XdFiNk5W+eYHXWMKpiYhKxSRpRzCc7v0pEaZOI6ark/KGdtvx9OuoFevPwNT8LY
 pAFuj1lWMARCb1e7wrlyBcUeBlb2u+viWhlXPpbQOe6+DUQFKeQhwHHXeBPE1keXIClb
 A2dpwaD/nZWMSM+Jeu4nI7ZNeJkWzCWTu3Tq8v8d3yDAap8oiubChR1FjAIMKWCp0ndJ
 18oWWakyBKTPFa+bKLOrc9RKli0HZbMbY1WpIpwOEL06xVCkpy4dvZTd4fzZyEcVFrfJ
 h0Xg==
X-Gm-Message-State: AOJu0Ywwgb0JwVnyw76y48BfgkZQOj7vZnF1CaG8kddQN3SQgVY6j1Ty
 Vxf+umi5eYGhkRzRq+tDMlgJGK3Zm29EQSK6bZooKtuMaUYxVlJcdmiG7WbWvuiOLuobjcynIys
 Z
X-Gm-Gg: ASbGncvMNUAgVtLnl4vXfrRrfq7Y6VIrxnZt61Ch1YH9ahnfd2t3Q2SFEJ1p/I3iK5V
 OEhmqGuwS9Gl1NQF5HzA+Ct8vXIpLQFqPCig6Djz8/NEw8maB39bbQiL6EfYuKAQMGW/1nU0+Cm
 Nf0HPcdN7ByOZZM7Uh08z1LuL+NpskqZEMc5QUIasQtcZ7lVcB5pQOGLSvoPL1EbGa7me2LsvYZ
 N+mqcaP9YkFFQijwM9M31Cefh0BTrQxKeuYHqXpEjqQyixsuPdJsWM4/TwdAqW/E0GNgVU3dNau
 ZWB7cSCcK0yRLW0wisLMdYTVdkxWopG0AMPAILopM6PW46w=
X-Google-Smtp-Source: AGHT+IGGt5Jz9OlzIKxzacwBptSVPT0FdPcyElFGFmV063rD2MSRje04WCFfXTRvUZtjYuQLsInC3w==
X-Received: by 2002:a05:6a00:1da9:b0:72a:bc6a:3a87 with SMTP id
 d2e1a72fcca58-7305d2d04f0mr986172b3a.0.1738871838254; 
 Thu, 06 Feb 2025 11:57:18 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/61] tcg: Add dbase argument to do_dup
Date: Thu,  6 Feb 2025 11:56:16 -0800
Message-ID: <20250206195715.2150758-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
 tcg/tcg-op-gvec.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 1aad7b0864..451091753d 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -534,9 +534,9 @@ static void do_dup_store(TCGType type, TCGv_ptr dbase, uint32_t dofs,
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
@@ -574,7 +574,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
         } else {
             tcg_gen_dupi_vec(vece, t_vec, in_c);
         }
-        do_dup_store(type, tcg_env, dofs, oprsz, maxsz, t_vec);
+        do_dup_store(type, dbase, dofs, oprsz, maxsz, t_vec);
         return;
     }
 
@@ -618,14 +618,14 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
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
@@ -634,7 +634,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
 
     /* Otherwise implement out of line.  */
     t_ptr = tcg_temp_ebb_new_ptr();
-    tcg_gen_addi_ptr(t_ptr, tcg_env, dofs);
+    tcg_gen_addi_ptr(t_ptr, dbase, dofs);
 
     /*
      * This may be expand_clr for the tail of an operation, e.g.
@@ -710,7 +710,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
 /* Likewise, but with zero.  */
 static void expand_clr(uint32_t dofs, uint32_t maxsz)
 {
-    do_dup(MO_8, dofs, maxsz, maxsz, NULL, NULL, 0);
+    do_dup(MO_8, tcg_env, dofs, maxsz, maxsz, NULL, NULL, 0);
 }
 
 /* Expand OPSZ bytes worth of two-operand operations using i32 elements.  */
@@ -1711,7 +1711,7 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t oprsz,
 {
     check_size_align(oprsz, maxsz, dofs);
     tcg_debug_assert(vece <= MO_32);
-    do_dup(vece, dofs, oprsz, maxsz, in, NULL, 0);
+    do_dup(vece, tcg_env, dofs, oprsz, maxsz, in, NULL, 0);
 }
 
 void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t oprsz,
@@ -1719,7 +1719,7 @@ void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t oprsz,
 {
     check_size_align(oprsz, maxsz, dofs);
     tcg_debug_assert(vece <= MO_64);
-    do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
+    do_dup(vece, tcg_env, dofs, oprsz, maxsz, NULL, in, 0);
 }
 
 void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -1745,12 +1745,12 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
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
@@ -1833,7 +1833,7 @@ void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
                           uint32_t maxsz, uint64_t x)
 {
     check_size_align(oprsz, maxsz, dofs);
-    do_dup(vece, dofs, oprsz, maxsz, NULL, NULL, x);
+    do_dup(vece, tcg_env, dofs, oprsz, maxsz, NULL, NULL, x);
 }
 
 void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -3772,7 +3772,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
     check_overlap_3(dofs, aofs, bofs, maxsz);
 
     if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
-        do_dup(MO_8, dofs, oprsz, maxsz,
+        do_dup(MO_8, tcg_env, dofs, oprsz, maxsz,
                NULL, NULL, -(cond == TCG_COND_ALWAYS));
         return;
     }
@@ -3892,7 +3892,7 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
     check_overlap_2(dofs, aofs, maxsz);
 
     if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
-        do_dup(MO_8, dofs, oprsz, maxsz,
+        do_dup(MO_8, tcg_env, dofs, oprsz, maxsz,
                NULL, NULL, -(cond == TCG_COND_ALWAYS));
         return;
     }
-- 
2.43.0


