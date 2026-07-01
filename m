Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8D6C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wepb1-0007iM-SU; Wed, 01 Jul 2026 03:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wepax-0007hk-P3; Wed, 01 Jul 2026 03:42:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wepau-0003di-6B; Wed, 01 Jul 2026 03:42:55 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6613IEVf3925066; Wed, 1 Jul 2026 07:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=RM6+3mkfORi3FtboyDGJOAEYU9NSVP3wsDaiCiHRD5k=; b=mpfkfZZgPWE1
 E95GP+x38ydaH3/uB6TzIRH11ON9ATFFljq76qz6V2Ti8CSt9EnP2Ty6AQKFents
 2tB/duhUYK4AzyxwRV892iNHTtmTuETE/lpqk5xt7rA875/vrnVaPOSNBfIOniuP
 vwA7UTy0lZWrM4y3c6kIbAPBTtKVp4UHDVNt2FsCnc/7wROJ09T/rSOpdfYEMp2u
 efwTaS/peDp/rukKHJZsbUwUYQUSepvcHqR2ZO2wXPUGAmYcHmU5rUvwu9p74mbx
 C9W4XHG0FWwxKL0WeBnAwNKRTiJj+j4ZzdPJz+V1Hmodxs7efLb6S/lK+uJXCSVD
 c0yBdfPWIQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe386f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 07:42:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6617YgKX000655;
 Wed, 1 Jul 2026 07:42:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhye046-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 07:42:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6617geKR26018514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 07:42:40 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14AF358054;
 Wed,  1 Jul 2026 07:42:40 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 968695805C;
 Wed,  1 Jul 2026 07:42:38 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 07:42:38 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 01 Jul 2026 09:42:38 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, richard.henderson@linaro.org,
 david@kernel.org, thuth@redhat.com, berrange@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <b13c7644-83aa-48c8-9045-550a436b57ad@oss.qualcomm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
 <e516de9c-e9fb-45af-aa5e-8cb9dbf1e3f3@linux.ibm.com>
 <d55a9d7e7759251c1e75050a9a9ccd6f@linux.ibm.com>
 <6e7ce946-1128-4b2c-9520-a171bca3ceb7@linux.ibm.com>
 <a6e637d07024e0ff8a457500110e225f@linux.ibm.com>
 <9cbb2f6f-c80e-4ba8-a307-4f640f64a8a5@linux.ibm.com>
 <b13c7644-83aa-48c8-9045-550a436b57ad@oss.qualcomm.com>
Message-ID: <d6e0a18ac424ae1fc31fc3a437e983b2@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tjtGnImnMSepl9nTpZp_lTj6cI8IXSbg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NCBTYWx0ZWRfX9t9QzJYnGAEU
 2yvyKPXGuIos6ERhDQ9RovG0RoWDrbyWFx8RHKM2QFcvX1oeT+H/wpIf+uHFR5Bz+RDS2U8dDDb
 LqtAkShsxAyIwMLZcXPAstFvIqvDnjQ=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a44c4f2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=S5ATVKC61F_2tYt7UqEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NCBTYWx0ZWRfX9HlzwggIDTwm
 V/9lIqDDYd+pfOod7W41gemtQHE2VCO3Z+LPQUtrP2uzlL4Dq1g3frz3ofg4wErzjI7KOepPaa5
 KQG92N0ytWzMQndFryva1vnmw7jHmHHYKMQ3EDnzoXKU4nBH5GGYe5tw5fZLnLYAO4QCg+QJUHF
 5Lxc1Pht0TMKuvCHX/+cyTzXC5dW46RzruVFLD7g7braCeywtSDLeG3D83/Yap8WtWc93qGN6qW
 NztzI15kTUM1jq10C7ngIcnAetqOfNbL2EEPFW9Pk1X/akUzEQHPltbhjnhK+T6v4uO6soj/gux
 u3U1xCjRmojmNSe35RSiIrpsV6PRvJPxfo4SfpwtmlLlH3uPZPagNxRZmbRu2LYPn4mRO5IMvdY
 ikl+0a7v2w+WM3WIrQMPUBTI/bYmIpgqH2tMnAtOUX/4fMyGM1JNu4Dohi4Yk+/yta0fqFYlhIc
 eAPi0p7et770N8MlrqA==
