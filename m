Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D91D46607
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 17:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgRPD-0008RF-P6; Thu, 15 Jan 2026 12:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgROu-0008PA-9S
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:44:53 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgROp-0006zA-3O
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:44:48 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b8712507269so185235766b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 09:44:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768499085; cv=none;
 d=google.com; s=arc-20240605;
 b=gptRfEgKsgrvbQMdpCmVbVQkfEEGnOlqTvkJQpiU/s3zZsFtmL5XpvkhBYtkyGmdPL
 1IGH4zLANevmrZ5VWlVe1K8+zzGbskWO8ZeSpCQjDAs2de8tXdWcx4g4g81ebDPQZC56
 kPr1RQyjHCW9c8L14aJrAfzB4aXS40CrwilQtiFNAS+OMDgErLvyQXdHldlr/Vt3NXqV
 tkURxGDJKfQhLwMU04UVY1pJ9P9O/rIBTwjTz0CuQNjEVfAN8sGFqivvIjE/Zwmgq8Ad
 58JQ0oMhHxp0qp0p/nd2r4wa+xUnFT76PluATkcrEWotf1RykxrmdU03uMrgRPLNftsM
 mtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fA7FOKlU7W8aCa33XDCB2juyBR0y0n1FS/r0Xb890nc=;
 fh=KgimXnKYua7njztgMQq2QSz3aOrdbSVOwRY3A+EqJ1s=;
 b=RfMiUT0Wx1hfrUhu6jCLLvG5MJJhZnr6VaI1hoULRCSVZGvFmP4dS0IAOXWB2C8eJh
 EL+s5AsKTzf7mkF8N2+3tWrGMc9WMFQXpWxcCV4Z01ibh3XRl8G4yO+GG9Q9PoeCfGYI
 4XB1TuCbUk0YK7YEbqOLHsOXcwizSznTVfX13Y3BJgkI+I58ftK7tCFjsu4B5zSQWM/f
 r/3LPVsPxAoB5bNXw6vWcZ+iLSB7gt0brBE0TjAi3l9D6P7tTb1MVaG56TTVZrD83KZK
 G1UuNFyQDpWxJUzTlGGPwY2854+Y7o5B9va2WYCUy/xDd4he6LuGZ00pHfwedC/NIEeK
 i5aw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768499085; x=1769103885; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fA7FOKlU7W8aCa33XDCB2juyBR0y0n1FS/r0Xb890nc=;
 b=RRh9q8ZFRSmYPLh/MWlzwmSRsaSlGsVUtBsPTBjZfdw+l3wigEwDiHOtrEKszHcV+X
 2Xi+U6To2ud1ljpQX4tdb0O2pyp91dvtRAoE8J7n5pFPrhSmzmC/kZVSrO4D3eECVRKD
 9OFka252L4q1LPZ8SrVsW3rl+xOOQ+kNIHByzSPWXlNaXrrp2kH45AcMKZQE6vm9Au9P
 C05LkM65wKTAlvFefwjLYwal7X5pdxTWUdzgOLhcXI2R1ksY1nvxuLodsMSA0BGhNuNt
 z8eTfWUmult5xgSSX3gispJTaefVgWofC7FOrhnD39s8Go8WyNMvNUUILj4vDGgKEqTF
 lEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768499085; x=1769103885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fA7FOKlU7W8aCa33XDCB2juyBR0y0n1FS/r0Xb890nc=;
 b=XWFnC5o9lt2fZb6YgrzhWNf1xXPptm+jQ8Pk03Jq0TqkltGUzmEMRJGoaRYOFuPaAB
 mOITygztmCT3H3W3nP56DvMAzNGQ8eG9cjzojoWm3OkHB/6BdA+5FS1ARQlYOZ88Z6Pn
 tXCAhrnmUQLyQ6l8kbQzGMopFYVaUeE4HsikuV3d/tM8QcPLH3U0Eaz0NwPCCGHakKbR
 sYw4TGCeZljdz31xOW6z/7oC/8dUXqE1YXC1wJbRXaNp0lGw5AC8tn/47Huvflm44vCm
 NPlbTVkK3M0w4daUmai8qIRAmvbhSLp+ZEIKJhLyoLHmFpNENVmlhm8ZMIpcOm7nMC8R
 w8Ew==
