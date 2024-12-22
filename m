Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986E0E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOoY-0004sz-0Z; Sun, 22 Dec 2024 11:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoT-0004oV-RA
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:18 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoS-0003if-9C
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:17 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-725ee27e905so4253091b3a.2
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884895; x=1735489695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGaisTWn6CCAvd5l9eh9fSq3ae4swEAtCSXmPrNxbdQ=;
 b=yMpELYTbGDEy8dq7HlpmvyPsBEW0p6u4eYfCSxDg94wSyeuSo/9/WMj6VuHwL/DrgE
 kNbN4fIbDZq31gC5TYSngVr3YDMSzSC0BZC7QLoUJ94XwcqpTarho1GPl+ooX99obtCZ
 T0aRQb5WxI3PcKzqM5Jk52lod5z6X+CeZ2XwpsHCnPayB5/mfR6yYljEHHfbjz+jcXMI
 KxP7rl+bZbO7KMofUW5vNgCk6a4mXJ+xD21LOYiyhrAwQHieADng2EGbWLcUHmIy1VDO
 Qpqu/T1NTt2Udthgd8eHTX/zvfB92GvcIm9uyKvxWTSA3+bUJ/Ia6BimJA5p6TBE02Sx
 wuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884895; x=1735489695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rGaisTWn6CCAvd5l9eh9fSq3ae4swEAtCSXmPrNxbdQ=;
 b=juf2nWPhTuydp/UdnOCSJdyNmgWrqqha7yZ9rcwiYfhaFfdulet/voYr/dPgSbIsdB
 QV2R04oNpNfRKyhqx42uJsmquuezTPiFhzaOjFt06ncOpY7HIEklV/QliY4tagWNsson
 BDg+b7IGkZuTVLkeo5tpxS2QqWYA3XoSHQc1fI7MS8seUgRt5hfje3yB3rgQLS26bCpn
 rCYf3CejjW4ARibl5s77ZUkq1Lpxuu4fMtx1aKUThWrwh7t7irbiQRzPZiZLKokXEFG2
 Zq9iEduCjlGOCVV/kXKokKkJnyc28r5bvlvWLUeEAsqR4+k/wyGB6hgRAbgPXJXqOn8x
 Z4Bg==
X-Gm-Message-State: AOJu0YwbRY3bIxpUw6v5QfvKLPN0K4jQOJ8AWc0PD0r3tv0P+jY78w1x
 c/pUxKms7WAXbFMJdy2Zz8iMPR+N5Ck9r6oiLi8vyWapwzvxxpJLszbwzUouoP7A2nZ1W8FU6vC
 kQUw=
X-Gm-Gg: ASbGncvrAd4I+Kox1G6+gov04GSCwGYtmaCFxY7M3Ydr6uAGo5mDtJAm3paodyBm5an
 u02yvkqo6czhDtsW0yeAFGbmaZt3Xz4UCaTad006IwbkbHSu9xcMo/QJTpVcQ2wqwwSxI8C8nHI
 Uvuj7Nzrg1r/LwdlGIcO4nrEy9PmX9gTGCI6DeNLoYSkzN+7io4CbZZ+WIQf2vsrdDB5KMGXKpl
 AqN0FtQzC0L64X0UuQVjp5WjjxZadASvJa6fMPxs/yPKlY4VXM1dxNhVq/1Nic=
X-Google-Smtp-Source: AGHT+IF/rj/Ln3Y/V5FfNuWwfOyKZc2IxsI2aIniLL8KQytwNf/LL5NUwsuEEnu89rdUF1Q2JilFNg==
X-Received: by 2002:a05:6a00:3cc1:b0:726:41e:b32e with SMTP id
 d2e1a72fcca58-72abdd3ced1mr12744599b3a.4.1734884894729; 
 Sun, 22 Dec 2024 08:28:14 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842dcaca43bsm5848808a12.66.2024.12.22.08.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:28:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 41/51] tcg/optimize: Simplify sign bit test in fold_shift
Date: Sun, 22 Dec 2024 08:24:36 -0800
Message-ID: <20241222162446.2415717-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Merge the two conditions, sign != 0 && !(z_mask & sign),
by testing ~z_mask & sign.   If sign == 0, the logical and
will produce false.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 052b5a060e..e53e6b6969 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2513,7 +2513,7 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
 
 static bool fold_shift(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask, z_mask, sign;
+    uint64_t s_mask, z_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
@@ -2548,8 +2548,7 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
          * If the sign bit is known zero, then logical right shift
          * will not reduce the number of input sign repetitions.
          */
-        sign = -s_mask;
-        if (sign && !(z_mask & sign)) {
+        if (~z_mask & -s_mask) {
             return fold_masks_s(ctx, op, s_mask);
         }
         break;
-- 
2.43.0


