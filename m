Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525FCC88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52Yt-0000kI-Kg; Fri, 11 Sep 2026 10:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52O8-00032N-Qk
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52O5-0008QM-Bj
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SO3n0XnxHzcPurmZyEeQNszEXfuag/bmU5uMUoRgi50=;
 b=MFWKIb0T9nMWosDNBtiUYqjZJK0PnACPnpXzGowf6VnUxdwHLVY9OG+N3D4uquZLfpZEEe
 MWgoPbCtvKJKIGVFSDU+oCnbd2OmrcfcRJ+hhD8kI19BGjA3TsV+UEpuNAC7QaVhCxIkau
 pZMESERVALtWSwTnbRGWWK/ENm6ud6E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-GrM6ooB6MO2NkU78jUtD2w-1; Fri,
 11 Sep 2026 10:37:49 -0400
X-MC-Unique: GrM6ooB6MO2NkU78jUtD2w-1
X-Mimecast-MFC-AGG-ID: GrM6ooB6MO2NkU78jUtD2w_1789137468
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B06671964CF6; Fri, 11 Sep 2026 14:37:28 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE51C3000229; Fri, 11 Sep 2026 14:37:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 26/28] hw: device AMD, Intel and ARM IOMMUs as secure
Date: Fri, 11 Sep 2026 15:36:25 +0100
Message-ID: <20260911143627.2743803-27-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These are needed in virtualization use cases to support PCI device
assignment use cases so must provide a security boundary.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/smmu-common.c  | 1 +
 hw/arm/smmuv3.c       | 2 ++
 hw/i386/amd_iommu.c   | 4 +++-
 hw/i386/intel_iommu.c | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 8e40ba603d..bca9a32e9f 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -1040,6 +1040,7 @@ static const TypeInfo smmu_base_info = {
     .class_size    = sizeof(SMMUBaseClass),
     .class_init    = smmu_base_class_init,
     .abstract      = true,
+    .secure        = true,
 };
 
 static void smmu_base_register_types(void)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ed19536a4d..2a9721b87e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2272,12 +2272,14 @@ static const TypeInfo smmuv3_type_info = {
     .instance_init = smmuv3_instance_init,
     .class_size    = sizeof(SMMUv3Class),
     .class_init    = smmuv3_class_init,
+    .secure        = true,
 };
 
 static const TypeInfo smmuv3_iommu_memory_region_info = {
     .parent = TYPE_IOMMU_MEMORY_REGION,
     .name = TYPE_SMMUV3_IOMMU_MEMORY_REGION,
     .class_init = smmuv3_iommu_memory_region_class_init,
+    .secure = true,
 };
 
 static void smmuv3_register_types(void)
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 578c27ccbe..3192609ba0 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2783,7 +2783,8 @@ static const TypeInfo amdvi_sysbus = {
     .name = TYPE_AMD_IOMMU_DEVICE,
     .parent = TYPE_X86_IOMMU_DEVICE,
     .instance_size = sizeof(AMDVIState),
-    .class_init = amdvi_sysbus_class_init
+    .class_init = amdvi_sysbus_class_init,
+    .secure = true,
 };
 
 static void amdvi_pci_class_init(ObjectClass *klass, const void *data)
@@ -2805,6 +2806,7 @@ static const TypeInfo amdvi_pci = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(AMDVIPCIState),
     .class_init = amdvi_pci_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 82c3c3b2c3..20e44590ca 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5687,6 +5687,7 @@ static const TypeInfo vtd_info = {
     .parent        = TYPE_X86_IOMMU_DEVICE,
     .instance_size = sizeof(IntelIOMMUState),
     .class_init    = vtd_class_init,
+    .secure        = true,
 };
 
 static int vtd_attrs_to_index(IOMMUMemoryRegion *iommu_mr, MemTxAttrs attrs)
-- 
2.55.0


