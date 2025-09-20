Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB50CAC5AD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzyAf-0006U0-Ok; Sat, 20 Sep 2025 10:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyAB-0006MJ-9N
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:02:07 -0400
Received: from p-east3-cluster3-host1-snip4-3.eps.apple.com ([57.103.86.6]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyA9-0007mE-Pi
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:02:07 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 5FCC018172C6; Sat, 20 Sep 2025 14:02:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Dd6SbfhuNBk34fWK2+hdiPZ7ix95XwKfJ2aHHWwGTnY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=A3xndNqOGRGj7PcCrihMdXpro7ZQDNVoQ1e/NgEeG2aJyMqJR4mBasjn06T4ueWdgIp4FWfI8qLXdtKv/XcHHBJ1yGmkD41e1AcNqCcDq8r68pBobbFZFSwDi8dtr9VsoVeMpWTFNcSQlIPZyOCrbUQS4NHjNVJyz4DCnrS91wYNB6g20zQzSTJY56m95k1eZcztHsKIoxSh7ifAIiL3Tqt623rHVAo7vGyJh6FP/peQwkLIv98URdUOOHSJH+IRYO5Z7+y8TZxT/3uCwZhhfDyAW8H473JAGg1sqBIZExjzRDv1mBIwoTfD7OmOkwJoc8xz7ACM6oWIlbTWxwkNwQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 7C3BC181726E; Sat, 20 Sep 2025 14:01:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 03/23] hw/arm: virt: add GICv2m for the case when ITS is
 not available
Date: Sat, 20 Sep 2025 16:01:04 +0200
Message-ID: <20250920140124.63046-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250920140124.63046-1-mohamed@unpredictable.fr>
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OgemViRJvTP77DdQ0xAf8VBpVPayVeei
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDEzNiBTYWx0ZWRfX0GP9fe2PrVt0
 BQyM2h18h6Dj9p+XIZngel3MDXUKYdJIt4TgUct8uQjg/uu9Jh5MchQ/Pe5OHCJyO6GgIlLsVud
 A1pmuSO3XsKQ2g+Bmgz027H5i3K/wwlboQbuZr0sPlBI9ebaKgP3+gYlckbGmc/TRvw63KODK3B
 7tN8MyammaIwTjkXDWX/97ssFL/N6xbx7ffMS2XRMX1olChoYGp2U7ZUM1Xq3MgkiJPhg/rduiA
 wPUPgV5Bp6G5TltTKAH4iakKSCeaqWLq8+87MWXK0gvGYuEmzeYojafgPyIc1ksd8PbhL91z4=
X-Proofpoint-ORIG-GUID: OgemViRJvTP77DdQ0xAf8VBpVPayVeei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1030 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509200136
X-JNJ: AAAAAAABNcovwDyH2h9g8qcMdwkLTUTCoxdis40lsmYQKWlwFxFTwM6lzs7EHYWao2rPnrqjWwi+D/saB0FwWJMqG8XzJ9x9UQ87t5jokRYNQbQa/lrl0PpXJAqv2m/daGmot7evBwMyw7Dri+VDoT3iS84W85pibQc3QX4MgsCJq006HzxTf92gZR5V5hgM6yruZEl15EJjk1vBmjLKBK/eal6SiqUp5qIB/17kiIwHYTNAPSBJkvfUnwHAc4sDSQHdnPA3joDS1F74CLa1pnzH9y1MYmOokHLR7IwDwVz5mdAWrxVtOL0SHHBVo8Fh6g8UELFtFWOiRbz/yY9L6tjkYI7rlaEkmeNbTnINVnDHzELN/vgLC6AMB/sSOruwjU4/D9+UffAPkHv0p8lPsc+7kDELLt3d7RzL+wH1zurL1ZWi19RpiOEVDRR3uRiMCPbGPn4AqCgBPBkfSerXxJ9Yhe+R7bVsCr/EUlYR0qqpEZnyEvDzk/OeI6/5edxTaIqpwPwSyrk3EJJc6kV+3MZRyY54puaI5+uMMzAh7LBF0m6skZDTqPEyz4CNJCZgSdC5ZcZXzYQlV2lNFlD69bZfimkOJSU0I+s0vX/GobWZdNZNGIsnx5wS0Qe179vWNOjKs9SW53nKwonWFhYFIlIKRIuEe7Qm5BY56xS5PzE9xP0JGDKgaA1QrtDAKwoRbBiYfyYsGlke7SOa7a/UVbeQjB0EP2/nq/lJ1RA4yTbOLw6zh2MIXWQuHr0IGhJOYYlnOvtxCtd3GEHZdeREACIhvwXtC4l5+Sn+ESyaBF025P4GlNCYs7uArSFuk/UupmJCFTzafstyazek+guq2xDFKC1XpbAuErogJGsz2ujq4zZ+7aPXlJS7pnuZfc23msO70YuXAv7N59Xx/F+VuL4=
Received-SPF: pass client-ip=57.103.86.6;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 96830f7c4e..7a049b8328 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -959,7 +959,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
             build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
         }
-    } else {
+    }
+
+    if (!vms->its && !vms->no_gicv3_with_gicv2m) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 02209fadcf..01274ec804 100644
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
@@ -2433,6 +2435,8 @@ static void machvirt_init(MachineState *machine)
     vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
         !vmc->no_ns_el2_virt_timer_irq;
 
+    vms->no_gicv3_with_gicv2m = vmc->no_gicv3_with_gicv2m;
+
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
@@ -3467,6 +3471,7 @@ static void virt_instance_init(Object *obj)
     vms->its = true;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
+    vms->no_gicv3_with_gicv2m = false;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
@@ -3519,8 +3524,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
 
 static void virt_machine_10_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_10_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
+    vmc->no_gicv3_with_gicv2m = true;
 }
 DEFINE_VIRT_MACHINE(10, 1)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ea2cff05b0..3c030f4b5d 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -131,6 +131,7 @@ struct VirtMachineClass {
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
 };
-- 
2.50.1 (Apple Git-155)


