Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88B5C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 05:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ2Ej-0003Be-1i; Wed, 31 Jul 2024 01:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZ2Ee-0002uc-Tx; Wed, 31 Jul 2024 01:50:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZ2Ec-0007Nn-D8; Wed, 31 Jul 2024 01:50:52 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V4xmmG027953;
 Wed, 31 Jul 2024 05:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 eSFXwttmeKMmn2p7RQIU2PElHLGiN8wfZ+lXSrqrozg=; b=DVeFDsx+Ij9ravNw
 KPUZQe7NDvguXH6cgZ7M4DWJ/rj43SC8jAuW2A8p/i6R0ElwN/4fDuJgoMYcyZ39
 fK0tfgjb1P1Nl2FuhKNszVbuxFvCJ02IKzByMKK1Rt4kEeSq1lzPn1NsG/UFg70+
 DItERg8b0/O9fcaEQ6i+AuKv6QoOxm59xg4qOomvyOIxnIN3OHWYR3/ianS1RI1z
 46GKb98ahhIRY46V9tbasNzK/gJLC279tzexI7y8TniUz9qzRphCbMobvu7b1Bj+
 7kthrH9M1LOj5FK6GxUuAKu+dq+GR5HUrM81xA0LVHdxFCdfU2of9+9Qq12ceos7
 5SxWzw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qeqbg2vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 05:50:41 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46V5oe3r016409;
 Wed, 31 Jul 2024 05:50:40 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qeqbg2vq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 05:50:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46V4pWvp007470; Wed, 31 Jul 2024 05:50:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7u9u5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 05:50:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46V5oYxe52167004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jul 2024 05:50:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 771EB2004E;
 Wed, 31 Jul 2024 05:50:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38B5220040;
 Wed, 31 Jul 2024 05:50:32 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jul 2024 05:50:31 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v6 RESEND 4/5] target/ppc: Add Power11 DD2.0 processor
Date: Wed, 31 Jul 2024 11:20:21 +0530
Message-ID: <20240731055022.696051-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731055022.696051-1-adityag@linux.ibm.com>
References: <20240731055022.696051-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rxGD1A41thasgsSWRi_F021uGtg-uU1c
X-Proofpoint-GUID: dh0jZj1AmKZ3wsHF5tcJ3UEawCRFD1Fd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_02,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310039
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
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

Add CPU target code to add support for new Power11 Processor.

Power11 core is same as Power10, hence reuse functions defined for
Power10.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 target/ppc/compat.c      |  7 +++++
 target/ppc/cpu-models.c  |  3 ++
 target/ppc/cpu-models.h  |  3 ++
 target/ppc/cpu.h         |  2 ++
 target/ppc/cpu_init.c    | 60 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/cpu_init.h    |  8 ++++++
 target/ppc/excp_helper.c |  4 +++
 7 files changed, 87 insertions(+)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 5b20fd7ef04c..0cec1bde9179 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -100,6 +100,13 @@ static const CompatInfo compat_table[] = {
         .pcr_level = PCR_COMPAT_3_10,
         .max_vthreads = 8,
     },
+    { /* POWER11, ISA3.10 */
+        .name = "power11",
+        .pvr = CPU_POWERPC_LOGICAL_3_10_P11,
+        .pcr = PCR_COMPAT_3_10,
+        .pcr_level = PCR_COMPAT_3_10,
+        .max_vthreads = 8,
+    },
 };
 
 static const CompatInfo *compat_by_pvr(uint32_t pvr)
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index f2301b43f78b..ece348178188 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -734,6 +734,8 @@
                 "POWER9 v2.2")
     POWERPC_DEF("power10_v2.0",  CPU_POWERPC_POWER10_DD20,           POWER10,
                 "POWER10 v2.0")
+    POWERPC_DEF("power11_v2.0",  CPU_POWERPC_POWER11_DD20,           POWER11,
+                "POWER11_v2.0")
 #endif /* defined (TARGET_PPC64) */
 
 /***************************************************************************/
