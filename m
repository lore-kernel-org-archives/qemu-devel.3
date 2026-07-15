Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39B0C4450A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzAi-0006cU-Ge; Wed, 15 Jul 2026 08:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wjzAg-0006cG-S6; Wed, 15 Jul 2026 08:57:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wjzAf-0001CL-5P; Wed, 15 Jul 2026 08:57:06 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FBfd62074718; Wed, 15 Jul 2026 12:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MN95CTnd0AAGhUOfI
 9SP8BWXAWZLRVcOk3iS3PjjPuY=; b=hWpk9zgFoldfbzYdJwSZuOnzhxBCih06o
 ho7SEWT1mFMMWgyNLvQc6LJl8dhAN8Ne11Cwp4yJPL36/r+DLYU/DSgX/9KFlqGH
 UbXSaItduaWHhB7WvkZyAGm+WeWrqZqozzDcG/c86/xbcPDZv56PtAWAsPHF/47j
 lUI4mHBW8uz+edZU99OpH+9Nuy9p8rZQsZT3FPy5rAyyHim41AYudnkWMZ2kg0tn
 jBWsbPp3pGcUJEdeNKC7R8hjHHZwoZ+/HZ8mYNrKxBxrxGHd6X9aA3rxR6o5GTG6
 RGV/OMeuSo//OjC/vRxLR4b3PTw9xg7oSrNz5CHYMOUKrNnaF9bFA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtbnp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 12:57:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FCng3R024497;
 Wed, 15 Jul 2026 12:57:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw86v6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 12:57:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66FCuuWD20840782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2026 12:56:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEC922004D;
 Wed, 15 Jul 2026 12:56:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AED8F2004B;
 Wed, 15 Jul 2026 12:56:53 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.30.15]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2026 12:56:53 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, tommusta@gmail.com
Cc: richard.henderson@linaro.org, milesg@linux.ibm.com, shivangu@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 2/7] target/ppc: Use PPC2_ISA207 instead of PPC2_BCTAR_ISA207
Date: Wed, 15 Jul 2026 18:26:29 +0530
Message-ID: <20260715125634.2107320-3-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715125634.2107320-1-rathc@linux.ibm.com>
References: <20260715125634.2107320-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 9ZwTjaIjHZgk2xz6Myw0J7WgaJw4NWyr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEyNiBTYWx0ZWRfX+BTRPjmHCU6j
 Q6fitJY0FBBZ9PnsJ8jA6TB82PkpmsMXC0twPJikQtqw5VRzspJ31xulzvHaMlMnjCchQnwnGlp
 YWL+Kv1t1gVwPM1YQcWVt35+iMoh5kk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEyNiBTYWx0ZWRfX5pDuvqcaHZ96
 Awg1l7mFzgNcfza4IriGW/oFGIn42RDhvMrYyeUSpz0l/zcY9+q3ZiIypBJuPJm3v4bPgnKMtpo
 qXl6hLjWisvDQwhbEGAdsc2KARfFilecV01ppT86nBeSHPlEzKGleJQcjkZlByU6LfPwBexN5kF
 qydKLWVAqW/qJeRPxdjcTlsd0m/YsEkuwAqWyNq8iLSOAVPfb99pT4JYTwr9qr4l6cLJ/zqy/LS
 uiiiFjkLfhBInLaIWCJk0SciONP/HCIKr2AkF+V5ejdFbsbfqyahvfi4uUt6gAcGm2QSxyHNHqR
 Zc9+KhiKTx/zNbz3KEm3FLZFg+VJWQ+ZqIW4IddQgojKSnkjpQXdevwJC/iHfQ+ej64bNUwtjLO
 WjSyedYTv1VHsp72eC7p2Kme0yZwYYmXtihAAUHA/OxLpC/Ifz7cuB6flFz6ZbIIdrxUWTGEUPf
 augNp59xN43QFXxSRXA==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a57839e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=hiDdZy2nWI0Nl09HBLIA:9
X-Proofpoint-GUID: qTt6TpUVO3sDypdWOyVhmk-0puDVNrwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

PPC2_BCTAR_ISA207 is only ever set in the CPUPPCState's insns_flags2
alongside PPC2_ISA207. Checks made by PPC2_BCTAR_ISA207 could be
replaced with PPC2_ISA207, hence rendering is useless and apt for
removal. This patch does the same.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 linux-user/ppc/elfload.c | 7 +++----
 target/ppc/cpu.h         | 4 +---
 target/ppc/cpu_init.c    | 2 +-
 target/ppc/cpu_init.h    | 2 +-
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
index 0d54da9803..5c6065e08a 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -116,10 +116,9 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     do { if (cpu->env.insns_flags2 & flag) { features |= feature; } } while (0)
 
     GET_FEATURE(PPC_ISEL, QEMU_PPC_FEATURE2_HAS_ISEL);
-    GET_FEATURE2(PPC2_BCTAR_ISA207, QEMU_PPC_FEATURE2_HAS_TAR);
-    GET_FEATURE2((PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
-                  PPC2_ISA207S), QEMU_PPC_FEATURE2_ARCH_2_07 |
-                  QEMU_PPC_FEATURE2_VEC_CRYPTO);
+    GET_FEATURE2((PPC2_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
+                  PPC2_ISA207S), (QEMU_PPC_FEATURE2_ARCH_2_07 |
+                  QEMU_PPC_FEATURE2_VEC_CRYPTO | QEMU_PPC_FEATURE2_HAS_TAR));
     GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00 |
                  QEMU_PPC_FEATURE2_DARN | QEMU_PPC_FEATURE2_HAS_IEEE128);
     GET_FEATURE2(PPC2_ISA310, QEMU_PPC_FEATURE2_ARCH_3_1 |
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 91ef34cb21..df1e943d8d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2577,8 +2577,6 @@ enum {
     PPC2_FP_CVT_ISA206 = 0x0000000000000400ULL,
     /* ISA 2.06B floating point test instructions                            */
     PPC2_FP_TST_ISA206 = 0x0000000000000800ULL,
-    /* ISA 2.07 bctar instruction                                            */
-    PPC2_BCTAR_ISA207  = 0x0000000000001000ULL,
     /* ISA 2.07 load/store quadword                                          */
     PPC2_LSQ_ISA207    = 0x0000000000002000ULL,
     /* ISA 2.07 Altivec                                                      */
@@ -2610,7 +2608,7 @@ enum {
                         PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
                         PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
                         PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | \
-                        PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | \
+                        PPC2_LSQ_ISA207 | \
                         PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
                         PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index de33ac3a88..be8b3c447d 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6349,7 +6349,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, const void *data)
     pcc->insns_flags2 = PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |
                         PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
                         PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
-                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
+                        PPC2_FP_TST_ISA206 |
                         PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
                         PPC2_TM | PPC2_PM_ISA206 | PPC2_MEM_LWSYNC |
diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
index 1c41c0d349..7dd587908e 100644
--- a/target/ppc/cpu_init.h
+++ b/target/ppc/cpu_init.h
@@ -17,7 +17,7 @@
 #define PPC_INSNS_FLAGS2_POWER_COMMON                                \
     (PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |                 \
      PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
-     PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |   \
+     PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 |                       \
      PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 | PPC2_ISA205 |              \
      PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |    \
      PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206)
-- 
2.53.0


