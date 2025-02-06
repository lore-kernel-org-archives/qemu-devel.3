Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870C2C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80W-0007Pe-Ak; Thu, 06 Feb 2025 14:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg806-00079m-Pu
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:26 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg804-0000Sj-8s
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:26 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f0bc811dbso36347955ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871842; x=1739476642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EspsqzaZ6GlbqtXIsalcEYjHvoKmFLTIXcSUIIyZVaE=;
 b=k3VnPnfaaF6G6/BsDh7CSTWwcDQyW9HAk9Sd0+gityraDCj21GoUdauzXvrgaAi7wT
 jgSwEl3L9QYE1LSJVE8oJiVHX3P0979sO7Xd7ibRNcJNGk74duKKsXo5sfDbIK+yPAxF
 6gEVkc2iCEQH/jwSlU0NwztaaG4+7Psj3KWPgiRGNLSJynqcHLZEFPPj2K/kUyq+tj4z
 HCSHNyWVum1QL0TOw5QtHrrqZagvG7K2Fxl/UBMYiRJveZhDNmnAfv4gN++VHHoJF/AN
 fhnSW1UcbfoOjoDvz+7iM4zoc4Uod2rrQBOoMtSP6d/ShumLXVGcJbitSAehzYSgg5SS
 TK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871842; x=1739476642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EspsqzaZ6GlbqtXIsalcEYjHvoKmFLTIXcSUIIyZVaE=;
 b=vx8QL9Xq/6S9+6wG2U2ID/ZFOux99kEEZCerxxV089J/XHhVSoMjm+nPoojWeMgefh
 4Y2CG84MCeqRYSaxukdMDN4UYEP74UG2rIogEQkJMJba5bB2KI7aVr1wqJCMMWqqtHsn
 I4WkT6wmzueQe+6/UGD7PMi5EFX7sfJlUIs7Qnzr8yvniXjX8JYz/POVO+ZrnBBk2XSO
 M+6Zk0kGGoCZ1oHyouJNfBX2DxG9TF9kBtojTpmgj5Y3J7YcDliZTM+Zt661chuCK/Ng
 +wKv8YdtG8xZeMyIo/BF/TGlECx1yT9WdSPWZyU4ey6w/lpoqWK5rr0MZMasSDvP+oA0
 ZTaA==
X-Gm-Message-State: AOJu0Yx6qq2K6J/cy5816DHnm6dQoCxf/fYxLia5s38xffrXJjoS/kv3
 3kdb8lj5LcA/7uEGSZdGPqAUv34k+UnPMkgY5vJq4QUkogWQRDevfRZB4mNHKZy9/Kaxy1vS2ST
 5
X-Gm-Gg: ASbGncufTub3axIw65K2fQJUY7yEbR2vi9vFzV0dXLNFMRbHMfHAU39KPTspbaWdF58
 Hp+UfDsOHKJX2H3ufebB0kWPFuEHo+2nuGxA984xbUtA23rb1m+r4YNdRwKl9o6t+XAbP/5ilhu
 LQkjBpPnZxet+Z9DnPb8edNrifXpeejQuUSlsBJovZ/UWqfj14cp11DoASd0vXdUlCpDQgRwx7e
 xeXPRc+5E3p4eT4TFvEmrGSD1kGI1VzLwV2QsYiRX/imPhaiFHopraCVs8WejooM6lNPIGYmt8q
 DsTa8qn83AoX+5Yerr+zm5vA/MjfDgJ7xbNvq1M9FWHA6Ug=
X-Google-Smtp-Source: AGHT+IE/rZcATUjHglDGLQCthFB2NyaU6RlNABdcYxgakCs3n70Dc+cos+MMV79kA4qc6hYSrIgyxQ==
X-Received: by 2002:a62:b40c:0:b0:727:39a4:30cc with SMTP id
 d2e1a72fcca58-73042a57f94mr6945938b3a.1.1738871841782; 
 Thu, 06 Feb 2025 11:57:21 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 07/61] tcg: Split out tcg_gen_gvec_mov_var
Date: Thu,  6 Feb 2025 11:56:21 -0800
Message-ID: <20250206195715.2150758-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


