Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16321E7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOpV-0005L7-TE; Sun, 22 Dec 2024 11:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOob-0004yU-Bj
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:25 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoZ-0003kA-Rz
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:25 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2161eb94cceso22380735ad.2
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884902; x=1735489702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CP2cLUZ8ZQcQ42iAJZyJU72duE6mhG1kg0Yhh0LbfQQ=;
 b=sl7D8YHog0cy/yRV6AeJmQ3Opv5S34IAVP/9O8dhduBx4StTVGj1Sm61XQAoqC8W3n
 gJlioIgew9k+/25lmjuVpsE/42kXbqfQuIUGSbVpVhIAAYe5KZczsvufxtBqEcje+peS
 xcg/W8g4xtChFAmPPbjPozoLEP5gsQ7CtZ/znRv7lktDtQYjtapUo8/+7uKlBCxDsBPm
 RrmZPlUkjpP8et9wid0IMTk18fRtO41gIKHVkiBYNp+mLThaVbLVH5NNbCmwtSuFenbl
 qFhSGe5eKHJ7GbspZB8lT+N0uQeCSrfb2kgIbK2VgvDrcG8SCUc15CfkZ7onN8578e/J
 Ao3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884902; x=1735489702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CP2cLUZ8ZQcQ42iAJZyJU72duE6mhG1kg0Yhh0LbfQQ=;
 b=wJdtbB/YVPl2zgpAuHpXoX9NnEWxbNMifFHLVodgGGHcU2P4FH5tTr7gLBKUWxQkkp
 +j7W7rXMVCf2ImSnjtVk8MisXzzCFvjgMGzTjbGDZw2i6ZZ7YjPctpfhOZgjhJ3ZDNjF
 3upCYUwTYon2obcxTr/M5vt27GLp++oQAFdhtJd8l81bemtZKeSZnLiI8TJlIeEOs5FX
 6fKC2pVWhepWqZUVOk+OqW/aYC4HahpsB6eT/qHcxTCq/JMy7lYemZ8/XW6kzOfU4s6q
 YzxY89IyYsCEl1f9wV4cfxBG+bU3Ebx61hXSc7XsYu7gqMTZB0PpswgfIsV7ehB5KVpl
 vedw==
X-Gm-Message-State: AOJu0YyiogoqA3rPRErNf50Wq0DxJRybRlQ0szuzi7IfHiv0twLSL5Id
 Dn1CPkC/R83EguwZwRwYMwr0tP9O0ctnrxWSAYDnjoMwXkfdasvim2AaSeJqk37xHCD0bE4k8jU
 C4lE=
X-Gm-Gg: ASbGncsvOrjb1T0JMqiKmJI9zsSsuE/zfDEIP5lFeDzEuEgCROGDTaeZVLWAfs28IBj
 xXB16bPoBYOTBAiEgLZeZjOE3MwqlSjhW4MTteZq6Gv6779gyNMW3H45IjPN6AaI4KCNLDuzl88
 ZKodsp0TbkGUw5FUBcWAc8CEW/KDEgvoiraHvoyVHV05bFm7jSsfxDlq+tojAMhQlEKzFls6FjI
 C37E92ipUuURHn7+tbnMZdnaHNoXT510Y9Wi+20zcLIS/DqfwJ+O8iy9Svhs/g=
X-Google-Smtp-Source: AGHT+IFCrGYxpxC4eCT9WFefFGUwcOpiv6xwdoRMdLanw7C38mnGNytYm3ZOiH47yQUFw7yxRkcl7w==
X-Received: by 2002:a17:902:f652:b0:215:a05d:fb05 with SMTP id
 d9443c01a7336-219e6ebd102mr163377505ad.32.1734884902086; 
 Sun, 22 Dec 2024 08:28:22 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842dcaca43bsm5848808a12.66.2024.12.22.08.28.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:28:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 49/51] tcg/optimize: Re-enable sign-mask optimizations
Date: Sun, 22 Dec 2024 08:24:44 -0800
Message-ID: <20241222162446.2415717-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

All instances of s_mask have been converted to the new
representation.  We can now re-enable usage.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 902c219032..607697e19c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1780,7 +1780,7 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
         g_assert_not_reached();
     }
 
-    if (0 && !type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
+    if (!type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
     }
 
@@ -2489,7 +2489,7 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
     s_mask = s_mask_old >> pos;
     s_mask |= -1ull << (len - 1);
 
-    if (0 && pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
+    if (pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
     }
 
-- 
2.43.0


