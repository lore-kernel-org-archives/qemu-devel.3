Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFF4C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfWG-0005d5-M8; Mon, 06 Jul 2026 05:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgfWC-0005Zt-6h; Mon, 06 Jul 2026 05:21:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgfW7-00063z-3w; Mon, 06 Jul 2026 05:21:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6669J4xg3152755; Mon, 6 Jul 2026 09:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=56pydjf83ON+u/iG1
 HDD+ibNtZnQ0adUhpl1mkJg5+Q=; b=qtKUr70YHczhz5UUcciyxNiJkiXOyKt+q
 WZDBJjywMZSO9XqmCt0v4tVBq6tXf8mLv/TUc5V65aRCQC3jp0sKH31QA9lDs8g9
 uFVCMNeGZuNhYl7bh+C6jEFt9gBra3OnxiHK2oTFfKsya8WS9kGCOBccyH2llenh
 IKaovPy+ClPhyKsTxxpsQrUDKeKLSk5ekjClmEkztq7w55IOcrxZXUBM6yCJ+q1Y
 V2J/hNh546/kflB4mRi3VvJBzxkmvc4ZwvBiqQ8ZwylCmrWSMKS5m2RdaWBwuIna
 J6fb4PdFpGgMWIbjh2OHng9tx0TfndKkfvp7soKpqwLHWVtOhZLNQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdhakv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:21:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669JcdX023101;
 Mon, 6 Jul 2026 09:21:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvw2x8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:21:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6669LQNV12452352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 09:21:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3282B5805C;
 Mon,  6 Jul 2026 09:21:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E367E5805B;
 Mon,  6 Jul 2026 09:21:23 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 09:21:23 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-stable@nongnu.org
Subject: [PATCH 5/5] s390x/css: limit number of CHPIDs in description
Date: Mon,  6 Jul 2026 11:19:09 +0200
Message-ID: <20260706091909.864405-6-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706091909.864405-1-borntraeger@linux.ibm.com>
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4b7397 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=taQyAogG0pZaN8zP0A4A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfXz60ptpdJaeXW
 IGGlOw/kB8Vrg+wMz9vrOq0rtpq5uPMH1KKE5U19kZj5GLmt6uEIcP6HQ/blhw1zv2QHxDAYriR
 b52pJeboQMNMZu7NckSmgcepMAgjCKBihtC5YcoNj6I6QfwUx0J9t7Kp7U/As/e7InGthGvDeQN
 I8ufxEkFdE7i0+vkmhRPxcQ++zs5zlZL15Eo/tBPUj0h4eSkgCgHjTUrzFUTpypkRgj5tAKdfbn
 pMsxVozLqfsdvqIK9xS9Whq10KKwZdwAWANrrbXESur+8xiJtwP7bIdW2mgTHa9y5tPWgYf3Bn1
 Hjobkpm/MqxGQfvOQ9dMmkEQRKQRxjuNSnJlBnLOA65zjuFr+92cE6EN0mKGobdkOp+ZLY+sPPz
 Wc5ieAsMk3h23clQgzNL3xlTwEAuB4du+QV6PzSyUbRAPELfDI/3YnoXx3qmB2txSPMFOILqsdQ
 yu+boJMpFBQO0m+PWjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX073dw7UQ6pYI
 NvYtDQW5AoUYHGo/2MsegHpQWabFr0dFogK2XVQACrSf3NgHtTXmkjgenbKkTegW11ZJ22MGcnN
 VWARsoZ4Ss66HVuvOVfJ8N0kQfQhrrU=
X-Proofpoint-GUID: akebyfqCLnx1TuxhZrrHpM333PbJoVw1
X-Proofpoint-ORIG-GUID: akebyfqCLnx1TuxhZrrHpM333PbJoVw1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060094
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

From: Eric Farman <farman@linux.ibm.com>

virtio-ccw uses a single virtual CHPID for all devices and
device-types, but vfio-ccw (passthrough) shares real CHPID
information with the guest. A sufficiently large passthrough
configuration would exceed the defined response payload.

Fix this by limiting the number of CHPID descriptions that
are returned based on the given response format.

Cc: qemu-stable@nongnu.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/css.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 96d5378f3c..29ba39f79e 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1872,6 +1872,7 @@ int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
     int i, desc_size;
     uint32_t words[8];
     uint32_t chpid_type_word;
+    uint32_t max_chpids, chpid_count = 0;
     CssImage *css;
 
     if (!m && !cssid) {
@@ -1882,9 +1883,25 @@ int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
     if (!css) {
         return 0;
     }
+
+    if (rfmt == 0) {
+        max_chpids = 256;
+    } else if (rfmt == 1) {
+        max_chpids = 127;
+    } else {
+        /* Should be rejected by caller */
+        return 0;
+    }
+
     desc_size = 0;
     for (i = f_chpid; i <= l_chpid; i++) {
         if (css->chpids[i].in_use) {
+            /* Limit number of CHPIDs sent back */
+            if (chpid_count == max_chpids) {
+                break;
+            }
+
+            chpid_count++;
             chpid_type_word = 0x80000000 | (css->chpids[i].type << 8) | i;
             if (rfmt == 0) {
                 words[0] = cpu_to_be32(chpid_type_word);
-- 
2.53.0


