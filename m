Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B3FCD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXfjx-00030B-CS; Thu, 11 Jun 2026 09:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXfjr-0002zf-MZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 09:46:31 -0400
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXfjq-0000ir-39
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 09:46:31 -0400
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-13832028e9fso3295970c88.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 06:46:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781185588; cv=none;
 d=google.com; s=arc-20240605;
 b=EjgG9i37AYSWuk3P1c6HS97cCJhLPQrY+/KBnU1UhcoA2prdONl08Fiec1h2lYDCCx
 uFycHwnXLkuh7dObpOv6SfQJu17z1a037hz8yS/q8ioBAmJxGTRsVctt9P4d9lit7tg2
 rF38raJvJ3yReaT+qOkKBZ5vlrNM9feB1oWxjVsWvUgLanPafokVd8aG04k6RbEJSrOF
 laVszlLsq9uc7PKAGtUM5K80khoVwi8fNaJfVpqKZwRnPOtcwq2hOURLvS8IgoIuXMqH
 +g7lS2o0bClOUlrZ/V8hITm05vF3f5q5jU0wL3v+C+CwWqpW0TkSv7eZtKJy8wmm3Az6
 MlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kPomZFA3khv8E1I+KmB7TmRo1R6PA6pXARWIvgmr9qs=;
 fh=AZkZ0b1lNOWrPAvx6utUMPvNnVTPoQb/VE06IgS7KRU=;
 b=dV3digqd01FdZSKm7si7NSyCXgUcMgHRPqicDMijlNGW/a3aFt/S8dcAAXzhp0OwVC
 fF/7U2uJVoHbt35M3boT0y87MobKAVePRZT2DblKb5MtA/RgxM0uHryWgk5ayxkEsCAQ
 0D7fi4ecQCea1gmDUkIa6/BCVBMn+pm+fur9UReSnUqMPEkzJOOuFJrT7GdZwSIO37PB
 qqizWWjPTdCYWFp4uPEZfbt9jMOAW7EmjygaKxYbaORnH4dU4qZTVsfbdDa3zI+GLtp5
 KlEEWWbxFcl3nTZ+jzuS7itgfaRAhPi1v6RscTFvK4fiYsxPY5VVpI03E2/QjOAC9C2Y
 Glvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781185588; x=1781790388; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPomZFA3khv8E1I+KmB7TmRo1R6PA6pXARWIvgmr9qs=;
 b=sENqtKJC+ldvgLeA0logTw0WA3W7izFYqwgUnVUvqPIxiuS4yLz4qF18a37RT0SuOs
 jHNXAAB7dQWasbpvqTUfLW4Wygssk4W5H6yccGcjjZPPZrHUK+worOR53TgDYAZEKA4E
 M201/0Gk+grkhwKa4vt4hVtjTjLIXC2v1R2LJUOGCV1ip8i1vW697IsTxMhu38Of50um
 ZzHTsj3OuYlUyw49OzqGwWogqcLPW8BYU8sh9cwzAPmac6MhTQlpeJM3zLn49TwLOIc2
 y1dprh5nC4rBfR4ngioXaNslZSzTWfbYLJBOd6sQZXey4q3HD5/Cknbx+JRI05Tirh34
 lrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781185588; x=1781790388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kPomZFA3khv8E1I+KmB7TmRo1R6PA6pXARWIvgmr9qs=;
 b=CysD0hO8wZnbMiPrZ7xybwR95g+OCSC4oc9ORTGunxjEdg60oT5UMp65/usokrACgw
 uxvnfZpM615dJrEWZVHLZ8PqH8T/RKEkPLQMOphRk2Lao557h/a+B50v9Ao/P5UyWJR7
 QY1UVEqhyp7+3CGT/W1mAJ+gMvDTjiU2I/vCvnX4lAAgViG0XRxX6KL0t8hQcDU2mW4l
 Rt3icx7IufP7zi7a6Or/vsENFJfbeyy6vcaVnSWdoEsUdOrZ7QAzIqXNuC3s2xpK70w1
 tiCl+4oL+KbTxj1YsSt3wyaL5pugjiAuF0bJi8P1g0/BdZQJa7m4tN+agc+EyRB/x8LM
 UQNw==
