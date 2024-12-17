Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3918DE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbEx-0007zU-IR; Tue, 17 Dec 2024 12:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEt-0007yJ-0y
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:07 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEj-0006EN-BC
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:06 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so3142638f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455995; x=1735060795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aHyyIHMtv0oMxmwcCUA/L8UMGk0pBiBPJFrKgf77yOE=;
 b=ybPcov6Bg3sQQuVF1XlHiQ2HuPngvfmBAdAsdbzY+mvDjmyDGYibN8knZCVrFedB4e
 DxiJgrsSWLkB9aPcxoht5iEaZQFjfREHfD0306oWptkftx91uRTCsXzst4qfaL0TUnkr
 r5w75au9qfzWc4HALcx9XdrVQ4LZ0RXOemK/ePyGvHZQv/hiVLI3/a9Jsxl1RTvQ3nBc
 0uAWzYEvFtjGGZOAruVD6Z+vmcz6HPjsg5hyzq367xVLZyqQ2/FUR0KzmKnbMRdYgIKx
 xC5TwuoLo1w/PzYo8oXz5k1/sXhRWtonbI9nRcSCUl8oqHVdn3+/IdgPvb4C2xv9ozT/
 tWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455995; x=1735060795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aHyyIHMtv0oMxmwcCUA/L8UMGk0pBiBPJFrKgf77yOE=;
 b=DbIm+6IEi4CO7B3X3RkPEHkC4vPvurVICPKmepUzN9Ssqi/cmmZB45shFCah6KIpoY
 WQKW5OlTvbqMRnzZXprziaxp/XOCySXzx40dyRp9Esnu7ci8d9jNcHaNWD2vk81PzkrH
 Iw4uMa9qRN/xTSNO9bK9R9wJfPOXVot+QS5pQYdGej0X6/2H78SwdFd5vCQhrtF3jNhz
 6hN1tQ4wKVEQ/WluUIjushT21i8C12YeO1HyAZIOFnO8WzfYb1WsOGvGyDfwt+/uy1xU
 Tq+HtZAEuiGPaTzm+nxz8oa7txi+M1fbGDcXxZI9E7auCiuccK70+kRsaNq1w2ZQJxp1
 YHVA==
X-Gm-Message-State: AOJu0Ywb4PFHBwrVdrtj8DDhRZ3tBUXY9l0yak74WXZ/PhJTGgjMP12A
 +l7BuoCAmBDXecOHknC5a5o1l7n6ZpJyxO+Lgwu2fXNiyMA2BoG4RUahXnTSvuoVlXzZstyqLNd
 G
X-Gm-Gg: ASbGnct24PHGUgzma1wKBcQOcYpYbUPn0QT/OvJSAjf52iKu7H94tj0oM0G6hG0e0Zs
 cnxu1FFfALmIh78twOPpslYrFFxUYmtCIXtIT7Xb9eqImlkZywSXC7FEdgI+L2UB1Rhbl6nbBdD
 3BreF/6n3QGvVCTiGyT8ghzy+5XeDmgJJRt+xdVUc1y7zGkCI8WVWfbbyODXogslyLG/NxSe0M/
 I3RNjT/gMtfWzmij9HITa3PwRVMm26pAxhaFFx2g8a8QbMnFNnklqtlElgN7co=
X-Google-Smtp-Source: AGHT+IH+4VWQr7a1kwP3dYK8aZMolBOl799ayFRzvFfMYjZjOHxsHypDs6xUIoGgD+qOV9RpF7zfdg==
X-Received: by 2002:a05:6000:186c:b0:385:e105:d884 with SMTP id
 ffacd0b85a97d-388e4664e22mr31233f8f.46.1734455995047; 
 Tue, 17 Dec 2024 09:19:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/19] target/arm: Add decodetree entry for DSB nXS variant
Date: Tue, 17 Dec 2024 17:19:33 +0000
Message-Id: <20241217171937.3899947-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

The DSB nXS variant is always both a reads and writes request type.
Ignore the domain field like we do in plain DSB and perform a full
system barrier operation.

The DSB nXS variant is part of FEAT_XS made mandatory from Armv8.7.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211144440.2700268-5-peter.maydell@linaro.org
[PMM: added missing "UNDEF unless feature present" check]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 3 +++
 target/arm/tcg/translate-a64.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7aa10f51471..8c798cde2b4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -260,6 +260,9 @@ WFIT            1101 0101 0000 0011 0001 0000 001 rd:5
 
 CLREX           1101 0101 0000 0011 0011 ---- 010 11111
 DSB_DMB         1101 0101 0000 0011 0011 domain:2 types:2 10- 11111
+# For the DSB nXS variant, types always equals MBReqTypes_All and we ignore the
+# domain bits.
+DSB_nXS         1101 0101 0000 0011 0011 -- 10 001 11111
 ISB             1101 0101 0000 0011 0011 ---- 110 11111
 SB              1101 0101 0000 0011 0011 0000 111 11111
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ecbc46ba55f..7c65fc3a3b1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1986,6 +1986,15 @@ static bool trans_DSB_DMB(DisasContext *s, arg_DSB_DMB *a)
     return true;
 }
 
+static bool trans_DSB_nXS(DisasContext *s, arg_DSB_nXS *a)
+{
+    if (!dc_isar_feature(aa64_xs, s)) {
+        return false;
+    }
+    tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+    return true;
+}
+
 static bool trans_ISB(DisasContext *s, arg_ISB *a)
 {
     /*
-- 
2.34.1


