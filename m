Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F50CD1283
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 05:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrAdd-0001fo-Un; Mon, 01 Apr 2024 01:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1rrAdb-0001fE-OR
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 01:55:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1rrAdZ-0004Uk-PL
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 01:55:19 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4314SGjE027728
 for <qemu-devel@nongnu.org>; Mon, 1 Apr 2024 05:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z1wOLA9aX/83xmeiPbxJ9U1+Nym/F3Cj6vNJ3HkldAI=;
 b=kCQ3cy2mEl8yiGYLA8h4CHGhZXizIN+jU6ODCQ3K2X7kzO8oSCjx09OBoAVbTGumH+XQ
 rlKAp1B14dlDcfh4yaFIfpoqtc+tuIdcmwpyzP3CnmFtNUuTcPb5u0iMRJVRqQhGeQRN
 V4XUCJJ37/uKyHPGBvTMbQbhgubG9sZV5RwAmg7Kt01djQmuOCv+5h3ASFpIOc9Arg0F
 UUxreiQBFWreisCdNjoX07w20ceOY8EbloUqJP3YcuoD11v+UrrqO7Gk3bKfP2tWJizN
 /P6so4xkzhdLK1PPhH8cn5W/SoTOlusug3Ad0aMWIXiaqc+Gb2/JJW7cX9YgeI5H0+8G 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x7nx0847x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 05:55:15 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4315tED4026791
 for <qemu-devel@nongnu.org>; Mon, 1 Apr 2024 05:55:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x7nx0847w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Apr 2024 05:55:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4314LN4m002227; Mon, 1 Apr 2024 05:55:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6xjm6c6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Apr 2024 05:55:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4315t8dU29360844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Apr 2024 05:55:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55ADC2005A;
 Mon,  1 Apr 2024 05:55:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B09C20040;
 Mon,  1 Apr 2024 05:55:07 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Apr 2024 05:55:07 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/2] ppc: pseries: add P11 cpu type
Date: Mon,  1 Apr 2024 11:25:02 +0530
Message-ID: <20240401055503.1880587-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240401055503.1880587-1-adityag@linux.ibm.com>
References: <20240401055503.1880587-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dBcaNtzVfRUF7GY-6I_gH8xWa36pfrgO
X-Proofpoint-ORIG-GUID: eXG7g5yozqIntLyhZMKn6WNQTF5C94Um
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_02,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010039
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Base support for "--cpu power11" in QEMU

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/system/ppc/pseries.rst |   6 +-
 hw/ppc/spapr_cpu_core.c     |   1 +
 target/ppc/compat.c         |   7 ++
 target/ppc/cpu-models.c     |   2 +
 target/ppc/cpu-models.h     |   2 +
 target/ppc/cpu_init.c       | 162 ++++++++++++++++++++++++++++++++++++
 6 files changed, 177 insertions(+), 3 deletions(-)

diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
index a876d897b6e4..3277564b34c2 100644
--- a/docs/system/ppc/pseries.rst
+++ b/docs/system/ppc/pseries.rst
@@ -15,9 +15,9 @@ Supported devices
 =================
 
  * Multi processor support for many Power processors generations: POWER7,
-   POWER7+, POWER8, POWER8NVL, POWER9, and Power10. Support for POWER5+ exists,
-   but its state is unknown.
- * Interrupt Controller, XICS (POWER8) and XIVE (POWER9 and Power10)
+   POWER7+, POWER8, POWER8NVL, POWER9, Power10 and Power11. Support for POWER5+
+   exists, but its state is unknown.
+ * Interrupt Controller, XICS (POWER8) and XIVE (POWER9, Power10, Power11)
  * vPHB PCIe Host bridge.
  * vscsi and vnet devices, compatible with the same devices available on a
    PowerVM hypervisor with VIOS managing LPARs.
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 5aa1ed474ad6..96a389264b71 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -400,6 +400,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power10_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power11"),
 #ifdef CONFIG_KVM
     DEFINE_SPAPR_CPU_CORE_TYPE("host"),
 #endif
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index ebef2cccecf3..12dd8ae290ca 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -100,6 +100,13 @@ static const CompatInfo compat_table[] = {
         .pcr_level = PCR_COMPAT_3_10,
         .max_vthreads = 8,
     },
