Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19D0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 00:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb8X5-0003Vn-9t; Mon, 05 Aug 2024 20:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sb8X3-0003V5-Ja
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 20:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sb8X2-0003zp-02
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 20:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722905910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOOusmaimSYFokD/OzN2j0hZavQmFjM3gVve7cwPnLw=;
 b=D6oUFsXYy+DgK7FpD03EUdcw3IdgXTTZ99gbHIeqlxVSAVC42G+ujR9yKjFcNZrlWmnZaD
 rE0S8Ya0XjkPZgMXt6NCy/6TxEM9OE09fasrYtWGxnjQ7GMnr5Nsp72CPSKwCB6zdA9DiY
 fQ3rqzZDM367QOJiV4i1Lrcp0AFhTH0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-YeozxPyWOSCu5RduUX-hVw-1; Mon,
 05 Aug 2024 20:58:28 -0400
X-MC-Unique: YeozxPyWOSCu5RduUX-hVw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71C6F1955D42
 for <qemu-devel@nongnu.org>; Tue,  6 Aug 2024 00:58:27 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.8])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3CAD19560AE; Tue,  6 Aug 2024 00:58:24 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 2/3] virtio_net: Add the check for vdpa mac address
Date: Tue,  6 Aug 2024 08:58:02 +0800
Message-ID: <20240806005814.51651-2-lulu@redhat.com>
In-Reply-To: <20240806005814.51651-1-lulu@redhat.com>
References: <20240806005814.51651-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When using a VDPA device, this is another acceptable situations
The hardware MAC address is not 0, and the MAC address in the QEMU command line is 0.
This is also acceptable

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7f51bd0dd3..c144ae2e78 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3592,11 +3592,22 @@ static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n, MACAddr
      * 1.The hardware MAC address is the same as the QEMU command line MAC
      *   address, and both of them are not 0.
      */
-
+	/*
+     * 2.The hardware MAC address is not 0,
+     *  and the MAC address in the QEMU command line is 0.
+     *  In this situation, the hardware MAC address will overwrite
+     *  the QEMU command line address.
+     */
 	if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) != 0) {
 		if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) == 0)) {
 			return true;
 		}
+		if (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) == 0) {
+			/* overwrite the mac address with hardware address*/
+			memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
+			memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n->mac));
+			return true;
+		}
 	}
 	error_setg(errp, "vDPA device's mac != the mac address from qemu cmdline"
 			 "Please check the the vdpa device's setting.");
-- 
2.45.0


