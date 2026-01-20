Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981A9CA5FA3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 15:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viE7W-0005wi-Vr; Tue, 20 Jan 2026 10:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viE7U-0005w3-DM
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:58:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viE7R-0004Ot-NR
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768924690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0I9SD6OSw84hii5Rhrh4Oi/VeF63v7ktb7loYV31rW0=;
 b=dRfI1SC6nF7rv/bmvGtPKoSG/Ga74ROddKkWi6ZqP0isa1M6gNmbzH4afUGKTegKZvuYP8
 rgH8v0t3VB4q2VtByOFO5l9H4B324q/5KMk1m4E9vBu3ve3R7mP3S4VYk7STCPAtf+Z4W0
 vf9QtiWO1HBQ31Xu0ZubF1/y3iPZBMY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-AGo2tVbsPHiuoTF1p3PuJw-1; Tue, 20 Jan 2026 10:58:07 -0500
X-MC-Unique: AGo2tVbsPHiuoTF1p3PuJw-1
X-Mimecast-MFC-AGG-ID: AGo2tVbsPHiuoTF1p3PuJw_1768924686
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c6a291e7faso836104885a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 07:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768924686; x=1769529486; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0I9SD6OSw84hii5Rhrh4Oi/VeF63v7ktb7loYV31rW0=;
 b=s4VapcTbji0gcHmW45gm7meUVG/YULmNnpkZ4xw/FxlpcCahQLxAeCfMT/gEKJ0wzT
 e2qeEJ0Zz4ov5w1iqM8WeuGWuIszqz0aZnM59lUjtctq4hM4gqvHbmsn4Laq+3pXVjv3
 Gw5fGmJqoxIzMcBwlyAWmQE9gZcZDbvkBakLPQpOaxSUHVf/JPMVYuEwBZylAjQ+xa6e
 9XePQp1DQIK0FR+fs3VO39vmhirL6KjQxS/FSr9w6Ehf2K+Dbtor6aI+xlckkw9DYhfM
 Tp2DurJWvwYF1Urd/ctusn1GHTtkpCXPaKTpkiFecInfHl1MavNvGmHd8g34bWsS2jUQ
 NOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768924686; x=1769529486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0I9SD6OSw84hii5Rhrh4Oi/VeF63v7ktb7loYV31rW0=;
 b=rlc/b3nEDQqAwLS4QTt9aBOaQqIrys4UhSlOTOPkar9J/6VV071Y3PEoXrrJRvsQRN
 8QxwqA9vPMfHwPOrMJhjy0RkeYpgt2qI/xSzmbaOKS5L3GFgTZJA0RileLeH0S/NbRf3
 fpVCzeUTJKXSMP8sMjdSkbaIp43wmBWiC7/E2SStHwZpFv8AWijuNeXGRVC3Z5KIQ2ri
 qOQk1T23RV2sp76QUxkAQw6pza96ym2pYziLIRCa7toWyCPaDKCdKi+FOUlQfcjNDsbs
 uX8vG1HiperGH8saQ3JQTgbEwRJXw2KM1LNlDSOkO0fKyLRWvPRzp4kRT8BCfAVh7H4d
 erdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQcHa2lDgyASqlgMxdpz9XLtG6+6/NNhbg6778prSqk8ifeR5qKKVepUFCLg/V6e2l5jEH1Y5fnDNq@nongnu.org
X-Gm-Message-State: AOJu0YyIorM6LQ5BQvC33PKHWq5zC9KuSNpuxSSg/1YA/R/OI3Cpbe6R
 K8qkjLOWv60AbBELW0ry3k1RoyJYz/H9t21hPEt63ptVrUV/EYKrutpEj5ckwdOpepoVyc7rxs7
 CwoH8FyOossOHUR8sZKNYFAT9/L3ln/2xVoWS6sq+kt3QZ7QcTdgZRKqh
X-Gm-Gg: AY/fxX7vxz+OVO0KwAudO4AyVY6s6M0uo9B5t9UE1nOfCk8WIhD11lmZUhFDAsbTDNq
 DVzIzozNInqrBysByg804SORtmjWV5bPuIc7JD+CPTBHDDCRa1Xj+fVOOYXGh32d++B6tLHDwGX
 gxLBIH+Ar/qbMLzx8A4ta0ABIOGk9WOsTrlyVpNRMo4pqBOhpJbWO5MYJilQwCXiceQpXWkt7Nd
 2PDkqn9uCmOqwMORZSIWYjaiGl7Lw9oWVIbn9o0TbBVgeW0UjcEZdlDNNGwBKXFEmeEk40faAWI
 mgygZE/s5t/lGr5eJ+qYOA3fLPE65Gf0f5j3a0upvDvNZAJgcgCH823EpVhWOeldQDN3ClI/RqC
 47J0=
