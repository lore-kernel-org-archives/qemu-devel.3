Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90652C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 05:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x74ay-0007ju-J3; Thu, 17 Sep 2026 01:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x74av-0007j6-AJ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:23:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x74at-00040Q-G6
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:23:37 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H0TrJh3597322
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6hoNwrKV1ED
 5Y0r6qVxyQHqoEbIw/jlTkxpkfgqJ4ZM=; b=QH57hV4DvZjdqd8DpLQFIaCMBX5
 v5OgB6mfKfsPcO4JNdg+mrYaNPqdixeXKv9gwQ2PEKD+8mq+Lsqz3kVKvzEHE57u
 +jCsePKwyH/HxNd1vXmGcX1hJtyGzc8GM7g/FAtOV/opXuIwKLzqu9sq1H1qH20N
 j/pECSad5LUeFJtKefRXwKqTGV008OAO5q7O7DhKhVPz7Iq63M+pH5MCX1Ghicd7
 ztP8nw/uSfGLFaJFCwV5Aj5fJGGgFcqtwE6fcEBaMH0H3ikInnWXHMZ01yLR1tLo
 069Stv+2kGe8+nnTMEt41mpIgVsybMN18KHv0JbcbWRcspphY8RZ8uwtH2Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxayauen-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:23:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-398d3a12589so120047a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 22:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789622613; x=1790227413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6hoNwrKV1ED5Y0r6qVxyQHqoEbIw/jlTkxpkfgqJ4ZM=;
 b=i7AYlI6XIIFj/fb+cLOMcr6tmIAcH7LWpnQ5g5H4Z/Nv6lKPwexrqFXEmhas74M4Rj
 bkq4ZJdFFRIIWc+S9rZ8ynVMxB/OzfqBM49yUObDJmCA5EgN0gquziPRfYQ4Fgp639m9
 JbFQkVEO37Cr948SveZdMSVdtTJZeParf1tN1+uVoOANH5Yx1jeXM6CM91N3TE8wuT29
 cpDYz+HxDdIPTZkQQ+2e17qzsTOUH0d8kAePCDkTu7mLqsY225FbDHQ5Alnanju/jWeG
 NPmrD0x4ptCUUFlhOAfN2TnS0AMqSJ10br0BbN7XEKqkp9H0GiZ92cLetkb6pYFe/wO3
 v9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789622613; x=1790227413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6hoNwrKV1ED5Y0r6qVxyQHqoEbIw/jlTkxpkfgqJ4ZM=;
 b=pDZy+4mR070FvDSfaXRTeZG0flzwv5hmh0kYDvFuksHIwPD0R20OXNH1R2OLi8BBul
 t6B22x+CYWUuaDRASQzRudfZTWXGV30O9OTsyKD/V5Zmo8wIogth81oVtTLg0qv+mR7p
 +USAKJ2VO9Wzz2aSR+6a0es5vWeWuSK8Fy38ZIuBNCGfiK9klkNJYKN+uRJ7J6gZY+9+
 tCRSmWe7jXuY/HGDySTi8qRAx6bknXEPfe9k5WwqV9y/vBTGaoKb9SPv5q1tR7iC/+b/
 Ew2B8DZkW4Tipxk9BcaTiVNyonLTglWrcYfNWI2lwx2dCXXmHNRAqOp66AR0N+Nr2NVq
 UsUw==
X-Gm-Message-State: AFuF++kxfSmltAHyHZrj9sISlYnURycbyPronZeH291FUNEyJxLWhQKr
 POxTXFbiRFpp+6rpIcE8aHAUF+0q6QmWtqc/nfQjgXe9PDxotEUDXEyILOCMx+6XYQA2uP114be
 R+5uyhoHtHS1nYlDcee+VPGJrhVZSSFQH8ptZzVpsSrqdZSuwEd4szGtUc5sNMiOsww==
X-Gm-Gg: AYBFou2ZTrY+c91kdX73gAEGl4iDaftzoDcDeks6Xh5riHKgfRSuaVS4h72MNEvVip0
 0V9Wq8hP9j5SE6WZtDiljz53VaJIYzO53JTJxRsn/UXSEsRaWjmdxNo1L1mrD81fYeF2r0F9KMd
 Goxohiuocdr5Ag9a0xk4MCuc9q8K6+VSC7W/WiazhgOs2Y2Wped6Hftgu3puUr8yZJvweIFzZRm
 u/GwV1VOApcBmdXygZygHXzQx4PSDbyLTNqU6BabcU+wbugZjfYHnNBKJGGcs4eK+SuBD0ldIuX
 CFimrvuxmu/RdBN4Gg/KfRMsEAudUDF8yalb9iMyolO4s4WQAkB/qnZyyPGsrRdEwai+UOSrDQ8
 Qs18cLmfWJgd6Zt2IxhVeYDyeSRoYjP1tRGwlJQYghB3BUyX+sny4D9S2v54CRGspal1l1sV1HA
 qWR/mDB4fB5nbENTvEzAizGXfNAxyuO+w=
