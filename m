Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F09E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZfJ-0005zc-Dq; Fri, 06 Dec 2024 09:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJZfF-0005zL-Qq
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:50:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJZfD-0007RU-Cv
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733496638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zOTtQB1Dh01ItUbjgIyQPJFE6Fk5qdWKYkVKO6EXmoY=;
 b=LzLX1hlo8khiS7htuwXmyS3LPKtqR3MYW6qoSKsZhnmUoE5E5IcS195W23wJHC91BAVT9Q
 XoyLml7vy2hyhQvNpmnQb0BLAH1eaRRbDAHv1gFW35WVGgVKDoJ3l3vDqWPajzwt0bgSPu
 JfvJvkYaEDGF1kRm+iIHp0g7Z+xKpJU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-SaIJgf3eNpqda083VyqlVQ-1; Fri, 06 Dec 2024 09:50:36 -0500
X-MC-Unique: SaIJgf3eNpqda083VyqlVQ-1
X-Mimecast-MFC-AGG-ID: SaIJgf3eNpqda083VyqlVQ
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d87c55ca85so51909746d6.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 06:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733496636; x=1734101436;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOTtQB1Dh01ItUbjgIyQPJFE6Fk5qdWKYkVKO6EXmoY=;
 b=bKYR3DNlAGIhvtWRTTfQWTbYeQ2hZ3FeUouKmSgJUoF5mFoPzx1xFyxZDyBHgjuS0V
 sNvSD88pN8E9UK0Rk3alUSOzE0XV+O0z+2Aq2OOdJTH+XaxTFZ4TFbu3FtEAIwvGCBMm
 PZJf+s8118d0E+HbqIZNkdRKgrn41raVdsHB9FZuiX7NWpu7sybt4EJUmMSxH4Okov0Y
 nhf9ooTMY2c5TBFlslvhTyYGB2Vhbc9w2cnUFd6iCORtE1kE0hgbwpCPNLk0KRvQ12pB
 GBg14FRAx1bR6DC2gYrgXbnyFw0/etJIU4JWSMN/OQmhc7i2GWRQ3sBUdbwCYUXwvDJl
 pe/g==
X-Gm-Message-State: AOJu0YxQcpP2DppRfhhbd8PeTI14/YvB28OInd8WjkiBbAQarUZ8J8WD
 THRh2nwayvPSOXDQ3qfnf75bIUgyEHZHl04DTHpJ08NSAENqkSWBSpbF7/BvO9LeU1xOdxoHzYL
 YftMmYI8qJmCs6UC1fZg2OWaT68ayaweFxTR3875c1Vp/wZn4YeI6
X-Gm-Gg: ASbGncsyTO/l1djoNmbep6Z7wYHtru47l8vkCLIa2TVD8DnhK2rTAkrvmXlnM7EUcOo
 HPfpvO4BSXS6bG54WGbpBDoqp3OVzDLHu7uhzg4PnM8LExBVPk9sDNuPn69GCfbboH41Yxz4Hf4
 osD4UDJ8pCC23cG4jGo8Bc7xLxLwwbdiUihh8LBLlFEzJljsQWxUnQuQgPdDaYFYhMlJ8QqwQLw
 3sxPyb1JujY/H0I4XOg7lE8lmDUCRrfj3t1WIywbY16s0XSpl/NiUAkwGlalOp8JMKbRRifbEnn
 rsIHxLxGcHY=
X-Received: by 2002:a05:6214:20eb:b0:6d8:e5f4:b969 with SMTP id
 6a1803df08f44-6d8e70a4069mr56795796d6.10.1733496636209; 
 Fri, 06 Dec 2024 06:50:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnzkzKkzbpkptU6zWgND0bKF+1whETQRLndz3mbbzbibK/8CdlodjuD2tfuKU7/l1SETzmDg==
X-Received: by 2002:a05:6214:20eb:b0:6d8:e5f4:b969 with SMTP id
 6a1803df08f44-6d8e70a4069mr56795416d6.10.1733496635880; 
 Fri, 06 Dec 2024 06:50:35 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66dda7sm19644086d6.21.2024.12.06.06.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 06:50:35 -0800 (PST)
