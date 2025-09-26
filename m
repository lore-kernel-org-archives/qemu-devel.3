Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD277CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v293z-0007Pz-MH; Fri, 26 Sep 2025 10:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293q-0007HU-QO
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293g-0004vp-MR
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=okvnAzNjwQR5hgm//DrI3IoAMik3uXuFNRrwbadnKH4=;
 b=d9qXPIfrcnGxeAT1ZgtNFtjmKURFpROGgQ2qpLDWexoPv/O0+8lu1iExB6wqTCgSCPBYw0
 nR0YlXPncSwUz5qJxISbS17HgyWXJkPKCtRLuXxzpeDmoEl3gQ7c8DuPcnkldg7EnOwZkq
 S6by+vnh7xpagad0bAlPFho9D+Dx1wM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-NjgFToZYOii6K-I5bG0-Qg-1; Fri,
 26 Sep 2025 10:04:18 -0400
X-MC-Unique: NjgFToZYOii6K-I5bG0-Qg-1
X-Mimecast-MFC-AGG-ID: NjgFToZYOii6K-I5bG0-Qg_1758895457
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3011A180057A; Fri, 26 Sep 2025 14:04:17 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4428C195419F; Fri, 26 Sep 2025 14:04:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 27/32] hw/scsi: mark most SCSI controllers as insecure /
 devices as secure
Date: Fri, 26 Sep 2025 15:01:38 +0100
Message-ID: <20250926140144.1998694-28-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The scsi-block, scsi-hd, scsi-cd & scsi-generic devices can be used
with any controller including virtio-scsi, so must be considered
secure for virtualization.

All the non-virtio SCSI controllers, however, are serving emulation
use cases and are complex enough to not consider them secure.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/scsi/esp-pci.c           | 2 ++
 hw/scsi/esp.c               | 2 ++
 hw/scsi/lsi53c895a.c        | 2 ++
 hw/scsi/megasas.c           | 2 ++
 hw/scsi/mptsas.c            | 1 +
 hw/scsi/scsi-disk.c         | 4 ++++
 hw/scsi/scsi-generic.c      | 1 +
 hw/scsi/spapr_vscsi.c       | 1 +
 hw/scsi/vhost-scsi-common.c | 1 +
 hw/scsi/vmw_pvscsi.c        | 1 +
 10 files changed, 17 insertions(+)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 12c86eb7aa..966524e3d7 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -450,6 +450,7 @@ static const TypeInfo esp_pci_info = {
     .instance_init = esp_pci_init,
     .instance_size = sizeof(PCIESPState),
     .class_init = esp_pci_class_init,
+    .secure = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -574,6 +575,7 @@ static const TypeInfo dc390_info = {
     .parent = TYPE_AM53C974_DEVICE,
     .instance_size = sizeof(DC390State),
     .class_init = dc390_class_init,
+    .secure = false,
 };
 
 static void esp_pci_register_types(void)
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 1d264c40e5..ba9bf6ec45 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1678,6 +1678,7 @@ static const TypeInfo esp_info_types[] = {
         .instance_init = sysbus_esp_init,
         .instance_size = sizeof(SysBusESPState),
         .class_init    = sysbus_esp_class_init,
+        .secure        = false,
     },
     {
         .name = TYPE_ESP,
@@ -1686,6 +1687,7 @@ static const TypeInfo esp_info_types[] = {
         .instance_finalize = esp_finalize,
         .instance_size = sizeof(ESPState),
         .class_init = esp_class_init,
+        .secure = false,
     },
 };
 
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 9ea4aa0a85..afdd9f0b47 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2396,6 +2396,7 @@ static const TypeInfo lsi_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(LSIState),
     .class_init    = lsi_class_init,
+    .secure        = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -2413,6 +2414,7 @@ static const TypeInfo lsi53c810_info = {
     .name          = TYPE_LSI53C810,
     .parent        = TYPE_LSI53C895A,
     .class_init    = lsi53c810_class_init,
+    .secure        = false,
 };
 
 static void lsi53c895a_register_types(void)
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 844643d916..6e5d9b71be 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2556,6 +2556,7 @@ static const TypeInfo megasas_info = {
     .instance_size = sizeof(MegasasState),
     .class_size = sizeof(MegasasBaseClass),
     .abstract = true,
+    .secure = false,
 };
 
 static void megasas_register_types(void)
@@ -2572,6 +2573,7 @@ static void megasas_register_types(void)
         type_info.class_data = info;
         type_info.class_init = megasas_class_init;
         type_info.interfaces = info->interfaces;
+        type_info.secure = false;
 
         type_register_static(&type_info);
     }
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 4ada35b7ec..58388b4480 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1441,6 +1441,7 @@ static const TypeInfo mptsas_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(MPTSASState),
     .class_init = mptsas1068_class_init,
+    .secure = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index b4782c6248..dd3a24da4f 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3173,6 +3173,7 @@ static const TypeInfo scsi_disk_base_info = {
     .instance_size = sizeof(SCSIDiskState),
     .class_size    = sizeof(SCSIDiskClass),
     .abstract      = true,
+    .secure        = true,
 };
 
 #define DEFINE_SCSI_DISK_PROPERTIES()                                   \
@@ -3244,6 +3245,7 @@ static const TypeInfo scsi_hd_info = {
     .name          = "scsi-hd",
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_hd_class_initfn,
+    .secure        = true,
 };
 
 static const Property scsi_cd_properties[] = {
@@ -3285,6 +3287,7 @@ static const TypeInfo scsi_cd_info = {
     .name          = "scsi-cd",
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_cd_class_initfn,
+    .secure        = true,
 };
 
 #ifdef __linux__
@@ -3325,6 +3328,7 @@ static const TypeInfo scsi_block_info = {
     .name          = "scsi-block",
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_block_class_initfn,
+    .secure        = true,
 };
 #endif
 
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 9e380a2109..380e3184c1 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -806,6 +806,7 @@ static const TypeInfo scsi_generic_info = {
     .parent        = TYPE_SCSI_DEVICE,
     .instance_size = sizeof(SCSIDevice),
     .class_init    = scsi_generic_class_initfn,
+    .secure        = true,
 };
 
 static void scsi_generic_register_types(void)
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 20f70fb272..5560249863 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1290,6 +1290,7 @@ static const TypeInfo spapr_vscsi_info = {
     .parent        = TYPE_VIO_SPAPR_DEVICE,
     .instance_size = sizeof(VSCSIState),
     .class_init    = spapr_vscsi_class_init,
+    .secure        = true,
 };
 
 static void spapr_vscsi_register_types(void)
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index 43525ba46d..3db2191f33 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -164,6 +164,7 @@ static const TypeInfo vhost_scsi_common_info = {
     .parent = TYPE_VIRTIO_SCSI_COMMON,
     .instance_size = sizeof(VHostSCSICommon),
     .abstract = true,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 7c98b1b8ea..073e0e8b7b 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1299,6 +1299,7 @@ static const TypeInfo pvscsi_info = {
     .instance_size = sizeof(PVSCSIState),
     .class_init    = pvscsi_class_init,
     .instance_init = pvscsi_instance_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { INTERFACE_PCIE_DEVICE },
-- 
2.50.1


