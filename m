Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331CBCA600C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN3c-0003or-FB; Wed, 07 Oct 2026 04:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEHjJ-0006BQ-Nq; Tue, 06 Oct 2026 22:50:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEHj2-00040V-Hi; Tue, 06 Oct 2026 22:49:54 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A5XVP1603478; Tue, 6 Oct 2026 10:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FICTGFNUbsZvRU5/q
 kM31KCJEdZMVkEI0BlR/dbmCVY=; b=HpaUxMZQClW+KKZR+9bxPXG6/Qafdfgts
 Eb9uyVkNaTpokTRerxhu6lqm3z8ENnpzPt9B1ZZn6o+H/oCaBIQG8dhSE/UsGZ0+
 Q3XDVVZdKxmW+q64AlRmtQEOshd6mot2+zm0ouY7idwa72qOCzNI4W1wdPn9ZrtG
 iovI6ItUwAyI3PwzOisLaHdw0s8vBH5lei8Hdd+n9IF485XCcf09nArbvn7dbr0B
 d32ebIOmpJ7hcngJJw9P3mtRGq3KoZkX/3jb81nwPkFAFmUQk2qD+Zn4eahKV2mR
 cLOYyGc0O52pzDqKF9FeW0p5z9IluPSJpw90hwkMOXFNoL8QScADA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrfguc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A6Ift108866; Tue, 6 Oct 2026 10:57:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jsjbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696AvDKO42140152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 10:57:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AAF62004D;
 Tue,  6 Oct 2026 10:57:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3A0120040;
 Tue,  6 Oct 2026 10:57:10 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.87.135.85]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 10:57:10 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, uverma@linux.ibm.com,
 milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 2/8] target/ppc: Enable Dense Math Facility for ISA 3.2
Date: Tue,  6 Oct 2026 16:26:13 +0530
Message-ID: <20261006105650.189752-3-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006105650.189752-1-rathc@linux.ibm.com>
References: <20261006105650.189752-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX2RbZXnpsXOHg
 8/VqpiBCEmlsxkS3hjzz+GFYRGR4IXaIBylEixbbU18v8Ogy05Obw9RIJu6EPKKDaYGW/m74XOe
 Y37nXejfImItYp1sb3AxQhrsNt0PQY4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX1ul9rUjdKfgb
 fGtAWM1tzmITR7p1w5ti4B8tNeulw1H4hBJX/3wibi3YDVj7HAaTtza+TZ635TZ/n6gfea60pyX
 cJLRpkoT9GBjHMrAq6vShHDGQDR4vHJav8lDgv6Q6k/Nl1GuxS/Lio6leafTGQtaPEp4mNztgtY
 Z8/+3hgIGIrDRiPg4sfuG0f032RImAm+24RjAbBDn5Viw19OWJONRssWZXNa6Rkr7R56XZDEaeX
 fSwwGB8sYm3LYi8012mwUl1Im7rL+ox34k7eqjc3GO11pKFCRf7rOhX+q3D+mNAcP8pVM/shOU6
 eLWjL1tDx+k+VeVK5C4hDkVYLGGLxdwMZuVOqnFtQicPEPdbyHKnWkqOgLNcQrFBNt9Vwn1CYQf
 MjxHKbh04/xba+zeVf9REQc9X5hg18d9mW6lyB0mDAkjbfTxLK6W5Z9wA3B6KqfWvob6AIXiRLF
 HJL8q0Dcy32vZeWb2og==
X-Proofpoint-GUID: 47kyCsAjE7Mg-p2j2--csrAXrRWzqO4D
X-Proofpoint-ORIG-GUID: gSrBdjKQrj2IwX0Z9Aa0TrB3f_bHAJa9
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac4d40f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=WKNKSzKWUzdxrvhZDZcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060042
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This patch implements the dense math registers (DMR) that are introduced
in RFC 02653 for ISA 3.2 as part of the dense math facility (DMF).
Also adds a new hflag for the same.

