Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3379BCF649C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 16:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suwNg-0001BC-HO; Sun, 29 Sep 2024 12:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1suwNK-0000wX-E2
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 12:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1suwNH-00053X-Ab
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 12:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727625738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VwQC8bKf/OEarvRsEXY6j875sA5t7Fkeh/Q7c0jUIl4=;
 b=DLBJt563syzddJs2KPsPjTi7H6YKFY2R+BkGwPPusdrkKoyw4CB5pWfoxKiN42zF0wV/ZH
 Ugfgy+rl62EQmo1iIG/JfFvAi/pVK5t/+yIieuObHx1IAnGRoX5qEsQ4v/fOUbNP/BOul0
 7xgvXAayrbsEjES7LR66tyvV7kjpSys=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-oItx7WseNz23LOkA9hkHRg-1; Sun,
 29 Sep 2024 12:01:07 -0400
X-MC-Unique: oItx7WseNz23LOkA9hkHRg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14F7A195FE3B
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2024 16:01:07 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9489A19373D7; Sun, 29 Sep 2024 16:01:04 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] virtio_net: Add the 2rd acceptable situation for Mac
 setup.
Date: Sun, 29 Sep 2024 23:59:56 +0800
Message-ID: <20240929160045.2133423-3-lulu@redhat.com>
In-Reply-To: <20240929160045.2133423-1-lulu@redhat.com>
References: <20240929160045.2133423-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/net/virtio-net.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7aa7308244..5c610d8078 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3607,6 +3607,18 @@ static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
         if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) == 0)) {
             return true;
         }
+        /*
+         * 2.The hardware MAC address is not 0,
+         *  and the MAC address in the QEMU command line is 0.
+         *  In this situation, the hardware MAC address will overwrite
+         *  the QEMU command line address.
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


