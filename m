Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5F4C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 12:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUQ1G-0008Hs-02; Thu, 18 Jul 2024 08:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhrica@redhat.com>) id 1sUQ1E-00088K-CM
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhrica@redhat.com>) id 1sUQ1C-00014J-NP
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721304834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bd1PuNKdySoFnT6EiD3AS0xMqjrcrTU1xer1swDRTcQ=;
 b=EF4UHBwJixkrq6V7cOYl0+K0ocmGI+2O1dVkWhXwWESt8om5mTMEIxb4Kq2m/QkLW+WuKJ
 HkwWyzTdjQXAszooFBZU12JuC5NEgcNtqJ85WSRerxMwg/nvE/rv4GTjog2P8HJrCByrys
 kEnDV/rMN0hmcvZGy+kBO+dsNxGH8Pw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-wsX8-TdyPga9eMKNp7zByg-1; Thu,
 18 Jul 2024 08:13:52 -0400
X-MC-Unique: wsX8-TdyPga9eMKNp7zByg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A96A81955D48
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 12:13:51 +0000 (UTC)
Received: from m-rh-lap.brq.redhat.com (unknown [10.43.17.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 990E319560AA; Thu, 18 Jul 2024 12:13:49 +0000 (UTC)
From: Matej Hrica <mhrica@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, dbassey@redhat.com, aesteve@redhat.com,
 slp@redhat.com, Matej Hrica <mhrica@redhat.com>
Subject: [RFC PATCH 2/2] vhost-user-gpu: Add shared memory region support
Date: Thu, 18 Jul 2024 14:12:47 +0200
Message-ID: <20240718121247.181510-3-mhrica@redhat.com>
In-Reply-To: <20240718121247.181510-1-mhrica@redhat.com>
References: <20240718121247.181510-1-mhrica@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mhrica@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a 'hostmem' property to the vhost-user-gpu which enables the shared memory
in the parent object.
The memory region is created by the parent object (virtio-gpu-pci or virtio-vga)
Add a subregion (which spans the whole region) in vhost-user-gpu and register it
in the shmem_list, which enables the usage of SHMEM_MMAP/UNMAP operations.

Signed-off-by: Matej Hrica <mhrica@redhat.com>
---
 hw/display/vhost-user-gpu.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 0ebc2218b9..78a1d090d8 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -643,6 +643,30 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
     }
 
     g->vhost_gpu_fd = -1;
+
+    /*
+     * If shared memory is enabled in the config, the parent (virtio-gpu-pci,
+     * virtio-vga) has already added a shared memory region at this point.
+     * Add a subregion that spans the whole region and register it in
+     * the shmem_list to be usable for SHMEM_MMAP/UNMAP operations.
+     */
+    if (virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
+        void *hostmem_ptr = mmap(NULL, g->parent_obj.conf.hostmem,
+                                 PROT_READ | PROT_WRITE,
+                                 MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+        if (hostmem_ptr == MAP_FAILED) {
+            error_setg(errp, "Unable to mmap blank hostmem");
+            return;
+        }
+
+        virtio_new_shmem_region(vdev);
+        MemoryRegion *mr = &vdev->shmem_list[vdev->n_shmem_regions - 1];
+        memory_region_init_ram_ptr(mr,
+                                   OBJECT(vdev),
+                                   "vhost-user-gpu-hostmem",
+                                   g->parent_obj.conf.hostmem, hostmem_ptr);
+        memory_region_add_subregion(&g->parent_obj.hostmem, 0, mr);
+    }
 }
 
 static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
@@ -653,6 +677,7 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
 
 static Property vhost_user_gpu_properties[] = {
     VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
+    DEFINE_PROP_SIZE("hostmem", VhostUserGPU, parent_obj.conf.hostmem, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.45.2


