Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D711EFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHNbt-0005Mh-Gm; Mon, 27 Apr 2026 11:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wHNbs-0005M8-Nl
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:10:56 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wHNbr-0003Ny-4F
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:10:56 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67790429f71so3745287a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 08:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777302652; cv=none;
 d=google.com; s=arc-20240605;
 b=ROYBvNB7VuBFlTm2YGXV+0u6pXOh5IZ7RM1f1aYmH/ITO0c3QSalDpLuC1TZlzhtXN
 pUPCPu9SrwGr1ViUMfmwFLtwj6mwl4//pNk1DUh4oMiBqH+acamsGZwNN2RXlcrmDF0D
 hA/ShhVoGWsI6O+T+DtBiMpdhUfdMvfFo9zUsxKr3Trpj8NJefwkD8PixaWFfbNv16PS
 DOKeGwZIBxb0JAraroWk5hgRFIq1AkC69EQwitRRR+UCWX48JPP2ZBOLigePkOOJyTgQ
 N9JiPuOz8jUzC4DuaSzJ7r6WOq4N4A6yu3hJl8GdiFyFwQgjz3ts7JjY+ipEeo2GHDTg
 zzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RSvxK73chVdaSTFJP4M0SC3nfpSEZdj9QlEG04yRFgc=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=eyg89bhbkE+YSCiHsg1VI1IFua72qbLFLqfoD7va00c4U3z3vJxOzZZgeoUUCJ4eMi
 12o91C9mPfwv7bbIr7U0thuyE2u+chFv7G3CvIl/h4P69gRhSLF7gu8AVqXFJ0g+Gas/
 JrqmmVqMxAShWaskU+s6txKo8zC7EhY3BuieE0wOHuoXncmL01sqiI1nuwOgpfCWAhx3
 Q1R6nj9e2rcPMYyfRW1DkOLiDfSI4xc+yDVsCIszi5vhzBwMUKPkD2ZxdlrPM91VZPjK
 E14iusqZJyZDB4C1Vs0CwNI/Kj2UIz43FvEQo8pnjubNzK4fM+NjFCRQMYhYT5CHUW34
 dmSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777302652; x=1777907452; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSvxK73chVdaSTFJP4M0SC3nfpSEZdj9QlEG04yRFgc=;
 b=Uhv2c8TTg41Q9fT9JnpGBEYN14FNP5ysrGd6kycBTyDT63nfoCHJ3Y1sBX+aLLKtWV
 XgRJVaXxlWq0LQvQpvzEwGqMIwV2ecH8K/PbDJp7c5b3xA80ppxr7nEUGLEBFtno+g16
 Y0c+cNpSh2zlBWDbSGjaa5VS/FqYv1ycFHFnTroC7O/X1BAGNNJ4RU9GOna/gc+UnEZN
 lzWxqZ790eX4xkcv+3PsYQwYCf2Fhhpt34wNhLl4bqy6F+XlGPBXk7gD+RxApmYoloMQ
 ebXkugjZvCJv8wzOMkEhksLsj4sirsK7bXXjwxbOsKyfVw5JVn4G3IAv9z5bk1bWlauR
 on/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777302652; x=1777907452;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RSvxK73chVdaSTFJP4M0SC3nfpSEZdj9QlEG04yRFgc=;
 b=Zq8tLKN5h+89cwlF223VQeFnPFxbZx8OmlZWkBBbymaR3eIrAwnx/Pz8ZnsjIUsOXn
 f2j548mpcDFP0QVS7zvgqSrTEOuSOYYdncE1bxUI7dnC0LkmBG8J6jSbaBQMQSncMtQ/
 oicgUvwtOsUoPN5Hrb2fsNTf2pHfMcIFbMKzAJjcSoi6sZqCCdXJfXhNm26pPKME59YX
 y4ucPyw2ota8zjHSz/wyG671/W4duJ+tdAXSHMEDcHG3bKL0kqKIEOLlAg0rhj6juqlx
 wO0n8B6DneQuSW/tlGeihjIDq9euk+poiMrcKOQpkMLqBhK8tHwIJFOoX/XeFCvGfDXD
 rYpQ==
X-Gm-Message-State: AOJu0YzmNHAVxbe8OLJKte2qIcwED6rf6eGXMdrtkZ397yU5BZNzvwJt
 SbM+s3pTE+Meq5C7f74xQmpNLBTBZ55nLTHUPPdh7GoUmqfU6k9QADa/luroaQwB7FWuCKKex0H
 KLd7v0/auCTDWVk1DvhFGLtTLyysxzBA=
