Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48681CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAa-0008E9-9i; Wed, 30 Sep 2026 11:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAX-00089t-9n; Wed, 30 Sep 2026 11:24:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAV-0001z4-13; Wed, 30 Sep 2026 11:24:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5mob1933223; Wed, 30 Sep 2026 15:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xQte5zo4vzgO1k/oQ
 KeZkMOmir2JVajJlABNQfzE8T4=; b=KZtn3NijDX/dEZzVkE5M54AINYslHAoE1
 yKWg9CMxyVttyTOOS0mDSlV9M702zRVfHtrC+lN9F+yf++gT/rlResFd0BiaGIUZ
 0PqXdqkyFJtNoC3RUBnibRpQ7SJMbapuvDQmyB8gGhpCJniCAMIhROz+Iv7FZ5+J
 9W8NY/3d1WHFfGJSLeP5nyHuUDCSVbsEBPdv/fwXiYlUnoLa5w7fRBMj3NnnJxcI
 roZ70qHH3V7JyHT6DDL6WDZs3Acn0pQssACZq8FjXcSsK9zt95hlF5e8+vhfOUdq
 +F+J96ZO+YfZPXN3tRYqJ8a/W3o9kr6zQV/3M1I26q5Pt+iCYr5SQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fecyef-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE3BXD3577012; Wed, 30 Sep 2026 15:24:24 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23m9km-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOMoP1901374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B250F5805E;
 Wed, 30 Sep 2026 15:24:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34BCA58051;
 Wed, 30 Sep 2026 15:24:22 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:22 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PULL 02/23] virtio-ccw: Do not overwrite existing indicators
Date: Wed, 30 Sep 2026 11:23:59 -0400
Message-ID: <20260930152420.1956230-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abd29a9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=smRGcg3zAD8wOz9YheIA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfXy5sp7tPNcOSA
 daKVd0bso2H8nARDqDaQz/qUu2lGxhejM3qV8vTbXx5tLNBBSzcc38nFR+N1x/EzLR1dN2Y74TW
 EdGglz6cXjEEiWkvbd80R93E56yoUoI=
X-Proofpoint-ORIG-GUID: tbsCeXnERMzRuJkMWWnQ7YiDJv6yuddv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfXzVx6ckcGq0qt
 pPPbtnQ3UZdZp+uuRM2lgl/8Wv9HRVJpTpsdpgIdjoVvc4R/B//TZMUhDxRW9Mo+HQdTcrV0p5n
 RNRBqGbk9WBM9Yu//+RRDGi6a4WzaPDSaH/vtWXmgDEDKXQb02rBbTAztOsnxssgiGb6U8SZ6hD
 dXOLxqfBiG064jRUXna8S0YaGsoMqb3zNVlc5r9IYFxYqffmSN7wGhhecjcPrUn1vGT+xQmR1Zo
 pFBjmKCj1f4B71ShohsMFke2EbzqpxhPNIGOowWNY5ZPWJOLdLh8e7x8ezPs/mXp6UHDnwtbQ7i
 Xzw4SOE/Jb6x7PWx0DezG8cus9+dWATDN0UyjIM3UxJlwDiGfz+oqNlrinN9khYx81fY5e7YP7F
 QQiuG/7Y0d1tB5poCciBxzB2bbTtS41ovRUt4S7P/jJRa1aCQlcu4lFQ+7+GieXpyxkDb2vE1SG
 Z6F/jOsk28o783jKhRA==
X-Proofpoint-GUID: tbsCeXnERMzRuJkMWWnQ7YiDJv6yuddv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

The various indicators pointers allow them to be overwritten,
but leak any existing structs that might be there. If indicators
exist, ensure that they are released before setting the new ones.

Both the regular and adapter interrupt paths check that they
aren't being asked to enable interrupts when the other one is
enabled, so just do this release once all the potential checks
are completed.

Cc: qemu-stable@nongnu.org
Fixes: 7bca3892cb ("s390x/virtio-ccw: reference-counted indicators")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-3-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/virtio-ccw.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index eb6378ea4c..f46f936150 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -582,6 +582,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             if (ret) {
                 break;
             }
+            if (dev->indicators) {
+                /* Need to remove existing indicators first */
+                release_indicator(&dev->routes.adapter, dev->indicators);
+                dev->indicators = NULL;
+            }
             indicators = be64_to_cpu(indicators);
             dev->indicators = get_indicator(indicators, sizeof(uint64_t));
             sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
@@ -606,6 +611,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             if (ret) {
                 break;
             }
+            if (dev->indicators2) {
+                /* Need to remove existing indicators first */
+                release_indicator(&dev->routes.adapter, dev->indicators2);
+                dev->indicators2 = NULL;
+            }
             indicators = be64_to_cpu(indicators);
             dev->indicators2 = get_indicator(indicators, sizeof(uint64_t));
             sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
@@ -666,6 +676,17 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             } else if (thinint.isc > MAX_ISC) {
                 ret = -ENOSYS;
             } else {
+                if (dev->indicators) {
+                    /* Need to remove existing indicators first */
+                    release_indicator(&dev->routes.adapter, dev->indicators);
+                    dev->indicators = NULL;
+                }
+                if (dev->summary_indicator) {
+                    /* Need to remove existing indicators first */
+                    release_indicator(&dev->routes.adapter,
+                                      dev->summary_indicator);
+                    dev->summary_indicator = NULL;
+                }
                 thinint.ind_bit = be64_to_cpu(thinint.ind_bit);
                 thinint.summary_indicator =
                     be64_to_cpu(thinint.summary_indicator);
-- 
2.55.0


