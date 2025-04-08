Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5E7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 06:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u22Df-0007Ew-A4; Tue, 08 Apr 2025 02:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u22DY-0007CG-R4
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u22DX-0001wa-As
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744092829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfxzveTaXJtWwFKEeVvLZ0x0ccZfdKdEW4mEoLLWsSA=;
 b=Tmb8tn/mHTinfoZd/uHVZTe0PuEeaKm9kFjgEjMZjj4095OdC0QmJF+EP3tGViiUDeqHCM
 2h7IAc3Y2Zsr0QR/4+GCCmQ5jP/JZTmn5gGoUU7/W+C8esv9Pmac0cWCUc3rOHgQN8aEZ3
 pi1jzB/2zBRcLyxt6Uc6USFsQXQ1I0s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-KFaZtCBIOtSX9-zSRxHXSw-1; Tue,
 08 Apr 2025 02:13:47 -0400
X-MC-Unique: KFaZtCBIOtSX9-zSRxHXSw-1
X-Mimecast-MFC-AGG-ID: KFaZtCBIOtSX9-zSRxHXSw_1744092827
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19A57180025A
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 06:13:47 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FC75180B486; Tue,  8 Apr 2025 06:13:43 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 3/4] virtio_net: Add second acceptable configuration for
 MAC setup
Date: Tue,  8 Apr 2025 14:12:45 +0800
Message-ID: <20250408061327.2590372-4-lulu@redhat.com>
In-Reply-To: <20250408061327.2590372-1-lulu@redhat.com>
References: <20250408061327.2590372-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 94ee21d1fc..45b63eb9de 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3769,6 +3769,20 @@ static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
         if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) == 0)) {
             return true;
         }
+        /*
+         * 2. The hardware MAC address is NOT 0 and the MAC address in
+         *  the QEMU command line is 0.
+         *  In this situation, we use the hardware MAC address overwrite
+         *  the QEMU command line address saved in VirtIONet->mac[0].
+         *  In the following process, QEMU will use this MAC address
+         *  in VirtIONet to complete the initialization.
+         */
+        if (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) == 0) {
+            /* overwrite the mac address with hardware address */
+            memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
+            memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n->mac));
+            return true;
+        }
     }
     error_setg(errp,
                "vDPA device's MAC address %02x:%02x:%02x:%02x:%02x:%02x "
-- 
2.45.0


