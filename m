Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A584E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYuH-0004lt-VU; Tue, 17 Dec 2024 09:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNYuG-0004lf-N3
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:50:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNYuE-000839-RI
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734447036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=emjWDfLNAhNUnYKuPHhSrGM4N+rqXId8ScPz0XxtJJo=;
 b=MHAHrOleuh6M22htMjaZxBAQthrmFCw6bgSmXbAP6PRHoFblpe6Q9QuAacqwyBiCdrMsPF
 kUzM/l0c7GpmQPSefpYgFthQiH8yobSfLOMJBNZmMFaCWpDqJaF7yEpsuNcz4f4iUBMzr7
 hGzpb6/krqe9QsYfH7Wea/PZVgYgG3o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-l2Jbl4NcMYqzdEPtVkuf0g-1; Tue, 17 Dec 2024 09:50:34 -0500
X-MC-Unique: l2Jbl4NcMYqzdEPtVkuf0g-1
X-Mimecast-MFC-AGG-ID: l2Jbl4NcMYqzdEPtVkuf0g
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-468f80df8caso22569091cf.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 06:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734447033; x=1735051833;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=emjWDfLNAhNUnYKuPHhSrGM4N+rqXId8ScPz0XxtJJo=;
 b=XB9UH3lu0dXwLQb8w5hCW3XEnOVp+qGCioAuxVn0pmc/h2BX1w+rJJ69pxj6A5LXJ4
 iVr6XcQ8qkWeA0aFyWgL0nHyokRqstjT6q4xEmR/cF5VaHDpXIf6E4B2mzEYlyzElqZH
 GeMmv7pCt4FeC3jKUOkTm+Pf9oc2FpEiDwh2kY/Rr7Or7uI5DtevJJEZkyFQbqGn/ci1
 3HP+djVzdhb21y1xzyVbwQEnT/kDUJvXUxJSMrWvBxuGb9Ra0S6ewH1EKv6pUj2nm+1C
 INDigScJmKwiiXKz25PnpmNqSJLl9DXlkfFkMoe8/paV+9FptQdA6366m0OWB3JE+XzD
 RbFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtgsDhvJu/Eu/dLZTO/mIvcmnO+rpWLnRaHRKmQ1OJlLuozkGN+2qZ3NFbdag900HjrtHpa2WLuAUJ@nongnu.org
X-Gm-Message-State: AOJu0YyAHWK9kxn7H1byTTb3SWdL2O0qPdJw8OBQldX86kAoqFVKVDMC
 m2r0wa0QHDdOWmVZbgNn8PL4nL5Xo9taYPeN4n8d9ZpW5/ludCb75F/RVxoawxQRbuj0PJ7IQw0
 Jo5aY1NgKQLB33F32cEdfYJMCa5gpCOOenjzVUcDNJtYz72E92xZA
X-Gm-Gg: ASbGnct/FAvPlYsXm4ZqjeiALIpNRQD5hH/Nw4lGaQ5gRK0Filj+WZKnt0QfiQdQ5JF
 0ApD/Z+sHx20+jCaK6MaL3LUkwRPXh5hBsvKiEnV0GXjyAV3a0OCT2ui3w9ClLdOmyvPjI16X2S
 EBxfEzC2a+T09ezxQg3eafeyLtLOqyzFv3a9sMQqveMYcuegjLYe/C1XybdemBQXx+vnSbuvg8N
 rd2QNRcfjPlAf5uyFKkrV8FE3W68K23Hrua8TK5qMfnvFoVX37Chiu/dp5z1enoMA8naitOBh07
 vjgSZhkl64+YrF5UvA==
X-Received: by 2002:a05:622a:249:b0:467:7ff3:e4bf with SMTP id
 d75a77b69052e-468f8b66984mr61520471cf.51.1734447033292; 
 Tue, 17 Dec 2024 06:50:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuya+0lxbcMnQajxqDE+tDW/j6F+YMSZb909laZrEqGyaM9qUmrYEr4Bzj0cvPRZo0beQHvw==
X-Received: by 2002:a05:622a:249:b0:467:7ff3:e4bf with SMTP id
 d75a77b69052e-468f8b66984mr61519841cf.51.1734447032771; 
 Tue, 17 Dec 2024 06:50:32 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2e81a4fsm39672281cf.60.2024.12.17.06.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 06:50:31 -0800 (PST)
Date: Tue, 17 Dec 2024 09:50:29 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 08/24] migration: Add thread pool of optional load
 threads
Message-ID: <Z2GPtTsJPZQ4RVtJ@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
 <9a229308-2c80-4ee2-8c49-5fec2207ad74@redhat.com>
 <489d1769-3807-4007-888c-608c1e9407fb@maciej.szmigiero.name>
 <Z1DcVH6j7pzboucr@x1n>
 <366e5477-9d3f-4c11-8042-542e9b4b7f65@maciej.szmigiero.name>
 <Z1sReL5wrlhvO3P5@x1n>
 <d45267a6-74a6-4eeb-b8fa-f427db03afde@maciej.szmigiero.name>
 <Z2BVYvO1359M1i9Q@x1n>
 <db0cce73-e04d-4baf-8e45-06c65d3c529d@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db0cce73-e04d-4baf-8e45-06c65d3c529d@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Tue, Dec 17, 2024 at 12:15:36AM +0100, Maciej S. Szmigiero wrote:
