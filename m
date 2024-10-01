Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E01CF3185
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 21:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svkSm-0005mI-9G; Tue, 01 Oct 2024 17:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svkSj-0005hy-Hy
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 17:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svkSf-0006R3-Jx
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 17:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727818269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N1IV1IoUfmF6TW7jHd2mD++pYAINTp/UYRDfSvr6/R8=;
 b=f2jLxhEmdUrbijMDSEQpBYoI8KRB4JKVtwaTx3dcKxh+qJnyU6dZ6Ny+GFnazMgIFFLi6H
 CgwH44PLuo/XYrcCEJGsB0kiL6AvVPQhPvGzp4cTOpDabmULclEJ0bRsXRmPJrL3lIax42
 fTO61tVbY2KqOKJHDKc3ucO4Vq8nIvY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-rpONUxIXPKyM07vAG9tr6w-1; Tue, 01 Oct 2024 17:31:05 -0400
X-MC-Unique: rpONUxIXPKyM07vAG9tr6w-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cb2cd97215so98280826d6.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 14:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727818264; x=1728423064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1IV1IoUfmF6TW7jHd2mD++pYAINTp/UYRDfSvr6/R8=;
 b=HBrVWy0s4+uyM6hcSb5gyAY7A/PMzBMjyTrp5k2K/p+6qsgJvAnA5kmWsS7sM8Ilza
 L6PNnw3fzonmFEdRj6Uuyr8dQKk8JGzqT+s2mWWj1GulZ+LWelLTJCnuiJkwrQZqtjz0
 WedcY4ysb1ixEWPP1etKAfGRjR9r2MvtQoNrXLU7LGr7KbdpRCm89gACBw+yTfjiEE7q
 UwfE56pfiiwr5yyppFbAmNZOHGL1eeBfrvQWQD7o3asUUQaP7gDGY1UigR5WNA3UmZh3
 am5FQNrvtBadlZpKsPSrRa2YNI9FN5yV9q17E1+UVQAw8BVSUtqjQe5/LRq1niFbReYO
 uwzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnQ9gFIE9tTAYYNU9cb16NyIXEMik/0/fDWLmE+Cu3VRCGZe649gqND2LhmyvYZUQnHjqPu5Lm5c2x@nongnu.org
X-Gm-Message-State: AOJu0YzGLBnk3+ysN/t20wLBDnQfooaAwEFg8YJs9rFhHwu8jGNCDiwY
 JnzK06p6uyvy2EJdkj3xQO1rUh6D15Tbvd0u2/DzNKzaxMx6O6dD6N4huIQg0evZztpyLxJAFW7
 xAbQftiY1o5ygozpIpkf1bubYFNsI4DnjDuiNjr6j/imv+oGUt+aW
X-Received: by 2002:a05:6214:3bc9:b0:6b7:aed3:408f with SMTP id
 6a1803df08f44-6cb819dd35cmr14439476d6.13.1727818263235; 
 Tue, 01 Oct 2024 14:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvAOa6/GOzKBJQZ4vg5Ke8asbwFFZDk+1byuf/xGlpsn9pYwX6Xlu95kgvlZaGQKfjT61JsQ==
X-Received: by 2002:a05:6214:3bc9:b0:6b7:aed3:408f with SMTP id
 6a1803df08f44-6cb819dd35cmr14438776d6.13.1727818262408; 
 Tue, 01 Oct 2024 14:31:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b60f8f4sm53884766d6.33.2024.10.01.14.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 14:31:01 -0700 (PDT)
Date: Tue, 1 Oct 2024 17:30:59 -0400
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
Message-ID: <ZvxqE0i5qGGiSFk0@x1n>
References: <Zt9UjvvbeUZQlGNY@x1n>
 <d245c8b6-b765-42e1-a5ec-bdb46494cec4@maciej.szmigiero.name>
 <ZuyTjQJujZo6tw9p@x1n>
 <bbed8165-de5c-4ebe-a6cc-ff33f9ea363a@maciej.szmigiero.name>
 <Zu2mvrKOvmD1WtvD@x1n>
 <848ba96d-c3ca-4fbb-9ec4-92023230c026@maciej.szmigiero.name>
 <ZvYCGFnI_68B_w3h@x1n>
 <c013f26f-6e55-4426-9ec9-e160e8179a7a@maciej.szmigiero.name>
 <ZvsesAPD6G4Ef9m0@x1n>
 <927023c9-c8ba-4cdf-9d42-bf1109a139af@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <927023c9-c8ba-4cdf-9d42-bf1109a139af@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 01, 2024 at 10:41:14PM +0200, Maciej S. Szmigiero wrote:
