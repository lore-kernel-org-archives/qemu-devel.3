Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCB0CD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV6aF-0000Km-21; Thu, 04 Jun 2026 07:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wV6aA-0000GC-F6
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:49:55 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wV6a7-0006wC-Ld
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:49:54 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-687ed9aabb3so1184918a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 04:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780573790; cv=none;
 d=google.com; s=arc-20240605;
 b=N5C2eyCou3WiokRqHIyWHEi2za1YHUf5FuXQyzxoWSskbvRYpm2a1dd8ca81adO9gP
 nJOEr7mLHIN8j/j2mg1pO02rYvlhPEIwWGrVbrAaZXv2vLHIozPkwd+MRJeGmSIjscB1
 sxd+VFwJSAYGymKFTb2lOkIBsD4eT3aQhiz8bjSJ88qoLralUU+fMbf9p64XPnI9iUhm
 ENbevHripRPiXpkC5xWSw+u18tvWE6j4UNWKm0vXXOj3ev3JZ7aqfz7DfRcarwtTCTN9
 shGXb5Ce5LzRmcCxVkN63wYmNquS/3XkdPWhUE8lvPCDpWvQVlFgQKV/TMmNDL1INrgU
 GMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3/rmTrcSv2Ldz3vYhQxWOfmh4yijIF4WLIB9OeAfXbk=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=JZOidXlQ28TMd8ezQUEbBdFGaFvYYwrLbP8VtDWGZQ8dEB86/RqymlDtlSlEqBC34/
 Q/m+MfK2OdFz4G+9TlLsygMX4nPfkipcg/npTyiGqq+ld9lUWhxSKgdVzpTAmu0lQnjL
 4WD3V1ZX8jelcp3sZc5Zt0CaPzmdkGKKSmOGeJ8oXTGKtZDO9CGuujdnKdOfmmrLPZ/a
 rYfhT/seCcYUJSpJtswjmib0ntpAP7wH0kjMFtAuijPtoLjTVpTDlObzWdKwOqyjh7K4
 Owuh5NnKIE2TDq0kBJpjA1PCjwPYVsEDAwuQFBdHrtc5H6TMqrYvYmv0UeY+dTxMfgf5
 kZcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780573790; x=1781178590; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/rmTrcSv2Ldz3vYhQxWOfmh4yijIF4WLIB9OeAfXbk=;
 b=kzQ3/koOgU2w02ZVDCA0BGErhWfsP9fbfq/BgKCdcM8VS9KGwWVFUO1kopskhEiJ/o
 Q63Lh8hC43mDodxpuP3zJ95NchCyldyKxvpITPHNk8AwXiTt+Xe1abwT1wuj7erMYhXv
 Y2d43X6Yy3Vrr3PsQBaexboI/YTBrPc7k8N6gCBFDAfiphoI2hVC8OSKUaWkXarAcFph
 x4mPeQ/dIj6st6U3uPCFmPJVNeXeWHx8AL0rWAE6sO25P5pbJuKQTPd8YeeSBeFwvjOl
 Xn2QBJh/a9zLNbtZqfc4/YQciBWqfCFaVfAC1edMASr3qFREFUZNaFzXbSSdmU8jRwCI
 DZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780573790; x=1781178590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3/rmTrcSv2Ldz3vYhQxWOfmh4yijIF4WLIB9OeAfXbk=;
 b=mvFVgbhiMbgOePEN33DS/XVuEfSvufgkOWaZl0GSmSRFmAIP91NQ/Rp90bPVWxhF7V
 g0sQfIsCURQT/P37S5uVuC5V/BJZlhLxJigu6KU44/Kd9goYb9r2A0xyyvtUNvcGPDNf
 2tBegdNgrLSwKdp2QFx8+B4Zxow1eg6VlD3JMRyibK4DuHphZl+YsX2D9zqhUV/p/lRS
 OgvKPpa4GkiYvRrVgyiZe6PdwTu3N4i3Grs5rMm4XBX4Og04I3y5dOH5GqEjHgSjWqRC
 g7g7Cl3x+dIPtoEfzzJp0N1tDSnf+d42NaP7LbzyZ2xFpDB0ivYivp4tkwt6Tt9NjJbF
 3nSg==
X-Gm-Message-State: AOJu0Yzuqjwr7ce6v52LCo2x50ZdzseAH9RkSn3swQoXugpjOmmhgefy
 +kNBlG/W1UxTsN9kA/Q5F/TgzLnffZKTObSDpvBL0nsVeFSbx9kWdMQdOQv2JIKy+qizplAwj7e
 sJJrB3davxM6VRetm7ac1Wl24mFPrj40=
