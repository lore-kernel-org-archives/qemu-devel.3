Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5366CE77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5h-0007L8-8L; Sun, 08 Dec 2024 17:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5M-0007D4-8f
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:08 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5K-0006GV-RO
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:08 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71df1f45b0cso170632a34.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698146; x=1734302946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kB6bt5gsM+uIGBlj2PVExFpGSSwWH11mu7Vzk4S/tlM=;
 b=WQzJ1+JNa7euvYNVHjmsaOK5b4JQ22vBD094u7ZSml2jl4gdf/I6NBzrvJd2Q5FmqT
 1lIep+UcTijxe883NAah0MugonXHIedLgBHrASLvZpeRbiWkqIk2hIAKrH2h2LQpOlrI
 O7cNZO8CcwzyAsZ6Zujfld4vFyKBSKqsZVY1VqAX4IAZucUc36InFxMQn14JXioBp7eC
 ve2pvXJqIWzQnpfhnFMq5VGHRyUABD31VEdm+MEbdk9gdWdFzKkJ1jdru1ycgGBcG9C7
 r6K6oO8ckhjihj9jt/X0C+zh3JnFMUxQ/cOkMSBmCed4R+dKq0mZKRvn764ZEHSrOUap
 BRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698146; x=1734302946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kB6bt5gsM+uIGBlj2PVExFpGSSwWH11mu7Vzk4S/tlM=;
 b=Y4rbxnXjgm0W1AJM43hTGNq/ihMjwo9UZ8wqwCoKaGMbmAl6myzYIpZ+uwa0/xnuLd
 IPUU+SlRhthH8IYbYH65WFGBQtiSHfFMgZD0GsXKlVVQj+taub7r58Xy0lc/cZ0RRm1u
 R43N17uVcZpyHPje+dbmulJ5Sdg3DD7u5icAH99Dl4u6SoiCeun8j2Eg9OdJ9bzd2dEb
 9oADkSG7T82+tH8/mwt02amBsDB8zNwgMNnLtanTjQXPlglTPKA0lYIWr9DoptJPRJn3
 We4sSQECpwJVAXQuC718b1cpck6dNM2azHVr+RV98NJUJ5GCrj5ZyTatGM92AyDQUDfT
 y1vg==
X-Gm-Message-State: AOJu0YzFj0jN7Q+RSXvcT5G3LMHAeXvoViYb1HvYUyO+Q2LkfFV0SrtD
 FKbx7CvGFR/98cA9HiL6urEw3B0KS7OfTxFPE/IXca7al3P/ngkBmFATeNBLub1eJ3kDhrxOFI5
 Cx5lZ7Q==
X-Gm-Gg: ASbGncskL5p2R6OdmTz5zYVFboWGoRubcHfPZeghHlL/O25tiubj/IKjHCEvQ7W/u6k
 C1igPvBniWaqR3LVxiZQyemV9bfFeSXJ6y9tx5FL7vRF7HNxgeFxjHBPbxMC6K15xILT6Bw/yMw
 LMIy+6ILHUdOqGsuQIfQwk/uttMC2TJK7wIfKCWeAFEaEqpvchBQf9EY2ajUybbRYATU/QtAk96
 q26Mjsi/nCafvE+1F8g3ImGhfdumu3tP22EkTJQ/+5AA1HVyesdgAaGDufo1/iq6uX/RLiE1NIn
 wdskw+8E9i20613I4N1UXTZV1wHzQGeibrSe
X-Google-Smtp-Source: AGHT+IFE+paJKOG72+tI2ayl89k0tJPy95KMNwz5gXEH/pWnrF8tFUO7NxakPEHz6yheN8z8R+ahvQ==
X-Received: by 2002:a05:6830:25d0:b0:718:4fd:bd78 with SMTP id
 46e09a7af769-71dced091famr6067572a34.13.1733698145830; 
 Sun, 08 Dec 2024 14:49:05 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:49:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 16/17] target/hexagon: Use mulu64 for int128_mul_6464
Date: Sun,  8 Dec 2024 16:48:43 -0600
Message-ID: <20241208224844.570491-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index 343c40a686..6749538c09 100644
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


