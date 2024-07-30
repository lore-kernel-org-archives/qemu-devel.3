Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C31DC52D1D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 19:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYsS2-0002m7-FF; Tue, 30 Jul 2024 15:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sYsRu-0002Nj-Bp; Tue, 30 Jul 2024 15:23:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sYsRs-0002HS-Ld; Tue, 30 Jul 2024 15:23:54 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UISUjR004647;
 Tue, 30 Jul 2024 19:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 NdE/Fyel2C7AFtVEeKtdExqkuy8FZQ5dd9vlztjZABc=; b=CLdJcxqWEpizOnDw
 qme2wXj9uGqJY1yD77x1/y9izrfmg+A1g0azJq8eyatKHwZ1mENm1SPmCoXbQdSz
 VBi/R06doHJNhztAJSdMDpby2FtDTLXBK5m2Dm1ODpzum7cK6pA69CmCdvF9cF2r
 kKFNAt5q/TN6YdXuguTWT0NlEQ3r3lLyhtQ3YTAX821nzJBGMXgC4XAg6nkom9QS
 pH0Of5eK0j0Mz0+PHrpVWQOHfn5H+G69FdEqstI0MoGRtAJ594+MvuxOaRsmHiWQ
 Sx1KtiifjSnfqbCvY7k/k0C/0quuVOdb3TvsHkk9hXL+w860hztXERNnJkGfivTw
 dze/zQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q5fx03h7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 19:23:44 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46UJNhM5032211;
 Tue, 30 Jul 2024 19:23:43 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q5fx03h6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 19:23:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46UGU54k007479; Tue, 30 Jul 2024 19:23:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7u6w7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 19:23:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46UJNbV253936570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jul 2024 19:23:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AD4520043;
 Tue, 30 Jul 2024 19:23:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 239F920040;
 Tue, 30 Jul 2024 19:23:35 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.195.42.9]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jul 2024 19:23:34 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v6 3/5] target/ppc: Fix regression due to Power10 and Power11
 having same PCR
Date: Wed, 31 Jul 2024 00:53:23 +0530
Message-ID: <20240730192325.669771-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730192325.669771-1-adityag@linux.ibm.com>
References: <20240730192325.669771-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LXPk5SEM5aCvgVVHrJvpAWWbpnsoN_03
X-Proofpoint-ORIG-GUID: ST9M8qMuPDfxoSCywy470HbwJxkhGMgr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_15,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 mlxlogscore=909 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 target/ppc/compat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index ebef2cccecf3..5b20fd7ef04c 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -132,6 +132,10 @@ static bool pcc_compat(PowerPCCPUClass *pcc, uint32_t compat_pvr,
         /* Outside specified range */
         return false;
     }
+    if (compat->pvr > pcc->spapr_logical_pvr) {
+        /* Older CPU cannot support a newer processor's compat mode */
+        return false;
+    }
     if (!(pcc->pcr_supported & compat->pcr_level)) {
         /* Not supported by this CPU */
         return false;
-- 
2.45.2


