Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9922C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 16:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx8GJ-00062P-Tj; Wed, 17 Apr 2024 12:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx8GI-00062E-F5
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 12:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx8GG-0006v0-Ad
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 12:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713371751;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y6kts7pxXXJAKfkRga6NVJ659tLDFnKhg38vz87u35c=;
 b=b9BbYdAHA1LUlPxSycporvGy3utCo3BiQ9ix3gnQkYbXZUzIxVP1O5lvsl18pF/d/njoQ/
 sC7/vOL1bEhbeT2co5Q82Oh7vcKxxyG0Lu0UUTiMCsm26dkQZKeA2kW4WDU1XGt/ajGZrO
 ylqZvpjCbk3leE6FMaCUIuV6b0WAzsw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-Z_c9xQRcPUui7VmV1HqwUQ-1; Wed,
 17 Apr 2024 12:35:48 -0400
X-MC-Unique: Z_c9xQRcPUui7VmV1HqwUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1A1D3C23FC3;
 Wed, 17 Apr 2024 16:35:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7170E1121312;
 Wed, 17 Apr 2024 16:35:45 +0000 (UTC)
Date: Wed, 17 Apr 2024 17:35:39 +0100
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
Message-ID: <Zh_6W8u3H4FmGS49@redhat.com>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
 <Zh-KF72Fe9oV6tfT@redhat.com>
 <c0b1dbb1-d353-4832-af90-96895b2129fc@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0b1dbb1-d353-4832-af90-96895b2129fc@maciej.szmigiero.name>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Wed, Apr 17, 2024 at 02:11:37PM +0200, Maciej S. Szmigiero wrote:
> On 17.04.2024 10:36, Daniel P. Berrangé wrote:
> > On Tue, Apr 16, 2024 at 04:42:39PM +0200, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > VFIO device state transfer is currently done via the main migration channel.
> > > This means that transfers from multiple VFIO devices are done sequentially
> > > and via just a single common migration channel.
> > > 
> > > Such way of transferring VFIO device state migration data reduces
> > > performance and severally impacts the migration downtime (~50%) for VMs
> > > that have multiple such devices with large state size - see the test
> > > results below.
> > > 
> > > However, we already have a way to transfer migration data using multiple
> > > connections - that's what multifd channels are.
> > > 
> > > Unfortunately, multifd channels are currently utilized for RAM transfer
> > > only.
> > > This patch set adds a new framework allowing their use for device state
> > > transfer too.
> > > 
> > > The wire protocol is based on Avihai's x-channel-header patches, which
> > > introduce a header for migration channels that allow the migration source
> > > to explicitly indicate the migration channel type without having the
> > > target deduce the channel type by peeking in the channel's content.
> > > 
> > > The new wire protocol can be switch on and off via migration.x-channel-header
> > > option for compatibility with older QEMU versions and testing.
> > > Switching the new wire protocol off also disables device state transfer via
> > > multifd channels.
> > > 
> > > The device state transfer can happen either via the same multifd channels
> > > as RAM data is transferred, mixed with RAM data (when
> > > migration.x-multifd-channels-device-state is 0) or exclusively via
> > > dedicated device state transfer channels (when
> > > migration.x-multifd-channels-device-state > 0).
> > > 
> > > Using dedicated device state transfer multifd channels brings further
> > > performance benefits since these channels don't need to participate in
> > > the RAM sync process.
> > 
> > I'm not convinced there's any need to introduce the new "channel header"
> > protocol messages. The multifd channels already have an initialization
> > message that is extensible to allow extra semantics to be indicated.
> > So if we want some of the multifd channels to be reserved for device
> > state, we could indicate that via some data in the MultiFDInit_t
> > message struct.
> 
> The reason for introducing x-channel-header was to avoid having to deduce
> the channel type by peeking in the channel's content - where any channel
> that does not start with QEMU_VM_FILE_MAGIC is currently treated as a
> multifd one.
> 
> But if this isn't desired then, as you say, the multifd channel type can
> be indicated by using some unused field of the MultiFDInit_t message.
> 
> Of course, this would still keep the QEMU_VM_FILE_MAGIC heuristic then.

I don't like the heuristics we currently have, and would to have
a better solution. What makes me cautious is that this proposal
is a protocol change, but only addressing one very narrow problem
with the migration protocol.

I'd like migration to see a more explicit bi-directional protocol
negotiation message set, where both QEMU can auto-negotiate amongst
themselves many of the features that currently require tedious
manual configuration by mgmt apps via migrate parameters/capabilities.
That would address the problem you describe here, and so much more.

If we add this channel header feature now, it creates yet another
thing to keep around for back compatibility. So if this is not
strictly required, in order to solve the VFIO VMstate problem, I'd
prefer to just solve the VMstate stuff on its own.

> > That said, the idea of reserving channels specifically for VFIO doesn't
> > make a whole lot of sense to me either.
> > 
> > Once we've done the RAM transfer, and are in the switchover phase
> > doing device state transfer, all the multifd channels are idle.
> > We should just use all those channels to transfer the device state,
> > in parallel.  Reserving channels just guarantees many idle channels
> > during RAM transfer, and further idle channels during vmstate
> > transfer.
> > 
> > IMHO it is more flexible to just use all available multifd channel
> > resources all the time.
> 
> The reason for having dedicated device state channels is that they
> provide lower downtime in my tests.
> 
> With either 15 or 11 mixed multifd channels (no dedicated device state
> channels) I get a downtime of about 1250 msec.
> 
> Comparing that with 15 total multifd channels / 4 dedicated device
> state channels that give downtime of about 1100 ms it means that using
> dedicated channels gets about 14% downtime improvement.

Hmm, can you clarify. /when/ is the VFIO vmstate transfer taking
place ? Is is transferred concurrently with the RAM ? I had thought
this series still has the RAM transfer iterations running first,
and then the VFIO VMstate at the end, simply making use of multifd
channels for parallelism of the end phase. your reply though makes
me question my interpretation though.

Let me try to illustrate channel flow in various scenarios, time
flowing left to right:

1. serialized RAM, then serialized VM state  (ie historical migration)

      main: | Init | RAM iter 1 | RAM iter 2 | ... | RAM iter N | VM State |


2. parallel RAM, then serialized VM state (ie today's multifd)

      main: | Init |                                            | VM state |
  multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
  multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
  multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |


3. parallel RAM, then parallel VM state

      main: | Init |                                            | VM state |
  multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
  multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
  multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
  multifd4:                                                     | VFIO VM state |
  multifd5:                                                     | VFIO VM state |


4. parallel RAM and VFIO VM state, then remaining VM state

      main: | Init |                                            | VM state |
  multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
  multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
  multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
  multifd4:        | VFIO VM state                                         |
  multifd5:        | VFIO VM state                                         |


I thought this series was implementing approx (3), but are you actually
implementing (4), or something else entirely ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


