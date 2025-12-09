Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A87D3B997
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3yP-000136-57; Tue, 09 Dec 2025 15:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yL-0000wj-R6
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:10 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yK-0001Ix-5K
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:09 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso52820015e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310765; x=1765915565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2TsH1QuOfILL0JbSzIZnX8n/oioAmO7Rffye27/Lbio=;
 b=wBAtmHHOEVkFmSK5i8dduhuRx6ujtDU8xUvIC9mkLV+AMWrRAIX7cqUVBtbPRQnroy
 vTJDrMvKU9MGTpeBmEi9OzRdqzWx/C1vlLcudTR69GwC2IhVFeV2GwanJ/OMsVzz1UJ4
 DDAfXkOICSpWdUZwQaZrQ5TqERnlrRxB5vrpAHnzJR4X0L4uP/LFriSjTesraeJlqIA1
 0oK/qzE8HvYMZnKxLKsUwTV+ZuCixcGBOOrOQgMyUBqAXTDZGRoZljdLOX4bco1wMB0v
 QohpGkbwDlRNgi2gt3/wsF+SR5A02ds5BlHgRl7YVklfIxX/ArnxN2F6ea4sRVtLWDfz
 jlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310765; x=1765915565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2TsH1QuOfILL0JbSzIZnX8n/oioAmO7Rffye27/Lbio=;
 b=jsCBR+h6ESv2emR/VV71l2ILKv0EFk4geYaaUdxsz5mJf/qdHLrMbVzBnrttZcUhDI
 l/+8hIHeZIONiKpNEZpxH7Uls9Q3JuCj6cpVNe/j6moFxmJ9oIjEYHegMIUEYf4HzsJ9
 1qfk6pBa5wOo3bGcg0iJUSxVh/pi7Vfz3zmE4zF6QYEiYBvBvAF5juAOeEk7yAZKbU+E
 Eyacd+gumVWVhyaIKxyFcERXUdCzIs9pkc4a/VEVXDLVFZz6SulHy3/FyjSLjYJOTAjb
 ZaOEl+aDVMBGA/4Vy0Gd9Xeb0TVL9W2l2f9MRlZ5guNq27Bp1Qdcfl/t6mj/FlTchIWE
 gcdQ==
X-Gm-Message-State: AOJu0YzQ+eqNIKp7aLTdPs5BqGDn2hzeqvvPdFStPM8vkiMXT8VNmsmc
 DPjB+q/OpzFSPrkZoqwhy2H+YrjD1Xy00B7JCxe42p11VTVsJ1XXnEpKW/+jXwPZLil2i6tmsLt
 qFQrs82Q=
X-Gm-Gg: ASbGnctSFuqA56vYNo6OTeh+TLV2QsEhrCXXuVDJ/16UMJ9fPfKY9mk2KbEVr2LDQSG
 KpavFZns4kEGqB6vaQgAlOAE3qlGBizVYyhRpdIzMGnwJNc/Tf8eGgdmP1vvYvU2ayFxqrC/UOI
 2KmassJaDBAJcnxJGBvmYAyeD/DeKEm8mnq52J1GiQlE2yzj0uuq+S2SQhF3VnHol92UpOOUqFk
 V8geQpJT8mbza08Ma1xnXh+UHyikSrgydaSCi7G0slUCswiiT29n2MsSbGQp9edc6bC3ILTjQ2t
 MHEZSMFqB6+4SawgAATxF3uoG/rgE8CNI8p7f0Y0BkEeUcTpH8hpDsdLcXbmsiNzPzbnryAjQja
 bYL1oqy5rTIuqLpBw/mbLJrgBrbjqfs1gTrH4AGEVXj0Cw/HqkeKeIYP+P5O7mOLm+5DWbnVEvX
 d4Eg22ICHfnuGNBa4qr7QUqT7ffX3konWVN3nHzJUxdZLwFFYyeAa3/kMj4/LP
