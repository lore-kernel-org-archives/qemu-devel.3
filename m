Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C94C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD10A-0004bN-7N; Fri, 31 May 2024 08:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zu-0004U8-9l
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zr-0003WU-4Z
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42108739ed8so25313505e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157072; x=1717761872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hoLdKfz5//S9+WQLs/kTAMazR29BMfS0J7R/dQu2aq8=;
 b=REfQWvIaG+92WecLLwzJsvUnbzHfBjCIBQ8U/tvzO9CK/KWnBvyyfzNE6Vh7JvMnjs
 2Rgpml0TwFEgeY9FDbcOhBioQ6eOkXrQkitAsg9k3frg9l6cLqoHeNPNQNYZNbtNoeHQ
 OuR1DtnbqEbYKae0c0W2uqiu88nSpqQwkl8w1DojSjHaPcWoFiY5OmVQv3UG0wTvzeBt
 WGISexXfXYQijMkCCoqeCn5F0KkenNHmmiBZePuR6Lafa7nLeewfQuAm11Z226CQALRc
 3qMpboRmrwYqjkTGEY6pRnLnqokhtri6Sr2PpqjDtZs6JeVWgyu+7rWdeld2xRMzCR4I
 BOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157072; x=1717761872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hoLdKfz5//S9+WQLs/kTAMazR29BMfS0J7R/dQu2aq8=;
 b=KxVoP2RmCRgGoZ6qtd1gwsO/urf6UQJgKBLPTtsQ16cG9V/KrOKBsKtI7SYJJ4LEJr
 T3VRS/ZvVDL90SjC/oDpJcdThjUXnEYAHXRk7cvsjavu8FGHmr3XlTked6KkpzDuhhxz
 XpjiJU4lQb2MnvPmOvrQKfzvcEk+vp0a/8fT2nlGGvNiFhfPFZ6PgJnxIDblchdzcfoX
 huIcAnRKAoFYMHFw7fEYXjY+CIgyUicG3MvWe9tKDZX+rXWYonLDI2ILu5KO6e4LAjE5
 BkqgWjfdrBaHOgub+vOHE7auoRZAp9CqakZoNoMbX2mO3dPxbpYaNmqxjEijaKn/JaaV
 e2kA==
X-Gm-Message-State: AOJu0YzYVC/GpLw/kdXxZmU2z2MKsIrzSmE2jNFwL1bwCwWZfVcv0lCS
 IMoE7X4VqH5fEFU7sfire8xiNCdwqzRzK0082/RkRTMF+xaq8ue94KYKr9itfsn+VjL1CBh/wIO
 A
X-Google-Smtp-Source: AGHT+IGjM7FRheyA/CKQc0MuZalFWu54F5bqC1hDutWKnyje6DyfMcnFwYWzudoVIEJVEkRDjg8ATQ==
X-Received: by 2002:a05:600c:4515:b0:419:a3f:f4f6 with SMTP id
 5b1f17b1804b1-4212e046d11mr16442785e9.8.1717157071870; 
 Fri, 31 May 2024 05:04:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/43] docs/system/target-arm: Re-alphabetize board list
Date: Fri, 31 May 2024 13:03:58 +0100
Message-Id: <20240531120401.394550-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The board list in target-arm.rst is supposed to be in alphabetical
order by the title text of each file (which is not the same as
alphabetical order by filename).  A few items had got out of order;
correct them.

The entry for
"Facebook Yosemite v3.5 Platform and CraterLake Server (fby35)"
remains out-of-order, because this is not its own file
but is currently part of the aspeed.rst file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240520141421.1895138-1-peter.maydell@linaro.org
---
 docs/system/target-arm.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index c9d7c0dda7e..870d30e3502 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -86,16 +86,16 @@ undocumented; you can get a complete list by running
    arm/bananapi_m2u.rst
    arm/b-l475e-iot01a.rst
    arm/sabrelite
+   arm/highbank
    arm/digic
    arm/cubieboard
    arm/emcraft-sf2
-   arm/highbank
    arm/musicpal
    arm/gumstix
    arm/mainstone
    arm/kzm
-   arm/nrf
    arm/nseries
+   arm/nrf
    arm/nuvoton
    arm/imx25-pdk
    arm/orangepi
@@ -107,8 +107,8 @@ undocumented; you can get a complete list by running
    arm/stellaris
    arm/stm32
    arm/virt
-   arm/xlnx-versal-virt
    arm/xenpvh
+   arm/xlnx-versal-virt
 
 Emulated CPU architecture support
 =================================
-- 
2.34.1


