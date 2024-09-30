Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE90CE8347
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 14:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svHEv-0006My-P0; Mon, 30 Sep 2024 10:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svHEt-0006Kj-JC
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 10:19:03 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svHEr-0006oM-Tb
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 10:19:03 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2facaa16826so12029541fa.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727705940; x=1728310740; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EQJ32KlF8mPKocXqqBljPbSCtyHKX+d8JsxRrAkDdOU=;
 b=VBn05YD1K4nU0wd4PO45Cdk2B70bWcTyG45OU4ISrtmvKqFt4Iu7BR+Ssu2yqOEQwI
 hVh7mAhhIDllR/AeT2E+DI4xcrW7qvxAq49NIKNrXuvr/Qx4S5XSyRhNg1eGRM7eI+OF
 dyFguMv5wORT3WUhl48TVU7EenOORCMzB3614CDYAB7yhCL3TgJf/JIZyc7jJdCwahnJ
 Nbc4oDY+Iv3952bhw4VcTQKrzLd3k7ZOiTaOXBrww8w5wY8BSAzlOMEEmEDiV6kXZqjm
 rLIvN9aBgxapslF68CF+KnmQyKbmtDjlPWugD5zBsPgAqN6lYZaNKN94rI7BEmxB/HVQ
 sOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727705940; x=1728310740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EQJ32KlF8mPKocXqqBljPbSCtyHKX+d8JsxRrAkDdOU=;
 b=jLkKYLsVFETC8BWbe5gY2x+E2EZnFMJXYF0UuSZYQ7N4+5GG5YFYlgrA3178y/BXGU
 lf5XN/opwM2cCedkDmbpfZc4udVgTILM68XU2DhpZa6xq8cxmf2xHZyyZPh+JgeJ8DSa
 K8YDt3E2tgtaPyAnQ6gOe46Q5A1+///mS3c2CRdSOmX8j/ggZuofwZwjxLSfSd0RBFq9
 1DV8DkZw6J3e3sSNR9ppUBTXZu5yk2GyuigsByeCXJZtwjevXOJz8Mh2pufuOyB+MwS3
 KnXaVGWjg8e1/OZK6kTOSaCPsZbJRLdASi8Ut+kf11yTxGVpo27b4RhKqxFljVITe6GU
 VHyw==
X-Gm-Message-State: AOJu0YwHVPyHXrwkIghgBR3iUDsJwgP1E3Nx9fFscHAdOw0cdeOJOf7i
 KCxkkuc2th21vXJ47vHX7VqqIY2wUXn/dHSlft8Mh0J7Ezk/EdbI8wgU4qbu58hWdw1+saRNWwL
 kHnYBkdobLxGpn8KvEFfSzKk4dXwmz6xBz6OmrQ==
X-Google-Smtp-Source: AGHT+IG0CHHZB4XhbcJlCY46AvIc5dBS6v6/QDKcXWamknHXlqMGv5D5TZtsNc/gj8hWEaXHUED0EmCeP2hlHWHZzQk=
X-Received: by 2002:a05:651c:19a9:b0:2fa:c5e5:62a0 with SMTP id
 38308e7fff4ca-2fac5e5671bmr27789241fa.1.1727705939852; Mon, 30 Sep 2024
 07:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240906164834.130257-1-jlu@pengutronix.de>
In-Reply-To: <20240906164834.130257-1-jlu@pengutronix.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2024 15:18:48 +0100
Message-ID: <CAFEAcA-_=vrtqVPUdu02ryUtdH5MwifEnHgeQVq=V4Z2Jp_dUg@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/sdcard: Fix handling of disabled boot partitions
To: Jan Luebbe <jlu@pengutronix.de>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

On Fri, 6 Sept 2024 at 17:51, Jan Luebbe <jlu@pengutronix.de> wrote:
>
> The enable bits in the EXT_CSD_PART_CONFIG ext_csd register do *not*
> specify whether the boot partitions exist, but whether they are enabled
> for booting. Existence of the boot partitions is specified by a
> EXT_CSD_BOOT_MULT != 0.
>
> Currently, in the case of boot-partition-size=1M and boot-config=0,
> Linux detects boot partitions of 1M. But as sd_bootpart_offset always
> returns 0, all reads/writes are mapped to the same offset in the backing
> file.
>
> Fix this bug by calculating the offset independent of which partition is
> enabled for booting.

Looking at the spec this change seems correct to me.

Can you elaborate on when users might run into this bug?
As far as I can see only aspeed.c sets boot-partition-size,
and when it does so it also sets boot-config to 8. Or are
we fixing this for the benefit of future board types?

> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  hw/sd/sd.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index a140a32ccd46..26d6eebe898d 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -774,19 +774,12 @@ static uint32_t sd_blk_len(SDState *sd)
>   */
>  static uint32_t sd_bootpart_offset(SDState *sd)
>  {
> -    bool partitions_enabled;
>      unsigned partition_access;
>
>      if (!sd->boot_part_size || !sd_is_emmc(sd)) {
>          return 0;
>      }
>
> -    partitions_enabled = sd->ext_csd[EXT_CSD_PART_CONFIG]
> -                                   & EXT_CSD_PART_CONFIG_EN_MASK;
> -    if (!partitions_enabled) {
> -        return 0;
> -    }
> -
>      partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
>                                   & EXT_CSD_PART_CONFIG_ACC_MASK;
>      switch (partition_access) {
> --

thanks
-- PMM

