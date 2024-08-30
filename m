Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF89CA0EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 18:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk607-0003CR-Fa; Fri, 30 Aug 2024 14:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk5zw-00037E-8O
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:05:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk5zt-0006Yi-39
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:05:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42bb8cf8a5bso14259375e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725041118; x=1725645918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=87fChB+xc7soA2EPRxfWWl3aNqmrKrcv5Gq87Q1dcqo=;
 b=FIqM/CbS4br1G/WLewwDxMx2ivRf0XUfGdn+p1D6P5q86Hm0k2B0DK4YCyDw7Bq9F8
 FWd9ikntxQ81Hd0j3kg3UoNgOnIUbkft+X8dbCRBFxk4DDBtmZ+vXaZs6gYaaKbNLn7i
 j09saCLvJ+SxGEd/rPGOQVXXdpI/fkRkpkgqSQoRlCw5zk7Lbtev51S8kBlPEKd+5bhe
 E+l4AFhDtN6GCFW2Nkg9Fsdfv+CWCwlz+tgCYbrrSadgQErbenBz6KC7PecLtv0Jxhhy
 Q2MOnQYjmkzaaIRZiwPVm/afkwmSeTFxfznDY7LJDbJNyXG7cyZBcj+78m5R8z9g9bnu
 ZRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725041118; x=1725645918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=87fChB+xc7soA2EPRxfWWl3aNqmrKrcv5Gq87Q1dcqo=;
 b=YuQOc6nsG67xx2/h1MuLs3oAsjsXME+5hwk6s+jxeMyaBe+eHtFiZIqz2WS8JnpHBw
 s2XelG4CFh9p4s0duriIzjDEDJyAFLBsLWM/U6SmzjJ8CHlvobbqRCRCp305gzIQLsns
 k0VP8ZL7nozZ9ofk8SwbrXSXb2W3fpfKslc0UQ0LspK2K7V3AjIef/ob4zqfQN0V3A3j
 PEnWUOlCLen+Q7wOcHxSTiVRiT2Q+oNoTMyVJY3Xby5+Ibm81Mxx/qgh/tq89nSOurRW
 K3bbuCf8TM2h7Vb0luk0HsO9u1pybaiEy7xjuyj+wf8A1ChJsksM9aXVr494sL7aYAKZ
 Ki6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOuPzXLYJQzgDIOiDTi4nJmE3ceC91bKkt797m+7e5b+aMi2t4v7pwXeIxikGQ8MriaXu8rDfHoQ+5@nongnu.org
X-Gm-Message-State: AOJu0YyP0NIMhWx5R/feVoJVytn5J28A9hynhnWro8xhrqlJuM7l/9EB
 crgrxuu/3hweeip3qks4eUJoZuUvHv3ugez1QfwJyO7wjh3wL3U9mLWel1if8tY=
X-Google-Smtp-Source: AGHT+IFPrpNb9+Tkdye1l5pkQBg/gM2yevwxGKkYvtwY1e6R/IawqdDblLVkBlCqLkg0i+B+DXhrFw==
X-Received: by 2002:a05:600c:3c93:b0:426:67f0:b4eb with SMTP id
 5b1f17b1804b1-42bb0244482mr54257325e9.2.1725041117971; 
 Fri, 30 Aug 2024 11:05:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbe79f545sm18969555e9.2.2024.08.30.11.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 11:05:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] hw/gpio/aspeed_gpio: Avoid shift into sign bit
Date: Fri, 30 Aug 2024 19:05:16 +0100
Message-Id: <20240830180516.2103062-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In aspeed_gpio_update() we calculate "mask = 1 << gpio", where
gpio can be between 0 and 31. Coverity complains about this
because 1 << 31 won't fit in a signed integer.

For QEMU this isn't an error because we enable -fwrapv,
but we can keep Coverity happy by doing the shift on
unsigned numbers.

Resolves: Coverity CID 1547742
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Very minor but I'm just fixing a few easy issues on a Friday
evening :-)

 hw/gpio/aspeed_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 6474bb8de5b..d6ccf63a2ff 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -281,7 +281,7 @@ static void aspeed_gpio_update(AspeedGPIOState *s, GPIOSets *regs,
     diff &= mode_mask;
     if (diff) {
         for (gpio = 0; gpio < ASPEED_GPIOS_PER_SET; gpio++) {
-            uint32_t mask = 1 << gpio;
+            uint32_t mask = 1U << gpio;
 
             /* If the gpio needs to be updated... */
             if (!(diff & mask)) {
-- 
2.34.1


