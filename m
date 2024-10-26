Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E831AD10BE8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 08:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4bk4-0003vE-O3; Sat, 26 Oct 2024 04:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t4bk3-0003v4-Ag
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 04:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t4bk2-0000jW-18
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 04:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729929705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKlkXYheZX/iFDeiLoZ2HpXGEX2BvApxquUOpmEpCrc=;
 b=ABgCoBbLrAceEcf3BbgDClbFCDe36jrHseciIBLFIsudMetE3D4qbFv2EbAjLC08QDJDI/
 i1m2ylaE/WEuvRA3/CjfMqnZ4qlqeX364Mxi2U3RiouohfZHDakYQ1u7y+P0q8D/Yqlqg9
 NQt2F36zjfsMiHOwE6rHC4PvN+/ib40=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-v1Y5pS37OriOjqjCOT1rxw-1; Sat,
 26 Oct 2024 04:01:42 -0400
X-MC-Unique: v1Y5pS37OriOjqjCOT1rxw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11358195608B
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 08:01:38 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65C921956056; Sat, 26 Oct 2024 08:01:34 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] virtio_net: Add the 2rd acceptable situation for Mac
 setup.
Date: Sat, 26 Oct 2024 16:00:01 +0800
Message-ID: <20241026080121.461781-4-lulu@redhat.com>
In-Reply-To: <20241026080121.461781-1-lulu@redhat.com>
References: <20241026080121.461781-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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

When using a VDPA device, the following situations are
also acceptable: the hardware MAC address is not 0,
and the MAC address in the QEMU command line is 0.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 0b342d0cc2..6900e3c44b 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3607,6 +3607,20 @@ static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
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


