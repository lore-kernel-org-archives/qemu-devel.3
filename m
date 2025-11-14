Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFBACDB481
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 03:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJknq-0004Pz-GP; Thu, 13 Nov 2025 22:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJknn-0004Ob-Dm
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 22:48:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJknl-0003Vj-JY
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 22:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763092125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xESHkyCgDZUuElSFICc3k0Xt2tWmu58rcuZH0lYtxR8=;
 b=NCgqRvuzVbaWZAyiskBQGUFngZbyw0z/y2oOdmcQ3L9mv6vUbIUB0bXd2Zk2Yd9baZXtsw
 xSUUN8WW4eX+gtbLpmKgG9Yj/vKt4m/iW3MWDb/KwS3FYGS/oAFdt6oYimwUNgaq5FL5By
 zQOYq3zalghbfRSzdri2MA9OSRB9NdE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-Q7j3h3mwNGKBR6T-y9DWLw-1; Thu,
 13 Nov 2025 22:48:43 -0500
X-MC-Unique: Q7j3h3mwNGKBR6T-y9DWLw-1
X-Mimecast-MFC-AGG-ID: Q7j3h3mwNGKBR6T-y9DWLw_1763092122
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CCEF180048E; Fri, 14 Nov 2025 03:48:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A94618002B6; Fri, 14 Nov 2025 03:48:37 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 5/5] net: pad packets to minimum length in qemu_receive_packet()
Date: Fri, 14 Nov 2025 11:48:06 +0800
Message-ID: <20251114034806.2440-6-jasowang@redhat.com>
In-Reply-To: <20251114034806.2440-1-jasowang@redhat.com>
References: <20251114034806.2440-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In commits like 969e50b61a28 ("net: Pad short frames to minimum size
before sending from SLiRP/TAP") we switched away from requiring
network devices to handle short frames to instead having the net core
code do the padding of short frames out to the ETH_ZLEN minimum size.
We then dropped the code for handling short frames from the network
devices in a series of commits like 140eae9c8f7 ("hw/net: e1000:
Remove the logic of padding short frames in the receive path").

This missed one route where the device's receive code can still see a
short frame: if the device is in loopback mode and it transmits a
short frame via the qemu_receive_packet() function, this will be fed
back into its own receive code without being padded.

Add the padding logic to qemu_receive_packet().

This fixes a buffer overrun which can be triggered in the
e1000_receive_iov() logic via the loopback code path.

Other devices that use qemu_receive_packet() to implement loopback
are cadence_gem, dp8393x, lan9118, msf2-emac, pcnet, rtl8139
and sungem.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3043
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/net.c b/net/net.c
index 27e0d27807..8aefdb3424 100644
--- a/net/net.c
+++ b/net/net.c
@@ -775,10 +775,20 @@ ssize_t qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size)
 
 ssize_t qemu_receive_packet(NetClientState *nc, const uint8_t *buf, int size)
 {
+    uint8_t min_pkt[ETH_ZLEN];
+    size_t min_pktsz = sizeof(min_pkt);
+
     if (!qemu_can_receive_packet(nc)) {
         return 0;
     }
 
+    if (net_peer_needs_padding(nc)) {
+        if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
+            buf = min_pkt;
+            size = min_pktsz;
+        }
+    }
+
     return qemu_net_queue_receive(nc->incoming_queue, buf, size);
 }
 
-- 
2.42.0


