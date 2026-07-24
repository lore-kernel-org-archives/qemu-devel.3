Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E3BC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnGlu-0005YG-BH; Fri, 24 Jul 2026 10:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wnGln-0005Uq-1r; Fri, 24 Jul 2026 10:20:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wnGll-00076r-AW; Fri, 24 Jul 2026 10:20:58 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ODfcl21992724; Fri, 24 Jul 2026 14:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=XWiIGbnVfPOt+SKvoxLq4ZMYODnhezOXCFteePNGcbM=; b=adLm6/bcU5Tz
 3qj+WCsyGJKFNh6Mh24nHw6YZeAalAnOexErYLjFiPgYNgS3Q1FbfqdKSEyQOKC9
 1Ei+PMOb883JNXALeCZavbCLcWXH4v6kajNGQWmSrmcewrHJaRgg3rSSUIV1iOMC
 GtQBT4A0rQs051M1KV/Ynxdiez0F9kPSC2SEtPusAugZsZmf7EPlw0kmDFGsKy31
 l8RbX5/sWQtZkOTVq0Aqv0U1G2Qmz/Zamyz4ZmGiSvCLKXmuLtweFzTS1FYSG4nk
 Jny3g9i4I+G/QBFaarF0KdAuahzTZmOXcWVu9/LlJUKBbM5dqTbcVFu+N4v6Orwo
 TJc5KDAYMg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h00bmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 14:20:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OEJg2l026947;
 Fri, 24 Jul 2026 14:20:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyrywd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 14:20:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66OEKp6U33161972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 14:20:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9274958055;
 Fri, 24 Jul 2026 14:20:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECA6158043;
 Fri, 24 Jul 2026 14:20:50 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 14:20:50 +0000 (GMT)
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 16:20:50 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v12 04/17] crypto: Add aes-helpers file to support some
 AES modes
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <alZEqU-d7NTHI1ZF@redhat.com>
References: <20260710152906.80207-1-freude@linux.ibm.com>
 <20260710152906.80207-5-freude@linux.ibm.com> <alZEqU-d7NTHI1ZF@redhat.com>
Message-ID: <1c487081a366a59f4e6762979f5b15b9@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a6374c5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=LCagy2Ma_--e8QgrMPEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Jw45BPo2p4PPc_FwVTXZl2J-IUupo0gh
X-Proofpoint-GUID: Jw45BPo2p4PPc_FwVTXZl2J-IUupo0gh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX/JYNW6Dksb2o
 XzC5kkRlQ5vppqxNOYV8ZW/XDBxXMKIUSvELgFll9Urlmd9kMW39OSdVl0jzcXobguiUkDZrvZu
 8CS25nzBCSYT3CzTsBmHXRTjH+ojF2oa6PlkW6bVNH46Oq3gAOiwW7quGeQQeuOLLfKwarWfzFd
 PzC9qGSruWXFjtPSPICFYs7ePpQC8a7VhE7wYPQkuQXB3uu3p14kY8eL6rYUoDsiTsvuE6XJU+H
 66+6UB9MDm1f9wgjyygPSkcbQjKzGbPy42gSAkCZmVxSx6hZkJ+YH6NliPBisfAXPsvtPYJjUeT
 BRKj/YeKgOifuQlqRi24eiml15PeSKt9Kt94ZZGAe+WQIwg+hI9UJ4jue/Zr1VzhCwvEneUIS5K
 H1F+NVqWmiq9jlX8UlFzA4u5e/GYn3CfDumtqaL6LNHYLlVmZpfj7PngxKTo3YojaWcC7V0Ed3h
 ARgESsaY7Ln82w3XUCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX36TdDY0jV5ZD
 hOyCA4QoRCWo0EX7KFZLxgtjtaX69cqAPLlOIuaEDLnKWsqHq4aqcedsUZ2AzZcQxpIWB2Ahbr8
 2frKwRUzDMsi8faQlGmer+RYOEODvlQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240128
Received-SPF: pass client-ip=148.163.156.1; envelope-from=freude@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
Reply-To: freude@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-07-14 16:16, Daniel P. Berrangé wrote:
> On Fri, Jul 10, 2026 at 05:28:50PM +0200, Harald Freudenberger wrote:
>> Add a new file crypto/aes-helpers.c with simple functions
>> to support some AES modes:
>> - AES cbc: AES_cbc_encrypt() AES_cbc_decrypt()
>> - AES ctr: AES_ctr_encrypt()
>> - AES xts: AES_xts_encrypt() AES_xts_decrypt()
>> and some AES related helpers:
>> - AES_xor()
>> - AES_xts_prep_next_tweak()
>> Add header file include/crypto/aes-helpers.h for these functions
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>> ---
>>  crypto/aes-helpers.c         | 106 ++++++++++++++++++++++++++++++++
>>  crypto/meson.build           |   1 +
>>  include/crypto/aes-helpers.h | 116 
>> +++++++++++++++++++++++++++++++++++
>>  3 files changed, 223 insertions(+)
>>  create mode 100644 crypto/aes-helpers.c
>>  create mode 100644 include/crypto/aes-helpers.h
> 
>> diff --git a/include/crypto/aes-helpers.h 
>> b/include/crypto/aes-helpers.h
>> new file mode 100644
>> index 0000000000..c1552b0e8f
>> --- /dev/null
>> +++ b/include/crypto/aes-helpers.h
>> @@ -0,0 +1,116 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * AES helper functions and modes
>> + */
>> +
>> +#ifndef QEMU_AES_HELPERS_H
>> +#define QEMU_AES_HELPERS_H
>> +
>> +/**
>> + * AES_xor:
>> + *
>> + * Bitwise XOR operation between two AES blocks.
>> + *
>> + * @src1: first source buffer of AES_BLOCK_SIZE bytes
>> + * @src2: second source buffer of AES_BLOCK_SIZE bytes
>> + * @dst: destination buffer of AES_BLOCK_SIZE bytes
> 
> nit-picking - the list of parameters should normally be at the
> start of the docs comment, immediately after the function name,
> and then the description follows

Ok, done -> see v13

> 
> With that change made:
> 
>   Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>   Acked-by: Daniel P. Berrangé <berrange@redhat.com>
> 

Thanks for your review.

> 
> 
> With regards,
> Daniel

