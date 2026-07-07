Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BC5C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzuU-0005qU-0X; Tue, 07 Jul 2026 03:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgzuM-0005nx-7i; Tue, 07 Jul 2026 03:07:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgzuJ-00035w-00; Tue, 07 Jul 2026 03:07:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674IM382286321; Tue, 7 Jul 2026 07:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=szF7+mE2K02OxmaLp
 /mCwxJxwZ9PE/MDUnbYH8Ju7Eo=; b=r9zN8u+h9pyj87HNME5MDG7M3jYuvkD1H
 aC8LWBv4XAzTCOGX3i1/WL7QQIrreAKj9EL9TWxtSRMkbKWe12HhCxoPdTHBJC/Z
 zp4TZGyS9oEy3SREzxwKmw9p0iRGg4jVclb+mbYpSsFaUoaVnZtdHM63MC7vSIYO
 7tIeLxKdLLnxud9XBj2WN9ufQKwrYols36KNd74JNmNU1dBwM2heAO7itz2T2vig
 eitclNjQASTTBeZv3M/Faciw7Oj4mNI/LTZDRPVHyUMe3wr624I0MoZ5OudT8rob
 UqB9FyTuUK4whI+oKuYWyUSuP7Vnc7xsY2CeE/WiTlyQYhh6ZLNmw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4nmr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 07:07:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6676ngZb023410;
 Tue, 7 Jul 2026 07:07:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq1n7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 07:07:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66777iZv34931030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 07:07:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9972D58067;
 Tue,  7 Jul 2026 07:07:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 934EE58059;
 Tue,  7 Jul 2026 07:07:42 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 07:07:42 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 5/5] s390x/css: limit number of CHPIDs in description
Date: Tue,  7 Jul 2026 09:07:28 +0200
Message-ID: <20260707070728.147203-6-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707070728.147203-1-borntraeger@linux.ibm.com>
References: <20260707070728.147203-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bw1fs36K11gCNMeVrDh5rHV_QayoZx_R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfX+unsccazNZ2q
 eFdrk/BaM3Bp8MPPv/s5Etj1hQG5JKluWMVQWl1FlApQ8FsfLRq2F+fDubqb/+rz+mOguSCne40
 TIExOm18RJt4ng/P4VbBx3ID+Nao+wyfD3IJzuHikU+aBOVs6mC7VfMfO5HLdqzCsSGOHKaTiAg
 4n0++WEAc3qMmuEHOm1mb0w1Nq0N1VAFZ+x9RK/YqxlDhuMzEfrrOzT4RL/z8A2R5NeTPcvGzoR
 81tO5JqzuYnSjOaz7v0Ww9aTi9QrkyAt1of+b7BuUS/nMHxp7sDr6BK2UvjX1SV50IKAp19ljAl
 1Ihz9Fx6zcHhMd5fFPAeyVizXFQamSlDfJju5FHTGA7J5GpWZSIIe4yqo+oSjVBAdIokXgWLkF0
 mOIFip2zV1xvM+qu+e7w5kx6HzvrijRrPmVkpbyxV6xzTCnlQGZO8yPAGCGBRMS3fXMVD0o91mN
 r7M+yv2aUM6Ij0tLpjA==
X-Proofpoint-ORIG-GUID: bw1fs36K11gCNMeVrDh5rHV_QayoZx_R
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4ca5c3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=taQyAogG0pZaN8zP0A4A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfX2dI0E8hNXT7r
 IL6i7k9x6tYvaViHK8TXl8sO2W/Zstc3wo9Pa/0MBqVkN0CbFD1xjskMQZ83kX8ZgkG/JlTqanG
 bh80FtKyOoP/Dyjb6kzUo/q+tVFBHrs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070064
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

From: Eric Farman <farman@linux.ibm.com>

virtio-ccw uses a single virtual CHPID for all devices and
device-types, but vfio-ccw (passthrough) shares real CHPID
information with the guest. A sufficiently large passthrough
configuration would exceed the defined response payload.

Fix this by limiting the number of CHPID descriptions that
are returned based on the given response format.

Cc: qemu-stable@nongnu.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
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


