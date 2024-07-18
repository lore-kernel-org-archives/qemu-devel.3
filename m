Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5275C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR3q-0008F5-Oa; Thu, 18 Jul 2024 09:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3l-0007td-4l
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:38 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3i-0004Sw-O2
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:36 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eefc3d707dso10106351fa.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308832; x=1721913632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yCmmBscXHr7DP5v15ZBTuTVPUGJ3/3t6QvO+9hat3Zg=;
 b=ZXzWSJwmIXu4ps812/7Zlkt10i+g9PzqVVi66timp6scgeqeoEAARK14HUg1o5aMme
 2DmLEJ/ekfpXmsJNPtWMx5TXQhfStM9bjlgNO8y6Bigox4NRH12Mrmlquejv7+N2NZgu
 KAvebyV02Cg0+49/YiJNDz/KgiTbLo9lNPWTIpbeOEbTIfkR3NCTBQwNEBmbLdbgbCOu
 gOsKOW3MKQSnauVVn2iXdESSS2ApziWYakhwCx1Bb+btmYeG3SAw+mWF5UDlHWI7IEwV
 lCPXoL0tEH0IUizLdxmV4OMPN9HXzcbzImqmQloMvxo2K6KH/iNp/uDUygLfJlY99bQH
 Rv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308832; x=1721913632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCmmBscXHr7DP5v15ZBTuTVPUGJ3/3t6QvO+9hat3Zg=;
 b=Lg3pYg4zqSxGO0/EPLdJ7uOG6dKZTXaEHdYBlP3j0psp/2PAwKdIEMoDxKMJS2zvzs
 ntytLZO9+7ui6omTxTjdAvBiOhX+iYq2JEr5BN9qLCwTvISb3BIZOD8v+etq/m8hb2Jt
 kzC12XhURQ7dGQvBIYtUCLboH88v/SRglXP9KrEE0ylLxCAbQOqhzFKnfmEoP3qyWolo
 MQG7QPvXiOxCvZW60uPFFxU6mDzG6rGWgSzyV20svRQiGW7aGT7nJKV/M2JbVAdSMnry
 h7/xDOX4OQw2vnok47NYl66zYfi1lxIjF3efj4avTQyq/6dn7jfiJrNutZMl2lSuRL7J
 odbA==
X-Gm-Message-State: AOJu0YwyitLTObNa0EeFNAsa7tm4pYn7xRpg5K3m2FXoAQJXNDeUFIVG
 n5XGskD7Wu+a5rCPLgAA+QSydJl7zPg17RcQLYKHO6qLsjAC3apnW1ObNg8eHmdtuyIMqhdDu1L
 C
X-Google-Smtp-Source: AGHT+IGXHxxehFhsnAbj/v7cuJHva1NVc/GuH2A/0X/pXU8X7lqr4E6BEnfn0LdDAA/p5t0ytO/+/A==
X-Received: by 2002:a2e:7314:0:b0:2ee:bd1b:84c with SMTP id
 38308e7fff4ca-2ef05996013mr16963951fa.0.1721308831557; 
 Thu, 18 Jul 2024 06:20:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/26] hw/display/bcm2835_fb: fix fb_use_offsets condition
Date: Thu, 18 Jul 2024 14:20:05 +0100
Message-Id: <20240718132028.697927-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

From: SamJakob <me@samjakob.com>

It is common practice when implementing double-buffering on VideoCore
to do so by multiplying the height of the virtual buffer by the
number of virtual screens desired (i.e., two - in the case of
double-bufferring).

At present, this won't work in QEMU because the logic in
fb_use_offsets require that both the virtual width and height exceed
their physical counterparts.

This appears to be unintentional/a typo and indeed the comment
states; "Experimentally, the hardware seems to do this only if the
viewport size is larger than the physical screen".  The
viewport/virtual size would be larger than the physical size if
either virtual dimension were larger than their physical counterparts
and not necessarily both.

Signed-off-by: SamJakob <me@samjakob.com>
Message-id: 20240713160353.62410-1-me@samjakob.com
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/bcm2835_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index e40ed2d2e18..650db3da82c 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -145,7 +145,7 @@ static bool fb_use_offsets(BCM2835FBConfig *config)
      * viewport size is larger than the physical screen. (It doesn't
      * prevent the guest setting this silly viewport setting, though...)
      */
-    return config->xres_virtual > config->xres &&
+    return config->xres_virtual > config->xres ||
         config->yres_virtual > config->yres;
 }
 
-- 
2.34.1


