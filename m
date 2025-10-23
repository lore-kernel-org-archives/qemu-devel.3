Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B89CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtkO-0001Hr-Ed; Thu, 23 Oct 2025 07:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkK-0001GU-7l
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkI-0001aA-GI
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:44 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9pGRG016406;
 Thu, 23 Oct 2025 11:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gumBZn
 sDL9HL0lcEHsF9XA4suBSXbHfK2Xn0Lw9jxU8=; b=Qo0r4Xron3ATegUF/iDRY5
 CVEVT6Gw88MpB7GE27Dj4QmVIHE9MHvQXEKrCbWzgaSjgvoPkdShPiIVYdewQHCg
 Z6Mi1UVFVQlN49XDcoZpDo323OyAafuIU9AE1af9Zwt6tZyf2zpM/7vkzh8UAoxN
 qhkya1pTrfS7pxBmw6WCmkrdhJrHd1GEyRFO/mFAIa5Ql1RjdCJIG7tgC0BOYEwC
 bIapKqG1L7m+dZXHt8o7QyQyyIi9eC5aZKzNCg++3gWsfaQXjE6dsbQ9RO8eJDFz
 8eFUZXJ9g2LPzNe3Qf/e0MtGDLDxvhQMCPN+6f/N+Zi85KFCcoDR70Dy2akybZvQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hrcnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9cOgq017066;
 Thu, 23 Oct 2025 11:44:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky5krv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBiZfV29557076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F47C20049;
 Thu, 23 Oct 2025 11:44:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DAEA20040;
 Thu, 23 Oct 2025 11:44:34 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:34 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 05/32] hw/ppc/spapr: Inline few SPAPR_IRQ_* uses
Date: Thu, 23 Oct 2025 17:13:52 +0530
Message-ID: <20251023114422.3675018-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXx/At+VwklSHC
 LOmWzPJhqDLEyvIPuCbQo27FiE3TosoSsIyuAV8IZJrLcKF6iwkGgrX40cP7dw6RBm//YQ9a41P
 THoM7JE88/LjQkPl8qS7wbuOQYjb3EFN7cMwGTQBvjF5F9cajFw5SbkI4FdDVEfflbsgmMXEKnl
 0utWsEnLKE3Pp2d4GTNvkRU1BvQbR/Eptsr4cfeakmxbFMGjWOKjauxt0QxRb5f5mvEomo6jQIs
 dufCgiWUJjrkIwWae999x93lQTdiXY4qqHV3HWxpn06omENtAbDQiRXh9zhQRMrBz97QnCbnobO
 MF3CYVHPE9ewsw4dK4ehFmRlTeiPMQaizq1RIceA91ATv8qGsKSbyC50cShxzxOFCGwPSS/4UkI
 PgSyETq0VlIsHorTC8GhqlvSrL33iw==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fa1528 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=FGj2XIL8PdlB0YAdb_sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: 0LpW3Eqi3yo943DM8HeY3uuNkWkMLCD0
X-Proofpoint-ORIG-GUID: 0LpW3Eqi3yo943DM8HeY3uuNkWkMLCD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20251021084346.73671-6-philmd@linaro.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_events.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 548a190ce8..892ddc7f8f 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -1041,16 +1041,14 @@ void spapr_clear_pending_hotplug_events(SpaprMachineState *spapr)
 
 void spapr_events_init(SpaprMachineState *spapr)
 {
-    int epow_irq = SPAPR_IRQ_EPOW;
-
-    spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
+    spapr_irq_claim(spapr, SPAPR_IRQ_EPOW, false, &error_fatal);
 
     QTAILQ_INIT(&spapr->pending_events);
 
     spapr->event_sources = spapr_event_sources_new();
 
     spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPOW,
-                                 epow_irq);
+                                 SPAPR_IRQ_EPOW);
 
     /* NOTE: if machine supports modern/dedicated hotplug event source,
      * we add it to the device-tree unconditionally. This means we may
@@ -1061,12 +1059,10 @@ void spapr_events_init(SpaprMachineState *spapr)
      * checking that it's enabled.
      */
     if (spapr->use_hotplug_event_source) {
-        int hp_irq = SPAPR_IRQ_HOTPLUG;
-
-        spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
+        spapr_irq_claim(spapr, SPAPR_IRQ_HOTPLUG, false, &error_fatal);
 
         spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_HOT_PLUG,
-                                     hp_irq);
+                                     SPAPR_IRQ_HOTPLUG);
     }
 
     spapr->epow_notifier.notify = spapr_powerdown_req;
-- 
2.43.5


