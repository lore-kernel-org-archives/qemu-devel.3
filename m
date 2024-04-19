Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC8DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 10:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxlLz-0003VU-52; Fri, 19 Apr 2024 06:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxlLw-0003UH-8O
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxlLt-0006yT-Nb
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713522016;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esdjpP/6ZIZCUdYlGWi+u+iN74GkIVJE91Tt0svDOvY=;
 b=L3K+9lo3Ftj1xQT2iZgEF3VwQt6RL53HBqws8bOkLzgL+5BFzHRKMcHoql22Lqe8xX2PW7
 3toOBRdrqddm91JJQSpSKisjuHoOXN+80/SlZPvhUlxEOdd5plWemh7p6CseJ52Vdum5d7
 EZsBiicEIgTFefVoSuEseih7GyLXvXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-Sudp4MP_OdyyhBWrZ9KlOQ-1; Fri, 19 Apr 2024 06:20:13 -0400
X-MC-Unique: Sudp4MP_OdyyhBWrZ9KlOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27A56803CA4;
 Fri, 19 Apr 2024 10:20:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EC772166B32;
 Fri, 19 Apr 2024 10:20:05 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:20:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 00/26] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <ZiJFU_QrOHVvwe4W@redhat.com>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
 <Zh-KF72Fe9oV6tfT@redhat.com>
 <c0b1dbb1-d353-4832-af90-96895b2129fc@maciej.szmigiero.name>
 <Zh_6W8u3H4FmGS49@redhat.com>
 <71ede5c8-857c-418b-9e37-b8d343ddfa06@maciej.szmigiero.name>
 <ZiD4aLSre6qubuHr@redhat.com>
 <aebcd78e-b8b6-44db-b2be-0bbd5acccf3f@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aebcd78e-b8b6-44db-b2be-0bbd5acccf3f@maciej.szmigiero.name>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 18, 2024 at 08:14:15PM +0200, Maciej S. Szmigiero wrote:
