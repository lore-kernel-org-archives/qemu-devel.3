Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A3FE77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLq6y-0003hW-2X; Thu, 12 Dec 2024 15:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLq6t-0003fv-2A
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:35 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLq6k-0000w9-NO
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:33 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71e3048970eso458084a34.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 12:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734036504; x=1734641304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5mnyXonXiy4zaF6iAQaiGzQHiUuvaz9CiX/0uI1U14=;
 b=K6fE21nnuqaAjKsKU0fSTDOrICSf/L4NfjpkrzhF4TuSW8EfNWJodVM0bcEe1+Gls1
 Tm5hh60voOmILEs2D2XjpRVNwNExuxZAZ/wfXRlpLxJU1TuLKxOb3vJ7oTZDDgxvtlEK
 zXwmEr9omcFqBP87CFcr8mOQopN8PT7M3+I52spdN0CJxauJtrWDyPMggryKtaUvoHFL
 AuK3hCnM2SjnL49q7ki/S5zV45WVwHELOyNvFu2ykyTjwr1uIZBJt1ZNXXAGwWMd8nP8
 LefSsPIivA8WJyCvGhNTzCP0EvJmFRF7p73J8j7fYK4G4hKjdAM3fwmCeIQSXfqsCYQl
 nnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734036504; x=1734641304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r5mnyXonXiy4zaF6iAQaiGzQHiUuvaz9CiX/0uI1U14=;
 b=Au1CbQ/FXOchaQomP4TloUdQDSA/2vAz9PMmpnQFkqH19six0U1zYdTqL6ZbUxLgu+
 YnTxUUZDiyt6AhZ7UCwKyB11YDG3oL+xSB8wQt3HdSEKt+pnVpz6hmM/k9qcTk9Z636K
 64f1rpmmYWCszXlCtP0ieEVLS01DpgxWxCweE0+tYU1LHGHrRWtdrqf5E3hp465Uk5Gt
 x3/4f4q5GwRazEQoTOcbCLmpBSt31SmSPHayLphMfKukToDfp+vF66DN6JevS5rXNLfI
 pyMkskMkI4iEVu9iJ6eyvFQw5PMX/Z0bu6OT5yNJxmFiv5dXMmYs5fwmZaAnl1Ia9uN0
 brjA==
X-Gm-Message-State: AOJu0YyY+qUDtFFB5YXIJfLCQQrUczasVRF0H4ao29NTWmiH2eL21Qrr
 K2KJYkzvsYPOOTZzog0WP1pcmFCEQYstDyxQ85H2bsZOWN5Q8eYoOs2qMErP821nTjxkEp4nZoy
 BWGwaTfyu
X-Gm-Gg: ASbGnctnAwdn8a6zX1JdbYuk7ypla2WCc534XtQTf+Dxb4yc57I2kwmzONKDANsOgii
 DCIhrVHsK8sRRbJfOoMVVSI4X2gasDd1YS5SMW+9lsU7Fl7NyXa/6Rb3P8TtYOBi8nqv9g0Hbat
 aFiNmVjVraQhk2vUeuE/tEXX0XqyDxxQu+sMJkTk+uhdEbta6tOwg/+cm+e54Bw4O3/lUGzHYtl
 iEqgDjyj5f6WHIn94C/ah3c+tdHsaCYe1+c0LV77v6M3/nvly6mAFZ1WSifsfbO
X-Google-Smtp-Source: AGHT+IGU9eUMb68Kl4H1SoHFMivQ7cGbXTTvG8hrmRybcqeTT3/AS+ABrzmx4XyAzneSi3seJCfmxw==
X-Received: by 2002:a05:6830:4490:b0:71d:5f22:afec with SMTP id
 46e09a7af769-71e36ea1c78mr1161819a34.12.1734036504004; 
 Thu, 12 Dec 2024 12:48:24 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2b8197b58sm2129758eaf.12.2024.12.12.12.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 12:48:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Artemev <roman.artemev@syntacore.com>, qemu-stable@nongnu.org,
 Denis Tomashev <denis.tomashev@syntacore.com>
Subject: [PULL 2/4] tcg/riscv: Fix StoreStore barrier generation
Date: Thu, 12 Dec 2024 14:48:16 -0600
Message-ID: <20241212204818.2468583-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212204818.2468583-1-richard.henderson@linaro.org>
References: <20241212204818.2468583-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Roman Artemev <roman.artemev@syntacore.com>

On RISC-V to StoreStore barrier corresponds
`fence w, w` not `fence r, r`

Cc: qemu-stable@nongnu.org
Fixes: efbea94c76b ("tcg/riscv: Add slowpath load and store instructions")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Denis Tomashev <denis.tomashev@syntacore.com>
Signed-off-by: Roman Artemev <roman.artemev@syntacore.com>
Message-ID: <e2f2131e294a49e79959d4fa9ec02cf4@syntacore.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index f8331e4688..96f9a7e348 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1624,7 +1624,7 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
         insn |= 0x02100000;
     }
     if (a0 & TCG_MO_ST_ST) {
-        insn |= 0x02200000;
+        insn |= 0x01100000;
     }
     tcg_out32(s, insn);
 }
-- 
2.43.0


