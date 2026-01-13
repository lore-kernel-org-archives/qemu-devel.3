Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43739D29DF7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfapt-0006pb-QS; Tue, 13 Jan 2026 04:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaps-0006ls-4F
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfapq-0003Io-HB
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AzcQn3ODHV+v085VDLif4nakqsbjXDjsAeKgDZNIfiQ=;
 b=RA4nCObQsNtaVcRjBwQ7MtZxIgkEDRdzFamwGG5wFSqmJs4YrI/Og3ookFI1+MbTJdVDFm
 vedWI2ajZCtwVGFAro6wnTrp558e/y03iGQEDW7deo+/w1tnuh8MeMM7zjBRfkygl6MBl/
 6TTzzMaFNa+4mbNLLOGa9IMISzbxVik=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-8JvNqaXwPxW320HQl2-bUA-1; Tue,
 13 Jan 2026 04:37:06 -0500
X-MC-Unique: 8JvNqaXwPxW320HQl2-bUA-1
X-Mimecast-MFC-AGG-ID: 8JvNqaXwPxW320HQl2-bUA_1768297025
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90C4418005B7; Tue, 13 Jan 2026 09:37:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A24BA30001A2; Tue, 13 Jan 2026 09:37:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/41] intel_iommu: Implement get_viommu_flags() callback
Date: Tue, 13 Jan 2026 10:36:04 +0100
Message-ID: <20260113093637.1549214-9-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Implement get_viommu_flags() callback and expose a request for nesting
parent HWPT for now.

VFIO uses it to create nesting parent HWPT which is further used to create
nested HWPT in vIOMMU. All these will be implemented in following patches.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260106061304.314546-7-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i386/intel_iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7bec53a58722b3e7cbf02059734b8d1613a94ed1..9ce1bab93c56cd3d303e24be43c6ae1e2c4716a0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -24,6 +24,7 @@
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "hw/core/sysbus.h"
+#include "hw/core/iommu.h"
 #include "intel_iommu_internal.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
@@ -4659,6 +4660,16 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
     vtd_iommu_unlock(s);
 }
 
+static uint64_t vtd_get_viommu_flags(void *opaque)
+{
+    IntelIOMMUState *s = opaque;
+    uint64_t flags;
+
+    flags = s->fsts ? VIOMMU_FLAG_WANT_NESTING_PARENT : 0;
+
+    return flags;
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
@@ -5312,6 +5323,7 @@ static PCIIOMMUOps vtd_iommu_ops = {
     .pri_register_notifier = vtd_pri_register_notifier,
     .pri_unregister_notifier = vtd_pri_unregister_notifier,
     .pri_request_page = vtd_pri_request_page,
+    .get_viommu_flags = vtd_get_viommu_flags,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
-- 
2.52.0


