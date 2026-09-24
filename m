Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A23C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 19:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9pRA-0003xh-P5; Thu, 24 Sep 2026 15:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9pR6-0003wK-4W; Thu, 24 Sep 2026 15:48:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9pR4-0008AP-6i; Thu, 24 Sep 2026 15:48:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5YAO3107453; Thu, 24 Sep 2026 19:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=P6tbl9NdtovYKBprj
 LeqduLPRTuwn7kGUjAvElXustY=; b=VAZZFOEV0tB+RSf8DdeCrbhfSFICwMNs4
 aPmeGmQ+loextBBstn37V3KXj0GMNQepcJ3EAYz+yObgIMKDDXncvRVeezolHGqY
 Q/EZWhhqmTU3XS2mMisHTF2XCZ/yBTclRvfPEzDmCr9wlEkExVftRKdM2g6hYeiK
 9H/m1ixhk5tqjq97x0hqGnACpRe8+ccA+CZ3M3wk5qzcS4dzpoBofEkuk+Q4+Sqc
 +KkVWEGpqBQdHlwcGk7jISaTBVB1rE//9ZWOXf8GgiOrOmXErwbkYgRZg35xqJv9
 ofVZu9uclDVj0CCrCc/vKYCCzfgbSkjdXnrc5bO26DoqDNp5s6zmw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvjfv3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 19:48:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlXDe2572657; Thu, 24 Sep 2026 19:48:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jygae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 19:48:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OJmkBx3933084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 19:48:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8F415805B;
 Thu, 24 Sep 2026 19:48:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A4C358059;
 Thu, 24 Sep 2026 19:48:45 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.83.151])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 19:48:45 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v4 3/8] pc-bios/s390-ccw: Introduce virtio_tswap helpers
Date: Thu, 24 Sep 2026 15:48:32 -0400
Message-ID: <20260924194837.80732-4-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924194837.80732-1-zycai@linux.ibm.com>
References: <20260924194837.80732-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CoX9tRmLp7zVIIi4yw5xASGHOX7aDzlQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4MCBTYWx0ZWRfXyXEF8zs/tWn7
 WoYPHdxzxcdEAeYSS/RlU165ageWT8/5QPUsKXcZlcaLU9+mO663/mwb27CybUxQ+Us+t1IByKN
 eMtfnQ4H4z0luLiVFC56avPrWDqkDeQ=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab57ea0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=nmTm2IjeaI_QYA0BkewA:9
X-Proofpoint-GUID: CoX9tRmLp7zVIIi4yw5xASGHOX7aDzlQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4MCBTYWx0ZWRfX2z41XTk6E8F9
 AtPefFzr9PkDJjiRd2PjYBGpfbg74T2YJwj/jrq6+Ka233LGMZZU4jwbMASh7tkLpjMB2wPS6xX
 K4uD3qh1QVbgPGeapmoat3+I/IdcZ3iCBS1xzk513Ngk1mUMND0QR06qLdCqvDynqFjyRCmbBIC
 IiyljOj6kzVHIov4qARDBDr9JBvYxhuh3hPq6rpa/rpR0GywBL9K4rLPcvNImGMKF9kFFTvWws1
 pUcX6LbtwGvZIdxHLFDM4YoQcAim/Q2pXSGTcStDW99zOW9HlWMnHYGxIYalFoAVX8yaFvSQ5Bz
 5rXDh8lxGzxRhNtr0xw4F+WW3al7Pk6k4dvg0HxV72feR9GMHsfBm0zGb+iu/irvGIxh0brTDEo
 IHpALFLn9kM5EQKCUL61rbtOuP47qtoyYS+nknfP0r3GGyvv1ZAsnFRjXHZOQd08B+TXPjc5p89
 r+GS2lbeBUvFtebMjEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240080
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

While only the 16-bit helper is used immediately, the 32-bit and 64-bit
variants are added here for later use.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio.c | 27 +++++++++++++++++++++------
 pc-bios/s390-ccw/virtio.h |  4 ++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 34c5e6ee22..8949e6c7c0 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -102,7 +102,7 @@ void vring_init(VRing *vr, VqInfo *info)
     vr->avail->idx = 0;
 
     /* We're running with interrupts off anyways, so don't bother */
-    vr->used->flags = be_ipl() ? VRING_USED_F_NO_NOTIFY : bswap16(VRING_USED_F_NO_NOTIFY);
+    vr->used->flags = virtio_tswap16(VRING_USED_F_NO_NOTIFY);
     vr->used->idx = 0;
     vr->used_idx = 0;
     vr->next_idx = 0;
@@ -143,6 +143,22 @@ bool be_ipl(void)
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
@@ -159,12 +175,11 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
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
@@ -182,7 +197,7 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
     /* Chains only have a single ID */
     if (!(flags & VRING_DESC_F_NEXT)) {
         avail_idx++;
-        vr->avail->idx = be_ipl() ? avail_idx : bswap16(avail_idx);
+        vr->avail->idx = virtio_tswap16(avail_idx);
     }
 }
 
@@ -190,7 +205,7 @@ int vr_poll(VRing *vr)
 {
     uint16_t used_idx;
 
-    used_idx = be_ipl() ? vr->used->idx : bswap16(vr->used->idx);
+    used_idx = virtio_tswap16(vr->used->idx);
     if (used_idx == vr->used_idx) {
         vring_notify(vr);
         yield();
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index aa307025e0..645dc288b1 100644
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


