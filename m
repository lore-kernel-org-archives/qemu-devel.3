Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AF2CD342F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 22:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK1b8-000210-80; Mon, 04 May 2026 18:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1ag-0001vv-Gx; Mon, 04 May 2026 18:16:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1ac-0002rp-5f; Mon, 04 May 2026 18:16:36 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644EdUZS3352054; Mon, 4 May 2026 22:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+3QkYVr0hUmoBCdQG
 PlXBbNPoa12+z4M4QE/ERmfb60=; b=TxNjvGAgn0/kA7DgF5GRX5suJ7hoq/Ydh
 tLRRQqltlVzwFBqNdgowzEYzW8n4mQXWjq4l6R7CMIzXz3Q31oxthlOvGtMlOGGA
 RG5uR+Bo5K90tS+e50fiVUcudJyzaHeFDzEApPI99qtC2g9lbQ1D5LxECdA9GouH
 RqMmBd8XEDHr4mHXLgS//SO1xgSHLtSH4JAfeXZEfrj4vh267cbEMV8UjX031bxL
 kHx47giHao26qcSMz5F8zpLXUPxswA3XDyjqhBhqXxcOj59kSMI3qGyDmBaq+kbm
 Cp8ndeIX8JQXOJtuiRCwu8qAbqAwv2Ok5Nz3KXykr0mjMc9Fv86Cw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxgty9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644M9gbi012907;
 Mon, 4 May 2026 22:16:22 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3gxyuu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644MGLft15860456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 22:16:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8A4D5805D;
 Mon,  4 May 2026 22:16:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F29F58043;
 Mon,  4 May 2026 22:16:21 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.119.68])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 22:16:20 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 3/6] pc-bios/s390-ccw: Rename Virtio CCW run function for
 generic use
Date: Mon,  4 May 2026 18:16:10 -0400
Message-ID: <20260504221613.826825-4-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260504221613.826825-1-jrossi@linux.ibm.com>
References: <20260504221613.826825-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDIwNSBTYWx0ZWRfXxBey4f6BcSl0
 N7iHT8RDvA1knZWa4zKGyijyAHnXHQvoHuifpOSHbnkYII63R9NIPTEOFV0Y6dDhpRRa0Ya54GO
 jHZR7dcncNXAcwHpn0XNpYACmdeoxXzeIxLBIxc3VUzjq4ffdhD46Cd1ugQ3M0rze229DFSMukH
 fUWfFYlf0Dgb8MfQWgUTGS8LmE1S/UHiXePVJw97/Aaco22QpC528s210jbAOl/KX4nq+tx7wCN
 TDZhY/NHIR+oq069Truw9++hFLFetTMNWt6yPWQZOh86LNFjPsPdRHG14CvRAtPyRfWKTbp6T6g
 2iz2z2uK+Z4SYnqB/sYd2xdV5mjLbLNlMe5ISwE9BnjaqUJGuOmZCSgyBqdBtItuO39vnjQrlwM
 IasoRDetGED48IhBA7vsOwc6dC99yWWt1j235B9hQpNyv9HaGbyIhzLkR80mBDsPwjGGx1NU/wR
 xXA1/CJinSpwuyGWMYw==
X-Proofpoint-ORIG-GUID: ajAHJUGzEYBaQ2r58Z58lwqRnzSZltUP
X-Proofpoint-GUID: ajAHJUGzEYBaQ2r58Z58lwqRnzSZltUP
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69f91ab7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=HwR0zErlyjH57yb9cWcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

The same function can be used for issuing both CCW and PCI virtio commands, so
remove CCW from the existing name.  Additionally, move the function out of the
CCW specific file and make it static.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio-ccw.c | 17 -----------------
 pc-bios/s390-ccw/virtio-ccw.h |  1 -
 pc-bios/s390-ccw/virtio.c     | 19 ++++++++++++++++++-
 3 files changed, 18 insertions(+), 19 deletions(-)

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
index 00850acc2f..79dccdcbfc 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -69,12 +69,29 @@ int drain_irqs(void)
     }
 }
 
+static int virtio_do_run(VDev *vdev, int vqid, VirtioCmd *cmd)
+{
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
+        return -1;
+    }
+    return 0;
+}
+
 int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
 {
     switch (vdev->ipl_type) {
     case S390_IPL_TYPE_CCW_SCSI:
     case S390_IPL_TYPE_CCW:
-        return virtio_ccw_run(vdev, vqid, cmd);
+        return virtio_do_run(vdev, vqid, cmd);
     default:
         return -1;
     }
-- 
2.52.0


