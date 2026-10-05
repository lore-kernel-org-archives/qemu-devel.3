Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F100CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDifv-000615-Lk; Mon, 05 Oct 2026 09:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDifU-00060H-0q; Mon, 05 Oct 2026 09:23:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDifR-0004OX-Ne; Mon, 05 Oct 2026 09:23:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CZaT03033433; Mon, 5 Oct 2026 13:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Z/BAEU
 MfO5XLYAsGPgMHf9JY/3EoWRJswtCwR8ilZtw=; b=fImwpZPev+EhJzwDfh8jlX
 oDoU5K8oKG9k7rUTUzwP0p4ethbFjsVK6LYREh1hvHdqLJkotLRUBweWJAYggowX
 KVl6cZZq2WARAnP5keyhUMN1vjPj1cvcKcYwehLueHJ50y3duGg08ak4BegnbHfV
 f6wrZC8J/ZO3TKnBfJv8hR+gaPDA7/AlV6pyQUtXWoPDcVPhhHcGG3nHIe253RbV
 pA7sX0LVok7OMbx2norgAXSLKZK7dGegmqlMhVICXGIZj3pYs4rWSVTy2dh8Uv6O
 DTKJ+bgGQFhaNrMF83BhGc7TlMw57yquC78BpLDaNU5zzw0B4aIkBoeqiELPd/vw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scradt6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 13:23:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CI13R2874749; Mon, 5 Oct 2026 13:23:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jnkhv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 13:23:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695DNcbc19071560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 13:23:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3C6D5805A;
 Mon,  5 Oct 2026 13:23:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E3EE58052;
 Mon,  5 Oct 2026 13:23:38 +0000 (GMT)
Received: from [9.16.60.171] (unknown [9.16.60.171])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 13:23:38 +0000 (GMT)
Message-ID: <cbd6f028-1c29-42fc-b7fc-7510ecc08ac6@linux.ibm.com>
Date: Mon, 5 Oct 2026 08:23:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/16] s390x/pci: Factor ioat sanity checks into a
 separate function
Content-Language: en-US
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260930145255.140164-1-kshk@linux.ibm.com>
 <20260930145255.140164-15-kshk@linux.ibm.com>
 <a58ad322-bfb3-4ca6-a9fd-098391da4f3b@linux.ibm.com>
 <606b2a78-52b5-40a7-87cc-3f247985aa51@linux.ibm.com>
In-Reply-To: <606b2a78-52b5-40a7-87cc-3f247985aa51@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MSBTYWx0ZWRfXyDjGdjVJi1xN
 qWEuNVElEPjvOd369kOG32/D8idz2wAvkMBul7hvwfJ2O4LCEKXFtHqxO8N5TX9hnGAo1azyxA3
 VFkUUSczD/PVyJZK9O3zGZRYZOB3+9g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MSBTYWx0ZWRfX+yBpLJin1528
 SAaMsSciSnrJ4VauTN6dTUSPaO4wkc8Rv00NKmHk9Mr6nU6B0/eT4Ne9p883LJTJguDLyBnNfsb
 Bi0InmIuz2ug9P7uf6hnMkxlzYZyGy9L6NkpVE2/xeyyNpiesHDxD/LV9oYDUEM5IX6/DP9vrv/
 VwoKuFiGHObf9mc14upVGtrX9DzSDP8MFZhj5xAtCqJ1vLLICrq22Nr+n+9iEsEUCLdxElrmzPP
 tCkGbTlChMhmQmmmpM5z2OAlmIh7xZcgW6t+nHC2UKSDTqera5Bq3bm75pfPlljAJER31LJeics
 hfRayIZ4Zps1SwQmFaYvRCsSXnINvY7yLpZWjZUikbQW9ZIekduoSOzcED4yfm1riZmA2s5P+b3
 3cH6znHw+YOLlzMMe/SJd+de9kuBZL56ut+PhZf+F7/K/bFPod3Blrlr3U0zS0ejgsu+TJp5W9b
 kPTtiPsjU26XB//9sJg==
X-Proofpoint-GUID: QMtXg-EQK2o-lywV2pAMTOvTAlaicj1I
X-Proofpoint-ORIG-GUID: QMtXg-EQK2o-lywV2pAMTOvTAlaicj1I
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac3a4dd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=M8hfrNKWCRZ6EoJrtGIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050051
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 261002 19:43, Konstantin Shkolnyy wrote:
> On 261002 13:28, Matthew Rosato wrote:
>>
>>> -static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, 
>>> ZpciFib fib,
>>> -                    uintptr_t ra)
>>> +bool s390_pci_ioat_validate(S390PCIBusDevice *pbdev, uint64_t pba,
>>> +                             uint64_t pal, uint64_t g_iota, Error 
>>> **errp)
>>>   {
>>> -    uint64_t pba = ldq_be_p(&fib.pba);
>>> -    uint64_t pal = ldq_be_p(&fib.pal);
>>> -    uint64_t g_iota = ldq_be_p(&fib.iota);
>>>       uint8_t dt = (g_iota >> 2) & 0x7;
>>>       bool t = s390_pci_is_translation_enabled(g_iota);
>>> -    pba &= ~0xfff;
>>> -    pal |= 0xfff;
>>>       if (pba > pal || pba < pbdev->zpci_fn.sdma || pal > pbdev- 
>>> >zpci_fn.edma) {
>>> -        s390_program_interrupt(env, PGM_OPERAND, ra);
>>> -        return -EINVAL;
>>> +        return false;
>>
>> This will now violate include/qapi/error.h because you're returning
>> false but not setting errp:
>>
>>   * - On success, the function should not touch *errp.  On failure, it
>>   *   should set a new error, e.g. with error_setg(errp, ...), or
>>   *   propagate an existing one, e.g. with error_propagate(errp, ...).
>>
>> A simple solution would be to add a new message for this case.
> 
> But the original reg_ioat() also didn't print any message in this error 
> branch. I had to assume it was intentional, and preserved the behavior.
> 
> If you believe a new message should be introduced, I can insert a commit 
> for that - what would be the explanation?

Other code sites reporting PGM_OPERAND also don't generate error 
messages - it appears, the current policy is not to do that in the cases 
when the guest is at fault (gave invalid parameters). The case at hand 
falls in that category.

> 
>>
>> [...]
>>> +
>>> +static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, 
>>> ZpciFib fib,
>>> +                    uintptr_t ra)
>>> +{
>>> +    Error *err = NULL;
>>> +    uint64_t pba = ldq_be_p(&fib.pba);
>>> +    uint64_t pal = ldq_be_p(&fib.pal);
>>> +    uint64_t g_iota = ldq_be_p(&fib.iota);
>>> +    bool t = s390_pci_is_translation_enabled(g_iota);
>>> +
>>> +    pba &= ~0xfff;
>>> +    pal |= 0xfff;
>>> +
>>> +    if (!s390_pci_ioat_validate(pbdev, pba, pal, g_iota, &err)) {
>>> +        if (err) {
>>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s\n", 
>>> error_get_pretty(err));
>>> +            error_free(err);
>>> +        }
>>
>> With that change, you won't need the if (err) check anymore.
>>
>> Thanks,
>> Matt
> 


