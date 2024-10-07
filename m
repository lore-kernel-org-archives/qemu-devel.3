Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E7ECFB448
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxppQ-0002mZ-AW; Mon, 07 Oct 2024 11:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sxppE-0002OU-Te; Mon, 07 Oct 2024 11:39:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sxppC-0001Wb-Fe; Mon, 07 Oct 2024 11:39:08 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497CP59g005684;
 Mon, 7 Oct 2024 15:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 b49RX0PSDpZXRkOFjZ3TMCwTxXD0qleRTv8FDtXiezs=; b=rOOn0b2otAq+aWdW
 lGwMts+demNwLDjCaDs9Gq649rbqMUuErA74FFoPzoPAdCFRKIlBlPXBdXkk20gz
 CrOXHnqwUxVNSEcJ237JUudkFgJFulMVlf8iid3c2nNrH8zaZpQi4EdoiQ3NfT9O
 Tgcsz0oQCHa+1dAsc0XLLsgxI5KGuSCmzNAWhNE5ixUz7GNSQLNBxQigydmDq1Ms
 G34vnv3OOYbn0Z72VNR0ybpAxaVAIn2BI0HXSYSFaRnoW9KmK0xen/XX+q9Dxjas
 Tf/tE7dR5rZN5QqkIO2pXGep6ycxGuMFLV3vuqJ0kXGAdjGDV/JF9e8na2DvN8d+
 xtDTqA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424fmph2qt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:56 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497FcufS023695;
 Mon, 7 Oct 2024 15:38:56 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424fmph2qn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497DTOAi013798;
 Mon, 7 Oct 2024 15:38:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fsrymc6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 497Fcrol49348962
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Oct 2024 15:38:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84C992004B;
 Mon,  7 Oct 2024 15:38:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BD0020040;
 Mon,  7 Oct 2024 15:38:52 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Oct 2024 15:38:52 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v3 07/14] ppc/spapr: remove deprecated machine pseries-2.7
Date: Mon,  7 Oct 2024 21:08:31 +0530
Message-ID: <20241007153838.1085522-8-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007153838.1085522-1-harshpb@linux.ibm.com>
References: <20241007153838.1085522-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XNrOmEorfkPO0lNTU9I8E8bV1gmBA7AG
X-Proofpoint-ORIG-GUID: MHl6gF308GEan2bS0WCKjSdDQrUjC-AT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_08,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 phishscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410070108
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.7 specific code with this patch for now.

While at it, also remove pre-2.8-migration and pci/mmio hacks introduced
for backward compatibility.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/pci-host/spapr.h |  4 --
 target/ppc/cpu.h            |  5 ---
 hw/ppc/spapr.c              | 75 -------------------------------------
 hw/ppc/spapr_pci.c          | 57 ++++------------------------
 target/ppc/cpu_init.c       |  1 -
 target/ppc/machine.c        | 52 -------------------------
 6 files changed, 7 insertions(+), 187 deletions(-)

diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 79187e80fd..0db87f1281 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -83,10 +83,6 @@ struct SpaprPhbState {
     bool pcie_ecs; /* Allow access to PCIe extended config space? */
 
     /* Fields for migration compatibility hacks */
-    bool pre_2_8_migration;
-    uint32_t mig_liobn;
-    hwaddr mig_mem_win_addr, mig_mem_win_size;
-    hwaddr mig_io_win_addr, mig_io_win_size;
     bool pre_5_1_assoc;
 };
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 321ed2da75..cab4a46fc1 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1456,11 +1456,6 @@ struct ArchCPU {
     opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
 
     /* Fields related to migration compatibility hacks */
-    bool pre_2_8_migration;
-    target_ulong mig_msr_mask;
-    uint64_t mig_insns_flags;
-    uint64_t mig_insns_flags2;
-    uint32_t mig_nb_BATs;
     bool pre_2_10_migration;
     bool pre_3_0_migration;
     int32_t mig_slb_nr;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a9c988b8f6..c89ab89b97 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5203,81 +5203,6 @@ static void spapr_machine_2_8_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 8);
 
