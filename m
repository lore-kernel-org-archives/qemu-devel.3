Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362A2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWG4K-00083s-LD; Tue, 23 Jul 2024 10:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4G-0007uv-8V
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4E-0003eR-E1
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721743236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RIzxcHlTUnXXEN3gGBhKdomiNcQkqsc1CXw0al+SQeM=;
 b=c6x41URjxSV61GyyIUrd0GINUMw0Ch0PD6KCFRz7mXYCyuTXbzj4Hs4Ef385GgNQoEW7JA
 cFCOpZBwFtHx1vEL68ag5CZWk9R9gHxIS8FTGF2JvXFBOooF6ifG3j4TWNvyU/4ijCnWFN
 MfDr83ZD6vBV+Gn6npRWWKBPBev+SkM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-01gOCSz7N5e9t3a5E6yegA-1; Tue,
 23 Jul 2024 10:00:29 -0400
X-MC-Unique: 01gOCSz7N5e9t3a5E6yegA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 883061944A8B; Tue, 23 Jul 2024 14:00:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.91])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BFA6195605A; Tue, 23 Jul 2024 14:00:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 02/16] vfio/pci: Extract mdev check into an helper
Date: Tue, 23 Jul 2024 16:00:05 +0200
Message-ID: <20240723140019.387786-3-clg@redhat.com>
In-Reply-To: <20240723140019.387786-1-clg@redhat.com>
References: <20240723140019.387786-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Joao Martins <joao.m.martins@oracle.com>

In preparation to skip initialization of the HostIOMMUDevice for mdev,
extract the checks that validate if a device is an mdev into helpers.

A vfio_device_is_mdev() is created, and subsystems consult VFIODevice::mdev
to check if it's mdev or not.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/helpers.c             | 14 ++++++++++++++
 hw/vfio/pci.c                 | 12 +++---------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e8ddf92bb18547f0d3b811b3d757cbae7fec8b8d..98acae8c1c975390c6cd0fdc02a1282f64ea2987 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -116,6 +116,7 @@ typedef struct VFIODevice {
     DeviceState *dev;
     int fd;
     int type;
+    bool mdev;
     bool reset_works;
     bool needs_reset;
     bool no_mmap;
@@ -231,6 +232,7 @@ void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
 struct vfio_device_info *vfio_get_device_info(int fd);
+bool vfio_device_is_mdev(VFIODevice *vbasedev);
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index b14edd46edc9069bb148359a1b419253ff4e5ef0..7e23e9080c9d2860dea51ca5ef5fbc840d42a32d 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -675,3 +675,17 @@ int vfio_device_get_aw_bits(VFIODevice *vdev)
 
     return HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX;
 }
+
+bool vfio_device_is_mdev(VFIODevice *vbasedev)
+{
+    g_autofree char *subsys = NULL;
+    g_autofree char *tmp = NULL;
+
+    if (!vbasedev->sysfsdev) {
+        return false;
+    }
+
+    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
+    subsys = realpath(tmp, NULL);
+    return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e03d9f3ba5461f55f6351d937aba5d522a9128ec..b34e91468a533ab4d550bf2392e940b867f7b34c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2963,12 +2963,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     ERRP_GUARD();
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
-    char *subsys;
     int i, ret;
-    bool is_mdev;
     char uuid[UUID_STR_LEN];
     g_autofree char *name = NULL;
-    g_autofree char *tmp = NULL;
 
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -2997,14 +2994,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
      * stays in sync with the active working set of the guest driver.  Prevent
      * the x-balloon-allowed option unless this is minimally an mdev device.
      */
-    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
-    subsys = realpath(tmp, NULL);
-    is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
-    free(subsys);
+    vbasedev->mdev = vfio_device_is_mdev(vbasedev);
 
-    trace_vfio_mdev(vbasedev->name, is_mdev);
+    trace_vfio_mdev(vbasedev->name, vbasedev->mdev);
 
-    if (vbasedev->ram_block_discard_allowed && !is_mdev) {
+    if (vbasedev->ram_block_discard_allowed && !vbasedev->mdev) {
         error_setg(errp, "x-balloon-allowed only potentially compatible "
                    "with mdev devices");
         goto error;
-- 
2.45.2


