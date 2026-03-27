Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E63810ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Dt-0002A4-6T; Fri, 27 Mar 2026 07:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CZ-0007aO-21
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CV-0000EK-6V
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso19230425e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610279; x=1775215079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aesAU2RMjJwSCep4Qu42XobLR0m7TUFyFIMDbtxPytI=;
 b=VNepMIzpCODzfGr7qvqq0MGvyRHgZ/4DQQ8TkgS4ClQSt5/RbNvZc9dBDmk9pVy0NX
 wCNXtG6LnfpTfVX/p+XEnrEhRLhdVs1SOTh3hSqD3s/2UNC6S0uBVLy3NGdPp2Iui58M
 2js+4aluCZ5RcrVMJWqbTJCZ/Ku4r1qB1LVzjS/Zbi5lXj0fe4r1PY9vAGMcofKWAE4+
 PMrkfop0rOZiB4vLzbjZ1PzIbGJ3b14t4DkBnZWjdv92xedoIxLCFkpvWpzqeh39J5oc
 lAZgug/dSZQYQ0NyKz7ezq0I9pX0ZN6ZWaczo5/7knMi87lAIoMKpwQtapnY2VnLVlIL
 Kx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610279; x=1775215079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aesAU2RMjJwSCep4Qu42XobLR0m7TUFyFIMDbtxPytI=;
 b=reAeJTdkfpp4+jqJBwuBSaUnzIPh/Mvj6Cixzuj2qFAg/Pr0XBeldjnh2ij6H+zJx9
 gVZ9o9SpP2F7Mjp9JefKsj84iQFRE8h8UJ1G4lvE2373Vb++fVEtjgOm3ExvyhPfFFk2
 Iih0gsQK4pLjHg3qsHa8ln7tPz8+ZfTN4yXhQU69ISwSN9BDUgNUqaCaphYOuYUIJ4Bz
 uZtGn34rpIa7ZwXPWTmZmWHKvZJk4ENXfPcriXUKqMtjvm2Vm3jED45nVgHK/CrQIwkd
 AejP0fjbCCx/63hUMa99luOoFWRLCZP7ppZSGLr/jTft9X+aSoXDW8zdzFppFmUTS+D6
 /v2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWONq3WCHQjCrToAca/SmDs8hac145+e6jN0qH6ZSnBZJtRqyb6r4n45vKva1NfSrm1FT6lsR5oa834@nongnu.org
X-Gm-Message-State: AOJu0YwGZPEo5s1blZkfMtQ3E98Qk+4dMQhtyl+KvheYiaPmHqbNFJk+
 B4fw6wiYOIj6u+QlnExOkqzB4tsW5tGsaTvRY0dCyfvazoCtBo8YokQrXraOWhzxWpw=
X-Gm-Gg: ATEYQzxG3d2d8FgcOdltAPdzH2syr6Us8NKv5EjoYy4hRaYBSDo3xZlAMlAokhcmP8T
 PUHVKImKFDz4B9p5dVjQIGe9IQtdePCZo54MsNvy5giruV8rJwDL6gJ+EryaHgdCL38SKXcIeaS
 iQPton5DG19caFEw6U0yrpMPwqexzbON5dqp02Ckcv71FWDK+3uI3P9uAxFfnUAjF6rpeNZNHx/
 ZysGe5GjcoifVWDWGCDQTeReiP1zJlC6AFMze4dVQrZCSNeoclJcqBSbC/3cNSLjZsF32j7da+s
 jNHp36BXMzdIYQ+0GU+3LlNrd9ZNFcXhJ6Oxc4UTNt9GOFRayKFTnWOf5uPvZR5RSD25V/hqcfq
 UL5GCF/W6Fc40OwL19S3/wr3g/D74d+XWFGI2ZuTMdib+rZfqeNf1wZz2BbflZEui0eOX2uDtpP
 humpuT112w/oKzRuzgnIH935g6toI/wn6Mt8wsqwwuBmIIsA+ENHrYHFnqZDsGKtLyAlO7IXC85
 CWbBTfU0ue5DEHt9T+OccTLxScBz2Y=
