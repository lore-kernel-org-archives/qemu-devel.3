Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAF5C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 19:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYsTV-0002BX-Vn; Tue, 30 Jul 2024 15:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sYsTO-0001UR-OD; Tue, 30 Jul 2024 15:25:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sYsTJ-0002YX-6g; Tue, 30 Jul 2024 15:25:25 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UIxbDY009395;
 Tue, 30 Jul 2024 19:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=F4Nnrhkvkx7ek
 lCx8f99WiWAwcCacm3ieAUqA6ctQ+E=; b=WE0k9tp2WR/fPQczlmc/XwnYrRZPn
 FpwHLQjt34cpS6vEVBsLsJNEcNNubW6JJjR85Kb4tK7CLKUU4Xdltx1ebiZuBX45
 VpFHypLEBzT90epx9qWr4Ri2pkTAffGvFYYlmpDnOaxpOl93dRl5RBzV4Yv6glH7
 Tw53fdnTUcbYGRXp99NEifSQa2pDGQ1nJAKDx7f9CHg1GQ/ddVMqIYLZx3H9CCqZ
 qYB/ojupevW6LeB4tgtiBM7xtxfROc97iiCZl8WyIHOb98IJ3LIJlszRNcR1v8vM
 Yn2v9BOVjZRT64zd8suKQcedEnxWkLOkdFn60t2uVjhDAx8ASAcYd1D4w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q5xf01n4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 19:25:09 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46UJP9F6019327;
 Tue, 30 Jul 2024 19:25:09 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q5xf01mm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 19:25:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46UIcbQo003793; Tue, 30 Jul 2024 19:23:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndemedv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 19:23:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46UJNWcv45613500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jul 2024 19:23:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12FA720043;
 Tue, 30 Jul 2024 19:23:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E15A820040;
 Tue, 30 Jul 2024 19:23:29 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.195.42.9]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jul 2024 19:23:29 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v6 1/5] target/ppc: Reduce code duplication across Power9/10
 init code
Date: Wed, 31 Jul 2024 00:53:21 +0530
Message-ID: <20240730192325.669771-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730192325.669771-1-adityag@linux.ibm.com>
References: <20240730192325.669771-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S2R_JHceWPnf5XKder88IFLIdSj7Bqnz
X-Proofpoint-GUID: UvaSzo5Xf_6N0Uvh987OxOHcEseLdQk6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_15,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Power9/10 initialization code consists of a lot of logical OR of
various flag bits as supported by respective Power platform during its
initialization, most of which is duplicated and only selected bits are
added or removed as needed with each new platform support being added.
Remove the duplicate code and share using common macros.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
[PMM: renamed many POWERPC_* flags to PPC_* flags, checkpatch fixes]
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 target/ppc/cpu_init.c | 124 +++++-------------------------------------
 target/ppc/cpu_init.h |  84 ++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 109 deletions(-)
 create mode 100644 target/ppc/cpu_init.h

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 23881d09e9f3..4c7368cfaeb5 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -52,6 +52,7 @@
 #include "kvm_ppc.h"
 #endif
 
+#include "cpu_init.h"
 /* #define PPC_DEBUG_SPR */
 /* #define USE_APPLE_GDB */
 
@@ -6510,58 +6511,15 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     dc->fw_name = "PowerPC,POWER9";
     dc->desc = "POWER9";
     pcc->pvr_match = ppc_pvr_match_power9;
-    pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07;
-    pcc->pcr_supported = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
-                         PCR_COMPAT_2_05;
+    pcc->pcr_mask = PPC_PCR_MASK_POWER9;
+    pcc->pcr_supported = PPC_PCR_SUPPORTED_POWER9;
     pcc->init_proc = init_proc_POWER9;
     pcc->check_pow = check_pow_nocheck;
     pcc->check_attn = check_attn_hid0_power9;
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
+    pcc->insns_flags = PPC_INSNS_FLAGS_POWER9;
+    pcc->insns_flags2 = PPC_INSNS_FLAGS2_POWER9;
+    pcc->msr_mask = PPC_MSR_MASK_POWER9;
+    pcc->lpcr_mask = PPC_LPCR_MASK_POWER9;
     pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
     pcc->mmu_model = POWERPC_MMU_3_00;
 #if !defined(CONFIG_USER_ONLY)
@@ -6574,10 +6532,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     pcc->excp_model = POWERPC_EXCP_POWER9;
     pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
     pcc->bfd_mach = bfd_mach_ppc64;
-    pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
-                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
-                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
+    pcc->flags = POWERPC_FLAGS_POWER9;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
@@ -6690,60 +6645,15 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     dc->fw_name = "PowerPC,POWER10";
     dc->desc = "POWER10";
     pcc->pvr_match = ppc_pvr_match_power10;
