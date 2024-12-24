Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524D7E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAy-0004GW-DE; Tue, 24 Dec 2024 15:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAD-0002up-4m
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:58 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAB-0002d6-KQ
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:56 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21683192bf9so61844195ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070754; x=1735675554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BIzmSJg2IBNvRjDTAJOD5BUlfsyyTZSbfZK35bezBU=;
 b=e9O7fo3m2xxQZD+MrWBnhPaYYVk39jM8kNseTGCP2PwzAIGJxHz6wzZCBlwZ2pknvH
 ftr8dAVn0GL/BxsbXJJPagP6xu9MPYRKpGgM0fZY3al0hy4r9buDBykwWNdTgG583gW7
 VFvGfkYXgTI6CEsWoHHn+H7j25Gni/PLg72sOFBMLZeEHNc9xH3TpKJK5UQukGYCuvZY
 efSC5KgcEZ5JWbFnn1VTwpadJ+cUVIgG0YFzafUttIedmNkn9xz0/G8peH54AqgSBWz3
 4nsVOSHmQHH5/hZLT/o/Cmbv0HuyWpVNkJ1g71OrZE/jiA26egFOvyLrG3bFqXwInje3
 lFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070754; x=1735675554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/BIzmSJg2IBNvRjDTAJOD5BUlfsyyTZSbfZK35bezBU=;
 b=jE3+F7T7IfIrLoemcrBTBuosM18mJtTPIgWI2KKGWCknws9Y5n3zdl+YC40kYgkD3Q
 r17DJHGrBmEHYO7P83QsBLGyNrQM+TIJpa+VOO9XnBaMAc01EBPoQm+chWRz0RAQKaCm
 IRTIs6ON4UJBJ2Bl0IkwnarbdpCiCEcw03wLp3fObD98TnYNtoqZoqhIOVETMNG+HBLI
 RGcEzjfaGtSkB+Qa9dyzqNrOJHAzAYE8bvBTa6jIdFBquqiXVfkJkaxOo+FEhgVRYWBu
 4H6EIgkGnLOy1jOAloZXOjkAKkzUSV8H2Gn82GRk7NgCeIOPi2zUr87dUBlRcZPrMT7E
 1Cpg==
X-Gm-Message-State: AOJu0Yz2jek1ZIK6Yabuz3QBwQmJdlG9r9hT1fvklhO8laGZjY8O2b79
 k0W/UlKdwbO5+EnC0d9X798gH9i7JACZt3PtGusTk13ZA8qF7ohWbQxMtv0SWCOutDyXtuDylIr
 4H84=
X-Gm-Gg: ASbGncumC008be/FFVDPpKvb6jZlq7adldF3fHLgHj32b2EsPhgRQmFHSdsT0P6+25c
 B8Ga5ty7Z5nK3NzrjZft8mcWHB+SlUJdKbWd0fDGpk2TzOT/OoClFUMDwsZWDPmMdCaJfN4KfN0
 ZcivGcpv/TcbKGsTH2W5UgsTHIQjkKVKeVd5EXsAYiKvw91DWrQUDAZObkqZkSe1GOgCfGho4Y3
 wdwCr0PF6BxMtc84HgdESbhD44ldc3cW4+3XtVanWjk0Rh9LY+OKFsdLti2wSLGrBckNyv9ZnRa
 L4EtWKPV7X89o8lbzgUjLfdviw==
X-Google-Smtp-Source: AGHT+IF65FuvGmVtOqnWIzTLiuuH9JlWod7Ax+vaaY2itZYA44QCU5hVb2SluvTrNW9NnXxZ0jgAKQ==
X-Received: by 2002:a05:6a21:3987:b0:1e1:ccfb:240 with SMTP id
 adf61e73a8af0-1e5e081d78cmr29133019637.41.1735070754356; 
 Tue, 24 Dec 2024 12:05:54 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 34/72] tcg/optimize: Return true from fold_qemu_st, fold_tcg_st
Date: Tue, 24 Dec 2024 12:04:43 -0800
Message-ID: <20241224200521.310066-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Stores have no output operands, and so need no further work.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 7bd17a36c7..07792c5351 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2143,7 +2143,7 @@ static bool fold_qemu_st(OptContext *ctx, TCGOp *op)
 {
     /* Opcodes that touch guest memory stop the mb optimization.  */
     ctx->prev_mb = NULL;
-    return false;
+    return true;
 }
 
 static bool fold_remainder(OptContext *ctx, TCGOp *op)
@@ -2706,7 +2706,7 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
 
     if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
         remove_mem_copy_all(ctx);
-        return false;
+        return true;
     }
 
     switch (op->opc) {
@@ -2730,7 +2730,7 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
         g_assert_not_reached();
     }
     remove_mem_copy_in(ctx, ofs, ofs + lm1);
-    return false;
+    return true;
 }
 
 static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
@@ -2740,8 +2740,7 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
     TCGType type;
 
     if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
-        fold_tcg_st(ctx, op);
-        return false;
+        return fold_tcg_st(ctx, op);
     }
 
     src = arg_temp(op->args[0]);
@@ -2763,7 +2762,7 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
     last = ofs + tcg_type_size(type) - 1;
     remove_mem_copy_in(ctx, ofs, last);
     record_mem_copy(ctx, type, src, ofs, last);
-    return false;
+    return true;
 }
 
 static bool fold_xor(OptContext *ctx, TCGOp *op)
-- 
2.43.0


