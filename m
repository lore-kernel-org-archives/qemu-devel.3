Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5404DC54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 16:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIUsT-0003yI-91; Fri, 23 May 2025 12:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIUsB-0003r3-Tz; Fri, 23 May 2025 12:03:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIUs9-0002u1-9w; Fri, 23 May 2025 12:03:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NA2eAZ006420;
 Fri, 23 May 2025 16:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=flKSRWwIVyWcugu85
 KpsEwhisGiqLUH40eJIaMYTL0o=; b=EZ0w4zaleCYo79/HMUoRIpQsgUsqeNFrY
 wxrHgj8G0/I/aNdXf/nSYgVvBU3yzWwSMFtqdYKfs66JF0pmPRF47z/n7mWgiGi4
 EhvZT1ZqOgoKDt5UxDWK5E2A9x87mbvl7xn90qsW/GOQWBcPN5TJPEQ/23zZQUH1
 Q7qsQmO4nclvwyb69V2m1SRNIDdPmrnx9txNoAA0LKfs10ad21MK7j+Zxje5UWWE
 G2Ma8ojlUMVgSoc0J0ooOfXjXpfkNwf2y90gmWc8PGBuEqFvg9o5CfPirqI3eQai
 uiTI6aHo+xdUwiFhks4jHCBXgpK8WxMmP/zoBAuzTFckFV/cHqgog==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t9m7w4a9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 16:03:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54NEbeJa031973;
 Fri, 23 May 2025 16:03:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwmqfa4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 16:03:43 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54NG3gkB26477138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 16:03:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A0455805C;
 Fri, 23 May 2025 16:03:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4404D58051;
 Fri, 23 May 2025 16:03:41 +0000 (GMT)
Received: from MacBookPro.ibm.com (unknown [9.61.240.236])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 May 2025 16:03:41 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v11 3/4] hw/vfio/ap: Storing event information for an AP
 configuration change event
Date: Fri, 23 May 2025 12:03:37 -0400
Message-ID: <20250523160338.41896-4-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250523160338.41896-1-rreyes@linux.ibm.com>
References: <20250523160338.41896-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SMZCVPvH c=1 sm=1 tr=0 ts=68309c60 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=dt9VzEwgFbYA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8 a=cKQ_eDIM6AGRu3ddSD4A:9
X-Proofpoint-GUID: TqamCVwje5Td1HWFSN0f7vwFVVvQsBk2
X-Proofpoint-ORIG-GUID: TqamCVwje5Td1HWFSN0f7vwFVVvQsBk2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE0NSBTYWx0ZWRfXxPjfYrIxlYyc
 d31GcHv9g7UO8sXj+cjoY3Mc8cIHPHzjV6lNt3Pvw1mS0cJfhCnIj7QTVlucpL1SYJ4WSq2vsMK
 wVufhI2HB65sy3HJ8iM+PtKtkNQI4RPA78T5G5ryH/9mRX1azyJciNkr2Xdtj5HENCyZpB9ZSAz
 oIXLueAcUBbfqSvhAu1af8TtBbRPcHpNJRo5jBwHJKLknEDDNO/hioKEGpJV1iMXA88E+A9gLBL
 pq4/13rL7gsxnwnMHZmuhVj+ZNuk0mY/t6Y/E04lH2cElIZqeI6Jdmxw+kxw/wgA06WZWLolvBn
 cf1hDvf5VsdD+yfj8MHNVOrpM/UdyGF5vX7hjziN0dWk2SZg0EJguUkL22W/bZyUv8ojzCNVmBf
 NA6ep4C/mg4uDqOOdRCFWN8821MDbbzf1Rr2vyB4C4EqQizPWuTZzo/FojnVoKsHx8EeB/pm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230145
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
---
 hw/vfio/ap.c                 | 53 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-bridge.h | 39 ++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index fc435f5c5b..97a42a575a 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -10,6 +10,7 @@
  * directory.
  */
 
+#include <stdbool.h>
 #include "qemu/osdep.h"
 #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
@@ -48,6 +49,8 @@ typedef struct APConfigChgEvent {
 static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
     QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
 
+static QemuMutex cfg_chg_events_lock;
+
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
 
 static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
@@ -96,6 +99,49 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
 
 }
 
+int ap_chsc_sei_nt0_get_event(void *res)
+{
+    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
+    APConfigChgEvent *cfg_chg_event;
+
+    qemu_mutex_lock(&cfg_chg_events_lock);
+
+    if (!ap_chsc_sei_nt0_have_event()) {
+        qemu_mutex_unlock(&cfg_chg_events_lock);
+        return EVENT_INFORMATION_NOT_STORED;
+    }
+
+    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
+    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
+
+    qemu_mutex_unlock(&cfg_chg_events_lock);
+
+    memset(nt0_res, 0, sizeof(*nt0_res));
+    g_free(cfg_chg_event);
+
+    /*
+     * If there are any AP configuration change events in the queue,
+     * indicate to the caller that there is pending event info in
+     * the response block
+     */
+    if (ap_chsc_sei_nt0_have_event()) {
+        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
+    }
+
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
+    return !QTAILQ_EMPTY(&cfg_chg_events);
+}
+
 static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                           unsigned int irq, Error **errp)
 {
@@ -192,6 +238,13 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
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


