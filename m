Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B9EC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMkZ-0007vJ-NL; Tue, 03 Jun 2025 04:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMkT-0007Yl-Sx
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMkR-0005uk-Py
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450d668c2a1so27077475e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938310; x=1749543110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7MD0/Ee90ZrXQaB9jW91JelH8N1BJVB8xK/qD2yN+w=;
 b=aPceGHAADZqpRhr51pN5leIeYjROFOc2QxjDUjoWM9E8nzoji0MfDiq+JOfzwjkSo2
 P9pQctHUPYEthSIrJOSmaxVOeLB06joW+cWmUpS3KH5EcEBcW156RWKVGuTV/NTR/Sjo
 Pepht9gLjafyIKEMd3XGGkqXVdBcc61fVskl8y5QkpMfIvmIi7EkyNnq6onxi4ShCwhU
 qXsa/1lbsa/3vENzr8Q/jbDHsAxqUapH4lhCU4K8oVrA2/DkocIlrjzILkXtFiIWUkC4
 gYYVzW8gwY/OfcIShtAYXUNblUJWFupvSlY3Lt55cwgfJOwphek4Df3181F3iICpzmJH
 wUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938310; x=1749543110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g7MD0/Ee90ZrXQaB9jW91JelH8N1BJVB8xK/qD2yN+w=;
 b=ircgZceDnkYl9iqdxG4SlpC/1AJxWKrQSf4yyct/8uarbIUVh+xt6k746hlvSbYm8R
 rxiA3wYHsvWiNT0Yva1skJZLAaWXDdeLAwlWGEDytdlngCz9LrZ5Q86+mAc5KqkQEhbs
 d6oUdOsGZEScK1Rzn/ZZrdYVQEgIwUuXD9TUf9teeuLwpXPVRDr69Zu2m6jQ2g6GlUON
 vqq5KSmWMwhaL2Tu8NsQcCHKRL4Zgrrlk3GqrhBe3zDCuElEmT3g2SoY5ARGE+959Tx+
 3u1Tt6PVLpmcncYyXf5asrQRYgK2wsjr13Fengi0YROhWyXnGQ7sNC7r1QrRQEAqXVFp
 G5Tw==
X-Gm-Message-State: AOJu0YyKYMKN++srWjo+4ud4oK2Tuw/gXYY8HpSDL5+RZf8JVJcHYi33
 edUCwLC3X6Srf9QuYpWCQyJzl8sv2vE2eMxvwHkLXU2IgLRNcyTk5chfTLT2H97jpnG2lmKYCDl
 RW0gwp9Y=
X-Gm-Gg: ASbGncu2sxSJstFviYHsHTyl8HP6Jms3zjWxfCz4YhJi/c05Lrp2Mkj1aF/n9jh709y
 z/QPYmqh7Fn471mpCh4PekTGV79SJH+cKLGEhgyAGWs8wHQ2Q8gEMBTUOfqiBuA+dd+THXRxCfq
 N3b6Zmjou7l2Chm16BEZxhOp51USPPU58FXayPYyGrqfihQlm61qrb+t9AFgV6yfmjLH+SHkQVF
 F2LDVusiO4tITodDyB8/eNhQGq3RpNK2qEcoBzSh1SvjUrT1Mics/wbWJNhrhG5UAqAmYJOQIrw
 jw+dZK2GpDjn5fjMmXv87sW+IG0SBCDuFsP2XnooPWu3n13YPsA2rLQ049kABWbTo2F8cIFpf/a
 6eOtfDHTNKsSJvR0zQrrU5AM=
X-Google-Smtp-Source: AGHT+IEEUelRSGmofqHgRd2y6FFhwQ1cV9N4oKJVeAIz0/A8twaLa59yDMd4HWo4nPwbUDd9/86Rrw==
X-Received: by 2002:a05:600c:5849:b0:441:d228:3a07 with SMTP id
 5b1f17b1804b1-451e61215admr11369155e9.13.1748938310098; 
 Tue, 03 Jun 2025 01:11:50 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:11:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 25/27] tcg/optimize: Simplify fold_andc constant checks
Date: Tue,  3 Jun 2025 09:09:06 +0100
Message-ID: <20250603080908.559594-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

If operand 2 is constant, then the computation of z_mask and a_mask
will produce the same results as the explicit check via fold_xi_to_i.
Shift the calls of fold_xx_to_i and fold_ix_to_not down below the
i2->is_const check.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f3a2328fe4..8d14a38f9d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1482,10 +1482,7 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
     uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1, *t2;
 
-    if (fold_const2(ctx, op) ||
-        fold_xx_to_i(ctx, op, 0) ||
-        fold_xi_to_x(ctx, op, 0) ||
-        fold_ix_to_not(ctx, op, -1)) {
+    if (fold_const2(ctx, op)) {
         return true;
     }
 
@@ -1510,6 +1507,10 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
         op->args[2] = arg_new_constant(ctx, ~ti_const_val(t2));
         return fold_and(ctx, op);
     }
+    if (fold_xx_to_i(ctx, op, 0) ||
+        fold_ix_to_not(ctx, op, -1)) {
+        return true;
+    }
 
     z_mask = t1->z_mask & ~t2->o_mask;
     o_mask = t1->o_mask & ~t2->z_mask;
-- 
2.43.0


