Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDA8E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSJ-0000TC-Nj; Wed, 11 Dec 2024 11:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSI-0000Pe-C3
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:54 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSG-0007m0-Dm
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:54 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361f796586so8314165e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934051; x=1734538851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=29O0/DLcrT8c2OpSddhWFboFUPNGO6o5HYkb0BNPIH0=;
 b=s6+uvASTZ8ulz9D3glnITwS72a8xBGMLUTjvwINKwqGRq8IzWcsbc9kj7fRzEqGj+v
 YC3rq3sepWf1XN86xtzSv4Y4lluGw6nPFgcr0EoP4i4rfm3I/A+2/8cIXgv/TjNcEDyo
 k/oO4+zk9ItFqJZmYTxtaa89vTVWPN0h1G/lkiNab3Umn1uqE6OaC0xbZQ5vrerBENCi
 fkOn55xHMgSjCxNNmGwAxTqSVEr62HXEKdUey9owV+l8XwGlFgT8dJab/RiDM0z1ECEj
 X83jjqmvifU1w/TxxzTEOCqU4TvEERVaO70FGZrzqz9IMS4TTEYw1ZcuYPHVXt6aqw2s
 sIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934051; x=1734538851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29O0/DLcrT8c2OpSddhWFboFUPNGO6o5HYkb0BNPIH0=;
 b=OZaC21PVjKUeJjGCLMDxrv8V9+ecqWCPUjby1OqTStyzWrXSlrW3aW4VFnMotZAdT4
 2K9XX1xL9nnxi0fPD/67x/3hDctrqFNB6vtqYErUa2vh6BY2mKES/I+sKERSOusQQ3Yp
 9A+PDOEmL+i9ZlSuez5EHtDGWF7+5TWgR0RYNg7DDcpcigiUtWFLCG7BdDZq/lYIMWzp
 jqcxgn0I2YWeBXUcv2L/SMvHej3OYI6yfNoDnDQDOEqB4A27YHK6JbRnAdzXWZbjRVEh
 oySGdR74OmNZ/I/4ZvAPWLPifhEVXrbXJg8/Sp8FkuH0lbpHLIVAMhI29AXb1ih3zc39
 4XVw==
X-Gm-Message-State: AOJu0Yx2Am/wdSpgO9hMwM6yyIe+5wz0rgJpzh8wlRbxRWNIsG1X+CD1
 gCn+23Tj7rAARDHJAoZBS9+SmuzMAKBvVwFaEPuH58/0dv0vEYRfOseBG66alkoKeLgRfF0OPEQ
 i
X-Gm-Gg: ASbGncuDsmF7qgV48DBJYDTi5t7cE7AEegVmPi8XpbClIKcdzLAVZdT8R1D7DcvvT4M
 9Te5drNWkmh1S35CY5+ZsB5annDycmrY0W3jv4mfTCXcDtIkRMSlYR8/NSP55Jvbq6+WEV5CKkI
 BYb1lEPoBkD334pZ/aGNI4Ob5ecLZL61hCVK8K6a445OtuZDv/7zmqfEsm0ceNtP92/IGg2Jr9J
 5xr1fmsS9k7w8kh1k30l0vK+0LXDn8cBKT3MdTbNRffmVEXRq07a4w5gVkc
X-Google-Smtp-Source: AGHT+IH78QrEhS1/5AF2lKOzp2KIYbUILskSLpOhzq7bImQH7XfkLdxsRQ+dDUOdrCgMqNhOwP+JVg==
X-Received: by 2002:a05:600c:4f11:b0:428:d31:ef25 with SMTP id
 5b1f17b1804b1-4361c3ab1bdmr32696415e9.12.1733934051020; 
 Wed, 11 Dec 2024 08:20:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/72] target/ppc: Use env->fp_status in helper_compute_fprf
 functions
Date: Wed, 11 Dec 2024 16:19:30 +0000
Message-Id: <20241211162004.2795499-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

In the helper_compute_fprf functions, we pass a dummy float_status
in to the is_signaling_nan() function. This is unnecessary, because
we have convenient access to the CPU env pointer here and that
is already set up with the correct values for the snan_bit_is_one
and no_signaling_nans config settings. is_signaling_nan() doesn't
ever update the fp_status with any exception flags, so there is
no reason not to use env->fp_status here.

Use env->fp_status instead of the dummy fp_status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-34-peter.maydell@linaro.org
---
 target/ppc/fpu_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 230466a87f3..d93cfed17b4 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -155,8 +155,7 @@ void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)           \
     } else if (tp##_is_infinity(arg)) {                           \
         fprf = neg ? 0x09 << FPSCR_FPRF : 0x05 << FPSCR_FPRF;     \
     } else {                                                      \
-        float_status dummy = { };  /* snan_bit_is_one = 0 */      \
-        if (tp##_is_signaling_nan(arg, &dummy)) {                 \
+        if (tp##_is_signaling_nan(arg, &env->fp_status)) {        \
             fprf = 0x00 << FPSCR_FPRF;                            \
         } else {                                                  \
             fprf = 0x11 << FPSCR_FPRF;                            \
-- 
2.34.1


