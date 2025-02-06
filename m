Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AA3C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg802-00076A-79; Thu, 06 Feb 2025 14:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg800-00075S-PY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:20 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg7zz-0000QB-5d
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:20 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f9e415fa42so2327685a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871837; x=1739476637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xtlbbj3ba3c2YlVvb2qqUXYeWTRl+FoyWyAeHsAMccs=;
 b=gKju7Lf9VufpN1KVxNbisf+b0DZ+QEqHPwRoRiyQGlFiwHcnQtHOc51BTHviQqssvC
 1qj/ZWuZarfkgKTMgm5hv2GCXJzUn9Isr312lMDEF7jv70+8NNjpaj37iy+4mKhPwrtu
 cyOjMBAUWePaOHxXrfj07MNajPHEFj7VutDeqg9Ba5LjMd5e6Z/2b98LuUr6SJOUMOn/
 xmAXUdVd8RMf+9WPAPnW2eQgZE0fuApQxjN2P8x8RWLgc14y5ruZaoJZZ3mQBtdcTcK8
 z0HPvTSz/fe+Tn5DDsVkF4zsjHzIMbBEhVKql2WTkQuiSsa9qDCAf7YlNwhnEubS+E1M
 aOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871837; x=1739476637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xtlbbj3ba3c2YlVvb2qqUXYeWTRl+FoyWyAeHsAMccs=;
 b=reXILqG8wRRa84vQ0Y2osb1I114intyaI6oCnUXeUY9dn/t0iEW7PSU4OpBh04nCUG
 ftZOnyuF8Pt7lA0VSN9NP+KaF2XhwmBaeuwpv+yjL0sx9HIvWb7U/hY5qsq+X2dGCvnp
 3z7bDnhwpY3qdSeycRlD18q3cYZlERdcGECf8Gx2NbmJlmhPDl9+01T+ELd8EUusJnFJ
 uJhCYnT0fG9K/+j90aFLAJvBKVIxO73WG2FJEHjv4e+mNEakn32NkpG+Bnop5koEMTas
 /TeoRBJB6Ky/An7doNUOgmEBVsXg+qSev0uqgRRtkf+W8nwVUuYD0iPTXpz2UQ9AJVjr
 wNmA==
X-Gm-Message-State: AOJu0YyM77W2BCdR0WYf/Uqo2oT6aJtNVQTae0GoKPQOg9EeQ4nDpXRx
 80JeEut7hO4IKcKq6q+g/xUg+Y+8IHJsqPOU2WiEnEdfLt28guBmVJY5BdwohzBx8cCZ7lUKBku
 6
X-Gm-Gg: ASbGncuhSoBxHNXAlC6qmeyNWWKAt3FhC81b1uP4Ksw7MgQVRMKd+dlsBZqiqTMthjD
 YFuXFnWzLUvoSGv0Q45D7n4ljukXLKCItmisC4CgBE1vx/kjYzXJ1CuQFp2s5+lVBAD0TPg7xpE
 OX/qEPPRRRviDc8KPNztPL3Na/MHcXq++REViHuLQq+bfzLYm/O1rMQSw9G9xL6KCgUa1WTdhlA
 zL1r2ww4m6ZMBBjPFvOwLUjtCUpIUes4KxCBgDUNetxE4e5/gVM2/LbkthDUyazaiq0rJbzODAn
 VQhc5hafrm0jY2ql4AGDGgLxud+mjY7vTbDltblbINMsfbc=
X-Google-Smtp-Source: AGHT+IGB13wIXcjFFEWPmU7u1T8AubRJXSNfO32DaGoYVMSIW8Q05wUynDDS+NpktCjI5t4aytZB9A==
X-Received: by 2002:a05:6a00:22cc:b0:72a:8461:d172 with SMTP id
 d2e1a72fcca58-7305d4318a1mr971020b3a.3.1738871837518; 
 Thu, 06 Feb 2025 11:57:17 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 01/61] tcg: Add dbase argument to do_dup_store
Date: Thu,  6 Feb 2025 11:56:15 -0800
Message-ID: <20250206195715.2150758-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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


