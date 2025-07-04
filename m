Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD3FC83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc3o-0007tY-3k; Fri, 04 Jul 2025 04:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3i-0007pU-1f
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3f-0000SX-5W
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u7HynSMK05b6lBlM28Uo8t4bq96JVAh38/zQHg3D6aM=;
 b=cehiYIAD/u2v4Cec4A6k43hbjtGwwyR/tKvQxJzEedUMKh0ZBJ3oV9WDF042AeHuziwHy3
 QGw2Bl300SF+d0gjtUu1XS3Xdtd+/KexHvGfodErVghftpW8PTT7putl5V24vpLvSkEkO+
 DH6pgagjyEU58KLJPuV4TyxGMvThL90=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-WjtOCcv8OyS-Jp8NqkQkQg-1; Fri,
 04 Jul 2025 04:46:06 -0400
X-MC-Unique: WjtOCcv8OyS-Jp8NqkQkQg-1
X-Mimecast-MFC-AGG-ID: WjtOCcv8OyS-Jp8NqkQkQg_1751618765
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEA2918002EC; Fri,  4 Jul 2025 08:46:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 900AB195E752; Fri,  4 Jul 2025 08:46:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 12/27] backends/iommufd: change process ioctl
Date: Fri,  4 Jul 2025 10:45:13 +0200
Message-ID: <20250704084528.1412959-13-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Define the change process ioctl

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-7-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/system/iommufd.h |  3 +++
 backends/iommufd.c       | 24 ++++++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 28 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 2d24d93d17e280bce53030a52588bd91425e03ea..db5f2c716c5be6cd1313045ab6dd28eb1f8356f3 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -69,6 +69,9 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
                                       uint32_t *entry_num, void *data,
                                       Error **errp);
 
+bool iommufd_change_process_capable(IOMMUFDBackend *be);
+bool iommufd_change_process(IOMMUFDBackend *be, Error **errp);
+
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 OBJECT_DECLARE_TYPE(HostIOMMUDeviceIOMMUFD, HostIOMMUDeviceIOMMUFDClass,
                     HOST_IOMMU_DEVICE_IOMMUFD)
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 3a2ecc7f5ba67699249ae1ad632fc8a45e9b53d3..87f81a05f6465cabc5673745f95947db2bb4a4fb 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -73,6 +73,30 @@ static void iommufd_backend_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
 }
 
+bool iommufd_change_process_capable(IOMMUFDBackend *be)
+{
+    struct iommu_ioas_change_process args = {.size = sizeof(args)};
+
+    /*
+     * Call IOMMU_IOAS_CHANGE_PROCESS to verify it is a recognized ioctl.
+     * This is a no-op if the process has not changed since DMA was mapped.
+     */
+    return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
+}
+
+bool iommufd_change_process(IOMMUFDBackend *be, Error **errp)
+{
+    struct iommu_ioas_change_process args = {.size = sizeof(args)};
+    bool ret = !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
+
+    if (!ret) {
+        error_setg_errno(errp, errno, "IOMMU_IOAS_CHANGE_PROCESS fd %d failed",
+                         be->fd);
+    }
+    trace_iommufd_change_process(be->fd, ret);
+    return ret;
+}
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
 {
     int fd;
diff --git a/backends/trace-events b/backends/trace-events
index e5f3e70cd1ba7eb532c8f763b12460ef8f552245..56132d3fd22b5a217b07349c74f17e50d553a799 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -7,6 +7,7 @@ dbus_vmstate_loading(const char *id) "id: %s"
 dbus_vmstate_saving(const char *id) "id: %s"
 
 # iommufd.c
+iommufd_change_process(int fd, bool ret) "fd=%d (%d)"
 iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d owned=%d users=%d"
 iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
 iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
-- 
2.50.0


