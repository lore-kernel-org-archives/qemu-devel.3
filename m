Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F342C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 08:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Z7C-00054r-En; Mon, 21 Sep 2026 04:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x8Z6o-0004wZ-2j; Mon, 21 Sep 2026 04:10:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x8Z6f-0000JW-Ed; Mon, 21 Sep 2026 04:10:37 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L7ZSiW863110; Mon, 21 Sep 2026 08:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ljV1cwh42jouyKL1m
 zID5B7wqkiCqJ2gColDpuU5lAA=; b=gyzfllVo7T5EJ2TuzEV4hJzWEJI9TCJpc
 ttGC81LI5UMZLKXl0FxJyCNASKta9Pck8bwAszGtl3mxW8BPpM033BF4S0KigBV4
 I3AzvXxR4vPGHHIMmTaHsZgO+QSgZ5aWu/GEm1Nzr6RucmJvpnnubU8stlqs5l+6
 VmO1ZJbO5i41SVOeFIo2M/ZhVb3ylmwmQLJ1zyA05Hgs5YBQkCDlRqsU/haEdf3c
 afeYxqSGuOx4KB0z9o7mcmjspQctPwk4VTcZdq6L14hYZ5TQonzINMVGYxWQHu6N
 +AEbZtN9Edf9drqrXCDAeHU9EUi8Ahc6gP6cqEaHqQeWetgiFgVMA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskduyaav-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 08:10:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L7HU1g843518; Mon, 21 Sep 2026 08:10:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjmd6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 08:10:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68L8AOY754526302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 08:10:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90F8620043;
 Mon, 21 Sep 2026 08:10:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F99C20040;
 Mon, 21 Sep 2026 08:10:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.112])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 08:10:20 +0000 (GMT)
From: Aniket Sahu <asahu1x@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, npiggin@gmail.com,
 adityag@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 rathc@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com,
 amachhiw@linux.ibm.com, asahu1x@linux.ibm.com
Subject: [PATCH v3 1/2] tests/functional/ppc64: extend pseries migration tests
Date: Mon, 21 Sep 2026 13:40:09 +0530
Message-ID: <20260921081010.31778-2-asahu1x@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260921081010.31778-1-asahu1x@linux.ibm.com>
References: <20260921081010.31778-1-asahu1x@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: vsGTWggu54815b46a0FdwB0alcyVb5Jk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDExNSBTYWx0ZWRfX9FN78rndyY4M
 fdsKkZBelAbSBS5EM0hhtSih8KtDuFzIZphY+ImLdwKKsE1hJusvifKvwlDuTrlmPFkPeDUjZPL
 2TOvJcKJmpA2D+dkQXwEVG2y/GKoAbg=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab0e675 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=nntn5sUTz_BbCZulGUMA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: Ch22X0Dwz-zCfXLq0vzfB04LrXCVYOK3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDExNSBTYWx0ZWRfX/Dcm+xYUZxJK
 bzgPh9i0U1a2h2Hs1M5EKp8eEg6l9aRDv6NGVM1jTNnKMK8xcrnd8pj5VQLih4EHPG8n59wmkBA
 TK1ueskwGxYRN8/iwfQC8TLkn1uBKm4qo9SARKU0/0Kwivddo1SBiUHmxmQQ0CLsQ/4ihrMtpWJ
 oiCPt89dciJ8suhgbT4EnbMGqSwiYkWivJ8uVkGlDxjv3QCYqA3qbBG3D8y+kQnGYHNoMebz/hn
 ZTs9bLtkCKchPfWn/vU+BCet0yko/Re1eAqIIyH1XgivmeldlgDkTENBBuVzvt4C8aDcj0TB5wB
 WNrF4jZo556T9Rq6ZHUkpAQdGv0NjGn6DyH5REOSBi/BD2oZECs9RzewO62RJ0GwP9FqFhK8bnd
 302jmuTkAo1BntTsOJmynfxcsoi4We75aFa/aIowale6Fu8m8lGdxsYnIZFgnnMKgc4Tnay3imC
 4/h4v6m87zFysXxu0Dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210115
Received-SPF: pass client-ip=148.163.158.5; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

The existing test_migration.py exercises all three migration transport
paths (TCP, UNIX, exec) but only against the mac99 machine type.
A regression in pseries-specific vmstate save/restore handlers would
not be caught by migrating a mac99 guest.

Switch the UNIX socket and exec (socat) migration tests from mac99 to
pseries so that these transport paths are exercised against the pseries
vmstate.  The TCP test is left on mac99 since pseries TCP migration is
already covered by test_ppc64_linux_migration in test_pseries.py.

Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
---
 tests/functional/ppc64/test_migration.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
index 7d49ee175b..e1d51551b8 100755
--- a/tests/functional/ppc64/test_migration.py
+++ b/tests/functional/ppc64/test_migration.py
@@ -15,11 +15,11 @@ def test_migration_with_tcp_localhost(self):
         self.migration_with_tcp_localhost()
 
     def test_migration_with_unix(self):
-        self.set_machine('mac99')
+        self.set_machine('pseries')
         self.migration_with_unix()
 
     def test_migration_with_exec(self):
-        self.set_machine('mac99')
+        self.set_machine('pseries')
         self.migration_with_exec()
 
 
-- 
2.52.0


