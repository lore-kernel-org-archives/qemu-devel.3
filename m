Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1665EF31E24
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAq91-0008Mn-Ng; Thu, 09 Apr 2026 10:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1wAq8y-0008ME-5C; Thu, 09 Apr 2026 10:14:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1wAq8w-0000hX-KT; Thu, 09 Apr 2026 10:14:03 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639BbK7i2211629; Thu, 9 Apr 2026 14:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AWFhyEEbRYqvGNebo
 Mncanft41maUJsvjia+OSWLOMw=; b=co1o48VTY7SyQa1PeBiJalUbroWtdKn96
 zlnegyDaG/VmWF6bqWyU2GNRqoKe/W2YlOvmStktmeprRoXScvk+wEF+5JXlKqaY
 HtTqYJ1JgZ3jq1qq/mjQ3mnDYaCliIzzccH8bczMpWIHrilpoUMmXZ/IS2pNprzo
 CqYYm6N9o/n8X6GIP+GtLkFH10wdTP3P4YnPZlAHfwknXYPXI23IqVqUNlVFJ0ZY
 MqoRvRFVlxWm4ANorN8djnhXFuu12BfCrETdK03mtskD2rCFgAgHn63HxQg2R3XH
 3U7+fjCLHGN+n6MbUkbgI0joWL/FSeeRpIx9e9ast7B41gyYX87Cw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hmf1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 14:14:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639D088F030063;
 Thu, 9 Apr 2026 14:14:00 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7kve4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 14:14:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 639EDxEY24183520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Apr 2026 14:13:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 335B55805D;
 Thu,  9 Apr 2026 14:13:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6739C58052;
 Thu,  9 Apr 2026 14:13:58 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown
 [9.61.93.104]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Apr 2026 14:13:58 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, clg@redhat.com, farman@linux.ibm.com,
 borntraeger@linux.ibm.com, alex@shazbot.org, cohuck@redhat.com,
 Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 2/2] hw/vfio/ap: Callbacks for migration of guests with
 pass-through access to AP devices
Date: Thu,  9 Apr 2026 10:13:45 -0400
Message-ID: <20260409141352.997844-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409141352.997844-1-akrowiak@linux.ibm.com>
References: <20260409141352.997844-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEyNiBTYWx0ZWRfX2lLYsPISAyWu
 rrcCEWH7SUl9U7DOszV4hrstJyQ46tKun/Bq69wHwdX3eD/XpmSDvHFuYTTYKv4UXSHPcNjv86h
 lyZ+ANu1cuhUwJI2RxJrgRZLN1GmxxZ41NFDbfJj7km3ffZXxn97F7MrOiEHFA1IzTnJZO7MlzV
 GQW0geDqsMNwLnlzqtCUo25Au7Gu707m01TTixweu7ilFh03HxuS8fn8rDSl5cnnOeFR+2Hy1oq
 2BHPlLE3qznPIapCOkDLMbAajEGvTIzZIUR1g4PX3g2Yfhe5FU/Ov7AqTz2SRxWfRd8FUEHOy1V
 pEaH7NZhW888hQqBnlAGdvQnB/f+PafMN76C4Lo9M5wqGToYDEzyP3kowDrmb85j8wEqqz7D1tz
 ILD5cv8iBx2EWl/0aMIRI/3N+GE4iYO4XK6jO5Xos+/8OlPnfnmix4y0abzJlKzdib9NQTFNX1I
 d1uy7ezT4uo5pvT3Etw==
X-Proofpoint-GUID: ZW-PGTcr803UkRXkmA2PLwLF4beMfHVn
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d7b429 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=_xvLCLdD-WGpu_BjdYgA:9
X-Proofpoint-ORIG-GUID: ZW-PGTcr803UkRXkmA2PLwLF4beMfHVn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090126
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

From: Anthony  Krowiak <akrowiak@linux.ibm.com>

Implements the callbacks used by the VFIO migration framework to migrate
guests with pass-through access to s390 crypto devices.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 hw/vfio/ap.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index fd68983702..49947b18c3 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -32,6 +32,7 @@
 #include "hw/s390x/ap-bridge.h"
 #include "system/address-spaces.h"
 #include "qom/object.h"
+#include "vfio-migration-internal.h"
 
 #define TYPE_VFIO_AP_DEVICE      "vfio-ap"
 
@@ -47,6 +48,7 @@ static const VMStateDescription vmstate_ap_device = {
     .name = "vfio-ap-device",
     .version_id = 1,
     .minimum_version_id = 1,
+    .unmigratable = 0,
     .fields = (const VMStateField[]) {
         VMSTATE_END_OF_LIST()
     },
@@ -66,17 +68,44 @@ static void __attribute__((constructor)) vfio_ap_global_init(void)
     qemu_mutex_init(&cfg_chg_events_lock);
 }
 
+static int vfio_ap_save_config(VFIODevice *vdev, QEMUFile *f, Error **errp)
+{
+    VFIOAPDevice *vapdev = container_of(vdev, VFIOAPDevice, vdev);
+
+    return vmstate_save_state(f, &vmstate_ap_device, vapdev, NULL, errp);
+}
+
+static int vfio_ap_load_config(VFIODevice *vdev, QEMUFile *f)
+{
+    VFIOAPDevice *vapdev = container_of(vdev, VFIOAPDevice, vdev);
+    Error *err = NULL;
+    int ret;
+
+    ret = vmstate_load_state(f, &vmstate_ap_device, vapdev, 1, &err);
+    if (ret) {
+        error_report_err(err);
+    }
+
+    return ret;
+}
+
+static Object *vfio_ap_get_object(VFIODevice *vbasedev)
+{
+    VFIOAPDevice *vdev = container_of(vbasedev, VFIOAPDevice, vdev);
+
+    return OBJECT(vdev);
+}
+
 static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
 {
     vdev->needs_reset = false;
 }
 
-/*
- * We don't need vfio_hot_reset_multi and vfio_eoi operations for
- * vfio-ap device now.
- */
 struct VFIODeviceOps vfio_ap_ops = {
     .vfio_compute_needs_reset = vfio_ap_compute_needs_reset,
+    .vfio_save_config = vfio_ap_save_config,
+    .vfio_load_config = vfio_ap_load_config,
+    .vfio_get_object = vfio_ap_get_object,
 };
 
 static void vfio_ap_req_notifier_handler(void *opaque)
@@ -251,6 +280,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         goto error;
     }
 
+    if (!vfio_migration_realize(vbasedev, errp)) {
+        goto error;
+    }
+
     if (!vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err)) {
         /*
          * Report this error, but do not make it a failing condition.
@@ -287,6 +320,8 @@ static void vfio_ap_unrealize(DeviceState *dev)
 
 static const Property vfio_ap_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
+    DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOAPDevice,
+                            vdev.enable_migration, ON_OFF_AUTO_ON),
 #ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-- 
2.52.0


