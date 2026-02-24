Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF79BEFB810
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 08:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuo0W-0006DG-8V; Tue, 24 Feb 2026 03:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vuo0T-0006Ce-2W
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 03:43:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vuo0R-0006Nl-1E
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 03:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771922576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NP0F3hHDXEGmveKxj/AudgtlRQuzFBgzQWgOKdkd3+g=;
 b=VSqNzMivH9M2KxyH+M+Tmz1UhrMdGRGcRACsyGGAPuRJ/rl/nZ/W+F5g5YZd+TT1zVr1Ny
 gz3vvoT3RThybTF6kN3m1pAloTLdb9lbcG3CwLrRDJK+Y6LQWqv8xC0uDJEBQICPo8ae0X
 nehkHvDGkpv+wH/A+PXh2TC2FTxQsdI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-3ym2HmZ3OoOpYNK5-Nd4BQ-1; Tue,
 24 Feb 2026 03:42:53 -0500
X-MC-Unique: 3ym2HmZ3OoOpYNK5-Nd4BQ-1
X-Mimecast-MFC-AGG-ID: 3ym2HmZ3OoOpYNK5-Nd4BQ_1771922572
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BECB018005B7; Tue, 24 Feb 2026 08:42:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BB7219560A2; Tue, 24 Feb 2026 08:42:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A633221E692D; Tue, 24 Feb 2026 09:42:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V4 4/4] qapi: examine IOThread attachment status via
 query-iothreads
