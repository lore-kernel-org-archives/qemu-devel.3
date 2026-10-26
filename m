Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ACE606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lBId3Ts5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLJR-0000UN-Py; Mon, 26 Oct 2026 10:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLH7-00079P-4l; Mon, 26 Oct 2026 10:02:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLH4-00019Z-Jk; Mon, 26 Oct 2026 10:02:08 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QBEXLp3272999; Mon, 26 Oct 2026 14:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=OifMq1jrva8jHy4qD
 FY/28sA7BVKIpBk/6NKF9X0PaU=; b=lBId3Ts5NlMuh4hGU+w21VCNsEUrsCjem
 qXTUioRptDguM1TIRBQQUBsswtoClWUVevHFh21qxDR/rMfCt95BdShi1Az5SxwQ
 6Ye1c1JR7HFGCbrrOsAEzV0MhFhd0lA1xvU0tdWHNtqFv2hDm9jj0H7IpxD80ImQ
 LW0UnU/3//5oh/Q7cbYpzCAuJIeocpdo0vGJd0M8DTb5gAdKV6Qi+X7Wm4TVbOeA
 X7DbozPHgeGtlUcTuBgC/Z2uOIVWsy2wd+cAQRYSNRT3dazIpDZk841L6Y2vTZIN
 gNDEhIdWYYDWft7D1Ka6RHPmoOOpQKhbYTU1YAa/ucn05LrQg6i/w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3m2gg1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:02:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QB5LKi2503111; Mon, 26 Oct 2026 14:02:03 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh9py5xv7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:02:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69QE21YF13238866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2026 14:02:01 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1E4058059;
 Mon, 26 Oct 2026 14:02:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB86258043;
 Mon, 26 Oct 2026 14:02:00 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.109.57]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2026 14:02:00 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>
Subject: [PULL 6/6] MAINTAINERS: Update s390 boot reviewer
Date: Mon, 26 Oct 2026 10:01:53 -0400
Message-ID: <20261026140153.2072253-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026140153.2072253-1-farman@linux.ibm.com>
References: <20261026140153.2072253-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfX4qjmvIrAABVH
 qkxDJ46cxY7R6pZi2fhXG6sAtxoUiughBMRrPmBazoFLd79k0R4MjedRJ6JxBf1SuyTrB64rddj
 qEvg0TYDtDQRacm6pD6quyFav1YmAOI=
X-Proofpoint-ORIG-GUID: sV5BPAdO0uFrcRJQqFJKlfd0R85yVpLt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfX63bAM9Oy5hCQ
 eI4dfq6SKke0yzaouUv+rRa4eBjeQO2s5FCJd51FYLyTLZ9nzVFSUqTRw3RYyMkx0tPw6LA6nEa
 /1s5Pb/oMOFEsWrcHIZDhHnEOICq3k66pW/Z4CQH6CZA72fvxFOSCZUhV4oMZ/CKQRVyBLOzNpB
 UYEsQu0B5zOHnd10pbsYN/pdUIXTQdzc3mIQvj0PY58iJyLtPahWTeRQ3UGUgt9dxTUQS6BE7rP
 yrGSULUfuX1ytJgce3d621j6LgLAn8mX3isUsC8iTyX/yX+lheIU/MwYVLmCcdMse/w//b5+qjZ
 HWBn4Ht+zN3BbPe5+YIxBG7Wa4hjWdmToRI0xmJ7Tnaw28u09I1zTBh40GTuN4uUiMR195ZqWwq
 HgF4+UXUmiosvHkQCn5knSkIUMwYeQ==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6adf5d5c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=KLxLvsQGpjq_ZAk5-FcA:9
X-Proofpoint-GUID: sV5BPAdO0uFrcRJQqFJKlfd0R85yVpLt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610260054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Josh picked up some recent fixes in this area, and offered to help
with reviews as well. Let's free up some of Jason's plate.

Thank you, both!

Cc: Jared Rossi <jrossi@linux.ibm.com>
Cc: Jason Herne <jjherne@linux.ibm.com>
Cc: Joshua Daley <jdaley@linux.ibm.com>
Acked-by: Jared Rossi <jrossi@linux.ibm.com>
Acked-by: Joshua Daley <jdaley@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261023151229.1196404-3-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 040d27a94f..d240e1fe60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1987,7 +1987,7 @@ S390-ccw boot
 M: Jared Rossi <jrossi@linux.ibm.com>
 R: Zhuoying Cai <zycai@linux.ibm.com>
 R: Christian Borntraeger <borntraeger@linux.ibm.com>
-R: Jason Herne <jjherne@linux.ibm.com>
+R: Joshua Daley <jdaley@linux.ibm.com>
 S: Supported
 F: hw/s390x/ipl.*
 F: hw/s390x/cert-store.[ch]
-- 
2.56.0


