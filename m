Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11BBE7718E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDs-0000fH-0g; Tue, 24 Dec 2024 15:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDh-0007cC-JG
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:34 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDf-00030x-Ro
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:33 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21631789fcdso47001165ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070970; x=1735675770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3y+AMSb8rvB6VTUgl6UjDCiMyf5UHg9L6oBAf1WE4w=;
 b=QRF+WSytAizZEVmDGUAhMK9zkDw4TEbThe4XS++5AIS9IWhEaINDFsii7hflDkHdgy
 ifb+AszHk8hQUcLJnrc5D6azXz4vuq3KsPDvXJXCK4d85/TxE10xiMnPQHqAWfj2kLv1
 hiUvxBloaQofBvVACArluwBRsLzLEXwL1vvWoq9m1IyAfIiwsWplWM04TvOzFvAH5v/B
 E8AyZUT9EpdcW1EWha6tzDVClB1C3oGSf9eQqbXBFJL3y7TYjm4g+VwDb+qoL3Wf8/UA
 9UCIPQ2NNNp7luSMD/Pku3pbyrn6S0peORnnhcFoOEND/468nj0dd2kkVYg/w+yVPOFz
 WLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070970; x=1735675770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3y+AMSb8rvB6VTUgl6UjDCiMyf5UHg9L6oBAf1WE4w=;
 b=g/6Z5GuR44NQ0zgL6XVz0R9GHrXFAGH9nwLF1Vk7UOWXxAcqdBdFkz+nHlSY0SKoLE
 5IYocgaGuNNeS8ewPkbh9X4BMSRpQR2GoX9Hja2TdlDoRXKxu3BS3wOXqeKwvWn9g/sK
 TP67NvOoUws2TTwihPigLhunefzBbbV0S5a5K8D/qyxdVo/8iAh6ArKf4l2gX+UxZW2S
 sSlTtFvm6o4hI1jNi0jU3pwQ8XUk9sSjOfkP0shXuI+FqCIsh3Mh627HlvstD/M/F6pt
 g0AIgINhwfu4nd8X2jYItXFvGN1WXcOq6ddIXVYKHEC5fum9o94y7zyr0LehaLm5rari
 TrUg==
X-Gm-Message-State: AOJu0Yygs2Hk6fhxqhbTy6LXZeNwzmL8RNZ1SAo7jmDdPLXKTMk2WTw2
 9JJ06PdJWZYphjssEqg23XuXBjNTg5VmGKsSFCSPsMT4++YSHP2WbQ36NxkwDMkdyZ24uVmjiDQ
 1WQc=
X-Gm-Gg: ASbGncsIP+2VIXn36HZBqtfctf1YeehRzzRUnwpg5FZcgFdjaHB6seJ3MgkKQggjAQi
 MdFakmMPNqU9uiIw5HeE9Vs4rsY8NHNU8XB0dG5gNfLtcSYB5j7OASmuMl60hNqVBFQyehsYQ9F
 smoS37cjd9Z3nh/TFcCjm6B0yfm6EbSQymTvYgCtF6dpdlHdXI9nKMzSTPTDorW2VB+Kxy0XOBa
 ViuGi20OCFM3Y8yNpoJpRJjRI7QYXKwGrPSgcso0t8SBdAao/DWMk3FRQbGwfATpuJuRX8k+MQ6
 tPeQ6KXpsiwnp/LbS/n9Tt0bmQ==
X-Google-Smtp-Source: AGHT+IGp7TOBZiUa7Up2TEXqhP5jtgaI4NWFdsR7EhUpgPxHA7kehlLUBYw+PxPoppz2x7GONPIZNQ==
X-Received: by 2002:a05:6a00:66cb:b0:725:41c4:dbc7 with SMTP id
 d2e1a72fcca58-72abdae93e4mr26701042b3a.4.1735070970632; 
 Tue, 24 Dec 2024 12:09:30 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 70/72] target/hexagon: Use mulu64 for int128_mul_6464
Date: Tue, 24 Dec 2024 12:05:19 -0800
Message-ID: <20241224200521.310066-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
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

No need to open-code 64x64->128-bit multiplication.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index ddc793fe14..07d2880776 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -82,38 +82,12 @@ int32_t float32_getexp(float32 f32)
     return -1;
 }
 
-static uint32_t int128_getw0(Int128 x)
-{
-    return int128_getlo(x);
-}
-
-static uint32_t int128_getw1(Int128 x)
-{
-    return int128_getlo(x) >> 32;
-}
-
 static Int128 int128_mul_6464(uint64_t ai, uint64_t bi)
 {
-    Int128 a, b;
-    uint64_t pp0, pp1a, pp1b, pp1s, pp2;
+    uint64_t l, h;
 
-    a = int128_make64(ai);
-    b = int128_make64(bi);
-    pp0 = (uint64_t)int128_getw0(a) * (uint64_t)int128_getw0(b);
-    pp1a = (uint64_t)int128_getw1(a) * (uint64_t)int128_getw0(b);
-    pp1b = (uint64_t)int128_getw1(b) * (uint64_t)int128_getw0(a);
-    pp2 = (uint64_t)int128_getw1(a) * (uint64_t)int128_getw1(b);
-
-    pp1s = pp1a + pp1b;
-    if ((pp1s < pp1a) || (pp1s < pp1b)) {
-        pp2 += (1ULL << 32);
-    }
-    uint64_t ret_low = pp0 + (pp1s << 32);
-    if ((ret_low < pp0) || (ret_low < (pp1s << 32))) {
-        pp2 += 1;
-    }
-
-    return int128_make128(ret_low, pp2 + (pp1s >> 32));
+    mulu64(&l, &h, ai, bi);
+    return int128_make128(l, h);
 }
 
 static Int128 int128_sub_borrow(Int128 a, Int128 b, int borrow)
-- 
2.43.0


