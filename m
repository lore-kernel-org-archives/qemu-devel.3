Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBECC83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjE0-0008J0-Hc; Fri, 04 Jul 2025 12:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDy-0008Gu-UP
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDx-00066e-9P
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so9571765e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646316; x=1752251116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CjmSifyultKO92TqHZgAe9D2aJBwtyFLFYx6SMlRFYs=;
 b=nnx5cexLhSujvJnJScaBf+LXC0N5uS4OqiVd2IZE8V5JLtRnCM+NBvHUl4950Tw3Uo
 p6b5BTGOUCHiuKNO42LT2IUiNWEUQQEFrtEev0ng+m7Jq582ly7B1rF0a1+Zf/VwFBwS
 LjwmFSh2wb2JMHEBJPNwzlmPErgmcmzIGCJFlpFs+Oxj1y25Tko9D1v/egFVzNMUOnZ1
 AF1QxMJhc11snY4bdRlftivNxufnTspJ+27R9cy+fT5P7PL2I2bnDKf6+dGO75e222zd
 Rk2RijEHkb6pkA6AtSQyayKBVL61BCrVnkmJ/txVQj8RtehLBKUOp3x7lH60n9jMr8gy
 kH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646316; x=1752251116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CjmSifyultKO92TqHZgAe9D2aJBwtyFLFYx6SMlRFYs=;
 b=qiRX6ZetLsYOw5Ltej9+iPQ5I25bNxMb5SdT/GrrpydWtVKKckQN6ecByDgW3F4qBj
 6lhEjNiQOuroAkOQZ1GGyPBiD4SKszdE0WMsBsnlkhSYXLGPk4sLxmjuSulZJgoBihXP
 tcAvihVKSLx+FJN4dItUGxvtgW+C2NkeqYDo6Dp0j6cDeq+bD9TIuLriXNOWe7g84zmI
 Zgy4ipcYpddDiQDVISy4bGN1H7bV+lG6RNsIeD0uT84nrtR9qYT7/WhKMneuDcu/INfU
 EaDVbBc/1E8WD2ii3BjES0PTO463wWCmwASOXJh2nxRdqG/EAVI4taqfANpGTCPxQoYh
 PyfQ==
X-Gm-Message-State: AOJu0YwYeha4fcu0t4bA3Tx6zHRQUJhwiGHb63fzReJiqn6VDgBY0j7+
 QJVR4xABk7PaERQf93fa1mt0rqLZ1JW3GQBlYRgRY/GcoHC7e6y1aPBw+JXaT/JW+ZOcXwyu1AS
 B06R1
X-Gm-Gg: ASbGncu2svE0eX9s3L5e6Ev2rAWka0AksMqv6Xzie7i6KsIBohV+WW7p4D97yjQMFaE
 fCVCFGZ4DMGk/o0dGPs35AsAPW+DMXirEvRUHEJcKS3HpkMh3NKb9Qu+hPMWL3sGGtB0uwcD27o
 34gw74qzFPgXiSCeAAP1wjkyJq6aEZVyWzOnQrvBZ+0Ez/O+Hc+trRS30JonEU/1lvZZx0Dh+OZ
 BWS0BBdUg4e/zPZWw0JLBZ0C5n3OaWO0pGX+JxmsgELP5/m/0BYXL06Ti3TGUfpx1YG5h1HoWO6
 HTyiaf3mDF7FsJ0FCaG+DFgqutKup75Cmo7n5+PUGDWvkI28Im5mS3zX+J+6s+oRWmVA
X-Google-Smtp-Source: AGHT+IHZZMdoHpjn3K6htzrnEVlnZpXGQVws6eCSO7YQPlVcWWBn2ak3UPc/xCAVo97OQOHNoE8s2w==
X-Received: by 2002:a05:600c:648a:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-454b4e769e4mr31289875e9.10.1751646315554; 
 Fri, 04 Jul 2025 09:25:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 013/119] target/arm: Fix SME vs AdvSIMD exception priority
Date: Fri,  4 Jul 2025 17:23:13 +0100
Message-ID: <20250704162501.249138-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We failed to raise an exception when
sme_excp_el == 0 and fp_excp_el == 1.

Cc: qemu-stable@nongnu.org
Fixes: 3d74825f4d6 ("target/arm: Add SME enablement checks")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 815225b1301..5c44a5dece9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1488,7 +1488,8 @@ bool sme_enabled_check(DisasContext *s)
      * to be zero when fp_excp_el has priority.  This is because we need
      * sme_excp_el by itself for cpregs access checks.
      */
-    if (!s->fp_excp_el || s->sme_excp_el < s->fp_excp_el) {
+    if (s->sme_excp_el
+        && (!s->fp_excp_el || s->sme_excp_el <= s->fp_excp_el)) {
         bool ret = sme_access_check(s);
         s->fp_access_checked = (ret ? 1 : -1);
         return ret;
-- 
2.43.0