X-Received: by 2002:a05:600c:1f11:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-48727d5a31emr34549805e9.7.1774610279150; 
 Fri, 27 Mar 2026 04:17:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 60/65] hw/arm/virt: Create and connect GICv5
Date: Fri, 27 Mar 2026 11:16:55 +0000
Message-ID: <20260327111700.795099-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In this commit we create and connect up the GICv5.  We do not
advertise it in the ACPI tables or DTB; that will be done in a
following commit.

The user-facing gic-version property still only documents and permits
in its setter function the existing set of possible values; we won't
permit the user to select a GICv5 until all the code to handle it is
in place.

Although we currently implement only the IRS, and only for EL1,
we reserve space in the virt board's memory map now for all the
register frames that the GICv5 may use. Each interrupt domain has:
 * one IRS config register frame
 * one ITS config register frame
 * one ITS translate register frame
and each of these frames is 64K in size and 64K aligned and must be
at a unique address (that is, it is not permitted to have all the IRS
config register frames at the same physical address in the different
S/NS/etc physical address spaces).

The addresses and layout of these frames are entirely up to the
implementation: software will be passed their addresses via firmware
data structures (ACPI or DTB).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/arm/virt.c         | 101 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  14 ++++++
 2 files changed, 115 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8c383d7e40..b6a04f868b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -69,6 +69,7 @@
 #include "hw/intc/arm_gic.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/intc/arm_gicv5_common.h"
 #include "hw/core/irq.h"
 #include "kvm_arm.h"
 #include "whpx_arm.h"
@@ -184,6 +185,19 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_GIC_ITS] =            { 0x08080000, 0x00020000 },
     /* This redistributor space allows up to 2*64kB*123 CPUs */
     [VIRT_GIC_REDIST] =         { 0x080A0000, 0x00F60000 },
+    /* The GICv5 uses this address range differently from GICv2/v3/v4 */
+    [VIRT_GICV5_IRS_S] =        { 0x08000000, 0x00010000 },
+    [VIRT_GICV5_IRS_NS] =       { 0x08010000, 0x00010000 },
+    [VIRT_GICV5_IRS_EL3] =      { 0x08020000, 0x00010000 },
+    [VIRT_GICV5_IRS_REALM] =    { 0x08030000, 0x00010000 },
+    [VIRT_GICV5_ITS_S] =        { 0x08040000, 0x00010000 },
+    [VIRT_GICV5_ITS_NS] =       { 0x08050000, 0x00010000 },
+    [VIRT_GICV5_ITS_EL3] =      { 0x08060000, 0x00010000 },
+    [VIRT_GICV5_ITS_REALM] =    { 0x08070000, 0x00010000 },
+    [VIRT_GICV5_ITS_TR_S] =     { 0x08080000, 0x00010000 },
+    [VIRT_GICV5_ITS_TR_NS] =    { 0x08090000, 0x00010000 },
+    [VIRT_GICV5_ITS_TR_EL3] =   { 0x080A0000, 0x00010000 },
+    [VIRT_GICV5_ITS_TR_REALM] = { 0x080B0000, 0x00010000 },
     [VIRT_UART0] =              { 0x09000000, 0x00001000 },
     [VIRT_RTC] =                { 0x09010000, 0x00001000 },
     [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
@@ -780,6 +794,49 @@ static void create_v2m(VirtMachineState *vms)
     vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
 }
 
