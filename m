Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCC0CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGWWN-0001wQ-5d; Tue, 13 Oct 2026 03:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xGWVd-0001mW-AS
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 03:01:20 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xGWVZ-0006Fc-FM
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 03:01:12 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c2e5e801487so381336566b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 00:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791874868; cv=none;
 d=google.com; s=arc-20260327;
 b=ksEJUxiRDab85WhCxM0D4B3Wb9sOmHoAQFg5996ZSV485XT0aipKTvTRWo2cBf1Dgq
 osMeGioG5Bq7+oqyBM993Q05kNwjXINWPGwvn3rsUfZyKUKhm8FTMraWN0+9KhzRuEp/
 7V8bQoda8+tI5RT1L5+l3OldDudUf9sYFmV6beCNM1goH0nWSviK9SRA2GjYpDrLDoD5
 0RgdFUtBUF4079Y4Nw+0mgYdPPNj+LidGzR8cC4kmsPNqEhoBMjT/rzFvzNiVnoKHj7N
 W2n/7HBb7c/k7u8iS8s2eGnNBzVpQEAw9m/faHWUYPDYiO5vsygajXwUDFpksUzm18e0
 f1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TKCT5RnEV1vWOyylNVGqIx5R7i4UZOmdib+i9xrVYAQ=;
 fh=GM/I2I6fEf5qvJbdhgjZMuNCECIEwt8XqdRDAWXnLqc=;
 b=f7kfLHT0KaxbhaxnHHnERucelw5Aw690UYdmUNCMPryYGQYdBCOiNfVtZRvQDeACiQ
 mWqwm2uECTSRlCU0LHp/oiVGE00TTSe5QvhWZOBYEpjzRyNspn0Hl2QVZHQ+BoLiQohn
 Sb7a42nScMUArRWVimdttkY91AE6ElYOQgv5MhCl0oViSn3iXGUz+T3NPPo0/H0AG8eC
 SX0YuxU6ilzJE1QxnrGgjCTQ+Yi+nWrjj4KprQzbq0hy/SvxE84hB6o0eqZUyqCtKIJd
 bUMQ7qo6Ctp2wLhwNuYcwsItnbTorCj7JB8Wni8oppekhxJ99PYzgEBEesQ8/xr2OowR
 XPDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791874868; x=1792479668; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TKCT5RnEV1vWOyylNVGqIx5R7i4UZOmdib+i9xrVYAQ=;
 b=euDsU3nmDmV8pvwsq/RmQSM6yefFODWpYrQ911F4gUsavtNlacBv6ZjmuJeQl1XT42
 e2o5LfHDD9H6dhgozDnVz/nNrpWcC6T9c1n8/geC3A9PQeN3xezfB0zAighk7DBaRaDJ
 uHrXaoeVtHIkoeku+0Xh8z8CASfq0KV3pONFzFJigdzV3C/HlkZrqZYwjq4dnAOKuDJq
 7g5HflYa2WDbE/k045pKNJ6Y4XL+Elgkip1tBbNfxjJWeDmFcQhtc47OmtbpdYyNW6s9
 O/hoplpkA6BMT9dkLf/20iN0WnMj0a/FIzKGxg15IQcYBa4uJIAz1RUYNnm2VzR3tVYQ
 V/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791874868; x=1792479668;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TKCT5RnEV1vWOyylNVGqIx5R7i4UZOmdib+i9xrVYAQ=;
 b=GFKAruWeyAqUs0HXqVOqRkxpbxP1XJm3xa/ctbW3pRQcDCXU693GsW6YzhnYYdtwDk
 wGi6Y/sbxkzS3hsngV2+z+7wvr7aH8MILLUhEJEX8oKEnNS6e0gNYRDhb8ITeZv5+vH1
 AU6LJshgwZcNi5ikiCtLXi7OW7NswBwok/rzq+CWMCrYImibjm9Kdwmi0sYDaYvqEWsQ
 f9M7I5/8ssVDDj1Kt4VyJAFIvKUZVvCI9f9Y937UsJaR18jJo6xXna9HzRoaHMl0+NPt
 Q4yBFTeLahUSRtfav/jzQEEGG5KdutLIO1tKpAXHdfjGk1/x6V2bfZmHoZnzVoJBRXWA
 Q8mQ==
