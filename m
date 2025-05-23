Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57F6C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 04:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIKK9-0003bo-81; Fri, 23 May 2025 00:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIKK6-0003al-L5; Fri, 23 May 2025 00:47:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIKJz-0002O6-Ao; Fri, 23 May 2025 00:47:58 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MNWKht006673;
 Fri, 23 May 2025 04:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=dcP2o7DN36bf0Cm4C
 xEa62CdUnWfV5qXAzKPfZBWoO0=; b=mTxz9ACw7quyT3PMnPo4JHg3R9lNMaWxg
 Cnhx/Z2S0AMq3o6WABPF8ssxjfoFOnMpxRXlES66UaxU7ArUUQgoiqaCas7OIv35
 hlVaoDjshwNHqTbDdVDiWeqDWb+gMeNQmM+CP1pOkBNXpqWJKlHFeHDzmoLNBoht
 hZuPJ5uFV5B6jKumPVN+aIFp0O+7yPrJ8UD2cocAN7jMeADiJ0S2CvKvcApeUzMV
 gY9D9fDJYxIL/6WxQyyEycJmi7czWle8l3ZjRw7sp96dlJc2Hz/Rk4o51pvsBG99
 K/MpJOosJ3nid4ADSnn5talalALPqAUAT1IRbk0SrhgbWVfOiLj7A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t9m7t2pj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 04:47:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54N1MbFZ015454;
 Fri, 23 May 2025 04:47:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnnmwu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 04:47:46 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54N4ljU162980416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 04:47:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA3845805D;
 Fri, 23 May 2025 04:47:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C5AF58058;
 Fri, 23 May 2025 04:47:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.243.208])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 May 2025 04:47:44 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v10 3/4] hw/vfio/ap: Storing event information for an AP
 configuration change event
Date: Fri, 23 May 2025 00:47:40 -0400
Message-ID: <20250523044741.59936-4-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250523044741.59936-1-rreyes@linux.ibm.com>
References: <20250523044741.59936-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SMZCVPvH c=1 sm=1 tr=0 ts=682ffdf3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=dt9VzEwgFbYA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8 a=cKQ_eDIM6AGRu3ddSD4A:9
X-Proofpoint-GUID: 81hGvnI2KuRTmg8lMstwWdJYgX-6NnCT
X-Proofpoint-ORIG-GUID: 81hGvnI2KuRTmg8lMstwWdJYgX-6NnCT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDAzOCBTYWx0ZWRfX5R8sLccUm5Jm
 mLQMyzOfewVMkJAXAs52JhpG3JupwCdmlft1+HtqoI1GOtvgfavZZQOGecCGp4l6jSAQdibqELY
 +6p8dAD46/zbtnV/z7MFvyddcgM0QDiav10Mm1efVaZ/iaMa8dOqPeNJ6YYSXxhZSdKF83AOIqq
 4JxTlcff2fjD4+UKDfG8vNZvuMCDL2q635eP4WyA56z0+di0lPssU8ehVonCY0bxAnhltihP82X
 mHaDUxRKr7VfwZmULT3BiHCjhe4Oa87SoGit29HrFj9zPKBQ06bDgm6S9me7RuVfyYxocKcALsU
 7tOh3hwfa/81RmUf6JlvVaQVs1i7LTDKyySfc2vjgG043HpD89inbP/aZ0T9RcyN943A/uO6oKS
 mki/6ce58xayQXfrc0YV7D8Qfxhc22WyjJsotrizneH8X4qXFQCWEFUO5T0meJ9061x0y2AR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
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

These functions can be invoked by the function that handles interception
of the CHSC SEI instruction for requests indicating the accessibility of
one or more adjunct processors has changed.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
---
 hw/vfio/ap.c                 | 53 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-bridge.h | 36 ++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index fc435f5c5b..a6b4514606 100644
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
 
+bool ap_chsc_sei_nt0_get_event(void *res)
+{
+    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
+    APConfigChgEvent *cfg_chg_event;
+
+    qemu_mutex_lock(&cfg_chg_events_lock);
+
+    if (!ap_chsc_sei_nt0_have_event()) {
+        qemu_mutex_unlock(&cfg_chg_events_lock);
+        return true;
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
+    return false;
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
index 470e439a98..ae31532f6e 100644
--- a/include/hw/s390x/ap-bridge.h
+++ b/include/hw/s390x/ap-bridge.h
@@ -16,4 +16,40 @@
 
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
+ *   false - An event was available and written to @res
+ *   true - No event was available
+ */
+bool ap_chsc_sei_nt0_get_event(void *res);
+
+bool ap_chsc_sei_nt0_have_event(void);
+
 #endif
-- 
2.48.1


