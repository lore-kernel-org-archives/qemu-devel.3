Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A12C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFC3c-0008EB-QA; Thu, 06 Jun 2024 08:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sFC3a-0008C3-5K; Thu, 06 Jun 2024 08:17:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sFC3Y-0006EK-Aw; Thu, 06 Jun 2024 08:17:25 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 456CCSZQ024749; Thu, 6 Jun 2024 12:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=h6VHakey/41eoMID9x1GF+gfi2vVsl+KAyfGGnlm/fw=;
 b=iIXwP883VigMmLr//zRMcK/0fXFV9111DucnE5563TWgN/pZMMmsN6lJZe4rUq0TdzgT
 WgJaCCBQ72aQ4+kLtYldleKIG2FPsUvq66eQJF/eXTmPMN7V9hqZvOgWdYIW+zZi1C7q
 S0Fq35nWzbWeJI1pMXi+JdxYF79X9hch+nKjX77HDAwTVqXPMWqJP9YAJmSr/dVRMh4r
 UCB0VNfaRhC0Dk6prgpEpL8HRGRUGLtJvGlEewyqDxG64MOuNihfWZHUzjOjpYf9NnBu
 IFMu8XkfWS/ULFfS3DWhQEgF8zpnvZ9YVb2unr/w6tVkIxJ+odFpnhN1YyD1PoZRfntz wg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykcwj00ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:17:20 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456CHJ88001258;
 Thu, 6 Jun 2024 12:17:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykcwj00ea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:17:19 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 456CA6pB008517; Thu, 6 Jun 2024 12:17:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygec12n63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:17:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 456CHCxP52035908
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Jun 2024 12:17:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8772A2004B;
 Thu,  6 Jun 2024 12:17:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD3FE20040;
 Thu,  6 Jun 2024 12:17:10 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Jun 2024 12:17:10 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v5 5/5] target/ppc: Fix regression due to Power10 and Power11
 having same PCR
Date: Thu,  6 Jun 2024 17:46:57 +0530
Message-ID: <20240606121657.254308-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606121657.254308-1-adityag@linux.ibm.com>
References: <20240606121657.254308-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AjQWrj9Rpqfj1Avuo6WORNhxMb2v9vvy
X-Proofpoint-ORIG-GUID: MU3k9KJD9dIb87hgU2Mkt8djb_OU3NQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=884 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Power11 has the same PCR (Processor Compatibility Register) value, as
Power10.

Due to this, QEMU considers Power11 as a valid compat-mode for Power10,
ie. earlier it was possible to run QEMU with '-M pseries,max-compat-mode=power11 --cpu power10'

Same PCR also introduced a regression where `-M pseries --cpu power10`
boots as Power11 (ie. logical PVR is of Power11, even though PVR is Power10).
The regression was due to 'do_client_architecture_support' checking for
valid compat modes and finding Power11 to be a valid compat mode for
Power10 (it happens even without passing 'max-compat-mode' explicitly).

Fix compat-mode issue and regression, by ensuring a future Power
processor (with a higher logical_pvr value, eg. P11) cannot be valid
compat-mode for an older Power processor (eg. P10)

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 target/ppc/compat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 12dd8ae290ca..168a3c06316f 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -139,6 +139,10 @@ static bool pcc_compat(PowerPCCPUClass *pcc, uint32_t compat_pvr,
         /* Outside specified range */
         return false;
     }
+    if (compat->pvr > pcc->logical_pvr) {
+        /* Older CPU cannot support a newer processor's compat mode */
+        return false;
+    }
     if (!(pcc->pcr_supported & compat->pcr_level)) {
         /* Not supported by this CPU */
         return false;
-- 
2.45.1


