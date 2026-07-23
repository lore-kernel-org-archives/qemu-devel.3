Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24718C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1xq-00061w-KA; Thu, 23 Jul 2026 18:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wy-000576-6P
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:34 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wv-0001UT-DL
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:30 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-667b0ced2d3so1083336d50.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845888; x=1785450688; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1QFQi4UgZC12C/rG3wGbIoCAr9m0fHFGugO6XfGTbqc=;
 b=iHhzpPp19foWlaW/RPcFyhJP7lN1NHu2qPUuLWFitN4DVYP4zrSC3XqNHFTcXR1hQs
 jV1owfGCpPnvGusKiAEn7dnd6MyVMqiFcKo+6datBEtQ2Pk5xIPmO1PptkPyCMbvVBpq
 htfdVtfUCxqFQRgnKqp9bwFDYN9ryHwni3TRqqqke2OaalF1AfjVLM8vy1H+ntZJ6Gmq
 DOb6sjIGlJPUHFVj1YJeyPpbivHOTwtCk3/pbxRPOqgXgIWvGQ+tbmCgSIL2MhHuZKHL
 tGYctitxSKndOQ7QNO0oMTG+SAKW1eLjecyjjUhWVDxl9Lbk4uRcBBdEzzo1h1mu1tC1
 j0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845888; x=1785450688;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1QFQi4UgZC12C/rG3wGbIoCAr9m0fHFGugO6XfGTbqc=;
 b=XRSqwTUqHdSbF09vuOe3SQq3P1RmaKpGQ0ywff3b5blNtiBwyAPBewFC1uN63LsUY7
 gtwttqTR2eHb1FNpSmg01v1RHEyYHkwZNBm1oA+6dXNA1gIG0Uja6caVoe6LGZLF0Aah
 Uck+TLMMaqB7vhWfCu8Jm4AXXGiqsGmgKsAfM4OyU8WZwdv2k5kJo7d1p1+qi3pcSz5K
 6q4GjdiEvl8t2cEI244siw6HcAXY2TPlDMdJhWoIF0rBxRvUkj7lJ9HqyjOPXLwzM9/U
 UF47VjSzdP6gJKXt2zmbOen30o1/Cq3RBy4i39ugnB9aRyx1kJy9CoIVSldsHRKOSPik
 2xcQ==
X-Gm-Message-State: AOJu0YyG7MZyNdi/jiNFAfRNfaWZ/YxBjurLhr1UPsq6oNV1/IH2eT/D
 mvse08Gad8kcwhE5bgGG7pEzc6l+WDbXe82rE8Z6thSmAPD/LHzo8xAdz6nU2xbY
X-Gm-Gg: AR+sD13mh9CgzKro+XlcUvlg+aI0VDqx1H68knwIJmN4mHAUx8G8W1vyeRozW+y1Rh0
 RGRD907BiLaMqurjlfciNylKoQzEYgdSzFz1PAvJjIXq/fe48xjPGnwtgjOyC3twPFXYV/8vdux
 FTljMXv9gmhNIevqgGE3/jIz1F9Qv1SaHWtLCoUIcbjl9wz5avBoC+/+WxWOkoxerJY7Rm76YHe
 AR+FDbpbPmDoAaNuojJt6GQ2R/PnOklgTbHfR1gl8E7sj3gVRj298ssKnIHIo+t57zBBAbNIHUv
 6VwL6hOmYayzJG3cpcWi4nVoykyHDpFHgJwsqFjkLTPmMOAU1FfZXOH/Gi4yYF5SznMmz26oeMS
 ZU/PCOEsY5otAj2wdfrL7ypblIwPAtGakI+gP9o6SefU/tSnPgDGWBfjNELFPFzv41Zrjy3ZL/r
 5MVupEjII=
X-Received: by 2002:a05:690e:440d:b0:667:8b90:3577 with SMTP id
 956f58d0204a3-668a503789dmr898097d50.105.1784845888389; 
 Thu, 23 Jul 2026 15:31:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:31:27 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:12 -0700
