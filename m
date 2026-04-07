Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F13FF513B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 21:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wADYZ-0005Ye-TS; Tue, 07 Apr 2026 17:01:55 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wADYY-0005YK-Mo
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:01:54 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wADWQ-0001Ph-IU
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 16:59:43 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 00759600AC;
 Tue,  7 Apr 2026 20:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7332DC116C6;
 Tue,  7 Apr 2026 20:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775595581;
 bh=i38PdCOospeuZ97BtU06FHd3FUy6qM5rW3XcNazdeJ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MYYKYD+OBRWFWRpnqS3BCf90+Rud0g27Ap/F1mlIDtu4AD94v8FOklJNl+f5PjkWh
 5vHy9Jn/QhyfqWpIGl3ETtLOJTEUYgpCIKzHocMmW3LD3LztTOYYS9mho5PliK/l/u
 bNN77xD3Uo0R6uKIquhu1+HXG4IN33dv/6kXLoslsMsnyb/6ru5VDr39/v+WITV+ov
 DrSDxAQ5+b40H+k/bdNdaPVhsA6av0fZS9p0C8HP1OkMxJ1adpLsD5GAkV2VNfSVG/
 E/4Ur7Kr0HvLVyD9ES28bsD7tJPUJIxBeMZ0AUmh7mm/yuTTuJnEAllLhPh/gnFadR
 xMALj6RzlBK3A==
Date: Tue, 7 Apr 2026 22:59:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 1/5] monitor: store monitor id and dynamic flag in
 Monitor struct
Message-ID: <20260407-beackern-bereichern-888fb1925d45@brauner>
References: <20260407-work-qmp-monitor-hotplug-v3-0-cb259800fffb@kernel.org>
 <20260407-work-qmp-monitor-hotplug-v3-1-cb259800fffb@kernel.org>
 <adTe4_uiYogOULtn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adTe4_uiYogOULtn@redhat.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=brauner@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 07, 2026 at 11:39:31AM +0100, Daniel P. Berrangé wrote:
> On Tue, Apr 07, 2026 at 09:32:45AM +0200, Christian Brauner wrote:
> > Add 'id', 'dynamic', and 'dead' fields to struct Monitor. The id field
> > stores the monitor identifier from MonitorOptions which was previously
> > parsed but discarded. The dynamic flag marks monitors created at runtime
> > via the upcoming monitor-add command, and the dead flag will be used for
> > deferred destruction during monitor-remove.
> > 
> > Extend monitor_init_qmp() to accept id and dynamic parameters so these
> > are set before the monitor is added to mon_list.
> > 
> > For iothread monitors, move monitor_list_append() from the setup BH to
> > the caller so monitor_find_by_id() can detect duplicates immediately.
> > Without this, two concurrent monitor-add calls could both pass the
> > duplicate check before either BH runs.  This means the monitor is now
> > visible in mon_list before its chardev handlers are set up, which was
> > not the case before.  This is safe because the request queue is still
> > empty (no chardev handlers means no monitor_qmp_read(), so the
> > dispatcher finds nothing to dispatch) and event broadcast is handled
> > below.
> > 
> > This requires initializing mon->commands = &qmp_cap_negotiation_commands
> > before monitor_list_append().  Without it, commands is NULL (from
> > g_new0) and monitor_qapi_event_emit() would not skip the monitor during
> > event broadcast -- its check is specifically for the
> > qmp_cap_negotiation_commands pointer, so a NULL falls through to
> > qmp_send_response() on an uninitialized monitor.  CHR_EVENT_OPENED sets
> > commands to the same value again later.
> > 
> > Add monitor_find_by_id() to look up monitors by identifier.  The lookup
> > takes monitor_lock to serialize with the I/O thread BH that modifies
> > mon_list, but releases it before returning.  The caller must hold the
> > BQL to ensure the returned pointer remains valid since only BQL holders
> > can destroy monitors.
> > 
> > Free the id string in monitor_data_destroy().
> > 
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  include/monitor/monitor.h  |  3 ++-
> >  monitor/monitor-internal.h |  5 +++++
> >  monitor/monitor.c          | 21 ++++++++++++++++++++-
> >  monitor/qmp.c              | 11 ++++++++---
> >  4 files changed, 35 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> > index 296690e1f1..7a2bb603e4 100644
> > --- a/include/monitor/monitor.h
> > +++ b/include/monitor/monitor.h
> > @@ -19,7 +19,8 @@ bool monitor_cur_is_qmp(void);
> >  
> >  void monitor_init_globals(void);
> >  void monitor_init_globals_core(void);
> > -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
> > +void monitor_init_qmp(Chardev *chr, bool pretty, const char *id,
> > +                      bool dynamic, Error **errp);
> >  void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
> >  int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
> >  int monitor_init_opts(QemuOpts *opts, Error **errp);
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index feca111ae3..4896812d4e 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -98,7 +98,10 @@ struct Monitor {
> >      bool is_qmp;
> >      bool skip_flush;
> >      bool use_io_thread;
> > +    bool dynamic;           /* true if created via monitor-add */
> > +    bool dead;              /* awaiting drain after monitor-remove */
> 
> Neither of these fields appear to be used for anything in this
> patch. If they're used in a later patch, then add them at time
> of use.

Ok.

