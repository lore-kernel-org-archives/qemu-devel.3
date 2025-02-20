Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D3FC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 14:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl7qp-0003Zi-Os; Thu, 20 Feb 2025 09:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tl7qo-0003ZT-7F
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 09:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tl7ql-0002xZ-Oy
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 09:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740062904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9fouMV72Q6liuIYXeNVZASKsl10RDW5cnWNZtY73ln0=;
 b=diRwv+Y5FXT9jXNVwveBIAudfSGXwZa6O+VR5hfCC0lSuhqRbmBANfDgMM5Zc6WE/JiTX9
 mQ1Es8J9Twz/L6hCV2JRYIJkR0Rb6k64Wr6fO7O/FtMGnN5nNcMM548dVT6LYTxtRmjEz2
 23v65n3YDGW76lk1kuHXDLCftQ1ZdbE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-z0aRVs7IPMiY6kAG0qsHLA-1; Thu, 20 Feb 2025 09:48:21 -0500
X-MC-Unique: z0aRVs7IPMiY6kAG0qsHLA-1
X-Mimecast-MFC-AGG-ID: z0aRVs7IPMiY6kAG0qsHLA_1740062900
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f27acb979so920065f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 06:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740062900; x=1740667700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fouMV72Q6liuIYXeNVZASKsl10RDW5cnWNZtY73ln0=;
 b=Y0IVEMlE7eVw4xqu/kR/vxdTPgpKnkiLem7ZsX4ioCW8t6s13iMGb3pQre5GfAvtX+
 zHmsogXk7cDg/0l7fHLIH1LZzH7xd0dSR/5JNCvV3xc5icbyLfs/qMBNMApGhGuibpef
 Dq0aNi6nJyomQRcaqSQuJxo7L4+kAkjSJEzdAwwcEVO299BVieMOQF+jJ4sRBEl+Pcq/
 uXEmTnw0pdaTseaevK+ejJqXIrSRU7UD2tmi3o/umGScOsTHSwIltXFY8CsaEQj86oTr
 2MClWN+dcyUrpukNeFvTzw9j4I9acX4lT0apSQFl6TfeMFleqhK4Akt8d45KEDUfwky4
 zo7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV20TUpGMdfHosIpj2hsTsl9shvjSzHXRKDX8lgUuy69UNzS/q+mNZTsxEMvIsSd5ibUgW7KIhPU3D@nongnu.org
X-Gm-Message-State: AOJu0YxxJQgcl2ettT1LOlPtO7ueUpujHvU89zvEH6MIPAM8l03QQY2f
 d9zU5ScIm723zCAH5hMQGj8MjheB5aHdEWwvL1BBupZQMzr+WBcZ4xzOPzzTp8IvFzD9AcamXs/
 73oKnkx9p8qqLa2IMWVhoFTN8bSZNl/KV83BQIGnjUnw6HINAtina
X-Gm-Gg: ASbGncszcOEyjBPUmdyCzkAPEYRoqZtjCMBiV+7ohjuLWaah8GdrmjVtQjWjI3m3jqq
 9jpzEMczgmNc+7ut0S0zgZ0Ju1jEsK6yUjVLLtSaxAfJyDFxlXwtlVAsLvpcnxLMahXxhOQkssU
 4ozmxnjilYXLucdAPiIPl+9NcqzsffcbTvaM89+GSySflQsv+Q46dMErqTztstWPL7wfSlp7+LB
 LD292LRSshqv2ld8guXXcew7YUDISfNpDMCctWuLbjGXOY8JLK8harGm63sDKKqIWZEyOqGHzf7
 efQq5iKpqRIdN/iNVTMJBKnejA==
X-Received: by 2002:a05:6000:4011:b0:38d:d664:67d8 with SMTP id
 ffacd0b85a97d-38f33f31f9dmr15273437f8f.11.1740062900350; 
 Thu, 20 Feb 2025 06:48:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2BiQ+qT4pPuAAx8ih7NeuNbyGwoHp4zgM3CtO1UN6dafSOBEINjcVZxeWmP1wSuiYjpiiwQ==
