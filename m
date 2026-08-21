Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145DAC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMdx-00017M-BC; Fri, 21 Aug 2026 06:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wxMdv-00016N-J9
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:38:35 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wxMdt-00009V-2X
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:38:35 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6983d3dae7aso3414421a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787308711; cv=none;
 d=google.com; s=arc-20260327;
 b=qKsFHUJ3lUzUm0mU4ngMfwPP98JBOh/y4kj/qHecchvisilvZ9b8CSulz7wPkvz1cn
 gU49eeFMgbCV0xmQRq6+XEMocnP+EEXaY/+pzHD88PFkUzg6kulnH873+rpBrjksZQ3i
 qrrqqZJm1j6PTuS3T4ormuYY8+0KyjZMZcrqIIHCjQhF2S3db8ZcUP7yp+iGQneKt8IG
 oLTl3n/SpMxZLsCV+KRFeyTEIPfDsSKcNkCpKQjL1tZ9sbJ7PJa+2VRPh4X+0NG7dXzn
 Nsneo8BfbvI3cRCKx5ow9XebrdE1czBLTUXgF92d4MKQ2p0D1ppf21NIwMJ8Y22zI1d3
 J1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YDiTFJFgXmJVItqIZoQblfN5qchlanA5Lo23Yv5j74E=;
 fh=DJqWylnBAUxHYpKH4Ho2328mijw9dhpROwaE7k7557U=;
 b=MiHwiJQa/1vWaq0ntOGpL2ohwNg9McXT8FfFUHl3FAlyGCTBaPKoVXy28Iayvhhr1d
 jEchBBxjakZuGgT3F8BoTq7QMcv0XzesHMICrhjBPxCdJsUvmNEDe/wZmq+Gp9I+vZ3b
 h4iYP8o4z1u/K3n20C8qycMyNqPChLxR0oMygc1nnK8z4PPvo5AFgOdHcIDJRJGzjAOy
 BmH/KF6IaZOtUDa6gpCgg6bE4z6HthdIUzHAFHU+Lr1Ba3wpHQO2EHUiBl1//9+x9TX0
 zhMGlgxjwH0B7SQxRip5nDkIeSB5CNnhPsIJEceZXF42aYxHbw/vDq6D5Zf4WujQFhoL
 jmeg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1787308711; x=1787913511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YDiTFJFgXmJVItqIZoQblfN5qchlanA5Lo23Yv5j74E=;
 b=VIO89pKpyUD85uFss7L3WAsExvX3505i3ItfZERYN35eq5JwG0AG5EgB35KlGAH0wa
 rzoj2ZWe9y3OZNY1CV0/Kxa4bFQKjvHIN3lunmojTCKhu9XVgMhaBckNXX/WAreYlc9U
 PSoIyTN0UEvRR3yJhY91As18v7z7Gsc9DXXt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787308711; x=1787913511;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YDiTFJFgXmJVItqIZoQblfN5qchlanA5Lo23Yv5j74E=;
 b=d0B8ert+MVVRA25WG8BphSGUSy4m/lVytAFpeEiPnUHNHwezQ2ujpCp+/UGpL93wqR
 7znaZEP6c2QlHczEEiTICWSuvK1xIi6brBnsQur75Y56JItAZicPlKay1qoIk/FuNxZb
 ImXjsSpFvNWqm6v+AZjOMa4jzAbPHseeJ9z5RRxKPLtMSUFMuzZSK58fpiOCVcxKkqFD
 h8mGQpP4XVoJDjzHvRxtGl0rsdlTTTz0ft4Y//I8dwsneke2QNzFMS6daNQbw8Sglmn3
 Ttxkgy8YHb+vH5nU4TtIt+N2QLQSjBcCIMT27t4Sqfx0JoJHHepEG0LGT5oWai43Ld8z
 oVXQ==
X-Gm-Message-State: AFuF++mv2AFyfQhWTYWf2rpbRgD48TUvNv3RmX1IkjoqT6bTUBAIRAry
 m6ewwVRP+vCj36go+Cot2wDjO7p5MeAeIF3KAotwfICvo6SFnCbgGk4F7BPgvOTUuvT31QTwnZl
 AbbhIUZjeqBowwnjXrEx+XyCKPHsCIwa91FEBc21y9w==
X-Gm-Gg: AR+sD13dSZKa8eBZivMnFF+hy8pQ8GG7eZ92iRyvqHrY5af7I7FMIOtU/BiABGkm5yv
 /V+cvV4p9crQbsE37J6pZseDkdaIWOF+ZZpulx0VSr1Qwvjq49eL8C+uBS112/kemD8cMiF25fZ
 Y+YjRk3iDxhsmp6vo3EHL4GlQD8wtAtpgDWT8A8vnGOijo8DusTKhR8nSfgARfjscinC/1Q1g26
 xUQj2JMbT7W9ACiUUkCCkNhWWiJHeTEI/tAcnIx0cCMDGpHN2Oir+rh4z5ZIBrvFWB8rgfTGHl9
 drbx8u8LeVirNu4awXFF/KfnfxSwk35/x4Wd5TbPzKZv9OVlVwqlMkYiaZgwZWDlcuSZqqZtcte
 T
