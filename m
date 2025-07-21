Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8E0C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYd-0002oh-NQ; Mon, 21 Jul 2025 09:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYM-0000M6-Py
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYK-0005Kd-5M
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:38 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a522224582so2143630f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104454; x=1753709254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UY1tdCp4tGowHUgLzuBpKHat0vai5QJSXiFEppO4oFI=;
 b=FJAIK4EMEZHgjvQYV1XtuAddOGWYHrNFXcHAnz7T9kd7QIft4T9OnCFavrX+p8E5n4
 F2/LBKus8Ee+YS+mGnRSYEsnzCeYtfhlFS88z4TPRSMykBnHqIMcIGyjSQanZ9bN4jFQ
 ftZjx9OZgxDN16ocsNbKW3L/Vxxh52ZhPzKSLU57+k0ys9FtfPKnS2XHIp9ALTQjdTi7
 Vi7BxsmbgWbTuOcZUPGEho5LPiXcGMMr+zq8zdCj2Jfqan9d9duOeYCYTOta8FSH84nk
 a/+T2o9BXtMIt7Nufsz4nAUcQSJ5tiDNGvVZ6nNb7AEw5oLAhNGI3BxzWMcHZvGA75N/
 I1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104454; x=1753709254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UY1tdCp4tGowHUgLzuBpKHat0vai5QJSXiFEppO4oFI=;
 b=BpNKitjdgTYzdxY914FrB0xz1Mwk3ygFxBCIsCvTw1kbd8I/ioMKtCApP/Vg3aHGnN
 OPEBni33spB+0CrUtyXEczL+RYaUsSsUvtyd2DRfuAPJEYwsU2JjDnWlKPGuwvWWzZ5P
 S9jz6+fuj+oUlzkNo31J94ERmdGJBQ2/dzjD+yxliRskL/yfGXYKMojkQL/gLfgP7ADA
 njaPGsiI0ceQwMnbY1qAH+euQ1v4sTxqPxj5WkBtonYOdCbxdOQBqU89zlQ9DS7QC/Z0
 jP2OtdvUtjr1LEkRXc+mxaRuzVPouxid6oV2DviB3dghMI1Q/hjPk816hnitCvjf2V15
 LDoA==
X-Gm-Message-State: AOJu0YxNLC0boiNQCqKUE/0kQUcHL2ZtmgkYdcKOV3rwWr5d/1BfUToC
 z9tKnccqho7mdGrkppIndz2k1IgGrKCgxgp10z2vLNHWaxBzIqyd7k/B29zTIlUS+G6UkHB/IaW
 Wqaw6
X-Gm-Gg: ASbGnctEApB7j/suFsVpgfUDErwfpLlw95tRCM5Uwe3E/zUHn63LKwlkeqTTcC9sH0/
 hfR70kVtOpeXfV2RZE3nSjLGLuQMoEC0F1TOeaXz9knIQbbFvXPxWpoC4MFx/GZwm4jOjajFD2D
 ojKrhciZsKmN61PWO/UXsa2ejVVwICIqrBlOYL7Byfz7BwZ1yjhlAjhn70ard7LtFOBfLKTq+xb
 uhs7RHzldV9ARui9xKrALkOvVBlH3N80MmRZ1Xlut9OY6wVncDeOftrjUN1410DrYZus0cjUbI5
 54vUozBB1JtSQjYtiMX7FV86VKXA+xMHjoCo5hv6kiexK49HJtYI3DS7GW2GalyIBOLHCcuYWqH
 0QqC4mFhDNV2gQ+R2PNYd7Dd8h0Rw
X-Google-Smtp-Source: AGHT+IHtuG9a6qR47X/EL5GyALSmpxcz9atnvPL6pDGK5gMnYKSYIaN5pfVveLQf9XSPyT0kmgxz5g==
X-Received: by 2002:a05:6000:4602:b0:3b5:e6f2:ab4d with SMTP id
 ffacd0b85a97d-3b60dd997cbmr14880359f8f.42.1753104454091; 
 Mon, 21 Jul 2025 06:27:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/20] target/arm: Don't nest H() macro calls in SVE DO_REDUCE
Date: Mon, 21 Jul 2025 14:27:12 +0100
Message-ID: <20250721132718.2835729-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

In the part of the SVE DO_REDUCE macro used by the SVE2p1 FMAXQV,
FMINQV, etc insns, we incorrectly applied the H() macro twice when
calculating an offset to add to the vn pointer.  This has no effect
on little-endian hosts but on big-endian hosts the two invocations
will cancel each other out and we will access the wrong part of the
array.

The "s * 16" part of the expression is already aligned, so we only
need to use the H macro on the "e". Correct the macro usage.

Fixes: 1de7ecfc12d05 ("target/arm: Implement FADDQV, F{MIN, MAX}{NM}QV for SVE2p1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250718173032.2498900-9-peter.maydell@linaro.org
---
 target/arm/tcg/sve_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 105cc5dd122..bf894f0bf13 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4509,7 +4509,7 @@ void helper_sve2p1_##NAME##qv_##SUF(void *vd, void *vn, void *vg,     \
         TYPE data[ARM_MAX_VQ];                                        \
         for (unsigned s = 0; s < segments; s++) {                     \
             uint16_t pg = *(uint16_t *)(vg + H1_2(s * 2));            \
-            TYPE nn = *(TYPE *)(vn + H(s * 16 + H(e)));               \
+            TYPE nn = *(TYPE *)(vn + (s * 16 + H(e)));                \
             data[s] = (pg >> e) & 1 ? nn : IDENT;                     \
         }                                                             \
         *(TYPE *)(vd + H(e)) = FUNC##_reduce(data, status, segments); \
-- 
2.43.0


