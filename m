Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391C4CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWXQQ-0004Y3-Bx; Mon, 08 Jun 2026 06:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWXQO-0004Xn-BS
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWXQM-0007Q1-0k
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780915301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=t/DtfMWS7IKz2r0yR969zgbCTLVoKoAP1bHCuhTBwZI=;
 b=eBk5ArGM1xbVbarPOqG4IOoNZ8Xj3OX7LU2sXJCbkFi8byyQzuNsSHx7q5eYPvEmV2hRNA
 097KYaQTfD3yP+QMNTlFpZ3GpP9Xck/9S6ylsSXtuPLuqYVQkAgyZcaTQptSbjr8AkAU2x
 lQAz2l7m+/KexOTWH7D7PH8GDlzsxz4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-ZHGzPX_bOuO-BpE5j_QBsQ-1; Mon,
 08 Jun 2026 06:41:39 -0400
X-MC-Unique: ZHGzPX_bOuO-BpE5j_QBsQ-1
X-Mimecast-MFC-AGG-ID: ZHGzPX_bOuO-BpE5j_QBsQ_1780915298
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A78F0180044D; Mon,  8 Jun 2026 10:41:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8681180049F; Mon,  8 Jun 2026 10:41:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0B3C21E6A01; Mon, 08 Jun 2026 12:41:35 +0200 (CEST)
Resent-To: zhangckid@gmail.com, qemu-devel@nongnu.org, dave@treblig.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 08 Jun 2026 12:41:35 +0200
Resent-Message-ID: <87mrx5iaao.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V8 06/15] monitor: assign unique default ID to anonymous
 monitors