X-Google-Smtp-Source: AGHT+IFqxVth0wnzVr6cP3Ln91muyD60oO13YIgzEwHN5xCcbtD90JjCM8YWvRvNdn1b8nltbVnIhA==
X-Received: by 2002:a05:600c:3496:b0:477:333a:f71f with SMTP id
 5b1f17b1804b1-47a83790c18mr968935e9.17.1765310765285; 
 Tue, 09 Dec 2025 12:06:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d7efdbsm7210075e9.9.2025.12.09.12.06.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Dec 2025 12:06:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/10] vhost: Always initialize cached vring data
Date: Tue,  9 Dec 2025 21:05:31 +0100
Message-ID: <20251209200537.84097-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209200537.84097-1-philmd@linaro.org>
References: <20251209200537.84097-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hanna Czenczek <hreitz@redhat.com>

vhost_virtqueue_start() can exit early if the descriptor ring address is
0, assuming the virtqueue isn’t ready to start.

In this case, all cached vring information (size, physical address,
pointer) is left as-is.  This is OK at first startup, when that info is
still initialized to 0, but after a reset, it will retain old (outdated)
information.

vhost_virtqueue_start() must make sure these values are (re-)set
properly before exiting.

(When using an IOMMU, these outdated values can stall the device:
vhost_dev_start() deliberately produces an IOMMU miss event for each
used vring.  If used_phys contains an outdated value, the resulting
lookup may fail, forcing the device to be stopped.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251208113008.153249-1-hreitz@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/vhost.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 266a11514a1..e654ea468a0 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1261,7 +1261,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
-    hwaddr s, l, a;
+    hwaddr l;
     int r;
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_file file = {
@@ -1272,8 +1272,17 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     };
     struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
 
-    a = virtio_queue_get_desc_addr(vdev, idx);
-    if (a == 0) {
+    vq->desc_size = virtio_queue_get_desc_size(vdev, idx);
+    vq->desc_phys = virtio_queue_get_desc_addr(vdev, idx);
+    vq->desc = NULL;
+    vq->avail_size = virtio_queue_get_avail_size(vdev, idx);
+    vq->avail_phys = virtio_queue_get_avail_addr(vdev, idx);
+    vq->avail = NULL;
+    vq->used_size = virtio_queue_get_used_size(vdev, idx);
+    vq->used_phys = virtio_queue_get_used_addr(vdev, idx);
+    vq->used = NULL;
+
+    if (vq->desc_phys == 0) {
         /* Queue might not be ready for start */
         return 0;
     }
@@ -1301,24 +1310,23 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         }
     }
 
-    vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
-    vq->desc_phys = a;
-    vq->desc = vhost_memory_map(dev, a, &l, false);
-    if (!vq->desc || l != s) {
+    l = vq->desc_size;
+    vq->desc = vhost_memory_map(dev, vq->desc_phys, &l, false);
+    if (!vq->desc || l != vq->desc_size) {
         r = -ENOMEM;
         goto fail_alloc_desc;
     }
-    vq->avail_size = s = l = virtio_queue_get_avail_size(vdev, idx);
-    vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail = vhost_memory_map(dev, a, &l, false);
-    if (!vq->avail || l != s) {
+
+    l = vq->avail_size;
+    vq->avail = vhost_memory_map(dev, vq->avail_phys, &l, false);
+    if (!vq->avail || l != vq->avail_size) {
         r = -ENOMEM;
         goto fail_alloc_avail;
     }
-    vq->used_size = s = l = virtio_queue_get_used_size(vdev, idx);
-    vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
-    vq->used = vhost_memory_map(dev, a, &l, true);
-    if (!vq->used || l != s) {
+
+    l = vq->used_size;
+    vq->used = vhost_memory_map(dev, vq->used_phys, &l, true);
+    if (!vq->used || l != vq->used_size) {
         r = -ENOMEM;
         goto fail_alloc_used;
     }
-- 
2.51.0


