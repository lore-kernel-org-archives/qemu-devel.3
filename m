Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAB2C53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6pT-0008VK-Sa; Wed, 29 Jul 2026 12:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wp6pQ-0008Ui-M8; Wed, 29 Jul 2026 12:08:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wp6pN-0006UB-8w; Wed, 29 Jul 2026 12:08:19 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TFHa7i2684342; Wed, 29 Jul 2026 16:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=F21nKn
 DfFS9bUSa3pz1dAtHPz9MlYaG7PMOT5OWcmQ8=; b=VLoPrbf79e5QiSoS5Gqnti
 Zj2gQboM50SIfGVoE5BFtJyUWzLdYh8qgbL/xYhPhi6tts7p1AApv5JuflHrz82H
 XDMuW2eAQ9+lCOxS9Fhi7YkMKGntyzXZ4qj6/38YzthLgrNK3EQyDhVbafpXUlBo
 M4k3TfL2OcW4iU9MZ+bICZRj/p4gR9I2Ya1N1Xs1GQE7mBN5FqUwPtBf24zMGjaj
 6096fc/E8LOKd9X4oPgDme9/6ZvOBydwHbm/Ny528OEG1xllmtySKZKsmprwZvMX
 lkeHRwSwMxr0IiLKuq2wCBYSNCpBcNv8EmFH3htrNkpJWIZn3IskGdNyLmbWufbw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyckgjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 16:08:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFuIbj020472;
 Wed, 29 Jul 2026 16:08:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk7e1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 16:08:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66TG893E30278368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jul 2026 16:08:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 795675805A;
 Wed, 29 Jul 2026 16:08:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4483B58051;
 Wed, 29 Jul 2026 16:08:09 +0000 (GMT)
Received: from [9.61.244.82] (unknown [9.61.244.82])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jul 2026 16:08:09 +0000 (GMT)
Message-ID: <bc7d585c-b122-4759-b137-6d05e02d1485@linux.ibm.com>
Date: Wed, 29 Jul 2026 11:08:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] s390x/pci: Implement migration for emulated
 devices
Content-Language: en-US
To: Farhan Ali <alifm@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260724030919.123733-1-kshk@linux.ibm.com>
 <20260724030919.123733-15-kshk@linux.ibm.com>
 <6390365c-018e-4ac9-96fd-7dba63736a2c@linux.ibm.com>
 <403c57ad-107a-4d59-ad4a-874d2c3a5f2d@linux.ibm.com>
 <992b35d7-5a7d-4f16-9409-1b2d3e2c2416@linux.ibm.com>
 <bd784407-06a3-47fc-8c13-4e3d70e856b5@linux.ibm.com>
 <cd95e362-56b6-4e1f-ae8b-287db5fbb41d@linux.ibm.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <cd95e362-56b6-4e1f-ae8b-287db5fbb41d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6aCa6qWn7L5MRzk32iTXxnzJNUv4nUO-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfX0IIvsVQsYldu
 FGc9PESjxUKepDBDk5O6G4dla3A02XzTpGJdnB7rD9Jxv3BJXK3hDGnoD3W1m5JzLzgeVMIO2tj
 j78R65QrTZ4XGPphWfw855/6j6C0WAmMr1x94DhpFFyTGsOvwXt8pvrnyOY7569u3jjdK5YE+7R
 Fn7K3UlIqoyAY/Gr5s+sB47uU+KcORqduPkgf6tv8j7vDg16UtWVR1T2CGmtNfvenWLq1znDikR
 s4UiRUm0VUOtqyOuliaYNyAvQcSn5M0w1YIeIuogx3WfZDLZinPsRMte3pg6gvM1qGOXpJN0td0
 KiyE73ncH9oppAw9xJjsT/lecd+XBImt7sppNKTz8WCguUdBJ8vgjaKQRzS3fj86MxMgtjc+rNA
 4vyqcW9iU2rc6xpk5zKEFjOzy3LYbKpqo+vBoi2Ns7QosdGF1sXwHmegErwLUFgdn+92M5omNcg
 HiBKdm2iThA9OFJRqCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfX6drIVz4r6r09
 LNY1oIFvtJmxbRukWMWqw2zqOB/VeaMS1nyoSSmdW1y6QSXGJ5FaObISQFEYSTJTbqw94y4pqxp
 mZK10QUhl3x4cQGsQMyGihvoezfrf/0=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6a256b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=P-IC7800AAAA:8
 a=QFrQIMpG0r8RfQomfMcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 6aCa6qWn7L5MRzk32iTXxnzJNUv4nUO-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290126
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

