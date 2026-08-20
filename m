Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391CBC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3kj-0003Kn-Kd; Thu, 20 Aug 2026 10:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3kL-0002vq-Eb; Thu, 20 Aug 2026 10:28:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3kJ-0002E5-RM; Thu, 20 Aug 2026 10:27:57 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K9ClPQ503860; Thu, 20 Aug 2026 14:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MvwwcJd1y6wb06YRo
 P3LGSibNWfH4TR/9PA7aFD/ATU=; b=jYFr1a9Y75LZKpQ1DXC+iRTqTZw5Fkn37
 4P+HiDNkOuBoh3TAWVGoFTOdKtGl2Lhur762nl5D+UEd9LQnO4Nqwhd2BfOYpDTj
 dV8py33FosKDG4FGuC4H5nC5VTnKxhMuFtraFPSnioPkHR/5sx6p+/XqR/CmlUhm
 MjTQMpB5TH+sp+YIM1ig0j0OX4/KP0hHpklWyP7kNJPDMTDpdrANFsXoS578l1OJ
 4erLozwywg+IifyWTq5Zl6NylKw4apKMv1mCFDdRz+gbwoGRUmqEo5BP9VlYdsM0
 JMb0hNgtW/pdbNX70W5FCLch/S0Fep6KQjK/JXMa2oShLVK02onXA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4aqtf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:27:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEQZuc020988;
 Thu, 20 Aug 2026 14:27:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngptjc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:27:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KERn8251511564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:27:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97F5A20049;
 Thu, 20 Aug 2026 14:27:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B280120040;
 Thu, 20 Aug 2026 14:27:45 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:27:45 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 3/7] target/ppc: Use PPC2_ISA207 instead of PPC2_LSQ_ISA207
Date: Thu, 20 Aug 2026 19:57:00 +0530
Message-ID: <20260820142717.337686-4-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820142717.337686-1-rathc@linux.ibm.com>
References: <20260820142717.337686-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a870eea cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=nQ85-MmU5D-d4o_ZYwcA:9
X-Proofpoint-ORIG-GUID: KsMYSq401Jvl_AkEXmKbb1u6gMFZDmdS
X-Proofpoint-GUID: 1PPm9z5KLr-z_q8BYwqQviBuKOimd9T2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX/fLKbLu93t/I
 O6xRxEkfIP3RAtUfLqEoGL1SqNEim7gmI0NU7N5emOee+bR3UqIkvFOqgOMPJUbt82myfLJwBlW
 QUoG7BTdZrkWeN+nO28G95dlCer/wqY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfXyWn3vAG1eKQj
 PN97qDGtKb+ozDJc+CtqEiReYcWS+Ikw0Gq2fQ8a5Wpt0CbGh4FbTrEjUn84PwKbj2q29NR7QUH
 4EKqupWHi3Z9IHgSmXkpNandQF9bP1+dCeTIKhcJ0H9oLX799cP9Ai6SloYbJVF73woz7DHB3NH
 b8iGwQvETfp4WwBsK+AYgWy+WBXaAkyPKCM+NdmBfEGIjFcvsdw8FArRZjVHyFrNJer8rXO79du
 tENH+WuWBF3kyNwxQhw4Dm8yWFgPqvw5Mj3of27PhMMcPp8QsTSiXYbhUJsenQgR5tO+PNb9fdj
 1mASHX5q10rL2pViu9Z/zX7/Z706k5Liy6ZqjTAyHRs05X+8PoAQ5faVhc2ondD3Ymk9kyWd9he
 VzQDmVh096d28J1fCE6NQHVNfgg5vZJ67HrrDj+BKYSiyJ+a8bFMRL2LFonYjAh5Q7VA0KVnG0L
 fowWkgXFLz9SUvUHb2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200105
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

PPC2_LSQ_ISA207 is only ever set in the CPUPPCState's insns_flags2
alongside PPC2_ISA207. Checks made by PPC2_LSQ_ISA207 could be
replaced with PPC2_ISA207, hence rendering it useless and apt for
removal. This patch does the same.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 linux-user/ppc/elfload.c                   | 2 +-
 target/ppc/cpu.h                           | 3 ---
 target/ppc/cpu_init.c                      | 3 +--
 target/ppc/cpu_init.h                      | 2 +-
 target/ppc/translate/fixedpoint-impl.c.inc | 4 ++--
 5 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
index 5c6065e08a..76ab9f43de 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -116,7 +116,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     do { if (cpu->env.insns_flags2 & flag) { features |= feature; } } while (0)
 
     GET_FEATURE(PPC_ISEL, QEMU_PPC_FEATURE2_HAS_ISEL);
-    GET_FEATURE2((PPC2_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
+    GET_FEATURE2((PPC2_ISA207 | PPC2_ALTIVEC_207 |
                   PPC2_ISA207S), (QEMU_PPC_FEATURE2_ARCH_2_07 |
                   QEMU_PPC_FEATURE2_VEC_CRYPTO | QEMU_PPC_FEATURE2_HAS_TAR));
     GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00 |
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index df1e943d8d..b3cd8d85df 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2577,8 +2577,6 @@ enum {
     PPC2_FP_CVT_ISA206 = 0x0000000000000400ULL,
     /* ISA 2.06B floating point test instructions                            */
     PPC2_FP_TST_ISA206 = 0x0000000000000800ULL,
-    /* ISA 2.07 load/store quadword                                          */
-    PPC2_LSQ_ISA207    = 0x0000000000002000ULL,
     /* ISA 2.07 Altivec                                                      */
     PPC2_ALTIVEC_207   = 0x0000000000004000ULL,
     /* PowerISA 2.07 Book3s specification                                    */
@@ -2608,7 +2606,6 @@ enum {
                         PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
                         PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
                         PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | \
-                        PPC2_LSQ_ISA207 | \
                         PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
                         PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9bb94fed89..9077c5f581 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6349,8 +6349,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, const void *data)
     pcc->insns_flags2 = PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |
                         PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
                         PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
-                        PPC2_FP_TST_ISA206 |
-                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
+                        PPC2_FP_TST_ISA206 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
                         PPC2_TM | PPC2_PM_ISA206 | PPC2_MEM_LWSYNC |
                         PPC2_BCDA_ISA206;
diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
index 7dd587908e..6961007926 100644
--- a/target/ppc/cpu_init.h
+++ b/target/ppc/cpu_init.h
@@ -18,7 +18,7 @@
     (PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |                 \
      PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
      PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 |                       \
-     PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 | PPC2_ISA205 |              \
+     PPC2_ALTIVEC_207 | PPC2_ISA205 |                                \
      PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |    \
      PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206)
 
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index cef67d6431..b9c20b66dc 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -116,7 +116,7 @@ static bool do_ldst_quad(DisasContext *ctx, arg_D *a, bool store, bool prefixed)
 
     REQUIRE_INSNS_FLAGS(ctx, 64BX);
 
-    if (!prefixed && !(ctx->insns_flags2 & PPC2_LSQ_ISA207)) {
+    if (!prefixed && !(ctx->insns_flags2 & PPC2_ISA207)) {
         /* lq and stq were privileged prior to V. 2.07 */
         REQUIRE_SV(ctx);
 
@@ -280,7 +280,7 @@ TRANS64(STDCX, do_store_cond, MO_UQ);
 static bool trans_STQCX(DisasContext *ctx, arg_STQCX *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_INSNS_FLAGS2(ctx, LSQ_ISA207);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207);
 #if defined(TARGET_PPC64)
     TCGLabel *lfail = gen_new_label();
     TCGv ea = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
-- 
2.55.0


