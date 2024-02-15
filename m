Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6E6C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rac8j-0002jD-3o; Thu, 15 Feb 2024 08:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rac8h-0002iu-4w
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:50:59 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rac8f-0001rZ-0C
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:50:58 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-563b7b48b9aso593422a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 05:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708005055; x=1708609855; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyaJA0HNIcaRxRK+On+ocjBrpyNSpvXsCeRbmdnaBnk=;
 b=e0PI5BAgecye9W3W3pHxC9RFOnfA+OSFLEFbSdmiD/1RU0c8wj819a2NtyAZbD5P7F
 Cpoil1oQlgMyZ0T7fhj6nYaWnqgvUguLV9PCz95REBU1LZ3V+7WoEJ+WheyMMibOEv6m
 x0cEEcgnKXraAOFF2dEJdf4SVgvTxaUebUnyvT2HAZdR95ksMYIozO0NW3SNVuLWs5cK
 h1OFpJY+kgmh35sHhhs6kubVES54WP7njom2wJYGP4EIwEUVozTkGVpiLvt4FV/PTli6
 khEFN44Z+hG61zo11CoJBvEFBClelOGyVEMukyM+TuoWRY+45umzdw3P4XEFi2Rn/QMj
 Y+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708005055; x=1708609855;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyaJA0HNIcaRxRK+On+ocjBrpyNSpvXsCeRbmdnaBnk=;
 b=e6wZpFfc3Cc/zAyFBFNXRw5gTn9PnHOU0j2pAJkoS21Go7fqdA1gsb4xQT/vK5f9/Z
 0wxqrVrrMexLV+H6SYGShBxAitJEruYWBHTQ2R3bTCe8PANkSm5s2cR7nzvM3ONJ0u84
 tE7lC5vsfXCz3rYenTPy/mRRDgV71awC7m14cYN41tW8ADvl6/zaopwbsHNyMrwhDFSS
 UFiEpeeNNPL2ZSFA6EH34e/n3ZLyrhdFIGB0JxWsc+HJW1TgRvEgn9rb9es3UdwYIe5I
 GLr7PFI2Nr7f7/AMYgl9tMLDDZh5ooQgQWLOxr6brPZTMKzxaMmOk/o8JcTffIWkYdUY
 NFOA==
X-Gm-Message-State: AOJu0YxPrjn/yKKU5LrhB9dy7lkkNusxxcHomQcAKMlPJN3+dIxxaKOB
 A7VbpkVYxr02Yf6lpzHVdHe9LwjOzYVigaFaNf4k0TL/YhcA2RxU6UEpi/PB1AJXBDNtI8XcH8V
 MXeSaMNN6aQGtBdb/gIhaDic486tcXjndwhUuow==
X-Google-Smtp-Source: AGHT+IGveJof3wuofXDorpGwGYKvjD8A6kLEE0AnrjHkdMsTFyli1+X3vkKqDv8fc0FWGaFNye3uN41IuZeGZbo25FI=
X-Received: by 2002:a05:6402:2cd:b0:561:f236:a480 with SMTP id
 b13-20020a05640202cd00b00561f236a480mr1311088edx.7.1708005055239; Thu, 15 Feb
 2024 05:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20240213155214.13619-1-philmd@linaro.org>
In-Reply-To: <20240213155214.13619-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 13:50:44 +0000
Message-ID: <CAFEAcA-uk4Zyc=ULzESFLxWrO3Sdpm_cPKmkKsmK5obuntWYog@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] hw/arm/stellaris: QOM/QDev cleanups
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 13 Feb 2024 at 15:52, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Since v1:
> - Rebased
> - Split I2C reset as enter/hold/exit (Peter)
> - Added R-b tags
>
> Gustavo wants to access the QOM path of an input IRQ line
> from the NVIC, but since the device is orphan he ends up
> with this nasty path [*]:
>
>   -device ivshmem-flat,chardev=3Divshmem_flat,x-irq-qompath=3D'/machine/u=
nattached/device[1]/nvic/unnamed-gpio-in[0]',x-bus-qompath=3D'/sysbus'
>
> Add the missing parent so the tree is now:
>
> (qemu) info qom-tree
> /machine (lm3s6965evb-machine)
>   /gamepad (stellaris-gamepad)
>   /oled (ssd0323)
>   /peripheral (container)
>   /peripheral-anon (container)
>   /soc (container)
>     /v7m (armv7m)
>       /cpu (cortex-m3-arm-cpu)
>         /unnamed-gpio-in[0] (irq)
>         /unnamed-gpio-in[1] (irq)
>         /unnamed-gpio-in[2] (irq)
>         /unnamed-gpio-in[3] (irq)
>       /cpuclk (clock)
>       /nvic (armv7m_nvic)
>         /NMI[0] (irq)
>         /nvic_sysregs[0] (memory-region)
>         /systick-trigger[0] (irq)
>         /systick-trigger[1] (irq)
>         /unnamed-gpio-in[0] (irq)
>         ...
>
> [*] https://lore.kernel.org/qemu-devel/20231127052024.435743-1-gustavo.ro=
mero@linaro.org/
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/arm/stellaris: Convert ADC controller to Resettable interface
>   hw/arm/stellaris: Convert I2C controller to Resettable interface
>   hw/arm/stellaris: Add missing QOM 'machine' parent
>   hw/arm/stellaris: Add missing QOM 'SoC' parent



Applied to target-arm.next, thanks.

-- PMM

