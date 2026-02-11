Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB088E9E2FD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 12:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq9LR-0006hG-TE; Wed, 11 Feb 2026 07:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1vq9LQ-0006gn-DD
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:29:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1vq9LO-0008Ms-Nm
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770812961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bfo71XqCSKmxPUviffHaEkHQ6i/xi5Ji/h2hsH26RrU=;
 b=H0sA1bp0djn33arWn6vg3Z5QZwyqC/idv/ZUJtaiIVYYRbC2l5FRoCV+pIuP7cGXJtLTGl
 +h5+UO4s8LjxgV7Kj9rfWHjDhKWpBE+jYbVc4qVhZSnQSpyM/wL02qCqkH+c/vpVJzxU21
 tRxSegfpvpxylp8RL5Kv6Z8IT4fLPf4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-OqUUvH5aPUCrVt5xmFmitw-1; Wed, 11 Feb 2026 07:28:15 -0500
X-MC-Unique: OqUUvH5aPUCrVt5xmFmitw-1
X-Mimecast-MFC-AGG-ID: OqUUvH5aPUCrVt5xmFmitw_1770812894
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-354bc535546so4932130a91.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 04:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770812894; x=1771417694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bfo71XqCSKmxPUviffHaEkHQ6i/xi5Ji/h2hsH26RrU=;
 b=s27V1Xp8UtiwUDAGH1G2lByQ0KqXbslwK7sVHWM/Hbt2Ueb2rwvLIEyRqpy+BpG5UL
 bsNzGBQRiJW3rSaWDMEQCTGLj+FTOE7HBOnAZcgHmhtu+gdv9CSjlgFWrRBBa5xa/OBw
 PkvjYWhurmbrLHL3Xu+GV+vvn8yjyCkDswGnNqatoMx8LnznIQPE0AZcv+pTYMessH5O
 d3TRmez+r4aRsusRGmjeqvk59vfmFMn+Z/MdP5r1gMNrSAKUS9rMme5bvjjmLS6zsjw0
 yIJgG+1vil3C83J2qqj/4VPBJVcEXDTTwIO/eGIZO93jnJlRvIAsV89L/srRlf4kp/W3
 /E+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770812894; x=1771417694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bfo71XqCSKmxPUviffHaEkHQ6i/xi5Ji/h2hsH26RrU=;
 b=udvKPCoTh4vt4Qjme4f8b+1O1lyfiVUjED7r5Iw+wxHnXdU2pgEsYCG3sLPqx3Kjwj
 e8PrPWOHTlb+bQNdPVbgdKX153yKxbWPwYQ6+4cXscXz6txdaR0+GfHEypIZ+scrSMGv
 8yfzjrvXfkVd4avI6XvA++dZgE5SxRHohLeAsO63M+ZtcLvAOaLOI/vaNYpfsDu9R+54
 Phjj+r3b2vg8AXvDm7i1Z5SlSQATBzOPhosHZ724AoYuuNdipXXZw3phZxXzlc0ArGjz
 2z61qlTxprIjbq3Dg4p9Ce7nJyUc4FQTTlyvxRoWsMUvSAhfYtsDlwy4dWWfAHqP1ME8
 YEQg==
X-Gm-Message-State: AOJu0Yw0lpT0tLebf9W01Ge0BtMaUibSHBKd2q3rB7f1MgbnUD6jIbBS
 2rN6ePIvm4IqlJK7aGNwelA+oiik7MzMXrt1kDXdUo2dm6QAwTbc2OdRd5z7U3o++pRyu1FGXJa
 TWneLF14C0lTMBdKuEXuyCPV0LRIP6f44avhVwsmky4pzFCqS9MbJ2B8siySgMribdT5XtNeuEq
 Bdqk8LgEtErMX+K85IR5lU5MK83WhLxXRo5geV
X-Gm-Gg: AZuq6aIXMXangGgw7ull0M2r3Kwo1h4kDWg6j+1YzTxNp74sK1ep2m+KMjVujtSNHOV
 v+P/PjtdQ41wXyjVrc2Cu6tYVnQt3FIXW9bQf2+af2Ikox2Mkd4BQkPwuKdnLwL8xzp/eXStnBm
 AwEpfiqZdPGHvem4CACj4T/z5MbB3JQFdl8zPVn8tNv0GQn7wAuqnvfD08CqjCjOpN1HRz5/bSh
 GGx3sSDGxhHGjINP3QIH4gCVCWTRY0B4NLO5sfyfi8+vZfCti05sFNPA0zafhD4F3ZqDjI2ThLC
 ZgUia7jIYcEPky+E4bvQhoIroJ0UYRv9Dl4x6HvqQNdzG1XoUubsappwhZJyOciC7bznHCT+v8h
 lqj6xwk/AlnL8raznjJH+LZVvy01q94d9PMrGqGvIuthpFEs=
