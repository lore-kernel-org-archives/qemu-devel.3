Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AA7C5321C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJrk-0004zz-Fk; Mon, 27 Jul 2026 07:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woJrP-0004wB-AH; Mon, 27 Jul 2026 07:51:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woJrN-0003ae-Mg; Mon, 27 Jul 2026 07:51:07 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RAIRAT061215; Mon, 27 Jul 2026 11:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Yv1VW1giWluFfcs0T
 +1cYIFBlcFRoUOf0MrCLZR6ruk=; b=JCfEXzuh0kNV9nVkv1UvhW9kEE6sDgyxV
 6/eutDabCVi0nTNPKtF4RmQKk+ZQYtgxPI87EloERPUmihsjyB2kR9XZOSXhqq9T
 Gte8CGV2OgxGf4ilSoY5BKoFr+FsYCYA+yB89I4lg/r8491QCxK1grczgb6YRHom
 BgNP0qbgdf8ouFpOgGHUedrPj9AusBwqR50ebAYEjdDnsiEnn4nIR2acWt4BPtzd
 k/ZNgX5IwQLGBuJyO8NFF94mZ/RAP9At3wUU0+RIrDeY2E5IjIApGr4G3prcmL8Y
 /l9HJI/jDfpklaW87+QBM0bLLo1wvNgoAdBiH5zs0Gl9KYNwTSb6A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc7sf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 11:51:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RBfQf5016292;
 Mon, 27 Jul 2026 11:51:00 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg510m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 11:51:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RBoxcT2425344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 11:50:59 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A866458063;
 Mon, 27 Jul 2026 11:50:59 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14D6458056;
 Mon, 27 Jul 2026 11:50:57 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 11:50:56 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/5] hw/char/sclpconsole-lm: avoid guest triggerable assert
Date: Mon, 27 Jul 2026 13:50:48 +0200
Message-ID: <20260727115052.24289-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727115052.24289-1-borntraeger@linux.ibm.com>
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _y8OI0Y4ymTTiBftnTJJ6o1OLMwy7Iiu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfX8qYngBzY7dsd
 5BdYfaHImgj6ktjJPEzfv9dVg5LcTFA5b+LgrDlHDH+p9sqa2VF4+J+PrQAWAX4vNoTJZN5Sikf
 jcBv1Cugc5/gdSOFj0PMnrlkzxnbybTliKuCzVJlsWNHY8LZQwUMAMV6bA1WogOrk/nmk8JAe/Y
 mMrPlxJpQQQJnWSbSmSLPSoDWTSOIbJKEaCRe9+EepYaep46taqqTjXi9cZV6txyvrk04c/AYiM
 fZd1YmeRwhZF142+QP7WAvZrJLgul9opw+dsEx3NyoMOEET5UJBpHppsA0wC1CGahfoWTgHZRSR
 rPksotxpbynlW4KH4qlOXR5m8mhkkqpzCXioZPRARb590+G6ZTgZs7dKvXYBmlsk4gqGfyNqfL1
 1wvOZqdnATR0s+LL93bsA9ZO8qUn8IErB4YNHMyNkqr+t/hHZ+N25Zj68MgOtiwpdAb88uRjv2E
 uSaC+pxde6wSoEGCSGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfX65uIIBhcaXIu
 WDP/noh3MbktpXVGspmqXjFFlRAyTmjscCvZZFpCiikkOpqJK8JehEd3ks2pP6Qca6VQV20CTwC
 NHYoeNSG/g9u/KZ4H1MiKtezGmVsNrA=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a674625 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=g1diX7UtM1YA1248a64A:9
X-Proofpoint-GUID: _y8OI0Y4ymTTiBftnTJJ6o1OLMwy7Iiu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270116
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

If a guest uses incorrect message length it can trigger an assert in
process_mbd which kills the guest instead of reporting an error.  Fix
this by adding the correct length check.

Fixes: 6a444f8507 ("s390/sclplmconsole: Add support for SCLP line-mode console")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 hw/char/sclpconsole-lm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 9a16896d22..f6ed282f1b 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -243,7 +243,8 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *ebh)
     SCLPConsoleLM *scon = SCLPLM_CONSOLE(event);
 
     len = be16_to_cpu(data->mdb.header.length);
-    if (len < sizeof(data->mdb.header)) {
+    if (len < sizeof(data->mdb.header) ||
+        len > be16_to_cpu(data->header.length) - sizeof(EventBufferHeader)) {
         return SCLP_RC_INCONSISTENT_LENGTHS;
     }
     len -= sizeof(data->mdb.header);
-- 
2.53.0


