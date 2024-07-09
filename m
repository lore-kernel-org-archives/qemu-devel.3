Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858AFC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRClH-0004JU-KB; Tue, 09 Jul 2024 11:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCl9-0003T9-DA
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:28:04 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCl3-0006Y7-SV
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:28:03 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52ea1a69624so6105525e87.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538875; x=1721143675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IrpdCD+BuSWH4PAnzhWg9dOS6Rs+7FERDF9DQN/buM=;
 b=TQIzWjlzP2Vk/R3b23Bu50k2arFb2fFPAA+v5ToFk4KxWqDKMY5A6gtd6a9f0mpctk
 OGq8Jw7EzNhRqrFrhV0kn3Z0F4Suqd2ziOJabG4NmawKNUtuSWQx3XDZZlmEWmUQ539M
 pb1paKImHdWxcDDH5rK6h0otyX6aMU4bEkNz00PmdKdBkgfu04cXLLaZkgDRMc1Amfoe
 pJM1JodVQHMXUQSSV3YbX5zezjLZaemdzZbtBamBjIiYH1RX9jx8GDeqZjunijHRCQDw
 U9GSkD54z+FTdhJIf9d3IPxQGXRm0dAp0RUiw6nOblzdeZRx/dsXI0orfh1kD6q98Atw
 nxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538875; x=1721143675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+IrpdCD+BuSWH4PAnzhWg9dOS6Rs+7FERDF9DQN/buM=;
 b=IPl/KlOQdtxmlioyRDMCzQ2Q36enr++P/psKXm8d+V6okb1HwmCuG54rfkMyCF/22J
 Cbxa+0yhxf7rNl4HhfDGsLPd/21dW839LIluIkHCSSA8mdfUj9Fx90Iyr3Ql5i9FYpzE
 WdU3+pMgzPUgtWn8lFcZcDYdI6KTGj3iFuPGLaH4UOkzQPLPf1qoQVAeP/7THWJB3SO4
 JV79uoNXgJGBERv4AQrHOglmxdlr5S7edwNThHRuqeJVbmSzJN42sda6m6O+iO3IqHJ/
 vCf7x+xdXpFsoo9HsJ2+KKQsjhMaeWcoEtY1zhoahQK80oXcEiiRMQQUq5EfxQGYIfCz
 8bCQ==
X-Gm-Message-State: AOJu0Yz3iwFJsFaZr0Gjbd+xhAIfIZdhhP+WeabgVn8AQT1Ank+noUfE
 6gZu47PqoRCm4C+1hxDhzxSIYT4NMnC8wk9f6+Vzzuh7lcqZ3v2O82S7puFLwiNlj6Z7vf3MdfC
 v
X-Google-Smtp-Source: AGHT+IE/KUS9nFXQqVi+nJcCXRRmL4z0TVAQ8SIkOfTfqf/rl3q1LRxFnr1ooIy43BiTlWlIYepmaA==
X-Received: by 2002:a05:6512:1154:b0:52b:c14d:733c with SMTP id
 2adb3069b0e04-52eb99d741bmr1577497e87.68.1720538875240; 
 Tue, 09 Jul 2024 08:27:55 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f7420cesm45316395e9.46.2024.07.09.08.27.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:27:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
Subject: [PATCH v47 19/19] hw/sd/sdcard: Enable TYPE_EMMC card model
Date: Tue,  9 Jul 2024 17:25:56 +0200
Message-ID: <20240709152556.52896-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now than the implementation is functional, allow
to instantiate it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6aa83251f7..4a6e9cc035 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2941,7 +2941,6 @@ static const TypeInfo sd_types[] = {
         .name           = TYPE_EMMC,
         .parent         = TYPE_SDMMC_COMMON,
         .class_init     = emmc_class_init,
-        .abstract       = true, /* FIXME: Remove once model fully functional */
     },
 };
 
-- 
2.41.0


