Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D67F99344
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFp1U-0005iP-3X; Thu, 23 Apr 2026 04:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wFp1D-0005eL-M3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 04:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wFp1B-0005oY-E0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 04:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776931354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsWDxmR6XqjVrFB53NH7U8cNq+72c8riXv3g8z5SYkU=;
 b=iPrsYCrKekQSlxm+DtZPbejCl30cXFEpZO0mop0vvXonZI6YPOWIWtekhjy/9WemmnlQVA
 Z2GRatXFDuu6huAvZC9DbfyOMOX+JIwaOQwCEtRgtn5fbtGywEy9Xn+2nF/L0u54AV48lX
 QqVCruml4EkJT/8Zvb6KcCbIPNKMuOk=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-SOW9rpLtOkKlaxCa_wJ7xg-1; Thu, 23 Apr 2026 04:02:32 -0400
X-MC-Unique: SOW9rpLtOkKlaxCa_wJ7xg-1
X-Mimecast-MFC-AGG-ID: SOW9rpLtOkKlaxCa_wJ7xg_1776931352
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9539bc7e2d0so10397731241.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 01:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776931351; cv=none;
 d=google.com; s=arc-20240605;
 b=F4HhlNDOUkWorIiqpORTswh5s8EFbpIq5Hy8a23HPjr8zk8mHMCEXre2oxwCUnX1qd
 o/KfVZs82xCCVU7oX6iSsufP3WxPqkE1z3bc5f90HBZcF0EiXeQNk97ze8Rl6/jIlmAQ
 CLc9vHtR/3qD5YuvpOxGSeG06gj+rPofyMqXq6+NsBDcCz5gknPxswWZ+t9z6Ma76TvI
 hGrFoZ5qY3Z2Fw0xzvkuhTkUDyJRZMcbsOOhoWsFCzCTNnkCsFeyGLxGQwkqy/et+Tv6
 rGprist391OPL+tCCdRlyNrmKUUdr808NuAKOkT5iDpg1ZMtlqi+rHBkSze7PS5bcptq
 t2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WsWDxmR6XqjVrFB53NH7U8cNq+72c8riXv3g8z5SYkU=;
 fh=8aBEJY+feA7d7ThUvpzyIH9FOGeOtT6IdrliqPJEqPM=;
 b=EnDS4GJjVN7Ku0VlIGBDSwioPmm6qe4Rww/BgihAYrVZKgLAkVek5+JOh/UzHyM8PP
 H91MhZHOEZ+GxoDC47jNxpa6rK3BkG4hH4ajUbiX4MrfVdZTG6yoaF9Z2p1p3IyHLrz2
 zl87u2B6ebSMgF60HB0aTc25O0LTtKoJWn8Q+ZCcxa7GMiHLi5/NTcPQA4913/7+MX5n
 xGzkNPDUbISIEJSaefAaTxAIZMyGDvz68P2UYwlHO6/f3HrW2L8wB/DG/M8vO6melqpm
 uZxX5PPXYUJQkaRH+mC7sXqx2bkjJkAESksO/ErgFwHokt3JxIlugbpo39UpSnnlV9wy
 5H5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776931351; x=1777536151; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WsWDxmR6XqjVrFB53NH7U8cNq+72c8riXv3g8z5SYkU=;
 b=szMPN/j0ZF1Os/lgUoi0MAmYV+ZsnzbKN54rQRBw+zKvTETC7wg+B8yX0t1G8VFIGp
 LndTjBCrZhTlUAG76OEHas9QY7rpTdiejP3ttG5g/KuqblkfF0zOH3R4BdJbUt+7mJbo
 wpZWYXn3A6gP9fE4wm1q4ycIv2lZXmQhsQJnx6R5TGUlTK5C2rNKTg4kuu3SPIy0VHpt
 qnQcBw3uekROmdc/CHWE/kfPCgVw1ZGZREXw0zEZ+0n6a9qgaTXWTXGv6mGrxL9faZOu
 WUdXdDJQ4Ff6Vp+iO6HU5PdR1UdD9+Y5ol1lnjj8HURessbUosbuVPCOe3/rxVQ83j+n
 Nm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776931351; x=1777536151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WsWDxmR6XqjVrFB53NH7U8cNq+72c8riXv3g8z5SYkU=;
 b=cyvpaih3+UDTB/iSFCLNBchyyFmvzKsR3nbpKorVgKgXABnFITaPtnMEz0VirUnE6j
 OSNfG0g4wuqHlDmC3Mw4F3Sgn1yCGdgzlJVKUZrVuGXcbLsgeCg9DbDFgjnA8X6qp93f
 WBy3CGpNKlVXcyzvc0mNLUy3yNED/rEi9QHcdoNNbpBpIN9J9eXy6M1YXlA3pOPYWy5p
 4D09e9ujw0GNSqdrT2XDRRFkfNcFCIEhvW3C0pOGHAiyeRav2C3GfGvFoTwUILV2cMUu
 xXUSMW2yYVX9GQ9JZe/3MOsJoIbvqnSrzaz+k4QufgKcAM5yWRI0gOIVzX9ofmUVIBL4
 ko5Q==
