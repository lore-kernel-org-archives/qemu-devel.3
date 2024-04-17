Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C05C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 08:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx0mn-00064V-5j; Wed, 17 Apr 2024 04:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx0ml-00064C-EB
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 04:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx0mi-0001sH-PF
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 04:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713343011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=eg5/71RLFC6C4lwbk37/7KuJVC+Uqnq0aTr+/PQQtP8=;
 b=IfOcgzax4ZfBDRRVX13tMbePtWhd/DYh3OXBZIUa7yjRg2Y4D+Nth0zuvD0zeEPXrPpeDD
 boz8O7Ei9LIFNP5FkFw1p6b9NOR80azRfKNT/n6FxlcNbPngJOxGObmpbN6+SxwOeC5f2m
 CxEcTZdA+y8wBCw1s1Eb3b24Kjmyul8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-SzCyYEL6NEe-LD87-MR_Yw-1; Wed,
 17 Apr 2024 04:36:47 -0400
X-MC-Unique: SzCyYEL6NEe-LD87-MR_Yw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D16F3C0DF69;
 Wed, 17 Apr 2024 08:36:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 038261121312;
 Wed, 17 Apr 2024 08:36:44 +0000 (UTC)
Date: Wed, 17 Apr 2024 09:36:39 +0100
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
Message-ID: <Zh-KF72Fe9oV6tfT@redhat.com>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1713269378.git.maciej.szmigiero@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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

On Tue, Apr 16, 2024 at 04:42:39PM +0200, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> VFIO device state transfer is currently done via the main migration channel.
> This means that transfers from multiple VFIO devices are done sequentially
> and via just a single common migration channel.
> 
> Such way of transferring VFIO device state migration data reduces
> performance and severally impacts the migration downtime (~50%) for VMs
> that have multiple such devices with large state size - see the test
> results below.
> 
> However, we already have a way to transfer migration data using multiple
> connections - that's what multifd channels are.
> 
> Unfortunately, multifd channels are currently utilized for RAM transfer
> only.
> This patch set adds a new framework allowing their use for device state
> transfer too.
> 
> The wire protocol is based on Avihai's x-channel-header patches, which
> introduce a header for migration channels that allow the migration source
> to explicitly indicate the migration channel type without having the
> target deduce the channel type by peeking in the channel's content.
> 
> The new wire protocol can be switch on and off via migration.x-channel-header
> option for compatibility with older QEMU versions and testing.
> Switching the new wire protocol off also disables device state transfer via
> multifd channels.
> 
> The device state transfer can happen either via the same multifd channels
> as RAM data is transferred, mixed with RAM data (when
> migration.x-multifd-channels-device-state is 0) or exclusively via
> dedicated device state transfer channels (when
> migration.x-multifd-channels-device-state > 0).
> 
> Using dedicated device state transfer multifd channels brings further
> performance benefits since these channels don't need to participate in
> the RAM sync process.

I'm not convinced there's any need to introduce the new "channel header"
protocol messages. The multifd channels already have an initialization
message that is extensible to allow extra semantics to be indicated.
So if we want some of the multifd channels to be reserved for device
state, we could indicate that via some data in the MultiFDInit_t
message struct.

That said, the idea of reserving channels specifically for VFIO doesn't
make a whole lot of sense to me either.

Once we've done the RAM transfer, and are in the switchover phase
doing device state transfer, all the multifd channels are idle.
We should just use all those channels to transfer the device state,
in parallel.  Reserving channels just guarantees many idle channels
during RAM transfer, and further idle channels during vmstate
transfer.

IMHO it is more flexible to just use all available multifd channel
resources all the time. Again the 'MultiFDPacket_t' struct has
both 'flags' and unused fields, so it is extensible to indicate
that is it being used for new types of data.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