X-Gm-Gg: Acq92OFuG+16d7BVcWCDTmS/WcdtAk+7qGzCtgVn1POmLufuqKIrTWdk4PZxoM2uhB4
 T3b1MaJ21z+dBsC+37/1hz7GUDE5M1rHXtxQs6VjjUrV7gjfaku5pQ5J37LX3D+PKqEYM/+52MI
 GWvxxyzoKxt09moGmx3igjGedmcDbbl28mveEDGmMqP6wciK/WjBYnbxYIKBYJl3MF2lY3EKj8m
 8gaM3SboPb9EWFEpR58jf2M4ud4NF4NzBRfrw32B9rTs9juWzKIOgF5vHZ0QYLNoJWCLnxycunv
 xbXS/dgpSm/MBWuF6m0=
X-Received: by 2002:a17:907:cbc5:b0:beb:7979:47dd with SMTP id
 a640c23a62f3a-bf0b2bd0608mr412867766b.27.1780573789175; Thu, 04 Jun 2026
 04:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260529213321.96271-1-zhangckid@gmail.com>
 <20260529213321.96271-15-zhangckid@gmail.com>
 <87jysgrgm7.fsf@pond.sub.org>
In-Reply-To: <87jysgrgm7.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 4 Jun 2026 19:49:12 +0800
X-Gm-Features: AVHnY4IS28Y3GD4TU8sCBVAEkAPBxnyadsF9TVmMcFNX0tD2cFCTVCSldaA_7R4
Message-ID: <CAK3tnvLJq0-RiwS5t1+ZYn4aXVKqpHkwYx6N_YcBEwF1J3BeAg@mail.gmail.com>
Subject: Re: [PATCH V8 14/15] qapi: examine IOThread attachment status via
 query-iothreads
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52d.google.com
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

On Wed, Jun 3, 2026 at 1:34=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Extend the 'IOThreadInfo' structure to include attachment metrics.
> > This allows users to monitor the associated devices by identify them
> > by their QOM paths.
>
> Should we mention block nodes and monitors, too?
>

Good catch, will add the block nodes and monitors.

