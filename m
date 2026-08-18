Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8719C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHKZ-00051N-P0; Tue, 18 Aug 2026 06:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwHKY-00051B-GI; Tue, 18 Aug 2026 06:46:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwHKW-0000xf-J2; Tue, 18 Aug 2026 06:46:06 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IAVZUi028653; Tue, 18 Aug 2026 10:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=iujDh1jPpsU3nVd/eEjRWulWXKcloNEMfSfRtASc0
 9o=; b=SqENSvRkU/J8vQ6IclgDxot7IkOK/cg0JfInwsuCQO6/gWBkfOh0UglvY
 fb+Xq8M41+ziev5g3Jeg8zsKyVP+m647im6Zk8ezbnuVNSyukgdf5+v0os7TRq+R
 PpNX9sePouf+UkD5k9JzpEFyK++CGz0b4+yrY2/VmN280hjh/RifF9TT+yLDU61j
 pPWsN66BOCKLZpaBbuIeqokSu3HnqOHL9izWqGYSt1LKSlkQjRAgeTcnaluQz2U8
 pG1tsU5PxJDILD2ocqXIDo1ABNOyY16KcBanRtO8yS3qMUxXCRNPpbe6dnX4c2ac
 +2Ryivq9W4IydHGSXNSuDM3yDLJUQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4qnm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 10:46:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IAfLTr014991;
 Tue, 18 Aug 2026 10:46:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh2qq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 10:46:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IAjubN41287944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 10:45:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0347D20043;
 Tue, 18 Aug 2026 10:45:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81AD220040;
 Tue, 18 Aug 2026 10:45:54 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.bl1-in.ibm.com (unknown
 [9.123.8.229]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 10:45:54 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, aik@ozlabs.ru,
 amachhiw@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3] target/ppc: Add lower bound check for watchdogNumber
Date: Tue, 18 Aug 2026 16:15:51 +0530
Message-ID: <20260818104551.76023-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Sza_7LD35-r6LIty1aI6JgjxJ-wphIBc
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a8437e9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8
 a=j_FQD6ciWsqbTIv_aGcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3NyBTYWx0ZWRfXyhHpM8+96lpr
 WN10VIi8PM863FTkO+QJalNkV9LxezEu4tv0LNJVaB6L/gcg/GtneHks892lRYtizD/I44c/3ar
 yqboI8ZSmm3a8jEHdDJgPCKntPejd9s=
X-Proofpoint-ORIG-GUID: wchrQpOwk4u0jUymX0QVH4Ppi6_-bHeq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3NyBTYWx0ZWRfX0aQM4GpjfBeP
 LQz+YnkyFBR/kgBQ5RbAZEPO/v1WJV+2g8nU3uWLqPJGbqheJmFFQy4UfXy0DSXAvktly+f3sM6
 i6WMr4LTmZj1N7vJyc6zOpDrFSdO47jhT8IT6nDQiSdgL/WbFPt1mzCODen+t7a9d16inlIaESY
 zYnupC7YhucbZie4O4VZo+Y+J6S2QmyOOk26N/7+Ho9fPVAROsJ7srZzzP9fM5pzZYQlbTeDgix
 K93eIEkJrEeJALEsXYCclFVESYqgFQhxXri2wd480soNzKtkjNByeqFzUN+ZRHP1Vjde5fa5NGZ
 p79P8sxKuZi2NayBtO728JRxzOTZNLnIUF2eYDr9CtRyfO6vy4pEmxMGW0+Aq9iYqSSSrZFrn4P
 0xVgMJGxd4lunBkH0KUah/qejGkBV/6BdWfAwtJKRshIzw+3bcKgog8yW4NyU/QEcUikmKwE3BG
 WWOS7LXPdf3J3RMDnMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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

Add missing lower bound check for H_WATCHDOG H_CALL's watchdogNumber parameter
as per PAPR documentation ver 12.10.00 section 14.15.5 'H_WATCHDOG'.

Closes : https://gitlab.com/qemu-project/qemu/-/work_items/3600
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---

Changes from v2:
Renamed watchdogNumber_valid to watchdog_number_valid - Amit
Retained Amit's Reviewed-by

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
2.55.0


