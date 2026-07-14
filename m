Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9901EC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjctr-0005SF-55; Tue, 14 Jul 2026 09:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjcti-0005Hi-2U; Tue, 14 Jul 2026 09:10:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjctg-00053H-Ig; Tue, 14 Jul 2026 09:10:05 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBfn4h1129175; Tue, 14 Jul 2026 13:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UJCmva
 GA01pYzMbIwUS8xn9KHkwHROX3efdHoJAyyTc=; b=KKpXh8xfSAKSl4F0MLuDSg
 H5ZJjFJzBg7MjCmkdb6B7IlojJF2RWsKz/ITjxpyVLMg8SMw/npc/kSUj+9wnpMz
 Sgn0pWJe+wJW2XEJEPKb6ntgCRMuPP8NTx4Ib6t/dmcXMJcFE50ViQ0moJprjKG/
 ZsOeYtHULTJyx1WsXhc2oReGMNAK0pkGLvRF+pYp8RtaJFwR8hSPNcF8h3ZTBzKg
 VWqIOwXnD/mnEk+iQIyJM1+oDoU8If6IV1jMi8UskFKJuH/CifiUqlhXgJcE9ho6
 EQxhBF58At6MwVKTkL/MTp/0nPpBYhPwNscjooJM7uBfc0Afz/vaTI/clCAw4v8g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwnra3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 13:10:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ED4gaM026747;
 Tue, 14 Jul 2026 13:10:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jtwcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 13:09:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ED9vHY45678894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 13:09:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8BE22004B;
 Tue, 14 Jul 2026 13:09:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9070320043;
 Tue, 14 Jul 2026 13:09:57 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 13:09:57 +0000 (GMT)
Message-ID: <cfccf6ab-f1f4-4686-a004-1c2fc8e68f92@linux.ibm.com>
Date: Tue, 14 Jul 2026 15:09:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 34/51] target/s390x: Use CPUBreakpoint arg in
 breakpoint_handler
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-35-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: a0qQPXVYvx8Ds2RISXJysGE6gvoTrk-x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfX78iL4OJpkL1T
 Ql8HFYZK1ywn6MB5yvxQT0V8h83wVyv73AHENduZdoqqCMF7kcUV/CW2Pk//OAreI0ighmuhYlz
 2RwDUVYaBL3i4u7zPYzYE2/Y1e92pqi/HWku1TMFy1/2PJvT6gNKDLdAEcNoeqTvBkB1YTL8o3o
 y2XUBsbS9pKc96iRtfR+XyXcXY9XO5BYIPzVbsh1U+RU89DffAmTONX/xW0UlQBgPMzS6+uBWW9
 7GDEM0iXhz2kvYXDuPDIrb8/CRijEde4wOqlKWpxm2SOMAg6DUi7zvv/IFZMu2yyIPW+7AQrXnD
 bZWtNX0rpDF2zTd7VnIo8khtf6WuNw4lyPTv1kFQOzQv0Yvcx7B4QyFZJb2L9RICOwtzwbzY7ty
 YqWDVluzKkJysnoDjpwZOUcDjlFsLIvZ1gm0cNotO+t2GpMB+snTUTiKeJ/WbZZl0rZE7LlcAlC
 dSAijfUSvFKfyf5ZqwQ==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a563528 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=QOF5ejBOQ8wh0JJU6jIA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dbZvQ6Sm7DI-kGgAhmw86M9sKnHgBxl-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfX9M5sczNs9VlZ
 /fr+s2k8flkWOWZBx5yAtzP/86UH62IXnFDE8PoxvRAJqRdI9ycWwBG4duhT7sX2KFDo6kBzNQA
 I7zAdlqm+YWCMAo2Msjz+lkXtVIyP/g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140132
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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



On 7/10/26 22:53, Richard Henderson wrote:
> We no longer need to test for BP_CPU, or clear watchpoint_hit.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/debug.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>

