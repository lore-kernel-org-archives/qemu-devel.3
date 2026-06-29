Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5DFC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBLT-0004tl-CY; Mon, 29 Jun 2026 08:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1weBL4-0004qd-Df; Mon, 29 Jun 2026 08:43:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1weBL2-0001S1-74; Mon, 29 Jun 2026 08:43:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAmTpd3181970; Mon, 29 Jun 2026 12:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=dPbdjCwNnK8IOCg8soyyMUy6JflddGGILKq4Bj8rJ6c=; b=rNFGoWkdOX+d
 BQkUb5o8fDEVH0HZat+lOGU3Qr+smJCltZJRcVz9guSkJM4LvCgivt2Up7D+9fF6
 +in2H+JXvssS7o7mUyIY96dtgU1sx3l/Urv8hzNNo5u4fvSniNOmvqEsOWX6BLpf
 k9S/6i0MtE/aKVauBPnC0IPQh3trYzpG9vkyYg8ZnrtqZ/pW3izhHSndJ7FWWcdj
 wF2p+oLryuieTA5EtAIm4N3i4efV5SxdQPgMI3fkzvjC0r/6jamVzFBhoZZp96M2
 VsuCmhhmDLv4OoxHj4WxgteriGs4eh5N8QILwPteL2OdG3xlEfspXPTjkek1V+hC
 tZGOqTB34g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfsb0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 12:43:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TCYeCK027559;
 Mon, 29 Jun 2026 12:43:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy5783-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 12:43:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65TChfld35455248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jun 2026 12:43:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 662D65803F;
 Mon, 29 Jun 2026 12:43:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E949158056;
 Mon, 29 Jun 2026 12:43:39 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Jun 2026 12:43:39 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 29 Jun 2026 14:43:39 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <e217579b-50be-431d-8703-a19b3058f90b@oss.qualcomm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
 <29ecbee8-2452-47cc-89cb-7d7a26abb685@oss.qualcomm.com>
 <1fdb2816ac1592b4d08bc0060927bfeb@linux.ibm.com>
 <e217579b-50be-431d-8703-a19b3058f90b@oss.qualcomm.com>
Message-ID: <ddf3dc604cdc0e2d8294166306cb2187@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a42687f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=sAccT5BgK4xihKQz0gUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwMSBTYWx0ZWRfX5x81Umsuxjfw
 cmBQc8TMxmVhmCBzS/k6uQ1/9rUt7pRZX/BcAVyrW52kF25JyBVCWuRrruZwN8BCJZ21WnxAJ6P
 nMSK0idP3edgUN2mTkwVcoU5FXwbGb8=
X-Proofpoint-GUID: k3V7HL9t4sRPd2dL3dJWIPohAWN5ni1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwMSBTYWx0ZWRfX7aFaX2LSfV1a
 BEkS2SET7m56y46Q7bvRjX7vF4/Jfn6M3uRjLUM3/XTuYzbajfnXVtgiSlDN+JT6M2HLpXS0j0l
 i7ghwwsfX4QW1q2dNCWqNrzAmIfS+BLQFkeK68JCfZvG+r6j/O2zlU0z4Ks/HsDzC5PxnjzCK4H
 gsG0+RqgrN4nJEThRNuqSol/CmvkknClYNP/vutfI/vtMl9kJ3CWdfHcdoLLkN6aooFaDzFYZAj
 KycZhQggWaOxnWeLR/33B/gaiyxUdcA7L1agzj1cYAgf2Ef/A4FnVUvYowPohkaYpBhCtZdWYrV
 DuDzfrR944HwM5vQtZBVQ911+a+MYj8i8cl3pTFJV80x/sIV52cdjrWNElmMVMrd1mNVTJIrsjF
 rgp6oXHbiwWiGMKUTUOqsS5PRxanpvEBvb4XnBFWyKS0/FiF9vF1jp0DHCdc7xZ9GBJYdbqjYRo
 G4tHU5ZvynKfDWfyXZg==
X-Proofpoint-ORIG-GUID: k3V7HL9t4sRPd2dL3dJWIPohAWN5ni1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290101
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

On 2026-06-25 12:37, Philippe Mathieu-Daudé wrote:
> On 25/6/26 09:31, Harald Freudenberger wrote:
>> On 2026-06-24 12:05, Philippe Mathieu-Daudé wrote:
>>> Hi Harald,
>>> 
>>> On 24/6/26 10:09, Harald Freudenberger wrote:
>>>> With the introduction of the address wrapping function
>>>> wrap_address() the result can't be used to walk the
>>>> source address any more. So introduce a new local variable
>>>> to hold the wrapped address to avoid mixing source and
>>>> wrapped address value.
>>>> 
>>>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>>>> argument")
>>> 
>>> This commit merely added an argument. I suppose you meant
>>> 9f17bfdab42 ("target/s390x: support SHA-512 extensions").
>>> 
>> 
>> No. Commit fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>> argument")
>> introduces the mmu_idx with the wrap_address() function or macro.
> 
> You are saying the same, not really explaining, I'm not following...
> 

I rephrased my wording regarding this fix. Please see v9 coming soon.

>> And the result was something like this:
>> 
>>    for (int i = 0; i < 8; i++, addr += 8) {
>>      addr = wrap_address(env, addr);
>>      a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>>    }
>> 
>> This code reuses the addr variable in the loop
>> by setting addr to the wrapped address but after
>> that the loop adds +8 to this wrapped address.
>> This code only works as long as the wrapped address
>> is equal to the address put put in.
>> Thus introduce another intermediate variable which
>> holds the wrapped address:
>> 
>>    for (int i = 0; i < 8; i++, addr += 8) {
>>      uint64_t _addr = wrap_address(env, addr);
>>      a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>    }
>> 
>> Of course it would also work with a direct replacement:
>> 
>>    for (int i = 0; i < 8; i++, addr += 8) {
>>      a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
>>    }
>> 
>> but this isn't that readable.
>> 
>>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>>> ---
>>>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>> 
>>>> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/ 
>>>> crypto_helper.c
>>>> index ae392bce0e..29ad2aff43 100644
>>>> --- a/target/s390x/tcg/crypto_helper.c
>>>> +++ b/target/s390x/tcg/crypto_helper.c
>>>> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState *env, 
>>>> const int mmu_idx,
>>>>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, 
>>>> mmu_idx);
>>>>         for (int i = 0; i < 8; i++, addr += 8) {
>>>> -        addr = wrap_address(env, addr);
>>>> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>>>> +        uint64_t _addr = wrap_address(env, addr);
>>> 
>>> s/_addr/wa/ or even directly inline?
>>> 
>>>            a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
>>> 
>>>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>>>       }
>>>>   }
>> 


