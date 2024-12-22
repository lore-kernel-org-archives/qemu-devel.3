Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF4EE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlr-0002un-Qh; Sun, 22 Dec 2024 11:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlQ-0002bD-87
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:18 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlN-0003BN-JN
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:06 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso31883525ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884704; x=1735489504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kE0P1VyOBIABwqO8UKTPptAdEwwVsrua/XfTwHmi5Ao=;
 b=I8dpLu/8Jm/zPD73odW1f8Cr21W14KBYjb2WH39rTl4VK88Fq9psMYasxF5CW5Wg62
 WgfxuxzUGSZI7L2OPZ8SJgqNqNI+7IpsqHWipAynyb43C3KXW/qjqSk984agNl58X4c1
 +1NHh2ObQOfYMzjFp3VJEi7vzzQoHLtSiS66bhtV+mNnMfqw++s8bwJXMP2JkH/Xtnf5
 qgYeme39kdKr+sdExw9kqUt184FH+pzJ7UY5kPV6ULayES6C/VvFBrK2lKh49SQWqFZV
 MYVjqLQnlMuXJNszWUEwxm8DcO4wQuPmZ9fq1rgAg/dpdPvszk8U+Hvu+Q6Ux4Rd2uSa
 vPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884704; x=1735489504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kE0P1VyOBIABwqO8UKTPptAdEwwVsrua/XfTwHmi5Ao=;
 b=NxOv/BoVxiLlcDdmTJW6qfI3fNuS2Nqd1tL41TaxJ5dHl2mOVL/NpUe2sxj/Astf4n
 daKyHmkPmZYGduRmI8jkbRd7rZeh5StMVbpv9kVmnYRGOxwZoAUmy75mUuA+1xyMpclw
 Xx88dWhxLNIzPcuqgtYykSUwjXtjh+sqEOEvi/2y/PEBPOagtozmbOtk9q90Bg1gjDOU
 0HS0GMAFkhdSCvUk+I0AJOwOHzzLjBr7z4CTfJvXWV55X4neLtEvT5ebQvjMJB3ftchp
 8XbST4+jp7LSpO9p4uQ0avc1+bzxLHpzAGE39qjFkkG1yoBgMt1cGLoIsImjzLb3KBlO
 TUVQ==
X-Gm-Message-State: AOJu0YyOGk/zUV97NMWIIbbE0a1p0ZDKYR9LVagyBwrh4ja+N1cqjadk
 ovpOBJ+r8P6EI9JOXD0/tnveb+xhlBKjpCchUKmt7Ri+eUt9NX0Bd66F4Hr0B58DxKcBuRuqhqV
 Bn/Q=
X-Gm-Gg: ASbGncuyi6lmKk6DRxS/9oNYVfR3m0ClyHO7EowJJmup8HiqKtihzlXCvYoIx1BKyOE
 Ytmjbnvv3Ar5IXs5kOkTDUjhENPJFQQMJtGiBIc1DdjZzB2ANI9GUNHqn3lMC1cJmcihaz6gyC+
 5rOZcGTiMF6nTmhS7cnLDTdsfW101x/YwuhbxF+YBb0t0G0QTbIUgdUDSaQ5XXxUmTmDPjNPELy
 eH7gGPBgY5l5QLjjpGY7cAlWaah0W4o24Moy7h/cAFjUyQSfbh2Pu6GhG6rlUM=
X-Google-Smtp-Source: AGHT+IEPfkprDV8EhQM1Do7DMI8qiyExjsecgLcr88s6EtLjwrxKLkGZPw29xRMU13fJb1/LoSskog==
X-Received: by 2002:a17:903:11c5:b0:215:aae1:40f0 with SMTP id
 d9443c01a7336-219e6cd8c7fmr166855465ad.0.1734884704062; 
 Sun, 22 Dec 2024 08:25:04 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 26/51] tcg/optimize: Use fold_masks_s in fold_nor
Date: Sun, 22 Dec 2024 08:24:21 -0800
Message-ID: <20241222162446.2415717-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 98fc5e02a6..4196de9e16 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2039,14 +2039,16 @@ static bool fold_neg(OptContext *ctx, TCGOp *op)
 
 static bool fold_nor(OptContext *ctx, TCGOp *op)
 {
+    uint64_t s_mask;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_not(ctx, op, 0)) {
         return true;
     }
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return false;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_s(ctx, op, s_mask);
 }
 
 static bool fold_not(OptContext *ctx, TCGOp *op)
-- 
2.43.0