@@ -909,6 +911,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "power8nvl", "power8nvl_v1.0" },
     { "power9", "power9_v2.2" },
     { "power10", "power10_v2.0" },
+    { "power11", "power11_v2.0" },
 #endif
 
     /* Generic PowerPCs */
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 0229ef3a9a5c..72ad31ba50d7 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -354,6 +354,8 @@ enum {
     CPU_POWERPC_POWER10_BASE       = 0x00800000,
     CPU_POWERPC_POWER10_DD1        = 0x00801100,
     CPU_POWERPC_POWER10_DD20       = 0x00801200,
+    CPU_POWERPC_POWER11_BASE       = 0x00820000,
+    CPU_POWERPC_POWER11_DD20       = 0x00821200,
     CPU_POWERPC_970_v22            = 0x00390202,
     CPU_POWERPC_970FX_v10          = 0x00391100,
     CPU_POWERPC_970FX_v20          = 0x003C0200,
@@ -391,6 +393,7 @@ enum {
     CPU_POWERPC_LOGICAL_2_07       = 0x0F000004,
     CPU_POWERPC_LOGICAL_3_00       = 0x0F000005,
     CPU_POWERPC_LOGICAL_3_10       = 0x0F000006,
+    CPU_POWERPC_LOGICAL_3_10_P11   = 0x0F000007,
 };
 
 /* System version register (used on MPC 8xxx)                                */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 752e11204b35..d1d60b4eac55 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -215,6 +215,8 @@ typedef enum powerpc_excp_t {
     POWERPC_EXCP_POWER9,
     /* POWER10 exception model           */
     POWERPC_EXCP_POWER10,
+    /* POWER11 exception model           */
+    POWERPC_EXCP_POWER11,
 } powerpc_excp_t;
 
 /*****************************************************************************/
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c5cd4133ea2f..9cb5dd4596bf 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6675,6 +6675,66 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->l1_icache_size = 0x8000;
 }
 
