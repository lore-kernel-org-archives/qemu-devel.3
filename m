Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC95C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 18:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNbwZ-0004Ex-1F; Fri, 06 Jun 2025 14:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uNbwV-0004Dj-SM; Fri, 06 Jun 2025 14:37:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uNbwS-0008Ix-7q; Fri, 06 Jun 2025 14:37:27 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556Dpsq9019430;
 Fri, 6 Jun 2025 18:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/N3U4t3LiiReJXxka
 GTq63I6YAr4N0FuMqvFbBhGAy0=; b=OuC/fcSIA8MLTEngNKTGLuMI0XPcBb9Db
 HDup4lT1Ir5kvVHkBiQQJnqL5WlxugFccE1Ia+gIQ9dfON3wKJEiSLEYtyeZg8Gh
 3inAHN/FyVXj6X+2BMHh41pjsIQnq4gGHhiEbSOuhle+oTNqsuhjaRMMSLdsqRpD
 yeiaymLDaObzO7cD/g+Ou2kkwAig0EruxEvcn+1ZE/iFPLeKmPaDE74xmuQa91wC
 yJf/u2xNilWpFxYEVXT2Or3CXikqEg+1n4zzpE0mjzq/uU+KwIBBGzAFA9wXKykg
 xw5+VfdbtBo2GmbEkM7FlY/y+Q5SX9GeF6TKThrJEyNDOO0ZRLCdA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf08681-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 18:37:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 556FbajM012511;
 Fri, 6 Jun 2025 18:37:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 470et2tekv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 18:37:20 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 556IbJVX26018060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Jun 2025 18:37:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 324B758043;
 Fri,  6 Jun 2025 18:37:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02F7458059;
 Fri,  6 Jun 2025 18:37:18 +0000 (GMT)
Received: from MacBookPro.ibm.com (unknown [9.61.255.166])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Jun 2025 18:37:17 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v12 1/4] hw/vfio/ap: notification handler for AP config
 changed event
Date: Fri,  6 Jun 2025 14:37:13 -0400
Message-ID: <20250606183716.26152-2-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606183716.26152-1-rreyes@linux.ibm.com>
References: <20250606183716.26152-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hUvawCydIqPCwkoWCFElpAcREXCQO9mD
X-Authority-Analysis: v=2.4 cv=DYMXqutW c=1 sm=1 tr=0 ts=68433561 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6IFa9wvqVegA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8 a=cI7fhctStQOMI3-b00QA:9
X-Proofpoint-GUID: hUvawCydIqPCwkoWCFElpAcREXCQO9mD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE1OSBTYWx0ZWRfX0jQChyrLDbO1
 uoCoJoNh9tRlqND0fLKCTEPhBF2FHvXUV5fAeUwNOW/0sdv4xcx4ozZQlmOk2g+c7j9idreaBlG
 INfEt1BtBo4szej1Cr395I7EAkuJHDfeQXlTcngRExpu/aYKRD/tzxIWuLv6/FumudrBFX6tyz9
 P4fz5nZvSdEEAb10A+x4QirXaDw74ESUQi++64BFn23D1FLSh99JDO0WCNoPyKOiSMWUe6fHR/Y
 i8xtCqW2pH21rRHNpdsWmvlQ0OsWuPi2kSut0r9/LPAGVaglwuayPj0TltSN1h98Upck+N1dcm3
 EbAOjqZVWjU3i6dKukq1y0Pq6/8z3OiGhlYbhD/avGV4mwnxG0iQeDi5J1Xa0GV2gPW9VxO2RPk
 I6zPH/WKLq/NuZSf15cc1fbYQME+pM0RdKieT6JCNTX4Bq9LMnxqx72Hq4ueyBbZOrILlvUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_07,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


