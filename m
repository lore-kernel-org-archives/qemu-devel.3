Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811ADC3ABBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 07:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDeZD-0001gX-3G; Sat, 10 May 2025 03:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDeZA-0001gE-I3
 for qemu-devel@nongnu.org; Sat, 10 May 2025 03:24:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDeZ8-00055u-3z
 for qemu-devel@nongnu.org; Sat, 10 May 2025 03:24:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22fa414c497so33975355ad.0
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746861848; x=1747466648;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e+pMRAggeuPhoe9yc9U1qTNLL1hFaDIp/gWZePmc9Yg=;
 b=KnKt1ds91XNtd6YMX3CW59Vz5YmKGXYsM1OoQiEzxhw2xlMU971yeeYFX62ZsHS6+q
 whLSow+wucsg4ROUkizIHmnkzQnH4FG1zaMZf4nzGPZ1MXv/biiWuwssXq0O+WZX22G+
 rNzQakSRUxh04ZGgapbrO0n85+oteek01zjKixK6mRkzYIW61+youTzwePzETwWfduxU
 +RXcIl/LpbSUJNZ7E9HsyZElUx0/i7pev1HhVqP6fJdmxGe1eTDvvOmQ6QSOGQoBzRY9
 OOYdGCQmHm2ut5O1ED5pZqvMD2LFI5GamuBZcAsDiepjHFceiKRuoBIxHRn1W4qWGxRb
 vLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746861848; x=1747466648;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e+pMRAggeuPhoe9yc9U1qTNLL1hFaDIp/gWZePmc9Yg=;
 b=ZSnIZj+qZVxluX3UmNcaS30TrZnWO/l1xNoThwn7EB5QgUAkKl8grF17TyruOOUNNv
 YuIsSpy2mlfwZnD7zOCIhhb9uhfvg08RhXd3/sPI6xXeKTVNKH0u5KU3leJDi7J2AtJO
 sZ0dTWwNaoJDx3m0aZ/PKkeCUEyWuhVMhR52CXlS/iiQkMA8QCLeVobtNyWjzn2uJ23V
 1ar/pbEIQTuKjm9ygDZZp9H56SBaBXY3doKE0GRCMGs2LkMTLGC4f0EyEiMgCGHpXfAg
 OmJ7jatSW3noQwcf50zreWm5WiYZw90norLhaleuBf3Uh/kUQOTP5m4wVkKq/IhrTxBa
 hm5A==
X-Gm-Message-State: AOJu0YzfkBKJxOg1G9x1u9856pTNdYzbYC6giY9tAJauNakBQCDHMuek
 Q7Wr9iRBRhfjhlSpO6M8Jm49KLI0qvH8AmrIqh1ob4ZbktBteGYSJ0soXXIeXQI=
X-Gm-Gg: ASbGnctMeFw5op/wSPCTmiR5R565I2zkYnZv1LLsj5vijBWsafoERwIwbNeYvUb2jgk
 6HsghocvW+N23nRQ5sivpwVYIwvo6ye9DbET9woDqE2DtoN/ruEGxZwKHyYuWmA9z5AIeVJ3PCP
 OAEn49opXuw327hoUSGhhs/qR+9MGlxmwlYlXMIb82uja7XrjNapt2XyBcl7mpndrh5/4sZmPH6
 6EtEEyPw5cbYzq8BWXBf4d2Ymi51VWAUax+juefhFvRpGclsMsqeUbv69o23tMSf41cKevR/bZj
 B2COf7y5Zc2CIXdJlhiW/pW42Xf0gZQ3U1ZmPC1FNpg3hFTn2CQj
X-Google-Smtp-Source: AGHT+IFSA1lXFkASjtF5ZtMbojEPwIccDD5TkL3Tc3SLZ+f1xGXl9LyheXMK/0HKSGTeNL4HAEiLWQ==
X-Received: by 2002:a17:902:cccc:b0:22e:50fa:50d6 with SMTP id
 d9443c01a7336-22fc9185df4mr89252625ad.37.1746861848177; 
 Sat, 10 May 2025 00:24:08 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22fc82a2e4fsm27977615ad.232.2025.05.10.00.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 00:24:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 May 2025 16:24:01 +0900
Subject: [PATCH] virtio-net: Add queues for RSS during migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-n-v1-1-19ee26ac3ca6@daynix.com>
X-B4-Tracking: v=1; b=H4sIABD/HmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwMz3TzdxFTzpFQDYwtLYwsjJaC6gqLUtMwKsBnRsbW1APzHcwBTAAA
 A
X-Change-ID: 20250406-n-ae7be0389382
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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

virtio_net_pre_load_queues() inspects vdev->guest_features to tell if
VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_features
is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
VIRTIO_NET_F_MQ uses bit 22.

Instead of inferring the required number of queues from
vdev->guest_features, use the number loaded from the vm state.

Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio.h |  2 +-
 hw/net/virtio-net.c        | 11 ++++-------
 hw/virtio/virtio.c         | 14 +++++++-------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 638691028050..af52580c1e63 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -211,7 +211,7 @@ struct VirtioDeviceClass {
     int (*start_ioeventfd)(VirtIODevice *vdev);
     void (*stop_ioeventfd)(VirtIODevice *vdev);
     /* Called before loading queues. Useful to add queues before loading. */
-    int (*pre_load_queues)(VirtIODevice *vdev);
+    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);
     /* Saving and loading of a device; trying to deprecate save/load
      * use vmsd for new devices.
      */
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index de87cfadffe1..c25c6cf54183 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3026,11 +3026,10 @@ static void virtio_net_del_queue(VirtIONet *n, int index)
     virtio_del_queue(vdev, index * 2 + 1);
 }
 
-static void virtio_net_change_num_queue_pairs(VirtIONet *n, int new_max_queue_pairs)
+static void virtio_net_change_num_queues(VirtIONet *n, int new_num_queues)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     int old_num_queues = virtio_get_num_queues(vdev);
-    int new_num_queues = new_max_queue_pairs * 2 + 1;
     int i;
 
     assert(old_num_queues >= 3);
@@ -3066,16 +3065,14 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
     int max = multiqueue ? n->max_queue_pairs : 1;
 
     n->multiqueue = multiqueue;
-    virtio_net_change_num_queue_pairs(n, max);
+    virtio_net_change_num_queues(n, max * 2 + 1);
 
     virtio_net_set_queue_pairs(n);
 }
 
-static int virtio_net_pre_load_queues(VirtIODevice *vdev)
+static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
 {
-    virtio_net_set_multiqueue(VIRTIO_NET(vdev),
-                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_RSS) ||
-                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_MQ));
+    virtio_net_change_num_queues(VIRTIO_NET(vdev), n);
 
     return 0;
 }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce3744..286648fe9b60 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3255,13 +3255,6 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         config_len--;
     }
 
-    if (vdc->pre_load_queues) {
-        ret = vdc->pre_load_queues(vdev);
-        if (ret) {
-            return ret;
-        }
-    }
-
     num = qemu_get_be32(f);
 
     if (num > VIRTIO_QUEUE_MAX) {
@@ -3269,6 +3262,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         return -1;
     }
 
+    if (vdc->pre_load_queues) {
+        ret = vdc->pre_load_queues(vdev, num);
+        if (ret) {
+            return ret;
+        }
+    }
+
     for (i = 0; i < num; i++) {
         vdev->vq[i].vring.num = qemu_get_be32(f);
         if (k->has_variable_vring_alignment) {

---
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20250406-n-ae7be0389382

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


