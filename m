Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DC7C5DF9A
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 07:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy2kQ-0002W2-GH; Sun, 23 Aug 2026 03:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy2kP-0002Vu-BF
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:36:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy2kN-0005pK-KF
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:36:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67N722IK2466996
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=PugpNVa6hPnBy+ufS
 +RaZdLPwhih40Y8LGYcAL6rz+s=; b=RyLud4Z5EYNOp+BW69Z7iFjl+rqfFE7Uq
 MCp2kKCbmZjB4hGIejC+4EhfC4YVk5l2GBhU8BtazuXsSLJ8Lt2C+ACigq6lV/Yv
 6PM1De4hf5U0uqDN+JcsbIwFA1fzBJ4hcoJiPQUIF5eh0adQJZ9xHbNzQnUVODkn
 kB8s2hS4DCRutq99KmlIXvNFTcCtTXADal7OrS7eYBbdvwk8kj3xbezOM6/8+69/
 9+Kq3CydAqLrxWSOOwUvod0bNT28uBzC8w2k07DdZJwn5WMLNMAIhbjk5RB8DG0g
 d0LaQ5p+zlFdfOAZWt9w6gU/vAhO/BrGG379ALBGpRCn6Ob/bVbeg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393m2j8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 07:36:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67N7QReM027450;
 Sun, 23 Aug 2026 07:36:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jgsc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 07:36:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67N7ZuKn25887020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Aug 2026 07:35:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EC5F20040;
 Sun, 23 Aug 2026 07:35:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7668B2004E;
 Sun, 23 Aug 2026 07:35:54 +0000 (GMT)
Received: from Mac.com (unknown [9.39.19.238])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 23 Aug 2026 07:35:54 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 huntr bubble <bubblehuntr@gmail.com>
Subject: [PULL 4/7] hw/watchdog: Add lower bound check for watchdogNumber
Date: Sun, 23 Aug 2026 13:05:30 +0530
Message-ID: <20260823073536.40282-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260823073536.40282-1-harshpb@linux.ibm.com>
References: <20260823073536.40282-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: N8GOPX3ysSJLTW58OAksdQldNyWnZSKz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDA2NiBTYWx0ZWRfX0HMiFuCZB0w+
 4O7jzk25IV12pxLRPt58RRJ7TGaVIDEyMP/Je70AucwTtwrgRVa/FFGm9aAUbx/sBlVuQ1pDri3
 tUJwcSWEu30YnTbtGjoclZF5wEY2YhfK08DUc+MEFmRHOFvLNWRcGRw6qQLCqsTKkGKWVglengt
 Dt9Q1giC587KQOJoMIkQ8r44yL31ehQFBJ0sRtqwvfOk8+SisRw1E2b9dG+tv3RUrPZO3A/qv9Q
 +xGfKmxeAeLkWk9fac5MgLs2CV44YZlB7V8ChaqYymQAY7qhH5aYPe+Q3kSNya6hl+ue8voofVS
 Ao2AlLI3eV1tuPUO1+Jmt9WL87xUct0XSAG+K78KmbcoBDB2Ci6/9RnvrLKNBnd6wPyXe4Oigxc
 AQl/i4/2/V0xG6UxK27j42IAPbcqD3INJs3n7l3RNmvAgGN3ES8M8Es6E8S2ajP2HZ5mlOaLGmh
 BjLRGaqbtB3SPcBzlEw==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8aa2e1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=j_FQD6ciWsqbTIv_aGcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDA2NiBTYWx0ZWRfXxUx5hq1pdqVe
 m4QUlv34AwCkBrHUHzC7aTaE0/GzvOo6J2/vQzdOzTgaBo2uqjTOVyueap3uWNQsiilTYwQ6nen
 nmwW3R6guLbgUJdwVxC88myHaNxfP7Q=
X-Proofpoint-ORIG-GUID: XOvYOjF8EvWOXdQxichedFEQplMQuE2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

Add missing lower bound check for H_WATCHDOG H_CALL's watchdogNumber parameter
as per PAPR documentation ver 12.10.00 section 14.15.5 'H_WATCHDOG'.

Closes : https://gitlab.com/qemu-project/qemu/-/work_items/3600

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reported-by: huntr bubble <bubblehuntr@gmail.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260818104551.76023-1-rathc@linux.ibm.com
[harshpb: corrected title prefix to hw/watchdog]
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/watchdog/spapr_watchdog.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
index 5b3f50de3a..5a72896066 100644
--- a/hw/watchdog/spapr_watchdog.c
+++ b/hw/watchdog/spapr_watchdog.c
@@ -127,6 +127,12 @@ static void watchdog_expired(void *pw)
     }
 }
 
+static inline bool watchdog_number_valid(target_ulong watchdogNumber,
+                                        SpaprMachineState *spapr)
+{
+    return watchdogNumber >= 1 && watchdogNumber <= ARRAY_SIZE(spapr->wds);
+}
+
 static target_ulong h_watchdog(PowerPCCPU *cpu,
                                SpaprMachineState *spapr,
                                target_ulong opcode, target_ulong *args)
@@ -145,7 +151,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
 
     switch (operation) {
     case PSERIES_WDTF_OP_START:
-        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
+        if (!watchdog_number_valid(watchdogNumber, spapr)) {
             return H_P2;
         }
         if (timeoutInMs <= WDT_MIN_TIMEOUT) {
@@ -170,11 +176,11 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
     case PSERIES_WDTF_OP_STOP:
         if (watchdogNumber == PSERIES_WDT_STOP_ALL) {
             ret = watchdog_stop_all(spapr);
-        } else if (watchdogNumber <= ARRAY_SIZE(spapr->wds)) {
+        } else if (!watchdog_number_valid(watchdogNumber, spapr)) {
+            return H_P2;
+        } else {
             ret = watchdog_stop(watchdogNumber,
                                 &spapr->wds[watchdogNumber - 1]);
-        } else {
-            return H_P2;
         }
         break;
     case PSERIES_WDTF_OP_QUERY:
@@ -184,7 +190,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
         trace_spapr_watchdog_query(args[0]);
         break;
     case PSERIES_WDTF_OP_QUERY_LPM:
-        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
+        if (!watchdog_number_valid(watchdogNumber, spapr)) {
             return H_P2;
         }
         args[0] = PSERIES_WDTQL_QUERY_NOT_STOPPED;
-- 
2.52.0


