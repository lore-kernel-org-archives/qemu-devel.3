Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87495C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkZ2-0006vJ-Cz; Fri, 19 Apr 2024 05:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkYt-0006ma-O8; Fri, 19 Apr 2024 05:29:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkYr-00063v-Gx; Fri, 19 Apr 2024 05:29:38 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J9Dhxg030281; Fri, 19 Apr 2024 09:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AF2IJnqzJXGzRsfog9I7xmkbGnUtvJAa08bLldZgNEw=;
 b=kHm7zFB+OnqaVv6E4u7x8hwohKaD0eEBZZLlzCh7HxgZ0RdAvNEEWUSMufgPWu23JB0S
 OAsi9MWS5y7W//+/tlyGh3ldx/cg5HCtOsxX0mV1wK36e3Nvlb9AipBe9G2zRuR8T0U0
 sqTSK/vgws58g9SJKG9WWOmLA1j0KK7GF0ZbLqDKKqVqixXNfRWtoyW2cPqyEbbViLza
 v0hpGaOH9F/10OZ/+sd2fDW4M0o0wuBOeJyD/ani6R2FZzmSIbFj0w3fDXJn4jDD59TO
 QkVitbAGUrKyvjTJDJLRxuiu+gZQBqvd4iANdhPBhs6X9yWAoKfoJ3tLXlBr2EaDJCYR Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkns7g191-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:29:34 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43J9ROld020373;
 Fri, 19 Apr 2024 09:29:33 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkns7g18y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:29:33 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J8pU3X027847; Fri, 19 Apr 2024 09:29:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xkbmpas11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:29:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43J9TRji49480100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Apr 2024 09:29:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85ECC2004D;
 Fri, 19 Apr 2024 09:29:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79D4B2004B;
 Fri, 19 Apr 2024 09:29:25 +0000 (GMT)
Received: from [9.171.89.59] (unknown [9.171.89.59])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Apr 2024 09:29:25 +0000 (GMT)
Message-ID: <42302364-328a-4358-8923-a53a3222ba2d@linux.vnet.ibm.com>
Date: Fri, 19 Apr 2024 14:59:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] target/ppc: Move logical fixed-point instructions to
 decodetree.
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-9-rathc@linux.ibm.com>
 <3be7fc22-b181-4b0a-bf80-d2011da1a437@linaro.org>
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <3be7fc22-b181-4b0a-bf80-d2011da1a437@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XoCBEYTqZJfg-5IoGxOszTUuxEtBwtv1
X-Proofpoint-GUID: ndUylHwThJ3NgisLegdyGgtTwgCsXxHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=872 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404190070
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 4/17/24 01:05, Richard Henderson wrote:
> On 4/15/24 23:39, Chinmay Rath wrote:
>> Moving the below instructions to decodetree specification :
>>
>>     andi[s]., {ori, xori}[s]            : D-form
>>
>>     {and, andc, nand, or, orc, nor, xor, eqv}[.],
>>     exts{b, h, w}[.],  cnt{l, t}z{w, d}[.],
>>     popcnt{b, w, d},  prty{w, d}, cmp, bpermd    : X-form
>>
>> With this patch, all the fixed-point logical instructions have been
>> moved to decodetree.
>> The changes were verified by validating that the tcg ops generated by 
>> those
>> instructions remain the same, which were captured with the '-d 
>> in_asm,op' flag.
>>
>> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
>> ---
>>   target/ppc/helper.h                        |   8 +-
>>   target/ppc/insn32.decode                   |  38 +++
>>   target/ppc/int_helper.c                    |  10 +-
>>   target/ppc/translate.c                     | 359 ---------------------
>>   target/ppc/translate/fixedpoint-impl.c.inc | 269 +++++++++++++++
>>   5 files changed, 316 insertions(+), 368 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Thanks,
Chinmay
>
> r~
>


