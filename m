Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0184CF07A5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 05:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sym1v-0006OM-1f; Thu, 10 Oct 2024 01:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sym1s-0006F0-3O; Thu, 10 Oct 2024 01:48:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sym1q-0005b7-DY; Thu, 10 Oct 2024 01:48:03 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A4U5Eo009220;
 Thu, 10 Oct 2024 05:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=VO2fhRpGW50Xo
 xgcN3PSNxc45sbhCKrRXjeIou0fU0c=; b=cW7URSS9S/SyJbY2+km/LbPtg6yPZ
 1a0Hfq7Nbaq+8XCpW1x1gOPLvRpR4u53jpp6eBd7rNscdigvMdmaMlYQxyQVGt+f
 3yZ1P+aqIMoKdxCDMy17AnwEvb6k3xn3eAGYbyPASNqF91qeRTPEd6Ua6Ch+Tuc9
 xrjbNAPQ4xcOBLATB7X7sU2NzuYtv8WDVLM27RxBYee2666IFPaRYK2NCe/zAN8g
 zqa+I/1R5qqMVvQUu5LKttww6s1UpqWrfAizS30KD/pooafF1daMaJ/7J0AqBaYI
 EzuMyayPjUTbL0f5NDdPUUt9tLOMdyDyBnCZ6GHFUBR3JeitgH4N5mPPA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4267xk07uw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:59 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A5lxQU030472;
 Thu, 10 Oct 2024 05:47:59 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4267xk07ut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A32pZF022835;
 Thu, 10 Oct 2024 05:47:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg15m7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A5luR446203352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 05:47:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5CC620043;
 Thu, 10 Oct 2024 05:47:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCFA720040;
 Thu, 10 Oct 2024 05:47:55 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2024 05:47:55 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v4 8/9] target/ppc: combine multiple ail checks into one
Date: Thu, 10 Oct 2024 11:17:39 +0530
Message-ID: <20241010054740.1106997-9-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010054740.1106997-1-harshpb@linux.ibm.com>
References: <20241010054740.1106997-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yg1g6nMXtvTVqEML8RNomViXmmMF0wWQ
X-Proofpoint-ORIG-GUID: HZEvnTjulCldfBVP4czeS2j9mN3vn01k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_02,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=635 impostorscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100036
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

ppc_excp_apply_ail has multiple if-checks for ail which is un-necessary.
Combine them as appropriate.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/excp_helper.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 4eeeedff5b..a8bd537a18 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -324,10 +324,7 @@ static void ppc_excp_apply_ail(PowerPCCPU *cpu, int excp, target_ulong msr,
         }
 
         ail = (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
-        if (ail == 0) {
-            return;
-        }
-        if (ail == 1) {
+        if (ail == 0 || ail == 1) {
             /* AIL=1 is reserved, treat it like AIL=0 */
             return;
         }
@@ -351,10 +348,7 @@ static void ppc_excp_apply_ail(PowerPCCPU *cpu, int excp, target_ulong msr,
         } else {
             ail = (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
         }
-        if (ail == 0) {
-            return;
-        }
-        if (ail == 1 || ail == 2) {
+        if (ail == 0 || ail == 1 || ail == 2) {
             /* AIL=1 and AIL=2 are reserved, treat them like AIL=0 */
             return;
         }
-- 
2.45.2


