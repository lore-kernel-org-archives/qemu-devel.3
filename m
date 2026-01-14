Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0409FD37E39
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg18a-0007ov-Rx; Wed, 14 Jan 2026 08:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18Y-0007nr-Aw
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:14 -0500
Received: from p-east2-cluster3-host3-snip4-1.eps.apple.com ([57.103.77.152]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18W-0006TD-Js
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:14 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 2C2D7180031B; Wed, 14 Jan 2026 13:42:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=pnYhzV+5jiiMNx1pcU6+RM5m8iDu5NPUOmI5LVpVt6Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=BLkcQe8gcW9aYEo24oXlkAkklo86lTTBU8D+C2Qx3j+80tKe9m8Oad5vmwibbbS1Ewh6KJTN+6eCN1P7VIp+13ID05wxETOIkUMQCKMcvfmRAKJKs+6tSmC1e/01fO7fIW27zMIt4yQn+khi0gjSjq886EY1P/x7TkXkkLNykjXr2DWcT16DSMrmNoxvLh/3/2C94gN/Hh7l7nGvpe0HkMmbTy+bTPEI0cf32sVCi/lAvDIQraxvP3Db7uHMZTYcnL+RWCezJehe7YTC2gLzL9YRIybX9GAsnxMMAJWms/qNUTeWQni9SIhdL9nb1PbLua8Sctnn3a2IdQ+moiBNCg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 1743A1800499; Wed, 14 Jan 2026 13:42:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 04/26] hw/arm: virt: add GICv2m for the case when ITS is
 not available
Date: Wed, 14 Jan 2026 14:41:21 +0100
Message-ID: <20260114134143.26198-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=UsVu9uwB c=1 sm=1 tr=0 ts=69679d31
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=8tVNtdTugjW4QW2w:21 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=GHBMd-oUYIP45a8agUkA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: lXdXJrTA2PuaAsf8L9GSfbS0r0tTQIv2
X-Proofpoint-ORIG-GUID: lXdXJrTA2PuaAsf8L9GSfbS0r0tTQIv2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfXxqeBsayU/LN0
 4qN1mGzONenNBJ50c6bkvRsUVl1XeGGQEXCNPw/TZ28cCdUUcgrWvGu8buSUwqCLRzy7Qtt7yxc
 vAonVAqXMDO30/Y663AM316L1ShYtE1DOv+CptEW3EuzBFEMcQOKCctYbV3NczDIqoLIDtzV4k1
 z2AsGTMjZK2vBfW2sBoBcwhX+nkpokncRfMMezTzf4kG8VZMTBvEY7m+3Edpqpbgk7PZv0Iw/Zq
 3yuSl+N/OWn3df5GYGCj15tYOIhRbzXh8ahDsuhwsHw8loksLumGfbnT1CZU6A/AmDNTPvj1Jsg
 jDvQppPCP2q2T8T4Igq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAABuH+WtjXUkZm0oi9Hlc5BDNyb0sZ33djuJiQVDTjVwOsrwPkSrHDDtGD5ZjEB9sWnKFSzluTGMnrsHpUh8KAO89f6Ov9WLpwXovKSdZP5dWL+XL82T0xd8IEenjF3qf9lPcCqP20orfialxzLecCYD1a2txShAqUUrSlj33udD1YbaWa1Q7uLx+ixAd/q98c14tagY21zBXr+8CLWDtG/mOPAv+9q0kREMKUBtnEWHuGJZN/oC5gmO3+K97V2eQmhnHGMJHQJsWcH6eJ1WQ5dzZmSrHqrH0dbFiz3eExBaikMrvNSRO26YyLLNFd7O58prxeDq8UBLoWwf0MxcJnG5FpXvZSkR5Nfjja+NluealxswPB8Om9RiEMWJKB0Y2VIy/lw8zstXwYYB8itNfGc1TELcM0mnfRTxa2DyCcT+E37L0F7qIjPrDCrphssAnXV4ATb4M2EBYiIlzqJZJvCvq38hN3d8VPZs0CtJcN0mmOproxJsUiBjpL6h4Mg4Or1G1NxkB+a8+cMfFueXPJeQYzu3EMBTUtjXeRGnY5tqleRZuxIXJRKvYkELr4tNpRm3vAX5pu15wp7ByWC53EFukXyXrgx1JN0u4uakHRFZEuL3mNGo8iNmflpYtVddwaSpxlVCvwHbqcKkcYxhf/mTogtWrkSyXXAtC+oLyeH4ssnKpEMNyvZsksBkzvuGH9BYwQpt3tOvWNQxGVgavkv86K+TAaupH1vyG3ce80SJwUrt1W/hXfQkCwnJ+gJudUO4BgnMrR60AzQhR4be9ZeLiGCRoN/L+HLXevlZNtEgZg31AqpJl0662/FQiWHOuGdgR5GO0fjezxDHuE+hLnWdpdf0/K94rFuFcHV4sBadwM9X0xY1y3F6MpAuBQLNpm9ED71x+0JvNj6q3UPvUVUVBIX/UHB9q0u/VnBw6ofsOg=
Received-SPF: pass client-ip=57.103.77.152;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 9d0568a7d5..4fad34e108 100644
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
@@ -2444,6 +2446,8 @@ static void machvirt_init(MachineState *machine)
     vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
         !vmc->no_ns_el2_virt_timer_irq;
 
+    vms->no_gicv3_with_gicv2m = vmc->no_gicv3_with_gicv2m;
+
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
@@ -3488,6 +3492,7 @@ static void virt_instance_init(Object *obj)
     vms->its = true;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
+    vms->no_gicv3_with_gicv2m = false;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
@@ -3540,7 +3545,10 @@ DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
 
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
index 8694aaa4e2..c5bc47ee88 100644
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
 };
-- 
2.50.1 (Apple Git-155)


