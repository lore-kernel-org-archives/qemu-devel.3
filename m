Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48D0CF3970
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 21:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srORO-0008EK-Lf; Thu, 19 Sep 2024 17:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srORM-0008Do-Un
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 17:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srORK-0000CN-N7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 17:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726780308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lF38y5BjJ2J2/qW+mdNleFzYhGqmRK5WPAWeu9e+6fA=;
 b=K2DfgBriAwvF3oUfyMWEf5QGuvypp4IGr/kXU6++qf4DVSVJiP1r0lWFmjwr1aW/ImhMvx
 3ohjWWoHdulhVZWVAzn9nO+OT2VfHaPHOgXOdq6frIdZ1PxUmSvrAmChq5NWKNAimUqyfm
 Oe+W2BOmTLuJI+QyzMNFZCggW3z56QE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-nEobC0pVNO-gtCp1xJsW9Q-1; Thu, 19 Sep 2024 17:11:47 -0400
X-MC-Unique: nEobC0pVNO-gtCp1xJsW9Q-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6ddb9b15af3so28640587b3.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 14:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726780306; x=1727385106;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lF38y5BjJ2J2/qW+mdNleFzYhGqmRK5WPAWeu9e+6fA=;
 b=EQ5dwKnG1K5SyD85DRLdVfVUJ08j7DM/1il+4PRGEe00+dd7WBaiS2yFzGA6PoTVYO
 KmRLMJiVi0o/77nDpWGurBJow1GT5h4EqplCY8iOVm1qbwTIx/yjQkWWxgsOSrV56ISp
 +t0U1Wlo1yUbZ/jYbEUF7KT4q6sjOuMm0gzJ9Cc8/H4MHPrFQbhJZaNP7zsyQ9XFH0nf
 IqWFJscQT2zlc+tjCg7veKowhTffC7EJvQvsgWTngYYNHQ0G23pBzFqKVOTvCPrUIgSP
 58XkLro1TNf8xcwGSa1+JZs2TyeYCuz/yD9q5Lkf2yh3b3g4l8hky/kesWzyfAyYbQKv
 glFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwoJJTPuaNFf4duAZQcgtWZrk4b4IBOn6AomTOx4XmjDo8bQ5g0enBdqT8olmy8EHh0BruEWHftHoc@nongnu.org
X-Gm-Message-State: AOJu0YxknCV0PmYdawEDWogcmPko/wX7pv6GXQFzjHn39JOgb263dv6Z
 M1s77Hg5LKbNVTrhYriK5gf5JkcGZb/mvozixhigr5X3ZQonBeY1jQlAcm/+YljzHPFWQ1wKsxc
 S4DSj9HppzkCFHgMbmVhwfrMGLsfjZRCyob2c7Y/K5wHGCp32irXd
X-Received: by 2002:a05:690c:385:b0:6dd:d1b5:c645 with SMTP id
 00721157ae682-6dfeeec59b0mr12162797b3.31.1726780306591; 
 Thu, 19 Sep 2024 14:11:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe6Jt22MXDY+FdTcMMsqCLjNfe6dAK/Pfj0Mm0P+RxDsUhKLq0MES74rw+mKY7e1rSDH62uw==
X-Received: by 2002:a05:690c:385:b0:6dd:d1b5:c645 with SMTP id
 00721157ae682-6dfeeec59b0mr12162547b3.31.1726780306223; 
 Thu, 19 Sep 2024 14:11:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b178f2de1sm10704671cf.62.2024.09.19.14.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 14:11:44 -0700 (PDT)
Date: Thu, 19 Sep 2024 17:11:41 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/17] migration: Add load_finish handler and
 associated functions
Message-ID: <ZuyTjQJujZo6tw9p@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <1a7599896decdbae61cee385739dc0badc9b4364.1724701542.git.maciej.szmigiero@oracle.com>
 <Zt9UjvvbeUZQlGNY@x1n>
 <d245c8b6-b765-42e1-a5ec-bdb46494cec4@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d245c8b6-b765-42e1-a5ec-bdb46494cec4@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 19, 2024 at 09:49:10PM +0200, Maciej S. Szmigiero wrote:
