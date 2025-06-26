Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4F6C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhIt-0004No-TK; Thu, 26 Jun 2025 03:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhIr-0004NU-Na
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhIp-0001vG-TN
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750923946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGinRN5UYQIQXdu8qzSrfoWxXQNkX7kh8kvKzxPuFBc=;
 b=NI7Pptnap2WC71XInHXosjXnR+zXU/ZcR3r8z0dAMlsQluiwNw09yIJ1v4nPkKC6zU3HBj
 tDdtyF11WCha0jT6+pC+e9RQ8IRL1ldwfNdqRrnLYnxOvYI7+8tGA4EuYdP6xHS3HA45hf
 f1yPU3qoBipX5xakV9MFtEW1yP4phJY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-zoaH5A2DOqKu6jGsQYIJTg-1; Thu,
 26 Jun 2025 03:45:40 -0400
X-MC-Unique: zoaH5A2DOqKu6jGsQYIJTg-1
X-Mimecast-MFC-AGG-ID: zoaH5A2DOqKu6jGsQYIJTg_1750923939
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7851C18002ED; Thu, 26 Jun 2025 07:45:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60B59180035C; Thu, 26 Jun 2025 07:45:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/25] vfio: add vfio_device_get_region_fd()
Date: Thu, 26 Jun 2025 09:45:06 +0200
Message-ID: <20250626074529.1384114-3-clg@redhat.com>
In-Reply-To: <20250626074529.1384114-1-clg@redhat.com>
References: <20250626074529.1384114-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Levon <john.levon@nutanix.com>

This keeps the existence of ->region_fds private to hw/vfio/device.c.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20250616101337.3190027-1-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h | 12 ++++++++++++
 hw/vfio/device.c              |  7 +++++++
 hw/vfio/region.c              |  5 +----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index d45e5a68a24e7990fa93ce6549f5710b4f25a037..1926adb0a35c7d61ea84fb63de8a83f719578053 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -256,6 +256,18 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
                                      uint32_t subtype, struct vfio_region_info **info);
+
+/**
+ * Return the fd for mapping this region. This is either the device's fd (for
+ * e.g. kernel vfio), or a per-region fd (for vfio-user).
+ *
+ * @vbasedev: #VFIODevice to use
+ * @index: region index
+ *
+ * Returns the fd.
+ */
+int vfio_device_get_region_fd(VFIODevice *vbasedev, int index);
+
 bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
 
 int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index d32600eda1a282adaa4c58cfeb80c19c6489ee92..d91c695b69b67ff8f09f590d3fcca8f30f259170 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -243,6 +243,13 @@ retry:
     return 0;
 }
 
+int vfio_device_get_region_fd(VFIODevice *vbasedev, int index)
+{
+        return vbasedev->region_fds ?
+               vbasedev->region_fds[index] :
+               vbasedev->fd;
+}
+
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
                                      uint32_t subtype, struct vfio_region_info **info)
 {
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index f5b8e3cbf100f4f1b9fb916075653d3a6e1ca8d4..d04c57db630f3742ea90730e5b58d9aa8b60ffed 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -273,10 +273,7 @@ int vfio_region_mmap(VFIORegion *region)
             goto no_mmap;
         }
 
-        /* Use the per-region fd if set, or the shared fd. */
-        fd = region->vbasedev->region_fds ?
-             region->vbasedev->region_fds[region->nr] :
-             region->vbasedev->fd,
+        fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
 
         map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
         munmap(map_base, map_align - map_base);
-- 
2.49.0