DMR which are 1024 bits long are implemented as an array of 'rows' which
are 128 bits each. DMF instructions manipulate DMRs in the granularity
of these rows.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/cpu.h         | 13 +++++++++++++
 target/ppc/helper_regs.c |  4 ++++
 target/ppc/translate.c   |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 09b511030b..1cd379810a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -355,6 +355,11 @@ typedef union _ppc_vsr_t {
 typedef ppc_vsr_t ppc_avr_t;
 typedef ppc_vsr_t ppc_fprp_t;
 typedef ppc_vsr_t ppc_acc_t;
+typedef ppc_vsr_t ppc_dmr_row_t;
+
+typedef struct ppc_dmr_t {
+    ppc_dmr_row_t row[8];
+} ppc_dmr_t;
 
 #if !defined(CONFIG_USER_ONLY)
 /* Software TLB cache */
@@ -449,6 +454,7 @@ typedef enum {
 #define MSR_SEM5 PPC_BIT_NR(38) /* SIB Error Mask Bit 5 (PPE42)              */
 #define MSR_SEM6 PPC_BIT_NR(39) /* SIB Error Mask Bit 6 (PPE42)              */
 #define MSR_VSX  PPC_BIT_NR(40) /* Vector Scalar Extension (>= 2.06)x hflags */
+#define MSR_DM   PPC_BIT_NR(39) /* Dense Math Facility (>= 3.2)     x hflags */
 #define MSR_IS0  PPC_BIT_NR(40) /* Instance Specific Bit 0 (PPE42)           */
 #define MSR_S    PPC_BIT_NR(41) /* Secure state                              */
 #define MSR_SIBRC0 PPC_BIT_NR(41) /* Last SIB return code Bit 0 (PPE42)      */
@@ -743,6 +749,7 @@ FIELD(MSR, SIBRCA, MSR_SIBRCA7, 8)
 #define FSCR_IC_EBB         7
 #define FSCR_IC_TAR         8
 #define FSCR_IC_SCV        12
+#define FSCR_IC_DM         14
 
 /* Exception state register bits definition                                  */
 #define ESR_PIL   PPC_BIT(36) /* Illegal Instruction                    */
@@ -844,6 +851,8 @@ enum {
     POWERPC_FLAG_BHRB      = 0x01000000,
     /* Use PPE42-specific behavior                                           */
     POWERPC_FLAG_PPE42     = 0x02000000,
+    /* Has DMF                                                               */
+    POWERPC_FLAG_DM        = 0x04000000,
 };
 
 /*
@@ -873,6 +882,7 @@ enum {
     HFLAGS_INSN_CNT = 19, /* PMU instruction count enabled */
     HFLAGS_BHRB_ENABLE = 20, /* Summary flag for enabling BHRB */
     HFLAGS_VSX = 23, /* MSR_VSX if cpu has VSX */
+    HFLAGS_DM = 24, /* MSR_DM */
     HFLAGS_VR = 25,  /* MSR_VR if cpu has VRE */
 
     HFLAGS_IMMU_IDX = 26, /* 26..28 -- the composite immu_idx */
@@ -1364,6 +1374,9 @@ struct CPUArchState {
     float_status fp_status; /* Floating point execution context */
     target_ulong fpscr;     /* Floating point status and control register */
 
+    /* DMF registers */
+    ppc_dmr_t dmr[8] QEMU_ALIGNED(16);
+
     /* Internal devices resources */
     ppc_tb_t *tb_env;      /* Time base and decrementer */
     ppc_dcr_t *dcr_env;    /* Device control registers */
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index acf74c543a..75a97f8795 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -189,6 +189,10 @@ static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
         /* PPE42 has a single address space and no problem state */
         msr = 0;
     }
+    if (ppc_flags & POWERPC_FLAG_DM) {
+        QEMU_BUILD_BUG_ON(MSR_DM != HFLAGS_DM);
+        msr_mask |= 1 << MSR_DM;
+    }
 
 #ifndef CONFIG_USER_ONLY
     if (!env->has_hv_mode || (msr & (1ull << MSR_HV))) {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 467b8f3d4e..48e5903214 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -187,6 +187,7 @@ struct DisasContext {
     bool fpu_enabled;
     bool altivec_enabled;
     bool vsx_enabled;
+    bool dm_enabled;
     bool spe_enabled;
     bool tm_enabled;
     bool gtse;
@@ -5023,6 +5024,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->spe_enabled = (hflags >> HFLAGS_SPE) & 1;
     ctx->altivec_enabled = (hflags >> HFLAGS_VR) & 1;
     ctx->vsx_enabled = (hflags >> HFLAGS_VSX) & 1;
+    ctx->dm_enabled = (hflags >> HFLAGS_DM) & 1;
     ctx->tm_enabled = (hflags >> HFLAGS_TM) & 1;
     ctx->gtse = (hflags >> HFLAGS_GTSE) & 1;
     ctx->hr = (hflags >> HFLAGS_HR) & 1;
-- 
2.55.0


