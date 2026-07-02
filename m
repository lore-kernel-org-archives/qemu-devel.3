Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70181C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHC6-0007TM-2Q; Thu, 02 Jul 2026 09:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfHC4-0007Sy-15
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfHC0-000626-R0
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782997858;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3vgRq6beZepQVfinCafFcx9OLUjR6eiaENnfMnPJOY=;
 b=ahOGQ0Y3sv0xMUZMEBkCABhn+uGDP/3MHwHpGesexWH7bpfXjCyg6K8ULeh3/b3uRhNTYB
 j1rlJutRGTfJ6k/ebUTuI/bQtmfH6jym9e8zPPPWF0azFp8hReI9w15iCgfOk7OJafAtub
 W2rqsJoCdNuP1tjlPoscyQPxlMdxHmA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-75f2G2CCNVOXI0Z_bN2gsw-1; Thu,
 02 Jul 2026 09:10:55 -0400
X-MC-Unique: 75f2G2CCNVOXI0Z_bN2gsw-1
X-Mimecast-MFC-AGG-ID: 75f2G2CCNVOXI0Z_bN2gsw_1782997853
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B93518333A0; Thu,  2 Jul 2026 13:10:53 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.186])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A330336F04; Thu,  2 Jul 2026 13:10:49 +0000 (UTC)
Date: Thu, 2 Jul 2026 14:10:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v5 05/35] monitor: minimal conversion of monitors to QOM
Message-ID: <akZjVg5qKkkopoc7@redhat.com>
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-6-berrange@redhat.com>
 <87o6gs1buf.fsf@pond.sub.org> <akO58EjJf3xs4KmU@redhat.com>
 <87tsqi4zk6.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tsqi4zk6.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 01, 2026 at 03:19:53PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Jun 30, 2026 at 01:55:52PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > This introduces a Monitor QOM object, with MonitorHMP and