In-Reply-To: <CAK3tnvKEJSDMVC4bkEbhfsVXpp7nVbq+Kue9fFVmOrd5f_ugCg@mail.gmail.com>
 (Zhang Chen's message of "Tue, 24 Feb 2026 10:42:42 +0800")
References: <20260213171622.55629-1-zhangckid@gmail.com>
 <20260213171622.55629-4-zhangckid@gmail.com>
 <87wm0bq047.fsf@pond.sub.org>
 <CAK3tnvKEJSDMVC4bkEbhfsVXpp7nVbq+Kue9fFVmOrd5f_ugCg@mail.gmail.com>
Date: Tue, 24 Feb 2026 09:42:48 +0100
Message-ID: <874in65y7r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

> On Tue, Feb 17, 2026 at 3:51=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > Extend the 'IOThreadInfo' structure to include attachment metrics.
>> > This allows users to monitor how many devices are associated with
>> > a specific IOThread and identify them by their QOM paths.
>> >
>> > New fields added to IOThreadInfo:
>> > - @attached-cnt: An integer representing the number of devices
>> >   currently using this IOThread's AioContext.
>> > - @attached-dev: A string containing a delimited list ("|") of
>> >   QOM paths for the attached devices.
>> >
>> > These fields are also exposed via the Human Monitor Interface (HMP)
>> > command 'info iothreads' to assist with manual debugging and
>> > performance tuning.
>> >
>> > Example QMP output:
>> > {
>> >     "id": "iothread0",
>> >     "thread-id": 3134,
>> >     "attached-cnt": 2,
>> >     "attached-dev": "/machine/peripheral/blk1/virtio-backend | /machin=
e/peripheral/blk0/virtio-backend",
>> >     ...
>> > }
>> >
>> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>>
>> [...]
>>
>> > diff --git a/qapi/misc.json b/qapi/misc.json
>> > index 1f5062df2a..ca53638684 100644
>> > --- a/qapi/misc.json
>> > +++ b/qapi/misc.json
>> > @@ -76,6 +76,19 @@
>> >  #
>> >  # @thread-id: ID of the underlying host thread
>> >  #
>> > +# @attached-cnt: The parameter is a counter indicating how many
>> > +#     active devices are currently associated with this iothread
>> > +#     (e.g. virtio-blk).  In hotplug scenarios, users can
>> > +#     pre-allocate multiple iothread objects to serve as a persistent
>> > +#     thread pool.  When a device is hot-unplugged, the corresponding
>> > +#     IOThread is released but remains available, allowing subsequent
>> > +#     hot-plugged devices to attach to and reuse the existing thread.
>> > +#     (since 11.0)
>> > +#
>> > +# @attached-dev: A list of QOM paths for the devices currently
>> > +#     associated with this IOThread, delimited by " | ".
>> > +#     Returns "none" if no devices are attached. (since 11.0)

Does not compile:

    In file included from ../qapi/qapi-schema.json:66:
    ../qapi/misc.json:90:49: Use two spaces between sentences
    If this not the end of a sentence, please report a bug.

This error has been in master for almost three months.  Is your tree
that far behind?

>>
>> QAPI schema design maxim: do not encode structured data as strings.
>> @attached-devs should be an array of QOM paths instead.
>
> OK, will fix in next version.

Thanks!

>> Unless I misunderstand your docs, @attached-cnt is the number of QOM
>> paths in @attached-dev, i.e. @attached-dev is redundant.  If this is the
>> case, drop it.  If it isn't, educate me :)
>
> As Stefan's comments, I try to address more specific needs:
> https://mail.gnu.org/archive/html/qemu-devel/2026-02/msg01892.html

As far as I can tell, Stefan asked for the QOM paths of attached
devices.  @attached-dev provides it.  Good.  Why have @attached-cnt as
well?

>> We generally avoid abbreviations in the QAPI schema: @attached-count,
>> @attached-devices.
>>
>> > +#
>> >  # @poll-max-ns: maximum polling time in ns, 0 means polling is
>> >  #     disabled (since 2.9)
>> >  #
>> > @@ -93,6 +106,8 @@
>> >  { 'struct': 'IOThreadInfo',
>> >    'data': {'id': 'str',
>> >             'thread-id': 'int',
>> > +           'attached-cnt': 'int',
>> > +           'attached-dev': 'str',
>> >             'poll-max-ns': 'int',
>> >             'poll-grow': 'int',
>> >             'poll-shrink': 'int',
>> > @@ -118,6 +133,8 @@
>> >  #              {
>> >  #                 "id":"iothread0",
>> >  #                 "thread-id":3134,
>> > +#                 "attached-cnt":2,
>> > +#                 "attached-dev":/machine/peripheral/blk1/virtio-back=
end | /machine/peripheral/blk0/virtio-backend,
>>
>> Once again, the example is syntactically incorrect (the value lacks
>> double quotes), and once again I recommend to create example I/O by
>> actually running a test.  Getting tired of this, to be frank.
>
> Sorry for that again. Will fix in next version.
> And I tested this series before send the mail like this:
>
> (qemu) info iothreads
> iothread2:
>   thread_id=3D434428
>   attached-cnt=3D0
>   attached-dev=3Dnone
>   poll-max-ns=3D32768
>   poll-grow=3D0
>   poll-shrink=3D0
>   aio-max-batch=3D0
> iothread1:
>   thread_id=3D434427
>   attached-cnt=3D2
>   attached-dev=3D/machine/peripheral/blk1/virtio-backend |
> /machine/peripheral/blk0/virtio-backend
>   poll-max-ns=3D32768
>   poll-grow=3D0
>   poll-shrink=3D0
>   aio-max-batch=3D0

You can manually test QMP like this:

    $ qemu-system-x86_64 -S -display none -chardev socket,id=3Dqmp,path=3Dt=
est-qmp,server=3Don,wait=3Doff -mon mode=3Dcontrol,chardev=3Dqmp -object io=
thread,id=3Diot0

In another terminal:

    $ socat "READLINE,history=3D$HOME/.qmp_history,prompt=3DQMP> " UNIX-CON=
NECT:test-qmp=20
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 10}, "p=
ackage": "v10.2.0-1533-g627cf8d1ed-dirty"}, "capabilities": ["oob"]}}
    QMP> {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
    {"return": {}}
    QMP> {"execute": "query-iothreads"}
    {"return": [{"poll-shrink": 0, "thread-id": 2140323, "aio-max-batch": 0=
, "attached-dev": "none", "poll-grow": 0, "attached-cnt": 0, "poll-max-ns":=
 32768, "id": "iot0"}]}
    QMP> {"execute": "quit"}
    {"timestamp": {"seconds": 1771922506, "microseconds": 801687}, "event":=
 "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
    {"return": {}}


>> >  #                 "poll-max-ns":32768,
>> >  #                 "poll-grow":0,
>> >  #                 "poll-shrink":0,
>> > @@ -126,6 +143,8 @@
>> >  #              {
>> >  #                 "id":"iothread1",
>> >  #                 "thread-id":3135,
>> > +#                 "attached-cnt":1,
>> > +#                 "attached-dev":/machine/peripheral/blk3/virtio-back=
end,
>>
>> Likewise.
>
> Thanks
> Chen
>
>>
>> >  #                 "poll-max-ns":32768,
>> >  #                 "poll-grow":0,
>> >  #                 "poll-shrink":0,
>>


