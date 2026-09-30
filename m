Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80170CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAk-0008TK-TU; Wed, 30 Sep 2026 11:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAe-0008Jf-5Z; Wed, 30 Sep 2026 11:24:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAb-00021s-KG; Wed, 30 Sep 2026 11:24:35 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5RSe3171022; Wed, 30 Sep 2026 15:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6L2iiAoz9OL5aGyrN
 fNlKZXj0OmSpZ2iShMOfi+djuM=; b=cuYvbagxDfN7UTHHwBLUCNgx2NsO31RDw
 lmEG4TEXbQKEhOBgQfFK0ELR8pOA5RRI7fa1UAbNEYXBI0v/3bEABr6jT3sHQvka
 uDQRYM973edqJRFNrU/glc4/Af90JYle7GHXiAqXyN0vdFE+J270azNNzDZ4F9qW
 ljE2XPLGqs7IAiXeDIQ74u6Pv5DDQb3XezxdGlz0mOSxXtrwp1bJyy5apP6S3pz+
 f89V8h7cDhmcCffwpYhiuln94bdfgbfvV/CS3CT9R+OEBepNh6ga9Rz3+m5kbc2c
 /AQMzY4XLMCApcwhKPwLE/rjnvxSbWaoIySj9CBEe88AWXFrWBEaw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5dtrc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE38Db3541491; Wed, 30 Sep 2026 15:24:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpcetc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOTwJ27853406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:29 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 627BD58062;
 Wed, 30 Sep 2026 15:24:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFBFE5805F;
 Wed, 30 Sep 2026 15:24:28 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:28 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 13/23] pc-bios/s390-ccw: Introduce virtio_tswap helpers
Date: Wed, 30 Sep 2026 11:24:10 -0400
Message-ID: <20260930152420.1956230-14-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX426Q0xZnvazd
 jA2E+yPdrvzhcNZt+SlRiQ+p2d7IT+q4V7vN5GjjtPNbAsao7k+oKuTpb5Px3pCpEGTFf5PsgTv
 eCFCPGLVQ26LYJJxFsDg3S4YAfPj9oo=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abd29af cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=nmTm2IjeaI_QYA0BkewA:9
X-Proofpoint-GUID: EAAKisH_vAYT3TiBW_nBlHQNSHyAsG_D
X-Proofpoint-ORIG-GUID: EAAKisH_vAYT3TiBW_nBlHQNSHyAsG_D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfXy4eBhMrnX8L8
 AsuV6lJYJAumaQtYQhn8Eq1h3aUpRyB5ls74HPgd1Wsmf4vsdLarv/CS8UlyY22bHR2eo5vhYv8
 ztjKSNRMICWy6NOzOoDenogYz+2QipFS9Te7KDY94Q6b8If1/h48LHO5GgLALSwzxyIwfgpjAe2
 HEjYoY2AG9KgVE0OjzFTywQen3aPNJZ4UnoCXyMfrHcKfRNhCA9ljdt1vRrwJTQUJNGCnbciv8i
 9d6VqiFb2jNWRerHh3ajLg/Aw4NYuhilWuHWUMLiKkxxhF8Jz7Et3OcZf61YYjaS9ZfuXZPFfW8
 EN9lTf0NxgCnWC1NF+sJckWfhnPbchVo+issPhO956FKcwug0CEkPdy3YYCPAQpiChc+pGY6nth
 HRACW6cI2qe+z1ziewHdo72dHaIbSwkl7pTxcuNWnPwr24ECEZfpfEyw07kTA8GFixIFjFjG00a
 DfT+pz7aQEiRGF3J5yQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300060
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

From: Zhuoying Cai <zycai@linux.ibm.com>

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
Link: https://lore.kernel.org/qemu-devel/20260924222949.147720-4-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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


