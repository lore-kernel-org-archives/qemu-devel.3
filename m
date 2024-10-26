Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14827D10BE5
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 08:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4bkR-00046s-62; Sat, 26 Oct 2024 04:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t4bkO-00046L-WF
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 04:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t4bkN-0000lU-Av
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 04:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729929726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFxKPQmNQJxhJnDDuLXR6xxKpCSZvmkENCkFMxpimjo=;
 b=WmEuUigZ8pKhIMa2EsPK80t50xZnuUDo3dH+5WzNFdI0InTHjmj+69Bdvz5QebHtuItJmU
 17LMTYMDf+t2i9oikX/TaEn0IRPJo8plCt2DBtOO3tLErM1l4IrDDTsix++gbXRtubuaR9
 h5fD8YB67C1a9fTat/4RwBVRVO6z7Hw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-TWmcXlUuOjmvKwL8asOIsw-1; Sat,
 26 Oct 2024 04:02:04 -0400
X-MC-Unique: TWmcXlUuOjmvKwL8asOIsw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3246019560BA
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 08:02:04 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0532019560A3; Sat, 26 Oct 2024 08:02:00 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] virtio_net: Add the 3rd acceptable situation for Mac
 setup.
Date: Sat, 26 Oct 2024 16:00:02 +0800
Message-ID: <20241026080121.461781-5-lulu@redhat.com>
In-Reply-To: <20241026080121.461781-1-lulu@redhat.com>
References: <20241026080121.461781-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

While the hardware MAC address is 0 and the MAC address in
the QEMU command line is also 0, this configuration is
acceptable.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6900e3c44b..1e6a31baf8 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3622,6 +3622,19 @@ static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
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


