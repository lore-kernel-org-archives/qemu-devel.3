Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF0ACA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFoB-0002qg-PD; Fri, 09 Oct 2026 14:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xFFnq-0002of-Au; Fri, 09 Oct 2026 14:58:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xFFno-0004aZ-Eq; Fri, 09 Oct 2026 14:58:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Ha3oq3714668; Fri, 9 Oct 2026 18:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XTgachXJghq3xU0So
 1EXy42s8xYtRBFJ+MwRqwFqImI=; b=Yo7ye//YYmfGuAtdflmitB9QdjkrQfRqP
 KYvaa6JCXZa6RkgqLuRBiaLWIKsgqyf0qKRItyUIdBK5U1FzKjg28cetd5j4CLCA
 adaSFxPBNhKuHqeBRd+URl/mv92y3bM4nXIErXb81U82/vQdw+h1yZQDw5kxUPLK
 yZpM3Vntk2w1PY1ycYqHspI7tZhoLTFuKBrNfRhikHzVgOhZH0mkZgzKT7Krke4j
 zC+hr1gMV/9O2JysrV269lZPVkkJhTHcOyuhNMr1p/kwt/GJwNTPnuYImXBQ09P2
 ZNd1aeVbohXPumyRqgRWXpBu5JiR8vpcrEO/Crmg+foGvrOTK5Jtw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74terces-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:58:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8FpW1206662; Fri, 9 Oct 2026 18:58:39 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnmbeh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:58:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699IwcAL20644524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:58:38 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED5DC58043;
 Fri,  9 Oct 2026 18:58:37 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EAD05805E;
 Fri,  9 Oct 2026 18:58:37 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.ibm.com.com (unknown
 [9.67.47.107]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:58:37 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 2/2] target/s390x: mark feats dependent on deprecated feats
 as deprecated
Date: Fri,  9 Oct 2026 14:55:59 -0400
Message-ID: <20261009185559.144750-3-walling@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009185559.144750-1-walling@linux.ibm.com>
References: <20261009185559.144750-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gSaCyZmuYla3klXgEQqZccAIVmaFJjAT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3NCBTYWx0ZWRfX9jT07htpEnhw
 bQ1rl7FmTYbNq5RHercILTfM+g+86Noan1SpnjqBgD1VFIvQGJlnxOJTlSAsYQa1IWZwUkhpw2j
 G3CzuT2c+r8GQpOvRN63Mx+ejcVGRy6zdSCbyCfjx++zjgbxAAMtgH5YBk/YRnKzwj6weRE5Z5B
 Y+/jGsOR5dzmO6wJ7tV+tvMTtoJQbv5+qFwVgPPD+7K3/k0fEjGHazYIzjME3niTJIx8ULwkgNN
 KWqAORsrwpLDiuCPU6RKe8uPYIvrj/euV6Pxpcw++PVZKP5dCjSpRzEylaOCFlRmkf53DJylgxn
 5A72w90u16ARIPkbRq1VA2y/J6BvgAcOjhSQ3tNJi+i7FWD0qJD9fbwSmIsKMM9q6UV7J2UVAdn
 ycoPE3S8z1OJirR9AcZdoS18HDh0mgWeeBGnErBxUXMZNlv19MM6KP6GDEu+NECDu0Qpz2P0qBs
 /aqfHJbksDlHNLzEbGQ==
X-Proofpoint-GUID: gSaCyZmuYla3klXgEQqZccAIVmaFJjAT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3NCBTYWx0ZWRfX4BPbPmpWqBto
 FYEN0O1dUYKsoSYXndhgZnlHvZhbKs9mFvSv7AA5k8IbErsR+7dFY9J8FXkhG7X0oX+HiNdSt8C
 /xbPlYdWoNi2E6ZO5HYucL1mR+HmqLk=
X-Authority-Analysis: v=2.4 cv=Nf1zRGD4 c=1 sm=1 tr=0 ts=6ac93960 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=YJGIzY42qjv8PvxFfY0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
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

There are certain CPU model features that depend on other features
that are flagged for deprecation. For example `ineff_nc_tx` depends
on the `te` deprecated feature.

If a user defines a VM with the current list of deprecated features
disabled, the following warning occurs:

	warning: 'ineff_nc_tx' requires 'te'

To alleviate this, add these "dependent features" to the deprecated
features list. This allows the user to see *all* features that should
be disabled to ensure a successful migration to a host system that
may not support certain deprecated features.

Fixes: 6e55b32d45 ("target/s390x: flag te and cte as deprecated")
Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/cpu_features.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 20f9947c7be..babee7f5bac 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -360,10 +360,23 @@ void s390_get_deprecated_features(S390FeatBitmap features)
          S390_FEAT_TRANSACTIONAL_EXE
     };
     int i;
+    bool restart;
 
     for (i = 0; i < ARRAY_SIZE(feats); i++) {
         set_bit(feats[i], features);
     }
+
+    /* Mark features that depend on any deprecated feature */
+    do {
+        restart = false;
+        for (i = 0; i < s390_feat_deps_len; i++) {
+            if (test_bit(s390_feat_deps[i][1], features) &&
+                !test_and_set_bit(s390_feat_deps[i][0], features)) {
+                /* Restart in case set features have other dependencies */
+                restart = true;
+            }
+        }
+    } while (restart);
 }
 
 #define FEAT_GROUP_INIT(_name, _group, _desc)        \
-- 
2.55.0