> On 30.09.2024 23:57, Peter Xu wrote:
> > On Mon, Sep 30, 2024 at 09:25:54PM +0200, Maciej S. Szmigiero wrote:
> > > On 27.09.2024 02:53, Peter Xu wrote:
> > > > On Fri, Sep 27, 2024 at 12:34:31AM +0200, Maciej S. Szmigiero wrote:
> > > > > On 20.09.2024 18:45, Peter Xu wrote:
> > > > > > On Fri, Sep 20, 2024 at 05:23:08PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > On 19.09.2024 23:11, Peter Xu wrote:
> > > > > > > > On Thu, Sep 19, 2024 at 09:49:10PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > > > On 9.09.2024 22:03, Peter Xu wrote:
> > > > > > > > > > On Tue, Aug 27, 2024 at 07:54:27PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > > > > > > > 
> > > > > > > > > > > load_finish SaveVMHandler allows migration code to poll whether
> > > > > > > > > > > a device-specific asynchronous device state loading operation had finished.
> > > > > > > > > > > 
> > > > > > > > > > > In order to avoid calling this handler needlessly the device is supposed
> > > > > > > > > > > to notify the migration code of its possible readiness via a call to
> > > > > > > > > > > qemu_loadvm_load_finish_ready_broadcast() while holding
> > > > > > > > > > > qemu_loadvm_load_finish_ready_lock.
> > > > > > > > > > > 
> > > > > > > > > > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > > > > > > > > > ---
> > > > > > > > > > >       include/migration/register.h | 21 +++++++++++++++
> > > > > > > > > > >       migration/migration.c        |  6 +++++
> > > > > > > > > > >       migration/migration.h        |  3 +++
> > > > > > > > > > >       migration/savevm.c           | 52 ++++++++++++++++++++++++++++++++++++
> > > > > > > > > > >       migration/savevm.h           |  4 +++
> > > > > > > > > > >       5 files changed, 86 insertions(+)
> > > > > > > > > > > 
> > > > > > > > > > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > > > > > > > > > index 4a578f140713..44d8cf5192ae 100644
> > > > > > > > > > > --- a/include/migration/register.h
> > > > > > > > > > > +++ b/include/migration/register.h
> > > > > > > > > > > @@ -278,6 +278,27 @@ typedef struct SaveVMHandlers {
> > > > > > > > > > >           int (*load_state_buffer)(void *opaque, char *data, size_t data_size,
> > > > > > > > > > >                                    Error **errp);
> > > > > > > > > > > +    /**
> > > > > > > > > > > +     * @load_finish
> > > > > > > > > > > +     *
> > > > > > > > > > > +     * Poll whether all asynchronous device state loading had finished.
> > > > > > > > > > > +     * Not called on the load failure path.
> > > > > > > > > > > +     *
> > > > > > > > > > > +     * Called while holding the qemu_loadvm_load_finish_ready_lock.
> > > > > > > > > > > +     *
> > > > > > > > > > > +     * If this method signals "not ready" then it might not be called
> > > > > > > > > > > +     * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
> > > > > > > > > > > +     * while holding qemu_loadvm_load_finish_ready_lock.
> > > > > > > > > > 
> > > > > > > > > > [1]
> > > > > > > > > > 
> > > > > > > > > > > +     *
> > > > > > > > > > > +     * @opaque: data pointer passed to register_savevm_live()
> > > > > > > > > > > +     * @is_finished: whether the loading had finished (output parameter)
> > > > > > > > > > > +     * @errp: pointer to Error*, to store an error if it happens.
> > > > > > > > > > > +     *
> > > > > > > > > > > +     * Returns zero to indicate success and negative for error
> > > > > > > > > > > +     * It's not an error that the loading still hasn't finished.
> > > > > > > > > > > +     */
> > > > > > > > > > > +    int (*load_finish)(void *opaque, bool *is_finished, Error **errp);
> > > > > > > > > > 
> > > > > > > > > > The load_finish() semantics is a bit weird, especially above [1] on "only
> > > > > > > > > > allowed to be called once if ..." and also on the locks.
> > > > > > > > > 
> > > > > > > > > The point of this remark is that a driver needs to call
> > > > > > > > > qemu_loadvm_load_finish_ready_broadcast() if it wants for the migration
> > > > > > > > > core to call its load_finish handler again.
> > > > > > > > > 
> > > > > > > > > > It looks to me vfio_load_finish() also does the final load of the device.
> > > > > > > > > > 
> > > > > > > > > > I wonder whether that final load can be done in the threads,
> > > > > > > > > 
> > > > > > > > > Here, the problem is that current VFIO VMState has to be loaded from the main
> > > > > > > > > migration thread as it internally calls QEMU core address space modification
> > > > > > > > > methods which explode if called from another thread(s).
> > > > > > > > 
> > > > > > > > Ahh, I see.  I'm trying to make dest qemu loadvm in a thread too and yield
> > > > > > > > BQL if possible, when that's ready then in your case here IIUC you can
> > > > > > > > simply take BQL in whichever thread that loads it.. but yeah it's not ready
> > > > > > > > at least..
> > > > > > > 
> > > > > > > Yeah, long term we might want to work on making these QEMU core address space
> > > > > > > modification methods somehow callable from multiple threads but that's
> > > > > > > definitely not something for the initial patch set.
> > > > > > > 
> > > > > > > > Would it be possible vfio_save_complete_precopy_async_thread_config_state()
> > > > > > > > be done in VFIO's save_live_complete_precopy() through the main channel
> > > > > > > > somehow?  IOW, does it rely on iterative data to be fetched first from
> > > > > > > > kernel, or completely separate states?
> > > > > > > 
> > > > > > > The device state data needs to be fully loaded first before "activating"
> > > > > > > the device by loading its config state.
> > > > > > > 
> > > > > > > > And just curious: how large is it
> > > > > > > > normally (and I suppose this decides whether it's applicable to be sent via
> > > > > > > > the main channel at all..)?
> > > > > > > 
> > > > > > > Config data is *much* smaller than device state data - as far as I remember
> > > > > > > it was on order of kilobytes.
> > > > > > > 
> > > > > > > > > 
> > > > > > > > > > then after
> > > > > > > > > > everything loaded the device post a semaphore telling the main thread to
> > > > > > > > > > continue.  See e.g.:
> > > > > > > > > > 
> > > > > > > > > >          if (migrate_switchover_ack()) {
> > > > > > > > > >              qemu_loadvm_state_switchover_ack_needed(mis);
> > > > > > > > > >          }
> > > > > > > > > > 
> > > > > > > > > > IIUC, VFIO can register load_complete_ack similarly so it only sem_post()
> > > > > > > > > > when all things are loaded?  We can then get rid of this slightly awkward
> > > > > > > > > > interface.  I had a feeling that things can be simplified (e.g., if the
> > > > > > > > > > thread will take care of loading the final vmstate then the mutex is also
> > > > > > > > > > not needed? etc.).
> > > > > > > > > 
> > > > > > > > > With just a single call to switchover_ack_needed per VFIO device it would
> > > > > > > > > need to do a blocking wait for the device buffers and config state load
> > > > > > > > > to finish, therefore blocking other VFIO devices from potentially loading
> > > > > > > > > their config state if they are ready to begin this operation earlier.
> > > > > > > > 
> > > > > > > > I am not sure I get you here, loading VFIO device states (I mean, the
> > > > > > > > non-iterable part) will need to be done sequentially IIUC due to what you
> > > > > > > > said and should rely on BQL, so I don't know how that could happen
> > > > > > > > concurrently for now.  But I think indeed BQL is a problem.
> > > > > > > Consider that we have two VFIO devices (A and B), with the following order
> > > > > > > of switchover_ack_needed handler calls for them: first A get this call,
> > > > > > > once the call for A finishes then B gets this call.
> > > > > > > 
> > > > > > > Now consider what happens if B had loaded all its buffers (in the loading
> > > > > > > thread) and it is ready for its config load before A finished loading its
> > > > > > > buffers.
> > > > > > > 
> > > > > > > B has to wait idle in this situation (even though it could have been already
> > > > > > > loading its config) since the switchover_ack_needed handler for A won't
> > > > > > > return until A is fully done.
> > > > > > 
> > > > > > This sounds like a performance concern, and I wonder how much this impacts
> > > > > > the real workload (that you run a test and measure, with/without such
> > > > > > concurrency) when we can save two devices in parallel anyway; I would
> > > > > > expect the real diff is small due to the fact I mentioned that we save >1
> > > > > > VFIO devices concurrently via multifd.
> > > > > > 
> > > > > > Do you think we can start with a simpler approach?
> > > > > 
> > > > > I don't think introducing a performance/scalability issue like that is
> > > > > a good thing, especially that we already have a design that avoids it.
> > > > > 
> > > > > Unfortunately, my current setup does not allow live migrating VMs with
> > > > > more than 4 VFs so I can't benchmark that.
> > > > 
> > > > /me wonders why benchmarking it requires more than 4 VFs.
> > > 
> > > My point here was that the scalability problem will most likely get more
> > > pronounced with more VFs.
> > > 
> > > > > 
> > > > > But I almost certain that with more VFs the situation with devices being
> > > > > ready out-of-order will get even more likely.
> > > > 
> > > > If the config space is small, why loading it in sequence would be a
> > > > problem?
> > > > 
> > > > Have you measured how much time it needs to load one VF's config space that
> > > > you're using?  I suppose that's vfio_load_device_config_state() alone?
> > > 
> > > It's not the amount of data to load matters here but that these address
> > > space operations are slow.
> > > 
> > > The whole config load takes ~70 ms per device - that's time equivalent
> > > of transferring 875 MiB of device state via a 100 GBit/s link.
> > 
> > What's the downtime of migration with 1/2/4 VFs?  I remember I saw some
> > data somewhere but it's not in the cover letter.  It'll be good to mention
> > these results in the cover letter when repost.
> 
> Downtimes with the device state transfer being disabled / enabled:
>             4 VFs   2 VFs    1 VF
> Disabled: 1783 ms  614 ms  283 ms
> Enabled:  1068 ms  434 ms  274 ms
> 
> Will add these numbers to the cover letter of the next patch set version.

Thanks.

> 
> > I'm guessing 70ms isn't a huge deal here, if your NIC has 128GB internal
> > device state to migrate.. but maybe I'm wrong.
> 
> It's ~100 MiB of device state per VF here.

Ouch..

I watched your kvm forum talk recording, I remember that's where I get that
128 number but probably get the unit wrong.. ok that makes sense.

> 
> And it's 70ms of downtime *per device*:
> so with 4 VF it's ~280ms of downtime taken by the config loads.
> That's a lot - with perfect parallelization this downtime should
> *reduce by* 210ms.

Yes, in this case it's a lot.  I wonder why it won't scale as good even
with your patchset.

Did you profile why?  I highly doubt in your case network is an issue, as
there's only 100MB per-dev data, so even on 10gbps it takes 100ms only to
transfer for each, while now assuming it can run concurrently.  I think you
mentioned you were using 100gbps, right?

Logically when with multiple threads, VFIO read()s should happen at least
concurrently per-device.  Have you checked that there's no kernel-side
global VFIO lock etc. that serializes portions of the threads read()s /
write()s on the VFIO fds?

It's just a pity that you went this far, added all these logics, but
without making it fully concurrent at least per device.

I'm OK if you want this in without that figured out, but if I were you I'll
probably try to dig a bit to at least know why.

> 
> > I also wonder whether you profiled a bit on how that 70ms contributes to
> > what is slow.
> 
> I think that's something we can do after we have parallel config loads
> and it turns out their downtime for some reason still scales strongly
> linearly with the number of VFIO devices (rather than taking roughly
> constant time regardless of the count of these devices if running perfectly
> in parallel).

Similarly, I wonder whether the config space load() can involves something
globally shared.  I'd also dig a bit here, but I'll leave that to you to
decide.

> 
> > > 
> > > > > 
> > > > > > So what I'm thinking could be very clean is, we just discussed about
> > > > > > MIG_CMD_SWITCHOVER and looks like you also think it's an OK approach.  I
> > > > > > wonder when with it why not we move one step further to have
> > > > > > MIG_CMD_SEND_NON_ITERABE just to mark that "iterable devices all done,
> > > > > > ready to send non-iterable".  It can be controlled by the same migration
> > > > > > property so we only send these two flags in 9.2+ machine types.
> > > > > > 
> > > > > > Then IIUC VFIO can send config data through main wire (just like most of
> > > > > > other pci devices! which is IMHO a good fit..) and on destination VFIO
> > > > > > holds off loading them until passing the MIG_CMD_SEND_NON_ITERABE phase.
> > > > > 
> > > > > Starting the config load only on MIG_CMD_SEND_NON_ITERABE would (in addition
> > > > > to the considerations above) also delay starting the config load until all
> > > > > iterable devices were read/transferred/loaded and also would complicate
> > > > > future efforts at loading that config data in parallel.
> > > > 
> > > > However I wonder whether we can keep it simple in that VFIO's config space
> > > > is still always saved in vfio_save_state().  I still think it's easier we
> > > > stick with the main channel whenever possible.  For this specific case, if
> > > > the config space is small I think it's tricky you bypass this with:
> > > > 
> > > >       if (migration->multifd_transfer) {
> > > >           /* Emit dummy NOP data */
> > > >           qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> > > >           return;
> > > >       }
> > > > 
> > > > Then squash this as the tail of the iterable data.
> > > > 
> > > > On the src, I think it could use a per-device semaphore, so that iterable
> > > > save() thread will post() only if it finishes dumping all the data, then
> > > > that orders VFIO iterable data v.s. config space save().
> > > 
> > > In the future we want to not only transfer but also load the config data
> > > in parallel.
> > 
> > How feasible do you think this idea is?  E.g. does it involve BQL so far
> > (e.g. memory updates, others)?  What's still missing to make it concurrent?
> 
> My gut feeling is that is feasible overall but it's too much of a rabbit
> hole for the first version of this device state transfer feature.
> 
> I think it will need some deeper QEMU core address space management changes,
> which need to be researched/developed/tested/reviewed/etc. on their own.
> 
> If it was an easy task I would have gladly included such support in this
> patch set version already for extra downtime reduction :)

