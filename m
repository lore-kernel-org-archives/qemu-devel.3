Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80F1C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFC3a-0008C6-FA; Thu, 06 Jun 2024 08:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sFC3Y-0008Ag-J4; Thu, 06 Jun 2024 08:17:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sFC3W-0006Dm-CU; Thu, 06 Jun 2024 08:17:24 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 456C3Q0Z021830; Thu, 6 Jun 2024 12:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=Ss59u9TjusRJmOp0+mWHBLXM62IL/ME+k/NxPOYI6FA=;
 b=eTAL6amw1GVUGofVfePznawxrb5ZEIa7HW3VIHr+qyp3MryRLTD/UzXTEonmD9XeNtiA
 0YzySmt3wwAPOdxXMvy4uZXCuBJxxtcizfS8MoeA3ug6WeLcABx2NkqqgZZAh2vqhOFw
 jXjv0mYrgtO5hbFBI+4vNQLf5/v0BHGSnhSfuj7siD4Wa0WxdH9J/rFm6N+pncjgnHQb
 J24M8y+QNYKhcEbwo2d6Wy+MMHnm+wPwREqK+udOrzgdCosP4aQ+LJmfBrg13nZWXonB
 7lZ09X6HdCt9MsIt2bq3+eWPoqKUZH/XVev0XTNcJbUKcwdFvIO1XNpJHtQV18ax3zxn hw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykcrw81r4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:17:18 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456CHHd0015011;
 Thu, 6 Jun 2024 12:17:17 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykcrw81r1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:17:17 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45697tcG031129; Thu, 6 Jun 2024 12:17:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygeypten3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:17:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 456CHAX835259126
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Jun 2024 12:17:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 736CA20043;
 Thu,  6 Jun 2024 12:17:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94F4220040;
 Thu,  6 Jun 2024 12:17:08 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Jun 2024 12:17:08 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v5 4/5] target/ppc: Introduce 'PowerPCCPUClass::logical_pvr'
Date: Thu,  6 Jun 2024 17:46:56 +0530
Message-ID: <20240606121657.254308-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606121657.254308-1-adityag@linux.ibm.com>
References: <20240606121657.254308-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0egZtOh931k92n4HTwvBX7y_96rjV7gO
X-Proofpoint-ORIG-GUID: yXryiMW96zrVSskQKC8aZt426mvUCHtL
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

Introduce 'PnvChipClass::logical_pvr' to know corresponding logical PVR
of a PowerPC CPU.
This helps to have a one-to-one mapping between PVR and logical PVR for
a CPU, and used in a later commit to handle cases where PCR of two
generations of Power chip is same, which causes regressions with compat-mode.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2015e603d4e0..ff43e3645228 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1504,6 +1504,7 @@ struct PowerPCCPUClass {
     void (*parent_parse_features)(const char *type, char *str, Error **errp);
 
     uint32_t pvr;
+    uint32_t logical_pvr;
     /*
      * If @best is false, match if pcc is in the family of pvr
      * Else match only if pcc is the best match for pvr in this family.
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9aa098935d05..50f136cca7f0 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6152,6 +6152,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER7";
     dc->desc = "POWER7";
+    pcc->logical_pvr = CPU_POWERPC_LOGICAL_2_06_PLUS;
     pcc->pvr_match = ppc_pvr_match_power7;
     pcc->pcr_mask = PCR_VEC_DIS | PCR_VSX_DIS | PCR_COMPAT_2_05;
     pcc->pcr_supported = PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
@@ -6315,6 +6316,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER8";
     dc->desc = "POWER8";
+    pcc->logical_pvr = CPU_POWERPC_LOGICAL_2_07;
     pcc->pvr_match = ppc_pvr_match_power8;
     pcc->pcr_mask = PCR_TM_DIS | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->pcr_supported = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
@@ -6508,6 +6510,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER9";
     dc->desc = "POWER9";
+    pcc->logical_pvr = CPU_POWERPC_LOGICAL_3_00;
     pcc->pvr_match = ppc_pvr_match_power9;
     pcc->pcr_mask = POWERPC_POWER9_PCC_PCR_MASK;
     pcc->pcr_supported = POWERPC_POWER9_PCC_PCR_SUPPORTED;
@@ -6642,6 +6645,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER10";
     dc->desc = "POWER10";
+    pcc->logical_pvr = CPU_POWERPC_LOGICAL_3_10;
     pcc->pvr_match = ppc_pvr_match_power10;
     pcc->pcr_mask = POWERPC_POWER10_PCC_PCR_MASK;
     pcc->pcr_supported = POWERPC_POWER10_PCC_PCR_SUPPORTED;
@@ -6696,6 +6700,7 @@ POWERPC_FAMILY(POWER11)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER11";
     dc->desc = "POWER11";
+    pcc->logical_pvr = CPU_POWERPC_LOGICAL_3_10_PLUS;
     pcc->pvr_match = ppc_pvr_match_power11;
     pcc->pcr_mask = POWERPC_POWER10_PCC_PCR_MASK;
     pcc->pcr_supported = POWERPC_POWER10_PCC_PCR_SUPPORTED;
-- 
2.45.1


