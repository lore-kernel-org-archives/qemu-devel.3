Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42D0CEBF63
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 00:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stzFB-0000nA-Cu; Thu, 26 Sep 2024 20:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1stzF9-0000Wk-Am
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 20:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1stzF6-0007RL-D5
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 20:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727398434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KFM1bycWDdJ3Vk9tr5hq5/j4A2n3wGdK5MGT+ogX7c=;
 b=SCNBcBgR8kwwnbeSU2/JhTDVWhGQn9A0ksItABXByaRgngLj1RT0NoBMuYI92QYQNeVWvY
 8UePgDhroEePE635Rl2do5bcdMCOh3eJIBUQGf8dzyhWy7H3lq+GsS/D1c66RCWFwjiK1f
 pZ1N6ClJquEqsvJHsuQ1133bpcjl2CY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-ZpZtjjYsNSm1n1WmJ9DEOA-1; Thu, 26 Sep 2024 20:53:51 -0400
X-MC-Unique: ZpZtjjYsNSm1n1WmJ9DEOA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e0a022ea3aso1056183a91.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 17:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727398429; x=1728003229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KFM1bycWDdJ3Vk9tr5hq5/j4A2n3wGdK5MGT+ogX7c=;
 b=TvmoV3COY4/6wuFVDD0jsx/d61bP/WjdkmzD84bdg9trJ+PESo8H4s8j/WEQt7mZ5b
 417ff/WDKwkQGH1yasEq+YHcHGs2QQZWD38O9DrqFqyBWnenUHPf/x+aflME9A+6Mekx
 Q4IjwRxC7X+cRPW1fJ+irORBt6rhw7X6Doxm/5lhN7VZOrMYTRse/0AUOtpvTV044Ol8
 yEw8pDyQi2TVwO3/j0+jirLT9QFKUftDEuKvyIGboAbxEs2+i3trO9fj8LRVj0JKjsp+
 Fe9T5LY/5DXHea8SW9b8i7Nj/yzO9+aTV8mHvUmHjo9WoWUMKWIPvZE3AY5GcFucs0CS
 U3FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqK/mwv5KMtu3X8pO1bjs9qtNGFTt8MeEl8MRavGUTu/Tl8oMeUgk9H5GvogikfAlqG+ilj/sI8cpb@nongnu.org
X-Gm-Message-State: AOJu0YwPaxJuPeuTGtg0AYCQxrU/opN9prGL/q1I4oockiC2EMPegysJ
 M+2Yj0GbQ88CDaHG7R2jrVTdBi21xvznudbQFA2dDV/mVC3yAkjgSacrtmDjubl5Z9ZSTMgE1zq
 kQN1Em4MC877Fvw8SsyVNSnqorPLC9Fbkr4D+2q/W05vBnlK/+HZa
X-Received: by 2002:a17:90a:ea0f:b0:2e0:9d79:4a02 with SMTP id
 98e67ed59e1d1-2e0b8b1cd40mr1892750a91.20.1727398429390; 
 Thu, 26 Sep 2024 17:53:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIb4dZpZ/r2h9EM6oapUA+GIFliE1yXZ61jYuZJNm7qkziNKC3KKCl7O7ZLQlOtB6x4hclrw==
X-Received: by 2002:a17:90a:ea0f:b0:2e0:9d79:4a02 with SMTP id
 98e67ed59e1d1-2e0b8b1cd40mr1892728a91.20.1727398428983; 
 Thu, 26 Sep 2024 17:53:48 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e06e1ae753sm4206814a91.14.2024.09.26.17.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 17:53:48 -0700 (PDT)
Date: Thu, 26 Sep 2024 20:53:44 -0400
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
Message-ID: <ZvYCGFnI_68B_w3h@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <1a7599896decdbae61cee385739dc0badc9b4364.1724701542.git.maciej.szmigiero@oracle.com>
 <Zt9UjvvbeUZQlGNY@x1n>
 <d245c8b6-b765-42e1-a5ec-bdb46494cec4@maciej.szmigiero.name>
 <ZuyTjQJujZo6tw9p@x1n>
 <bbed8165-de5c-4ebe-a6cc-ff33f9ea363a@maciej.szmigiero.name>
 <Zu2mvrKOvmD1WtvD@x1n>
 <848ba96d-c3ca-4fbb-9ec4-92023230c026@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <848ba96d-c3ca-4fbb-9ec4-92023230c026@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 27, 2024 at 12:34:31AM +0200, Maciej S. Szmigiero wrote:
