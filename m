Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742CDFB3CE4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78dL-0005Ov-Pu; Mon, 30 Mar 2026 05:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78dI-0005Ng-5K
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78dF-00009h-8A
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774861798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eWiA0Dh9/0XY7MFofigYdL6zxy9cWPVcg9gwC7ePO1o=;
 b=ZsY/BXyGnPhUU1rUW3PKNnQljoBGygi75u4qc+G9i2ndwGDDLIkf12fj2hr42AZIUB4rns
 AMdWBvPJs0Wxn098B7OLWfhll1IU9wdIDmPNQTmtX6KJZOhCsQt0A9YaPctp1/XTwju0eR
 1Oo+8+QP9GoasT5Z6oxAJcrZlRwyspE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-1T75LCnWOr-UM1EnJWgImw-1; Mon,
 30 Mar 2026 05:09:55 -0400
X-MC-Unique: 1T75LCnWOr-UM1EnJWgImw-1
X-Mimecast-MFC-AGG-ID: 1T75LCnWOr-UM1EnJWgImw_1774861794
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E329019560BB; Mon, 30 Mar 2026 09:09:53 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.39])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6459E30001A1; Mon, 30 Mar 2026 09:09:50 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v3 0/7] net/filter: Add AF_PACKET support for vhost-net
Date: Mon, 30 Mar 2026 16:58:08 +0800
Message-ID: <20260330090944.1008027-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

This series adds AF_PACKET-based capture and injection datapath
support for the vhost TAP device in filter

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

Testing
=======
- Tested with vhost=on/off TAP device on x86_64

known issue: 
============
1. compilation should be disabled on non-Linux platforms.will fix in next version.
2. Sometimes the secondary VM receives duplicate packets. will fix this in next version.


Cindy Lu (7):
  net/filter-mirror: keep mirroring while stopped
  virtio-net: keep tap read polling disabled while vhost owns RX
  net/filter-redirector: add AF_PACKET netdev setup helpers
  net/filter-redirector: add AF_PACKET capture path
  net/filter-redirector: add AF_PACKET inject path
  net/filter: allow filters on vhost TAP backends
  net/filter-redirector: check CAP_NET_RAW before creating AF_PACKET

 hw/net/virtio-net.c  |  12 +-
 include/net/filter.h |   6 +
 include/net/net.h    |   6 +
 net/filter-mirror.c  | 379 ++++++++++++++++++++++++++++++++++++++++++-
 net/filter.c         |  17 +-
 net/net.c            |  10 +-
 6 files changed, 417 insertions(+), 13 deletions(-)

-- 
2.52.0


