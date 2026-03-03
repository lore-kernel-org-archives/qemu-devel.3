Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E43EC1432
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNrW-00051j-La; Tue, 03 Mar 2026 06:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNrS-000516-F9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:24:22 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNrQ-0005rW-3X
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:24:22 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64c9ebd1369so4855677d50.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:24:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772537058; cv=none;
 d=google.com; s=arc-20240605;
 b=luw6cuWk6AzDKuWbO26sp5YjQIlb0UamaN/ix5kNtT6+47XDRieUdfL4WqQGvBvGQZ
 mdvzLqtuwVrhP8rxPri7zFrj9FRQ0P9b78UbCxXXwA4Qo6dfL8Rqr9Gu8hQNYt2W4pvG
 fGI1GAc27DNwOjWg/HICxJaFgyc+sUT/ei/tcW2740TzR5esoxi3StW5V6lHVN5+edbo
 nnEzk0csf9ulaOYuTMoZT51kwaBrGQkuT8n9N0X6OC9i/fM4lUhUMhETP+BLeBJWFM60
 dzFfTjfE34BPHdRT7FcWbXizb/aqtlTKTQFdyAD8SgRJcsA+lCFszutNT1QWlm32Sr1i
 7X9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tjeGAeWkW88zo9xVTQEDAZr38G4dxg7jKkDmMC6ghRU=;
 fh=e8lPG31nRq0pa29+ILZPVpv23pShvDc8zQNyomzI6HQ=;
 b=TaJ5Oi46bE7S3aaXLRclyWMVm75XunvxL8PwDGcJTgn+gLIHb86fc2DseehBM2NNr4
 NAbPKTjXqMs8Ar+VDDYYUuaCspfZt8dtq+ZHnZg1/r8U+I3f97s1Y93rfEjln3yQxWlP
 XxI3R/PuHdSjouwsXq6ugEtew1bl5zb6yUyZ82gZNRnzbFEsWIMFhy4K20C01UHAOSsu
 j1baJIpVhs2ap0ECE86HqfMUcuMVwNEDkaZyHbg5VY8wVD/KBxO+cZFSuh9n2cfKMCpp
 U53NWU7LKv1622t/Bfc96DQC8MhYSsMxDKZeby7THhJhZVFm2wKEyHUh6IjNJ6AZufrP
 KXPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772537058; x=1773141858; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tjeGAeWkW88zo9xVTQEDAZr38G4dxg7jKkDmMC6ghRU=;
 b=Z0jNUmkHg/x6KwidXIc4TWKSd7XEdIyhcxrnIDgFatAl+A461TCNHekXBPqkpRc/tM
 CcS08CH6xyX2sYgzWK+99ice9n16NawmHWD4aTtTlKw8P0RUQXpqmRCzpTG3kJKYvYTw
 gYnbD/wA1So1O0TELONIWpcJ+Swb8teWf5ALQEDKUrwgi40wb4tF3KGZFxZS2dRhbidf
 YDZPG/C28JXzGBNx9W39cjPoG/MPHQy029oENc5NNG+8IjuSZ612KdmPM0dX0urd7AYb
 JhtdfWtWP0xG3q96tWUj+uTxPpzknuDBDn45oTnz3r4vISNM/kKRMAu+fZOlXqX2hTze
 bnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772537058; x=1773141858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tjeGAeWkW88zo9xVTQEDAZr38G4dxg7jKkDmMC6ghRU=;
 b=OfeIesFvfQbaWUX95mu6FykNXTLIN/TmwIomrtb+q/IzXoLefCJL6IA7QeVrk84q3O
 fpdpGF2uoD2dASVncwBMUYCcmeLq2UVNMihOHrQXQfugv0KXd4CU4jSbIGBh/k4QKom9
 drn0awF57/bmeW+7jgh9GKp5IMCE2eGpo+t319JwC+n+NrjnlMebf1UMMC7CkLMPSyox
 Dn3Kd3PSGdgmdVl0GVNhcwOfG/r5imIxqmNDz7T+uuuI0IkZrZSAROo+YEfqxJJV2ZXp
 yWhkbV1WgM0O1ZVCzWpkntMCbZR9UxEhJw70p+czxZWVh420IVbz/wyGbO5UY3D4vizX
 hv7Q==
X-Gm-Message-State: AOJu0YxGXzK5XVXRcRlmMs/kYDD8XFFh4i2+R3hn1os/bQ8Sl/m8EUeF
 Dqjn4Sz9+ZuBSSbs0vhwfCefQ7ghLjlBMb6y3MaH6rIUayC9Maiw+wZE3C0Q1bRr5GGEOTU6nhd
 tJLSN9sJGJ8Z4om9SHO9TDqI0uvZ7SDckqCB5yAiYqA==
X-Gm-Gg: ATEYQzz0bsUpfntYUKAKWGH229sxN52h760b2dMyXJu5HaMyF1kHzJqT562WCr9GLj6
 f1JR5MR4CE8X8HLamd9DoEw0QsCbrp2YmJrhY4PUNXyVwXG2mO3uwlpDBjEPSyER1XNVUnzLUzJ
 9x3un9GguQDc3LDRPtVawg1OppoKenXlRvipT0xLdRffrJVrs7I37pG3IJKn9KdCnP6kS+WZiup
 k3wzP4xzK8CjzMDaPj9FR/tKs6dqL+W8Wiu+hl987KsOHCyhG83h9+KAIveOgZf9c5/uFZXyXEW
 y5MMq0vide9BjGewOnouAp4POM+tZSzZJ8mUWVXFPpor+D58Hk1ipwWxYPPH8v0MCxA=
X-Received: by 2002:a53:c745:0:b0:64c:ac70:942c with SMTP id
 956f58d0204a3-64cc237d367mr8879449d50.75.1772537057765; Tue, 03 Mar 2026
 03:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20260302220254.1166849-1-shentey@gmail.com>
 <20260302220254.1166849-2-shentey@gmail.com>
In-Reply-To: <20260302220254.1166849-2-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:24:05 +0000
X-Gm-Features: AaiRm53BDZoRJhzcCv01hSKKTHllLdwJkPgjx2jeFdw342r-OIU71Dgfsvy-gVI
Message-ID: <CAFEAcA_OFakQ7akKOSLmkFPv9jOXgjE68iaWt8J11FKMPdTCxA@mail.gmail.com>
Subject: Re: [PATCH 01/12] hw/arm/Kconfig: Fix serial selection for NPCM8XX
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2 Mar 2026 at 22:03, Bernhard Beschow <shentey@gmail.com> wrote:
>
> CONFIG_SERIAL selects the internal TYPE_SERIAL device which is akin to
> an "IP block" that needs to be integrated with glue logic. In case of
> NPCM8XX this glue logic is TYPE_SERIAL_MM which the code uses already.
> Fix Kconfig to select CONFIG_SERIAL_MM which matches TYPE_SERIAL_MM.
>
> Fixes: ae0c4d1a1290 ("hw/arm: Add NPCM8XX SoC")
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index c66c452737..20e99e52b1 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -493,7 +493,7 @@ config NPCM8XX
>      select SMBUS
>      select PL310  # cache controller
>      select NPCM7XX
> -    select SERIAL
> +    select SERIAL_MM
>      select SSI
>      select UNIMP

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

