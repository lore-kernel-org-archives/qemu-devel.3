Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE9BC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvv3s-0008Mc-BG; Mon, 17 Aug 2026 06:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wvv3i-0008J7-L8; Mon, 17 Aug 2026 06:59:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wvv3g-0006cm-Ue; Mon, 17 Aug 2026 06:59:14 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9qLCb3727949; Mon, 17 Aug 2026 10:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=l2CGPw3G4c7ghCHnSIskkOQcSuNH4mJi+htyyL/o2
 38=; b=f7Y+TiGkUfY8OHj/fHC+AXD3qGeQvoZWSIFfxz6+06N49EPs3Z3QnRqEe
 ZzeQGfawR9LsRkd6rWM0ZZw9lVAWLaW/+RpGBa9ptGaPUFwknTUlWQg6KMGEq5X6
 SQDmUNaIfdwkLk4JOOb628zxsOOyxySECEnBDv8yBYDSxeF5j3dEnNvAJ44zM3Xw
 8LJL7SaGEt7THfrgi+v1ZY+zIesb3qQgfFsBaVsYihplcQRLZQRGxu2b16rnr0qj
 cqetPZ1uDZVGqJ7V3UnEql3bNycJENjl3vKOVUoChQn7xy5PrfbafmdmYgBXwJYD
 eyHOPPxgb4IGru+Ccxelvqu0wMX+A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4hurq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:59:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HAuI3G002929;
 Mon, 17 Aug 2026 10:59:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng5gxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:59:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HAx4n036045292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 10:59:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AD862004B;
 Mon, 17 Aug 2026 10:59:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCA6020040;
 Mon, 17 Aug 2026 10:59:01 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.52]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 10:59:01 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, aik@ozlabs.ru,
 amachhiw@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH] target/ppc: Add lower bound check for watchdogNumber
Date: Mon, 17 Aug 2026 16:28:54 +0530
Message-ID: <20260817105854.437724-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 9XQCjn7HCt5CMkhNCGrN0AffPBFktJBp
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a82e97d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8
 a=Mx9oKPrOMzdSx9n7BPAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA3OCBTYWx0ZWRfXxRhkIwdGg6Ii
 Gu63nf4CZeF0HiLX5jREpyuLnU2/8dF3QADHc2iT0xHf5plSlo3H7pD1EaoDe4HfOBMto5jZQ8z
 FyJDGnNLj+av2I0vRUl94tigiabKsHs=
X-Proofpoint-ORIG-GUID: GLDDIkUj753cm9V4nizqhWWGByVNHEZA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA3OCBTYWx0ZWRfX6Zcc7ktrJ4q4
 4GXk4p1Jy1CPBUlYP3SUMrQujLCMXVylurX6ybZbMZda7bt7wKuFd2FeqX2lBWy6G6sShOb87xn
 rONoMeJeVU6NGcU+1ptGCs68+9Z79smJpE4qd6ooPkpLnJ5q6+Iyw+Q5GWsOB1nwktjaS4IrPOr
 o1OVdtYLNaR5dOOdVwsImdBF1Ik2kdL7c1PeH9OD7LCRlmjx9+Uqb8F7MxCr/5Vu+MOoY7DoiTC
 JRV34fjtWghiZ2avnwEFWs4qxFAx/lfDAu9tFkgTXO/h8CeNr9h4z3GONPIC2cjiXWNzvQltO96
 mKOn0Cj/Cqso7UqERb6F5cpMiiyfskribIowG7+9CJCNeCJ46+L3tZfMcsHbawd4qC6LDulrQp7
 svw3/svbGosdITb60KLwYrPcWugXaNbyyTWkTJMCiqN7RZf+c4nTRS3Z2sPqLYirPliyvz9ypY8
 BsqjFgjPU1lY6FeAuMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170078
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add missing lower bound check for H_WATCHDOG H_CALL's watchdogNumber parameter
as per PAPR documentation ver 12.10.00 section 14.15.5 'H_WATCHDOG'.

Closes : https://gitlab.com/qemu-project/qemu/-/work_items/3600

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 hw/watchdog/spapr_watchdog.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
index 5b3f50de3a..5d7478e833 100644
--- a/hw/watchdog/spapr_watchdog.c
+++ b/hw/watchdog/spapr_watchdog.c
@@ -145,7 +145,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
 
     switch (operation) {
     case PSERIES_WDTF_OP_START:
-        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
+        if (watchdogNumber < 1 || watchdogNumber > ARRAY_SIZE(spapr->wds)) {
             return H_P2;
         }
         if (timeoutInMs <= WDT_MIN_TIMEOUT) {
@@ -170,7 +170,8 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
     case PSERIES_WDTF_OP_STOP:
         if (watchdogNumber == PSERIES_WDT_STOP_ALL) {
             ret = watchdog_stop_all(spapr);
-        } else if (watchdogNumber <= ARRAY_SIZE(spapr->wds)) {
+        } else if (watchdogNumber > 0 &&
+                   watchdogNumber <= ARRAY_SIZE(spapr->wds)) {
             ret = watchdog_stop(watchdogNumber,
                                 &spapr->wds[watchdogNumber - 1]);
         } else {
@@ -184,7 +185,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
         trace_spapr_watchdog_query(args[0]);
         break;
     case PSERIES_WDTF_OP_QUERY_LPM:
-        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
+        if (watchdogNumber < 1 || watchdogNumber > ARRAY_SIZE(spapr->wds)) {
             return H_P2;
         }
         args[0] = PSERIES_WDTQL_QUERY_NOT_STOPPED;
-- 
2.55.0


