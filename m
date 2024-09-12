Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF8AEE6452
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodgn-0003Aq-0J; Thu, 12 Sep 2024 02:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sodgk-00039m-GS; Thu, 12 Sep 2024 02:52:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sodgi-0003K2-Ea; Thu, 12 Sep 2024 02:52:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C4YLbK013986;
 Thu, 12 Sep 2024 06:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=YGtV8ueEtC9ssWq9VH/Yd2qSia
 PyYqo1EXcB7B24l+8=; b=oM956HJ0Pj6YPvsPSMPbX5Zb1OHE4tB3+/RywKMhOy
 GEE7/itMMmSBxFYKmcW7tZOHoBDp2RPAwDBzRk/EgamqaPKQxvOoyLxruX2Q+5tv
 S6sW6aMEKGELEVQGhjCWwR+vAXFPW9p7s8F7GNtIlXOmZC5yitpIo4L6RZu6FZUl
 B+3wzb1y+YqmyMhLbFBPjjRg7ny9NPPWjU7tsxJZ3HXZv/KyqkGW1Kw0bw90AAvG
 mC+DFbd/lTJMltDOWN+JN3Xa42Sbp/lo7Qqc1rB9MLmdMTRkixE3R1fHSVD7FvRE
 DKZl46tgy0yF9FfyxQzQAQcG7bWH478LC9PjWCLAO0EA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qj3rn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 06:52:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48C6qH0f016621;
 Thu, 12 Sep 2024 06:52:17 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qj3rm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 06:52:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48C3UIar027308;
 Thu, 12 Sep 2024 06:52:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3v3dvqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 06:52:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48C6qC9p49807620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 06:52:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5F992004B;
 Thu, 12 Sep 2024 06:52:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24F8E20040;
 Thu, 12 Sep 2024 06:52:11 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.38]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 06:52:10 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [RFC PATCH] ppc/spapr: Change printf format to %HWADDR_PRId for
 MIN_RMA_SLOF
Date: Thu, 12 Sep 2024 12:22:07 +0530
Message-ID: <20240912065207.508808-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: seTXPsSa13aeGRrUsA-zoR4eEIM39HSB
X-Proofpoint-ORIG-GUID: QAerPMoKDfdEikukXvoZy90BmxueD1vF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 mlxlogscore=569 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120045
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

Currently starting a pSeries machine, with lesser than 128MiB shows
below error:

    qemu-system-ppc64: pSeries SLOF firmware requires >= 80ldMiB guest RMA (Real Mode Area memory)

Above '80ldMib' is in hex, and it means 0x80 MiB = 128 MiB.

Change format specifier for this value to use 'HWADDR_PRId', instead of
'HWADDR_PRIx' thus showing decimal value instead of hex.

Thus, change the message to below error:

    qemu-system-ppc64: pSeries SLOF firmware requires >= 128MiB guest RMA (Real Mode Area memory)

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

---
This is an RFC, as it confused me why does QEMU print that error even with '-m' >80 MB.

This patch can also be considered a personal preference to see it as a decimal value instead of hex.

Or maybe we can have '0x80 MiB' instead ?

Does the 'ldMiB' actually mean that the value is in hexadecimal ? I did not find a reason in git history.
---
---
 hw/ppc/spapr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8aa3ce7449be..b2ddacc6dd01 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2819,8 +2819,8 @@ static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
 
     if (rma_size < MIN_RMA_SLOF) {
         error_setg(errp,
-                   "pSeries SLOF firmware requires >= %" HWADDR_PRIx
-                   "ldMiB guest RMA (Real Mode Area memory)",
+                   "pSeries SLOF firmware requires >= %" HWADDR_PRId
+                   "MiB guest RMA (Real Mode Area memory)",
                    MIN_RMA_SLOF / MiB);
         return 0;
     }
-- 
2.46.0


