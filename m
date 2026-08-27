Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34694C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaFe-0001l0-2n; Thu, 27 Aug 2026 09:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaFd-0001ju-98; Thu, 27 Aug 2026 09:34:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaFb-0002KF-1C; Thu, 27 Aug 2026 09:34:40 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVfTG1871829; Thu, 27 Aug 2026 13:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Nxu+VgowzuJklGjoJ
 LtZ+xUnfmSCsm7cXPMOi10zmlw=; b=A9wtESbS5Rqdqj914+inesbFocPgT1BzF
 RslGI8z88oUZBPHOHfNNfHTH4muVYJzjugUgF9isrKvDDbo67buhEjm0STaA0/SU
 ixZzwDNTo6pgIMKGHG03h56jijN34hUIOo1Hk25wSLco8gH6kG+Vu55hzhLT01OB
 8BcoMh+nA3yxJhho4nQfUSJFJRcKdqlIEj5+ZZxydUiUN9R+CNcqKXlui029QRK6
 X7D7jBpC5j88qL8s+lrXu7F6pyYt+THNR9gnvGtCEO53/x0Cm+ny07cOyqMpHMbX
 r2JwuOwYzq1HaIoorEaewvuYWP6a+yy2ucO9lXiqmmJBOQzy4XFOw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ewhdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:34:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQLJw013308;
 Thu, 27 Aug 2026 13:34:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qghjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:34:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDYWm336635134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:34:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EBA42004B;
 Thu, 27 Aug 2026 13:34:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3F7C20040;
 Thu, 27 Aug 2026 13:34:25 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.12.1]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:34:25 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v3 37/37] target/ppc: Add self as maintainer for PowerPC TCG
 CPUs
Date: Thu, 27 Aug 2026 18:59:52 +0530
Message-ID: <20260827133010.278889-38-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
References: <20260827133010.278889-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a903ced cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=m3VQ6hfItiEfsWDAiLMA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX3e/4wAl1Jnkk
 Oc2X/t75WiPCrC/BWEb/xHltt1UZlT+YtpLsIrwBMcMO+pHTZap4vndfx+ATIsc3qATzu0KLFUe
 o+Q92DkM4NE+RmgRSKG5BK6eOWmDYV4=
X-Proofpoint-GUID: RsOpiFVC_wkvM1WpZfeVARjTu5c5b5qQ
X-Proofpoint-ORIG-GUID: Q8m6oE7UNfgrxDA_rb-4AC5f2xUIVLK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX6/mygMwukgAu
 lDHn+QHfYUxa+G7Z39VYPUQo7YeCLi83oscouljGE/o8+ZdxrWi6+meoiWwhbWIO2HL7GZotm7n
 em7Ej9xpISpY/aLl/Z7/CIbyb4CU0d/7CncSWtGDgAyojpi6zLusajIwDV6Yo4RMQvipcArw/s2
 tGVlA9RXjwSeV+wqifocpN1TkMrJ/enYMBAHazXM4mdNZn9fD5DhXERAg5FnkXKgA6RbQEI9Vpg
 iDMYvm5TbVnckv/bZWIoZ478oC1A1XKo9pgiZNgspUouii4p6KSI4MGiV4r5G0QR+YGbIKhe8ed
 NQU+XmHQrMqMO8d379G9wZ781WrIHYzqtNQNWd9t8u0R/e+Gsb4MzAWspQVy1oX5yMfmXJdH4Ue
 NeEk9hWYXlHlRloXFJK+2+xXHeGoIuV5DAi6suejYrBVNZOXzXOOR8+hA0ZeAd8z4Xj6oA/4Oa7
 hmjqpbX1nspjhUBCZpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270113
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
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

I have been contributing and reviewing code in the PowerPC TCG CPUs
module for a long time now. Stepping up as an active maintainer to
better reflect the current status.

Acked-by: Aditya Gupta <adityag@linux.ibm.com>
Acked-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a0ee348c4..f040083503 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -337,8 +337,8 @@ F: tests/functional/or1k/meson.build
 F: tests/tcg/or1k/
 
 PowerPC TCG CPUs
+M: Chinmay Rath <rathc@linux.ibm.com>
 M: Nicholas Piggin <npiggin@gmail.com>
-R: Chinmay Rath <rathc@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.55.0


