Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706D5C982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Bqh-0002Pn-0Y; Thu, 17 Sep 2026 09:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1x7Bp7-0001tg-AA; Thu, 17 Sep 2026 09:06:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1x7Bp4-0006TD-1w; Thu, 17 Sep 2026 09:06:45 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HA1dZR2048909; Thu, 17 Sep 2026 13:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LCbbDP
 5GnGFpFZHX/u0KRkxQ3lJBD55rhlG+C7/Wur0=; b=G17isdxXvKQh2bd89Rn7W+
 dcuVguqHonK46Z6NoMJhYCwxB7gLB1TJdv1OdudJOrmmFWRipshL646hLYJJDQlY
 vhovjxraltnoVDWA8tyV20swJgICtOKMEznCbEasZfgvY2C4OdWkfcfS+H7oGMZE
 B43+2WfkBIgQs0lNNBR38AV/8wC8kktbJ/ZoF9GusOkc8RS8wDoAdrKFd7RI1IAw
 RxSubKEnHuQRsjZ/XdSuqRVbjfjEWXkR3rGM6gX+moNhgxY1F0Rxe/urR/DvHfAh
 Ph0JdLdIHRGeWQonCM0KgXYhN0vjrNDR6JXzElvqjnyw7gcSXt9UEHNNtKODJe2g
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j2aj8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 13:06:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H9aIjF2962377; Thu, 17 Sep 2026 13:06:37 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3ysj1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 13:06:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HD6aNl34800252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 13:06:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3824F58063;
 Thu, 17 Sep 2026 13:06:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76EEF58055;
 Thu, 17 Sep 2026 13:06:35 +0000 (GMT)
Received: from [9.61.247.238] (unknown [9.61.247.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 17 Sep 2026 13:06:35 +0000 (GMT)
Message-ID: <14172d34-1236-414a-9149-acca9fdd2c66@linux.ibm.com>
Date: Thu, 17 Sep 2026 09:06:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: fix DMA slot leak on I/O TLB entry
 replacement
To: Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, qemu-stable@nongnu.org
References: <20260910132408.12707-1-oelghoul@linux.ibm.com>
 <9aded4ae-512f-4b54-9421-02cb1f973ec0@linux.ibm.com>
 <139ec7b4-b467-4ef4-8832-9437f5047767@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <139ec7b4-b467-4ef4-8832-9437f5047767@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE4MyBTYWx0ZWRfX/kIppcEPXp20
 fI2YrbICH49nYXFo3wJOWjxl8Ae/t9/uVHGrIqtSSHgwLCXuoubO6Pwkp5/TZNdeZuZpnp4jG1e
 yjd+Y0RnqRREihqqCEmUT7P3eDItOLeEx3+vbe5GT3PGClP+OagvfNMUhdrdoRtZKCUmxqYvJe+
 6aZmcNfI5q+ddzEY51LmrO4MiGzsrAmSiKg3d3vWfg71o14m6ielU05XsaK128QD9MUpH6jXEPC
 Rn+MHaF3mjnbflE6uY6ExyVVE7Z6eB32h7wfDSuIo7oNe5x4dHC8H6Yjd12/YY6A4kNyoj5Vmdf
 xW0mfI+29Ds6vJSZl3tB68W3hasj9wvPqmhRjWbabhAvkzQz2p21EmVUojXkLYpBYU8OE40IHJi
 dyQ7rOF87NjWe7Cgw64ol+tuO//tTDtlbLE0G3f0ioM48ufHhzkzEcVAx6ZAhyDC/kyCqLVpvin
 Aa/lhQiNQkVAqa0LCgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE4MyBTYWx0ZWRfX+TL4P9PQ0MRe
 vL9qQe8zAFCw5UH6LNatkh57+rvnSU+xfje5mDxu1Buy0tsYzmrIlZtmgtdkzNkvVNhGjMVEed1
 lgWaXyw+OjciuMV3R8ZSKZr8mxEFQdg=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aabe5de cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=Lj1O-o6SViyWW_dxo_oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: xudiskfZf94KJh_XyvqadhTE4AMw5Jkm
X-Proofpoint-GUID: xudiskfZf94KJh_XyvqadhTE4AMw5Jkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170183
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/16/26 9:45 PM, Matthew Rosato wrote:
> On 9/14/26 5:27 PM, Farhan Ali wrote:
>>
>> On 9/10/2026 6:24 AM, Omar Elghoul wrote:
>>> When s390_pci_update_iotlb() does a mapping update for an IOVA that has
>>> an already-existing TLB entry with different permissions or translated
>>> address, it unmaps then remaps it. However, at the end of the map path,
>>> it unconditionally decrements the available DMA slot counter without a
>>> corresponding increment in the intermediate unmap branch.
>>>
>>> This causes the DMA slot count to be decremented on every remapping of
>>> an active IOVA, leading to a permanent DMA slot leak. This remapping
>>> without a prior invalidation and sync is not seen today in well-behaved
>>> guests but is allowed by the architecture. Fix it by only decrementing
>>> available DMA slots when inserting a brand new mapping.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")
>>> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
>>> ---
>>>    hw/s390x/s390-pci-inst.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>>> index b7de23c7d2..5840675aba 100644
>>> --- a/hw/s390x/s390-pci-inst.c
>>> +++ b/hw/s390x/s390-pci-inst.c
>>> @@ -665,6 +665,9 @@ static uint32_t s390_pci_update_iotlb(S390PCIIOMMU
>>> *iommu,
>>>                memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
>>>                event.type = IOMMU_NOTIFIER_MAP;
>>>                event.entry.perm = entry->perm;
>>> +        } else {
>>> +            /* only new mappings consume DMA slots */
>>> +            dec_dma_avail(iommu);
>>>            }
>> To me the else statement here makes it a little more confusing. I think
>> it would be easier to read, if we increment above when do the unmap in
>> the intermediate step. That way we associate incrementing the available
>> entries with unmap and decrementing it with map operation. But I guess
>> this avoids an additional function call for the same result.
> 
> So first, for the code itself:
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> As to the readability vs adding an intermediate increment -- maybe if
> you add another small comment it would help with readability?
> 
> Something like:
> 
> if (cache) {
>      /* valid->valid transitions re-use a DMA slot */
>      ...
> } else {
>      /* invalid->valid transitions consume a new DMA slot */
>      ...
> }

That's a great suggestion, I will post a v2 with more comments.

Thanks



