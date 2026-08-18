Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24232C5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwFq9-0007me-H9; Tue, 18 Aug 2026 05:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwFq7-0007lz-P3; Tue, 18 Aug 2026 05:10:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwFq5-0008Kc-Eb; Tue, 18 Aug 2026 05:10:35 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HM1ioO759187; Tue, 18 Aug 2026 09:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=qMTZ9DUSzhvHGl6fglwoEvW9q1sLDiiYJ02rnS0fb
 Os=; b=fwIEQBgwKvaS02qc4F/dDMHLNHFzAelGAqnGgFPCU0/rCZpCkaRteHiJj
 p8w2+tvb3dv9A/Sn/aUxpwgBE2vgxN/iu0hGH8W5F1u5epHeDYDwQ5aF7Gp2algh
 EIZgINK7iNYH9kduz0+gmM5xWontLjzKbeAfSuYwr18CQxtPXdarDNa5BEkUBQs6
 P7hsvvSbNTmWDIQ/ye0iFmCHXqQDc0RnJTq8H34tueE3eYu0/q5YPzy4KAPTSRf3
 LSNtlTRHD46N8lD8/keekguFhi3/Vybja5IsEM33rv0R2EKJkAJenyJoDwXObwmU
 xhHXG1EGTppzhJhPBNwdYnBRJq3Yg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqq67u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 09:10:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I8uLfT015175;
 Tue, 18 Aug 2026 09:10:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw2g9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 09:10:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67I9ANfh41943452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 09:10:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B2CE2006A;
 Tue, 18 Aug 2026 09:10:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA0D32004D;
 Tue, 18 Aug 2026 09:10:21 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.bl1-in.ibm.com (unknown
 [9.123.8.229]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 09:10:21 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, aik@ozlabs.ru,
 amachhiw@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2] target/ppc: Add lower bound check for watchdogNumber
Date: Tue, 18 Aug 2026 14:40:19 +0530
Message-ID: <20260818091019.51350-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2NiBTYWx0ZWRfX/hMJ5z7IEb3E
 7wcLAYb1/XEkD9ad/wuEIHEQx1Rc4ReGv1pZ6lIDqgrtx685SsqivxPEIVcfWSnwof0xmCPJl8h
 +vz5uDowctkHOt1YL2sT2x8lIknnpjI3qJgHni1paLMfFQMPFfZDXLk3KC6xhfzjcK8q4OZcnqb
 s0NkjxTy6aMrs7duKvqmODyXWN/qnviT2lOXDFiI+y31rFosaOJ6DbnJhZ2mQ9tw8tZbjJ2+lDX
 pM/xhcRPGhvQMMi3pU5f/0BVH7m3IAkB+I9d06ps7d+eUpsIGW9epyTrkIQ9qfllkjfvcxRFlkp
 dZGESPorMsgb5YO+hqmkVcQ/2/fiIl6uWy1V+OtXLOlpu74GD8gyaFQgjWKXRG7Bb8mgx4icG16
 Kw1sCBCfUCBNV9/tBmb43qL9QkFmV2SG2FGAvePDsZUvvk4KNWCfIZxTPw0mnobWRX/7vEDbPna
 A162QLDsdr2RZ/KGkAA==
X-Proofpoint-ORIG-GUID: kqYaB1ZCusK1zop-x0aBLgGTjLu6QDjl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2NiBTYWx0ZWRfX2h5uIe/9dlzr
 NGEI6EIfI+RhRZOdDJ5bTEMhGGHXUH2QcjDHS7UNiTAHq6EuKY9pEkGG9XRa59ijNdej4kJdGK2
 hITy6LJ1oh5zdKcOieAEx51CFiFwPyE=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a842187 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=j_FQD6ciWsqbTIv_aGcA:9
X-Proofpoint-GUID: 3vTMbme2kCT4MQfGsqDd-9ISgsGZ_EbX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180066
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
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---

Changes from v1 : Incorporated changes suggested by Amit.
v1 : https://lore.kernel.org/qemu-devel/20260817105854.437724-1-rathc@linux.ibm.com/

 hw/watchdog/spapr_watchdog.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
index 5b3f50de3a..460b4457a6 100644
--- a/hw/watchdog/spapr_watchdog.c
+++ b/hw/watchdog/spapr_watchdog.c
@@ -127,6 +127,12 @@ static void watchdog_expired(void *pw)
     }
 }
 
+static inline bool watchdogNumber_valid(target_ulong watchdogNumber,
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
+        if (!watchdogNumber_valid(watchdogNumber, spapr)) {
             return H_P2;
         }
         if (timeoutInMs <= WDT_MIN_TIMEOUT) {
@@ -170,11 +176,11 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
     case PSERIES_WDTF_OP_STOP:
         if (watchdogNumber == PSERIES_WDT_STOP_ALL) {
             ret = watchdog_stop_all(spapr);
-        } else if (watchdogNumber <= ARRAY_SIZE(spapr->wds)) {
+        } else if (!watchdogNumber_valid(watchdogNumber, spapr)) {
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
+        if (!watchdogNumber_valid(watchdogNumber, spapr)) {
             return H_P2;
         }
         args[0] = PSERIES_WDTQL_QUERY_NOT_STOPPED;
-- 
2.55.0


