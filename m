Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367D6CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 17:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL2Rf-0002Oy-O5; Thu, 07 May 2026 13:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wL2Rb-0002OQ-CF
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wL2RY-0002N7-N5
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778174602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AlcHBxTK9YoW80lVhS9wc/md9QCLbs2pg1lkBvXyIGY=;
 b=VbpADl7puq09UT7a8XLKBqgDY6GxJIw5n6iI5GseEtJD2CBn8iBCWX1rwxj2MoNt3BLThF
 oVueTgkb9HXwKCPMgGoosUJv1GV8w/0Xnb+Ya4kxBjADYHMwAcTJLq6kUMSwLfiIpMf4Hr
 Cwpx+BvabURTNIZY989UTPDbqdWKsro=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-5sG7-GnAN3iAFkpHxb8LbQ-1; Thu, 07 May 2026 13:23:20 -0400
X-MC-Unique: 5sG7-GnAN3iAFkpHxb8LbQ-1
X-Mimecast-MFC-AGG-ID: 5sG7-GnAN3iAFkpHxb8LbQ_1778174600
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8aca172588cso25110906d6.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778174600; x=1778779400; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AlcHBxTK9YoW80lVhS9wc/md9QCLbs2pg1lkBvXyIGY=;
 b=Rpb2AOC3FZL62ZTyIePUBQjVB0+DFZgIZn0tjfuSSKUp+K5uk1f4PgY/r6XXL1jdun
 GcugZmHAAObTTXO8M0z28pmEEWaTmez+ey9/GXg76S/m0iYcLc/BZnG9bZEX+iiVqxrG
 mgmv+P0/U8xWamM/E6ovHIYc8VG9h8AxqaWhZ4l3N19sZWlYLkTDpfb+bpOOEBPn33Z8
 pL/gSaBqgjT89+WIkETkupczpC8D8nB/g7Cev9qMxtRmtJSHExGknpKEHMJ9RihQ7+CI
 SHpBUL6QIeT1Bo1Xq3Mo8JQRCXrDi8lo8SNjKkMPhcD+5pmOl5ko4GTtqsUQU8pwDq9u
 5ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778174600; x=1778779400;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AlcHBxTK9YoW80lVhS9wc/md9QCLbs2pg1lkBvXyIGY=;
 b=tPDkRCv6FRkgeYDCUBNRW8YZFx1Ep+zlyrrGEsvZJcfWiNI/4UXR9mzg9WWYVX4qV/
 N59sWKfSbezvaG5S+MFQpaxNrQWvY0m9aBG78B4M0cWZXP/OujhqPuix8bL/15QYNdP+
 pZy6510WRwcFJJ6fVgFDT1Nn25cs9qPJeLJ4bvFNMnu8r6/7Ezowzh3RHgKWoN9mBSoz
 KctO2UVQef3bqRNQ9TaodOKCIIxOyU3qyodduxTiTPMfCqmr98KLWk2LTPUqcXRr36+p
 UpwMV9ckE/ejwWppDJ7RrvVirrn5/PiKyoO5aRRPAOIv7sO8XA1LUJyWB/HgwX3SMOx5
 IJvA==
X-Gm-Message-State: AOJu0Yw6m41G9w42+9SrqNlmgkglnAd8gNQU94qAqrx+k97waGHsCMqC
 Q18E+0+Zkj/KbQnLtr7bh6yR8QVGPVIdz4QY783oasM+Qs2IeaSJtKBVg8fcsitgs0xsZkqnwB9
 s6ji+6rbLLBpOLt7o2OG17XUrRX39XXBlmQV+gLmonCNEV2xrTlN96UZT
X-Gm-Gg: AeBDieutMMQOe3lsihM+jiBZbOaEvMnDLc/wInBDV34Oky4Cn+I8y7sZPoqGAJ6QXIQ
 68PxkulBxwmAqsFrU1PUdHorYHc141l2hGc+TsMMdIcRk//BzOLQkzkabwvOTsJ0AzaISLFIq7Y
 OmwH24s5htb03xjM2bzw9yZlXRC0AgIw8KfIKBkphVFmnu8YGk3Sv/nzQKmCc7EzgLxuF0zbkt6
 KMOCalWxhM0h85mwsvMmtjsyhLAj56xjwtMpLvMFxgmGDd5EZBb5efDdnHrgkryzSyDCzUZXk90
 wgiAT6XJq739A+atsp61nryWeAd6II9EMoEp0aML7Ce6I4dNsD8xcuISpzVGICiOXHietzyhM4y
 wp0s+W2uRnDgOlzLF1PoWJ9cyVRK7fVcc3LoL3rLq66Ecrzo=
X-Received: by 2002:a05:6214:5783:b0:8ac:b3d4:d11 with SMTP id
 6a1803df08f44-8bc4323ac68mr129797606d6.14.1778174599672; 
 Thu, 07 May 2026 10:23:19 -0700 (PDT)
X-Received: by 2002:a05:6214:5783:b0:8ac:b3d4:d11 with SMTP id
 6a1803df08f44-8bc4323ac68mr129796736d6.14.1778174598951; 
 Thu, 07 May 2026 10:23:18 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bdf9081f49sm20268586d6.41.2026.05.07.10.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 10:23:18 -0700 (PDT)
Date: Thu, 7 May 2026 13:23:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Ben Chaney <bchaney@akamai.com>, Juraj Marcin <jmarcin@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Pranav Tyagi <prtyagi@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] migration: Fix crash on second migration when cancel early
Message-ID: <afzKhaaebtcYrEhe@x1.local>
References: <20260421175820.302795-1-peterx@redhat.com>
 <87pl38xnw7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pl38xnw7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

On Wed, May 06, 2026 at 05:51:20PM -0300, Fabiano Rosas wrote:
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
> Sorry for taking too long on this, it fell off my queue. Looks good to
> me. I reproduced the original issue and tested this patch under load
> with hacked tests:
> 
> /mode/transfer/defer + early cancel
> /cancel/src/after/setup + 2nd migrate
> 
> Tested-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thanks for double checking those!  Then let me pick this patch up.

> 
> BTW, I found it weird that we cannot start a second migration on the
> incoming after the first one having never properly started. Trying to
> actually do it without shutting down both QEMUs was fun. A bunch of
> asserts on the incoming side due to yank. After hacking a little and
> using migrate_recover to start the second migration on the incoming, I
> managed to make it work, but it hanged mid-transfer for some
> reason. Probably some iochannel reset needed.

Yeah, I am guessing we need to first fill the gaps on destination side to
properly manage those async tasks on port listens, etc.. and those can be
the owners of dangling iochannels.

-- 
Peter Xu


