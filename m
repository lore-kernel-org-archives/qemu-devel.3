Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E47C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 12:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6q6U-0003Mh-Ma; Mon, 21 Apr 2025 08:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u6q5g-00039p-HR
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 08:17:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u6q5e-0002SU-ME
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 08:17:36 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224341bbc1dso35795915ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 05:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745237853; x=1745842653;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y1J/YGsXG6z5Mbaxw/Zeylbg51Zs2PDPdPQbWeOptEs=;
 b=JtkPAIshDfut5RzWF/fQMYJRxVL1Rf8i7C0Gx4q9H2tjKqeGKTnbuvNbsNxHz8nONn
 vlJIjMi5lyZpJ1QFVz81qwY6VxQZoxprbGTT0QKJHOcYQqLSchLrTYWHGbLjfFkl8fVR
 qev7UxfH+R6dIRM78OibaUmH+Hcqzzt1viYBze+1Wa9F0uxSFtyTKVe0e9MM5Cu09lY0
 GZP5vhcODDbYeMqIA97qiD8E91vhMHYWKjVbDwM9R1HdaKBvjP0V/oc8VGTKP9dj+Zqd
 OwvPA7+N+OxsxtXINY7CZDaLay2UoBD0dcIOyAuKcwFeVkq1TLOMwuKYd2W46wS0B7tL
 +8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745237853; x=1745842653;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1J/YGsXG6z5Mbaxw/Zeylbg51Zs2PDPdPQbWeOptEs=;
 b=EDZbq8VljGTUcj8oSAEY2Ul5VF7s7M9ex5xXmiWwOye8O9ZukUIhlUJaPo7M2XU+hn
 6095j0aBTkAQ583lkdAYzrRhYiueh7Rdt1HVn2MnXQ0KNBIj5iTIC6QwS7AQRZhv9tEL
 xvb3Qr0+PfQwaDf3q/DnrLpaPRlcU/Xn7Io7MS89s4A6oUGriP51LXIitijC7JihSXrj
 3EkOQ+KLGE7Z2yfDWmReEFPnysA9D+G8vxsXQEHSwQsAlLz0V+3Kg9f+xaWEAyR2bXgC
 clpmIU65VfGRUVXpexJSkYfC0l0sYPADSpX8Q7yQvutJ3dEveWxNuEc4DwA2tutoe9gw
 4wCg==
X-Gm-Message-State: AOJu0Yw3kaec2nmMKywfecpSn0nuk5Kxs/sP2SDSreecAiBrexXwYLnn
 cjUyfKTUumwKLu/sfvTvUYTSFZXLUC0dSlOWlvTXc3uOk0Sf4EGMJ5nCUuQXB0nFJRSQiTbPRlE
 svyI=
X-Gm-Gg: ASbGnctqfq3vZ4YN+F+oFh8LW2lKIg9q0yEaqfP8bs2ZwO8MHitkRYb0FthK8WJspFC
 Bwy5CFOsRhFeKt0gUrf/CEcG6QMzZiC3KruLJuBi4J8Bn5QJGp0WGQRodrzo/kBHjZofuTIYq73
 Q7OeJTydUXY1IHlHcjEegeQCrpo+BUl7s9O+q3v8Z+AgjMpzuUPcj85gdS3nAKLrKtmYEQx6swU
 blegwJnC5Pjv+v/H1rpHkBOKRoGfgR0U71UBGzukhNMy+M4chtrZk2BJnCiMzYdditwD4hqBp0t
 v42WSnh7AnuQ2NC3460AmQlgsd6Fa9rhIOg8AP2MIauo4SU=
X-Google-Smtp-Source: AGHT+IENEcJZ3z085aF/Eipr9GYFxxGSTn7lf6sKF5Yt0jXTcdB2LexbcBpoqcC20X1MsapSL5WhVg==
X-Received: by 2002:a17:903:1a0d:b0:220:e156:63e0 with SMTP id
 d9443c01a7336-22c53566fe7mr137364495ad.8.1745237853169; 
 Mon, 21 Apr 2025 05:17:33 -0700 (PDT)
Received: from localhost ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22c50bf398fsm64053525ad.66.2025.04.21.05.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 05:17:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 21 Apr 2025 21:17:21 +0900
Subject: [PATCH v2 2/2] virtio: Move virtio_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-reset-v2-2-e4c1ead88ea1@daynix.com>
References: <20250421-reset-v2-0-e4c1ead88ea1@daynix.com>
In-Reply-To: <20250421-reset-v2-0-e4c1ead88ea1@daynix.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move virtio_reset() to a later part of the file to remove the forward
declaration of virtio_set_features_nocheck() and to prepare the
situation that we need more operations to perform during reset.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/virtio.c | 88 ++++++++++++++++++++++++++----------------------------
 1 file changed, 43 insertions(+), 45 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 755260981efd..033e87cdd3b9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2316,51 +2316,6 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
     }
 }
 
-static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val);
-
-void virtio_reset(void *opaque)
-{
-    VirtIODevice *vdev = opaque;
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
-    int i;
-
-    virtio_set_status(vdev, 0);
-    if (current_cpu) {
-        /* Guest initiated reset */
-        vdev->device_endian = virtio_current_cpu_endian();
-    } else {
-        /* System reset */
-        vdev->device_endian = virtio_default_endian();
-    }
-
-    if (k->get_vhost) {
-        struct vhost_dev *hdev = k->get_vhost(vdev);
-        /* Only reset when vhost back-end is connected */
-        if (hdev && hdev->vhost_ops) {
-            vhost_reset_device(hdev);
-        }
-    }
-
-    if (k->reset) {
-        k->reset(vdev);
-    }
-
-    vdev->start_on_kick = false;
-    vdev->started = false;
-    vdev->broken = false;
-    virtio_set_features_nocheck(vdev, 0);
-    vdev->queue_sel = 0;
-    vdev->status = 0;
-    vdev->disabled = false;
-    qatomic_set(&vdev->isr, 0);
-    vdev->config_vector = VIRTIO_NO_VECTOR;
-    virtio_notify_vector(vdev, vdev->config_vector);
-
-    for(i = 0; i < VIRTIO_QUEUE_MAX; i++) {
-        __virtio_queue_reset(vdev, i);
-    }
-}
-
 void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
 {
     if (!vdev->vq[n].vring.num) {
@@ -3171,6 +3126,49 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
     return ret;
 }
 
+void virtio_reset(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    int i;
+
+    virtio_set_status(vdev, 0);
+    if (current_cpu) {
+        /* Guest initiated reset */
+        vdev->device_endian = virtio_current_cpu_endian();
+    } else {
+        /* System reset */
+        vdev->device_endian = virtio_default_endian();
+    }
+
+    if (k->get_vhost) {
+        struct vhost_dev *hdev = k->get_vhost(vdev);
+        /* Only reset when vhost back-end is connected */
+        if (hdev && hdev->vhost_ops) {
+            vhost_reset_device(hdev);
+        }
+    }
+
+    if (k->reset) {
+        k->reset(vdev);
+    }
+
+    vdev->start_on_kick = false;
+    vdev->started = false;
+    vdev->broken = false;
+    virtio_set_features_nocheck(vdev, 0);
+    vdev->queue_sel = 0;
+    vdev->status = 0;
+    vdev->disabled = false;
+    qatomic_set(&vdev->isr, 0);
+    vdev->config_vector = VIRTIO_NO_VECTOR;
+    virtio_notify_vector(vdev, vdev->config_vector);
+
+    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+        __virtio_queue_reset(vdev, i);
+    }
+}
+
 static void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
                                                            Error **errp)
 {

-- 
2.49.0