X-Gm-Gg: AeBDietDh2e2DNsvb/Rl8p1bbkGIDJJm0po292TT6RIos7OOAKv+Osfd5QNzUQ6/qgE
 xy0zAR+bwRxzyb4gFGeJ8Aldccy4qZ+S4wCcWiGFLj8LveuRb1mudmIiT8jCl+n7hxrmRKo1GGS
 3j2c221TYvW84rRaUCqkFjTG0bSAYHO5QpgULIGOsRo2vbNg76EPE2J89nsRLhxiTw+51vV5hf3
 Vqnx5RV733EttWaaQ1mL4TavB2WLft5EZtJgCnGELTiP11xjaNGW54IKpNXDScwI9LGfEpxzrX/
 ekeZEXcRQm7SopVjC8E=
X-Received: by 2002:a17:907:9307:b0:bae:6e71:dc27 with SMTP id
 a640c23a62f3a-bae6e71de27mr599511766b.17.1777302652081; Mon, 27 Apr 2026
 08:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260410150457.85190-1-zhangckid@gmail.com>
 <20260410150457.85190-14-zhangckid@gmail.com>
 <87340lomam.fsf@pond.sub.org>
In-Reply-To: <87340lomam.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 27 Apr 2026 23:10:12 +0800
X-Gm-Features: AVHnY4KmknWZaWIuTjtZCUMY1dTBlvaNzi9oIcbqXZdiNtskJ_ATGF27lx9YSjU
Message-ID: <CAK3tnvJuj75aJXWCbP1g3dTQut3daJ0y=SMf6dRnZjvEm8NiWQ@mail.gmail.com>
Subject: Re: [PATCH V6 13/14] qapi: examine IOThread attachment status via
 query-iothreads
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Apr 23, 2026 at 9:10=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Extend the 'IOThreadInfo' structure to include attachment metrics.
> > This allows users to monitor the associated devices by identify them
> > by their QOM paths.
> >
> > New fields added to IOThreadInfo:
> > - @holders: IoThreadHolder(QOM path or block node name) of the devices
> >             currently associated with this iothread.
>
> See "I'm confused" below.
>
> >
> > These fields are also exposed via the Human Monitor Interface (HMP)
> > command 'info iothreads' to assist with manual debugging and
> > performance tuning.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>
> [...]
>
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index d65d8012b2..e173d54a5e 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -94,7 +94,8 @@
> >  # @IoThreadHolderKind:
> >  #
> >  # @block-node: Block node name.
> > -# @qom-object: Standard QOM path.
> > +#
> > +# @qom-object: QOM path.
> >  #
> >  # Since: 11.0
> >  ##
>
> Squash this into PATCH 02, please.

OK.

>
> > @@ -104,7 +105,7 @@
> >  ##
> >  # @IoThreadHolder:
> >  #
> > -# @type: Current IoThread holder type support QOM path and Block node.
> > +# @type: Current IoThread holder type support QOM path and block node.
>
> This, too.
>
> >  #
> >  # Since: 11.0
> >  ##
> > @@ -124,6 +125,13 @@
> >  #
> >  # @thread-id: ID of the underlying host thread
> >  #
> > +# @holders: IoThreadHolder(QOM path or block node name) of the devices
>
> Space before (

OK.

>
> > +#     currently associated with this iothread.  Users can pre-allocate
>
> I'm confused.  What is holding what?
>
> A QOM object / block node / monitor holding an I/O thread?

Yes, this series tried to manage the IOthread lifecycle.
So we need to know who is using any of the IOthread, step by step:
1. Create an iothread.
2. Attach the iothread to a QOM object/ block node/ monitor(iothread_ref())=
.
3. Detach the iothread from a QOM object/ block node/ monitor(iothread_unre=
f()).

Thanks
Chen

>
> > +#     multiple iothread objects to serve as a persistent thread pool.
> > +#     When a device is hot-unplugged, it is detached from its
> > +#     iothread, but the iothread remains available, allowing future
> > +#     hot-plugged devices to attach to it.
> > +#
> >  # @poll-max-ns: maximum polling time in ns, 0 means polling is
> >  #     disabled (since 2.9)
> >  #
> > @@ -141,6 +149,7 @@
> >  { 'struct': 'IOThreadInfo',
> >    'data': {'id': 'str',
> >             'thread-id': 'int',
> > +           'holders': ['IoThreadHolder'],
> >             'poll-max-ns': 'int',
> >             'poll-grow': 'int',
> >             'poll-shrink': 'int',
> > @@ -166,6 +175,8 @@
> >  #              {
> >  #                 "id":"iothread0",
> >  #                 "thread-id":3134,
> > +#                 "holders":["/machine/peripheral/blk1/virtio-backend"=
,
> > +#                            "/machine/peripheral/blk0/virtio-backend"=
],
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
> > @@ -174,6 +185,7 @@
> >  #              {
> >  #                 "id":"iothread1",
> >  #                 "thread-id":3135,
> > +#                 "holders":["/machine/peripheral/blk2/virtio-backend"=
],
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
>

