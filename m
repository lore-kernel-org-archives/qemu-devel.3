Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E70E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 22:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIyB4-0004vQ-HW; Wed, 04 Dec 2024 17:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIyB2-0004uB-Mr
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIyB0-0003eb-OZ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733352537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NCrxB+nmPNiaerRV2hyqsFy8fx6aLE1CgxV1XqNstG4=;
 b=FnBz6IAzfE9EANPw0N4ZDrrr/vximzI0stZDQ4CqpSWAJBa4Igp0DaDSRAnqGkHsj6VFK0
 kwcuqAZH/1amG/6gUvVH0gT4lYSrfNicUc/K0NEZCVCRrbR4Oyj0DvLZJGJ5sK6C7VFlTc
 M0MyhMYNqDxZEpclPjc+SVOldd0z2hY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-Ig22DLtvMIOOCXyMCPIVVg-1; Wed, 04 Dec 2024 17:48:56 -0500
X-MC-Unique: Ig22DLtvMIOOCXyMCPIVVg-1
X-Mimecast-MFC-AGG-ID: Ig22DLtvMIOOCXyMCPIVVg
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-841aa90930cso21404939f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 14:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733352536; x=1733957336;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NCrxB+nmPNiaerRV2hyqsFy8fx6aLE1CgxV1XqNstG4=;
 b=Z3URwGEoxhLTuV8hIBrUB9/AgDrvthDMthMrCgUEOFAQi/M3NMSP2HPaYQeTnbkeUx
 ct1+HUtA1wauWJBTyKoisOtLrdTuohnTFCbbvvY1b3TUPczWn3CAaslfoU7x3asvSNCb
 IdSrWupmqfhdU2Qaez8kna+rOMnoNSX8iXUR4UKdEMFo+ZA6sBg4og68vLT7C/CkTWRS
 GJS5U5yVe8vGzk1IAKWJvNkMBtQ94uzEAmAgLAUot8n34g4dp2ZVtocLTr/6yElyDWm0
 /ABI3K661TRCXi5EGdFVbgjMEChziopUOAOaBp7JvrLe7R8Ulrdj5WotS6AK/LuLci0l
 Z9Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU62dTcIYqF2lSQtIpxSHtbltPsReW77hkyxCQVWoC2LvHzlqQDQU6U/OxBVi9JSrCUoHRrT8fkmPmp@nongnu.org
X-Gm-Message-State: AOJu0YzqggwUT7RAU7CYRc0W9Ujum8GodMKgDpphFlABiSwb8vMEIK/2
 R0YAI9pJlLvMk6HgSQ2l+4DHWFjzbf+Eg++G8I9fkxHrwO/2RFyyX/LdWhUYFv1J4ORZtqwlRdx
 kF8f1x5aoKBa9lPzGbsqvmTqrvBAMkDgBPJgbkebs1FPhgFKZ4Kn9
X-Gm-Gg: ASbGncsQ8Tl8RNzAUEKSNEpR78ZmJm1ZbcBiQO/mv2LTKeHLF5B3PIKtO/ksGpRkfW8
 L/yDdikj4By9qNfmCnO8dzrw2F8/4zXl9ypJ6q0Wr3Sf+UxOp7UjPE0NoAYEViNGOXfychiwi5v
 Kd/zICyS0gnBziGQTJgutieejWc92tTFumkQn/o381aZeqrhurOVRe+UdGEJCE1/DunM4Ss57xV
 844gjX0w1yJBJnrJ7d0AF3Nk6/S9r3ADHruNuNcRqC4+gCOQQ/BfvqyVodZTsH+Yly+Z5CPD4cU
 YEAF38JwWYM=
X-Received: by 2002:a05:6602:3405:b0:841:a1c0:c058 with SMTP id
 ca18e2360f4ac-8445b577d49mr1132819639f.9.1733352535746; 
 Wed, 04 Dec 2024 14:48:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPTd5XBC2Pfd23AJlECiUND0Mi1V5LCaKgyGJY/42esHEU7hGG7uso2dw/N82oy7mqxDZ1LQ==
