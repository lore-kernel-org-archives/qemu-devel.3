Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E656DC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgABU-0006qb-Bs; Thu, 06 Feb 2025 17:17:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgAB3-0006iZ-4S
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:16:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgAAz-0003gv-Gi
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738880207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s3VNz428wissCdwqp1I1HvwdE7fhTbo/YCNNUaTfSY4=;
 b=i/yK5I8Q9JDfsj18cCMRQzSToksZcq9gvqxYTQbYvEk2O8vtJyB7Ewrr/Pa6LptNYsEJKl
 7PsZ5CtFicJvzhpDt7XPOuLXbAR9wfEFc1Wsis7KJuiC8HE9bHNRkOkLTDnOmOdCzpAHSB
 LzbHle1f4p5Na0KOfmbBbkplabZFgOo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-3zRTAdyoOHiKiLaBh6W64g-1; Thu, 06 Feb 2025 17:16:45 -0500
X-MC-Unique: 3zRTAdyoOHiKiLaBh6W64g-1
X-Mimecast-MFC-AGG-ID: 3zRTAdyoOHiKiLaBh6W64g
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e433680e07so28502656d6.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738880205; x=1739485005;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3VNz428wissCdwqp1I1HvwdE7fhTbo/YCNNUaTfSY4=;
 b=f4m45APBHP+jy39/rRaan1/bZuaWf+TUNxj00Cngxb96fnfSzTadii9Ji2XpHkdE7k
 wG2wlm2+/SU24mAu00jXHjTqU+tDeardVigk76DKcbyVnM3hOW8yhTBN8GvC5RVI+82y
 SAN/Sz06+VA+lrrisLroEs9AA+fAdPhJEVNjpgNRNiViA8wP6InCpPsWiCXdb02EsNFc
 xYjlOc2EDOIVw3e7fVuRyxfgOc0/ETcuikOFTBuY8c+QiQ7NC1tbAULDV/PviNn6jCn6
 ZvuhNQ1rNU2VhIRmXQuiiUTJEvL6QOTnN80JZit1IHMC0e7XHoovVP6PCd1eeAeNe6IW
 Ho7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3qMCZlC3NRbhJCVXGWxseDwgZ04vozlPzoYKdM87YU4DhqVTvzbszMEmnVyOgnAqyp2KXHE/FGsbT@nongnu.org
X-Gm-Message-State: AOJu0YxHfuqx8PT2pw5bk+B8cpX9uP7Ccn98ZkyVsUbf41+V9SDx5JEb
 4ntEpdW7uVpghc8UBQJh//GSUMMt7tIUfbyhSMKuv50Jc4VVd9VDddtzJ8CSafc54fwQ4Ql4OO+
 UvMxVfYv2TK2vSk6ILV7IxV7szvqzJ4uCU8HU7LPtzZCcQNMWOG27
X-Gm-Gg: ASbGncsJVchmRpHjWoYWt4fA42qC8D6VpEsChFWdOcXmlQ+CJHLKNK4iIi9SHjg9zTQ
 Y7n6Sqm1DjfSXrvNR76gj1P/uDHqHFuKUpMn37b70b02AOQPHaHPkcmRjaxWTMEa7gXGt4AbJPd
 UNIqkA3CwXXdZBewcYTlpdvzoU6OdLroZ7/t69aNt1D7CNXYvxOcfpmB2EioXc4wXut1pj28Qkb
 gnSD/EfYzkFuhYxOxTsHUkknVBYFPsoQWejwKu1KdgdHylw+K4sYVsrXYfFyzuIjINFffrb1UjE
 1sEPNEiRxJo03kg8lWSfBcNPskDf1Z1+ubBhNNb+TFAI4kKx
X-Received: by 2002:a05:6214:260f:b0:6e4:2872:45f5 with SMTP id
 6a1803df08f44-6e445679883mr10788566d6.25.1738880205181; 
 Thu, 06 Feb 2025 14:16:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHi2Ga9gtKqRpTLs9QY/CmZ5/H0mTyx7aKXKQle0RMKnrsP0MlgkSLaKMXgSt0njvEZGWFZXQ==
X-Received: by 2002:a05:6214:260f:b0:6e4:2872:45f5 with SMTP id
 6a1803df08f44-6e445679883mr10788056d6.25.1738880204685; 
 Thu, 06 Feb 2025 14:16:44 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e444b5ad24sm2551376d6.103.2025.02.06.14.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 14:16:43 -0800 (PST)
