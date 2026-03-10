Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D84BF3C27D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vztjQ-0000mQ-Nv; Tue, 10 Mar 2026 05:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vztjK-0000lX-Pi
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:50:24 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vztjI-0001px-Ts
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:50:22 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-661b16ac011so6332474a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 02:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773136219; cv=none;
 d=google.com; s=arc-20240605;
 b=gQm5Uil58i3dRQpTD9sfQZCxWdzXuRvaG4QmCDXPtovvGjyV1K2aWk9lcc4316XlvQ
 7gYmbM+vmaZo3Q0bi7hUOYPvufChQkcb4f5snrs4CEPSzGHdCa9PtiNBSaATxX4iUfh3
 olAezNo75B3YHyQRgEsia0seNi+39otTXSrzpU6Yif/jJkbMctNFCppT6DNSlt88Cbll
 djX9Xyj4lbsWkc5HZfRJokAfz1hqN/+a8UwzzWD9fCUPsW383ezSCbqE7ikm+iZT7/fw
 M1NOpFITrTxbw+3mLjthex6W/nIOBKdz7wW5M1MSvy4ZorVeGSwkoVDYCVzw/P3LG1DV
 P4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BAsVF2XzAaxJVvKHHH5r0ZnlGx8AEryu0ptCLjyan1w=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=dedbVOuMiQXw3QOvmBnz9dHahmWS7naowUmSe4EIpJ290YWciNKNsANcYbKaaFM93s
 wY45eLtpgiRTog2RQvAchHOJbX3O7O6VVSqI0sZeNJ5uXJgAbzNDQgvDmIWAeVWTTqwa
 dwXUUfOIPwP93+gbLn4xDrY7J6yfZIPEn2Ian8/o5cKkTw4skn9Zy5qfgRIiBkgjQrdC
 9NvmnJeBjcn6nBp5xkIQjvhqk5+Z/pNodJkqjo9Ccp3HbqYe3hSiml1vBKBibmQujurz
 bac2c6P80c+Wh/QiJR1v2cegn/ZZGy+Xz2F/bn/VO9oWzYyIA2uWoxfQWo9COVp2gU8Y
 HAaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773136219; x=1773741019; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAsVF2XzAaxJVvKHHH5r0ZnlGx8AEryu0ptCLjyan1w=;
 b=E528cVk5LScED7d3hRED1igw+dHejoe/wzcXDNUKoW78YDJrLbfIMb44uFbGe7gsa6
 mbgqEi7r6iiKAEj+0FDTm+SyIoI5sgfADtkUJbQRLl5YCFiSeK7Lu3XQnfntFisyy8bJ
 j7mr3Sy25DRrIk0YGpjRrOwdjuQSptigNiOqHBEvWtzaQd+SgDWg0ZlexV8YCANiujSW
 TKiqqUIorbxGXwVPzsdVRgVbwlv9YkUy/cFW2RIHeuKulAcUHbpuctGtKk53yHv7xHdU
 AQQyRlWW+0+QJ2ROi6mLNiZWU+cV85MD78U4GxpJzEGHpPztqOtfMr4fKRrnUOPLzRo6
 MGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773136219; x=1773741019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BAsVF2XzAaxJVvKHHH5r0ZnlGx8AEryu0ptCLjyan1w=;
 b=jKggH74Ku9IU5ZUNlrEFrXfAFQo7HvuRLgPL6j129O2HqeGCeLUAdbRgAYNUR2RaoL
 IGlzsmmzNrz2P5Iy1lII1M6XDkyYqHiejKmZa94JSPZi9Nhn4QSYsdDLgQRdLBD0XcVG
 dCKc3Lrczew9+dABX8OIKETMLKrLHP1YGZYtQEuhDnG3SGxHUnLENUBFx814PvwtAA11
 dfIUareZGf9G0YL5+a2tcVdZ8JDOc1kX3ZnkM2j1tzq1Qd6hWYRcNkFwT/kI8kiyejcH
 7HL8mAuw+fWdmK8xjXWw1p89OvZ2wSmpWXMaxSZNbe021XL5lHCkdIJRyEdKzHvfCGnL
 XF/w==
X-Gm-Message-State: AOJu0YyZuXmM8+pf7y7vDqv9HoKulal263N7B59CxayJzFOgPFaRov3E
 KmKv5gP5cWsVZCrtSd/2e2OtCUvYq3BUPCitKwhqAMo2AWBCns110uFe+A7xwHK8N+NsbKMloi4
 ZYxNaKk5xIZAD91Da+3qn3helyjm4pDk=
X-Gm-Gg: ATEYQzz4lWfa6jZtK/jbkPN8GLlpEdd7yaCs8G0DRumRghlhkXyPuotuTM01N9SbbjM
 6hYFGzkQ4eU4DHx7vlBUUWi26yz6No8H7JQ5H8eH+PUeE9slqwjPwM6yGph74inXy+Lcg8fqoQ+
 zAgazX4WxEAmbqm8v00YTyB9UYaGs0Fplqo10vgTY9yUqY1GK/Vf4lE6WWW1HS02jzRq1YWCbS3
 KXoZZODV4pNf1m0eZUEd3UVdD/fvtJb+6QVDSQcZICdr2zIyTO/Cl5oMNy2+1aGkUhjhFE+fWcR
 X6b6D5A=