-/*
- * pseries-2.7
- */
-
-static bool phb_placement_2_7(SpaprMachineState *spapr, uint32_t index,
-                              uint64_t *buid, hwaddr *pio,
-                              hwaddr *mmio32, hwaddr *mmio64,
-                              unsigned n_dma, uint32_t *liobns, Error **errp)
-{
-    /* Legacy PHB placement for pseries-2.7 and earlier machine types */
-    const uint64_t base_buid = 0x800000020000000ULL;
-    const hwaddr phb_spacing = 0x1000000000ULL; /* 64 GiB */
-    const hwaddr mmio_offset = 0xa0000000; /* 2 GiB + 512 MiB */
-    const hwaddr pio_offset = 0x80000000; /* 2 GiB */
-    const uint32_t max_index = 255;
-    const hwaddr phb0_alignment = 0x10000000000ULL; /* 1 TiB */
-
-    uint64_t ram_top = MACHINE(spapr)->ram_size;
-    hwaddr phb0_base, phb_base;
-    int i;
-
-    /* Do we have device memory? */
-    if (MACHINE(spapr)->device_memory) {
-        /* Can't just use maxram_size, because there may be an
-         * alignment gap between normal and device memory regions
-         */
-        ram_top = MACHINE(spapr)->device_memory->base +
-            memory_region_size(&MACHINE(spapr)->device_memory->mr);
-    }
-
-    phb0_base = QEMU_ALIGN_UP(ram_top, phb0_alignment);
-
-    if (index > max_index) {
-        error_setg(errp, "\"index\" for PAPR PHB is too large (max %u)",
-                   max_index);
-        return false;
-    }
-
-    *buid = base_buid + index;
-    for (i = 0; i < n_dma; ++i) {
-        liobns[i] = SPAPR_PCI_LIOBN(index, i);
-    }
-
-    phb_base = phb0_base + index * phb_spacing;
-    *pio = phb_base + pio_offset;
-    *mmio32 = phb_base + mmio_offset;
-    /*
-     * We don't set the 64-bit MMIO window, relying on the PHB's
-     * fallback behaviour of automatically splitting a large "32-bit"
-     * window into contiguous 32-bit and 64-bit windows
-     */
-
-    return true;
-}
-
-static void spapr_machine_2_7_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] = {
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0xf80000000", },
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem64_win_size", "0", },
-        { TYPE_POWERPC_CPU, "pre-2.8-migration", "on", },
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pre-2.8-migration", "on", },
-    };
-
-    spapr_machine_2_8_class_options(mc);
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power7_v2.3");
-    mc->default_machine_opts = "modern-hotplug-events=off";
-    compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    smc->phb_placement = phb_placement_2_7;
-}
-
-DEFINE_SPAPR_MACHINE(2, 7);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 8f1964ce52..7e24084673 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1814,30 +1814,15 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
 
     assert(sphb->index != (uint32_t)-1); /* checked in spapr_phb_pre_plug() */
 
-    if (sphb->mem64_win_size != 0) {
-        if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
-            error_setg(errp, "32-bit memory window of size 0x%"HWADDR_PRIx
-                       " (max 2 GiB)", sphb->mem_win_size);
-            return;
-        }
-
-        /* 64-bit window defaults to identity mapping */
-        sphb->mem64_win_pciaddr = sphb->mem64_win_addr;
-    } else if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
-        /*
-         * For compatibility with old configuration, if no 64-bit MMIO
-         * window is specified, but the ordinary (32-bit) memory
-         * window is specified as > 2GiB, we treat it as a 2GiB 32-bit
-         * window, with a 64-bit MMIO window following on immediately
-         * afterwards
-         */
-        sphb->mem64_win_size = sphb->mem_win_size - SPAPR_PCI_MEM32_WIN_SIZE;
-        sphb->mem64_win_addr = sphb->mem_win_addr + SPAPR_PCI_MEM32_WIN_SIZE;
-        sphb->mem64_win_pciaddr =
-            SPAPR_PCI_MEM_WIN_BUS_OFFSET + SPAPR_PCI_MEM32_WIN_SIZE;
-        sphb->mem_win_size = SPAPR_PCI_MEM32_WIN_SIZE;
+    if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
+        error_setg(errp, "32-bit memory window of size 0x%"HWADDR_PRIx
+                   " (max 2 GiB)", sphb->mem_win_size);
+        return;
     }
 