> On 9.09.2024 22:03, Peter Xu wrote:
> > On Tue, Aug 27, 2024 at 07:54:27PM +0200, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > load_finish SaveVMHandler allows migration code to poll whether
> > > a device-specific asynchronous device state loading operation had finished.
> > > 
> > > In order to avoid calling this handler needlessly the device is supposed
> > > to notify the migration code of its possible readiness via a call to
> > > qemu_loadvm_load_finish_ready_broadcast() while holding
> > > qemu_loadvm_load_finish_ready_lock.
> > > 
> > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > ---
> > >   include/migration/register.h | 21 +++++++++++++++
> > >   migration/migration.c        |  6 +++++
> > >   migration/migration.h        |  3 +++
> > >   migration/savevm.c           | 52 ++++++++++++++++++++++++++++++++++++
> > >   migration/savevm.h           |  4 +++
> > >   5 files changed, 86 insertions(+)
> > > 
> > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > index 4a578f140713..44d8cf5192ae 100644
> > > --- a/include/migration/register.h
> > > +++ b/include/migration/register.h
> > > @@ -278,6 +278,27 @@ typedef struct SaveVMHandlers {
> > >       int (*load_state_buffer)(void *opaque, char *data, size_t data_size,
> > >                                Error **errp);
> > > +    /**
> > > +     * @load_finish
> > > +     *
> > > +     * Poll whether all asynchronous device state loading had finished.
> > > +     * Not called on the load failure path.
> > > +     *
> > > +     * Called while holding the qemu_loadvm_load_finish_ready_lock.
> > > +     *
> > > +     * If this method signals "not ready" then it might not be called
> > > +     * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
> > > +     * while holding qemu_loadvm_load_finish_ready_lock.
> > 
> > [1]
> > 
> > > +     *
> > > +     * @opaque: data pointer passed to register_savevm_live()
> > > +     * @is_finished: whether the loading had finished (output parameter)
> > > +     * @errp: pointer to Error*, to store an error if it happens.
> > > +     *
> > > +     * Returns zero to indicate success and negative for error
> > > +     * It's not an error that the loading still hasn't finished.
> > > +     */
> > > +    int (*load_finish)(void *opaque, bool *is_finished, Error **errp);
> > 
> > The load_finish() semantics is a bit weird, especially above [1] on "only
> > allowed to be called once if ..." and also on the locks.
> 
> The point of this remark is that a driver needs to call
> qemu_loadvm_load_finish_ready_broadcast() if it wants for the migration
> core to call its load_finish handler again.
> 
> > It looks to me vfio_load_finish() also does the final load of the device.
> > 
> > I wonder whether that final load can be done in the threads,
> 
> Here, the problem is that current VFIO VMState has to be loaded from the main
> migration thread as it internally calls QEMU core address space modification
> methods which explode if called from another thread(s).

Ahh, I see.  I'm trying to make dest qemu loadvm in a thread too and yield
BQL if possible, when that's ready then in your case here IIUC you can
simply take BQL in whichever thread that loads it.. but yeah it's not ready
at least..

Would it be possible vfio_save_complete_precopy_async_thread_config_state()
be done in VFIO's save_live_complete_precopy() through the main channel
somehow?  IOW, does it rely on iterative data to be fetched first from
kernel, or completely separate states?  And just curious: how large is it
normally (and I suppose this decides whether it's applicable to be sent via
the main channel at all..)?

> 
> > then after
> > everything loaded the device post a semaphore telling the main thread to
> > continue.  See e.g.:
> > 
> >      if (migrate_switchover_ack()) {
> >          qemu_loadvm_state_switchover_ack_needed(mis);
> >      }
> > 
> > IIUC, VFIO can register load_complete_ack similarly so it only sem_post()
> > when all things are loaded?  We can then get rid of this slightly awkward
> > interface.  I had a feeling that things can be simplified (e.g., if the
> > thread will take care of loading the final vmstate then the mutex is also
> > not needed? etc.).
> 
> With just a single call to switchover_ack_needed per VFIO device it would
> need to do a blocking wait for the device buffers and config state load
> to finish, therefore blocking other VFIO devices from potentially loading
> their config state if they are ready to begin this operation earlier.

I am not sure I get you here, loading VFIO device states (I mean, the
non-iterable part) will need to be done sequentially IIUC due to what you
said and should rely on BQL, so I don't know how that could happen
concurrently for now.  But I think indeed BQL is a problem.

So IMHO this recv side interface so far is the major pain that I really
want to avoid (comparing to the rest) in the series.  Let's see whether we
can come up with something better..

One other (probably not pretty..) idea is when waiting here in the main
thread it yields BQL, then other threads can take it and load the VFIO
final chunk of data.  But I could miss something else.

-- 
Peter Xu