X-Received: by 2002:a17:90b:4c0c:b0:34a:8c77:d37b with SMTP id
 98e67ed59e1d1-3567afb221bmr2753552a91.16.1770812893737; 
 Wed, 11 Feb 2026 04:28:13 -0800 (PST)
X-Received: by 2002:a17:90b:4c0c:b0:34a:8c77:d37b with SMTP id
 98e67ed59e1d1-3567afb221bmr2753516a91.16.1770812893191; 
 Wed, 11 Feb 2026 04:28:13 -0800 (PST)
Received: from mbawa-thinkpadt14gen5.bengluru.csb
 ([2406:7400:51:e13a:21f1:8c60:5b7:96f5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8249e81976dsm2443786b3a.52.2026.02.11.04.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 04:28:12 -0800 (PST)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	sebott@redhat.com
Subject: [PATCH] hw/arm/virt: Add virtio-transports property
Date: Wed, 11 Feb 2026 17:57:59 +0530
Message-ID: <20260211122759.125094-1-mbawa@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Windows ARM64 guests detect virtio-mmio devices declared in ACPI
tables even when no backend is attached. This causes "Unknown
devices" (ACPI\LNRO0005) to appear in Device Manager.

Until Windows fixes that by supporting, adding a new machine
property 'virtio-transports' to control the number of
virtio-mmio transports instantiated. The default remains
NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.
Setting it to 0 allows users to disable virtio-mmio entirely.

Usage: -machine virt,virtio-transports=0

Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
 hw/arm/virt-acpi-build.c |  2 +-
 hw/arm/virt.c            | 43 ++++++++++++++++++++++++++++++++++++++--
 include/hw/arm/virt.h    |  1 +
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c145678185..27c007fd62 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1150,7 +1150,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     fw_cfg_acpi_dsdt_add(scope, &memmap[VIRT_FW_CFG]);
     virtio_acpi_dsdt_add(scope, memmap[VIRT_MMIO].base, memmap[VIRT_MMIO].size,
                          (irqmap[VIRT_MMIO] + ARM_SPI_BASE),
-                         0, NUM_VIRTIO_TRANSPORTS);
+                         0, vms->virtio_transports);
     acpi_dsdt_add_pci(scope, memmap, irqmap[VIRT_PCIE] + ARM_SPI_BASE, vms);
     if (vms->acpi_dev) {
         build_ged_aml(scope, "\\_SB."GED_DEVICE,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 390845c503..0a659ba540 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1206,7 +1206,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
      * between kernel versions). For reliable and stable identification
      * of disks users must use UUIDs or similar mechanisms.
      */
-    for (i = 0; i < NUM_VIRTIO_TRANSPORTS; i++) {
+    for (i = 0; i < vms->virtio_transports; i++) {
         int irq = vms->irqmap[VIRT_MMIO] + i;
         hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
 
@@ -1221,7 +1221,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
      * loop influences virtio device to virtio transport assignment, whereas
      * this loop controls how virtio transports are laid out in the dtb.
      */
-    for (i = NUM_VIRTIO_TRANSPORTS - 1; i >= 0; i--) {
+    for (i = vms->virtio_transports - 1; i >= 0; i--) {
         char *nodename;
         int irq = vms->irqmap[VIRT_MMIO] + i;
         hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
@@ -2705,6 +2705,36 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
     extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
 }
 
+static void virt_get_virtio_transports(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    uint8_t transports = vms->virtio_transports;
+
+    visit_type_uint8(v, name, &transports, errp);
+}
+
+static void virt_set_virtio_transports(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    uint8_t transports;
+
+    if (!visit_type_uint8(v, name, &transports, errp)) {
+        return;
+    }
+
+    if (transports > NUM_VIRTIO_TRANSPORTS) {
+        error_setg(errp, "virtio-transports must not exceed %d",
+                   NUM_VIRTIO_TRANSPORTS);
+        return;
+    }
+
+    vms->virtio_transports = transports;
+}
+
 static bool virt_get_its(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -3427,6 +3457,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set the high memory region size "
                                           "for PCI MMIO");
 
+    object_class_property_add(oc, "virtio-transports", "uint8",
+                                   virt_get_virtio_transports,
+                                   virt_set_virtio_transports,
+                                   NULL, NULL);
+    object_class_property_set_description(oc, "virtio-transports",
+                                          "Set the number of virtio-mmio transports to instantiate");
+
     object_class_property_add_str(oc, "gic-version", virt_get_gic_version,
                                   virt_set_gic_version);
     object_class_property_set_description(oc, "gic-version",
@@ -3540,6 +3577,8 @@ static void virt_instance_init(Object *obj)
 
     vms->irqmap = a15irqmap;
 
+    vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
+
     virt_flash_create(vms);
 
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 3b382bdf49..f898afaa6e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -169,6 +169,7 @@ struct VirtMachineState {
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
     int psci_conduit;
+    uint8_t virtio_transports;
     hwaddr highest_gpa;
     DeviceState *gic;
     DeviceState *acpi_dev;
-- 
2.53.0