X-Gm-Message-State: AOJu0YwuqUZhjaV8jAEbb+4AjZT8mod1Oho6zxxDusbTQPVOWE5lCXcA
 VtGc83ABzNQUtxIhfIMev0YXBI7JpRMREV6Pcr4bf7+SJ+vrFQmrpkWIaU7bB6Cl/z3pkiDjpbr
 /7gVpp+hgpyKrvmxQLr3fDf4O644vdpw=
X-Gm-Gg: AY/fxX55CxenobAjrRX13KQAlUwjy4MYGJDwaUU79YEnMLvAVh6C0xdZrHPRthYa8DV
 4l/ogAUNJ/MUl7ALRLr/hDfd+m8WDN1O1sp7801KDcXnfdolx6ibvCc7oNH0B3y9HGvf/kbCtGr
 VisIzBaKihaAe5BpZx4x9luMbObtyTma1lGQRRWIHoVbgXOjmtrw2jfDHGEeIvRooJu8X/nIEWQ
 VUbcsQ+ohc8YWR+rqenl2QoCHV6lXDzWW5PpVp4AFiC4KqFzmt0K5+tFVnMl40COqCQZKnH
X-Received: by 2002:a17:907:7b98:b0:b83:8f35:773b with SMTP id
 a640c23a62f3a-b879300de06mr34640566b.54.1768499085045; Thu, 15 Jan 2026
 09:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20251229103859.98777-1-zhangckid@gmail.com>
 <20251229103859.98777-3-zhangckid@gmail.com>
 <877bts8fsa.fsf@pond.sub.org>
 <CAK3tnvJuoin17F9FDnYJA+vXeUeGpMv3R=2vrOBFUotjRCymfQ@mail.gmail.com>
In-Reply-To: <CAK3tnvJuoin17F9FDnYJA+vXeUeGpMv3R=2vrOBFUotjRCymfQ@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 16 Jan 2026 01:44:06 +0800
X-Gm-Features: AZwV_QiIfu4qp4jdT166PBaqbS0ZR7nlJoi1_eDx_Dcg8vU_sxj_GhWlSMuvIFo
Message-ID: <CAK3tnvLo45v9M26TLg3Djsn0FeUKNuRyXTfmP77uFp5f2JrN_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] qapi: Add thread_status flag for iothreads
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62c.google.com
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

On Fri, Jan 9, 2026 at 11:11=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> wr=
ote:
>
> On Thu, Jan 8, 2026 at 8:12=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
> >
> > Zhang Chen <zhangckid@gmail.com> writes:
> >
> > > The thread_status depends on struct IOThreadInfo's
> > > 'attached': 'bool'. Show in the qmp/hmp CMD with
> > > 'attached' or 'detached'.
> > >
> > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > ---
> > >  iothread.c         | 1 +
> > >  monitor/hmp-cmds.c | 2 ++
> > >  qapi/misc.json     | 6 ++++++
> > >  3 files changed, 9 insertions(+)
> > >
> > > diff --git a/iothread.c b/iothread.c
> > > index 38e38fb44d..fb4898e491 100644
> > > --- a/iothread.c
> > > +++ b/iothread.c
> > > @@ -358,6 +358,7 @@ static int query_one_iothread(Object *object, voi=
d *opaque)
> > >      info =3D g_new0(IOThreadInfo, 1);
> > >      info->id =3D iothread_get_id(iothread);
> > >      info->thread_id =3D iothread->thread_id;
> > > +    info->attached =3D iothread->attached;
> > >      info->poll_max_ns =3D iothread->poll_max_ns;
> > >      info->poll_grow =3D iothread->poll_grow;
> > >      info->poll_shrink =3D iothread->poll_shrink;
> > > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > > index 33a88ce205..84b01737cf 100644
> > > --- a/monitor/hmp-cmds.c
> > > +++ b/monitor/hmp-cmds.c
> > > @@ -197,6 +197,8 @@ void hmp_info_iothreads(Monitor *mon, const QDict=
 *qdict)
