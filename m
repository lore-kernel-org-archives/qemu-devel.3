Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DFBD262AF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 01:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viMyq-0000ND-Dn; Tue, 20 Jan 2026 20:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1viMyd-0000K5-SB
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 20:25:47 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1viMyX-0008EV-Tr
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 20:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=W+Q+U4frGgY6Ka9E31wVj8AxX5C3Peg1JvAnSg9yoB8=; b=rjzG9imMz1ABb2iV
 UvU/MbbVY56S6n97ENjomHKkbxztdGrvYjY5FxTovAHiuKQV+P3pEzVI3erv3IyoaJtrMPrD8qtvn
 fnq5UmCPeuf7ENZUBRrWqO8PkttaGd/Uf0nn/MnzDbeRhQa9FIskB/2qoYmGSuVjMGgkSRxvE31uD
 YQ2Jgt2ltZ4APYKYqK6p0O7zo7ntARgTwVh/+hznczVVp4IAEvb0qV5ASnB5JvZtucQeCRUiXq4Q+
 ze1HunKG/XcBa+q8b0OdXNCnfSswZAkQSTJxoEL0Hx43pwI2Rf9x+Kw0zUpPvssGi0jKACwert48o
 2+b053YDvcuqvAjH6w==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1viMyS-0000000GE3T-3Odo;
 Wed, 21 Jan 2026 01:25:32 +0000
Date: Wed, 21 Jan 2026 01:25:32 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aXArDHMRAohmUt51@gallifrey>
References: <20260115224929.616aab85@penguin> <aWlso1w39cQnEh2t@x1.local>
 <aWlxY9TWGT1aaMJz@gallifrey> <aWl6ixQpHaMJhV_E@x1.local>
 <20260117204913.584e1829@penguin> <aW6xNcsz3RIqHeE5@x1.local>
 <20260120110811.7df19a6c@penguin> <aW-mCye_eFmy5f4B@x1.local>
 <aW_Rqbc2Swg8vkXY@gallifrey> <aW_ccMSY4xJlRVn2@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aW_ccMSY4xJlRVn2@x1.local>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 01:07:56 up 86 days, 44 min,  2 users,  load average: 0.00, 0.01,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Peter Xu (peterx@redhat.com) wrote:
> On Tue, Jan 20, 2026 at 07:04:09PM +0000, Dr. David Alan Gilbert wrote:

<snip>

> > >   (2) Failure happens _after_ applying the new checkpoint, but _before_ the
> > >       whole checkpoint is applied.
> > > 
> > >       To be explicit, consider qemu_load_device_state() when the process of
> > >       colo_incoming_process_checkpoint() failed.  It means SVM applied
> > >       partial of PVM's checkpoint, I think it should mean PVM is completely
> > >       corrupted.
> > 
> > As long as the SVM has got the entire checkpoint, then it *can* apply it all
> > and carry on from that point.
> 
> Does it mean we assert() that qemu_load_device_state() will always success
> for COLO syncs?

Not sure; I'd expect if that load fails then the SVM fails; if that happens
on a periodic checkpoint then the PVM should carry on.

> Logically post_load() can invoke anything and I'm not sure if something can
> start to fail, but I confess I don't know an existing device that can
> trigger it.

Like a postcopy, it shouldn't fail unless there's an underlying failure
(e.g. storage died)

> Lukas told me something was broken though with pc machine type, on
> post_load() not re-entrant.  I think it might be possible though when
> post_load() is relevant to some device states (that guest driver can change
> between two checkpoint loads), but that's still only theoretical.  So maybe
> we can indeed assert it here.

I don't understand that non re-entrant bit?

