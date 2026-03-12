Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE36AFED2DF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0aFi-0004W3-Pp; Thu, 12 Mar 2026 03:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aFg-0004Vq-M5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aFe-00085F-2D
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773299671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KBuYAHMVHaYqmy8mPeqIgwY/x8x5XzbtQH5SdPw7vG8=;
 b=BmQfth6La/ht2KL+AcFHh0AD43dMSH5NkcWkeQ/hrVWoIVqEgmLBVVhOToPu1KRk9EoBHU
 xYfCydJQveW8BEPo/oav6PW7lQO+PI48lBMqfPsUussqvtz/Pn71CEvJJoWPMK6UgLoTDv
 XpsVLfxV0JTZbhw5Ur3AYjyfVk2KUBI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-KyhapCbBNcqYgWwtqeHl4w-1; Thu,
 12 Mar 2026 03:14:30 -0400
X-MC-Unique: KyhapCbBNcqYgWwtqeHl4w-1
X-Mimecast-MFC-AGG-ID: KyhapCbBNcqYgWwtqeHl4w_1773299669
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CDC91953991; Thu, 12 Mar 2026 07:14:29 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.170])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F75F180035F; Thu, 12 Mar 2026 07:14:24 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v2 0/9] net/filter-redirector: Add AF_PACKET support for
 vhost-net
Date: Thu, 12 Mar 2026 15:09:28 +0800
Message-ID: <20260312071415.1836655-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series adds an AF_PACKET support for vhost tap
device in filter-redirector/filter-buffer.when the vhost=on will use
AF_PACKET to capture and inject,

Example Usage(not change with exist upstream code)
=============
Primary VM (mirror incoming packets to secondary via chardev socket):

  -netdev tap,id=net0,vhost=on,...
  -chardev socket,id=mirror0,host=...,port=...,server=on,wait=off
  -object filter-redirector,id=vm1redir,netdev=net0,outdev=mirror0...

Secondary VM (receive mirrored packets):
  
  -netdev tap,id=net0,vhost=on,...
  -chardev socket,id=red0,host=...,port=...,reconnect-ms=..
  -object filter-buffer,id=swbuf,netdev=net0,queue=tx,interval=1000000,status=off.....
  -object filter-redirector,id=r1,netdev=net0,queue=tx,indev=red0,status=off,enable_when
  _stopped=true.... \

TODO
=======  
This series still based on tap device. The vhost-vdpa support is on going,will send soon 

changset
===========
change in v2: 
1. add support for filter-buffer 
2. remove the in_netdev and out_netdev for AF_PACKET bind port, now only use netdev 
when the vhost=on start use AF_PACKET to capture and inject, when use vhost=off will use
the existing code
3. add CAP_NET_RAW check
4. address the comment 


Testing
=======
- Tested with vhost=on/off TAP netdev on x86_64

Cindy Lu (9):
  net/filter: allow redirector on vhost TAP backends
  net/filter-redirector: add role helpers for AF_PACKET paths
  net/filter-redirector: add AF_PACKET socket setup and input handler
  net/filter-redirector: add send helpers and netdev counters
  net/filter-redirector: route chardev and AF_PACKET receive paths
  net/filter: Add support for filter-buffer
  virtio-net: keep tap read polling disabled while vhost owns RX
  virtio-net: handle short vnet headers on replay RX
  net/filter-redirector: check CAP_NET_RAW before creating AF_PACKET

 hw/net/virtio-net.c |  66 +++++-
 include/net/queue.h |   5 +
 net/filter-mirror.c | 493 ++++++++++++++++++++++++++++++++++++++++++--
 net/filter.c        |  16 +-
 4 files changed, 551 insertions(+), 29 deletions(-)

-- 
2.52.0


