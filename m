Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7500C35FFF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 12:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqXlP-0001Wo-Io; Tue, 17 Sep 2024 08:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqXlN-0001VJ-0p
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:57:01 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqXlL-0004PQ-7v
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:57:00 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c260b19f71so6373191a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726577816; x=1727182616; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=165FhIhHwLfItIpKxDEmGRr/lo1RBAQqbOSx6Ab9I7k=;
 b=Y5J6smTizacMhB0SjvkHliJp6/6F1m57kjglB6QO3iIOjM/98v/B50/QfC3dCR23s3
 Jf7BkRGctQ+sPyvzKNqdb7fLD8/2HsrBRhuBDRxIDKgzYhtrCgwzt1ewogCR0+eFJsjW
 eRL5V2ChNDvRVIchKs1xd21cIQdtdgFVH6aZRX8ktsLYRxrzcLCMiqDSXLIb9KNbg1Rs
 qVW6aQHtymkoYyfXCBicyqYDAEz3yPJwYrzaK8WoXe9kXP+NwgLykNEEmH1nbJUZ8bJ8
 Fzy2siC+8BFIpLdRb0NumZV0dj+8cp2xDWGl4kKlSRCzi+NujY4hPaGKA9zeCVVe4OqG
 sh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726577816; x=1727182616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=165FhIhHwLfItIpKxDEmGRr/lo1RBAQqbOSx6Ab9I7k=;
 b=QYew6uH04EZLnd01Nz1XwWYTIjME3G5sbvIxYIsuEiXrTwyFXONtghU0l2b88AvXTG
 IvPEVcwle8js9Hl+Doc80UEpTY5wrEMMIFGh2R5AJZ9FIj3/T47GJIJnxItL5TaRt+zo
 rgPqjyKslzMFMX6zWOY9yA9VA3UgZ4vsqRH1381NuP6fl/v6rXVWq7mX6C8/KgM0x/Jl
 3mcLqEwHFtT87hLibMopRG42B4gx8EytcXAvboACfCH09Xa4hFDFhVjSvWHYoR+8iEom
 8rv4TGqXlwgzUo//8mX3bhrgCskTo5j8bqUfqDXj8a41E51c1GyNHCFChmtyaJMip+zH
 JL9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCZjfHE6Sw1GJvE++fV6qhz54fIk4LigitAHagOKvt+lcElMX459hKBsPDaafm9TjQSw36ILdf8wpm@nongnu.org
X-Gm-Message-State: AOJu0YwcqpLFGK/3MdqpXrRxXuSLHvwiNG7oQCWnn4FK4juYwjk7wTSs
 bfS3wPSryBzAnmNqmHllFNh4vK+33u2XKWrTIYKTseQZ+qrj/cBWxOmDpszzetY1V+YbqpHDKp8
 FfLQz4y+tml4I9vvFIoC2ofW6/jLrJRQ/Y9bthA==
X-Google-Smtp-Source: AGHT+IHwN8yH6PNgHxSPcDJygVaR7wOHgqjwlGcfxnvh/JN6+q1Vkd0CG61E9156pI3k+Qo/U/EqlaGPyBx3BFiZ9YM=
X-Received: by 2002:a05:6402:13cb:b0:5c3:c3f5:592e with SMTP id
 4fb4d7f45d1cf-5c413e12400mr17266188a12.12.1726577816309; Tue, 17 Sep 2024
 05:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240913163636.253949-1-r.peniaev@gmail.com>
 <20240913163636.253949-2-r.peniaev@gmail.com>
 <CAMxuvawD8QrsjJ9xiE9KDa=BTj8urRcCcN5YasiE3m-R7xEcuQ@mail.gmail.com>
 <CAFEAcA96LM9fe5bTOVVAz3PuNfAt_aGr_6gq3BP9wfFq0Y3OwA@mail.gmail.com>
In-Reply-To: <CAFEAcA96LM9fe5bTOVVAz3PuNfAt_aGr_6gq3BP9wfFq0Y3OwA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2024 13:56:45 +0100
Message-ID: <CAFEAcA_EqBLsZeVFjnj9zJ2s-VM=jmFnOf2vSqSJTEWke86=SA@mail.gmail.com>
Subject: Re: [PATCH 1/2] chardev: implement backend chardev multiplexing
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Roman Penyaev <r.peniaev@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 17 Sept 2024 at 13:40, Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> On Tue, 17 Sept 2024 at 13:32, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Hi Roman
> >
> > On Fri, Sep 13, 2024 at 8:37=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.=
com> wrote:
> > >
> > > This patch implements multiplexing capability of several backend
> > > devices, which opens up an opportunity to use a single frontend
> > > device on the guest, which can be manipulated from several
> > > backend devices.
> > >
> > > The idea of the change is trivial: keep list of backend devices
> > > (up to 4), init them on demand and forward data buffer back and
> > > forth.
> > >
> > > The following is QEMU command line example:
> > >
> > >   -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0 =
\
> > >   -chardev vc,id=3Dvc0 \
> > >   -chardev mux,id=3Dmux0,chardev=3Dvc0,,sock0 \
> > >   -device virtconsole,chardev=3Dmux0 \
> > >   -vnc 0.0.0.0:0
> > >
> > > Which creates 2 backend devices: text virtual console (`vc0`)
> > > and a socket (`sock0`) connected to the single virtio hvc
> > > console with the multiplexer (`mux0`) help. `vc0` renders
> > > text to an image, which can be shared over the VNC protocol.
> > > `sock0` is a socket backend which provides biderectional
> > > communication to the virtio hvc console.
> >
> > I think I would rather implement a new mux for this purpose, like
> > "mux-be" perhaps?
> >
> > "mux" has been a bit hidden (behind mux=3Don) for various reasons, and
> > is probably not at production quality level.
>
> You get a mux by default (for serial vs HMP monitor), so
> I think it's pretty heavily used and tested in that sense...

I should have said "by default for any -nographic invocation";
that's still a pretty common usage pattern, though.

-- PMM

