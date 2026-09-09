Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0011C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FjS-0001VO-3j; Wed, 09 Sep 2026 06:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4FjQ-0001VF-Fa
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4FjO-0002Ff-IG
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788950440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zSLTexni7kwekvkmDZtHGJ6KKF4CFvsHSGrrfyC0Wv8=;
 b=Ic21HD+K3ImHbm1NrHt5ITbFL9FhrmLWEkv6BAMJtE6c1srwPs/EXEXr1wsoHHhPkP94YF
 H65UOzJhI7U+eL/+Wv9HZTr4SIfsR0IqYsIpIs8EbJPi2NKiWgbjYmBA3l3y0P6DkDNkeK
 qEDngtbjFCRQVqTxA9EHKP7swrg/r6E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-8AnZ7JrLPRece0QnIRE7eA-1; Wed,
 09 Sep 2026 06:40:39 -0400
X-MC-Unique: 8AnZ7JrLPRece0QnIRE7eA-1
X-Mimecast-MFC-AGG-ID: 8AnZ7JrLPRece0QnIRE7eA_1788950438
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 476711800762; Wed,  9 Sep 2026 10:40:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF7471955D84; Wed,  9 Sep 2026 10:40:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E12E21E6A04; Wed, 09 Sep 2026 12:40:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V15 05/14] monitor: track IOThread users with QOM paths
In-Reply-To: <CAK3tnvKfeJK-p8POfzDoG2NLt=NWgKnF_WcmAWAHWXnuQdCWTw@mail.gmail.com>
 (Zhang Chen's message of "Wed, 9 Sep 2026 15:57:02 +0800")
References: <20260907063725.626685-1-zhangckid@gmail.com>
 <20260907063725.626685-6-zhangckid@gmail.com>
 <874ig1xmbi.fsf@pond.sub.org>
 <CAK3tnvKfeJK-p8POfzDoG2NLt=NWgKnF_WcmAWAHWXnuQdCWTw@mail.gmail.com>
Date: Wed, 09 Sep 2026 12:40:35 +0200
Message-ID: <87fqzin1wc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 127.0.0.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Zhang Chen <zhangckid@gmail.com> writes:

> On Mon, Sep 7, 2026 at 8:44=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > Monitors that require an IOThread share the internal mon_iothread.
>> > Account for each monitor explicitly in IOThread holder tracking, using
>> > the monitor's canonical QOM path to distinguish holders.
>> >
>> > Acquire the shared monitor IOThread AioContext once and store the
>> > IOThread and canonical QOM path so the holder can be released after the
>> > monitor has been removed from the QOM tree. Reuse the stored context f=
or
>> > later operations.
>> >
>> > Release the holder from monitor_finalize(), after resources associated
>> > with the AioContext have been destroyed. This pairs the reference taken
>> > in complete() with instance finalization and keeps the IOThread alive
>> > throughout monitor teardown.
>> >
>> > The internal mon_iothread remains hidden from query-iothreads, as befo=
re.
>> > Management applications therefore cannot use it to determine which
>> > monitors are using the IOThread. Nevertheless, track the monitor
>> > holders so that they follow the same explicit holder and
>> > IOThread reference lifecycle as other AioContext users.
>> >
>> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> > ---
>> >  monitor/monitor-internal.h |  5 +++++
>> >  monitor/monitor.c          | 26 +++++++++++++++++++++-----
>> >  monitor/qmp.c              |  5 +++--
>> >  3 files changed, 29 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
>> > index 822a66d06d..1d5aeae5e6 100644
>> > --- a/monitor/monitor-internal.h
>> > +++ b/monitor/monitor-internal.h
>> > @@ -77,6 +77,11 @@ struct Monitor {
>> >      GString *outbuf;
>> >      guint out_watch;
>> >      int mux_out;
>> > +
>> > +    /* iothread context and holder identity */
>> > +    IOThread *iothread;
>> > +    char *iothread_qom_path;
>> > +    AioContext *ctx;
>> >  };
>> >
>> >  struct MonitorQMPClass {
>> > diff --git a/monitor/monitor.c b/monitor/monitor.c
>> > index 2654b81890..cc7f6785b5 100644
>> > --- a/monitor/monitor.c
>> > +++ b/monitor/monitor.c
>> > @@ -93,6 +93,16 @@ static void monitor_finalize(Object *obj)
>> >      qemu_chr_fe_deinit(&mon->chr, false);
>> >      g_string_free(mon->outbuf, true);
>> >      qemu_mutex_destroy(&mon->mon_lock);
>> > +
>> > +    if (mon->iothread) {
>>
>> As we'll see in monitor_complete() below, mon->iothread is mon_iothread
>> if monitor_requires_iothread(mon), else null.  Which means
>> mon->mon_iothread is non-null if and only if
>> monitor_requires_iothread(mon).
>>
>> Here, you check whether mon->mon_iothread is non-null to find out
>> whether @mon uses the monitor I/O thread, and you read the monitor I/O
>> thread from mon->mon_iothread.
>>
>> Elsewhere in this file, we check monitor_requires_iothread(mon) and you
>> read mon_iothread, e.g. in monitor_cancel_out_watch()
>>
>>            if (monitor_requires_iothread(mon)) {
>>                ctx =3D iothread_get_g_main_context(mon_iothread);
>>            }
>>
>> I don't like this inconsistency.  Two ways to avoid it:
>>
>> 1. Always use monitor_requires_iothread(mon) to check and mon_iothread
>> to read.  Drop struct Monitor member iothread.
>>
>> 2. Always use mon_iothread, except where we initialize it in
>> monitor_complete().
>
> Just to clarify: by option 2, do you mean using mon->iothread
> consistently for per-monitor checks and accesses, except in
> monitor_complete(), where monitor_requires_iothread() determines
> whether to initialize it?

Yes.  I meant to write 2. Always use mon->iothread, but mistyped.


