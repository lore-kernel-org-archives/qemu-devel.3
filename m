Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65304C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 15:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxprO-0002fI-No; Fri, 19 Apr 2024 11:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxprH-0002eo-8n
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:09:00 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxprD-00085g-Bw
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:08:57 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-571c25a329eso2503635a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713539332; x=1714144132; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VD67OE+c1MW2Nrl9j1vYfQSom4Wr5fQZfhvS6Thwdi8=;
 b=OkiiXj3t0ryQAC3tKqfBG1CCzzna/XTUdza3tmrfPLMC1rima27cdaJ2I32Oml9m8t
 4FHCe6Nq/QEaEJUTiMeQhDOjZWjof+UqyTqfSFguAMDEfGaDEfpvW2TzwwLuekCSI3ta
 tyPSZza0PswJzWlr6G8T4sjMRWMx9cezNy0MaiEv1jJ7HKH6JeR65+RfenH+GaTIPyhq
 nEEEwmApxc1KxwLfLKAwz4Pi7I8HBlNAzLqmByCsmIfTjRMKyZbVgORFrUnyLmOvlKJ/
 9E2qIi4hgZHpunC18ZDmLkH6veBdA4BxfckcvuPvUcrTZ2NyFlw34y/HQIyZeeVeoJS3
 YKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713539332; x=1714144132;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VD67OE+c1MW2Nrl9j1vYfQSom4Wr5fQZfhvS6Thwdi8=;
 b=VcUAvTno3+/vpvFidveZWheRmknm8cT+ZNQUu47UDBgPcq6bTPwvWBDb4U4xUhV/jJ
 5Ap0/Z8eHTg8igTMIU0J9WF+y80USN8sDz4wpnRr9J+uO9Ww/4Kt7aliiUEeDw/94IeD
 PefW8TxNd0X7zkU/mjRHoLFsYLcHOVK81gM7ZLDU/lPv5Dr3pmOOGVogyuVHKVF3o3EU
 ndgaAvo4o/ocm4+KPBeXu3cESubXEJSu2qO7CAv4BfyJFOhTiocrusVUdMMy68XIf/J1
 L+v85ennY64nQvhwSbz+wZiFFx3Ay9FvEAq5RcSLwSzcIP00ip2st/wdETRIVkaLzfAl
 5y8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtH0N4SvYgvAMQ0DyKsv3g6S8iQD9tQovg1QohQkxc+C8lW1lW8qpRhLEC3Te69a8EuWlQsHP+KtjUDAmGW17NHymMhgo=
X-Gm-Message-State: AOJu0YyDJLWUx/Hvw9+7y57Mg/EKIxgj7eD1LtjyWUVb9Nkh7Wrn4gRM
 Wcdcenzt1rQZtWRTcP00oReT3mtCDcRw5MoqOrYllXuKdH6DtyIZ/0alXluU9uHvJkI04eEaVfs
 foMziW6CACPSkVc/KX93KNyW1ZohVWyzbKmvMqw==
X-Google-Smtp-Source: AGHT+IEdytZSbGMpHHgJ8vK4E+HFEmNiFG14IDEulQHbF+szMqVqBMxnNAEF3WhY+UrooIRiA1Wx/inZE5iRDwTR8gc=
X-Received: by 2002:a50:8716:0:b0:570:5e98:64b7 with SMTP id
 i22-20020a508716000000b005705e9864b7mr2357302edb.17.1713539331508; Fri, 19
 Apr 2024 08:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240418191602.2017-1-raphael.poggi@lynxleap.co.uk>
 <5b8ce05b-62c6-4362-aa16-a9e845eb4df7@linaro.org>
 <CACqcpZCubN0Bnmht03TRCWdtYUd4aOpitcx31J+NiMEe2vWhSA@mail.gmail.com>
In-Reply-To: <CACqcpZCubN0Bnmht03TRCWdtYUd4aOpitcx31J+NiMEe2vWhSA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Apr 2024 16:08:40 +0100
Message-ID: <CAFEAcA9wcaptrL5LHWah0MeKP1CV-WbfwsS65kibLwJ4TpvjTg@mail.gmail.com>
Subject: Re: [PATCH] hw/core/clock: always iterate through childs in
 clock_propagate_period
To: Raphael Poggi <raphael.poggi@lynxleap.co.uk>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, luc@lmichel.fr, damien.hedde@dahe.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, 18 Apr 2024 at 21:39, Raphael Poggi
<raphael.poggi@lynxleap.co.uk> wrote:
>
> Hi Philippe,
>
> Le jeu. 18 avr. 2024 =C3=A0 20:43, Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> a =C3=A9crit :
> >
> > Hi Raphael,
> >
> > On 18/4/24 21:16, Raphael Poggi wrote:
> > > When dealing with few clocks depending with each others, sometimes
> > > we might only want to update the multiplier/diviser on a specific clo=
ck
> > > (cf clockB in drawing below) and call "clock_propagate(clockA)" to
> > > update the childs period according to the potential new multiplier/di=
viser values.
> > >
> > > +--------+     +--------+      +--------+
> > > | clockA | --> | clockB |  --> | clockC |
> > > +--------+     +--------+      +--------+
> > >
> > > The actual code would not allow that because, since we cannot call
> > > "clock_propagate" directly on a child, it would exit on the
> > > first child has the period has not changed for clockB, only clockC is
> >
> > Typo "as the period has not changed"?
>
> That's a typo indeed, thanks!
>
> >
> > Why can't you call clock_propagate() on a child?
>
> There is an assert "assert(clk->source =3D=3D NULL);" in clock_propagate(=
).
> If I am not wrong, clk->source is set when the clock has a parent.

I think that assertion is probably there because we didn't
originally have the idea of a clock having a multiplier/divider
setting. So the idea was that calling clock_propagate() on a
clock with a parent would always be wrong, because the only
reason for its period to change would be if the parent had
changed, and if the parent changes then clock_propagate()
should be called on the parent.

We added mul/div later, and we (I) didn't think through all
the consequences. If you change the mul/div settings on
clockB in this example then you need to call clock_propagate()
on it, so we should remove that assert(). Then when you change
the mul/div on clockB you can directly clock_propagate(clockB),
and I don't think you need this patch at that point.

thanks
-- PMM