In-Reply-To: <CAK3tnvJ1UHfAviTJd5vanpSBV2b+OR8XSJbVzh9WvL0nSr9MMQ@mail.gmail.com>
 (Zhang Chen's message of "Thu, 4 Jun 2026 17:57:34 +0800")
References: <20260529213321.96271-1-zhangckid@gmail.com>
 <20260529213321.96271-7-zhangckid@gmail.com>
 <87ecioswnv.fsf@pond.sub.org>
 <CAK3tnvJ1UHfAviTJd5vanpSBV2b+OR8XSJbVzh9WvL0nSr9MMQ@mail.gmail.com>
Date: Mon, 08 Jun 2026 11:29:56 +0200
Message-ID: <87ecihl6qz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Wed, Jun 3, 2026 at 1:02=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > Currently, dynamically or implicitly created monitors (such as those
>> > generated via '-monitor stdio', GDB stub terminals, or mux chardevs)
>> > leave the 'id' field in the Monitor struct as NULL.
>>
>> There is no @id member in struct Monitor.
>
> Yes, I try to add it in this patch.
>
>>
>> >                                                     But the original
>> > @MonitorOptions have the @id field.
>>
>> QAPI type MonitorOptions has an optional member @id.
>>
>> Instances are only created by monitor_init_opts() from a QemuOpts, and
>> member @id is set to the QemuOpts's @id, which is also optional.
>>
>> monitor_init_opts() is only called during startup on behalf of CLI
>> option -mon, its shorthands -monitor, -qmp, -qmp-pretty, and for default
>> monitors.
>>
>> -mon accepts an "id" parameter, but it's optional.
>>
>> The others make up an "id".  For instance, the default monitor usually
>> gets "compat_monitor0".
>>
>> Aside: there's code that checks whether a non-null QemuOpts "id" starts
>> with "compat_monitor".  That's horrifying.
>>
>> As far as I can tell, the only way to create a monitor with null @id in
>> MonitorOptions is -mon without "id".
>>
>> This is a swamp.  Instead of messing with MonitorOptions member @id, ...
>
> I don't quite understand here, the "compat_monitor0" has been saved in
> the struct chardev's label field. I know each monitor need to bind to a c=
hardev.
> In principle, the "compat_monitor0" mark belonging to the chardev, not
> the monitor.
> Why is it forbidden to replace monitor with chardev?
> So I think the monitor need to a unique ID field in the struct monitor.
>
>>
>> >                                     This makes it difficult to track,
>> > debug, or associate monitors with specific iothreads or
>> > infrastructure components.
>> >
>> > Fix this by introducing monitor_get_id(), which uses an atomic counter
>> > to generate a unique fallback name ("mon_default_X") when 'id' is
>> > not explicitly supplied in MonitorOptions. Update all internal HMP
>> > and QMP initialization paths to propagate and store this string.
>>
>> ... you create yet another ID that is used for nothing but referring to
>> monitors from IOThreadHolder.  Hmm.
>>
>> Is it really necessary that every monitor has an ID?  If a user want
>> one, they can simply avoid -mon without id.
>
> I think yes, the iothread ref/unref is the first user.

What would happen if we used MonitorOptions @id instead of adding yet
another monitor ID?  IOThreadHolderMonitor then has to use
MonitorOptions @id, and query-iothreads can then identify the monitor
holding the I/O thread only when the user assigned a monitor ID.

The only way *not* to assign one is -mon without "id".

I'd expect human users to use the shorthands instead of -mon, and I'd
expect management applications to use -mon with "id".  So, monitors
without "id" should be rare.

But even if they are rare, and probably unwise, they're not impossible.
What are the consequences?

I can't see truly bad ones.  If you want query-iothreads to identify
your monitors, just give them IDs!  That's why I'm doubting the need for
yet another monitor ID.

Note that entire issue goes away if we can make monitors QOM objects
before the interface becomes unchangable.

>> If it's not necessary, ignore the remainder of my review.
>>
>> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> > ---
>> >  chardev/char.c             |  2 +-
>> >  gdbstub/system.c           |  3 ++-
>> >  include/monitor/monitor.h  |  6 ++++--
>> >  monitor/hmp.c              | 20 +++++++++++++++++++-
>> >  monitor/monitor-internal.h |  2 ++
>> >  monitor/monitor.c          |  4 ++--
>> >  monitor/qmp.c              | 18 +++++++++++++++++-
>> >  stubs/monitor-internal.c   |  3 ++-
>> >  8 files changed, 49 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/chardev/char.c b/chardev/char.c
>> > index ca8b37ed8d..f057247001 100644
>> > --- a/chardev/char.c
>> > +++ b/chardev/char.c
>> > @@ -805,7 +805,7 @@ static Chardev *qemu_chr_new_from_name(const char =
*label, const char *filename,
>> >
>> >      if (qemu_opt_get_bool(opts, "mux", 0)) {
>> >          assert(permit_mux_mon);
>> > -        monitor_init_hmp(chr, true, &err);
>> > +        monitor_init_hmp(chr, true, NULL, &err);
>> >          if (err) {
>> >              error_report_err(err);
>> >              object_unparent(OBJECT(chr));
>> > diff --git a/gdbstub/system.c b/gdbstub/system.c
>> > index e86c5870ab..50f934fde3 100644
>> > --- a/gdbstub/system.c
>> > +++ b/gdbstub/system.c
>> > @@ -388,7 +388,8 @@ bool gdbserver_start(const char *device, Error **e=
rrp)
>> >          /* Initialize a monitor terminal for gdb */
>> >          mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
>> >                                     NULL, NULL, &error_abort);
>> > -        monitor_init_hmp(mon_chr, false, &error_abort);
>> > +
>> > +        monitor_init_hmp(mon_chr, false, NULL, &error_abort);
>> >      } else {
>> >          qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
>> >          mon_chr =3D gdbserver_system_state.mon_chr;
>> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
>> > index 55649a8664..c6ccd34cda 100644
>> > --- a/include/monitor/monitor.h
>> > +++ b/include/monitor/monitor.h
>> > @@ -19,11 +19,13 @@ bool monitor_cur_is_qmp(void);
>> >
>> >  void monitor_init_globals(void);
>> >  void monitor_init_globals_core(void);
>> > -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
>> > -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
>> > +void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Erro=
r **errp);
>> > +void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
>> > +                      Error **errp);
>> >  int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
>> >  int monitor_init_opts(QemuOpts *opts, Error **errp);
>> >  void monitor_cleanup(void);
>> > +char *monitor_get_id(void);
>> >
>> >  int monitor_suspend(Monitor *mon);
>> >  void monitor_resume(Monitor *mon);
>> > diff --git a/monitor/hmp.c b/monitor/hmp.c
>> > index cc4390486e..47f57f69e5 100644
>> > --- a/monitor/hmp.c
>> > +++ b/monitor/hmp.c
>> > @@ -43,6 +43,8 @@
>> >  #include "system/block-backend.h"
>> >  #include "trace.h"
>> >
>> > +static int mon_hmp_id_counter;
>> > +
>> >  static void monitor_command_cb(void *opaque, const char *cmdline,
>> >                                 void *readline_opaque)
>> >  {
>> > @@ -65,6 +67,14 @@ void monitor_read_command(MonitorHMP *mon, int show=
_prompt)
>> >      }
>> >  }
>> >
>> > +static char *monitor_hmp_get_id(void)
>> > +{
>> > +    int id =3D qatomic_fetch_inc(&mon_hmp_id_counter);
>>
>> Why atomic?  As far as I can see, this is only called during startup in
>> the main thread.  Even if we merge dynamic monitor creation, the monitor
>> command to create a monitor will also run in the main thread.
>
> Yes, you are right.
> Will change it to:
> int id =3D mon_hmp_id_counter++;
>
>
>>
>> > +    char *name =3D g_strdup_printf("mon_default_hmp_%d", id);
>>
>> Can clash with the user's monitor IDs.
>
> Just run it when the user didn't input thie monitor ID:
>
> +void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
> +                      Error **errp)
>  {
>      MonitorHMP *mon =3D g_new0(MonitorHMP, 1);
>
> +    if (!id) {
> +        g_autofree char *mon_id =3D  monitor_hmp_get_id();
> +        mon->common.id =3D g_strdup(mon_id);
> +    } else {
> +        mon->common.id =3D g_strdup(id);
> +    }

I'm not sure I was able to express myself with sufficient clarity, so
let me try again.

Something like

     -mon mode=3Dcontrol,chardev=3Dqmp2 -chardev socket,id=3Dqmp2,server=3D=
on,wait=3Doff,path=3Dtest-qmp

will make your code generate monitor-name "mon_default_qmp_0".

Something like

    -mon mode=3Dcontrol,chardev=3Dqmp2,id=3Dmon_default_qmp_0 -chardev sock=
et,id=3Dqmp2,server=3Don,wait=3Doff,path=3Dtest-qmp

will *also* produce monitor-name "mon_default_qmp_0".

Thus, your auto-generated monitor names can clash with the user's.
That's bad.


While testing this, I ran into a crash:

    $ qemu-system-x86_64 -S -nodefaults -display none -qmp stdio -mon mode=
=3Dcontrol,chardev=3Dqmp2 -chardev socket,id=3Dqmp2,server=3Don,wait=3Doff,=
path=3Dtest-qmp
    Segmentation fault         (core dumped) qemu-system-x86_64 -S -nodefau=
lts -display none -qmp stdio -mon mode=3Dcontrol,chardev=3Dqmp2 -chardev so=
cket,id=3Dqmp2,server=3Don,wait=3Doff,path=3Dtest-qmp

Stack backtrace:

    #0  0x0000555555f09eae in aio_bh_enqueue (bh=3D0x555557a18760, new_flag=
s=3D10)
        at ../util/async.c:95
    #1  0x0000555555f0a084 in aio_bh_schedule_oneshot_full
        (ctx=3D0x0, cb=3D0x555555df6733 <monitor_qmp_setup_handlers_bh>, op=
aque=3D0x555557791cc0, name=3D0x55555648240f "monitor_qmp_setup_handlers_bh=
")
        at ../util/async.c:141
    #2  0x0000555555df69bf in monitor_init_qmp
        (chr=3D0x555557a17e60, pretty=3Dfalse, id=3D0x0, errp=3D0x7fffffffd=
860)
        at ../monitor/qmp.c:569
    #3  0x0000555555df4e73 in monitor_init
        (opts=3D0x555557a18c60, allow_hmp=3Dtrue, errp=3D0x7fffffffd860)
        at ../monitor/monitor.c:751
    #4  0x0000555555df5028 in monitor_init_opts
        (opts=3D0x555557790600, errp=3D0x555557646870 <error_fatal>)
        at ../monitor/monitor.c:784
    #5  0x0000555555a668fb in mon_init_func
        (opaque=3D0x0, opts=3D0x555557790600, errp=3D0x555557646870 <error_=
fatal>)
        at ../system/vl.c:1249
    #6  0x0000555555efb375 in qemu_opts_foreach
        (list=3D0x555557517da0 <qemu_mon_opts>, func=3D0x555555a668d4 <mon_=
init_func>, opaque=3D0x0, errp=3D0x555557646870 <error_fatal>) at ../util/q=
emu-option.c:1148
    #7  0x0000555555a68e1c in qemu_create_late_backends () at ../system/vl.=
c:2117
    #8  0x0000555555a6e1e2 in qemu_init (argc=3D11, argv=3D0x7fffffffdc98)
        at ../system/vl.c:3822
    #9  0x0000555555e170a8 in main (argc=3D11, argv=3D0x7fffffffdc98)
        at ../system/main.c:71

I did not bisect to find the commit that breaks this.

[...]