X-Received: by 2002:a17:90b:50cf:b0:39e:345b:3333 with SMTP id
 98e67ed59e1d1-39e345b3d5fmr3537405a91.2.1789622613409; 
 Wed, 16 Sep 2026 22:23:33 -0700 (PDT)
X-Received: by 2002:a17:90b:50cf:b0:39e:345b:3333 with SMTP id
 98e67ed59e1d1-39e345b3d5fmr3537364a91.2.1789622612915; 
 Wed, 16 Sep 2026 22:23:32 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5af4f0bsm14256187eec.24.2026.09.16.22.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 22:23:32 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v11 04/10] hw/riscv/virt: add opt-in RPMI base support
Date: Thu, 17 Sep 2026 10:52:43 +0530
Message-ID: <20260917052250.1041262-5-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917052250.1041262-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260917052250.1041262-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA2OCBTYWx0ZWRfX4102MTTQUuVF
 BQPwynocl3BHaHxF1eY/Q8pFuaRNglHMdPoCkCL9UE2/ZiTq16W+uBf5vMohFTy+J+Dr5aW+Fwp
 t8qi4hLWQ6snQ4U+AHQaSlD0CNgx1E9H5CWqscYg03TRK2wDKgwWCyqcrfni564HLNZSq6093K5
 kSfS0LRDa1ji274OTLt9WWBgYsPHNsKYWLvI0udaNk285ni+zw6RKd258CUKSIpw3KTLgZw4AOv
 1rsLm/8iEcBP5B06S6wd+IxEDR9OsGQwMRn5sNo5eaJpqSxBVN9b4liAfJA22+C7+tz011NONdx
 VO0GsAgOCduf00tt2iuvPPju817BBlmKe9q26jJ/nYlL8hY1nn4UWoXdNnM5JEWIp/42DWpbGIF
 hXrt9yPXkhLcCS28McPLHws8TwD8/sQeoN110qEE3PVobr4Tcj//igOfxSc8BU4jVCdDc0c14Dt
 6PKHSZqRFWAbP06/irA==
X-Proofpoint-GUID: OfZyB1Jiv8setWqd_JjJEeDXiWu4QMOq
X-Authority-Analysis: v=2.4 cv=EoJHPicA c=1 sm=1 tr=0 ts=6aab7956 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=CvjZw6EAnlyfa7EY1UoA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: OfZyB1Jiv8setWqd_JjJEeDXiWu4QMOq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA2OCBTYWx0ZWRfX28vsfKsRZerQ
 fucsxx1Qjgkzr6NZHf1RxKCVRFYdb7utdE7JvmjlNNv7akCmioAX2TtMAPKlRw7WjT7x0CxzKbf
 NsnmLqGBA+pFHsXQr5CH1/7PNLhwYRM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the virt machine rpmi=on/off option and wire the initial RPMI Base
transport into machine realization.

The option remains disabled by default and requires TCG plus librpmi.
Invalid accelerator/build combinations fail during machine
initialization. When enabled, virt allocates the RPMI shared-memory
transport, creates the RPMI device, configures Base service metadata,
and emits the corresponding device-tree nodes for firmware discovery.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/virt.c         | 96 +++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h |  3 ++
 3 files changed, 100 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d06ac26648..c3f9d7580b 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -49,6 +49,7 @@ config RISCV_VIRT
     imply VIRTIO_VGA
     imply TEST_DEVICES
     imply TPM_TIS_SYSBUS
+    imply RISCV_RPMI
     select DEVICE_TREE
     select RISCV_NUMA
     select GOLDFISH_RTC
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d58656f70d..c822cc15ca 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -44,6 +44,8 @@
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_test.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "hw/riscv/rpmi-fdt.h"
 #include "hw/core/platform-bus.h"
 #include "chardev/char.h"
 #include "system/device_tree.h"
