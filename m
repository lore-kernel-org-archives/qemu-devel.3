Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AF6C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7yy-00052o-S5; Sat, 21 Jun 2025 19:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yw-00051H-OW
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yv-0004RC-4B
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:46 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-749068b9b63so1393039b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549844; x=1751154644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EspsqzaZ6GlbqtXIsalcEYjHvoKmFLTIXcSUIIyZVaE=;
 b=xwloZYFYzOP9e1X5GCv8vqeHL8wE1qdqmfs/0G9joBt5WZKPGWrHJw8XjsKjNyjyn8
 /7+6Q1oIEKyuV0q9mMepQSKOygn+28OiRtFwxULZdmCUHDQB9lHJOxwrgz7Fh2HO4FKq
 lHVKEwj8YmCgJ1Q69rHeJyTEHUoz05C6jh1sTV8vzIjD9K4FRdGYZt/HbIi3fAntaBGW
 EIPqcQzEeJ9ViXCLFM0UX11S5Njtgo5VGyK/88Qsj0vZB7BkqfD5pDxRK1ZXfAtPsv//
 nGqi9VO+cstssVqAHxYHFNsX8KuwwSUpFgrbq/5cdbl0WldYb4uOtAa2p0ak3AUzbkSt
 RylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549844; x=1751154644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EspsqzaZ6GlbqtXIsalcEYjHvoKmFLTIXcSUIIyZVaE=;
 b=ojWGclM9LhP7EdEvpbl2Wuj/5L3+LGvNlqT96BDBaRRSegES9YjX1Vmzf62Ifq/aqA
 c9IWDl7m2eJsennbf8ezxEvFAdqhKM5LrIm6hXArk3d1oiwNyEyPQ+Q7ZAg9xTCR2bYk
 vUDjmIkN7aFKczvvOwVoAi6DaKjuVow3m4D2NIo/fJQCIlsgFylG5FzSq0blndUTnV3v
 Xtd0UIcUY++ONC7F00voyvsOFcVJIwIwvawPZyaN3/7SqjLZPR6kEHfWPBKEtK90liTx
 W59NVeOS3n7kx2YANqkgdlFfz8f0uHcsVe5C83ek049Gy3kJhmLnGYzURIvBGT9fR7wX
 wGhA==
X-Gm-Message-State: AOJu0Yx3W9CBvzsloSdYGKcwaPYH7ZevcNslYetyK4XQki7zRlnaxP4E
 yhSouqWaBk1Z3uQECFlOE/5aXIhOEK8yfygJO9ku+Ri6i6XrjxDGLOBz33SwgYPyMHFPGRHlPqB
 4EykH
X-Gm-Gg: ASbGncvPxpLO73IAl6fnHAmKJK/MZ98t4b18ehbpIa+EPZDmDcFPZbXbnBvfdTRY/Ze
 7jPvzVLrN0mHQsHTJPvOPsyTpZhINVDqPgZmvaqyyPrWbzkZtQIE0DYbVSADpsIdWht7RtKajSN
 a5+FpGbCOyOpr4a5d03vtz7PUnmA8hbd/6mbnVSfBmgsERbNQvxzvW4Top7YDfLTkxhq/l09MUc
 rZgiLVZAujyPuTInQxU1ckznVWq6SMKR8Ij4hS7lrwsKEBaV0jSEUSrOLsoA/M1Ab2IPWH0fc4F
 J2xLQSAcx/prKROo96hCyPd2yvolfYF+Yl3JYPv3lFWqmXdk2UgNfiklVsR7rP2jdPDYf8MvoHg
 Aa9gEQjvimmqQMnVmylLw
X-Google-Smtp-Source: AGHT+IG3R2mMc9bc5wnm5F1itA5+lvVnD1EJYMB2B0sx7so1MG+nrV7IWMGLkPDhAwTODQtwHAEuAg==
X-Received: by 2002:a05:6a20:939e:b0:1f5:882e:60f with SMTP id
 adf61e73a8af0-22026cf3e02mr10806309637.17.1750549843765; 
 Sat, 21 Jun 2025 16:50:43 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 007/101] tcg: Split out tcg_gen_gvec_mov_var
Date: Sat, 21 Jun 2025 16:49:03 -0700
Message-ID: <20250621235037.74091-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 include/tcg/tcg-op-gvec-common.h |  4 ++++
 tcg/tcg-op-gvec.c                | 21 +++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index 6e8fccad01..cabbe957c8 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -253,6 +253,10 @@ void tcg_gen_gvec_4i(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
 
 /* Expand a specific vector operation.  */
 
+void tcg_gen_gvec_mov_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          uint32_t oprsz, uint32_t maxsz);
+
 void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 3e53e43354..5e58b1cc75 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1741,8 +1741,9 @@ static void vec_mov2(unsigned vece, TCGv_vec a, TCGv_vec b)
     tcg_gen_mov_vec(a, b);
 }
 
-void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t oprsz, uint32_t maxsz)
+void tcg_gen_gvec_mov_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen2 g = {
         .fni8 = tcg_gen_mov_i64,
@@ -1750,14 +1751,22 @@ void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fno = gen_helper_gvec_mov,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    if (dofs != aofs) {
-        tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g);
-    } else {
+
+    if (dofs == aofs && dbase == abase) {
         check_size_align(oprsz, maxsz, dofs);
         if (oprsz < maxsz) {
-            expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
+            expand_clr(dbase, dofs + oprsz, maxsz - oprsz);
         }
+        return;
     }
+
+    tcg_gen_gvec_2_var(dbase, dofs, abase, aofs, oprsz, maxsz, &g);
+}
+
+void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_mov_var(vece, tcg_env, dofs, tcg_env, aofs, oprsz, maxsz);
 }
 
 void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t oprsz,
-- 
2.43.0