On 260728 16:29, Farhan Ali wrote:
> 
> On 7/28/2026 1:59 PM, Konstantin Shkolnyy wrote:
>> On 260728 12:46, Farhan Ali wrote:
>>>
>>> On 7/27/2026 4:23 PM, Konstantin Shkolnyy wrote:
>>>>>> +static int s390_pci_device_pre_load(void *opaque)
>>>>>> +{
>>>>>> +    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(opaque);
>>>>>> +    S390PCIBusDevice *found_pbdev;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Make sure pbdev is removed from the table before state 
>>>>>> load. The change
>>>>>> +     * of pbdev->idx means it needs to be moved to a different 
>>>>>> position anyway,
>>>>>> +     * and is illegal while in the table. But be careful to not 
>>>>>> remove
>>>>>> +     * instead another pbdev whose state might have been loaded 
>>>>>> earlier and
>>>>>
>>>>> I think "instead" is not needed in the statement above.
>>>>>
>>>>> Maybe I am missing something, but could you help me understand why 
>>>>> do we need to remove the pbdev if we found at a particular idx? If 
>>>>> there is a collision with idx, ie on destination we have a 
>>>>> different device with the same idx, are we removing a valid device?
>>>>
>>>> I see that this is not the best comment. How about this variant:
>>>>
>>>>     * State loading can change pbdev->idx. Therefore, make sure 
>>>> pbdev is removed
>>>>     * from the table before that happens. The table type used stores 
>>>> a pointer
>>>>     * to pbdev->idx and becomes corrupt if idx is changed from 
>>>> outside. But be
>>>>     * careful to not remove instead another pbdev whose state might 
>>>> have been
>>>>     * loaded earlier and that got assigned this idx value and had 
>>>> therefore
>>>>     * already replaced our pbdev in the table. post_load() will 
>>>> reinsert our
>>>>     * pbdev into the table.
>>>>
>>> So pbdev->idx is autogenerated when we create the device at 
>>> destination, since we are migrating the idx from source this could 
>>> change on destination and corrupt the hash table?
>>
>> Exactly.
>>
>>  Then do we need to migrate the idx?
>>>
>>
>> idx is part of "function handle". So, it should remain unchanged after 
>> migration.
>>
>>>
>>>>>
>>>>>> +     * that has then replaced our pbdev. (post_load() will put 
>>>>>> our pbdev back.)
>>>>>> +     */
>>>>>> +    found_pbdev = g_hash_table_lookup(s390_get_phb()->zpci_table, 
>>>>>> &pbdev->idx);
>>>>>> +    assert(found_pbdev); 
>>> AFAIU the pbdev->idx at pre_load() would be what we assign 
>>> automatically at the destination. In that case wouldn't this assert 
>>> always be true?
>>
>> Yes. This assert documents that a pbdev is always expected to be found 
>> for this "autogenerated when we create the device at destination" 
>> pbdev->idx - either the pbdev we are currently processing, or another 
>> pbdev that was "loaded" earlier with the same idx value (which came 
>> from the source) and inserted by post_load() into zpci_table.
>>>
>>>
>>>>>> +    if (found_pbdev == pbdev) {
>>>
>>> similarly this should also be true?
>>
>> No always true, as described above.
>>
> Okay this makes a lot more sense to me now, thanks for the explanation!
> 
> 
>>>
>>>
>>>>>> + g_hash_table_remove(s390_get_phb()->zpci_table, &pbdev->idx);
>>>
>>> Don't we have to free this idx now? so reverse of s390_pci_alloc_idx()?
>>
>> AFA I can see, simply removing pbdev->idx from zpci_table already 
>> "frees" the idx value for reuse. s390_pci_alloc_idx() interprets s- 
>> >next_idx as the "next mostly likely free" idx value. It then checks 
>> if zpci_table has this idx; if it does, it checks idx+1, etc. until it 
>> doesn't.
>>
>> It seems, we could add "s->next_idx = pbdev->idx;" here to make it 
>> pick this idx next time instead of larger values, but it's not 
>> strictly necessary. Do you think we should do it? 
> 
> We seem to be doing it in s390_pci_interp_plug() [1] so maybe we should 
> just to close this gap? In reality though this "leak" is not a concern 
> for resource exhaustion.
> 
> [1] https://elixir.bootlin.com/qemu/v11.1.0-rc1/source/hw/s390x/s390- 
> pci-bus.c#L1072

However, s390_pcihost_unplug() doesn't change s->next_idx after calling 
g_hash_table_remove().

In practice, since we have 64K values to go through before the idx 
allocator wraps around and starts searching from 0, it seems unlikely to 
happen. (We'd have to plug PCI devices 64K times.)

The purpose of s->next_idx appears to be to help allocation to happen on 
the first try without checking zpci_table many times.

If we just keep incrementing s->next_idx and never set it back, it'll 
allocate on the first try 64K times.

If, however, we set it back after g_hash_table_remove(), the next 
allocation will be quick, but subsequent ones might have to scan 
zpci_table before finding a free value. In this implementation, the 
scanning we try to avoid might happen in practice long before we reach 
64K allocations. On top of that, we'll then reuse old "function handle" 
values - not that I know of a problem with that, but...

So, it's extra code to set s->next_idx back and I don't see how it's useful.

> 
> Thanks
> 
> Farhan
> 
>>
>>>
>>>
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int s390_pci_device_post_load(void *opaque, int version_id)
>>>>>> +{
>>>>>> +    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(opaque);
>>>>>> +
>>>>>>       /*
>>>>>> -     * TODO: add state handling here, so migration works at least 
>>>>>> with
>>>>>> -     * emulated pci devices on s390x
>>>>>> +     * Now that pbdev->idx has been loaded, use it to place pbdev 
>>>>>> back into
>>>>>> +     * the table. This may replace a different not-yet-state- 
>>>>>> loaded pbdev,
>>>>>> +     * but pre_load() handles this case.
>>>>>>        */
>>>>>> -    .unmigratable = 1,
>>>>>> +    g_hash_table_replace(s390_get_phb()->zpci_table, &pbdev->idx, 
>>>>>> pbdev);
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Regenerate IOMMU state, including IOTLB contents and QEMU 
>>>>>> memory regions.
>>>>>> +     */
>>>>>> +    if (pbdev->iommu_enabled) {
>>>>>> +        assert(pbdev->iommu);
>>>>>> +        if (s390_pci_is_translation_enabled(pbdev->g_iota)) {
>>>>>> +            s390_pci_iommu_enable(pbdev);
>>>>>> +            s390_pci_ioat_replay(pbdev);
>>>>>> +        } else {
>>>>>> +            s390_pci_iommu_direct_map_enable(pbdev);
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Guest sets fmb_addr by mpcifc.ZPCI_MOD_FC_SET_MEASURE 
>>>>>> instruction,
>>>>>> +     * whose handler consequently starts fmb_timer. We may need 
>>>>>> to restart it.
>>>>>> +     */
>>>>>> +    if (pbdev->fmb_addr) {
>>>>>> +        assert(!pbdev->fmb_timer);
>>>>>> +        assert(pbdev->pci_group);
>>>>>> +        pbdev->fmb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
>>>>>> +                                        fmb_update, pbdev);
>>>>>> +        timer_mod(pbdev->fmb_timer,
>>>>>> +                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
>>>>>> + pbdev->pci_group->zpci_group.mui);
>>>>>> +    }
>>>>>> +    return 0;
>>>>>> +} 
>>