-    pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07 |
-                    PCR_COMPAT_3_00;
-    pcc->pcr_supported = PCR_COMPAT_3_10 | PCR_COMPAT_3_00 | PCR_COMPAT_2_07 |
-                         PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
+    pcc->pcr_mask = PPC_PCR_MASK_POWER10;
+    pcc->pcr_supported = PPC_PCR_SUPPORTED_POWER10;
     pcc->init_proc = init_proc_POWER10;
     pcc->check_pow = check_pow_nocheck;
     pcc->check_attn = check_attn_hid0_power9;
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
+    pcc->insns_flags = PPC_INSNS_FLAGS_POWER10;
+    pcc->insns_flags2 = PPC_INSNS_FLAGS2_POWER10;
+    pcc->msr_mask = PPC_MSR_MASK_POWER10;
+    pcc->lpcr_mask = PPC_LPCR_MASK_POWER10;
 
     pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
     pcc->mmu_model = POWERPC_MMU_3_00;
@@ -6756,11 +6666,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->excp_model = POWERPC_EXCP_POWER10;
     pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
     pcc->bfd_mach = bfd_mach_ppc64;
-    pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
-                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
-                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_SCV |
-                 POWERPC_FLAG_BHRB;
+    pcc->flags = POWERPC_FLAGS_POWER10;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
new file mode 100644
index 000000000000..7479b59da73b
--- /dev/null
+++ b/target/ppc/cpu_init.h
@@ -0,0 +1,84 @@
+#ifndef TARGET_PPC_CPU_INIT_H
+#define TARGET_PPC_CPU_INIT_H
+
+#define PPC_INSNS_FLAGS_POWER9                                      \
+    PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |             \
+    PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |                   \
+    PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE | PPC_FLOAT_FRSQRTES |      \
+    PPC_FLOAT_STFIWX | PPC_FLOAT_EXT | PPC_CACHE | PPC_CACHE_ICBI | \
+    PPC_CACHE_DCBZ | PPC_MEM_SYNC | PPC_MEM_EIEIO | PPC_MEM_TLBIE | \
+    PPC_MEM_TLBSYNC | PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |  \
+    PPC_SEGMENT_64B | PPC_SLBI | PPC_POPCNTB | PPC_POPCNTWD |       \
+    PPC_CILDST
+
+#define PPC_INSNS_FLAGS_POWER10 PPC_INSNS_FLAGS_POWER9
+
+#define PPC_INSNS_FLAGS2_POWER_COMMON                               \
+    PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |                 \
+    PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
+    PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |   \
+    PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 | PPC2_ISA205 |              \
+    PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |    \
+    PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206
+
+#define PPC_INSNS_FLAGS2_POWER9                                     \
+    PPC_INSNS_FLAGS2_POWER_COMMON | PPC2_TM
+#define PPC_INSNS_FLAGS2_POWER10                                    \
+    PPC_INSNS_FLAGS2_POWER_COMMON | PPC2_ISA310
+
+#define PPC_MSR_MASK_POWER_COMMON          \
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
+#define PPC_MSR_MASK_POWER9         \
+    PPC_MSR_MASK_POWER_COMMON | (1ull << MSR_TM)
+#define PPC_MSR_MASK_POWER10        \
+    PPC_MSR_MASK_POWER_COMMON
+
+#define PPC_PCR_MASK_POWER9         \
+    PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07
+#define PPC_PCR_MASK_POWER10        \
+    PPC_PCR_MASK_POWER9 | PCR_COMPAT_3_00
+
+#define PPC_PCR_SUPPORTED_POWER9    \
+    PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05
+#define PPC_PCR_SUPPORTED_POWER10   \
+    PPC_PCR_SUPPORTED_POWER9 | PCR_COMPAT_3_10
+
+#define PPC_LPCR_MASK_POWER9                                                \
+    LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |                           \
+    (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |                  \
+    LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |                 \
+    (LPCR_PECE_L_MASK & (LPCR_PDEE|LPCR_HDEE|LPCR_EEE|LPCR_DEE|LPCR_OEE)) | \
+    LPCR_MER | LPCR_GTSE | LPCR_TC | LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE |  \
+    LPCR_HDICE
+/* DD2 adds an extra HAIL bit */
+#define PPC_LPCR_MASK_POWER10   \
+    PPC_LPCR_MASK_POWER9 | LPCR_HAIL
+
+#define POWERPC_FLAGS_POWER_COMMON                                      \
+    POWERPC_FLAG_VRE | POWERPC_FLAG_SE | POWERPC_FLAG_BE |              \
+    POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |       \
+    POWERPC_FLAG_VSX | POWERPC_FLAG_SCV
+
+#define POWERPC_FLAGS_POWER9  \
+    POWERPC_FLAGS_POWER_COMMON | POWERPC_FLAG_TM
+#define POWERPC_FLAGS_POWER10 \
+    POWERPC_FLAGS_POWER_COMMON | POWERPC_FLAG_BHRB
+
+#endif /* TARGET_PPC_CPU_INIT_H */
-- 
2.45.2