X-Received: by 2002:a05:6602:3405:b0:841:a1c0:c058 with SMTP id
 ca18e2360f4ac-8445b577d49mr1132816639f.9.1733352535436; 
 Wed, 04 Dec 2024 14:48:55 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a707c7sm1260439f.43.2024.12.04.14.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 14:48:54 -0800 (PST)
Date: Wed, 4 Dec 2024 17:48:52 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 08/24] migration: Add thread pool of optional load
 threads
Message-ID: <Z1DcVH6j7pzboucr@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
 <9a229308-2c80-4ee2-8c49-5fec2207ad74@redhat.com>
 <489d1769-3807-4007-888c-608c1e9407fb@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <489d1769-3807-4007-888c-608c1e9407fb@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 27, 2024 at 09:16:49PM +0100, Maciej S. Szmigiero wrote:
> On 27.11.2024 10:13, Cédric Le Goater wrote:
> > On 11/17/24 20:20, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > Some drivers might want to make use of auxiliary helper threads during VM
> > > state loading, for example to make sure that their blocking (sync) I/O
> > > operations don't block the rest of the migration process.
> > > 
> > > Add a migration core managed thread pool to facilitate this use case.
> > > 
> > > The migration core will wait for these threads to finish before
> > > (re)starting the VM at destination.
> > > 
> > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > ---
> > >   include/migration/misc.h |  3 ++
> > >   include/qemu/typedefs.h  |  1 +
> > >   migration/savevm.c       | 77 ++++++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 81 insertions(+)
> > > 
> > > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > > index 804eb23c0607..c92ca018ab3b 100644
> > > --- a/include/migration/misc.h
> > > +++ b/include/migration/misc.h
> > > @@ -45,9 +45,12 @@ bool migrate_ram_is_ignored(RAMBlock *block);
> > >   /* migration/block.c */
> > >   AnnounceParameters *migrate_announce_params(void);
> > > +
> > >   /* migration/savevm.c */
> > >   void dump_vmstate_json_to_file(FILE *out_fp);
> > > +void qemu_loadvm_start_load_thread(MigrationLoadThread function,
> > > +                                   void *opaque);
> > >   /* migration/migration.c */
> > >   void migration_object_init(void);
> > > diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> > > index 3d84efcac47a..8c8ea5c2840d 100644
> > > --- a/include/qemu/typedefs.h
> > > +++ b/include/qemu/typedefs.h
> > > @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;
> > >    * Function types
> > >    */
> > >   typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
> > > +typedef int (*MigrationLoadThread)(bool *abort_flag, void *opaque);
> > >   #endif /* QEMU_TYPEDEFS_H */
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index 1f58a2fa54ae..6ea9054c4083 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -54,6 +54,7 @@
> > >   #include "qemu/job.h"
> > >   #include "qemu/main-loop.h"
> > >   #include "block/snapshot.h"
> > > +#include "block/thread-pool.h"
> > >   #include "qemu/cutils.h"
> > >   #include "io/channel-buffer.h"
> > >   #include "io/channel-file.h"
> > > @@ -71,6 +72,10 @@
> > >   const unsigned int postcopy_ram_discard_version;
> > > +static ThreadPool *load_threads;
> > > +static int load_threads_ret;
> > > +static bool load_threads_abort;
> > > +
> > >   /* Subcommands for QEMU_VM_COMMAND */
> > >   enum qemu_vm_cmd {
> > >       MIG_CMD_INVALID = 0,   /* Must be 0 */
> > > @@ -2788,6 +2793,12 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
> > >       int ret;
> > >       trace_loadvm_state_setup();
> > > +
> > > +    assert(!load_threads);
> > > +    load_threads = thread_pool_new();
> > > +    load_threads_ret = 0;
> > > +    load_threads_abort = false;
> > 
> > I would introduce a qemu_loadvm_thread_pool_create() helper.
> 
> Will do.

On top of Cedric's suggestion..

Maybe move it over to migration_object_init()?  Then we keep
qemu_loadvm_state_setup() only invoke the load_setup()s.

> 
> > Why is the thead pool always created ? Might be OK.
> > 
> 
> This functionality provides a generic auxiliary load helper threads
> pool, not necessarily tied to the multifd device state transfer.
> 
> That's why the pool is created unconditionally.
> 
> > > +
> > >       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> > >           if (!se->ops || !se->ops->load_setup) {
> > >               continue;
> > > @@ -2806,19 +2817,72 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
> > >               return ret;
> > >           }
> > >       }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +struct LoadThreadData {
> > > +    MigrationLoadThread function;
> > > +    void *opaque;
> > > +};
> > > +
> > > +static int qemu_loadvm_load_thread(void *thread_opaque)
> > > +{
> > > +    struct LoadThreadData *data = thread_opaque;
> > > +    int ret;
> > > +
> > > +    ret = data->function(&load_threads_abort, data->opaque);
> > > +    if (ret && !qatomic_read(&load_threads_ret)) {
> > > +        /*
> > > +         * Racy with the above read but that's okay - which thread error
> > > +         * return we report is purely arbitrary anyway.
> > > +         */
> > > +        qatomic_set(&load_threads_ret, ret);
> > > +    }
> > > +
> > >       return 0;>   }
> > > +void qemu_loadvm_start_load_thread(MigrationLoadThread function,
> > > +                                   void *opaque)
> > > +{> +    struct LoadThreadData *data;
> > > +
> > > +    /* We only set it from this thread so it's okay to read it directly */
> > > +    assert(!load_threads_abort);
> > > +
> > > +    data = g_new(struct LoadThreadData, 1);
> > > +    data->function = function;
> > > +    data->opaque = opaque;
> > > +
> > > +    thread_pool_submit(load_threads, qemu_loadvm_load_thread,
> > > +                       data, g_free);
> > > +    thread_pool_adjust_max_threads_to_work(load_threads);
> > > +}> +>   void qemu_loadvm_state_cleanup(void)
> > >   {
> > >       SaveStateEntry *se;
> > >       trace_loadvm_state_cleanup();
> > > +
> > >       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> > >           if (se->ops && se->ops->load_cleanup) {
> > >               se->ops->load_cleanup(se->opaque);
> > >           }
> > >       }
> > > +
> > > +    /*
> > > +     * We might be called even without earlier qemu_loadvm_state_setup()
> > > +     * call if qemu_loadvm_state() fails very early.
> > > +     */
> > > +    if (load_threads) {
> > > +        qatomic_set(&load_threads_abort, true);
> > > +        bql_unlock(); /* Load threads might be waiting for BQL */
> > > +        thread_pool_wait(load_threads);
> > > +        bql_lock();
> > > +        g_clear_pointer(&load_threads, thread_pool_free);
> > > +    }
> > 
> > I would introduce a qemu_loadvm_thread_pool_destroy() helper
> 
> Will do.

Then this one may belong to migration_incoming_state_destroy().

> 
> > >   }
> > >   /* Return true if we should continue the migration, or false. */
> > > @@ -3007,6 +3071,19 @@ int qemu_loadvm_state(QEMUFile *f)
> > >           return ret;
> > >       }
> > > +    if (ret == 0) {
> > > +        bql_unlock(); /* Let load threads do work requiring BQL */
> > > +        thread_pool_wait(load_threads);
> > > +        bql_lock();
> > > +
> > > +        ret = load_threads_ret;
> > > +    }
> > > +    /*
> > > +     * Set this flag unconditionally so we'll catch further attempts to
> > > +     * start additional threads via an appropriate assert()
> > > +     */
> > > +    qatomic_set(&load_threads_abort, true);

I assume this is only for debugging purpose and not required.

Setting "abort all threads" to make sure "nobody will add more thread
tasks" is pretty awkward, IMHO.  If we really want to protect against it
and fail hard, it might be easier after the thread_pool_wait() we free the
pool directly (destroy() will see NULL so it'll skip; still need to free
there in case migration failed before this).  Then any enqueue will access
null pointer on the pool.

-- 
Peter Xu