> On 18.04.2024 12:39, Daniel P. Berrangé wrote:
> > On Thu, Apr 18, 2024 at 11:50:12AM +0200, Maciej S. Szmigiero wrote:
> > > On 17.04.2024 18:35, Daniel P. Berrangé wrote:
> > > > On Wed, Apr 17, 2024 at 02:11:37PM +0200, Maciej S. Szmigiero wrote:
> > > > > On 17.04.2024 10:36, Daniel P. Berrangé wrote:
> > > > > > On Tue, Apr 16, 2024 at 04:42:39PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> (..)
> > > > > > That said, the idea of reserving channels specifically for VFIO doesn't
> > > > > > make a whole lot of sense to me either.
> > > > > > 
> > > > > > Once we've done the RAM transfer, and are in the switchover phase
> > > > > > doing device state transfer, all the multifd channels are idle.
> > > > > > We should just use all those channels to transfer the device state,
> > > > > > in parallel.  Reserving channels just guarantees many idle channels
> > > > > > during RAM transfer, and further idle channels during vmstate
> > > > > > transfer.
> > > > > > 
> > > > > > IMHO it is more flexible to just use all available multifd channel
> > > > > > resources all the time.
> > > > > 
> > > > > The reason for having dedicated device state channels is that they
> > > > > provide lower downtime in my tests.
> > > > > 
> > > > > With either 15 or 11 mixed multifd channels (no dedicated device state
> > > > > channels) I get a downtime of about 1250 msec.
> > > > > 
> > > > > Comparing that with 15 total multifd channels / 4 dedicated device
> > > > > state channels that give downtime of about 1100 ms it means that using
> > > > > dedicated channels gets about 14% downtime improvement.
> > > > 
> > > > Hmm, can you clarify. /when/ is the VFIO vmstate transfer taking
> > > > place ? Is is transferred concurrently with the RAM ? I had thought
> > > > this series still has the RAM transfer iterations running first,
> > > > and then the VFIO VMstate at the end, simply making use of multifd
> > > > channels for parallelism of the end phase. your reply though makes
> > > > me question my interpretation though.
> > > > 
> > > > Let me try to illustrate channel flow in various scenarios, time
> > > > flowing left to right:
> > > > 
> > > > 1. serialized RAM, then serialized VM state  (ie historical migration)
> > > > 
> > > >         main: | Init | RAM iter 1 | RAM iter 2 | ... | RAM iter N | VM State |
> > > > 
> > > > 
> > > > 2. parallel RAM, then serialized VM state (ie today's multifd)
> > > > 
> > > >         main: | Init |                                            | VM state |
> > > >     multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > > 
> > > > 
> > > > 3. parallel RAM, then parallel VM state
> > > > 
> > > >         main: | Init |                                            | VM state |
> > > >     multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd4:                                                     | VFIO VM state |
> > > >     multifd5:                                                     | VFIO VM state |
> > > > 
> > > > 
> > > > 4. parallel RAM and VFIO VM state, then remaining VM state
> > > > 
> > > >         main: | Init |                                            | VM state |
> > > >     multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd4:        | VFIO VM state                                         |
> > > >     multifd5:        | VFIO VM state                                         |
> > > > 
> > > > 
> > > > I thought this series was implementing approx (3), but are you actually
> > > > implementing (4), or something else entirely ?
> > > 
> > > You are right that this series operation is approximately implementing
> > > the schema described as numer 3 in your diagrams.
> > 
> > > However, there are some additional details worth mentioning:
> > > * There's some but relatively small amount of VFIO data being
> > > transferred from the "save_live_iterate" SaveVMHandler while the VM is
> > > still running.
> > > 
> > > This is still happening via the main migration channel.
> > > Parallelizing this transfer in the future might make sense too,
> > > although obviously this doesn't impact the downtime.
> > > 
> > > * After the VM is stopped and downtime starts the main (~ 400 MiB)
> > > VFIO device state gets transferred via multifd channels.
> > > 
> > > However, these multifd channels (if they are not dedicated to device
> > > state transfer) aren't idle during that time.
> > > Rather they seem to be transferring the residual RAM data.
> > > 
> > > That's most likely what causes the additional observed downtime
> > > when dedicated device state transfer multifd channels aren't used.
> > 
> > Ahh yes, I forgot about the residual dirty RAM, that makes sense as
> > an explanation. Allow me to work through the scenarios though, as I
> > still think my suggestion to not have separate dedicate channels is
> > better....
> > 
> > 
> > Lets say hypothetically we have an existing deployment today that
> > uses 6 multifd channels for RAM. ie:
> >          main: | Init |                                            | VM state |
> >      multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd5:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd6:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> > 
> > That value of 6 was chosen because that corresponds to the amount
> > of network & CPU utilization the admin wants to allow, for this
> > VM to migrate. All 6 channels are fully utilized at all times.
> > 
> > 
> > If we now want to parallelize VFIO VM state, the peak network
> > and CPU utilization the admin wants to reserve for the VM should
> > not change. Thus the admin will still wants to configure only 6
> > channels total.
> > 
> > With your proposal the admin has to reduce RAM transfer to 4 of the
> > channels, in order to then reserve 2 channels for VFIO VM state, so we
> > get a flow like:
> > 
> >          main: | Init |                                            | VM state |
> >      multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd5:                                                     | VFIO VM state |
> >      multifd6:                                                     | VFIO VM state |
> > 
> > This is bad, as it reduces performance of RAM transfer. VFIO VM
> > state transfer is better, but that's not a net win overall.
> > 
> > 
> > 
> > So lets say the admin was happy to increase the number of multifd
> > channels from 6 to 8.
> > 
> > This series proposes that they would leave RAM using 6 channels as
> > before, and now reserve the 2 extra ones for VFIO VM state:
> > 
> >          main: | Init |                                            | VM state |
> >      multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd5:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd6:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd7:                                                     | VFIO VM state |
> >      multifd8:                                                     | VFIO VM state |
> > 
> > 
> > RAM would perform as well as it did historically, and VM state would
> > improve due to the 2 parallel channels, and not competing with the
> > residual RAM transfer.
> > 
> > This is what your latency comparison numbers show as a benefit for
> > this channel reservation design.
> > 
> > I believe this comparison is inappropriate / unfair though, as it is
> > comparing a situation with 6 total channels against a situation with
> > 8 total channels.
> > 
> > If the admin was happy to increase the total channels to 8, then they
> > should allow RAM to use all 8 channels, and then VFIO VM state +
> > residual RAM to also use the very same set of 8 channels:
> > 
> >          main: | Init |                                            | VM state |
> >      multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd5:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd6:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd7:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd8:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> > 
> > This will speed up initial RAM iters still further & the final switch
> > over phase even more. If residual RAM is larger than VFIO VM state,
> > then it will dominate the switchover latency, so having VFIO VM state
> > compete is not a problem. If VFIO VM state is larger than residual RAM,
> > then allowing it acces to all 8 channels instead of only 2 channels
> > will be a clear win.
> 
> I re-did the measurement with increased the number of multifd channels,
> first to (total count/dedicated count) 25/0, then to 100/0.
> 
> The results did not improve:
> With 25/0 multifd mixed channels config I still get around 1250 msec
> downtime - the same as with 15/0 or 11/0 mixed configs I measured
> earlier.
> 
> But with the (pretty insane) 100/0 mixed channel config the whole setup
> gets so for into the law of diminishing returns that the results actually
> get worse: the downtime is now about 1450 msec.
> I guess that's from all the extra overhead from switching between 100
> multifd channels.
> 
> I think one of the reasons for these results is that mixed (RAM + device
> state) multifd channels participate in the RAM sync process
> (MULTIFD_FLAG_SYNC) whereas device state dedicated channels don't.

Hmm, I wouldn't have expected the sync packets to have a signicant
overhead on the wire. Looking at the code though I guess the issue
is that we're blocking I/O in /all/ threads, until all threads have
seen the sync packet.

eg in multifd_recv_sync_main

    for (i = 0; i < thread_count; i++) {

        qemu_sem_wait(&multifd_recv_state->sem_sync);
    }

    for (i = 0; i < thread_count; i++) {
        qemu_sem_post(&p->sem_sync);
    }

and then in the recv thread is 

    qemu_sem_post(&multifd_recv_state->sem_sync);
    qemu_sem_wait(&p->sem_sync);

so if any 1 of the recv threads is slow to recv the sync packet on
the wire, then its qemu_sem_post is delayed, and all other recv
threads are kept idle until the sync packet arrives.

I'm not sure how much this all matters during the final switchover
phase though. We send syncs at the end of each iteration, and then
after sending the residual RAM. I'm not sure how that orders wrt
sending of the parallel VFIO state

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