X-Gm-Message-State: AOJu0Yyl8jtjYhqNTF/2toPeKF34Tf1tX3IbsQepOmPjmEWAtBGKV2G9
 orWpt2kY+VJNqxHrSg2NbMj+DarzPIVTdrXrIK23TrznKP0nUA6IsoQdLDnT/Zor8nadQsBAZXz
 Iv0Bc0vqosvA+xrr/i9JjhDMjBvgnTzo=
X-Gm-Gg: Acq92OFoEHRMKTZVeyVK9p1+NIR8cEyOraIARGNS9Of/BGhZbtIIltBdbCYEXFShhUH
 RCqYcOwLG91gun8u5r4YN8J/+ugsinRJPQSmXgzQgRht1duwfTvHQWpWXUDFcFYOsPGB1uBX/bG
 gNHnyZzLAi/lqpW3wGD/sQ0yF7TbzZS7jx+KRnXaoawl9NPR+6LFpPtkBC/ksOH6h7rc1BJu9w4
 2jx+z+bgw89tKay6kF/fEenOkEMJl83IJOsQVeXEqe+Lg66ImkPzAyzWWE49/xHp7C2vg5P3a9i
 /gM2Gl6rDjfnXP4p1gSt9B5P+BMTbKX3j/rbdpTddk3j1IvH6w==
X-Received: by 2002:a05:7300:fd0b:b0:304:d92a:e60a with SMTP id
 5a478bee46e88-30804b75e04mr2387242eec.31.1781185587755; Thu, 11 Jun 2026
 06:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
 <20260611-b4-ui-v3-22-72bcbbea0fae@redhat.com>
 <ec625143-875e-41a3-b6f7-f3e23aa4b71b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ec625143-875e-41a3-b6f7-f3e23aa4b71b@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 17:46:15 +0400
X-Gm-Features: AVVi8CcyTA6mic_W7RndEkCp3rwtapYoI31l8UZuuNYDH4Hdp440b6GkQPUduKk
Message-ID: <CAJ+F1CLyz0Bo=_pqVh2c854VXrDdSF0HSBMbjfBCxZ5xGeUfXQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/35] ui/dbus: implement display cleanup
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x1229.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Thu, Jun 11, 2026 at 5:19=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/06/11 18:03, Marc-Andr=C3=A9 Lureau wrote:
> > Add dbus_cleanup() to unparent the D-Bus display object, ensuring
> > proper teardown before user_creatable_cleanup() runs.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   ui/dbus-console.c |  3 +++
> >   ui/dbus.c         | 13 +++++++++++++
> >   2 files changed, 16 insertions(+)
> >
> > diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> > index 742bf9639a4..63d21493101 100644
> > --- a/ui/dbus-console.c
> > +++ b/ui/dbus-console.c
> > @@ -152,6 +152,9 @@ dbus_display_console_dispose(GObject *object)
> >       DBusDisplayConsole *ddc =3D DBUS_DISPLAY_CONSOLE(object);
> >
> >       qemu_console_unregister_listener(&ddc->dcl);
> > +    if (ddc->dcl.con) {
> > +        qemu_console_set_display_gl_ctx(ddc->dcl.con, NULL);
>
> Somewhat weird, but theoretically this may clear a console GL context
> registered by another display. Below is an example I let an LLM generate
> (not tested):
>
> qemu-system-x86_64 \
>    -machine q35 \
>    -device virtio-vga-gl \
>    -display dbus,p2p=3Dyes,gl=3Doff \
>    -spice unix=3Don,addr=3D/tmp/qemu-spice.sock,disable-ticketing=3Don,gl=
=3Don
>

Right, it's a bit embarassing. I think spice should be a display (and
vnc too eventually..), so we wouldn't have 2 competing console/display
handlers that have their own GL.

I think the safest for now is to simply prevent spice with a display
providing GL. I'll work on a patch.

