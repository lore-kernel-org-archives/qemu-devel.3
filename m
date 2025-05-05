Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E611DC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QA-0006p3-Lw; Mon, 05 May 2025 16:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pw-0006iD-Iz
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:00 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pt-0000N6-Ie
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:27:59 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso4658318b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476876; x=1747081676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p7ZaCEQNsiBmYp3nl0if94zw00aQ6FdJJAQYLtZwFJo=;
 b=SJpvt9JtexCRmIpYLYBVZZ4Zf+GT7zfdM/w5sdQw0gckgw0dykJWV5vECyxRxjLc0b
 Mm+vUYVsWND2xBSaG5KOSBo9NTkizDuiwblJg5g5xL7zfZzCiSwp7aewrplw/ecq4jjG
 cbvM7X0898KeBFW8y7ZVRFZVtlDtH7hzXP4sk4642CCdNHvO+VaI+utBGAtcE4UHlB2u
 xQneDcQUNkGrmNkmQFokPC1eleMYgmV1ZAoqpPRRPhVo8aIp4PLqihF4i4Kw7d+KBPqh
 eHL8TFRHOkE1VwQ6ERw6lS1BzsPmwOS9nvL7i0KBmb9H1yUst4b0x52Q/wuWLzm2a3Oa
 fj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476876; x=1747081676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p7ZaCEQNsiBmYp3nl0if94zw00aQ6FdJJAQYLtZwFJo=;
 b=Jqq19ZVztVAvdETRONwGsRC5lahFyrQy5d3cR4HXpcxUMaXuzpRFpAo9HxOavdL9NV
 sPZb3N37W+ue8aAgnC/mTG0HatAnTR3Pqf+gGrdu49s5zkmWuEJOHJjeNZreeCe4FGaH
 +H94tMh0RKrDTfSX9kHxLmAKNKmw8cgGSHoi26UMLqxEREK/R5In1jMwusIg8rgui1/9
 scW7coYRHlHqBvQvFtTRCR+TjfdY6t6KQrAfSIXebfmoILvoa3V3TgFswSSg12dHvz3M
 5kg3Rzme3byT6o2XF98p9n30kE5OkNQLQ1Gop2iY/nLNVNa4wDi2PCDFyv8dN1hbkFrE
 TbTw==
X-Gm-Message-State: AOJu0Yzo3uWCBrtIN9D8ybCg4au917f0Pzi1JRYwzMrrQPlas728CHVH
 OAQ9ONdbRz6R/CYlvFhCla974thoxP935yULSI9hKwjkyZ6AVq9m9GeU2C+AHRFsCOPFsPHrq70
 f
X-Gm-Gg: ASbGnctA7BXkWygh3ljjDrWzcvfQ8l75Dy5W3TreS0kXgCTaqnJXc3ZAhzG1Q0AFBaz
 zqsHPD846HeTdfyh4HiODQ98MvWDpbQKOQp+XvYyURTErNHBCEGhZtNcKCPNyongcvpvRq4RN++
 wfCnPLCVkd1V49A4l8lCygFWSPY35R2z7Yb9GoyODCCyU+Bn40Ia3UWg3sPY4DulWECGTsFBgOR
 fxnttVHMEP+3gIpMSat1nMNVdSQ7UpGFRfimwYKfBqpPLnm8awNmdNxtoPp8casXDoiOQra3CU2
 ig5Ad+CFWoeMC/OepY0al0yUwbrKRkTq418fZrJfVWZwwcx9oRd/uclQ3oilNTmrBNvv664S39s
 =
X-Google-Smtp-Source: AGHT+IHmcOpSyprKhYdlbe4nNWyD7CT/0mBaoX2DnwHlE1sbQbiiJehxDPjRhkftCol29z2csiaAQQ==
X-Received: by 2002:a05:6a00:2c85:b0:73c:3060:d53 with SMTP id
 d2e1a72fcca58-74091adf89bmr755793b3a.18.1746476876050; 
 Mon, 05 May 2025 13:27:56 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.27.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:27:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/20] tcg/optimize: Build and use o_bits in fold_and
Date: Mon,  5 May 2025 13:27:34 -0700
Message-ID: <20250505202751.3510517-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 tcg/optimize.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 395ad8232a..c9f0f46b83 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1420,7 +1420,7 @@ static bool fold_addco(OptContext *ctx, TCGOp *op)
 
 static bool fold_and(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z1, z2, z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
@@ -1432,26 +1432,21 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     t2 = arg_info(op->args[2]);
-    z1 = t1->z_mask;
-    z2 = t2->z_mask;
 
-    /*
-     * Known-zeros does not imply known-ones.  Therefore unless
-     * arg2 is constant, we can't infer affected bits from it.
-     */
-    if (ti_is_const(t2) && fold_affected_mask(ctx, op, z1 & ~z2)) {
+    /* Affected bits are those not known zero, masked by those known one. */
+    if (fold_affected_mask(ctx, op, t1->z_mask & ~t2->o_mask)) {
         return true;
     }
 
-    z_mask = z1 & z2;
-
+    z_mask = t1->z_mask & t2->z_mask;
+    o_mask = t1->o_mask & t2->o_mask;
     /*
      * Sign repetitions are perforce all identical, whether they are 1 or 0.
      * Bitwise operations preserve the relative quantity of the repetitions.
      */
     s_mask = t1->s_mask & t2->s_mask;
 
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


