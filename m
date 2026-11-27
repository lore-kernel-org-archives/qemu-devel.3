Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1634A606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=OY8I12O7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp8m-00006O-Oz; Fri, 27 Nov 2026 01:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp7i-0006Qy-EJ; Fri, 27 Nov 2026 01:07:54 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp7f-00067T-8G; Fri, 27 Nov 2026 01:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=Ff+9B8nIiacnkgkAzOz84oWhFZwz1NZZn2HhJLq+AJE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OY8I12O7aTzdH8Mx4x3ERNcDP+OylXggP+/pM0D0EkY9XzS9WLxXWA9QOP15delpr
 tpWObcVzFpBzPSbj2P7Qn+5ExSmfHw2FFJtilvMPJ7GwYobLbYFcMM7ULtPm1bFjZF
 JLft9D0IGmrAqI2wCACovxnFFGTd5usJRH0w2vbKj2h6SOkReZlWlBHj6QfbbEsBYg
 /6Z/yNIBe+tQJSlVPpKRfv6nPtco1645t7oEP7fC2MoY6tQMHdi/OqhYIn2/GAEkuw
 /ThFmjClaaUaMF9zQ071hC12ge2ohywaOrQ7KiD1dUVA6LXcbQMHDzhBTQ87/iLdJ2
 QuG6YdXVcenhw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1C5351EA366;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 19B06469991;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 02B42CF31A; Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Jia Jia <physicalmtea@gmail.com>, Michael S. Tsirkin <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 116/152] hw/virtio/virtio-crypto: Drain in-flight
 operations before unrealizing (CVE-2026-50625)
Date: Fri, 27 Nov 2026 08:54:14 +0300
Message-ID: <20261127055709.39630-53-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thomas Huth <thuth@redhat.com>

virtio_crypto_device_unrealize() does not drain or cancel requests that
are sitting in the cryptodev backend's throttle delay queue. So when
hot-unplugging the device, the throttle timer callback can still run and
complete the queued operation later through the virtio_crypto_req_complete()
callback, which dereferences the already-freed VirtIOCrypto device and its
deleted virtqueue, so we end up with a host use-after-free bug here.

Fix it by draining the queue first before deleting the virtqueue and the
device.

CVE: CVE-2026-50625
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3918
Reported-by: Jia Jia <physicalmtea@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261118123948.221366-1-thuth@redhat.com>
(cherry picked from commit 902c849979ce2be367dc0a643310d6b45b76bcd4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index e8f2b18f201..1f035d0cd71 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -262,6 +262,25 @@ static void cryptodev_backend_throttle_timer_cb(void *opaque)
     }
 }
 
+void cryptodev_backend_drain_requests(CryptoDevBackend *backend)
+{
+    CryptoDevBackendOpInfo *opinfo, *tmp;
+
+    /* Cancels pending timer, prevent it from firing during or after drain */
+    if (throttle_enabled(&backend->tc)) {
+        throttle_timers_detach_aio_context(&backend->tt);
+    }
+
+    QTAILQ_FOREACH_SAFE(opinfo, &backend->opinfos, next, tmp) {
+        QTAILQ_REMOVE(&backend->opinfos, opinfo, next);
+        cryptodev_backend_operation(backend, opinfo);
+    }
+
+    if (throttle_enabled(&backend->tc)) {
+        throttle_timers_attach_aio_context(&backend->tt, qemu_get_aio_context());
+    }
+}
+
 int cryptodev_backend_crypto_operation(
                  CryptoDevBackend *backend,
                  CryptoDevBackendOpInfo *op_info)
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 85c7279aae2..6d053e7d936 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1116,6 +1116,8 @@ static void virtio_crypto_device_unrealize(DeviceState *dev)
     VirtIOCryptoQueue *q;
     int i;
 
+    cryptodev_backend_drain_requests(vcrypto->cryptodev);
+
     for (i = 0; i < vcrypto->max_queues; i++) {
         virtio_delete_queue(vcrypto->vqs[i].dataq);
         q = &vcrypto->vqs[i];
diff --git a/include/system/cryptodev.h b/include/system/cryptodev.h
index b20822df0dc..a160a6781a7 100644
--- a/include/system/cryptodev.h
+++ b/include/system/cryptodev.h
@@ -389,6 +389,15 @@ int cryptodev_backend_close_session(
            CryptoDevCompletionFunc cb,
            void *opaque);
 
+/**
+ * cryptodev_backend_drain_requests:
+ * @backend: the cryptodev backend object
+ *
+ * Drain crypto operations that might still be in flight on a throttled
+ * backend.
+ */
+void cryptodev_backend_drain_requests(CryptoDevBackend *backend);
+
 /**
  * cryptodev_backend_crypto_operation:
  * @backend: the cryptodev backend object
-- 
2.47.3


