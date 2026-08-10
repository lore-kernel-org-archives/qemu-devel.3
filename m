Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2715C5B570
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 17:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtTqs-0007X1-UH; Mon, 10 Aug 2026 13:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wtTqi-0007Uu-Ur
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 13:31:45 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wtTqe-0002hU-Sq
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 13:31:44 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c15d47266baso216696866b.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 10:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786383096; cv=none;
 d=google.com; s=arc-20260327;
 b=eTInLAMCAKjA05G7oSmYJwL4v+zBc7jouICiLqA7/N4tUd3sSt+sCuG3HmEsHLma+D
 76L7E1aEKxJjIabdx80+nXx8fhL9r8yE1aUiezrg6xiO2EPkFVsPh+OXOikvwLv8RE4c
 3qZjNYlUIY2vVXlKRFGjUY87WSTBHJOAKN7aa5MkdQ/Luiv55GSqzNMeg8gWmgKKKDGe
 439rEq+E8PzoQBObaCsJKWF3eA3+LHeqOfywCWzN0FYQEZm/9jKxhLfge8ynrHfu2cLa
 L/5wYTqO8YE9UxYInTL8171wSiyi7ep88845firvLe5gorYmXTPehqqlaGDlRG890WVV
 5H+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7X6TOUngAPsJ+ia7LA3jtTQlKikXXB3DopGtQeycirw=;
 fh=lj2KhW/MAsZ/+uqmxCUPGYBeJsseSAo4tZ2naAjMmts=;
 b=jqh150yqD/OIzj752trU9Pd6xHgwNyrgiXKFYWHkoFTvYUZTTfp4Eu9NgoXZNRSEIV
 u/MhYDiZZZIPVtlBsKOGXmKk6iTlCmwbjj1ojt860MUjj0IHQiPghB97xwEY9lGCCcSE
 +JQU/1M+M0seqqawMQmAcCkMi/cvaMc0ByuyvMSOhce+4Jn0K1mQtnKMIg+/Kxuq0y9e
 aYMcfzdryU6oiRg8GOX2TDvvBdPKGoMCilFnljp+evn8zzLIU/NmQdbGUHdlQCDKXSd6
 Xp5ieLRCdu0He1qgHUpTkQA5V2KAoIjgpjCtypzW3fgMH92qeqovvB5CoLzUC1V1ZE2Y
 H14g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1786383096; x=1786987896; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7X6TOUngAPsJ+ia7LA3jtTQlKikXXB3DopGtQeycirw=;
 b=JTgdzYF3XK0goQI3Gkje1PPS2VKObng8vMwQPyKNnUxa6pC5HEATDo75L41taBCaEH
 VpvLhWxWEagIoQgH1KT4wJ0r3gyy/6LKbq7z6SzRh+eyFW6Sl8C2Ow97L8OzdfwdzUdi
 Udf5r7i86ZosZu0HPwPG0i3YUKCVgm6UAyVjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786383096; x=1786987896;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7X6TOUngAPsJ+ia7LA3jtTQlKikXXB3DopGtQeycirw=;
 b=RzS2sFAox/T/b4MtU3Em8LMRjA3Sxq5NTc2jrz6+3JwEvUUt+V54dAtc/euOmxmNW2
 dyfOxlgzE+seDd1GR3v05Yk0RTmqHa/3Lam+A8kOLwbPWMVtDQCWqCDB10p7utRcnYl8
 oHBbEwFwhM7T1uF+tSfzOaB3jDF4m8qnQUqtwiVAZeDXA8eojsfikz2qmwfWm0S5xC8S
 SYebqSoFHHaUqGrEkNGBztp5xWWB8eqeN9wXjPwupXtfXr7fg5V6SFf+68z/jCEAG2RG
 l6kn1qiP3quYN2DkBAOKNHdbfCeGl6DiI1uoIeHJZODGPAnhZYDh/j0Efbw4RJupLXXB
 GQUw==
