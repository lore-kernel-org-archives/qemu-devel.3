Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115A2C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0k6-0002eK-WD; Mon, 04 Aug 2025 15:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06Y-0001ES-6N
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:17 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06R-0001As-TE
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:12 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76bdce2ee10so2488979b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754332806; x=1754937606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bB7IRnB2X72HyfFQdO8pk3Ty2DGMB4Kj1UdkMvzsUlw=;
 b=q4leUAtVs4wFdbHZDmDHGyTpxED5lmYCXwUWji3kUuqojVManVqTHwjxaM05zR4Kt+
 wWtrk2m6Q94CuGGfOyPwimI+gcHt6VFXxx6QTJy5cm8fDkTo3qGH8YUqDKYwF/6keraG
 S7D6pZwjBJeIP4KrdR1MxqdYIrUW9tLp83BowV/6rYoTzhVpbTvl3i3vTRnDyFfp/ScM
 7vDRvYs73gWdbwpDPECzVuA3+I+1C0lJMjM9Sxxx1g1YJYOWEh0/ZVCvVWCUuEYr9rsy
 KnW/C0YkfKSDtz3qRx9Jzt650V+kXb6w5L9/y9bFrTvakAY7J5l0gTUCNL35Xf3qr2NH
 O9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754332806; x=1754937606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bB7IRnB2X72HyfFQdO8pk3Ty2DGMB4Kj1UdkMvzsUlw=;
 b=bFqVLsSv0YpeOCxqz4GmBMLPriSNfrzDb10JgfNTH2hAxQZQn2oDgViy1+RXEER3+v
 W3QO+kWnZ7/DvSsE41ULV6z6szUbGUfgEBD7Jg4ebNK+g8AhEBulCTCjRgzLYPR6lu/t
 WIiHk6O1YOgHf936wcccyi2k3f6nTtDBDtj9BPo4BYTJFTdz+pmLIccQTsMI4hcx74vq
 VvnDd7pwOFdaSPJMU1UsOwrS+obRDbBtESyZU6r3v6K+j0gypOcm3Lh8A0eo3t1RH9lH
 hijx9SHcghwP3/DcyeURBKiQsXcOGozTikwIc3xBdkgzHljuNarJ9w/A0UxTFh2+N4Re
 LI9Q==
X-Gm-Message-State: AOJu0YwQKvufcEDFCry6G2h93eipDdCHaVGDtajRR9lD3I6eZtyvjw70
 t/USyYfgACAtHGy6y+/3JXhML+F8H5eS7J/8LCgyPeNyep6WLlQRLYXfK3yjNstBHgXwIBeLs6P
 oqqRs
X-Gm-Gg: ASbGncvD/vQ25J9BvA3H1ZhDF/xb2lA/YN7dObl94A4J4M/IQt1knNm5qeoa7iW6grx
 oS8kK+auR+NToF4SsrHA+F5NTbECEZHpP5RNC/JVY6zf9Zp3WchL12FhSgR7jlyq8EEjBy9vyKQ
 28mmCJ/XanbZK1hF1riZBLqgr+TJIzJnHOJ0nfexyl+rOHWY5nIyqYj+ilkcLq5p1PCOi/Unq/+
 WiuKdnruumvYipxn+I+GvEEOowiTyzaXB6v+nMcz3+bIh4YlZ5DpRcGuHRvljhO5Hua4FhhIpvd
 IgbSNCEuYiaUDTPabDmt+dItsOVqJ4YMulCBCXO26vr/TyikJ9rhmahWFRGdiVsMzSSDxshobJL
 aDyCkAFnth5ay3H25+joQNA==
X-Google-Smtp-Source: AGHT+IEYkGZM3k0ctQRWy6R3Zit6AC8O84fNQgxm3FWYumeodaFHzn1yK2QVOBU5TXfjz31HO9n39g==
X-Received: by 2002:a05:6a00:2d11:b0:76c:503:180d with SMTP id
 d2e1a72fcca58-76c05031c1fmr7477209b3a.8.1754332806414; 
 Mon, 04 Aug 2025 11:40:06 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd78875cesm9940171b3a.15.2025.08.04.11.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 11:40:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 10/12] semihosting/arm-compat-semi: eradicate target_long
Date: Mon,  4 Aug 2025 11:39:48 -0700
Message-ID: <20250804183950.3147154-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
References: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

We use int64_t or int32_t depending on ret size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/arm-compat-semi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index f593239cc9a..55d7bf29ad6 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -501,10 +501,13 @@ void do_common_semihosting(CPUState *cs)
         break;
 
     case TARGET_SYS_ISERROR:
+    {
         GET_ARG(0);
-        common_semi_set_ret(cs, (target_long)arg0 < 0);
+        bool ret = is_64bit_semihosting(env) ?
+                   (int64_t)arg0 < 0 : (int32_t)arg0 < 0;
+        common_semi_set_ret(cs, ret);
         break;
-
+    }
     case TARGET_SYS_ISTTY:
         GET_ARG(0);
         semihost_sys_isatty(cs, common_semi_istty_cb, arg0);
-- 
2.47.2


