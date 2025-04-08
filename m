Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE99C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 06:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u22EE-0007kt-UL; Tue, 08 Apr 2025 02:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u22Dy-0007WV-QE
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u22Dx-0001yV-4N
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744092854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cPR42kA0dDxhaaC2cfyBVWCZvGqQEyUACJjLYf9+oxA=;
 b=QNROP2lGHHyTzBinel9zcBQATxYVwXnyPtINMhFOlzej8ayUfUByFCKIFObU3cMaOfxxBk
 yKtHr/HhcTm98IHi9o8JdqLcHbZpX1jBmoNFvFAjygaYUHhjCjoI3wZu+iSTTTth9qfhcr
 pTbrO66wZCfrRxBFWF19+i7TaJ72GtY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-JIc2fgVPMB2AMgcHB-U2DQ-1; Tue,
 08 Apr 2025 02:14:13 -0400
X-MC-Unique: JIc2fgVPMB2AMgcHB-U2DQ-1
X-Mimecast-MFC-AGG-ID: JIc2fgVPMB2AMgcHB-U2DQ_1744092852
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4112180035E
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 06:14:12 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAA0A180AF7C; Tue,  8 Apr 2025 06:14:09 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 4/4] virtio_net: Add third acceptable configuration for MAC
 setup.
Date: Tue,  8 Apr 2025 14:12:46 +0800
Message-ID: <20250408061327.2590372-5-lulu@redhat.com>
In-Reply-To: <20250408061327.2590372-1-lulu@redhat.com>
References: <20250408061327.2590372-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
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

For VDPA devices, Allow configurations where both the hardware MAC address
and QEMU command line MAC address are zero.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 45b63eb9de..6c6bd116f7 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3784,6 +3784,18 @@ static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
             return true;
         }
     }
+    /*
+     * 3. The hardware MAC address is 0,
+     *  and the MAC address in the QEMU command line is also 0.
+     *  In this situation, QEMU generates a random MAC address and
+     *  uses CVQ/set_config to assign it to the device.
+     */
+    if ((memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) == 0) &&
+        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) == 0)) {
+        memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
+
+        return true;
+    }
     error_setg(errp,
                "vDPA device's MAC address %02x:%02x:%02x:%02x:%02x:%02x "
                "is not the same as the QEMU command line MAC address "
-- 
2.45.0


