Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BB0E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL29g-0006hE-Mj; Tue, 10 Dec 2024 10:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29a-0006KO-Mh
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:04 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29Y-0000JB-Ip
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:01 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5f2b71bdeeeso993865eaf.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844479; x=1734449279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G5qyspCYN19hthHdUnJwpB6rA6TWvsrls4PjVzoBXSI=;
 b=YOjQPRgPKSRPGG0vdK5PK+fbwotPS8ZwbygrXBTO2xN3rs/9YlIibk1WDwv6e2NEP8
 uDY04XsvBP3JzzMOgfEk/zobbSoEtWCjdDeTU4S1zd8/xgcOYOBGI5c3kG13xPN1ZLh7
 2QoIvJvV02a41eBjseqMbsOkE+sI8n0p95GX3hiJBvbHlVk2hWVLIxYsqBrSP89WfACr
 sxC2pWiqjj4yD4l1jipzGN+h0L70K43kTl+CZp6csGgEXo9TiyYm48BWTbutVNq9eBc+
 41NtWxg7NVwBVbh5jJlNz3AyVbr+2whqnTCjbQOg8TY+cx7VnElIHSoO/olnWqlsPqSy
 v5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844479; x=1734449279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5qyspCYN19hthHdUnJwpB6rA6TWvsrls4PjVzoBXSI=;
 b=NR0fqrB2UygQ36mpkYYppysl9aQJiFQglOOVaO7PcPuDI3DnK+qsqouifBOlmgroit
 yO75bsh6apkUvrFbAbj9dYUFHho4ONpT30PtR3CxjkP/rFZt+QO72jVVgG75q7p4luFd
 aiFjIU/crZrXMbHzZROx34C0y3SlZWq64NEw4dhFTqh+rhQqZGV1w33Ox5cBueuTKwpQ
 PY1aduwfQhi73oR/UFdWvSmg6DZuzk5CURBR8UBumiP8jZhI6a5OG1VcGuOY2jG76weI
 xNxaqq8AnMvtpTm9AG2RHTWhkYN+ZsfrJwEgVRMcN/sbmGjHjE1/KO/rj1EEewx78CVj
 cagw==
X-Gm-Message-State: AOJu0YwkGjeY7Rw/bAu/TTDkulvHD5SOl35b+i20HMpnS9dY0xcveHUP
 Avsuaju99a7nkyQKxeRl0Sy71TatJK/cInwCXi3+RJ4O2c9KbZHFYpVECL2R24hNn59qNVrSgB7
 +o6Yi/k7r
X-Gm-Gg: ASbGncuuJNXvW+SnYW/n48vWP8/r0MwQwUxvSmfoJqPE8G49opvCIa+h64iasYzIFH0
 pi7FVwMg29d9voVzVEXFXOBOvA0NdeVrwJzVXfDdU4vbTI/vgIKzUFYr1hEyOoe3MDWwPKqnw4Y
 57oeQoAb/eOzgJBGY2/4NbkEbS2XevexOX2It0mAUOSI9xCNjz3zto3HQgupndc/Pv6+EoHoekA
 vHv1HsqDsIh8n+rGPBiZ2rZFX5sFbohWrOCuR1utRouIAoEzbKC12xrT51PHA==
X-Google-Smtp-Source: AGHT+IEFIcNxIXy4kJr9GoQwqCWZbIv9Mu6ePgk0HoSPnT95vc1xL6PsnV0e+YD2Z/uRqm0OrQlMqg==
X-Received: by 2002:a05:6820:1a05:b0:5f2:c4c7:390b with SMTP id
 006d021491bc7-5f2c8bed69fmr2900109eaf.2.1733844479272; 
 Tue, 10 Dec 2024 07:27:59 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc4a0267esm2785955a34.52.2024.12.10.07.27.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:27:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 41/46] tcg/optimize: Use fold_masks_zs in fold_xor
Date: Tue, 10 Dec 2024 09:23:56 -0600
Message-ID: <20241210152401.1823648-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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
 tcg/optimize.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 46116970f3..fec46014be 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1093,11 +1093,6 @@ static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
     return fold_masks_zsa(ctx, op, z_mask, smask_from_zmask(z_mask), -1);
 }
 
-static bool fold_masks(OptContext *ctx, TCGOp *op)
-{
-    return fold_masks_zsa(ctx, op, ctx->z_mask, ctx->s_mask, ctx->a_mask);
-}
-
 /*
  * Convert @op to NOT, if NOT is supported by the host.
  * Return true f the conversion is successful, which will still
@@ -2758,6 +2753,8 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
 
 static bool fold_xor(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask, s_mask;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xx_to_i(ctx, op, 0) ||
         fold_xi_to_x(ctx, op, 0) ||
@@ -2765,11 +2762,11 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    ctx->z_mask = arg_info(op->args[1])->z_mask
-                | arg_info(op->args[2])->z_mask;
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return fold_masks(ctx, op);
+    z_mask = arg_info(op->args[1])->z_mask
+           | arg_info(op->args[2])->z_mask;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
-- 
2.43.0


