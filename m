Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E71BFA1FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFZgM-00022v-Un; Wed, 22 Apr 2026 11:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFZgJ-0001yi-Qr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 11:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFZgG-0000oA-PA
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 11:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776872398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=saU6kuDwma6n7Nmzao6ikScZYd76vvpOTyUjB/pj+pk=;
 b=fzP54wtsdcYHeWcgGUp7GNv+Ba/EdQjQadzT9bxKF1c6TkYbGec90knIG9+Hn8Lyrb70+r
 Ot+fD24XGXxYmXDPLHc8omPn0dGMs9L5FLJh1GRHl9//iz/SBojFi3uYaImirQxBHNK8Xe
 re1bTl8ZSthL3xSv+0v/fRz+N6RdNmg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-nOq3G7nPPVuurB9f7zObxQ-1; Wed, 22 Apr 2026 11:39:56 -0400
X-MC-Unique: nOq3G7nPPVuurB9f7zObxQ-1
X-Mimecast-MFC-AGG-ID: nOq3G7nPPVuurB9f7zObxQ_1776872396
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-47018d3424fso7441943b6e.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776872396; x=1777477196; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=saU6kuDwma6n7Nmzao6ikScZYd76vvpOTyUjB/pj+pk=;
 b=oITaPgLworJsis9IHmcuzD+1SrMnmTeKoot4+XbqWADARJ8auJB7wUIZFGrU7ksKdp
 RrVkN26UBf11d16U/f4NVd0c7BdCNChZFCEx5+aZF/9583p48tHt77wnZmqUroThmJaj
 gebsNR27yIedHkVtfUlKXBRfftLzDuqTYdMK1ugvK5AKIHUcxKszGtyOgiaFeQfjck+F
 anf7ViNukDQzczSX1mEKrKxyBSxceVqewhwtPIxfW3drD5AH14sl6ifFSaoih3av0eeJ
 +aUmYPMpcsPyzscvvm6hwViSzf8yCURuoO9SiCz7w5lnB31VYzLmaCdW4VvgiIFSLgfS
 9XTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776872396; x=1777477196;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=saU6kuDwma6n7Nmzao6ikScZYd76vvpOTyUjB/pj+pk=;
 b=j47tNqcQV79dfqyN9VLOq/dN6ibi5kZMsIwWG533nt3K30qSaDXMmZtEzLABbQT6aG
 R0iAYucfYioWJNSWIo3lYcxd5Pm1Gf94B+nExw3pW5toKzboaKnzsdQVvB4II8//d1hc
 kw5MY+dJEFjZqlxFwQA8/nBD1MH6V/ozRBbK3Z4bxLnCIp7ZqO1XaMHu6QQH63jO40nK
 gaXEXHjzqsHR3zPIyxdqY3uA0aX2VgfyXAn4S+0ROIfxJAQ5B8NTHHq23iO9EuIb8Kz4
 M5fBkWkBln7ZmEGhkJ9FZhR8Y8d9SfRnLV+CPjVK6FeNb2+n0SRiqMSaXTCQKL/2YLcf
 urzw==
X-Gm-Message-State: AOJu0YwqSsKSe1gHPHqYGAuk0C/TEUlAwCwzKkpgwR/xyGQP/RHfyNWK
 Ln98JqOZ7QwMUZAZpxpOm9cDwYnSZ1ZYSAN5s1RImddTQ1XLMbU6TG9san3zT8NNpa+3bIdpea1
 UPbzAktSMA91t7inKJAUuVVpcXnf8ClwWfmaI4G2nC++hBh9l82cx33q4
