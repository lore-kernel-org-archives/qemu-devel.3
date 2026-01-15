Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1269ED3CC8B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB1g-00060d-H6; Wed, 14 Jan 2026 19:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1d-00060D-B0
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:15:46 -0500
Received: from p-west3-cluster4-host1-snip4-10.eps.apple.com ([57.103.74.181]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1b-0001rg-Og
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:15:45 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 C78C6180042D; Thu, 15 Jan 2026 00:15:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=pnYhzV+5jiiMNx1pcU6+RM5m8iDu5NPUOmI5LVpVt6Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Yx5rxy7dvM3NoIosN9RuxzM4xRCjRbqi5NxiUaaEU3uyOp0XZzz4pxrrp8jkFMxoSDVAAzRnqHlzRX76/aZLp/RwYofS5dNhS9IUOKmUfUa/cI1JBGkKatw2qEv3Rcq624Ekvp5u6PYh6KUARPRMqpMF5g/MO0pP4Q9Bv8vSon57L2UHkM8kASAWtBes+TYRtnwG+gbHU+gwnZXvraeeWLCIPUelBYSE5a2egZUG3iQp9ObbnHOR8B+539pfaLiKp0BdlaHrPtIQTkeAJYZvA0D2jnIZeCQ7TmO5v/Jj5nVzvfOYK1QGZszESB4mP1y0rKQthfJp6gllTbgy73FH5w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 598B81800412; Thu, 15 Jan 2026 00:15:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v15 04/26] hw/arm: virt: add GICv2m for the case when ITS is
 not available
Date: Thu, 15 Jan 2026 01:14:43 +0100
Message-ID: <20260115001505.57237-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wzfZFFoBUDWS6zr6qgtbJ-sUHaJRB_iE
X-Authority-Info: v=2.4 cv=VbD6/Vp9 c=1 sm=1 tr=0 ts=696831ae
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=8tVNtdTugjW4QW2w:21
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=GHBMd-oUYIP45a8agUkA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: wzfZFFoBUDWS6zr6qgtbJ-sUHaJRB_iE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfXy7xoeZt48mzl
 YpaEz3Tyet3wIO1W5px9u7DauBwPyFwWBXwfER97W4EPZpehZ2sfK8q2qPfC9DTTCxxSDsJFeAi
 a9wEP/UNWosGtrW4dmNUlN1oFh+T42MIMkK2MY4noXur76HHdySVJRv/ZRu+aBtkUfn/GPJX8iM
 x9ccAb1GSg6krAu2zAMJT9l7DXb9xDH/UKBNb9WMnWJVQ58C4kx5PlXVkqjCcmQrpp89n6rNJjN
 O8yiTKIGUSoDdQaFjevt8PQoCEB4BpwVniW340yyHx5suNzR/2cZNuCU/z+bLhGiCSiGLyrc2qE
 E6xd5Krvjd/uYkMd5Zl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1030 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAABbo6OrdgDDk0fKlqTDIHMkox/xMytvL1RER4qqnei5bAj9wfcr0eXIz9yFpkZ03yu6biIqXoh3O9N1s4mtozXpA6k/T03UGuZl7ANi5o7lZ3ApAmMNIVlyQw20vfGmgSqAYsa0rOxm5lKe5USxhpRL7KZ//Cv5nBhOl6FJ+8luAQDqkXNBg6wsIRmcFwOXwUkHq0gCKibqQERj9DKSNDJRY9j1X2tWfi1fMYzKwUrRzlyILM12TFTFu3IVMMSU4Vvk4wHwDlOUUL/0fHTdMDS+Om8a0n3+4WYkokNIBJCUHPgpc6ldI+n+S/LHpPq8SSh5MsB8lszOsI0RNOr5NbVcVArTMCGwvsHUpdTjvLaGwdh+UOAIcdvQI7mg/OK9q9MahIBfVmDJhZe84zrD9HPlp0Zm80SbOM1j2KBnVL5vteKZm6uj9gT/ub+2ux9yX7ItiE7WlkGG5PmSxg5llPHpXNYcWJZuH7Qu/OTlQhl1i3wIJKzj/7u78yn1Mpte/9FuptgycLAYWWyH2sfZQr6W1j15akbRH4sfpvZUJwLRttB+D2rdJ+2Hp//VFd+ZmK2jlp/FBKwYsz5viL9PV2oIkvNCk26MFdzAvr1hiMh+GgZCra8mV0MkDjQTz7D0/05jDal4w0DVnyOSi/AntcLk2wXEgBtSdpivU8TjfGqntAjhwNp4SnHw8EZ13fjb6URTV9Ao9Lw24w7wFPwQ+g6B3HjzEEty9gj0MIYyrVM5VLH8ZEDMhNRrmPNKtvkwn9lkEwMR4pORTOJ98BD4AMysLCIaFe+SbOS3jZqJ+0OusKCWLWfe7VPrAKauqdT7iHtE9Ya6nd5YrJQ6MbsDiUC40ri6F+0jjRQ30JVWPY5uRbECgQJ+YQWDrGcwp5uF3MLJsm0ypqgjL7tfbJM+70OvV8SsAcc+E3vZLfTb2bBygh8GDxJNM626jIK9mRsocJj4E/tpA==
Received-SPF: pass client-ip=57.103.74.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