X-Received: by 2002:a05:620a:4706:b0:8c6:afac:808e with SMTP id
 af79cd13be357-8c6afac8203mr1597808985a.60.1768924686265; 
 Tue, 20 Jan 2026 07:58:06 -0800 (PST)
X-Received: by 2002:a05:620a:4706:b0:8c6:afac:808e with SMTP id
 af79cd13be357-8c6afac8203mr1597805185a.60.1768924685645; 
 Tue, 20 Jan 2026 07:58:05 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a71c149esm1043935985a.18.2026.01.20.07.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 07:58:05 -0800 (PST)
Date: Tue, 20 Jan 2026 10:58:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aW-mCye_eFmy5f4B@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
 <aWl6ixQpHaMJhV_E@x1.local> <20260117204913.584e1829@penguin>
 <aW6xNcsz3RIqHeE5@x1.local> <20260120110811.7df19a6c@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120110811.7df19a6c@penguin>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 20, 2026 at 12:48:47PM +0100, Lukas Straub wrote:
> On Mon, 19 Jan 2026 17:33:25 -0500
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Sat, Jan 17, 2026 at 08:49:13PM +0100, Lukas Straub wrote:
> > > On Thu, 15 Jan 2026 18:38:51 -0500
> > > Peter Xu <peterx@redhat.com> wrote:
> > >   
> > > > On Thu, Jan 15, 2026 at 10:59:47PM +0000, Dr. David Alan Gilbert wrote:  
> > > > > * Peter Xu (peterx@redhat.com) wrote:    
> > > > > > On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:    
> > > > > > > Nack.
> > > > > > > 
> > > > > > > This code has users, as explained in my other email:
> > > > > > > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc99839451d6841366619c4ec0d5af5264e2f6464    
> > > > > > 
> > > > > > Please then rework that series and consider include the following (I
> > > > > > believe I pointed out a long time ago somewhere..):
> > > > > >     
> > > > >     
> > > > > > - Some form of justification of why multifd needs to be enabled for COLO.
> > > > > >   For example, in your cluster deployment, using multifd can improve XXX
> > > > > >   by YYY.  Please describe the use case and improvements.    
> > > > > 
> > > > > That one is pretty easy; since COLO is regularly taking snapshots, the faster
> > > > > the snapshoting the less overhead there is.    
> > > > 
> > > > Thanks for chiming in, Dave.  I can explain why I want to request for some
> > > > numbers.
> > > > 
> > > > Firstly, numbers normally proves it's used in a real system.  It's at least
> > > > being used and seriously tested.
> > > > 
> > > > Secondly, per my very limited understanding to COLO... the two VMs in most
> > > > cases should be in-sync state already when both sides generate the same
> > > > network packets.
> > > > 
> > > > Another sync (where multifd can start to take effect) is only needed when
> > > > there're packets misalignments, but IIUC it should be rare.  I don't know
> > > > how rare it is, it would be good if Lukas could introduce some of those
> > > > numbers in his deployment to help us understand COLO better if we'll need
> > > > to keep it.  
> > > 
> > > It really depends on the workload and if you want to tune for
> > > throughput or latency.  
> > 
> > Thanks for all the answers from all of you.
> > 
> > If we decide to keep COLO, looks like I'll have no choice but understand it
> > better, as long as it still has anything to do with migration..  I'll leave
> > some more questions / comments at the end.
> > 
> > > 
> > > You need to do a checkpoint eventually and the more time passes between
> > > checkpoints the more dirty memory you have to transfer during the
> > > checkpoint.
> > > 
> > > Also keep in mind that the guest is stopped during checkpoints. Because
> > > even if we continue running the guest, we can not release the mismatched
> > > packets since that would expose a state of the guest to the outside
> > > world that is not yet replicated to the secondary.  
> > 
> > Yes this makes sense.  However it is also the very confusing part of COLO.
> > 
> > When I said "I was expecting migration to not be the hot path", one reason
> > is I believe COLO checkpoint (or say, when migration happens) will
> > introduce a larger downtime than normal migration, because this process
> > transfers RAM with both VMs stopped.
> > 
> > You helped explain why that large downtime is needed, thanks.  However then
> > it means either (1) packet misalignment, or (2) periodical timer kickoff,
> > either of them will kickoff checkpoint..
> 
> Yes, it could be optimized so we don't stop the guest for the periodical
> checkpoints.

Likely we must stop it at least to savevm on non-rams.  But I get your
point.  Yes, I think it might be good idea to try to keep in sync even
without an explicit checkpoint request, almost like what live precopy does
with RAM to shrink the downtime.