Yes I understand.

Note that it doesn't need to be implemented and resolved in one shot, but I
wonder if it'll still be good to debug the issue and know where is not
scaling.

Considering that your design is fully concurrent as of now on iterable data
from QEMU side, it's less persuasive to provide perf numbers that still
doesn't scale that much; 1.78s -> 1.06s is a good improvement, but it
doesn't seem to solve the scalability issue that this whole series wanted
to address in general.

An extreme (bad) example is if VFIO has all ioctl()/read()/write() take a
global lock, then any work in QEMU trying to run things in parallel will be
a vain.  Such patchset cannot be accepted because the other issue needs to
be resolved first.

Now it's in the middle of best/worst condition, where it did improve but it
still doesn't scale that well.  I think it can be accepted, but still I
feel like we're ignoring some of the real issues.  We can choose to ignore
the kernel saying that "it's too much to do together", but IMHO the issues
should be tackled in the other way round.. the normal case is one should
work out the kernel scalability issues, then QEMU should be on top.. Simply
because any kernel change that might scale >1 device save()/load() can
affect future QEMU change and design, not vice versa.

Again, I know you wished we make some progress, so I don't have a strong
opinion.  Just FYI.

> 
> > > 
> > > So going back to transferring this data serialized via the main migration
> > > channel would be taking a step back here.
> > 
> > If below holds true:
> > 
> >    - 70ms is still very small amount in the total downtime, and,
> > 
> >    - this can avoid the below load_finish() API
> > 
> > Then I'd go for it.. or again, at least the load_finish() needs change,
> > IMHO..
> 
> As I wrote above, it's not 70 ms total but 70 ms per device.
> 
> Also, even 70 ms is a lot, considering that the default downtime limit
> is 300 ms - with a single device that's nearly 1/4 of the limit already.
> 
> > > 
> > > By the way, we already have a serialization point in
> > > qemu_savevm_state_complete_precopy_iterable() after iterables have been sent -
> > > waiting for device state sending threads to finish their work.
> > > 
> > > Whether this thread_pool_wait() operation will be implemented using
> > > semaphores I'm not sure yet - will depend on how well this will fit other
> > > GThreadPool internals.
> > > 
> > > > On the dst, after a 2nd thought, MIG_CMD_SEND_NON_ITERABE may not work or
> > > > needed indeed, because multifd bypasses the main channel, so if we send
> > > > anything like MIG_CMD_SEND_NON_ITERABE on the main channel it won't
> > > > guarantee multifd load all complete.  However IIUC that can be used in a
> > > > similar way as the src qemu I mentioned above with a per-device semaphore,
> > > > so that only all the iterable data of this device loaded and applied to the
> > > > HW would it post(), before that, vfio_load_state() should wait() on that
> > > > sem waiting for data to ready (while multifd threads will be doing that
> > > > part).  I wonder whether we may reuse the multifd recv thread in the
> > > > initial version, so maybe we don't need any other threads on destination.
> > > > 
> > > > The load_finish() interface is currently not able to be reused right,
> > > > afaict.  Just have a look at its definition:
> > > > 
> > > >       /**
> > > >        * @load_finish
> > > >        *
> > > >        * Poll whether all asynchronous device state loading had finished.
> > > >        * Not called on the load failure path.
> > > >        *
> > > >        * Called while holding the qemu_loadvm_load_finish_ready_lock.
> > > >        *
> > > >        * If this method signals "not ready" then it might not be called
> > > >        * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
> > > >        * while holding qemu_loadvm_load_finish_ready_lock.
> > > >        *
> > > >        * @opaque: data pointer passed to register_savevm_live()
> > > >        * @is_finished: whether the loading had finished (output parameter)
> > > >        * @errp: pointer to Error*, to store an error if it happens.
> > > >        *
> > > >        * Returns zero to indicate success and negative for error
> > > >        * It's not an error that the loading still hasn't finished.
> > > >        */
> > > >       int (*load_finish)(void *opaque, bool *is_finished, Error **errp);
> > > > 
> > > > It's over complicated on defining all its details:
> > > > 
> > > >     - Not re-entrant by default..
> > > 
> > > What do you mean by "re-entrant" here?
> > > 
> > > This handler is called only from single migration thread, so it cannot
> > > be re-entered anyway since the control doesn't return to the migration
> > > code until this handler exits (and obviously the handler won't call
> > > itself recursively).
> > 
> > I think it's not a good design to say "you can call this function once, but
> > not the 2nd time until you wait on a semaphore".
> 
> That's not exactly how this API is supposed to work.
> 
> I suspect that you took that "it might not be called again until
> qemu_loadvm_load_finish_ready_broadcast() is invoked" as prohibition
> from being called again until that signal is broadcast.
> 
> The intended meaning of that sentence was "it is possible that it won't
> be called again until qemu_loadvm_load_finish_ready_broadcast() is invoked".
> 
> In other words, the migration core is free to call this handler how
> many times the migration core wants.
> 
> But if the handler wants be *sure* that it will get called by the
> migration core after the handler has returned "not ready" then it needs
> to arrange for load_finish_ready_broadcast() to be invoked somehow.

