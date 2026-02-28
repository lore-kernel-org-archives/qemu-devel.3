Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A83C1048922
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 00:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw875-0002pc-Qw; Fri, 27 Feb 2026 19:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vw874-0002pO-Kx
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 19:23:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vw872-0001fM-8W
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 19:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772238194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6FW4nhECYfQ6rv+M/6GyGIHMF8EBPLONBEHATaJ5mU=;
 b=Q/lPRIDs2RyzINjYHtp9OVWpPOVB+dWtRo+NrgpFkLj5HFd/IIwQ4lqnb4iwITTGznySZ8
 nlZykGDdg17FP4OEHjoK3mleYIaWxWTdfNuYlzaQnr7OstnOisfUQBo/YEyhNcOLAy6j3h
 fhRmqqnGCSFPz585FoJp+uSDkCvERbo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-CFjqIRpqOBa9a85p4E51ww-1; Fri, 27 Feb 2026 19:23:13 -0500
X-MC-Unique: CFjqIRpqOBa9a85p4E51ww-1
X-Mimecast-MFC-AGG-ID: CFjqIRpqOBa9a85p4E51ww_1772238192
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cb3a129cd2so2592158385a.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 16:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772238192; x=1772842992; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c6FW4nhECYfQ6rv+M/6GyGIHMF8EBPLONBEHATaJ5mU=;
 b=go2M/8GqxopXz9aIr/Cd8eN7ZH+9AaOhsh/Z1aLbP65mYZphaPNaA9v0M97UDpemYs
 ipJjwIG9vonJo4hO45N0vJjHIBp6WeWPbDZhQsK4wvLeWe37JrtJQmwqAuiNi5FyHp1/
 7B4pgso7DIRnUOJqiCLMZyJAQBHuqNvb/Q56V7in1OqoWNcNUmwFav5ZY+uN+pbmMCI3
 UuWoz1hND/mp5APMXNohLFjy9KWHQStw0gKItJswcJxgeSABL+8EYrqCkniZGgLKrXUB
 XCCOxYnuA/1Cm5awC1wWLLkbtfL2jQni467D7trHSggYjtLmwSGmnDka9kAAZsAcWWHk
 jVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772238192; x=1772842992;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c6FW4nhECYfQ6rv+M/6GyGIHMF8EBPLONBEHATaJ5mU=;
 b=haukcyWHGEtZIQfs/ZGJhuIDeqbd6kqmTw6iq+gNz6ZOuSlN72Z6GhgA4DM4Lv7tpT
 3r8+B9rSNVGAPT+/FCW5CeAdScj+ON0SoWxim3J7fHKO3FjdN1UXvs8G/3VJcsTAjvVA
 Ea/ALm8LDbScM9kyuDsvXJnVlOI/Hcmbf3qSTl2tClYvwxIbNaN1pyMoEKNQeMPHL3ws
 gITuSOiQm/S6ZPVDNLTi4v7m/D865W4pMnp9ZO5Iw3W4IxKdqUoeDx5eDy25elC6+hk+
 v1oPH4Hu2vcinUNlAS0/Z8qRQukvCotN0w4O3PCfW8QUX1YLJPSLQmSvnTb9x1vgPHHv
 22Ng==
X-Gm-Message-State: AOJu0YwpvU3bU4LfgA7UG9FJdMKk3LM7D+XloFLYyVWeQT2/aJem5lXp
 HtpUVJGfX63HV4HuWC8zc4thLNcoMsd0FqMjAA7/xi9LU3LmAHrpIsciefbVnXBenh3x/ot8m14
 XAc/q9cp6oo6dYT/VPekKByf4phQiU8/ZyhPECsdWAjhuIB6q3s78TTdQ
