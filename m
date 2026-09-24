Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A27C98325
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 22:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9rx9-0000QJ-Qq; Thu, 24 Sep 2026 18:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9rx6-0000Oi-K5; Thu, 24 Sep 2026 18:30:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9rx4-0005Ez-RC; Thu, 24 Sep 2026 18:30:04 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5Z6J1896355; Thu, 24 Sep 2026 22:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=P6tbl9NdtovYKBprj
 LeqduLPRTuwn7kGUjAvElXustY=; b=nh9APYywByJKj0qT35mVlLfy/KLvjVvdW
 8c5Dl4TM/3l50cd3XnTtzHTvT504yP++2sz7DZMtDBSva0wLgFJh6Ft3VpnZT6sd
 lIMoSsZ2OVzm3pPXofAX/JpFUCfRJuSKYhYjE4s9JKuw9ZoHoqLNGhasqzBPNQyM
 J670vdLj29o/0wOxV4o/JJSOW6BugrrjgsX9CxiGWzEPii61pFQ7mhL0e7NkF27f
 L1ttyQednM0Sd8J0FgD1g8yswVAmQwIkITZL7+LLrW/FRYL6nGp+D6MC4CSLRybM
 VmvarS26V/QWrNpkp8lHkvWf4woYHZD9jaRdkLS0qk8H4+qi/J8fQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqu27v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 22:30:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlYg02521591; Thu, 24 Sep 2026 22:30:00 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2yws3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 22:30:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OMTxdc30933690
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 22:29:59 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3093F58052;
 Thu, 24 Sep 2026 22:29:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B8B358045;
 Thu, 24 Sep 2026 22:29:57 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.83.151])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 22:29:57 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v5 3/8] pc-bios/s390-ccw: Introduce virtio_tswap helpers
Date: Thu, 24 Sep 2026 18:29:44 -0400
Message-ID: <20260924222949.147720-4-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924222949.147720-1-zycai@linux.ibm.com>
References: <20260924222949.147720-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab5a469 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=nmTm2IjeaI_QYA0BkewA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5MCBTYWx0ZWRfX+td506oS+SRu
 OFkD23zzXbekrG4NSKiIqGcYhVD1a8rykeyur6Vi0pmbkqe+lFIbFMSjexDOsq82qwMMNSPjZpe
 WlSvCiIjZ1NkUoDFMG+1kAXGRenAvcgqrt865Q8JHxakzx1nl4Hakuli2KzYlSz8OIpX3GidWj0
 iU0CHmx0swJIt5snoFCXixqFUGyFl1EOf7REO2oSdSr3R0g1v9z7dlBKrvwwoe7WnbNBZIh9HY3
 64PiPxS16z/+zJ1ks19nw1ICqRMOGKsFTk+Wcm8lcHny1iD7nuA0qe8ILQh9O3vxrtny8xp8Tyn
 kDRr/6XdydSk48rh1qWRcGQ2ZV/7um6qHFfSW5fVCBfEouNoqfuUy5YuimtmKWInX4J4pq4s0/M
 /OvRF6hS4o4rWOsiO/JROezpM343ZYTJ0+kxTdT8l/yhXLh4PvQbRw6jd4vXs+V2sUUOWYVLlJ/
 li5wffldZWKBZqAQmQw==
X-Proofpoint-ORIG-GUID: gSWhgu9c46V_0pG26Y9rIBf8eigdjaO9
X-Proofpoint-GUID: gSWhgu9c46V_0pG26Y9rIBf8eigdjaO9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5MCBTYWx0ZWRfX/P7Wnk8q1AFg
 8+nd++uMDLHhmzrLpa+JNlXqvL2g9flqqdhw97sl6f3/wf4hHXCunr92rvLSu5hX4ej1ibjGwZR
 Drsc1ilp3T4rGJEnM3VO7hwOLk8k4+c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240090
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