X-Gm-Gg: AeBDieuhH9Vv5gALKP4PM3+LAoKJCRE75BZYgHzNtFrwj377UV9Vj+Y1sI+lAJHgCD9
 t+hNGq4KIz0pEXACz8CrXm8USc+nHyJm4Tc3AwLJDRB74bw6YvvREgDvW730W5oc9QKonvH6GsV
 5qhBxAPCM361/CCyA9hl9/SRwFbNhovQDSCmTLwP3kEkEOlIYLLEX201q/emj803lw2Rphjmudi
 oqoKA6ivgT83IVJ+1R2WebxIGGMYN+SwWGjYUVjePTp5NcmqhCYLqVp4H+UeGoj5uXObxo6K2zv
 BHPvb14vISqW5UAP2qHLoG/8Anp6W81e2zzdKR50BDGffbjlYWG7iB//PGcEgH9f4gfoBVuQDbz
 nAu3/q/7Bom5uYhiDcaWVEAlUwQjO2LIq8u8Xz//EvnCH2/mAsHbTH1qtjA==
X-Received: by 2002:a05:6820:1b10:b0:684:5041:9296 with SMTP id
 006d021491bc7-69462de2716mr12367392eaf.10.1776871962891; 
 Wed, 22 Apr 2026 08:32:42 -0700 (PDT)
X-Received: by 2002:a05:6820:1b10:b0:684:5041:9296 with SMTP id
 006d021491bc7-69462de2716mr12367341eaf.10.1776871962213; 
 Wed, 22 Apr 2026 08:32:42 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac7d4e6sm132487036d6.20.2026.04.22.08.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 08:32:41 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:32:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Ben Chaney <bchaney@akamai.com>, Juraj Marcin <jmarcin@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Pranav Tyagi <prtyagi@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] migration: Fix crash on second migration when cancel early
Message-ID: <aejqGMhhrfQENE1X@x1.local>
References: <20260421175820.302795-1-peterx@redhat.com>
 <87wlxzdsv9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wlxzdsv9.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Wed, Apr 22, 2026 at 10:31:06AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Marc-André reported an issue on QEMU crash when retrying a cancelled
> > migration during early setup phase, see "Link:" for more information, and
> > also easy way to reproduce.
> >
> > This patch is a replacement of the prior fix proposed by not only switching
> > to migration_cleanup(), but also fixing it from CPR side, so that we track
> > hup_source properly to know if src QEMU is waiting or the HUP signal.
> >
> > To put it simple: this chunk of special casing in migration_cancel() should
> > not affect normal migration, but only cpr-transfer migration to cover the
> > small window when the src QEMU is waiting for a HUP signal on cpr
> > channel (so that src QEMU can continue the migration on the main channel).
> >
> > To achieve that, we'll also need to remember to detach the hup_source
> > whenenver invoked: after that point, we should always be able to cleanup
> > the migration.
> >
> > It's not a generic operation to explicitly detach a gsource from its
> > context while in its dispatch() function.  But it should be safe, because
> > gsource disptch() will only happen with a boosted refcount for the
> > dispatcher so that the gsource will not be freed until the callback
> > completes. It's also safe to return G_SOURCE_REMOVE after the gsource is
> > detached, as glib will simply ignore the G_SOURCE_REMOVE.
> >
> > One can refer to latest 2.86.5 glib code in g_main_dispatch() for that:
> >
> > https://github.com/GNOME/glib/blob/2.86.5/glib/gmain.c#L3592
> >
> > When at this, add a bunch of assertions to make sure nothing surprises us.
> >
> > After this patch applied, the 2nd migration will not crash QEMU, instead
> > it'll be in CANCELLING until the socket connection times out (it will take
> > ~2min on my Fedora default kernel).  During this process no 2nd migration
> > will be allowed, and after it timed out migration can be restarted.
> >
> > It's because so far we don't have control over socket_connect_outgoing(),
> > or anything yet managed by a task executed in qio_task_run_in_thread().
> > Speeding up the cancellation to be left for future.

[1]

