Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9EFC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhLC-0002QS-1X; Fri, 04 Jul 2025 10:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIM-0005J8-71
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:43 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIK-0005xC-Ed
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:41 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2ea08399ec8so907967fac.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638899; x=1752243699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AUY72MQ1kLespnWy6+gTZuXwFdz1x/T5obJXeRu/P0=;
 b=Lhmau6QGqcdoH9DWRx60TUgZ/cT9KESWrseqQxFmgO3RudgKR4WYQ59G8ZbwDXV0KE
 XaQ5EmY0RuyYSGYPpkbj4Xz/PJxszTWYpwLooW+CxxIrZO8ZrPRRd+mmFHCpP+LzpVBt
 fQkwZpBTI8E3jTODtx5ankFzbeomTO0d93voRAurviq/q8CaBf1MEGSbkCugzRzH1XLG
 ycoiRGSeEbeo9/1OUTyW78RtLNCFC6x7b74cYc+TC7vBRkjEZs0OKvy0veOsZgSM5It7
 Dzxv4Xzk5QYmD6H+MFimfFiLcsRTMGoi4KZ7L/s3xypHM5QHXL+NY9oK7ZEIgY30rYMc
 635A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638899; x=1752243699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4AUY72MQ1kLespnWy6+gTZuXwFdz1x/T5obJXeRu/P0=;
 b=xIep8koO64aTLkae+UCl+HzJIYTl8SdDSVFR9Y2v3AtDa/q+XYBrYb16tQA6DVvZfR
 RWfFHqTI00RTtbvy3IfEDzWF+2kBfphT+PABHg5tzbGCWe2r+6MXQITAMiHXF3X03A+2
 QvHvSxqOFiMQQYTcxhyFv2YKdGeu3co2LD8RkGHTUKMEZ3yol1GoFD3KOQBSnmo2AiZD
 tNov5XF0fQfZpCguc5GmGKe0Zx+lqc7nh204vD+6fQn47mBENjDoZXzEVD06KzyIXzVg
 SwkMN6uRriy9/VFCKaiPbrIQDe/18O8JSNEYxuwis7uPY5cQsHDxCbwj3iKIY5ZATcWc
 qyKQ==
X-Gm-Message-State: AOJu0Ywv9EHwOJ1NYWMQi5gyvuSD7JE7RGz+gAaTd5XsDDTQAr5iRziv
 BiK0SPRhMF8N1MBK7HEwkRRPeDVRZ8CAq/CcdmxnrHdWlY/PawZpBze93mlXH4xs8lhPys50tXU
 7CUvDtBk=
X-Gm-Gg: ASbGncvsTA9Nm3fvOTLaX585gzyWtZltU2ALr0bqPPnq9IrOBLW0qWQ9NtZpa9Ua5aW
 cXp3GXhE+mxCTrUAVjmA4C+XBVj74+KFSLZCGcOd4z70McSt6MYeuSclPI55wr4ENX4ZbvHq2xN
 +xmgmDSbySPzXzNdQIxFGKEyZgwpyLMUClAzv18QYCPtK2L6fxPsP2NAE59PAbGHp9O7q85KKu1
 r1jMI26MfuFDwYwNMxInsgHM0RlHLd0SMky9laOXJM5EmZf9AtVCTiEx53UMLk9fx2/kZ95yxh+
 cZHHywoTVbEr0Yp60Q35U9VlU5TOyHvyNb1GKjb3MP/P2iVeiYtghC8H9EAp+0u+a1d1OAes54q
 coy8DI1R8PdFQvQBScLXt7fI191VZHYbeMW1lqYN+BD+u6Vn+
X-Google-Smtp-Source: AGHT+IEMW1yxSJIgNtuQlZDM5FugioD2nIaKinYyThH7g2uEiSMLpm/Tjy6Zm+BENNfVsTX4mgfjRw==
X-Received: by 2002:a05:6870:f21e:b0:2d5:1d1:8613 with SMTP id
 586e51a60fabf-2f796d5eaabmr1679955fac.23.1751638899199; 
 Fri, 04 Jul 2025 07:21:39 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 023/108] target/arm: Split out get_zarray
