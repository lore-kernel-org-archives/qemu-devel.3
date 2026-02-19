Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FB9E9A052
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7uG-0001Aw-3H; Thu, 19 Feb 2026 12:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1vt7u2-00012f-V3
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:33:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1vt7u1-0004T9-20
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771522403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yAVzG0o86ycl8AVxd7PvcwR9rkF5ddTGG9+7DzM5edQ=;
 b=NQGwsfbaB4UUciAftVl0ZYM+HKyiJXlU+I5L59SQ2bs0ah0bsg8luuGyvE07VfiHzZrRwu
 iYBnkOp5mTo97VbNcbkMM9lpK6gPGzHlzTPW6hT/2IN5QAVmPO1Y0xcwcXaCljxKkinjAY
 MdDw9sh7BR2Ar6GXZjlotZt5eKdSfCA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-0-DeFQNgN369SHClNXLOAg-1; Thu, 19 Feb 2026 12:33:22 -0500
X-MC-Unique: 0-DeFQNgN369SHClNXLOAg-1
X-Mimecast-MFC-AGG-ID: 0-DeFQNgN369SHClNXLOAg_1771522401
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a7701b6353so13929095ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771522401; x=1772127201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yAVzG0o86ycl8AVxd7PvcwR9rkF5ddTGG9+7DzM5edQ=;
 b=DGatYUEn3yTVcKUf/yxeuQSxE1G13GvThB6Un6aDS3cwogMXqzfgNNBjNjddQ3+3u6
 pESEuakdv/j+bxvecQpgyAnpIZmM1Ms4R2a/AisvA/cgnqDgojjhsn1hsfp9cUDeKzBb
 bciarg8DtbeOd4JTiuUH9VLWqgnVtx4eXdeTdgWtxk6rNGmcVXbREU98OO7vxTxtNQ2S
 paQBwCfbhuM9cINV6GunYcOU4EGbAkvaq2YtFwqMEICvvb5TB4cb3+1t5AGL2PqPSeB6
 PgVkf7apqL/N4jhZM6/+5kAuETrrOK8r31C4W2I3Yor+VdVQzaGGhKH6YmvgWo+Nf7yw
 KS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771522401; x=1772127201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yAVzG0o86ycl8AVxd7PvcwR9rkF5ddTGG9+7DzM5edQ=;
 b=w75/Ijp+gbMz1Pcp3L/gDdRVRD/8qJ37Cl8gvzqih1rs+7r2s723XGBeMBAcAoVfOQ
 YvQYmpCMa9ozoX7xx16d9xh5P4gkrBcBuGwyEPtgYSwC6kUbF7C/UT/uovXdSicTmBpL
 /5UDEAlMbEjtQXxpNd9GMaqTM+EBQncFK785uAhNAAd06TPiAS/aTr/nofsu++5Uo4z/
 AB2hSLqYUM+01JGePxW5vswgETfFxGmlQF24tq2M/kygkqdWzXjLT98ATx+qUMii0fto
 miNUkEXf/hWvog3tq22BLxFHn0pArQK0QlKE+n8I3pzpoUyNHFaJdUXgupwtPFjTWJ9E
 BSNA==
X-Gm-Message-State: AOJu0YzRp/hLOiLdCViyAAaXiuiWaq5EsGVsPndzwKvgpS4L51r09HpE
 N6LQNFhbEJ8V5bXwkrgJziP6Ogjgl0kP0maEtDSL/KFa2VNaIhAZst4kuA92ONyXeS/aLILsUJn
 IkK3sjvArbEw7fYwzW01M4RzNVzjGGH4CSqy8djbAugSd735GoOFekA+ia7221zxQpkvtzfbcEA
 yUtq0vpna26qA1M4Gg6P9ZWRop/nL9f5IyPcQV
X-Gm-Gg: AZuq6aLLnuLC+Xjd8V89V0DtXpEoSrFtQygdQtVHh6hqvCmKFWzVN8sfvFrDru05pDz
 bWM3Y2gm2xBEGNBnQ2/ivfjLwu33n9ScnW3NryaBpxOr1sXPu1+CFlE5MYZkjuHzJ0PDP/WmGa8
 k+Hzrkmm2VPrnhUaTgUG41XOlgtfXZF1oIT/eHRp9zUPG1fNIUfbwXnEEDCuCby3DCvpj83Pqez
 aRn0lOfIb/vVHbL7hj15oGUGvnQEds7T+5/i8YPPz3rTD1haggmbOReSl3K5fJJYgnLCXaCbrgy
 +GZkzOxUdjYVIbq/GEpFX9qOz2pz1+b1KkB8/lev4uBfDg3RS5n1Jmyrblzr+urhTxVjdN/xqzA
 M7HosgUCx/B3nu0UyupFcv180oc8y7BUvOMPTgnqZx6vJF2q4
X-Received: by 2002:a17:903:22d2:b0:2aa:d674:a27e with SMTP id
 d9443c01a7336-2ad17431b8dmr189240065ad.10.1771522400695; 
 Thu, 19 Feb 2026 09:33:20 -0800 (PST)
X-Received: by 2002:a17:903:22d2:b0:2aa:d674:a27e with SMTP id
 d9443c01a7336-2ad17431b8dmr189239585ad.10.1771522400042; 
 Thu, 19 Feb 2026 09:33:20 -0800 (PST)
Received: from mbawa-thinkpadt14gen5.bengluru.csb
 ([2406:7400:51:d336:b064:aee8:1042:ba4c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadce38sm177392115ad.71.2026.02.19.09.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:33:19 -0800 (PST)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org
Cc: pierrick.bouvier@linaro.org, shannon.zhaosl@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v2] hw/arm/virt: Add virtio-mmio-transports property
Date: Thu, 19 Feb 2026 23:02:56 +0530
Message-ID: <20260219173256.152743-1-mbawa@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Windows ARM64 guests detect virtio-mmio devices declared in ACPI
tables even when no backend is attached. This causes "Unknown
devices" (ACPI\LNRO0005) to appear in Device Manager.

Until Windows fixes that by supporting, add a new machine
property 'virtio-mmio-transports' to control the number of
virtio-mmio transports instantiated. The default remains
NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.
Setting it to 0 allows users to disable virtio-mmio entirely.

Usage: -machine virt,virtio-mmio-transports=0

Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
Changes in v2:
 - Renamed property from virtio-transports to virtio-mmio-transports
 - Added documentation in docs/system/arm/virt.rst

 docs/system/arm/virt.rst |  5 +++++
 hw/arm/virt-acpi-build.c |  2 +-
 hw/arm/virt.c            | 43 ++++++++++++++++++++++++++++++++++++++--
 include/hw/arm/virt.h    |  1 +
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e5570773ba..e037f2c269 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -212,6 +212,11 @@ dtb-randomness
 dtb-kaslr-seed
   A deprecated synonym for dtb-randomness.
 
+virtio-mmio-transports
+  Set the number of virtio-mmio transports to create (between 0 and 32;
+  the default is 32).  Unused transports are harmless, but you can
+  use this property to avoid exposing them to the guest if you wish.
+
 x-oem-id
   Set string (up to 6 bytes) to override the default value of field OEMID in ACPI
   table header.
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
index 390845c503..b1e8ce9723 100644
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
+        error_setg(errp, "virtio-mmio-transports must not exceed %d",
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
 
+    object_class_property_add(oc, "virtio-mmio-transports", "uint8",
+                                   virt_get_virtio_transports,
+                                   virt_set_virtio_transports,
+                                   NULL, NULL);
+    object_class_property_set_description(oc, "virtio-mmio-transports",
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


