Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFE9E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRg-0008Vk-Jz; Wed, 11 Dec 2024 11:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRe-0008Tu-UQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:14 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRd-0007aF-3P
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:14 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-435004228c0so31036435e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934012; x=1734538812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M9hY+EVOhnfdsTHDgLMsqyKxn/CXpVf3YCN0NO8bItY=;
 b=XKkjupWOQtgswoE1WwqYi1vj1Oj6OKSvtsuo2+3g7Y8WLXibYihncmn9f191+hMDu9
 wPU4gdS8GZGCmgbEOvT6lYTQA254hVnMROAh0L0I24PAX4wwe9D+ZV5AMq6F4GuauYRu
 yMoBf8LFEfeBX3PxwOp5dD55OZzO4gTk+sgNEQxzRZp1IY2dVUVE/P2bcKnt6CoQhGWA
 egolTFUBn3yZX9DE+4iWjmMR8ej4XCljbXhFfgLbll8HWcYswjb4lyC9OwQpkVA6ktw9
 lji0sBZD4myXp6jO2Fze+WF6u9dKnI99twFFEDh00tfk8PNtBDjBpWPvdXxFwWrn06bh
 69AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934012; x=1734538812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9hY+EVOhnfdsTHDgLMsqyKxn/CXpVf3YCN0NO8bItY=;
 b=LHH2KFdK11F6da25YJw9GO02zExiSwMlDRNPms8gmDveuhdMAK3s1MJ/agM9771I1s
 FVfT5MtK0aEC4fLqHQ5iloSFO3mc29nXdx/93mikqfMHKiDF2aibBhUvRPVT4IjU82es
 W2IQPpQ7HEhAOgsbU1wCnZjnCA/0DnrDz1omezP9JptjtcZlf2c4RslzIsYOcOVnKDgi
 goybXM7B2AG1zQBHv46IOrcsUi0wB4/hf0Ki9vVwTwdQA/vab6rMFO11w+apEDcYLKJ+
 AvPnpwt95+7OnKaM9zqSkVVg9ngKKhC1vHhh83Pv4DcUyfdDM22cKvegGXCaTFzOd85B
 742A==
X-Gm-Message-State: AOJu0YzeDN63+nofcheJj2+VI1T5o8Zetdtl2vDOGukTZNwDGwZWrmS9
 iRjfANNUDF7LT9dRpALTsLS/x07GZWQd8kqYcqn1rM5eWwM/sOlbS6cwb4zhkg7VgDFokuwSZmI
 2
X-Gm-Gg: ASbGncuyvOOGf5dZeXSkUEgzBEXRdOaJLSsM5YLGpUCG28HPH+NouKhG4AiXdew2mJO
 NfdFeT7vHv9znK1A73wpje5OkTaFeLs2aVKI+vyAbnZhv4563QtTY5CwOx8vIkB62sCs7Oeaf+p
 dmGBmUfsTUlf5fEYKI6JxLFFMfDPx/uRQ6/yX8FYgNe6tHw2/ZmU/+qoHdcFh8EVf1HQIWqnpfF
 /VCCC75p7uPb9HuKI7RptZ78K0kO20i7a4GxTEhm9bIODpWXGMhxYUbzMaq
X-Google-Smtp-Source: AGHT+IGfDIBUpLDI4Aylj2Ic4B0/VRhGYrxt7yKG5hE4OmxN03HJE8IT666psExYNu/1BCJ160+p9g==
X-Received: by 2002:a05:600c:3b09:b0:431:5c3d:1700 with SMTP id
 5b1f17b1804b1-4361c42e606mr29831575e9.21.1733934011658; 
 Wed, 11 Dec 2024 08:20:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/72] hw/net/lan9118_phy: Fix off-by-one error in MII_ANLPAR
 register
Date: Wed, 11 Dec 2024 16:18:55 +0000
Message-Id: <20241211162004.2795499-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Turns 0x70 into 0xe0 (== 0x70 << 1) which adds the missing MII_ANLPAR_TX and
fixes the MSB of selector field to be zero, as specified in the datasheet.

Fixes: 2a424990170b "LAN9118 emulation"
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20241102125724.532843-4-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/lan9118_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index d2dcd732ac1..d8fc9ddd3ac 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -54,7 +54,7 @@ uint16_t lan9118_phy_read(Lan9118PhyState *s, int reg)
         val = s->advertise;
         break;
     case 5: /* Auto-neg Link Partner Ability */
-        val = 0x0f71;
+        val = 0x0fe1;
         break;
     case 6: /* Auto-neg Expansion */
         val = 1;
-- 
2.34.1


