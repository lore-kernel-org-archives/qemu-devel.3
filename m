Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB69EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weB4s-0001Hu-TJ; Mon, 29 Jun 2026 08:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1weB4r-0001Ge-LX; Mon, 29 Jun 2026 08:27:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1weB4q-0003hf-05; Mon, 29 Jun 2026 08:27:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAmJ4l3030319; Mon, 29 Jun 2026 12:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=AhvgWBqBK+gyx3Qqoia17/KZeoYe0d0Vgb6jf0VEkgw=; b=PpuUX6814gB8
 zzWw2fS+UzyY4KbVw5s05ntVqn0xC9X1ouc89NlDyr34PJn0ZSEWr/cJDVNB2Qzx
 pfHRXHyyWKDl4kNhghKAZgBU9kc+Vg6SoMGTDMcwzmXogwrVxmdg1DXvFU2Zxph+
 xilG6DwB5+InrCBwvjPXvXpjJqvxPkaXNvR/sR+xaENqBS9tYinBfyBimhaoV4kl
 igqyKalwvIvGftPtSd4hsuVqc83supUp/Rl0S+imQReHzLybUwQ1U6+OuRWzktme
 SJR5Wun5IpoKkEf9+7c67zqHlYKDR/mCqESyzaz36AmMtWKoAmWruVOX5MvFBySo
 6zDts7gJwg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pds9js-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 12:26:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TCJmee032478;
 Mon, 29 Jun 2026 12:26:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq5j74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 12:26:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65TCQt9618285158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jun 2026 12:26:56 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1E385805F;
 Mon, 29 Jun 2026 12:26:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89DD058062;
 Mon, 29 Jun 2026 12:26:54 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Jun 2026 12:26:54 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 29 Jun 2026 14:26:54 +0200
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
In-Reply-To: <29ecbee8-2452-47cc-89cb-7d7a26abb685@oss.qualcomm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
 <29ecbee8-2452-47cc-89cb-7d7a26abb685@oss.qualcomm.com>
Message-ID: <4d2925e1d9f9f2cb78601c65fefb621c@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GxuyfIghLTY5NmzupVbslA-cW1v7HlNr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwMSBTYWx0ZWRfXzkSKdlI7oOJi
 yF+J02GryK8HTWHo69DBeeWZHGs/E9HmEywj5Mgfp8b391UUvmPw8XVPv/aXjcIKb7MSFZtm8Ur
 MMdrpqfbBs8xiFbOo0YoaK7D6g6wvMI=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a426492 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Wqay2uD6u1lBzW4eh1cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwMSBTYWx0ZWRfX+ImgEoRC7qI3
 9um/vzSQcRExqIwkProFOb0frGswV5h6KH1lN8UL88iVyVBEuQ3z6oiZzG+y8yCdJ6KUftDfxvx
 KOPxFmxRYxedzVDyG1BW18pAzsCFZxicYBSP15RhlVL2MgGCEUODoPgwOF3jQo7GnBTmHeiYCC0
 SJVrPDjNMAwBFL2c+xc4IDJ6VgoAkyg2HTT0uanzjmZfABNxGdNAwM8Wkw6J2kHLIzpOwQV2lNC
 R2RZLC8JTrNdW+C6Nf5cHnst1uTLHqB4lkHGZ0E3HUZFP/GMdY/gLlva7rPfbcvNX/YWH0F+8pe
 X9ZytQlEgcw4PVXuL6ymwdRwlzedlJ2kRqN6naZt0rC8H58vtg3HQcUY4UBFaKufirVkkCjcl07
 uVDnKQU88v5Khzzoig1RT6XhN68DV4tgL3I35lcRCZvw6hu0VWMcID89nC0uR+JPxW5/raQU8dz
 bXmI7FJTj2zwcCcrFbg==
X-Proofpoint-ORIG-GUID: GxuyfIghLTY5NmzupVbslA-cW1v7HlNr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
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

On 2026-06-24 12:05, Philippe Mathieu-Daudé wrote:
> Hi Harald,
> 
> On 24/6/26 10:09, Harald Freudenberger wrote:
>> With the introduction of the address wrapping function
>> wrap_address() the result can't be used to walk the
>> source address any more. So introduce a new local variable
>> to hold the wrapped address to avoid mixing source and
>> wrapped address value.
>> 
>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>> argument")
> 
> This commit merely added an argument. I suppose you meant
> 9f17bfdab42 ("target/s390x: support SHA-512 extensions").

Yep, you are right. This addr overwrite was introduced with the
original code - thus the commit you mentioned. I'll correct it.

> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>> 
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
> 
> s/_addr/wa/ or even directly inline?
> 
>            a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
> 
>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>       }
>>   }

Yes, let's make all these occurrences directly inline.

