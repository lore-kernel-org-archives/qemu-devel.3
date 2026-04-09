Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656B9F31E22
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAq95-0008PO-Ko; Thu, 09 Apr 2026 10:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1wAq8z-0008MS-6j; Thu, 09 Apr 2026 10:14:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1wAq8x-0000hZ-32; Thu, 09 Apr 2026 10:14:04 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63971Y0S1656683; Thu, 9 Apr 2026 14:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cUo6lPnMtKarhCbO6
 lVs/jRRVEJ1XiICyAEL31zc+Wk=; b=QTyMNdxt5wYVH2u67OQpSsZBCNkO35mi9
 CrLelJQeVOIDwBOT/ETNxT00Rsn7kIDxvvBwFM034U0bz9BP7RP+7JF8b89uw54m
 gP2z95L0jVtrYa4+/5uB4qPAAd0YM8LaSHQAU7OlxUAuaqnrbtckescvehj2FCwl
 VZPS0YEvwavzn2gjvj0kfkzdXJXeaJfLRHugxNf39NxR6MBvfOXug5WR54yrlaMP
 onMlB1K3QrbSgetbDr1rIvRLALPmOsN5CKj3c/MxWDxSVYEfar4vxeNBWpTMHrXS
 cNy4jDCXeHjjIKVnfe5xAELw/3Hc3T/HUiaZlsLRxhMWWfskBWmeg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fnbm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 14:14:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639CkhOP030062;
 Thu, 9 Apr 2026 14:14:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7kve3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 14:14:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 639EDwDj66322726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Apr 2026 14:13:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DBAF58056;
 Thu,  9 Apr 2026 14:13:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8959658052;
 Thu,  9 Apr 2026 14:13:57 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown
 [9.61.93.104]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Apr 2026 14:13:57 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, clg@redhat.com, farman@linux.ibm.com,
 borntraeger@linux.ibm.com, alex@shazbot.org, cohuck@redhat.com,
 Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 1/2] hw/vfio/ap: Extend vfio device state description to
 facilitate live migration
Date: Thu,  9 Apr 2026 10:13:44 -0400
Message-ID: <20260409141352.997844-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409141352.997844-1-akrowiak@linux.ibm.com>
References: <20260409141352.997844-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEyNiBTYWx0ZWRfX4p5bDr589Z3w
 QLDy0a9JYXbpleF956i9tn4EvcSBKpffcDGyJOvJE9F6c5HLk9X4oDgavpTM5x2jQcrKf0m0anu
 cAaDaQ5fsy7pz9Zt3A/kMVUWhAu8TZPOF6Ax8dc9pJudTLnRgblQd0D3aEu1QJwqP6TlCYub2wa
 IDaSVGSeHaUtxXyVN4xijO8sqAnH6e34dGblEL3fCcPV3BI4riYBCvhETv1qu4K2GWNIcN6MZSp
 8jnqpeiX6obCj6gSnEFMMblbdUyMjCxY5fKd9tO3QxxYJSSn49PeCEhGemyLwW4ZWvM0YZeI/Aa
 bI9sLtpSvXw16w7VD+D7XhtfePf8NvBqBkFkGXFiwq2VtAKqhudIg6XKfukdkG81lRVZ9wclGAl
 G0O4GQSbNIG+KR+yf5okwuu3ufyWARMlYCJZeJJN6MxlnZWpDTfLe/JvSTFpGm33a1tzXl3axlw
 tULRIRgYSOBqS2K56QA==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d7b429 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=U2XpRZ1s8oYUY_CUuxAA:9
X-Proofpoint-ORIG-GUID: wqad3MMXo-0E5-ne4fXC0xjVWNvGba_8
X-Proofpoint-GUID: wqad3MMXo-0E5-ne4fXC0xjVWNvGba_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090126
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Make the changes needed to the VFIOAPDevice state description to facilitate
live guest migration.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 hw/vfio/ap.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 5c8f305653..fd68983702 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -41,6 +41,16 @@ struct VFIOAPDevice {
     EventNotifier req_notifier;
     EventNotifier cfg_notifier;
 };
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
+
+static const VMStateDescription vmstate_ap_device = {
+    .name = "vfio-ap-device",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    },
+};
 
 typedef struct APConfigChgEvent {
     QTAILQ_ENTRY(APConfigChgEvent) next;
@@ -56,8 +66,6 @@ static void __attribute__((constructor)) vfio_ap_global_init(void)
     qemu_mutex_init(&cfg_chg_events_lock);
 }
 
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
-
 static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
 {
     vdev->needs_reset = false;
@@ -297,11 +305,6 @@ static void vfio_ap_reset(DeviceState *dev)
     }
 }
 
-static const VMStateDescription vfio_ap_vmstate = {
-    .name = "vfio-ap",
-    .unmigratable = 1,
-};
-
 static void vfio_ap_instance_init(Object *obj)
 {
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(obj);
@@ -335,7 +338,7 @@ static void vfio_ap_class_init(ObjectClass *klass, const void *data)
 #ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_ap_set_fd);
 #endif
-    dc->vmsd = &vfio_ap_vmstate;
+    dc->vmsd = &vmstate_ap_device;
     dc->desc = "VFIO-based AP device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->realize = vfio_ap_realize;
-- 
2.52.0


