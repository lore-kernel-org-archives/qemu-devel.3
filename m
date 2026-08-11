Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D531AC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnkc-0002YF-Lp; Tue, 11 Aug 2026 10:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkb-0002VR-Aq; Tue, 11 Aug 2026 10:46:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkZ-0003ft-Lt; Tue, 11 Aug 2026 10:46:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDWwKT3633650; Tue, 11 Aug 2026 14:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xuOZiOd7rtc9H/Hxs
 jgYJDkbvhn+I80yBwm3cQLhm+0=; b=SlKMr657n5Wu11Nbf1iZGREdqLBggEBZp
 c21fA00UfBvU2yWG3rO59uO4VL1oN+N5nuYFlC4nRnr8oSqNRuMw6Tr/xyayRIIy
 YR1pM/7lbktVZBeKUpC3Fr36iTwCIwoQ3klMxP0+FI0rN2NA1eULhmn3j9Q6m2GN
 M04JRctP/gSlrZzSEWKGh1SlRUZL4a08Iqt4LWnM9PI51XpNc7NFmDwroJDJ43UW
 bIQk4kyIoXO+xxlAc47O/OVrgMZG4JSrXnb/Z9Y6OqYO8q+FCqR/q9FlDBuBRyWg
 P9zAtKAYhN8xSDOsZDHD/bYI+yWzxtzDLU7CPT5mL8eQVyzdPil/A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23p62b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEfGYY001967;
 Tue, 11 Aug 2026 14:46:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq1ga9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BEkdeT64225588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 14:46:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FC725805D;
 Tue, 11 Aug 2026 14:46:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 157AF58055;
 Tue, 11 Aug 2026 14:46:39 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.86.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 14:46:38 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v2 5/8] pc-bios/s390-ccw: Abstract virtio_run() for generic use
Date: Tue, 11 Aug 2026 10:46:26 -0400
Message-ID: <20260811144629.866641-6-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260811144629.866641-1-jrossi@linux.ibm.com>
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b35d2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=0PGiSlKGR9UV7cgr1PYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX8jj2IEm52+FW
 9E70xmF2FJiRFGyYmFeI4PxdoETCxSKA+G0Yr9Y+eHT48XqGZhYU0j27Q6jIeARvAogUpSDfwQ4
 /Bgki66XtiOumw7WMjYNu0EpRA5if4uhmZVn+TuXEAzHsmqSbi7VRoabrGb6yTO+Ums4fbOGdI4
 jcNpxJK7QV/IoVrH6VizyxsL9DXz3CWLVnq1QyVIURxDDW6DH67dfLZ9TcXYIjBds8VX5bGOC9T
 lpuurhwGugHA+9zh/Wo8E9NIoBkbS6GXm0gRZzTRTwBzI9MNOBSpe1sgy/sEPCx1VWdTkFBrzie
 Fl912n+XrL5Q56/5TH3W1iA3M0pLMHQLZsjj6D0dk2jSkQrzlfmYaI/mk9Q8dsE4dGV0VtL2Wgh
 uZjf+KLaurqBOs5B0rNVXNwb8GocUqgc2tz+7oR6ZDziJImAPpyAFxHi7CwxXo2aCEE5Kqk2PxV
 81/cB9J0MHS/a0J3fRw==
X-Proofpoint-ORIG-GUID: mfdKgguGmcFOLu_n7qffhe6ZNX3SIYYB
X-Proofpoint-GUID: mfdKgguGmcFOLu_n7qffhe6ZNX3SIYYB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX5+8F0wykgm8l
 J1zuxFp30WsvchvppGL7ii4xyvUIafWo/fE5fOEtCOCmj2LDQxY7BB0aacgVl7XiCs5MNNfkz6G
 BjjG6O7LRfB2VJ7sy6woaF2tU11qYys=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

The existing virtio_ccw_run() actually has no dependency on CCW.  Rather
than add a case for non-ccw devices, we can just put main logic right in
the virtio_run() call so that it can be used for other bus types directly.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio-ccw.c | 17 -----------------
 pc-bios/s390-ccw/virtio-ccw.h |  1 -
 pc-bios/s390-ccw/virtio.c     | 16 +++++++++++-----
 3 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio-ccw.c b/pc-bios/s390-ccw/virtio-ccw.c
index 5cb2158ed2..ea5dbc2857 100644
--- a/pc-bios/s390-ccw/virtio-ccw.c
+++ b/pc-bios/s390-ccw/virtio-ccw.c
@@ -107,23 +107,6 @@ long virtio_ccw_notify(SubChannelId schid, int vq_idx, long cookie)
                          vq_idx, cookie);
 }
 
-int virtio_ccw_run(VDev *vdev, int vqid, VirtioCmd *cmd)
-{
-    VRing *vr = &vdev->vrings[vqid];
-    int i = 0;
-
-    do {
-        vring_send_buf(vr, cmd[i].data, cmd[i].size,
-                       cmd[i].flags | (i ? VRING_HIDDEN_IS_CHAIN : 0));
-    } while (cmd[i++].flags & VRING_DESC_F_NEXT);
-
-    vring_wait_reply();
-    if (drain_irqs()) {
-        return -1;
-    }
-    return 0;
-}
-
 int virtio_ccw_reset(VDev *vdev)
 {
     return run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
diff --git a/pc-bios/s390-ccw/virtio-ccw.h b/pc-bios/s390-ccw/virtio-ccw.h
index a506767eaa..43d21906e5 100644
--- a/pc-bios/s390-ccw/virtio-ccw.h
+++ b/pc-bios/s390-ccw/virtio-ccw.h
@@ -16,7 +16,6 @@ extern SubChannelId blk_schid;
 /* virtio-ccw.c */
 int drain_irqs_ccw(SubChannelId schid);
 bool virtio_ccw_is_supported(VDev *vdev);
-int virtio_ccw_run(VDev *vdev, int vqid, VirtioCmd *cmd);
 long virtio_ccw_notify(SubChannelId schid, int vq_idx, long cookie);
 int virtio_ccw_setup(VDev *vdev);
 int virtio_ccw_reset(VDev *vdev);
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 0b33544144..34c5e6ee22 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -70,13 +70,19 @@ int drain_irqs(void)
 
 int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
 {
-    switch (vdev->ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
-    case S390_IPL_TYPE_CCW:
-        return virtio_ccw_run(vdev, vqid, cmd);
-    default:
+    VRing *vr = &vdev->vrings[vqid];
+    int i = 0;
+
+    do {
+        vring_send_buf(vr, cmd[i].data, cmd[i].size,
+                       cmd[i].flags | (i ? VRING_HIDDEN_IS_CHAIN : 0));
+    } while (cmd[i++].flags & VRING_DESC_F_NEXT);
+
+    vring_wait_reply();
+    if (drain_irqs()) {
         return -1;
     }
+    return 0;
 }
 
 void vring_init(VRing *vr, VqInfo *info)
-- 
2.54.0