> >> > MonitorQMP subclasses. This is the bare minimum conversion
> >> > of just the type declarations and replacing g_new/g_free
> >> > with object_new/object_unref.
> >> >
> >> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> >> > Tested-by: Peter Krempa <pkrempa@redhat.com>
> >> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> > ---
> >> >  include/monitor/monitor.h  | 11 ++++++++++-
> >> >  monitor/hmp.c              | 29 +++++++++++++++++++++++++++--
> >> >  monitor/monitor-internal.h | 18 ++++++++++++++++--
> >> >  monitor/monitor.c          | 18 ++++++++++++++++--
> >> >  monitor/qmp-cmds.c         | 15 ++++++++-------
> >> >  monitor/qmp.c              | 29 +++++++++++++++++++++++++++--
> >> >  6 files changed, 104 insertions(+), 16 deletions(-)
> >> >
> >> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> >> > index b9642b58ba..2e9f9e12e9 100644
> >> > --- a/include/monitor/monitor.h
> >> > +++ b/include/monitor/monitor.h
> >> > @@ -5,8 +5,17 @@
> >> >  #include "qapi/qapi-types-misc.h"
> >> >  #include "qemu/readline.h"
> >> >  #include "exec/hwaddr.h"
> >> > +#include "qom/object.h"
> >> > +
> >> > +#define TYPE_MONITOR "monitor"
> >> > +OBJECT_DECLARE_TYPE(Monitor, MonitorClass, MONITOR);
> >> > +
> >> > +#define TYPE_MONITOR_HMP "monitor-hmp"
> >> > +OBJECT_DECLARE_TYPE(MonitorHMP, MonitorHMPClass, MONITOR_HMP);
> >> > +
> >> > +#define TYPE_MONITOR_QMP "monitor-qmp"
> >> > +OBJECT_DECLARE_TYPE(MonitorQMP, MonitorQMPClass, MONITOR_QMP);
> >> >  
> >> > -typedef struct MonitorHMP MonitorHMP;
> >> >  typedef struct MonitorOptions MonitorOptions;
> >> >  
> >> >  #define QMP_REQ_QUEUE_LEN_MAX 8
> >> > diff --git a/monitor/hmp.c b/monitor/hmp.c
> >> > index 4e4468424a..81047d2513 100644
> >> > --- a/monitor/hmp.c
> >> > +++ b/monitor/hmp.c
> >> > @@ -43,6 +43,20 @@
> >> >  #include "system/block-backend.h"
> >> >  #include "trace.h"
> >> >  
> >> > +OBJECT_DEFINE_TYPE(MonitorHMP, monitor_hmp, MONITOR_HMP, MONITOR);
> >> > +
> >> > +static void monitor_hmp_finalize(Object *obj)
> >> > +{
> >> > +}
> >> > +
> >> > +static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
> >> > +{
> >> > +}
> >> > +
> >> > +static void monitor_hmp_init(Object *obj)
> >> > +{
> >> > +}
> >> > +
> >> >  static void monitor_command_cb(void *opaque, const char *cmdline,
> >> >                                 void *readline_opaque)
> >> >  {
> >> > @@ -1526,10 +1540,21 @@ static void monitor_readline_flush(void *opaque)
> >> >  
> >> >  void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
> >> >  {
> >> > -    MonitorHMP *mon = g_new0(MonitorHMP, 1);
> >> > +    MonitorHMP *mon;
> >> > +    static int counter;
> >> > +    g_autofree char *id = g_strdup_printf("hmpcompat%d", counter++);
> >> 
> >> Hmm.  The system picking IDs is problematic when they can clash with the
> >> user's IDs.  If we had an ounce of common sense, we'd restrict both
> >> across the board so they cannot clash.  But we don't.
> >> 
> >> We need an ID here, because we need to make the new object the child of
> >> something (actually: child of /objects/), which requires a child name.
> >> 
> >> Non-problem with -object / object-add, because @id is mandatory there.
> >> 
> >> Non-problem with -device / device_add, because we use separate parents
> >> for devices with and without @id (/machine/peripheral/ and
> >> /machine/peripheral-anon/, plus the /machine/unattached/ orphanage).
> >> 
> >> Example for an existing problem:
> >> 
> >>     $ qemu-system-x86_64 -nodefaults -monitor stdio -chardev null,id=chr0 -mon id=compat_monitor0,chardev=chr0
> >>     qemu-system-x86_64: -mon id=compat_monitor0,chardev=chr0: Duplicate ID 'compat_monitor0' for mon
> >> 
> >> Example for a problem created by this series:
> >> 
> >>     $  qemu-system-x86_64 -nodefaults -display none -S -monitor stdio -chardev null,id=chr0 -object monitor-hmp,id=hmpcompat0,chardev=chr0
> >>     qemu-system-x86_64: -monitor stdio: attempt to add duplicate property 'hmpcompat0' to object (type 'container')
> >> 
> >> I readily admit that these clashes are *unlikely*.  Still, do we really
> >> want to define an interface that claims to let you pick any ID, then
> >> rejects some of them sometimes?  Feels rather 1990s to me.  At the very
> >> least, cover the wart in the commit message.
> >
> > The way I looked at it was aything using -object with the new
> > monitor-qmp/monitor-hmp types is new code. They can:
> >
> >   1. Trivially abide the warning about "hmpcompatNN" / "qmpcompatNN"
> >      being internal usage for compat syntax
> 
> A wart you can easily cope with is still a wart.  Oh well, we'll live.
> However, the wart should be documented.
> 
> >   2. Not use both  -monitor and -object on the same QEMU instance
> >      so not have a clash between the two to begin with
> 
> Management applications aware of the monitor QOM types should use
> -object / object-add exclusively.
> 
> Human users will use -monitor to save typing.  If they then need to plug
> an additional one at run time, they have no choice but use object-add.
> Again, we'll live.
> 
> > The remaining danger where is some existing code using -object with
> > a *non-monitor* type, and calling it "hmpcompatNN" / "qmpcompatNN",
> > which would be insanity. Never say never, but I think that's an
> > acceptable risk.
> 
> The risk is acceptable.  The documentation complexity that comes with
> the wart bothers me.
> 
> Could we use id_generate()?

Since we want to re-use the QemuOpts ID present in -monitor/-qmp,
I'm going to stick with "compat_monitorNNN" and get rid of
use of 'hmpcompatNN' and 'qmpcompatNN'.  id_generate() does not
help here because it forces a "#" prefix onto the ID which then
(intentionally) violates  id_wellformed() which object_new_xxx()
validates.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


