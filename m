Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0659C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQol-0007yy-6M; Tue, 18 Aug 2026 16:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQoY-0007ud-2v; Tue, 18 Aug 2026 16:53:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQoU-0000hx-IJ; Tue, 18 Aug 2026 16:53:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJWQma1294471; Tue, 18 Aug 2026 20:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=DzcKdScEVVW6+ZAl9
 rSticEq9HCccksw6wjyy64we9Q=; b=QJ2ZME47PTlrctZ5cAOLJfuKz7sOvreeD
 YsuZ2ju4dlaQ2+rY46CBy5aoWoT/e4p5QNwgZdmgxZlDEz2+680q9j+vQRfYDlUb
 R1R1YP6fFa+2utRxhk1ncX3zEZxHg/XYsHnDpxnKTRnLQnTAi+0dCaQFZT2oLktA
 jWjMUF0/JEyIt+qyGjeDZvxZ4ao9uROTpbxTzie/QYDL8RwX2mO43WteOcM8c+tD
 AZvFtsR7RCEPlHkFuuqcBwU9bR/BQ2+AyBsxbQbg/A1fnrYWsl+Th/vFRlLnPjF2
 m8TO6P8CxQtZpf0VFNyuZzkwahg1ZsSvy47jPa3tpW+kUc9tss5wQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frta88e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IKfNQN014347;
 Tue, 18 Aug 2026 20:53:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw5hth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IKrZnw51446092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 20:53:35 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3407058050;
 Tue, 18 Aug 2026 20:53:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B18F358045;
 Tue, 18 Aug 2026 20:53:33 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.136.182])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 20:53:33 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v1 3/7] pc-bios/s390-ccw: Introduce virtio_tswap helpers
Date: Tue, 18 Aug 2026 16:53:20 -0400
Message-ID: <20260818205324.580199-4-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818205324.580199-1-zycai@linux.ibm.com>
References: <20260818205324.580199-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a84c651 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=nmTm2IjeaI_QYA0BkewA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX1ne8rR1AyBMC
 Gs3Vi/db3sTXuvVUi8i+aP4pIv4LLGyEhDEsUDozRQG14YabIpC8qPcj3ZGwkJO+syj1XR6AEmt
 mDotUKaeM0EyuKLFWSb0wr8dnDo8EV0=
X-Proofpoint-GUID: ZjVXvhSXebwpJaOPvCq2rxr_IfvO8Jww
X-Proofpoint-ORIG-GUID: ZjVXvhSXebwpJaOPvCq2rxr_IfvO8Jww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX9Gl+RjUkufO2
 6tcyHIYOnDmOkQZ2pCmX+y7+13FzCTD6o7zSw5/lbQJ2oTfaMbXRcxMfeBICI/QpL0JpTbH1KW4
 Velqt7ViR8CHi2nldlo56Qa1GXHPA0u1auqSL6KDr9sFRCkOCSmNgUiZf3X4/5GOMt/bwEmn7N/
 dWKic8ORQdjxbPaby0c9zGoQcvUBPBmUZvQD7eKRZJDsxfO17tI7Sl8cQ310sjnx0RdgBqd+JzI
 jv9eQulVfSCt601Rrx4F8Rc/R4DrrmOauAdmyIOtLdr8IBln6zYGJYt2IDuTqAcgYomFZx9entd
 AwElCD2QFS8rsGsflwstBDAtV5XkMWt59Bvlo4fjab0AJw7aGG4SYWwauaWX1TH0/SUwZpoYXBH
 1yPsJV9pkvKg6ZuNQXcsGi0xHVQBgStBtkTGX/oFvbSW+ud1AV0hzg8PIQCLtamwDDvDzXSe7vu
 IldLaXOMJUY5hj/8Wcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

Replace the repeated pattern:

    be_ipl() ? x : bswapN(x)

with helpers that conditionally byte-swap based on the virtio transport
endianness.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio.c | 27 +++++++++++++++++++++------
 pc-bios/s390-ccw/virtio.h |  4 ++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index a0d249db24..037c00a3e1 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -97,7 +97,7 @@ void vring_init(VRing *vr, VqInfo *info)
     vr->avail->idx = 0;
 
     /* We're running with interrupts off anyways, so don't bother */
-    vr->used->flags = be_ipl() ? VRING_USED_F_NO_NOTIFY : bswap16(VRING_USED_F_NO_NOTIFY);
+    vr->used->flags = virtio_tswap16(VRING_USED_F_NO_NOTIFY);
     vr->used->idx = 0;
     vr->used_idx = 0;
     vr->next_idx = 0;
@@ -140,6 +140,22 @@ bool be_ipl(void)
     }
 }
 
+/* Conditionally byte-swap between virtio-endian and s390x native big-endian. */
+uint16_t virtio_tswap16(uint16_t x)
+{
+    return be_ipl() ? x : bswap16(x);
+}
+
+uint32_t virtio_tswap32(uint32_t x)
+{
+    return be_ipl() ? x : bswap32(x);
+}
+
+uint64_t virtio_tswap64(uint64_t x)
+{
+    return be_ipl() ? x : bswap64(x);
+}
+
 /*
  * Format the virtio ring descriptor endianness
  * Return the available index increment in the appropriate endianness
@@ -156,12 +172,11 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
 {
     uint16_t avail_idx;
 
-    avail_idx = be_ipl() ? vr->avail->idx : bswap16(vr->avail->idx);
+    avail_idx = virtio_tswap16(vr->avail->idx);
 
     /* For follow-up chains we need to keep the first entry point */
     if (!(flags & VRING_HIDDEN_IS_CHAIN)) {
-        vr->avail->ring[avail_idx % vr->num] = be_ipl() ? vr->next_idx :
-                                                          bswap16(vr->next_idx);
+        vr->avail->ring[avail_idx % vr->num] = virtio_tswap16(vr->next_idx);
     }
 
     vr->desc[vr->next_idx].addr = (unsigned long)p;
@@ -179,7 +194,7 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
     /* Chains only have a single ID */
     if (!(flags & VRING_DESC_F_NEXT)) {
         avail_idx++;
-        vr->avail->idx = be_ipl() ? avail_idx : bswap16(avail_idx);
+        vr->avail->idx = virtio_tswap16(avail_idx);
     }
 }
 
@@ -187,7 +202,7 @@ int vr_poll(VRing *vr)
 {
     uint16_t used_idx;
 
-    used_idx = be_ipl() ? vr->used->idx : bswap16(vr->used->idx);
+    used_idx = virtio_tswap16(vr->used->idx);
     if (used_idx == vr->used_idx) {
         vring_notify(vr);
         yield();
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 04dbc65dbd..3c84a480d9 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -287,6 +287,10 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
 int virtio_reset(VDev *vdev);
 int virtio_setup_ccw(VDev *vdev);
 
+uint16_t virtio_tswap16(uint16_t x);
+uint32_t virtio_tswap32(uint32_t x);
+uint64_t virtio_tswap64(uint64_t x);
+
 /* virtio-net.c */
 int virtio_net_init(void *mac_addr);
 void virtio_net_deinit(void);
-- 
2.55.0