+static void create_gicv5(VirtMachineState *vms, MemoryRegion *mem)
+{
+    MachineState *ms = MACHINE(vms);
+    SysBusDevice *gicbusdev;
+    const char *gictype = gicv5_class_name();
+    QList *cpulist = qlist_new(), *iaffidlist = qlist_new();
+
+    vms->gic = qdev_new(gictype);
+    qdev_prop_set_uint32(vms->gic, "spi-range", NUM_IRQS);
+
+    object_property_set_link(OBJECT(vms->gic), "sysmem", OBJECT(mem),
+                             &error_fatal);
+
+    for (int i = 0; i < ms->smp.cpus; i++) {
+        qlist_append_link(cpulist, OBJECT(qemu_get_cpu(i)));
+        /*
+         * GICv5 IAFFIDs must be system-wide unique across all GICs.
+         * For virt we make them the same as the CPU index.
+         */
+        qlist_append_int(iaffidlist, i);
+    }
+    qdev_prop_set_array(vms->gic, "cpus", cpulist);
+    qdev_prop_set_array(vms->gic, "cpu-iaffids", iaffidlist);
+
+    gicbusdev = SYS_BUS_DEVICE(vms->gic);
+    sysbus_realize_and_unref(gicbusdev, &error_fatal);
+
+    /*
+     * Map the IRS config frames for the interrupt domains.
+     * At the moment we implement only the NS domain, so this is simple.
+     */
+    sysbus_mmio_map(gicbusdev, GICV5_ID_NS,
+                    vms->memmap[VIRT_GICV5_IRS_NS].base);
+
+    /*
+     * The GICv5 does not need to wire up CPU timer IRQ outputs to the GIC
+     * because for the GICv5 those PPIs are entirely internal to the CPU.
+     * Nor do we need to wire up GIC IRQ/FIQ signals to the CPUs, because
+     * that information is communicated directly between a GICv5 IRS and
+     * the GICv5 CPU interface via our equivalent of the stream protocol.
+     */
+}
+
 /*
  * If the CPU has FEAT_NMI, then turn on the NMI support in the GICv3 too.
  * It's permitted to have a configuration with NMI in the CPU (and thus the
@@ -992,6 +1049,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     case VIRT_GIC_VERSION_4:
         create_gicv3(vms, mem);
         break;
+    case VIRT_GIC_VERSION_5:
+        create_gicv5(vms, mem);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -1927,6 +1987,11 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
     /*
      * Adjust MPIDR to make TCG consistent (with 64-bit KVM hosts)
      * and to improve SGI efficiency.
+     * - GICv2 only supports 8 CPUs anyway
+     * - GICv3 wants 16 CPUs per Aff0 because of an ICC_SGIxR
+     *   register limitation
+     * - GICv5 has no restrictions, so we retain the GICv3 16-per-Aff0
+     *   layout because that's what KVM does
      */
     if (vms->gic_version == VIRT_GIC_VERSION_2) {
         clustersz = GIC_TARGETLIST_BITS;
@@ -2072,6 +2137,11 @@ static VirtGICType finalize_gic_version_do(const char *accel_name,
         return finalize_gic_version_do(accel_name, VIRT_GIC_VERSION_MAX,
                                        gics_supported, max_cpus);
     case VIRT_GIC_VERSION_MAX:
+        /*
+         * We don't (currently) make 'max' select GICv5 as it is not
+         * backwards compatible for system software with GICv3/v4 and
+         * at time of writing not widely supported in guest kernels.
+         */
         if (gics_supported & VIRT_GIC_VERSION_4_MASK) {
             gic_version = VIRT_GIC_VERSION_4;
         } else if (gics_supported & VIRT_GIC_VERSION_3_MASK) {
@@ -2100,6 +2170,7 @@ static VirtGICType finalize_gic_version_do(const char *accel_name,
     case VIRT_GIC_VERSION_2:
     case VIRT_GIC_VERSION_3:
     case VIRT_GIC_VERSION_4:
+    case VIRT_GIC_VERSION_5:
         break;
     }
 
@@ -2124,6 +2195,12 @@ static VirtGICType finalize_gic_version_do(const char *accel_name,
             exit(1);
         }
         break;
+    case VIRT_GIC_VERSION_5:
+        if (!(gics_supported & VIRT_GIC_VERSION_5_MASK)) {
+            error_report("%s does not support GICv5 emulation", accel_name);
+            exit(1);
+        }
+        break;
     default:
         error_report("logic error in finalize_gic_version");
         exit(1);
@@ -2175,6 +2252,10 @@ static void finalize_gic_version(VirtMachineState *vms)
                 gics_supported |= VIRT_GIC_VERSION_4_MASK;
             }
         }
+        if (!hvf_enabled() && module_object_class_by_name("arm-gicv5")) {
+            /* HVF doesn't have GICv5 support */
+            gics_supported |= VIRT_GIC_VERSION_5_MASK;
+        }
     } else {
         error_report("Unsupported accelerator, can not determine GIC support");
         exit(1);
@@ -2208,6 +2289,9 @@ static void finalize_msi_controller(VirtMachineState *vms)
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         } else if (whpx_enabled()) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        } else if (vms->gic_version == VIRT_GIC_VERSION_5) {
+            /* GICv5 ITS is not yet implemented */
+            vms->msi_controller = VIRT_MSI_CTRL_NONE;
         } else {
             vms->msi_controller = VIRT_MSI_CTRL_ITS;
         }
