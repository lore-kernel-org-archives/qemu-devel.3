Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1208D64075
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9f1w-0007Yj-KU; Sat, 09 Nov 2024 01:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t9f1v-0007Yb-QP
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:33:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t9f1u-0001U0-GJ
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731133986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4VNHmUiIa21a929R2Y1nHP51u+LIhF20n26bB3YK0w=;
 b=NUWSuPXXokBGG0vqSwcNFn0ke+LrGt55InsoIoB4sjWVkfJMRgKSQdRnh8R4wArW7vlErF
 cSZw9xXV9S5EtPNQaaWjuhm3Q8TRkAouNS1+PxpuEbQIEVMKf6k0bXuUaKhXE17WnBoMwq
 qX3jowAVRb9cN1tLoLrxxAaASeccXrs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-HRzcUnunMX63lQk5fZDv-g-1; Sat,
 09 Nov 2024 01:33:04 -0500
X-MC-Unique: HRzcUnunMX63lQk5fZDv-g-1
X-Mimecast-MFC-AGG-ID: HRzcUnunMX63lQk5fZDv-g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E81841955EE9
 for <qemu-devel@nongnu.org>; Sat,  9 Nov 2024 06:33:02 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A13A195E480; Sat,  9 Nov 2024 06:32:59 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 3/4] virtio_net: Add second acceptable configuration for
 MAC setup
Date: Sat,  9 Nov 2024 14:31:25 +0800
Message-ID: <20241109063241.1039433-4-lulu@redhat.com>
In-Reply-To: <20241109063241.1039433-1-lulu@redhat.com>
References: <20241109063241.1039433-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For VDPA devices, Allow configurations where the hardware MAC address
is non-zero while the MAC address in the QEMU command line is zero.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 01cac20d92..f74aa4f8db 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3612,6 +3612,20 @@ static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
         if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) == 0)) {
             return true;
         }
+        /*
+         * 2.The hardware MAC address is NOT 0,
+         *  and the MAC address in the QEMU command line is 0.
+         *  In this situation, Here we use the hardware MAC address overwrite
+         *  the QEMU command line address(is 0) in VirtIONet->mac[0].
+         *  in the follwoing process, QEMU will use this mac in VirtIONet and
+         *  finish the bring up
+         */
+        if (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) == 0) {
+            /* overwrite the mac address with hardware address*/
+            memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
+            memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n->mac));
+            return true;
+        }
     }
 
     error_setg(errp,
-- 
2.45.0


