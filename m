Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1ABC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTpk-0005dH-03; Mon, 10 Feb 2025 08:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1thTpg-0005ca-Tn
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:28:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1thTpd-0005KK-Q3
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739194092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsaSs5aQGFwRDRKVp1F+uns1oYEvP8HocKPOsB+0Mwk=;
 b=Nq8W8/AOL1N0EdwHwHLwmmmfrOMqjydSPahTH5IOw13RtwG0JDqDabLEhWqc+vKJ3pZ7jy
 ZYvzBYXq7h0J5unzS6ob1yYO1Tc1DMBbaZgKC9vb4LUSz6Br+Rutpl2d5Xbe21v+7KR9I/
 FL7MMSLkg/AES3vbmaR7aOg1+fqUupM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-ZREEPKA1NoipJ2guHeg5rQ-1; Mon, 10 Feb 2025 08:27:03 -0500
X-MC-Unique: ZREEPKA1NoipJ2guHeg5rQ-1
X-Mimecast-MFC-AGG-ID: ZREEPKA1NoipJ2guHeg5rQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38ddcb63ed1so690612f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739194022; x=1739798822;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fsaSs5aQGFwRDRKVp1F+uns1oYEvP8HocKPOsB+0Mwk=;
 b=L7+oi57lz15kCCF9P4vO/DbBF0EWa/BhmKhb3lva22BEDMSU8fk0I/EzuoqEmL5A7v
 bQns7WfXD0SufQYT8VO7DSexdXYhJxEAAtKOF4ud3iecQ1ntjp2L0lbOahB1UGGvXj/K
 79KGuTrjx9Cq15gDVzroUQgzIG5F7NW4rNtKyFkrNTARmmMADEX5jtj/oAVzouAvZ0Fs
 IZBeWca9qZayjxBrhIGxai3MTYiXoGxuuDSjpbeAMlvaEbL+6qGN5qHILnfm6q33bSBY
 BZlgAxa9Xrpn2SYAv6XGT71Nupf+741/voLeV3+lf19jl0UdxN3FH9Z63D3e+vP9KQB8
 Utug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqiaizTexSda1vzuGcAlg87Y4kvLcx0RZEYbZFO490urT8XLLDTQVuLPysEu/4gJ/EyKpqt2pmcddD@nongnu.org
X-Gm-Message-State: AOJu0Yxrx04plehsPkL5RlNAxYzWWx4hPrEIbrL8fLJ+sE81WFX7IT7q
 z2K2U6epSO/y2qwPeUgbZ8gsMkuQ4gyd5kyRTYUq7vXAAjvdMxI/AjBvXb2QgbQVCkU4pENEP/b
 w8gAPHZy0/EK+tt8YNnT4S80kkoLMLQGtNVMKwXiLNMtHPQge2qVV
X-Gm-Gg: ASbGncstChUeXpdUvQVx6Xqv2AGrEgEoeQJQcETIYzsWzCnNoUdwbtU/bT/QpC3aqkb
 /LNsWUjz+BhfvrgZ/kugJwJbkoYqn5q8YNvlEmmHe1BseBrE0WSlA/4ZrvcUX7CduUg5tlJEa6e
 Qo9z+W9mBY82mle0X8rssSt7rXb5xs8rp/tenmXygSfg1C2nIm77RAftx89KsU6zpKhw+aIRMC0
 AyeIdYtEn5MfOKwHw2uvAeIVdBUHp7dL0T/XK29tjXBjqsOLMhoACvJvfAWIr9XpjJ7soJodamo
 Pq437mvjKgov0wF+PZ5Hyufa58zCxVGs2zNJvEZkPK9/6kT5qQ==
X-Received: by 2002:a5d:6d03:0:b0:38d:d664:67d8 with SMTP id
 ffacd0b85a97d-38dd6646bddmr4790818f8f.11.1739194022088; 
 Mon, 10 Feb 2025 05:27:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7d2jz+bKv55hyAajCCbZ3Df5RraOtQ1X0Lz8Ken0G3pTjkA3EFMHqN8i7VoQKUiewppkg/w==