X-Gm-Message-State: AFq9FYJc2RB27ml3gbh0PLHkw2cf7gj8UVsvtFYgZqvNx9cehkbuL7/4
 2lsfdc8V66BfG5tJ1yeIM3tfCZbY4U2XJCU06z3hleYX9T93QnBVG7VgCL8Hk/GlRxj7/JPRDEG
 kebSlOjmx3y7MElIVNrLUj6lGgWyHhrs=
X-Gm-Gg: AYBFou1oXA3Lw6bLW63V8kHM9WGaCIDNPItnRBJxAPLnrNG8PWjlXj33t7kLJkD5cjx
 3DSpBXgZhUJyABEFQwEx9WQbQKNZRWihcj2TkCGWAYop6goMMg04rXlRKMHn5g38s2SCrtiiLht
 K6PTuPi5TqWhMhDPNOWeWgMZpnE1sDsrNSau9LkrcPhj+sXn69g9cFnLclkj+M+2XqRBOItA8D1
 pDQApDv7Q/Yul1RIPamE6/8Mrq9mg8kec1MAeokP1K5upqAj1FyUH+I1h/biFU0FJlhWcbN/DyC
 PNj6+nh17+/691+jiufD0TsfIRaHa3P1bc709FlxsHZl22GS0Pkv
X-Received: by 2002:a17:907:724b:b0:c2e:1d6a:6b78 with SMTP id
 a640c23a62f3a-c31aa0e0cb8mr1176461466b.47.1791874867472; Tue, 13 Oct 2026
 00:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-3-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-3-4c3dff084ec9@free.fr>
From: =?UTF-8?B?5p6X5bu65piO?= <jaminlin1207@gmail.com>
Date: Tue, 13 Oct 2026 15:00:55 +0800
X-Gm-Features: AclHuK_0EmA86gxslNXKzkKFMXSLT-zOmF24a1p4E6djvihwlnmWjCpLOGNXMCs
Message-ID: <CA+8rw5xkA0idsTC5e+G=YWLDn4cPLkvMiDNjcT9ef5Sh_3QMQQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/50] hw/arm: sanmiguel: remove the second SPI flash
 controller
To: Emmanuel Blot <emmanuel.blot@free.fr>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=jaminlin1207@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

>
> The board only populates the flash device attached to the FMC
> controller; the SoC SPI controllers are left unused. Advertising a
> part there presents the guest with a flash device the hardware does
> not have.
>
> While here, add the missing year to the copyright line.
>
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/arm/aspeed_ast2600_sanmiguel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/aspeed_ast2600_sanmiguel.c b/hw/arm/aspeed_ast2600_sanmiguel.c
> index 345a9c9416..ac2aef740a 100644
> --- a/hw/arm/aspeed_ast2600_sanmiguel.c
> +++ b/hw/arm/aspeed_ast2600_sanmiguel.c
> @@ -1,7 +1,7 @@
>  /*
>   * Facebook SanMiguel BMC
>   *
> - * Copyright (c) Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> @@ -384,7 +384,7 @@ static void aspeed_machine_sanmiguel_class_init(ObjectClass *oc,
>      amc->hw_strap1 = SANMIGUEL_BMC_HW_STRAP1;
>      amc->hw_strap2 = SANMIGUEL_BMC_HW_STRAP2;
>      amc->fmc_model = "mx66l1g45g";
> -    amc->spi_model = "mx66l1g45g";
> +    amc->spi_model = NULL;
>      amc->num_cs    = 2;
>      amc->macs_mask = ASPEED_MAC0_ON;
>      amc->i2c_init  = sanmiguel_bmc_i2c_init;
>
> --
> 2.50.1
>
>

Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>

