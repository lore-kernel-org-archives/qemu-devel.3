Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB784C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weurI-0007OW-1s; Wed, 01 Jul 2026 09:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weurF-0007O3-Qa
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:20:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weurD-0007Qt-RN
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782912002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UY+ggtfc1Juk7+p1n//cnya+72sLhLRGEub5NzeKu2Q=;
 b=TvVvqLChuOhG9R0W3KKD+dgD22SEkqDvxRSXpVB3eGyiAzctjfNX6MUGu1ZBQmAcmhRgQ2
 dFW8iqz71XrbLQVGU2UPJcdsDtXty6dssegTx1LQAkMiZ+Z3TOiZOOATpltZkGwXIKJFxw
 xALonsK7svwyuGyImvEOZ8dMEUD5ay8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-jWtxGS7WPT2i4zmDHJIpDA-1; Wed,
 01 Jul 2026 09:19:58 -0400
X-MC-Unique: jWtxGS7WPT2i4zmDHJIpDA-1
X-Mimecast-MFC-AGG-ID: jWtxGS7WPT2i4zmDHJIpDA_1782911997
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF0421944DFF; Wed,  1 Jul 2026 13:19:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 126BE1955D53; Wed,  1 Jul 2026 13:19:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ADD8F21E6920; Wed, 01 Jul 2026 15:19:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 devel@lists.libvirt.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Peter Krempa
 <pkrempa@redhat.com>
Subject: Re: [PATCH v5 05/35] monitor: minimal conversion of monitors to QOM
In-Reply-To: <akO58EjJf3xs4KmU@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 30 Jun 2026 13:43:28 +0100")
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-6-berrange@redhat.com>
 <87o6gs1buf.fsf@pond.sub.org> <akO58EjJf3xs4KmU@redhat.com>
