Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C147010F996C
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqG-0002XK-4b; Wed, 08 Apr 2026 14:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wAXq5-0001xb-46
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wARpz-0004EN-Re
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 08:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775650610;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7dO+BtaDz89OHmm69g+D9idcep0u77g5comT2YDKOmo=;
 b=K0dMVC91lyf4rzXdU9/v/2hibgGilFfEdDX7AhW7k3rEHJhApro2QqvysTGmZO+Q3J44LU
 fKNZN0pmoiyBBMjE43Lh0vtsVoPcm1sIITD5PnPjuRrpH6UikAvOcnNFde9/KxdVpu2CYl
 bq3vVF56cndCxVmD57t2ii3HWluNZus=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-yMuJjTlGN0qyzDo-q48Jmw-1; Wed,
 08 Apr 2026 08:16:47 -0400
X-MC-Unique: yMuJjTlGN0qyzDo-q48Jmw-1
X-Mimecast-MFC-AGG-ID: yMuJjTlGN0qyzDo-q48Jmw_1775650606
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8811D1956051; Wed,  8 Apr 2026 12:16:46 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94E501800351; Wed,  8 Apr 2026 12:16:44 +0000 (UTC)
Date: Wed, 8 Apr 2026 13:16:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: Re: [RFC v4 0/5] net/filter: Add AF_PACKET support for vhost-net
Message-ID: <adZHKW40HajoCzAk@redhat.com>
References: <20260407050818.2249570-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407050818.2249570-1-lulu@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 07, 2026 at 01:05:47PM +0800, Cindy Lu wrote:
> Hi, All
> 
> This series wires AF_PACKET-backed packet capture and inject support into
> the existing socket chardev backend so filter-redirector can keep using exist
> process
> 
> Example Usage
> =============
>   Users are expected to create the AF_PACKET socket in userspace, bind it
>   to the target tap device, and then pass the resulting fd to QEMU via
>   the existing FD_PLACEHOLDER mechanism.
> 
>   Creating such a socket requires CAP_NET_RAW (or running as root).  A
>   typical setup looks like:
> 
>       sock = socket.socket(socket.AF_PACKET, socket.SOCK_RAW,
>                            socket.htons(ETH_P_ALL))
>       sock.bind((ifname, ETH_P_ALL))

While FD passing is certainly desirable, and indeed required, for
libvirt to manage QEMU, IMHO, the QIOChannelSocket should be made
capable of opening AF_PACKET sockets explicitly too.

I generally only consider "FD" passing for QIOCHannelSocket to be
supported for address families that we can explicitly open - we
shouldn't have address familys that are only supported via FD
passing

> 
>   The bound fd can then be passed to QEMU with:
> 
>       -chardev socket,...,fd=${FD_PLACEHOLDER},...
> 
> Primary VM (mirror incoming packets to secondary via chardev socket):
> 
>   -netdev "tap,id=net0,ifname=${TAP}...vhost=on"
>   -device "${VIRTIO_NET_DEVICE}"
>   -chardev "socket,id=chain_out,fd=${FD_PLACEHOLDER},af-packet-mode=capture"
>   -chardev "socket,id=mirror0,host=${MIRROR_HOST},port=${MIRROR_PORT},reconnect-ms=${MIRROR_RECONNECT_MS}"
>   -object "filter-redirector,id=r1,netdev=net0,queue=tx,indev=chain_out,status=on,vnet_hdr_support=off,position=head"
>   -object "filter-redirector,id=r1_mirror,netdev=net0,queue=tx,outdev=mirror0,status=on,vnet_hdr_support=off,insert=behind"
> 
> Secondary VM (receive mirrored packets):
> 
>   -netdev "tap,id=net0,ifname=${TAP}...vhost=on"
>   -device "${VIRTIO_NET_DEVICE}"
>   -chardev "socket,id=red0,host=${MIRROR_BIND_HOST},port=${MIRROR_PORT},server=on,wait=off"
>   -chardev "socket,id=chain_in,fd=${FD_PLACEHOLDER},af-packet-mode=inject"
>   -object "filter-redirector,id=r1,netdev=net0,queue=tx,indev=red0,status=off,vnet_hdr_support=off,position=head"
>   -object "filter-redirector,id=r1_inject,netdev=net0,queue=tx,outdev=chain_in,status=off,vnet_hdr_support=off,position=id=r1,insert=behind"
> 
> 
> changset
> ===========
> change in v2: 
> 1. add support for filter-buffer 
> 2. remove the in_netdev and out_netdev for AF_PACKET bind port, now only use netdev 
> when the vhost=on start use AF_PACKET to capture and inject, when use vhost=off will use
> the existing code
> 3. add CAP_NET_RAW check
> 4. address the comment 
> 
> change in v3: 
> 1. reuse the exist Capture/inject process 
> 
> change in v4: 
> 1.move the capture/inject to chardev 
> 2.move the create/bind socket to user script
> 
> Testing
> =======
> - Tested with vhost=on/off TAP device on x86_64
> 
> 
> 
> Cindy Lu (5):
>   net/filter: allow filters on vhost netdevs
>   chardev/socket: add AF_PACKET initialization
>   io/channel-socket: tolerate AF_PACKET getpeername
>   chardev/socket: add AF_PACKET inject path
>   chardev/socket: add AF_PACKET capture path
> 
>  chardev/char-socket.c         | 385 +++++++++++++++++++++++++++++++++-
>  chardev/char.c                |   3 +
>  include/chardev/char-socket.h |  13 ++
>  io/channel-socket.c           |   6 +-
>  net/filter.c                  |   6 -
>  qapi/char.json                |  23 +-
>  qemu-options.hx               |   5 +-
>  7 files changed, 429 insertions(+), 12 deletions(-)
> 
> -- 
> 2.52.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


