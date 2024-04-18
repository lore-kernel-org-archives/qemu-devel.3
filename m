Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438AFC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxYXx-000315-T1; Thu, 18 Apr 2024 16:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.poggi@lynxleap.co.uk>)
 id 1rxYXv-00030i-Dg
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:39:51 -0400
Received: from 2.mo582.mail-out.ovh.net ([46.105.76.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.poggi@lynxleap.co.uk>)
 id 1rxYXt-0003Io-8M
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:39:51 -0400
Received: from director1.ghost.mail-out.ovh.net (unknown [10.108.2.78])
 by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4VL8lh6ncHz1F9h
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 20:39:44 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-5hgvh (unknown [10.110.96.193])
 by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 765C11FD20
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 20:39:43 +0000 (UTC)
Received: from lynxleap.co.uk ([37.59.142.107])
 by ghost-submission-6684bf9d7b-5hgvh with ESMTPSA
 id hmhpARCFIWZXlgQAcGzEYw
 (envelope-from <raphael.poggi@lynxleap.co.uk>)
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 20:39:44 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001540b2b82-e8d0-476a-a08c-09626303b0ba,
 7D36A28102BF8EA446AFB9278237F9F63EFFF5A1)
 smtp.auth=raphael.poggi@lynxleap.co.uk
X-OVh-ClientIp: 209.85.217.52
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-47b6ac9745eso444617137.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 13:39:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVJyz+L+MXvbIQjovnGoC0EOiQRnGJbcZU96I3WoEc66RdINMKeyf7QJ+AYB3Yu517A0GYHeSTaa+LgTb0AjW0Sox819I4=
X-Gm-Message-State: AOJu0Yx/yHn+Dy7iD9gYmN5j6A7iDaOmLDM4RVk9ggBxAPqCnEzW8fXy
 QCM/Li0xWMaLQfPvu7hFDNRdq9UrSejXnhGSP4LVuQgJTKhe8smcr4a/Ljd6AOYi6ynx5ELfqkK
 dPcfmejwfTpCTkV2JjYzOQIqUO7w=
X-Google-Smtp-Source: AGHT+IFH1aWXS+VjI8UqlQc8tD4ex7rbmOPU3Rb1wh4FAFf72dVWALIGPsLPAyCh7iGIyrYq/GoBfUfZPeAbuJtFzlg=
X-Received: by 2002:a05:6102:b0b:b0:47b:b782:e216 with SMTP id
 b11-20020a0561020b0b00b0047bb782e216mr130372vst.13.1713472782709; Thu, 18 Apr
 2024 13:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240418191602.2017-1-raphael.poggi@lynxleap.co.uk>
 <5b8ce05b-62c6-4362-aa16-a9e845eb4df7@linaro.org>
In-Reply-To: <5b8ce05b-62c6-4362-aa16-a9e845eb4df7@linaro.org>
From: Raphael Poggi <raphael.poggi@lynxleap.co.uk>
Date: Thu, 18 Apr 2024 21:39:09 +0100
X-Gmail-Original-Message-ID: <CACqcpZCubN0Bnmht03TRCWdtYUd4aOpitcx31J+NiMEe2vWhSA@mail.gmail.com>
Message-ID: <CACqcpZCubN0Bnmht03TRCWdtYUd4aOpitcx31J+NiMEe2vWhSA@mail.gmail.com>
Subject: Re: [PATCH] hw/core/clock: always iterate through childs in
 clock_propagate_period
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Raphael Poggi <raphael.poggi@lynxleap.co.uk>, qemu-devel@nongnu.org,
 luc@lmichel.fr, 
 damien.hedde@dahe.fr, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 9588163608518532735
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfhgjhfffkffuvfevtgfgsehtqhertddttdejnecuhfhrohhmpeftrghphhgrvghlucfrohhgghhiuceorhgrphhhrggvlhdrphhoghhgiheslhihnhiglhgvrghprdgtohdruhhkqeenucggtffrrghtthgvrhhnpedtheeivdehvddugfejueffhfegkedthfekieetvefhgeefleejvefggeefvdevffenucfkphepuddvjedrtddrtddruddpvddtledrkeehrddvudejrdehvddpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgrphhhrggvlhdrphhoghhgiheslhihnhiglhgvrghprdgtohdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheekvddpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=46.105.76.65;
 envelope-from=raphael.poggi@lynxleap.co.uk; helo=2.mo582.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Philippe,

Le jeu. 18 avr. 2024 =C3=A0 20:43, Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> a =C3=A9crit :
>
> Hi Raphael,
>
> On 18/4/24 21:16, Raphael Poggi wrote:
> > When dealing with few clocks depending with each others, sometimes
> > we might only want to update the multiplier/diviser on a specific clock
> > (cf clockB in drawing below) and call "clock_propagate(clockA)" to
> > update the childs period according to the potential new multiplier/divi=
ser values.
> >
> > +--------+     +--------+      +--------+
> > | clockA | --> | clockB |  --> | clockC |
> > +--------+     +--------+      +--------+
> >
> > The actual code would not allow that because, since we cannot call
> > "clock_propagate" directly on a child, it would exit on the
> > first child has the period has not changed for clockB, only clockC is
>
> Typo "as the period has not changed"?

That's a typo indeed, thanks!

>
> Why can't you call clock_propagate() on a child?

There is an assert "assert(clk->source =3D=3D NULL);" in clock_propagate().
If I am not wrong, clk->source is set when the clock has a parent.

>
> > impacted in our example.
> >
> > Signed-off-by: Raphael Poggi <raphael.poggi@lynxleap.co.uk>
> > ---
> >   hw/core/clock.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/clock.c b/hw/core/clock.c
> > index a19c7db7df..85421f8b55 100644
> > --- a/hw/core/clock.c
> > +++ b/hw/core/clock.c
> > @@ -101,8 +101,9 @@ static void clock_propagate_period(Clock *clk, bool=
 call_callbacks)
> >               if (call_callbacks) {
> >                   clock_call_callback(child, ClockUpdate);
> >               }
> > -            clock_propagate_period(child, call_callbacks);
> >           }
> > +
> > +        clock_propagate_period(child, call_callbacks);
> >       }
> >   }
> >
>

