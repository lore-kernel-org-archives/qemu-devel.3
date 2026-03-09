Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF865EFCD73
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzXCe-0004wk-E1; Mon, 09 Mar 2026 05:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzXCW-0004vn-Je
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:47:00 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzXCU-00006T-1K
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:47:00 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64c9a6d6b70so9718337d50.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 02:46:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773049616; cv=none;
 d=google.com; s=arc-20240605;
 b=Jl+O/IaxkGr9z+8E/46rjQoX6XzVYeWPimt0FXbW9bDfGY8MaC6MXIpq1Eno4UBZvd
 rLwQ33hBAYLtfeU6XsYprST5Qw/lenu1hjAMtkcWT7eDouDehOIZnno/8yDkBCrD1JV2
 3ajJniD4IsxNyXuzYWgBFyjULFHTYJA8jViSW2QW+1jaVLW3+QhApcLdNeJREUP52f/p
 5FtevLXk8xf+w07RCZdId33bXLYLMRmpOUuyI4fJ0s8t7RarGdoJ7Vwu5fGLYoTHUnMH
 CKRHK7tpdcrN1x8x5q6xauxMUmFQ29ZcF7morUEGST0JsK1q/JMtUkhYbWL+RN+1gd/a
 S0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WXTKPx6DOn8tj+ElBjv8zsF6JK0+oHmjWzFt5qs1PH4=;
 fh=OB6xuOJuO4/iAKhS3gKvuHG0B66IvEoj4oKzbPgMo48=;
 b=YYSsPtomRQD5olHnC9Ln7W8Ra0EVTJejxG7K+w07ginZXVXt5HxXJ5Y/m70ZAEO459
 RNX2rxEHcMHKKyteAeDJ0avjsFTVcbR81S4HUcWnoed1OnI+lPWn/Dt0xCQ06XdiVEmR
 znkShCsygF2aDU77GwjQOj/K1JSKF7XbC1BqXbEgATVJDeGc9LftmkQ3Xj83E8hktsra
 kVNwDf9q/Kyv+b7HEdIqNXdPQQEHen3iRI0FXTKX5WjOYX17NcYCDFFfcvF6W+1GAM4/
 vpLQHLxDiM71eQrV/8nz/fxELFMrlWilibLTCcmmHKhUCkXXioK6WAYeAkY+sw0lPBoI
 D77Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773049616; x=1773654416; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WXTKPx6DOn8tj+ElBjv8zsF6JK0+oHmjWzFt5qs1PH4=;
 b=Rnsqv3s7cfV6YeT5IeQQkGQGbMrG5/AvvPWjJ5/+0QBk+ensgXGY+gC4GuLJq8zmt+
 thD4GU7TNMQPPQkbGsF6kkwtq+nlbODO39rjr0JyEIAhVFbRlhuBhb861qz94mFD0Rio
 aVBBN0SrETOXRp7u7cwQ+if1yOTNCWptfhBVgHi1hoxMLFxh+OsyMFzvF5YkZTZq4EPt
 GY30tfBh6BzfOwSLVWMBWShQFkDjwnwHtJaCAAJSIym/cW6Dtw6/d5Sj/n1f7w4vxvDO
 TByJ2bwU0+L5gpUC0c3/waRgDsrH8Vzg4d8Bf1lww+JTT4dKKN8U6cVzC0A2V5dZqPu0
 6jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773049616; x=1773654416;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXTKPx6DOn8tj+ElBjv8zsF6JK0+oHmjWzFt5qs1PH4=;
 b=VAtlww6tEKbR2rhlcKKuPAZNrhVtg4eV//+6l1IS5YDaBiCqXOE133GcM91xx0pNEg
 dmfladmdptcUXCUb4BKdbWwFEO+oycgfBDtfE2CUsA9Mwt0pMhvHDM4MqbgGyU/6mmuw
 cXexvti7Xtu1hdrJC+DXuEZIe/pOgLoC9jJL16eWn7FK9LEhjPW6AkNNLqPXQTvBHF6p
 6nAJumZHKHUD05mS340r8D1F5YJP8qARweC0xhPqNI0YY9udTYHAxZm4Fjmu6p5yvC3j
 w+iN+Ek6t0dfJI31EHCwgBJ1fQlW+gk0k6Re0xnsVFvp2RzdyCXpMRUDvHSgERWLorb4
 OnkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIEfK03uwX+ni6Qm5cbPgOsMJXJjqpkFGoX7hAZzxjyQwc6jUKpTmzT+itauQNLlzpU2xOYVZj2yPB@nongnu.org
