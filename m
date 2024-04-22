Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CD7C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 06:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rynES-0007E1-LR; Mon, 22 Apr 2024 02:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rynEJ-0007AB-1W; Mon, 22 Apr 2024 02:32:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rynEH-0003z7-3B; Mon, 22 Apr 2024 02:32:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43M5E3ER002441; Mon, 22 Apr 2024 06:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7xyIOWXBe9jSBsLKF70/yc3QLrVv3/sbSoPSSEYHitU=;
 b=JOoIP1V6raw1YLaqsBalIoaZwUAK52p7TJmF5RxCzhieqA49YtMhCgaAXkbdc8WdfLZr
 L4OMOf/NPO7pyP/LDbjvw6v2bBDC6PmHblg4H7YhBKZmUmDoTen9OHJou9xVAot2EAJI
 AloffQ1ar9d72wkWkYqvuCmYkZuzNLLTDnTAqIJS+iDmPR+aHXlg/r3Nnm9GAw9QB08h
 ERLRnBOYVqVYlR2ojh97UJkNPArd/xmkWTTSk+cHUw7RrzHLuT69CtAd54uOJrYya/Mr
 IyCFPCLxOEZkAexPg75q0DFER/4Vdmvd1X9vvqjWAVHJRkeH1+DW6wQD3t+RA/LzvUx9 KA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xnhj60481-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Apr 2024 06:32:36 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43M6WZUI022717;
 Mon, 22 Apr 2024 06:32:35 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xnhj60480-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Apr 2024 06:32:35 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43M4FLs5005373; Mon, 22 Apr 2024 06:32:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3c4w3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Apr 2024 06:32:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43M6WTck53019124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Apr 2024 06:32:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63BEA20043;
 Mon, 22 Apr 2024 06:32:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15FDD20040;
 Mon, 22 Apr 2024 06:32:28 +0000 (GMT)
Received: from [9.199.192.140] (unknown [9.199.192.140])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Apr 2024 06:32:27 +0000 (GMT)
Message-ID: <4b4f7340-815c-4592-91f6-d0b9a68db775@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2024 12:02:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] target/ppc: Move multiply fixed-point insns (64-bit
 operands) to decodetree.
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-6-rathc@linux.ibm.com>
 <87bafba4-7a65-42e9-acf2-d05962ce7186@linaro.org>
 <fe7001b8-7e81-4634-8e45-3661b790c8b7@linux.vnet.ibm.com>
 <60632882-1c19-4dd0-aeab-d53d7ffd86f0@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <60632882-1c19-4dd0-aeab-d53d7ffd86f0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CBPrJ0lBab7LYdXO2ek7nj2Z2CSvrcR6
X-Proofpoint-ORIG-GUID: 5lPvCiLg9Hsa0dL2v9Oa8kWY1b8a6OW5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_03,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404220028
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Hi Richard,

On 4/20/24 21:21, Richard Henderson wrote:
> On 4/19/24 02:25, Chinmay Rath wrote:
>> Hi Richard,
>>
>> On 4/17/24 00:06, Richard Henderson wrote:
>>> On 4/15/24 23:39, Chinmay Rath wrote:
>>>> +static bool trans_MADDHDU(DisasContext *ctx, arg_MADDHDU *a)
>>> ...
>>>> +    tcg_gen_movi_i64(t1, 0);
>>>
>>> Drop the movi.
>>>
>>>> +    tcg_gen_add2_i64(t1, cpu_gpr[a->vrt], lo, hi, cpu_gpr[a->rc], 
>>>> t1);
>>>
>>> Use tcg_constant_i64(0).
>>>
>> Looks like tcg_gen_add2_i64 internally modifies the passed arguments, 
>> hence constant is not expected.
>> However, I tried using tcg_constant_i64(0) as suggested but this 
>> leads to an assert failure :
>> qemu-system-ppc64: ../tcg/tcg.c:5071: tcg_reg_alloc_op: Assertion 
>> `!temp_readonly(ts)' failed.
>
> You misunderstood my suggestion.
>
>   TCGv_i64 t1 = tcg_temp_new_i64();
>   tcg_gen_add2_i64(t1, cpu_gpr[vrt], lo, hi, cpu_gpr[a->rc], 
> tcg_constantant_i64(0));
>
Thank you for the clarification. Will add this to v2.
Regards,
Chinmay
>
> r~
>


