Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E05D3409C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklkG-0003wT-1V; Tue, 27 Jan 2026 11:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vklja-0003YX-C9; Tue, 27 Jan 2026 11:16:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljX-0000k5-9A; Tue, 27 Jan 2026 11:16:06 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R5dVcL013677;
 Tue, 27 Jan 2026 16:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HhtUYhPQrqqybqNk5
 G/9CaIxhOVsRzUyUOr2HMqmQn0=; b=bLQiJNeCRnwMyMJrrJj/R8Z0iZ2BXbeme
 goIRddh6Xh8LMNrpGWLyyBmkrj6Ab73OhDpqM7gCASU4cCqVm4rqelSPZMQf+4oM
 p/wMH3noPK1sHECZVoI4OSDeYUh5lDTm/PowB+JArPe2hgp6cKP1BXIz/U6ktRuR
 LlVlxM/7rSjphvcNL9IAiyQfUGhzmcYQqWXbqPeCO6Pr/gINxAZx+MGGM0Qz1Px4
 Lnq5uGOeD0N5SBoGfk5XiXpm5t3eDTuKMiRRax3JEq5e0d82IzcBhwayZooHO13s
 sQ3pzU8bQ5zMMMh8UbDWerulkofPXIWg0b/iIVP8mLSiVAzlpDQ/A==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfvr35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:15:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RD0Boa006711;
 Tue, 27 Jan 2026 16:15:58 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sy9e2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:15:57 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RGFu3I30278162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 16:15:56 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C5865805D;
 Tue, 27 Jan 2026 16:15:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E2D05805A;
 Tue, 27 Jan 2026 16:15:55 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 16:15:55 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v3 02/14] pc-bios/s390-ccw: Remove redundant vring schid
 attribute
Date: Tue, 27 Jan 2026 11:15:35 -0500
Message-ID: <20260127161547.459443-3-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127161547.459443-1-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=6978e4be cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=IrE9pShrE_OzcS6fqDcA:9
X-Proofpoint-GUID: eSR-CKddYWU4-TrLElhnRHSbC5cvD8L4
X-Proofpoint-ORIG-GUID: eSR-CKddYWU4-TrLElhnRHSbC5cvD8L4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfX+3d8jUWodxja
 gW0PCzvrrNjdTumJ1eoaMfn5zHXxjmlrIvbXlR9h+wYP/Nfe0Z0Ja/txr4w4pjXK/RWCNFMiYzH
 HWhBXz4LPKztbE1lt9BkVWb3HaWfi8qJpC/g+vCl+VmOh8EtUghChY1jb5r7XmI39J8eO10Iktl
 LMiCINdSU/jC1tKnXbmGxPaBra3R/TP83xC01J8P8bJB3mOx3fvWmb8GsvP4cz8qPuSc5Knzn9k
 eaKN1DDj1lwh62eLpPm9kUEjPbuBfVUIFSWD/yh1uipCpaPlEHocKdgpLrcm5ITm3M23P7pm47m
 pJmGwziQZZ2W3A67CPAc6WiCGH3pjWG7EXX2acbrVKsS4jKqSEhLxUtlfhm5psVrw+LLXBiP+6h
 owjnyG6S4Y61Togeo5RZ/5F4z1ouxNtCD+cpvucsHTt3VxUXRkPcE2+ssM/FjnMpHpPdgr8aAvl
 6n7QztDk/ahm7kTJ5mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601270129
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

The schid is already stored as an attribute of the VDev itself and any other
instances are copies of this same value.  To avoid CCW specific attributes in
the VRing let's just access the existing VDev schid attribute as needed.

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


