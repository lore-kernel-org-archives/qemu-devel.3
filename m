Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D126E92FE3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNEF-00069N-Fc; Mon, 29 Dec 2025 19:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNEA-00068O-0v
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:43 -0500
Received: from p-east2-cluster6-host11-snip4-10.eps.apple.com ([57.103.76.241]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNE7-0003gf-Nc
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:41 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 BFADD1800476; Tue, 30 Dec 2025 00:04:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=1eybbgQXT+wf9Pb17rKnNcXISNCmng16ZKUPr4ZmEzE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Y2kD3RnvG7PwNOH2+JBo2GvEyB0KfNqDQ3CsRUodSOSuxvmE+S5Mj0XQVdfVVx8/JyqO8b5UdENbndCAHw/q0ulbXUpDi2euedbZ5y+5sIfP4hOtL6NLXWyKlwBoypU+ILjZrbrIKNA8v9XWR2Rw3lOO4iKzQlrreB2+whBsH5EuO/lDz5wpuDPHkq6X/svWxjG4nGlJ5OfXvyLZt3HBHX2b0vDrTf6ZY/pFQrij9TayIyYNf1st2kmcZtLuWAEG9cGWjrKPlft5/AeldmKLaU3LKFdOCslyH0XZQpnZgwNg31cgep13sX2uBLCi3GjZtfy662vw4F1BOdjUNeWN9g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 4ECB8180046E; Tue, 30 Dec 2025 00:04:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 04/28] hw/arm: virt: add GICv2m for the case when ITS is
 not available
Date: Tue, 30 Dec 2025 01:03:36 +0100
Message-ID: <20251230000401.72124-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX1NkFJZhJZYep
 B+OWPtnvyvElydo1FT70uo1JXc9wsG9LN0rGEFdksjkbMaYpy6u4bGd2dotTyvtYWsW1Sfxsq86
 nbCfcb1/DXN/3xBeFPX6NTSEEE/OUtHetDtPVjk4ykYFrR2LrHFZ5BRJcWzGj3xyT0D6/OosKpl
 Dgr9vZTAEr9PuIcp7LHmO4TK1MsblEco+qimUW5F2jeROWbBtTlhRotAQ8saxdEiy3k6+NSELwy
 jzyAerPR7clKCNshXTFsm3aJDMcEK11Dpk0ds+zlz9R1FGGdAGzITN9X4QhxJDeZ6pPLNyoM59d
 4QO7PG7UNFyBBUlENca
X-Proofpoint-GUID: 1Tiv06ewnzmYuAnd5jb_6sQdBBrmbnti
X-Proofpoint-ORIG-GUID: 1Tiv06ewnzmYuAnd5jb_6sQdBBrmbnti
X-Authority-Info: v=2.4 cv=GOcF0+NK c=1 sm=1 tr=0 ts=69531715 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=8tVNtdTugjW4QW2w:21 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=5LJxe2L5dRr0YdfDuXsA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 clxscore=1030 suspectscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAAByMo3iUUZvi33EjotqEJj3mDcWeds0qkuDcQX0Dl/lxg6+sizeLT3hzflL9j51wfKPVUQnSP6akSHwZo6xirOHKtoeRAjswbpb4BUBMuiEWsM3SSdW+eQccFXECzziZtcJ+74W3vVLseq4o6hizZawlhfA9VPEgpZt7bDOFgUBclK/l7V1TkTUxL+sPdizEi1x2/9TlMQa48I6KyBv/VJnhsIpPJkW0xdb7kW5GdRL1JZ+o1eAoI4KpkATbKUOhsS1pkzQALVisWSa4ff7UyUUkwXfI/6nS+1KsxOJiGWe9dkBcC4y2RFRuBLpRcN5PQPvWq2A87CmbbPErrrrMSqURJXD0JHRm8lyT/4jGOShWzgsXtAkEi8QD0dt+dU3TSN1Yn5MalyeSt2rVNvWtLHfA2v0RTp0jTusxe8SP5WU1x7vsLmV89bxYx2Glhbc2DUA9sCJhrjUgyWvTdIsoITNYbPLyiHC/uKFw3Ftum8gXZnzqVnG+XZnUUKAA9hw8xhWZNDskDE/flX38j/u0fbYvfZj+aYTu+lqdxXpeotMey/KX2lOBBLa9zvbVyO+5KXWme3WnJ6T6ATDmCzxZjynmAJWX29sw8I8wzY8exuC+7RYjwHAk0JSmu6R8n6UEZzIrkmBapUgMeiETmAb96MWQAcwz20GjIYE3hSyQHSSLGktoO4dS62LZ2b3UwDWgGGdGmcvGMab0yOCynyf+R3mOJPE4OZtN5vhvlQUnXiM22Nc9QpXRnbPuZzoLGmMWw9EOI9oP7gq2tet1wfOWxvUBPUsg/whzjUEVjAqTowP2DUwF/09gFeGs32Lef4CnWibOxucbx8zHtLMXTelzL5Tglj/bBbXbDnAZgtBv0jClxNXK/jzH7FmudzlDSPa1IEpNKqKBOkpYpZncjFWjIiJMSYNBCoygrTc11rpiNIx5O2foesnKpoKeacgDqJeB/cMg==
Received-SPF: pass client-ip=57.103.76.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/arm/virt-acpi-build.c |  5 ++++-
 hw/arm/virt.c            | 16 +++++++++++++++-
 include/hw/arm/virt.h    |  2 ++
 3 files changed, 21 insertions(+), 2 deletions(-)

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
index fd0e28f030..0fb8dcb07d 100644
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
@@ -3533,10 +3538,19 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_11_0_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
+
 static void virt_machine_10_2_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
+    vmc->no_gicv3_with_gicv2m = true;
+    virt_machine_11_0_options(mc);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
+DEFINE_VIRT_MACHINE(10, 2)
 
 static void virt_machine_10_1_options(MachineClass *mc)
 {
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


