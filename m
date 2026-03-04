Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507DCEDEC02
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcSV-0002MW-Lf; Tue, 03 Mar 2026 21:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSR-0002KX-DL; Tue, 03 Mar 2026 21:59:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSP-0000Tx-JN; Tue, 03 Mar 2026 21:59:31 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623ETaI9658904; Wed, 4 Mar 2026 02:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Z/WZ4Ued9sMaAzGDa
 Mk8e5bEKDML/ZEaTDWfLPabYF4=; b=g/HL6k1g1dCqo/iEUnwWFSK50LAyGaRDW
 /Az0n2kVa7yhKQVntZOJi7S+/j+A8k2/q/n5cRb+mxX2qCyzjzWPqi91NUPoSw2a
 IJyh1aOELs9y0EUZ8O+3D1oMb5FIct1X9U3+YyJeOH79ZUuwtlVb366Dkgkrvmc8
 agUxFKsNrGq23ip4xyF5fl+OvpgcvWQRDgitMXrMnO/RM9gsRp4SYk90zxWwDqV+
 m6fiphR//cTv+6tZ6a7ttCm80WyknJ9jjaWdym+Ii9zMUC9AVhsTQ6KKH3gQa3wO
 rurEIxHg/wnN1WzP0dUWkafhgzDY+TREyQJNgxk//aatTSyRCUj/A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjddq73-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623MF9Tn029080;
 Wed, 4 Mar 2026 02:59:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmaps557b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:27 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6242xPKL28508714
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 02:59:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B47645805D;
 Wed,  4 Mar 2026 02:59:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8417658043;
 Wed,  4 Mar 2026 02:59:24 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 02:59:24 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 02/15] pc-bios/s390-ccw: Remove redundant vring schid
 attribute
Date: Tue,  3 Mar 2026 21:59:04 -0500
Message-ID: <20260304025917.2157032-3-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260304025917.2157032-1-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a7a00f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=IrE9pShrE_OzcS6fqDcA:9
X-Proofpoint-ORIG-GUID: DVPzLvqYyWAHL6x0fxGMldgOqB6WLdZr
X-Proofpoint-GUID: DVPzLvqYyWAHL6x0fxGMldgOqB6WLdZr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMSBTYWx0ZWRfX55VhTNreKm8T
 Tp6qyoe+Dxsw7l+uoRUO4CHkE425BSWOyJFiYXLWt1rR8/2Nxd9IDWkqteYC3VI0cyvXZAmxe4D
 fouLRfEJcsPg2KiovnFj+TpZdVfGF6Nn/f2PX15DmX+RMzOAk0xQQ8zBEKupcsr1bP8b+U4/T96
 t5pOue6+GoWXeFBEi96PJ7FEVsHEA/Ar4KgPvJ2GnC9LJCHFbet4cVEXHOR26SuFbuG4EEfwM24
 Nif4LwrNh3jxRCNI7p+m602++89FUU7m2NO0q3gGz2K0gKCKq9Yv2q+ON2qnykX/8l7EgVt0hqx
 DwFRwEj/VgrzhPH69NNZ1t1Q8DGpFPF3bujqzRHnDN1KqpNhfwSO7Bp8yO1Egoyzg+FKPmroPjE
 UC53ANzsGhc6+UPRIrebUl/QPBZ7r/u3O7AFLoLHlHt057Pdxnm2sWiDCNpEaI9T+YKNT8YOaaO
 pldGdijlpfVo92KtvvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The schid is already stored as an attribute of the VDev itself and any other
instances are copies of this same value.  To avoid CCW specific attributes in
the VRing let's just access the existing VDev schid attribute as needed.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio-blkdev.c | 2 +-
 pc-bios/s390-ccw/virtio-net.c    | 2 +-
 pc-bios/s390-ccw/virtio.c        | 9 ++++-----
 pc-bios/s390-ccw/virtio.h        | 3 +--
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 4b819dd80f..019c2718b1 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -42,7 +42,7 @@ static int virtio_blk_read_many(VDev *vdev, unsigned long sector, void *load_add
     /* Now we can tell the host to read */
     vring_wait_reply();
 
-    if (drain_irqs(vr->schid)) {
+    if (drain_irqs()) {
         /* Well, whatever status is supposed to contain... */
         status = 1;
     }
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index 301445bf97..7eb0850069 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -88,7 +88,7 @@ int send(int fd, const void *buf, int len, int flags)
     while (!vr_poll(txvq)) {
         yield();
     }
-    if (drain_irqs(txvq->schid)) {
+    if (drain_irqs()) {
         puts("send: drain irqs failed");
         return -1;
     }
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index cd6c99c7e3..f384a990dc 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -72,14 +72,14 @@ static long virtio_notify(SubChannelId schid, int vq_idx, long cookie)
  *             Virtio functions                *
  ***********************************************/
 
-int drain_irqs(SubChannelId schid)
+int drain_irqs(void)
 {
     Irb irb = {};
     int r = 0;
 
     while (1) {
         /* FIXME: make use of TPI, for that enable subchannel and isc */
-        if (tsch(schid, &irb)) {
+        if (tsch(vdev.schid, &irb)) {
             /* Might want to differentiate error codes later on. */
             if (irb.scsw.cstat) {
                 r = -EIO;
@@ -134,7 +134,7 @@ static void vring_init(VRing *vr, VqInfo *info)
 
 bool vring_notify(VRing *vr)
 {
-    vr->cookie = virtio_notify(vr->schid, vr->id, vr->cookie);
+    vr->cookie = virtio_notify(vdev.schid, vr->id, vr->cookie);
     return vr->cookie >= 0;
 }
 
@@ -211,7 +211,7 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
     } while (cmd[i++].flags & VRING_DESC_F_NEXT);
 
     vring_wait_reply();
-    if (drain_irqs(vr->schid)) {
+    if (drain_irqs()) {
         return -1;
     }
     return 0;
@@ -316,7 +316,6 @@ int virtio_setup_ccw(VDev *vdev)
         }
         info.num = config.num;
         vring_init(&vdev->vrings[i], &info);
-        vdev->vrings[i].schid = vdev->schid;
         if (run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), false)) {
             puts("Cannot set VQ info");
             return -EIO;
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 597bd42358..06ba4e45ac 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -103,7 +103,6 @@ struct VRing {
     VRingDesc *desc;
     VRingAvail *avail;
     VRingUsed *used;
-    SubChannelId schid;
     long cookie;
     int id;
 };
@@ -269,7 +268,7 @@ struct VirtioCmd {
 typedef struct VirtioCmd VirtioCmd;
 
 bool vring_notify(VRing *vr);
-int drain_irqs(SubChannelId schid);
+int drain_irqs(void);
 void vring_send_buf(VRing *vr, void *p, int len, int flags);
 int vr_poll(VRing *vr);
 int vring_wait_reply(void);
-- 
2.52.0


