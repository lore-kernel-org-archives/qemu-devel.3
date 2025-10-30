Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD743CCF9FF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOMC-0007U6-Ab; Thu, 30 Oct 2025 04:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOM7-0007Qx-Ov
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOM2-0007Kx-6d
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TLlKct026264;
 Thu, 30 Oct 2025 08:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OMSQO3
 LV8qRtKPG4lneeSvpGgrsLHxL5ow4dZoQr66M=; b=ZGzpqvlDkQCsbFr9k+MldN
 ZJRS+dWTZsa2pP180UfxrXps2gUqTCvI0qaQ+Lav6vLuWqm2N4l3xb+sYV5gJzBs
 GYPeqOuQYf2dcLXok2OfQLhpOBmmSQRDJWk7HXAW+Nt6a+yTK1TX2UNQX+k22uKp
 g4mab3Z3LCpUCFMQCXFw6UEJ8DNURlILiKciaVe5uw+gCG7U7jYF5zPct4MK7dCU
 EpJdgQzX1yKD/pb1ElcfEzzsPjMeNmv20xWS9sV+I9bk/Cw8X3xHxQXQCwxbS21F
 tPuuWQO/C24Iyz0yChTPlAALbP8Nw371hmQiMghJgO4h46TiNuFHcXOWZCsoBAhQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aaq7f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:49:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U6GTAN027440;
 Thu, 30 Oct 2025 08:49:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33w2qqne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:49:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U8nq9i29032868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 08:49:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA4D82004D;
 Thu, 30 Oct 2025 08:49:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BE3320040;
 Thu, 30 Oct 2025 08:49:52 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Oct 2025 08:49:51 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/10] target/ppc: Remove the unusable e200 CPUs
Date: Thu, 30 Oct 2025 14:19:30 +0530
Message-ID: <20251030084936.1132417-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251030084936.1132417-1-harshpb@linux.ibm.com>
References: <20251030084936.1132417-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ALkgKXG8 c=1 sm=1 tr=0 ts=690326b3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=AzKrvkh7JctuODD7RhsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: FosXJHHT8crJcTUCGGyAt1Dg2nMvtpiO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX92UABca5Mzta
 voAg2WqbrxGNchlrCG6eWnT+mR1DaVW+51c3y6r5SJM3M0Wil9pNi4xYNka+vrcw5iwTUypyYGK
 IPw3nyyYLj7CwXPCNY3rl2wbhXgXbZGfFyPpmKD2hKswOzBQ3tryVb1dpX6lw8PAbEavlFBj7DW
 DVvCeFaEj8rViqbqgX7cLPWurSNIqwCZvcbRzxTgm0d7yFcQKRNrtzb+UIT2zKK1rB0GKM2K9Qd
 oESQqXZDb9kiMvcAN7ZAtUocOirWT2HPkgl6D7taIZNNAv1l0mWc79m3P3bK6VcRCZLGhDdDRM/
 gu7uqpVPvJzVPqM0414oYVhP/KZnLmr+hspip821EKvPDyYjWP+23btawtj8zjAlhnhnvgW3K4q
 PzeDb+0CWHm78eDQMTFX9d23FCPxbg==
X-Proofpoint-GUID: FosXJHHT8crJcTUCGGyAt1Dg2nMvtpiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

There is currently no machine in QEMU (except the "none" machine)
that can be run with with one of the e200 ppc CPUs - all machines
either complain about an invalid CPU type or crash QEMU immediately.

Looking at the history of this CPU type, it seems like it has never
been used in QEMU and only implemented as a placeholder (see e.g. the
comment about unimplemented instructions in the POWERPC_FAMILY(e200)
section of cpu_init.c). Being completely unused and unusable since
such a long time, let's just remove it now (without deprecation phase,
since there were no users of this dead code anyway).

Note: The init_excp_e200() is used by the e500 CPUs, too, so we
rename this function to init_excp_e500() instead of removing it.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20251024065726.738005-3-thuth@redhat.com
Message-ID: <20251024065726.738005-3-thuth@redhat.com>
---
 target/ppc/cpu-models.h |   4 --
 target/ppc/cpu-models.c |   5 --
 target/ppc/cpu_init.c   | 147 +---------------------------------------
 3 files changed, 2 insertions(+), 154 deletions(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index c6cd27f390..a439eb37ee 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -120,10 +120,6 @@ enum {
 #define CPU_POWERPC_MPC5200_v12      CPU_POWERPC_G2LEgp1
 #define CPU_POWERPC_MPC5200B_v20     CPU_POWERPC_G2LEgp1
 #define CPU_POWERPC_MPC5200B_v21     CPU_POWERPC_G2LEgp1
-    /* e200 family */
-    /* e200 cores */
-    CPU_POWERPC_e200z5             = 0x81000000,
-    CPU_POWERPC_e200z6             = 0x81120000,
     /* e300 family */
     /* e300 cores */
     CPU_POWERPC_e300c1             = 0x00830010,
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 89ae763c7f..26b6debcfc 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -244,11 +244,6 @@
                     CPU_POWERPC_MPC5200B_v20, POWERPC_SVR_5200B_v20, G2LE)
     POWERPC_DEF_SVR("mpc5200b_v21", "MPC5200B v2.1",
                     CPU_POWERPC_MPC5200B_v21, POWERPC_SVR_5200B_v21, G2LE)
-    /* e200 family                                                           */
-    POWERPC_DEF("e200z5",        CPU_POWERPC_e200z5,                 e200,
-                "PowerPC e200z5 core")
-    POWERPC_DEF("e200z6",        CPU_POWERPC_e200z6,                 e200,
-                "PowerPC e200z6 core")
     /* e300 family                                                           */
     POWERPC_DEF("e300c1",        CPU_POWERPC_e300c1,                 e300,
                 "PowerPC e300c1 core")
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 12c645699e..86ead740ee 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -1811,7 +1811,7 @@ static void init_excp_G2(CPUPPCState *env)
 #endif
 }
 
