Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A9FC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgeds-0004L7-8t; Mon, 06 Jul 2026 04:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgedd-0004H9-6c
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgeda-0007mY-IP
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:12 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665MIQXk1515033
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gInICDXBXwmPm2d50
 VqhDLSClwfWLLLRTdygjRwKm4w=; b=l1vE8uH55us/RYJefAvDPgQT9WdPXTgup
 RubWvzxt2Sfb0sHeJSj3k17ujJpc0ilQJYjT8q+CAMtnEzwF+mgJ4gdZP7UQKSaw
 HMGTNMTEtQ5o0k3y4kud6VC6oByFZx08xe3a+0saFQ+odAvq9BuqL8I9Yp2PETua
 OhrklMMOYxIB1RQxSyj6ZthTCkI5shqjopqSIUTOFwn3lFtnw156Kw+D2LytYrSz
 1+dmwUMc9K9XSCU5yO9ld+y+oi2qkSbkD/MaQ4OQKDs4+L0kymlPbzDwGTt7+5Bh
 oLr2ZJK8pQDZIRUszjS5hNk0LxshS/qTueIa8lS8NvuZoxeu5GqzA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdh3cm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:25:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668JcCa024141
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:25:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4mnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:25:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6668P5qP52691370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 08:25:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1677C2004B;
 Mon,  6 Jul 2026 08:25:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1ADED20043;
 Mon,  6 Jul 2026 08:25:04 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.1.190])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 08:25:03 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PULL 5/8] ppc/pnv: Replace Power8E with Power11 for 'none' machine
 test
Date: Mon,  6 Jul 2026 13:54:48 +0530
Message-ID: <20260706082451.59299-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706082451.59299-1-harshpb@linux.ibm.com>
References: <20260706082451.59299-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4b6665 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4vOvNoFDifOwbC3DQlcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXwDBmj/k3/F1w
 ab9cHDsp535LzSnNROc5a4B30rzAPnD72lPd5e+FR33rWWqzc+3apU433Md3NlB71AfwiyQ/0ZG
 N1on/tcem/VGyWj9IsXGRH85P5wLpLbP3fanms1SHvkvcsyMcsVt+vSVfTnAnSE1ujzdqYgP+6v
 13anUutrnob1p1ymuqBnOjX2nLxp7L5ciPaOu/3Np5pXoiPvrgmClBc+vXqNUSyYq1bTRvsjlCM
 TrU8uw0Q//A1Wjf8Z5UamdC0e2rh1VXt+CNplCRvVFUfjVz83qBybQsY5WJc2Hzmr9CtTsbaVoe
 w+Dg6HBgl7gnH7Ou35rp02Z9pG60QSM8N85lNVyOJJbWC46CIACWya3LGlBD3EYQS5nU2371fih
 SErvoZJCIY1GALg7y5myQnTf4/HNWt3mTBP4ynbElkZVAmgLqPHk+zkmnP47mka74CdPj6OV8sg
 WdBWJdOfT/PrWQcU93g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX5412s+/ue5sJ
 3OPgRrqGCyrBeNJJ56AhnfwCH4N+s/J5uwvi/5JyT/cCedcULM2goKBXYDLALnaVedE3QG96nUH
 yELI1RcbvT/J7KsettC5HLI42TUES7U=
X-Proofpoint-GUID: PP-TpLHn6opeUex3hmAD6B0Q23y4XWV3
X-Proofpoint-ORIG-GUID: PP-TpLHn6opeUex3hmAD6B0Q23y4XWV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

From: Aditya Gupta <adityag@linux.ibm.com>

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

As Power8E chip is removed in future commits, remove the use of Power8E
chip for use with the none machine test, and replace with Power11 for
ppc64 test coverage for the test

Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Reviewed-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260703085955.2318600-6-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 tests/qtest/machine-none-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index bafd7d660e..3205df190f 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -38,7 +38,7 @@ static struct arch2cpu cpus_map[] = {
     { "mips64el", "I6500" },
     { "or1k", "or1200" },
     { "ppc", "604" },
-    { "ppc64", "power8e_v2.1" },
+    { "ppc64", "power11_v2.0" },
     { "s390x", "qemu" },
     { "sh4", "sh7750r" },
     { "sh4eb", "sh7751r" },
-- 
2.52.0


