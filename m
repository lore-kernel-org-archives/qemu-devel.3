Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F100FEFB6E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 17:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw1Xz-00073u-9h; Fri, 27 Feb 2026 12:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vw1Xy-00073j-BS
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 12:22:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vw1Xv-0002ss-2V
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 12:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772212953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/FoRDNULwobUv87bLgI7+mgOvV8vuLBeBAhDkKVDx8=;
 b=LsxUeUzHhVKuWwyuMcPofY6YvMeOwEw7wl4c+r7uXaaoQ5fRJZMWZE5awe7ShAO8KRbHR9
 uT2KggQx3Cre8MClVNBrMNSso6bnxMPKxymGJ/EiMZzmZQTxZgJbd3YOfYYsKNeAgvWmTJ
 psAfwpTOB0cDegdnIgCqOBn6qHu4DRM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-00XyB01iPX-WdbO1NOV1PQ-1; Fri, 27 Feb 2026 12:22:31 -0500
X-MC-Unique: 00XyB01iPX-WdbO1NOV1PQ-1
X-Mimecast-MFC-AGG-ID: 00XyB01iPX-WdbO1NOV1PQ_1772212951
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c881d0c617so1569394285a.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 09:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772212951; x=1772817751; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F/FoRDNULwobUv87bLgI7+mgOvV8vuLBeBAhDkKVDx8=;
 b=mTDmmsg+Mz63t77n/EIOLPafEd+ZFrvSakwJXmUHX7pUImqRzUAH3uqPT/8NIIgr3T
 xi5vS0ohCcMOm7SnDVpkloj0F5I4D+OugL139GDZ3awh4kQhPw8KrpcvuZ/oGZrtbdgx
 XBHVKhQnwWlx1md6MzylpeTyJe/AXmmi0ab9fGPNlrF36qK+GsRL4Ao3LDIN0hHIo20O
 JGrSfoiJi/650qDiu06AH/WBQdLVFwU3EzDuGDwnV+cs92gL+reviXQce9NlGKAEJv1b
 cFTeHmCOqKPC9JThms+sXoY6oRhMDjAgo//oiWWT3399YJm/J3Z+03mSSebXMl43mmbj
 oSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772212951; x=1772817751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F/FoRDNULwobUv87bLgI7+mgOvV8vuLBeBAhDkKVDx8=;
 b=B6K+f6NL7oUyBtC1vGyNDDvXSF/rGfAIeb/azA2vL8GpJQ9EayELcpqzrqh+z3Y4pB
 EGRrVtEqD5jflG1fQJIgM7+oKv4A78EScASQmbEUEyXQUHsPI/k+/S9rIiPnjVw57/1r
 /OViGw98FJG0m3qn41y18MWzN/ksJzQ3Uve0kNo/nJCmTNwuEuVCD9rRmtSFEtF+nr9R
 aKwEOAE/ZZ9/NYl+5yYU+4jvYoot3YTb1g9paMI7ufBJ5TcWZHs1AsbKhLcJYwdS9y4u
 EE4yhiF+YezC/q5N36YS/uDdI5pQtS81fmFx9E65B6prQYKtfYUKK137szhSuCgJYo9H
 sTdQ==
X-Gm-Message-State: AOJu0YyyQMm1GrLVUKtQGXkt8rS+ez2JukRpdgtrwk+RjRbkByeXcFdK
 pZ7Nz+PeXQtAkuETcBpGc2MQpasL9+IyqeEVB65GYb1+QjyxgFKgdP9kuNKl3OlYf+90z3jRBcQ
 8YEmxfT1aAacVpQOw9pbDiowwjlC3j1uXaFQFW1LM3ksCaXCwsDdNGHYe
