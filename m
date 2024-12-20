Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEBCE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUQj-0002p1-E1; Thu, 19 Dec 2024 23:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPV-0001YR-Mv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:49 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPU-0006rL-2B
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:45 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-728e81257bfso1357597b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734668083; x=1735272883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jULyl7u+QKbWOLYYhEW/2BBIfmsvWodRkVtxb7KDSes=;
 b=fOsnTLm1bzJd2IkkKD16lFemy5eFKLUxEeAu9PQaNRxDvgTa3AKw8Pl+x6uhvm8rOy
 9lX0t9VQnLIH5leMRfd36vmZTF6J7QBZngAR1/KcaGnrPAahoD/yheVww3AktuDd9uDD
 XD/frzc69MN1CwFJBMUuCB43raUMIXeRAUvojLymCKeIfRoTogvlfmN1Vr5ytQmansgc
 D09C7fKzK+eh50QamszsZH+jJAW+JXyjsszzbEJgTm7rov8SEnvFOnOrDvX9UriUG942
 U/geqU2EWz0/Ye8kG0sPZj/hkqMVDL5+xFQrE++eiMYkkCGkq3rpg+pFDvSWpp/pAUCC
 pDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734668083; x=1735272883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jULyl7u+QKbWOLYYhEW/2BBIfmsvWodRkVtxb7KDSes=;
 b=WyWrsaGun6PERWHuAIDSEm+12XJMhbA4bMD1eyJCKstuJTU7UXEY+30G76Vmgil9IZ
 LqjsXbXWxVVSZQxappxBh5JT3PdfzxiPaxDRq0REXQP/hzY66Qx9IPqLLoB0NDdtXXJc
 +2QLV5BsQvryszIf9vgH3v3SajfHvAVKauj85G2Q6ld3/7YbT3C3EDUTwNleeIN/MBWL
 epSZ2PaeP84jQ4SCOKVug2NYy1lodihr+Qqkv6+ywrUqVNOmtYpM3WnvY035Rk/Na+cl
 RLYnJaKxfKJ4L8r39mSyTPFl6lq6mwKJUcf4QSMQylAek4JxPidYHp+gsWKwLLin7Lys
 hjBw==
X-Gm-Message-State: AOJu0YwlPEJMTBDi0OKuUmX4wifAUHHLkduTBYbfcyT8NrIturHpYkTn
 MwpJ2/xMTSX/LAzpjyy3yosHMNlJIv27jKtjpf67FawSmXK1mDueWQ7FUhRsnZ2ivbBeJlX5zFw
 S
X-Gm-Gg: ASbGncsS2m2En9X0Fj6Ir6LsU/JegNM+YIRgzRBbt8YCpRu2EO6uPAaLlxSMATPgjPS
 WLEBwfe5et8bVhfQOHAiHFOGppQIxnGV0ckNu5O7FV+FfVlxrcQNziDbbGbxHppN5atMMhDiGpG
 qFs/RMnIB9ROwjaSx1LpXcLkN24tmwQN9tOov/cY1i6GI2A2DAFJFWnqINZL3LLw6zr4d/d6GnD
 lQVQZ4YzCtN8IJqErEEcq7EzlVMnXH/PX7JxLzqHrDcsI08qqfWkNERA2k0a+E=
X-Google-Smtp-Source: AGHT+IGYrckfjn7ZpNDZAugLzW9SEcHUs83GB6NRWUjIFBHlzotmIBK/goG3sq0MSweBuG+j4//f0Q==
X-Received: by 2002:a05:6a00:44ce:b0:725:ea30:ab15 with SMTP id
 d2e1a72fcca58-72abdd5efb5mr1743062b3a.1.1734668082624; 
 Thu, 19 Dec 2024 20:14:42 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-8529e78a55dsm506952a12.80.2024.12.19.20.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:14:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 49/51] tcg/optimize: Remove z_mask, s_mask from OptContext
Date: Thu, 19 Dec 2024 20:11:01 -0800
Message-ID: <20241220041104.53105-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 tcg/optimize.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 94be844ee5..2b64b8a0ec 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -64,8 +64,6 @@ typedef struct OptContext {
     QSIMPLEQ_HEAD(, MemCopyInfo) mem_free;
 
     /* In flight values from optimization. */
-    uint64_t z_mask;  /* mask bit is 0 iff value bit is 0 */
-    uint64_t s_mask;  /* mask of clrsb(value) bits */
     TCGType type;
 } OptContext;
 
@@ -986,14 +984,6 @@ static bool finish_folding(OptContext *ctx, TCGOp *op)
     for (i = 0; i < nb_oargs; i++) {
         TCGTemp *ts = arg_temp(op->args[i]);
         reset_ts(ctx, ts);
-        /*
-         * Save the corresponding known-zero/sign bits mask for the
-         * first output argument (only one supported so far).
-         */
-        if (i == 0) {
-            ts_info(ts)->z_mask = ctx->z_mask;
-            ts_info(ts)->s_mask = ctx->s_mask;
-        }
     }
     return true;
 }
@@ -2907,10 +2897,6 @@ void tcg_optimize(TCGContext *s)
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


