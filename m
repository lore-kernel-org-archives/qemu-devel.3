Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF95CC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Thp-0000pM-8B; Wed, 23 Sep 2026 16:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg7-00089u-43
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:56 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg4-00050M-O7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:54 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85f0fc1fd8eso724838b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195691; x=1790800491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OcvnRRYGDr2MyKAYiYrzAnGfCSmuHtaPLGjjlAkzGBQ=;
 b=D0OyiKv6GLbxztyXzkjOdZBKPwDnDacCcdL2zdfYY5ovLHHclmODbfHA80EF2SiJpL
 zjZ53kK/gtDuhn/0inNGBVmvZhLDeScmovkgi7C7v00zYzFEq5374qnA4myJKHr76mJm
 +0wMlvZVh9SPMhUezab3tkxmW/BrZCdHtHpbHT6gl82o/y26zKRxOtF8qopGeRWtJdGR
 ntxkwkkfAJknthGkJ/w5F9XGRYLQleESry6ggjk8eA5tlgSzqOESrOMWXIjzRWbFuSTJ
 99ZA+Gv7i9alda7HmDnjtTBvmW/LndPyp0ixHT0rhVfCw4+nq/VAU/nL412eOWU9ulz+
 /p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195691; x=1790800491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OcvnRRYGDr2MyKAYiYrzAnGfCSmuHtaPLGjjlAkzGBQ=;
 b=yqGw2jXhJp6+tounPqOpPSPZpPBRNwZJM6UC9rPbbSF04scJM++47GjmTTMV3Tmr/D
 KFO5m+BAjcIgFTFIKmEka0za6VE429CzWyzs+mPNecQJJJ4Bhh3W5rPbFJkn6+0LS+kb
 EJqrnB5fcC0ysfDSbHREvndCDCcQ293dbJAuBOdCR2sgi51c7yp5XGXV4lfxw4UEkrxK
 nx2qteqCX+W9of7NPpp70j0oW20PpPOw2TG03Nf3VOQ+hRBVkMsmS7XT2645z4yvMRNx
 3iq2vjnZDMnE6tOnAjzpLQBP9ymJUmeQmG3sZeYoXOixnZrX9PuZag6DqtnTtVKkaDmj
 Ni3w==
X-Gm-Message-State: AFuF++mnAIlPscIRRvSOcHk02VhXWBQmwj0Vl25FWOdFYR1ScfqZ/KW6
 ejM8n0M0DsXrq785FO5R4ntRoxROK7L1PeBhqRxJX95KXj2YBcXmSr8xJ/ctTOFFYC1dT+fRrDU
 q4JBh
X-Gm-Gg: AYBFou0T6kRNpfASCR4srs1H+FU3+u/7P5PO4MJ86dySvIiY+hCkfyhdB2lfr4BQgqB
 HM/BqKwt1sAMeon4umrpGS3fNuqW0+4L4l1XczNKDRn6bsyrKqF2wZthGHjIZbTMQec6S+FNkHM
 zjiWxhP05xyJVucI9NAcZAOb5zw9QcIdyPpOEnQ46cCYUiKFx3Dp6kkk8VWMdQh0S5yxZHE628o
 Y2uCa+F3oRnh1lNXNt4HZAN3huE/OLFMAoQ4a0ZksCj8vdsQZ6Fk381nDj2yyd4825Hht9ClrBc
 ONJ5MbAojj3o5XVqIet37oo/fepMW28qhf9scpoCiKjMovhkFOgQ/SB1AoF0OkAadJRgjGK0KwK
 jRXkGUtywjra8dhefrS1KYzDseUBnb8JwmHY33i1I5si2UtWSkHg2TEPdGuu2ZI+i9xnecxV8rC
 8VlFHt3eYmbc+3rlrmXCsGuCbPz1mt3YQoialJVncFOwMfbeYfySTzLpHbN7D1ahF32CLEMYxC5
 sNC4glCMkUIGjV76lqcv8+3LNhV3T0=
X-Received: by 2002:a05:6a00:bb91:b0:878:3773:81fb with SMTP id
 d2e1a72fcca58-87e9cd0e721mr246779b3a.55.1790195690808; 
 Wed, 23 Sep 2026 13:34:50 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 08/16] tcg/optimize: Fix expansion/simplification of deposit
Date: Wed, 23 Sep 2026 13:34:33 -0700
Message-ID: <20260923203441.31276-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
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

When we computed z_mask/o_mask for the deposit, we may accidentally
prove that the result is a constant.

If we let the rest of the code expand as-is, when can we get to the
end we'll see the constant, note that it's the same as the current
value, remove what we think is "the opcode" that computes this same
value.  But in this case we've been expanding deposit to multiple
opcodes and the removal of only the last opcode breaks the expansion.

Fix this by noting the constant result early, before expanding,
allowing the entire operation to be removed.

Cc: qemu-stable@nongnu.org
Fixes: 5f747705a4 ("tcg/optimize: Lower unsupported deposit during optimize")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4449
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index bd91220650b..1e4d2a0a425 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1708,6 +1708,23 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     type_mask = MAKE_64BIT_MASK(0, width);
     len_mask = MAKE_64BIT_MASK(0, len);
 
+    /*
+     * Compute result masks before calling other fold_* subroutines
+     * which could modify the masks of our inputs.
+     */
+    z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
+    o_mask = deposit64(t1->o_mask, ofs, len, t2->o_mask);
+    if (ofs + len < width) {
+        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
+    } else {
+        s_mask = t2->s_mask << ofs;
+    }
+
+    /* Sometimes we prove a constant from non-constants. */
+    if (z_mask == o_mask) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0], z_mask);
+    }
+
     /* Inserting all-zero into a value. */
     if ((t2->z_mask & len_mask) == 0) {
         op->opc = INDEX_op_and;
@@ -1740,18 +1757,6 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         return fold_or(ctx, op);
     }
 
-    /*
-     * Compute result masks before calling other fold_* subroutines
-     * which could modify the masks of our inputs.
-     */
-    z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
-    o_mask = deposit64(t1->o_mask, ofs, len, t2->o_mask);
-    if (ofs + len < width) {
-        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
-    } else {
-        s_mask = t2->s_mask << ofs;
-    }
-
     /* Inserting a value into zero. */
     if (ti_is_const_val(t1, 0)) {
         uint64_t need_mask;
-- 
2.53.0


