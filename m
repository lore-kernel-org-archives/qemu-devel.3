Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E5BEF48DC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 07:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqnKQ-0002Zs-Nn; Fri, 13 Feb 2026 02:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vqnKO-0002ZR-GZ
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 02:11:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vqnKM-0005bC-Kl
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 02:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770966656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aAeo8Qp29w58NpL2Ar0gIFc3G/2b+aZ7G1Yo/rVw+Uk=;
 b=CXuzVTXsEhjoaqVLA5NnDn00BYoGd4wkg0PQXgSRCn1G7fNyZa5SUUtNljKx2eHedHPMuG
 mt3qTzyxPTaL4pgEMqm1bIhHewytGrSnV35S4icmiNvnKhnxeR3Qo8pm1u53y4cxJDTO8W
 BwhRy+NPy4Se9HHLEdSnN9z52WFkTqI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-Wq8vh4GPPTy-4gSJFhrtcA-1; Fri,
 13 Feb 2026 02:10:51 -0500
X-MC-Unique: Wq8vh4GPPTy-4gSJFhrtcA-1
X-Mimecast-MFC-AGG-ID: Wq8vh4GPPTy-4gSJFhrtcA_1770966650
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40A061956094; Fri, 13 Feb 2026 07:10:50 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B753B30001BE; Fri, 13 Feb 2026 07:10:46 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [RFC 0/5] net/filter-redirector: Add AF_PACKET support for vhost-net
Date: Fri, 13 Feb 2026 15:08:00 +0800
Message-ID: <20260213071042.3733239-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This series extends filter-redirector to support vhost-net backends by
introducing AF_PACKET based packet capture and injection.

TODO
========
This series introduces basic support for filter-redirector, enabling
simple mirroring of VM1's ingress traffic to VM2's mirror port. 
Additional functionality including filter_buffer and other filter features
will be added in following versions.

Example Usage
=============
Primary VM (mirror incoming packets to secondary via chardev socket):

  -netdev tap,id=net0,vhost=on,...
  -chardev socket,id=mirror0,host=...,port=...,server=on,wait=off
  -object filter-redirector,id=vm1redir,netdev=net0,in_netdev=net0,outdev=mirror0

Secondary VM (receive mirrored packets):

  -chardev socket,id=red0,host=...,port=...,reconnect-ms=1000
  -object filter-redirector,id=vm2redir,netdev=net0,indev=red0,out_netdev=net0

Testing
=======
- Tested with vhost=on/off TAP netdev on x86_64

Cindy Lu (5):
  net/filter: Allow redirector on vhost backends
  net/filter-redirector: add in/out_netdev properties
  net/filter-redirector: Add AF_PACKET sockets initialization
  net/filter-redirector: add AF_PACKET redirect datapath
  qapi: add in/out_netdev to filter-redirector

 net/filter-mirror.c | 460 +++++++++++++++++++++++++++++++++++++++++---
 net/filter.c        |   6 +-
 qapi/qom.json       |  19 +-
 3 files changed, 459 insertions(+), 26 deletions(-)

-- 
2.52.0