+    { /* POWER11, ISA3.10 */
+        .name = "power11",
+        .pvr = CPU_POWERPC_LOGICAL_3_10_PLUS,
+        .pcr = PCR_COMPAT_3_10,
+        .pcr_level = PCR_COMPAT_3_10,
+        .max_vthreads = 8,
+    },
 };
 
 static const CompatInfo *compat_by_pvr(uint32_t pvr)
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 7dbb47de6456..f97c4dadb6fd 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -738,6 +738,8 @@
                 "POWER10 v1.0")
     POWERPC_DEF("power10_v2.0",  CPU_POWERPC_POWER10_DD20,           POWER10,
                 "POWER10 v2.0")
+    POWERPC_DEF("power11",  CPU_POWERPC_POWER11,           POWER11,
+                "POWER11")
 #endif /* defined (TARGET_PPC64) */
 
 /***************************************************************************/
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 0229ef3a9a5c..a1b540c3aa9e 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -354,6 +354,7 @@ enum {
     CPU_POWERPC_POWER10_BASE       = 0x00800000,
     CPU_POWERPC_POWER10_DD1        = 0x00801100,
     CPU_POWERPC_POWER10_DD20       = 0x00801200,
+    CPU_POWERPC_POWER11            = 0x00821200,
     CPU_POWERPC_970_v22            = 0x00390202,
     CPU_POWERPC_970FX_v10          = 0x00391100,
     CPU_POWERPC_970FX_v20          = 0x003C0200,
@@ -391,6 +392,7 @@ enum {
     CPU_POWERPC_LOGICAL_2_07       = 0x0F000004,
     CPU_POWERPC_LOGICAL_3_00       = 0x0F000005,
     CPU_POWERPC_LOGICAL_3_10       = 0x0F000006,
+    CPU_POWERPC_LOGICAL_3_10_PLUS  = 0x0F000007,
 };
 
 /* System version register (used on MPC 8xxx)                                */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 344196a8ce3d..aec4a6599af2 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2087,6 +2087,11 @@ static void init_excp_POWER10(CPUPPCState *env)
     init_excp_POWER9(env);
 }
 
+static void init_excp_POWER11(CPUPPCState *env)
+{
+    init_excp_POWER9(env);
+}
+
 #endif
 
 static int check_pow_hid0(CPUPPCState *env)
@@ -6625,6 +6630,163 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->l1_icache_size = 0x8000;
 }
 
