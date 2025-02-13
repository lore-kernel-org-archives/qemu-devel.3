Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00203C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 11:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiXfN-0002y6-Lq; Thu, 13 Feb 2025 06:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1325cea77=graf@amazon.de>)
 id 1tiXfG-0002xj-5V; Thu, 13 Feb 2025 06:45:56 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1325cea77=graf@amazon.de>)
 id 1tiXfE-0005hB-DD; Thu, 13 Feb 2025 06:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1739447152; x=1770983152;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lL2Y6LqQ4b46Dr+kJFr/TmMrYftcnjDurs+LN2y3h8E=;
 b=P+Nie4bos4SgnWZOAzyFzqnFhzAs+anJJ1khfMgsCjK++RdlJULG0xWW
 Edo65M1GAObBQDIyK76u3ftsRSAJKDPPtM35yO3ahzsVGa9m2Vk7ciFGr
 dTw+YzH+OUhm5iofJw0CCkTIv63pvcR9QzKmr6uWSykRdRLz4fbLsZVWI A=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; d="scan'208";a="471830947"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 11:45:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:65043]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.115:2525]
 with esmtp (Farcaster)
 id 10549cb2-9ec4-4781-8830-434f14aa7401; Thu, 13 Feb 2025 11:45:44 +0000 (UTC)
X-Farcaster-Flow-ID: 10549cb2-9ec4-4781-8830-434f14aa7401
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 11:45:43 +0000
Received: from ip-10-253-83-51.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 11:45:42 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, Vikrant Garg
 <vikrant1garg@gmail.com>, <qemu-stable@nongnu.org>
Subject: [PATCH] hw/virtio/virtio-nsm: Respond with correct length
Date: Thu, 13 Feb 2025 11:45:41 +0000
Message-ID: <20250213114541.67515-1-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=52.95.49.90;
 envelope-from=prvs=1325cea77=graf@amazon.de; helo=smtp-fw-6002.amazon.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

When we return a response packet from NSM, we need to indicate its
length according to the content of the response. Prior to this patch, we
returned the length of the source buffer, which may confuse guest code
that relies on the response size.

Fix it by returning the response payload size instead.

Fixes: bb154e3e0cc715 ("device/virtio-nsm: Support for Nitro Secure Module device")
Reported-by: Vikrant Garg <vikrant1garg@gmail.com>
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/virtio/virtio-nsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
index 098e1aeac6..b22aa74e34 100644
--- a/hw/virtio/virtio-nsm.c
+++ b/hw/virtio/virtio-nsm.c
@@ -1596,7 +1596,7 @@ static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
     g_free(req.iov_base);
     g_free(res.iov_base);
     virtqueue_push(vq, out_elem, 0);
-    virtqueue_push(vq, in_elem, in_elem->in_sg->iov_len);
+    virtqueue_push(vq, in_elem, sz);
     virtio_notify(vdev, vq);
     return;
 
-- 
2.47.1


