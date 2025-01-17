Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A3AC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 11:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYkLs-0003zq-Ie; Fri, 17 Jan 2025 06:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tYkLp-0003zK-Ti
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:17:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tYkLm-0002kx-8n
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737112636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1e1EoMtzClgZuD0WOSRDYZYUPPimek40ubocF2UXxJI=;
 b=TNgciuVyMsgZScUCLrpD3u2eklhblTqHs8PvHuLcLNPePvS5q9lrK9uQgajlcC01KoSGAV
 yXrDaVgaU1hfQ3hgk7K0H/5OeU9suz+NGFuajldxeViUvIiC7OJNUsPZGF4lbUJs3g0CfJ
 dExvJbRFoFiuTtJCyd5u7UoS+UwJ/oQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-KjCCcHh6N3yaQP7xBfz-uw-1; Fri,
 17 Jan 2025 06:17:15 -0500
X-MC-Unique: KjCCcHh6N3yaQP7xBfz-uw-1
X-Mimecast-MFC-AGG-ID: KjCCcHh6N3yaQP7xBfz-uw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADB3D19560AF
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:17:14 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.193.59])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA4DE195E3E0; Fri, 17 Jan 2025 11:17:13 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 2/2] net/dump: Correctly compute Ethernet packet offset
Date: Fri, 17 Jan 2025 12:17:09 +0100
Message-ID: <20250117111709.970789-3-lvivier@redhat.com>
In-Reply-To: <20250117111709.970789-1-lvivier@redhat.com>
References: <20250117111709.970789-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When a packet is sent with QEMU_NET_PACKET_FLAG_RAW by QEMU it
never includes virtio-net header even if qemu_get_vnet_hdr_len()
is not 0, and filter-dump is not managing this case.

The only user of QEMU_NET_PACKET_FLAG_RAW is announce_self,
we can show the problem using it and tcpddump:

- QEMU parameters:

  .. -monitor stdio \
     -netdev bridge,id=netdev0,br=virbr0 \
     -device virtio-net,mac=9a:2b:2c:2d:2e:2f,netdev=netdev0 \
     -object filter-dump,netdev=netdev0,file=log.pcap,id=pcap0

- HMP command:

  (qemu) announce_self

- TCP dump:

  $ tcpdump -nxr log.pcap

  without the fix:

    08:00:06:04:00:03 > 2e:2f:80:35:00:01, ethertype Unknown (0x9a2b), length 50:
         0x0000:  2c2d 2e2f 0000 0000 9a2b 2c2d 2e2f 0000
         0x0010:  0000 0000 0000 0000 0000 0000 0000 0000
         0x0020:  0000 0000

  with the fix:

    ARP, Reverse Request who-is 9a:2b:2c:2d:2e:2f tell 9a:2b:2c:2d:2e:2f, length 46
         0x0000:  0001 0800 0604 0003 9a2b 2c2d 2e2f 0000
         0x0010:  0000 9a2b 2c2d 2e2f 0000 0000 0000 0000
         0x0020:  0000 0000 0000 0000 0000 0000 0000

Fixes: 481c52320a26 ("net: Strip virtio-net header when dumping")
Cc: akihiko.odaki@daynix.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 net/dump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/dump.c b/net/dump.c
index d7dd2ce461de..140215aa1054 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -155,7 +155,8 @@ static ssize_t filter_dump_receive_iov(NetFilterState *nf, NetClientState *sndr,
 {
     NetFilterDumpState *nfds = FILTER_DUMP(nf);
 
-    dump_receive_iov(&nfds->ds, iov, iovcnt, qemu_get_vnet_hdr_len(nf->netdev));
+    dump_receive_iov(&nfds->ds, iov, iovcnt, flags & QEMU_NET_PACKET_FLAG_RAW ?
+                     0 : qemu_get_vnet_hdr_len(nf->netdev));
     return 0;
 }
 
-- 
2.47.1