X-Gm-Gg: ATEYQzzJ3kl1RH6x0iESAQIgp7G8QfMhu/tGel48ZlMZhozEPvO35BOqTJDudiDC5Lz
 mUZuR21oM8r4yH1OyP+pdonCt+Yyd4CruZvnR3kJbnuib+1amy0ACIADcjexm5zaJxYoS2wut1K
 gSOraB3g2v5Jj1LIODaUkb1I8VUs8zRr98nFYvQRCCDLV0z9UCnrkFVRP3cI0U9SpZYX7ok3Zkl
 He9B94MrcqEge98M/j4NTHivo+i1WOt8K0KQDxq1s4xDbxcQ12vGvD9NcBJbvjsBiK6rJzCyUMR
 TcFamznvDGdOgn1E/oB+/0ly8LfBE21f5Pp7jJ4KmP6HX0kcspkjtyClERW9OesDgv57qBLQrsc
 colYseTjQVJX1jQ==
X-Received: by 2002:a05:620a:4014:b0:8c7:15fc:2a23 with SMTP id
 af79cd13be357-8cbc8e41d72mr453316685a.79.1772212950824; 
 Fri, 27 Feb 2026 09:22:30 -0800 (PST)
X-Received: by 2002:a05:620a:4014:b0:8c7:15fc:2a23 with SMTP id
 af79cd13be357-8cbc8e41d72mr453310385a.79.1772212950088; 
 Fri, 27 Feb 2026 09:22:30 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c73a3130sm48465926d6.49.2026.02.27.09.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 09:22:29 -0800 (PST)
Date: Fri, 27 Feb 2026 12:22:18 -0500
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
Message-ID: <aaHSypDPWTn8WXNv@x1.local>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
 <20260220-colo_unit_test_multifd-v10-19-bfe67d422ef1@web.de>
 <aaBrc4bMxUHhgpH8@x1.local> <20260227124903.241af498@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227124903.241af498@penguin>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Feb 27, 2026 at 12:49:03PM +0100, Lukas Straub wrote:
