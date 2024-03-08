Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64002C54E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYIV-0004XJ-9H; Fri, 08 Mar 2024 06:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYIN-0004Kx-Pr; Fri, 08 Mar 2024 06:21:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYIL-00045F-UH; Fri, 08 Mar 2024 06:21:47 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428ACYjK003389; Fri, 8 Mar 2024 11:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=F6utjyhh9O7OCfDSEUK9foV/6dLvhS7fFy3RvhZGYn4=;
 b=ZaTyz+vBIVGOLE3DRyBQA1ffvLN/QZFY1Cc7dZR0N101sUDsIn2+2Pf5LqyAxLQlYnmN
 F0o/BKv6zZYumKUdW/66lTJgy9kcUes0aiAtNcE8JM1yB1VhYgwmwMVP3kkwVXJXW2c/
 x3BlZQ7wD1yWV8BuHBolMy/leGuCYkwrzUCjNzci4TH9/QfbONoNeRptle0icnvUSSXd
 AI9faLbZJDhULEajCBRuB3M0BaTFd+6oOfZ11qnG2eB1ibJLaY43AhbS2k20MInt++RE
 8chFemrQGsRpv6Wi3xCJGA+WNmDMAw1YKCKfu35P5Ze2eXIXexNK4izHRSSYGXHZ5hjn iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr0qdh4m1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:21:06 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428At4R4015950;
 Fri, 8 Mar 2024 11:21:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr0qdh4kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:21:05 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428A6w8s025381; Fri, 8 Mar 2024 11:21:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmeu047kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:21:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428BKx5S30147284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 11:21:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2DA720040;
 Fri,  8 Mar 2024 11:20:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2557520043;
 Fri,  8 Mar 2024 11:20:56 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.171.30.1]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 11:20:55 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 09/14] spapr: nested: Extend nested_ppc_state for nested
 PAPR API
Date: Fri,  8 Mar 2024 16:49:35 +0530
Message-Id: <20240308111940.1617660-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308111940.1617660-1-harshpb@linux.ibm.com>
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: omCc3qs966c5uayYd0CuT3-9AzUQat81
X-Proofpoint-GUID: dtuFZAQYw_Rsh0UOVZtWAMajYsHBEuV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=946
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403080090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently, nested_ppc_state stores a certain set of registers and works
with nested_[load|save]_state() for state transfer as reqd for nested-hv API.
Extending these with additional registers state as reqd for nested PAPR API.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr_nested.h |  50 ++++++++++++++++
 target/ppc/cpu.h              |   2 +
 hw/ppc/spapr_nested.c         | 106 ++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)

diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 2ac3076fac..d232014ccb 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -7,6 +7,7 @@ typedef struct SpaprMachineStateNested {
     uint64_t ptcr;
     uint8_t api;
 #define NESTED_API_KVM_HV  1
+#define NESTED_API_PAPR    2
     bool capabilities_set;
     uint32_t pvr_base;
     GHashTable *guests;
@@ -121,6 +122,55 @@ struct nested_ppc_state {
     uint64_t ppr;
 
     int64_t tb_offset;
+    /* Nested PAPR API */
+    uint64_t amor;
+    uint64_t dawr0;
+    uint64_t dawrx0;
+    uint64_t ciabr;
+    uint64_t purr;
+    uint64_t spurr;
+    uint64_t ic;
+    uint64_t vtb;
+    uint64_t hdar;
+    uint64_t hdsisr;
+    uint64_t heir;
+    uint64_t asdr;
+    uint64_t dawr1;
+    uint64_t dawrx1;
+    uint64_t dexcr;
+    uint64_t hdexcr;
+    uint64_t hashkeyr;
+    uint64_t hashpkeyr;
+    ppc_vsr_t vsr[64] QEMU_ALIGNED(16);
+    uint64_t ebbhr;
+    uint64_t tar;
+    uint64_t ebbrr;
+    uint64_t bescr;
+    uint64_t iamr;
+    uint64_t amr;
+    uint64_t uamor;
+    uint64_t dscr;
+    uint64_t fscr;
+    uint64_t pspb;
+    uint64_t ctrl;
+    uint64_t vrsave;
+    uint64_t dar;
+    uint64_t dsisr;
+    uint64_t pmc1;
+    uint64_t pmc2;
+    uint64_t pmc3;
+    uint64_t pmc4;
+    uint64_t pmc5;
+    uint64_t pmc6;
+    uint64_t mmcr0;
+    uint64_t mmcr1;
+    uint64_t mmcr2;
+    uint64_t mmcra;
+    uint64_t sdar;
+    uint64_t siar;
+    uint64_t sier;
+    uint32_t vscr;
+    uint64_t fpscr;
 };
 
 typedef struct SpaprMachineStateNestedGuestVcpu {
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0133da4e07..4cffd46c79 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1755,9 +1755,11 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_PSPB              (0x09F)
 #define SPR_DPDES             (0x0B0)
 #define SPR_DAWR0             (0x0B4)
+#define SPR_DAWR1             (0x0B5)
 #define SPR_RPR               (0x0BA)
 #define SPR_CIABR             (0x0BB)
 #define SPR_DAWRX0            (0x0BC)
+#define SPR_DAWRX1            (0x0BD)
 #define SPR_HFSCR             (0x0BE)
 #define SPR_VRSAVE            (0x100)
 #define SPR_USPRG0            (0x100)
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 4c0e2e91e1..09ebf42a57 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -108,6 +108,7 @@ static target_ulong h_copy_tofrom_guest(PowerPCCPU *cpu,
 static void nested_save_state(struct nested_ppc_state *save, PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
 
     memcpy(save->gpr, env->gpr, sizeof(save->gpr));
 
@@ -134,6 +135,58 @@ static void nested_save_state(struct nested_ppc_state *save, PowerPCCPU *cpu)
     save->pidr = env->spr[SPR_BOOKS_PID];
     save->ppr = env->spr[SPR_PPR];
 
+    if (spapr_nested_api(spapr) == NESTED_API_PAPR) {
+        save->pvr = env->spr[SPR_PVR];
+        save->amor = env->spr[SPR_AMOR];
+        save->dawr0 = env->spr[SPR_DAWR0];
+        save->dawrx0 = env->spr[SPR_DAWRX0];
+        save->ciabr = env->spr[SPR_CIABR];
+        save->purr = env->spr[SPR_PURR];
+        save->spurr = env->spr[SPR_SPURR];
+        save->ic = env->spr[SPR_IC];
+        save->vtb = env->spr[SPR_VTB];
+        save->hdar = env->spr[SPR_HDAR];
+        save->hdsisr = env->spr[SPR_HDSISR];
+        save->heir = env->spr[SPR_HEIR];
+        save->asdr = env->spr[SPR_ASDR];
+        save->dawr1 = env->spr[SPR_DAWR1];
+        save->dawrx1 = env->spr[SPR_DAWRX1];
+        save->dexcr = env->spr[SPR_DEXCR];
+        save->hdexcr = env->spr[SPR_HDEXCR];
+        save->hashkeyr = env->spr[SPR_HASHKEYR];
+        save->hashpkeyr = env->spr[SPR_HASHPKEYR];
+        memcpy(save->vsr, env->vsr, sizeof(save->vsr));
+        save->ebbhr = env->spr[SPR_EBBHR];
+        save->tar = env->spr[SPR_TAR];
+        save->ebbrr = env->spr[SPR_EBBRR];
+        save->bescr = env->spr[SPR_BESCR];
+        save->iamr = env->spr[SPR_IAMR];
+        save->amr = env->spr[SPR_AMR];
+        save->uamor = env->spr[SPR_UAMOR];
+        save->dscr = env->spr[SPR_DSCR];
+        save->fscr = env->spr[SPR_FSCR];
+        save->pspb = env->spr[SPR_PSPB];
+        save->ctrl = env->spr[SPR_CTRL];
+        save->vrsave = env->spr[SPR_VRSAVE];
+        save->dar = env->spr[SPR_DAR];
+        save->dsisr = env->spr[SPR_DSISR];
+        save->pmc1 = env->spr[SPR_POWER_PMC1];
+        save->pmc2 = env->spr[SPR_POWER_PMC2];
+        save->pmc3 = env->spr[SPR_POWER_PMC3];
+        save->pmc4 = env->spr[SPR_POWER_PMC4];
+        save->pmc5 = env->spr[SPR_POWER_PMC5];
+        save->pmc6 = env->spr[SPR_POWER_PMC6];
+        save->mmcr0 = env->spr[SPR_POWER_MMCR0];
+        save->mmcr1 = env->spr[SPR_POWER_MMCR1];
+        save->mmcr2 = env->spr[SPR_POWER_MMCR2];
+        save->mmcra = env->spr[SPR_POWER_MMCRA];
+        save->sdar = env->spr[SPR_POWER_SDAR];
+        save->siar = env->spr[SPR_POWER_SIAR];
+        save->sier = env->spr[SPR_POWER_SIER];
+        save->vscr = ppc_get_vscr(env);
+        save->fpscr = env->fpscr;
+    }
+
     save->tb_offset = env->tb_env->tb_offset;
 }
 
@@ -141,6 +194,7 @@ static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
 
     memcpy(env->gpr, load->gpr, sizeof(env->gpr));
 
@@ -167,6 +221,58 @@ static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
     env->spr[SPR_BOOKS_PID] = load->pidr;
     env->spr[SPR_PPR] = load->ppr;
 
+    if (spapr_nested_api(spapr) == NESTED_API_PAPR) {
+        env->spr[SPR_PVR] = load->pvr;
+        env->spr[SPR_AMOR] = load->amor;
+        env->spr[SPR_DAWR0] = load->dawr0;
+        env->spr[SPR_DAWRX0] = load->dawrx0;
+        env->spr[SPR_CIABR] = load->ciabr;
+        env->spr[SPR_PURR] = load->purr;
+        env->spr[SPR_SPURR] = load->purr;
+        env->spr[SPR_IC] = load->ic;
+        env->spr[SPR_VTB] = load->vtb;
+        env->spr[SPR_HDAR] = load->hdar;
+        env->spr[SPR_HDSISR] = load->hdsisr;
+        env->spr[SPR_HEIR] = load->heir;
+        env->spr[SPR_ASDR] = load->asdr;
+        env->spr[SPR_DAWR1] = load->dawr1;
+        env->spr[SPR_DAWRX1] = load->dawrx1;
+        env->spr[SPR_DEXCR] = load->dexcr;
+        env->spr[SPR_HDEXCR] = load->hdexcr;
+        env->spr[SPR_HASHKEYR] = load->hashkeyr;
+        env->spr[SPR_HASHPKEYR] = load->hashpkeyr;
+        memcpy(env->vsr, load->vsr, sizeof(env->vsr));
+        env->spr[SPR_EBBHR] = load->ebbhr;
+        env->spr[SPR_TAR] = load->tar;
+        env->spr[SPR_EBBRR] = load->ebbrr;
+        env->spr[SPR_BESCR] = load->bescr;
+        env->spr[SPR_IAMR] = load->iamr;
+        env->spr[SPR_AMR] = load->amr;
+        env->spr[SPR_UAMOR] = load->uamor;
+        env->spr[SPR_DSCR] = load->dscr;
+        env->spr[SPR_FSCR] = load->fscr;
+        env->spr[SPR_PSPB] = load->pspb;
+        env->spr[SPR_CTRL] = load->ctrl;
+        env->spr[SPR_VRSAVE] = load->vrsave;
+        env->spr[SPR_DAR] = load->dar;
+        env->spr[SPR_DSISR] = load->dsisr;
+        env->spr[SPR_POWER_PMC1] = load->pmc1;
+        env->spr[SPR_POWER_PMC2] = load->pmc2;
+        env->spr[SPR_POWER_PMC3] = load->pmc3;
+        env->spr[SPR_POWER_PMC4] = load->pmc4;
+        env->spr[SPR_POWER_PMC5] = load->pmc5;
+        env->spr[SPR_POWER_PMC6] = load->pmc6;
+        env->spr[SPR_POWER_MMCR0] = load->mmcr0;
+        env->spr[SPR_POWER_MMCR1] = load->mmcr1;
+        env->spr[SPR_POWER_MMCR2] = load->mmcr2;
+        env->spr[SPR_POWER_MMCRA] = load->mmcra;
+        env->spr[SPR_POWER_SDAR] = load->sdar;
+        env->spr[SPR_POWER_SIAR] = load->siar;
+        env->spr[SPR_POWER_SIER] = load->sier;
+        ppc_store_vscr(env, load->vscr);
+        ppc_store_fpscr(env, load->fpscr);
+    }
+
     env->tb_env->tb_offset = load->tb_offset;
 
     /*
-- 
2.39.3