Subject: [PATCH RFC 13/15] hw/virtio/vhost-user: add shadow virtqueues and
 eventfd intercepts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-13-6b97c439eb28@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=4076;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=0C4OJBARAj4ugns9dH114UzMJ3emOVC06QOHSGg7dNA=;
 b=7Cr+Jh0PFvuHJMvhUkVdgwIL9XxTyQhNW5PzLn4DD5mzQ22Oj5OWhm8yQ2gn2Pvw9DNYMooA8
 kVNl3CHuhXLDYIjyQp9zQdrRK2hiNrOOX2s3bPryNXpCM6/k9kMzka3
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=connorkite@gmail.com; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Adds shadow virtqueues that will eventually be used to transfer data
between device and host via bounce buffers when isolation mode is
active.  The svqs are initalized, and eventfd assignments are
intercepted so that notifications come to svqs first before
the guest or backend receive them.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-user.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index acabfb7f1c..75858289a2 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -18,6 +18,7 @@
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-net.h"
+#include "hw/virtio/vhost-shadow-virtqueue.h"
 #include "hw/virtio/vhost-iova-tree.h"
 #include "chardev/char-fe.h"
 #include "io/channel-socket.h"
@@ -365,7 +366,9 @@ struct vhost_user {
 
     /* Isolated memory data*/
     struct IsolationRegion iso_memory;
+    GPtrArray *shadow_vqs;
     VhostIOVATree *iso_iova_tree;
+    bool svqs_allocated;
 };
 
 struct scrub_regions {
@@ -1693,6 +1696,24 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
 static int vhost_user_set_vring_kick(struct vhost_dev *dev,
                                      struct vhost_vring_file *file)
 {
+    struct vhost_user *u = dev->opaque;
+    int svq_idx = file->index - dev->vq_index;
+    if (u->user->memory_isolation) {
+        VhostShadowVirtqueue *svq = g_ptr_array_index(u->shadow_vqs,
+                                                      svq_idx);
+        vhost_svq_set_svq_kick_fd(svq, file->fd);
+
+        if (svq->hdev_kick.initialized == false) {
+            int r = event_notifier_init(&svq->hdev_kick, 0);
+            if (r) {
+                error_report("Failed to create kick event notifier");
+                return r;
+            }
+        }
+
+        file->fd = event_notifier_get_fd(&svq->hdev_kick);
+    }
+
     int ret = vhost_set_vring_file(dev, VHOST_USER_SET_VRING_KICK, file);
     if (ret < 0) {
         return ret;
@@ -1721,6 +1742,24 @@ static int vhost_user_set_vring_kick(struct vhost_dev *dev,
 static int vhost_user_set_vring_call(struct vhost_dev *dev,
                                      struct vhost_vring_file *file)
 {
+    struct vhost_user *u = dev->opaque;
+    int svq_idx = file->index - dev->vq_index;
+    if (u->user->memory_isolation) {
+        VhostShadowVirtqueue *svq = g_ptr_array_index(u->shadow_vqs,
+                                                      svq_idx);
+        vhost_svq_set_svq_call_fd(svq, file->fd);
+
+        if (svq->hdev_call.initialized == false) {
+            int r = event_notifier_init(&svq->hdev_call, 0);
+            if (r) {
+                error_report("Failed to create call event notifier");
+                return r;
+            }
+        }
+
+        file->fd = event_notifier_get_fd(&svq->hdev_call);
+    }
+
     return vhost_set_vring_file(dev, VHOST_USER_SET_VRING_CALL, file);
 }
 
@@ -2715,6 +2754,17 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
+static void vhost_user_init_svq(struct vhost_dev *dev, struct vhost_user *u)
+{
+    /*Modified from vhost-vdpa*/
+    u->shadow_vqs = g_ptr_array_new_full(dev->nvqs, vhost_svq_free);
+    for (int i = 0; i < dev->nvqs; i++) {
+        VhostShadowVirtqueue *svq;
+        svq = vhost_svq_new(NULL, NULL);
+        g_ptr_array_add(u->shadow_vqs, svq);
+    }
+}
+
 static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
                                    Error **errp)
 {
@@ -2859,6 +2909,10 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
     u->postcopy_notifier.notify = vhost_user_postcopy_notifier;
     postcopy_add_notifier(&u->postcopy_notifier);
 
+    if (vus->memory_isolation) {
+        vhost_user_init_svq(dev, u);
+    }
+
     return 0;
 }
 

-- 
2.43.0


