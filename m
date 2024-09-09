Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83529ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhWf-0003Nq-Pj; Mon, 09 Sep 2024 12:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snhWd-0003Go-UK
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snhWa-0001ot-A2
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725900357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CHaoMf2F8hbpm0qZK255Q57r1VUNQsaLBGFFCbM6kI0=;
 b=DaZRVW+LxehmFUSYHepXk/STG37Tv8wIqn1MAKZowwHxACKCZfnLxww5lmy06WR3Ns2Y/g
 rby8TQkf82LwFZ7U37XASBFneIaFLr/ELrbzSYltgwhzUVq/zGvpd4UY1xLe8iuHlPUB/Y
 j5EJ0bvXWxJzEIHYuDBZG9QnNeIx42s=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-UV7OrH7qOJGxUJLMGHcotA-1; Mon, 09 Sep 2024 12:45:55 -0400
X-MC-Unique: UV7OrH7qOJGxUJLMGHcotA-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5e1d7e1a846so1269682eaf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725900354; x=1726505154;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHaoMf2F8hbpm0qZK255Q57r1VUNQsaLBGFFCbM6kI0=;
 b=qR2iAjKdy56mVpjwRvz/3ac5HjIBFwm3yAN+i7odtLsjaJVCXUWfGtEXXwEHU0JN7C
 P0FeyoJYbgxm1pyZldLTVh08eMz6/YHa5XnCWTJAHDNmOIlhib0cmgaaSxFF+0bYVmJr
 Rm1kTCrOobH0cHNBY6GuONK5zbqsZEc4Kkrpdb5+mAf5iIDBtm7z5ISUI6C97h/zjLo6
 M49XClJSHckHe8qAoVYVtr1MBaWPYT6/i0UArrx0tyMMTlVP8BQpWdNBa3r6BH9eI50p
 jDDrleyuUHllgC2uHxkB2V3mzhxYBV4W7r5j/TGk8UEiRbqyYKbkXmPl2mIAT7DQEt6P
 VkTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOuqsioHfHRFFc2DAVpRJ7O9I/3MpkmqyIk5hK5pqWq+1PFq1ZjbXkxgknNfA70WN3MSrFRurOzTuL@nongnu.org
X-Gm-Message-State: AOJu0YyVZ8wJ0x3DydKgKX7EcLO2toCOxpdl9BYVkYNyOaax5eAnib1X
 WGjGadAs5uVucElNkl1ozbO9LyBGg4R0h58lP4kZ8tsjTNaEnsrQ6z7/TShULfboaq7vQJywFFx
 P0Ir8pmqXNLHxSzLO2ral+K8SxspwM/VXBNELptSWjDl+p+h1O47O
X-Received: by 2002:a05:6358:248f:b0:1b5:f973:1e9d with SMTP id
 e5c5f4694b2df-1b84beae8d4mr1197900455d.19.1725900353946; 
 Mon, 09 Sep 2024 09:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJn5E977anOPGeYVWB1q9GS1FzqzNskMiHAoD11kQeQzBxdSeJsUOzhDD8/pvRebHFYtwS1g==
X-Received: by 2002:a05:6358:248f:b0:1b5:f973:1e9d with SMTP id
 e5c5f4694b2df-1b84beae8d4mr1197895955d.19.1725900353503; 
 Mon, 09 Sep 2024 09:45:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7945585sm232676585a.15.2024.09.09.09.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:45:52 -0700 (PDT)
Date: Mon, 9 Sep 2024 12:45:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 05/17] thread-pool: Implement non-AIO (generic) pool
 support
Message-ID: <Zt8mPlBLO9FUHgxG@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <54947c3a1df713f5b69d8296938f3da41116ffe0.1724701542.git.maciej.szmigiero@oracle.com>
 <CAJSP0QU+dhh_e2LJRoGCxtCEh6C2-GBoZoFZL2W-SMSQPzUtYg@mail.gmail.com>
 <d6e7dbd4-634f-4f62-8516-7bbf404b7adf@maciej.szmigiero.name>
 <CAJSP0QXURSS4cHj0i6xy27HMbtF2D4ckL4fwDk5rHA3vFFtHUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QXURSS4cHj0i6xy27HMbtF2D4ckL4fwDk5rHA3vFFtHUg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi, Stefan, Maciej,

Sorry to be slow on responding.

