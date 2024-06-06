Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A58C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFC3a-0008Cw-W6; Thu, 06 Jun 2024 08:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sFC3Y-0008BG-TE; Thu, 06 Jun 2024 08:17:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sFC3W-0006Dq-IJ; Thu, 06 Jun 2024 08:17:24 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 456C2dfJ020923; Thu, 6 Jun 2024 12:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=E12OaciOl1HfBFqAG6bOyIiXW1FJkLSq8oRPovzamZA=;
 b=slsd3awbyk8umIx7mdpm7BeY0iL3WTtDJLIKU9D/L6QWX9AXd3aiRp8xYHn7X0kjCdVG
 IBPz/z/ciVbxr/ptq2Lu0d0gtidQWQT8pkMBAcreGW8DPiwFh3kE/QAIo+w7CGDMKoMv
 yN+Fle3SBa88NZQQciaszdobIT6QzAwQ+QICqng7BUxc4uVM/ASz6IfROoG+1/JlqgId
 60LVYI1XxS6+ujsq3iEgNo1NHHwTXMtYY3YoslVui+sA9IdWQfcUQzx/Oi+8jDjji4GC
 lITIcJ0vtvzJm6/fFC4RYG1XmLor8tqct5FozCh0uIpohd1mNse2Pm1d+50M6Lq2Y2r5 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykcrw81qf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:17:12 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456CHCqC014889;
 Thu, 6 Jun 2024 12:17:12 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykcrw81qb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:17:12 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 456BR27G026550; Thu, 6 Jun 2024 12:17:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yggp39ya7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:17:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 456CH53354657366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Jun 2024 12:17:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8894120043;
 Thu,  6 Jun 2024 12:17:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 626A920040;
 Thu,  6 Jun 2024 12:17:03 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Jun 2024 12:17:03 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v5 2/5] target/ppc: Add Power11 DD2.0 processor
Date: Thu,  6 Jun 2024 17:46:54 +0530
Message-ID: <20240606121657.254308-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606121657.254308-1-adityag@linux.ibm.com>
References: <20240606121657.254308-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jYahh5Anknp1-k14bdot0JAUA1ka4cq7
X-Proofpoint-ORIG-GUID: UnSTd2NDl31x88BzCtgpRALqQk1c0eBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406060090
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

Add CPU target code to add support for new Power11 Processor.

Power11 core is same as Power10, hence reuse functions defined for
Power10.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 target/ppc/compat.c     |  7 ++++++
 target/ppc/cpu-models.c |  3 +++
 target/ppc/cpu-models.h |  3 +++
 target/ppc/cpu_init.c   | 54 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index ebef2cccecf3..12dd8ae290ca 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -100,6 +100,13 @@ static const CompatInfo compat_table[] = {
         .pcr_level = PCR_COMPAT_3_10,
         .max_vthreads = 8,
     },
+    { /* POWER11, ISA3.10 */
+        .name = "power11",
+        .pvr = CPU_POWERPC_LOGICAL_3_10_PLUS,
+        .pcr = PCR_COMPAT_3_10,
+        .pcr_level = PCR_COMPAT_3_10,
+        .max_vthreads = 8,
+    },
 };
 
 static const CompatInfo *compat_by_pvr(uint32_t pvr)
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index f2301b43f78b..ece348178188 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -734,6 +734,8 @@
                 "POWER9 v2.2")
     POWERPC_DEF("power10_v2.0",  CPU_POWERPC_POWER10_DD20,           POWER10,
                 "POWER10 v2.0")
+    POWERPC_DEF("power11_v2.0",  CPU_POWERPC_POWER11_DD20,           POWER11,
+                "POWER11_v2.0")
 #endif /* defined (TARGET_PPC64) */
 
 /***************************************************************************/
@@ -909,6 +911,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "power8nvl", "power8nvl_v1.0" },
     { "power9", "power9_v2.2" },
     { "power10", "power10_v2.0" },
+    { "power11", "power11_v2.0" },
 #endif
 
     /* Generic PowerPCs */
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 0229ef3a9a5c..ef74e387b047 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -354,6 +354,8 @@ enum {
     CPU_POWERPC_POWER10_BASE       = 0x00800000,
     CPU_POWERPC_POWER10_DD1        = 0x00801100,
     CPU_POWERPC_POWER10_DD20       = 0x00801200,
+    CPU_POWERPC_POWER11_BASE       = 0x00820000,
+    CPU_POWERPC_POWER11_DD20       = 0x00821200,
     CPU_POWERPC_970_v22            = 0x00390202,
     CPU_POWERPC_970FX_v10          = 0x00391100,
     CPU_POWERPC_970FX_v20          = 0x003C0200,
@@ -391,6 +393,7 @@ enum {
     CPU_POWERPC_LOGICAL_2_07       = 0x0F000004,
     CPU_POWERPC_LOGICAL_3_00       = 0x0F000005,
     CPU_POWERPC_LOGICAL_3_10       = 0x0F000006,
+    CPU_POWERPC_LOGICAL_3_10_PLUS  = 0x0F000007,
 };
 
 /* System version register (used on MPC 8xxx)                                */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 3d8a112935ae..9aa098935d05 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6669,6 +6669,60 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->l1_icache_size = 0x8000;
 }
 
+static bool ppc_pvr_match_power11(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
+{
+    uint32_t base = pvr & CPU_POWERPC_POWER_SERVER_MASK;
+    uint32_t pcc_base = pcc->pvr & CPU_POWERPC_POWER_SERVER_MASK;
+
+    if (!best && (base == CPU_POWERPC_POWER11_BASE)) {
+        return true;
+    }
+
+    if (base != pcc_base) {
+        return false;
+    }
+
+    if ((pvr & 0x0f00) == (pcc->pvr & 0x0f00)) {
+        return true;
+    }
+
+    return false;
+}
+
+POWERPC_FAMILY(POWER11)(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
+
+    dc->fw_name = "PowerPC,POWER11";
+    dc->desc = "POWER11";
+    pcc->pvr_match = ppc_pvr_match_power11;
+    pcc->pcr_mask = POWERPC_POWER10_PCC_PCR_MASK;
+    pcc->pcr_supported = POWERPC_POWER10_PCC_PCR_SUPPORTED;
+    pcc->init_proc = init_proc_POWER10;
+    pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_hid0_power9;
+    pcc->insns_flags = POWERPC_FAMILY_POWER9_INSNS_FLAGS; /* same as P9 */
+    pcc->insns_flags2 = POWERPC_FAMILY_POWER10_INSNS_FLAGS2;
+    pcc->msr_mask = POWERPC_POWER10_PCC_MSR_MASK;
+    pcc->lpcr_mask = POWERPC_POWER10_PCC_LPCR_MASK;
+
+    pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
+    pcc->mmu_model = POWERPC_MMU_3_00;
+#if !defined(CONFIG_USER_ONLY)
+    /* segment page size remain the same */
+    pcc->hash64_opts = &ppc_hash64_opts_POWER7;
+    pcc->radix_page_info = &POWER10_radix_page_info;
+    pcc->lrg_decr_bits = 56;
+#endif
+    pcc->excp_model = POWERPC_EXCP_POWER10;
+    pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
+    pcc->bfd_mach = bfd_mach_ppc64;
+    pcc->flags = POWERPC_POWER10_PCC_FLAGS;
+    pcc->l1_dcache_size = 0x8000;
+    pcc->l1_icache_size = 0x8000;
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
 {
-- 
2.45.1