X-Gm-Message-State: AOJu0Ywqe/fjH2jb4VvMswl5QtFd5ujtGqP7Kj+IuxKxRSc3gZVGYxgr
 6ZMl/FKG7OSXpwk9lmcSuQwpPqCilrvGkTWjEcs6uWlegvd+x36G+Lm/sY6LK/uwrsYg6R9o1+T
 06HSbFLHHDkqJBpkbXcklt5Jf8+klQ7XT5d9E97tzgg==
X-Gm-Gg: AR+sD13kDLvGpv9ZgOItk0haLS3G4+EB0edPxcWEhoYfpmc3WYoWLjurhZzuTtLlGvq
 F/wLSW73ppFaYCvyNmhrhCf8X/iELhC0ThGjckUR9T2fiK2GmPN09Zv7pnnuxMtPmtE2fJzLjpU
 BW52JH9u/PgO1Cp648BbsFGjMRS3tUDMLG/vmenDhsXxJo33Rrce0kGADGWWzwdoh53hm2CDvXr
 9QNYTDS4A/EnmMI8PHMC078bJ0T8hPFm+Cmip+VbvBQn6UofNQzS77Uo4Lc9MFRWIzf4ZzhbG89
 KjiXEtZsxOVmLrdLZs2R/QWb7IXNcGRRGZtECjwpWTSOtlnlFhvy8EA5PQ/X8TlRbsVZlXDAlg1
 F
X-Received: by 2002:a17:907:9623:b0:c12:e178:9e68 with SMTP id
 a640c23a62f3a-c2073364351mr1471764266b.19.1786383094931; Mon, 10 Aug 2026
 10:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260810121525.100540-1-alexander@mihalicyn.com>
 <87h5l22faq.fsf@draig.linaro.org>
In-Reply-To: <87h5l22faq.fsf@draig.linaro.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 10 Aug 2026 19:31:23 +0200
X-Gm-Features: AUfX_mxemoPNSIL8XO9tONYrImuj2PQAQz8TDsoiY6iyzCLynWAWz-gUeCWpYg0
Message-ID: <CAJqdLrr2hR_ObgzEosMhDvbz+B9sywGQwJPEcjrzhr1imhCptQ@mail.gmail.com>
Subject: Re: [PATCH] hw/char/pl011: support backend hotswap
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x631.google.com
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

Am Mo., 10. Aug. 2026 um 16:58 Uhr schrieb Alex Benn=C3=A9e <alex.bennee@li=
naro.org>:
>
> Alexander Mikhalitsyn <alexander@mihalicyn.com> writes:
>
> > From: Aleksanr Mikhalitsyn <alexander@mihalicyn.com>

Ugh, I did git format-patch and copied this patch from my Raspberry PI
dev/test machine
and it turns out that I have a stupid typo in my `git config get
user.name` on that machine.
I'll drop -v2 a bit later.

> >
> > Currently, when Incus issues "chardev-change" QMP command to change
> > chardev backend from ringbuf to socket it receives an error (with aarch=
64 VM):
> > "Chardev user does not support chardev hotswap" [1], [2]
> >
> > Let's fix this by properly implementing BackendChangeHandler for pl011.
> >
> > Link: https://discuss.linuxcontainers.org/t/unable-to-connect-to-vm-con=
sole-on-arm-architecture/23096/3 [1]
> > Link: https://github.com/lxc/distrobuilder/issues/892 [2]
> > Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > Signed-off-by: Alexander Mikhalitsyn
> > <aleksandr.mikhalitsyn@futurfusion.io>

Dear Alex,

first of all thank you very much for such a fast reaction and review ;-)

>
> At first I wondered why the FE needs to care about where the BE is
> routed to but 7bb86085e61 (char: chardevice hotswap) explains:
>
>   However, backends are not stateless and are set up by the frontends
>   via qemu_chr_fe_<> functions, and it's not (generally) possible to
>   replay that setup entirely in a backend code, as different chardevs
>   respond to the setup calls differently, so do frontends work
>   differently basing on those setup responses. Moreover, some frontend
>   can generally get and save the backend pointer
>   (qemu_chr_fe_get_driver()), and it will become invalid after backend
>   change.