+    /* 64-bit window defaults to identity mapping */
+    sphb->mem64_win_pciaddr = sphb->mem64_win_addr;
+
     if (spapr_pci_find_phb(spapr, sphb->buid)) {
         SpaprPhbState *s;
 
@@ -2066,8 +2051,6 @@ static Property spapr_phb_properties[] = {
                        (1ULL << 12) | (1ULL << 16)
                        | (1ULL << 21) | (1ULL << 24)),
     DEFINE_PROP_UINT32("numa_node", SpaprPhbState, numa_node, -1),
-    DEFINE_PROP_BOOL("pre-2.8-migration", SpaprPhbState,
-                     pre_2_8_migration, false),
     DEFINE_PROP_BOOL("pcie-extended-configuration-space", SpaprPhbState,
                      pcie_ecs, true),
     DEFINE_PROP_BOOL("pre-5.1-associativity", SpaprPhbState,
@@ -2105,20 +2088,6 @@ static int spapr_pci_pre_save(void *opaque)
     gpointer key, value;
     int i;
 
-    if (sphb->pre_2_8_migration) {
-        sphb->mig_liobn = sphb->dma_liobn[0];
-        sphb->mig_mem_win_addr = sphb->mem_win_addr;
-        sphb->mig_mem_win_size = sphb->mem_win_size;
-        sphb->mig_io_win_addr = sphb->io_win_addr;
-        sphb->mig_io_win_size = sphb->io_win_size;
-
-        if ((sphb->mem64_win_size != 0)
-            && (sphb->mem64_win_addr
-                == (sphb->mem_win_addr + sphb->mem_win_size))) {
-            sphb->mig_mem_win_size += sphb->mem64_win_size;
-        }
-    }
-
     g_free(sphb->msi_devs);
     sphb->msi_devs = NULL;
     sphb->msi_devs_num = g_hash_table_size(sphb->msi);
@@ -2165,13 +2134,6 @@ static int spapr_pci_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static bool pre_2_8_migration(void *opaque, int version_id)
-{
-    SpaprPhbState *sphb = opaque;
-
-    return sphb->pre_2_8_migration;
-}
-
 static const VMStateDescription vmstate_spapr_pci = {
     .name = "spapr_pci",
     .version_id = 2,
@@ -2181,11 +2143,6 @@ static const VMStateDescription vmstate_spapr_pci = {
     .post_load = spapr_pci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64_EQUAL(buid, SpaprPhbState, NULL),
-        VMSTATE_UINT32_TEST(mig_liobn, SpaprPhbState, pre_2_8_migration),
-        VMSTATE_UINT64_TEST(mig_mem_win_addr, SpaprPhbState, pre_2_8_migration),
-        VMSTATE_UINT64_TEST(mig_mem_win_size, SpaprPhbState, pre_2_8_migration),
-        VMSTATE_UINT64_TEST(mig_io_win_addr, SpaprPhbState, pre_2_8_migration),
-        VMSTATE_UINT64_TEST(mig_io_win_size, SpaprPhbState, pre_2_8_migration),
         VMSTATE_STRUCT_ARRAY(lsi_table, SpaprPhbState, PCI_NUM_PINS, 0,
                              vmstate_spapr_pci_lsi, SpaprPciLsi),
         VMSTATE_INT32(msi_devs_num, SpaprPhbState),
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 23881d09e9..7768392986 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7452,7 +7452,6 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 }
 
 static Property ppc_cpu_properties[] = {
-    DEFINE_PROP_BOOL("pre-2.8-migration", PowerPCCPU, pre_2_8_migration, false),
     DEFINE_PROP_BOOL("pre-2.10-migration", PowerPCCPU, pre_2_10_migration,
                      false),
     DEFINE_PROP_BOOL("pre-3.0-migration", PowerPCCPU, pre_3_0_migration,
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index d433fd45fc..21bed7c7c8 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -118,13 +118,6 @@ static const VMStateInfo vmstate_info_vsr = {
 #define VMSTATE_VSR_ARRAY(_f, _s, _n)                             \
     VMSTATE_VSR_ARRAY_V(_f, _s, _n, 0)
 
-static bool cpu_pre_2_8_migration(void *opaque, int version_id)
-{
-    PowerPCCPU *cpu = opaque;
-
-    return cpu->pre_2_8_migration;
-}
-
 #if defined(TARGET_PPC64)
 static bool cpu_pre_3_0_migration(void *opaque, int version_id)
 {
@@ -139,22 +132,6 @@ static int cpu_pre_save(void *opaque)
     PowerPCCPU *cpu = opaque;
     CPUPPCState *env = &cpu->env;
     int i;
-    uint64_t insns_compat_mask =
-        PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB
-        | PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES
-        | PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE | PPC_FLOAT_FRSQRTES
-        | PPC_FLOAT_STFIWX | PPC_FLOAT_EXT
-        | PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ
-        | PPC_MEM_SYNC | PPC_MEM_EIEIO | PPC_MEM_TLBIE | PPC_MEM_TLBSYNC
-        | PPC_64B | PPC_64BX | PPC_ALTIVEC
-        | PPC_SEGMENT_64B | PPC_SLBI | PPC_POPCNTB | PPC_POPCNTWD;
-    uint64_t insns_compat_mask2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX
-        | PPC2_PERM_ISA206 | PPC2_DIVE_ISA206
-        | PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206
-        | PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207
-        | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207
-        | PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_TM
-        | PPC2_MEM_LWSYNC;
 
     env->spr[SPR_LR] = env->lr;
     env->spr[SPR_CTR] = env->ctr;
@@ -177,29 +154,6 @@ static int cpu_pre_save(void *opaque)
         env->spr[SPR_IBAT4U + 2 * i + 1] = env->IBAT[1][i + 4];
     }
 
-    /* Hacks for migration compatibility between 2.6, 2.7 & 2.8 */
-    if (cpu->pre_2_8_migration) {
-        /*
-         * Mask out bits that got added to msr_mask since the versions
-         * which stupidly included it in the migration stream.
-         */
-        target_ulong metamask = 0
-#if defined(TARGET_PPC64)
-            | (1ULL << MSR_TS0)
-            | (1ULL << MSR_TS1)
-#endif
-            ;
-        cpu->mig_msr_mask = env->msr_mask & ~metamask;
-        cpu->mig_insns_flags = env->insns_flags & insns_compat_mask;
-        /*
-         * CPU models supported by old machines all have
-         * PPC_MEM_TLBIE, so we set it unconditionally to allow
-         * backward migration from a POWER9 host to a POWER8 host.
-         */
-        cpu->mig_insns_flags |= PPC_MEM_TLBIE;
-        cpu->mig_insns_flags2 = env->insns_flags2 & insns_compat_mask2;
-        cpu->mig_nb_BATs = env->nb_BATs;
-    }
     if (cpu->pre_3_0_migration) {
         if (cpu->hash64_opts) {
             cpu->mig_slb_nr = cpu->hash64_opts->slb_size;
@@ -760,12 +714,6 @@ const VMStateDescription vmstate_ppc_cpu = {
         /* Backward compatible internal state */
         VMSTATE_UINTTL(env.hflags_compat_nmsr, PowerPCCPU),
 
-        /* Sanity checking */
-        VMSTATE_UINTTL_TEST(mig_msr_mask, PowerPCCPU, cpu_pre_2_8_migration),
-        VMSTATE_UINT64_TEST(mig_insns_flags, PowerPCCPU, cpu_pre_2_8_migration),
-        VMSTATE_UINT64_TEST(mig_insns_flags2, PowerPCCPU,
-                            cpu_pre_2_8_migration),
-        VMSTATE_UINT32_TEST(mig_nb_BATs, PowerPCCPU, cpu_pre_2_8_migration),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
-- 
2.45.2


