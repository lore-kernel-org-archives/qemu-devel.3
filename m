Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA0BC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKtw-0000BA-V7; Sat, 15 Mar 2025 02:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKs0-0003zi-Ll; Sat, 15 Mar 2025 02:19:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKrw-0003LT-Ty; Sat, 15 Mar 2025 02:19:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A7431FF9DD;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7E9BD1CAC46;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 540D7558D1; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Graf <graf@amazon.com>,
 Vikrant Garg <vikrant1garg@gmail.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 17/51] hw/virtio/virtio-nsm: Respond with correct length
Date: Sat, 15 Mar 2025 09:17:23 +0300
Message-Id: <20250315061801.622606-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Alexander Graf <graf@amazon.com>

When we return a response packet from NSM, we need to indicate its
length according to the content of the response. Prior to this patch, we
returned the length of the source buffer, which may confuse guest code
that relies on the response size.

Fix it by returning the response payload size instead.

Fixes: bb154e3e0cc715 ("device/virtio-nsm: Support for Nitro Secure Module device")
Reported-by: Vikrant Garg <vikrant1garg@gmail.com>
Signed-off-by: Alexander Graf <graf@amazon.com>
Message-Id: <20250213114541.67515-1-graf@amazon.com>
Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Fixes: bb154e3e0cc715 (&quot;device/virtio-nsm: Support for Nitro Secure Module device&quot;)<br>
Reported-by: Vikrant Garg <vikrant1garg@gmail.com>
Signed-off-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Vikrant Garg <vikrant1garg@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 131fe64e63c88ec52c45a5946a478c0edeb31b78)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
index a3db8eef3e..5dd56cf274 100644
--- a/hw/virtio/virtio-nsm.c
+++ b/hw/virtio/virtio-nsm.c
@@ -1589,7 +1589,7 @@ static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
     g_free(req.iov_base);
     g_free(res.iov_base);
     virtqueue_push(vq, out_elem, 0);
-    virtqueue_push(vq, in_elem, in_elem->in_sg->iov_len);
+    virtqueue_push(vq, in_elem, sz);
     virtio_notify(vdev, vq);
     return;
 
-- 
2.39.5


