Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318DCC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 10:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s90L8-0000lK-G6; Mon, 20 May 2024 06:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s90L7-0000ks-5d; Mon, 20 May 2024 06:33:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s90L5-0008WJ-6C; Mon, 20 May 2024 06:33:56 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44K9RdDi009930; Mon, 20 May 2024 10:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KTOq10yvZhFXALEkREdFPnVXyjeE568UYyiVEIZJazo=;
 b=PQrBSrpyTxO6bNaSc93a+px+TAuF1XXUKs2niMCPPWDrb959A7cPoecjWwM59GB6yRR9
 V4DVEcpNyccrI0bkEB2ckNzKvIsI1ILguMA5mjdTH+eiotGGq9R2j8mhOhfv88T+iU+Q
 zAwBCY5ue2nGFkl1dqDOCEKwVRUpzpJfJgdUz7p7M45QzG//mq9w0eMRXX9Td00hTf0O
 KuEoaxrixJwDA6BQOEBtzEbxB5qb2E2/yYtaKNl3Lkz5EVBuVYOZDZWzq5OxZIfKT4mI
 zqPaV123R2APwUqoJNjWaQhUn9e21r0Rhse9io63jkDgr050r13PpdEBN0a1OxBL9m1W aA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y83wbr4yn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 10:33:53 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44KAXqAP017132;
 Mon, 20 May 2024 10:33:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y83wbr4yg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 10:33:52 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44K8mchd000878; Mon, 20 May 2024 10:33:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y771yydc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 10:33:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44KAXlsN44630464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 May 2024 10:33:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99C3420069;
 Mon, 20 May 2024 10:33:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8172C20063;
 Mon, 20 May 2024 10:33:44 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com (unknown
 [9.195.33.101]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 May 2024 10:33:44 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH 6/6] target/ppc: redue code duplication across Power9/10 init
 code
Date: Mon, 20 May 2024 16:03:29 +0530
Message-Id: <20240520103329.381158-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240520103329.381158-1-harshpb@linux.ibm.com>
References: <20240520103329.381158-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8CBHzPOYohJUPfGSrtOwaQO2hVmgx5-L
X-Proofpoint-ORIG-GUID: WeXOy5SCAGEX3Lw7m0b4uU9Ybt7mF3zh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_05,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Power9/10 initialization code consists of a lot of logical OR of
various flag bits as supported by respective Power platform during its
initialization, most of which is duplicated and only selected bits are
added or removed as needed with each new platform support being added.
Remove the duplicate code and share using common macros.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/cpu_init.h |  79 +++++++++++++++++++++++++++
 target/ppc/cpu_init.c | 123 ++++++------------------------------------
 2 files changed, 94 insertions(+), 108 deletions(-)
 create mode 100644 target/ppc/cpu_init.h

diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
new file mode 100644
index 0000000000..29358bfdf6
--- /dev/null
+++ b/target/ppc/cpu_init.h
@@ -0,0 +1,79 @@
+#ifndef TARGET_PPC_CPU_INIT_H
+#define TARGET_PPC_CPU_INIT_H
+
+#define POWERPC_FAMILY_POWER9_INSNS_FLAGS                           \
+    PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |             \
+    PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |                   \
+    PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE | PPC_FLOAT_FRSQRTES |      \
+    PPC_FLOAT_STFIWX | PPC_FLOAT_EXT |PPC_CACHE | PPC_CACHE_ICBI |  \
+    PPC_CACHE_DCBZ | PPC_MEM_SYNC | PPC_MEM_EIEIO | PPC_MEM_TLBIE | \
+    PPC_MEM_TLBSYNC | PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |  \
+    PPC_SEGMENT_64B | PPC_SLBI | PPC_POPCNTB | PPC_POPCNTWD |       \
+    PPC_CILDST
+#define POWERPC_FAMILY_POWER10_INSNS_FLAGS \
+        POWERPC_FAMILY_POWER9_INSNS_FLAGS
+
+#define POWERPC_FAMILY_POWER9_INSNS_FLAGS2_COMMON                   \
+    PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |                 \
+    PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
+    PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |   \
+    PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 | PPC2_ISA205 |              \
+    PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |    \
+    PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206
+
+#define POWERPC_FAMILY_POWER9_INSNS_FLAGS2                          \
+    POWERPC_FAMILY_POWER9_INSNS_FLAGS2_COMMON | PPC2_TM
+#define POWERPC_FAMILY_POWER10_INSNS_FLAGS2                         \
+    POWERPC_FAMILY_POWER9_INSNS_FLAGS2_COMMON | PPC2_ISA310
+
+#define POWERPC_POWER9_COMMON_PCC_MSR_MASK \
+    (1ull << MSR_SF) |                     \
+    (1ull << MSR_HV) |                     \
+    (1ull << MSR_VR) |                     \
+    (1ull << MSR_VSX) |                    \
+    (1ull << MSR_EE) |                     \
+    (1ull << MSR_PR) |                     \
+    (1ull << MSR_FP) |                     \
+    (1ull << MSR_ME) |                     \
+    (1ull << MSR_FE0) |                    \
+    (1ull << MSR_SE) |                     \
+    (1ull << MSR_DE) |                     \
+    (1ull << MSR_FE1) |                    \
+    (1ull << MSR_IR) |                     \
+    (1ull << MSR_DR) |                     \
+    (1ull << MSR_PMM) |                    \
+    (1ull << MSR_RI) |                     \
+    (1ull << MSR_LE)
+
+#define POWERPC_POWER9_PCC_MSR_MASK \
+    POWERPC_POWER9_COMMON_PCC_MSR_MASK | (1ull << MSR_TM)
+#define POWERPC_POWER10_PCC_MSR_MASK \
+    POWERPC_POWER9_COMMON_PCC_MSR_MASK
+#define POWERPC_POWER9_PCC_PCR_MASK \
+    PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07
+#define POWERPC_POWER10_PCC_PCR_MASK \
+    POWERPC_POWER9_PCC_PCR_MASK | PCR_COMPAT_3_00
+#define POWERPC_POWER9_PCC_PCR_SUPPORTED \
+    PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05
+#define POWERPC_POWER10_PCC_PCR_SUPPORTED \
+    POWERPC_POWER9_PCC_PCR_SUPPORTED | PCR_COMPAT_3_10
+#define POWERPC_POWER9_PCC_LPCR_MASK                                        \
+    LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |                           \
+    (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |                  \
+    LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |                 \
+    (LPCR_PECE_L_MASK & (LPCR_PDEE|LPCR_HDEE|LPCR_EEE|LPCR_DEE|LPCR_OEE)) | \
+    LPCR_MER | LPCR_GTSE | LPCR_TC | LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE |  \
+    LPCR_HDICE
+/* DD2 adds an extra HAIL bit */
+#define POWERPC_POWER10_PCC_LPCR_MASK \
+    POWERPC_POWER9_PCC_LPCR_MASK | LPCR_HAIL
+#define POWERPC_POWER9_PCC_FLAGS_COMMON                                 \
+    POWERPC_FLAG_VRE | POWERPC_FLAG_SE | POWERPC_FLAG_BE |              \
+    POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |       \
+    POWERPC_FLAG_VSX | POWERPC_FLAG_SCV
+
+#define POWERPC_POWER9_PCC_FLAGS  \
+    POWERPC_POWER9_PCC_FLAGS_COMMON | POWERPC_FLAG_TM
+#define POWERPC_POWER10_PCC_FLAGS POWERPC_POWER9_PCC_FLAGS_COMMON
+
+#endif /* TARGET_PPC_CPU_INIT_H */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 636e12ba7a..48773ec831 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -51,6 +51,7 @@
 #include "kvm_ppc.h"
 #endif
 
+#include "cpu_init.h"
 /* #define PPC_DEBUG_SPR */
 /* #define USE_APPLE_GDB */
 
@@ -6412,57 +6413,14 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     dc->fw_name = "PowerPC,POWER9";
     dc->desc = "POWER9";
     pcc->pvr_match = ppc_pvr_match_power9;
-    pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07;
-    pcc->pcr_supported = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
-                         PCR_COMPAT_2_05;
+    pcc->pcr_mask = POWERPC_POWER9_PCC_PCR_MASK;
+    pcc->pcr_supported = POWERPC_POWER9_PCC_PCR_SUPPORTED;
     pcc->init_proc = init_proc_POWER9;
     pcc->check_pow = check_pow_nocheck;
-    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
-                       PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
-                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
-                       PPC_FLOAT_FRSQRTES |
-                       PPC_FLOAT_STFIWX |
-                       PPC_FLOAT_EXT |
-                       PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
-                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
-                       PPC_MEM_TLBIE | PPC_MEM_TLBSYNC |
-                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
-                       PPC_SEGMENT_64B | PPC_SLBI |
-                       PPC_POPCNTB | PPC_POPCNTWD |
-                       PPC_CILDST;
-    pcc->insns_flags2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |
-                        PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
-                        PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
-                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
-                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
-                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
-                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_MEM_LWSYNC |
-                        PPC2_BCDA_ISA206;
-    pcc->msr_mask = (1ull << MSR_SF) |
-                    (1ull << MSR_HV) |
-                    (1ull << MSR_TM) |
-                    (1ull << MSR_VR) |
-                    (1ull << MSR_VSX) |
-                    (1ull << MSR_EE) |
-                    (1ull << MSR_PR) |
-                    (1ull << MSR_FP) |
-                    (1ull << MSR_ME) |
-                    (1ull << MSR_FE0) |
-                    (1ull << MSR_SE) |
-                    (1ull << MSR_DE) |
-                    (1ull << MSR_FE1) |
-                    (1ull << MSR_IR) |
-                    (1ull << MSR_DR) |
-                    (1ull << MSR_PMM) |
-                    (1ull << MSR_RI) |
-                    (1ull << MSR_LE);
-    pcc->lpcr_mask = LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
-        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
-        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
-        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
-                             LPCR_DEE | LPCR_OEE))
-        | LPCR_MER | LPCR_GTSE | LPCR_TC |
-        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
+    pcc->insns_flags = POWERPC_FAMILY_POWER9_INSNS_FLAGS;
+    pcc->insns_flags2 = POWERPC_FAMILY_POWER9_INSNS_FLAGS2;
+    pcc->msr_mask = POWERPC_POWER9_PCC_MSR_MASK;
+    pcc->lpcr_mask = POWERPC_POWER9_PCC_LPCR_MASK;
     pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
     pcc->mmu_model = POWERPC_MMU_3_00;
 #if !defined(CONFIG_USER_ONLY)
