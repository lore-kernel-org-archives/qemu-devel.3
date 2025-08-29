Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8793CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNL4-0004IC-6j; Sat, 30 Aug 2025 11:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urzWV-0008MI-IQ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:52:11 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urzWU-0000zl-1z
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:52:11 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2489acda3bbso16340045ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756475528; x=1757080328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6ugGnloBP1A/JNiPociBvYx/p6/DHz1cAJve+Grw0JE=;
 b=A+atSk2nVA4kA/wzhF72BTBzH+geZjhVbPi5C/9jAhaCs1xFazOaOTLSZ3HCTgOpgl
 vBfQIRg7uc54D5chLS0h3vDX/lvgDwQVbvqyxTgwYd2ifb8VXZa1USybudCsutimnwD7
 r0c8bxZOvariV2X0ERh3k/dWR9xUGUEN38GSEbR6xfSYGdLSmIs0m8ZNh024zXsRxRFz
 RCtRaKcVNAnxGHTqw6g3tciiJsC6QoSsffcSrpWe5+jJTsEVODBT/g7zS+tfpqzn68yg
 81zfStZumiuT93JMUJYRiCn8Pt2syBC9tUO0Fc0ZFSslmYWUYoRlIeYbTj5Aw8rB5bT/
 SYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756475528; x=1757080328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ugGnloBP1A/JNiPociBvYx/p6/DHz1cAJve+Grw0JE=;
 b=wIMIFJtzdFaJwOERMQt4a++c1q2sEBl5DdU3C3XcH6atLt48VB+MPjNw8EnRbPuXGK
 ilypdBmFwQUUe+1XTbv55TngMFZquU5JLiQEs2tdVpyZla6NG8+8iUcsnU7Sz2WtcmUR
 nb5H9WdYTLYcxf/azBqE6Wbnjlug/nAjtMYQYvASiz2yk05lTRNUnpVhre1Py/9VK9no
 12POKhYiSHQ1KmKv0uqW5RESVLQyE/OHeooj+McrLiMgZTUIL8dVuYosmaFQLEUFxDQY
 Bcl+5hfHnpC3ExdyGM+tnmDOAkpboF6J+IuzVNFXmRPqfuSmUTUYKxjPnKVpjjIxrX/1
 od1Q==
X-Gm-Message-State: AOJu0YyiYcEVIFl0Ws9J+wPV/ZNFhKLI3u2zplHCz4FPxbQ6hZisZQJY
 M8g6yEF7o6QG5bfzRzlGcJHKocOVo9JiNUAwbkxN0QcmrP3Tdm1bMWbCVZl4mJ2yX6nQvTt60pG
 dYRziHEY=
X-Gm-Gg: ASbGnctHhoY4DNe25OvzQq42fIqF+BS650v4T37ITDaqwfrV0wSXrCPFmw/rMgrVWJ9
 2pbRFyHycrsEV3W1su5+ygzWNFGOsrG0yf0cPlbLwBCHjZZbulXPVW+fzLfLjOTu3vpKwAyHcSM
 mr71zrMOOsN2FCfATXFx0dXIJoogCF1gpbeHV1HvRVHgk81D/3PcPvRb7KakPcFMn3KayYhgeoT
 o5PK3CdEqC/ZjPGoW5Wtp/Yf1OqygUgc4c/iWC9UhFhaXZpslaGl2EUn6O9SnUZdhvr8Sk7GdKH
 wPvVhQEI8iDjs+LiVtFv0dop6UtoDpEUaYS6WKEVyYUa8mwWfSTOcfrdQLfXdZljS7DXD8PlJbO
 CCUynMFjyC+gI5+/PjOqZaGXdi5fxX654iZ8AxPxLLlgzEaGosZr11xiYVnfo4R2T4EoWqMI=
X-Google-Smtp-Source: AGHT+IGK78rmTz+6XPFVlsQ0CEW9mg3iiz4yD2/7aJD6kTO/3Qp+X8PDZD1ygXzSP2fKQJdmWrRFNA==
X-Received: by 2002:a17:903:124c:b0:240:84b:a11a with SMTP id
 d9443c01a7336-2462ee2bc6fmr361146025ad.17.1756475528388; 
 Fri, 29 Aug 2025 06:52:08 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903705b9dsm26457415ad.7.2025.08.29.06.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:52:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] tcg/arm: Fix tgen_deposit
Date: Fri, 29 Aug 2025 23:52:03 +1000
Message-ID: <20250829135203.284630-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
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

When converting from tcg_out_deposit, the arguments were not
shuffled properly.

Cc: qemu-stable@nongnu.org
Fixes: cf4905c03135f1181e8 ("tcg: Convert deposit to TCGOutOpDeposit")
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 836894b16a..338c57b061 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -975,7 +975,8 @@ static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          TCGReg a2, unsigned ofs, unsigned len)
 {
     /* bfi/bfc */
-    tcg_out32(s, 0x07c00010 | (COND_AL << 28) | (a0 << 12) | a1
+    tcg_debug_assert(a0 == a1);
+    tcg_out32(s, 0x07c00010 | (COND_AL << 28) | (a0 << 12) | a2
               | (ofs << 7) | ((ofs + len - 1) << 16));
 }
 
-- 
2.34.1


