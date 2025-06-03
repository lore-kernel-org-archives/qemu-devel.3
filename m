Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BDDC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMjt-0003NJ-5S; Tue, 03 Jun 2025 04:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjR-0002LZ-Qp
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjP-0005m4-4d
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so19701365e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938246; x=1749543046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbV7CB/vme0Aevai0jjNyEglAqtC776CtVcj3Rlc0uA=;
 b=u3qfQwPTxsCfEx9KrHz9GWxmrT2hBaGgo0qZiZZcDrGb/bOedmFxIyL+265TeJsYSS
 9c1HtpVMAbvrqG7Y7uTbpFZu7B4ksf4BQiUmsV4bwk7daj1MtuTGpDvxi1M2xbb/srKu
 yFnhN/aHkT6xt5ONaINvFrlgqAsL4aj1+0qS95V/im3CmGTskglRU8vH5U9WNxfCAZDI
 dxL485O4KrjCiJoL/5LEdBNlTaNaiU+AN1kIqn1bYgY6HciNIe2J4ogp1sTxxys93lRN
 RBxpcxXfUY/JkIo7iqUCbF02mfV1HenLTqYNge1U/WjvfBGN58up3ovPoUeFeyEAERRk
 ktjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938246; x=1749543046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbV7CB/vme0Aevai0jjNyEglAqtC776CtVcj3Rlc0uA=;
 b=meQ1mcnlxQ39hCIUgC55GP8UmpaMbIMuznN/gHcCeuF8IdGTKz6BsobQ1KBEQGL8Zi
 D8uI8XLItTSBGAqY6TAsA0rmY1XBckrQ+7BL6aQLLKHIzDQtnFMnVMd6vGXx/Ulg3kKu
 O7WQ5N9+7zTXUtoVxkauMEZ3OCCDWookXauvlT2gJSiu9e+pK7vKyWW76/SPjX1BQsSZ
 zpf17/TRml0ePwoBU+hWZojD0x4t92rCXYbLdjVfST5NhVtzW54cfbrfo2BUQNG1vYB2
 BCegO8HNA+pBpcOMuqrQtxyUIBRkR9ceOPweoLKQFuHBZzYzNr6X2u5oS9LM20wfEaZ+
 5GfQ==
X-Gm-Message-State: AOJu0YyLL5/vAVQIa0TT8lMJFAkuWMegkMpxqqb0y+iqf62y8VO+Aj21
 ycqOedBDBBykxwsfQg0yIXMHUeU3OXQBRzujF2pSq4XlREPRrT2uRvwy/KlMFynf8BsEe8z7AHG
 f1N5NWfk=
X-Gm-Gg: ASbGncvpgluma1Vqg94v9yVXQL3FUlfFMQiTA6BvqnA4zIFD9f8yJXhzIpdilt5H/1J
 sGHZk+DLGsWp5+QhYCCsnj0/INRv9dKRqY0NEIOE8vvBBipX51kGgXCrEKyoluSHO5sJwSCG3ao
 iz97syhVN0iFZGRfMGhwuIInYfKcp8cgvYwAy64edwFP6YCsvAFE6RG3c9+DiLpDnM1mKqT+W6v
 ZY29+Ek6Gwb+rWUaqsVEcdIyYArpvBjMmjH6gu/3TX4CClRQhuGepZteTQ7IHj8GxhAiqsqMzET
 H8ZfXjv0w1E17iWqnoVvds32xLpt4D42nQR3Q+971MV1s+nAUrN7yH2xTu374rFM9UkqsjYEnTt
 lXDA4M5U+bepg
X-Google-Smtp-Source: AGHT+IGDbIRH/RzvnqMGMBjfedHSfH7T2P6PAqxt+N2+ISmrwkrfjverWhiR8odqr/JQiROYbUCzpg==
X-Received: by 2002:a05:6000:b4e:b0:3a4:fc3f:8d5b with SMTP id
 ffacd0b85a97d-3a4fc3f8d96mr7515454f8f.47.1748938245664; 
 Tue, 03 Jun 2025 01:10:45 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:10:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 14/27] tcg/optimize: Build and use o_bits in fold_deposit
Date: Tue,  3 Jun 2025 09:08:55 +0100
Message-ID: <20250603080908.559594-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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
 tcg/optimize.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c9c53f796f..043568a10d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1847,7 +1847,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     int ofs = op->args[3];
     int len = op->args[4];
     int width = 8 * tcg_type_size(ctx->type);
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask;
 
     if (ti_is_const(t1) && ti_is_const(t2)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0],
@@ -1882,7 +1882,9 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     }
 
     z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    o_mask = deposit64(t1->o_mask, ofs, len, t2->o_mask);
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_divide(OptContext *ctx, TCGOp *op)
-- 
2.43.0


