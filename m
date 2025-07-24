Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0727EC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 10:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uesqh-0008Rt-0K; Thu, 24 Jul 2025 06:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uesqd-0008KG-Lp; Thu, 24 Jul 2025 06:06:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uesqc-0006dp-1T; Thu, 24 Jul 2025 06:06:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O7HtAF028693;
 Thu, 24 Jul 2025 10:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Vz6FBn
 gQQA/WKfPaW8ZutjgHjQMr87oU9DtZpNQthpY=; b=H9+EMSWIGvUHcL9mZc2FTa
 bNyQV4ZLJXrrQT/nYxLMo3JcHHd3hrAqE1FGv/E5SMw0SLkPCuD0ekY44b6aM0Ru
 WHpjcUx+yofaMtiCKtp0dG6z+AvThKKL8OIIhFTP6gGI3DYWHgH4mTiNIctfow2K
 xDU1SXxalEcCGAIWZS6qesTMS3xusTU+cqyvaWneyinl5kE6fWRCcwRFvWtAcCNZ
 uHYV70WHNI+Hy4ffweWXqRsEBwc26Q5WaZjnERH2y5miayB//Gl0vmuQ6ISCVJOE
 ZWSW0SIPL9IOhXUGW8Vb2VdmYhTiThOZprnBbNHGTOzOYMyOtyNuRLAZGZez+t9g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdyrr41-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:43 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56OA6ULL029425;
 Thu, 24 Jul 2025 10:06:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdyrr3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6dl8R005057;
 Thu, 24 Jul 2025 10:06:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8g36dr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56OA6aD217563970
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 10:06:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B43282007C;
 Thu, 24 Jul 2025 10:06:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4D8C20079;
 Thu, 24 Jul 2025 10:06:34 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 10:06:34 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com, philmd@linaro.org
Subject: [PATCH v2 3/5] MAINTAINERS: Add myself as reviewer for PowerPC TCG
 CPUs
Date: Thu, 24 Jul 2025 15:36:17 +0530
Message-ID: <20250724100623.3071131-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724100623.3071131-1-harshpb@linux.ibm.com>
References: <20250724100623.3071131-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C00Sh1JXXzudH4Vh_d1ysEcO4kjCHSHA
X-Authority-Analysis: v=2.4 cv=XP0wSRhE c=1 sm=1 tr=0 ts=688205b3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=ayvLt1LFfqT23g-EUowA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: fMzzdQhlNSxyWsj03e_ogmh02TMF2PMd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3MSBTYWx0ZWRfXzMYZvV6SVibO
 xAavCq5GLAEigUQJC1A3FSfHAkk4YPJ5UQKlmvEaBwPIXPobozg2bIlPit7dku2E1A5Wvx6KF+r
 BELwpPlNjqC0zoRZI1XrjpxKq0S3U6mzJevs8oiMyZEyhdXgw0gvfwA0fYMke6FYvcOW0GT5pZK
 m1aqjZFUsug0W2cuoJ70DymXhnSIaP5MktectT8YsK3AAGPxSQ8UyDTZ9vRiw8lm5f5G2AXALDn
 P/7tUWeOm78uCKIKPTRtEm8S0aq7WJpo/L7DNyjPl4kvjLDLzEx+pVmh1WfZmNPFtPklFP4YPhY
 uueHYaClnXhDdB1yJ+wIL/iQ97Ptp0l+1caLOF7CtfvBl7aHTDXysSsBFJVRHSdW11XERDiaIXw
 q/MW+lUc1Q1Pt/DqfZXmIQWdVM7b9aFSpEFFe2qgSBoZfA2Rqlwr8SHpcqov42retEQKpqr2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=952 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240071
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: Chinmay Rath <rathc@linux.ibm.com>

I have been working on Power ISA for a long time now and have mostly
contributed in TCG instruction translation area (moved 300+ instructions to
decodetree as of yet) and would like to continue contributing to PPC TCG in
best possible ways I can. I think it's time to step up and assist in reviewing
related patches to enable myself contribute more effectively in this direction.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e95ef00c1..31bcb82e93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -296,6 +296,7 @@ F: tests/tcg/openrisc/
 PowerPC TCG CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 M: Daniel Henrique Barboza <danielhb413@gmail.com>
+R: Chinmay Rath <rathc@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: target/ppc/
-- 
2.43.5