Date: Fri, 6 Dec 2024 09:50:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 2/7] migration/multifd: Allow to sync with sender
 threads only
Message-ID: <Z1MPOQ6Tg_FVSiF9@x1n>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-3-peterx@redhat.com>
 <877c8dc58x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877c8dc58x.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, Dec 06, 2024 at 10:26:06AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Teach multifd_send_sync_main() to sync with threads only.
> >
> > We already have such requests, which is when mapped-ram is enabled with
> > multifd.  In that case, no SYNC messages will be pushed to the stream when
> > multifd syncs the sender threads because there's no destination threads
> > waiting for that.  The whole point of the sync is to make sure all threads
> > flushed their jobs.
> 
> s/flushed/finished/ otherwise we risk confusing people.

done.

> 
> >
> > So fundamentally we have a request to do the sync in different ways:
> >
> >   - Either to sync the threads only,
> >   - Or to sync the threads but also with the destination side.
> >
> > Mapped-ram did it already because of the use_packet check in the sync
> > handler of the sender thread.  It works.
> >
> > However it may stop working when e.g. VFIO may start to reuse multifd
> > channels to push device states.  In that case VFIO has similar request on
> > "thread-only sync" however we can't check a flag because such sync request
> > can still come from RAM which needs the on-wire notifications.
> >
> > Paving way for that by allowing the multifd_send_sync_main() to specify
> > what kind of sync the caller needs.  We can use it for mapped-ram already.
> >
> > No functional change intended.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/multifd.h        | 19 ++++++++++++++++---
> >  migration/multifd-nocomp.c |  7 ++++++-
> >  migration/multifd.c        | 15 +++++++++------
> >  3 files changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 50d58c0c9c..bd337631ec 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -19,6 +19,18 @@
> >  typedef struct MultiFDRecvData MultiFDRecvData;
> >  typedef struct MultiFDSendData MultiFDSendData;
> >  
> > +typedef enum {
> > +    /* No sync request */
> > +    MULTIFD_SYNC_NONE = 0,
> > +    /* Sync locally on the sender threads without pushing messages */
> > +    MULTIFD_SYNC_LOCAL,
> > +    /*
> > +     * Sync not only on the sender threads, but also push "SYNC" message to
> > +     * the wire (which is for a remote sync).
> 
> s/SYNC/MULTIFD_FLAG_SYNC/
> 
> Do we need to also mention that this needs to be paired with a
> multifd_recv_sync_main() via the emission of the
> RAM_SAVE_FLAG_MULTIFD_FLUSH flag on the stream?

If we want to mention something, IMO it would be better about what happens
on the src, not dest.  It can be too hard to follow if we connect that
directly to the dest behavior.

Does this look good to you?

    /*
     * Sync not only on the sender threads, but also push MULTIFD_FLAG_SYNC
     * message to the wire for each iochannel (which is for a remote sync).
     *
     * When remote sync is used, need to be paired with a follow up
     * RAM_SAVE_FLAG_EOS / RAM_SAVE_FLAG_MULTIFD_FLUSH message on the main
     * channel.
     */

> 
> > +     */
> > +    MULTIFD_SYNC_ALL,
> > +} MultiFDSyncReq;
> > +
> >  bool multifd_send_setup(void);
> >  void multifd_send_shutdown(void);
> >  void multifd_send_channel_created(void);
> > @@ -28,7 +40,7 @@ void multifd_recv_shutdown(void);
> >  bool multifd_recv_all_channels_created(void);
> >  void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
> >  void multifd_recv_sync_main(void);
> > -int multifd_send_sync_main(void);
> > +int multifd_send_sync_main(MultiFDSyncReq req);
> >  bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
> >  bool multifd_recv(void);
> >  MultiFDRecvData *multifd_get_recv_data(void);
> > @@ -143,7 +155,7 @@ typedef struct {
> >      /* multifd flags for each packet */
> >      uint32_t flags;
> >      /*
> > -     * The sender thread has work to do if either of below boolean is set.
> > +     * The sender thread has work to do if either of below field is set.
> >       *
> >       * @pending_job:  a job is pending
> >       * @pending_sync: a sync request is pending
> > @@ -152,7 +164,8 @@ typedef struct {
> >       * cleared by the multifd sender threads.
> >       */
> >      bool pending_job;
> > -    bool pending_sync;
> > +    MultiFDSyncReq pending_sync;
> > +
> >      MultiFDSendData *data;
> >  
> >      /* thread local variables. No locking required */
> > diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> > index 55191152f9..219f9e58ef 100644
> > --- a/migration/multifd-nocomp.c
> > +++ b/migration/multifd-nocomp.c
> > @@ -345,6 +345,8 @@ retry:
> >  
> >  int multifd_ram_flush_and_sync(void)
> >  {
> > +    MultiFDSyncReq req;
> > +
> >      if (!migrate_multifd()) {
> >          return 0;
> >      }
> > @@ -356,7 +358,10 @@ int multifd_ram_flush_and_sync(void)
> >          }
> >      }
> >  
> > -    return multifd_send_sync_main();
> > +    /* File migrations only need to sync with threads */
> > +    req = migrate_mapped_ram() ? MULTIFD_SYNC_LOCAL : MULTIFD_SYNC_ALL;
> > +
> > +    return multifd_send_sync_main(req);
> >  }
> >  
> >  bool multifd_send_prepare_common(MultiFDSendParams *p)
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 498e71fd10..2248bd2d46 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -523,7 +523,7 @@ static int multifd_zero_copy_flush(QIOChannel *c)
> >      return ret;
> >  }
> >  
> > -int multifd_send_sync_main(void)
> > +int multifd_send_sync_main(MultiFDSyncReq req)
> >  {
> >      int i;
> >      bool flush_zero_copy;
> 
> assert(req != MULTIFD_SYNC_NONE) ?

Sure.

> 
> > @@ -543,8 +543,8 @@ int multifd_send_sync_main(void)
> >           * We should be the only user so far, so not possible to be set by
> >           * others concurrently.
> >           */
> > -        assert(qatomic_read(&p->pending_sync) == false);
> > -        qatomic_set(&p->pending_sync, true);
> > +        assert(qatomic_read(&p->pending_sync) == MULTIFD_SYNC_NONE);
> > +        qatomic_set(&p->pending_sync, req);
> >          qemu_sem_post(&p->sem);
> >      }
> >      for (i = 0; i < migrate_multifd_channels(); i++) {
> > @@ -635,14 +635,17 @@ static void *multifd_send_thread(void *opaque)
> >               */
> >              qatomic_store_release(&p->pending_job, false);
> >          } else {
> > +            MultiFDSyncReq req = qatomic_read(&p->pending_sync);
> > +
> >              /*
> >               * If not a normal job, must be a sync request.  Note that
> >               * pending_sync is a standalone flag (unlike pending_job), so
> >               * it doesn't require explicit memory barriers.
> >               */
> > -            assert(qatomic_read(&p->pending_sync));
> > +            assert(req != MULTIFD_SYNC_NONE);
> >  
> > -            if (use_packets) {
> > +            /* Only push the SYNC message if it involves a remote sync */
> > +            if (req == MULTIFD_SYNC_ALL) {
> >                  p->flags = MULTIFD_FLAG_SYNC;
> >                  multifd_send_fill_packet(p);
> >                  ret = qio_channel_write_all(p->c, (void *)p->packet,
> > @@ -654,7 +657,7 @@ static void *multifd_send_thread(void *opaque)
> >                  stat64_add(&mig_stats.multifd_bytes, p->packet_len);
> >              }
> >  
> > -            qatomic_set(&p->pending_sync, false);
> > +            qatomic_set(&p->pending_sync, MULTIFD_SYNC_NONE);
> >              qemu_sem_post(&p->sem_sync);
> >          }
> >      }
> 

-- 
Peter Xu


