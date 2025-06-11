Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61707C71135
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 21:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPSkp-0004cO-NI; Wed, 11 Jun 2025 17:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uPSko-0004cC-27; Wed, 11 Jun 2025 17:13:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uPSkl-0004MC-L6; Wed, 11 Jun 2025 17:13:01 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BGRlrm021660;
 Wed, 11 Jun 2025 21:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=fCf/2hPBcC4phuQ3z7LKAIsZUUkBujUxvu+Dq56Fi
 6I=; b=EDvntfoTvxd3mIAJyj3txjhkLG/GDcXogkPvLeiwHD8b2xZYiP/PxM7KP
 B+YX7UVBneSq7kr1i3n+XJzGnB2/aDx5dHolS7/QVpjE4R3icrW9vbiLkfM4LV+b
 rcdW+PEUb7GMtiKOA/PBN8kHPu0UJo90TIPbhEuujv/lbSoA8wJH34ekvNJvip2e
 aJVjUMYFBO09NcvXd9xIz/vPhVMCZPG5MPW759O71gbysnVOxI4gEsjRBIEERwR2
 G93VT9lel2sawKBJZS61qB+A0FxQk2DbB6PMhyL0CuDTfl/pDIXBCEk9SKyTXznq
 8/VV9HsX3bxn6FF5nSgYxWHTgQD8A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup6x9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 21:12:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55BHQJbs027957;
 Wed, 11 Jun 2025 21:12:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47518mhfwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 21:12:55 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55BLCrDW24117996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 21:12:54 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D055B58045;
 Wed, 11 Jun 2025 21:12:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9836158054;
 Wed, 11 Jun 2025 21:12:52 +0000 (GMT)
Received: from MacBookPro.ibm.com (unknown [9.61.250.81])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Jun 2025 21:12:52 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v1] hw/vfio/ap: attribute constructor for
 cfg_chg_events_lock
Date: Wed, 11 Jun 2025 17:12:52 -0400
Message-ID: <20250611211252.82107-1-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=6849f158 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=LeD7RAK3qBdoSFKBwLEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE3NiBTYWx0ZWRfXwGxi9E6Tt1UJ
 4/qaLri0Mn055nGKpVG2VUINJZldRMRdsEBWAes1MtvfFEC4wxqurArWeG5yhRoAe7bpY++nAkq
 shL62jGm0tQsx8KyShdG4tRK0d14irYXs7vP7JmIJ8sUNvDBm9brnjDL5WsROaS6Jxy5AYwjz+r
 dQqXVW33fvha0IAhZEJS1w0LvBbDEARGjwsF3KqQ3ZDPdWuBo/gwO/zLPaXGM/na3GiyNJx0wMN
 tD98U9vuuPWrOoEHFt4b1UU5jduvcjM5BGi7XZBWgM/AOHT9KjUe0OM50ccyxAtnihrnjT4cV1j
 +XKL7GoJc+PQL8OhRMeMYoJoq6gYPHPbmyOuFU48OzFI+LCw7H604kvTqxUxW6+EeqhROav9vep
 Oa24hqU+4AMKahIOhZzh1NBD2PiCjYkfELmk7NMGzvVp3HGyrdRK9sOAmv+wsvQxYWURoNJK
X-Proofpoint-GUID: CM5WHBKbVGSFmxUo-KQQ0pksPOXxMKHv
X-Proofpoint-ORIG-GUID: CM5WHBKbVGSFmxUo-KQQ0pksPOXxMKHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=790 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110176
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Created an attribute constructor for cfg_chg_events_lock for locking
mechanism when storing event information for an AP configuration change
event

Fixes: fd03360215 ("Storing event information for an AP configuration change event")
Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
---
 hw/vfio/ap.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 874e0d1eaf..1df4438149 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -52,6 +52,11 @@ static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
 
 static QemuMutex cfg_chg_events_lock;
 
+static void __attribute__((constructor)) vfio_ap_global_init(void)
+{
+    qemu_mutex_init(&cfg_chg_events_lock);
+}
+
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
 
 static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
@@ -230,13 +235,6 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
     VFIODevice *vbasedev = &vapdev->vdev;
 
-    static bool lock_initialized;
-
-    if (!lock_initialized) {
-        qemu_mutex_init(&cfg_chg_events_lock);
-        lock_initialized = true;
-    }
-
     if (!vfio_device_get_name(vbasedev, errp)) {
         return;
     }
-- 
2.48.1


