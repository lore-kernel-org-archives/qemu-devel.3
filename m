Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0ABC3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 04:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIKK7-0003ah-5U; Fri, 23 May 2025 00:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIKK3-0003ZP-Ty; Fri, 23 May 2025 00:47:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIKJw-0002Nu-R0; Fri, 23 May 2025 00:47:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MNWGbW004879;
 Fri, 23 May 2025 04:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/N3U4t3LiiReJXxka
 GTq63I6YAr4N0FuMqvFbBhGAy0=; b=Fs+EA7V3xxbqP0Bi2YOLAiBZjx4QQEIvB
 qu/3BXqiC76ll4bqXxgOCOa/ynQDVVK0kGZQx638/5LYNy26Cu1TUDW7h2VSHX/j
 EYSLyy6bvDo7rpee1LFeEkCEm2tl8qO9vi+0g2mlSElnVuwe9GjD6XCE/dUD6aSx
 oQrKy3/jNCxilk7joyyvmDLQIPKEjBRdiPWlBKOovr+odLSecJOsSqSg1mK2jngS
 dvJTzf0epd6f6L14x263jGlZb121ACav5Zlq4Nwg1Boy8nzgCKRqyT/vTODv5BlU
 aeBbg2ABxGvGT0buQlpG3c7RVvtb63HjDIB4q+HLu0rcQu/P7QAvg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t14jmuqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 04:47:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54N1uPr1031996;
 Fri, 23 May 2025 04:47:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwmqcx1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 04:47:44 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54N4lh8O30409230
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 04:47:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2708358057;
 Fri, 23 May 2025 04:47:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F2FB58058;
 Fri, 23 May 2025 04:47:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.243.208])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 May 2025 04:47:42 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v10 1/4] hw/vfio/ap: notification handler for AP config
 changed event
Date: Fri, 23 May 2025 00:47:38 -0400
Message-ID: <20250523044741.59936-2-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250523044741.59936-1-rreyes@linux.ibm.com>
References: <20250523044741.59936-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bp9Jhlr1qfbTz6q2l4E117xva1I5ZGdJ
X-Authority-Analysis: v=2.4 cv=XOkwSRhE c=1 sm=1 tr=0 ts=682ffdf1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=dt9VzEwgFbYA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8 a=cI7fhctStQOMI3-b00QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDAzOCBTYWx0ZWRfX9wXm76awi2p1
 Wx5YSEGO3bfc7sV3/sg2scLgweEddjI0vZS/cECQB+dDFfDlG6aaWphxY6zSNvCN/kHE7GG8i7h
 8RthDX2ijrNhoI2Gpz9VruLjCA2C9mTJbDH0QyqaY67BpStQ2W/y3GIb7IyQACENrJyQvu3rWUQ
 kiyb90Yp6ZyM0HGI0c1xcMd/Se3+J6mbI22CiYok8VO7Mf+J/Q0fOKuJRLw0qiB8uob0QoX/Sx1
 4k4PU3Jj9uuDuqg0eA8YTU715vzXlLiwisigDtGVuD56wgUHnzlCfLQTeCIxdCZNexXXqRGsM/i
 EZ9i2uDqqqr7oERL3MyOrxNli7Rj8B0X5IX+bLAGMsR29HapBZl4d/IFh03mnzNxqn/G9EuCdK9
 jX83UnjeicSfvpe8K1yhiG8IfPA8dBPTHoWxVUrAp4vKHFTctXz4OWaeIJYKMu46iMt2/nl/
X-Proofpoint-GUID: bp9Jhlr1qfbTz6q2l4E117xva1I5ZGdJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230038
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 785c0a0197..93c74ebedb 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -18,6 +18,7 @@
 #include "hw/vfio/vfio-device.h"
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
@@ -137,6 +155,9 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
     case VFIO_AP_REQ_IRQ_INDEX:
         notifier = &vapdev->req_notifier;
         break;
+    case VFIO_AP_CFG_CHG_IRQ_INDEX:
+        notifier = &vapdev->cfg_notifier;
+        break;
     default:
         error_report("vfio: Unsupported device irq(%d)", irq);
         return;
@@ -176,6 +197,15 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
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
@@ -188,6 +218,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
 
     vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
+    vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX);
     vfio_device_detach(&vapdev->vdev);
     g_free(vapdev->vdev.name);
 }
-- 
2.48.1