> 
> > 
> > I don't know if COLO services care about such relatively large downtime,
> > especially it is not happening once, but periodically for every tens of
> > seconds at least (assuming when periodically then packet misalignment is
> > rare).
> > 
> 
> If you want to tune for latency you go for like 500ms checkpoint
> interval.
> 
> 
> The alternative way to do fault tolerance is micro checkpointing where
> only the primary guest runs while you buffer all sent packets. Then
> every checkpoint you transfer all ram and device state to the secondary
> and only then release all network packets.
> So in this approach every packet is delayed by checkpoint interval +
> checkpoint downtime and you use a checkpoint interval of like 30-100ms.
> 
> Obviously, COLO is a much better approach because only few packets
> observe a delay.
> 
> > > 
> > > So the migration performance is actually the most important part in
> > > COLO to keep the checkpoints as short as possible.  
> > 
> > IIUC when a heartbeat will be lost on PVM _during_ sync checkpoints, then
> > SVM can only rollback to the last time checkpoint.  Would this be good
> > enough in reality?  It means if there's a TCP transaction then it may broke
> > anyway.  x-checkpoint-delay / periodic checkpoints definitely make this
> > more possible to happen.
> 
> We only release the mismatched packets after the ram and device state
> is fully sent to the secondary. Because then the secondary is in the
> state that generated these mismatched packets and can take over.

My question was more about how COLO failover works (or work at all?) if a
failure happens exactly during checkpointing (aka, migration happening).

First of all, if the failure happens on SVM, IIUC it's not a problem,
because PVM has all the latest data.

The problem lies more in the case where the failure happened in PVM. In
this case, SVM only contains the previous checkpoint results, maybe plus
something on top of that snapshot, as SVM kept running after the previous
checkpoint.

So the failure can happen at different spots:

  (1) Failure happens _before_ applying the new checkpoint, that is, while
      receiving the checkpoint from src and for example the PVM host is
      down, channel shutdown.

      This one looks "okay", IIUC what will happen is SVM will keep running
      but then as I described above it only contains the previous version
      of the PVM snapshot, plus something SVM updated which may not match
      with PVM's data:

           (1.a) if checkpoint triggered because of x-checkpoint-delay,
           lower risk, possibly still in sync with src

           (1.b) if checkpoint triggered by colo-compare notification of
           packet misalignment, I believe this may cause service
           interruptions and it means SVM will not be able to competely
           replace SVM in some cases.

  (2) Failure happens _after_ applying the new checkpoint, but _before_ the
      whole checkpoint is applied.

      To be explicit, consider qemu_load_device_state() when the process of
      colo_incoming_process_checkpoint() failed.  It means SVM applied
      partial of PVM's checkpoint, I think it should mean PVM is completely
      corrupted.

Here either (1.b) or (2) seems fatal to me on the whole high level design.
Periodical syncs with x-checkpoint-delay can make this easier to happen, so
larger windows of critical failures.  That's also why I think it's
confusing COLO prefers more checkpoints - while it helps sync things up, it
enlarges high risk window and overall overhead.

