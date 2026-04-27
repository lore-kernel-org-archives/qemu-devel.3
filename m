Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C6AFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH5n-0006BX-GD; Mon, 27 Apr 2026 04:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHH5l-0006BE-QY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:13:21 -0400
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHH5j-0003zX-Ag
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:13:21 -0400
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso13363641eec.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777277597; cv=none;
 d=google.com; s=arc-20240605;
 b=c8qQdNIko/L636aOhpcnmnDKVHvnTVKSBObz1WGE6L7xNortjlAVguJcwdWAzgxPF6
 AjOQ6ib//xM80lc26C/LbnESvzi5MyskqwJFEM08pcVcZX6sMXKL1+2i4nzMyiBoNnjU
 eTwU0T7w2LdQEbPhfE19FndSAYLVL0/GEmWrgUjkIsQHThZi2Xgag901V2sxXAYVj7fp
 05WnCqyCwdVftXGkYQI+yLt1GxbX7/yAzyGTYbV85KvehVydRd5I22IVdyvZzguWaPI+
 3RIEiTDjf76HCgAlsYfuX8L94h8PrlDPbcE8sD3iUB2JeZlugj1PvuZWGPGwHsu3GaEc
 HrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aaVO7J9u9pu7A9MvL+UM6uqGcKIh9RcTwxfrMiOy3SM=;
 fh=8aBEJY+feA7d7ThUvpzyIH9FOGeOtT6IdrliqPJEqPM=;
 b=ef+lXbTb/7xeWCmltrUDOXZ6vN0lKYLgR16Woyu7+3z5qqztcwYAp72WXUJRprf3Sl
 NDY+la0YPoNLmwps2kGKXyj1mJN9mVGhjY6OsuO1sRCHmVxT79Owybon+fgaAOrruoZ7
 ff0X1lcjzAltFlLPjWS1a7QvYoiWAKw6Cb6AHQ7lqVyzSLvcK7CGzCjmNuPV2Ltnkpk3
 X9eHxw9v//Sp2U/BqjK3Y0bDdj/GuhjjSLyeMhsuzFSuSQnm6+pGYKORQ1dEgJekbmWq
 dNlcm5VDRipRkl5sDgM8qoodRERoZ0OceSMHoZt78pdLKAUobj3BBp3UcvbCnWpZnZDS
 zAAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777277597; x=1777882397; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaVO7J9u9pu7A9MvL+UM6uqGcKIh9RcTwxfrMiOy3SM=;
 b=Frw9xgj3RiGbwkkdRNj+LpKBnWJAuPnU5GTSDghkwHg0ngy/TzvSi2YH4SKCCtrP68
 /bp52t92s68Oo4wF+57wAF65S4BhpQweKDGAfjDNP4rBjEKwRBMf/XKtS+ZnsccsfnAl
 SyXSAb1U9JMC/CVI9JLqAtgJ+57asGceBBvaF0W6ZVHh7pd+AtyUVt/CGCpahoku26SL
 pEJAr7W6thMPtJyAW/6WCooGTSmDucVxTpMHGMlp/7+vu/KdGatWPr89RQG+frjwvsVw
 HUz/QVqn5dho1ZNxj9l0MUUOQxwC15yftbqbyvo6id/LwUi4CBi2Y41fizmNbPq0XEkm
 sBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277597; x=1777882397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aaVO7J9u9pu7A9MvL+UM6uqGcKIh9RcTwxfrMiOy3SM=;
 b=cHWm8w0QryxItoN2QuojZD8Ulb4KUBIKLIxqyT37xAiyLu7f2a2kgpxQu6AEC3zhhI
 fEnIoCviOmq7bA+Xj7hwi0SvEaIhRCfS1pwhEr5x8eGuWkErk0VCcexLzFfm29XEhu02
 BEX/YrwsPlJCZjMalDbFzldxVvn18RdExABFi/GBxjb81lP3jB3gxb3G3GX35iDIrPHW
 pKtPXGdVs05Iz3YTScDULynAO3/HFvhOpHIkaOHDEHgNjH8iK34y1gvSxb482cufYpaF
 UjFpN5vahW24eDksVAfhG0DLzT07WZE2VLATgI5KAZ0Ai+qptpQxFNlNlV4jKENvlg0W
 oLaQ==
X-Gm-Message-State: AOJu0YyO3yhbUeiqdP0BGN1SOr1SDOj2a2X+HpSJ0v50g/IUkxR73Fhk
 4Nrd10sY1/heEHxcmJPH0icWNY+Jk6HazDoGTs6aIhp8S63u5f9eJYmpSz3QSzLQePirMSE7b+s
 anlqIDyvhpeXz28TlbRfA0CgjjJeQh9pfDLEC
X-Gm-Gg: AeBDietVvNxctpmUQGuuzc7HqQt/dd13r/vSIUm87n1VTU837XqZjNdNuzetIW12pQW
 3bF1LOlRIIWxRtYs7f63cRhDzFlq1Y5YWHi8EYuozJn+WZhWTCv+Ly5109nG/RGOoBWVjDTQvIN
 woxxPfTDJQXeEawRpJtIM4x6FNce0HlNWNwJOl+OB2Z4T/QAo8so+VQaBLMW4fekn+X957zqTLv
 PLPF3d2ZF5NQmlAClujoDYwG3n6Sa1jAxL5GVuJYIva9nCVv1vbI7IRxFlZgpfsd7SF5DLLci/S
 JDH1N/PLwHEoOCoPxVPHuAt/VpNSlxCD6jvu+hRCb+1L5LdKGXE=
