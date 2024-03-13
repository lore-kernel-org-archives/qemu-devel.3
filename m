Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0825AC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkN8r-0007xv-Nb; Wed, 13 Mar 2024 07:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rkN8p-0007xG-87; Wed, 13 Mar 2024 07:51:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rkN8m-00040O-4L; Wed, 13 Mar 2024 07:51:26 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42DB6jNH013100; Wed, 13 Mar 2024 11:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XiwRsVbqhwtQkWhhV6/5WlzBAZEoNvY+8IAeggKrTX8=;
 b=j0Y29R8tPNscNWX6iX96KQ4+HA3kFbQdTf4lA2BAf0oPDT7psgZjDwBB9yCz1gkNlfhw
 e+kcBrNU4NV+j4cqjgOw8gt3U1+BihsxvWZ/2rw3iCW6swTy7nO/BzZs8u/sP4/f4rl1
 akRs2/RlIXHF8TG4e8WuJYnxxt7jchzTkd1N1KgwLsVa88QBKQRfeF58CAhiNtwvwq/M
 b+PqCpL3zazCVH335bgNpQ1/y9VsbyJCqT40kQCqtif7VlHUYQOIVQpIqD29lHTgTyrl
 NOsieNhcEgS2LXh5iGEFzOrSMhsZg4rCeQSv+BcfNol9MTQBpQV5uA5EwnxRYf9cxNkl sA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wu6w3v049-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Mar 2024 11:51:09 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42DBp8QH017535;
 Wed, 13 Mar 2024 11:51:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wu6w3v047-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Mar 2024 11:51:08 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42D9Wos6015524; Wed, 13 Mar 2024 11:51:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2fywrpf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Mar 2024 11:51:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42DBp2Fn25363032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 11:51:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E0BC20040;
 Wed, 13 Mar 2024 11:51:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F6B220043;
 Wed, 13 Mar 2024 11:51:00 +0000 (GMT)
Received: from [9.199.192.140] (unknown [9.199.192.140])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 13 Mar 2024 11:51:00 +0000 (GMT)
Message-ID: <b647b088-7551-4f78-9cef-69adf9092699@linux.vnet.ibm.com>
Date: Wed, 13 Mar 2024 17:20:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Move floating-point arithmetic instructions
 to decodetree.
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, danielhb413@gmail.com, clg@kaod.org,
 harshpb@linux.ibm.com, sbhat@linux.ibm.com
References: <20240307110318.170319-1-rathc@linux.ibm.com>
 <CZRO4Y67CBPV.2IAKB80EFDKEY@wheely>
 <0c7c6be1-12fb-4267-9d41-bd51637d104a@linaro.org>
 <CZRU903MDUJ1.6S9RSO5A4RDG@wheely>
 <CAFEAcA8im7S-bsx-hYqgUy4tsc8yXjWQf7Sb-=KnuREyqqC8mw@mail.gmail.com>
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA8im7S-bsx-hYqgUy4tsc8yXjWQf7Sb-=KnuREyqqC8mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HS4CtudiXoWVxTZlAvFXN4MpHGmvlVf7
X-Proofpoint-ORIG-GUID: hRCSyB5MjGYpnMqRA2ZjqU6XEUB6_Rrh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1011 mlxlogscore=832
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130088
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 3/12/24 19:59, Peter Maydell wrote:
> On Tue, 12 Mar 2024 at 14:25, Nicholas Piggin <npiggin@gmail.com> wrote:
>> On Wed Mar 13, 2024 at 12:01 AM AEST, Richard Henderson wrote:
>>> On 3/11/24 23:36, Nicholas Piggin wrote:
>> [snip]
>>
>>>> #define FPU_HELPER(name, op, flags_handler)                           \
>>>> float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)   \
>>>> {                                                                     \
>>>>       float64 ret = op(arg1, arg2, &env->fp_status);                    \
>>>>       int flags = get_float_exception_flags(&env->fp_status);           \
>>>>       flags_handler(env, flags)                                         \
>>>>       return ret;                                                       \
>>>> }
>>>>
>>>> static inline void addsub_flags_handler(CPUPPCState *env, int flags)
>>>> {
>>>>       if (unlikely(flags & float_flag_invalid)) {
>>>>           float_invalid_op_addsub(env, flags, 1, GETPC());
>>>>       }
>>>> }
>>>>
>>>> static inline void mul_flags_handler(CPUPPCState *env, int flags)
>>>> {
>>>>       if (unlikely(flags & float_flag_invalid)) {
>>>>           float_invalid_op_mul(env, flags, 1, GETPC());
>>>>       }
>>>> }
>>>>
>>>> static inline void div_flags_handler(CPUPPCState *env, int flags)
>>>> {
>>>>       if (unlikely(flags & float_flag_invalid)) {
>>>>           float_invalid_op_div(env, flags, 1, GETPC());
>>>>       }
>>>>       if (unlikely(flags & float_flag_divbyzero)) {
>>>>           float_zero_divide_excp(env, GETPC());
>>>>       }
>>>> }
>>> Beware -- GETPC() may only be called from the outermost helper.
>> Ah, because it's using __builtin_return_address. Good to know.
>> Using always_inline and a comment should do the trick then.
> The standard way to fix this is that you call GETPC() at the
> outermost helper and then pass that value around as an extra
> uintptr_t ra argument to called functions that need it.
Thanks Peter, Nick and Richard. I shall post v2 with suggested updates.

Regards,
Chinmay
>
> thanks
> -- PMM
>


