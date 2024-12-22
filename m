Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F93AE7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOpb-0005Qs-Nw; Sun, 22 Dec 2024 11:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOob-0004yT-BJ
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:25 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoZ-0003k2-R6
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:25 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-725ed193c9eso2995659b3a.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884901; x=1735489701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmhkoZPz1+ScFaHu09NYHBzvHbi5p/B+3zA/reryXoQ=;
 b=XPWuAhTZwn2gm7eoTT3Q0CmKm/ETW/6SjjMy7UoUAdD/9NrGDz1dOINPm10LPtPtz9
 Snubpz/37pJKBrX3fLYI6ywXlSQUCxgg/+Z6UkPFAUkFtpf0hj6KerksAVV76kHRJB85
 B1peHau/Pln+vlk2xGl7MKbVJBwAaeqq3g/UepUCZ1PfDHyuRVRju8VH7DoJxc2e6wmg
 oi6D85BETMNc8fAWyHUiKa79LKaiM+TmQDq4lwPCqBv9OBHoKDsTpmWYg+my1lBYJS09
 qx1ur/GVmuro4JOEuB2JSdY99bLZoQkEg9FIX6AH4R0vBFEtg/Q68ujv9MqJ7NWKwsYf
 UHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884901; x=1735489701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PmhkoZPz1+ScFaHu09NYHBzvHbi5p/B+3zA/reryXoQ=;
 b=sn1MMIBpWlmZLK9kv2ejCOVkp5Bx+qbUxEi1SkEj/vjBAvzcpP7n4Md87BdeMYQQT/
 dkJxkbMU3j2+WB0gwEKkT5+tGbZr60UnsHp37KW/x6kbasvHxN4HI9fbWScbxi5EPFse
 Ux+J7hpdnRZ2rhA78hQXjsFmsW0XCK+ufMgPML08DFr1MVRCupdVmL0vT+CnN19afTPG
 Ng7mAZVQ3VvKfRLQZcBi5dn8/b565BHGj6oMl/ZFUQ8x6zwPPTAG/8EIH62Dno6rYqZR
 vlKd5M6NA99DOSyonRNkyugcDhx0CIKuIUxGTaT6ss9O5dgj3cApEPzWptjNPH8ScdcW
 uyFQ==
X-Gm-Message-State: AOJu0YxmPtbCghe/oQvEdFDcRwr/Vq05wU9tYAhaQ9NYGYZB1Isp+EnR
 uwTWhMBE13WYHoJOKFzBRVxr10D8mOnQ/Gw+rHgfuNHzpMkKfRikuPSGlUOi9No/XYmBKjDhfNQ
 JB3E=
X-Gm-Gg: ASbGncusnnpIh/NwTFIMKIM0MN1ENMlbm1UYLT3qHM04nY36eGb4x+C6qkUHCP8z29r
 ngqQTWqnkrBFSNgfpOVqjTYFF1/+txDMuVpFlodIzGyYagKASvihycz5pppqyNW6i1Ke7Vg9gB/
 dde9AmySWEJiRoDdRRAB3/ISJzyVSKJ2wDYA0HJoCKcr+1RpAmoNYLhEpwgSzFBbZpIa+B0tiJv
 h0IwdgiWuaLpn54+8rt6WM0jqfkYc8GIfulEjwYa521y23NG/q0RB9gpW5XE5w=
X-Google-Smtp-Source: AGHT+IHhfgYEITaL5zAiKCd+zU55X9257Uv3JUAeRR0eQW4tn5XnKQ2LrKz2lejd5Ty+M7aQzqWxTg==
X-Received: by 2002:a05:6a21:7889:b0:1db:ff9c:6f3a with SMTP id
 adf61e73a8af0-1e5e081c9edmr15300033637.42.1734884901119; 
 Sun, 22 Dec 2024 08:28:21 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842dcaca43bsm5848808a12.66.2024.12.22.08.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:28:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 48/51] tcg/optimize: Remove z_mask, s_mask from OptContext
Date: Sun, 22 Dec 2024 08:24:43 -0800
Message-ID: <20241222162446.2415717-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

All mask setting is now done with parameters via fold_masks_*.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 7481b59d59..902c219032 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -64,8 +64,6 @@ typedef struct OptContext {
     QSIMPLEQ_HEAD(, MemCopyInfo) mem_free;
 
     /* In flight values from optimization. */
-    uint64_t z_mask;  /* mask bit is 0 iff value bit is 0 */
-    uint64_t s_mask;  /* mask bit is 1 if value bit matches msb */
     TCGType type;
 } OptContext;
 
@@ -947,13 +945,6 @@ static bool finish_folding(OptContext *ctx, TCGOp *op)
     for (i = 0; i < nb_oargs; i++) {
         TCGTemp *ts = arg_temp(op->args[i]);
         reset_ts(ctx, ts);
-        /*
-         * Save the corresponding known-zero/sign bits mask for the
-         * first output argument (only one supported so far).
-         */
-        if (i == 0) {
-            ts_info(ts)->z_mask = ctx->z_mask;
-        }
     }
     return true;
 }
@@ -2862,10 +2853,6 @@ void tcg_optimize(TCGContext *s)
             ctx.type = TCG_TYPE_I32;
         }
 
-        /* Assume all bits affected, no bits known zero, no sign reps. */
-        ctx.z_mask = -1;
-        ctx.s_mask = 0;
-
         /*
          * Process each opcode.
          * Sorted alphabetically by opcode as much as possible.
-- 
2.43.0