> On 20.09.2024 18:45, Peter Xu wrote:
> > On Fri, Sep 20, 2024 at 05:23:08PM +0200, Maciej S. Szmigiero wrote:
> > > On 19.09.2024 23:11, Peter Xu wrote:
> > > > On Thu, Sep 19, 2024 at 09:49:10PM +0200, Maciej S. Szmigiero wrote:
> > > > > On 9.09.2024 22:03, Peter Xu wrote:
> > > > > > On Tue, Aug 27, 2024 at 07:54:27PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > > > 
> > > > > > > load_finish SaveVMHandler allows migration code to poll whether
> > > > > > > a device-specific asynchronous device state loading operation had finished.
> > > > > > > 
> > > > > > > In order to avoid calling this handler needlessly the device is supposed
> > > > > > > to notify the migration code of its possible readiness via a call to
> > > > > > > qemu_loadvm_load_finish_ready_broadcast() while holding
> > > > > > > qemu_loadvm_load_finish_ready_lock.
> > > > > > > 
> > > > > > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > > > > > ---
> > > > > > >     include/migration/register.h | 21 +++++++++++++++
> > > > > > >     migration/migration.c        |  6 +++++
> > > > > > >     migration/migration.h        |  3 +++
> > > > > > >     migration/savevm.c           | 52 ++++++++++++++++++++++++++++++++++++
> > > > > > >     migration/savevm.h           |  4 +++
> > > > > > >     5 files changed, 86 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > > > > > index 4a578f140713..44d8cf5192ae 100644
> > > > > > > --- a/include/migration/register.h
> > > > > > > +++ b/include/migration/register.h
> > > > > > > @@ -278,6 +278,27 @@ typedef struct SaveVMHandlers {
> > > > > > >         int (*load_state_buffer)(void *opaque, char *data, size_t data_size,
> > > > > > >                                  Error **errp);
> > > > > > > +    /**
> > > > > > > +     * @load_finish
> > > > > > > +     *
> > > > > > > +     * Poll whether all asynchronous device state loading had finished.
> > > > > > > +     * Not called on the load failure path.
> > > > > > > +     *
> > > > > > > +     * Called while holding the qemu_loadvm_load_finish_ready_lock.
> > > > > > > +     *
> > > > > > > +     * If this method signals "not ready" then it might not be called
> > > > > > > +     * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
> > > > > > > +     * while holding qemu_loadvm_load_finish_ready_lock.
> > > > > > 
> > > > > > [1]
> > > > > > 
> > > > > > > +     *
> > > > > > > +     * @opaque: data pointer passed to register_savevm_live()
> > > > > > > +     * @is_finished: whether the loading had finished (output parameter)
> > > > > > > +     * @errp: pointer to Error*, to store an error if it happens.
> > > > > > > +     *
> > > > > > > +     * Returns zero to indicate success and negative for error
> > > > > > > +     * It's not an error that the loading still hasn't finished.
> > > > > > > +     */
> > > > > > > +    int (*load_finish)(void *opaque, bool *is_finished, Error **errp);
> > > > > > 
> > > > > > The load_finish() semantics is a bit weird, especially above [1] on "only
> > > > > > allowed to be called once if ..." and also on the locks.
> > > > > 
> > > > > The point of this remark is that a driver needs to call
> > > > > qemu_loadvm_load_finish_ready_broadcast() if it wants for the migration
> > > > > core to call its load_finish handler again.
> > > > > 
> > > > > > It looks to me vfio_load_finish() also does the final load of the device.
> > > > > > 
> > > > > > I wonder whether that final load can be done in the threads,
> > > > > 
> > > > > Here, the problem is that current VFIO VMState has to be loaded from the main
> > > > > migration thread as it internally calls QEMU core address space modification
> > > > > methods which explode if called from another thread(s).
> > > > 
> > > > Ahh, I see.  I'm trying to make dest qemu loadvm in a thread too and yield
> > > > BQL if possible, when that's ready then in your case here IIUC you can
> > > > simply take BQL in whichever thread that loads it.. but yeah it's not ready
> > > > at least..
> > > 
> > > Yeah, long term we might want to work on making these QEMU core address space
> > > modification methods somehow callable from multiple threads but that's
> > > definitely not something for the initial patch set.
> > > 
> > > > Would it be possible vfio_save_complete_precopy_async_thread_config_state()
> > > > be done in VFIO's save_live_complete_precopy() through the main channel
> > > > somehow?  IOW, does it rely on iterative data to be fetched first from
> > > > kernel, or completely separate states?
> > > 
> > > The device state data needs to be fully loaded first before "activating"
> > > the device by loading its config state.
> > > 
> > > > And just curious: how large is it
> > > > normally (and I suppose this decides whether it's applicable to be sent via
> > > > the main channel at all..)?
> > > 
> > > Config data is *much* smaller than device state data - as far as I remember
> > > it was on order of kilobytes.
> > > 
> > > > > 
> > > > > > then after
> > > > > > everything loaded the device post a semaphore telling the main thread to
> > > > > > continue.  See e.g.:
> > > > > > 
> > > > > >        if (migrate_switchover_ack()) {
> > > > > >            qemu_loadvm_state_switchover_ack_needed(mis);
> > > > > >        }
> > > > > > 
> > > > > > IIUC, VFIO can register load_complete_ack similarly so it only sem_post()
> > > > > > when all things are loaded?  We can then get rid of this slightly awkward
> > > > > > interface.  I had a feeling that things can be simplified (e.g., if the
> > > > > > thread will take care of loading the final vmstate then the mutex is also
> > > > > > not needed? etc.).
> > > > > 
> > > > > With just a single call to switchover_ack_needed per VFIO device it would
> > > > > need to do a blocking wait for the device buffers and config state load
> > > > > to finish, therefore blocking other VFIO devices from potentially loading
> > > > > their config state if they are ready to begin this operation earlier.
> > > > 
> > > > I am not sure I get you here, loading VFIO device states (I mean, the
> > > > non-iterable part) will need to be done sequentially IIUC due to what you
> > > > said and should rely on BQL, so I don't know how that could happen
> > > > concurrently for now.  But I think indeed BQL is a problem.
> > > Consider that we have two VFIO devices (A and B), with the following order
> > > of switchover_ack_needed handler calls for them: first A get this call,
> > > once the call for A finishes then B gets this call.
> > > 
> > > Now consider what happens if B had loaded all its buffers (in the loading
> > > thread) and it is ready for its config load before A finished loading its
> > > buffers.
> > > 
> > > B has to wait idle in this situation (even though it could have been already
> > > loading its config) since the switchover_ack_needed handler for A won't
> > > return until A is fully done.
> > 
> > This sounds like a performance concern, and I wonder how much this impacts
> > the real workload (that you run a test and measure, with/without such
> > concurrency) when we can save two devices in parallel anyway; I would
> > expect the real diff is small due to the fact I mentioned that we save >1
> > VFIO devices concurrently via multifd.
> > 
> > Do you think we can start with a simpler approach?
> 
> I don't think introducing a performance/scalability issue like that is
> a good thing, especially that we already have a design that avoids it.
> 
> Unfortunately, my current setup does not allow live migrating VMs with
> more than 4 VFs so I can't benchmark that.

/me wonders why benchmarking it requires more than 4 VFs.

> 
> But I almost certain that with more VFs the situation with devices being
> ready out-of-order will get even more likely.

If the config space is small, why loading it in sequence would be a
problem?

Have you measured how much time it needs to load one VF's config space that
you're using?  I suppose that's vfio_load_device_config_state() alone?

> 
> > So what I'm thinking could be very clean is, we just discussed about
> > MIG_CMD_SWITCHOVER and looks like you also think it's an OK approach.  I
> > wonder when with it why not we move one step further to have
> > MIG_CMD_SEND_NON_ITERABE just to mark that "iterable devices all done,
> > ready to send non-iterable".  It can be controlled by the same migration
> > property so we only send these two flags in 9.2+ machine types.
> > 
> > Then IIUC VFIO can send config data through main wire (just like most of
> > other pci devices! which is IMHO a good fit..) and on destination VFIO
> > holds off loading them until passing the MIG_CMD_SEND_NON_ITERABE phase.
> 
> Starting the config load only on MIG_CMD_SEND_NON_ITERABE would (in addition
> to the considerations above) also delay starting the config load until all
> iterable devices were read/transferred/loaded and also would complicate
> future efforts at loading that config data in parallel.

However I wonder whether we can keep it simple in that VFIO's config space
is still always saved in vfio_save_state().  I still think it's easier we
stick with the main channel whenever possible.  For this specific case, if
the config space is small I think it's tricky you bypass this with:

    if (migration->multifd_transfer) {
        /* Emit dummy NOP data */
        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
        return;
    }

Then squash this as the tail of the iterable data.

On the src, I think it could use a per-device semaphore, so that iterable
save() thread will post() only if it finishes dumping all the data, then
that orders VFIO iterable data v.s. config space save().

On the dst, after a 2nd thought, MIG_CMD_SEND_NON_ITERABE may not work or
needed indeed, because multifd bypasses the main channel, so if we send
anything like MIG_CMD_SEND_NON_ITERABE on the main channel it won't
guarantee multifd load all complete.  However IIUC that can be used in a
similar way as the src qemu I mentioned above with a per-device semaphore,
so that only all the iterable data of this device loaded and applied to the
HW would it post(), before that, vfio_load_state() should wait() on that
sem waiting for data to ready (while multifd threads will be doing that
part).  I wonder whether we may reuse the multifd recv thread in the
initial version, so maybe we don't need any other threads on destination.

The load_finish() interface is currently not able to be reused right,
afaict.  Just have a look at its definition:

    /**
     * @load_finish
     *
     * Poll whether all asynchronous device state loading had finished.
     * Not called on the load failure path.
     *
     * Called while holding the qemu_loadvm_load_finish_ready_lock.
     *
     * If this method signals "not ready" then it might not be called
     * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
     * while holding qemu_loadvm_load_finish_ready_lock.
     *
     * @opaque: data pointer passed to register_savevm_live()
     * @is_finished: whether the loading had finished (output parameter)
     * @errp: pointer to Error*, to store an error if it happens.
     *
     * Returns zero to indicate success and negative for error
     * It's not an error that the loading still hasn't finished.
     */
    int (*load_finish)(void *opaque, bool *is_finished, Error **errp);

It's over complicated on defining all its details:

  - Not re-entrant by default.. this is so weirdly designed so that the
    caller needs to know which is even the "1st invocation of the
    function"... It is just weird.

  - Requires one more global mutex that non vmstate handler ever requested,
    that I feel like perhaps can be replaced by a sem (then to drop the
    condvar)?

  - How qemu_loadvm_load_finish_ready_broadcast() interacts with all
    above..

So if you really think it matters to load whatever VFIO device who's
iterable data is ready first, then let's try come up with some better
interface..  I can try to think about it too, but please answer me
questions above so I can understand what I am missing on why that's
important.  Numbers could help, even if 4 VF and I wonder how much diff
there can be.  Mostly, I don't know why it's slow right now if it is; I
thought it should be pretty fast, at least not a concern in VFIO migration
world (which can take seconds of downtime or more..).

IOW, it sounds more reasonalbe to me that no matter whether vfio will
support multifd, it'll be nice we stick with vfio_load_state() /
vfio_save_state() for config space, and hopefully it's also easier it
always go via the main channel to everyone.  In these two hooks, VFIO can
do whatever it wants to sync with other things (on src, sync with
concurrent thread pool saving iterable data and dumping things to multifd
channels; on dst, sync with multifd concurrent loads). I think it can
remove the requirement on the load_finish() interface completely.  Yes,
this can only load VFIO's pci config space one by one, but I think this is
much simpler, and I hope it's also not that slow, but I'm not sure.

Thanks,

-- 
Peter Xu