X-Received: by 2002:a17:907:e8c:b0:c20:f85f:e7c6 with SMTP id
 a640c23a62f3a-c244d69f833mr955306666b.8.1787308710528; Fri, 21 Aug 2026
 03:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260817113349.103833-1-alexander@mihalicyn.com>
 <CAFEAcA-BsxOCC4eM1ohcnr3_xmCabKNWQchtdsVzO91stiir-Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-BsxOCC4eM1ohcnr3_xmCabKNWQchtdsVzO91stiir-Q@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 21 Aug 2026 12:38:18 +0200
X-Gm-Features: AcwNN1WDP8i18Z9l7PTydhOY1B1ZEJmaUUSq_o2UY3hV1AztTS_gaDrP8QiwNrY
Message-ID: <CAJqdLrpdp1mfFU9ci62z4Ck29o9LMAbCOgq22xdCBvezkrov4g@mail.gmail.com>
Subject: Re: [PATCH v3] hw/char/pl011: support backend hotswap
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x531.google.com
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

Am Fr., 21. Aug. 2026 um 11:57 Uhr schrieb Peter Maydell
<peter.maydell@linaro.org>:
>
> On Mon, 17 Aug 2026 at 12:33, Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
> >
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Currently, when Incus issues "chardev-change" QMP command to change
> > chardev backend from ringbuf to socket it receives an error (with aarch=
64 VM):
> > "Chardev user does not support chardev hotswap" [1], [2]
> >
> > Let's fix this by properly implementing BackendChangeHandler for pl011.
> >
> > Please, note that we have to "replay" CHR_IOCTL_SERIAL_SET_BREAK, becau=
se
> > if BRK bit was set before backend change (i.e. (s->lcr & LCR_BRK) is tr=
ue),
> > then after change we need to send break to a new backend too.
> >
> > Link: https://discuss.linuxcontainers.org/t/unable-to-connect-to-vm-con=
sole-on-arm-architecture/23096/3 [1]
> > Link: https://github.com/lxc/distrobuilder/issues/892 [2]
> > Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion=
.io>
> > ---
> > v3:
> >         - introduced pl011_set_handlers()
> >           [ as suggested by Alex Benn=C3=A9e ]
> >         - introduced pl011_set_break()
> >           [ as suggested by Philippe Mathieu-Daud=C3=A9 ]
> > v2:
> >         - fixed a typo in commit author name
> >           [ I did `git format-patch` and copied this patch from my Rasp=
berry PI
> >             dev/test machine and it turns out that I have a stupid typo=
 in my
> >             `git config get user.name` on that machine. ]
> >         - added RWB tag from Alex Benn=C3=A9e
> >         - adjusted a commit message
>
> I have one review suggestion here:
>
> > +static inline int pl011_set_break(PL011State *s, uint64_t lcr)
> > +{
> > +    int break_enable =3D lcr & LCR_BRK;
> > +
> > +    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK, &break_enab=
le);
> > +
> > +    return break_enable;
> > +}
>
> I think this would be better with a similar API to
> pl011_loopback_break(): make it take a bool brk_enable,
> and return void. (pl011_loopback_break() takes an int,
> but we shouldn't copy that: it uses it as a bool, so it
> ought to take a bool.)

Dear Peter,

Sure, I've changed this ;-) The only thing is that I kept brk_enable
as int, because in serial_chr_ioctl we have:
static int serial_chr_ioctl(Chardev *chr, int cmd, void *arg)
{
<...>
    case CHR_IOCTL_SERIAL_SET_BREAK:
        {
            int enable =3D *(int *)arg; // << int is assumed
            if (enable) {
                tcsendbreak(fioc->fd, 1);
            }
        }

I'll send -v4 in a moment.

Kind regards,
Alex

>
> >  static void pl011_write(void *opaque, hwaddr offset,
> >                          uint64_t value, unsigned size)
> >  {
> > @@ -462,9 +471,7 @@ static void pl011_write(void *opaque, hwaddr offset=
,
> >              pl011_reset_tx_fifo(s);
> >          }
> >          if ((s->lcr ^ value) & LCR_BRK) {
> > -            int break_enable =3D value & LCR_BRK;
> > -            qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
> > -                              &break_enable);
> > +            int break_enable =3D pl011_set_break(s, value);
> >              pl011_loopback_break(s, break_enable);
>
> Then this code becomes something like
>     bool break_enable =3D value & LCR_BRK;
>     pl011_set_break(s, break_enable);
>     pl011_loopback_break(s, break_enable);
>
> which is more straightforward than passing the raw LCR value
> to pl011_set_break and relying on it returning the "is BRK set?"
> information that we then pass to pl011_loopback_break().

+

>
> > +static int pl011_be_change(void *opaque);
>
> > +static inline void pl011_set_handlers(PL011State *s)
> > +{
> > +    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive=
,
> > +                             pl011_event, pl011_be_change, s, NULL, tr=
ue);
> > +}
> > +
> > +static int pl011_be_change(void *opaque)
> > +{
> > +    PL011State *s =3D opaque;
> > +
> > +    pl011_set_handlers(s);
> > +    pl011_set_break(s, s->lcr);
>
> and here we would then pass in s->lcr & LCR_BRK.

+

>
> > +
> > +    return 0;
> > +}
>
> thanks
> -- PMM

