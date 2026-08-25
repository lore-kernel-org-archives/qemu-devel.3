Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DF1C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 18:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyvVV-00010k-SY; Tue, 25 Aug 2026 14:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wyvVU-00010Q-6D; Tue, 25 Aug 2026 14:04:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wyvVR-0004fc-VM; Tue, 25 Aug 2026 14:04:19 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PI1V2R3932486; Tue, 25 Aug 2026 18:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zIKFcz
 3EcuTa2eULJvvkkTfU5rPWJOsZQy8iZ2ZPCFs=; b=btHphJ9eqO2idE0ffxayyh
 5E3crB7AlDHW2Sqeb7cqqdxS9tyJPABvMTBgzDX+rAFYq0rZZx/O76e3xYgPx7UF
 mYF10oRSH4vMm8XG8XlVF+ScdYQvS5GX1WWticcnshaFmXRiItXIuFPGMPdj0lar
 5aiYmO8XLjoi2T+xlCrKkMH3/O5C52xXHmpgzlqc2Ho1MnjH2Rp4PeVK07aNB83S
 VD3//Pc8xuC9OfjpSXpyLKm2QkUGOwA4+3itphL8LdbruAAdhXIwn83QTnkpB2/y
 Ww1HJYZCALwpjAXdoQggRLqYeV9kHh/VEZFK2JJjCQbSVFxjH2JSwnTff+bv55bQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqsudj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 18:04:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PHuGSE027880;
 Tue, 25 Aug 2026 18:04:13 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q5uk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 18:04:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67PI4BiS32047782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 18:04:11 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B8145805A;
 Tue, 25 Aug 2026 18:04:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A06EE5805C;
 Tue, 25 Aug 2026 18:04:10 +0000 (GMT)
Received: from [9.61.69.254] (unknown [9.61.69.254])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 25 Aug 2026 18:04:10 +0000 (GMT)
Message-ID: <36b43f47-32d7-4ff0-ad76-2d1ab1df2c7f@linux.ibm.com>
Date: Tue, 25 Aug 2026 14:04:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] hw/s390x/ipl: Fix incorrect PCI IPL block length
 constant
To: Zhuoying Cai <zycai@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com, "Jason J . Herne" <jjherne@linux.ibm.com>
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
 <20260811144629.866641-3-jrossi@linux.ibm.com>
 <51730ac3-ff1f-4eca-98f9-b31b47596185@linux.ibm.com>
 <1bf6e2a3-be53-47b3-8694-9b249770a655@linux.ibm.com>
 <0ba0a7aa-623a-48e3-bde9-48ee82331d1a@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <0ba0a7aa-623a-48e3-bde9-48ee82331d1a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3VcQ5RgoDCa_EOnciQA7YUjQIdVnmm4m
X-Proofpoint-ORIG-GUID: 3VcQ5RgoDCa_EOnciQA7YUjQIdVnmm4m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE1MyBTYWx0ZWRfX3rrUVWgW73Ef
 sCeb+i5aLjeX9GYAqfy89s3IHJxTBuDJ651Fa8mJNYWjpcYz63e2YEgZHoVYBpTEoIGiUB2VZWw
 +ZRd9XQCT8zfVSI7QH7ZmF1PWKNXPwVUjDnw+tVEp9S4k9Zv5SepwVcOIqQOxi4krmAjvM+Ewz+
 /wJNEPoQ3jEIHazpHceQOcUMdi+xAILIDTc3IKp8h24XlCkjYGAtVhGsvJw/oh4YSw9CIrFg+1y
 S0+UA0hnyF2WCJ5edl5HwV1exGsBGbFUJbnuUFozDSSKBIx5LB9Q227ilCjXsW3xJJ0qoa40QH+
 Y88ryWjxEdW8M8dzcT46FSEctD+fhALKVBQxLIX8bF7cNuwssWnZEwq2wB0DC8JOGt8IbwUFNPF
 Ss96l18gF3zErbKw6VPnqR24THf4lqD4XPPFvM01+hENoxoaCuSLpFCss31idK7TYFn8k2CzfJV
 P5k4IE1K1gAnMCSGflg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8dd91d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=8d6mbopdc3591D8QASsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE1MyBTYWx0ZWRfX/oIXvRk8lesZ
 I8tf80gAKIXQgIqmMPP5bsHV3Sb8GJTZ4qiSovig7mpgOOq/wffvuQ6DRWz7WLIOWW8Y2QWei1y
 08u+2k2QVWMUwaIT4MS3SdkCQepDQCY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250153
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 8/25/26 12:44 PM, Zhuoying Cai wrote:
> On 8/25/26 6:29 AM, Eric Farman wrote:
>>
>> On 8/24/26 1:53 PM, Zhuoying Cai wrote:
>>> On 8/11/26 10:46 AM, jrossi@linux.ibm.com wrote:
>>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>>
>>>> The IplBlockPci struct is 336 bytes in length.
>>>>
>>> The commit message is slightly misleading because IplBlockPci itself is
>>> 312 bytes in length.
>>>
>>> Maybe reword it to something like:
>>> "IplBlockPci is 312 bytes, so the minimum PCI IPLB length is 336 bytes."
>>>
>> Given that, should the #define be sizeof(IplBlockPci) + 24?
>>
> If IplBlockPci is likely to expand in the future, it might make sense to
> derive this value from the structure layout. For example,
> offsetof(IplParameterBlock, pci) + sizeof(IplBlockPci) could be more
> accurate. Otherwise, keeping it as a constant like the other definitions
> seems reasonable as well.

