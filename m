Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049A3EBFD2F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCE62-0004Ke-Sq; Mon, 13 Apr 2026 06:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCE5y-0004IL-5h
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCE5r-0003bI-KD
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776074433;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8IIXypvTFSbFFYLtuWzV10yJ6eGgj1z63sXTkL82/k=;
 b=b0TW/LslGIcPYly6ku7Aj/ZjtntyzLbA//28khPp9TDBKUkPa6WpnDSm+TdwOB4Dju4OqT
 Bksp4Dy5ZqnXHmtlIy4fs6MXsgb6PulHtP8oBwvsOevK5Rleu4Z6862Ao7d18uzU7bI9Ye
 TIOflf+Fcdq0ap6L8f/pjgyiFfydqiE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-ebbZnXXwOMCbVKfj6N9NWg-1; Mon,
 13 Apr 2026 06:00:29 -0400
X-MC-Unique: ebbZnXXwOMCbVKfj6N9NWg-1
X-Mimecast-MFC-AGG-ID: ebbZnXXwOMCbVKfj6N9NWg_1776074428
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E3021800741; Mon, 13 Apr 2026 10:00:28 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF8181800594; Mon, 13 Apr 2026 10:00:24 +0000 (UTC)
Date: Mon, 13 Apr 2026 11:00:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 05/17] monitor: remove 'skip_flush' field
Message-ID: <ady-tRaiip62s_l6@redhat.com>
References: <20260410160458.3778874-1-berrange@redhat.com>
 <20260410160458.3778874-6-berrange@redhat.com>
 <adxGrbCi4LfS0lsT@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adxGrbCi4LfS0lsT@gallifrey>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Apr 13, 2026 at 01:28:13AM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > The 'skip_flush' field is set on the dummy throwaway HMP monitor
> > object created by QMP's  'human-monitor-command', as an indication
> > not to try to write data to the chardev. Instead the QMP command
> > impl will grab the data straight out of the in-memory buffer.
> > 
> > The flag is redundant, however, as the monitor code could instead
> > simply check the 'fe_is_open' field on the CharFrontend, which
> > will be false in the same scenarios that 'skip_flush' is true.
> 
> For monitors on sockets where the other end isn't connected, does that
> change the behaviour?   Does that also have !fe_is_open and can that hit this
> case?

The only place that sets fe_is_open is qemu_chr_fe_set_open,
which is called by qemu_chr_fe_set_handlers_full.

IOW, it merely reflects the fact that some frontend (the
monitor in this case) and configured the chardev for use,
and is separate from any notion of whether the chardev
backend is open/connected.



> 
> Dave
> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  monitor/hmp.c              |  2 +-
> >  monitor/monitor-internal.h |  4 +---
> >  monitor/monitor.c          | 11 +++++++----
> >  monitor/qmp-cmds.c         |  2 +-
> >  monitor/qmp.c              |  2 +-
> >  5 files changed, 11 insertions(+), 10 deletions(-)
> > 
> > diff --git a/monitor/hmp.c b/monitor/hmp.c
> > index 614d9a3707..72f8303662 100644
> > --- a/monitor/hmp.c
> > +++ b/monitor/hmp.c
> > @@ -1539,7 +1539,7 @@ void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
> >          return;
> >      }
> >  
> > -    monitor_data_init(&mon->parent, false, false, false);
> > +    monitor_data_init(&mon->parent, false, false);
> >  
> >      mon->use_readline = use_readline;
> >      if (mon->use_readline) {
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index 25320928a7..84117805b7 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -102,7 +102,6 @@ struct Monitor {
> >      CharFrontend chr;
> >      int suspend_cnt;            /* Needs to be accessed atomically */
> >      bool is_qmp;
> > -    bool skip_flush;
> >      bool use_io_thread;
> >  
> >      char *mon_cpu_path;
> > @@ -183,8 +182,7 @@ extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
> >  extern QemuMutex monitor_lock;
> >  extern MonitorList mon_list;
> >  
> > -void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
> > -                       bool use_io_thread);
> > +void monitor_data_init(Monitor *mon, bool is_qmp, bool use_io_thread);
> >  void monitor_data_destroy(Monitor *mon);
> >  int monitor_can_read(void *opaque);
> >  void monitor_list_append(Monitor *mon);
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index 7936e2ab22..f7e3708d2f 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -167,7 +167,12 @@ void monitor_flush_locked(Monitor *mon)
> >      size_t len;
> >      const char *buf;
> >  
> > -    if (mon->skip_flush) {
> > +    /*
> > +     * When used by QMP human-monitor-command, no chardev
> > +     * will be connected, as we want to just collect the
> > +     * output in the buffer
> > +     */
> > +    if (!mon->chr.fe_is_open) {
> >          return;
> >      }
> >  
> > @@ -621,8 +626,7 @@ static void monitor_iothread_init(void)
> >      mon_iothread = iothread_create("mon_iothread", &error_abort);
> >  }
> >  
> > -void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
> > -                       bool use_io_thread)
> > +void monitor_data_init(Monitor *mon, bool is_qmp, bool use_io_thread)
> >  {
> >      if (use_io_thread && !mon_iothread) {
> >          monitor_iothread_init();
> > @@ -630,7 +634,6 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
> >      qemu_mutex_init(&mon->mon_lock);
> >      mon->is_qmp = is_qmp;
> >      mon->outbuf = g_string_new(NULL);
> > -    mon->skip_flush = skip_flush;
> >      mon->use_io_thread = use_io_thread;
> >  }
> >  
> > diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> > index d0ed241d6a..be2bd985b7 100644
> > --- a/monitor/qmp-cmds.c
> > +++ b/monitor/qmp-cmds.c
> > @@ -168,7 +168,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
> >      char *output = NULL;
> >      MonitorHMP *hmp = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
> >  
> > -    monitor_data_init(&hmp->parent, false, true, false);
> > +    monitor_data_init(&hmp->parent, false, false);
> >  
> >      if (has_cpu_index) {
> >          int ret = monitor_set_cpu(&hmp->parent, cpu_index);
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index 36cb078f30..fe2aec9ce9 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -538,7 +538,7 @@ void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
> >      qemu_chr_fe_set_echo(&mon->parent.chr, true);
> >  
> >      /* Note: we run QMP monitor in I/O thread when @chr supports that */
> > -    monitor_data_init(&mon->parent, true, false,
> > +    monitor_data_init(&mon->parent, true,
> >                        qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
> >  
> >      mon->pretty = pretty;
> > -- 
> > 2.53.0
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