OK I see.

> 
> (..)
> > > 
> > > >       that I feel like perhaps can be replaced by a sem (then to drop the
> > > >       condvar)?
> > > 
> > > Once we have ability to load device config state outside main migration
> > > thread replacing "load_finish" handler with a semaphore should indeed be
> > > possible (that's internal migration API so there should be no issue
> > > removing it as not necessary anymore at this point).
> > > 
> > > But for now, the devices need to have ability to run their config load
> > > code on the main migration thread, and for that they need to be called
> > > from this handler "load_finish".
> > 
> > A sem seems a must here to notify the iterable data finished loading, but
> > that doesn't need to hook to the vmstate handler, but some post-process
> > tasks, like what we do around cpu_synchronize_all_post_init() time.
> > 
> > If per-device vmstate handler hook version of load_finish() is destined to
> > look as weird in this case, I'd rather consider a totally separate way to
> > enqueue some jobs that needs to be run after all vmstates loaded.  Then
> > after one VFIO device fully loads its data, it enqueues the task and post()
> > to one migration sem saying that "there's one post-process task, please run
> > it in migration thread".  There can be a total number of tasks registered
> > so that migration thread knows not to continue until these number of tasks
> > processed.  That counter can be part of vmstate handler, maybe, reporting
> > that "this vmstate handler has one post-process task".
> > 
> > Maybe you have other ideas, but please no, let's avoid this load_finish()
> > thing..
> 
> I can certainly implement the task-queuing approach instead of the
> load_finish() handler API if you like such approach more.

