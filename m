Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D233CFA1FE8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFd8G-0002xZ-TQ; Wed, 22 Apr 2026 15:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemoreira@google.com>)
 id 1wFd8F-0002wy-1n
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:21:07 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jemoreira@google.com>)
 id 1wFd8D-0006B8-CD
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:21:06 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-50d6b393d60so3235411cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776885664; cv=none;
 d=google.com; s=arc-20240605;
 b=KTUDler2vSY6QE7bHGl8r8wIRcPFI97ANqJgkLjrg8fonZBh6x9w6yuvEUZKefjO50
 VXfm9k71mBetnVMTEhSMHKX+77LiN4m1HM/fegt3hCpusLAOHEg0txLbMyN8JdMBWDVK
 vnNDqhOr5EY+6GwMGfxXCFhLTPDw7UyyqsbHA7h0aYLOkEr6+6jfuyS29wSgnora87bl
 hN3iVxibU1HDyLTGnldzNRnXkbtknimDleZu6Bt3zAeWdaHBCYFmdo2EdyluqBtoOwL0
 /2I/1tIBd4QyyLw2Vc8QHCUEglowCCWmrRHrQGCjgJxhdB9kVSg/VVZWs4c/n82pQR8z
 DibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lTmzBrjr7Z+9LG3YOTWzEcHyH0AEGS90m8YNAo038JI=;
 fh=MLap5cF7G5v9oTY/S2snS0yne1QlZyDQWJlAycJrsJo=;
 b=G7yx3HVPN+8ILNEFdmxpRHc1JOa97N6H/NHuMz1TArsR1jO8NRTpLeWVsYu0NYZBIK
 qqmO0II1oqnheUoB12GupMZsjDyMHB2p4/J7w/4PL1MBGjuqjVK620q4CE1D8oRabmQU
 yiQdKsS3fdFZ793cIBJGUty4T7gRb87DLxos62LGbC1mRnWWLOad4WHcf7hxODVUjGiw
 Y9eTfaw2mxSI659+w/+cpkaFjX04jc3NNImmH66avvthdn55evVwJxxOm70N0lheTdIk
 mo70fkwZrG/Ytgxf7UAhDMOIPhFjO22JiJvn5aCIwBEnrZtNzZUlSzwABU0tkgx22Uip
 y0eg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1776885664; x=1777490464; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTmzBrjr7Z+9LG3YOTWzEcHyH0AEGS90m8YNAo038JI=;
 b=DrP89Vi2zQPBJ4/VreGITEj+jm2A7sy/yUYUe9bEaYqZU11hNxtEzsrvskOSDMLuZe
 GhxLZ17JBJHCIq/OXf3q4jeaDMQT5Fw9L/I7DyHz57YZhyhzeBG1xn3KOvboLiZRsGsc
 whvEp+tGbaizsvyS2km8h0638bzo4qDoy97pxMYlxzAq3ppEnBn0QCA86tIkT6MBqAPr
 mUMO2Zb1qXQ9FLm5EABwhuKpbxInmSkHWLlItI+pEp10Zb7rFNDUv7Isq/k2ejIw8MOM
 A7DCW73Ds1EjfLbLMSLtLqXmMWcPLgYgdVYdtkLmXFo7M070WFStldAduk59ESxRG4vS
 2rnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776885664; x=1777490464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lTmzBrjr7Z+9LG3YOTWzEcHyH0AEGS90m8YNAo038JI=;
 b=MJ8GzqvY3wO3DktsSEU0oRGHmXcwMZqhr5j35i9cnPFNFnbLL215m1Fc3vDMOOleM9
 FemAXg1UzMD8GkAmwdbdZ4FDGnwqwbzsh9J9Y6SDruGZRNAFLMEqXGF2+NexBoXtViYG
 oqiFrH8JF4Csm1IhUtWF8izIeQunPq+j5+8qYwKtnFn4sPf3JK7JKzyJpFud8nqS5D/w
 l1h1dZOiB57rrNOiPv+m2Ua7qYf3wHHAB3zzRJ8fD4vbYfKVtdOiDjyxVp48qBWmSB4s
 LUhZJW+kTEEKACU8VuoJTuOojKWoAxVD7CVXNe8ozD0ISdEAzY/BrkNIdFOZOjT8RghA
 v9Dg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/563VDxN4BBaj8rD5CBMNMtPBjMjPzSTVWH6PsPnkXyTpOUeKAprNtiyTe/Dn5ZcLuXWWgYGK/ImYb@nongnu.org
