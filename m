Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2260CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA5O-0003VW-Od; Wed, 29 Oct 2025 13:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5F-0003Pg-AM
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:41 -0400
Received: from p-east2-cluster1-host4-snip4-10.eps.apple.com ([57.103.76.23]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA50-0003Ff-HR
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:39 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 5041A1800602; Wed, 29 Oct 2025 17:35:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=JHEgQXI56zcvBQsz6pNUn1flvTbXYsGowZgT2ZZujDg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AXLAmwbELPlKLSDAkK2EVSF7ZKHo+AFwCLvT/8Lm5RGN6zeB/hrqFCN4YqF/mxvlG0y62TaSslm8B1rM/HB8t1wIkm1ltafAHVS+UjLQ2tdMcEzWQsSYwpwi4i4Lwo8aOmCpOfddoHtZvHzj45aoCWs/HkpNGZbp6Mjl0LOz024DXxkTrh1aQ/UngG6RL90oGLNNzeQHVTgASVyiP6adg9pVpHy9wa6tYaWBgsOkpHpc8oM0+whmMCF4AfOdoHbugQ+CcNPM+5TIzsPfNVB/ChzlvjLyIOwOtgx2wI6T70OQapNUYZv9vR1rfRDCmNWgz5Asxa17IUIOa8A8M3grLA==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 D38471859E5A; Wed, 29 Oct 2025 16:55:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v10 04/28] hw/arm: virt: add GICv2m for the case when ITS is
 not available
Date: Wed, 29 Oct 2025 17:54:46 +0100
Message-ID: <20251029165510.45824-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GpNlfF904dzmvLdrIuxrGVRhdaLS3Kkb
X-Proofpoint-GUID: GpNlfF904dzmvLdrIuxrGVRhdaLS3Kkb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX8D6Op2qk5AIW
 HUKQV7fZQnVsiOgEZ7JQHDRpEUPdRo03XKfAllcHKHqFqhXkZHIE6dDK4SWhKhetbGLD30JZvd5
 MSqDP4cVtviMnZpb2iZXnMEXtv/UFu4yz3OM29mmnN98fHaTTN2l6muIkOtT6KMeJF5wlNS91nk
 cWKvNGGPD41qhurmGC/2InwpgASJgnsWdAQttgmrom5JkIgiAdEiZ/0/bJTtovAGs+x9PK+YKpj
 JcrDGtnbVMWvwKbwhMYiYrAEiut1XCEAnvLkV6fbrcitdQldI5jrqf0kF0KutL19JL0SJOAU0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 clxscore=1030 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABEB7F0yRrIsY/oZiKFrA0cImsd7ywWhaq0a1dA7H3vQ/KSJh211OjiJER8WQ/maBDYcoYTozeeemufUevYK3aKqDvW0lUVIJGkn/UYkvUn3+j2q/rAKE3BDJ6dtnINlnKtCp+tbxRnPEQLv8aam4v//+slyqGkZIq+tzrKB7ekKKCNQlY9zXkWB18VvKqL22Tv/9Iag6Fx6qzyB0elrUC1yA/d8yQ+YwiRGqogmsClQ1wI5HEMQjcf8DoNX1DGQs1JPoK1has+77IJj3ZWjz1uDdPFpBPYgK1gZ0ihH93OXUspBhRHJPaZGX2wcMNaFpd2E3N4/whfxFG6rUIeEosyVHEnQq6giGuUfjNEbCfpFb0imCMKKBVv5DoiQOSNF7aH7iV0WqI9QX+ibYrr4fyA7B1gA7yF2Vrvu64TeZ+RAu7bdwjdVeSnh1Vq6c52VGwzy+YGR9clt0RRezbcYa7Fol41+t7crWChr7WQQtGvTw7hTRMDznFw7tVEk8JenCNz4eKc/MvE1p3gITVx9DCPnPxwVEBVaLsAO5zEb7a1IOuXSH6KZqNQwUJQ0v7N/Nniawp5bsQQaLu20fQJHGxxiKKMWWzpKmB9F3uZSQCrAATEKNw6X5ynGFhC6iePl5dw0mcw5vUFX0ESLG0d3kt4KTbBVPZOa05Chva4bn+oP0CS66ZN6/cztkPdL8WCQGQ574NxrgXqPov9QK2pdDlW6Bw/1EpenLpl7YCTnXqwsrxf08xx5ktE2wwXZZWJxOOdEY1DlWGAYKqVGr/KbTkIqHJ0JE=
Received-SPF: pass client-ip=57.103.76.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