> >
> > New fields added to IOThreadInfo:
> >  @holders: IOThreadHolder of the devices currently associated with
> >      this iothread.  Users can pre-allocate multiple iothread objects
> >      to serve as a persistent thread pool.  When a device is hot-unplug=
ged,
> >      it is detached from its iothread, but the iothread remains availab=
le,
> >      allowing future hot-plugged devices to attach to it.  (Since 11.1)
> >
> > These fields are also exposed via the Human Monitor Interface (HMP)
> > command 'info iothreads' to assist with manual debugging and
> > performance tuning.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  iothread.c         | 22 ++++++++++++++++++++++
> >  monitor/hmp-cmds.c | 26 ++++++++++++++++++++++++++
> >  qapi/misc.json     | 11 +++++++++++
> >  3 files changed, 59 insertions(+)
> >
> > diff --git a/iothread.c b/iothread.c
> > index a85e960e45..5949785b32 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -24,6 +24,8 @@
> >  #include "qemu/error-report.h"
> >  #include "qemu/rcu.h"
> >  #include "qemu/main-loop.h"
> > +#include "qapi/clone-visitor.h"
> > +#include "qapi/qapi-visit-misc.h"
> >
> >  /*
> >   * iothread_ref:
> > @@ -119,6 +121,25 @@ static void iothread_unref(IOThread *iothread, con=
st IOThreadHolder *holder)
> >      object_unref(OBJECT(iothread));
> >  }
> >
> > +static IOThreadHolderList *iothread_get_holders_list(IOThread *iothrea=
d)
> > +{
> > +    IOThreadHolderList *head =3D NULL;
> > +    IOThreadHolderList **prev =3D &head;
> > +    GList *l;
> > +
> > +    for (l =3D iothread->holders; l; l =3D l->next) {
> > +        IOThreadHolder *src =3D l->data;
> > +        IOThreadHolderList *entry =3D g_new0(IOThreadHolderList, 1);
> > +
> > +        entry->value =3D QAPI_CLONE(IOThreadHolder, src);
> > +
> > +        *prev =3D entry;
> > +        prev =3D &entry->next;
> > +    }
>
> If iothread->holders was a IOThreadHolderList instead of a GList, this
> loop could be QAPI_CLONE(IOThreadHolderList, iothread->holders) instead.

Nice comments, I will try it in next version.

>
> > +
> > +    return head;
> > +}
> > +
> >  static void *iothread_run(void *opaque)
> >  {
> >      IOThread *iothread =3D opaque;
> > @@ -488,6 +509,7 @@ static int query_one_iothread(Object *object, void =
*opaque)
> >      info =3D g_new0(IOThreadInfo, 1);
> >      info->id =3D iothread_get_id(iothread);
> >      info->thread_id =3D iothread->thread_id;
> > +    info->holders =3D iothread_get_holders_list(iothread);
> >      info->poll_max_ns =3D iothread->poll_max_ns;
> >      info->poll_grow =3D iothread->poll_grow;
> >      info->poll_shrink =3D iothread->poll_shrink;
> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > index 443b8c785d..1b5883147b 100644
> > --- a/monitor/hmp-cmds.c
> > +++ b/monitor/hmp-cmds.c
> > @@ -237,11 +237,37 @@ void hmp_info_iothreads(Monitor *mon, const QDict=
 *qdict)
> >      IOThreadInfoList *info_list =3D qmp_query_iothreads(NULL);
> >      IOThreadInfoList *info;
> >      IOThreadInfo *value;
> > +    IOThreadHolderList *h;
> >
> >      for (info =3D info_list; info; info =3D info->next) {
> >          value =3D info->value;
> >          monitor_printf(mon, "%s:\n", value->id);
> >          monitor_printf(mon, "  thread_id=3D%" PRId64 "\n", value->thre=
ad_id);
> > +        monitor_printf(mon, "  holders=3D");
> > +        if (value->holders) {
> > +            for (h =3D value->holders; h; h =3D h->next) {
> > +                IOThreadHolder *holder =3D h->value;
> > +
> > +                switch (holder->type) {
> > +                case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
> > +                    monitor_printf(mon, "[block-node: %s]",
> > +                                   holder->u.block_node.node_name);
> > +                    break;
> > +                case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> > +                    monitor_printf(mon, "[qom-path: %s]",
> > +                                   holder->u.qom_object.qom_path);
> > +                    break;
> > +                case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
> > +                    monitor_printf(mon, "[monitor-name: %s]",
> > +                                   holder->u.monitor_name.monitor_name=
);
> > +                    break;
> > +                default:
> > +                    monitor_printf(mon, "[unknown]");
> > +                    break;
> > +                }
> > +            }
> > +            monitor_printf(mon, "\n");
> > +        }
> >          monitor_printf(mon, "  poll-max-ns=3D%" PRId64 "\n", value->po=
ll_max_ns);
> >          monitor_printf(mon, "  poll-grow=3D%" PRId64 "\n", value->poll=
_grow);
> >          monitor_printf(mon, "  poll-shrink=3D%" PRId64 "\n", value->po=
ll_shrink);
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index d9f82f0922..4c16be3fd4 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -137,6 +137,13 @@
> >  #
> >  # @thread-id: ID of the underlying host thread
> >  #
> > +# @holders: IOThreadHolder of the devices currently associated with
>
> This is rendered like
>
>     =E2=80=A2 holders ([IOThreadHolder]) =E2=80=93 IOThreadHolder of the =
devices currently associated with
>
> Better use something like
>
>    # @holders: the devices currently associated with ...
>
> I'm not sure about "devices", though.  It's QOM objects, block nodes,
> and monitors.  Perhaps the QOM objects are all be devices (subtypes of
> TYPE_DEVICE), but I'd have to dig through your patches to be sure.  Does
> it matter?

Yes, you are right, will change the comments from "devices" to "QOM
objects, block nodes or monitors".

>
> > +#     this iothread.  Users can pre-allocate multiple iothread objects
> > +#     to serve as a persistent thread pool.  When a device is
> > +#     hot-unplugged, it is detached from its iothread, but the
> > +#     iothread remains available, allowing future hot-plugged devices
> > +#     to attach to it.  (Since 11.1)
>
> This may need to be rewritten with block nodes and monitors in mind.

OK.

>
> > +#
> >  # @poll-max-ns: maximum polling time in ns, 0 means polling is
> >  #     disabled (since 2.9)
> >  #
> > @@ -159,6 +166,7 @@
> >  { 'struct': 'IOThreadInfo',
> >    'data': {'id': 'str',
> >             'thread-id': 'int',
> > +           'holders': ['IOThreadHolder'],
> >             'poll-max-ns': 'int',
> >             'poll-grow': 'int',
> >             'poll-shrink': 'int',
> > @@ -185,6 +193,8 @@
> >  #              {
> >  #                 "id":"iothread0",
> >  #                 "thread-id":3134,
> > +#                 "holders":[{"qom-path": "/machine/peripheral/blk1/vi=
rtio-backend", "type": "qom-object"},
> > +#                            {"qom-path": "/machine/peripheral/blk0/vi=
rtio-backend", "type": "qom-object"}],
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
> > @@ -193,6 +203,7 @@
> >  #              {
> >  #                 "id":"iothread1",
> >  #                 "thread-id":3135,
> > +#                 "holders":[{"qom-path": "/machine/peripheral/blk2/vi=
rtio-backend", "type": "qom-object"}],
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
>
> Would it be useful if one of these examples was a block node?

OK, will update a demo for block node.

Thanks
Chen

>

