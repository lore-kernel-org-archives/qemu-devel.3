Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00ADC61CE7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6CC-0006dT-3P; Thu, 05 Jun 2025 04:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6C4-0006cX-MV
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6C2-0008Gi-QG
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749113002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJ3p6F/+Ne3AztxF8uDtog14rFuE5GbDTI3fcbvrIOs=;
 b=T5LsKw2xYitG4MCyC9N2/vSqMqTQD6GT/R2tho0Gi7Q0eQ2xipVW2tA4g6MyYR95OzzycB
 7oSQNu+gE3IbrSj/UW/6156a/hO3yRkVTch/PiHordZLXvwORdJwR9a7z/zxYp/Bpa6Hf0
 dqfFkMCk0cQym4PRxd+0+mxV/RWnTzc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-WbPyQeVpNwWZPHPza3_MEQ-1; Thu,
 05 Jun 2025 04:43:19 -0400
X-MC-Unique: WbPyQeVpNwWZPHPza3_MEQ-1
X-Mimecast-MFC-AGG-ID: WbPyQeVpNwWZPHPza3_MEQ_1749112998
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1302C18007E1; Thu,  5 Jun 2025 08:43:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEB461954B33; Thu,  5 Jun 2025 08:43:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 10/16] backends/iommufd: Add a helper to invalidate
 user-managed HWPT
Date: Thu,  5 Jun 2025 10:42:39 +0200
Message-ID: <20250605084245.1520562-11-clg@redhat.com>
In-Reply-To: <20250605084245.1520562-1-clg@redhat.com>
References: <20250605084245.1520562-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

This helper passes cache invalidation request from guest to invalidate
stage-1 page table cache in host hardware.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250604062115.4004200-2-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/system/iommufd.h |  4 ++++
 backends/iommufd.c       | 36 ++++++++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 41 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index cbab75bfbf67fe75e97dffbbbd2d98caca7f7c5e..83ab8e1e4ca034ecad07e08d55ef3cb5183b1fe2 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -61,6 +61,10 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
                                       uint64_t iova, ram_addr_t size,
                                       uint64_t page_size, uint64_t *data,
                                       Error **errp);
+bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
+                                      uint32_t data_type, uint32_t entry_len,
+                                      uint32_t *entry_num, void *data,
+                                      Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index b73f75cd0bca694267e8c54af9750f08cd305a50..8bcdb60fe7ee439503f0fcc4d65d50c5916dcf1f 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -311,6 +311,42 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
     return true;
 }
 
+bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
+                                      uint32_t data_type, uint32_t entry_len,
+                                      uint32_t *entry_num, void *data,
+                                      Error **errp)
+{
+    int ret, fd = be->fd;
+    uint32_t total_entries = *entry_num;
+    struct iommu_hwpt_invalidate cache = {
+        .size = sizeof(cache),
+        .hwpt_id = id,
+        .data_type = data_type,
+        .entry_len = entry_len,
+        .entry_num = total_entries,
+        .data_uptr = (uintptr_t)data,
+    };
+
+    ret = ioctl(fd, IOMMU_HWPT_INVALIDATE, &cache);
+    trace_iommufd_backend_invalidate_cache(fd, id, data_type, entry_len,
+                                           total_entries, cache.entry_num,
+                                           (uintptr_t)data, ret ? errno : 0);
+    *entry_num = cache.entry_num;
+
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_HWPT_INVALIDATE failed:"
+                         " total %d entries, processed %d entries",
+                         total_entries, cache.entry_num);
+    } else if (total_entries != cache.entry_num) {
+        error_setg(errp, "IOMMU_HWPT_INVALIDATE succeed but with unprocessed"
+                         " entries: total %d entries, processed %d entries."
+                         " Kernel BUG?!", total_entries, cache.entry_num);
+        return false;
+    }
+
+    return !ret;
+}
+
 static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
 {
     HostIOMMUDeviceCaps *caps = &hiod->caps;
diff --git a/backends/trace-events b/backends/trace-events
index 40811a316215bad7b8554cedf3b8ba1968a6fbfe..7278214ea51144b7d7b36d64908567c9467036e8 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -18,3 +18,4 @@ iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
+iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
-- 
2.49.0