X-Proofpoint-ORIG-GUID: tjtGnImnMSepl9nTpZp_lTj6cI8IXSbg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010074
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

On 2026-06-30 16:19, Philippe Mathieu-Daudé wrote:
> On 30/6/26 12:54, Ilya Leoshkevich wrote:
>> 
>> 
>> On 6/30/26 12:23, Harald Freudenberger wrote:
>>> On 2026-06-30 11:33, Ilya Leoshkevich wrote:
>>>> On 6/29/26 14:57, Harald Freudenberger wrote:
>>>>> On 2026-06-24 14:56, Ilya Leoshkevich wrote:
>>>>>> On 6/24/26 10:09, Harald Freudenberger wrote:
>>>>>>> With the introduction of the address wrapping function
>>>>>>> wrap_address() the result can't be used to walk the
>>>>>>> source address any more. So introduce a new local variable
>>>>>>> to hold the wrapped address to avoid mixing source and
>>>>>>> wrapped address value.
>>>>>>> 
>>>>>>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>>>>>>> argument")
>>>>>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>>>>>> ---
>>>>>>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>>>>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>>>> 
>>>>>> If I take as an example AMODE 24 and look at the third loop 
>>>>>> iteration,
>>>>>> with the current code in master I would get:
>>>>>> 
>>>>>>     ((((addr & 0xffffff) + 8) & 0xffffff) + 8) & 0xffffff
>>>>>> 
>>>>>> and with your patch it would be:
>>>>>> 
>>>>>>     (addr + 8 + 8) & 0xffffff
>>>>>> 
>>>>>> which is undeniably more elegant, but otherwise looks equivalent 
>>>>>> to me.
>>>>>> 
>>>>>> What is the functional issue here?
>>>>>> 
>>>>>>> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/ 
>>>>>>> crypto_helper.c
>>>>>>> index ae392bce0e..29ad2aff43 100644
>>>>>>> --- a/target/s390x/tcg/crypto_helper.c
>>>>>>> +++ b/target/s390x/tcg/crypto_helper.c
>>>>>>> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState 
>>>>>>> *env, const int mmu_idx,
>>>>>>>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | 
>>>>>>> MO_UNALN, mmu_idx);
>>>>>>>         for (int i = 0; i < 8; i++, addr += 8) {
>>>>>>> -        addr = wrap_address(env, addr);
>>>>>>> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>>>>>>> +        uint64_t _addr = wrap_address(env, addr);
>>>>>>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>>>>>>       }
>>>>>>>   }
>>>>>> 
>>>>>> [...]
>>>>> 
>>>>> It is a fix, not an improvement. The original code
>>>>> used the addr variable to hold the wrapped address.
>>>>> But as addr is also used as the loop variable there
>>>>> is a mixing between unwrapped and wrapped address here
>>>>> and the unfixed code only works when wrap_address does
>>>>> return the very same address as output as it became as
>>>>> input. My fix corrects this.
>>>> 
>>>> What does the patch change w.r.t. wrapping?
>>>> Suppose we have amode 24 and addr = 0xfffff0:
>>>> 
>>>> Before:
>>>> 
>>>>   i = 0; addr = wrap(0xfffff0) = 0xfffff0;
>>>>          a[0] = ldq(0xfffff0);
>>>>   i = 1; addr = wrap(0xfffff0 + 8) = 0xfffff8;
>>>>          a[1] = ldq(0xfffff8);
>>>>   i = 2; addr = wrap(0xfffff8 + 8) = 0;
>>>>          a[2] = ldq(0);
>>>>   i = 3; addr = wrap(0 + 8) = 8;
>>>>          a[3] = ldq(8);
>>>> 
>>>> After:
>>>> 
>>>>   i = 0; addr = 0xfffff0;
>>>>          _addr = wrap(0xfffff0) = 0xfffff0;
>>>>          a[0] = ldq(0xfffff0)
>>>>   i = 1; addr = 0xfffff0 + 8;
>>>>          _addr = wrap(0xfffff8) = 0xfffff8;
>>>>          a[1] = ldq(0xfffff8);
>>>>   i = 2; addr = 0xfffff8 + 8 = 0x1000000
>>>>          _addr = wrap(0x1000000) = 0;
>>>>          a[2] = ldq(0);
>>>>   i = 3; addr = 0x1000000 + 8 = 0x1000008;
>>>>          _addr = wrap(0x1000008) = 8;
>>>>          a[3] = ldq(8);
>>>> 
>>>> The behavior look identical to me.
>>>> What am I missing?
>>> 
>>> Lets assume addr is some 0x1000 and wrap does just add some offset, 
>>> e.g. 0x8000
>>> 
>>> for (int i = 0; i < 8; i++, addr += 8) {
>>>      addr = wrap_address(env, addr);
>>>      fetch or write something at the wrapped address addr;
>>> }
>>> 
>>> Then the idea of this loop is to run through addr 0x1000 ... 0x103F.
>>> 1. loop with i=0 and addr 0x1000
>>> 2. loop with i=1 and addr 0x1000 + 8
>>> 3. loop with i=2 and addr 0x1000 + 8 + 8
>>> 4. loop with i=3 and addr 0x1000 + 8 + 8 + 8
>>> 5. loop with i=4 and addr 0x1000 + 8 + 8 + 8 + 8
>>> 6. loop with i=5 and addr 0x1000 + 8 + 8 + 8 + 8 + 8
>>> 7. loop with i=6 and addr 0x1000 + 8 + 8 + 8 + 8 + 8 + 8
>>> 8. loop with i=7 and addr 0x1000 + 8 + 8 + 8 + 8 + 8 + 8 + 8
>>> 
>>> BUT the given code does something different. As the addr is used in 
>>> the loop
>>> to hold the wrapped address this loop in fact does:
>>> 1. loop with i=0 and addr 0x1000 - all fine, but as addr = 
>>> wrap_address() at the
>>>     end of the loop now addr is 0x1000 + 0x8000 = 0x9000, so next 
>>> loop starts with
>>> 2. loop with i=1 and addr 0x9000 + 8
>>>     and at the end of the loop addr is 0x9008 + 0x8000 = 0x11008 and 
>>> next loop starts
>>> 3. loop with i=2 and addr 0x11008 + 8
>>>     ...
>>> 
>>> So introducing an intermediate variable which holds the wrapped 
>>> address
>>> makes sure the surrounding addr walk in the loop does as intended.
>> 
>> Ah, now I see where we were talking past each other, thanks for the
>> clarification. You assume that wrap_address() may do arbitrary
>> transformations, like addition in your example above. But today it 
>> does
>> only bitwise "and", as defined by the architecture:
>> 
>> static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
>> {
>>      if (!(env->psw.mask & PSW_MASK_64)) {
>>          if (!(env->psw.mask & PSW_MASK_32)) {
>>              /* 24-Bit mode */
>>              a &= 0x00ffffff;
>>          } else {
>>              /* 31-Bit mode */
>>              a &= 0x7fffffff;
>>          }
> 
>            bool wrap32 = env->psw.mask & PSW_MASK_32;
>            a = extract64(a, 0, wrap32 ? 31 : 24);
>>      }
>>      return a;
>> }
>> 
>> and I believe in this specific case the order doesn't matter.
>> 

Hm, however a wrap_address() function may return whatever
wrapping address calculation may be. A caller should not
rely on the returned address being 'the same' as the address
given in. So using separate variables for the address to
wrap and the wrapped address is wise in my opinion.