I have an even simpler solution now.  I think you can reuse precopy
notifiers.

You can add one new PRECOPY_NOTIFY_INCOMING_COMPLETE event, invoke it after
vmstate load all done.

As long as VFIO devices exist, VFIO can register with that event, then it
can do whatever it wants in the main loader thread with BQL held.

You can hide that sem post() / wait() all there, then it's completely VFIO
internal.  Then we leave vmstate handler alone; it just doesn't sound
suitable when the hooks need to be called out of order.

> 
> > I'd rather still see justifications showing that this 70ms really is
> > helpful.. I'd rather wish we have +70ms*Ndev downtime but drop this hook
> > until we have a clearer mind when all config space can be loaded
> > concurrently, for example.  So we start from simple.
> 
> As I wrote above, even 70ms for a single device is a lot considering the
> default downtime limit - and that's even more true if multiplied by
> multiple devices.
> 
> > > 
> > > >     - How qemu_loadvm_load_finish_ready_broadcast() interacts with all
> > > >       above..
> > > > 
> > > > So if you really think it matters to load whatever VFIO device who's
> > > > iterable data is ready first, then let's try come up with some better
> > > > interface..  I can try to think about it too, but please answer me
> > > > questions above so I can understand what I am missing on why that's
> > > > important.  Numbers could help, even if 4 VF and I wonder how much diff
> > > > there can be.  Mostly, I don't know why it's slow right now if it is; I
> > > > thought it should be pretty fast, at least not a concern in VFIO migration
> > > > world (which can take seconds of downtime or more..).
> > > > 
> > > > IOW, it sounds more reasonalbe to me that no matter whether vfio will
> > > > support multifd, it'll be nice we stick with vfio_load_state() /
> > > > vfio_save_state() for config space, and hopefully it's also easier it
> > > > always go via the main channel to everyone.  In these two hooks, VFIO can
> > > > do whatever it wants to sync with other things (on src, sync with
> > > > concurrent thread pool saving iterable data and dumping things to multifd
> > > > channels; on dst, sync with multifd concurrent loads). I think it can
> > > > remove the requirement on the load_finish() interface completely.  Yes,
> > > > this can only load VFIO's pci config space one by one, but I think this is
> > > > much simpler, and I hope it's also not that slow, but I'm not sure.
> > > 
> > > To be clear, I made a following diagram describing how the patch set
> > > is supposed to work right now, including changing per-device
> > > VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE into a common MIG_CMD_SWITCHOVER.
> > > 
> > > Time flows on it left to right (->).
> > > 
> > > ----------- DIAGRAM START -----------
> > > Source overall flow:
> > > Main channel: live VM phase data -> MIG_CMD_SWITCHOVER -> iterable                                                                          -> non iterable
> > > Multifd channels:                                       \ multifd device state read and queue (1) -> multifd config data read and queue (1) /
> > > 
> > > Target overall flow:
> > > Main channel: live VM phase data -> MIG_CMD_SWITCHOVER -> iterable -> non iterable -> config data load operations
> > > Multifd channels:                                       \ multifd device state (1) -> multifd config data read (1)
> > > 
> > > Target config data load operations flow:
> > > multifd config data read (1) -> config data load (2)
> > > 
> > > Notes:
> > > (1): per device threads running in parallel
> > 
> > Here I raised this question before, but I'll ask again: do you think we can
> > avoid using a separate thread on dest qemu, but reuse multifd recv threads?
> > 
> > Src probably needs its own threads because multifd sender threads takes
> > request, so it can't block on its own.
> > 
> > However dest qemu isn't like that, it's packet driven so I think maybe it's
> > ok VFIO directly loads the data in the multifd threads.  We may want to
> > have enough multifd threads to make sure IO still don't block much on the
> > NIC, but I think tuning the num of multifd threads should work in this
> > case.
> 
> We need to have the receiving threads decoupled from the VFIO device state
> loading threads at least because otherwise:
> 1) You can have a deadlock if device state for multiple devices arrives
> out of order, like here:
> 
> Time flows left to right (->).
> Multifd channel 1: (VFIO device 1 buffer 2) (VFIO device 2 buffer 1)
> Multifd channel 2: (VFIO device 2 buffer 2) (VFIO device 1 buffer 1)
> 
> Both channel receive/load threads would be stuck forever in this case,
> since they can't load buffer 2 for devices 1 and 2 until they load
> buffer 1 for each of these devices.
> 
> 2) If devices are loading buffers at different speeds you don't want
> to block the faster device from receiving new buffer just because
> the slower one hasn't finished its loading yet.

