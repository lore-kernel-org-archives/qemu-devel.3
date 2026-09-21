Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15273C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kKM-0006Tp-P2; Mon, 21 Sep 2026 16:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKC-0006D4-Ql; Mon, 21 Sep 2026 16:09:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKA-0005PH-Gg; Mon, 21 Sep 2026 16:09:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8NVF1869625; Mon, 21 Sep 2026 20:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6d9xzvsVRtXXMEMmq
 eJv7dmZV7NSgM+UQYeH4PMjA2Y=; b=azV22Li51mGerXmeoigL+HBuAK2Y7nzcp
 CU/xRyyzCIt63I68ayS1wChMr2f7dLlamExdpnuubWh9Th4Zy50ve1ysnEodac9u
 X94re9Ye9YxVqmJmitpVwLwY7dTln5MBI3oO+CmquhFZDeV52MLnMgjf6+lLsjDn
 HGv3iF0APeUUfbUjIa+3cpg1HG3ZqFHnvAYDChZTZyANePAuNTJ6GbO65gterYey
 0IVtr9rMJfQ64DXV5xgpjnkwfTVL1kqWtj87YJ5ZlykkesrsDeE0PFe3ekBDU0Oi
 qrrx3JsNKiUwtkThUwsGSXaM9kJH7ULsMbsOyvbQqtZ0xa+nkhW6A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs2h2s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJKJMx167161; Mon, 21 Sep 2026 20:08:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bk9f18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8m6b55247158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE72158043;
 Mon, 21 Sep 2026 20:08:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B39A58055;
 Mon, 21 Sep 2026 20:08:48 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:48 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 28/33] pc-bios/s390-ccw: Abstract virtio_run() for generic use
Date: Mon, 21 Sep 2026 16:08:25 -0400
Message-ID: <20260921200830.1302919-29-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab18ed2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0PGiSlKGR9UV7cgr1PYA:9
X-Proofpoint-ORIG-GUID: bnC2ybh97jtiEWxWCTFUOPOwXUYEezh6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX/SotjiKaqqDf
 00jAoM4FzEb9HG7UN3IycfnBQ77jIz57VRtLzc59UgbKaHmcvNHm8eDJrB3eL94ZLib2xKLvPUI
 7K7kW9Fmc/XvOOFY8OfbpD9svcPOf8fC7nUt6ub1dlyABxyNsTR5d/JVuDLZICGjP7yIGesRqjk
 QguGW8ENlct9tqQiUHeIsxaUna/4JWqv+KgFHHO34JdWVNvXEjAdPKiaiBDAznE/ei0K61D0l0B
 ktxDwx/uAhVc7v/JRjWtXbrc8irwtyWAC4Ay+Bx4viVN8HSekDaw95HgjXeo2nqITGMY5yBQWw3
 O/3IqHP/HZHmpyfaMYMncvXBuEmm1GoNd+a2I7GbXSkWHkvWdXUSIv6U8gZsBD7WbYPw13RtizX
 FtTLMoF5l5vPOsG6qOn2cAHV7KiQ1NHCy1DLZYIF2KHd0z5ylP7IK6gZvH6UWe+1ho5OJW+GNL7
 RiZKqxk4Ql9pxKXskAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfXxN2JYgLJpZ8O
 1OIbEBRdJwVQl2r6jOZpFp3uq1yLsZmfGJYvQWaVeg2ysOfB1aWFC06Wra3/rcv/0PzlSWCKvld
 N/13lAlzGsM4Npsyrvhf4lrmsPHK2r8=
X-Proofpoint-GUID: bnC2ybh97jtiEWxWCTFUOPOwXUYEezh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210294
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
than add a case for non-ccw devices, we can just put the main logic right in
the virtio_run() call so that it can be used for other bus types directly.

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260831194919.3830270-6-jrossi@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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
2.55.0


