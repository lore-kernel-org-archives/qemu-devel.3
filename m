Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C61CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyR3A-00045x-Jx; Tue, 16 Sep 2025 04:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyR39-00045Y-NO
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyR37-0005YY-62
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758011306;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1JzctO1HNQVySkb42iphrUbmyIZys3cWDEQaxz/ot9Q=;
 b=f7H0zIohx2VMB+E4tKhedwfn33JwrBsN2iUGW31cD3N0rYbY9d3EcIazL4JV46VRoNlxsh
 t6rE7thK2f2QvAJbCis3SHzogBoibPwwk/jiQ8bq5eTtQ+2SkseHy4P2r9Y1/Nk+sp1/Mb
 5vw/NVq2uIdwwDj1c47nooHXbbzkEaw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-xoKumOi6NqCvGy5hn6UeQg-1; Tue,
 16 Sep 2025 04:28:23 -0400
X-MC-Unique: xoKumOi6NqCvGy5hn6UeQg-1
X-Mimecast-MFC-AGG-ID: xoKumOi6NqCvGy5hn6UeQg_1758011302
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C1F9195608E; Tue, 16 Sep 2025 08:28:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 388D318003FC; Tue, 16 Sep 2025 08:28:18 +0000 (UTC)
Date: Tue, 16 Sep 2025 09:28:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, leiyang@redhat.com,
 marcandre.lureau@redhat.com, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v4 05/12] migration: qemu_file_set_blocking(): add errp
 parameter
Message-ID: <aMkfn2_GBUDlUB6O@redhat.com>
References: <20250915193105.230085-1-vsementsov@yandex-team.ru>
 <20250915193105.230085-6-vsementsov@yandex-team.ru>
 <aMh0sjXkQ9IYo_SB@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMh0sjXkQ9IYo_SB@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 15, 2025 at 04:18:58PM -0400, Peter Xu wrote:
> On Mon, Sep 15, 2025 at 10:30:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > qemu_file_set_blocking() is a wrapper on qio_channel_set_blocking(),
> > so let's passthrough the errp.
> 
> This looks all reasonable in general.
> 
> Said that, using error_abort in migration code normally are not suggested
> because it's too strong.

Note, that prior to this series, the existing qemu_socket_set_nonblock
method that migration is calling will assert on failure. This series
removes that assert and propagates it back to the callers to let them
decide what to do. Ideally they would gracefully handle it, but if
they assert that is no worse than current behaviour.

> I did check all of below should be on the incoming side which is not as
> severe (because killing dest qemu before switchover is normally
> benign). Still, can we switch all below users to error_warn (including the
> one below that may want to error_report_err(), IMHO a warn report is fine
> even for such error)?

IMHO ignoring a failure to change the blocking flag status is not
a warnnig, it is unrecoverable for the migration operation. It
should be possible to propagate the error in some way, but it will
potentially require changes across multiple migration methods to
handle this.

