Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F293606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fJybn4Ww
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT568-0004Od-9i; Mon, 16 Nov 2026 17:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT560-00047x-LQ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:22:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT55z-000644-5Z
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794867758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZF/GZw261j7nYjDiMSPebcgwmDkIKJCV1UxqJCvQzS4=;
 b=fJybn4Wwwj5+OZttwbSqLlJ+abuxZggMGbBsTouaPpBvbty0w0X1ihzullOfQy0rf22qZx
 Wmy6fIzIpmpwcwAWeNQCFVRYrBio2nybO0k2ioCahslF9wWDnu6xq1mxH0xb5PAsLZQq8x
 QXUEBdRRAOdYT7XJ+ld+71aZBsZWHJM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-J6oRLRE8PPqor3E7x5EV6w-1; Mon,
 16 Nov 2026 17:22:37 -0500
X-MC-Unique: J6oRLRE8PPqor3E7x5EV6w-1
X-Mimecast-MFC-AGG-ID: J6oRLRE8PPqor3E7x5EV6w_1794867756
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5531B1800576
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:22:36 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2912330001A2; Mon, 16 Nov 2026 22:22:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 24/26] hw: device AMD, Intel and ARM IOMMUs as secure
Date: Mon, 16 Nov 2026 22:21:56 +0000
Message-ID: <20261116222158.2840471-25-berrange@redhat.com>
In-Reply-To: <20261116222158.2840471-1-berrange@redhat.com>
References: <20261116222158.2840471-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These are needed in virtualization use cases to support PCI device
assignment use cases so must provide a security boundary.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/smmuv3.c       | 2 ++
 hw/i386/amd_iommu.c   | 4 +++-
 hw/i386/intel_iommu.c | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ed19536a4dc..2a9721b87e7 100644
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
index 2d5c7b5cdf6..be4b9b28ef6 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2848,7 +2848,8 @@ static const TypeInfo amdvi_sysbus = {
     .name = TYPE_AMD_IOMMU_DEVICE,
     .parent = TYPE_X86_IOMMU_DEVICE,
     .instance_size = sizeof(AMDVIState),
-    .class_init = amdvi_sysbus_class_init
+    .class_init = amdvi_sysbus_class_init,
+    .secure = true,
 };
 
 static void amdvi_pci_class_init(ObjectClass *klass, const void *data)
@@ -2870,6 +2871,7 @@ static const TypeInfo amdvi_pci = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(AMDVIPCIState),
     .class_init = amdvi_pci_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b7da5d086d3..cea27794184 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5727,6 +5727,7 @@ static const TypeInfo vtd_info = {
     .parent        = TYPE_X86_IOMMU_DEVICE,
     .instance_size = sizeof(IntelIOMMUState),
     .class_init    = vtd_class_init,
+    .secure        = true,
 };
 
 static int vtd_attrs_to_index(IOMMUMemoryRegion *iommu_mr, MemTxAttrs attrs)
-- 
2.56.1


