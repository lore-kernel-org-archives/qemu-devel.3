Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739E6CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgh-0001Z8-Dd; Fri, 29 May 2026 07:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgg-0001Xo-9u
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvge-0008CJ-35
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4909def6a21so2583315e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055254; x=1780660054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GtiU35O6TVYYbrzgvhU5QrUMnpE7cmAahJpVL7hIFE8=;
 b=G+VkF7UTSMaUhXj3TF8/NMbVv/UJAwWI+/j1U3A7NtXbVSm+ngdsDToUKPnSl2jQ8R
 EpyHcKn25o0TqRjer2E0p4d4ted5mKg5m0goBD0YjxVsgQUbNHQxp9lXQcb5Rhg2WIIm
 xoRN+v3CunIVD/Rey3MqANZ1a0UH+TezTwOxoJ318Uc6Bj1bob7beh8C3eLPFTMr/c/O
 t5SDjCuBRKeFcZ+3NhSyNqAHlArbk2vcJBwbp2T5VAt2m/VOddD+R8UCuV9aFCsrK0Nr
 Gfd0sZsh18uhxhCID1EFaX6xT1UIM3cnVUqghPAqfTMyIs1j+KvjCttvbpYQkEagvTJV
 3JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055254; x=1780660054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GtiU35O6TVYYbrzgvhU5QrUMnpE7cmAahJpVL7hIFE8=;
 b=H33h7aqATA3jWiqja57H9gIRE6t77UZl6rqR4GOC2kym/qytgkfdRY2ellIyRl2Py/
 7xg5Gf5qUvDaszSAuvfnyzitah1sJt4QM7sLKXzyHYzsCcurU0g3MnFRkDwd25wClfUO
 6rY2hNP0hGzTDIx1Zr/babtgJfqHQdQahehBHj3yisSVsMyt8MPePQJDzVeM8dGGHc4T
 AxEEXcqI5mwHoF2ExwPH5T4i+TLk7oAiYajsGqJPimzCU3jBbHkwL+ZJYM4aEM/XFgAG
 OiCJQvEQQJ1ugTiaeTp9kWN6Juv5sxG9I6urFZ4RgMd7KHpIsjQ7UYJmq5Z8mO5tYCXj
 Gf0A==
X-Gm-Message-State: AOJu0Yxydu8+FzvByARKDqjlYDc1Qy9Vaa5xPIjBPirkNmvg2ehXVsxR
 ES+pGX3wRK/Nq+TagA/35pK5zvJJJk+XU+P0c2bpMjV7mk43wUvsPpr74itieki/7Sz5/slK2e0
 +dYJv
X-Gm-Gg: Acq92OH53zg2yrDlXBW8/GixKlOOJc79DrBKBIRQrekchX6U4XZUssP/fXNtzXSEH3H
 6rgrFEwPR/q8F81wieP0bhMaj0BUwgdBslakcPmMbEYlBOFQtxBBuOvhMTv5dPOph04t0alPKag
 CIlbBn2hz3eomTgBXHXuc4BGg9myA34FazvdCzNcFrsaPzCX197jfFcOPWKN4EB2XPsggmwbYsi
 dKb5n0lvjBMk0nJCiurmyp3h0D6Q4mfIwRq0UeIY/cT0vGsHAQZfS4nw0wKkcx+yWJSrxuKolMu
 aMJQ/tP9mgTuuTuzBRR6mQU4X/e/7vLH1Z3KUijE2OprKN33c8t3Y0JcLtdIRRb9b8lVX2LniDh
 PxWfG3i3P9c7QQ5fYytnX8Rau5kt1G9TTOMn638YJpKBUiwttoDhYGddP2Kbvr+n1gzxkyqb4j9
 pagkjm69njmDiZSQ7nKNDdvW6ezA5x5t+HONZXiG9ejEnEoNKdFBJPNZZXEQPeq4se/mEPdl7LM
 I2ErFo6uiAqL/+SIG882kGpmTjFlpBCX9vw42NiuA==
X-Received: by 2002:a05:600c:4f53:b0:48f:e26a:1744 with SMTP id
 5b1f17b1804b1-4909c07e7d7mr46506065e9.9.1780055254537; 
 Fri, 29 May 2026 04:47:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/21] hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
Date: Fri, 29 May 2026 12:47:10 +0100
Message-ID: <20260529114723.42040-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: YannickV <Y.Vossen@beckhoff.com>

The is25lp016d has 4 Block Write Protect Bits. BP3 specifies
whether the upper or lower range should be protected. Therefore,
we add the HAS_SR_TB flag to the is25lp016d flags.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260518073401.11279-10-corvin.koehne@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index b8a2543c0b..4a4cda6602 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -217,7 +217,8 @@ static const FlashPartInfo known_devices[] = {
     /* ISSI */
     { INFO("is25lq040b",  0x9d4013,      0,  64 << 10,   8, ER_4K) },
     { INFO("is25lp080d",  0x9d6014,      0,  64 << 10,  16, ER_4K) },
-    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32, ER_4K) },
+    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32,
+           ER_4K | HAS_SR_TB) },
     { INFO("is25lp032",   0x9d6016,      0,  64 << 10,  64, ER_4K) },
     { INFO("is25lp064",   0x9d6017,      0,  64 << 10, 128, ER_4K) },
     { INFO("is25lp128",   0x9d6018,      0,  64 << 10, 256, ER_4K) },
-- 
2.43.0