Date: Thu, 6 Feb 2025 17:16:42 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 19/33] migration: Add
 save_live_complete_precopy_thread handler
Message-ID: <Z6U0yrulbkuvO-FK@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <7561a5d67e113e166c7d43246d52feec6ca06fb5.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6JUP2w9u_FQRP6u@x1.local>
 <4ad3e311-e701-4029-bb51-e69da4f69468@maciej.szmigiero.name>
 <Z6J5vyd1_gdWlYAB@x1.local>
 <c107d827-6913-4af5-8a63-c71000060fec@maciej.szmigiero.name>
 <Z6OKDxw1hnNKCjJn@x1.local>
 <495c4c76-ffb2-4d63-adf7-97a22c03bbdd@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <495c4c76-ffb2-4d63-adf7-97a22c03bbdd@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Feb 06, 2025 at 12:41:50PM +0100, Maciej S. Szmigiero wrote:
> On 5.02.2025 16:55, Peter Xu wrote:
> > On Wed, Feb 05, 2025 at 12:53:21PM +0100, Maciej S. Szmigiero wrote:
> > > On 4.02.2025 21:34, Peter Xu wrote:
> > > > On Tue, Feb 04, 2025 at 08:32:15PM +0100, Maciej S. Szmigiero wrote:
> > > > > On 4.02.2025 18:54, Peter Xu wrote:
> > > > > > On Thu, Jan 30, 2025 at 11:08:40AM +0100, Maciej S. Szmigiero wrote:
> > > > > > > +static int multifd_device_state_save_thread(void *opaque)
> > > > > > > +{
> > > > > > > +    struct MultiFDDSSaveThreadData *data = opaque;
> > > > > > > +    int ret;
> > > > > > > +
> > > > > > > +    ret = data->hdlr(data->idstr, data->instance_id, &send_threads_abort,
> > > > > > > +                     data->handler_opaque);
> > > > > > 
> > > > > > I thought we discussed somewhere and the plan was we could use Error** here
> > > > > > to report errors.  Would that still make sense, or maybe I lost some
> > > > > > context?
> > > > > 
> > > > > That was about *load* threads, here these are *save* threads.
> > > > 
> > > > Ah OK.
> > > > 
> > > > > 
> > > > > Save handlers do not return an Error value, neither save_live_iterate, nor
> > > > > save_live_complete_precopy or save_state does so.
> > > > 
> > > > Let's try to make new APIs work with Error* if possible.
> > > 
> > > Let's assume that these threads return an Error object.
> > > 
> > > What's qemu_savevm_state_complete_precopy_iterable() supposed to do with it?
> > 
> > IIUC it's not about qemu_savevm_state_complete_precopy_iterable() in this
> > context, as the Error* will be used in one of the thread of the pool, not
> > migration thread.
> > 
> > The goal is to be able to set Error* with migrate_set_error(), so that when
> > migration failed, query-migrate can return the error to libvirt, so
> > migration always tries to remember the 1st error hit if ever possible.
> > 
> > It's multifd_device_state_save_thread() to do migrate_set_error(), not in
> > migration thread.  qemu_savevm_state_complete_*() are indeed not ready to
> > pass Errors, but it's not in the discussed stack.
> 
> I understand what are you proposing now - you haven't written about using
> migrate_set_error() for save threads earlier, just about returning an Error
> object.
> 
> While this might work it has tendency to uncover errors in other parts of
> the migration core - much as using it in the load threads case uncovered
> the TLS session error.

Yes, hitting the tls issue is unfortunate, thanks for finding the bug.  I'm
ok if we have any workaround for that that is easily revertable, then we
fix it later.  Or if Fabiano's series can land earlier.  To me it seems
easier you stick with Fabiano's series and focus on the rest of the patches.

If we hit another bug, it's more unfortunate, but imho there's not much we
can do but try to fix all of them..

> 
> (Speaking of which, could you please respond to the issue at the bottom of
> this message from 2 days ago?:
> https://lore.kernel.org/qemu-devel/150a9741-daab-4724-add0-f35257e862f9@maciej.szmigiero.name/
> It is blocking rework of the TLS session EOF handling in this patch set.
> Thanks.)
> 
> But I can try this migrate_set_error() approach here and see if something
> breaks.
> 
> (..)
> > > > > 
> > > > > > Meanwhile, I still feel uneasy on having these globals (send_threads_abort,
> > > > > > send_threads_ret).  Can we make MultiFDDSSaveThreadData the only interface
> > > > > > between migration and the threads impl?  So I wonder if it can be:
> > > > > > 
> > > > > >      ret = data->hdlr(data);
> > > > > > 
> > > > > > With extended struct like this (I added thread_error and thread_quit):
> > > > > > 
> > > > > > struct MultiFDDSSaveThreadData {
> > > > > >        SaveLiveCompletePrecopyThreadHandler hdlr;
> > > > > >        char *idstr;
> > > > > >        uint32_t instance_id;
> > > > > >        void *handler_opaque;
> > > > > >        /*
> > > > > >         * Should be NULL when struct passed over to thread, the thread should
> > > > > >         * set this if the handler would return false.  It must be kept NULL if
> > > > > >         * the handler returned true / success.
> > > > > >         */
> > > > > >        Error *thread_error;
> > > > > 
> > > > > As I mentioned above, these handlers do not generally return Error type,
> > > > > so this would need to be an *int;
> > > > > 
> > > > > >        /*
> > > > > >         * Migration core would set this when it wants to notify thread to
> > > > > >         * quit, for example, when error occured in other threads, or migration is
> > > > > >         * cancelled by the user.
> > > > > >         */
> > > > > >        bool thread_quit;
> > > > > 
> > > > >               ^ I guess that was supposed to be a pointer too (*thread_quit).
> > > > 
> > > > It's my intention to make this bool, to make everything managed per-thread.
> > > 
> > > But that's unnecessary since this flag is common to all these threads.
> > 
> > One bool would be enough, but you'll need to export another API for VFIO to
> > use otherwise.  I suppose that's ok too.
> > 
> > Some context of multifd threads and how that's done there..
> > 
> > We started with one "quit" per thread struct, but then we switched to one
> > bool exactly as you said, see commit 15f3f21d598148.
> > 
> > If you want to stick with one bool, it's okay too, you can export something
> > similar in misc.h, e.g. multifd_device_state_save_thread_quitting(), then
> > we can avoid passing in the "quit" either as handler parameter, or
> > per-thread flag.
> 
> Of course I can "export" this flag via a getter function rather than passing
> it as a parameter to SaveLiveCompletePrecopyThreadHandler.
> 
> > > 
> > > > It's actually what we do with multifd, these are a bunch of extra threads
> > > > to differeciate from the "IO threads" / "multifd threads".
> > > > 
> > > > > 
> > > > > > };
> > > > > > 
> > > > > > Then if any multifd_device_state_save_thread() failed, for example, it
> > > > > > should notify all threads to quit by setting thread_quit, instead of
> > > > > > relying on yet another global variable to show migration needs to quit.
> > > > > 
> > > > > multifd_abort_device_state_save_threads() needs to access
> > > > > send_threads_abort too.
> > > > 
> > > > This may need to become something like:
> > > > 
> > > >     QLIST_FOREACH() {
> > > >         MultiFDDSSaveThreadData *data = ...;
> > > >         data->thread_quit = true;
> > > >     }
> > > 
> > > At the most basic level that's turning O(1) operation into O(n).
> > > 
> > > Besides, it creates a question now who now owns these MultiFDDSSaveThreadData
> > > structures - they could be owned by either thread pool or the
> > > multifd_device_state code.
> > 
> > I think it should be owned by migration, and with this idea it will need to
> > be there until waiting thread pool completing their works, so migration
> > core needs to free them.
> > 
> > > 
> > > Currently the ownership is simple - the multifd_device_state code
> > > allocates such per-thread structure in multifd_spawn_device_state_save_thread()
> > > and immediately passes its ownership to the thread pool which
> > > takes care to free it once it no longer needs it.
> > 
> > Right, this is another reason why I think having migration owing these
> > structs is better.  We used to have task dangling issues when we shift
> > ownership of something to mainloop then we lose track of them (e.g. on TLS
> > handshake gsources).  Those are pretty hard to debug when hanged, because
> > migration core has nothing to link to the hanged tasks again anymore.
> > 
> > I think we should start from having migration core being able to reach
> > these thread-based tasks when needed.  Migration also have control of the
> > thread pool, then it would be easier.  Thread pool is so far simple so we
> > may still need to be able to reference to per-task info separately.
> 
> These are separate threads, so they are are pretty easy to identify
> in a debugger or a core dump.
> 
> Also, one can access them via the thread pool pointer if absolutely
> necessary.
> 
> If QMP introspection ever becomes necessary then it could be simply
> built into the generic thread pool itself.
> Then all thread pool consumers will benefit from it.

Having full control of tasks assigned makes sure it'll be manageable even
if num_tasks > num_threads.  And it's manageable when another thread wants
to do anything with a task.  I know it's always tasks==threads for now but
I think we shouldn't assume it like that when designing the api.

If we'll have one bool showing "we need to quit all tasks", then indeed I
don't see a major concern with not maintaining per-task infos.  In
qmp_cancel logically we should set that bool.

To me, I want to avoid any form of unnecessary struggles when e.g. main
thread wants to access the tasks, then UAFs racing with thread pool freeing
a task info struct or things like that.  For now, I'm OK not having it.
The bool should work.  We can leave that for later.

> 
> > > 
> > > Now, with the list implementation if the thread pool were to free
> > > that MultiFDDSSaveThreadData it would also need to release it from
> > > the list.
> > > 
> > > Which in turn would need appropriate locking around this removal
> > > operation and probably also each time the list is iterated over.
> > > 
> > > On the other hand if the multifd_device_state code were to own
> > > that MultiFDDSSaveThreadData then it would linger around until
> > > multifd_device_state_send_cleanup() cleans it up even though its
> > > associated thread might be long gone.
> > 
> > Do you see a problem with it?  It sounds good to me actually.. and pretty
> > easy to understand.
> > 
> > So migration creates these MultiFDDSSaveThreadData, then create threads to
> > enqueue then, then wait for all threads to complete, then free these
> > structs.
> 
> One of the benefits of using a thread pool is that it can abstract
> memory management away by taking ownership of the data pointed to by
> the passed thread opaque pointer (via the passed GDestroyNotify).
> 
> I don't see a benefit of re-implementing this also in the migration
> code (returning an Error object does *not* require such approach).
> 
> > > 
> > > > We may want to double check qmp 'migrate_cancel' will work when save
> > > > threads are running, but this can also be done for later.
> > > 
> > > > > 
> > > > > And multifd_join_device_state_save_threads() needs to access
> > > > > send_threads_ret.
> > > > 
> > > > Then this one becomes:
> > > > 
> > > >     thread_pool_wait(send_threads);
> > > >     QLIST_FOREACH() {
> > > >         MultiFDDSSaveThreadData *data = ...;
> > > >         if (data->thread_error) {
> > > >            return false;
> > > >         }
> > > >     }
> > > >     return true;
> > > 
> > > Same here, having a common error return would save us from having
> > > to iterate over a list (or having a list in the first place).
> > 
> > IMHO perf isn't an issue here. It's slow path, threads num is small, loop
> > is cheap.  I prefer prioritize cleaness in this case.
> > 
> > Otherwise any suggestion we could report an Error* in the threads?
> 
> Using Error doesn't need a list, load threads return an Error object
> just fine without it:
> >     if (!data->function(data->opaque, &mis->load_threads_abort, &local_err)) {
> >         MigrationState *s = migrate_get_current();
> > 
> >         assert(local_err);
> > 
> >         /*
> >          * In case of multiple load threads failing which thread error
> >          * return we end setting is purely arbitrary.
> >          */
> >         migrate_set_error(s, local_err);
> >     }
> > 
> 
> Same can be done for save threads here (with the caveat of migrate_set_error()
> uncovering possible other errors that I mentioned earlier).
> 
> > > 
> > > > > 
> > > > > These variables ultimately will have to be stored somewhere since
> > > > > there can be multiple save threads and so multiple instances of
> > > > > MultiFDDSSaveThreadData.
> > > > > 
> > > > > So these need to be stored somewhere where
> > > > > multifd_spawn_device_state_save_thread() can reach them to assign
> > > > > their addresses to MultiFDDSSaveThreadData members.
> > > > 
> > > > Then multifd_spawn_device_state_save_thread() will need to manage the
> > > > qlist, making sure migration core remembers what jobs it submitted.  It
> > > > sounds good to have that bookkeeping when I think about it, instead of
> > > > throw the job to the thread pool and forget it..
> > > 
> > > It's not "forgetting" about the job but rather letting thread pool
> > > manage it - I think thread pool was introduced so these details
> > > (thread management) are abstracted from the migration code.
> > > Now they would be effectively duplicated in the migration code.
> > 
> > Migration is still managing those as long as you have send_threads_abort,
> > isn't it?  The thread pool doesn't yet have an API to say "let's quit all
> > the tasks", otherwise I'm OK too to use the pool API instead of having
> > thread_quit.
> 
> The migration code does not manage each thread separately.
> 
> It manages them as a pool, and does each operation (wait, abort)
> on the pool itself (either literally via ThreadPool or by setting
> a variable that's shared by all threads).
> 
> > > 
> > > > > 
> > > > > However, at that point multifd_device_state_save_thread() can
> > > > > access them too so it does not need to have them passed via
> > > > > MultiFDDSSaveThreadData.
> > > > > 
> > > > > However, nothing prevents putting send_threads* variables
> > > > > into a global struct (with internal linkage - "static", just as
> > > > > these separate ones are) if you like such construct more.
> > > > 
> > > > This should be better than the current global vars indeed, but less
> > > > favoured if the per-thread way could work above.
> > > 
> > > You still need that list to be a global variable,
> > > so it's the same amount of global variables as just putting
> > > the existing variables in a struct (which could be even allocated
> > > in multifd_device_state_send_setup() and deallocated in
> > > multifd_device_state_send_cleanup() for extra memory savings).
> > 
> > Yes this works for me.
> > 
> > I think you got me wrong on "not allowing to introduce global variables".
> > I'm OK with it, but please still consider..
> > 
> >    - Put it under some existing global object rather than having separate
> >      global variables all over the places..
> > 
> >    - Having Error reports
> 
> Ok.
> 
> > And I still think we can change:
> > 
> > typedef int (*SaveLiveCompletePrecopyThreadHandler)(char *idstr,
> >                                                      uint32_t instance_id,
> >                                                      bool *abort_flag,
> >                                                      void *opaque);
> > 
> > To:
> > 
> > typedef int (*SaveLiveCompletePrecopyThreadHandler)(MultiFDDSSaveThreadData*);
> > 
> > No matter what.
> 
> We can do that, although this requires "exporting" the MultiFDDSSaveThreadData
> type.

I'm OK with that.

I think it's fair to export it because that's the interface for
outside-migration.

> 
> > > 
> > > These variables are having internal linkage limited to (relatively
> > > small) multifd-device-state.c, so it's not like they are polluting
> > > namespace in some major migration translation unit.
> > 
> > If someone proposes to introduce 100 global vars in multifd-device-state.c,
> > I'll strongly stop that.
> > 
> > If it's one global var, I'm OK.
> > 
> > What if it's 5?
> > 
> > ===8<===
> > static QemuMutex queue_job_mutex;
> > 
> > static ThreadPool *send_threads;
> > static int send_threads_ret;
> > static bool send_threads_abort;
> > 
> > static MultiFDSendData *device_state_send;
> > ===8<===
> > 
> > I think I should start calling a stop.  That's what happened..
> > 
> > Please consider introducing something like multifd_send_device_state so we
> > can avoid anyone in the future randomly add static global vars.
> 
> As I wrote before, I will pack it all into one global variable,
> could be called multifd_send_device_state as you suggest.
> 
> > > 
> > > Taking into consideration having to manage an extra data structure
> > > (list), needing more code to do so, having worse algorithms I don't
> > > really see a point of using that list.
> > > 
> > > (This is orthogonal to whether the thread return type is changed to
> > > Error which could be easily done on the existing save threads pool
> > > implementation).
> > 
> > My bet is changing to list is as easy (10-20 LOC?).  If not, I can try to
> > provide the diff on top of your patch.
> > 
> > I'm also not strictly asking for a list, but anything that makes the API
> > cleaner (less globals, better error reports, etc.).
> 
> I just think introducing that list is a step back due to reasons I described
> above.
> 
> And its not actually necessary for returning an Error code.

I'm ok with having no list, as long as the rest are addressed.

Thanks,

-- 
Peter Xu