> >
> > I also tested cpr-transfer by only providing cpr channel not the main
> > channel (with -incoming defer), kickoff migration on source, then cancel it
> > on source directly without providing the main channel.  It keeps working.
> >
> > I wanted to add an unit test for that but it'll need to refactor current
> > cpr-transfer tests first; let's leave it for later.
> >
> > Link: https://lore.kernel.org/r/20260417184742.293061-1-marcandre.lureau@redhat.com
> > Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/migration/cpr.h  |  1 +
> >  migration/migration.h    |  5 +++++
> >  migration/cpr-transfer.c | 10 ++++++++++
> >  migration/migration.c    | 31 +++++++++++++++++++++++--------
> >  4 files changed, 39 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> > index 5850fd1788..ebf09a2f0a 100644
> > --- a/include/migration/cpr.h
> > +++ b/include/migration/cpr.h
> > @@ -57,6 +57,7 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
> >  void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc func,
> >                                  void *opaque);
> >  void cpr_transfer_source_destroy(MigrationState *s);
> > +bool cpr_transfer_source_active(MigrationState *s);
> >  
> >  void cpr_exec_init(void);
> >  QEMUFile *cpr_exec_output(Error **errp);
> > diff --git a/migration/migration.h b/migration/migration.h
> > index b6888daced..2bc2787480 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -514,6 +514,11 @@ struct MigrationState {
> >      bool postcopy_package_loaded;
> >      QemuEvent postcopy_package_loaded_event;
> >  
> > +    /*
> > +     * When set, it means cpr-transfer is waiting for the HUP signal from
> > +     * destination to continue the 2nd step of migration via the main
> > +     * channel.
> > +     */
> >      GSource *hup_source;
> >  
> >      /*
> > diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
> > index 61d5c9dce2..9defe7bad7 100644
> > --- a/migration/cpr-transfer.c
> > +++ b/migration/cpr-transfer.c
> > @@ -6,6 +6,7 @@
> >   */
> >  
> >  #include "qemu/osdep.h"
> > +#include "qemu/main-loop.h"
> >  #include "qapi/clone-visitor.h"
> >  #include "qapi/error.h"
> >  #include "qapi/qapi-visit-migration.h"
> > @@ -79,6 +80,7 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
> >  void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc func,
> >                                  void *opaque)
> >  {
> > +    assert(bql_locked());
> >      s->hup_source = qio_channel_create_watch(cpr_state_ioc(), G_IO_HUP);
> 
> Before I review the patch in detail, let me just make a high level
> comment here:
> 
> I wonder if we should have a "register" in the iochannel layer for the
> several watches we create. So we could at migration_cancel time call

Yes, we need to do this part of mgmt better either now or at some point..

Said that, just to mention: what you're discussing below seems to be about
dest QEMU, not src QEMU.

Here the "unmanaged async tasks" I mentioned above [1] is only about src
QEMU.  It only applies to socket channels and socket_connect_outgoing().
It is slightly even trickier, IIUC, because instead of creating a watch
directly, it creates a pthread and run the task there, then when the task
fn() completes that thread will inject one event back to the main event
loop.  See qio_task_thread_worker() and the @completion gsource.

One thing I can try to do is to work out fast cancellation for sockets here
on src side, so we don't need to wait for that 2min timeout..  But it would
still be nice to have this fix land first because it fixes a crash.. so it
may still be something on top but I can start look into.  I actually don't
know how frequent users will suffer from the 2min timeout: normally when
the host:port isn't available we should just get disconnected fast.

Starting from now, I'll only discuss about dest QEMU side (IOW, may not be
directly relevant to this patch).

> g_clear_handle/g_source_destroy on all at the same time. The management
> of these source ids is getting too particular.
> 
> I'm seeing that exec, fd and file migration all ignore the id returned
> by channel-watch.c. In the case of exec this is causing
> qio_channel_command_finalize() to be skipped, leaving the exec'ed
> command process behind! So what I did as an experiment was to register

Are we?

We're on the same page at least on that the gsources are not yet managed.
But I am not sure they're leaked.

