Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20199CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAc-0008HD-FH; Wed, 30 Sep 2026 11:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAX-00089x-DI; Wed, 30 Sep 2026 11:24:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAV-0001zB-8y; Wed, 30 Sep 2026 11:24:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5Qhf1932724; Wed, 30 Sep 2026 15:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HFyJXEbp2yaL+lYzt
 ZKDi+2mf0MpDuNKqlCgIbTDzv8=; b=PP4sVK7kG+W7FQ6j2F14IM1hNjnDmCZ6w
 9mqfV8KBvcUAQT32I6ujxkNTHPQAT5tLP8gLjK5Adf1llT2tIkrbvdJRMAvQ4q8+
 5a/2Dd8Nxzk8HR4oyGsBYMYU0dVLP6BU3005AClkO0BGt48wU2yaOsdFch8I5Oxo
 GLurqRs8t5AMKvD1eeJeCVCungHZHNF1GDL069iEUCsx4B9F3M0qKGuMPHJRSqEQ
 n7JcqOePR+xoXkfL72LUR0tSGlSv0MhccggMGMEBtC1dLZuJUCDW+9LOHr5rpQrE
 0vMYmGynD7qhAOMFbD6PG20d1S4Pgf9BxkoJvbkqhh5x2EZ4NAa4g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fecyeh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE38BM2287793; Wed, 30 Sep 2026 15:24:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pb3j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOOmG29491748
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECE4A5805F;
 Wed, 30 Sep 2026 15:24:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 610D75805E;
 Wed, 30 Sep 2026 15:24:23 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:23 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PULL 04/23] vfio/ap: Clear error object pointer after non-fatal
 errors
Date: Wed, 30 Sep 2026 11:24:01 -0400
Message-ID: <20260930152420.1956230-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abd29a9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=rlruftgHjx7kiOjKd_sA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX8WALSVPtAFcL
 hzEVIsx9TeuAJvNb6NtK0vIUQYLjQD32hC6JsfgO0A0altOEuhH8sRGCUPCQ3zo3PC3cZ+SXSnC
 3/lR0fEodnaLU2mQ4xLtdx+sLpzvfmk=
X-Proofpoint-ORIG-GUID: aTJEh0NAQGlwQ6xITKbUToVfUAJFDZgB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfXyB3V4n6IzLz5
 cXGAy1Zv1N2r+h4Krq5qk7M+cNB5eJqgd+QMnLYqF/ZasYY4WGX2nZfuMWk0LryNtg4/CjG3a0N
 bojwoUvK7CdnQu4dI+W9z9OT6YwY/P45J/oVm9L+Dm00BXbQiYS44GJI7Lm43QijxXMsvEGnXLq
 Gl2SBca9CTOeyUZRouFZ79xdvsMkC9PILGuuEuFmFwxzhpewgfVX0KLvDduttav/GkEayOzkBwL
 Dry+nV/16SHp14K38qKprF1NNrUx7jfvC0hnCbiV4MlPaERU7FgP2nkRFT0R5fjtV5uXDQCdxSQ
 5FSRa+8fgehqrS5FXEdZ4EVixTVEid90Pz6VvNP3WkMPoZp8Kq333adk93OzgaV+eHSTo01EVgs
 ym01gDKSYldCz7ylyuXY1BMUotlTI3+53ZA3fHoL+pmrcUVL2IH3JQ1ict4nNxxjVtjgKV5c4R7
 DLMxbhwRXOqPAC3r0pg==
X-Proofpoint-GUID: aTJEh0NAQGlwQ6xITKbUToVfUAJFDZgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Registering a new IRQ notifier will allocate an error object if needed,
and warn_report_err() will release that memory once it's finished.
The pointer remains, however, so subsequent errors after the non-fatal
errors in vfio_ap_realize() would cause an assertion failure for a
non-NULL pointer.

Fix this by clearing the pointer once the warning has been reported,
to reset the state of the error objects.

Cc: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: qemu-stable@nongnu.org
Fixes: 1360b2ad1f ("s390x/ap: Wire up the device request notifier interface")
Fixes: 0fb8a62fe4 ("hw/vfio/ap: notification handler for AP config changed event")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-5-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/vfio/ap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 6e2a1223ea..2926e04ad4 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -247,8 +247,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         /*
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operation.
+         * Clear the pointer, since the warning will release it.
          */
         warn_report_err(err);
+        err = NULL;
     }
 
     if (!vfio_ap_register_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX, &err))
@@ -256,8 +258,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         /*
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operation.
+         * Clear the pointer, since the warning will release it.
          */
         warn_report_err(err);
+        err = NULL;
     }
 
     return;
-- 
2.55.0