X-Received: by 2002:a05:6000:4011:b0:38d:d664:67d8 with SMTP id
 ffacd0b85a97d-38f33f31f9dmr15273411f8f.11.1740062899901; 
 Thu, 20 Feb 2025 06:48:19 -0800 (PST)
Received: from rh-jmarcin (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258f8ddbsm20890240f8f.47.2025.02.20.06.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 06:48:19 -0800 (PST)
Date: Thu, 20 Feb 2025 15:48:17 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Yan Fu <yafu@redhat.com>
Subject: Re: [PATCH] migration: Fix UAF for incoming migration on
 MigrationState
Message-ID: <gtxeejfyyr4v7ebwtesl6zn743knf4bp73balfmlhlgxm3a5jw@kqig7553jjen>
References: <20250220132459.512610-1-peterx@redhat.com>
 <87h64o90dn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h64o90dn.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2025-02-20 11:06, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On the incoming migration side, QEMU uses a coroutine to load all the VM
> > states.  Inside, it may reference MigrationState on global states like
> > migration capabilities, parameters, error state, shared mutexes and more.
> >
> > However there's nothing yet to make sure MigrationState won't get
> > destroyed (e.g. after migration_shutdown()).  Meanwhile there's also no API
> > available to remove the incoming coroutine in migration_shutdown(),
> > avoiding it to access the freed elements.
> >
> > There's a bug report showing this can happen and crash dest QEMU when
> > migration is cancelled on source.
> >
> > When it happens, the dest main thread is trying to cleanup everything:
> >
> >   #0  qemu_aio_coroutine_enter
> >   #1  aio_dispatch_handler
> >   #2  aio_poll
> >   #3  monitor_cleanup
> >   #4  qemu_cleanup
> >   #5  qemu_default_main
> >
> > Then it found the migration incoming coroutine, schedule it (even after
> > migration_shutdown()), causing crash:
> >
> >   #0  __pthread_kill_implementation
> >   #1  __pthread_kill_internal
> >   #2  __GI_raise
> >   #3  __GI_abort
> >   #4  __assert_fail_base
> >   #5  __assert_fail
> >   #6  qemu_mutex_lock_impl
> >   #7  qemu_lockable_mutex_lock
> >   #8  qemu_lockable_lock
> >   #9  qemu_lockable_auto_lock
> >   #10 migrate_set_error
> >   #11 process_incoming_migration_co
> >   #12 coroutine_trampoline
> >
> > To fix it, take a refcount after an incoming setup is properly done when
> > qmp_migrate_incoming() succeeded the 1st time.  As it's during a QMP
> > handler which needs BQL, it means the main loop is still alive (without
> > going into cleanups, which also needs BQL).
> 
> We should start documenting uses of BQL and dependencies on the main
> loop more thoroughly. Otherwise later when we decide to move stuff into
> threads or QMP people decide to rework how QMP uses coroutines,
> etc. there we'll be many bugs.

Maybe it could be also useful to add assertions to places where locked
BQL is assumed and the assumption is not clear enough. Then, when
something changes, it will fail with a clear reason instead of debugging
race conditions that might occur.

> 
> I think the BQL is irrelevant here. The concurrent access is prevented
> by qmp_migrate_incoming() not being a coroutine, hence keeping the main
> loop from looping.
> 
> This case would be "relying on the qmp_migrate_incoming() being
> serialized with the dispatch of the incoming coroutine by the main
> loop".
> 
> >
> > Releasing the refcount now only until the incoming migration coroutine
> > finished or failed.  Hence the refcount is valid for both (1) setup phase
> > of incoming ports, mostly IO watches (e.g. qio_channel_add_watch_full()),
> > and (2) the incoming coroutine itself (process_incoming_migration_co()).
> >
> > Note that we can't unref in migration_incoming_state_destroy(), because
> > both qmp_xen_load_devices_state() and load_snapshot() will use it without
> > an incoming migration.  Those hold BQL so they're not prone to this issue.
> >
> > PS: I suspect nobody uses Xen's command at all, as it didn't register yank,
> > hence AFAIU the command should crash on master when trying to unregister
> > yank in migration_incoming_state_destroy()..  but that's another story.
> >
> > Also note that in some incoming failure cases we may not always unref the
> > MigrationState refcount, which is a trade-off to keep things simple.  We
> > could make it accurate, but it can be an overkill.  Some examples:
> >
> >   - Unlike most of the rest protocols, socket_start_incoming_migration()
> >     may create net listener after incoming port setup sucessfully.
> >     It means we can't unref in migration_channel_process_incoming() as a
> >     generic path because socket protocol might keep using MigrationState.
> >
> >   - For either socket or file, multiple IO watches might be created, it
> >     means logically each IO watch needs to take one refcount for
> >     MigrationState so as to be 100% accurate on ownership of refcount taken.
> >
> > In general, we at least need per-protocol handling to make it accurate,
> > which can be an overkill if we know incoming failed after all.  Add a short
> > comment to explain that when taking the refcount in qmp_migrate_incoming().
> >
> > Bugzilla: https://issues.redhat.com/browse/RHEL-69775
> > Tested-by: Yan Fu <yafu@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 40 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 38 insertions(+), 2 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index c597aa707e..f57d853e9f 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -116,6 +116,27 @@ static void migration_downtime_start(MigrationState *s)
> >      s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >  }
> >  
> > +/*
> > + * This is unfortunate: incoming migration actually needs the outgoing
> > + * migration state (MigrationState) to be there too, e.g. to query
> > + * capabilities, parameters, using locks, setup errors, etc.
> > + *
> > + * NOTE: when calling this, making sure current_migration exists and not
> > + * been freed yet!  Otherwise trying to access the refcount is already
> > + * an use-after-free itself..
> > + *
> > + * TODO: Move shared part of incoming / outgoing out into separate object.
> > + * Then this is not needed.
> 
> It will be needed on the new object still, no?
> 
> > + */
> > +static void migrate_incoming_ref_outgoing_state(void)
> > +{
> > +    object_ref(migrate_get_current());
> > +}
> > +static void migrate_incoming_unref_outgoing_state(void)
> > +{
> > +    object_unref(migrate_get_current());
> > +}
> > +
> >  static void migration_downtime_end(MigrationState *s)
> >  {
> >      int64_t now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > @@ -850,7 +871,7 @@ process_incoming_migration_co(void *opaque)
> >               * postcopy thread.
> >               */
> >              trace_process_incoming_migration_co_postcopy_end_main();
> > -            return;
> > +            goto out;
> >          }
> >          /* Else if something went wrong then just fall out of the normal exit */
> >      }
> > @@ -866,7 +887,8 @@ process_incoming_migration_co(void *opaque)
> >      }
> >  
> >      migration_bh_schedule(process_incoming_migration_bh, mis);
> > -    return;
> > +    goto out;
> > +
> >  fail:
> >      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> >                        MIGRATION_STATUS_FAILED);
> > @@ -883,6 +905,9 @@ fail:
> >  
> >          exit(EXIT_FAILURE);
> >      }
> > +out:
> > +    /* Pairs with the refcount taken in qmp_migrate_incoming() */
> > +    migrate_incoming_unref_outgoing_state();
> 
> Nit, the comment is redundant, the function name is already clear
> enough.
> 
> >  }
> >  
> >  /**
> > @@ -1888,6 +1913,17 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
> >          return;
> >      }
> >  
> > +    /*
> > +     * Making sure MigrationState is available until incoming migration
> > +     * completes.
> > +     *
> > +     * NOTE: QEMU _might_ leak this refcount in some failure paths, but
> > +     * that's OK.  This is the minimum change we need to at least making
> > +     * sure success case is clean on the refcount.  We can try harder to
> > +     * make it accurate for any kind of failures, but it might be an
> > +     * overkill and doesn't bring us much benefit.
> > +     */
> 
> Hopefully not any real leak... Let's see what my scripts say about
> it. If it doesn't trigger with migration-test that's fine.
> 
> > +    migrate_incoming_ref_outgoing_state();
> >      once = false;
> >  }
> 


