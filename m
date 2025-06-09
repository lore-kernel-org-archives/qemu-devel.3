Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E23AC678DA
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfc3-00022L-Lp; Mon, 09 Jun 2025 12:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uOfbr-0001zo-S9; Mon, 09 Jun 2025 12:44:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uOfbo-0003g8-QM; Mon, 09 Jun 2025 12:44:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55977leH025405;
 Mon, 9 Jun 2025 16:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YT1bP9b3CAXHrFrek
 QNF8d3IjxOl+cQEcvyCjLmfRRk=; b=YTn/d+1ittSwdfyAtU7kVIoiHxi5JbZMJ
 GkFLFRQF+4TziL+Q/DLWAGm/VYxeNQcatrBbDBYr0VXIuGK39I1znHE0IWd2Shx8
 wG3y8CKUh2tDsulfIuT3h8/QijLJpLOpjoSOTKqgS60jcz85u8ba7ZPixjq6XKA0
 8gu6h6U7chI08DzLTIoZvqj3N1sHor3OJrx1LL6lQIzeKCMjBD02WJ6Sin4biTvt
 1U4nKd3O6Kz9JLgWLbtdDg4EplovEsuFI2iys6skM0dV9POSCtt3WIXw7MEUkU3o
 eeYZq27UXjPoVvJpAbrQF9tjfUG+L1QsTnhp73FSfKmEJnNvpmdNA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bunste5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 16:44:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 559FcsUV003367;
 Mon, 9 Jun 2025 16:44:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4751ykec20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 16:44:26 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 559GiOb830606028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Jun 2025 16:44:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF7C55805F;
 Mon,  9 Jun 2025 16:44:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A6FA58054;
 Mon,  9 Jun 2025 16:44:23 +0000 (GMT)
Received: from MacBookPro.ibm.com (unknown [9.61.253.10])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Jun 2025 16:44:23 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v13 3/4] hw/vfio/ap: Storing event information for an AP
 configuration change event
Date: Mon,  9 Jun 2025 12:44:17 -0400
Message-ID: <20250609164418.17585-4-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609164418.17585-1-rreyes@linux.ibm.com>
References: <20250609164418.17585-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=68470f6b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6IFa9wvqVegA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8 a=Z0WjHMB6GHtyqmt2ikkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEyMSBTYWx0ZWRfX/T3fEVxXrO2H
 IaUzVJlvV+yC+tuZdjJCcqLe2l2/OZZnzMJ5sJpxP1ZcLxNCR1woqq4GZT6b3A2rYRJYxm0book
 AobSWhrRlaK0c7zOWTmJhcxlHB8WpWbDGi7JX9yvryd4sBS612PvRtA9ykX6YTmD59Mc5jMvnLb
 RinPWLdrvsPrq28iWGnFQNxGh7ksX2rBfsK12ffcRB4lpwDPw1viHbpsWXxAS0bGorL25Z+sxrf
 AV1xNaPhrGl9ifhCukxax52FyacgsxIwcBv117jvmAZOEQZG8Mzswm95MeJ1xaQpibdJrnXIbr1
 J02cUsAw9X0X46oL6cG2eZWCfO71rhv+kIU2Ob6xHXgMcrFiPHr3rMttZyHaLAGDQTLBSjDWk5D
 OLu+T70oTZ7TK9bziKqBw0cLx1rXblDgd/tqwRWih5Ircxgnshp0oom/TdqOTqkSeWc5BHA3
X-Proofpoint-GUID: Hvp4OMx2hYMEyw2VfwZXvA413VsG9i7s
X-Proofpoint-ORIG-GUID: Hvp4OMx2hYMEyw2VfwZXvA413VsG9i7s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=846 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

These functions can be invoked by the function that handles interception
of the CHSC SEI instruction for requests indicating the accessibility of
one or more adjunct processors has changed.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 hw/vfio/ap.c                 | 40 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-bridge.h | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 681fd4a4f1..874e0d1eaf 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -10,6 +10,7 @@
  * directory.
  */
 
+#include <stdbool.h>
 #include "qemu/osdep.h"
 #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
@@ -101,6 +102,38 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
 
 }
 
+int ap_chsc_sei_nt0_get_event(void *res)
+{
+    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
+    APConfigChgEvent *cfg_chg_event;
+
+    WITH_QEMU_LOCK_GUARD(&cfg_chg_events_lock) {
+        if (QTAILQ_EMPTY(&cfg_chg_events)) {
+            return EVENT_INFORMATION_NOT_STORED;
+        }
+
+        cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
+        QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
+    }
+
+    memset(nt0_res, 0, sizeof(*nt0_res));
+    g_free(cfg_chg_event);
+    nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
+    nt0_res->length = sizeof(ChscSeiNt0Res);
+    nt0_res->code = NT0_RES_RESPONSE_CODE;
+    nt0_res->nt = NT0_RES_NT_DEFAULT;
+    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
+    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
+
+    return EVENT_INFORMATION_STORED;
+}
+
+bool ap_chsc_sei_nt0_have_event(void)
+{
+    QEMU_LOCK_GUARD(&cfg_chg_events_lock);
+    return !QTAILQ_EMPTY(&cfg_chg_events);
+}
+
 static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                           unsigned int irq, Error **errp)
 {
@@ -197,6 +230,13 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
     VFIODevice *vbasedev = &vapdev->vdev;
 
+    static bool lock_initialized;
+
+    if (!lock_initialized) {
+        qemu_mutex_init(&cfg_chg_events_lock);
+        lock_initialized = true;
+    }
+
     if (!vfio_device_get_name(vbasedev, errp)) {
         return;
     }
diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
index 470e439a98..7efc52928d 100644
--- a/include/hw/s390x/ap-bridge.h
+++ b/include/hw/s390x/ap-bridge.h
@@ -16,4 +16,43 @@
 
 void s390_init_ap(void);
 
+typedef struct ChscSeiNt0Res {
+    uint16_t length;
+    uint16_t code;
+    uint8_t reserved1;
+    uint16_t reserved2;
+    uint8_t nt;
+#define PENDING_EVENT_INFO_BITMASK 0x80;
+    uint8_t flags;
+    uint8_t reserved3;
+    uint8_t rs;
+    uint8_t cc;
+} QEMU_PACKED ChscSeiNt0Res;
+
+#define NT0_RES_RESPONSE_CODE 1
+#define NT0_RES_NT_DEFAULT    0
+#define NT0_RES_RS_AP_CHANGE  5
+#define NT0_RES_CC_AP_CHANGE  3
+
+#define EVENT_INFORMATION_NOT_STORED 1
+#define EVENT_INFORMATION_STORED     0
+
+/**
+ * ap_chsc_sei_nt0_get_event - Retrieve the next pending AP config
+ * change event
+ * @res: Pointer to a ChscSeiNt0Res struct to be filled with event
+ * data
+ *
+ * This function checks for any pending AP config change events and,
+ * if present, populates the provided response structure with the
+ * appropriate SEI NT0 fields.
+ *
+ * Return:
+ *   EVENT_INFORMATION_STORED - An event was available and written to @res
+ *   EVENT_INFORMATION_NOT_STORED - No event was available
+ */
+int ap_chsc_sei_nt0_get_event(void *res);
+
+bool ap_chsc_sei_nt0_have_event(void);
+
 #endif
-- 
2.48.1


