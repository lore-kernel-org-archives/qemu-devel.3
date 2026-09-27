Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA6AC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksX-0008R7-W8; Sun, 27 Sep 2026 05:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrV-0002IG-QV
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:58 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrT-0008HM-Gp
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:57 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc78d59bb02so640779a12.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500074; x=1791104874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uu2xaJ+fNg2AxWgY8ED6VJtHshgxiIKwKiGTq3A8uGA=;
 b=qtwC4tCqrpNqG6FXH0E9ciPOkqcLgM3CodlLiJaKSe4RXeUIzW/dGc7n2Nceur2QdT
 Qz5Ti8GiygkPgEZrJiU/4BZq2cy9Nn95be251OGWUf/Iujn6L9dLVGf2WV660sjCGsn6
 Ku1qVLzV9Jtb9XJPAYQCZcTLT/vVuasxLRYI1UTVV2TlKEcHf9X3lmf71zp5p9Iydopu
 0HowdTJ3xgW1nKqhJk3ZldqHvpUcEXyrzO0SH/EFpjbEAYXTqdQ/6AepSiq9kZtFPZbV
 Rbb2+G84xWxTmUpTF85DVL3iDcX8OcAOMhUSpP3bVVAfB4MyQcZxaDZpFP0sT+vEc4Y0
 gmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500074; x=1791104874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uu2xaJ+fNg2AxWgY8ED6VJtHshgxiIKwKiGTq3A8uGA=;
 b=czLeJaqkP0s3zgYYas58qejmiRDEz2XX+5B60ov06NpknOIHNuSprFiV4fUsdbyq95
 PUVWFr9PpcAb8rFzQKN5tEVqXwoWteDoKazzeU9xnOwBG3m9+xo4Ei7ytrUkn6zelBeT
 a+Sedg6J/HvsTj9Mo9ZtmgV6ZF3PW8iatczUbFEO7g66HMXjNLEdjhDgilNm0093UNEG
 Lw4emVolAcIQ1ACNbmmvp5tKdyYDpEsagXi7hSq2U9gO1LPjUfQJ6+VMN0L7qWDwBmiK
 lOCRkYG4WSgJg9zjtpXfpVFcCZyhNNgqFKOVJ4R3zeFCPwMydKsO5RzzNCKyKzMDGjDa
 4HTw==
X-Gm-Message-State: AFq9FYKiGccSL95+cQhxgX8idEDfPtqxuNqETTq2P+rOIikzS0OcZpX/
 I1f9cK9D8AbBP+S/ZoggIxXMRMdw6sFbMVga+gW3VQjODy/4yTnBbSa6PCkAlZ95Dj44X5goIqc
 IuavF
X-Gm-Gg: AYBFou0K7SkKhb/HNKRaNFkNpjho7zT1Ck/3l8UNWjuYDyHCU/uRDXBv+rcilUkrUDv
 C7MUuRb0/DxJ1X400tRVfw5yi8JiFKWMrPieCx1KuobrQlvRoHNa/2CQu5g2vGFz5xx6c3QH283
 hCoiDwFvZl/vOJDGoeTw1KidELSR7fR39S0iC3wGtzYdmZTo7/bwH6S4h7+Lr7djhEdrSPgUr/f
 RoEYILa1gy10vqXdajuG+iTMZrGofIARYLDjniXOuck/DxNHFx2Isef1SlOkXopN8uFZQdHaiBh
 p6wczEBN73QwpBSWtvdBGXAC1ddcNxPLnLBk4SleiuOPQsT567JIz1+zWkLmD0oG9kcH6d78drK
 3pZyPf2/9TOYgCTxbT/swacYY48G4JvT2ve6qQGZ8UFn7rHHCHaYLAOzkdA9HuGT4wm4iNa7W3v
 xWmDyjsSx2oPBZSGxMAugDrQ4MtT7gJTSlYkb/Lby6Rbb9Kcluxd5M4YmcRMVmKtWAADyriZjsl
 L01XK0v4OPuKleYJJKyKWGkOyLllA==
X-Received: by 2002:a17:90b:540b:b0:3a0:4384:adf6 with SMTP id
 98e67ed59e1d1-3a09855cfa2mr7806444a91.0.1790500074078; 
 Sun, 27 Sep 2026 02:07:54 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 091/101] tcg: Generic expansion of tcg_gen_ld16s_*
Date: Sun, 27 Sep 2026 02:00:01 -0700
Message-ID: <20260927090011.10724-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index bf300de4b9f..3782d1839fc 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -141,7 +141,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
@@ -168,7 +167,6 @@ void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 75bb38a07e5..785c417a74e 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF3(eqv, TCGV, TCGV, TCGV)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld16s, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 608010bb542..af28243cb73 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -788,6 +788,12 @@ void tcg_gen_ld8u(TCGType type, TCGTemp *dst,
     tcg_gen_op_tti(INDEX_op_ld8u, type, dst, base, ofs);
 }
 
+void tcg_gen_ld16s(TCGType type, TCGTemp *dst,
+                   TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld16s, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1398,11 +1404,6 @@ void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
 }
 
-void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld16s, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
@@ -1426,11 +1427,6 @@ void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
 }
 
-void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld16s, ret, arg2, offset);
-}
-
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld32u, ret, arg2, offset);
-- 
2.53.0


