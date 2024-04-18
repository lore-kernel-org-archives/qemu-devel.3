Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699DEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 10:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxPBH-0007L3-4Q; Thu, 18 Apr 2024 06:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxPBE-0007Kd-Fy
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxPBB-0001SV-NB
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713436784;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bzVSN5vmjPewQi2ieeAHpQhqXd7H5/793Aq48dQfis=;
 b=MbSF5Y6+ea7wd6OG9bma6mZxrGIkH7HH4m9tem2Ta1wd7WTAphzFRWBfEpYq+LxeFFuIRM
 RNQzyGsHCH0gJrO0hvwJGdchsBmQY6UyyQ0vp7d7oW71guvKAQWI+y/Gw5lGkY6LAIgnB4
 Opi+PYe5+P8BvJR5raH0MG/A6v9TvKA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-eN-rktZ2PdSemc2QvFwUrg-1; Thu,
 18 Apr 2024 06:39:41 -0400
X-MC-Unique: eN-rktZ2PdSemc2QvFwUrg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE5B21C106A6;
 Thu, 18 Apr 2024 10:39:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B840140005B;
 Thu, 18 Apr 2024 10:39:38 +0000 (UTC)
Date: Thu, 18 Apr 2024 11:39:36 +0100
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
Message-ID: <ZiD4aLSre6qubuHr@redhat.com>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
 <Zh-KF72Fe9oV6tfT@redhat.com>
 <c0b1dbb1-d353-4832-af90-96895b2129fc@maciej.szmigiero.name>
 <Zh_6W8u3H4FmGS49@redhat.com>
 <71ede5c8-857c-418b-9e37-b8d343ddfa06@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71ede5c8-857c-418b-9e37-b8d343ddfa06@maciej.szmigiero.name>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
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

On Thu, Apr 18, 2024 at 11:50:12AM +0200, Maciej S. Szmigiero wrote:
> On 17.04.2024 18:35, Daniel P. Berrangé wrote:
> > On Wed, Apr 17, 2024 at 02:11:37PM +0200, Maciej S. Szmigiero wrote:
> > > On 17.04.2024 10:36, Daniel P. Berrangé wrote:
> > > > On Tue, Apr 16, 2024 at 04:42:39PM +0200, Maciej S. Szmigiero wrote:
> > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > 
> > > > > VFIO device state transfer is currently done via the main migration channel.
> > > > > This means that transfers from multiple VFIO devices are done sequentially
> > > > > and via just a single common migration channel.
> > > > > 
> > > > > Such way of transferring VFIO device state migration data reduces
> > > > > performance and severally impacts the migration downtime (~50%) for VMs
> > > > > that have multiple such devices with large state size - see the test
> > > > > results below.
> > > > > 
> > > > > However, we already have a way to transfer migration data using multiple
> > > > > connections - that's what multifd channels are.
> > > > > 
> > > > > Unfortunately, multifd channels are currently utilized for RAM transfer
> > > > > only.
> > > > > This patch set adds a new framework allowing their use for device state
> > > > > transfer too.
> > > > > 
> > > > > The wire protocol is based on Avihai's x-channel-header patches, which
> > > > > introduce a header for migration channels that allow the migration source
> > > > > to explicitly indicate the migration channel type without having the
> > > > > target deduce the channel type by peeking in the channel's content.
> > > > > 
> > > > > The new wire protocol can be switch on and off via migration.x-channel-header
> > > > > option for compatibility with older QEMU versions and testing.
> > > > > Switching the new wire protocol off also disables device state transfer via
> > > > > multifd channels.
> > > > > 
> > > > > The device state transfer can happen either via the same multifd channels
> > > > > as RAM data is transferred, mixed with RAM data (when
> > > > > migration.x-multifd-channels-device-state is 0) or exclusively via
> > > > > dedicated device state transfer channels (when
> > > > > migration.x-multifd-channels-device-state > 0).
> > > > > 
> > > > > Using dedicated device state transfer multifd channels brings further
> > > > > performance benefits since these channels don't need to participate in
> > > > > the RAM sync process.
> > > > 
> > > > I'm not convinced there's any need to introduce the new "channel header"
> > > > protocol messages. The multifd channels already have an initialization
> > > > message that is extensible to allow extra semantics to be indicated.
> > > > So if we want some of the multifd channels to be reserved for device
> > > > state, we could indicate that via some data in the MultiFDInit_t
> > > > message struct.
> > > 
> > > The reason for introducing x-channel-header was to avoid having to deduce
> > > the channel type by peeking in the channel's content - where any channel
> > > that does not start with QEMU_VM_FILE_MAGIC is currently treated as a
> > > multifd one.
> > > 
> > > But if this isn't desired then, as you say, the multifd channel type can
> > > be indicated by using some unused field of the MultiFDInit_t message.
> > > 
> > > Of course, this would still keep the QEMU_VM_FILE_MAGIC heuristic then.
> > 
> > I don't like the heuristics we currently have, and would to have
> > a better solution. What makes me cautious is that this proposal
> > is a protocol change, but only addressing one very narrow problem
> > with the migration protocol.
> > 
> > I'd like migration to see a more explicit bi-directional protocol
> > negotiation message set, where both QEMU can auto-negotiate amongst
> > themselves many of the features that currently require tedious
> > manual configuration by mgmt apps via migrate parameters/capabilities.
> > That would address the problem you describe here, and so much more.
> 
> Isn't the capability negotiation handled automatically by libvirt
> today?
> I guess you'd prefer for QEMU to internally handle it instead?

