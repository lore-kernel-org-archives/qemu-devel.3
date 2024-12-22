Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44BEE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlv-0002x8-VT; Sun, 22 Dec 2024 11:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlN-0002ap-93
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:06 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlJ-0002zH-2R
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:04 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so37023425ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884699; x=1735489499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NUfpXkC8dy7CkOQ8+W7y3UlGToz+fRAfXgFSmgORkTU=;
 b=uy0+mv2n05BPimnAeKgrtgsnrDjOLTeOQDISCH3kZEX/qgHYnwpMVbPFOjtZrzc6pa
 ojHNuELATZ4S5OAHtLn/0ipUQw0/v61P3njnkNnkd+afkq2og96qQXf46vJQRc2FHkYV
 ryckcBPzy90MxamR5Jd7gYOD1jsuBeI/IMrAtk6xRFKpyKo0M81D2JMQwZlAKtOrlJYw
 3aMRiSBTADwppjO5JI98oYF2wHXj/HBNyOq7t9vBd0nVHSz2i9HqFvcOIxdNmZRAcBZ0
 kM4Od5kX2t7YB52eXQwB8Fu5+NKyaKg4v/edBFG4Top8qDaCTfRUZO4VPt5ScgY+Mr0n
 R0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884699; x=1735489499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NUfpXkC8dy7CkOQ8+W7y3UlGToz+fRAfXgFSmgORkTU=;
 b=oyqTbweY+FRF71vslVTu4rrPee2NK3ldKeH64YBp5SvRj5CppV/1esmeOQka9WrL05
 GoXKM71jgm23d+dDSdPHyFLotZ1pFL7d4KKYSUfrv8asv/J84MDqIMGyyl/hG/eyea8E
 64hTe9OK5yAU/F7pGyeBPQjRfPVw1D/qwq5zSwPvAbcW0fakJ6/54mxdewqVnpIn4hwQ
 QyWDofIOIRCcoWuwOlfgfDSvinGUJrD/tVybI22KuyqqxLlwwA5LzviqKNNhRvh+l5Dd
 ToMjFLjw/w6SfjAhxK9BWyHFjNNtoxOAfuao4GJgRf3TNkQW5MP+Zi/6k6r2zwRZSG3K
 5iZA==
X-Gm-Message-State: AOJu0Yzhfkjct4dy6qfc+Rol9K4+wRlgwwGmjnABtLx/S/QL2azGXGL+
 9pxPhacVzRQB8d5VrVFYggp6VMd3OAyyD8sXxSWO3YVWiRNX3uSm1isQJ7c1gYtNvOGtSqpYhJR
 2mWo=
X-Gm-Gg: ASbGncuRZV1sUS9fWSyKTmVLQTB5TlCS2cHr8HrVyttCyJoyQTNRWuUFcwuHgNqI3Ai
 NKIIc1qdaZdUl7r4tKOi8b5V0fHfrRVqAZxuhr2WcIUb9U20HibU2iwofBBaHI7Y3JSuR4dnk1Z
 NHQqe7OklYKQXPjx9670rrB/65Dc6+DpQU4Y+CSbiX+qYTOd60ZR2U9O1AJwzCDo2LUi2fA6nKx
 NfkFSpPnZ7YmxbdFDa1kv4PYyaoLeK9H34nU5kyOb4l2aaMTXh8D5Cf9GzoiaQ=
X-Google-Smtp-Source: AGHT+IG0BWfMY9U2zRS0hyYUKOhdxYMn1w6P3zGX0DrMXby8iG/cC2+JgEQYnnvWGJYwqZLT2sJ/AQ==
X-Received: by 2002:a17:902:f602:b0:216:3c2b:a5e5 with SMTP id
 d9443c01a7336-219e6ebb682mr129995655ad.27.1734884699199; 
 Sun, 22 Dec 2024 08:24:59 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 18/51] tcg/optimize: Use fold_masks_z in fold_extract
Date: Sun, 22 Dec 2024 08:24:13 -0800
Message-ID: <20241222162446.2415717-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Avoid the use of the OptContext slots.  Find TempOptInfo once.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9c1fba00fb..5aca1b3c38 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1722,25 +1722,22 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
 static bool fold_extract(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask_old, z_mask;
+    TempOptInfo *t1 = arg_info(op->args[1]);
     int pos = op->args[2];
     int len = op->args[3];
 
-    if (arg_is_const(op->args[1])) {
-        uint64_t t;
-
-        t = arg_info(op->args[1])->val;
-        t = extract64(t, pos, len);
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t);
+    if (t1->is_const) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0],
+                                extract64(t1->val, pos, len));
     }
 
-    z_mask_old = arg_info(op->args[1])->z_mask;
+    z_mask_old = t1->z_mask;
     z_mask = extract64(z_mask_old, pos, len);
     if (pos == 0 && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
         return true;
     }
-    ctx->z_mask = z_mask;
 
-    return fold_masks(ctx, op);
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_extract2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


