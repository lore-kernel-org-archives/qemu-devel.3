Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FB5C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSC-0000f1-UP; Mon, 30 Jun 2025 11:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRl-0000Sz-Qy
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:34 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRb-0008FG-NZ
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:27 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2ef493de975so1457043fac.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297357; x=1751902157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fEFba83PMta+Yg5bkX3XrQ6GehU8yhJygO/yADzTlOE=;
 b=EbthRygHQylIndNHcJYbcgM4alhNEI5MiQdJ/qJ6Vu2qK8JE0LuEPop8/9qzTP3N8S
 NuACIAbVjVUxSpK02TcCGmGJnoCMJXwTlB1K1U6yQ06Btr1Qp6YfGfJ6YqAKnDJIypXV
 GcX1UAWbxXf3DN/GDtFHGJZR4w470p9S3zpyO4dJbkIX4KVlsE+OhnDlqgCsUDd4dz4i
 4avLfuI9nhqv2DuOaXZseDYjDWwiPFJ4ciNziV3kuyjb3zcgmK5Kz0f0NDXcijTgIjJL
 AiVzpBPoFV95FZ5QsBrIVUvcUDFAbZyLRosnw5uYuZ4fFnFly4dMs1+WUulqi6La3t7i
 26ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297357; x=1751902157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fEFba83PMta+Yg5bkX3XrQ6GehU8yhJygO/yADzTlOE=;
 b=RS9yGoUVTdN0jVzFBALLJcXTIsnHFISveEKur6Y8SsraFWOjrZcBX3heDRe1pvm3Al
 H5ls0smE9sGWahTu4nYUDDhfMOo8HyQDYYLbQX6uVILlZa+Pb0/WcwVnYqpmgLChWpGQ
 KG5mH9juxxD0Ft5+wHX966kvkIt0fXH+eFk8rUu5nVD3RrJEMHvIlWSopF3CDmzalo9q
 kuVh2nnomT6r9BAGwt091sA6TAbeTBLRSdmZ+G7JDC108qsU4ulkOlqPtIHP8wrKA2rQ
 ffaZmyiJDueljlMpfpB7h3ZqRtvCAt2OeqV2fenEXeL4IJbZ7bSQiBS4YgxMVOQq9PoC
 9DSw==
X-Gm-Message-State: AOJu0YzYXbc32bhGhFKXK1ioLX/JQyaMRCQHzeifJdrQ1clBeGhEtKud
 BQsiiBqVtLeLmRmGhix47x2uMBYA/7j5jqcDAclQm5DWSaHjcRUKZ+K72mdocBS/PRPTNCFJSZl
 TFmeL
X-Gm-Gg: ASbGncu3jt2DMFiHQe8QIzOennzuiAiHnNgDBwhWKMo0s9J/xqsusi9U5EOUyvd341A
 0eUAS97M10j4hBsEdCPR9NX7x3f8XceMi6ujld85E84Jo/KAxmrQ1hqwsnYekHM4r/z914jqbYE
 4kxc/5NXO7VDo5gpV5j/MwzOfHK0kEekFWqofc18c0Os/OU2C5HV827RZcG8QgNxewE+Ugxj3L9
 jR8xlFXnCHKy11f+05MQDjjpOUHH8BB9dzhyp5nARl7I7POYwKij0xqrb83lp9fr4Uxgm+0nuaf
 M6ouFsjB8nzjCiq75VdzVHz0CFo0eBLob0Bxl3iiKRb9+0RGx94YmrWeuJS7vtwpFx6V0g==
X-Google-Smtp-Source: AGHT+IGsq9vNnTw5a4n2NHLNcp5aK4hXXymgmO7UqY+jhUUqS1Y8sgcYfGGTGOisG5XE+IRH74ru3w==
X-Received: by 2002:a05:6871:a603:b0:2d0:4a2c:7c22 with SMTP id
 586e51a60fabf-2efed695c8bmr8773468fac.18.1751297357296; 
 Mon, 30 Jun 2025 08:29:17 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 20/29] tcg/optimize: Build and use o_bits in fold_sextract
Date: Mon, 30 Jun 2025 09:28:46 -0600
Message-ID: <20250630152855.148018-21-richard.henderson@linaro.org>
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

This was the last use of fold_affected_mask,
now fully replaced by fold_masks_zosa.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index abcbee9111..673849f07a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1121,22 +1121,6 @@ static bool fold_masks_s(OptContext *ctx, TCGOp *op, uint64_t s_mask)
     return fold_masks_zosa(ctx, op, -1, 0, s_mask, -1);
 }
 
-/*
- * An "affected" mask bit is 0 if and only if the result is identical
- * to the first input.  Thus if the entire mask is 0, the operation
- * is equivalent to a copy.
- */
-static bool fold_affected_mask(OptContext *ctx, TCGOp *op, uint64_t a_mask)
-{
-    if (ctx->type == TCG_TYPE_I32) {
-        a_mask = (uint32_t)a_mask;
-    }
-    if (a_mask == 0) {
-        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
-    }
-    return false;
-}
-
 /*
  * Convert @op to NOT, if NOT is supported by the host.
  * Return true f the conversion is successful, which will still
@@ -2669,7 +2653,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
 
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask, s_mask_old;
+    uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1 = arg_info(op->args[1]);
     int pos = op->args[2];
     int len = op->args[3];
@@ -2679,16 +2663,14 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
                                 sextract64(ti_const_val(t1), pos, len));
     }
 
-    s_mask_old = t1->s_mask;
-    s_mask = s_mask_old >> pos;
+    s_mask = t1->s_mask >> pos;
     s_mask |= -1ull << (len - 1);
-
-    if (pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
-        return true;
-    }
+    a_mask = pos ? -1 : s_mask & ~t1->s_mask;
 
     z_mask = sextract64(t1->z_mask, pos, len);
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    o_mask = sextract64(t1->o_mask, pos, len);
+
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
 }
 
 static bool fold_shift(OptContext *ctx, TCGOp *op)
-- 
2.43.0