Yes, it would be much saner if QEMU handled it automatically as
part of its own protocol handshake. This avoids the need to change
libvirt to enable new functionality in the migration protocol in
many (but not all) cases, and thus speed up development and deployment
of new features.

Libvirt should really only need to be changed to support runtime
performance tunables, rather than migration protocol features.

> > > > That said, the idea of reserving channels specifically for VFIO doesn't
> > > > make a whole lot of sense to me either.
> > > > 
> > > > Once we've done the RAM transfer, and are in the switchover phase
> > > > doing device state transfer, all the multifd channels are idle.
> > > > We should just use all those channels to transfer the device state,
> > > > in parallel.  Reserving channels just guarantees many idle channels
> > > > during RAM transfer, and further idle channels during vmstate
> > > > transfer.
> > > > 
> > > > IMHO it is more flexible to just use all available multifd channel
> > > > resources all the time.
> > > 
> > > The reason for having dedicated device state channels is that they
> > > provide lower downtime in my tests.
> > > 
> > > With either 15 or 11 mixed multifd channels (no dedicated device state
> > > channels) I get a downtime of about 1250 msec.
> > > 
> > > Comparing that with 15 total multifd channels / 4 dedicated device
> > > state channels that give downtime of about 1100 ms it means that using
> > > dedicated channels gets about 14% downtime improvement.
> > 
> > Hmm, can you clarify. /when/ is the VFIO vmstate transfer taking
> > place ? Is is transferred concurrently with the RAM ? I had thought
> > this series still has the RAM transfer iterations running first,
> > and then the VFIO VMstate at the end, simply making use of multifd
> > channels for parallelism of the end phase. your reply though makes
> > me question my interpretation though.
> > 
> > Let me try to illustrate channel flow in various scenarios, time
> > flowing left to right:
> > 
> > 1. serialized RAM, then serialized VM state  (ie historical migration)
> > 
> >        main: | Init | RAM iter 1 | RAM iter 2 | ... | RAM iter N | VM State |
> > 
> > 
> > 2. parallel RAM, then serialized VM state (ie today's multifd)
> > 
> >        main: | Init |                                            | VM state |
> >    multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> >    multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> >    multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > 
> > 
> > 3. parallel RAM, then parallel VM state
> > 
> >        main: | Init |                                            | VM state |
> >    multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> >    multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> >    multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> >    multifd4:                                                     | VFIO VM state |
> >    multifd5:                                                     | VFIO VM state |
> > 
> > 
> > 4. parallel RAM and VFIO VM state, then remaining VM state
> > 
> >        main: | Init |                                            | VM state |
> >    multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> >    multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> >    multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> >    multifd4:        | VFIO VM state                                         |
> >    multifd5:        | VFIO VM state                                         |
> > 
> > 
> > I thought this series was implementing approx (3), but are you actually
> > implementing (4), or something else entirely ?
> 
> You are right that this series operation is approximately implementing
> the schema described as numer 3 in your diagrams.

> However, there are some additional details worth mentioning:
> * There's some but relatively small amount of VFIO data being
> transferred from the "save_live_iterate" SaveVMHandler while the VM is
> still running.
> 
> This is still happening via the main migration channel.
> Parallelizing this transfer in the future might make sense too,
> although obviously this doesn't impact the downtime.
> 
> * After the VM is stopped and downtime starts the main (~ 400 MiB)
> VFIO device state gets transferred via multifd channels.
> 
> However, these multifd channels (if they are not dedicated to device
> state transfer) aren't idle during that time.
> Rather they seem to be transferring the residual RAM data.
> 
> That's most likely what causes the additional observed downtime
> when dedicated device state transfer multifd channels aren't used.

Ahh yes, I forgot about the residual dirty RAM, that makes sense as
an explanation. Allow me to work through the scenarios though, as I
still think my suggestion to not have separate dedicate channels is
better....


Lets say hypothetically we have an existing deployment today that
uses 6 multifd channels for RAM. ie:
 
        main: | Init |                                            | VM state |
    multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd5:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd6:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |

That value of 6 was chosen because that corresponds to the amount
of network & CPU utilization the admin wants to allow, for this
VM to migrate. All 6 channels are fully utilized at all times.


If we now want to parallelize VFIO VM state, the peak network
and CPU utilization the admin wants to reserve for the VM should
not change. Thus the admin will still wants to configure only 6
channels total.

With your proposal the admin has to reduce RAM transfer to 4 of the
channels, in order to then reserve 2 channels for VFIO VM state, so we
get a flow like:

 
        main: | Init |                                            | VM state |
    multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd5:                                                     | VFIO VM state |
    multifd6:                                                     | VFIO VM state |

This is bad, as it reduces performance of RAM transfer. VFIO VM
state transfer is better, but that's not a net win overall.



So lets say the admin was happy to increase the number of multifd
channels from 6 to 8.

This series proposes that they would leave RAM using 6 channels as
before, and now reserve the 2 extra ones for VFIO VM state:

        main: | Init |                                            | VM state |
    multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd5:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd6:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
    multifd7:                                                     | VFIO VM state |
    multifd8:                                                     | VFIO VM state |


RAM would perform as well as it did historically, and VM state would
improve due to the 2 parallel channels, and not competing with the
residual RAM transfer.

This is what your latency comparison numbers show as a benefit for
this channel reservation design.

I believe this comparison is inappropriate / unfair though, as it is
comparing a situation with 6 total channels against a situation with
8 total channels.

If the admin was happy to increase the total channels to 8, then they
should allow RAM to use all 8 channels, and then VFIO VM state +
residual RAM to also use the very same set of 8 channels:

        main: | Init |                                            | VM state |
    multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
    multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
    multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
    multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
    multifd5:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
    multifd6:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
    multifd7:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
    multifd8:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|

This will speed up initial RAM iters still further & the final switch
over phase even more. If residual RAM is larger than VFIO VM state,
then it will dominate the switchover latency, so having VFIO VM state
compete is not a problem. If VFIO VM state is larger than residual RAM,
then allowing it acces to all 8 channels instead of only 2 channels
will be a clear win.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