All of those suggestions would be valid, but I'm leaning toward keeping it
defined without using sizeof() for the sake of consistency if nothing
else.  The other IPLB types are already defined as fixed numbers and for
the IplBlockQemuScsi being used later in this patch series, it actually has
a minimum value that is less than the sizeof() itself due to the same struct
servicing both PCI and CCW controllers, where the minimum size for CCW is
less than PCI.

I can envision several ways to improve the definitions and/or naming
conventions, but I think it is outside the scope of this series because the
changes should be uniformly applied to all definitions, not just PCI.
Possibly something to consider in the future.

As far as the commit message, I will update it to state more specifically
that the minimum size of the IPLB used for PCI devices is 336 (referring
to the IplBlockPci struct directly was not accurate).

>> And does the patch itself need to be cc'd to stable?

I think it could be a candidate, but I don't believe it really needs to be
applied to stable.  There is no exploitable bug with the incorrect length
definition as it is; I only noticed it because I was checking the field
offsets against the other IPLBs. The length is still within the designated
IPLB boundaries.  I'll cc stable in the next version and they can pick it
up if they feel it warrants the change, but it has no impact in practice.

>>
>>> Otherwise:
>>> Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>
>>>
>>>> Fix the S390_IPLB_MIN_PCI_LEN to reflect this, and assign a valid blk0_len
>>>> while we are at it.
>>>>
>>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>>> ---
>>>>    hw/s390x/ipl.c | 2 ++
>>>>    hw/s390x/ipl.h | 2 +-
>>>>    2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>>> index d5fdc3ea0f..fd6e9100f9 100644
>>>> --- a/hw/s390x/ipl.c
>>>> +++ b/hw/s390x/ipl.c
>>>> @@ -526,6 +526,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>>>>            switch (devtype) {
>>>>            case PCI_DEVTYPE_VIRTIO:
>>>>                iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
>>>> +            iplb->blk0_len =
>>>> +                cpu_to_be32(S390_IPLB_MIN_PCI_LEN - S390_IPLB_HEADER_LEN);
>>>>                iplb->pbt = S390_IPL_TYPE_PCI;
>>>>                iplb->pci.fid = cpu_to_be32(pbdev->fid);
>>>>                break;
>>>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>>>> index fac30763df..b4d93054a7 100644
>>>> --- a/hw/s390x/ipl.h
>>>> +++ b/hw/s390x/ipl.h
>>>> @@ -107,7 +107,7 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
>>>>    #define S390_IPLB_MIN_PV_LEN 148
>>>>    #define S390_IPLB_MIN_CCW_LEN 200
>>>>    #define S390_IPLB_MIN_FCP_LEN 384
>>>> -#define S390_IPLB_MIN_PCI_LEN 376
>>>> +#define S390_IPLB_MIN_PCI_LEN 336
>>>>    #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
>>>>    
>>>>    static inline bool iplb_valid_len(IplParameterBlock *iplb)