> > >          value =3D info->value;
> > >          monitor_printf(mon, "%s:\n", value->id);
> > >          monitor_printf(mon, "  thread_id=3D%" PRId64 "\n", value->th=
read_id);
> > > +        monitor_printf(mon, "  thread_status=3D%s" "\n",
> > > +                       value->attached ? "attached" : "detached");
> > >          monitor_printf(mon, "  poll-max-ns=3D%" PRId64 "\n", value->=
poll_max_ns);
> > >          monitor_printf(mon, "  poll-grow=3D%" PRId64 "\n", value->po=
ll_grow);
> > >          monitor_printf(mon, "  poll-shrink=3D%" PRId64 "\n", value->=
poll_shrink);
> > > diff --git a/qapi/misc.json b/qapi/misc.json
> > > index 6153ed3d04..2eea920bd2 100644
> > > --- a/qapi/misc.json
> > > +++ b/qapi/misc.json
> > > @@ -76,6 +76,9 @@
> > >  #
> > >  # @thread-id: ID of the underlying host thread
> > >  #
> > > +# @attached: flag to show current iothread attached status
> >
> > What does "attached status" actually mean?
>
> This flag means weather the "-object iothread" already been used by a
> real device.
> In hotplug scenario, user can add multiple "-object iothread" and
> multiple devices (like virtio-blk).
> When user hotunplug the devices can keep the iothreads as a thread
> pool, following the new
> hotplug devices can attach to the released iothread.
>
> >
> > > +#            (since 10.3.0)
> >
> > (since 12.0)
>
> OK.
>
> >
> > > +#
> > >  # @poll-max-ns: maximum polling time in ns, 0 means polling is
> > >  #     disabled (since 2.9)
> > >  #
> > > @@ -93,6 +96,7 @@
> > >  { 'struct': 'IOThreadInfo',
> > >    'data': {'id': 'str',
> > >             'thread-id': 'int',
> > > +           'attached': 'bool',
> > >             'poll-max-ns': 'int',
> > >             'poll-grow': 'int',
> > >             'poll-shrink': 'int',
> > > @@ -118,6 +122,7 @@
> > >  #              {
> > >  #                 "id":"iothread0",
> > >  #                 "thread-id":3134,
> > > +#                 'thread_status':"attached",
> >
> > I believe this is actually
> >
> >                      "attached": true
> >
> > and ...
>
> No, I changed it here for readability:
> > > +        monitor_printf(mon, "  thread_status=3D%s" "\n",
> > > +                       value->attached ? "attached" : "detached");
>
> But if you think ""attached": true" is more direct way, I can change
> it next version.

If no other comments, I will keep this part and update to version 2
for this series.

Thanks
Chen

>
> >
> > >  #                 'poll-max-ns':0,
> > >  #                 "poll-grow":0,
> > >  #                 "poll-shrink":0,
> > > @@ -126,6 +131,7 @@
> > >  #              {
> > >  #                 "id":"iothread1",
> > >  #                 "thread-id":3135,
> > > +#                 'thread_status':"detached",
> >
> >                      "attached": false
> >
> > Recommend to create example output by running a test instead of making
> > it up, because making it up likely screws it up :)
>
> Uh.... This output print is the real test in my machine, maybe you
> missed the previous description.
>
> Thanks
> Chen
>
> >
> > >  #                 'poll-max-ns':0,
> > >  #                 "poll-grow":0,
> > >  #                 "poll-shrink":0,
> >