X-Received: by 2002:a05:7301:4591:b0:2d9:6373:ad24 with SMTP id
 5a478bee46e88-2e479214a0emr21787066eec.26.1777277597388; Mon, 27 Apr 2026
 01:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260422202646.272081-1-marcandre.lureau@redhat.com>
 <87v7dis20c.fsf@pond.sub.org>
 <CAMxuvaxCkJ7PeMxOXqDXPvWRdTst93ufwEOA8hqd40XKVCWGJA@mail.gmail.com>
 <87y0ieqhzz.fsf@pond.sub.org>
 <CAMxuvaxryBmJ4+VL5qNv2pP3t9KoKS-jH45nY1hzvoxz-rCHXg@mail.gmail.com>
 <87zf2undu6.fsf@pond.sub.org>
In-Reply-To: <87zf2undu6.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 12:13:04 +0400
X-Gm-Features: AVHnY4KMfoCpy9HysjfhXRBM9rgrg6MgAvA2jFsIaNqNMqwwsIQKwZMbbRD4w_s
Message-ID: <CAJ+F1C+TPQ+LoPAXMaaru8jqGV=Awvu8ifdQC_9gmSaT3UEwJg@mail.gmail.com>
Subject: Re: [PATCH] ui/console: remove console from global list on
 finalization
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Apr 23, 2026 at 2:59=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi
> >
> > On Thu, Apr 23, 2026 at 10:59=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
> >>
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >> > Hi
> >> >
> >> > On Thu, Apr 23, 2026 at 9:02=E2=80=AFAM Markus Armbruster <armbru@re=
dhat.com> wrote:
> >> >>
> >> >> marcandre.lureau@redhat.com writes:
> >> >>
> >> >> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> >> >
> >> >> > This commit removes the QemuConsole from the global "consoles" li=
st when
> >> >> > it is finalized.
> >> >> >
> >> >> > Previously, there was a TODO comment indicating this path needed
> >> >> > checking. The assertions added ensure that `dcls`, `gl_block`, an=
d the
> >> >> > `dump_queue` are empty before removal, confirming the console is =
in a
> >> >> > clean state.
> >> >> >
> >> >> > Fix potential use-after-free crashes when a display console is re=
moved.
> >> >> >
> >> >> > Reported-by: Markus Armbruster <armbru@redhat.com>
> >> >> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m>
> >> >> > ---
> >> >> >  ui/console.c | 5 ++++-
> >> >> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >> >> >
> >> >> > diff --git a/ui/console.c b/ui/console.c
> >> >> > index f445db11389..b64e2122f34 100644
> >> >> > --- a/ui/console.c
> >> >> > +++ b/ui/console.c
> >> >> > @@ -394,10 +394,13 @@ qemu_console_finalize(Object *obj)
> >> >> >  {
> >> >> >      QemuConsole *c =3D QEMU_CONSOLE(obj);
> >> >> >
> >> >> > -    /* TODO: check this code path, and unregister from consoles =
*/
> >> >> > +    assert(c->dcls =3D=3D 0);
> >> >> > +    assert(c->gl_block =3D=3D 0);
> >> >> > +    assert(qemu_co_queue_empty(&c->dump_queue));
> >> >>
> >> >> Help me out: what ensures this?
> >> >
> >> > - No display change listener left
> >> > - No GL lock left
> >> > - No pending screendump
> >>
> >> Yes, but what ensures none of these are left / pending by the time we
> >> finalize?
> >
> > Unfortunately, we don't have much support for unplugging display
> > consoles. So those asserts are mostly there to remind us of further
> > issues.. I should probably leave the TODO.
> >
> > In general graphics devices do not support hot-plugging. It looks like
> > we are missing a couple of hotpluggable =3D false in hw/display.
>
> I trust you'll take care of them.
>
> >                                                                So, it
> > should not be reachable today but by using low-level QMP/QOM like in
> > this test.
>
> Due to QOM's design, introspection must create and destroy a temporary
> object.  This must not have observable side effects.
>
> Devices have a life cycle supporting this:
>
>     instance_init -+-> realize ---> unrealize -+-> instance_finalize.
>                    |                           |
>                    +---------------------------+
>
> We can keep instance_init and instance_finalize free of side effects by
> doing them in realize and unrealize instead.
>
> Non-device objects lack realize / unrealize.  I believe the wheel has
> been reinvented a few times there.
>
> Back to qemu_console_finalize().  I guess the correctness argument goes
> roughly like this:
>
> 1. After initialization, these assertions hold.
>
> 2. Therefore, immediate finalize works.  QOM introspection works.
>
> 3. Non-immediate finalization cannot happen.
>
> Is this about right?

I am confident it can happen on hot-unplug, but it's not working proprely.

>
> > Text console/VC is also poorly supported and leaks, so it will never
> > reach qemu_console_finalize() either.
> >
> > I can try to improve the situation by sending a more complete series,
> > so those assert() are unlikely to be reachable in the future.
>
> I'm just trying to understand why this works :)
>
> More complete patches are always nice, but I'm not demanding you do that
> now.  Comments perhaps?

I think we should leave a TODO & asserts for the hot-unplug cases