> > 
> > > Here either (1.b) or (2) seems fatal to me on the whole high level design.
> > > Periodical syncs with x-checkpoint-delay can make this easier to happen, so
> > > larger windows of critical failures.  That's also why I think it's
> > > confusing COLO prefers more checkpoints - while it helps sync things up, it
> > > enlarges high risk window and overall overhead.
> > 
> > No, there should be no point at which a failure leaves the SVM without a checkpoint
> > that it can apply to take over.
> > 
> > > > > > I have quite a few more performance and cleanup patches on my hands,
> > > > > > for example to transfer dirty memory between checkpoints.
> > > > > >   
> > > > > > > 
> > > > > > > IIUC, the critical path of COLO shouldn't be migration on its own?  It
> > > > > > > should be when heartbeat gets lost; that normally should happen when two
> > > > > > > VMs are in sync.  In this path, I don't see how multifd helps..  because
> > > > > > > there's no migration happening, only the src recording what has changed.
> > > > > > > Hence I think some number with description of the measurements may help us
> > > > > > > understand how important multifd is to COLO.
> > > > > > > 
> > > > > > > Supporting multifd will cause new COLO functions to inject into core
> > > > > > > migration code paths (even if not much..). I want to make sure such (new)
> > > > > > > complexity is justified. I also want to avoid introducing a feature only
> > > > > > > because "we have XXX, then let's support XXX in COLO too, maybe some day
> > > > > > > it'll be useful".  
> > > > > > 
> > > > > > What COLO needs from migration at the low level:
> > > > > > 
> > > > > > Primary/Outgoing side:
> > > > > > 
> > > > > > Not much actually, we just need a way to incrementally send the
> > > > > > dirtied memory and the full device state.
> > > > > > Also, we ensure that migration never actually finishes since we will
> > > > > > never do a switchover. For example we never set
> > > > > > RAMState::last_stage with COLO.
> > > > > > 
> > > > > > Secondary/Incoming side:
> > > > > > 
> > > > > > colo cache:
> > > > > > Since the secondary always needs to be ready to take over (even during
> > > > > > checkpointing), we can not write the received ram pages directly to
> > > > > > the guest ram to prevent having half of the old and half of the new
> > > > > > contents.
> > > > > > So we redirect the received ram pages to the colo cache. This is
> > > > > > basically a mirror of the primary side ram.
> > > > > > It also simplifies the primary side since from it's point of view it's
> > > > > > just a normal migration target. So primary side doesn't have to care
> > > > > > about dirtied pages on the secondary for example.
> > > > > > 
> > > > > > Dirty Bitmap:
> > > > > > With COLO we also need a dirty bitmap on the incoming side to track
> > > > > > 1. pages dirtied by the secondary guest
> > > > > > 2. pages dirtied by the primary guest (incoming ram pages)
> > > > > > In the last step during the checkpointing, this bitmap is then used
> > > > > > to overwrite the guest ram with the colo cache so the secondary guest
> > > > > > is in sync with the primary guest.
> > > > > > 
> > > > > > All this individually is very little code as you can see from my
> > > > > > multifd patch. Just something to keep in mind I guess.
> > > > > > 
> > > > > > 
> > > > > > At the high level we have the COLO framework outgoing and incoming
> > > > > > threads which just tell the migration code to:
> > > > > > Send all ram pages (qemu_savevm_live_state()) on the outgoing side
> > > > > > paired with a qemu_loadvm_state_main on the incoming side.
> > > > > > Send the device state (qemu_save_device_state()) paired with writing
> > > > > > that stream to a buffer on the incoming side.
> > > > > > And finally flusing the colo cache and loading the device state on the
> > > > > > incoming side.
> > > > > > 
> > > > > > And of course we coordinate with the colo block replication and
> > > > > > colo-compare.  
> > > > > 
> > > > > Thank you.  Maybe you should generalize some of the explanations and put it
> > > > > into docs/devel/migration/ somewhere.  I think many of them are not
> > > > > mentioned in the doc on how COLO works internally.
> > > > > 
> > > > > Let me ask some more questions while I'm reading COLO today:
> > > > > 
> > > > > - For each of the checkpoint (colo_do_checkpoint_transaction()), COLO will
> > > > >   do the following:
> > > > > 
> > > > >     bql_lock()
> > > > >     vm_stop_force_state(RUN_STATE_COLO)     # stop vm
> > > > >     bql_unlock()
> > > > > 
> > > > >     ...
> > > > >   
> > > > >     bql_lock()
> > > > >     qemu_save_device_state()                # into a temp buffer fb
> > > > >     bql_unlock()
> > > > > 
> > > > >     ...
> > > > > 
> > > > >     qemu_savevm_state_complete_precopy()    # send RAM, directly to the wire
> > > > >     qemu_put_buffer(fb)                     # push temp buffer fb to wire
> > > > > 
> > > > >     ...
> > > > > 
> > > > >     bql_lock()
> > > > >     vm_start()                              # start vm
> > > > >     bql_unlock()
> > > > > 
> > > > >   A few questions that I didn't ask previously:
> > > > > 
> > > > >   - If VM is stopped anyway, why putting the device states into a temp
> > > > >     buffer, instead of using what we already have for precopy phase, or
> > > > >     just push everything directly to the wire?
> > > > 
> > > > Actually we only do that to get the size of the device state and send
> > > > the size out-of-band, since we can not use qemu_load_device_state()
> > > > directly on the secondary side and look for the in-band EOF.
> > > 
> > > I also don't understand why the size is needed..
> > > 
> > > Currently the streaming protocol for COLO is:
> > > 
> > >   - ...
> > >   - COLO_MESSAGE_VMSTATE_SEND
> > >   - RAM data
> > >   - EOF
> > >   - COLO_MESSAGE_VMSTATE_SIZE
> > >   - non-RAM data
> > >   - EOF
> > > 
> > > My question is about, why can't we do this instead?
> > > 
> > >   - ...
> > >   - COLO_MESSAGE_VMSTATE_SEND
> > >   - RAM data
> 
> [1]
> 
> > >   - non-RAM data
> > >   - EOF
> > > 
> > > If the VM is stoppped during the whole process anyway..
> > > 
> > > Here RAM/non-RAM data all are vmstates, and logically can also be loaded in
> > > one shot of a vmstate load loop.
> > 
> > You might be able to; in that case you would have to stream the 
> > entire thing into a buffer on the secondary rather than applying the
> > RAM updates to the colo cache.
> 
> I thought the colo cache is already such a buffering when receiving at [1]
> above?  Then we need to flush the colo cache (including scan the SVM bitmap
> and only flush those pages in colo cache) like before.
> 
> If something went wrong (e.g. channel broken during receiving non-ram
> device states), SVM can directly drop all colo cache as the latest
> checkpoint isn't complete.

