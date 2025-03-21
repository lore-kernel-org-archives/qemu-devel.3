Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15164C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tveoa-0002F9-Sq; Fri, 21 Mar 2025 12:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1tveoA-0001Tc-EO
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:01:25 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1tveo3-0004kF-75
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:01:18 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3cf880d90bdso7603225ab.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1742572866; x=1743177666;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/j24HTeIuy/kxPZcpyaYAUbMTp2d4MrtvnI0K5CHXk=;
 b=L64IZttejAKKKqOuTrGFqdkPtk3WMTjqIDeoa5++oZv2BYHl//NiAqlI/eC6cIyqpP
 p8+Ipnvfiyu0xAzM8Aji91h4/CGkOb+WFmOwWewMhDGZr1gUXrdCTFAjPnEg8pvdq8g7
 XLAxfPa1wQoOr5Ervqu0YDdjweQQC9yXdAqBPM8P1KY9HFVAqIinmYZ12Mgwhx5osijM
 oeYoesyRpzxjvv5bYPQHyKTm06mDx8dxU1SG41m5Lczreyyg+Asc+NpHIUGR9zYct8T1
 QumgV/q23kUoK4IYaecB7WpK3GUgXGzjSc9Il5C5DXisODH3Jr2s3bH40DqUjsl5Brzx
 eSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742572866; x=1743177666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/j24HTeIuy/kxPZcpyaYAUbMTp2d4MrtvnI0K5CHXk=;
 b=N26nNuquvFfhh+cbWSDAOT9GmxngSsgoFiwqXET8R37tq4hpJn6zXZ6vGdU1MUrdxM
 +BIuP4FRzxBSvoL7MAi3b3SpVpqxIvwFyTA/50/ohR6vkRbA24ExIi+OjEceZPgm9URf
 BjraWItuhZcEjuh6ah3ET1/o/ZxpUq62izdt+ravU6EOip1++C4K1J5sNeIE1vNKjGlQ
 xQU4iCWnfGdDFuGYehce6392/cdXlabFB0Ftlgyp7XLSxy7FTbs6IFJ9exYFI1rOYSs7
 H9c5989VZXFz7tTavS52A/ZZ1PMZv9GOTfSkh8DqoAqzoG1i4VjWel9RTbremOoqMwl/
 sNMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOtnbB2EgFepYh9CI36c/6VoqdS4Na7PCRRTyw9wcnG+iFFFDsCkKzqg2eCWRQqOVjjbTtKn1CXVlf@nongnu.org
X-Gm-Message-State: AOJu0YxAafuHuxYkCXl5lu+NU5lAtvvA7hnZvd3NunClS0L4zQ8tnl6k
 LuanykR7wb+BnLVnEtpTi55UJ+w2/PQHYJpXtCKEATLSSfB2tZT6RlF8fQNmMS37PUwwbmcbVAp
 xZylqTLXm3JsKD+6dBAVJEwWRJ62vhpiO/NiNOw==
X-Gm-Gg: ASbGncv2eoKLt1I4rQruHqW6UrufGPDb9DJi7qdzx3bDXN4q4SWJKu8J8FutcFeujDr
 n9FvXhH0yIOiJdaaYvRXIABnZaVHon53KFQBeZkHISpy12KfOhWQBHHkkiJ6giTcaMcC6WBX+pB
 BZ8GnczmMnAtdrBW2UNu+G+FAnd3fmJeZie4od
X-Google-Smtp-Source: AGHT+IFHC0WgHO1hs1MRYjdrNIEJ+K6XADSfT+e0WaYBEyFfCQ3bsGoJpq8Iy8xdQO17qNvdeJUFA/pb9vgNq4pzFI0=
X-Received: by 2002:a92:c26e:0:b0:3d5:893a:93ea with SMTP id
 e9e14a558f8ab-3d5961193acmr34830285ab.13.1742572866127; Fri, 21 Mar 2025
 09:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250321081255.30564-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250321081255.30564-1-heinrich.schuchardt@canonical.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 21 Mar 2025 21:30:55 +0530
X-Gm-Features: AQ5f1JoXJNtw-CO8w94mR-2xPp88vq8YfUpV_cUkoWVlKv6o4h9GCm8mf4zQsfI
Message-ID: <CAAhSdy0-we9B19wRRqk_rRFkjY2LPPMRGaTdE=_4Ge_pCR4Y4Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] goldfish_rtc: keep time offset when resetting
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, 
 Frederik Du Toit Lotter <fred.lotter@canonical.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::135;
 envelope-from=anup@brainfault.org; helo=mail-il1-x135.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 21, 2025 at 1:43=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Currently resetting leads to resynchronizing the Goldfish RTC with the
> system clock of the host. In real hardware an RTC reset would not change
> the wall time. Other RTCs like pl031 do not show this behavior.
>
> Move the synchronization of the RTC with the system clock to the instance
> realization.
>
> Reported-by: Frederik Du Toit Lotter <fred.lotter@canonical.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  hw/rtc/goldfish_rtc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
> index 0f1b53e0e4..203a343511 100644
> --- a/hw/rtc/goldfish_rtc.c
> +++ b/hw/rtc/goldfish_rtc.c
> @@ -239,15 +239,8 @@ static const VMStateDescription goldfish_rtc_vmstate=
 =3D {
>  static void goldfish_rtc_reset(DeviceState *dev)
>  {
>      GoldfishRTCState *s =3D GOLDFISH_RTC(dev);
> -    struct tm tm;
>
>      timer_del(s->timer);
> -
> -    qemu_get_timedate(&tm, 0);
> -    s->tick_offset =3D mktimegm(&tm);
> -    s->tick_offset *=3D NANOSECONDS_PER_SECOND;
> -    s->tick_offset -=3D qemu_clock_get_ns(rtc_clock);
> -    s->tick_offset_vmstate =3D 0;
>      s->alarm_next =3D 0;
>      s->alarm_running =3D 0;
>      s->irq_pending =3D 0;
> @@ -258,6 +251,7 @@ static void goldfish_rtc_realize(DeviceState *d, Erro=
r **errp)
>  {
>      SysBusDevice *dev =3D SYS_BUS_DEVICE(d);
>      GoldfishRTCState *s =3D GOLDFISH_RTC(d);
> +    struct tm tm;
>
>      memory_region_init_io(&s->iomem, OBJECT(s),
>                            &goldfish_rtc_ops[s->big_endian], s,
> @@ -267,6 +261,12 @@ static void goldfish_rtc_realize(DeviceState *d, Err=
or **errp)
>      sysbus_init_irq(dev, &s->irq);
>
>      s->timer =3D timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
> +
> +    qemu_get_timedate(&tm, 0);
> +    s->tick_offset =3D mktimegm(&tm);
> +    s->tick_offset *=3D NANOSECONDS_PER_SECOND;
> +    s->tick_offset -=3D qemu_clock_get_ns(rtc_clock);
> +    s->tick_offset_vmstate =3D 0;
>  }
>
>  static const Property goldfish_rtc_properties[] =3D {
> --
> 2.48.1
>
>