X-Gm-Gg: ATEYQzxTco/szn5qIsbi7okrxiHNXhoXQawqwosNa26qjhvSlYbN0Q3yqn4hKVu+5sC
 KLsAO+jq+pi+j1RGTkzTppChxnucSfP1nRBimPSGiaRCEtBJQralC/ZDnBv3rzLMr60Hf9pwuvB
 7Q9EtUvLDwROM1TJr8gLilFyP1+y7AgmHk9qpqt9Qzn2H1WkPs2D1AA06oMvBTpcFub5g7Zt3Ns
 3ZKbrulERrLC6RDVM1pvTMsAHpRfAxadZw9TspRjUm/o+mEJYdgQneKVb8tM1jMEyTASkqM64x4
 gSLJ6DBOlpaOk2JsbJCNIjXUY5sfvJlOWwBdju2K7Q45CbkEtMnY+SJjrzVPqRc/wFKFJsllbQ3
 adlQzk7j5M6zg8g==
X-Received: by 2002:a05:620a:c43:b0:8cb:df8:e86a with SMTP id
 af79cd13be357-8cbbf3ce859mr1191015285a.28.1772238192040; 
 Fri, 27 Feb 2026 16:23:12 -0800 (PST)
X-Received: by 2002:a05:620a:c43:b0:8cb:df8:e86a with SMTP id
 af79cd13be357-8cbbf3ce859mr1191010385a.28.1772238191351; 
 Fri, 27 Feb 2026 16:23:11 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf66c515sm593994085a.11.2026.02.27.16.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 16:23:10 -0800 (PST)
Date: Fri, 27 Feb 2026 19:22:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v10 19/19] migration: Always open
 s->rp_state.from_dst_file on the source
Message-ID: <aaI1Y7T3NAywueIb@x1.local>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
 <20260220-colo_unit_test_multifd-v10-19-bfe67d422ef1@web.de>
 <aaBrc4bMxUHhgpH8@x1.local> <20260227124903.241af498@penguin>
 <aaHSypDPWTn8WXNv@x1.local> <20260227185914.4fd05c0b@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227185914.4fd05c0b@penguin>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
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

