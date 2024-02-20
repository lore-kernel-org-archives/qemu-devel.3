Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D2BC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVdk-0004GR-Dm; Tue, 20 Feb 2024 14:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcVde-0004DW-2d
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:18:49 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcVdQ-00056j-GZ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:18:45 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-512b29f82d1so3708922e87.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708456710; x=1709061510; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pyCaNxySkOUWpGuc9oH4PJykwp3ULCdSIjMM/dXphSI=;
 b=wcXcqxUvCbar7+iy0HyPuGhWJXLtZgloj2iPgcZIPE+a1aRV+WVIPBtzkzGMI4LkPD
 kdSAwek7WBPtygNQZHU9RID6zAB1qtEnwbw5E7verq+TodlBKwRFK1uc3DUZhySBaJuD
 IVfnsCwuj4mYcOwq+VvjQggrtVjiN5SHelBmbiG65UccoXjKV+UHHwX7CWpUGPEumlEX
 Hl90e7hX8fszj4oIosHElRXopXsVBw+hIyrgjtonrF/PbHLOlTYDaQUK9B37MvjHiO6p
 pqQnr1F4XqinLZrEmJr7hOxachQmzOzBTQfUMWgPGT8c34samBgkWr+TAeRnpNmakbYk
 hFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708456710; x=1709061510;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pyCaNxySkOUWpGuc9oH4PJykwp3ULCdSIjMM/dXphSI=;
 b=nu9lYJq1BvcV9gExdx6jjNiwrChNts88Sz+4OpEGvqxaHDLVt53qngZuOVS9KaXuM3
 xbJVz9wlfBHjef41Qf/LFMCBvt80alQytWu/J8t5MEjUcub87qcPwalL+bdUD9W4mWv5
 +NEHsjDK9hmtcbDSqlRr+dRzi4A1n4z0VAhgCeGctswaI4ITQoyndqLxRLs6wz0NyMb4
 vyXGJY6yHIeIqK4zS0JHI80v0Qj94OkAnqOHanB37TAXCR+KwFIz2yrDY/vBnCZN2HN9
 hL1aqgj+86qPVoh4e3IQj+gQ2aPpkNCGQgEOHX1kOCHUtQc+UCpGCzJU+Gm5lEsHST00
 sdKQ==
X-Gm-Message-State: AOJu0YxN2ajMo8uReUWf4suXyvBQtmJIaNijFIjZbrGS2VhqiYIZvtP2
 +w2evDpkVbiuMh9l83o8wWFMUAMn9Oi1GBW6aT/T7omhNjfKIXXFKHVKpRJmr2ID9t+b/Jo2vgH
 sv/6Mjd6XCTk5mYvuLDLfeqPkJl+MX00qoCGiew==
X-Google-Smtp-Source: AGHT+IHsw0T4i+ypWcR6CPJyzQdiulxCa81nZXhvcWyWvs9PYoAIOQld/5wAwwGe8VMpWpfXiS3JPwrvm/HVSThnlUA=
X-Received: by 2002:ac2:4942:0:b0:512:b354:c5ea with SMTP id
 o2-20020ac24942000000b00512b354c5eamr4108516lfi.24.1708456710269; Tue, 20 Feb
 2024 11:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-10-peter.maydell@linaro.org>
 <18996dba-a47c-4e68-b9cf-5e0ae5e9cd43@linaro.org>
In-Reply-To: <18996dba-a47c-4e68-b9cf-5e0ae5e9cd43@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2024 19:18:19 +0000
Message-ID: <CAFEAcA9dVvXcW6GD13a0K=+BnQ84AEtV-2foFAcCgsw8WjUsog@mail.gmail.com>
Subject: Re: [PATCH 09/10] hw/core/machine: Use qemu_register_resettable for
 sysbus reset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 20 Feb 2024 at 19:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 20/2/24 17:06, Peter Maydell wrote:
> > Move the reset of the sysbus (and thus all devices and buses anywhere
> > on the qbus tree) from qemu_register_reset() to qemu_register_resettabl=
e().
> >
> > This is a behaviour change: because qemu_register_resettable() is
> > aware of three-phase reset, this now means that:
> >   * 'enter' phase reset methods of devices and buses are called
> >     before any legacy reset callbacks registered with qemu_register_res=
et()
> >   * 'exit' phase reset methods of devices and buses are called
> >     after any legacy qemu_register_reset() callbacks
> >
> > Put another way, a qemu_register_reset() callback is now correctly
> > ordered in the 'hold' phase along with any other 'hold' phase methods.
> >
> > The motivation for doing this is that we will now be able to resolve
> > some reset-ordering issues using the three-phase mechanism, because
> > the 'exit' phase is always after the 'hold' phase, even when the
> > 'hold' phase function was registered with qemu_register_reset().
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I believe that given we don't make much use of enter/exit phases
> > currently that this is unlikely to cause unexpected regressions due
> > to an accidental reset-order dependency that is no longer satisfied,
> > but it's always possible...
> > ---
> >   hw/core/machine.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index fb5afdcae4c..9ac5d5389a6 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -1577,14 +1577,13 @@ void qdev_machine_creation_done(void)
> >       /* TODO: once all bus devices are qdevified, this should be done
> >        * when bus is created by qdev.c */
> >       /*
> > -     * TODO: If we had a main 'reset container' that the whole system
> > -     * lived in, we could reset that using the multi-phase reset
> > -     * APIs. For the moment, we just reset the sysbus, which will caus=
e
> > +     * This is where we arrange for the sysbus to be reset when the
> > +     * whole simulation is reset. In turn, resetting the sysbus will c=
ause
> >        * all devices hanging off it (and all their child buses, recursi=
vely)
> >        * to be reset. Note that this will *not* reset any Device object=
s
> >        * which are not attached to some part of the qbus tree!
> >        */
> > -    qemu_register_reset(resettable_cold_reset_fn, sysbus_get_default()=
);
>
> Interestingly after this patch TYPE_S390_IPL is the last device
> using resettable_cold_reset_fn(). Per commit cd45c506c8e:
>
>      /*
>       * Because this Device is not on any bus in the qbus tree (it is
>       * not a sysbus device and it's not on some other bus like a PCI
>       * bus) it will not be automatically reset by the 'reset the
>       * sysbus' hook registered by vl.c like most devices. So we must
>       * manually register a reset hook for it.
>       * TODO: there should be a better way to do this.
>       */

Mmm, we could now have that s390 code call
qemu_register_resettable(OBJECT(dev)).
Though the "better way" remark still applies, because ideally we shouldn't
be doing reset only via the qbus tree.

thanks
-- PMM

