Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71E8CE8D61
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 09:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srDaF-0000iS-0Z; Thu, 19 Sep 2024 05:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srDaD-0000hk-7q
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 05:36:17 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srDaA-0007JY-H1
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 05:36:16 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-535be093a43so786543e87.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726738572; x=1727343372; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lQk3wNDz3JKiyjh8ZbhDK1G2OFwi/dMyBXNc4TF75Ak=;
 b=O9pRIOY3Igm+0ZRZQqehu1U2bFkSHyUGoIFLPOTMVAtq8dYYyXR4jBCNZS7Eue8WXl
 EVQla2fKOJnlpUXipUEdnMe2lW9tzhjO4jzFmCweTJa1LgZw7J0mpP2jPsaH++uuqFox
 K7S96txrJS2TvHOrQ52oyeXsX+EY6h8cLX7ywt+86JE3NZFagH8yOqXWitgF5NbBU2Vw
 E3o71hC3aaVdtPW+UtWv7FXrrIr8pvylRvqeB2H+BFMiNWWnT2U9zYZU2bzRUYOgfBFv
 Au8ooq47HBriqAQNmQ5ye+b1pAPotFWT7seDK2A/KasjtrFwvzN63OvROa0dkAFzYRDp
 Lu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726738572; x=1727343372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lQk3wNDz3JKiyjh8ZbhDK1G2OFwi/dMyBXNc4TF75Ak=;
 b=KlD563/0lOkpFjO6Txk5VVUT7fEyaPuvfC3v+rUyIhEkQFG3L5XeHfOBA3jEjqI/rU
 aj/GZLtXhrzwf13ZL0CSyvOCGLBg1b7mYAvt7Q0u930CBa9e5+Xhx5lVkSvVFjGLVG60
 39RHNotVQHUkUX1qwV/eqY4fVoSxF7ZAaaS4ikoA3Wm8eIoh03dj3td6NbB5TkzsiVvg
 d1wQAR/Z0JXEoZc7FXvfZr7bv/+ZiduuStSKBHzLunMNeHVRy9b4SZrKRBY1PIjlB2go
 Wpn0ryiukb0+rNa0Qp2xa29P3iDReYtLl01YiY+xJdwQu/nHbSRor3z8Wfu+du/+Jpio
 bOuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEaIx3qCivfB0N8+Ouh9RFSk4hbyJfGYjOZgSDG/4Ext4KjXx5PCt6Vue5RA9Orl98HhWwFIEuNhoj@nongnu.org
X-Gm-Message-State: AOJu0YyDGaycpwmYe+VT/GFceZ1fULDloTCNn4Xlh20tIbqbUJa/onVo
 BjRSY0IGc6tW3Yh4F81txdsV7pAbj7p1kNZ7Q88kEIhslb+qWp9zc7PWASkv5YPIshJWtS2QmLB
 wLo2QHZzvfMnFz4/wD6N2+rf/lgb89ll0JaOssw==
X-Google-Smtp-Source: AGHT+IHN+m7ETAaB03wNc6RnaeBNFcBNNi3Xu+yNgzClf4JLEc333Hwfy/IGJxPt/pkuJzcufGf5wKmtaOz2UWBJ+lY=
X-Received: by 2002:a05:6512:2345:b0:533:4689:973c with SMTP id
 2adb3069b0e04-53678fbaf3cmr11818141e87.23.1726738571865; Thu, 19 Sep 2024
 02:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
 <20240918192254.3136903-9-tavip@google.com>
 <Zus1YzMOZD1ppO-2@mail.minyard.net>
 <CAGWr4cSvq+WnUQO3-8jyasQPhKGQCvzOYqRm5W8vRdhW9iU=xw@mail.gmail.com>
 <ZutGsQglLtK7MtRB@mail.minyard.net>
In-Reply-To: <ZutGsQglLtK7MtRB@mail.minyard.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2024 10:36:00 +0100
Message-ID: <CAFEAcA_ZUkz8xv_PP27nD_eRL18v0cU6A7K+K57b8ML-9pmodQ@mail.gmail.com>
Subject: Re: [PATCH 08/25] hw/i2c: add support for flexcomm i2c
To: corey@minyard.net
Cc: Octavian Purdila <tavip@google.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 stefanst@google.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, eduardo@habkost.net, luc@lmichel.fr, 
 damien.hedde@dahe.fr, alistair@alistair23.me, thuth@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Wed, 18 Sept 2024 at 22:31, Corey Minyard <corey@minyard.net> wrote:
> Generally it's frowned upon to have a ton of extra stuff that's not
> used.  I would think some is ok, like defining bits in registers that
> aren't used yet, but I have no idea how all the enums below here
> actually tie into anything.  I'm guessing these are just bitmasks into
> registers, but really, it's a lot easier to read if you have something
> like:
>
> /*
>  * The I2C Master function enable. When disabled, the Master
>  * configuration settings are not changed, but the Master function is
>  * internally reset.
>  */
> #define FLEXCOMM_I2C_CFG_MSTEN (1 << 4)

The FIELD macro already gives you that:
  FIELD(FLEXCOMM_I2C_CFG, MSTEN, startbit, len);
will define an R_FLEXCOMM_I2C_CFG_MSTEN_MASK (which is
(1 << startbit) for the 'len == 1' case).

You can also set and read a 1 bit field the same as
any other, with the FIELD_DP32/FIELD_EX32 macros, so
you don't often need to directly use the MASK macro:
  s->cfg = FIELD_DP32(s->cfg, CFG, MSTEN, 1);
and
  if (FIELD_EX32(s->cfg, CFG, MSTEN)) {
     ...
  }

The FIELD() macros are a bit unwieldy sometimes but the
advantage over ad-hoc #defines is that they're consistent
for every field in every register.

I agree that providing enums for the possible values for 1-bit
fields is a bit superfluous.

thanks
-- PMM

