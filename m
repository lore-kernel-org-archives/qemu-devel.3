Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C61C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTelp-0006CI-5H; Tue, 16 Jul 2024 05:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTelm-000648-UU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:46:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTela-0000Mb-TH
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721123198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFTtJtdsThEqMi7LJVZYeWhDHRsj81sqf11CY+bIUpM=;
 b=PSJ/MG9CIzxhjgJ9kXJMR6P9BI+NR9Q4IMShM/pHOXDDv2o8sm64p1IM60ETYeumjiCtAY
 Lyh3BMGVeXBGnE38jjqfv4d67mipUGXTnfnsugl2uGZowXlsrWXQZdxocMdfysJAmkLfdM
 uz9w/35MkWM7y5O64hQI0heJyowbYxY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-20GRXQARPnWqsfGkyA3HvQ-1; Tue,
 16 Jul 2024 05:46:34 -0400
X-MC-Unique: 20GRXQARPnWqsfGkyA3HvQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 880651955F0B; Tue, 16 Jul 2024 09:46:33 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.185])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE5AF300018D; Tue, 16 Jul 2024 09:46:28 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, jasowang@redhat.com
Cc: yanghliu@redhat.com
Subject: [PATCH 1/6] Revert "virtio-iommu: Clear IOMMUDevice when VFIO device
 is unplugged"
Date: Tue, 16 Jul 2024 11:45:03 +0200
Message-ID: <20240716094619.1713905-2-eric.auger@redhat.com>
In-Reply-To: <20240716094619.1713905-1-eric.auger@redhat.com>
References: <20240716094619.1713905-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This reverts commit 1b889d6e39c32d709f1114699a014b381bcf1cb1.
There are different problems with that tentative fix:
- Some resources are left dangling (resv_regions,
  host_resv_ranges) and memory subregions are left attached to
  the root MR although freed as embedded in the sdev IOMMUDevice.
  Finally the sdev->as is not destroyed and associated listeners
  are left.
- Even when fixing the above we observe a memory corruption
  associated with the deallocation of the IOMMUDevice. This can
  be observed when a VFIO device is hotplugged, hot-unplugged
  and a system reset is issued. At this stage we have not been
  able to identify the root cause (IOMMU MR or as structs beeing
  overwritten and used later on?).
- Another issue is HostIOMMUDevice are indexed by non aliased
  BDF whereas the IOMMUDevice is indexed by aliased BDF - yes the
  current naming is really misleading -. Given the state of the
  code I don't think the virtio-iommu device works in non
  singleton group case though.

So let's revert the patch for now. This means the IOMMU MR/as survive
the hotunplug. This is what is done in the intel_iommu for instance.
It does not sound very logical to keep those but currently there is
no symetric function to pci_device_iommu_address_space().

probe_done issue will be handled in a subsequent patch. Also
resv_regions and host_resv_regions will be deallocated separately.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio-iommu.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 33ae61c4a6..4e34dacd6e 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -467,26 +467,6 @@ static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
     return &sdev->as;
 }
 
-static void virtio_iommu_device_clear(VirtIOIOMMU *s, PCIBus *bus, int devfn)
-{
-    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
-    IOMMUDevice *sdev;
-
-    if (!sbus) {
-        return;
-    }
-
-    sdev = sbus->pbdev[devfn];
-    if (!sdev) {
-        return;
-    }
-
-    g_list_free_full(sdev->resv_regions, g_free);
-    sdev->resv_regions = NULL;
-    g_free(sdev);
-    sbus->pbdev[devfn] = NULL;
-}
-
 static gboolean hiod_equal(gconstpointer v1, gconstpointer v2)
 {
     const struct hiod_key *key1 = v1;
@@ -728,7 +708,6 @@ virtio_iommu_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
     }
 
     g_hash_table_remove(viommu->host_iommu_devices, &key);
-    virtio_iommu_device_clear(viommu, bus, devfn);
 }
 
 static const PCIIOMMUOps virtio_iommu_ops = {
-- 
2.41.0


