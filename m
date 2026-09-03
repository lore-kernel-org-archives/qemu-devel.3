Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9BBC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AFP-0003vq-Nx; Thu, 03 Sep 2026 12:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x2AFM-0003uW-2D; Thu, 03 Sep 2026 12:25:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x2AFK-0006W6-76; Thu, 03 Sep 2026 12:25:03 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2Q5j3425608; Thu, 3 Sep 2026 16:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=oF035lZWSOugjvxdi
 pCuYzntpXytqybUreJPuzPgrdc=; b=UrZQCPty7wcDbKC831RKwCOMk3OcqYvE9
 uaue2EFIvPKgjvu90QlMVpzJkVDlmoofeYCJogyAdIYTUvrTYCla5LfPjNS4Oyax
 4M2Cr3J2Vpk+/omoYSZggj7/L/dKud9NFi8B77aA3yf41oV9Kr8394sua7NNcrGj
 zIM8rhanfWhY15EtOvjoeOE+ysF9iwQTKbDQiqmnERfAHwPJl9UWhasT2YHmkkZ/
 2KTIL9CPVUIG0MeriKXoeQ45dYpiMASIJMxrM+VlZvCY2a/2vh56NAbvWkUweU8U
 lFrERrMZn0GxIaoB9NbV3IHbX4k3uB2GUNG6y2uS9WIXQx0SpqOOg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq555x3a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:25:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GBmIA006194;
 Thu, 3 Sep 2026 16:24:59 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjartyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:24:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683GOvj226280464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 16:24:58 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A89875805D;
 Thu,  3 Sep 2026 16:24:57 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A93C58059;
 Thu,  3 Sep 2026 16:24:56 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.144])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 16:24:56 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, jdaley@linux.ibm.com,
 pbonzini@redhat.com
Subject: [PATCH v2 3/7] pc-bios/s390-ccw: Introduce virtio_tswap helpers
Date: Thu,  3 Sep 2026 12:24:45 -0400
Message-ID: <20260903162449.2588271-4-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903162449.2588271-1-zycai@linux.ibm.com>
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0MCBTYWx0ZWRfX1wLAby29xgVu
 R3VRyrZFqf75iM9H+W7mGtM0gPb4nfFK2uKwQXaWJ9ujiibVKInkgsrv82qadxZ7NM5sZs8UKGk
 frwxRcovX2pFQAjlAexzSIOQLjolC/MjnrR/izMsrB7HQARc/hWSbKd03xZzAZMAqGo+I3UIlEe
 JCGDHbmxcj6nX4PTXqnOPZE8oTR+7PogPT+Acq7eInO1ukRKwj8mgF54rdttUYkhLXQxeJhXgmN
 m6xx8REvXsMelnQue17G9UTbM4Fhwd3aB+Gvl/Zv9UrtmihstF+rSPRTMS55rt6RZ1XN/dpeEAU
 yDS28aeI3WGkFLoPPzvUcmCRNb6zFuaNxpkX9a0dn1cyNcTHMWJxZvAvBr7kH9BSvsYOdfqHnwP
 RuIawICJ37SXnpyr2CZbrgN33ZLYQhwbTsIg/EzuQeyl0ZZybkGvvde/py6jcCVvOieX90HMIFI
 5MSwes6ELOoWxHW1IVw==
X-Proofpoint-ORIG-GUID: DnudH2s4T7e2xTR1z8b19JgWnjp01X1W
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a999f5c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=nmTm2IjeaI_QYA0BkewA:9
X-Proofpoint-GUID: DnudH2s4T7e2xTR1z8b19JgWnjp01X1W
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0MCBTYWx0ZWRfXywTo8AdguKz+
 tRnBzML0YFEg5+kHvPwbWoiV+exiXBQWPRJWZUL8Sqzoa0eH0ZdrPLLtI+KJQ3En8OPbsE5Cuab
 og2sNWEu/RQWoOmA786ByfcJv2ge8Hs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030140
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

Replace the repeated pattern:

    be_ipl() ? x : bswapN(x)

with helpers that conditionally byte-swap based on the virtio transport
endianness.

While only the 16-bit helper is used immediately, the 32-bit and 64-bit
variants are added here for later use.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
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


