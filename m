Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF185C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 13:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txQgg-0008Sx-2m; Wed, 26 Mar 2025 09:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1txQge-0008SI-BG
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1txQgc-00070V-Gd
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742995249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dC+AiPaMgFsw+tPI4Vesk91t1xTDFBFSya1ekpSSiU=;
 b=FCP4qXpoADrETMwNTxN8occP5c4q/OxdEWSSCEigAgsuAQ5BzB2m8IsqmiRWl3MGzK8M4I
 1grIzNl1j/15968k9iUVQcY1yy+aBlim3fRD6Q5hcXSWNrOpQ/pmIPRmie45InHFY4J4Ie
 jgZ+LjSYzPJGluv/11b4dCq0qp3R0yM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-H8Gp0-LdO9SE3Xj8zPP3VQ-1; Wed,
 26 Mar 2025 09:20:48 -0400
X-MC-Unique: H8Gp0-LdO9SE3Xj8zPP3VQ-1
X-Mimecast-MFC-AGG-ID: H8Gp0-LdO9SE3Xj8zPP3VQ_1742995247
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08F6F196DF03
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 13:20:47 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BD7A1955BC1; Wed, 26 Mar 2025 13:20:43 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 3/4] virtio_net: Add second acceptable configuration for
 MAC setup
Date: Wed, 26 Mar 2025 21:19:32 +0800
Message-ID: <20250326132021.1215568-4-lulu@redhat.com>
In-Reply-To: <20250326132021.1215568-1-lulu@redhat.com>
References: <20250326132021.1215568-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

For VDPA devices, Allow configurations where the hardware MAC address
is non-zero while the MAC address in the QEMU command line is zero.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index a3b431e000..1fd0403d5d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3767,6 +3767,20 @@ static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
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


