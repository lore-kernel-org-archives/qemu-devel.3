Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEA6E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 23:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKn5i-0004lF-IG; Mon, 09 Dec 2024 18:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tKn5g-0004kJ-3p; Mon, 09 Dec 2024 18:23:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tKn5e-00063s-6y; Mon, 09 Dec 2024 18:22:59 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9KjJu0009922;
 Mon, 9 Dec 2024 23:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1suOYB
 Vlga9H1+CpyQ5FDH1Lt9aSKgjmhoqlwt0Ylx0=; b=DNaBJjOUG0RJ5hNX6Cto8C
 QaHEz3mBV3bXbvQjwMBnPF7R3dW9D7X3N01VJZqOdyD/42xyrnGWVNnXrbYA9dok
 G3RDfSOywD6L3jo+zQcEQihRs0pI1TlRrrv+q/ejE1vilc/qE7vqxyvLfyUfK6YL
 8lccWqNInOLZjS1bNkZgi7zl/nNrZZ+93QqvM96Z4Ufa+atYMPg7rUgmcYSa/63J
 XXL9pC3VfcM+FVQRPjaZ6loezxMfNIL/fF78d62acxKPU8bPY9eeR0VoC7FMnODO
 fGK7a2zLEQw++Y5b8NRTS7E4XwRczprkDuKycLRMv869fsao5eFAJeptpMqyU/ZA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xb0d1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 23:22:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9LdaJt032727;
 Mon, 9 Dec 2024 23:22:54 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps92qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 23:22:54 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B9NMrDW11403998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Dec 2024 23:22:53 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7597E58055;
 Mon,  9 Dec 2024 23:22:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D6E45804B;
 Mon,  9 Dec 2024 23:22:52 +0000 (GMT)
Received: from [9.61.107.222] (unknown [9.61.107.222])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Dec 2024 23:22:52 +0000 (GMT)
Message-ID: <a6bfbf15-cbe4-4023-9a8e-d172cf8c8128@linux.ibm.com>
Date: Mon, 9 Dec 2024 18:22:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390x/pci: add support for guests that request direct
 mapping
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
 <20241209192927.107503-2-mjrosato@linux.ibm.com>
 <f7451934-bf20-4c50-8780-4d5ebf932096@redhat.com>
 <31b6b62b-4656-4ca0-a8ac-99fe4293de45@linux.ibm.com>
 <7bd2018a-df16-4ede-b7d7-dfdb9cbfc7c0@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <7bd2018a-df16-4ede-b7d7-dfdb9cbfc7c0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1LLktGsdvPUBcZVJjdSo45fE8swgXzW9
X-Proofpoint-ORIG-GUID: 1LLktGsdvPUBcZVJjdSo45fE8swgXzW9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090175
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/9/24 5:09 PM, David Hildenbrand wrote:
> On 09.12.24 22:45, Matthew Rosato wrote:
>> On 12/9/24 4:01 PM, David Hildenbrand wrote:
>>> On 09.12.24 20:29, Matthew Rosato wrote:
>>>
>>> Hi,
>>>
>>> Trying to wrap my head around that ... you mention that "pin the entirety of guest memory".
>>>
>>> Do you mean that we will actually end up longterm pinning all guest RAM in the kernel, similar to what vfio ends up doing?
>>
>> Yes.  Actually, the usecase here is specifically PCI passthrough via vfio-pci on s390.  Unlike other platforms, the default s390 approach only pins on-demand and doesn't longterm pin all guest RAM, which is nice from a memory footprint perspective but pays a price via all those guest-2 RPCIT instructions.  The goal here is now provide the optional alternative to longterm pin like other platforms.
> 
> Okay, thanks for confirming. One more question: who will trigger this longterm-pinning? Is it vfio?
> 
> (the code flow from your code to the pinning code would be nice)
> 

Yes, the vfio IOMMU code triggers it.  My s390_pci_setup_stage2_map added by this patch calls memory_region_notify_iommu in a loop such that we trigger iommu notifications to map iova X+pba -> GPA X for all GPA, where pba = a "base address" offset that has to be applied when mapping on s390. The notifications are sent in the largest batches possible to minimize vfio ioctls / use the least number of vfio dma mappings.

The iommu notifications get picked up in vfio_iommu_map_notify where we will follow the container DMA path down to vfio_legacy_dma_map; then ultimately vfio is handling the pinning via the VFIO_IOMMU_MAP_DMA ioctl.

>>
>>>
>>> In that case, it would be incompatible with virtio-balloon (and without modifications with upcoming virtio-mem). Is there already a mechanism in place to handle that -- a call  to ram_block_discard_disable() -- or even a way to support coordinated discarding of RAM (e.g., virtio-mem + vfio)?
>>
>> Good point, should be calling add ram_block_discard_disable(true) when set register + a corresponding (false) during deregister...  Will add for v2.
>>
>> As for supporting coordinated discard, I was hoping to subsequently look at virtio-mem for this.
> 
> As long as discarding is blocked for now, we're good. To support it, the RAMDiscardManager would have to be wired up, similar to vfio.
> 
> I think the current way of handling it via
> vf
> +    IOMMUTLBEvent event = {
> +        .type = IOMMU_NOTIFIER_MAP,
> +        .entry = {
> +            .target_as = &address_space_memory,
> +            .translated_addr = 0,
> +            .perm = IOMMU_RW,
> +        },
> +    };
> 
> 
> Is probably not ideal: it cannot cope with memory holes (which virtio-mem would create).
> 
> Likely, you'd instead want an address space notifier, and really only map the memory region sections you get notified about.
> 
> There, you can test for RAMDiscardManager and handle it like vfio does.
> 

I'll start looking into this; for the moment I'll plan on blocking discarding in this series with a follow-on to then enable virtio-mem, but if I get something working sooner I'll add it to this series.  Either way I'll put you on CC.


