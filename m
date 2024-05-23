Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EE0C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 05:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA0n3-0002To-3z; Thu, 23 May 2024 01:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sA0mv-0002OI-Em; Thu, 23 May 2024 01:14:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sA0mo-0000pZ-58; Thu, 23 May 2024 01:14:45 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N42a6C014066; Thu, 23 May 2024 05:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9lpa27T+UbgauvHsMP28ueUlm80/+afxzo4gvJYBkms=;
 b=mTGZ79Un/NHW7sX6X4MmspGGsfs3041twkMnOrHZnC0vQXqSC01LAvI8Un3vh4qnvsHj
 W2Gv+hBAckf+ZPdGPW1d8UcBtF8XBxELEfsFC9HhWQ0LFYvMqpoEW1Dk2thqzD7fd4B1
 +ASdpo7yt4QbGf1GtCFSHITXNEikCPjhYFFRqEn97s7sm8A/TRo+OFY3t+ATGLkyw4oj
 kVvQmwWDBL6RpnZTOv4mh9XEUlzH4jfrBrP3nr/GQkD1iN7Uipw9vXvEq1LQbNWSPjTr
 wDq0NotfnWfCDRnqeLLaqJLoZXC+FfX8fIGyOBoJhmnZqF4XwVQqqclhGNCp4JV2U8dn 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9xe484v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 05:14:36 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44N5EZnm019021;
 Thu, 23 May 2024 05:14:35 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9xe484uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 05:14:35 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N2O4Vx007384; Thu, 23 May 2024 05:14:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y79c37p44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 05:14:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44N5EVwP47710504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 May 2024 05:14:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F5DA2004B;
 Thu, 23 May 2024 05:14:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2614020043;
 Thu, 23 May 2024 05:14:30 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.165])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 May 2024 05:14:29 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v2 6/7] target/ppc: reduce duplicate code between
 init_proc_POWER{9, 10}
Date: Thu, 23 May 2024 10:44:11 +0530
Message-Id: <20240523051412.226970-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240523051412.226970-1-harshpb@linux.ibm.com>
References: <20240523051412.226970-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: llwnVAsosvPN_zT1oCd7lmrwthU4mwPE
X-Proofpoint-GUID: ieCouRTGRTHUi34ZvoBpqpk_rIGaXNBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_02,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=644 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230033
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 target/ppc/cpu_init.c | 43 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 6d82f24c87..5fb9a0583e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6307,7 +6307,7 @@ static struct ppc_radix_page_info POWER9_radix_page_info = {
 };
 #endif /* CONFIG_USER_ONLY */
 
-static void init_proc_POWER9(CPUPPCState *env)
+static void register_power9_common_sprs(CPUPPCState *env)
 {
     /* Common Registers */
     init_proc_book3s_common(env);
@@ -6326,7 +6326,6 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power5p_ear_sprs(env);
     register_power5p_tb_sprs(env);
     register_power6_common_sprs(env);
-    register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
@@ -6342,6 +6341,12 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power9_book4_sprs(env);
     register_power8_rpr_sprs(env);
     register_power9_mmu_sprs(env);
+}
+
+static void init_proc_POWER9(CPUPPCState *env)
+{
+    register_power9_common_sprs(env);
+    register_HEIR32_spr(env);
 
     /* POWER9 Specific registers */
     spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
@@ -6499,39 +6504,9 @@ static struct ppc_radix_page_info POWER10_radix_page_info = {
 
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
+
     register_power10_hash_sprs(env);
     register_power10_dexcr_sprs(env);
     register_power10_pmu_sup_sprs(env);
-- 
2.39.3