@@ -100,6 +102,8 @@ static const MemMapEntry virt_memmap[] = {
     /* UART1 supports page isolation from UART0 */
     [VIRT_UART1] =        { 0x1000a000,         0x100 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
+    [VIRT_RPMI_SHMEM] =   { 0x10200000,       0x20000 },
+    [VIRT_RPMI_DOORBELL] = { 0x10230000,        0x1000 },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
     [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
@@ -988,6 +992,40 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     s->pci_iommu_bdf = bdf;
 }
 
+
+static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
+                                        const uint32_t *hart_ids,
+                                        uint32_t hart_count)
+{
+    return (RiscvRpmiConfig) {
+        .doorbell_base = s->memmap[VIRT_RPMI_DOORBELL].base,
+        .shmem_base = s->memmap[VIRT_RPMI_SHMEM].base,
+        .shmem_size = s->memmap[VIRT_RPMI_SHMEM].size,
+        .a2p_req_size = VIRT_RPMI_A2P_REQ_SIZE,
+        .p2a_req_size = VIRT_RPMI_P2A_REQ_SIZE,
+        .platform_info = "QEMU RISC-V virt RPMI",
+        .hart_ids = hart_ids,
+        .hart_count = hart_count,
+    };
+}
+
+static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
+                            uint32_t msi_phandle)
+{
+    RiscvRpmiConfig rpmi_cfg = virt_rpmi_config(s, NULL, 0);
+    uint32_t rpmi_mbox_handle;
+    RiscvRpmiFdtMboxConfig cfg = {
+        .shmem_base = rpmi_cfg.shmem_base,
+        .doorbell_base = rpmi_cfg.doorbell_base,
+        .a2p_req_size = rpmi_cfg.a2p_req_size,
+        .p2a_req_size = rpmi_cfg.p2a_req_size,
+        .doorbell_size = s->memmap[VIRT_RPMI_DOORBELL].size,
+    };
+
+    riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,
+                            &rpmi_mbox_handle);
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -1007,6 +1045,10 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
 
+    if (s->have_rpmi) {
+        create_fdt_rpmi(s, &phandle, msi_pcie_phandle);
+    }
+
     create_fdt_reset(s, &phandle);
 
     create_fdt_uarts(s, irq_mmio_phandle);
@@ -1334,6 +1376,18 @@ static void virt_machine_init(MachineState *machine)
         exit(1);
     }
 
+
+    if (s->have_rpmi) {
+#ifndef CONFIG_LIBRPMI
+        error_report("RISC-V RPMI support is not compiled in");
+        exit(1);
+#else
+        if (kvm_enabled()) {
+            error_report("RISC-V RPMI support is not available with KVM");
+            exit(1);
+        }
+#endif
+    }
     /* Initialize sockets */
     mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
@@ -1484,6 +1538,25 @@ static void virt_machine_init(MachineState *machine)
     /* SiFive Test MMIO device */
     sifive_test_create(s->memmap[VIRT_TEST].base);
 
+    if (s->have_rpmi) {
+        MachineClass *mc = MACHINE_GET_CLASS(machine);
+        const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
+        g_autofree uint32_t *rpmi_hart_ids =
+            g_new0(uint32_t, machine->smp.cpus);
+        RiscvRpmiConfig rpmi_cfg;
+        Error *local_err = NULL;
+
+        for (i = 0; i < machine->smp.cpus; i++) {
+            rpmi_hart_ids[i] = possible_cpus->cpus[i].arch_id;
+        }
+
+        rpmi_cfg = virt_rpmi_config(s, rpmi_hart_ids, machine->smp.cpus);
+        if (!riscv_rpmi_create(&rpmi_cfg, &local_err)) {
+            error_report_err(local_err);
+            exit(1);
+        }
+    }
+
     /* VirtIO MMIO devices */
     for (i = 0; i < VIRTIO_COUNT; i++) {
         sysbus_create_simple("virtio-mmio",
@@ -1575,6 +1648,7 @@ static void virt_machine_instance_init(Object *obj)
 
     s->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
+    s->have_rpmi = false;
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
     s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
@@ -1650,6 +1724,21 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
     s->have_aclint = value;
 }
 
+
+static bool virt_get_rpmi(Object *obj, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    return s->have_rpmi;
+}
+
+static void virt_set_rpmi(Object *obj, bool value, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    s->have_rpmi = value;
+}
+
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
 {
     return s->iommu_sys == ON_OFF_AUTO_ON;
@@ -1771,6 +1860,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "enable/disable emulating "
                                           "ACLINT devices");
 
+
+    object_class_property_add_bool(oc, "rpmi", virt_get_rpmi,
+                                   virt_set_rpmi);
+    object_class_property_set_description(oc, "rpmi",
+                                          "Set on/off to enable/disable "
+                                          "RISC-V RPMI devices");
+
     object_class_property_add_str(oc, "aia", virt_get_aia,
                                   virt_set_aia);
     object_class_property_set_description(oc, "aia",
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 7c862b0da2..76b5a57001 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -55,6 +55,7 @@ struct RISCVVirtState {
 
     int fdt_size;
     bool have_aclint;
+    bool have_rpmi;
     RISCVVirtAIAType aia_type;
     int aia_guests;
     char *oem_id;
@@ -82,6 +83,8 @@ enum {
     VIRT_VIRTIO,
     VIRT_UART1,
     VIRT_FW_CFG,
+    VIRT_RPMI_SHMEM,
+    VIRT_RPMI_DOORBELL,
     VIRT_IMSIC_M,
     VIRT_IMSIC_S,
     VIRT_FLASH,