X-Gm-Message-State: AOJu0YzFixlCQST7LqlVsho9kLaznbN7C+Huvo/WG0WDVJCScgnmWSSi
 MTuyowSGpyp7aR7xyilGTAz4wncfxhFGKsoWFk2Bwog45kulmK0s93tleiSlF3WMYMcSi3zE2Nq
 ANWVQiPwKR0mOivuudu1mnkehy+pFXVhxFOYo6l/g
X-Gm-Gg: AeBDievn45TPvuBU4BrOyyu+0IeOd05zYfDVjK31X8BDuFvt47YFDuVmsl9HIEatUFv
 usc9Bli3vFuPwPXTB6WazRVl8HhpqbWsRxLr2c9WAF9QM9yXAIBBoA26iVwSUpzcpihClEI4uz8
 RP1IvTAnl++BrNggX/LPf8qZTlr4dMvK0hz0mswqxo/AZjipxdD9IG/xleXRjMHz7cuKgTof445
 XPZ1h7hLsYgnVTnGS7ath4eQwVsOZM7CW9ChBHePR5flx5nxBRdRGUzHLNg8JMW9sAvDUZSE9Jr
 rBCSvDnGRB9k0Mn8guIyxhhQGWroGARSDhy4pwDVea94W6lpEy7pgoAvP8E=
X-Received: by 2002:ac8:5c84:0:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-50e440d269dmr46307001cf.3.1776885663618; Wed, 22 Apr 2026
 12:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <20260421211237.GC466778@fedora>
 <CAJi--PP6gsR5E7RtQ_RwV8fG9Xivk0fXTfNxWuZ6cX+uWBPV=A@mail.gmail.com>
 <CAGxU2F7UJhbikjFKMgMcFenFx35vmic-hj4pFm7vM0-gk-nCyg@mail.gmail.com>
In-Reply-To: <CAGxU2F7UJhbikjFKMgMcFenFx35vmic-hj4pFm7vM0-gk-nCyg@mail.gmail.com>
From: Jorge Moreira <jemoreira@google.com>
Date: Wed, 22 Apr 2026 12:20:52 -0700
X-Gm-Features: AQROBzBMONdFrbBlWXUd1zJQopaR7EyCF4WM346kgBeKuDcT1wsEGfv4VIcetAQ
Message-ID: <CAJi--PNoJmei-076Y5geaft98w-nB3OFK2e093EWkN+ZTaQK1Q@mail.gmail.com>
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, hreitz@redhat.com,
 gmaglione@redhat.com, 
 "Michael S . Tsirkin" <mst@redhat.com>, Hanna Czenczek <xanclic@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=jemoreira@google.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Apr 22, 2026 at 1:32=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, 22 Apr 2026 at 03:16, Jorge Moreira <jemoreira@google.com> wrote:
> >
> > On Tue, Apr 21, 2026 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >
> > > On Mon, Apr 20, 2026 at 05:48:13PM -0700, Jorge Moreira wrote:
> > > > While starting the vrings on SET_VRING_KICK could solve the state
> > > > machine issue, it still won't notify the back-end that buffers are
> > > > ready (the driver won't do this). Non-polling back-ends depend on t=
his
> > > > kick, especially for queues where data flows only from the driver t=
o
> > > > the back-end. Most implementations likely attempt to read from the
> > > > queue only after receiving the kick.
> > >
> > > This is an interesting question to clarify in the spec.
>
> Yep, which is in part related to what I wrote in the other reply:
> "I think the main issue to clarify is what the device should do
> when the vrings are configured, but the driver has already been
> initialized (which is usually the case after migration)."
>
> > >
> > > Stefan
> >
> > This is the question that interests me most, to be honest. I'd rather
> > have the discussion about when to activate the vrings in a different
> > thread and keep this one focused on whether the front-end should send
> > the kick or if the back-end is expected to check if there are "new"
> > buffers in the vring after restore.
> >
>
> IMO we don't need anything from the VMM. When the device receives
> SET_VRING_KICK, it can check if the vring already contains buffers
> (and this is the part we might need to clarify) and wake-up the other
> threads (or always wake-ups them, as crosvm does IIUC, and let them
> perform this check).
> After sending the SET_VRING_KICK message to the device, the VMM has
> the exact same knowledge of the vring state as the device, therefore,
> it's still unclear to me why we need to inject that kick.
>
> Stefano
>

Is it possible to activate a vring after it has been deactivated with
VHOST_USER_GET_VRING_BASE? If yes, does the front-end need to send the
kick file descriptor again with VHOST_USER_SET_VRING_KICK to
reactivate it?

