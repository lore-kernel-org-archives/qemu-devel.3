Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2686E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL25v-0004Cj-Ii; Tue, 10 Dec 2024 10:24:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25u-0004Br-1y
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:14 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25s-0008IZ-GY
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:13 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3eb45232717so1257886b6e.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844251; x=1734449051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KR0lekQhiKivBMDP67KsxynVb4xquNEZz8S0WP9LF84=;
 b=SwuK7/QELQ2OiZkKdkvE0OdFFFCHkJ55XlwHp+mCgBAsnZN4NdtVJpbnDvcHH+3N4J
 maA2dWIBDiDJfzLQFy2GpOQn9rcCK7+InKRQnQyLDnQm5xnPcIEhNRPa8I2QJ4+p+Jx4
 /jQ4ebE64PXp/+mJNnAU0/WSNTIMJbJlwEfHl9c0jMHxEDDu51ejBClBOIfew0vG8pP9
 SdcEFu1WIP9O6BB1EVb3ooZEmnqAbx6wErwsZ8NqENAlu8Jp+yyrUTL2EL6Tod0Dy+vP
 9C+6tDAxLMGSThKSTslbV/DUPuLZI+Bh7X8Lmvlmu3HyVPL46xLJBcsUCUVSWjmEqs3P
 apfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844251; x=1734449051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KR0lekQhiKivBMDP67KsxynVb4xquNEZz8S0WP9LF84=;
 b=L1Y64mSI3wq5Vj7Il3ubZVLiJ3XT5b5bk5WfbROE6kGQ997lS9tPnJMYnGbUAssFn1
 D/eZ19bzqCygk2mHPEcw5/DitKcdFIpg1aVDOJlKbCl1uwYP7bKfXHFjleRyrBPb0EtQ
 yOehFPlsuLFHRXyZPVQILOOBCr4GgSmuC0aX/kmw1Jiqr9PpfEqwj9reQFbjF6JDDfGS
 cS1PSrGtmm0ujtb6yx+CFVGTzWRcdxzgFWhc8A4uVRe20ZmCVkb53GOaD5LDzmNrLUpV
 bUUsJLb8OlQSMIcnE58cTN4P52ZBNTOGQIWnbEEqq6tsMegnDAq8mo9+FAU20pdb6CUV
 VmcQ==
X-Gm-Message-State: AOJu0Yx/ztdKn0x6RJFQRquq683FeWxiGotxhwg/z2Corppe+v+4nrWz
 olIweoDt3rkhXwt5+3u+zFF6ANM97h1tcOOzWKSbFBTwjw1Uw8uQQ2L9Hw6/S0dkZ+4aCIU5sIt
 r3v6La0ne
X-Gm-Gg: ASbGncu6SBSwTt3K55jasGu/bhDpa8upWi8buiKhfduFWlkZ4U7QvAiM3nxZrmyCiXE
 Q8i4HyDtNrX9kf/gCN9dGtidPqdfSw+9i6pv+73F1fvn7z0uhQbWQRd/4s8RoYTozMxR3T3Jvvz
 GwHk3YAbWN34a9ekJp9XrlS5fCxVQSycVYUN8USukAyzhoIG1ApQ7GBamtAf+UzFigod84k0++P
 2CUyir3LI48vOE4U0CkJB6v8qUxAEiW7p9BIGsc6BYl1uHVCvSv3P75AadtMA==
X-Google-Smtp-Source: AGHT+IGULme0b7BE3NnRoetIc4Z9NoeiWlWfR/yE4XiAanbzDPWl9CgaZ6Cyk2wgYBav0NpbYPC53w==
X-Received: by 2002:a05:6808:10c1:b0:3eb:71d7:246b with SMTP id
 5614622812f47-3eb71d725b5mr1455984b6e.39.1733844251092; 
 Tue, 10 Dec 2024 07:24:11 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/46] tcg/optimize: Copy mask writeback to fold_masks
Date: Tue, 10 Dec 2024 09:23:17 -0600
Message-ID: <20241210152401.1823648-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

Use of fold_masks should be restricted to those opcodes that
can reliably make use of it -- those with a single output,
and from higher-level folders that set up the masks.
Prepare for conversion of each folder in turn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 20c918e83b..1a9e3258e3 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1050,6 +1050,11 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
     uint64_t a_mask = ctx->a_mask;
     uint64_t z_mask = ctx->z_mask;
     uint64_t s_mask = ctx->s_mask;
+    const TCGOpDef *def = &tcg_op_defs[op->opc];
+    TCGTemp *ts;
+
+    /* Only single-output opcodes are supported here. */
+    tcg_debug_assert(def->nb_oargs == 1);
 
     /*
      * 32-bit ops generate 32-bit results, which for the purpose of
@@ -1062,8 +1067,6 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
         a_mask = (int32_t)a_mask;
         z_mask = (int32_t)z_mask;
         s_mask |= MAKE_64BIT_MASK(32, 32);
-        ctx->z_mask = z_mask;
-        ctx->s_mask = s_mask;
     }
 
     if (z_mask == 0) {
@@ -1072,7 +1075,12 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
     if (a_mask == 0) {
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
     }
-    return false;
+
+    ts = arg_temp(op->args[0]);
+    reset_ts(ctx, ts);
+    ts_info(ts)->z_mask = z_mask;
+    ts_info(ts)->s_mask = s_mask;
+    return true;
 }
 
 /*
-- 
2.43.0


