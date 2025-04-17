Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F51C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5MRI-00066j-4c; Thu, 17 Apr 2025 06:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u5MRF-00065v-Jx
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u5MRD-00076V-Qj
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744885542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0ABQxPb+sin1yUjY1rlXFm6+xfXpzGjs6uHJFTaCKM=;
 b=KbcQmLgy5Gqb0+TOY4VeVT2+JOs92Qivx137zeqnOpmsXUvERIn8DGIZlckWfw7jFEwt7A
 CS/UdK2IoWvnULFI9o7v+94w1j8NSa96iZqLw+8VHCjUa8oeX16ARJu6RDOx2zPmRgeYD4
 dpOyUsAPu1vBRVbN52xfMQFGL+9CbXk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-N4q65OtTPFGcNXiRmCsy0Q-1; Thu,
 17 Apr 2025 06:25:41 -0400
X-MC-Unique: N4q65OtTPFGcNXiRmCsy0Q-1
X-Mimecast-MFC-AGG-ID: N4q65OtTPFGcNXiRmCsy0Q_1744885540
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3DBC19560BB
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:25:40 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46255180045B; Thu, 17 Apr 2025 10:25:37 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 3/4] virtio_net: Add second acceptable configuration for
 MAC setup
Date: Thu, 17 Apr 2025 18:24:17 +0800
Message-ID: <20250417102522.4125379-4-lulu@redhat.com>
In-Reply-To: <20250417102522.4125379-1-lulu@redhat.com>
References: <20250417102522.4125379-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

For VDPA devices, Allow configurations where the hardware MAC address
is non-zero while the MAC address in the QEMU command line is zero.
In this case, QEMU will use the hardware MAC address from the device.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 0b6a4e5634..808a2fe4d4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3757,6 +3757,20 @@ static bool virtio_net_check_vdpa_mac(VirtIONet *n, uint8_t *hwmac,
         if ((memcmp(hwmac, cmdline_mac, sizeof(MACAddr)) == 0)) {
             return true;
         }
+        /*
+         * 2. The hardware MAC address is NOT 0 and the MAC address in
+         *  the QEMU command line is 0.
+         *  In this case,qemu will use the hardware MAC address overwrite
+         *  the QEMU command line MAC address saved in VirtIONet->mac[0].
+         *  In the following process, QEMU will use this MAC address
+         *  to complete the initialization.
+         */
+        if (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) == 0) {
+            /* overwrite the mac address with hardware address */
+            memcpy(&n->mac[0], hwmac, sizeof(n->mac));
+            memcpy(&n->nic_conf.macaddr, hwmac, sizeof(n->mac));
+            return true;
+        }
     }
 
     return false;
-- 
2.45.0


