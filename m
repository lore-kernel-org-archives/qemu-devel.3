Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F06C36010
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 14:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzFiW-0007OQ-29; Mon, 31 Mar 2025 10:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzFhx-0007IK-9a; Mon, 31 Mar 2025 10:01:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzFht-00031K-Ks; Mon, 31 Mar 2025 10:01:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V3mHCL024980;
 Mon, 31 Mar 2025 14:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aIhpVug6hP+IkMG8W
 Yvx8nUnsdz9WMIs7yr2+KgjD/c=; b=QWSkGsEqJANXh/rf789ZFnSXOp7TB2MBN
 UcdK3+K3JNGSIXqQifFLXBWqquu/JZx1DbZynqvCVp3tuhjF5LP0jLPKN0KXa4sQ
 4fX2x5dnf8O8/9pvr/zcYrIXD23F28M4Er7W6+q2K75umVKqS34I8RUcw90vR59Z
 qzbVzYL4T84gBkjjjqwIDGlMO+mwiFU0A+C9ZTMpgski9LhjrvG1sfPxB+tB4EdF
 KKKIq8fR/PTrTlSgyTWAu2hUX0HeBAMNmwxK/4V5lQrqNN4TIOJWB2iIjNNzgL93
 s5KFzxvxsQy3+mn9eNtsV/hvCFk3OaQwKndD3i93eNP2NkIAmhueA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qke9jbhx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Mar 2025 14:01:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VBHEqT005442;
 Mon, 31 Mar 2025 14:01:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pww25r9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Mar 2025 14:01:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52VE1YZS31654528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Mar 2025 14:01:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09E242004B;
 Mon, 31 Mar 2025 14:01:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCDA320043;
 Mon, 31 Mar 2025 14:01:33 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Mar 2025 14:01:33 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v3 4/4] hw/s390x: compat handling for backward migration
Date: Mon, 31 Mar 2025 16:00:41 +0200
Message-ID: <20250331140041.3133621-5-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250331140041.3133621-1-shalini@linux.ibm.com>
References: <20250331140041.3133621-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gFLZBDIg01vhpFm9OonWk7KwgpZoozQ5
X-Proofpoint-ORIG-GUID: gFLZBDIg01vhpFm9OonWk7KwgpZoozQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310100
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Add Control-Program Identification (CPI) device to QOM only when the virtual
machine supports CPI. CPI is supported from "s390-ccw-virtio-10.0" machine
and higher.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
---
 hw/s390x/event-facility.c  | 27 ++++++++++++++++++++++-----
 hw/s390x/s390-virtio-ccw.c |  1 +
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index c0fb6e098c..cb23bbc54b 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -22,6 +22,7 @@
 #include "hw/s390x/sclp.h"
 #include "migration/vmstate.h"
 #include "hw/s390x/event-facility.h"
+#include "hw/qdev-properties.h"
 
 typedef struct SCLPEventsBus {
     BusState qbus;
@@ -54,6 +55,7 @@ struct SCLPEventFacility {
     bool allow_all_mask_sizes;
     /* length of the receive mask */
     uint16_t mask_length;
+    bool use_cpi;
 };
 
 /* return true if any child has event pending set */
@@ -455,11 +457,20 @@ static void realize_event_facility(DeviceState *dev, Error **errp)
         qdev_unrealize(DEVICE(&event_facility->quiesce));
         return;
     }
-    if (!qdev_realize(DEVICE(&event_facility->cpi),
-                      BUS(&event_facility->sbus), errp)) {
-        qdev_unrealize(DEVICE(&event_facility->quiesce));
-        qdev_unrealize(DEVICE(&event_facility->cpu_hotplug));
-        return;
+    /*
+     * Add sclpcpi device to QOM only when the virtual machine supports
+     * Control-Program Identification. It is supported by "s390-ccw-virtio-10.0"
+     * machine and higher.
+     */
+    if (!event_facility->use_cpi) {
+        object_unparent(OBJECT(&event_facility->cpi));
+    } else {
+        if (!qdev_realize(DEVICE(&event_facility->cpi),
+                          BUS(&event_facility->sbus), errp)) {
+            qdev_unrealize(DEVICE(&event_facility->quiesce));
+            qdev_unrealize(DEVICE(&event_facility->cpu_hotplug));
+            return;
+        }
     }
 }
 
@@ -470,12 +481,18 @@ static void reset_event_facility(DeviceState *dev)
     sdev->receive_mask = 0;
 }
 
+static const Property qemu_event_facility_properties[] = {
+    DEFINE_PROP_BOOL("use-cpi", SCLPEventFacility,
+                     use_cpi, true),
+};
+
 static void init_event_facility_class(ObjectClass *klass, void *data)
 {
     SysBusDeviceClass *sbdc = SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(sbdc);
     SCLPEventFacilityClass *k = EVENT_FACILITY_CLASS(dc);
 
+    device_class_set_props(dc, qemu_event_facility_properties);
     dc->realize = realize_event_facility;
     device_class_set_legacy_reset(dc, reset_event_facility);
     dc->vmsd = &vmstate_event_facility;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 75b32182eb..c1001322e0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -939,6 +939,7 @@ static void ccw_machine_9_2_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] = {
         { TYPE_S390_PCI_DEVICE, "relaxed-translation", "off", },
+        { TYPE_SCLP_EVENT_FACILITY, "use-cpi", "off", },
     };
 
     ccw_machine_10_0_class_options(mc);
-- 
2.47.0


