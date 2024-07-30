Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A729FC49EA1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 19:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYsRz-0002Z1-PA; Tue, 30 Jul 2024 15:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sYsRu-0002NS-6y; Tue, 30 Jul 2024 15:23:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sYsRr-0002GZ-Qx; Tue, 30 Jul 2024 15:23:53 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UFPLYn030516;
 Tue, 30 Jul 2024 19:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 IVOz0PUC7UK9mIwBCQ10IVcoyQIdfoGIptTF86r7v7U=; b=JJ1ZY6SZW5riZgcu
 eTtwORrvYO2Kg/km4vdIlYcSwG/e09oAvh1m5Rlx1S+DW/S56tc4tWTP/YpGi3qQ
 xnwb3CaM+cHykq5I5Jiyk/813nRYhakdLUJigqB+OAOIX9L+HU8hxSjHgZsp0xKc
 5dWuRLHDXI0aOLz8jQKsGWtTthDlx4WomyYu/EJ5+/l2tjxHNllx6+W1vvoQU5mM
 +pChvXeFXET3EB5sojOcJdf7/d4hb+0JRTC3CsEqoSXM5M7mC0y7tv/qxtqveOne
 S8wf1eMcUxNUoIBmBrDuBnveRPqwMSgDrExSZnmIGKrXwVBx3vCVuHKonFjAMuKX
 T2tv2w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q13a8vtp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 19:23:41 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46UJNfVg028323;
 Tue, 30 Jul 2024 19:23:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q13a8vtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 19:23:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46UGvBOa029094; Tue, 30 Jul 2024 19:23:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm0punk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 19:23:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46UJNYAC51839344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jul 2024 19:23:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B431F2004E;
 Tue, 30 Jul 2024 19:23:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75DE320040;
 Tue, 30 Jul 2024 19:23:32 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.195.42.9]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jul 2024 19:23:32 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v6 2/5] target/ppc: Introduce
 'PowerPCCPUClass::spapr_logical_pvr'
Date: Wed, 31 Jul 2024 00:53:22 +0530
Message-ID: <20240730192325.669771-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730192325.669771-1-adityag@linux.ibm.com>
References: <20240730192325.669771-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4OY11AtWUG836KPEPbhtNeAa3O5ypq1K
X-Proofpoint-GUID: lbrLz2yc5wMiwJT96ucKt_Dv6scgh3WS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_15,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Introduce 'PnvChipClass::spapr_logical_pvr' to know corresponding logical
PVR of a PowerPC CPU.
This helps to have a one-to-one mapping between PVR and logical PVR for
a CPU, and used in a later commit to handle cases where PCR of two
generations of Power chip is same, which causes regressions with
compat-mode.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 321ed2da75b7..752e11204b35 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1482,6 +1482,7 @@ struct PowerPCCPUClass {
     void (*parent_parse_features)(const char *type, char *str, Error **errp);
 
     uint32_t pvr;
+    uint32_t spapr_logical_pvr;
     /*
      * If @best is false, match if pcc is in the family of pvr
      * Else match only if pcc is the best match for pvr in this family.
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 4c7368cfaeb5..c5cd4133ea2f 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6154,6 +6154,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER7";
     dc->desc = "POWER7";
+    pcc->spapr_logical_pvr = CPU_POWERPC_LOGICAL_2_06_PLUS;
     pcc->pvr_match = ppc_pvr_match_power7;
     pcc->pcr_mask = PCR_VEC_DIS | PCR_VSX_DIS | PCR_COMPAT_2_05;
     pcc->pcr_supported = PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
@@ -6317,6 +6318,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER8";
     dc->desc = "POWER8";
+    pcc->spapr_logical_pvr = CPU_POWERPC_LOGICAL_2_07;
     pcc->pvr_match = ppc_pvr_match_power8;
     pcc->pcr_mask = PCR_TM_DIS | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->pcr_supported = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
@@ -6510,6 +6512,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER9";
     dc->desc = "POWER9";
+    pcc->spapr_logical_pvr = CPU_POWERPC_LOGICAL_3_00;
     pcc->pvr_match = ppc_pvr_match_power9;
     pcc->pcr_mask = PPC_PCR_MASK_POWER9;
     pcc->pcr_supported = PPC_PCR_SUPPORTED_POWER9;
@@ -6644,6 +6647,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER10";
     dc->desc = "POWER10";
+    pcc->spapr_logical_pvr = CPU_POWERPC_LOGICAL_3_10;
     pcc->pvr_match = ppc_pvr_match_power10;
     pcc->pcr_mask = PPC_PCR_MASK_POWER10;
     pcc->pcr_supported = PPC_PCR_SUPPORTED_POWER10;
-- 
2.45.2