exec_connect_incoming() does qio_channel_add_watch_full(), within itself it
will release the refcount of the IO watch gsource.  It means it'll be a
dangling gsource on the main context.  So after the spawn of the new
process, it will still be finalized properly?

> watches like this:
> 
>   static inline void migration_watch_data(void) {};
>   
>   qio_channel_add_watch_full(ioc, G_IO_IN, exec_accept_incoming_migration,
>                              migration_watch_data, NULL,
>                              g_main_context_get_thread_default());
> 
> and at migrate_cancel():
> 
>   while(g_source_remove_by_user_data(migration_watch_data));
> 
> It feels to me that a wrapper around this, or even a hashtable of "func
> ptr->GSource" or "str->GSource id" would allow us to call a (say)
> qio_channel_clear_watches() and avoid having to do the management in
> each of the clients.

In general, this whole idea sounds reasonable.  I just want to check with
you on which side of QEMU we're talking about.

To me, dest QEMU is less of a concern when it can easily be killed.  But
still it's good to be able to manage those.  Src QEMU is more important
from that perspective.

> 
> We already have stuff like IOWatchPoll which kind of already wraps the
> watch creation in a sense.
> 
> >      g_source_set_callback(s->hup_source,
> >                            (GSourceFunc)func,
> > @@ -89,9 +91,17 @@ void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc func,
> >  
> >  void cpr_transfer_source_destroy(MigrationState *s)
> >  {
> > +    assert(bql_locked());
> >      if (s->hup_source) {
> >          g_source_destroy(s->hup_source);
> >          g_source_unref(s->hup_source);
> >          s->hup_source = NULL;
> >      }
> >  }
> > +
> > +bool cpr_transfer_source_active(MigrationState *s)
> > +{
> > +    /* Whenever the HUP gsource is available, it's active. */
> > +    assert(bql_locked());
> > +    return s->hup_source;
> > +}
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 5c9aaa6e58..58c1e56766 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1469,14 +1469,19 @@ void migration_cancel(void)
> >      }
> >  
> >      /*
> > -     * If migration_connect_outgoing has not been called, then there
> > -     * is no path that will complete the cancellation. Do it now.
> > -     */
> > -    if (setup && !s->to_dst_file) {
> > -        migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
> > -                          MIGRATION_STATUS_CANCELLED);
> > -        cpr_state_close();
> > -        cpr_transfer_source_destroy(s);
> > +     * This is cpr-transfer specific processing.
> > +     *
> > +     * If this is true, it means cpr-transfer migration is waiting for the
> > +     * destination to send HUP event on CPR channel to continue the next
> > +     * phase.  If so, do the cleanup proactively to avoid get stuck in
> > +     * CANCELLING state.
> > +     */
> > +    if (cpr_transfer_source_active(s)) {
> > +        assert(migrate_mode() == MIG_MODE_CPR_TRANSFER);
> > +        assert(setup && !s->to_dst_file);
> > +        migration_cleanup(s);
> > +        /* Now all things should have been released */
> > +        assert(!cpr_transfer_source_active(s));
> >      }
> >  }
> >  
> > @@ -2009,12 +2014,22 @@ static gboolean migration_connect_outgoing_cb(QIOChannel *channel,
> >      MigrationState *s = migrate_get_current();
> >      Error *local_err = NULL;
> >  
> > +    /*
> > +     * Detach and release the GSource right after use.  We rely on this to
> > +     * detect this small cpr-transfer window of "waiting for HUP event".
> > +     */
> > +    cpr_transfer_source_destroy(s);
> > +
> >      migration_connect_outgoing(s, opaque, &local_err);
> >  
> >      if (local_err) {
> >          migration_connect_error_propagate(s, local_err);
> >      }
> >  
> > +    /*
> > +     * This is redundant as we do cpr_transfer_source_destroy() at the
> > +     * entry, but it's benign; glib will just skip the detach.
> > +     */
> >      return G_SOURCE_REMOVE;
> >  }
> 

-- 
Peter Xu