> 
> > 
> > > 
> > > I have quite a few more performance and cleanup patches on my hands,
> > > for example to transfer dirty memory between checkpoints.
> > >   
> > > > 
> > > > IIUC, the critical path of COLO shouldn't be migration on its own?  It
> > > > should be when heartbeat gets lost; that normally should happen when two
> > > > VMs are in sync.  In this path, I don't see how multifd helps..  because
> > > > there's no migration happening, only the src recording what has changed.
> > > > Hence I think some number with description of the measurements may help us
> > > > understand how important multifd is to COLO.
> > > > 
> > > > Supporting multifd will cause new COLO functions to inject into core
> > > > migration code paths (even if not much..). I want to make sure such (new)
> > > > complexity is justified. I also want to avoid introducing a feature only
> > > > because "we have XXX, then let's support XXX in COLO too, maybe some day
> > > > it'll be useful".  
> > > 
> > > What COLO needs from migration at the low level:
> > > 
> > > Primary/Outgoing side:
> > > 
> > > Not much actually, we just need a way to incrementally send the
> > > dirtied memory and the full device state.
> > > Also, we ensure that migration never actually finishes since we will
> > > never do a switchover. For example we never set
> > > RAMState::last_stage with COLO.
> > > 
> > > Secondary/Incoming side:
> > > 
> > > colo cache:
> > > Since the secondary always needs to be ready to take over (even during
> > > checkpointing), we can not write the received ram pages directly to
> > > the guest ram to prevent having half of the old and half of the new
> > > contents.
> > > So we redirect the received ram pages to the colo cache. This is
> > > basically a mirror of the primary side ram.
> > > It also simplifies the primary side since from it's point of view it's
> > > just a normal migration target. So primary side doesn't have to care
> > > about dirtied pages on the secondary for example.
> > > 
> > > Dirty Bitmap:
> > > With COLO we also need a dirty bitmap on the incoming side to track
> > > 1. pages dirtied by the secondary guest
> > > 2. pages dirtied by the primary guest (incoming ram pages)
> > > In the last step during the checkpointing, this bitmap is then used
> > > to overwrite the guest ram with the colo cache so the secondary guest
> > > is in sync with the primary guest.
> > > 
> > > All this individually is very little code as you can see from my
> > > multifd patch. Just something to keep in mind I guess.
> > > 
> > > 
> > > At the high level we have the COLO framework outgoing and incoming
> > > threads which just tell the migration code to:
> > > Send all ram pages (qemu_savevm_live_state()) on the outgoing side
> > > paired with a qemu_loadvm_state_main on the incoming side.
> > > Send the device state (qemu_save_device_state()) paired with writing
> > > that stream to a buffer on the incoming side.
> > > And finally flusing the colo cache and loading the device state on the
> > > incoming side.
> > > 
> > > And of course we coordinate with the colo block replication and
> > > colo-compare.  
> > 
> > Thank you.  Maybe you should generalize some of the explanations and put it
> > into docs/devel/migration/ somewhere.  I think many of them are not
> > mentioned in the doc on how COLO works internally.
> > 
> > Let me ask some more questions while I'm reading COLO today:
> > 
> > - For each of the checkpoint (colo_do_checkpoint_transaction()), COLO will
> >   do the following:
> > 
> >     bql_lock()
> >     vm_stop_force_state(RUN_STATE_COLO)     # stop vm
> >     bql_unlock()
> > 
> >     ...
> >   
> >     bql_lock()
> >     qemu_save_device_state()                # into a temp buffer fb
> >     bql_unlock()
> > 
> >     ...
> > 
> >     qemu_savevm_state_complete_precopy()    # send RAM, directly to the wire
> >     qemu_put_buffer(fb)                     # push temp buffer fb to wire
> > 
> >     ...
> > 
> >     bql_lock()
> >     vm_start()                              # start vm
> >     bql_unlock()
> > 
> >   A few questions that I didn't ask previously:
> > 
> >   - If VM is stopped anyway, why putting the device states into a temp
> >     buffer, instead of using what we already have for precopy phase, or
> >     just push everything directly to the wire?
> 
> Actually we only do that to get the size of the device state and send
> the size out-of-band, since we can not use qemu_load_device_state()
> directly on the secondary side and look for the in-band EOF.

I also don't understand why the size is needed..

Currently the streaming protocol for COLO is:

  - ...
  - COLO_MESSAGE_VMSTATE_SEND
  - RAM data
  - EOF
  - COLO_MESSAGE_VMSTATE_SIZE
  - non-RAM data
  - EOF

My question is about, why can't we do this instead?

  - ...
  - COLO_MESSAGE_VMSTATE_SEND
  - RAM data
  - non-RAM data
  - EOF

If the VM is stoppped during the whole process anyway..

Here RAM/non-RAM data all are vmstates, and logically can also be loaded in
one shot of a vmstate load loop.

> 
> > 
> >   - Above operation frequently releases BQL, why is it needed?  What
> >     happens if (within the window where BQL released) someone invoked QMP
> >     command "cont" and causing VM to start? Would COLO be broken with it?
> >     Should we take BQL for the whole process to avoid it?
> 
> We need to release the BQL because block replication on the secondary side and
> colo-compare and netfilters on the primary side need the main loop to
> make progress.

Do we need it to make progress before vm_start(), though?  If we take BQL
once and release it once only after vm_start(), would it work?

I didn't see anything being checked in colo_do_checkpoint_transaction(),
after vm_stop() + replication_do_checkpoint_all(), and before vm_start()..

> 
> Issuing a cont during a checkpoint will probably break it yes.

Feel free to send a patch if you think it's a concern.  Ok to me even if
without, if mgmt has full control of it, so I'll leave it to you to decide
as I'm not a colo user after all.

> 
> > 
> > - Does colo_cache has an limitation, or should we expect SVM to double
> >   consume the guest RAM size?  As I didn't see where colo_cache will be
> >   released during each sync (e.g. after colo_flush_ram_cache).  I am
> >   expecting over time SVM will have most of the pages touched, then the
> >   colo_cache can consume the same as guest mem on SVM.
> 
> Yes, the secondary side consumes twice the guest ram size. That is one
> disadvantage of this approach.
> 
> I guess we could do some kind of copy on write mapping for the
> secondary guest ram. But even then it's hard to make the ram overhead
> bounded in size.

It's ok, though this sounds also like something good to be documented, it's
a very high level knowledge an user should know when considering COLO as an
HA solution.

Thanks,

-- 
Peter Xu


