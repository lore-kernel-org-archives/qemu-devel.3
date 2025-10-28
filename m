Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E68CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtQk-0001kn-Lp; Tue, 28 Oct 2025 19:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQg-0001h8-4M
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:42 -0400
Received: from p-east1-cluster6-host6-snip4-2.eps.apple.com ([57.103.90.183]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQR-0004kK-VG
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:41 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 8668018034EB; Tue, 28 Oct 2025 23:48:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=JHEgQXI56zcvBQsz6pNUn1flvTbXYsGowZgT2ZZujDg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JVKEHOd/2/+PwF2+emVJoJR8Xw0KWFIrqAV2IeUribNVVegxJPNWpZoffgRfzyvl938bWKCUvw1N3dlPIVa2kat5pYZ5w5KkakkK6QGuT0MD4GXWIK3ifNGT9oQefRE3r9YecJC9M55esCSi5opnzKrAmJQ5u6tg3G6BapzrHM9X9K+F2pGePkA0WvuvwwFq0t3Gxyr7Crqku92xMDE1Y7Q6mwTRqw/rBY6E0QVifAcZb1y+DQVDnaKrh12W+UNqbBRPJ0kW2N/JBZsBhdcCrtrddZwmAuQ3sAYZ5Y3D74HRtrpRuwHTkOc5CLniludX+n/RVPtc0617pQKNP+F9VQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 39A231803139; Tue, 28 Oct 2025 23:48:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 04/27] hw/arm: virt: add GICv2m for the case when ITS is
 not available
Date: Wed, 29 Oct 2025 00:47:34 +0100
Message-ID: <20251028234757.39609-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bR6Q7EQMrqhzklPnXTArX8MltI6igUuo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX1w1jBuusMWt3
 +F5regIoKzXQjV+9o67ifxim5QgbAqo1x06buJF9bAqN6eO9VR1Y2mULcTnknt930DUdSbHkUSV
 zR1UqMUtFVrWg1ZP4lcTk+Ew1+I7XNfT754IYz3Ync9y5ClFD8DdX9NTacnk0ECsu8GFyItcEnQ
 aH1uZQGrupKjN5Cvtbx22uCLWzviGzTKMOlxExxPP77eHuMMnPEwv98tZ4elrF/OccA2NN7p+jY
 2suyxsYWjFfiPx1LgLlKD8QIX7yrRiobSXThiLbFPTU5l0QtOwSHhUIr2Aj4Q78/dXNYcmOIk=
X-Proofpoint-ORIG-GUID: bR6Q7EQMrqhzklPnXTArX8MltI6igUuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 clxscore=1030
 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABzKFGWvPXCwYoANBgI+Tk7j8dAD9kd/EMj6xLR5XRTb5KxwD6JFugqRgZQohgkaCY8thRK3bx1ng+sKOn+NYj8lE6AE+iAxpZqXVxbIs2J0gj6mqI8rt104ZK5IFIhtLbwnWZIdKeGfSlnz8lYt3Q1YENw2QEJjKeAB6/OgrdAeGhjryC5fZ6sKUzyPeOdy5E7SgUdjcGvT38i8qscNW30G6ADLt2f+3IBbi7XCBMjSVw1ZgzP9a4gPuktQWp6WBX1j0JTVzq3dm2cI2b74Qbr/P5ZCgOnOwU2Di4q07C1XSyUCO5EFld5NdYusnc3uY61oKxKypPZgDnyXcWUd3/8CIGSI3Cm//TtKkYO7HkoschUg/qgxyjiCHhB2IZsiEgoSYOsAUtHglHeHZZ3SLrRzZYAgiAM4/SiMObKbSHqudrTxyYn4U2jiryei2EePOWdr9CQ9fCkEpAAeu/0OspSAgpJvqPB7iCSM/ib81wpX5wfyYog6gCdCZ91r3kzddff95DCXH23RYQA0N3LvfPTakN2/BjDshG5iDTYw2zLRGnIV1dsyZOGrLeA8YtchFiwfg1DRHV0An2S6Tw41rFxZuW5YlZffqdUofc0InD0hiilsPjkMIa5ZxHNrgkQN2p1ib07rfAYRhgHlPhJvHcaexe4Ldbs7WzEgDrAUXoZluLw+22awJkyAdXe9CfhhwfvE1nPEgywwYHif8dPJOWEoazGyG8DbW9SyA5FDCde6JJeOoqdqWtCH9GYZrSF2DOzZtpi9pajLkBAt9GBOSAWjWYipqXlp82cCX7x1dyLCj4
Received-SPF: pass client-ip=57.103.90.183;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Hypervisor.framework for macOS and WHPX for Windows, the provided environment is a GICv3 without ITS.

As such, support a GICv3 w/ GICv2m for that scenario.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/virt-acpi-build.c | 4 +++-
 hw/arm/virt.c            | 8 ++++++++
 include/hw/arm/virt.h    | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8bb6b60515..0a6ec74aa0 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -959,7 +959,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
             build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
         }
-    } else {
+    }
+
+    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) && !vms->no_gicv3_with_gicv2m) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 175023897a..61d7bab803 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -956,6 +956,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
         create_its(vms);
+    } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
+        create_v2m(vms);
     } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
         create_v2m(vms);
     }
@@ -2447,6 +2449,8 @@ static void machvirt_init(MachineState *machine)
     vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
         !vmc->no_ns_el2_virt_timer_irq;
 
+    vms->no_gicv3_with_gicv2m = vmc->no_gicv3_with_gicv2m;
+
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
@@ -3484,6 +3488,7 @@ static void virt_instance_init(Object *obj)
     vms->its = true;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
+    vms->no_gicv3_with_gicv2m = false;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
@@ -3536,9 +3541,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
 
 static void virt_machine_10_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_10_2_options(mc);
     mc->smbios_memory_device_size = 2047 * TiB;
     compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
+    vmc->no_gicv3_with_gicv2m = true;
 }
 DEFINE_VIRT_MACHINE(10, 1)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 04a09af354..d31348dd61 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -132,6 +132,7 @@ struct VirtMachineClass {
     bool no_cpu_topology;
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
+    bool no_gicv3_with_gicv2m;
     bool no_nested_smmu;
 };
 
@@ -180,6 +181,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    bool no_gicv3_with_gicv2m;
     CXLState cxl_devices_state;
     bool legacy_smmuv3_present;
 };
-- 
2.50.1 (Apple Git-155)


