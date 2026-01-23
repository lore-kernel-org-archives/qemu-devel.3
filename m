Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F776D74EC2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGsA-0005k6-3x; Fri, 23 Jan 2026 08:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vjGrz-0005U5-U6
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:06:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vjGrx-0007A9-5g
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769173592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+h8BpOsnTajvQuhMGpvF2odyCe1bnvrkW+Smuwz1xc=;
 b=gaURCGiG4mUOj4OK3dIOvIrSYS/pLslQYViiTm7tSSQPiXc2oCXoCviIzXxLjg4Yi6e5po
 zGZMA5LptXFcxJovb6YpLFGGUXYovHwX/Q3hZeTTVdb85WhdggNCSo0PMB9F76+8xSge/F
 c/AWAEGqBQgikStffC0RngZCLAy5Ta4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-nCCokQP1ObS8JI72RtLyKw-1; Fri,
 23 Jan 2026 08:06:28 -0500
X-MC-Unique: nCCokQP1ObS8JI72RtLyKw-1
X-Mimecast-MFC-AGG-ID: nCCokQP1ObS8JI72RtLyKw_1769173588
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E89751956096; Fri, 23 Jan 2026 13:06:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E3FD1958DC1; Fri, 23 Jan 2026 13:06:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D5FF021E692D; Fri, 23 Jan 2026 14:06:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 3/3] qapi: Add thread_status flag for iothreads
In-Reply-To: <CAK3tnvK=hyrVhwyEHfAOaDNStG=C9irPK39ua=g=Upep6f8g6g@mail.gmail.com>
 (Zhang Chen's message of "Fri, 16 Jan 2026 16:41:21 +0800")
References: <20251229103859.98777-1-zhangckid@gmail.com>
 <20251229103859.98777-3-zhangckid@gmail.com>
 <877bts8fsa.fsf@pond.sub.org>
 <CAK3tnvJuoin17F9FDnYJA+vXeUeGpMv3R=2vrOBFUotjRCymfQ@mail.gmail.com>
 <87wm1irmvw.fsf@pond.sub.org>
 <CAK3tnvK=hyrVhwyEHfAOaDNStG=C9irPK39ua=g=Upep6f8g6g@mail.gmail.com>
Date: Fri, 23 Jan 2026 14:06:24 +0100
Message-ID: <87jyx8a373.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Zhang Chen <zhangckid@gmail.com> writes:

> On Fri, Jan 16, 2026 at 4:18=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > On Thu, Jan 8, 2026 at 8:12=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
>> >>
>> >> Zhang Chen <zhangckid@gmail.com> writes:
>> >>
>> >> > The thread_status depends on struct IOThreadInfo's
>> >> > 'attached': 'bool'. Show in the qmp/hmp CMD with
>> >> > 'attached' or 'detached'.
>> >> >
>> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> >> > ---
>> >> >  iothread.c         | 1 +
>> >> >  monitor/hmp-cmds.c | 2 ++
>> >> >  qapi/misc.json     | 6 ++++++
>> >> >  3 files changed, 9 insertions(+)
>> >> >
>> >> > diff --git a/iothread.c b/iothread.c
>> >> > index 38e38fb44d..fb4898e491 100644
>> >> > --- a/iothread.c
>> >> > +++ b/iothread.c
>> >> > @@ -358,6 +358,7 @@ static int query_one_iothread(Object *object, v=
oid *opaque)
>> >> >      info =3D g_new0(IOThreadInfo, 1);
>> >> >      info->id =3D iothread_get_id(iothread);
>> >> >      info->thread_id =3D iothread->thread_id;
>> >> > +    info->attached =3D iothread->attached;
>> >> >      info->poll_max_ns =3D iothread->poll_max_ns;
>> >> >      info->poll_grow =3D iothread->poll_grow;
>> >> >      info->poll_shrink =3D iothread->poll_shrink;
>> >> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> >> > index 33a88ce205..84b01737cf 100644
>> >> > --- a/monitor/hmp-cmds.c
>> >> > +++ b/monitor/hmp-cmds.c
>> >> > @@ -197,6 +197,8 @@ void hmp_info_iothreads(Monitor *mon, const QDi=
ct *qdict)
>> >> >          value =3D info->value;
>> >> >          monitor_printf(mon, "%s:\n", value->id);
>> >> >          monitor_printf(mon, "  thread_id=3D%" PRId64 "\n", value->=
thread_id);
>> >> > +        monitor_printf(mon, "  thread_status=3D%s" "\n",
>> >> > +                       value->attached ? "attached" : "detached");
>> >> >          monitor_printf(mon, "  poll-max-ns=3D%" PRId64 "\n", value=
->poll_max_ns);
>> >> >          monitor_printf(mon, "  poll-grow=3D%" PRId64 "\n", value->=
poll_grow);
>> >> >          monitor_printf(mon, "  poll-shrink=3D%" PRId64 "\n", value=
->poll_shrink);
>> >> > diff --git a/qapi/misc.json b/qapi/misc.json
>> >> > index 6153ed3d04..2eea920bd2 100644
>> >> > --- a/qapi/misc.json
>> >> > +++ b/qapi/misc.json
>> >> > @@ -76,6 +76,9 @@
>> >> >  #
>> >> >  # @thread-id: ID of the underlying host thread
>> >> >  #
>> >> > +# @attached: flag to show current iothread attached status
>> >>
>> >> What does "attached status" actually mean?
>> >
>> > This flag means weather the "-object iothread" already been used by a
>> > real device.
>> > In hotplug scenario, user can add multiple "-object iothread" and
>> > multiple devices (like virtio-blk).
>> > When user hotunplug the devices can keep the iothreads as a thread
>> > pool, following the new
>> > hotplug devices can attach to the released iothread.
>>
>> Why would a management application or human user want to know this?
>
> Because some usercases already been changed.
> This demand comes from Cloud Native ecosystem.
> User want to manage resources more flexible like containers (Kata contain=
er).
> The real workload maybe changed(runc) in the VM without VM reboot,
> It may need hotplug/unplug different multi disks with multi iothreads to =
meet
> high level scheduler's needs(like K8s).

In your v2, you added a (broken) PATCH 4 that describes @attached as
follows:

    The ``attached`` parameter is a flag to show whether the iothread
    is attached to an actual device(for example virtio-blk). In hotplug
    scenario, user can add multiple "-object iothread" and multiple
    devices (like virtio-blk). When user hotunplug the devices can keep
    the iothreads as a thread pool, following the new hotplug devices can
    attach to the released iothread.

Should this information go into the QAPI schema, too?

>> The answer should lead us to better doc text.
>>
>
> OK, I will add it in next version.

[...]


