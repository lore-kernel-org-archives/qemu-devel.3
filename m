Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEF3CF07A5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 05:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sym1z-0006Zr-RE; Thu, 10 Oct 2024 01:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sym1t-0006JL-Ip; Thu, 10 Oct 2024 01:48:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sym1r-0005bP-RF; Thu, 10 Oct 2024 01:48:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A3IgAE000405;
 Thu, 10 Oct 2024 05:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=uaigQl+/E0Ios
 TfUESCFiGvykW8AXEOjA3RBH0xldS8=; b=VJUU2kiy3TrsQf4LX/1hfQdiaNT86
 tL1huWzsq9So2YubGKj7p/oDft6e+CyTN9CyZCENTsOBnx5I03vGxcnEX5wGcHZh
 0fSLi/IXMjQRDJXscCpqB3ZZbpG9yahZBy0sNGa9aSkHS5ySrpVYhEGgB5N9io1G
 MGlok3rtYHMBBjQmrvEYAtGjezib/3XWiT9ggumSXYo7jOE6mAy8XpgYWtWh+09K
 YwADVmbWdg8ldNqYXkTD2/c2Qi76giiE4SdYT9xl1Jj6WQtiXsF4MJz7BcSPWD1Z
 wuAcofwzFUGSIRY3xrOR+JN9vSQMVDkJZe2l6y6V4AaeVZ4XEC5NaQ+qQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4266w6rg4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:48:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A5m0AI006371;
 Thu, 10 Oct 2024 05:48:00 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4266w6rg47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:48:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A2VmRb010727;
 Thu, 10 Oct 2024 05:47:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 423j0jnqke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A5lw0r35390002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 05:47:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08B4420043;
 Thu, 10 Oct 2024 05:47:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02EAF20040;
 Thu, 10 Oct 2024 05:47:57 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2024 05:47:56 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v4 9/9] target/ppc: reduce duplicate code between
 init_proc_POWER{9, 10}
Date: Thu, 10 Oct 2024 11:17:40 +0530
Message-ID: <20241010054740.1106997-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010054740.1106997-1-harshpb@linux.ibm.com>
References: <20241010054740.1106997-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aJ9Z-NHwcow5qebcW-XE5BBOqF-YYfnR
X-Proofpoint-ORIG-GUID: 8MdTtgIJ3GqgKyaaoEJFYLlTYtnOE1Up
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_02,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=681 mlxscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100036
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Historically, the registration of sprs have been inherited alongwith
every new Power arch support being added leading to a lot of code
duplication. It's time to do necessary cleanups now to avoid further
duplication with newer arch support being added.

Signed-off-by: Harsh Prateek Bora <harshb@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 58 +++++++++----------------------------------
 1 file changed, 12 insertions(+), 46 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9cb5dd4596..de1dd63bf7 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6410,7 +6410,7 @@ static struct ppc_radix_page_info POWER9_radix_page_info = {
 #endif /* CONFIG_USER_ONLY */
 
 #define POWER9_BHRB_ENTRIES_LOG2 5
-static void init_proc_POWER9(CPUPPCState *env)
+static void register_power9_common_sprs(CPUPPCState *env)
 {
     /* Common Registers */
     init_proc_book3s_common(env);
@@ -6429,7 +6429,6 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power5p_ear_sprs(env);
     register_power5p_tb_sprs(env);
     register_power6_common_sprs(env);
-    register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
     register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
@@ -6447,16 +6446,21 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power8_rpr_sprs(env);
     register_power9_mmu_sprs(env);
 
-    /* POWER9 Specific registers */
-    spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
-                     spr_read_generic, spr_write_generic,
-                     KVM_REG_PPC_TIDR, 0);
-
     /* FIXME: Filter fields properly based on privilege level */
     spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
                         spr_read_generic, spr_write_generic,
                         KVM_REG_PPC_PSSCR, 0);
 
+}
+
+static void init_proc_POWER9(CPUPPCState *env)
+{
+    register_power9_common_sprs(env);
+    register_HEIR32_spr(env);
+    /* POWER9 Specific registers */
+    spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
+                     spr_read_generic, spr_write_generic,
+                     KVM_REG_PPC_TIDR, 0);
     /* env variables */
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
@@ -6562,50 +6566,12 @@ static struct ppc_radix_page_info POWER10_radix_page_info = {
 #define POWER10_BHRB_ENTRIES_LOG2 5
 static void init_proc_POWER10(CPUPPCState *env)
 {
-    /* Common Registers */
-    init_proc_book3s_common(env);
-    register_book3s_207_dbg_sprs(env);
-
-    /* Common TCG PMU */
-    init_tcg_pmu_power8(env);
-
-    /* POWER8 Specific Registers */
-    register_book3s_ids_sprs(env);
-    register_amr_sprs(env);
-    register_iamr_sprs(env);
-    register_book3s_purr_sprs(env);
-    register_power5p_common_sprs(env);
-    register_power5p_lpar_sprs(env);
-    register_power5p_ear_sprs(env);
-    register_power5p_tb_sprs(env);
-    register_power6_common_sprs(env);
+    register_power9_common_sprs(env);
     register_HEIR64_spr(env);
-    register_power6_dbg_sprs(env);
-    register_power7_common_sprs(env);
-    register_power8_tce_address_control_sprs(env);
-    register_power8_ids_sprs(env);
-    register_power8_ebb_sprs(env);
-    register_power8_fscr_sprs(env);
-    register_power8_pmu_sup_sprs(env);
-    register_power8_pmu_user_sprs(env);
-    register_power8_tm_sprs(env);
-    register_power8_pspb_sprs(env);
-    register_power8_dpdes_sprs(env);
-    register_vtb_sprs(env);
-    register_power8_ic_sprs(env);
-    register_power9_book4_sprs(env);
-    register_power8_rpr_sprs(env);
-    register_power9_mmu_sprs(env);
     register_power10_hash_sprs(env);
     register_power10_dexcr_sprs(env);
     register_power10_pmu_sup_sprs(env);
     register_power10_pmu_user_sprs(env);
-
-    /* FIXME: Filter fields properly based on privilege level */
-    spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
-                        spr_read_generic, spr_write_generic,
-                        KVM_REG_PPC_PSSCR, 0);
-
     /* env variables */
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
-- 
2.45.2