Date: Wed, 01 Jul 2026 15:19:53 +0200
Message-ID: <87tsqi4zk6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jun 30, 2026 at 01:55:52PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > This introduces a Monitor QOM object, with MonitorHMP and
>> > MonitorQMP subclasses. This is the bare minimum conversion
>> > of just the type declarations and replacing g_new/g_free
>> > with object_new/object_unref.
>> >
>> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > Tested-by: Peter Krempa <pkrempa@redhat.com>
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  include/monitor/monitor.h  | 11 ++++++++++-
>> >  monitor/hmp.c              | 29 +++++++++++++++++++++++++++--
>> >  monitor/monitor-internal.h | 18 ++++++++++++++++--
>> >  monitor/monitor.c          | 18 ++++++++++++++++--
>> >  monitor/qmp-cmds.c         | 15 ++++++++-------
>> >  monitor/qmp.c              | 29 +++++++++++++++++++++++++++--
>> >  6 files changed, 104 insertions(+), 16 deletions(-)
>> >
>> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
>> > index b9642b58ba..2e9f9e12e9 100644
>> > --- a/include/monitor/monitor.h
>> > +++ b/include/monitor/monitor.h
>> > @@ -5,8 +5,17 @@
>> >  #include "qapi/qapi-types-misc.h"
>> >  #include "qemu/readline.h"
>> >  #include "exec/hwaddr.h"
>> > +#include "qom/object.h"
>> > +
>> > +#define TYPE_MONITOR "monitor"
>> > +OBJECT_DECLARE_TYPE(Monitor, MonitorClass, MONITOR);
>> > +
>> > +#define TYPE_MONITOR_HMP "monitor-hmp"
>> > +OBJECT_DECLARE_TYPE(MonitorHMP, MonitorHMPClass, MONITOR_HMP);
>> > +
>> > +#define TYPE_MONITOR_QMP "monitor-qmp"
>> > +OBJECT_DECLARE_TYPE(MonitorQMP, MonitorQMPClass, MONITOR_QMP);
>> >=20=20
>> > -typedef struct MonitorHMP MonitorHMP;
>> >  typedef struct MonitorOptions MonitorOptions;
>> >=20=20
>> >  #define QMP_REQ_QUEUE_LEN_MAX 8
>> > diff --git a/monitor/hmp.c b/monitor/hmp.c
>> > index 4e4468424a..81047d2513 100644
>> > --- a/monitor/hmp.c
>> > +++ b/monitor/hmp.c
>> > @@ -43,6 +43,20 @@
>> >  #include "system/block-backend.h"
>> >  #include "trace.h"
>> >=20=20
>> > +OBJECT_DEFINE_TYPE(MonitorHMP, monitor_hmp, MONITOR_HMP, MONITOR);
>> > +
>> > +static void monitor_hmp_finalize(Object *obj)
>> > +{
>> > +}
>> > +
>> > +static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
>> > +{
>> > +}
>> > +
>> > +static void monitor_hmp_init(Object *obj)
>> > +{
>> > +}
>> > +
>> >  static void monitor_command_cb(void *opaque, const char *cmdline,
>> >                                 void *readline_opaque)
>> >  {
>> > @@ -1526,10 +1540,21 @@ static void monitor_readline_flush(void *opaqu=
e)
>> >=20=20
>> >  void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
>> >  {
>> > -    MonitorHMP *mon =3D g_new0(MonitorHMP, 1);
>> > +    MonitorHMP *mon;
>> > +    static int counter;
>> > +    g_autofree char *id =3D g_strdup_printf("hmpcompat%d", counter++);
>>=20
>> Hmm.  The system picking IDs is problematic when they can clash with the
>> user's IDs.  If we had an ounce of common sense, we'd restrict both
>> across the board so they cannot clash.  But we don't.
>>=20
>> We need an ID here, because we need to make the new object the child of
>> something (actually: child of /objects/), which requires a child name.
>>=20
>> Non-problem with -object / object-add, because @id is mandatory there.
>>=20
>> Non-problem with -device / device_add, because we use separate parents
>> for devices with and without @id (/machine/peripheral/ and
>> /machine/peripheral-anon/, plus the /machine/unattached/ orphanage).
>>=20
>> Example for an existing problem:
>>=20
>>     $ qemu-system-x86_64 -nodefaults -monitor stdio -chardev null,id=3Dc=
hr0 -mon id=3Dcompat_monitor0,chardev=3Dchr0
>>     qemu-system-x86_64: -mon id=3Dcompat_monitor0,chardev=3Dchr0: Duplic=
ate ID 'compat_monitor0' for mon
>>=20
>> Example for a problem created by this series:
>>=20
>>     $  qemu-system-x86_64 -nodefaults -display none -S -monitor stdio -c=
hardev null,id=3Dchr0 -object monitor-hmp,id=3Dhmpcompat0,chardev=3Dchr0
>>     qemu-system-x86_64: -monitor stdio: attempt to add duplicate propert=
y 'hmpcompat0' to object (type 'container')
>>=20
>> I readily admit that these clashes are *unlikely*.  Still, do we really
>> want to define an interface that claims to let you pick any ID, then
>> rejects some of them sometimes?  Feels rather 1990s to me.  At the very
>> least, cover the wart in the commit message.
>
> The way I looked at it was aything using -object with the new
> monitor-qmp/monitor-hmp types is new code. They can:
>
>   1. Trivially abide the warning about "hmpcompatNN" / "qmpcompatNN"
>      being internal usage for compat syntax

A wart you can easily cope with is still a wart.  Oh well, we'll live.
However, the wart should be documented.

>   2. Not use both  -monitor and -object on the same QEMU instance
>      so not have a clash between the two to begin with

Management applications aware of the monitor QOM types should use
-object / object-add exclusively.

Human users will use -monitor to save typing.  If they then need to plug
an additional one at run time, they have no choice but use object-add.
Again, we'll live.

> The remaining danger where is some existing code using -object with
> a *non-monitor* type, and calling it "hmpcompatNN" / "qmpcompatNN",
> which would be insanity. Never say never, but I think that's an
> acceptable risk.

The risk is acceptable.  The documentation complexity that comes with
the wart bothers me.

Could we use id_generate()?

>> This existing problem example leads me to the next mess: interaction
>> with monitors' *other* ID.
>>=20
>> qemu-system-FOO's -mon accepts an optional "id" parameter.  It goes into
>> its QemuOpts, and from there into MonitorOptions member @id.
>
> Arrrggggggghh.  That is not documented for -mon at all AFAICT
>
>   $ qemu-system-x86_64  -help 2>&1 | grep -- -mon
>   -monitor dev    redirect the monitor to char device 'dev'
>   -qmp dev        like -monitor but opens in 'control' mode
>   -mon [chardev=3D]name[,mode=3Dreadline|control][,pretty[=3Don|off]]
>
> but yeah as you say, it exists, and in fact libvirt even uses
> it despite it being undocumented.
>
>> qemu-storage-daemon's --monitor is similar, except it bypasses QemuOpts.
>>=20
>> qemu-system-FOO provides convenience options -monitor, -qmp,
>> -qmp-pretty.
>>=20
>> Their argument may refer to an existing chardev by ID, like
>> "chardev:ID".  This creates a monitor with that same[*] QemuOpts and
>> MonitorOptions ID.
>>=20
>> Else, their argument is character device configuration in legacy syntax,
>> like "stdio".  This creates both a monitor and a character device, with
>> ID "compat_monitorN", where N counts up from zero.  The character device
>> is visible in "info chardev", as always.
>>=20
>> Aside: in both cases we use the same ID for two different objects, which
>> feels unadvisable.
>
> Agreed, that's awful.
>
>> Aside: we have code checking whether a QemuOpts or character device ID
>> starts with "compat_monitor", which is horryfying.
>
> Eww.
>
>> Your series does not mess with this at all.  Understandable; I stay out
>> of this swamp when I can, too.
>
> I didn't realize the swap was there in this case !

Hope you brought insect repellent!

>> However, it results in monitors having two IDs, namely the one in
>> MonitorOptions, and the one in /object/.  This is confusing.
>>=20
>> Perhaps we should we'd get rid of the one in MonitorOptions.  May well
>> be more trouble than it's worth.
>>=20
>> Could we at least make the two IDs the same?
>
> Since -mon has an existing ID, we might as well pass it through to
> use as the child prop name for the objects.

Makes sense.

[...]


