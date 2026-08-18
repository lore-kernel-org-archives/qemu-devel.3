Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757C9C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNQ1-0007fE-Dx; Tue, 18 Aug 2026 13:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wwNQ0-0007ed-0M; Tue, 18 Aug 2026 13:16:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wwNPy-0008D3-BF; Tue, 18 Aug 2026 13:16:07 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE3U2G504941; Tue, 18 Aug 2026 17:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SwO8lThTltkt7sOOy
 sVutsLK+vl3XccbvKfzhI0UgF8=; b=a7KVX88YzlMXEByP4UbvPlh1Gtk3VuBHa
 S4fCc2HhGMdWi/knMDR38qrDaNM4tR5RUTApE1dQogeKAIqVsa1T08RJJW9S3Wkm
 uZr0EneymkCSQR2qDP970CUPqta9nTF/ssv3yArglfMjjRSdUAej9cE8DD0+mSAx
 MCf0+NVxpHSnRO2ZOIfNw4VyzZ9+NobpPudLoGakKT27si1YhksHxwdHeEJmCl5R
 p3DujTHGST2h2y+j63VMl7jNbD/u47ewVrDAK7MY1ZD7VhE7zVqH+uxuE+ZJASgW
 y8iXbv3wv9/TEyMjCRxt88Rxn8fEPmIp5q+qXECvDXdYWsdKHIvxA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4srfj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:16:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IHDjMA030494;
 Tue, 18 Aug 2026 17:16:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh4d5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:16:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IHFxBK46203168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 17:15:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E33F020040;
 Tue, 18 Aug 2026 17:15:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DF852004B;
 Tue, 18 Aug 2026 17:15:56 +0000 (GMT)
Received: from shivang.com (unknown [9.124.212.164])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 17:15:55 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, adityag@linux.ibm.com, harshpb@linux.ibm.com,
 hbathini@linux.ibm.com, mahesh@linux.ibm.com, npiggin@gmail.com,
 rathc@linux.ibm.com, sourabhjain@linux.ibm.com, vaibhav@linux.ibm.com
Subject: [PATCH v2 2/2] MAINTAINERS: add self as reviewer for PowerPC RAS
Date: Tue, 18 Aug 2026 22:45:33 +0530
Message-ID: <20260818171541.903431-3-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818171541.903431-1-shivangu@linux.ibm.com>
References: <20260818171541.903431-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: RMPGsSFMYNxPKUlHhBc9pcTRltGVQ-tP
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a849354 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=WK6P9NOuF5wEigxtcgcA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX1hEq/t6D+MYZ
 tl1pIcBJFvPsejixqhzU9HSPleA2RvumJhqQ46y99SWZMgegf/7m/s5WdcDfXfZqakg35t4SrdC
 8wDM65zmVK5k6DjwCkwyi3e15P+tV9s=
X-Proofpoint-ORIG-GUID: W7Jd8Sc52nYl71eaqHVo74ywin1qGzGN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX4Fe8ZU5EtqPf
 A5nDesKa6q37p9/zH8djAq+CUb/5o8etOtNUHf1kB6XmPHHSgsZUDvFYSbh5QO4qdE6BhSaH7QC
 XiAv15OAZhLt5To/OEPr8ogzBuKA0MH129PO4gUEkLS7RZzQ1svBFOMgxqCflHRUqW9rNuI4Lw0
 O3di0O2hZ3V0fF+6whJxkEQKciFH1pcW5CvDi1nXyDa2jnc7ymibbsOC4PktrnxL7FAv5S05yxZ
 oRsh2azARRjQdyczlAgkA2jGxjbIqOeB9zUf2jAk9SaiBl+zGkGkq3h/mLxtadUelo+8ZjGPuNH
 i5ZrT71nGtRuHNLhKDCg2VApCNZvX2D4dxJ9gzzmvnHHRl9awLF5RlVpJbka10XAibH9sydHvVk
 DnLLdUkCG2W6osenJLJXUdx7N5DQro+wVf4ipoF7KwzlseS9kiS3OcMPMe+lsvJ1t6KA3kWRlaX
 gttb4yMB2AiPUX2boKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180125
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

I have been contributing to Fadump, MPIPL as well as PowerNV for quite
some time, and my daily work responsibilities includes taking care of
PowerPC RAS features. I, therefore would like to step up as a reviewer
to get notified of incoming changes in this area and help reviewing
them.

Acked-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 99e6585ca0..62a0751577 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1766,6 +1766,7 @@ PowerPC RAS (Reliability, Availability and Serviceability)
 M: Aditya Gupta <adityag@linux.ibm.com>
 R: Sourabh Jain <sourabhjain@linux.ibm.com>
 R: Hari Bathini <hbathini@linux.ibm.com>
+R: Shivang Upadhyay <shivangu@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ppc/spapr_events.c
-- 
2.54.0


