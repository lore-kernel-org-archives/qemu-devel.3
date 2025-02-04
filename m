Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C28C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMPH-0004dX-Qe; Tue, 04 Feb 2025 12:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tfMPA-0004b4-P0; Tue, 04 Feb 2025 12:08:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tfMP8-0007Nf-WB; Tue, 04 Feb 2025 12:08:08 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEmCS028558;
 Tue, 4 Feb 2025 17:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=rP6S36xEkDaWXxbu7
 iGmB1qsEt469UxZGLkzp50ETKg=; b=pv4pd1/UkirVk2T0L0vmIcTfqsz7oe25k
 iaJrpU27XW8zhYtJeE7N2lyPBr8I6VLzGBe/27Cmw3YhCbx1Qud2snOZdKQtbl52
 3VZiyx3k3nh4O7Ucc6Ay2iNn+wOu2JdzcU1LShC46yLpgHwc6p4AmaMJN+zUuK/v
 a61J5ephSPJsRw+yMHb+UwQrkdkCgypO8IIcEAbmeCiKdLVMLdMIaFjc/Dwnj+Su
 wwuy+8q2A42ox359W5RohMj6p4uctKeVLZNq50SzYqcfK8/HVS9T3h31JTPJz2qX
 v9iwFDau2tkrCv1SksoTJJqLYN/+i1gyAblLSZO6vkaE32mHDX45g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44knqtrekc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 17:08:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514G5WQv024510;
 Tue, 4 Feb 2025 17:08:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxn4hr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 17:08:05 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 514H84VV57999628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Feb 2025 17:08:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6A3858059;
 Tue,  4 Feb 2025 17:08:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D285758043;
 Tue,  4 Feb 2025 17:08:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.255.239])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Feb 2025 17:08:02 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com
Subject: [RFC PATCH v2 2/5] hw/vfio/ap: notification handler for AP config
 changed event
Date: Tue,  4 Feb 2025 12:07:56 -0500
Message-Id: <20250204170759.36540-3-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250204170759.36540-1-rreyes@linux.ibm.com>
References: <20250204170759.36540-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GGkuPm2GyS8w7w4aUlXbgiGbnTK9-wD-
X-Proofpoint-ORIG-GUID: GGkuPm2GyS8w7w4aUlXbgiGbnTK9-wD-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/vfio/ap.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 30b08ad375..a2b3735349 100644
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
@@ -70,6 +72,16 @@ static void vfio_ap_req_notifier_handler(void *opaque)
     }
 }
 
+static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
+{
+    VFIOAPDevice *vapdev = opaque;
+
+    if (!event_notifier_test_and_clear(&vapdev->cfg_notifier)) {
+        css_generate_css_crws(0);
+    }
+
+}
+
 static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                           unsigned int irq, Error **errp)
 {
@@ -85,6 +97,10 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
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
@@ -136,6 +152,9 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
     case VFIO_AP_REQ_IRQ_INDEX:
         notifier = &vapdev->req_notifier;
         break;
+    case VFIO_AP_CFG_CHG_IRQ_INDEX:
+        notifier = &vapdev->cfg_notifier;
+        break;
     default:
         error_report("vfio: Unsupported device irq(%d)", irq);
         return;
@@ -175,6 +194,15 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
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
@@ -187,6 +215,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
 
     vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
+    vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX);
     vfio_detach_device(&vapdev->vdev);
     g_free(vapdev->vdev.name);
 }
-- 
2.39.5 (Apple Git-154)


