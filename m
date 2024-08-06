Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C1FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 00:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb8X9-0003lc-4q; Mon, 05 Aug 2024 20:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sb8X7-0003gX-Rl
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 20:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sb8X6-00040J-AZ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 20:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722905914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9axcQPO7O8Jkoe9Hp1KFaxb/8lUDpyeewOJx15zJSQg=;
 b=ih+LlXefV7unVr6GLVMar3s4JHjah2AGuTS07Rf7UQLE4bdkJXxKq6ARm50SuT7pWvEJWj
 DsNLnYYkVi/3i73MkC+AIRtsUZ3Fcp6JSFTJCf/ZPZpzajtG4ubggW2QUCO1j4f0ehLGmG
 ZMwtqk26QC3nBDQnQ+99WRKYF8ZgR7g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-cftLO2O2PC6h-574WQUe-A-1; Mon,
 05 Aug 2024 20:58:32 -0400
X-MC-Unique: cftLO2O2PC6h-574WQUe-A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BEE91955D45
 for <qemu-devel@nongnu.org>; Tue,  6 Aug 2024 00:58:31 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.8])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25A3C19560AE; Tue,  6 Aug 2024 00:58:27 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 3/3] virtio_net: remove the unnecessary check in get_config
Date: Tue,  6 Aug 2024 08:58:03 +0800
Message-ID: <20240806005814.51651-3-lulu@redhat.com>
In-Reply-To: <20240806005814.51651-1-lulu@redhat.com>
References: <20240806005814.51651-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The vdpa device with MAC address 0 should not boot.
So remove the check here

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c144ae2e78..8a7c743ad3 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -142,7 +142,6 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
     VirtIONet *n = VIRTIO_NET(vdev);
     struct virtio_net_config netcfg;
     NetClientState *nc = qemu_get_queue(n->nic);
-    static const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
 
     int ret = 0;
     memset(&netcfg, 0 , sizeof(struct virtio_net_config));
@@ -170,18 +169,6 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
         if (ret == -1) {
             return;
         }
-
-        /*
-         * Some NIC/kernel combinations present 0 as the mac address.  As that
-         * is not a legal address, try to proceed with the address from the
-         * QEMU command line in the hope that the address has been configured
-         * correctly elsewhere - just not reported by the device.
-         */
-        if (memcmp(&netcfg.mac, &zero, sizeof(zero)) == 0) {
-            info_report("Zero hardware mac address detected. Ignoring.");
-            memcpy(netcfg.mac, n->mac, ETH_ALEN);
-        }
-
         netcfg.status |= virtio_tswap16(vdev,
                                         n->status & VIRTIO_NET_S_ANNOUNCE);
         memcpy(config, &netcfg, n->config_size);
-- 
2.45.0


