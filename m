Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF80EC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5wZ-0006RO-Pe; Wed, 26 Aug 2026 01:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5wW-0006D9-Tq; Wed, 26 Aug 2026 01:12:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5wU-0005Zd-MA; Wed, 26 Aug 2026 01:12:56 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3VjDN1702333; Wed, 26 Aug 2026 05:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FmC2IchsTD9kmurv2
 U9M+i+MXlpgChAOhl2lnSugBiE=; b=C3W5kAXXNTI84Y7LRHiC5VqF2k3DZQG3I
 CgLUo86Ekkp8AGkoHyws1YTqWQRiIESpVMdGLDgTk4MmjbH6XaDoOgp1+M9GZYp7
 XWXW4WP8GP5QPfizUIFa8wiJcrilEUjSgpvc4Tc4hUGS93VAxcRc44cr5qVCkC95
 fD798fw7uXxUHpYZjVq3k5Gq0e31s5q6gSEbTOnD3Vm710DWCe8lYiRQ5gGVBP0n
 jM5rQ3lIirnwb1hCPp7r2hX/rS1atoE65Ws/Axh0BlQgVpXwxfZ8W25ariWxoXp0
 GdHx6CHB7GEGvHTWMpg02EtpaKAADl43CRZ69Lo052SAhlnLGCfRg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726emk7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:12:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5BI7T031857;
 Wed, 26 Aug 2026 05:12:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw8b37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:12:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5CmI69110002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:12:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 040752004B;
 Wed, 26 Aug 2026 05:12:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1377A20040;
 Wed, 26 Aug 2026 05:12:43 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:12:42 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 31/37] target/ppc: Use PPC2_ISA207 instead of
 PPC2_BCTAR_ISA207
Date: Wed, 26 Aug 2026 10:38:57 +0530
Message-ID: <20260826050923.74756-32-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8e75d5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=Al47QwtNd7R5P9kdeLgA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX5Yoq3J1kLk2f
 PKuHvrLeqIYKgprfORKypu8xZcv/h1CX53R5RxSpGtwZTwE0nnm7OlJiv85Bx8MUMxDlK5xY6//
 y/AypP8+Uu9O6DnWuNGuq4s03R0e1mM=
X-Proofpoint-GUID: CkuFkuOJhK3geW-QQBUwFbBeuf2Rl5Su
X-Proofpoint-ORIG-GUID: rH1ASTwQyICzW6oc6zqfEZU71g5Jk00Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfXzVAACHY/JRak
 yl1UXgMSWhccb7+QO5T/E0Hy21STyJtV9gsLUS9lqHBiMBZsdwO4nwlYb/jgMkZoYHKE0gQIHQx
 N+2d8SWt5KDS9Oga7+I9evwwYrSpO4VH9LE5GZtrewZMVmx7A8lQ5bd9aNaeYpp3lSr++LXOVeE
 Fl9BDp1hSasEMh7+LpTitSPe2PodHLs7t6nAuVdboGVssktJYDtQ0uzFQMaFRyy6uhLgiCnFzGy
 N6AMS/WdE3gDFiP5rXI9wvjzaZk26lrij0E8pVMxSD8ejPjN6QOADhv0+iFDOED2pibTpd9eW44
 R5rE2O4GneXAujkL2EN+3AOc1XNDnY7cz1tLL/QLgZW/iFCu4RxryBXNatrao/Rq/SWd1Gof0MV
 3yShfjtrJw7/9kBMIAIPsAthAb5kX+Y1DySDU0h3d9iv0SJkag1RRcdGnh8Z8IHfPBHB6DY7P/2
 OXc3cuDCarIIHv5HXSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
replaced with PPC2_ISA207, hence rendering it useless and apt for
removal. This patch does the same.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 linux-user/ppc/elfload.c               | 7 +++----
 target/ppc/cpu.h                       | 4 +---
 target/ppc/cpu_init.c                  | 2 +-
 target/ppc/cpu_init.h                  | 2 +-
 target/ppc/translate/branch-impl.c.inc | 2 +-
 5 files changed, 7 insertions(+), 10 deletions(-)

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
index b913edd243..c250f805a7 100644
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
diff --git a/target/ppc/translate/branch-impl.c.inc b/target/ppc/translate/branch-impl.c.inc
index c2889c1d12..77eac0a239 100644
--- a/target/ppc/translate/branch-impl.c.inc
+++ b/target/ppc/translate/branch-impl.c.inc
@@ -210,5 +210,5 @@ static bool bclr_helper(DisasContext *ctx, arg_bclr *a, int type)
 
 TRANS(BCLR, bclr_helper, BCOND_LR)
 TRANS(BCCTR, bclr_helper, BCOND_CTR)
-TRANS_FLAGS2(BCTAR_ISA207, BCTAR, bclr_helper, BCOND_TAR)
+TRANS_FLAGS2(ISA207, BCTAR, bclr_helper, BCOND_TAR)
 
-- 
2.55.0


