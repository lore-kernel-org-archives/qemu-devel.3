Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0E5C369D7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 05:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8BYV-0000BQ-RJ; Fri, 25 Apr 2025 01:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u8BXq-0008Ts-Eh; Fri, 25 Apr 2025 01:24:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u8BXn-0004H7-7a; Fri, 25 Apr 2025 01:24:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OL3F60032755;
 Fri, 25 Apr 2025 05:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=A9tYf/hlI0C0sQG2X
 K3eKBOEwumeCDovfTCRQi92Qxk=; b=BO5St0V8BUSqmQvwxJZQ4ymkMlSBAWvlC
 /eNStW4c8/aCrmuUzBPtuZ196baPfJODHoYdgj7ytJHKpVRydLFQh2kszIxyooBM
 MQ2ICNzr3P4pED94rKFdGZE7qYw92u90yJ1rUDnMR7rSyBn98cBoDMmFJWjC8AfD
 ml/By5FaWAJqjmspEz3Tj3kGQxAgmbsRFHmAJCMouh3Ou04mCeqvNeNC2B9TMb1n
 x9SkADpycVgLp9i41TxLuxu/r/ZMfHnS/YljBGQpEAaqMMiIMzgV4lF06ADzWY8c
 w3WUgEQb0/aelO4QRPktujodNHXuAQ/XdOck5In0V13ReXcbKxCdQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467vvksjq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 05:24:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53P3jBcV022293;
 Fri, 25 Apr 2025 05:24:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxkr0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 05:24:07 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53P5O3kx31654548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 05:24:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 752D05805A;
 Fri, 25 Apr 2025 05:24:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B230A58060;
 Fri, 25 Apr 2025 05:24:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.76])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Apr 2025 05:24:04 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [PATCH v7 3/6] hw/vfio/ap: notification handler for AP config changed
 event
Date: Fri, 25 Apr 2025 01:23:58 -0400
Message-ID: <20250425052401.8287-4-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250425052401.8287-1-rreyes@linux.ibm.com>
References: <20250425052401.8287-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAzNSBTYWx0ZWRfX9KKi91DS7bEd
 obAGdnfoGeqAcXvb43Z8RMdh5XfHpWOwC8wHZ+zlxkrBHj7C5bbg2oHF6INzWMdsI2wEnvXo+GS
 mR/HFwGvKCB/AgC/qOtfbi35BYJauCyO23XZg2cpUYpDnVGLTiyDfH575h7pUi5yiI9nI8h49vL
 U6D2c4F+nbjBkFqARQh2UG5oSsfvH43dxYYTmgEd8/xR6dlaFtHjPRV13FxbLHyYGF9il3ykhfr
 SvWtULUz0LlHl+j417FyWo8HbEFJXo4s7JSDRsES36lEZyZwujDHE9veJctghHWo+DCjyKEH3k8
 1ilf58jqxC8wLnQYTFYigjh8Mv+mPufqyUeFofH+fSQANxJJIQr0TN1h0uZ8gfe4DTwQVUbvqkE
 e5aWqd3VctxtCQrv22ApkwRyhf0pBQh8/M89sZrAtvMSzL6arUKSsGb7sdFQJssa3h94uvlw
X-Proofpoint-ORIG-GUID: iTiqNH6o30kitbGLkejD9JTi9yR0v3oa
X-Proofpoint-GUID: iTiqNH6o30kitbGLkejD9JTi9yR0v3oa
X-Authority-Analysis: v=2.4 cv=HoF2G1TS c=1 sm=1 tr=0 ts=680b1c78 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=XR8D0OoHHMoA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8 a=cI7fhctStQOMI3-b00QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250035
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Register an event notifier handler to process AP configuration
change events by queuing the event and generating a CRW to let
the guest know its AP configuration has changed

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 hw/vfio/ap.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index d6575d7c44..fcb07ef486 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -18,6 +18,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "system/iommufd.h"
 #include "hw/s390x/ap-device.h"
+#include "hw/s390x/css.h"
 #include "qemu/error-report.h"
 #include "qemu/event_notifier.h"
 #include "qemu/main-loop.h"
@@ -37,6 +38,7 @@ struct VFIOAPDevice {
     APDevice apdev;
     VFIODevice vdev;
     EventNotifier req_notifier;
+    EventNotifier cfg_notifier;
 };
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
@@ -70,6 +72,18 @@ static void vfio_ap_req_notifier_handler(void *opaque)
     }
 }
 
+static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
+{
+    VFIOAPDevice *vapdev = opaque;
+
+    if (!event_notifier_test_and_clear(&vapdev->cfg_notifier)) {
+        return;
+    }
+
+    css_generate_css_crws(0);
+
+}
+
 static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                           unsigned int irq, Error **errp)
 {
@@ -85,6 +99,10 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
         notifier = &vapdev->req_notifier;
         fd_read = vfio_ap_req_notifier_handler;
         break;
+    case VFIO_AP_CFG_CHG_IRQ_INDEX:
+        notifier = &vapdev->cfg_notifier;
+        fd_read = vfio_ap_cfg_chg_notifier_handler;
+        break;
     default:
         error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
         return false;
@@ -136,6 +154,9 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
     case VFIO_AP_REQ_IRQ_INDEX:
         notifier = &vapdev->req_notifier;
         break;
+    case VFIO_AP_CFG_CHG_IRQ_INDEX:
+        notifier = &vapdev->cfg_notifier;
+        break;
     default:
         error_report("vfio: Unsupported device irq(%d)", irq);
         return;
@@ -175,6 +196,15 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         warn_report_err(err);
     }
 
+    if (!vfio_ap_register_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX, &err))
+    {
+        /*
+         * Report this error, but do not make it a failing condition.
+         * Lack of this IRQ in the host does not prevent normal operation.
+         */
+        warn_report_err(err);
+    }
+
     return;
 
 error:
@@ -187,6 +217,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
 
     vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
+    vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX);
     vfio_detach_device(&vapdev->vdev);
     g_free(vapdev->vdev.name);
 }
-- 
2.48.1


