Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3977ACC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4R-0002EX-Et; Thu, 15 Oct 2026 06:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4Q-0002Dy-3w
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4O-0007oT-KY
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:21 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so44117125e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061539; x=1792666339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DeUFO6MgpKEQ6ouT8Jfz1t+piLPyNtVDq5lkQ5lejBw=;
 b=hXroj/rA8wvc8cvq9AH/NdEj04+lx25JhQNbW6rfUUIyWIgQ+5dBcBmJP0FBxpB958
 VOzrk+WchuTkYWgmRdNXvErIMsSnHl5rSLKUBL3ZG+IKNlpwphbOR1BE37zUMkNAYTE9
 FDe2b5aurIsdBU6MUAbh9dTJkjdi+mw4OC7Ky+w3pSVDygWP7GqhvCU9myTlE4oI68Zs
 CqqG/ia4313nSGdYisu6Bq9rSUnASUo1fEJeV6f0UyhhZJkSeliS8KY/5B54Ho+M8IOZ
 d1b3ZW7gg/OUdJkpFrpozLeMX8KfVgiGdRMQrcwRK2BC4Z2mRppqpEnneWaMO9XE34Z+
 gjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061539; x=1792666339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DeUFO6MgpKEQ6ouT8Jfz1t+piLPyNtVDq5lkQ5lejBw=;
 b=jmsSVAPrCX22wiR3d7GNNWz4Eqh/FgrPY4HFocBIt6ZOCKpYp/Ado+8yyHWxBmsfuW
 ybtga1PcNv+LE33p4KW2NUT36O/DvuCK33OD78uvlFu0MrQB0u9eBqv6iwf/34g2i2Or
 3iQI1W6hq5Q/uV942yhimxDXUEyAXTQ2a5Bw+n0oMQKu4dILQMXSnGzr4CpdWrtBMTw1
 rXiF1NSh4jjExjqrJgMVBp6CTnRco3ehQXNv8nI0Q8ieLTd6qQzqCgHSZJovwcFSaLE3
 aVZ0WcmYIyzAPQqoXHut1cENncKFaOi+UBfNIt5ilVDnsXT4pCTg7JkwPsKU3e27xJP6
 i7gw==
X-Gm-Message-State: AFq9FYKwWg9+A33FKtz03/w+21T2k8fNFW+H71mNMTzlrnJtu8WvKN74
 t4Xw4vF5z7D4YO2RNFFe9lItOZNDE4UPWlkwcA9DOX3hh4dd/CMhxyJQVrGnMNe1z6gQqUFtXLw
 Bze+Q0wk=
X-Gm-Gg: AYBFou34KrfAE6teTC6XsQZtLfMNQSC10sY6PbOskb69BT6kwZEgzBSMcCfe4g/5kSR
 SV0v3blIdTCgotVI7PHk2kTdnjzA8APpfecVupQiDJP8dCb3HB4ZZ3BkMdnRjd/Gcyk83FiGCyQ
 HZel9zlnfYVx5pC+SCdmkPU72ZQrlosYtmkwxCBhJtl2chl316xEaxei5+pt2fVRhSMBqvetj5S
 0WLLDpeYUz+tUB3R8YAMiVwV94mBhiwwmnb5cxLy7/1pZm3flbmhc1bvIhsFKsb5nlTmmQ/fbIA
 if0/pYGFr5LCOnqcaJe6WObzu8h4k/B/Vdw3gyruR//rv2cZHsUxKey0aj9btK+qHQzl3yByf41
 AJbzPL961Q7o1lsbRXDzUfajXWYdTPkFZq1l2Vl1nJToVO+8Ulm6JSVAcwe7sVGroT9IXx1YmIu
 Huyv7P7Eiq3MM/5qbZb8tpQpOn0W3Ab9Ohxpq8emTTqQOjzHpGt1mRXkmfUnGuLrAA3GMPN89bN
 Es866kihgChDE8hsa3Rwg+xVzPL1j8dvCuGjRC4alqwbBciB2Q+Xja0Tg8sKaE4inUmim1psJ95
 9+8W
X-Received: by 2002:a05:600c:609b:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4a18e4c9944mr372039995e9.30.1792061538334; 
 Thu, 15 Oct 2026 03:52:18 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dominic P <gcc@gcc.dp11.uk>,
	qemu-stable@nongnu.org
Subject: [PULL 01/16] tcg/optimize: Do not derive s_mask from rotated s_mask
Date: Thu, 15 Oct 2026 12:51:53 +0200
Message-ID: <20261015105212.356392-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Dominic P <gcc@gcc.dp11.uk>

fold_shift computes s_mask for a rotate by a constant by rotating the
input s_mask.  The result is not a sign mask.  For TCG_TYPE_I32,
fold_masks_zosa_int then ORs in INT32_MIN, which can make it look like
one: after sextract_i32 x,0,8 (s_mask ...ffffff80), rotr_i32 by 1 gives
0x7fffffc0, which becomes ...ffffffc0.  A following sextract_i32 0,8
is then folded to a mov.  rotl_i32 by 31 fails the same way.

ARM, qemu-arm exits 255 instead of 7 (correct with -one-insn-per-tb):

    ldr   r1, [r2]        @ *r2 == 3
    sxtb  r1, r1
    ror   r1, r1, #1
    sxtb  r1, r1          @ dropped
    cmp   r1, #0
    movle r0, #255
    movgt r0, #7

i386, the same with rotl_i32:

    movsbl %al, %eax
    roll   $31, %eax
    movsbl %al, %eax      # dropped

Handle rotates like the logical right shift and let fold_masks_zo
recompute s_mask from z_mask and o_mask.

Cc: qemu-stable@nongnu.org
Fixes: 93a967fbb57 ("tcg/optimize: Propagate sign info for shifting")
Signed-off-by: Dominic P <gcc@gcc.dp11.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260930185124.3036980-2-gcc@gcc.dp11.uk>
---
 tcg/optimize.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1e4d2a0a425..c631f690afb 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2703,17 +2703,26 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
         z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
         o_mask = do_constant_folding(op->opc, ctx->type, o_mask, sh);
 
-        if (op->opc == INDEX_op_shr) {
+        switch (op->opc) {
+        case INDEX_op_shr:
+        case INDEX_op_rotl:
+        case INDEX_op_rotr:
             /*
-             * Logical right shift will force the sign bit zero.
+             * Logical right shift will force the sign bit zero, and
+             * a rotate may move bits unrelated to the sign into it.
              * Don't bother computing s_mask and let fold_masks
              * recompute from z_mask.
              */
             return fold_masks_zo(ctx, op, z_mask, o_mask);
-        }
 
-        s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
-        return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
+        case INDEX_op_sar:
+        case INDEX_op_shl:
+            s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
+            return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
+
+        default:
+            g_assert_not_reached();
+        }
     }
 
     switch (op->opc) {
-- 
2.53.0