+static void init_proc_POWER11(CPUPPCState *env)
+{
+    init_proc_POWER10(env);
+}
+
+static bool ppc_pvr_match_power11(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
+{
+    uint32_t base = pvr & CPU_POWERPC_POWER_SERVER_MASK;
+    uint32_t pcc_base = pcc->pvr & CPU_POWERPC_POWER_SERVER_MASK;
+
+    if (!best && (base == CPU_POWERPC_POWER11_BASE)) {
+        return true;
+    }
+
+    if (base != pcc_base) {
+        return false;
+    }
+
+    if ((pvr & 0x0f00) == (pcc->pvr & 0x0f00)) {
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
+    pcc->spapr_logical_pvr = CPU_POWERPC_LOGICAL_3_10_P11;
+    pcc->pvr_match = ppc_pvr_match_power11;
+    pcc->pcr_mask = PPC_PCR_MASK_POWER11;
+    pcc->pcr_supported = PPC_PCR_SUPPORTED_POWER11;
+    pcc->init_proc = init_proc_POWER11;
+    pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_hid0_power9;
+    pcc->insns_flags = PPC_INSNS_FLAGS_POWER11;
+    pcc->insns_flags2 = PPC_INSNS_FLAGS2_POWER11;
+    pcc->msr_mask = PPC_MSR_MASK_POWER11;
+    pcc->lpcr_mask = PPC_LPCR_MASK_POWER11;
+
+    pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
+    pcc->mmu_model = POWERPC_MMU_3_00;
+#if !defined(CONFIG_USER_ONLY)
+    /* segment page size remain the same */
+    pcc->hash64_opts = &ppc_hash64_opts_POWER7;
+    pcc->radix_page_info = &POWER10_radix_page_info;
+    pcc->lrg_decr_bits = 56;
+#endif
+    pcc->excp_model = POWERPC_EXCP_POWER11;
+    pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
+    pcc->bfd_mach = bfd_mach_ppc64;
+    pcc->flags = POWERPC_FLAGS_POWER11;
+    pcc->l1_dcache_size = 0x8000;
+    pcc->l1_icache_size = 0x8000;
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
 {
diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
index 7479b59da73b..355d304e38ae 100644
--- a/target/ppc/cpu_init.h
+++ b/target/ppc/cpu_init.h
@@ -13,6 +13,8 @@
 
 #define PPC_INSNS_FLAGS_POWER10 PPC_INSNS_FLAGS_POWER9
 
+#define PPC_INSNS_FLAGS_POWER11 PPC_INSNS_FLAGS_POWER10
+
 #define PPC_INSNS_FLAGS2_POWER_COMMON                               \
     PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |                 \
     PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
@@ -25,6 +27,7 @@
     PPC_INSNS_FLAGS2_POWER_COMMON | PPC2_TM
 #define PPC_INSNS_FLAGS2_POWER10                                    \
     PPC_INSNS_FLAGS2_POWER_COMMON | PPC2_ISA310
+#define PPC_INSNS_FLAGS2_POWER11 PPC_INSNS_FLAGS2_POWER10
 
 #define PPC_MSR_MASK_POWER_COMMON          \
     (1ull << MSR_SF) |                     \
@@ -49,16 +52,19 @@
     PPC_MSR_MASK_POWER_COMMON | (1ull << MSR_TM)
 #define PPC_MSR_MASK_POWER10        \
     PPC_MSR_MASK_POWER_COMMON
+#define PPC_MSR_MASK_POWER11 PPC_MSR_MASK_POWER10
 
 #define PPC_PCR_MASK_POWER9         \
     PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07
 #define PPC_PCR_MASK_POWER10        \
     PPC_PCR_MASK_POWER9 | PCR_COMPAT_3_00
+#define PPC_PCR_MASK_POWER11 PPC_PCR_MASK_POWER10
 
 #define PPC_PCR_SUPPORTED_POWER9    \
     PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05
 #define PPC_PCR_SUPPORTED_POWER10   \
     PPC_PCR_SUPPORTED_POWER9 | PCR_COMPAT_3_10
+#define PPC_PCR_SUPPORTED_POWER11 PPC_PCR_SUPPORTED_POWER10
 
 #define PPC_LPCR_MASK_POWER9                                                \
     LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |                           \
@@ -70,6 +76,7 @@
 /* DD2 adds an extra HAIL bit */
 #define PPC_LPCR_MASK_POWER10   \
     PPC_LPCR_MASK_POWER9 | LPCR_HAIL
+#define PPC_LPCR_MASK_POWER11 PPC_LPCR_MASK_POWER10
 
 #define POWERPC_FLAGS_POWER_COMMON                                      \
     POWERPC_FLAG_VRE | POWERPC_FLAG_SE | POWERPC_FLAG_BE |              \
@@ -80,5 +87,6 @@
     POWERPC_FLAGS_POWER_COMMON | POWERPC_FLAG_TM
 #define POWERPC_FLAGS_POWER10 \
     POWERPC_FLAGS_POWER_COMMON | POWERPC_FLAG_BHRB
+#define POWERPC_FLAGS_POWER11 POWERPC_FLAGS_POWER10
 
 #endif /* TARGET_PPC_CPU_INIT_H */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index f33fc36db2aa..2029144622d8 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1661,6 +1661,7 @@ static void powerpc_excp(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_POWER8:
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
+    case POWERPC_EXCP_POWER11:
         powerpc_excp_books(cpu, excp);
         break;
     default:
@@ -2018,6 +2019,7 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
         return p8_next_unmasked_interrupt(env);
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
+    case POWERPC_EXCP_POWER11:
         return p9_next_unmasked_interrupt(env);
     default:
         break;
@@ -2372,6 +2374,7 @@ static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
         return p8_deliver_interrupt(env, interrupt);
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
+    case POWERPC_EXCP_POWER11:
         return p9_deliver_interrupt(env, interrupt);
     default:
         break;
@@ -3163,6 +3166,7 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     case POWERPC_EXCP_POWER8:
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
+    case POWERPC_EXCP_POWER11:
         /*
          * Machine check codes can be found in processor User Manual or
          * Linux or skiboot source.
-- 
2.45.2


