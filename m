Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4F4C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x180e-0000Mq-H6; Mon, 31 Aug 2026 15:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180c-0000Kw-AB; Mon, 31 Aug 2026 15:49:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180a-0002cs-Jv; Mon, 31 Aug 2026 15:49:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIVUuX1234644; Mon, 31 Aug 2026 19:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TcrP/asZ1aRGHrgtq
 HxYHFyagOlxTqH4UnirVRKx7QM=; b=ZSiD+0DcJG6SkbgTPFi4Jy9Hu3BUn/z/F
 NGkyronCYIRE5Hr4+7BUM7x7wUnmyI5QizsGcVXQi63xZ/UkehMBvQq/yjQ/PlNF
 JtiGmeeqfkiPK3xdCk8qcaY2jYjEX6YUiiaOB+IucS8iVooZ1Y5W8395kUJy6fXo
 204EPOzbRbd0jrAOfqhYCjvxbUkyXr2JbqQ0GR91YoEE6SRdEoX0CDMqJ3OcDup5
 7yoiOO+ML3l0hPADrziicHUFsrAbIqQj7Cyks+EUlIw8IXulUP/B20PMyhNY4fq7
 L1ElQxgA/KW+11rCPbzBs8/HZGi24CABXooFsHorUUUJv/bGnqCcQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r3fyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VJfiCm026976;
 Mon, 31 Aug 2026 19:49:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexyjam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VJnTCQ21562018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 19:49:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE0E758056;
 Mon, 31 Aug 2026 19:49:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6756058052;
 Mon, 31 Aug 2026 19:49:28 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.69.254])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 19:49:28 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 zycai@linux.ibm.com
Subject: [PATCH v3 5/8] pc-bios/s390-ccw: Abstract virtio_run() for generic use
Date: Mon, 31 Aug 2026 15:49:16 -0400
Message-ID: <20260831194919.3830270-6-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260831194919.3830270-1-jrossi@linux.ibm.com>
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a95daca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=0PGiSlKGR9UV7cgr1PYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfXw/EScuzKZn7V
 EEBRD06beo1nKKualmYCiyAC/zqJjUseNbdOWjhK62x/ZwxIJK9RUB5rF27JG+B0Z/cCovGyaZO
 bCgGF4sEJRa3M08/cza41u7Yyt3Sy+yTA4qbZFI2EM+58hdNr4t0CRJwa9h4TBBwVvFczZXt/fC
 agyVIm0zSAq5hIKejf19C/TWsqI7CnHxd7en/NiFhM3auhVgRMrYcin6R1zlWnBw3aKmI0JAWvq
 1d4AgOfhE1CAEDU5Ni5YKgEsPttkB7p3riaL2zRxKC+G8OfCKwawcFKaIlIHH9BLBpsKmWhF1UQ
 XV0cnq6VhYIGAU6cSPsDHPsq/rQqjbprsYAFB4yOx3E8bIaCT6eQq5Xy3385YyKOnp+djRnc84V
 Kake0QjWyV45sv5u6/RvN0hd6eTDt/qRRmhQhZRNT/TzMT8LqSySIKqqnmAbvYjzvANniIyY++Z
 c8wd+kk4IEAPMoxpKrw==
X-Proofpoint-GUID: UBoih_7GcWc0IQXEcBLI7lUgCcUMSOLp
X-Proofpoint-ORIG-GUID: UBoih_7GcWc0IQXEcBLI7lUgCcUMSOLp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfXzAGutReg0pW1
 sB4dUInO42g5XHNJxM8BOdCVGv7AOq9PPGAP5h+OAWnufRiJxHOVur7jC/1zrcb7F5LADJrjpap
 gjS38LJwYAYdNh8Td6E6lZic3X2wrUg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310169
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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


