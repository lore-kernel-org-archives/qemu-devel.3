Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BA5C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vic3S-00089C-F2; Wed, 21 Jan 2026 12:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vic3P-00088T-FM
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 12:31:40 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vic3N-000097-5Z
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 12:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=tm+himXEqLL5dWYFMmfzW7nYEp5IlR+cSgCVSaNxigM=; b=S06zeUNtymhjDP1j
 AMAnvgIeylfCfUd2syUc29vPJBT69TCS3ybqL+0WqA1pJ8vmlienimS+Invq+u1ca4nXTK3lBHvw+
 Bkd/IxW2SRvSx2dU+mN6w4r+6y8cUdyuL1IVQjq+W9QK5trRbM4XvwafJR207wfTnDnfNuAB8QPu4
 HioeH7AyTfw5HPMZfDz8SHTrf0Y0T0rGVC56bCXGgbpJ00Q0nBlTfWthIQHb8owFIYgFstNUXhFXs
 v6WgoIqJG+fwC0ucu8qzHXJM18Jq29bpztTHA+86hYRlnktatgazmHKDaEjbFML8AjryxuzcruHL+
 K2Ddm03oqUXkVsPLEw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vic3I-0000000GPBr-31ZU;
 Wed, 21 Jan 2026 17:31:32 +0000
Date: Wed, 21 Jan 2026 17:31:32 +0000
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
Message-ID: <aXENdA6DP5j0ETIU@gallifrey>
References: <aWlxY9TWGT1aaMJz@gallifrey> <aWl6ixQpHaMJhV_E@x1.local>
 <20260117204913.584e1829@penguin> <aW6xNcsz3RIqHeE5@x1.local>
 <20260120110811.7df19a6c@penguin> <aW-mCye_eFmy5f4B@x1.local>
 <aW_Rqbc2Swg8vkXY@gallifrey> <aW_ccMSY4xJlRVn2@x1.local>
 <aXArDHMRAohmUt51@gallifrey> <aXEG73I8tJyhpn69@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aXEG73I8tJyhpn69@x1.local>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 17:20:59 up 86 days, 16:57,  3 users,  load average: 0.10, 0.05, 0.01
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
> On Wed, Jan 21, 2026 at 01:25:32AM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > On Tue, Jan 20, 2026 at 07:04:09PM +0000, Dr. David Alan Gilbert wrote:
> > 
> > <snip>
> > 
> > > > >   (2) Failure happens _after_ applying the new checkpoint, but _before_ the
> > > > >       whole checkpoint is applied.
> > > > > 
> > > > >       To be explicit, consider qemu_load_device_state() when the process of
> > > > >       colo_incoming_process_checkpoint() failed.  It means SVM applied
> > > > >       partial of PVM's checkpoint, I think it should mean PVM is completely
> > > > >       corrupted.
> > > > 
> > > > As long as the SVM has got the entire checkpoint, then it *can* apply it all
> > > > and carry on from that point.
> > > 
> > > Does it mean we assert() that qemu_load_device_state() will always success
> > > for COLO syncs?
> > 
> > Not sure; I'd expect if that load fails then the SVM fails; if that happens
> > on a periodic checkpoint then the PVM should carry on.
> 
> Hmm right, if qemu_load_device_state() failed, likely PVM is still alive.
> 
> > 
> > > Logically post_load() can invoke anything and I'm not sure if something can
> > > start to fail, but I confess I don't know an existing device that can
> > > trigger it.
> > 
> > Like a postcopy, it shouldn't fail unless there's an underlying failure
> > (e.g. storage died)
> 
> Postcopy can definitely fail at post_load()..  Actually Juraj just fixed it
> for 10.2 here so postcopy can now fail properly while save/load device
> states (we used to hang):
> 
> https://lore.kernel.org/r/20251103183301.3840862-1-jmarcin@redhat.com

Ah good.

> The two major causes that can fail postcopy vmstate load that I hit (while
> looking at bugs after you left; I wished you are still here!):
> 
> (1) KVM put() failures due to kernel version mismatch, or,
> 
> (2) virtio post_load() failures due to e.g. virtio feature unsupported.
> 
> Both of them fall into "unsupported dest kernel version" realm, though, so
> indeed it may not affect COLO, as I expect COLO should have two hosts to
> run the same kernel.

Right.

> > > Lukas told me something was broken though with pc machine type, on
> > > post_load() not re-entrant.  I think it might be possible though when
> > > post_load() is relevant to some device states (that guest driver can change
> > > between two checkpoint loads), but that's still only theoretical.  So maybe
> > > we can indeed assert it here.
> > 
> > I don't understand that non re-entrant bit?
> 
> It may not be the exact wording, the message is here:
> 
> https://lore.kernel.org/r/20260115233500.26fd1628@penguin
> 
>         There is a bug in the emulated ahci disk controller which crashes
>         when it's vmstate is loaded more than once.
> 
> I was expecting it's a post_load() because normal scalar vmstates should be
> fine to be loaded more than once.  I didn't look deeper.

Oh I see, multiple calls to post-load rather than calling within side each other;
yeh that makes sense - some things aren't expecting that.
But again, you're likely to find that out pretty quickly either way; it's not
something that is made worse by regular checkpointing.

<snip>

> > Oh, I think I've remembered why it's necessary to split it into RAM and non-RAM;
> > you can't parse a non-RAM stream and know when you've got an EOF flag in the stream;
> > especially for stuff that's open coded (like some of virtio);   so there's
> 
> Shouldn't customized get()/put() will at least still be wrapped with a
> QEMU_VM_SECTION_FULL section?

Yes - but the VM_SECTION wrapper doesn't tell you how long the data in the
section is; you have to walk your vmstate structures, decoding the data
(and possibly doing magic get()/put()'s) and at the end hoping
you hit a VMS_END (which I added just to spot screwups in this process).
So there's no way to 'read the whole of a VM_SECTION' - because you don't
know you've hit the end until you've decoded it.
(And some of those get() calls are open coded list storage which are something
like

  do {
      x=get()
      if (x & flag)
        break;

      read more data
  } while (...)

so on those you're really hoping you hit the flag.
I did turn some get()/put()'s into vmstate a while back; but those open
coded loops are really hard, there's a lot of variation.

> > no way to write a 'load until EOF' into a simple RAM buffer; you need to be
> > given an explicit size to know how much to expect.
> > 
> > You could do it for the RAM, but you'd need to write a protocol parser
> > to follow the stream to watch for the EOF.  It's actuallly harder with multifd;
> > how would you make a temporary buffer with multiple streams like that?
> 
> My understanding is postcopy must need a buffer because postcopy needs page
> request to work even during loading vmstates.  I don't see it required for
> COLO, though..

Right that's true for postcopy; but then the only way to load the stream into
that buffer is to load it all at once because of the vmstate problem above.
(and because in the original postcopy we needed the original fd free
for page requests; you might be able to avoid that with multifd now)

> I'll try to see if I can change COLO to use the generic precopy way of
> dumping vmstate, then I'll know if I missed something, and what I've
> missed..

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