> 
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > ---
> >  migration/colo.c         | 5 ++++-
> >  migration/migration.c    | 8 +++++---
> >  migration/postcopy-ram.c | 2 +-
> >  migration/qemu-file.c    | 4 ++--
> >  migration/qemu-file.h    | 2 +-
> >  migration/savevm.c       | 4 ++--
> >  6 files changed, 15 insertions(+), 10 deletions(-)
> > 
> > diff --git a/migration/colo.c b/migration/colo.c
> > index e0f713c837..cf4d71d9ed 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -859,7 +859,10 @@ static void *colo_process_incoming_thread(void *opaque)
> >       * coroutine, and here we are in the COLO incoming thread, so it is ok to
> >       * set the fd back to blocked.
> >       */
> > -    qemu_file_set_blocking(mis->from_src_file, true);
> > +    if (!qemu_file_set_blocking(mis->from_src_file, true, &local_err)) {
> > +        error_report_err(local_err);
> > +        goto out;
> > +    }
> >  
> >      colo_incoming_start_dirty_log();
> >  
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 10c216d25d..e1ac4d73c2 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -951,7 +951,7 @@ static void migration_incoming_setup(QEMUFile *f)
> >  
> >      assert(!mis->from_src_file);
> >      mis->from_src_file = f;
> > -    qemu_file_set_blocking(f, false);
> > +    qemu_file_set_blocking(f, false, &error_abort);
> >  }
> >  
> >  void migration_incoming_process(void)
> > @@ -971,7 +971,7 @@ static bool postcopy_try_recover(void)
> >          /* This should be set already in migration_incoming_setup() */
> >          assert(mis->from_src_file);
> >          /* Postcopy has standalone thread to do vm load */
> > -        qemu_file_set_blocking(mis->from_src_file, true);
> > +        qemu_file_set_blocking(mis->from_src_file, true, &error_abort);
> >  
> >          /* Re-configure the return path */
> >          mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
> > @@ -4002,7 +4002,9 @@ void migration_connect(MigrationState *s, Error *error_in)
> >      }
> >  
> >      migration_rate_set(rate_limit);
> > -    qemu_file_set_blocking(s->to_dst_file, true);
> > +    if (!qemu_file_set_blocking(s->to_dst_file, true, &local_err)) {
> > +        goto fail;
> > +    }
> >  
> >      /*
> >       * Open the return path. For postcopy, it is used exclusively. For
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 45af9a361e..0172172343 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -1909,7 +1909,7 @@ void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file)
> >       * The new loading channel has its own threads, so it needs to be
> >       * blocked too.  It's by default true, just be explicit.
> >       */
> > -    qemu_file_set_blocking(file, true);
> > +    qemu_file_set_blocking(file, true, &error_abort);
> >      mis->postcopy_qemufile_dst = file;
> >      qemu_sem_post(&mis->postcopy_qemufile_dst_done);
> >      trace_postcopy_preempt_new_channel();
> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> > index d5c6e7ec61..0f4280df21 100644
> > --- a/migration/qemu-file.c
> > +++ b/migration/qemu-file.c
> > @@ -888,9 +888,9 @@ void qemu_put_counted_string(QEMUFile *f, const char *str)
> >   *       both directions, and thus changing the blocking on the main
> >   *       QEMUFile can also affect the return path.
> >   */
> > -void qemu_file_set_blocking(QEMUFile *f, bool block)
> > +bool qemu_file_set_blocking(QEMUFile *f, bool block, Error **errp)
> >  {
> > -    qio_channel_set_blocking(f->ioc, block, NULL);
> > +    return qio_channel_set_blocking(f->ioc, block, errp);
> >  }
> >  
> >  /*
> > diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> > index f5b9f430e0..c13c967167 100644
> > --- a/migration/qemu-file.h
> > +++ b/migration/qemu-file.h
> > @@ -71,7 +71,7 @@ void qemu_file_set_error(QEMUFile *f, int ret);
> >  int qemu_file_shutdown(QEMUFile *f);
> >  QEMUFile *qemu_file_get_return_path(QEMUFile *f);
> >  int qemu_fflush(QEMUFile *f);
> > -void qemu_file_set_blocking(QEMUFile *f, bool block);
> > +bool qemu_file_set_blocking(QEMUFile *f, bool block, Error **errp);
> >  int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
> >  void qemu_set_offset(QEMUFile *f, off_t off, int whence);
> >  off_t qemu_get_offset(QEMUFile *f);
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index fabbeb296a..abe0547f9b 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2095,7 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >       * Because we're a thread and not a coroutine we can't yield
> >       * in qemu_file, and thus we must be blocking now.
> >       */
> > -    qemu_file_set_blocking(f, true);
> > +    qemu_file_set_blocking(f, true, &error_fatal);
> >  
> >      /* TODO: sanity check that only postcopiable data will be loaded here */
> >      load_res = qemu_loadvm_state_main(f, mis);
> > @@ -2108,7 +2108,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >      f = mis->from_src_file;
> >  
> >      /* And non-blocking again so we don't block in any cleanup */
> > -    qemu_file_set_blocking(f, false);
> > +    qemu_file_set_blocking(f, false, &error_fatal);
> >  
> >      trace_postcopy_ram_listen_thread_exit();
> >      if (load_res < 0) {
> > -- 
> > 2.48.1
> > 
> 
> -- 
> Peter Xu
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