yes, exactly

>
> > ---
> >  hw/char/pl011.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> > index cb12c3e224f..3622248ec0c 100644
> > --- a/hw/char/pl011.c
> > +++ b/hw/char/pl011.c
> > @@ -660,12 +660,26 @@ static void pl011_init(Object *obj)
> >      s->id =3D pl011_id_arm;
> >  }
> >
> > +static int pl011_be_change(void *opaque)
> > +{
> > +    PL011State *s =3D opaque;
> > +    int break_enable =3D s->lcr & LCR_BRK;
> > +
> > +    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive=
,
> > +                             pl011_event, pl011_be_change, s, NULL, tr=
ue);
> > +
> > +    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
> > +                      &break_enable);
>
> So this is just ensuring that if we switch to a serial backend we
> properly register the break behaviour on the backend? Is it idempotent?

Right. And AFAIU, `CHR_IOCTL_SERIAL_SET_BREAK` is specific to the
char-serial device only.

So when we switch, let's say, from a serial to a socket backend, this
call is basically a no-op.
But when we switch back from the socket to the serial, this will
trigger `tcsendbreak(fioc->fd, 1)`, which is not idempotent (and is a
single-shot action).

But I believe it's not a problem here, because we do it once when we
*switch* between two different backends, and `fioc->fd` is a fresh fd
every time.
My point is that we can't really trigger this thing twice for the same fd.

Please, correct me if I'm wrong. I took inspiration from 16550A's
serial_be_change() when working on this.

=3D=3D=3D=3D BEGIN offtopic :-)

Btw, thanks to your question I did some more research on tcsendbreak()
and BRK behavior [1] and it feels to me that what we currently have in
pl011 UARTLCR_H's register handling code is not really correct. See:

static void pl011_write(void *opaque, hwaddr offset,
                        uint64_t value, unsigned size)
{
<..>
    case 11: /* UARTLCR_H */
        /* Reset the FIFO state on FIFO enable or disable */
        if ((s->lcr ^ value) & LCR_FEN) {
            pl011_reset_rx_fifo(s);
            pl011_reset_tx_fifo(s);
        }
        if ((s->lcr ^ value) & LCR_BRK) {

           // << spec [1] says that setting BRK means "If this bit is
set to 1, a low-level is continually output on the UARTTXD output,
after completing transmission of the current character."
           // what we do is CHR_IOCTL_SERIAL_SET_BREAK which is just
tcsendbreak(fioc->fd, 1) under the hood which can't emulate continuous
low-level signal on the UARTTXD output
           // for the time of BRK bit is set. It only does this for a
short period of time.

            int break_enable =3D value & LCR_BRK;
            qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
                              &break_enable);
            pl011_loopback_break(s, break_enable);
        }

I guess we need some pl011 expert in here :-)

[1] https://support.arm.com/documentation/ddi0183/g/programmers-model/regis=
ter-descriptions/line-control-register--uartlcr-h

>
> > +
> > +    return 0;
> > +}
> > +
> >  static void pl011_realize(DeviceState *dev, Error **errp)
> >  {
> >      PL011State *s =3D PL011(dev);
> >
> >      qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive=
,
> > -                             pl011_event, NULL, s, NULL, true);
> > +                             pl011_event, pl011_be_change, s, NULL, tr=
ue);
> >  }
>
> This does make me wonder if having a static pl011_set_handlers helper
> would keep things tidy and in one place? Either way:

I'm happy to do this too if you want me to. And probably for
hw/char/serial.c too, then?

>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks ;-)

Giving all the suspicion around UARTLCR_H and BRK behavior I still
believe that I'm not making things
worse by this change, but better, cause now we can do backend hotswap.
But it would be great to fully
understand that part too.

Kind regards,
Alex

>
> >
> >  static void pl011_reset(DeviceState *dev)
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

