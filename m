Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894BAC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZJF-00032D-LV; Tue, 30 Jun 2026 10:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1weZJE-00031w-MP; Tue, 30 Jun 2026 10:19:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1weZJD-0005Ud-4m; Tue, 30 Jun 2026 10:19:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEIXqY2124739; Tue, 30 Jun 2026 14:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VCQRjRmRZXn9/OTU0
 I0PqUrGr+FVL9UTjjtm7RHSfgk=; b=CfF99wl6dp5lsG6b1jlZKfXZqFs6R6zUW
 cag2bl1ZitHKve0KysTeXYofT8rvnxjYr1kPuJPgemNOr2SpLRpVAhm4wLetkEJN
 nZBPq7/oJP6UYKGKQJFNmE2FU6R482Esq4X4nV1OFrZWa3C4ClEHpcj5ZLfPC0Bt
 5ICsUJJJhO/Ao+AQTp4NFurB/WB85XP80bb43zMlo/Q59I7CXkqT0JUypOCv/g0c
 PHdZUyLTBkPacyfeaUZbs6eyBAvF+SHmtnlL21ZG7E/ypUp6sp/2yIzhgubV9WoV
 6KdK5KvVQ1MX9C/MxHJz6xQstamkXKJvtGEPi4B3iu0vkBh1YRZ/Q==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjq020-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 14:19:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UE4cDV015910;
 Tue, 30 Jun 2026 14:19:28 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhaj3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 14:19:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UEJRTo10552052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 14:19:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5BCE58059;
 Tue, 30 Jun 2026 14:19:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A462E58043;
 Tue, 30 Jun 2026 14:19:26 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.10.219])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 14:19:26 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com, jdaley@linux.ibm.com,
 jjherne@linux.ibm.com, farman@linux.ibm.com, nrb@linux.ibm.com
Subject: [PATCH v2 1/6] pc-bios/s390-ccw: Refactor byte swapping
Date: Tue, 30 Jun 2026 10:19:12 -0400
Message-ID: <20260630141917.673995-2-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260630141917.673995-1-jrossi@linux.ibm.com>
References: <20260630141917.673995-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzNCBTYWx0ZWRfXxTI0uW4q7imP
 6lR4Mqve5uLUEpQC5yDbJoIjF7ZWlrouGCGLzrZEFozcYnf3w/2Orcan06eleAvov4z8bA1mOX3
 Z8j4FvzsMGt4PwtpHdZMIM20HOkRvYSTTemze37mOBZbwiYTMfny9b91NwcsMqRc9qNyG0j1Ype
 6jPeY4mKjXzWJPb9MgEQeRLBt001X1DZnndZaI67U26LFrmMNAkEnWLbJ74JlKMTyJ+OmwHChY8
 BblxERNBfpSaq3qv4udmcmXjdzS1QpUdMwZxjtUv36cEM1zngoAUV73d3TJeCLU7pcm9mWAFoHs
 PM7en+psE8FIsXhdkaqYEQy/qbgBMjohjxVJDLNVtJesgHB+MgUlccU3GujIdqzdpVbt58S7Z6J
 AcxcEve0ytQpLHg9eVdqqAwf7iMoWVzIgAl/s9SBO4L0UonO/QTnlsC+Pabgfi7gny+mlhcqPo8
 8nZpBWpKGQ3D0/haNpg==
X-Proofpoint-GUID: CSXA6p9QLalY-n6jDtEHnPvHHYooAtC2
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a43d071 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Mh-7s8SilpXd35hLZrsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzNCBTYWx0ZWRfX2zTxrnwreTB1
 xj9fOmRtNgfbecZqivghQnUjhuY1ovpFpxAnnosm8MngoUgFToYCYkJKzZV9MYoxdQcGfh3mXw3
 JuMi2nX9RAdSA+cB5KgG6qANBKZGkPk=
X-Proofpoint-ORIG-GUID: CSXA6p9QLalY-n6jDtEHnPvHHYooAtC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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

From: Zhuoying Cai <zycai@linux.ibm.com>

Introduce local variables to cache the byte-swapped values eliminating
some redundant byte swap operations.  Additionally, do byte swap when
polling to avoid a special case where endianness is preserved.

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 390b55c7b9..a448dc96e2 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -153,14 +153,14 @@ static void vr_bswap_descriptor(VRingDesc *desc)
 
 void vring_send_buf(VRing *vr, void *p, int len, int flags)
 {
-    if (!be_ipl()) {
-        vr->avail->idx = bswap16(vr->avail->idx);
-    }
+    uint16_t avail_idx;
+
+    avail_idx = be_ipl() ? vr->avail->idx : bswap16(vr->avail->idx);
 
     /* For follow-up chains we need to keep the first entry point */
     if (!(flags & VRING_HIDDEN_IS_CHAIN)) {
-        vr->avail->ring[vr->avail->idx % vr->num] = be_ipl() ? vr->next_idx :
-                                                               bswap16(vr->next_idx);
+        vr->avail->ring[avail_idx % vr->num] = be_ipl() ? vr->next_idx :
+                                                          bswap16(vr->next_idx);
     }
 
     vr->desc[vr->next_idx].addr = (unsigned long)p;
@@ -177,23 +177,23 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
 
     /* Chains only have a single ID */
     if (!(flags & VRING_DESC_F_NEXT)) {
-        vr->avail->idx++;
-    }
-
-    if (!be_ipl()) {
-        vr->avail->idx = bswap16(vr->avail->idx);
+        avail_idx++;
+        vr->avail->idx = be_ipl() ? avail_idx : bswap16(avail_idx);
     }
 }
 
 int vr_poll(VRing *vr)
 {
-    if (vr->used->idx == vr->used_idx) {
+    uint16_t used_idx;
+
+    used_idx = be_ipl() ? vr->used->idx : bswap16(vr->used->idx);
+    if (used_idx == vr->used_idx) {
         vring_notify(vr);
         yield();
         return 0;
     }
 
-    vr->used_idx = vr->used->idx; /* Endianness is preserved */
+    vr->used_idx = used_idx;
     vr->next_idx = 0;
     vr->desc[0].len = 0;
     vr->desc[0].flags = 0;
-- 
2.54.0


