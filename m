Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0CAC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 11:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYkM5-0004CV-Aj; Fri, 17 Jan 2025 06:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tYkLr-0003zm-Pg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:17:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tYkLl-0002kt-Qc
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737112636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+LZepUqTaGzDSP4HQT6kz2ChZNHH1z2SedlKC29XaU=;
 b=aK+AxZxd9VcM30wkzJDnQTAb2aXrkiYv29fo23RoCozQM6EvgRrc87L0ywBUwWHTEawkjv
 GXXjIQgNkvXwsWjb6pjDDeo+hs3xBnH+5xth/KYPF22pDvic6W6Y+9J2klcUOgOWSAaAeP
 BQuCENDTPJUq9j6cXG1qY8jcRYSEDZ8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-hU13R0pWOIi0KYvBxZrmvA-1; Fri,
 17 Jan 2025 06:17:15 -0500
X-MC-Unique: hU13R0pWOIi0KYvBxZrmvA-1
X-Mimecast-MFC-AGG-ID: hU13R0pWOIi0KYvBxZrmvA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36B451955F36
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:17:13 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.193.59])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44B92195E3D9; Fri, 17 Jan 2025 11:17:12 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 1/2] net: Fix announce_self
Date: Fri, 17 Jan 2025 12:17:08 +0100
Message-ID: <20250117111709.970789-2-lvivier@redhat.com>
In-Reply-To: <20250117111709.970789-1-lvivier@redhat.com>
References: <20250117111709.970789-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

b9ad513e1876 ("net: Remove receive_raw()") adds an iovec entry
in qemu_deliver_packet_iov() to add the virtio-net header
in the data when QEMU_NET_PACKET_FLAG_RAW is set but forgets
to increase the number of iovec entries in the array, so
receive_iov() will only send the first entry (the virtio-net
entry, full of 0) and no data. The packet will be discarded.

The only user of QEMU_NET_PACKET_FLAG_RAW is announce_self.

We can see the problem with tcpdump:

- QEMU parameters:

  .. -monitor stdio \
     -netdev bridge,id=netdev0,br=virbr0 \
     -device virtio-net,mac=9a:2b:2c:2d:2e:2f,netdev=netdev0 \

- HMP command:

  (qemu) announce_self

- TCP dump:

  $ sudo tcpdump -nxi virbr0

  without the fix:

    <nothing>

  with the fix:

   ARP, Reverse Request who-is 9a:2b:2c:2d:2e:2f tell 9a:2b:2c:2d:2e:2f, length 46
        0x0000:  0001 0800 0604 0003 9a2b 2c2d 2e2f 0000
        0x0010:  0000 9a2b 2c2d 2e2f 0000 0000 0000 0000
        0x0020:  0000 0000 0000 0000 0000 0000 0000

Reported-by: Xiaohui Li <xiaohli@redhat.com>
Bug: https://issues.redhat.com/browse/RHEL-73891
Fixes: b9ad513e1876 ("net: Remove receive_raw()")
Cc: akihiko.odaki@daynix.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 net/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/net.c b/net/net.c
index c1bb19a52373..9cded70dde74 100644
--- a/net/net.c
+++ b/net/net.c
@@ -822,6 +822,7 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
         iov_copy[0].iov_len =  nc->vnet_hdr_len;
         memcpy(&iov_copy[1], iov, iovcnt * sizeof(*iov));
         iov = iov_copy;
+        iovcnt++;
     }
 
     if (nc->info->receive_iov) {
-- 
2.47.1