X-Received: by 2002:a05:6402:40d6:b0:662:ac65:19e7 with SMTP id
 4fb4d7f45d1cf-662ac651d8cmr2067864a12.10.1773136219131; Tue, 10 Mar 2026
 02:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-4-zhangckid@gmail.com>
 <20260309080201.GB39949@fedora>
In-Reply-To: <20260309080201.GB39949@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 10 Mar 2026 17:49:42 +0800
X-Gm-Features: AaiRm51OfMAitWGEFtsiG34znSa9alZMd0C_R-lbV8IhDle4Sc_yAuEfK3-rYjM
Message-ID: <CAK3tnvKypf4EvQaiswr3YfRVbbxHKNOGpFGdRAr5pG==py6-2A@mail.gmail.com>
Subject: Re: [PATCH V5 03/13] iothread: tracking iothread users with holder
 name
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52a.google.com
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

On Mon, Mar 9, 2026 at 4:02=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Thu, Mar 05, 2026 at 10:24:49PM +0800, Zhang Chen wrote:
> > Introduce iothread_get_aio_context() with a 'holder' argument and its
> > counterpart iothread_put_aio_context().
> >
> > Previously, users of an IOThread's AioContext did not explicitly
> > record their identity, making it difficult to debug which devices or
> > subsystems were pinning an IOThread.
> >
> > This patch enhances the reference counting mechanism by:
> > 1. Automatically incrementing the object reference count when a context
> >    is retrieved.
> > 2. Tracking holders by name using iothread_ref() and iothread_unref().
> >
> > In iothread_instance_finalize(), we now retrieve the source name from
> > the GMainContext to correctly unref the initial internal holder.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  include/system/iothread.h |  3 ++-
> >  iothread.c                | 28 ++++++++++++++++++++++++++--
> >  2 files changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index 21a76bd70d..595abeefbe 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -47,7 +47,8 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
> >
> >  char *iothread_get_id(IOThread *iothread);
> >  IOThread *iothread_by_id(const char *id);
> > -AioContext *iothread_get_aio_context(IOThread *iothread);
> > +AioContext *iothread_get_aio_context(IOThread *iothread, const char *h=
older);
> > +void iothread_put_aio_context(IOThread *iothread, const char *holder);
> >  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> >
> >  /*
> > diff --git a/iothread.c b/iothread.c
> > index 80a8cf4b32..da98fbb9ad 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -172,7 +172,8 @@ static void iothread_init_gcontext(IOThread *iothre=
ad, const char *thread_name)
> >      g_autofree char *name =3D g_strdup_printf("%s aio-context", thread=
_name);
> >
> >      iothread->worker_context =3D g_main_context_new();
> > -    source =3D aio_get_g_source(iothread_get_aio_context(iothread));
> > +    /* No need setup itself as the init holder */
> > +    source =3D aio_get_g_source(iothread_get_aio_context(iothread, NUL=
L));
>
> This is cleaner:
>
>   source =3D aio_get_g_source(iothread->ctx);
>
> That way iothread_get_aio_context() doesn't need a special case for
> NULL.

OK for here. But according to the following patch we try to use the
NULL to handle
problems that cannot be easily solved using ref/unref or get/put.
For example the patch 7 and 9.  We can discuss the details in that mail thr=
eads.

>
> >      g_source_set_name(source, name);
> >      g_source_attach(source, iothread->worker_context);
> >      g_source_unref(source);
> > @@ -362,11 +363,34 @@ char *iothread_get_id(IOThread *iothread)
> >      return g_strdup(object_get_canonical_path_component(OBJECT(iothrea=
d)));
> >  }
> >
> > -AioContext *iothread_get_aio_context(IOThread *iothread)
> > +AioContext *iothread_get_aio_context(IOThread *iothread, const char *h=
older)
> >  {
> > +    /*
> > +     * In some cases, iothread user need the ctx to clearup other reso=
urce.
> > +     * When holder is empty, back to the legacy way.
> > +     */
> > +    if (holder) {
> > +        /*
> > +         * This guarantees that the IOThread and its AioContext remain=
 alive
> > +         * as long as there is a holder.
> > +         */
> > +        object_ref(OBJECT(iothread));
>
> Can this be done in iothread_ref()/iothread_unref()? That would ensure
> that callers always increment the QOM reference count regardless of
> whether the iothread_ref() or iothread_get_aio_context() API is used.

Sure, will move it into iothread_ref()/iothread_unref().

Thanks

Chen

>
> > +
> > +        /* Add holder device path to the list */
> > +        iothread_ref(iothread, holder);
> > +    }
> > +
> >      return iothread->ctx;
> >  }
> >
> > +void iothread_put_aio_context(IOThread *iothread, const char *holder)
> > +{
> > +    object_unref(OBJECT(iothread));
> > +
> > +    /* Delete holder device path from the list */
> > +    iothread_unref(iothread, holder);
> > +}
> > +
> >  static int query_one_iothread(Object *object, void *opaque)
> >  {
> >      IOThreadInfoList ***tail =3D opaque;
> > --
> > 2.49.0
> >

