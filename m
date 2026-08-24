Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DAFC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyP2r-0003g6-9W; Mon, 24 Aug 2026 03:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyP2q-0003fi-Aw
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyP2o-0002BM-JB
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787556273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=8Ti/AIki3RcExnlLMlTKTNZlMP0IiJxDVBf1FwYF1bw=;
 b=L01L8QkspCyx/1XF/pRbT5mWRSq1nF0iS432taGJJaUod9r6UqGbeOhZH1gO88Tudud5Th
 JlIeR//WtFj7Se/kxxmkg0w1BW+b/Aji0SowGr2zAGxBiQ901RSYZVdvBwgKumh79vOyDN
 9qR8AN+RWWpseeZAz4kC0Uu6N60d1YM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-bRMTpBw6M3uqNgUaxj8O0Q-1; Mon,
 24 Aug 2026 03:24:30 -0400
X-MC-Unique: bRMTpBw6M3uqNgUaxj8O0Q-1
X-Mimecast-MFC-AGG-ID: bRMTpBw6M3uqNgUaxj8O0Q_1787556269
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 977C5180AAB6; Mon, 24 Aug 2026 07:24:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C3057C5; Mon, 24 Aug 2026 07:24:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8D7C421E6920; Mon, 24 Aug 2026 09:24:26 +0200 (CEST)
Resent-To: jasowangio@gmail.com, zhangckid@gmail.com, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 24 Aug 2026 09:24:26 +0200
Resent-Message-ID: <87ecfougk5.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V12 13/15] monitor/hmp: display IOThread holders
In-Reply-To: <CAK3tnvL0N3AK78zwZVLP7ycujGeEHhmyuM6VG+LQd3GRg5CtbA@mail.gmail.com>
 (Zhang Chen's message of "Sun, 23 Aug 2026 05:04:43 +0800")
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-14-zhangckid@gmail.com>
 <87y0e12okc.fsf@pond.sub.org>
 <CAK3tnvL0N3AK78zwZVLP7ycujGeEHhmyuM6VG+LQd3GRg5CtbA@mail.gmail.com>
Date: Mon, 24 Aug 2026 08:55:17 +0200
Message-ID: <878q5wvwh6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

Zhang Chen <zhangckid@gmail.com> writes:

> On Thu, Aug 20, 2026 at 4:17=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > Display holder information in info iothreads to aid manual debugging.
>> > Omit the holders line when an IOThread has no holders.
>> >
>> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> > ---
>> >  monitor/hmp-cmds.c | 21 +++++++++++++++++++++
>> >  1 file changed, 21 insertions(+)
>> >
>> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> > index e9fb8d827a..41a813e79f 100644
>> > --- a/monitor/hmp-cmds.c
>> > +++ b/monitor/hmp-cmds.c
>> > @@ -240,11 +240,32 @@ void hmp_info_iothreads(Monitor *mon, const QDic=
t *qdict)
>> >      IOThreadInfoList *info_list =3D qmp_query_iothreads(NULL);
>> >      IOThreadInfoList *info;
>> >      IOThreadInfo *value;
>> > +    IOThreadHolderList *h;
>> >
>> >      for (info =3D info_list; info; info =3D info->next) {
>> >          value =3D info->value;
>> >          monitor_printf(mon, "%s:\n", value->id);
>> >          monitor_printf(mon, "  thread_id=3D%" PRId64 "\n", value->thr=
ead_id);
>> > +        monitor_printf(mon, "  holders=3D");
>> > +        for (h =3D value->holders; h; h =3D h->next) {
>> > +            IOThreadHolder *holder =3D h->value;
>> > +
>> > +            switch (holder->type) {
>> > +            case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
>> > +                monitor_printf(mon, "[block-export: %s]",
>> > +                               holder->u.block_export.export_id);
>> > +                break;
>> > +            case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
>> > +                monitor_printf(mon, "[qom-path: %s]",
>> > +                               holder->u.qom_object.qom_path);
>> > +                break;
>> > +            default:
>> > +                monitor_printf(mon, "[unknown]");
>> > +                break;
>>
>> This is unreachable.  Please use
>>
>>                default:
>>                    g_assert_not_reached();
>>
>> to make it obvious.
>>
>> > +            }
>> > +        }
>> > +        monitor_printf(mon, "\n");
>> > +
>> >          monitor_printf(mon, "  poll-max-ns=3D%" PRId64 "\n", value->p=
oll_max_ns);
>> >          monitor_printf(mon, "  poll-grow=3D%" PRId64 "\n", value->pol=
l_grow);
>> >          monitor_printf(mon, "  poll-shrink=3D%" PRId64 "\n", value->p=
oll_shrink);
>>
>> Quick test:
>>
>>     $ qemu-system-x86_64 -S -nodefaults -display none -chardev socket,id=
=3Dchr-qmp,path=3Dtest-qmp,server=3Don,wait=3Doff -object monitor-qmp,id=3D=
qmp,chardev=3Dchr-qmp -monitor stdio
>>     QEMU 11.1.50 monitor - type 'help' for more information
>>     (qemu) info iothreads
>>     (qemu) q
>>
>> Hmm, no output?  The QMP monitor should be holding the monitor I/O
>> thread.  To confirm that, I made monitor_complete() print things (patch
>> appended), and got
>>
>>     ### monitor qmp holding iothread mon_iothread
>>     ### monitor compat_monitor0 without iothread
>>
>> What's going on here?
>>
>
> This is expected with the existing query-iothreads behavior.
> mon_iothread is created under the internal object root, while
> qmp_query_iothreads() only walks /objects, so internal IOThreads are
> intentionally not exposed through QMP/HMP.

TIL about the internal object root.  It's the root of a *second* QOM
composition tree.  I have been operating under the assumnption there is
just one.

Your series adds holder tracking for any I/O thread, whether it's in the
externally visible QOM composition tree (the one returned by
object_get_root()) or the internal one (the one returned by
object_get_internal_root()).  Makes sense, because at the place where we
track we don't want to know / make assumptions about which tree it is.

query-iothreads shows only the I/O threads in the externally visible QOM
composition tree.  Makes sense.

Fortunately, you were able to eliminate the special case for monitors.
If it was still there, the query-iothreads code to show it would be
dead.

Back to what got us there.  My attempt to test query-iothreads showing
holders failed, because monitors are not usable for this test.  Please
show me how to test this.  Ideally, a simple command line and a few
simple monitor commands ending with a query-iothreads that shows
holders.

> I prefer to preserve that behavior in this series, since exposing internal
> IOThreads would require additional API decisions, including handling ID
> collisions with user-created IOThreads.

Okay!

> I=E2=80=99ll also change the unreachable default case to
> g_assert_not_reached().
>
> Thanks
> Chen

[...]