+static void init_proc_POWER11(CPUPPCState *env)
+{
+    /* Common Registers */
+    init_proc_book3s_common(env);
+    register_book3s_207_dbg_sprs(env);
+
+    /* Common TCG PMU */
+    init_tcg_pmu_power8(env);
+
+    /* POWER8 Specific Registers */
+    register_book3s_ids_sprs(env);
+    register_amr_sprs(env);
+    register_iamr_sprs(env);
+    register_book3s_purr_sprs(env);
+    register_power5p_common_sprs(env);
+    register_power5p_lpar_sprs(env);
+    register_power5p_ear_sprs(env);
+    register_power5p_tb_sprs(env);
+    register_power6_common_sprs(env);
+    register_HEIR64_spr(env);
+    register_power6_dbg_sprs(env);
+    register_power8_tce_address_control_sprs(env);
+    register_power8_ids_sprs(env);
+    register_power8_ebb_sprs(env);
+    register_power8_fscr_sprs(env);
+    register_power8_pmu_sup_sprs(env);
+    register_power8_pmu_user_sprs(env);
+    register_power8_tm_sprs(env);
+    register_power8_pspb_sprs(env);
+    register_power8_dpdes_sprs(env);
+    register_vtb_sprs(env);
+    register_power8_ic_sprs(env);
+    register_power9_book4_sprs(env);
+    register_power8_rpr_sprs(env);
+    register_power9_mmu_sprs(env);
+    register_power10_hash_sprs(env);
+    register_power10_dexcr_sprs(env);
+
+    /* FIXME: Filter fields properly based on privilege level */
+    spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
+                        spr_read_generic, spr_write_generic,
+                        KVM_REG_PPC_PSSCR, 0);
+
+    /* env variables */
+    env->dcache_line_size = 128;
+    env->icache_line_size = 128;
+
+    /* Allocate hardware IRQ controller */
+    init_excp_POWER11(env);
+    ppcPOWER9_irq_init(env_archcpu(env));
+}
+
+static bool ppc_pvr_match_power11(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
+{
+    uint32_t base = pvr & CPU_POWERPC_POWER_SERVER_MASK;
+    uint32_t pcc_base = pcc->pvr & CPU_POWERPC_POWER_SERVER_MASK;
+
+    if (!best) {
+        if (base == CPU_POWERPC_POWER11) {
+            return true;
+        }
+    }
+
+    if (base != pcc_base) {
+        return false;
+    }
+
+    if ((pvr & 0x0f00) == (pcc->pvr & 0x0f00)) {
+        /* FIXME COMMENT: Major DD version matches to power10_v1.0 and power10_v2.0 */
+        return true;
+    }
+
+    return false;
+}
+
+POWERPC_FAMILY(POWER11)(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
+
+    dc->fw_name = "PowerPC,POWER11";
+    dc->desc = "POWER11";
+    pcc->pvr_match = ppc_pvr_match_power11;
+    pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07 |
+                    PCR_COMPAT_3_00 | PCR_COMPAT_3_10;
+    pcc->pcr_supported = PCR_COMPAT_3_10 | PCR_COMPAT_3_00 | PCR_COMPAT_2_07 |
+                         PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
+    pcc->init_proc = init_proc_POWER11;
+    pcc->check_pow = check_pow_nocheck;
+    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
+                       PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
+                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
+                       PPC_FLOAT_FRSQRTES |
+                       PPC_FLOAT_STFIWX |
+                       PPC_FLOAT_EXT |
+                       PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
+                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
+                       PPC_MEM_TLBIE | PPC_MEM_TLBSYNC |
+                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
+                       PPC_SEGMENT_64B | PPC_SLBI |
+                       PPC_POPCNTB | PPC_POPCNTWD |
+                       PPC_CILDST;
+    pcc->insns_flags2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |
+                        PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
+                        PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
+                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
+                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
+                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
+                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
+                        PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
+    pcc->msr_mask = (1ull << MSR_SF) |
+                    (1ull << MSR_HV) |
+                    (1ull << MSR_TM) |
+                    (1ull << MSR_VR) |
+                    (1ull << MSR_VSX) |
+                    (1ull << MSR_EE) |
+                    (1ull << MSR_PR) |
+                    (1ull << MSR_FP) |
+                    (1ull << MSR_ME) |
+                    (1ull << MSR_FE0) |
+                    (1ull << MSR_SE) |
+                    (1ull << MSR_DE) |
+                    (1ull << MSR_FE1) |
+                    (1ull << MSR_IR) |
+                    (1ull << MSR_DR) |
+                    (1ull << MSR_PMM) |
+                    (1ull << MSR_RI) |
+                    (1ull << MSR_LE);
+    pcc->lpcr_mask = LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
+        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
+        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
+        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
+                             LPCR_DEE | LPCR_OEE))
+        | LPCR_MER | LPCR_GTSE | LPCR_TC |
+        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
+    /* DD2 adds an extra HAIL bit */
+    pcc->lpcr_mask |= LPCR_HAIL;
+
+    pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
+    pcc->mmu_model = POWERPC_MMU_3_00;
+#if !defined(CONFIG_USER_ONLY)
+    /* segment page size remain the same */
+    pcc->hash64_opts = &ppc_hash64_opts_POWER7;
+    pcc->radix_page_info = &POWER10_radix_page_info;
+    pcc->lrg_decr_bits = 56;
+#endif
+    pcc->excp_model = POWERPC_EXCP_POWER10;
+    pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
+    pcc->bfd_mach = bfd_mach_ppc64;
+    pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
+                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
+                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
+                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
+    pcc->l1_dcache_size = 0x8000;
+    pcc->l1_icache_size = 0x8000;
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
 {
-- 
2.43.0


