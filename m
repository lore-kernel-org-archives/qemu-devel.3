Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03C1C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6LC-0007jL-0L; Tue, 07 Jul 2026 10:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wh6L8-0007hn-KR; Tue, 07 Jul 2026 09:59:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wh6L6-0000dS-2r; Tue, 07 Jul 2026 09:59:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667CISl73638188; Tue, 7 Jul 2026 13:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=p5N46SyAoidWVc7oX6kzl9bOjk2pNUG4kurTkBR3PkY=; b=Ne1oPX64Ufff
 imIgZfpbuIPgpserp7pTz2fKzFf9/+NyI6FR/Bmp+a/57VORFHwI28LfPz7MChMQ
 VCZIXBRVhCE7l0tBYdeAOFmlgsiEmbwIdsIfcRzGaE4gPAoH0tIYQvxQTKqr7h9m
 pQywC/ydJ22e0CrLzzz2bPfImZLlX67fWXd/mxZK8Fbgd1/4YD/dvaR0i+JU80Yb
 anf5Y+nTL5tAyVRZeVCbAMLpTT5yDN5+n508+rnJcSNWLjbufzldZjNc2adJiaPO
 wRfDMzr8d4FbdibuDIjuK1OMFjD82ytPiGLm9d4UkYdWX+adZsgn1wxpg2FFnhI5
 ACv/psXZXg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3qkbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 13:59:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667DnhbG020523;
 Tue, 7 Jul 2026 13:59:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw38w7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 13:59:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667DxmKa55247116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 13:59:48 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66C3E58056;
 Tue,  7 Jul 2026 13:59:48 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E7175803F;
 Tue,  7 Jul 2026 13:59:47 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 13:59:47 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 07 Jul 2026 15:59:47 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v10 08/21] target/s390x: Minimal AES XTS support for cpacf
 pcc instruction
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <4ed5f841-f757-4ba2-80df-ba2d378a7c8c@linux.ibm.com>
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <20260706094317.17032-9-freude@linux.ibm.com>
 <4ed5f841-f757-4ba2-80df-ba2d378a7c8c@linux.ibm.com>
Message-ID: <6d033d8032ea7d32aee473e48eeb61e0@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4d0657 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ko3a8Pm9YmVD1mtTZ6gA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzNSBTYWx0ZWRfX4tGACzwVQDkp
 j0r76Uso8BPDsWgH4jDbeQ8P0J3Uj0duhSXCfAh93Jf733953N8mNCBnFLOk4Gpi2WWqua/f5+E
 MaBregHHCvqzFQFpcZHYGpoUYYeW2X0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzNSBTYWx0ZWRfX8MTLaSMY9u/D
 /bpxFar7hECl7kAmOWGM4bijnWZwqQ0kM+JpZMksf/SFxKreDY/9TbC0CGN1X3UxRf/8iGHLkpr
 SR5QpHVnLcDqWNqvIgoUPNIFjuweAceYOWiOGghHVEED66yPXuX/gi8CP1zmuy4VFqpNy1T3Rt7
 kIAGH+T3ykmCD/57bCzK5QfbUxM3BmSmq+4dzPQxtR5bCaWScU3SRlHDxK2bQKRjbl7n1qRPJBO
 GyjkFJ7kBs0kNGws9lxf+Y71g9FKH9qiV86kXHYRPY0S4XlqfhxJbOzeU9hsjoQcUzawpECSPUy
 yWXRuAzVaT900scU51eWNY+1LfVO/lGzLoJi9Y4uvDSKktSZfhRvCTHXPyEgjUINHqXqjDtxw/R
 40a7cW/D2UB34K/03APfwG9yt5ZOpB3noDWjMviUZvxPFoCwpnK/pYZXC3MsujoPSaLl/kaycCe
 9etPqpV5eupDWpfLVuA==
X-Proofpoint-ORIG-GUID: sN9Uh5vZsz1e1UWAXVaIR1hIQB_W7Q0c
X-Proofpoint-GUID: sN9Uh5vZsz1e1UWAXVaIR1hIQB_W7Q0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070135
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

On 2026-07-07 09:21, Holger Dengler wrote:
> On 7/6/26 11:43, Harald Freudenberger wrote:
>> Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-AES-128
>> and PCC-Compute-XTS-Parameter-AES-128 but only for the special
> 
> typo(?): --> PCC-Compute-XTS-Parameter-AES-256
> 
>> case block sequential number is 0. However, this covers the s390
>> AES XTS implementation in the Linux kernel and Libica and thus
>> also Opencryptoki clear key via Libica.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> 
> Ordering? (T-b first, then S-o-b). See my comment below.
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 

Yea ... ordering

>> ---
>>   target/s390x/gen-features.c      |  2 +
>>   target/s390x/tcg/cpacf.h         |  2 +
>>   target/s390x/tcg/cpacf_aes.c     | 63 
>> ++++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c | 20 ++++++++++
>>   4 files changed, 87 insertions(+)
>> 
> [...]
>> diff --git a/target/s390x/tcg/cpacf_aes.c 
>> b/target/s390x/tcg/cpacf_aes.c
>> index 3d6aa19df2..f41b7dc541 100644
>> --- a/target/s390x/tcg/cpacf_aes.c
>> +++ b/target/s390x/tcg/cpacf_aes.c
>> @@ -290,3 +290,66 @@ int cpacf_aes_ctr(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>         return !len ? 0 : 3;
>>   }
>> +
>> +int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t 
>> ra,
>> +                  uint64_t param_addr, uint8_t fc)
>> +{
>> +    uint8_t key[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
>> +    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>> +    int keysize, i;
>> +    uint64_t addr;
>> +    AES_KEY exkey;
>> +
>> +    switch (fc) {
>> +    case CPACF_PCC_XTS_AES_128:
>> +        keysize = 16;
>> +        break;
>> +    case CPACF_PCC_XTS_AES_256:
>> +        keysize = 32;
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    /* fetch block sequence nr from param block into buf */
>> +    for (i = 0; i < AES_BLOCK_SIZE; i++) {
>> +        addr = wrap_address(env, param_addr + keysize + 
>> AES_BLOCK_SIZE + i);
>> +        buf[i] = cpu_ldb_mmu(env, addr, oi, ra);
>> +    }
>> +
>> +    /* is the block sequence nr 0 ? */
>> +    for (i = 0; i < AES_BLOCK_SIZE && !buf[i]; i++) {
>> +            ;
>> +    }
>> +    if (i < AES_BLOCK_SIZE) {
>> +        /* no, sorry handling of non zero block sequence is not 
>> implemented */
>> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> +        return 1;
>> +    }
> 
> Why not
> 
> for (i = 0; i < AES_BLOCK_SIZE && !buf[i]; i++);
> if (i < AES_BLOCK_SIZE) {
> ...
> 
> Or would that be against the coding guidelines?
> 

Yes. Qemu requires to always use {}.
But I could do some (inline) function is_mem_zero(mem, len)
instead. Maybe in v11 then.

> I personally would prefer the following, because it is more obvious.
> But your solution also works, so feel free to change it or leave it as
> is.
> 
> for (i = 0; i < AES_BLOCK_SIZE; i++) {
>     if (buf[i]) {
>         /*
>          * no, sorry handling of non zero block sequence is not
>          * implemented
>          */
>         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>         return 1;
>     }
> }
> 
> IMO, it is easier to read.
> 
> [...]