Date: Fri,  4 Jul 2025 08:19:46 -0600
Message-ID: <20250704142112.1018902-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

Prepare for MOVA array to/from vector with multiple registers
by adding a div_len parameter, herein always 1, and a vec_mod
parameter, herein always 0.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 47 +++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 2c8cb24b7c..ea0e5a7cb5 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -43,7 +43,8 @@ static bool sme2_zt0_enabled_check(DisasContext *s)
 
 /* Resolve tile.size[rs+imm] to a host pointer. */
 static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
-                                int tile, int imm, bool vertical)
+                                int tile, int imm, int div_len,
+                                int vec_mod, bool vertical)
 {
     int pos, len, offset;
     TCGv_i32 tmp;
@@ -52,10 +53,23 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     /* Compute the final index, which is Rs+imm. */
     tmp = tcg_temp_new_i32();
     tcg_gen_trunc_tl_i32(tmp, cpu_reg(s, rs));
+    /*
+     * Round the vector index down to a multiple of vec_mod if necessary.
+     * We do this before adding the offset, to handle cases like
+     * MOVA (tile to vector, 2 registers) where we want to call this
+     * several times in a loop with an increasing offset. We rely on
+     * the instruction encodings always forcing the initial offset in
+     * [rs + offset] to be a multiple of vec_mod. The pseudocode usually
+     * does the round-down after adding the offset rather than before,
+     * but MOVA is an exception.
+     */
+    if (vec_mod > 1) {
+        tcg_gen_andc_i32(tmp, tmp, tcg_constant_i32(vec_mod - 1));
+    }
     tcg_gen_addi_i32(tmp, tmp, imm);
 
     /* Prepare a power-of-two modulo via extraction of @len bits. */
-    len = ctz32(streaming_vec_reg_size(s)) - esz;
+    len = ctz32(streaming_vec_reg_size(s) / div_len) - esz;
 
     if (!len) {
         /*
@@ -111,6 +125,14 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     return addr;
 }
 
+/* Resolve ZArray[rs+imm] to a host pointer. */
+static TCGv_ptr get_zarray(DisasContext *s, int rs, int imm,
+                           int div_len, int vec_mod)
+{
+    /* ZA[n] equates to ZA0H.B[n]. */
+    return get_tile_rowcol(s, MO_8, rs, 0, imm, div_len, vec_mod, false);
+}
+
 /*
  * Resolve tile.size[0] to a host pointer.
  * Used by e.g. outer product insns where we require the entire tile.
@@ -177,7 +199,7 @@ static bool do_mova_tile(DisasContext *s, arg_mova_p *a, bool to_vec)
         return true;
     }
 
-    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, a->v);
+    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, 1, 0, a->v);
     t_zr = vec_full_reg_ptr(s, a->zr);
     t_pg = pred_full_reg_ptr(s, a->pg);
 
@@ -259,7 +281,7 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
         return true;
     }
 
-    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, a->v);
+    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, 1, 0, a->v);
     t_pg = pred_full_reg_ptr(s, a->pg);
     addr = tcg_temp_new_i64();
 
@@ -281,19 +303,14 @@ typedef void GenLdStR(DisasContext *, TCGv_ptr, int, int, int, int, MemOp);
 
 static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
 {
-    int svl = streaming_vec_reg_size(s);
-    int imm = a->imm;
-    TCGv_ptr base;
+    if (sme_za_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int imm = a->imm;
+        TCGv_ptr base = get_zarray(s, a->rv, imm, 1, 0);
 
-    if (!sme_za_enabled_check(s)) {
-        return true;
+        fn(s, base, 0, svl, a->rn, imm * svl,
+           s->align_mem ? MO_ALIGN_16 : MO_UNALN);
     }
-
-    /* ZA[n] equates to ZA0H.B[n]. */
-    base = get_tile_rowcol(s, MO_8, a->rv, 0, imm, false);
-
-    fn(s, base, 0, svl, a->rn, imm * svl,
-       s->align_mem ? MO_ALIGN_16 : MO_UNALN);
     return true;
 }
 
-- 
2.43.0