@@ -2223,6 +2307,10 @@ static void finalize_msi_controller(VirtMachineState *vms)
             error_report("GICv2 + ITS is an invalid configuration.");
             exit(1);
         }
+        if (vms->gic_version == VIRT_GIC_VERSION_5) {
+            error_report("GICv5 + ITS is not yet implemented.");
+            exit(1);
+        }
         if (whpx_enabled()) {
             error_report("ITS not supported on WHPX.");
             exit(1);
@@ -2395,6 +2483,13 @@ static void machvirt_init(MachineState *machine)
      */
     if (vms->gic_version == VIRT_GIC_VERSION_2) {
         virt_max_cpus = GIC_NCPU;
+    } else if (vms->gic_version == VIRT_GIC_VERSION_5) {
+        /*
+         * GICv5 imposes no CPU limit beyond the 16-bit IAFFID field.
+         * The maximum number of CPUs will be limited not by this, but
+         * by the MachineClass::max_cpus value we set earlier.
+         */
+        virt_max_cpus = 1 << QEMU_GICV5_IAFFID_BITS;
     } else {
         virt_max_cpus = virt_redist_capacity(vms, VIRT_GIC_REDIST);
         if (vms->highmem_redists) {
@@ -2440,6 +2535,12 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
+    if ((vms->virt || vms->secure) &&
+        vms->gic_version == VIRT_GIC_VERSION_5) {
+        error_report("mach-virt: GICv5 currently supports EL1 only\n");
+        exit(1);
+    }
+
     create_fdt(vms);
 
     assert(possible_cpus->len == max_cpus);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22bbc34ca8..0a804ddad4 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -63,6 +63,18 @@ enum {
     VIRT_GIC_VCPU,
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
+    VIRT_GICV5_IRS_S,
+    VIRT_GICV5_IRS_NS,
+    VIRT_GICV5_IRS_EL3,
+    VIRT_GICV5_IRS_REALM,
+    VIRT_GICV5_ITS_S,
+    VIRT_GICV5_ITS_NS,
+    VIRT_GICV5_ITS_EL3,
+    VIRT_GICV5_ITS_REALM,
+    VIRT_GICV5_ITS_TR_S,
+    VIRT_GICV5_ITS_TR_NS,
+    VIRT_GICV5_ITS_TR_EL3,
+    VIRT_GICV5_ITS_TR_REALM,
     VIRT_SMMU,
     VIRT_UART0,
     VIRT_MMIO,
@@ -116,12 +128,14 @@ typedef enum VirtGICType {
     VIRT_GIC_VERSION_2 = 2,
     VIRT_GIC_VERSION_3 = 3,
     VIRT_GIC_VERSION_4 = 4,
+    VIRT_GIC_VERSION_5 = 5,
     VIRT_GIC_VERSION_NOSEL,
 } VirtGICType;
 
 #define VIRT_GIC_VERSION_2_MASK BIT(VIRT_GIC_VERSION_2)
 #define VIRT_GIC_VERSION_3_MASK BIT(VIRT_GIC_VERSION_3)
 #define VIRT_GIC_VERSION_4_MASK BIT(VIRT_GIC_VERSION_4)
+#define VIRT_GIC_VERSION_5_MASK BIT(VIRT_GIC_VERSION_5)
 
 struct VirtMachineClass {
     MachineClass parent;
-- 
2.43.0


