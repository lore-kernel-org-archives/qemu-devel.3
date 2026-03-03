Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10272EC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxO8q-0005JJ-Bq; Tue, 03 Mar 2026 06:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxO8d-00058m-Fh
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:42:07 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxO8b-0001gY-Sn
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:42:07 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ad79dfb7cso5163307d50.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:42:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772538125; cv=none;
 d=google.com; s=arc-20240605;
 b=ZTVXck/n/wOViQJK0FySTo9grhHg9iKEa8MLM9wNRemCmEomLKijTPEU03cDF0vJwB
 Cka566uuzbejNxsVTpvIU0UTiTxDIyQB6bPaSn0Ejl882DurB7jmLwvBivAbfrELGhbk
 PyTd/KrCF+WLpd0WTdCVuuFkaJGYZBQOA7+rSu9wb4EgHyQa9wBdOb8KV9MLr1RQUcCk
 BWiCeeK1P+i58mk1+yGoiE6FBgu8SzKebWQmyHLcSSQIVVGPHXrSuM6p98I8l7ltZ2Un
 P2ZqTWrMImZBoQvV3wvAC4GVROmp1UX1LBcKHjZYkTQdhThZ1TKYeDeJeMmayZTbxy6i
 uivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TmcAWmmVEiZVO2IXHyRF4hwYUTz2/PggnQC6ob57Es4=;
 fh=e8lPG31nRq0pa29+ILZPVpv23pShvDc8zQNyomzI6HQ=;
 b=QxZN24+aXVvdRWrZM9r1kY6EYg3XI3+3TJtyoKTT500IlgoifTfs77x/D6y8Rsw1u/
 V4fvHlqF4RKzLXF5kLk2jw69MA3N4F6/bGfG2QkNUIAjosCPPLwa/PoY6n6+eRPjdq7m
 MtNS9ua/J4TgYER2twZ6z3VWEQfaBdoyGAM9yNHSE8+JuE7xolaFTBafAVB2kmrFlWMH
 SzJn9HEWMKcd+ceL4sdvlfaM6lHh8Yum6Odbtun4hatvcTHAja1aNek4//yR9yYBx2+o
 H2SDKu0t93Dhxmz0GkKRL0RaUnzkCVFZmuwMG4GekbQPJP2wzunQkSXAl2Tnl0SE+nS6
 z2Yg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772538125; x=1773142925; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TmcAWmmVEiZVO2IXHyRF4hwYUTz2/PggnQC6ob57Es4=;
 b=wD6Jgnr5KFz7zPTsEMJtCfRm/WsXhkOqA9FCKCC/vIEUGeA96qGo28gcJFDGAOu2/7
 qh3dhDubXxHQ+K6HDvIb7h0m+LHitXSWugusxMtfzmuKuGTLEQe0VFnLsj5ZFcH7lrLL
 xsF8nnUoHV0KLSAjFKvx/7V0ZF1U7onNLxeufTtR5wI9FSSk9+V26AFon/ACMrI0QL6q
 jGaEsiLcY2v+Bnm2jwDP174G1+3mu8L3+2TBVf9fDdaaYOQwluljcvkMj/ahV9aKr2uc
 bAGGwCosZSpietnC0qaqrD/Zz3lrJE/uQP5xemrg11ts9YqAGvZjpWpEUfBJqrLXvdA7
 mL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772538125; x=1773142925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TmcAWmmVEiZVO2IXHyRF4hwYUTz2/PggnQC6ob57Es4=;
 b=LaS7jFzxD39IBYzUe/tIkbA9y8YkUgJLIQFSFOP4iCvm75cbjZ2EJNrUJT+0k0ozvo
 nGa+2Gl+s2IJ2LYvzH+Aj1mOVcaX5twsMIk7mQambuRC8D9Rjq8CmR7/z5J7CZ4FcPml
 vJFp7wddTPsJB7pubruImoYmQIAzB0ijJ1xr+k4yabxNECqflJqIX8fQzMpIRP57sjzU
 stBG2BXe+nKmy4O99uvmBfU/OFMs3C72UNsr+zoMCgwmeZUdou57cK/l3MDihELZ3t9t
 BOUB3IMFbEPSCjG4r+cCnXK0MOfeDRiF5MX2StU2BRk1Zozz/IJyW5jQ0eQxVYyPj80F
 qmng==
