Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7011CF9D0EB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wChy6-00084t-7s; Tue, 14 Apr 2026 13:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wChy4-00084c-S0; Tue, 14 Apr 2026 13:54:32 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wChy2-0007L8-9C; Tue, 14 Apr 2026 13:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=PxUhdip49swQqkNn6XuQCXGuW4+JpuohqrVIazY77Ew=; b=fxmm0RzQWgJt3tI6
 8P0SLy+MZzpXRDdzVNox/OtjTsIxLajLSc5jO6MFeweWjfJqViEZ8I2/DKzEJqREFtETh521fMoOj
 XTNRy6526pXAtDZxy7ODamZLPL1meQE9GFNcNIBZyIfQSx0CWdLnOMvQ452aZ32jkRJDhgtirR8i8
 icEpUH/Msw6NKTZqwo7fzhnJx+mn2A6tmM8x7w8WHzymSmBjEhfrP9SkGyatbMVVKNaL1ssrdDoJj
 0C40NBGIOvUTto0BXKthsV/iR0fOinoTuDoG0vsZwkqy0KA5SJN8m4Rl1eRtVY9BTxvbaqh6nH0j6
 obMcWXAWc9mHRKRW+A==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wChxw-00000008KNM-07cc;
 Tue, 14 Apr 2026 17:54:24 +0000
Date: Tue, 14 Apr 2026 17:54:23 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 02/17] monitor: replace 'common' with 'parent' in
 MonitorQMP
Message-ID: <ad5_T21lwOD8Lf9m@gallifrey>
References: <20260410160458.3778874-1-berrange@redhat.com>
 <20260410160458.3778874-3-berrange@redhat.com>
 <db93e5db-92f7-445d-b1a7-b2be39a9a059@nutanix.com>
 <ad5ccvLw2XpdEn7-@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad5ccvLw2XpdEn7-@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 17:53:17 up 32 days, 19:06,  2 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Tue, Apr 14, 2026 at 04:15:42PM +0100, Mark Cave-Ayland wrote:
> > On 10/04/2026 17:04, Daniel P. Berrangé wrote:
> > 
> > > The field name 'parent' is standard practice for QOM structs
> > > so align the QMP monitor.
> > 
> > This is not correct: the first field of a QOM object struct should be called
> > parent_obj, followed by an empty line as per our style guidelines at https://qemu.readthedocs.io/en/master/devel/style.html#qemu-object-model-declarations.
> 
> Sigh, of course we're massively inconsistent in this :-(

Because it's all manual!
It needs macro'ing, and linting.

Dave

