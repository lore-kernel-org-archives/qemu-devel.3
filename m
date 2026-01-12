Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7212CF45D8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 23:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQvR-0003Kt-UB; Mon, 12 Jan 2026 18:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vfQvQ-0003KC-AM
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 18:02:16 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vfQvO-0006IJ-Nq
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 18:02:16 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 9034cdd405f10f7bd058b0d51d498517515ee3791efb5c917effaaa0d63f5937 with SMTP id
 69657d6e881ee7b9b8d5a3c3; Mon, 12 Jan 2026 23:02:06 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1768258926;
 bh=xwtjK7x6BTDlVvAv7/H3jIfDh9ywaqSThR0qDBIpM7Q=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:From:Reply-to:
 Subject:Date:Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=kHEXVRIFhQJpSNClxycx0Gkx4oCrBoOwRRJpI+zMWMo2GRtNPASJVvGiVBzJ9uPy0
 voAo+0pOs9M07mk9/l7CzCqifKDNyyY4736Ry9qFJDQ6bfddmTO9y7MUjQUqbKzMcv
 YECSqf5RIhGsG24HBFH74yfFsLfS3XE1aNPdao7NzgvGxmDaZwC57ztPe1ISX6oMu1
 uIDZtja+Fbvk1WOAsBBKLyM+ujtaV7L1EoIGqo5y+pAJ7NPbi8kWzi+O7iWW4ugL+e
 +WQgQt9m+HW8ZQODphuKIwFXi+o0d9mU6248tILDs6EZ4t5cw0+m08WNuFKOHDXYhp
 ritXFhYo/GLQg==
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
Subject: [RFC PATCH v2 3/3] contrib/vhost-user-bridge: Add UDP receive hexdump
Date: Mon, 12 Jan 2026 17:01:27 -0600
Message-ID: <20260112230127.99125-4-yodel.eldar@yodel.dev>
In-Reply-To: <20260112230127.99125-1-yodel.eldar@yodel.dev>
References: <20260112230127.99125-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


