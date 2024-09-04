Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840B1CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 09:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slmDw-00062O-Mb; Wed, 04 Sep 2024 05:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slmDu-000617-Iy
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 05:22:46 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slmDs-0001Fx-O2
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 05:22:46 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c0ba8c7c17so2813664a12.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725441761; x=1726046561; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XkE1raRaz+7qmkHF821LkX9BHPx5zoXet1RsVnWVAg=;
 b=J3PJOJ+n5ZhSwGMnLqZB8MAxILUFfp3Jd63NFDswUOhHbc24I20GAModRTniTqyfsU
 +iN1fRZmAqRIrsFrmP0Pr7jl7b9jrEz/0kBL2FcOmyxrqetcey+vNZIEfqyE7WRyds55
 ss5BoloUOinXhhDDljZrUuaqOcvlLlPVh50eJC8uwQ5vND1KOHQudPNmhRhG3lwEu66p
 MR62wgnKJl97oiLS/KBri2UrjxTIAhHrIZZu7otFmR5zOvirXyNgaHv6MApSrEEb9wWw
 PYnSl33nGXqv3lzH15c5BFSebIpefLsiKqXqML36gG76kMf/LQ4Jjf9FwTRfbTZnES98
 qPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725441761; x=1726046561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XkE1raRaz+7qmkHF821LkX9BHPx5zoXet1RsVnWVAg=;
 b=HCZ6kZeJztipSThZyMt7FDcdoL2n104HcwlRHoQ3KQcOQmuczAS17dUIc3GEO2PGtF
 n0/xPOT12ShPYc/2KiQO4gX/IU+mS2+zTR15lq7kDRvT9s0JFQYdwEmLPwfAipSKFoqW
 e/fIJ6s3GJy6CwVkJJ+nDRRdukqtcP12MlWANcgYpCk2mwXNwnSO/RfD58iTm+CXRWKE
 GcLmQ2MjWs/NpL7krQN0SbRN2bXugx2BAr7H8LkNI6RExdcmL4gwl9L0EtnMUoLdY197
 qwYMnyMgY5a/1ErzgTnl+BgvHvdr7L0oCmF8GD9uWM2srXjF8xWO9nnFXJctTBpEj5A5
 NmRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX++eNd8Nthub4GE+uFfvXmdRLTqoVk7UgHek+yBVIGqp9ot2o16b8PlYxsCp9I7zKB4B42uSpQzh+@nongnu.org
X-Gm-Message-State: AOJu0YxKODLzvS2yg1X2/Btnhs5N+RwDktt1bAyaQluuesMWvpkTrTSq
 pWnIfSHG5vMNnDFcusO1w/wKJCJgO+y6wOZHgszUi9d3ZX9VVCN0hji3u50vvw8PiFgZabQS7ug
 HLRSGcYiTXLnEUf8aAIUtoi1Po40U8OghGG7ocg==
X-Google-Smtp-Source: AGHT+IGyX6T6DE6PQ3P5xXe9/1bzWKPcc17GcVtpG6H7lrHCFTzrWadDi3XN2qRgx0EDNsMf38ios3l2jn9tIQdVMjE=
X-Received: by 2002:a05:6402:2803:b0:5c2:5f09:bb9c with SMTP id
 4fb4d7f45d1cf-5c25f09bc03mr7264760a12.30.1725441761103; Wed, 04 Sep 2024
 02:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-27-peter.maydell@linaro.org>
 <f65053b7-f909-4ff3-b938-05cff490548c@linaro.org>
In-Reply-To: <f65053b7-f909-4ff3-b938-05cff490548c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2024 10:22:29 +0100
Message-ID: <CAFEAcA-U+YAg7qqAu9LYmQ-YbNsxMB4AYCdQrm-r=pUe-O2=fA@mail.gmail.com>
Subject: Re: [PATCH for-9.2 26/53] hw/misc: Remove cbus
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 3 Sept 2024 at 22:37, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 3/9/24 18:07, Peter Maydell wrote:
> > The devices in hw/misc/cbus.c were used only by the
> > now-removed nseries machine types, so they can be removed.
> >
> > As this is the last use of the CONFIG_NSERIES define we
> > can remove that from KConfig now.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   MAINTAINERS            |   2 -
> >   include/hw/misc/cbus.h |  31 ---
> >   hw/misc/cbus.c         | 619 ----------------------------------------=
-
> >   hw/arm/Kconfig         |  14 -
> >   hw/misc/meson.build    |   1 -
> >   5 files changed, 667 deletions(-)
> >   delete mode 100644 include/hw/misc/cbus.h
> >   delete mode 100644 hw/misc/cbus.c
>
>
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index d33d59bee90..a70ceff504b 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -142,20 +142,6 @@ config OLIMEX_STM32_H405
> >       depends on TCG && ARM
> >       select STM32F405_SOC
> >
> > -config NSERIES
> > -    bool
> > -    default y
> > -    depends on TCG && ARM
>
> Maybe squash this ...
>
> > -    select OMAP
> > -    select TMP105   # temperature sensor
> > -    select BLIZZARD # LCD/TV controller
> > -    select ONENAND
> > -    select TSC210X  # touchscreen/sensors/audio
> > -    select TSC2005  # touchscreen/sensors/keypad
> > -    select LM832X   # GPIO keyboard chip
> > -    select TWL92230 # energy-management
> > -    select TUSB6010
>
> ... in the previous patch?

I left it til this one because it's only in this patch that
we get rid of the last user of the CONFIG_NSERIES define:

-system_ss.add(when: 'CONFIG_NSERIES', if_true: files('cbus.c'))

-- PMM

