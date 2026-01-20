Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B048AD262A4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 21:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viJcZ-0007yZ-3t; Tue, 20 Jan 2026 16:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1viJcW-0007uA-5S
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 16:50:40 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1viJcT-0002fe-Vc
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 16:50:39 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 6e55ebd206cd51642717122bceebae796ce0741c995ba3e4915e6cb245ee7f8a with SMTP id
 696ff8a52696f198342e2c58; Tue, 20 Jan 2026 21:50:29 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1768945829;
 bh=Ej5O681xYjZWSg5wZN5ay/83YP28Uk0vBVTIItvtfIw=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
 From:Reply-to:Subject:Date:Message-id:To:Cc:Mime-version:
 Content-type:Content-transfer-encoding:In-reply-to:References;
 b=cGPYTk94vmX0s3u0Yte0Er3s056UWE5lT7GYyTlAJt+XwMn/jxScoRCFq7dQ6uawA
 ZsX9gUJ100b8Hm4RAWVpwggH9d1kTk7aKExss+1tgkUaBOezjxAV+WkKtmnXPI06Cv
 5d/M25KHbaX/hXX86BH0BkMmAp5vT+nDOjD8dxmMv+vxLhpxohi2W6qiNzga3G2F28
 MWkfZs8xyWgN78BenNSejBvkxQ1MZ7sMwZCO8j81kQceP2KqUP0IS8v0qdTOXYS4pH
 kB671lYDBgEtPz8K83rQAtor079xhSXwaX+elgN+rKCXIcPql1lqRQyrNhrrbkvAdI
 m5NziAaUuPbxw==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH v3 3/3] contrib/vhost-user-bridge: Add UDP receive hexdump
Date: Tue, 20 Jan 2026 15:50:21 -0600
Message-ID: <20260120215021.30711-4-yodel.eldar@yodel.dev>
In-Reply-To: <20260120215021.30711-1-yodel.eldar@yodel.dev>
References: <20260120215021.30711-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

vhost-user-bridge debug prints UDP TX hexdumps in its transmit handler,
but does not for receives, even though they are beneficial for testing.
Add an RX hexdump in the receive callback.

To delineate between transmits and receives, also add a debug print
indicating that the program is in the transmit handler.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 contrib/vhost-user-bridge/vhost-user-bridge.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/vhost-user-bridge/vhost-user-bridge.c b/contrib/vhost-user-bridge/vhost-user-bridge.c
index ce4c3426d3..3f0fd0fa49 100644
--- a/contrib/vhost-user-bridge/vhost-user-bridge.c
+++ b/contrib/vhost-user-bridge/vhost-user-bridge.c
@@ -179,6 +179,9 @@ vubr_handle_tx(VuDev *dev, int qidx)
 
     assert(qidx % 2);
 
+    DPRINT("\n\n   ***   IN UDP TRANSMIT HANDLER    ***\n\n");
+    DPRINT("    hdrlen = %d\n", hdrlen);
+
     for (;;) {
         ssize_t ret;
         unsigned int out_num;
@@ -333,6 +336,10 @@ vubr_backend_recv_cb(int sock, void *ctx)
         };
         ret = RETRY_ON_EINTR(recvmsg(vubr->backend_udp_sock, &msg, 0));
 
+        if (ret > 0 && VHOST_USER_BRIDGE_DEBUG) {
+            iov_hexdump(sg, num, stderr, "RX:", ret);
+        }
+
         if (i == 0) {
             iov_restore_front(elem->in_sg, sg, hdrlen);
         }
-- 
2.52.0


