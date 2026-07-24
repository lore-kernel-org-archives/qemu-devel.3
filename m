Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D34C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCXH-00066C-My; Fri, 24 Jul 2026 05:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wnCXF-00062W-Ch
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wnCXD-0005Ex-MU
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784886579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hM0UOYu0DTtwdPVTAIBqON+Hb+wtKwg8N1qZZ9kL0UU=;
 b=dK2oPnwhR6ZUXzeoClh9uGpXuh1HH1tMuGQyX4WfB4fY37HKSYZDzUIJuPxiL8B1ez29mg
 stYo8yTrEGIGJL9EYMN5V6i6SPthTtGcs5Tu+11wlgLdECfgOb2op76p48iMJrFC9AOamt
 eFApqA88ypfrjo/6h/X9xBkpG9S1jPQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-zWmBWT5wMWaDKkw7vzwI9A-1; Fri,
 24 Jul 2026 05:49:35 -0400
X-MC-Unique: zWmBWT5wMWaDKkw7vzwI9A-1
X-Mimecast-MFC-AGG-ID: zWmBWT5wMWaDKkw7vzwI9A_1784886574
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79D5C19540C1; Fri, 24 Jul 2026 09:49:34 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BDE5B15A5; Fri, 24 Jul 2026 09:49:32 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Amit Shah <amit@kernel.org>, Jia Jia <physicalmtea@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2] hw/virtio-rng: Fix host use-after-free (CVE-2026-50624)
Date: Fri, 24 Jul 2026 11:49:31 +0200
Message-ID: <20260724094931.3005968-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fix a heap-use-after-free in the virtio-rng frontend when a delayed
rng-random backend completion arrives after the virtio-rng device has been
hot-unplugged.

Fixes: CVE-2026-50624
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3917
Reported-by: Jia Jia <physicalmtea@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2:
    - rename rng_backend_cancel_request_entropy() to
      rng_backend_cancel_requests()
    - added const to void *opaque

 backends/rng.c         | 16 ++++++++++++++++
 hw/virtio/virtio-rng.c |  2 ++
 include/system/rng.h   | 14 ++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/backends/rng.c b/backends/rng.c
index ab94dfea850a..7bed62616a52 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -68,6 +68,22 @@ static void rng_backend_free_request(RngRequest *req)
     g_free(req);
 }
 
+void rng_backend_cancel_requests(RngBackend *s,
+                                 EntropyReceiveFunc *receive_entropy,
+                                 const void *opaque)
+{
+    RngRequest *req, *next;
+
+    QSIMPLEQ_FOREACH_SAFE(req, &s->requests, next, next) {
+        if (req->receive_entropy != receive_entropy ||
+            req->opaque != opaque) {
+            continue;
+        }
+        QSIMPLEQ_REMOVE(&s->requests, req, RngRequest, next);
+        rng_backend_free_request(req);
+    }
+}
+
 static void rng_backend_free_requests(RngBackend *s)
 {
     RngRequest *req, *next;
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 66690a34dc97..d68d9011953b 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -234,6 +234,8 @@ static void virtio_rng_device_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIORNG *vrng = VIRTIO_RNG(dev);
 
+    rng_backend_cancel_requests(vrng->rng, chr_read, vrng);
+
     qemu_del_vm_change_state_handler(vrng->vmstate);
     timer_free(vrng->rate_limit_timer);
     virtio_del_queue(vdev, 0);
diff --git a/include/system/rng.h b/include/system/rng.h
index e383f87d20b2..a2667d75efd0 100644
--- a/include/system/rng.h
+++ b/include/system/rng.h
@@ -86,4 +86,18 @@ void rng_backend_request_entropy(RngBackend *s, size_t size,
  * deleted.
  */
 void rng_backend_finalize_request(RngBackend *s, RngRequest *req);
+
+/**
+ * rng_backend_cancel_requests:
+ * @s: the backend that created the request
+ * @receive_entropy: the function invoked when entropy is available
+ * @opaque: data passed to @receive_entropy
+ *
+ * This function is used by the front-end to cancel all requests to a
+ * given backend. Requests to cancel are identified by the receive_entropy
+ * function and the data passed to the function.
+ */
+void rng_backend_cancel_requests(RngBackend *s,
+                                 EntropyReceiveFunc *receive_entropy,
+                                 const void *opaque);
 #endif
-- 
2.54.0