> On Thu, 26 Feb 2026 10:49:07 -0500
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Fri, Feb 20, 2026 at 08:51:41PM +0100, Lukas Straub wrote:
> > > qemu_file_get_return_path() can not fail (See also commit 3f9d6e77b)
> > > so always open the return path socket on the source. This allows
> > > us to reuse the return path in other parts like colo. Also take
> > > the proper locks in colo while we're at it.
> > > 
> > > This fixes a crash due to a race between migrate_cancel() and
> > > the colo thread shutting down.
> > > 
> > > Before, the rp socket is opened just before the rp thread is started
> > > and closed after it terminates and postcopy fast path is closed.
> > > Now it's the same, only the rp socket stays open until migration_cleanup().
> > > 
> > > If there is a rp thread, the rp socket is shut down at the end of migration,
> > > but the file is still open. COLO is not compatible with postcopy, so this is
> > > safe as no one else uses the rp socket after this point.
> > > 
> > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > ---
> > >  migration/colo.c      | 29 ++++++-------------
> > >  migration/migration.c | 77 ++++++++++++++++++++++++---------------------------
> > >  2 files changed, 44 insertions(+), 62 deletions(-)
> > > 
> > > diff --git a/migration/colo.c b/migration/colo.c
> > > index ce02c71d8857d470be434bdf3a9cacad3baab0d5..0dee33f1145b81af276cf318e2984deae9ae0527 100644
> > > --- a/migration/colo.c
> > > +++ b/migration/colo.c
> > > @@ -173,11 +173,13 @@ static void primary_vm_do_failover(void)
> > >       * The s->rp_state.from_dst_file and s->to_dst_file may use the
> > >       * same fd, but we still shutdown the fd for twice, it is harmless.
> > >       */
> > > -    if (s->to_dst_file) {
> > > -        qemu_file_shutdown(s->to_dst_file);
> > > -    }
> > > -    if (s->rp_state.from_dst_file) {
> > > -        qemu_file_shutdown(s->rp_state.from_dst_file);
> > > +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > > +        if (s->to_dst_file) {
> > > +            qemu_file_shutdown(s->to_dst_file);
> > > +        }
> > > +        if (s->rp_state.from_dst_file) {
> > > +            qemu_file_shutdown(s->rp_state.from_dst_file);
> > > +        }  
> > 
> > Nit: these "start to take mutex for..." changes should belong to a separate
> > patch.
> > 
> 
> Will do.
> 
> > >      }
> > >  
> > >      old_state = failover_set_state(FAILOVER_STATUS_ACTIVE,
> > > @@ -537,6 +539,7 @@ static void colo_process_checkpoint(MigrationState *s)
> > >      Error *local_err = NULL;
> > >      int ret;
> > >  
> > > +    assert(s->rp_state.from_dst_file);
> > >      if (get_colo_mode() != COLO_MODE_PRIMARY) {
> > >          error_report("COLO mode must be COLO_MODE_PRIMARY");
> > >          return;
> > > @@ -544,12 +547,6 @@ static void colo_process_checkpoint(MigrationState *s)
> > >  
> > >      failover_init_state();
> > >  
> > > -    s->rp_state.from_dst_file = qemu_file_get_return_path(s->to_dst_file);
> > > -    if (!s->rp_state.from_dst_file) {
> > > -        error_report("Open QEMUFile from_dst_file failed");
> > > -        goto out;
> > > -    }
> > > -
> > >      packets_compare_notifier.notify = colo_compare_notify_checkpoint;
> > >      colo_compare_register_notifier(&packets_compare_notifier);
> > >  
> > > @@ -634,16 +631,6 @@ out:
> > >      colo_compare_unregister_notifier(&packets_compare_notifier);
> > >      timer_free(s->colo_delay_timer);
> > >      qemu_event_destroy(&s->colo_checkpoint_event);
> > > -
> > > -    /*
> > > -     * Must be called after failover BH is completed,
> > > -     * Or the failover BH may shutdown the wrong fd that
> > > -     * re-used by other threads after we release here.
> > > -     */
> > > -    if (s->rp_state.from_dst_file) {
> > > -        qemu_fclose(s->rp_state.from_dst_file);
> > > -        s->rp_state.from_dst_file = NULL;
> > > -    }
> > >  }
> > >  
> > >  void migrate_start_colo_process(MigrationState *s)
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index f36d42ef657bdf26d78ca642d77a9b76e1c0c174..8caa56940beef12de33a799695cf486c8fbd471c 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -97,7 +97,7 @@ static GSList *migration_blockers[MIG_MODE__MAX];
> > >  
> > >  static bool migration_object_check(MigrationState *ms, Error **errp);
> > >  static bool migration_switchover_start(MigrationState *s, Error **errp);
> > > -static bool close_return_path_on_source(MigrationState *s);
> > > +static bool stop_return_path_thread_on_source(MigrationState *s);
> > >  static void migration_completion_end(MigrationState *s);
> > >  
> > >  static void migration_downtime_start(MigrationState *s)
> > > @@ -1278,7 +1278,7 @@ static void migration_cleanup(MigrationState *s)
> > >      cpr_state_close();
> > >      cpr_transfer_source_destroy(s);
> > >  
> > > -    close_return_path_on_source(s);
> > > +    stop_return_path_thread_on_source(s);
> > >  
> > >      if (s->migration_thread_running) {
> > >          bql_unlock();
> > > @@ -1307,6 +1307,14 @@ static void migration_cleanup(MigrationState *s)
> > >          qemu_fclose(tmp);
> > >      }
> > >  
> > > +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > > +        tmp = s->rp_state.from_dst_file;
> > > +        s->rp_state.from_dst_file = NULL;
> > > +    }
> > > +    if (tmp) {
> > > +        qemu_fclose(tmp);
> > > +    }
> > > +
> > >      assert(!migration_is_active());
> > >  
> > >      if (s->state == MIGRATION_STATUS_CANCELLING) {
> > > @@ -2187,38 +2195,6 @@ static bool migrate_handle_rp_resume_ack(MigrationState *s,
> > >      return true;
> > >  }
> > >  
> > > -/*
> > > - * Release ms->rp_state.from_dst_file (and postcopy_qemufile_src if
> > > - * existed) in a safe way.
> > > - */
> > > -static void migration_release_dst_files(MigrationState *ms)
> > > -{
> > > -    QEMUFile *file = NULL;
> > > -
> > > -    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
> > > -        /*
> > > -         * Reset the from_dst_file pointer first before releasing it, as we
> > > -         * can't block within lock section
> > > -         */
> > > -        file = ms->rp_state.from_dst_file;
> > > -        ms->rp_state.from_dst_file = NULL;
> > > -    }
> > > -
> > > -    /*
> > > -     * Do the same to postcopy fast path socket too if there is.  No
> > > -     * locking needed because this qemufile should only be managed by
> > > -     * return path thread.
> > > -     */
> > > -    if (ms->postcopy_qemufile_src) {
> > > -        migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src);
> > > -        qemu_file_shutdown(ms->postcopy_qemufile_src);
> > > -        qemu_fclose(ms->postcopy_qemufile_src);
> > > -        ms->postcopy_qemufile_src = NULL;
> > > -    }
> > > -
> > > -    qemu_fclose(file);
> > > -}
> > > -
> > >  /*
> > >   * Handles messages sent on the return path towards the source VM
> > >   *
> > > @@ -2388,9 +2364,9 @@ out:
> > >      return NULL;
> > >  }
> > >  
> > > -static void open_return_path_on_source(MigrationState *ms)
> > > +static void start_return_path_thread_on_source(MigrationState *ms)  
> > 
> > Changing this seems OK, but I'm totally confused why you deleted
> > migration_release_dst_files().  That's the helper to properly close the two
> > possible qemufiles that rp thread uses.
> 
> Okay, so my reasoning here is:
> I think that closing ms->postcopy_qemufile_src is very closely
> related to cleaning up the rp thread so I moved that to
> stop_return_path_thread_on_source().

Hmm OK, I had that feeling you wanted to move all qemufile cleanups into
the cleanup function.

Actually I think that may still be easier for you, e.g. you can at least
reuse the migration_release_dst_files().  I don't see much benefit yet on
open code the preempt qemufiles..

> 
> Meanwhile I think s->rp_state.from_dst_file is more closely related to
> s->to_dst_file and in fact I think we can remove s->rp_state.from_dst_file
> entirely in the future and use s->to_dst_file for send *and* receive
> just like you would with a normal socket.
> 
> So I close s->rp_state.from_dst_file right besides s->to_dst_file in
> this patch. And I do the same open-coded file lock dance like
> s->to_dst_file already does.

Let's not do open coded things.  That makes things worse.

If you also agree we can cleanup qemufile alawys only until migration
cleanup then we can stick with it for now.

> 
> > IIUC you can keep it then use it
> > in either postcopy_pause() or migration_cleanup() directly.
> 
> I can do that if you wish.
> Should I keep closing ms->postcopy_qemufile_src inside
> migration_release_dst_files() or stop_return_path_thread_on_source() ?

If you use migration_release_dst_files() in both (1) postcopy pause and (2)
migration cleanup, IIUC we should covered all cases.  But please double
check.

> 
> > 
> > Then you need to remove the chunk [1] below, making the function only do
> > "stop" but not close.
> > 
> > >  {
> > > -    ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
> > > +    assert(ms->rp_state.from_dst_file);  
> > 
> > I don't see why this change is a must, to open from_dst_file earlier.  Can
> > we keep it as before, or would you justify it in a separate patch?
> 
> Well, the issue is that opening the return path file is behind this if:
> 
>  if (migrate_postcopy_ram() || migrate_return_path()) {
> -        open_return_path_on_source(s);
> +        start_return_path_thread_on_source(s);
>  }
> 
> And I want to always open the return path file, without also starting
> the return path thread.

I never notice this small difference.. then logically COLO should just
depend on return-path capability.

IIUC the simplest for your series to move on is:

  - If COLO always require return-path (I hope you know the best... e.g. do
    you enable return-path cap for your colo deployment?), we can add that
    enforcement in migrate_caps_check().  It's an ABI break only to COLO,
    but if you're OK, I don't see it an issue.

  - Just add one more condition above into:

  if (migrate_postcopy_ram() || migrate_return_path() || migrate_colo()) {
          open_return_path_on_source(s);
  }

  Instead of making rp complicated; after all many places assume rp thread
  is there when rp qemufile is there, vice versa.  Changing that needs more
  monitoring of code base, IMHO.  Better stick with it to be simple.

> 
> > 
> > >  
> > >      trace_open_return_path_on_source();
> > >  
> > > @@ -2402,7 +2378,7 @@ static void open_return_path_on_source(MigrationState *ms)
> > >  }
> > >  
> > >  /* Return true if error detected, or false otherwise */
> > > -static bool close_return_path_on_source(MigrationState *ms)
> > > +static bool stop_return_path_thread_on_source(MigrationState *ms)
> > >  {
> > >      if (!ms->rp_state.rp_thread_created) {
> > >          return false;
> > > @@ -2424,7 +2400,17 @@ static bool close_return_path_on_source(MigrationState *ms)
> > >  
> > >      qemu_thread_join(&ms->rp_state.rp_thread);
> > >      ms->rp_state.rp_thread_created = false;
> > > -    migration_release_dst_files(ms);
> > > +    /*
> > > +     * Close the postcopy fast path socket if there is one.
> > > +     * No locking needed because this qemufile should only be managed by
> > > +     * return path thread which we just stopped.
> > > +     */
> > > +    if (ms->postcopy_qemufile_src) {
> > > +        migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src);
> > > +        qemu_file_shutdown(ms->postcopy_qemufile_src);
> > > +        qemu_fclose(ms->postcopy_qemufile_src);
> > > +        ms->postcopy_qemufile_src = NULL;
> > > +    }  
> > 
> > [1]
> > 
> > >      trace_migration_return_path_end_after();
> > >  
> > >      /* Return path will persist the error in MigrationState when quit */
> > > @@ -2787,7 +2773,7 @@ static void migration_completion(MigrationState *s)
> > >          goto fail;
> > >      }
> > >  
> > > -    if (close_return_path_on_source(s)) {
> > > +    if (stop_return_path_thread_on_source(s)) {
> > >          goto fail;
> > >      }
> > >  
> > > @@ -2941,7 +2927,15 @@ static MigThrError postcopy_pause(MigrationState *s)
> > >           * path and just wait for the thread to finish. It will be
> > >           * re-created when we resume.
> > >           */
> > > -        close_return_path_on_source(s);
> > > +        stop_return_path_thread_on_source(s);
> > > +        QEMUFile *rp_file;
> > > +        WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > > +            rp_file = s->rp_state.from_dst_file;
> > > +            s->rp_state.from_dst_file = NULL;
> > > +        }
> > > +        if (rp_file) {
> > > +            qemu_fclose(rp_file);
> > > +        }  
> > 
> > Open-code this is going backwards.  Please see if we can reuse
> > migration_release_dst_files() at least.
> > 
> > Thanks,
> > 
> > >  
> > >          /*
> > >           * Current channel is possibly broken. Release it.  Note that this is
> > > @@ -3758,6 +3752,7 @@ void migration_start_outgoing(MigrationState *s)
> > >      if (!qemu_file_set_blocking(s->to_dst_file, true, &local_err)) {
> > >          goto fail;
> > >      }
> > > +    s->rp_state.from_dst_file = qemu_file_get_return_path(s->to_dst_file);
> > >  
> > >      /*
> > >       * Open the return path. For postcopy, it is used exclusively. For
> > > @@ -3765,7 +3760,7 @@ void migration_start_outgoing(MigrationState *s)
> > >       * QEMU uses the return path.
> > >       */
> > >      if (migrate_postcopy_ram() || migrate_return_path()) {
> > > -        open_return_path_on_source(s);
> > > +        start_return_path_thread_on_source(s);
> > >      }
> > >
> > >
> > >  
> > >      /*
> > > 
> > > -- 
> > > 2.39.5
> > >   
> > 
> 



-- 
Peter Xu


