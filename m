Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3DEC79FBE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkGC-00035S-AQ; Fri, 16 Jan 2026 08:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkG1-0002zZ-KT
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:52:59 -0500
Received: from ci-2003l-snip4-1.eps.apple.com ([57.103.91.242]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkFz-00025i-R9
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:52:57 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 613401800135; Fri, 16 Jan 2026 13:52:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=IRh8UKRU225HT8b9oQN8hIs6Dl68wlCfuPh9dj3ZRIA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MWH/QDyFVRRGHI81bdamgAdn/M9pNKQsYJFCDdSZSRXYv1lFmUCZKeoQ7khGRQysTiZcsXc4jmDsCouxtVV60qZVcXS7ubaEB1x7jGD+iiAjS3/0ZPt7txXSJn+d/NXefKrq8WSqx2lNIvs16LRNXFZ9hC0Uf3PFLsmxv2k7xVLY3Uh5m7sgql5qGU8xVjKgVSoGfgLpnjgkYveJuhmruw5IlEf87/M9Ifh0D8PzGzWUPDE4TNmGEiY8suFQAOqWQGhR7axCQMgQYCcoNI/Xbu26cIsggJhDOiGwS/hMiJm9/B4fOjoFBssXfPZulgJg+M5NecAKi4uDLaqOXogNtg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 B61471800211; Fri, 16 Jan 2026 13:52:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 04/26] hw/arm: virt: add GICv2m for the case when ITS is
 not available
Date: Fri, 16 Jan 2026 14:52:13 +0100
Message-ID: <20260116135235.38092-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX12D8r+RJVwZJ
 PPfeKiNJQlPQCxZid3BmIL5CbQP0Sdsk/tcC/veBiWVUUfmGT+lj5YYHAhYTfD0pLohUJB5u9Q8
 WypR9iz4JnPsxN/tjQBe/hP91qgq6CvW8PkJKjQvg39E6NDzbF7hK7Y8ygdUXn0THvCWibCuYX4
 5RSwEAoPOeOhVuo/0YXXwzCRdKZe/nowQsgrEZ/iWOIsJ165gox/x2Lt/CiyzCBCv7zeCGbzojN
 /uIoji8P5SB3Ome+BpP/YTnITA5BFBIk6cnd+G2JrJxxNsVCDS3O2qCXyG7VYiRG/tY45uMmkdd
 aXSLFonez3p4qDtQqhM
X-Authority-Info: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=696a42b5
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=8tVNtdTugjW4QW2w:21 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=GHBMd-oUYIP45a8agUkA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MqRUHi5OD6B-KkOC8buEbcuD_Y67cMTZ
X-Proofpoint-GUID: MqRUHi5OD6B-KkOC8buEbcuD_Y67cMTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 clxscore=1030 bulkscore=0 spamscore=0
 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABJ6RYuf67u/mdVU+67w//tf9iuLoT1B4RTMjN1xG9DnN2YKSqHOQI4X4dNeFCL9YqkWeDV6VRsRGOEJGilI0pq5JQLrGk3wDaGjn3olPuLjCjvRSXNW9qrM/VMEg0kN3KDs2s48+uRq6+p/MENcmN+5JJxV1+qZAV3qQBuk58EI8UYDRv3uxqKDgnPEM90usHlCtowsvEno7KlkyeyH5gt3wE1be/kzXKxs3oRKfvB8SzqbiyvKLZJtyPHpv/W0L2xFleBZ136ej6BPiPxYhnXnJIrlzbYwThNEntsqNXkmrNtK+5yzZ9YvhQb32CNXbnHQSMIp1H909A7SEYcI8/gpN3Q9PILGnK8bNJsBMcXUoGvuiRAXzu+qZxHpFXcTZhwdUa8qvasoABHaC88m9FclCerQmHzvT9Jm0JsATI2OTtnBRedl3tSsxjLrtjqTAoFS1spqdURDBFZOj0q1TuqWvB+Q1bRZARTDM2GUv7NW1oDjorDuJBc2SOmwKHn26gC/Ty2fAb7jkGr4ZJWRCJxdpCYMr4TI87XmCX2bBJwZWf+F0ee8qAPW+4EGSQuzZCunGdTjozL1YENC7JPpIjMsXibdgQlc/RpA4gSYeDpAq0BMrLOtnfndfNsUcTepns7pN/rrAZ7U5dN3zhkJLABHA+5H5lw3CmJ09hydxHKdoZe398IarhR8KCG+g5TzG7zzWij5Sg0sI4mnU+M1JoP+UtUDtAP/kUGjlYuqj39sPaEEZbvgGK2gkbuPwH1VbZm4N3nHWeaiM5izO7GQLK/0K1EEfMJJdDP5mglSOWTwG0NHqWep8r
Received-SPF: pass client-ip=57.103.91.242;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Hypervisor.framework for macOS and WHPX for Windows, the provided environment is a GICv3 without ITS.

As such, support a GICv3 w/ GICv2m for that scenario.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/virt-acpi-build.c | 5 ++++-
 hw/arm/virt.c            | 8 ++++++++
 include/hw/arm/virt.h    | 2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 03b4342574..40ea6b6dd5 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -960,7 +960,10 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
             build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
         }
-    } else {
+    }
+
+    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its)
+     && !vms->no_gicv3_with_gicv2m) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4badc1a734..275f26d439 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -959,6 +959,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
         create_its(vms);
+    } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
+        create_v2m(vms);
     } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
         create_v2m(vms);
     }
@@ -2449,6 +2451,8 @@ static void machvirt_init(MachineState *machine)
     vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
         !vmc->no_ns_el2_virt_timer_irq;
 
+    vms->no_gicv3_with_gicv2m = vmc->no_gicv3_with_gicv2m;
+
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
@@ -3497,6 +3501,7 @@ static void virt_instance_init(Object *obj)
     vms->its = true;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
+    vms->no_gicv3_with_gicv2m = false;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
@@ -3549,7 +3554,10 @@ DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
 
 static void virt_machine_10_2_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_11_0_options(mc);
+    vmc->no_gicv3_with_gicv2m = true;
     compat_props_add(mc->compat_props, hw_compat_10_2, hw_compat_10_2_len);
 }
 DEFINE_VIRT_MACHINE(10, 2)
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5907d41dbb..b7e59b8c63 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -130,6 +130,7 @@ struct VirtMachineClass {
     bool no_cpu_topology;
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
+    bool no_gicv3_with_gicv2m;
     bool no_nested_smmu;
 };
 
@@ -178,6 +179,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    bool no_gicv3_with_gicv2m;
     CXLState cxl_devices_state;
     bool legacy_smmuv3_present;
     MemoryRegion *sysmem;
-- 
2.50.1 (Apple Git-155)


