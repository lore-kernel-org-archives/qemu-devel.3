Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32489CD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 05:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTYmc-0003iL-8w; Sun, 31 May 2026 01:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wTYmY-0003iC-Pk
 for qemu-devel@nongnu.org; Sun, 31 May 2026 01:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wTYmX-00067M-5N
 for qemu-devel@nongnu.org; Sun, 31 May 2026 01:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780205534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6rwFYcB0jmuCgLR0JymamFysWVRXB5Tr5P50BFauCw=;
 b=hbfTYKlYy8KjPrIkOINZZJJ+2FWoYv3rJohAB7+lrxV0VbZlPiC0OYmCFjOb3EUE8AipzD
 BN4Gkvm3R7hoDnzpZzfqUGXmKvK32E5p7W+21O7jyUt/HBYynhbBUEIon4FiEXe8J0y+ut
 HXokS4DGHyIGB6/CDWGTH1qvjkE8VzM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-TjJi21zKOXa66MOdU5R5Xg-1; Sun, 31 May 2026 01:32:12 -0400
X-MC-Unique: TjJi21zKOXa66MOdU5R5Xg-1
X-Mimecast-MFC-AGG-ID: TjJi21zKOXa66MOdU5R5Xg_1780205532
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36d99181eaaso476185a91.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 22:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780205532; cv=none;
 d=google.com; s=arc-20240605;
 b=O+RJmHjoLE3+YH4Klt6Dgm8ly7MSmqGQxgH8tAINZ4dHG0cT99mnrXU7ADCap1NQcM
 4jAunRG6QCFDUBkrh9TffrWHBDFDUK02RqN1ILjsmck3H7+AV+2qTljAQTouO+ahzcIX
 c5M2dsUYnQaqsUvh3TbgQBduHy4RgEt6jsymoUL0wjhtel5C0xuYiNwOWUmOQlQoc7fp
 w/T8Mz8KzaRP1F1TLuM17SCgGLu99GRidJW9FtOVTmyFhvAuVQ91kTUdeKIXUeYo/OHl
 r2LZ8Bm+C2s3paI14oSk+Xm8Q+AYdqy2ix3rskNMbf14FVGXO+Sz0lt9LCEM81EoogRl
 JGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g6rwFYcB0jmuCgLR0JymamFysWVRXB5Tr5P50BFauCw=;
 fh=McZmlkt8FK1AVUJtKH5fW2xSh00Sm8PWy7JrdB/o5+c=;
 b=kDwPnICyBMM8suvEIqxyDcef0GnEWGY7fq82aR3/ye4MPfRmEIOmoTTMBm2FHauQPg
 lDKP0BKt3oXUmQDYco5I2/JbIm+vGQ0QSaBGxyl995J6h5R5lFc+1BpRwP9ckGeS+oHL
 IvBprYVNhsOZ5dcwcijASyk9Mq0cYDvBFJMRLZnSu96+4zcMlPfLRcbTZP0FAafQTcM0
 xy2vgOLl5ksXru+xeB+yyORwUTLEBUCwaVEDlASNgS1rxvgA8dFdNb21ZsuHkWr/vsOz
 q/t0gkrIHvggVbLzvP+2kGpyntCGOJOhoQp3u/GZt8KM6BO3ogSvyAPtzmtH4BQE0m56
 Zmxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780205532; x=1780810332; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6rwFYcB0jmuCgLR0JymamFysWVRXB5Tr5P50BFauCw=;
 b=BKToOKwiFxMykMHJh/TsizqWgq0HcHQLajw2trZbL35MbMLgIkIstrM3OuDvdGtHkV
 pKaMPuHeX2Um9UxHd1JUBCvLnp+gwLjbldFmFWJugMnbM85QGxKjTXiKbmiFjPZsX0kU
 nP3NH5s7NNgV0KouIN+4zLK/JOsNCD40UYyycJv1/SO6gCrkQFxoF24OKsMctQ5iXNWY
 Nkj3/S66700g73Ny3M96PZvmG89YyObt6PenN66WCLoncQg+sg6VE7DEA8SE4gukJ9c7
 eroNDLBhRCCYVOLO/mboANcyu5lvEuznYmhwIocX+as6gzHvN6dDMsZW1nrfBIN/JAN/
 pEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780205532; x=1780810332;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g6rwFYcB0jmuCgLR0JymamFysWVRXB5Tr5P50BFauCw=;
 b=hhQFf5pSZRi0XVsxyW3JO4ZeVocl7q4PPaPJ36SuD4fpAMt4zXgd8Hgq1NZ3xWXwg5
 usvzmXiKE79POVBeuiey1rZ6zTBeabY+N68YgK4EaQAIEI7mczVEbXKNcfHndkj0I967
 yB+CetDE4pOfmmQfOGHK8obhRKpB1uVxvOTl5gYGrxlD5cVeCMLUPmx99Nx4YbXNfDxT
 B1CpryRFp1u/RFa1/DFCngfpE6ca4TrsaIdB/Q4zrGyO7oxU8W1xNxKVyIJT5G3CESha
 rknRHn2QRMLTBgjzI2pel/3bNkSIztM0JX7pULnW5UmjlaYM8zBigWEhszmce1ETN01D
 rKdQ==