On Tue, Sep 03, 2024 at 03:04:54PM -0400, Stefan Hajnoczi wrote:
> On Tue, 3 Sept 2024 at 12:54, Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
> >
> > On 3.09.2024 15:55, Stefan Hajnoczi wrote:
> > > On Tue, 27 Aug 2024 at 13:58, Maciej S. Szmigiero
> > > <mail@maciej.szmigiero.name> wrote:
> > >>
> > >> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > >>
> > >> Migration code wants to manage device data sending threads in one place.
> > >>
> > >> QEMU has an existing thread pool implementation, however it was limited
> > >> to queuing AIO operations only and essentially had a 1:1 mapping between
> > >> the current AioContext and the ThreadPool in use.
> > >>
> > >> Implement what is necessary to queue generic (non-AIO) work on a ThreadPool
> > >> too.
> > >>
> > >> This brings a few new operations on a pool:
> > >> * thread_pool_set_minmax_threads() explicitly sets the minimum and maximum
> > >> thread count in the pool.
> > >>
> > >> * thread_pool_join() operation waits until all the submitted work requests
> > >> have finished.
> > >>
> > >> * thread_pool_poll() lets the new thread and / or thread completion bottom
> > >> halves run (if they are indeed scheduled to be run).
> > >> It is useful for thread pool users that need to launch or terminate new
> > >> threads without returning to the QEMU main loop.
> > >
> > > Did you consider glib's GThreadPool?
> > > https://docs.gtk.org/glib/struct.ThreadPool.html
> > >
> > > QEMU's thread pool is integrated into the QEMU event loop. If your
> > > goal is to bypass the QEMU event loop, then you may as well use the
> > > glib API instead.
> > >
> > > thread_pool_join() and thread_pool_poll() will lead to code that
> > > blocks the event loop. QEMU's aio_poll() and nested event loops in
> > > general are a source of hangs and re-entrancy bugs. I would prefer not
> > > introducing these issues in the QEMU ThreadPool API.
> > >
> >
> > Unfortunately, the problem with the migration code is that it is
> > synchronous - it does not return to the main event loop until the
> > migration is done.
> >
> > So the only way to handle things that need working event loop is to
> > pump it manually from inside the migration code.
> >
> > The reason why I used the QEMU thread pool in the first place in this
> > patch set version is because Peter asked me to do so during the review
> > of its previous iteration [1].
> >
> > Peter also asked me previously to move to QEMU synchronization
> > primitives from using the Glib ones in the early version of this
> > patch set [2].
> >
> > I personally would rather use something common to many applications,
> > well tested and with more pairs of eyes looking at it rather to
> > re-invent things in QEMU.
> >
> > Looking at GThreadPool it seems that it lacks ability to wait until
> > all queued work have finished, so this would need to be open-coded
> > in the migration code.
> >
> > @Peter, what's your opinion on using Glib's thread pool instead of
> > QEMU's one, considering the above things?
> 
> I'll add a bit more about my thinking:
> 
> Using QEMU's event-driven model is usually preferred because it makes
> integrating with the rest of QEMU easy and avoids having lots of
> single-purpose threads that are hard to observe/manage (e.g. through
> the QMP monitor).
> 
> When there is a genuine need to spawn a thread and write synchronous
> code (e.g. a blocking ioctl(2) call or something CPU-intensive), then

Right, AFAIU this is the current use case for VFIO, and anything beyond in
migration context, where we want to use genuine threads with no need to
integrate with the main even loop.

Currently the VFIO workfn should read() the VFIO fd in a blocked way, then
dump them to multifd threads (further dump to migration channels), during
which it can wait on a semaphore.

> it's okay to do that. Use QEMUBH, EventNotifier, or other QEMU APIs to
> synchronize between event loop threads and special-purpose synchronous
> threads.
> 
> I haven't looked at the patch series enough to have an opinion about
> whether this use case needs a special-purpose thread or not. I am
> assuming it really needs to be a special-purpose thread. Peter and you
> could discuss that further if you want.
> 
> I agree with Peter's request to use QEMU's synchronization primitives.
> They do not depend on the event loop so they can be used outside the
> event loop.
> 
> The issue I'm raising with this patch is that adding new join()/poll()
> APIs that shouldn't be called from the event loop is bug-prone. It
> will make the QEMU ThreadPool code harder to understand and maintain
> because now there are two different contexts where different subsets
> of this API can be used and mixing them leads to problems. To me the
> non-event loop case is beyond the scope of QEMU's ThreadPool. I have
> CCed Paolo, who wrote the thread pool in its current form in case he
> wants to participate in the discussion.
> 
> Using glib's ThreadPool solves the issue while still reusing an
> existing thread pool implementation. Waiting for all work to complete
> can be done using QemuSemaphore.

Right.  It's a pity that g_thread_pool_unprocessed() only monitors
unqueuing of tasks, and looks like there's no g_thread_pool_flush().

Indeed the current thread poll is very aio-centric, and if we worry about
misuse of the APIs we can switch to glib's threadpool.  Sorry Maciej, looks
like I routed you to a direction that I didn't see the side effects..

I think the fundamental request from my side (on behalf of migration) is we
should avoid a specific vmstate handler managing threads on its own.  E.g.,
any future devices (vdpa, vcpu, etc.) that may also be able to offload
save() processes concurrently to threads (just like what VFIO can already
do right now) should share the same pool of threads.  As long as that can
be achieved I am ok.

Thanks,

-- 
Peter Xu


