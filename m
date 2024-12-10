Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75B4E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL27n-0006BI-1P; Tue, 10 Dec 2024 10:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26b-0004l6-G6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:58 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26Z-0008QH-RF
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:57 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eb7934a948so173810b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844294; x=1734449094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DObOGllSB70fmbIhwRk8zrVb8ETW7KIGs2THZc+KVkM=;
 b=yxvdqPGFZ5HcF49IKrZO/kIPFb3YWBYceyQxn5jpmu6hjI1aonzSxHrCZ21qdITJYK
 r1JksP9l01hrOQ5HoA25HexkoHGqPU05+nKh3LEt/qirZIOGER5B5P6HbhYytDmzjBXO
 UYcNhSgQWj8eDo5CVu8BwsPiwBXeGL2tdr6jsr79v467h6Dr9x/U6kd6RDy9f2tG1aZG
 I/daeaxYwDKokXruTS2ului9R7aBTxjxp8rsGhpwUj6FJOq+1zcf9vCZAmtQr1W3c1H0
 NgtDJ0OE0tnQUZzCY++9kwo6bHCKX65xPRF2UZVcQp8IYyfgJ93H6nvci29a1nfb4dDG
 Tfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844294; x=1734449094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DObOGllSB70fmbIhwRk8zrVb8ETW7KIGs2THZc+KVkM=;
 b=AbyjIRBlisTY3mItto5MFFRkKYeRFgOWpw9s3aLgBzfQ4KrgEs2q/karDz5FWCPnmI
 xsKyKJVIXxNwo2xS81aeFPTuURzBkEKzU1/rss5EqASVsAcICDOFcfvKHaatz3mDFUdI
 hmoXMl764yDz8pplh/pP6qdBvSGCwIBzV5mxLjU9tS8ToAAkgBVEgKlKxKq+yHDwjR1B
 43B+Bs1u7nI/fhq3Tm2ConIv6l6bCo1QRRcmj5OHiy0pJrCTsWm1AsEJHaudZBpF2qG8
 w2kGA8IpyLgtqG1zfGMSLrDZNNH65PujvhIbjiWMpmAMm/h+BoyibRU9UAQ4Yehu4CM1
 vkMw==
X-Gm-Message-State: AOJu0YzyclLrSEkNtTrVPBsIGq49FO6ykt9ZqDkNj35feNeRhfXPHEwS
 YRGTnpPCqF9o87/snxFa3kpW8MofxzCBHwzQnS4D/JWW4kKaTaGSQ/NeBbNi/Yu+9RKxQtY4jV+
 Q4IESSM6z
X-Gm-Gg: ASbGncs39iF9oURNpiXGETmz5SiAv15QboAK5gouQ47VdrzyElgznSiAL++cZ0mbHVL
 X/b7t8dAPeFACkZiBZQeuFr70d0rcNmlUqYZrHDxqqN2gca7Ixgcevpe5GMRp3CTWHFy66zl6zh
 4wEJS44UL+NWrnJylYChtRVj4qaxpcgHfUaWGqOzP/KHE6qteGSQb+OWsAyFHr92llGYDx8rv9y
 hL4CksXcB1i6rjYNlbcJqQksQ9VfDSTHnUWc+0ORxmhQEN/6fRWYWKa8NsY+Q==
X-Google-Smtp-Source: AGHT+IFWZ3q/uHB6lW7pWFELD3dqpZ0zHLQGR1i+VSzSYIJuHHkaW2g+BhBNttbBrXP6XZa6IJyvgA==
X-Received: by 2002:a05:6808:1805:b0:3eb:5e08:f806 with SMTP id
 5614622812f47-3eb5e097668mr4544792b6e.29.1733844294527; 
 Tue, 10 Dec 2024 07:24:54 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 37/46] tcg/optimize: Use fold_masks_zs in fold_shift
Date: Tue, 10 Dec 2024 09:23:52 -0600
Message-ID: <20241210152401.1823648-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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
 tcg/optimize.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 551f96dfaa..bec5a07288 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2530,12 +2530,12 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
     if (arg_is_const(op->args[2])) {
         int sh = arg_info(op->args[2])->val;
 
-        ctx->z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
+        z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
 
         s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
-        ctx->s_mask = smask_from_smask(s_mask);
+        s_mask = smask_from_smask(s_mask);
 
-        return fold_masks(ctx, op);
+        return fold_masks_zs(ctx, op, z_mask, s_mask);
     }
 
     switch (op->opc) {
@@ -2544,23 +2544,22 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
          * Arithmetic right shift will not reduce the number of
          * input sign repetitions.
          */
-        ctx->s_mask = s_mask;
-        break;
+        return fold_masks_zs(ctx, op, -1, s_mask);
     CASE_OP_32_64(shr):
         /*
          * If the sign bit is known zero, then logical right shift
-         * will not reduced the number of input sign repetitions.
+         * will not reduce the number of input sign repetitions.
          */
         sign = (s_mask & -s_mask) >> 1;
         if (sign && !(z_mask & sign)) {
-            ctx->s_mask = s_mask;
+            return fold_masks_zs(ctx, op, -1, s_mask);
         }
         break;
     default:
         break;
     }
 
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
-- 
2.43.0


