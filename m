Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF538C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 10:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSC2v-0008Sg-7B; Thu, 19 Jun 2025 05:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uSC2t-0008S6-1H; Thu, 19 Jun 2025 05:58:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uSC2r-0007qH-25; Thu, 19 Jun 2025 05:58:58 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ILon6E002002;
 Thu, 19 Jun 2025 09:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=eQMYgEKscvieArEfR5ZE4FEIKFSqyMmrJ+K11+4Y4
 cw=; b=YWkfgwESmUMLTt2fn8menQdfht1a7ZreOJ36fH0snaiihj5JX6tkAPgn4
 2kP2g491zXXNd9cO/j6BxjUiuTvCJuovTsFcQrr3T9DMPvjViMqKeLC1whhD6rle
 gZEg5KYir2ojhINAYLrB8AkKvEaMvXGjsnVuvf5iH6n6mBvQ62R+wHaFfB/qEG6f
 WkOOZMQU+5FjkgORgG1pvpMoDeNC+OBsY1BJDMffnrxinTOSUHSNcA+cS/9jyn0x
 bp7PrguI/P1R9B6BYELUWmOT7kLh8ThuOrG9hRXC7uUJ1VpD24UWdRWtfPGieSJ0
 NAE/ed/KGHvIv7ulaglaNRLuogwiA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r2bywy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:58:51 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55J9i4Av029215;
 Thu, 19 Jun 2025 09:58:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r2bywu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:58:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8Dsi9005493;
 Thu, 19 Jun 2025 09:58:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mwmdeus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:58:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55J9wmVq43843990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Jun 2025 09:58:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6185F20043;
 Thu, 19 Jun 2025 09:58:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6A3220040;
 Thu, 19 Jun 2025 09:58:46 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.in.ibm.com (unknown
 [9.79.200.241]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Jun 2025 09:58:46 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 danielhb413@gmail.com
Cc: richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 0/5] target/ppc: Move floating-point instructions to
 decodetree.
Date: Thu, 19 Jun 2025 15:28:35 +0530
Message-ID: <20250619095840.369351-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BTqOQJMtT4jhmlJkTHzBPwV8DGbVNfUA
X-Proofpoint-ORIG-GUID: C5vVDsQaZEoBYXNf9s23oLUjs98z6-fU
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=6853df5b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6IFa9wvqVegA:10 a=eAAwq-GsvxDbn44f27QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA3OCBTYWx0ZWRfXyIiGQv73avdz
 9+z0gDwJ6lXuwl52ahhhQi2mMKOXMHVtlB5ALTK4UdzLQ5WubjEQJNDYJPUOnGqlZEtQM1ozD2G
 UfA5h37YqX3rhYLli16vgFd0UQ1PoYs/VSuOd2A5ZESbck8nuHfuFRc15h8VJs/nx8OTz3zntVl
 qVCEM0k2VX9YcRWaYbLQ2sMWZvjGltGHCHnycipPHo5RCj9kXFUYaq7rz8IYD7IU9jBb7jczgNj
 IMBL+f0xcfY5kG9vEdUQHFjScoB6HR+R+VbhUTaKE8gwYr67UyqL4Kew8o2Gxh0fN0sB+XAGVhj
 xy+7JSmOR5uW0sRdJ9CNYoqvUJdWJ88gtr8ZCaum1MlPnd3YLfOHK+AlebRr/7wC1abhYdJGcYX
 Ygkn0mKK+6XBrCxvk5NwywVUMYZAZo3f9nAarjWeZIRNfygeNRcwXzPJ+6aPXhz0z47b+zRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=778 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190078
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Moving floating point rounding, conversion, compare and move 
instructions to decodetree specification.

Also proposing myself as a reviewer for PowerPC TCG CPUs.

Chinmay Rath (5):
  target/ppc: Move floating-point rounding and conversion instructions
    to decodetree.
  target/ppc: Move floating-point compare instructions to decodetree.
  target/ppc: Move floating-point move instructions to decodetree.
  target/ppc: Move remaining floating-point move instructions to
    decodetree.
  MAINTAINERS: Add myself as reviewer for PowerPC TCG CPUs

 MAINTAINERS                        |   1 +
 target/ppc/fpu_helper.c            |  38 ++--
 target/ppc/helper.h                |  38 ++--
 target/ppc/insn32.decode           |  40 ++++
 target/ppc/translate/fp-impl.c.inc | 289 ++++++++++-------------------
 target/ppc/translate/fp-ops.c.inc  |  30 ---
 6 files changed, 181 insertions(+), 255 deletions(-)

-- 
2.49.0


