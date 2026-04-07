Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AABFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXZ-0000Gs-FK; Tue, 07 Apr 2026 14:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1wABUI-0004Gu-FY
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w9yfx-0003Gm-D4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 01:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775538510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=r7MgCxBodV/6hEOvHxo+i0I4wG7WCx8i1dakiz9yVNw=;
 b=Ajz7vD+hoL33pf/whrxVOT50aVAVTFck3X4UvonQjfw5UADLa6CgxqoP9tgSmpqbGQG4Pb
 47JcFRoiTQXoXUPbkVk4DtKL3ZEfES3dVRcP/u8TMewavTdYLdBvOByyqWKxo3Exo3eZ54
 n51a8fZaMOGhk7NynoJY3+kOaY7I0YE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-fhvUPWEfNa-74KkjgOTvCA-1; Tue,
 07 Apr 2026 01:08:27 -0400
X-MC-Unique: fhvUPWEfNa-74KkjgOTvCA-1
X-Mimecast-MFC-AGG-ID: fhvUPWEfNa-74KkjgOTvCA_1775538506
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C70FF180047F; Tue,  7 Apr 2026 05:08:25 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.55])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5ACEF180058C; Tue,  7 Apr 2026 05:08:22 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v4 0/5] net/filter: Add AF_PACKET support for vhost-net
Date: Tue,  7 Apr 2026 13:05:47 +0800
Message-ID: <20260407050818.2249570-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi, All

This series wires AF_PACKET-backed packet capture and inject support into
the existing socket chardev backend so filter-redirector can keep using exist
process

Example Usage
=============
  Users are expected to create the AF_PACKET socket in userspace, bind it
  to the target tap device, and then pass the resulting fd to QEMU via
  the existing FD_PLACEHOLDER mechanism.

  Creating such a socket requires CAP_NET_RAW (or running as root).  A
  typical setup looks like:

      sock = socket.socket(socket.AF_PACKET, socket.SOCK_RAW,
                           socket.htons(ETH_P_ALL))
      sock.bind((ifname, ETH_P_ALL))

  The bound fd can then be passed to QEMU with:

      -chardev socket,...,fd=${FD_PLACEHOLDER},...

Primary VM (mirror incoming packets to secondary via chardev socket):

  -netdev "tap,id=net0,ifname=${TAP}...vhost=on"
  -device "${VIRTIO_NET_DEVICE}"
  -chardev "socket,id=chain_out,fd=${FD_PLACEHOLDER},af-packet-mode=capture"
  -chardev "socket,id=mirror0,host=${MIRROR_HOST},port=${MIRROR_PORT},reconnect-ms=${MIRROR_RECONNECT_MS}"
  -object "filter-redirector,id=r1,netdev=net0,queue=tx,indev=chain_out,status=on,vnet_hdr_support=off,position=head"
  -object "filter-redirector,id=r1_mirror,netdev=net0,queue=tx,outdev=mirror0,status=on,vnet_hdr_support=off,insert=behind"

Secondary VM (receive mirrored packets):

  -netdev "tap,id=net0,ifname=${TAP}...vhost=on"
  -device "${VIRTIO_NET_DEVICE}"
  -chardev "socket,id=red0,host=${MIRROR_BIND_HOST},port=${MIRROR_PORT},server=on,wait=off"
  -chardev "socket,id=chain_in,fd=${FD_PLACEHOLDER},af-packet-mode=inject"
  -object "filter-redirector,id=r1,netdev=net0,queue=tx,indev=red0,status=off,vnet_hdr_support=off,position=head"
  -object "filter-redirector,id=r1_inject,netdev=net0,queue=tx,outdev=chain_in,status=off,vnet_hdr_support=off,position=id=r1,insert=behind"


changset
===========
change in v2: 
1. add support for filter-buffer 
2. remove the in_netdev and out_netdev for AF_PACKET bind port, now only use netdev 
when the vhost=on start use AF_PACKET to capture and inject, when use vhost=off will use
the existing code
3. add CAP_NET_RAW check
4. address the comment 

change in v3: 
1. reuse the exist Capture/inject process 

change in v4: 
1.move the capture/inject to chardev 
2.move the create/bind socket to user script

Testing
=======
- Tested with vhost=on/off TAP device on x86_64



Cindy Lu (5):
  net/filter: allow filters on vhost netdevs
  chardev/socket: add AF_PACKET initialization
  io/channel-socket: tolerate AF_PACKET getpeername
  chardev/socket: add AF_PACKET inject path
  chardev/socket: add AF_PACKET capture path

 chardev/char-socket.c         | 385 +++++++++++++++++++++++++++++++++-
 chardev/char.c                |   3 +
 include/chardev/char-socket.h |  13 ++
 io/channel-socket.c           |   6 +-
 net/filter.c                  |   6 -
 qapi/char.json                |  23 +-
 qemu-options.hx               |   5 +-
 7 files changed, 429 insertions(+), 12 deletions(-)

-- 
2.52.0


