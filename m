Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BA5C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMif-0000sh-6b; Tue, 03 Jun 2025 04:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMid-0000s7-EQ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:09:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMib-0005Ud-O5
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:09:59 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a363d15c64so3650729f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938195; x=1749542995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvC+gvYwUpDvO0mMy+5UZVX/B+N/FUSqeH9gL/AbVPY=;
 b=uQxJVsw+EWEZwYTRyCO+Cwgq3giefRXcEedYRd8gpONRNrX98sV4B0gXbNofFCQ2l5
 72bjJrjyMm2QqIUTePLJ0v2ISi6NtV8YzteFTcXS1j+zCjtJxomhfqjUBkEP95pgzTpV
 AnnmvYnp+30DZZBLJ8GhDrmzEP7L/uHxbvXKQi01jTKoXPI4p71OSmGgenG/TtMe1/sH
 iE8voDQzDdzcX7S+87z3ppG5z6+kcJ2VNznvhMssBRycKIZpPIdgnlFDYZz8meLjNsLU
 c/dFEAVT/h1i8Xn/HRHPoo3VnkP218BsECMM7G6zsYqf7wkmp09vY4Q8ND/LuTiX64cv
 GvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938195; x=1749542995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvC+gvYwUpDvO0mMy+5UZVX/B+N/FUSqeH9gL/AbVPY=;
 b=WHv0cSFOQJzT+ciprWL79FTOnug8z5ZfGX3GHYNpeyiSvuaFqq/5Q2J6OYjqptlv0Q
 7F2DCqjVtfRyHHFqTuBhnkArG1ui3rsRdGMrOg0fO9Zcf9NmMDaSQOLE/a/wuATgzIyg
 WUAZHIknCvwijdNRIej0BNKIujPgvLpb2uL+m+ZbW2onn4Tb4p8UepwMjYBz3CO3gX5F
 zX/FyOL8vEweQ+rJXfrw16vv6624CJ4IaRPt5NluoomZWdhIj8L1TADLspZcud6parCw
 V6ueI5SisjA0aWj8td/q5XjWUvDp6aA+ubW+bC/BMWyy9MUX+3ZaW3eR9CSx/V+WySz7
 EhhQ==
X-Gm-Message-State: AOJu0YzUbKriDqeTI40s5wnEbm6UrNLHbeWz3YjXz9DFov/XvZ6dB7y6
 biUgJ4QrF/bXFrDbOXnlR0Mz+Umznjp1E9xxnMx8bUFkAwbRU7ABTdZnsW9FK19aIAdSbgEK87m
 +m7pCnSQ=
X-Gm-Gg: ASbGncsECDErZx5bXDj3QmU6o9sHuk0pGNYv1cQSm/WmTBXKhB0NmtsvX7vXPv9v0gk
 XZhoALM4Sb8ydPeLdj6wH6GsqfV0YWCHIjFv6zi2PJyK6tnPPdBCxbHQ+4Jwh4oYPavdAVWlhzR
 LqLV+20vTsQupMD3ENdojrViGXpeVFFGxrUvJ1B4I2gNfbfJ24ICAvoxMelNsZxxD4UZFTMMff6
 R5q+mIun65TGgsGAHjZgorbzxsQPZvjEhvXCdKAfjuE52OB19FWmyIvKWSSL/5EkHqoIrI/9oAF
 5v7j9xS+aXmS8Mvj9pnifeSSYi+YvWuXSMliuFwqJAFJQ+WU/YN+VZ06qB7s4/cb0Yna9WxlidV
 IgPrz6JZaZ2y3
X-Google-Smtp-Source: AGHT+IEuFGkV9FJuaSfp/ky+Tw3fhfqh8vUViI65X2sVCftac9vev9q8OP9hXjY+tHA7LFvVUW71Mg==
X-Received: by 2002:a05:6000:2303:b0:3a4:dcb0:a5f with SMTP id
 ffacd0b85a97d-3a4f7a1c78amr12072098f8f.16.1748938194899; 
 Tue, 03 Jun 2025 01:09:54 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:09:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 05/27] tcg/optimize: Build and use o_bits in fold_andc
Date: Tue,  3 Jun 2025 09:08:46 +0100
Message-ID: <20250603080908.559594-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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
 tcg/optimize.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d9ccbb36e2..123734b167 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1452,7 +1452,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
@@ -1464,7 +1464,6 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     t2 = arg_info(op->args[2]);
-    z_mask = t1->z_mask;
 
     if (ti_is_const(t2)) {
         /* Fold andc r,x,i to and r,x,~i. */
@@ -1485,20 +1484,14 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
         return fold_and(ctx, op);
     }
 
-    /*
-     * Known-zeros does not imply known-ones.  Therefore unless
-     * arg2 is constant, we can't infer anything from it.
-     */
-    if (ti_is_const(t2)) {
-        uint64_t v2 = ti_const_val(t2);
-        if (fold_affected_mask(ctx, op, z_mask & v2)) {
-            return true;
-        }
-        z_mask &= ~v2;
-    }
-
+    z_mask = t1->z_mask & ~t2->o_mask;
+    o_mask = t1->o_mask & ~t2->z_mask;
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+
+    /* Affected bits are those not known zero, masked by those known zero. */
+    a_mask = t1->z_mask & t2->z_mask;
+
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
 }
 
 static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
-- 
2.43.0