-static void init_excp_e200(CPUPPCState *env, target_ulong ivpr_mask)
+static void init_excp_e500(CPUPPCState *env, target_ulong ivpr_mask)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000FFC;
@@ -2782,149 +2782,6 @@ POWERPC_FAMILY(G2LE)(ObjectClass *oc, const void *data)
                  POWERPC_FLAG_BE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_e200(CPUPPCState *env)
-{
-    register_BookE_sprs(env, 0x000000070000FFFFULL);
-
-    spr_register(env, SPR_BOOKE_SPEFSCR, "SPEFSCR",
-                 &spr_read_spefscr, &spr_write_spefscr,
-                 &spr_read_spefscr, &spr_write_spefscr,
-                 0x00000000);
-    /* Memory management */
-    register_BookE206_sprs(env, 0x0000005D, NULL, 0);
-    register_usprgh_sprs(env);
-
-    spr_register(env, SPR_HID0, "HID0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_HID1, "HID1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_ALTCTXCR, "ALTCTXCR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_BUCSR, "BUCSR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_CTXCR, "CTXCR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_DBCNT, "DBCNT",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_DBCR3, "DBCR3",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_L1CFG0, "L1CFG0",
-                 &spr_read_generic, SPR_NOACCESS,
-                 &spr_read_generic, SPR_NOACCESS,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_L1CSR0, "L1CSR0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_L1FINV0, "L1FINV0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_BOOKE_TLB0CFG, "TLB0CFG",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_BOOKE_TLB1CFG, "TLB1CFG",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_BOOKE_IAC3, "IAC3",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_BOOKE_IAC4, "IAC4",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_MMUCSR0, "MMUCSR0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000); /* TOFIX */
-
-    init_tlbs_emb(env);
-    init_excp_e200(env, 0xFFFF0000UL);
-    env->dcache_line_size = 32;
-    env->icache_line_size = 32;
-    /* XXX: TODO: allocate internal IRQ controller */
-}
-
-POWERPC_FAMILY(e200)(ObjectClass *oc, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
-
-    dc->desc = "e200 core";
-    pcc->init_proc = init_proc_e200;
-    pcc->check_pow = check_pow_hid0;
-    pcc->check_attn = check_attn_none;
-    /*
-     * XXX: unimplemented instructions:
-     * dcblc
-     * dcbtlst
-     * dcbtstls
-     * icblc
-     * icbtls
-     * tlbivax
-     * all SPE multiply-accumulate instructions
-     */
-    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL |
-                       PPC_SPE | PPC_SPE_SINGLE |
-                       PPC_WRTEE | PPC_RFDI |
-                       PPC_CACHE | PPC_CACHE_LOCK | PPC_CACHE_ICBI |
-                       PPC_CACHE_DCBZ | PPC_CACHE_DCBA |
-                       PPC_MEM_TLBSYNC | PPC_TLBIVAX |
-                       PPC_BOOKE;
-    pcc->msr_mask = (1ull << MSR_UCLE) |
-                    (1ull << MSR_SPE) |
-                    (1ull << MSR_POW) |
-                    (1ull << MSR_CE) |
-                    (1ull << MSR_EE) |
-                    (1ull << MSR_PR) |
-                    (1ull << MSR_FP) |
-                    (1ull << MSR_ME) |
-                    (1ull << MSR_FE0) |
-                    (1ull << MSR_DWE) |
-                    (1ull << MSR_DE) |
-                    (1ull << MSR_FE1) |
-                    (1ull << MSR_IR) |
-                    (1ull << MSR_DR);
-    pcc->mmu_model = POWERPC_MMU_BOOKE206;
-    pcc->excp_model = POWERPC_EXCP_BOOKE;
-    pcc->bus_model = PPC_FLAGS_INPUT_BookE;
-    pcc->bfd_mach = bfd_mach_ppc_860;
-    pcc->flags = POWERPC_FLAG_SPE | POWERPC_FLAG_CE |
-                 POWERPC_FLAG_UBLE | POWERPC_FLAG_DE |
-                 POWERPC_FLAG_BUS_CLK;
-}
-
 enum fsl_e500_version {
     fsl_e500v1,
     fsl_e500v2,
@@ -3159,7 +3016,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
     }
 #endif
 
-    init_excp_e200(env, ivpr_mask);
+    init_excp_e500(env, ivpr_mask);
     /* Allocate hardware IRQ controller */
     ppce500_irq_init(env_archcpu(env));
 }
-- 
2.43.5


