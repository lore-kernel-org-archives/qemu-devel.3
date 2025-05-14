Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3BDC3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 17:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFXU-0001Qp-HV; Wed, 14 May 2025 13:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFFXS-0001On-AW
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFFXN-0007Nx-4J
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747242295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yt7Go2NY2vORq6t2I/qWoIsyNcD4CNCagkdGZahyAeI=;
 b=U1TLp0DGMHWyUEsIJRt8pv7Ki8w6IVr7fWB8+r0wXi9WmPPh8jC63uRb35kaI/1TI0rw4R
 VZ3M71EI7GbDgEPnPhZH/yyehCTKYLXm+FTkDfPAgGtKTUEawRRdY8I4rWYV/JHt1vceqN
 jlmyzGomKxr2j9tSF2C8V6168ClrBEo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-OiJefIDVPtuZ48ciwpEbJg-1; Wed,
 14 May 2025 13:04:52 -0400
X-MC-Unique: OiJefIDVPtuZ48ciwpEbJg-1
X-Mimecast-MFC-AGG-ID: OiJefIDVPtuZ48ciwpEbJg_1747242291
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBEDF18001CA; Wed, 14 May 2025 17:04:50 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0A8130001B0; Wed, 14 May 2025 17:04:46 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	Jonathan.Cameron@huawei.com,
	philmd@linaro.org
Subject: [PATCH 02/22] hw/arm/virt: Introduce machine state acpi pcihp flags
 and props
Date: Wed, 14 May 2025 19:00:49 +0200
Message-ID: <20250514170431.2786231-3-eric.auger@redhat.com>
In-Reply-To: <20250514170431.2786231-1-eric.auger@redhat.com>
References: <20250514170431.2786231-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

acpi_pcihp VirtMachineClass state flag will allow
to opt in for acpi pci hotplug. This is guarded by a
class no_acpi_pcihp flag to manage compats (<= 10.0
machine types will not support ACPI PCI hotplug).

Machine state acpi_pcihp flag must be set before the creation
of the GED device which will use it.

Currently the ACPI PCI HP is turned off by default. This will
change later on for 10.1 machine type.

We also introduce properties to allow disabling it.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 include/hw/arm/virt.h |  2 ++
 hw/arm/virt.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9a1b0f53d2..10ea581f06 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -129,6 +129,7 @@ struct VirtMachineClass {
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
     bool no_nested_smmu;
+    bool no_acpi_pcihp;
 };
 
 struct VirtMachineState {
@@ -150,6 +151,7 @@ struct VirtMachineState {
     bool mte;
     bool dtb_randomness;
     bool second_ns_uart_present;
+    bool acpi_pcihp;
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9a6cd085a3..a0deeaf2b3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2397,8 +2397,10 @@ static void machvirt_init(MachineState *machine)
     create_pcie(vms);
 
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
+        vms->acpi_pcihp &= !vmc->no_acpi_pcihp;
         vms->acpi_dev = create_acpi_ged(vms);
     } else {
+        vms->acpi_pcihp = false;
         create_gpio_devices(vms, VIRT_GPIO, sysmem);
     }
 
@@ -2593,6 +2595,20 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
     vms->its = value;
 }
 
+static bool virt_get_acpi_pcihp(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->acpi_pcihp;
+}
+
+static void virt_set_acpi_pcihp(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->acpi_pcihp = value;
+}
+
 static bool virt_get_dtb_randomness(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -3310,6 +3326,10 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "in ACPI table header."
                                           "The string may be up to 8 bytes in size");
 
+    object_class_property_add_bool(oc, "acpi-pcihp",
+                                   virt_get_acpi_pcihp, virt_set_acpi_pcihp);
+    object_class_property_set_description(oc, "acpi-pcihp",
+                                          "Force ACPI PCI hotplug");
 }
 
 static void virt_instance_init(Object *obj)
@@ -3344,6 +3364,9 @@ static void virt_instance_init(Object *obj)
         vms->tcg_its = true;
     }
 
+    /* default disallows ACPI PCI hotplug */
+    vms->acpi_pcihp = false;
+
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
 
@@ -3394,8 +3417,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
 
 static void virt_machine_10_0_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_10_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
+    /* 10.0 and earlier do not support ACPI PCI hotplug */
+    vmc->no_acpi_pcihp = true;
 }
 DEFINE_VIRT_MACHINE(10, 0)
 
-- 
2.49.0


