Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0F7C7115D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7yu-0004zr-4t; Sat, 21 Jun 2025 19:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yt-0004ze-3l
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yr-0004QQ-ET
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:42 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso2537381b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549839; x=1751154639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xtlbbj3ba3c2YlVvb2qqUXYeWTRl+FoyWyAeHsAMccs=;
 b=kPz6uTdgIIK5ImKbNemN2c+CHEG+bcZZpapAB+DWDHjRU/xrjbLB48u54z2gUOgQXL
 4Jlp+rJfEfobd6AFfXOjRfW1FX7JYXGoogi9A38/j+S9eeqEvy5goHVUcH3FFZfvZ55q
 fqM8mIf6rKxcAEr2lXMPTNFJwcegw9KWhXmBwj6o3YGDvHyuLTtoUyHOngFOtp8Q/AcH
 dKhzRgngJN23T+FMSglVAsEIWnuMUS5lc59QsAerk7GPQMtd+uj+BfNukUUqjfOGrs+r
 JGgUPmjvNt9luqhZ9mlJBT3Xx6aLRShDm7Y2kD0b7rUjSDIUCQuNAbYvbyB8vCxcWubJ
 Nobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549839; x=1751154639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xtlbbj3ba3c2YlVvb2qqUXYeWTRl+FoyWyAeHsAMccs=;
 b=iZR+FkGL+NKBBbBClnjXBbVznmEpcbxR0TcsK7aNxBtINJvB1TfibekxMY0IeuYQi+
 jCdaDkWNYorQarYVdMgbJhPCuoKpbBT5NJh7zwV33FrJ0E8m+YNBRJan5eQrdP76WHzL
 6HNC/JD5PpULY4WBCii6VvjuoCT0diQlbUT6mBRaL3kFJt3wCNW0Ykxc0xVZDVAnzpvE
 +qlhdsZM8roXFFjEJ/aKxp/2EAbwYpcY6fycouexJCeT6Gf2xmH5M51b9HSxo09m2EYa
 iTNSJ+CbPwNeudlKpKZsxwQjCNA/6Fc9Dw3TnpUbr/wFzwU6kCdGTYq7TLSny0uwch9y
 lN8Q==
X-Gm-Message-State: AOJu0YwKxZiUAF4lv3bfuxuzNJC+XI3xqzcyNngLOz7/sHt7gn2c/zYJ
 ypTkIg75qzbKeukF+vS2kpND0Ww/bu6Y8aD1PnMZAcCpCuy3wd+u6LGygOyrm70BUs5KuCDI2aK
 3ZOZ8
X-Gm-Gg: ASbGnctfc9QuYKVSPooaQQeXC75aUOhwXDd/1iTAOSecni77JKo0A6yub0MZYlsFLAT
 KKEmzOGu12NZ4xlyk+8/KeclbrXnvit2dSa0M/YjrFeoiGNvOZ0l6vo6BbGjJsFd2qcympbJTP2
 +tkjtVLlK8jFpHPY6gh4A0zMjzAOjvZ6Wm6HUTKWepzRt3qTjIR/X4NX/3DpGQfC7mf72/GG7TV
 01560Ctly1fYwT/ekgOHwGUbOPrlK1WrMRwFN+BHAdjn7INFRTHL0JoNgifM5rzfAqcFnEjLPq/
 YZAShCSSqQyFpk4Z4JPXp3X8rY3b88GABtPFm2xtviFyrFqz9UzecY6E+jo3MzBbr/OlsEue0oK
 Wpsegc8QU+ZGkg58xcBxb
X-Google-Smtp-Source: AGHT+IGH65pwBJniH7q82f/ifBBkd5pKc4xtfFwKiA/63BzqlQojc2I5BPxpj4hkDesz3e5MeBL/2w==
X-Received: by 2002:a05:6a20:3948:b0:220:3a5:43e9 with SMTP id
 adf61e73a8af0-22026ef7865mr15408355637.32.1750549839459; 
 Sat, 21 Jun 2025 16:50:39 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 001/101] tcg: Add dbase argument to do_dup_store
Date: Sat, 21 Jun 2025 16:48:57 -0700
Message-ID: <20250621235037.74091-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 tcg/tcg-op-gvec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index d32a4f146d..1aad7b0864 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -483,8 +483,8 @@ static TCGType choose_vector_type(const TCGOpcode *list, unsigned vece,
     return 0;
 }
 
-static void do_dup_store(TCGType type, uint32_t dofs, uint32_t oprsz,
-                         uint32_t maxsz, TCGv_vec t_vec)
+static void do_dup_store(TCGType type, TCGv_ptr dbase, uint32_t dofs,
+                         uint32_t oprsz, uint32_t maxsz, TCGv_vec t_vec)
 {
     uint32_t i = 0;
 
@@ -496,7 +496,7 @@ static void do_dup_store(TCGType type, uint32_t dofs, uint32_t oprsz,
      * are misaligned wrt the maximum vector size, so do that first.
      */
     if (dofs & 8) {
-        tcg_gen_stl_vec(t_vec, tcg_env, dofs + i, TCG_TYPE_V64);
+        tcg_gen_stl_vec(t_vec, dbase, dofs + i, TCG_TYPE_V64);
         i += 8;
     }
 
@@ -508,17 +508,17 @@ static void do_dup_store(TCGType type, uint32_t dofs, uint32_t oprsz,
          * that e.g. size == 80 would be expanded with 2x32 + 1x16.
          */
         for (; i + 32 <= oprsz; i += 32) {
-            tcg_gen_stl_vec(t_vec, tcg_env, dofs + i, TCG_TYPE_V256);
+            tcg_gen_stl_vec(t_vec, dbase, dofs + i, TCG_TYPE_V256);
         }
         /* fallthru */
     case TCG_TYPE_V128:
         for (; i + 16 <= oprsz; i += 16) {
-            tcg_gen_stl_vec(t_vec, tcg_env, dofs + i, TCG_TYPE_V128);
+            tcg_gen_stl_vec(t_vec, dbase, dofs + i, TCG_TYPE_V128);
         }
         break;
     case TCG_TYPE_V64:
         for (; i < oprsz; i += 8) {
-            tcg_gen_stl_vec(t_vec, tcg_env, dofs + i, TCG_TYPE_V64);
+            tcg_gen_stl_vec(t_vec, dbase, dofs + i, TCG_TYPE_V64);
         }
         break;
     default:
@@ -574,7 +574,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
         } else {
             tcg_gen_dupi_vec(vece, t_vec, in_c);
         }
-        do_dup_store(type, dofs, oprsz, maxsz, t_vec);
+        do_dup_store(type, tcg_env, dofs, oprsz, maxsz, t_vec);
         return;
     }
 
@@ -1731,7 +1731,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
         if (type != 0) {
             TCGv_vec t_vec = tcg_temp_new_vec(type);
             tcg_gen_dup_mem_vec(vece, t_vec, tcg_env, aofs);
-            do_dup_store(type, dofs, oprsz, maxsz, t_vec);
+            do_dup_store(type, tcg_env, dofs, oprsz, maxsz, t_vec);
         } else if (vece <= MO_32) {
             TCGv_i32 in = tcg_temp_ebb_new_i32();
             switch (vece) {
-- 
2.43.0