X-Gm-Message-State: AOJu0Yxi6gBmgt1hL6TLtrxe5TiPapSX36n2HkPJtEnTwXBXx/p5abJf
 4cDhvEtTTb2ab5PwDEoYK86j1B2dd/f6Q+UDmK8yeRwxjWYLue53wTSpE7UU52jfEfWy188Ald3
 PDKm/wEQjZbWJRBWf12ybLbbuv6W9GQLrmITc2DHmeg==
X-Gm-Gg: ATEYQzxNboFSNgFb8CgbIlVVbov3vvontjQ2qdbHpNuf78nG+PXBO/rIVhB0LJlt1XM
 j7xT+2sWK2KZHPRRqtjTcVQMvgp77Xn4X6IVUUObfXyrW6EcJSP7j+8jLHBsmwAib0c4PqqAWp+
 RJTfD9QdQejD9PyvG5yUHKNGe6cKWpID5OB43NdsfFX4tl2upI/0AUF+IFiDvY95+sg65zZOPes
 0rEEw+VW41n2iQu5+6nl8SVIhPBlswMewEi9K72nqoDM5KEJbuN3rSJLzTpV0sanl4PYbtP4eu7
 V3eX7+QMe33D26SKNwk9pMtubcNrKKHggYLlOf24UCmhZfaQxMnPkrjyr3WallFtzi4=
X-Received: by 2002:a05:690e:e0b:b0:64c:a4ab:e4da with SMTP id
 956f58d0204a3-64d1409677emr7935798d50.6.1773049616006; Mon, 09 Mar 2026
 02:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260305220911.131508-1-shentey@gmail.com>
 <20260305220911.131508-14-shentey@gmail.com>
 <cf26c35f-a508-45bd-9398-5b4e7140d743@redhat.com>
In-Reply-To: <cf26c35f-a508-45bd-9398-5b4e7140d743@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 09:46:44 +0000
X-Gm-Features: AaiRm53VwoxCUBDt84uy8e7dWDXh6WYso9faRE0QiNfous25fYrGqq0rSlmzPi0
Message-ID: <CAFEAcA_cZbp4FW4SLxdRs4doE8ZkadNGrADe3tBrbXDpy-DC5A@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] hw/char/serial: Inherit from SysBusDevice
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org, 
 Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Mon, 9 Mar 2026 at 08:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 3/5/26 23:09, Bernhard Beschow wrote:
> > SerialState currently inherits just from DeviceState and serial devices
> > use SerialState as an "IP block". Since DeviceState doesn't have an API
> > to provide MMIO regions or IRQs, all serial devices access attributes
> > internal to SerialState directly. Fix this by having SerialState inherit
> > from SysBusDevice.
> >
> > In addition, DeviceState doesn't participate in the reset framework
> > while SysBusDevice does. This allows for implementing reset
> > functionality more idiomatically.
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> The lack of support for automatically resetting children other than
> buses is a pity indeed, but I don't think that this patch is correct.
>
> SysBusDevice is for devices connected directly to the board; a device
> should not have any children objects connected to a bus (unless the bus
> is part of the device itself, as is the case for usb-storage for example).

We also use it for various other things beyond that, though:
notably we use it extensively in SoC objects, which have
child objects which are almost always sysbus devices.
Very few devices really connect directly to a board.

I actively advise against people creating new devices that
directly inherit from TYPE_DEVICE. If you also advise against
creating devices that inherit from TYPE_SYSBUS_DEVICE that
aren't directly connected to the board, then we are jointly
saying "don't create this device" for quite a lot of devices :-)

-- PMM

