Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98402C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBYd-0008SF-4E; Mon, 29 Jun 2026 08:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1weBYQ-0008MA-GU; Mon, 29 Jun 2026 08:57:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1weBYO-000770-Qe; Mon, 29 Jun 2026 08:57:38 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAmiEJ2921871; Mon, 29 Jun 2026 12:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=ztRGkR8tk19o9CH6mEohp1ZLVndi3kFXcPKqtLkyiRg=; b=GpfV269ngloo
 eXrOEb4pnon/7KtA7G1QW7y7pEjFPUjbJD674GDuzrScp6pg0Y5wYN/qeRx+gZ3a
 rRy6EU5qwYDdsGWWAy3dCYkK9CWhAjnZiLaSX3tnt2uQIy+J9ynqVF/e/2q+TTUu
 FY/rBY/9CSOFKu2h0ZY39RzxI6NBmMrR785TXuqK3+saH6GQZ7hxeq/4gzWKXvAw
 FD4QpIRp5EFeW4Poulgi0rcsSzFNBjs2xke1CEIgreYD7iHJV/qp2raPEEFI20Cz
 Be/gmInaNWMAv8ajEVik7fBfP8V9dVnBxiPcT5AnPy9VmCO7DJ3tQ/wQY37uQg6r
 cmqy3B1IUA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26q9s796-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 12:57:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TCnlH5012372;
 Mon, 29 Jun 2026 12:57:31 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy58sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 12:57:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65TCvUx527394690
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jun 2026 12:57:30 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2EC55805E;
 Mon, 29 Jun 2026 12:57:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8C5858043;
 Mon, 29 Jun 2026 12:57:29 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Jun 2026 12:57:29 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 29 Jun 2026 14:57:29 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
 berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <e516de9c-e9fb-45af-aa5e-8cb9dbf1e3f3@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
 <e516de9c-e9fb-45af-aa5e-8cb9dbf1e3f3@linux.ibm.com>
Message-ID: <d55a9d7e7759251c1e75050a9a9ccd6f@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwNiBTYWx0ZWRfX0tKPxL66K/I8
 M0tB5NyRsf8/pgE0mYodYYF3V/29+dY/Y9SznEBiblKfp2eT/8MwmciobJQV+LPdcngdyep9szB
 LAdZp7jSKjjqOvJqscgbZK+f9B4soMhpxLJ01S34fa3+XpBY/rqM2MF7VS5lK3MDsCIH0iKMqIi
 OQ/9iCrZ8fid8n6A4/zAnCtWOQwyQ8mRN783n3qXirkJmyFWo9TwauqN26nyIUa2NW1bchw8nCR
 4HKDn3zE2yrQ0ED9O4C9zFxT8jRQbhMCVg4v91s96PobmAq90Cifryxmj3oytMdGAaqw/EAHJ91
 USdptUEEEcYjXV2IaJsRNXwG2bAXPywFJ8cndXK969TxnlvxVVPF6BA3myBpp8zV5oa0iAysT/x
 po+WEi85VGLZS4+NXLz8q74L4id8IleK6sJ8E7gX+h2r/h2K67yGwOWMU5DxYCxdBdOrs31+C0p
 4tMckC75YKYBrF3iPew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwNiBTYWx0ZWRfX5IntqDZjTMYq
 BTfTwZ1RODhljfT0erhsiRh9qAOCTQRz1tyJ9ldgYPpPrlZJ32bCV3lVDR6FQ4a/duzhuNIER3U
 vdB1Y2bX3xN/SdeCWKNsmKnouftNkgc=
X-Proofpoint-GUID: 9bk3po2i1DPTTnSXdMPCkKn108xMGY0H
X-Proofpoint-ORIG-GUID: 9bk3po2i1DPTTnSXdMPCkKn108xMGY0H
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a426bbc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=q-Bucc0gGw48xEf_XpsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290106
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
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
Reply-To: freude@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-06-24 14:56, Ilya Leoshkevich wrote:
> On 6/24/26 10:09, Harald Freudenberger wrote:
>> With the introduction of the address wrapping function
>> wrap_address() the result can't be used to walk the
>> source address any more. So introduce a new local variable
>> to hold the wrapped address to avoid mixing source and
>> wrapped address value.
>> 
>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>> argument")
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> If I take as an example AMODE 24 and look at the third loop iteration,
> with the current code in master I would get:
> 
>     ((((addr & 0xffffff) + 8) & 0xffffff) + 8) & 0xffffff
> 
> and with your patch it would be:
> 
>     (addr + 8 + 8) & 0xffffff
> 
> which is undeniably more elegant, but otherwise looks equivalent to me.
> 
> What is the functional issue here?
> 
>> diff --git a/target/s390x/tcg/crypto_helper.c 
>> b/target/s390x/tcg/crypto_helper.c
>> index ae392bce0e..29ad2aff43 100644
>> --- a/target/s390x/tcg/crypto_helper.c
>> +++ b/target/s390x/tcg/crypto_helper.c
>> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState *env, 
>> const int mmu_idx,
>>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, 
>> mmu_idx);
>>         for (int i = 0; i < 8; i++, addr += 8) {
>> -        addr = wrap_address(env, addr);
>> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>> +        uint64_t _addr = wrap_address(env, addr);
>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>       }
>>   }
> 
> [...]

It is a fix, not an improvement. The original code
used the addr variable to hold the wrapped address.
But as addr is also used as the loop variable there
is a mixing between unwrapped and wrapped address here
and the unfixed code only works when wrap_address does
return the very same address as output as it became as
input. My fix corrects this.