X-Gm-Message-State: AOJu0Yw/4yK90oHFmdsgv1Lnc5Yem52zXIbz4XBc+dAiwpAmYrqgoe4z
 BePxjKoJar07aNETDVE4ZhMwJd/hyXCzOZ04TvM1o52YUrgpwIO9JlPFEj2r+G1fjWPngSVeFqT
 c7wVUOUxeXBDGV8yopLTQ8qrropry/DvW+zhyH7lGXQ==
X-Gm-Gg: ATEYQzyTwEJA+Pb3Q/RHd6kSgPvkOgYhwfN5WUlmip31ZD4TGRNqcv6vt5Bh0KFa7+M
 vGMLuBuclTJaNaQ2ydtv7vdqL3lGwHg7XSP9jZfkUrZidYBUSfw77JEGpRZk9BrbI5VrVGqwzyB
 Tep2wUYelZLB7q9wmXkurGs/AfYDZ167g87Yo/6GbfNBk2slpS6I+EzTmcKHs6N1Js4+z7LWqBY
 nlaFkV16ARDvPnIso5rp9WEIl+FQO2JU+Bxm4T5lp1eyNLpheDLTWzHTOIej7U+JbozwN4Lx31l
 cA3lZtpDJSMN7z0l1qEdwY9x/2jDK6PA7P4kBIYZ8FrwlacLqLRjawl/LLNG6KrAwDo=
X-Received: by 2002:a05:690e:44a5:b0:649:6872:9d89 with SMTP id
 956f58d0204a3-64cc2285d6dmr9939518d50.50.1772538124574; Tue, 03 Mar 2026
 03:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20260302220254.1166849-1-shentey@gmail.com>
 <20260302220254.1166849-12-shentey@gmail.com>
In-Reply-To: <20260302220254.1166849-12-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:41:52 +0000
X-Gm-Features: AaiRm50ZDWOSzNYDTMqP2C9-_reSRaMxHA35okEURMI-9ETR6WIHoSKGo3tJgUk
Message-ID: <CAFEAcA-dmbSDNC+AL=OO9w=bM-79gVaysroQty=u-SxzQziUrg@mail.gmail.com>
Subject: Re: [PATCH 11/12] hw/char: Have SerialState inherit from SysBusDevice
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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
> SerialState currently inherits just from DeviceState and serial devices
> use SerialState as an "IP block". Since DeviceState doesn't have an API
> to provide MMIO regions or IRQs, all serial devices access attributes
> internal to SerialState directly. Fix this by having SerialState inherit
> from SysBusDevice.
>
> In addition, SerialState doesn't participate in the reset framework
> while SysBusDevice does. This allows for implementing reset
> functionality more idiomatically.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>



> @@ -76,12 +76,13 @@ static void serial_isa_realizefn(DeviceState *dev, Error **errp)
>      }
>      index++;
>
> -    s->irq = isa_get_irq(isadev, isa->isairq);
> -    qdev_realize(DEVICE(s), NULL, errp);
> +    sysbus_realize(sbd, errp);
> +    sysbus_connect_irq(sbd, 0, isa_get_irq(isadev, isa->isairq));
>      qdev_set_legacy_instance_id(dev, isa->iobase, 3);
>
> -    memory_region_init_io(&s->io, OBJECT(isa), &serial_io_ops, s, "serial", 8);
> -    isa_register_ioport(isadev, &s->io, isa->iobase);
> +    memory_region_init_io(sysbus_mmio_get_region(sbd, 0), OBJECT(isa),
> +                          &serial_io_ops, sbd, "serial", 8);

This looks very odd, because sysbus_mmio_get_region() is supposed
to be "the sysbus device provides an MR it has initialized, and this
is how you get hold of it". But here we're taking an uninitialized
thing and initializing it by calling memory_region_init_io(). It works
because it's just returning a pointer into the internal memory, but
it's still making assumptions about the internals of the device just as
much as directly accessing s->io.

Maybe this is worthwhile for the benefit of getting reset
handling automatically into the reset tree.

thanks
-- PMM