X-Gm-Message-State: AOJu0Yy8PERKdCIbWLogWuh1QBzu7eGZKYMQG0qKknasiUcyRgc7Uztw
 15/fszHz1BrJ7rvKtoFwOyLIGTMfQTEV6ZWcW/wJa1K1AXKwZ2tqCB7oe14kju3k3TSWNRd3+SI
 DNT4pAfHYRj6FI4wdYn+o1hD3E5eiox5oio/e/bV/qmsgl67KaSNqWxb7kPmHJ8ZB4Q2aLFysSs
 hNFIlkNolIMVN7lC+kPLctS2TL17M7tQo=
X-Gm-Gg: Acq92OE9I3a1Nrxz2u2u6MsTsEfMLZPatENHvqPbb+SJKRdE+G0jvPXnBW+25SPLE77
 lE0p/3ywcDjLoSYzQLx0OsLsuR3DgYyhQWhRLerStUSbLgvE6kgtJ2l+frsfo8rsSKT+MXuc/pQ
 7Hzd+NguaPmI+6EW29jcxtbc64f4DiDVid2Oj5Vg6hw+5H+EgXTwCcxpKjBWs0VfJTmgCP83Ie+
 4K/2HnYnAdxvWLa8l90XTgQXeeDG/jHDAkER2859IIoaDKA1J+L1v0uzplICxZN1xSIfJGazBae
 podBmjzdyeslBwawF6llpe7VYLfwgPTxs90=
X-Received: by 2002:a17:90a:d445:b0:35b:8d89:719b with SMTP id
 98e67ed59e1d1-36c4feeb843mr5856144a91.1.1780205531794; 
 Sat, 30 May 2026 22:32:11 -0700 (PDT)
X-Received: by 2002:a17:90a:d445:b0:35b:8d89:719b with SMTP id
 98e67ed59e1d1-36c4feeb843mr5856116a91.1.1780205531171; Sat, 30 May 2026
 22:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
 <20260529-b4-ui-v1-3-8db3068421ef@redhat.com>
 <CAFEAcA_YPFVabhNxsp84BVKtwehg8-ke3Saes7Tx4eW1b+57xg@mail.gmail.com>
In-Reply-To: <CAFEAcA_YPFVabhNxsp84BVKtwehg8-ke3Saes7Tx4eW1b+57xg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 31 May 2026 09:31:59 +0400
X-Gm-Features: AVHnY4IzhJiAElTg6SIzBBmtCkAVBFg68JPcKNOojM2kuz1A1oNjsbOCa2PWjCk
Message-ID: <CAMxuvaw5fypoRxb+mwDFS_Xf1Zmy9FoLk_im3BgRi3TGmc-XkA@mail.gmail.com>
Subject: Re: [PATCH 03/32] irq: add per-IRQ observer to fix
 qemu_irq_intercept_in leak
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 29, 2026 at 5:44=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 29 May 2026 at 12:17, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > qemu_irq_intercept_in() saves original IRQ handlers by allocating
> > new QOM objects, which are never freed. On a PC machine, this leaks
> > IRQ objects (one per IOAPIC pin) on every qtest run.
> >
> > Rather than tracking allocations to free later, avoid them: add an
> > "observer" field to IRQState, called by qemu_set_irq() after the
> > real handler. Interception sets the observer instead of rewriting
> > handlers, so there's nothing to save and nothing to leak.
> >
> > Fix qemu_notirq() to route through qemu_set_irq() so inverted IRQs
> > trigger observers too. Drop the LSan suppression.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/hw/core/irq.h         |  1 +
> >  hw/core/irq.c                 | 10 +++++-----
> >  system/qtest.c                |  3 ---
> >  scripts/lsan_suppressions.txt |  8 --------
> >  4 files changed, 6 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/hw/core/irq.h b/include/hw/core/irq.h
> > index 291fdd67df4..93d5710a73e 100644
> > --- a/include/hw/core/irq.h
> > +++ b/include/hw/core/irq.h
> > @@ -14,6 +14,7 @@ struct IRQState {
> >      qemu_irq_handler handler;
> >      void *opaque;
> >      int n;
> > +    qemu_irq_handler observer;
> >  };
> >
> >  void qemu_set_irq(qemu_irq irq, int level);
> > diff --git a/hw/core/irq.c b/hw/core/irq.c
> > index 106805e2417..fa11e9bc0aa 100644
> > --- a/hw/core/irq.c
> > +++ b/hw/core/irq.c
> > @@ -32,6 +32,9 @@ void qemu_set_irq(qemu_irq irq, int level)
> >          return;
> >
> >      irq->handler(irq->opaque, irq->n, level);
> > +    if (unlikely(irq->observer)) {
> > +        irq->observer(irq->opaque, irq->n, level);
> > +    }
> >  }
>
> Hmm. "observer" semantics are probably nicer than "steal
> the irq from the thing that would otherwise be connected to it",
> but on the other hand this means that this purely test-relevant
> thing is now in the code path for the common "signal an IRQ"
> that we use everywhere...

Sure, but is this more intrusive or expansive than a trace at this point?