> On 16.12.2024 17:29, Peter Xu wrote:
> > On Thu, Dec 12, 2024 at 11:53:24PM +0100, Maciej S. Szmigiero wrote:
> > > On 12.12.2024 17:38, Peter Xu wrote:
> > > > On Wed, Dec 11, 2024 at 12:05:23AM +0100, Maciej S. Szmigiero wrote:
> > > > > > Maybe move it over to migration_object_init()?  Then we keep
> > > > > > qemu_loadvm_state_setup() only invoke the load_setup()s.
> > > > > 
> > > > > AFAIK migration_object_init() is called unconditionally
> > > > > at QEMU startup even if there won't me any migration done?
> > > > > 
> > > > > Creating a load thread pool there seems wasteful if no
> > > > > incoming migration will ever take place (or will but only
> > > > > much later).
> > > > 
> > > > I was expecting an empty pool to not be a major resource, but if that's a
> > > > concern, yes we can do that until later.
> > > > 
> > > > [...]
> > > > 
> > > > > > > > > @@ -3007,6 +3071,19 @@ int qemu_loadvm_state(QEMUFile *f)
> > > > > > > > >              return ret;
> > > > > > > > >          }
> > > > > > > > > +    if (ret == 0) {
> > > > > > > > > +        bql_unlock(); /* Let load threads do work requiring BQL */
> > > > > > > > > +        thread_pool_wait(load_threads);
> > > > > > > > > +        bql_lock();
> > > > > > > > > +
> > > > > > > > > +        ret = load_threads_ret;
> > > > > > > > > +    }
> > > > > > > > > +    /*
> > > > > > > > > +     * Set this flag unconditionally so we'll catch further attempts to
> > > > > > > > > +     * start additional threads via an appropriate assert()
> > > > > > > > > +     */
> > > > > > > > > +    qatomic_set(&load_threads_abort, true);
> > > > > > 
> > > > > > I assume this is only for debugging purpose and not required.
> > > > > > 
> > > > > > Setting "abort all threads" to make sure "nobody will add more thread
> > > > > > tasks" is pretty awkward, IMHO.  If we really want to protect against it
> > > > > > and fail hard, it might be easier after the thread_pool_wait() we free the
> > > > > > pool directly (destroy() will see NULL so it'll skip; still need to free
> > > > > > there in case migration failed before this).  Then any enqueue will access
> > > > > > null pointer on the pool.
> > > > > 
> > > > > We don't want to destroy the thread pool in the path where the downtime
> > > > > is still counting.
> > > > 
> > > > Yeah this makes sense.
> > > > 
> > > > > 
> > > > > That's why we only do cleanup after the migration is complete.
> > > > > 
> > > > > The above setting of load_threads_abort flag also makes sure that we abort
> > > > > load threads if the migration is going to fail for other reasons (non-load
> > > > > threads related) - in other words, when the above block with thread_pool_wait()
> > > > > isn't even entered due to ret already containing an earlier error.
> > > > 
> > > > In that case IIUC we should cleanup the load threads in destroy(), not
> > > > here?  Especially with the comment that's even more confusing.
> > > > 
> > > 
> > > This flag only asks the threads in pool which are still running to exit ASAP
> > > (without waiting for them in the "fail for other reasons"
> > > qemu_loadvm_state() code flow).
> > 
> > I thought we could switch to an Error** model as we talked elsewhere, then
> > the thread who hits the error should set the quit flag, IIUC.
> > 
> > Even without it..
> > 
> > > 
> > > Setting this flag does *not* do the cleanup of the whole thread pool - this
> > > only happens in qemu_loadvm_state_cleanup().
> > 
> > ... we have two cases here:
> > 
> > Either no error at all, then thread_pool_wait() will wait for all threads
> > until finished.  When reaching here setting this flag shouldn't matter for
> > the threads because they're all finished.
> > 
> > Or there's error in some thread, then QEMU should be stuck at
> > thread_pool_wait() anyway, until all threads quit.  Again, I thought it
> > could be the qemu_loadvm_load_thread() that sets the quit flag (rather than
> > here) so the failed thread will notify all threads to quit.
> > 
> > I just still don't see what's the help of setting it after
> > thread_pool_wait(), which already marked all threads finished at its
> > return.  That goes back to my question on whether it was only for debugging
> > (so no new threads to be created after this), rather than the flag to tell
> > all threads to quit.
> 
> There's also a possibility of earlier error in qemu_loadvm_state()
> (not in the load threads themselves), for example if qemu_loadvm_state_main()
> returns an error.
> 
> In this case thread_pool_wait() *won't* be called but the load threads
> would still be running needlessly - setting load_threads_abort flag makes
> them stop.
> 
> The debugging benefit of assert()ing when someone tries to create
> a load thread after that point comes essentially for free then.

In that case, IMHO we should put all cleanup stuff into the cleanup
function, like migration_incoming_state_destroy().  I'd hope not having
that only for such debug purpose, OTOH.

This step can be easily overlook when this function adds more things.
Personally, I'm totally not a fan of using "if (ret==0) {do something}" and
keep writting like that.. but that's not the issue of this patch alone, so
we can do that for later.  Even so, having it here is still error prone
(e.g. consider one "goto" in the future before this step, logically it
should skip all next steps if a prior one fails).

Thanks,

-- 
Peter Xu