> I initially just checked 1st level objects, which favours 'parent'
> 
>   $ git grep 'Object parent;' | wc -l
>   34
>   $ git grep 'Object parent_obj;' | wc -l
>   18
> 
> but I should have checked more deeply
> 
>  $ git grep -E '(\w+) parent_obj;'  | wc -l
>  859
>  $ git grep -E '(\w+) parent;'  | wc -l
>  269
> 
> I'll switch to 'parent_obj' here.
> 
> > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > ---
> > >   monitor/monitor-internal.h |  2 +-
> > >   monitor/monitor.c          |  4 ++--
> > >   monitor/qmp-cmds-control.c |  4 ++--
> > >   monitor/qmp.c              | 40 +++++++++++++++++++-------------------
> > >   4 files changed, 25 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > > index ae0cf8c1da..0922588ad9 100644
> > > --- a/monitor/monitor-internal.h
> > > +++ b/monitor/monitor-internal.h
> > > @@ -132,7 +132,7 @@ struct MonitorHMP {
> > >   };
> > >   typedef struct {
> > > -    Monitor common;
> > > +    Monitor parent;
> > >       JSONMessageParser parser;
> > >       bool pretty;
> > >       /*
> > > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > > index 6532796edb..6b183edcf5 100644
> > > --- a/monitor/monitor.c
> > > +++ b/monitor/monitor.c
> > > @@ -308,7 +308,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
> > >               continue;
> > >           }
> > > -        qmp_mon = container_of(mon, MonitorQMP, common);
> > > +        qmp_mon = container_of(mon, MonitorQMP, parent);
> > >           {
> > >               QEMU_LOCK_GUARD(&mon->mon_lock);
> > >               if (qmp_mon->commands == &qmp_cap_negotiation_commands) {
> > > @@ -625,7 +625,7 @@ void monitor_data_destroy(Monitor *mon)
> > >       g_free(mon->mon_cpu_path);
> > >       qemu_chr_fe_deinit(&mon->chr, false);
> > >       if (monitor_is_qmp(mon)) {
> > > -        monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
> > > +        monitor_data_destroy_qmp(container_of(mon, MonitorQMP, parent));
> > >       } else {
> > >           readline_free(container_of(mon, MonitorHMP, parent)->rs);
> > >       }
> > > diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
> > > index 150ca9f5cb..ca471bc1c7 100644
> > > --- a/monitor/qmp-cmds-control.c
> > > +++ b/monitor/qmp-cmds-control.c
> > > @@ -76,7 +76,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
> > >       MonitorQMP *mon;
> > >       assert(monitor_is_qmp(cur_mon));
> > > -    mon = container_of(cur_mon, MonitorQMP, common);
> > > +    mon = container_of(cur_mon, MonitorQMP, parent);
> > >       if (mon->commands == &qmp_commands) {
> > >           error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
> > > @@ -126,7 +126,7 @@ CommandInfoList *qmp_query_commands(Error **errp)
> > >       MonitorQMP *mon;
> > >       assert(monitor_is_qmp(cur_mon));
> > > -    mon = container_of(cur_mon, MonitorQMP, common);
> > > +    mon = container_of(cur_mon, MonitorQMP, parent);
> > >       qmp_for_each_command(mon->commands, query_commands_cb, &list);
> > > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > > index 687019811f..69d9e40e32 100644
> > > --- a/monitor/qmp.c
> > > +++ b/monitor/qmp.c
> > > @@ -80,7 +80,7 @@ static void monitor_qmp_caps_reset(MonitorQMP *mon)
> > >   {
> > >       memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
> > >       memset(mon->capab, 0, sizeof(mon->capab));
> > > -    mon->capab_offered[QMP_CAPABILITY_OOB] = mon->common.use_io_thread;
> > > +    mon->capab_offered[QMP_CAPABILITY_OOB] = mon->parent.use_io_thread;
> > >   }
> > >   static void qmp_request_free(QMPRequest *req)
> > > @@ -124,7 +124,7 @@ static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
> > >            * when we get here while the monitor is suspended.  An
> > >            * unfortunately timed CHR_EVENT_CLOSED can do the trick.
> > >            */
> > > -        monitor_resume(&mon->common);
> > > +        monitor_resume(&mon->parent);
> > >       }
> > >   }
> > > @@ -139,7 +139,7 @@ void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
> > >       trace_monitor_qmp_respond(mon, json->str);
> > >       g_string_append_c(json, '\n');
> > > -    monitor_puts(&mon->common, json->str);
> > > +    monitor_puts(&mon->parent, json->str);
> > >       g_string_free(json, true);
> > >   }
> > > @@ -166,7 +166,7 @@ static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
> > >       QDict *error;
> > >       rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon),
> > > -                       &mon->common);
> > > +                       &mon->parent);
> > >       if (mon->commands == &qmp_cap_negotiation_commands) {
> > >           error = qdict_get_qdict(rsp, "error");
> > > @@ -207,7 +207,7 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
> > >               continue;
> > >           }
> > > -        qmp_mon = container_of(mon, MonitorQMP, common);
> > > +        qmp_mon = container_of(mon, MonitorQMP, parent);
> > >           qemu_mutex_lock(&qmp_mon->qmp_queue_lock);
> > >           req_obj = g_queue_pop_head(qmp_mon->qmp_requests);
> > >           if (req_obj) {
> > > @@ -302,7 +302,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
> > >           oob_enabled = qmp_oob_enabled(mon);
> > >           if (oob_enabled
> > >               && mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
> > > -            monitor_resume(&mon->common);
> > > +            monitor_resume(&mon->parent);
> > >           }
> > >           /*
> > > @@ -343,7 +343,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
> > >           }
> > >           if (!oob_enabled) {
> > > -            monitor_resume(&mon->common);
> > > +            monitor_resume(&mon->parent);
> > >           }
> > >           qmp_request_free(req_obj);
> > > @@ -408,7 +408,7 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
> > >            */
> > >           if (!qmp_oob_enabled(mon) ||
> > >               mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
> > > -            monitor_suspend(&mon->common);
> > > +            monitor_suspend(&mon->parent);
> > >           }
> > >           /*
> > > @@ -462,7 +462,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
> > >       switch (event) {
> > >       case CHR_EVENT_OPENED:
> > > -        WITH_QEMU_LOCK_GUARD(&mon->common.mon_lock) {
> > > +        WITH_QEMU_LOCK_GUARD(&mon->parent.mon_lock) {
> > >               mon->commands = &qmp_cap_negotiation_commands;
> > >               monitor_qmp_caps_reset(mon);
> > >           }
> > > @@ -504,27 +504,27 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
> > >       MonitorQMP *mon = opaque;
> > >       GMainContext *context;
> > > -    assert(mon->common.use_io_thread);
> > > +    assert(mon->parent.use_io_thread);
> > >       context = iothread_get_g_main_context(mon_iothread);
> > >       assert(context);
> > > -    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
> > > +    qemu_chr_fe_set_handlers(&mon->parent.chr, monitor_can_read,
> > >                                monitor_qmp_read, monitor_qmp_event,
> > > -                             NULL, &mon->common, context, true);
> > > -    monitor_list_append(&mon->common);
> > > +                             NULL, &mon->parent, context, true);
> > > +    monitor_list_append(&mon->parent);
> > >   }
> > >   void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
> > >   {
> > >       MonitorQMP *mon = g_new0(MonitorQMP, 1);
> > > -    if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
> > > +    if (!qemu_chr_fe_init(&mon->parent.chr, chr, errp)) {
> > >           g_free(mon);
> > >           return;
> > >       }
> > > -    qemu_chr_fe_set_echo(&mon->common.chr, true);
> > > +    qemu_chr_fe_set_echo(&mon->parent.chr, true);
> > >       /* Note: we run QMP monitor in I/O thread when @chr supports that */
> > > -    monitor_data_init(&mon->common, true, false,
> > > +    monitor_data_init(&mon->parent, true, false,
> > >                         qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
> > >       mon->pretty = pretty;
> > > @@ -533,7 +533,7 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
> > >       mon->qmp_requests = g_queue_new();
> > >       json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL);
> > > -    if (mon->common.use_io_thread) {
> > > +    if (mon->parent.use_io_thread) {
> > >           /*
> > >            * Make sure the old iowatch is gone.  It's possible when
> > >            * e.g. the chardev is in client mode, with wait=on.
> > > @@ -553,9 +553,9 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
> > >                                   monitor_qmp_setup_handlers_bh, mon);
> > >           /* The bottom half will add @mon to @mon_list */
> > >       } else {
> > > -        qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
> > > +        qemu_chr_fe_set_handlers(&mon->parent.chr, monitor_can_read,
> > >                                    monitor_qmp_read, monitor_qmp_event,
> > > -                                 NULL, &mon->common, NULL, true);
> > > -        monitor_list_append(&mon->common);
> > > +                                 NULL, &mon->parent, NULL, true);
> > > +        monitor_list_append(&mon->parent);
> > >       }
> > >   }
> > 
> > 
> > ATB,
> > 
> > Mark.
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

