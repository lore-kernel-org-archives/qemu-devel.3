Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F20C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4LN-0006jD-Fy; Mon, 19 Feb 2024 09:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maddy@linux.ibm.com>)
 id 1rc13r-0002HK-6L; Mon, 19 Feb 2024 05:39:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maddy@linux.ibm.com>)
 id 1rc13o-0007vB-Ro; Mon, 19 Feb 2024 05:39:46 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JA15gR022154; Mon, 19 Feb 2024 10:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0FsG32QWeXXytlDX0Lcp+J/rBi+/Vm1lmER1qSdtO+M=;
 b=q3B3AsQIWLKVyqg3uBXfKptnTcZJDSuIMqGfWiIfeIB9tUhOMV+QhwesPD3tXDDcly06
 xnzCJLcr4GlX3OfxR6811qI204H204ugFWQ4WEbEGRqQ76cfRBycZcZfE3u31OatVpYL
 V0MOeT/Pr+hDG2erUXW6s18urG0COO5Q/ZY4ZAAtLvxaWWTEywFavuqHfyYNPSo4+y1Y
 a5epluWwJmti+DvTHIe92EjzhHnWxCeSFskT8niG8jAZks0MTug8x5TowHSjNPUGwTvy
 2G9Qvie0nJ9rxg9xLJ3DzCIzUK2EnKTN/RPkKKp4MIFvUVqgpF0LWYNLNCsQii45cIch FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wbdgwe8cb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 10:39:39 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JAKUe5018968;
 Mon, 19 Feb 2024 10:39:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wbdgwe8c0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 10:39:38 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41J8ZdRF017265; Mon, 19 Feb 2024 10:39:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mm0ffn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 10:39:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41JAdWoI32768532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Feb 2024 10:39:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 421202004F;
 Mon, 19 Feb 2024 10:39:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D91420043;
 Mon, 19 Feb 2024 10:39:28 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown
 [9.171.81.188]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Feb 2024 10:39:28 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, atrajeev@linux.vnet.ibm.com,
 kjain@linux.ibm.com, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH] target/ppc: Add power10 pmu SPRs
Date: Mon, 19 Feb 2024 16:09:24 +0530
Message-ID: <20240219103924.445857-1-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OcJbSNCsgann8IMaQJ7_ZC3H5KvMPKw2
X-Proofpoint-ORIG-GUID: ZsPDBsHoUJWjoHL68icBY7QK8rhVq4PW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_07,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 mlxlogscore=866 lowpriorityscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190079
Received-SPF: pass client-ip=148.163.156.1; envelope-from=maddy@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 19 Feb 2024 09:10:00 -0500
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

Currently in tcg mode, when reading from power10 pmu spr like MMCR3,
qemu logs this message (when starting qemu with -d guest_errors)

	Trying to read invalid spr 754 (0x2f2) at 0000000030056bb0

This is becuase, no read/write call-backs are registered for
these SPRs. Add support to register generic read/write
functions to these power10 pmu sprs to fix it.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 target/ppc/cpu.h      |  6 ++++++
 target/ppc/cpu_init.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a44de22ca4..e5d0c8a5ee 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1933,6 +1933,12 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_TLB2CFG     (0x2B2)
 #define SPR_BOOKE_TLB3CFG     (0x2B3)
 #define SPR_BOOKE_EPR         (0x2BE)
+#define SPR_POWER_USIER2      (0x2E0)
+#define SPR_POWER_USIER3      (0x2E1)
+#define SPR_POWER_UMMCR3      (0x2E2)
+#define SPR_POWER_SIER2       (0x2F0)
+#define SPR_POWER_SIER3       (0x2F1)
+#define SPR_POWER_MMCR3       (0x2F2)
 #define SPR_PERF0             (0x300)
 #define SPR_RCPU_MI_RBA0      (0x300)
 #define SPR_MPC_MI_CTR        (0x300)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9931372a08..d64da75a61 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5308,6 +5308,38 @@ static void register_power8_pmu_user_sprs(CPUPPCState *env)
                  0x00000000);
 }
 
+static void register_power10_pmu_sup_sprs(CPUPPCState *env)
+{
+    spr_register_kvm(env, SPR_POWER_MMCR3, "MMCR3",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic,
+                     KVM_REG_PPC_MMCR3, 0x00000000);
+    spr_register_kvm(env, SPR_POWER_SIER2, "SIER2",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic,
+                     KVM_REG_PPC_SIER2, 0x00000000);
+    spr_register_kvm(env, SPR_POWER_SIER3, "SIER3",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic,
+                     KVM_REG_PPC_SIER3, 0x00000000);
+}
+
+static void register_power10_pmu_user_sprs(CPUPPCState *env)
+{
+    spr_register(env, SPR_POWER_UMMCR3, "UMMCR3",
+                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+    spr_register(env, SPR_POWER_USIER2, "USIER2",
+                 &spr_read_generic, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+    spr_register(env, SPR_POWER_USIER3, "USIER3",
+                 &spr_read_generic, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+}
+
 static void register_power5p_ear_sprs(CPUPPCState *env)
 {
     /* External access control */
@@ -6505,6 +6537,8 @@ static void init_proc_POWER10(CPUPPCState *env)
     register_power9_mmu_sprs(env);
     register_power10_hash_sprs(env);
     register_power10_dexcr_sprs(env);
+    register_power10_pmu_sup_sprs(env);
+    register_power10_pmu_user_sprs(env);
 
     /* FIXME: Filter fields properly based on privilege level */
     spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
-- 
2.43.0


