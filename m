Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAF6CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBR-0003BD-7K; Sun, 14 Jun 2026 15:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBQ-00038u-4b
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBO-00022T-KW
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=42Wx/LEWh6GcKpP6Zwkqps4q+eKptoyc2d1gA9UxQqU=;
 b=Fp5tqUgKtbIxR1HmvDUgl6r5mYYkD4MQfUUwHTVnQxKwpNEFFzg5m+xnHyfd+Tqej2WUL3
 C+++LGTOMpGWiXCBbDv5sXw5Ee/y3YEcwFyBULJ5oZ/ix2+c4rgc87EUShaRVKE8wfWmUu
 jh0QHgN845nr4LcEQlbX7/1K8nzZhIk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-_IgE74-iMIe7aToCLT2I-Q-1; Sun, 14 Jun 2026 15:07:44 -0400
X-MC-Unique: _IgE74-iMIe7aToCLT2I-Q-1
X-Mimecast-MFC-AGG-ID: _IgE74-iMIe7aToCLT2I-Q_1781464063
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef3aeeb41so1608473f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464063; x=1782068863; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=42Wx/LEWh6GcKpP6Zwkqps4q+eKptoyc2d1gA9UxQqU=;
 b=fRgKKSoqXH84n7/HcBhVVbxWcE6VPhJh41CTHLvvPVO5hTZ2If8QkFSlvXl3cNUtO4
 x6kAIdEkKmK5+aYShZGtL+pZG5VK/lEjhiqgG6fbNqcnEhpXHtSiOpEoF5IZlYUrIa84
 HoUBjcrdbLKlDEb0UKIUJlD5EK3M5bbs3OpBOE1UZ6ZgIlLCzP7h3UYdEMPudjVeOV5i
 6yiufV6ULlQlauRfRFwLuqC6U2IxeYYCg050jn/eWjXS3Zx2IBXNt+dwtFmMU0gU6FyS
 lnhPDSy1R8xlDdsvgeBzHXpUG9iY9cW/hmPKJQrHhQdNFu/iwR/lcdg0q/clI/kZlr9Z
 wE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464063; x=1782068863;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42Wx/LEWh6GcKpP6Zwkqps4q+eKptoyc2d1gA9UxQqU=;
 b=Q7vZLR6N4OdaUEGXyyj2J2/UP3n2ENtJgjFi8EO+M7QDfvdboZfA0d8ne2f8dksIDT
 X9VXn9HJZgfhQ5EM/gOtQQ5YklZ7bo7VKFKwn7rfmG1ivTlQQZChqjQgMOJPFvHanP+A
 +WaAPAspovLwrA5W2L2nxumvpHvSQMeKrKXViYRljKOEEUyENbCRIJd9naERXG9YY5QY
 vK2OvMYb/znCr0w6ABCffbSkiaviIu3KVkYLInQIcU+XCa3OrTAPzwzmMi8zoXYgwR9a
 z4x+szEfCY4ffi8ekDKfNQwtFgKV0Gzi3XGtwFLU+yXxwSfy2qQ9vJxWEssdexV1V43W
 ZdgA==
X-Gm-Message-State: AOJu0YyqaIk7S/Nd+9OYlz2+2o2F9A6YiQjg9caT11O+myqLkXGYe3qm
 /LftLNP1HqUVMi292YxHUznqdzFpYWNn8UdDbm/LXlzPqD2XcJSXiG5JUdlODYu6W6NzOZWT5A8
 euDIjXFyWV+Qv+I+S1GBjreZ3YF9B/YmY4yPCTtg9gvZjcTaJi5d/kDiHjs3Rt7MNvCVW/rlbzi
 DfgX3UvdeLDJ2+83XSTq0Yh03qyiWEDhy6eQ==
X-Gm-Gg: Acq92OH/JHwiLgQvYssUwMWTV9bFUaiO+XV2eLIObp9gr9koRP5cyrB2skXngdFN4g+
 TVlwhvOVhypC7WMZ7K0/lH3KiFXR/z3buq6ja8qJsF3bDTkPTDvO/YE8D+I7i/An4SiJ2pu8o4n
 O7tpFOcIG/Xv/+8t+R7H07SF037GnDmK/6ZrpdlRpfIWfr2Kzts6gfLsO/+S/k6za5K5YN0UWXj
 vileTZP1NE5/ZpkTSB2eMk1vm80Ahmh6yavm/FihQI+AWqt+PJXjrxVv2g5yRIxZa2KngL6EELN
 /wNWbZ31B2mztZDG3I+x/kNeeyMmHncsDYBGFC5pIbGO+iW0QjaQBQ5qQBq2/C8FS9L08vOAaA4
 EYrqS9qRBtfrmsAJiwWVRlH3GMX/yzLLpIAbvCqys8hM=
X-Received: by 2002:a7b:c8d9:0:b0:490:b3e7:4614 with SMTP id
 5b1f17b1804b1-490ec5020dbmr98352935e9.25.1781464063406; 
 Sun, 14 Jun 2026 12:07:43 -0700 (PDT)
X-Received: by 2002:a7b:c8d9:0:b0:490:b3e7:4614 with SMTP id
 5b1f17b1804b1-490ec5020dbmr98352695e9.25.1781464062869; 
 Sun, 14 Jun 2026 12:07:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f23fsm26725273f8f.9.2026.06.14.12.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:42 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 044/106] vhost: vhost_dev_init(): simplify features
 initialization
Message-ID: <3aedf875edd5fd2d595b4f1755a8ef2830963612.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Drop extra variable and extra function parameter passing, initialize
dev._features directly.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-19-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 55ce7ae977..93c6a5f5e9 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1560,18 +1560,17 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
     }
 }
 
-static int vhost_dev_get_features(struct vhost_dev *hdev,
-                                  uint64_t *features)
+static int vhost_dev_init_features(struct vhost_dev *hdev)
 {
     uint64_t features64;
     int r;
 
     if (hdev->vhost_ops->vhost_get_features_ex) {
-        return hdev->vhost_ops->vhost_get_features_ex(hdev, features);
+        return hdev->vhost_ops->vhost_get_features_ex(hdev, hdev->_features_ex);
     }
 
     r = hdev->vhost_ops->vhost_get_features(hdev, &features64);
-    virtio_features_from_u64(features, features64);
+    virtio_features_from_u64(hdev->_features_ex, features64);
     return r;
 }
 
@@ -1579,7 +1578,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
 {
-    uint64_t features[VIRTIO_FEATURES_NU64S];
     unsigned int used, reserved, limit;
     int i, r, n_initialized_vqs = 0;
 
@@ -1600,9 +1598,9 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = vhost_dev_get_features(hdev, features);
+    r = vhost_dev_init_features(hdev);
     if (r < 0) {
-        error_setg_errno(errp, -r, "vhost_get_features failed");
+        error_setg_errno(errp, -r, "vhost_init_features failed");
         goto fail;
     }
 
@@ -1628,8 +1626,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         }
     }
 
-    virtio_features_copy(hdev->_features_ex, features);
-
     hdev->memory_listener = (MemoryListener) {
         .name = "vhost",
         .begin = vhost_begin,
-- 
MST