X-Gm-Message-State: AOJu0YxgWr78hzJUb23FYrLfnJJF0rj2hCZNuCg0Q5rAKLZIAvnxVMaB
 QZa/LS9MGQtnSlxXYUZzcy0u46mWl652HoEB7whwXKkyE6FkRUJEnf+fz2h0igb7BOPJ1a82yuh
 lHMSHOFHmfU6bT7ic9BYsysWMo0vmgBAdf+DCPGggu1o+eft6i0Ha+RKoQNaFYXnksCxmKe9oli
 LfNuYMpbm3xt1NQuH+5Av8fQ0O/9qZC6CAVkuFNq8=
X-Gm-Gg: AeBDietpWS6SMaYakGDXNFJZAmtQBexSFGksZsJuofBgzBaCZmJy3AouuIko2iMT2N3
 q2FaXxeo03NM4Bsh5VphM3e9FMlU8vyreA5PI7OAuYFKA6h64YiOTiw38VOZkrrUnnrtw4ED26a
 WsUBSJ5fcbsFQRltQ1kmyR6AQh7ifoxbgBzG6qJvwjuZPXzk65Voq3CKzL+vZKhhaiEWP1Yv3KT
 Fq+kpg/DIEkg5UgBYk+zaVICnFJCesw74s1mUPVWSox6EQatVZQC6kKXG+n5YuNHhkbmYqH9YQc
 QUnX2XW8oX6ArvLk3JQvScDZaEgDNh+nu6M=
X-Received: by 2002:a05:6102:5114:b0:608:ce6d:4db1 with SMTP id
 ada2fe7eead31-616fb5837a1mr8464912137.3.1776931351306; 
 Thu, 23 Apr 2026 01:02:31 -0700 (PDT)
X-Received: by 2002:a05:6102:5114:b0:608:ce6d:4db1 with SMTP id
 ada2fe7eead31-616fb5837a1mr8464907137.3.1776931350835; Thu, 23 Apr 2026
 01:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260422202646.272081-1-marcandre.lureau@redhat.com>
 <87v7dis20c.fsf@pond.sub.org>
 <CAMxuvaxCkJ7PeMxOXqDXPvWRdTst93ufwEOA8hqd40XKVCWGJA@mail.gmail.com>
 <87y0ieqhzz.fsf@pond.sub.org>
In-Reply-To: <87y0ieqhzz.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 23 Apr 2026 12:02:16 +0400
X-Gm-Features: AQROBzDBwgWSA3nAYfL4J_iSF7p861XeGR6qFZkET-yFgskH-uKEBWPPkqMxRmE
Message-ID: <CAMxuvaxryBmJ4+VL5qNv2pP3t9KoKS-jH45nY1hzvoxz-rCHXg@mail.gmail.com>
Subject: Re: [PATCH] ui/console: remove console from global list on
 finalization
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi

On Thu, Apr 23, 2026 at 10:59=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi
> >
> > On Thu, Apr 23, 2026 at 9:02=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> marcandre.lureau@redhat.com writes:
> >>
> >> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> >
> >> > This commit removes the QemuConsole from the global "consoles" list =
when
> >> > it is finalized.
> >> >
> >> > Previously, there was a TODO comment indicating this path needed
> >> > checking. The assertions added ensure that `dcls`, `gl_block`, and t=
he
> >> > `dump_queue` are empty before removal, confirming the console is in =
a
> >> > clean state.
> >> >
> >> > Fix potential use-after-free crashes when a display console is remov=
ed.
> >> >
> >> > Reported-by: Markus Armbruster <armbru@redhat.com>
> >> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> > ---
> >> >  ui/console.c | 5 ++++-
> >> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/ui/console.c b/ui/console.c
> >> > index f445db11389..b64e2122f34 100644
> >> > --- a/ui/console.c
> >> > +++ b/ui/console.c
> >> > @@ -394,10 +394,13 @@ qemu_console_finalize(Object *obj)
> >> >  {
> >> >      QemuConsole *c =3D QEMU_CONSOLE(obj);
> >> >
> >> > -    /* TODO: check this code path, and unregister from consoles */
> >> > +    assert(c->dcls =3D=3D 0);
> >> > +    assert(c->gl_block =3D=3D 0);
> >> > +    assert(qemu_co_queue_empty(&c->dump_queue));
> >>
> >> Help me out: what ensures this?
> >
> > - No display change listener left
> > - No GL lock left
> > - No pending screendump
>
> Yes, but what ensures none of these are left / pending by the time we
> finalize?

Unfortunately, we don't have much support for unplugging display
consoles. So those asserts are mostly there to remind us of further
issues.. I should probably leave the TODO.

In general graphics devices do not support hot-plugging. It looks like
we are missing a couple of hotpluggable =3D false in hw/display. So, it
should not be reachable today but by using low-level QMP/QOM like in
this test.

Text console/VC is also poorly supported and leaks, so it will never
reach qemu_console_finalize() either.

I can try to improve the situation by sending a more complete series,
so those assert() are unlikely to be reachable in the future.


>
> >> >      g_clear_pointer(&c->surface, qemu_free_displaysurface);
> >> >      g_clear_pointer(&c->gl_unblock_timer, timer_free);
> >> >      g_clear_pointer(&c->ui_timer, timer_free);
> >> > +    QTAILQ_REMOVE(&consoles, c, next);
> >>
> >> Is @consoles only accessed from the main thread?
> >
> > Yes, the UI code is main thread only.
>
> Good, thanks!
>


