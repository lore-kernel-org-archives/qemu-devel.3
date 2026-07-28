Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D04C54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wopMw-0001kk-0I; Tue, 28 Jul 2026 17:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wopMu-0001kV-BK; Tue, 28 Jul 2026 17:29:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wopMr-0007mg-QQ; Tue, 28 Jul 2026 17:29:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SLHcFL2348054; Tue, 28 Jul 2026 21:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9NK/va
 exq+erXBvRttGd48viIAzb0tkHkeCQIXcFaRg=; b=GzLqSa/Risqm4tvc6nD2qx
 UZbMu5SSeDde9Jsq4NPRYtHCQMA7gVbmUxULu1CBdA2OGiz+D7LR/ucAY+tt1CFR
 ute1wtmFMfcbK4vMwFHn2dYGnzSEtV+F0hworSXULcRS5kYS29knk9LbEKjAigfE
 hpHWnRociQKDFT8Y7uUY/mhmkP3Dz+3j6zxgf02wtmJSNz05+8Q9F4SdssV40sDK
 vRArted13lW5GTJNfNK+8xYRClEPuQ5qkHfFKbY053yRE8Ff4t7BeIV8jfgAf/kO
 uUimavLpszMTZ2spXfVyTiLNjAagAku3cf7TpHxN03dSmRZagyB38GkqF3d/EggA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xqpu0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 21:29:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SLQGke029634;
 Tue, 28 Jul 2026 21:29:34 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk40a1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 21:29:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66SLTX9t19923630
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 21:29:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DCEB5805C;
 Tue, 28 Jul 2026 21:29:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02A9C58058;
 Tue, 28 Jul 2026 21:29:32 +0000 (GMT)
Received: from [9.61.245.202] (unknown [9.61.245.202])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jul 2026 21:29:31 +0000 (GMT)
Message-ID: <cd95e362-56b6-4e1f-ae8b-287db5fbb41d@linux.ibm.com>
Date: Tue, 28 Jul 2026 14:29:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260724030919.123733-1-kshk@linux.ibm.com>
 <20260724030919.123733-15-kshk@linux.ibm.com>
 <6390365c-018e-4ac9-96fd-7dba63736a2c@linux.ibm.com>
 <403c57ad-107a-4d59-ad4a-874d2c3a5f2d@linux.ibm.com>
 <992b35d7-5a7d-4f16-9409-1b2d3e2c2416@linux.ibm.com>
 <bd784407-06a3-47fc-8c13-4e3d70e856b5@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <bd784407-06a3-47fc-8c13-4e3d70e856b5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: um_3Pv9E162kpBiA7hDESM8y2SDLhycp
X-Proofpoint-ORIG-GUID: um_3Pv9E162kpBiA7hDESM8y2SDLhycp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE4MiBTYWx0ZWRfX4PWFjUJUBzK6
 OQgrHvKfRom7IO7SpZO+MznpXzOV88Q85qoJnVaFO2hpD6UpupsbIP7VhMO3N6e0Lgojm938KQV
 GF6cvh56JgMLuU4FWMqt4TLYiAinE7I=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a691f40 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=P-IC7800AAAA:8
 a=aKR-dzmuSlh7gA9EQgYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE4MiBTYWx0ZWRfX+tAuyolWY+c/
 FfX1U8UWCPSYxO0SxyP8IryrkBtPivOxVT74K2681XSskl64M7ZCJhJ8Ct+Dj7AnJ3OazT5URCS
 /Mc9sMsE06j6sB7U035DsSdW9zTYqjI7BWvc/EFS3VvnkzduuhNCXJ2XfaaC1H41pZ5KPdP9VMa
 6CRHGK4Q0j4Xi5E6k0h6FWQJkRmrV92mQSi20ryvrNCsI/BPYj5MP+LlByleOri3xl7/wjVZ1J9
 a+uIVw+UrOU3eNyP94KSCiE0QJEHUP3hXvkEMDuDPrkCOKfNTiLya/vnCMVIz/UCkx3Li8IokRo
 IxHhUVVzoD5Wa+e8xlvbqFwOhllDCKQTDuZDPwQSJR4+ssNkiuR8E4xxsZf17Mar89CW5q0HmZc
 QEnSqSdrjxlm+LsvSfwQ0e2tTWSr2ABFbRG9+emQFW3qEOuGKeu66AipudoJFwD/MFnjyihQ1/2
 Ky6E2rxnhUc1ewGGm3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280182
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
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


