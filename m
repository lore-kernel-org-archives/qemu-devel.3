Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF4DEEE27A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 04:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxh9-0001vY-TG; Fri, 13 Sep 2024 00:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxh5-0001Ws-23; Fri, 13 Sep 2024 00:14:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxh3-0002XR-DO; Fri, 13 Sep 2024 00:14:02 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CKlMqa004785;
 Fri, 13 Sep 2024 04:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=jCL9Lz7Lyh5GT
 3S6ak09BTeyoBCIFMK1GcWAdRuMN3g=; b=J4Xv4MIhO5FGzRf2kyAVTmLr37Vm9
 ZoVRHN2L4awRyMuRVor51D84Uomk80TBahFROQZusGNnW3vOZUxc3u1pxkOp21Xf
 EqbIGXUCZTvglNbqEON4/jIQY61XJFpT7Zgy+qzBRqEE6M2RS45AHTT17XkLnxaB
 9km2KWQv9+mjkC6Q/WFZAtESTBHcXlwj9uFX3ZX+ic+x3OkPXTOiGgTcF6airuAt
 go80jknTyf44xNXUNT09/qIegR2bB/eJapkk2XcrzExPWvvSNHV9fI8hUgsWKZgI
 Fr9prtMouDGwr7u44FcARIoAAF0WwFhPskDrBly8U8ge2FyI6wjYzsdxA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kyb1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:58 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48D4Dwh1008427;
 Fri, 13 Sep 2024 04:13:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kyb1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D1nnIA032073;
 Fri, 13 Sep 2024 04:13:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nn3rr6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48D4DtWD55968248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 04:13:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E2622004B;
 Fri, 13 Sep 2024 04:13:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D96820040;
 Fri, 13 Sep 2024 04:13:52 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 04:13:51 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v3 06/10] target/ppc: reduce duplicate code between
 init_proc_POWER{9, 10}
Date: Fri, 13 Sep 2024 09:43:33 +0530
Message-ID: <20240913041337.912876-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240913041337.912876-1-harshpb@linux.ibm.com>
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L217n2MlSRWoxyzADslc1zbXtxBLbnZY
X-Proofpoint-ORIG-GUID: dKrTM19sPWnMgwXJupaMGqDaTRt_Av3s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_01,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=686 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130028
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Historically, the registration of sprs have been inherited alongwith
every new Power arch support being added leading to a lot of code
duplication. It's time to do necessary cleanups now to avoid further
duplication with newer arch support being added.

Signed-off-by: Harsh Prateek Bora <harshb@linux.ibm.com>
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