Oh, I think I've remembered why it's necessary to split it into RAM and non-RAM;
you can't parse a non-RAM stream and know when you've got an EOF flag in the stream;
especially for stuff that's open coded (like some of virtio);   so there's
no way to write a 'load until EOF' into a simple RAM buffer; you need to be
given an explicit size to know how much to expect.

You could do it for the RAM, but you'd need to write a protocol parser
to follow the stream to watch for the EOF.  It's actuallly harder with multifd;
how would you make a temporary buffer with multiple streams like that?

> > The thought of using userfaultfd-write had floated around at some time
> > as ways to optimise this.
> 
> It's an interesting idea. Yes it looks working, but as Lukas said, it looks
> still unbounded.
> 
> One idea to provide a strict bound:
> 
>   - admin sets a proper buffer to limit the extra pages to remember on SVM,
>     should be much smaller than total guest mem, but admin should make sure
>     in 99.99% cases it won't hit the limit with a proper x-checkpoint-delay,
> 
>   - if limit triggered, both VMs needs to pause (initiated by SVM), SVM
>     needs to explicitly request a checkpoint to src,
> 
>   - VMs can only start again after two VMs sync again

Right, that should be doable with a userfault-write.

Dave

> Thanks,
> 
> -- 
> Peter Xu
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

