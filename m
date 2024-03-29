Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E14C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 07:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq6Oh-0007Gs-ON; Fri, 29 Mar 2024 03:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq6Od-0007G1-DE
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq6Ob-0001AU-NR
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711696283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4As8JaK3y8VkpGR+a4ziVkT+Y/hQh/LFQi6Zbs0dgI=;
 b=LOh2A5Pd/QFX185isi8Rc+LYVEaO4GClC9fp7UfU2rAA/Qi8T5NS0zECvmVDOkrRksjbDm
 ldsRagrAgAMcI0zPXBcfSHLqj9W8bFIjTIUpKp/wiJG76XiRFxYYJiVq0eQCDa5/Ke9J0J
 FwwuHh8BWi688tzu20TLSLkgBZ4mgf4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-dvL3COVpPqem_zgfWiN2rA-1; Fri,
 29 Mar 2024 03:11:19 -0400
X-MC-Unique: dvL3COVpPqem_zgfWiN2rA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65FE83C0254B;
 Fri, 29 Mar 2024 07:11:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EB3DC423E0;
 Fri, 29 Mar 2024 07:11:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 3/5] hw/net/net_tx_pkt: Fix virtio header without checksum
 offloading
Date: Fri, 29 Mar 2024 15:10:58 +0800
Message-ID: <20240329071100.31376-4-jasowang@redhat.com>
In-Reply-To: <20240329071100.31376-1-jasowang@redhat.com>
References: <20240329071100.31376-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

It is incorrect to have the VIRTIO_NET_HDR_F_NEEDS_CSUM set when
checksum offloading is disabled so clear the bit.

TCP/UDP checksum is usually offloaded when the peer requires virtio
headers because they can instruct the peer to compute checksum. However,
igb disables TX checksum offloading when a VF is enabled whether the
peer requires virtio headers because a transmitted packet can be routed
to it and it expects the packet has a proper checksum. Therefore, it
is necessary to have a correct virtio header even when checksum
offloading is disabled.

A real TCP/UDP checksum will be computed and saved in the buffer when
checksum offloading is disabled. The virtio specification requires to
set the packet checksum stored in the buffer to the TCP/UDP pseudo
header when the VIRTIO_NET_HDR_F_NEEDS_CSUM bit is set so the bit must
be cleared in that case.

Fixes: ffbd2dbd8e64 ("e1000e: Perform software segmentation for loopback")
Buglink: https://issues.redhat.com/browse/RHEL-23067
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/net_tx_pkt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 2e5f58b3c9..2134a18c4c 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -833,6 +833,7 @@ bool net_tx_pkt_send_custom(struct NetTxPkt *pkt, bool offload,
 
     if (offload || gso_type == VIRTIO_NET_HDR_GSO_NONE) {
         if (!offload && pkt->virt_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+            pkt->virt_hdr.flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
             net_tx_pkt_do_sw_csum(pkt, &pkt->vec[NET_TX_PKT_L2HDR_FRAG],
                                   pkt->payload_frags + NET_TX_PKT_PL_START_FRAG - 1,
                                   pkt->payload_len);
-- 
2.42.0