On Fri, Feb 27, 2026 at 06:59:14PM +0100, Lukas Straub wrote:
> On Fri, 27 Feb 2026 12:22:18 -0500
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Fri, Feb 27, 2026 at 12:49:03PM +0100, Lukas Straub wrote:
> > > On Thu, 26 Feb 2026 10:49:07 -0500
> > > Peter Xu <peterx@redhat.com> wrote:
> > >   
> > > > On Fri, Feb 20, 2026 at 08:51:41PM +0100, Lukas Straub wrote:  
> > > > > qemu_file_get_return_path() can not fail (See also commit 3f9d6e77b)
> > > > > so always open the return path socket on the source. This allows
> > > > > us to reuse the return path in other parts like colo. Also take
> > > > > the proper locks in colo while we're at it.
> > > > > 
> > > > > This fixes a crash due to a race between migrate_cancel() and
> > > > > the colo thread shutting down.
> > > > > 
> > > > > Before, the rp socket is opened just before the rp thread is started
> > > > > and closed after it terminates and postcopy fast path is closed.
> > > > > Now it's the same, only the rp socket stays open until migration_cleanup().
> > > > > 
> > > > > If there is a rp thread, the rp socket is shut down at the end of migration,
> > > > > but the file is still open. COLO is not compatible with postcopy, so this is
> > > > > safe as no one else uses the rp socket after this point.
> > > > > 
> > > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > > > ---
> > > > >  migration/colo.c      | 29 ++++++-------------
> > > > >  migration/migration.c | 77 ++++++++++++++++++++++++---------------------------
> > > > >  2 files changed, 44 insertions(+), 62 deletions(-)
> > > > > 
> > > > > diff --git a/migration/colo.c b/migration/colo.c
> > > > > index ce02c71d8857d470be434bdf3a9cacad3baab0d5..0dee33f1145b81af276cf318e2984deae9ae0527 100644
> > > > > --- a/migration/colo.c
> > > > > +++ b/migration/colo.c
> > > > > @@ -173,11 +173,13 @@ static void primary_vm_do_failover(void)
> > > > >       * The s->rp_state.from_dst_file and s->to_dst_file may use the
> > > > >       * same fd, but we still shutdown the fd for twice, it is harmless.
> > > > >       */
> > > > > -    if (s->to_dst_file) {
> > > > > -        qemu_file_shutdown(s->to_dst_file);
> > > > > -    }
> > > > > -    if (s->rp_state.from_dst_file) {
> > > > > -        qemu_file_shutdown(s->rp_state.from_dst_file);
> > > > > +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > > > > +        if (s->to_dst_file) {
> > > > > +            qemu_file_shutdown(s->to_dst_file);
> > > > > +        }
> > > > > +        if (s->rp_state.from_dst_file) {
> > > > > +            qemu_file_shutdown(s->rp_state.from_dst_file);
> > > > > +        }    
> > > > 
> > > > Nit: these "start to take mutex for..." changes should belong to a separate
> > > > patch.
> > > >   
> > > 
> > > Will do.
> > >   
> > > > >      }
> > > > >  
> > > > >      old_state = failover_set_state(FAILOVER_STATUS_ACTIVE,
> > > > > @@ -537,6 +539,7 @@ static void colo_process_checkpoint(MigrationState *s)
> > > > >      Error *local_err = NULL;
> > > > >      int ret;
> > > > >  
> > > > > +    assert(s->rp_state.from_dst_file);
> > > > >      if (get_colo_mode() != COLO_MODE_PRIMARY) {
> > > > >          error_report("COLO mode must be COLO_MODE_PRIMARY");
> > > > >          return;
> > > > > @@ -544,12 +547,6 @@ static void colo_process_checkpoint(MigrationState *s)
> > > > >  
> > > > >      failover_init_state();
> > > > >  
> > > > > -    s->rp_state.from_dst_file = qemu_file_get_return_path(s->to_dst_file);
> > > > > -    if (!s->rp_state.from_dst_file) {
> > > > > -        error_report("Open QEMUFile from_dst_file failed");
> > > > > -        goto out;
> > > > > -    }
> > > > > -
> > > > >      packets_compare_notifier.notify = colo_compare_notify_checkpoint;
> > > > >      colo_compare_register_notifier(&packets_compare_notifier);
> > > > >  
> > > > > @@ -634,16 +631,6 @@ out:
> > > > >      colo_compare_unregister_notifier(&packets_compare_notifier);
> > > > >      timer_free(s->colo_delay_timer);
> > > > >      qemu_event_destroy(&s->colo_checkpoint_event);
> > > > > -
> > > > > -    /*
> > > > > -     * Must be called after failover BH is completed,
> > > > > -     * Or the failover BH may shutdown the wrong fd that
> > > > > -     * re-used by other threads after we release here.
> > > > > -     */
> > > > > -    if (s->rp_state.from_dst_file) {
> > > > > -        qemu_fclose(s->rp_state.from_dst_file);
> > > > > -        s->rp_state.from_dst_file = NULL;
> > > > > -    }
> > > > >  }
> > > > >  
> > > > >  void migrate_start_colo_process(MigrationState *s)
> > > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > > index f36d42ef657bdf26d78ca642d77a9b76e1c0c174..8caa56940beef12de33a799695cf486c8fbd471c 100644
> > > > > --- a/migration/migration.c
> > > > > +++ b/migration/migration.c
> > > > > @@ -97,7 +97,7 @@ static GSList *migration_blockers[MIG_MODE__MAX];
> > > > >  
> > > > >  static bool migration_object_check(MigrationState *ms, Error **errp);
> > > > >  static bool migration_switchover_start(MigrationState *s, Error **errp);
> > > > > -static bool close_return_path_on_source(MigrationState *s);
> > > > > +static bool stop_return_path_thread_on_source(MigrationState *s);
> > > > >  static void migration_completion_end(MigrationState *s);
> > > > >  
> > > > >  static void migration_downtime_start(MigrationState *s)
> > > > > @@ -1278,7 +1278,7 @@ static void migration_cleanup(MigrationState *s)
> > > > >      cpr_state_close();
> > > > >      cpr_transfer_source_destroy(s);
> > > > >  
> > > > > -    close_return_path_on_source(s);
> > > > > +    stop_return_path_thread_on_source(s);
> > > > >  
> > > > >      if (s->migration_thread_running) {
> > > > >          bql_unlock();
> > > > > @@ -1307,6 +1307,14 @@ static void migration_cleanup(MigrationState *s)
> > > > >          qemu_fclose(tmp);
> > > > >      }
> > > > >  
> > > > > +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > > > > +        tmp = s->rp_state.from_dst_file;
> > > > > +        s->rp_state.from_dst_file = NULL;
> > > > > +    }
> > > > > +    if (tmp) {
> > > > > +        qemu_fclose(tmp);
> > > > > +    }
> > > > > +
> > > > >      assert(!migration_is_active());
> > > > >  
> > > > >      if (s->state == MIGRATION_STATUS_CANCELLING) {
> > > > > @@ -2187,38 +2195,6 @@ static bool migrate_handle_rp_resume_ack(MigrationState *s,
> > > > >      return true;
> > > > >  }
> > > > >  
> > > > > -/*
> > > > > - * Release ms->rp_state.from_dst_file (and postcopy_qemufile_src if
> > > > > - * existed) in a safe way.
> > > > > - */
> > > > > -static void migration_release_dst_files(MigrationState *ms)
> > > > > -{
> > > > > -    QEMUFile *file = NULL;
> > > > > -
> > > > > -    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
> > > > > -        /*
> > > > > -         * Reset the from_dst_file pointer first before releasing it, as we
> > > > > -         * can't block within lock section
> > > > > -         */
> > > > > -        file = ms->rp_state.from_dst_file;
> > > > > -        ms->rp_state.from_dst_file = NULL;
> > > > > -    }
> > > > > -
> > > > > -    /*
> > > > > -     * Do the same to postcopy fast path socket too if there is.  No
> > > > > -     * locking needed because this qemufile should only be managed by
> > > > > -     * return path thread.
> > > > > -     */
> > > > > -    if (ms->postcopy_qemufile_src) {
> > > > > -        migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src);
> > > > > -        qemu_file_shutdown(ms->postcopy_qemufile_src);
> > > > > -        qemu_fclose(ms->postcopy_qemufile_src);
> > > > > -        ms->postcopy_qemufile_src = NULL;
> > > > > -    }
> > > > > -
> > > > > -    qemu_fclose(file);
> > > > > -}
> > > > > -
> > > > >  /*
> > > > >   * Handles messages sent on the return path towards the source VM
> > > > >   *
> > > > > @@ -2388,9 +2364,9 @@ out:
> > > > >      return NULL;
> > > > >  }
> > > > >  
> > > > > -static void open_return_path_on_source(MigrationState *ms)
> > > > > +static void start_return_path_thread_on_source(MigrationState *ms)    
> > > > 
> > > > Changing this seems OK, but I'm totally confused why you deleted
> > > > migration_release_dst_files().  That's the helper to properly close the two
> > > > possible qemufiles that rp thread uses.  
> > > 
> > > Okay, so my reasoning here is:
> > > I think that closing ms->postcopy_qemufile_src is very closely
> > > related to cleaning up the rp thread so I moved that to
> > > stop_return_path_thread_on_source().  
> > 
> > Hmm OK, I had that feeling you wanted to move all qemufile cleanups into
> > the cleanup function.
> > 
> > Actually I think that may still be easier for you, e.g. you can at least
> > reuse the migration_release_dst_files().  I don't see much benefit yet on
> > open code the preempt qemufiles..
> > 
> > > 
> > > Meanwhile I think s->rp_state.from_dst_file is more closely related to
> > > s->to_dst_file and in fact I think we can remove s->rp_state.from_dst_file
> > > entirely in the future and use s->to_dst_file for send *and* receive
> > > just like you would with a normal socket.
> > > 
> > > So I close s->rp_state.from_dst_file right besides s->to_dst_file in
> > > this patch. And I do the same open-coded file lock dance like
> > > s->to_dst_file already does.  
> > 
> > Let's not do open coded things.  That makes things worse.
> > 
> > If you also agree we can cleanup qemufile alawys only until migration
> > cleanup then we can stick with it for now.
> > 
> > >   
> > > > IIUC you can keep it then use it
> > > > in either postcopy_pause() or migration_cleanup() directly.  
> > > 
> > > I can do that if you wish.
> > > Should I keep closing ms->postcopy_qemufile_src inside
> > > migration_release_dst_files() or stop_return_path_thread_on_source() ?  
> > 
> > If you use migration_release_dst_files() in both (1) postcopy pause and (2)
> > migration cleanup, IIUC we should covered all cases.  But please double
> > check.
> 
> Even better idea: Add a helper that closes s->to_dst_file and s->rp_state.from_dst_file
> and use that in postcopy pause and migration cleanup.
> 
> What do you think?

If you mean having the helper close all three possible qemufiles, then it
sounds OK to me.  As long as your new code will still properly manage the
preempt channel and not open-code it I'm OK.

> 
> > >   
> > > > 
> > > > Then you need to remove the chunk [1] below, making the function only do
> > > > "stop" but not close.
> > > >   
> > > > >  {
> > > > > -    ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
> > > > > +    assert(ms->rp_state.from_dst_file);    
> > > > 
> > > > I don't see why this change is a must, to open from_dst_file earlier.  Can
> > > > we keep it as before, or would you justify it in a separate patch?  
> > > 
> > > Well, the issue is that opening the return path file is behind this if:
> > > 
> > >  if (migrate_postcopy_ram() || migrate_return_path()) {
> > > -        open_return_path_on_source(s);
> > > +        start_return_path_thread_on_source(s);
> > >  }
> > > 
> > > And I want to always open the return path file, without also starting
> > > the return path thread.  
> > 
> > I never notice this small difference.. then logically COLO should just
> > depend on return-path capability.
> > 
> > IIUC the simplest for your series to move on is:
> > 
> >   - If COLO always require return-path (I hope you know the best... e.g. do
> >     you enable return-path cap for your colo deployment?), we can add that
> >     enforcement in migrate_caps_check().  It's an ABI break only to COLO,
> >     but if you're OK, I don't see it an issue.
> > 
> >   - Just add one more condition above into:
> > 
> >   if (migrate_postcopy_ram() || migrate_return_path() || migrate_colo()) {
> >           open_return_path_on_source(s);
> >   }
> > 
> >   Instead of making rp complicated; after all many places assume rp thread
> >   is there when rp qemufile is there, vice versa.  Changing that needs more
> >   monitoring of code base, IMHO.  Better stick with it to be simple.
> 
> That doesn't work either, because now you have the rp thread running
> and to stop the thread we
> qemu_file_shutdown(ms->rp_state.from_dst_file).

Do you mean this line?

    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
        if (migrate_has_error(ms) && ms->rp_state.from_dst_file) {
            qemu_file_shutdown(ms->rp_state.from_dst_file);
        }
    }

We don't shut it down if the migration succeeded, but rely on RP_SHUT
message.  I think it should still be true for COLO.  If something is wrong,
migration will fail and it won't switch to COLO state.  Otherwise it won't
shut so IIUC COLO can reuse it.

> And we're back to square one because we can't reuse the shut
> s->rp_state.from_dst_file in colo.
> 
> In fact looking at the code, qemu_file_shutdown() shuts both
> ms->rp_state.from_dst_file *and* s->to_dst_file because
> it calls qio_channel_shutdown(f->ioc, QIO_CHANNEL_SHUTDOWN_BOTH) and
> f->ioc is the same io channel for both files.
> 
> So after stop_return_path_thread_on_source() our connection the the
> secondary is severed. That's now workable.
> 
> > 
> > >   
> > > >   
> > > > >  
> > > > >      trace_open_return_path_on_source();
> > > > >  
> > > > > @@ -2402,7 +2378,7 @@ static void open_return_path_on_source(MigrationState *ms)
> > > > >  }
> > > > >  
> > > > >  /* Return true if error detected, or false otherwise */
> > > > > -static bool close_return_path_on_source(MigrationState *ms)
> > > > > +static bool stop_return_path_thread_on_source(MigrationState *ms)
> > > > >  {
> > > > >      if (!ms->rp_state.rp_thread_created) {
> > > > >          return false;
> > > > > @@ -2424,7 +2400,17 @@ static bool close_return_path_on_source(MigrationState *ms)
> > > > >  
> > > > >      qemu_thread_join(&ms->rp_state.rp_thread);
> > > > >      ms->rp_state.rp_thread_created = false;
> > > > > -    migration_release_dst_files(ms);
> > > > > +    /*
> > > > > +     * Close the postcopy fast path socket if there is one.
> > > > > +     * No locking needed because this qemufile should only be managed by
> > > > > +     * return path thread which we just stopped.
> > > > > +     */
> > > > > +    if (ms->postcopy_qemufile_src) {
> > > > > +        migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src);
> > > > > +        qemu_file_shutdown(ms->postcopy_qemufile_src);
> > > > > +        qemu_fclose(ms->postcopy_qemufile_src);
> > > > > +        ms->postcopy_qemufile_src = NULL;
> > > > > +    }    
> > > > 
> > > > [1]
> > > >   
> > > > >      trace_migration_return_path_end_after();
> > > > >  
> > > > >      /* Return path will persist the error in MigrationState when quit */
> > > > > @@ -2787,7 +2773,7 @@ static void migration_completion(MigrationState *s)
> > > > >          goto fail;
> > > > >      }
> > > > >  
> > > > > -    if (close_return_path_on_source(s)) {
> > > > > +    if (stop_return_path_thread_on_source(s)) {
> > > > >          goto fail;
> > > > >      }
> > > > >  
> > > > > @@ -2941,7 +2927,15 @@ static MigThrError postcopy_pause(MigrationState *s)
> > > > >           * path and just wait for the thread to finish. It will be
> > > > >           * re-created when we resume.
> > > > >           */
> > > > > -        close_return_path_on_source(s);
> > > > > +        stop_return_path_thread_on_source(s);
> > > > > +        QEMUFile *rp_file;
> > > > > +        WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > > > > +            rp_file = s->rp_state.from_dst_file;
> > > > > +            s->rp_state.from_dst_file = NULL;
> > > > > +        }
> > > > > +        if (rp_file) {
> > > > > +            qemu_fclose(rp_file);
> > > > > +        }    
> > > > 
> > > > Open-code this is going backwards.  Please see if we can reuse
> > > > migration_release_dst_files() at least.
> > > > 
> > > > Thanks,
> > > >   
> > > > >  
> > > > >          /*
> > > > >           * Current channel is possibly broken. Release it.  Note that this is
> > > > > @@ -3758,6 +3752,7 @@ void migration_start_outgoing(MigrationState *s)
> > > > >      if (!qemu_file_set_blocking(s->to_dst_file, true, &local_err)) {
> > > > >          goto fail;
> > > > >      }
> > > > > +    s->rp_state.from_dst_file = qemu_file_get_return_path(s->to_dst_file);
> > > > >  
> > > > >      /*
> > > > >       * Open the return path. For postcopy, it is used exclusively. For
> > > > > @@ -3765,7 +3760,7 @@ void migration_start_outgoing(MigrationState *s)
> > > > >       * QEMU uses the return path.
> > > > >       */
> > > > >      if (migrate_postcopy_ram() || migrate_return_path()) {
> > > > > -        open_return_path_on_source(s);
> > > > > +        start_return_path_thread_on_source(s);
> > > > >      }
> > > > >
> > > > >
> > > > >  
> > > > >      /*
> > > > > 
> > > > > -- 
> > > > > 2.39.5
> > > > >     
> > > >   
> > >   
> > 
> > 
> > 
> 



-- 
Peter Xu