@@ -6475,10 +6433,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     pcc->excp_model = POWERPC_EXCP_POWER9;
     pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
     pcc->bfd_mach = bfd_mach_ppc64;
-    pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
-                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
-                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
+    pcc->flags = POWERPC_POWER9_PCC_FLAGS;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
@@ -6557,59 +6512,14 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     dc->fw_name = "PowerPC,POWER10";
     dc->desc = "POWER10";
     pcc->pvr_match = ppc_pvr_match_power10;
-    pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07 |
-                    PCR_COMPAT_3_00;
-    pcc->pcr_supported = PCR_COMPAT_3_10 | PCR_COMPAT_3_00 | PCR_COMPAT_2_07 |
-                         PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
+    pcc->pcr_mask = POWERPC_POWER10_PCC_PCR_MASK;
+    pcc->pcr_supported = POWERPC_POWER10_PCC_PCR_SUPPORTED;
     pcc->init_proc = init_proc_POWER10;
     pcc->check_pow = check_pow_nocheck;
-    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
-                       PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
-                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
-                       PPC_FLOAT_FRSQRTES |
-                       PPC_FLOAT_STFIWX |
-                       PPC_FLOAT_EXT |
-                       PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
-                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
-                       PPC_MEM_TLBIE | PPC_MEM_TLBSYNC |
-                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
-                       PPC_SEGMENT_64B | PPC_SLBI |
-                       PPC_POPCNTB | PPC_POPCNTWD |
-                       PPC_CILDST;
-    pcc->insns_flags2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |
-                        PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
-                        PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
-                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
-                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
-                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
-                        PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
-                        PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
-    pcc->msr_mask = (1ull << MSR_SF) |
-                    (1ull << MSR_HV) |
-                    (1ull << MSR_VR) |
-                    (1ull << MSR_VSX) |
-                    (1ull << MSR_EE) |
-                    (1ull << MSR_PR) |
-                    (1ull << MSR_FP) |
-                    (1ull << MSR_ME) |
-                    (1ull << MSR_FE0) |
-                    (1ull << MSR_SE) |
-                    (1ull << MSR_DE) |
-                    (1ull << MSR_FE1) |
-                    (1ull << MSR_IR) |
-                    (1ull << MSR_DR) |
-                    (1ull << MSR_PMM) |
-                    (1ull << MSR_RI) |
-                    (1ull << MSR_LE);
-    pcc->lpcr_mask = LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
-        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
-        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
-        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
-                             LPCR_DEE | LPCR_OEE))
-        | LPCR_MER | LPCR_GTSE | LPCR_TC |
-        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
-    /* DD2 adds an extra HAIL bit */
-    pcc->lpcr_mask |= LPCR_HAIL;
+    pcc->insns_flags = POWERPC_FAMILY_POWER10_INSNS_FLAGS;
+    pcc->insns_flags2 = POWERPC_FAMILY_POWER10_INSNS_FLAGS2;
+    pcc->msr_mask = POWERPC_POWER10_PCC_MSR_MASK;
+    pcc->lpcr_mask = POWERPC_POWER10_PCC_LPCR_MASK;
 
     pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
     pcc->mmu_model = POWERPC_MMU_3_00;
@@ -6622,10 +6532,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->excp_model = POWERPC_EXCP_POWER10;
     pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
     pcc->bfd_mach = bfd_mach_ppc64;
-    pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
-                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
-                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_SCV;
+    pcc->flags = POWERPC_POWER10_PCC_FLAGS;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
-- 
2.39.3


