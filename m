Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFEDC8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSB-0000dy-UC; Mon, 30 Jun 2025 11:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRq-0000Th-BF
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:41 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRi-0008GK-H2
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:33 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2efb0b03e40so748281fac.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297362; x=1751902162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6TK1JZn6ykgJiG7bAj/R0ENVbAOSCznU44jivvGbwA=;
 b=xJjPmpnC2g1znZrukDeH/7geFkVxI67v7QNcB2JCLQa63+opCvjyLQdoqSoiYhJIiL
 2O96kcFVSunMKxPdniG7bRYo5gG5tM4sAg8rLmHjjPKzrQND8Jn84f/OYoVoa/fsDJYL
 jTeA5x8+M2WDI0gyIWcGZgbCUu8dIunwinUpa65psyF46nEhFji8dMR2hyP0tz0zaASo
 3dsD6R01n7pag8YHId364KwTdbZBalvUvsyQE+NwsPFbEQeXL59SPaeKGWPNpP5TGROj
 BjQNccuTRKYVKmtONUO7befmIL3OTxVxVkj1ZrMc2Uod3SUR+48PTeMaNV9/1zr1+WrS
 I4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297362; x=1751902162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l6TK1JZn6ykgJiG7bAj/R0ENVbAOSCznU44jivvGbwA=;
 b=Kdq7tqkJE3i3WZ6Hrqby9uifjBhBUijW7xksbzxLEo3Um1PHaKxpcGDASB6RWY+lhU
 4v0tyA2IsR1wq6jZmVA1bnAFrR/OGMkKU5lmItpLLPd9Lq/SIqTGjJvUalby8RFE4QH8
 Mvs6XmSDeFFSQ1lgp1o2Te1XuUGNGGJUkybY1HvkogXw/jVXnkUPdn398R10cjRRLUvZ
 dMp12a32tsFw85vZPl5B/JIaFIws9KMqC9qQfMrgSi1q8Risx9jx090SsDtSQQCAoOEZ
 qxONqdayb/7VZbnCaOdGkeynqCpILT6picwo6js2A5fqf/ymGimpR655vm2UWXmnP2fJ
 1x1A==
X-Gm-Message-State: AOJu0YzeJ7/pFfs4QhtAHFwpoUD9tMuA1Ex7NvzbX1bsuMnU9kSeCCZc
 tdvEqQafTg4w0AleM8mntMjU58azbDwjtaQVk/NER+h6GUHZ8oX9QXJqtftqbgeTZmWyyH3zIfW
 vBz++
X-Gm-Gg: ASbGncs7mpkIe11dvmZ6tmOsH8walCJS1UGJyNcpP3jo2Hh51gwxKFYuwJh0MZQbplR
 0fRSei2294kNK5vM29yTfSseoq2rrLPqwhRv+EXAbNJkBYGiKZXJstw7OX6/Qcuoevmin3R8aVr
 p2UvN7u5DCB/3m5MDC7OBlUUpwFSFIeUT14r7l5c7NWgNp6Hl1SLULGK6nv4ryApdHqqrA0QCLM
 dQlIDqYJVlnEcji7cS/XppkNOMHUKg1/hDBTo1p+3LE4n7oRyOSOtkBkBUBg2imtraa4Fj+fKOv
 Lcy62wtE3z1FfjtTPQLEetewrRscdq4c7DAwrawxPOirBdf480W6KjlqZ6OJr8TigD1HmEy1wnk
 m8Z4r
X-Google-Smtp-Source: AGHT+IEMnuATe4V0N7Z2H3W46yS6hHl5iUJJG6QyMdYHp9951mo1xqsVhQflPYoKy2F4LTXRoIQRAA==
X-Received: by 2002:a05:6871:d08b:b0:2d4:d07c:7cc5 with SMTP id
 586e51a60fabf-2efed497b0emr9044185fac.12.1751297361814; 
 Mon, 30 Jun 2025 08:29:21 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 26/29] tcg/optimize: Simplify fold_orc constant checks
Date: Mon, 30 Jun 2025 09:28:52 -0600
Message-ID: <20250630152855.148018-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

If operand 2 is constant, then the computation of z_mask and a_mask
will produce the same results as the explicit check via fold_xi_to_i.
Shift the calls of fold_xx_to_i and fold_ix_to_not down below the
i2->is_const check.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8d14a38f9d..a48ddd9171 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2326,10 +2326,7 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
     uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1, *t2;
 
-    if (fold_const2(ctx, op) ||
-        fold_xx_to_i(ctx, op, -1) ||
-        fold_xi_to_x(ctx, op, -1) ||
-        fold_ix_to_not(ctx, op, 0)) {
+    if (fold_const2(ctx, op)) {
         return true;
     }
 
@@ -2352,7 +2349,10 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
         op->args[2] = arg_new_constant(ctx, ~ti_const_val(t2));
         return fold_or(ctx, op);
     }
-
+    if (fold_xx_to_i(ctx, op, -1) ||
+        fold_ix_to_not(ctx, op, 0)) {
+        return true;
+    }
     t1 = arg_info(op->args[1]);
 
     z_mask = t1->z_mask | ~t2->o_mask;
-- 
2.43.0