X-Received: by 2002:a5d:6d03:0:b0:38d:d664:67d8 with SMTP id
 ffacd0b85a97d-38dd6646bddmr4790733f8f.11.1739194020212; 
 Mon, 10 Feb 2025 05:27:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391da965b3sm150674715e9.5.2025.02.10.05.26.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 05:26:59 -0800 (PST)
Message-ID: <61b05250-dc77-4aa9-bb0f-8394edec203b@redhat.com>
Date: Mon, 10 Feb 2025 14:26:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] s390x/pci: add support for guests that request
 direct mapping
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, qemu-devel@nongnu.org
References: <20250207205613.474092-1-mjrosato@linux.ibm.com>
 <20250207205613.474092-2-mjrosato@linux.ibm.com>
 <13cd0bc678f489ff26911362570efe1aca97a642.camel@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <13cd0bc678f489ff26911362570efe1aca97a642.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/10/25 14:12, Niklas Schnelle wrote:
> On Fri, 2025-02-07 at 15:56 -0500, Matthew Rosato wrote:
>> When receiving a guest mpcifc(4) or mpcifc(6) instruction without the T
>> bit set, treat this as a request to perform direct mapping instead of
>> address translation.  In order to facilitate this, pin the entirety of
>> guest memory into the host iommu.
>>
>> Pinning for the direct mapping case is handled via vfio and its memory
>> listener.  Additionally, ram discard settings are inherited from vfio:
>> coordinated discards (e.g. virtio-mem) are allowed while uncoordinated
>> discards (e.g. virtio-balloon) are disabled.
>>
>> Subsequent guest DMA operations are all expected to be of the format
>> guest_phys+sdma, allowing them to be used as lookup into the host
>> iommu table.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c         | 38 +++++++++++++++++++++++++++++++--
>>   hw/s390x/s390-pci-inst.c        | 13 +++++++++--
>>   hw/s390x/s390-pci-vfio.c        | 23 ++++++++++++++++----
>>   hw/s390x/s390-virtio-ccw.c      |  5 +++++
>>   include/hw/s390x/s390-pci-bus.h |  4 ++++
>>   5 files changed, 75 insertions(+), 8 deletions(-)
>>
>>
> ---8<---
>>   
>>   static const VMStateDescription s390_pci_device_vmstate = {
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index e386d75d58..8cdeb6cb7f 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -16,6 +16,7 @@
>>   #include "exec/memory.h"
>>   #include "qemu/error-report.h"
>>   #include "system/hw_accel.h"
>> +#include "hw/boards.h"
>>   #include "hw/pci/pci_device.h"
>>   #include "hw/s390x/s390-pci-inst.h"
>>   #include "hw/s390x/s390-pci-bus.h"
>> @@ -1008,17 +1009,25 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>>       }
>>   
>>       /* currently we only support designation type 1 with translation */
>> -    if (!(dt == ZPCI_IOTA_RTTO && t)) {
>> +    if (t && dt != ZPCI_IOTA_RTTO) {
>>           error_report("unsupported ioat dt %d t %d", dt, t);
>>           s390_program_interrupt(env, PGM_OPERAND, ra);
>>           return -EINVAL;
>> +    } else if (!t && !pbdev->rtr_avail) {
>> +        error_report("relaxed translation not allowed");
>> +        s390_program_interrupt(env, PGM_OPERAND, ra);
>> +        return -EINVAL;
>>       }
>>   
>>       iommu->pba = pba;
>>       iommu->pal = pal;
>>       iommu->g_iota = g_iota;
>>   
>> -    s390_pci_iommu_enable(iommu);
>> +    if (t) {
>> +        s390_pci_iommu_enable(iommu);
>> +    } else {
>> +        s390_pci_iommu_direct_map_enable(iommu);
>> +    }
>>   
>>       return 0;
>>   }
>> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
>> index 7dbbc76823..443e222912 100644
>> --- a/hw/s390x/s390-pci-vfio.c
>> +++ b/hw/s390x/s390-pci-vfio.c
>> @@ -131,13 +131,28 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>>       /* Store function type separately for type-specific behavior */
>>       pbdev->pft = cap->pft;
>>   
>> +    /*
>> +     * If the device is a passthrough ISM device, disallow relaxed
>> +     * translation.
>> +     */
>> +    if (pbdev->pft == ZPCI_PFT_ISM) {
>> +        pbdev->rtr_avail = false;
>> +    }
> 
> Just a note for external readers. The ISM device does work without the
> above but having explicit guest IOMMU mappings plus the respective
> shadow mappings in the host would catch driver misbehavior more easily.
> At the same time ISM uses long lived IOMMU mappings so the cost of
> shadowing its mappings is low.
> 
>> +
>>       /*
>>        * If appropriate, reduce the size of the supported DMA aperture reported
>> -     * to the guest based upon the vfio DMA limit.
>> +     * to the guest based upon the vfio DMA limit.  This is applicable for
>> +     * devices that are guaranteed to not use relaxed translation.  If the
>> +     * device is capable of relaxed translation then we must advertise the
>> +     * full aperture.  In this case, if translation is used then we will
>> +     * rely on the vfio DMA limit counting and use RPCIT CC1 / status 16
>> +     * to request that the guest free DMA mappings as necessary.
>>        */
>> -    vfio_size = pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
>> -    if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
>> -        pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
>> +    if (!pbdev->rtr_avail) {
>> +        vfio_size = pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
>> +        if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
>> +            pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
>> +        }
>>       }
>>   }
>>   
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index d9e683c5b4..6a6cb39808 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -937,8 +937,13 @@ static void ccw_machine_9_2_instance_options(MachineState *machine)
>>   
>>   static void ccw_machine_9_2_class_options(MachineClass *mc)
>>   {
>> +    static GlobalProperty compat[] = {
>> +        { TYPE_S390_PCI_DEVICE, "relaxed-translation", "off", },
>> +    };
>> +
>>       ccw_machine_10_0_class_options(mc);
>>       compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len);
>> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>>   }
>>   DEFINE_CCW_MACHINE(9, 2);
>>   
>> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
>> index 2c43ea123f..ea9e04ec49 100644
>> --- a/include/hw/s390x/s390-pci-bus.h
>> +++ b/include/hw/s390x/s390-pci-bus.h
>> @@ -277,7 +277,9 @@ struct S390PCIIOMMU {
>>       AddressSpace as;
>>       MemoryRegion mr;
>>       IOMMUMemoryRegion iommu_mr;
>> +    MemoryRegion dm_mr;
>>       bool enabled;
>> +    bool direct_map;
>>       uint64_t g_iota;
>>       uint64_t pba;
>>       uint64_t pal;
>> @@ -362,6 +364,7 @@ struct S390PCIBusDevice {
>>       bool interp;
>>       bool forwarding_assist;
>>       bool aif;
>> +    bool rtr_avail;
>>       QTAILQ_ENTRY(S390PCIBusDevice) link;
>>   };
>>   
>> @@ -389,6 +392,7 @@ int pci_chsc_sei_nt2_have_event(void);
>>   void s390_pci_sclp_configure(SCCB *sccb);
>>   void s390_pci_sclp_deconfigure(SCCB *sccb);
>>   void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
>> +void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu);
>>   void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
>>   void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
>>                                      uint64_t faddr, uint32_t e);
> 
> I'm not too familiar with the existing code or QEMU in general, but the
> changes makes sense to me. I'm assuming the braces around single
> statement bodies are accepted style in QEMU?

They are required :

   https://qemu.readthedocs.io/en/v9.2.0/devel/style.html#block-structure


> 
> I retested this version together with the v4 of the kernel version too.
> So feel free to add:
> 
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 


Thanks,

C.