On 7/28/2026 1:59 PM, Konstantin Shkolnyy wrote:
> On 260728 12:46, Farhan Ali wrote:
>>
>> On 7/27/2026 4:23 PM, Konstantin Shkolnyy wrote:
>>>>> +static int s390_pci_device_pre_load(void *opaque)
>>>>> +{
>>>>> +    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(opaque);
>>>>> +    S390PCIBusDevice *found_pbdev;
>>>>> +
>>>>> +    /*
>>>>> +     * Make sure pbdev is removed from the table before state 
>>>>> load. The change
>>>>> +     * of pbdev->idx means it needs to be moved to a different 
>>>>> position anyway,
>>>>> +     * and is illegal while in the table. But be careful to not 
>>>>> remove
>>>>> +     * instead another pbdev whose state might have been loaded 
>>>>> earlier and
>>>>
>>>> I think "instead" is not needed in the statement above.
>>>>
>>>> Maybe I am missing something, but could you help me understand why 
>>>> do we need to remove the pbdev if we found at a particular idx? If 
>>>> there is a collision with idx, ie on destination we have a 
>>>> different device with the same idx, are we removing a valid device?
>>>
>>> I see that this is not the best comment. How about this variant:
>>>
>>>     * State loading can change pbdev->idx. Therefore, make sure 
>>> pbdev is removed
>>>     * from the table before that happens. The table type used stores 
>>> a pointer
>>>     * to pbdev->idx and becomes corrupt if idx is changed from 
>>> outside. But be
>>>     * careful to not remove instead another pbdev whose state might 
>>> have been
>>>     * loaded earlier and that got assigned this idx value and had 
>>> therefore
>>>     * already replaced our pbdev in the table. post_load() will 
>>> reinsert our
>>>     * pbdev into the table.
>>>
>> So pbdev->idx is autogenerated when we create the device at 
>> destination, since we are migrating the idx from source this could 
>> change on destination and corrupt the hash table?
>
> Exactly.
>
>  Then do we need to migrate the idx?
>>
>
> idx is part of "function handle". So, it should remain unchanged after 
> migration.
>
>>
>>>>
>>>>> +     * that has then replaced our pbdev. (post_load() will put 
>>>>> our pbdev back.)
>>>>> +     */
>>>>> +    found_pbdev = g_hash_table_lookup(s390_get_phb()->zpci_table, 
>>>>> &pbdev->idx);
>>>>> +    assert(found_pbdev); 
>> AFAIU the pbdev->idx at pre_load() would be what we assign 
>> automatically at the destination. In that case wouldn't this assert 
>> always be true?
>
> Yes. This assert documents that a pbdev is always expected to be found 
> for this "autogenerated when we create the device at destination" 
> pbdev->idx - either the pbdev we are currently processing, or another 
> pbdev that was "loaded" earlier with the same idx value (which came 
> from the source) and inserted by post_load() into zpci_table.
>>
>>
>>>>> +    if (found_pbdev == pbdev) {
>>
>> similarly this should also be true?
>
> No always true, as described above.
>
Okay this makes a lot more sense to me now, thanks for the explanation!


>>
>>
>>>>> + g_hash_table_remove(s390_get_phb()->zpci_table, &pbdev->idx);
>>
>> Don't we have to free this idx now? so reverse of s390_pci_alloc_idx()?
>
> AFA I can see, simply removing pbdev->idx from zpci_table already 
> "frees" the idx value for reuse. s390_pci_alloc_idx() interprets 
> s->next_idx as the "next mostly likely free" idx value. It then checks 
> if zpci_table has this idx; if it does, it checks idx+1, etc. until it 
> doesn't.
>
> It seems, we could add "s->next_idx = pbdev->idx;" here to make it 
> pick this idx next time instead of larger values, but it's not 
> strictly necessary. Do you think we should do it? 

We seem to be doing it in s390_pci_interp_plug() [1] so maybe we should 
just to close this gap? In reality though this "leak" is not a concern 
for resource exhaustion.

[1] 
https://elixir.bootlin.com/qemu/v11.1.0-rc1/source/hw/s390x/s390-pci-bus.c#L1072

Thanks

Farhan

>
>>
>>
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int s390_pci_device_post_load(void *opaque, int version_id)
>>>>> +{
>>>>> +    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(opaque);
>>>>> +
>>>>>       /*
>>>>> -     * TODO: add state handling here, so migration works at least 
>>>>> with
>>>>> -     * emulated pci devices on s390x
>>>>> +     * Now that pbdev->idx has been loaded, use it to place pbdev 
>>>>> back into
>>>>> +     * the table. This may replace a different 
>>>>> not-yet-state-loaded pbdev,
>>>>> +     * but pre_load() handles this case.
>>>>>        */
>>>>> -    .unmigratable = 1,
>>>>> +    g_hash_table_replace(s390_get_phb()->zpci_table, &pbdev->idx, 
>>>>> pbdev);
>>>>> +
>>>>> +    /*
>>>>> +     * Regenerate IOMMU state, including IOTLB contents and QEMU 
>>>>> memory regions.
>>>>> +     */
>>>>> +    if (pbdev->iommu_enabled) {
>>>>> +        assert(pbdev->iommu);
>>>>> +        if (s390_pci_is_translation_enabled(pbdev->g_iota)) {
>>>>> +            s390_pci_iommu_enable(pbdev);
>>>>> +            s390_pci_ioat_replay(pbdev);
>>>>> +        } else {
>>>>> +            s390_pci_iommu_direct_map_enable(pbdev);
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * Guest sets fmb_addr by mpcifc.ZPCI_MOD_FC_SET_MEASURE 
>>>>> instruction,
>>>>> +     * whose handler consequently starts fmb_timer. We may need 
>>>>> to restart it.
>>>>> +     */
>>>>> +    if (pbdev->fmb_addr) {
>>>>> +        assert(!pbdev->fmb_timer);
>>>>> +        assert(pbdev->pci_group);
>>>>> +        pbdev->fmb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
>>>>> +                                        fmb_update, pbdev);
>>>>> +        timer_mod(pbdev->fmb_timer,
>>>>> +                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
>>>>> + pbdev->pci_group->zpci_group.mui);
>>>>> +    }
>>>>> +    return 0;
>>>>> +} 
>

