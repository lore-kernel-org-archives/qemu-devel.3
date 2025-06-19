Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C074C73C66
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 09:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSC38-000064-4L; Thu, 19 Jun 2025 05:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uSC35-0008Vu-6e; Thu, 19 Jun 2025 05:59:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uSC33-0007sO-8c; Thu, 19 Jun 2025 05:59:10 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J7l3eE020941;
 Thu, 19 Jun 2025 09:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0EeqV1ytio2oj4+eR
 uSsLtRAHiVutq8JhdWxsuPQVuo=; b=n5l+5CfLxUoren4OMGGvSLwhOosVdc6or
 NbYFPk26hL2Buv14QKxG70MTohDZ/5NKF5k98Gp/BBlVka1pF8ff1lyzqHrqwC6o
 E95kh3sEOqs8QRy3IzCaW0lU2l/2bMKtLEbsXx+mACQ1pbmILQaAHlYalkGHXiXh
 mc7Xbwg5m/ICe3Mdk2tx4qJQ/IYRwGc/fiuiNZWtXb4orUbldLrApp7771sQpUYo
 YTV5Y7uKOlwoS/ioWqorNijyP2vRul9S4nMFS+GLk1bcAWFGzA7pK4Nb2loYN3ZQ
 UYGPxDEDhYZyFemQnfg3TyOjebRsZL/juer9cmJvKA4cU8czZLmdg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790tecqqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:59:06 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55J9x697008334;
 Thu, 19 Jun 2025 09:59:06 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790tecqqb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:59:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55J709lU010853;
 Thu, 19 Jun 2025 09:59:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 479kdtns0k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:59:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55J9x3wY45875488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Jun 2025 09:59:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 996A520043;
 Thu, 19 Jun 2025 09:59:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1091120040;
 Thu, 19 Jun 2025 09:59:02 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.in.ibm.com (unknown
 [9.79.200.241]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Jun 2025 09:59:01 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 danielhb413@gmail.com
Cc: richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 5/5] MAINTAINERS: Add myself as reviewer for PowerPC TCG CPUs
Date: Thu, 19 Jun 2025 15:28:40 +0530
Message-ID: <20250619095840.369351-6-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619095840.369351-1-rathc@linux.ibm.com>
References: <20250619095840.369351-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qE3LMDyROjclFn_Ru9Vyf1bHlbyPCd3X
X-Proofpoint-GUID: PDUghQ2tA5QQZIBFUDawGqwAkumoqvmF
X-Authority-Analysis: v=2.4 cv=c92rQQ9l c=1 sm=1 tr=0 ts=6853df6a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=DuJFUVMG8awct7Q4CXcA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA3OCBTYWx0ZWRfX1hdDyhlMXZCq
 j4tsCiesl7z9g8YO0mmDosjG3tKZM+3HjIggjLictGSTu0+M0d5jEPb7ASRu5IzE8L/yGLr7KiB
 Y4gd8C5ShKSGCud/11iz+4drid5Hudua2RAeF8Tu+RNWFv5KNEcYdwDrqI4tWxm7T2wcasq6+Fg
 aLH1Oim2m+KiqFCjHHWfNXoJuRDUcAeeB/DTH1xgXUt+TzeuPPH5r15DMQSWWR/p9O4T5WXQAWb
 94QssV2iRgdg/LCmq0C5QX6PhLktTiSQ+KbArXZnGVkWJTzI4+AszfaKPhkdXXEHNy5wl5ioOPL
 aTQV9ZPZPLHvsuzH+hyiurDWVH7J4yrxopCMF8zUlMfeLeCrSBd3471k9UNYqtSxn+DenWPpDn6
 t4n5FhUfslj/gkcPZGb8v0q0kKJn9eaz1u3I/lb5w24wiLBWS6C/17WwMcrwPMPz7ERbSJBH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=965 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190078
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I have been working on Power ISA for a long time now and have mostly
contributed in TCG instruction translation area (moved 300+ instructions to
decodetree as of yet) and would like to continue contributing to PPC TCG in
best possible ways I can. I think it's time to step up and assist in reviewing
related patches to enable myself contribute more effectively in this direction.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 16af37986a..a2db7d72aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -295,6 +295,7 @@ F: tests/tcg/openrisc/
 PowerPC TCG CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 M: Daniel Henrique Barboza <danielhb413@gmail.com>
+R: Chinmay Rath <rathc@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: target/ppc/
-- 
2.49.0


