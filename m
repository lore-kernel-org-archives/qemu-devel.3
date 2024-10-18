Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F430D30019
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 16:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1pXn-0001x0-Dr; Fri, 18 Oct 2024 12:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1pXk-0001wa-E1
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:09:37 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1pXf-0003xM-7U
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:09:32 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c941623a5aso5892381a12.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729267769; x=1729872569; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbLx4yxb+uBezfr57eA6X/1UtI6z78vsSL3iCMRSr1M=;
 b=Dz3RVB2O5WzUF1DbAOWo2V9g97efDzdmqthWkeAyZZPTON3GGmwJwIvqACOuzsqnKK
 XLj6ElzQco3fveDL6j/RDFYTnthltyAorjFGdGGYJv+IdvUFb4CDhziwQE//lgP912tw
 PrqRFh05JS8prJA07SrtNGJF/JW2e9BFLBwwrnKvCulH3iKmD1uhlSs1mwC/+n0ERQNU
 zRMxoZS5BK4hmBJ2agcLlid2IXTUPVvnYNsb0Q0RjuQirxuE8SDuZE01sMt0YBYa5grI
 OyajTB2BbR7aB6LWcbXiQ/ZFKU/PifuQDyiRRjCtc1oFbMPphrJORCaASeEfDZbZ1319
 fZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729267769; x=1729872569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LbLx4yxb+uBezfr57eA6X/1UtI6z78vsSL3iCMRSr1M=;
 b=FrF5lPVKHiG3eLA7hWlyqYocy7TyDg/Ix5lHpLitXeNbCFEyTVYv3tUEcNHRHwc3YQ
 12Bid/8cscN5BWjyDp4vkIHzM4M3Srcm+iKK88GJ1Q7K/tvgmI7/m5hkyN7Gse39loy/
 mPKxm74SwYf1B55Thi/ltLd7HoeAUuKnajks+/jFjGjOo8/PfnLoj2zDKjhiQoQfytih
 QMl9YJKu86oXZzVpqmLrq5jCNmmbpCOVOo5W3w8cRsEFQDsyIrm2BZJ5BtEB3hyJAPF4
 6055d184YaxODNIjxHX3pQg4fqov3fF7ksDrt5Hu/m+Z03qt/SuCMOI7wr9yeM9gyCqg
 z0Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR0dJax6U9eJop4qsu8fLsyL+9E31MbKEK1MVqEiD1gB3ApPaZsXK+/cwum4FkMfOGyNPurxZ9DT/h@nongnu.org
X-Gm-Message-State: AOJu0Yx5C4eeJ55geShm5vF4G7p8G9wuauaFC9qXzpE4/hE+JlvUMI/q
 MHF+Ny5fJDMhI0y0b6pgfMXB/cu3G4blrrt+Ejf8QNOWk4RDdtvU9nhy8xaWfvOQbFNxqEn6GVs
 UibOzpwtSiEztm8zGnbJtPwh7OgdfUtyzrLDV6g==
X-Google-Smtp-Source: AGHT+IFnPSqYcPPwadZIC/OG56Wo/bLqiUHY/QaTGWxT+kxquXtQNORQiw7YjbEvrMI6RKVoSr0QW78Izki+PkOjKW0=
X-Received: by 2002:a05:6402:40c9:b0:5ca:152f:faed with SMTP id
 4fb4d7f45d1cf-5ca152ffb3amr34874a12.15.1729267769217; Fri, 18 Oct 2024
 09:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241010173929.3910466-1-tavip@google.com>
 <CAFEAcA9X1bdtxRL9fm_rnw9ezMZSW6HaURfMsA4aLMSHM4fzdw@mail.gmail.com>
 <ZxKHSB8l1HmtxrZ6@redhat.com>
In-Reply-To: <ZxKHSB8l1HmtxrZ6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 17:09:17 +0100
Message-ID: <CAFEAcA_Q_6Vd00Hyy4cUtMCN9=nX=SxqhRAB6Fhrd5_D_jyD0A@mail.gmail.com>
Subject: Re: [RFC PATCH] cli: add connect-gpios option
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Octavian Purdila <tavip@google.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, eduardo@habkost.net, armbru@redhat.com, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Fri, 18 Oct 2024 at 17:05, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Oct 18, 2024 at 04:38:24PM +0100, Peter Maydell wrote:
> > On Thu, 10 Oct 2024 at 18:39, Octavian Purdila <tavip@google.com> wrote=
:
> > >
> > > From: Valentin Ghita <valentinghita@google.com>
> > >
> > > Add option to allow for connecting device GPIOs. This is useful when
> > > adding a peripheral device from the command line which uses an
> > > interrupt.
> > >
> > > It takes the following options:
> > >
> > > * in-dev-path, out-dev-path - required, the device canonical object
> > >   path (e.g. /machine/peripheral-anon/device[0],
> > >   /machine/iotkit/cluster0/armv7m0) for the devices that should have
> > >   their in <-> out GPIOs connected
> > >
> > > * in-gpio-name, out-gpio-name - optional, the name of the GPIO list;
> > >   if not specified, the unnamed GPIO list is used
> > >
> > > * in-gpio-index, out-gpio-index - optional, the index in the GPIO lis=
t
> > >   that identifies the GPIO to be used; if not specified 0 (the first
> > >   GPIO in the list) is used
> > >
> > > Usage example:
> > >
> > >  # add the tmp105 sensor and connects its irq line to the CPU
> > >  qemu-system-arm \
> > >   --machine mps2-an505 \
> > >   --device tmp105,bus=3D/versatile_i2c/i2c,address=3D0x50 \
> > >   --connect-gpios out-dev-path=3D/machine/peripheral-anon/device[0],\
> > >     in-dev-path=3D/machine/iotkit/cluster0/armv7m0,in-gpio-index=3D10=
0
> >
> >
> > This seems to be moving down the path towards "create and
> > wire up machines on the command line". We shouldn't
> > be doing that ad-hoc with one small commandline option
> > at a time, we should be doing it with a coherent plan.
>
> Yeah, as a general rule, adding new CLI args is pretty undesirable.
> To avoid that we could utilize QOM for representing data:
> eg a "gpio-connection" object:
>
>   --object gpio-connection,out-dev-path=3D/machine/peripheral-anon/device=
[0],\
>            in-dev-path=3D/machine/iotkit/cluster0/armv7m0,in-gpio-index=
=3D100
>
> this would be OK if we're fine with some code somewhere that iterates
> over the 'gpio-connection' object instances performing the wiring.

Maybe, but as I say we would want an overall design for this,
not a single "well this happens to let this one user do this
one specific thing" approach.

At the moment our design is "QEMU command line options are for
doing the equivalent of plugging in PCI cards into slots, not
for the equivalent of soldering chips onto boards". And in
that view of the world "link this gpio line from the tmp105
up to the armv7m interrupt controller" is not something to do on
the command line, because it's definitely soldering wires.
So for current QEMU the answer is "if the AN505 has a tmp105
sensor, we should be creating it in the C code for the machine,
and if it doesn't then we don't support creating it on the
command line".

thanks
-- PMM

