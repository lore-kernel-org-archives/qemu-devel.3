Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB59D5C0FC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9f2N-00086Y-Ch; Sat, 09 Nov 2024 01:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t9f2L-000829-AE
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:33:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t9f2J-0001Uw-VZ
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731134011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0tiPZPS6Shh5GDPNeFDtpssQLVwX/B4YuknKiDeV/Uc=;
 b=fKSdM3wK6qZtlejA0NvbODGfOGo8KK30hm17mxfU1b7vr0md9gpZtZVczqtvzN8hb0K0j6
 /iMEuI0FTw8voLEa13VsddNNMgI2qc1dYh3OKecHf0kG+52EVr5u33w80minBsyFJYuFCW
 S/yodCK496MjK4P81J9NMa1h4jEtjRU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-KxE2G5asOoixBymEnIfiTA-1; Sat,
 09 Nov 2024 01:33:29 -0500
X-MC-Unique: KxE2G5asOoixBymEnIfiTA-1
X-Mimecast-MFC-AGG-ID: KxE2G5asOoixBymEnIfiTA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC2F519560AD
 for <qemu-devel@nongnu.org>; Sat,  9 Nov 2024 06:33:28 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D310D300019E; Sat,  9 Nov 2024 06:33:25 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 4/4] virtio_net: Add third acceptable configuration for MAC
 setup.
Date: Sat,  9 Nov 2024 14:31:26 +0800
Message-ID: <20241109063241.1039433-5-lulu@redhat.com>
In-Reply-To: <20241109063241.1039433-1-lulu@redhat.com>
References: <20241109063241.1039433-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

For VDPA devices, Allow configurations where both the hardware MAC address
and QEMU command line MAC address are zero.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f74aa4f8db..66f21f74f4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3627,6 +3627,19 @@ static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
             return true;
         }
     }
+    /*
+     * 3.The hardware MAC address is 0,
+     *  and the MAC address in the QEMU command line is also 0.
+     *  In this situation, qemu will generate a random mac address
+     *  QEMU will try to use CVQ/set_config to set this address to
+     *  device
+     */
+    if ((memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) == 0) &&
+        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) == 0)) {
+        memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
+
+        return true;
+    }
 
     error_setg(errp,
                "vDPA device's mac %02x:%02x:%02x:%02x:%02x:%02x"
-- 
2.45.0


