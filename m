Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1065C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 14:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWzdP-0005A4-Ky; Thu, 25 Jul 2024 10:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWzdH-00058s-Sj
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:39:52 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWzdB-0006Y3-JN
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:39:47 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ee920b0781so2609761fa.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721918383; x=1722523183; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BNpSucY1KMBLSosbiNo9qCL6RMZsHmjpavSdWcYWfw=;
 b=RRYQzHQccGrnMBKHb8dSI8thw93ewqEHKyvb6jOQf3mrKMmFdDP+gDAwrrbtH6aHl3
 RN9HtOw0TlisHyLmjFp0NH6EVkMoooeaSeNn8cc44cZe3MiI8k4m9g6NpWpnme5+ehvc
 QztwqnhzQtFb7AOpRxWodtsXCed4VoA3o3c3hs9eE0iDkHGpbU8gzKhi3x3W2Z1EFQQc
 +jRmN2YQSyiJXmIBo1Ek1BmC+SXwVgQVmBafU+Zd0Jka4d7AXDLS+gmWItJ02QAoaRZW
 c/iWO8ucHTD2sWOsaw0ayDNLB21mZbxqFzwFaSp8PIoxxsFBFrf85nYnw5R0rHzgMWa9
 zAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721918383; x=1722523183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9BNpSucY1KMBLSosbiNo9qCL6RMZsHmjpavSdWcYWfw=;
 b=R22XUNuYFjGMK9q3pAb1RJlVNttVu+JM540CCoTQtst2+6UScCPiud4JloX9u9t4sY
 opj7XzuJEvT+5klQJSjBck4S8zHK3kn5ErPTWk5aR43zBJg7mkVMQ78eSk22DXz5f/Sq
 OV2YFwVBW1a0IZdtj47xIsmhU5iNiQRctUqHoGS5fM2RxPx+fydRKwC6uZaKBpCy1u8S
 DCDkSgNSJO6NeTzZEi3e/ntaU3UfGNUXJhmhPqH07HbhhNsuGtgzPdQ6S1hKFNP99gXm
 kYJ3sL4RGYYh6bgKeVbaMVe3LLTL1f+nwrkyIp0n3ahRtGFQRi3a1x/hdeOuXiPllu2O
 CwFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN4p+m/QyBQRr/j5mRctnXD81YAKT1DvaPerKFzXuPVhkQGWZJytbfgHfPP5nq8ygMnPUexDsUky0VeF+CZKwVPn7QJMU=
X-Gm-Message-State: AOJu0YwMmlDpzTHJnKKxizGj3yilVCVhKvwcCl2YKqwkvtUgI5+UbhgY
 4B74hvWnoegCSM+n+er4E8cc+ZMewdTpXfxlsZqbnNzGsfHbq9J7Y9FOMRUt9aP6zKFIa/AIsVp
 Y6Dn0M3oNmCZaw923iiNkxTQtd+VVBbrgEqXr8A==
X-Google-Smtp-Source: AGHT+IFKYYZAqM6XxJtmFVoosLlXAB0bkRr6gE6Xm1ZhZcQgxXY/66RdAfFv0uw6E7UUOmzxTXoLrxmSQ3ahb6OQCGU=
X-Received: by 2002:a2e:b8c1:0:b0:2ef:22ad:77b8 with SMTP id
 38308e7fff4ca-2f03dba5692mr18352511fa.23.1721918383413; Thu, 25 Jul 2024
 07:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <172158154072.9480.4077116485578955977-0@git.sr.ht>
 <4100ce91-e4e0-426a-8098-93cd29e634ec@linaro.org>
 <CAFEAcA_A57pCQEHi_oSMvngQggfcbW9pR9+qkyQm49NQiVREnQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_A57pCQEHi_oSMvngQggfcbW9pR9+qkyQm49NQiVREnQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2024 15:39:25 +0100
Message-ID: <CAFEAcA8m0V3eExzzoZwoxrs38bt_pkmPm9nB4ybjWteh5q3DSA@mail.gmail.com>
Subject: Re: [PATCH qemu] [hw/char/bcm2835_aux] Fix receive FIFO filling up
 (raspi3)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: "~fvanhovell" <frederik@fvhovell.nl>, qemu-trivial@nongnu.org, 
 Cryptjar <cryptjar@junk.studio>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Mon, 22 Jul 2024 at 10:44, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> [Added missing cc of qemu-devel]
>
> On Mon, 22 Jul 2024 at 07:33, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
> >
> > On 21/7/24 18:13, ~fvanhovell wrote:
> > > From: Frederik van H=C3=B6vell <frederik@fvhovell.nl>
> > >
> > > When a bare-metal application on the raspi3 board reads the
> > > AUX_MU_STAT_REG MMIO register while the device's buffer is
> > > at full receive FIFO capacity
> > > (i.e. `s->read_count =3D=3D BCM2835_AUX_RX_FIFO_LEN`) the
> > > assertion `assert(s->read_count < BCM2835_AUX_RX_FIFO_LEN)`
> > > fails.
> > >
> >
> > Reported-by: Cryptjar <cryptjar@junk.studio>
> > Suggested-by: Cryptjar <cryptjar@junk.studio>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/459
> > > Signed-off-by: Frederik van H=C3=B6vell <frederik@fvhovell.nl>
> > > ---
> > >   hw/char/bcm2835_aux.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
> > > index 83990e20f7..fca2f27a55 100644
> > > --- a/hw/char/bcm2835_aux.c
> > > +++ b/hw/char/bcm2835_aux.c
> > > @@ -138,7 +138,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hw=
addr offset, unsigned size)
> > >           res =3D 0x30e; /* space in the output buffer, empty tx fifo=
, idle tx/rx */
> > >           if (s->read_count > 0) {
> > >               res |=3D 0x1; /* data in input buffer */
> > > -            assert(s->read_count < BCM2835_AUX_RX_FIFO_LEN);
> > > +            assert(s->read_count <=3D BCM2835_AUX_RX_FIFO_LEN);
> > >               res |=3D ((uint32_t)s->read_count) << 16; /* rx fifo fi=
ll level */
> > >           }
> > >           return res;
> >




Applied to target-arm.next, thanks.

-- PMM

