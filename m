Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9AE606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F8bs6n9j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRokW-0002aJ-F4; Fri, 13 Nov 2026 05:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRokU-0002Xx-H8
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:43:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRokS-0001Tq-Ul
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794566592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mFnCjpi3rLWb+N1bGtP7ph/+sE/Zoipau65ujAGZfGs=;
 b=F8bs6n9jwqUlYGW55yGgXgVD1+lO9mV10enO6/psvFukTc0IYw+PzRcWtMXUx/t3DZRG9y
 rUXWNbYSRTo+kgBI9JHvg2Xk+mKpW2oFVE2/PNsP0hB/6x5a5GbQocSbT6T412NRa1fqMs
 HncfLYfo+iZEtBORySoyzpje9mgRoP4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-G5ukWza1PHe9yAFJy4DiDA-1; Fri,
 13 Nov 2026 05:43:08 -0500
X-MC-Unique: G5ukWza1PHe9yAFJy4DiDA-1
X-Mimecast-MFC-AGG-ID: G5ukWza1PHe9yAFJy4DiDA_1794566587
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABAA31955E90; Fri, 13 Nov 2026 10:43:07 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB66A1800548; Fri, 13 Nov 2026 10:43:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Nov 2026 14:42:16 +0400
Subject: [PATCH v2 4/8] hw/display/vhost-user-gpu: reset scanouts on the
 main loop
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-issue-4848-v2-4-631414664bca@redhat.com>
References: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
In-Reply-To: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry0911@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3124;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gW55yUzAcKYL6NsFCq7rbwpdBGzQEwbu5RgezsK28jU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9umoc4hfDo86PFDZBLvZyzZhraSUALtpZiMF0
 38ztfoevfKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavbpqAAKCRDa6OEJdZac
 5S1zD/0RY1noBrJLUS85XDmCYjA3vZKktVJ7s4dnwy1N3qWdLJJGCrTkPWB2aTST32UEhkGKdy7
 5yU5RSI9Pf4ft1CjF5IbpjWQmkvn9EcNQ4oMr44765gijnR7RG+JWf+x6klTSUpYil4RtHkRCLx
 XGMRbcE/djv4qX95OeJJUdwEEd2v88ohL4Xx+A9/Q7dVarPxa9I5coYm1ybbBq/VhomCxQnCTuE
 IfaYG4XQPjQLZKjUtnRGXWO0Y0ynwll0QLK619suCE1odG0ieEoreUOT8cZTZwQ5gGpgETeRUHC
 BpQ6kNZiPu2dJGgfvD/EFA4JE3ezieNNUsiD0W/4D9kx8glx6OeD199VBiuP45RlDQ/JDDt4l6R
 bKE5xG50sgw2d+8tmaG0W/D0cChMDDy6jlDWgfugBKWeOvWbtIFef3YBVNrwbqWw4OeUlr9YTid
 4tmkbS1d7IQbQcnNdafHOPwHmNvd7kCU83F2O3qk3bhbmrTkFtQjPl5vq3x1bVXG+MPGZv5ayqa
 SMVoy2uGJbjBU5JbroioL6WsBP4mziQQOOSxg/cN7ytthBhiakXVU654MXEM2eB742MiywWvriZ
 QNEYpI0+ukpdCN43e8kk+VM1g2Y6t5NjSaGR4pplBkNZrWuNhaWgo2ZND+u/B0AojiQwXAmkpgB
 oVFYMFczwMAaFjA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vhost_user_gpu_reset() runs on the vCPU thread when the guest writes the
device status. Installing the placeholder surface there calls the
display listener without the EGL context being current, so the D-Bus
listener receives a surface without a texture and aborts on the tex_id
assertion.

Defer the display cleanup to a bottom half, as virtio_gpu_reset() does,
and wait for it when reset is triggered from a vCPU thread.

Reported-by: Dmitry R <rdmitry0911@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vhost-user-gpu.c    | 30 ++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-gpu.h |  4 ++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index d3b720d08a73..78df9abd3d0b 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -18,6 +18,7 @@
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
+#include "system/cpus.h"
 #include "standard-headers/drm/drm_fourcc.h"
 
 typedef enum VhostUserGpuRequest {
@@ -631,13 +632,16 @@ vhost_user_gpu_instance_finalize(Object *obj)
 {
     VhostUserGPU *g = VHOST_USER_GPU(obj);
 
+    g_clear_pointer(&g->reset_bh, qemu_bh_delete);
+    qemu_cond_destroy(&g->reset_cond);
+
     object_unref(OBJECT(g->vhost));
 }
 
 static void
-vhost_user_gpu_reset(VirtIODevice *vdev)
+vhost_user_gpu_reset_bh(void *opaque)
 {
-    VhostUserGPU *g = VHOST_USER_GPU(vdev);
+    VhostUserGPU *g = VHOST_USER_GPU(opaque);
     int i;
 
     /* release the scanouts before virtio_gpu_base_reset() drops ds */
@@ -653,6 +657,25 @@ vhost_user_gpu_reset(VirtIODevice *vdev)
         qemu_console_set_surface(scanout->con, NULL);
     }
 
+    g->reset_finished = true;
+    qemu_cond_signal(&g->reset_cond);
+}
+
+static void
+vhost_user_gpu_reset(VirtIODevice *vdev)
+{
+    VhostUserGPU *g = VHOST_USER_GPU(vdev);
+
+    if (qemu_in_vcpu_thread()) {
+        g->reset_finished = false;
+        qemu_bh_schedule(g->reset_bh);
+        while (!g->reset_finished) {
+            qemu_cond_wait_bql(&g->reset_cond);
+        }
+    } else {
+        aio_bh_call(g->reset_bh);
+    }
+
     virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
 
     vhost_user_backend_stop(g->vhost);
@@ -699,6 +722,9 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
         return;
     }
 
+    g->reset_bh = virtio_bh_io_new_guarded(qdev, vhost_user_gpu_reset_bh, g);
+    qemu_cond_init(&g->reset_cond);
+
     g->vhost_gpu_fd = -1;
 }
 
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 631dfc63a4d4..c8cb91032968 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -276,6 +276,10 @@ struct VhostUserGPU {
     CharFrontend vhost_chr;
     QemuDmaBuf *dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
     bool backend_blocked;
+
+    QEMUBH *reset_bh;
+    QemuCond reset_cond;
+    bool reset_finished;
 };
 
 #define MAX_SLOTS 4096

-- 
2.56.0.116.g6de20f6092dc