I don't see why it can't be avoided.  Let me draw this in columns.

How I picture this is:

   multifd recv thread 1                     multifd recv thread 2
   ---------------------                     ---------------------
   recv VFIO device 1 buffer 2             recv VFIO device 2 buffer 2
    -> found that (dev1, buf1) missing,      -> found that (dev2, buf1) missing,
       skip load                                skip load
   recv VFIO device 2 buffer 1             recv VFIO device 1 buffer 1 
    -> found that (dev2, buf1+buf2) ready,   -> found that (dev1, buf1+buf2) ready,
       load buf1+2 for dev2 here                load buf1+2 for dev1 here
                                               
Here right after one multifd thread recvs a buffer, it needs to be injected
into the cache array (with proper locking), so that whoever receives a full
series of those buffers will do the load (again, with proper locking..).

Would this not work?

> 
> > > (2): currently serialized (only one such operation running at a particular time), will hopefully be parallelized in the future
> > > ----------- DIAGRAM END -----------
> > > 
> > > Hope the diagram survived being pasted into an e-mail message.
> > > 
> > > One can see, that even now there's a bit of "low hanging fruit" of missing
> > > possible parallelism:
> > > It seems that the source could wait for multifd device state + multifd config
> > > data *after* non-iterables are sent rather than before as it is done
> > > currently - so they will be sent in parallel with multifd data.
> > 
> > Currently it's blocked by this chunk of code of yours:
> > 
> >      if (multifd_device_state) {
> >          ret = multifd_join_device_state_save_threads();
> >          if (ret) {
> >              qemu_file_set_error(f, ret);
> >              return -1;
> >          }
> >      }
> > 
> > If with your proposal that vfio config space sent via multifd channels,
> > indeed I don't see why it can't be moved to be after non-iterable save()
> > completes.  Is that what you implied as "low hanging fruit"?
> 
> Yes, exactly - to wait for save threads to finish only after non-iterables
> have already been saved.
> 
> By "low hanging fruit" I meant it should be a fairly easy change.
> 
> > [***]
> > 
> > > 
> > > Since written description is often prone to misunderstanding
> > > could you please annotate that diagram with your proposed new flow?
> > 
> > What I was suggesting (removing load_finish()) is mostly the same as what
> > you drew I think, especially on src:
> > 
> > ===============
> > Source overall flow:
> > Main channel: live VM phase data -> MIG_CMD_SWITCHOVER -> iterable                                                                          -> non iterable
> > Multifd channels:                                       \ multifd device state read and queue (1) -> multifd config data read and queue (1) /
> > ===============
> > 
> > In this case we can't do the optimization above [***], since what I
> > suggested requires VFIO's vfio_save_state() to dump the config space, so
> > the original order will be needed here.
> > 
> > While on dest, config data load will need to also load using vfio's
> > vfio_load_state() so it'll be invoked just like what we normally do with
> > non-iterable device states (so here "config data load operations" is part
> > of loading all non-iterable devices):
> > 
> > ===============
> > Target overall flow:                                                              (X)
> > Main channel: live VM phase data -> MIG_CMD_SWITCHOVER -> iterable -> non iterable (multifd config data read -> config data load operations)
> > Multifd channels:                                       \ multifd device state load                                /
> >                                          (lower part done via multifd recv threads, not separate threads)
> > ===============
> > 
> > So here the ordering of (X) is not guarded by anything, however in
> > vfio_load_state() the device can sem_wait() on a semaphore that only be
> > posted until this device's device state is fully loaded.  So it's not
> > completely serialized - "config data load operations" of DEV1 can still
> > happen concurrently with "multifd device state load" of DEV2.
> > 
> > Sorry, this might not be as clear as it's not easy to draw in the graph,
> > but I hope the words can help clarify what I meant.
> > 
> > If 70ms is not a major deal, I suggest we consider above approach, I think
> > it can simplify at least the vmstate handler API.  If 70ms matters, let's
> > try refactor load_finish() to something usable.
> 
> I understand your point here, however as I wrote above, I think that's too
> much downtime to "waste" so I will try to rework the load_finish() handler
> into the task-queuing approach as you suggested earlier.

Thanks.

-- 
Peter Xu


