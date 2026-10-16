Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AE2CCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 19:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHnby-0001W2-NH; Fri, 16 Oct 2026 15:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1xHnbv-0001Te-OU
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 15:28:59 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1xHnbt-0001QX-HL
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 15:28:59 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c2e3846d1caso40296366b.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792178935; x=1792783735; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ixIt9onMN2WRQoT1uwDGZiP6wgR14STx1KgXhX0nwtk=;
 b=QgF5BTUkC240CF9qycQKjy2TkTWWGQ/upP86w6bdh9Yk8IlP1wsfH6RZ+o3VUPtfVp
 E+ptd1Mvsy+hqYZB9EHg9jDiX9df2KtE6qpqQo9V3JJ6jyKkVV7k4Wy2AwuDtm/YCAue
 OrFkEOfmi2qfv+qBAyvf4LTDcw/AqSor/p5Xz+OQx0i8/Zglsu0+1G0yYiPsoExYkJTB
 cICVLF8Rexn3x8mrTgJp9siigX4vGP04OQVVe3H0plQdX6DpkIzY5CyQuUNhIOMsbdzJ
 xXwS6dM8lZ5sG0gh2yCumGS5EX1MtqBFQGyjbG27p8GsRPnCkReZkqgQauaFY42QhppV
 hUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792178935; x=1792783735;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ixIt9onMN2WRQoT1uwDGZiP6wgR14STx1KgXhX0nwtk=;
 b=JZBOlS4ZHdRKooz3DlENcVBsqJNw26c/XY5qhtRIvMqQisg1mqtjJOaitbnK1JCL1K
 8TMVGCA7Zy39Q9MGfGktCXt+VMNCSTa3sGCZzHEXJqZoayvEOFQs7rOTocKy0xk0DFnS
 mX8zxRXcAs06PFf7MhbyCG5O8U8OERFlNeLgs6QkGQ9/2tMrJn7nBwqWeoysD4VWbIUo
 yhI1Aw5oBBJODbnKY4EsZ2DUYV3K7DQJL1pdYslgDfkCz+qSd0mXvVaEeZ6q//FTzx1m
 jHahunaQHWVSZZJf7QFIo2LTMIXP4/9uPGW8loAWE40XlByUa2DO1HAY5K7JTOTrUL28
 dtdg==
X-Forwarded-Encrypted: i=1;
 AKwUvByzPnTROoiaQ0ppCiFXH08Y0v/maab5u+29n/x7X4iklKRMySnOrQKPpmMxRFIRl8k5DrLbvJ4lNniu@nongnu.org
X-Gm-Message-State: AFq9FYIZpzt6W+KlbeKCqUlafYwf0vRdXSf3FwrDCAggJzk7iijjrxvi
 Coz55H1pO6yl2rmM/Gz74wZSbYFJzxP5XMA+gEnOwndWMJmR8Teh06r8
X-Gm-Gg: AYBFou3S5q8xfuxXE+2Nkgw38tAEEIsMD1FIYrks3GncB2S1BqC47Exu3r2AfzSzJDE
 W+zwfXs9Htlhud592Qe1XWH90HNF0BJTitzj+CYC6Fy7Za5XP8sjWhA+JvmTzXuN1JKdexEvt8O
 OYpEEtyHc88MzxqciTO2QaU0vGGrDCKwy1JoErQ1CnWjWzXb831t28aFJgfvWhqu8T4+Fj6eQnk
 sB6DZIoRr1eHfhKt0rE72lcS/5mcp/1nvsvhq5NUSIMN99Ps6WorsNx9CvrMWkLu5hRsph7RAge
 QNcsSV4lfdN5gE0ktfQYOa/G/KyHXhvHRm2LO+EM/rZdqeiowapnH3fCE5+s83KdFhN7sC++Ytm
 TDDfv/oLlHV88pVSfuA6LjHjhmtqvpZJ+3sD1mio6GyhgSfx8FpiUqi1iX7x8KsMr+quYG2Phks
 C7WSqQeSZ//zYbILi+z++tRFifbw3i02dO6Y/2mj3R+60qc8q5YEerSVYgSYmTiNkXdI5HUWGzM
 1fqF/PnMHf9m1oyxFEMRIjrAadza6xJtdDXqsmugW2gUkXisoWX
X-Received: by 2002:a17:907:c008:b0:c2d:c17f:205b with SMTP id
 a640c23a62f3a-c419fef7b50mr66085966b.40.1792178934900; 
 Fri, 16 Oct 2026 12:28:54 -0700 (PDT)
Received: from [192.168.1.130] (93-143-197-174.adsl.net.t-com.hr.
 [93.143.197.174]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c40919bde49sm96022766b.55.2026.10.16.12.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 12:28:54 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
X-Google-Original-From: Ruslan Ruslichenko <ruslichenkor@gmail.com>
Message-ID: <068f6239-9a04-4182-9e45-19fe38106184@gmail.com>
Date: Fri, 16 Oct 2026 21:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/20] system/physmem: Add ats_do_translate helper
To: =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 Ruslan Ruslichenko <ruslichenko.r@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "artem_mygaiev@epam.com" <artem_mygaiev@epam.com>,
 "volodymyr_babchuk@epam.com" <volodymyr_babchuk@epam.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "francisco.iglesias@amd.com" <francisco.iglesias@amd.com>,
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "eugene@nuvacore.ai" <eugene@nuvacore.ai>,
 "Ruslan_Ruslichenko@epam.com" <Ruslan_Ruslichenko@epam.com>,
 "takahiro.nakata.wr@renesas.com" <takahiro.nakata.wr@renesas.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
 <20260915160044.345788-13-ruslichenko.r@gmail.com>
 <07181e2fc148dce3c2152f450e9337b4b9a21f16.camel@bull.com>
 <011b142e-feae-47e0-9c67-6cc7277c5113@gmail.com>
 <d29965e800482e96e8f42c8307900f665eb61a69.camel@bull.com>
Content-Language: en-US
In-Reply-To: <d29965e800482e96e8f42c8307900f665eb61a69.camel@bull.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/15/26 11:40, Clément MATHIEU--DRIF wrote:
> 
> On Wed, 2026-10-14 at 10:21 +0200, Ruslan Ruslichenko wrote:
>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
>>
>>
>> On 10/13/26 16:27, Clément MATHIEU--DRIF wrote:
>>
>>> Do you need to operate at physmem level?
>>> We have an API for PCI device for ATS and PRI (see pci_ats_request_translation and pci_pri_unregister_notifier)
>>>
>>
>>
>> This helper is used by Remote-Port-ATS device, which is used for resolving ATS requests from remote masters via RemotePort link and it is TYPE_DEVICE itself.  
>> As it is not a PCI device itself, we cannot use PCI API unfortunately.
>>
> 
> Ok, I see,
> 
> The issue I see here is that we are basically re-implemeting what IOMMUs already do through the PCI API.  
> It looks like there is a risk here as some IOMMUs might want to update their state when being called on ATS/PRI, which won't be done here.
> 
> I'm not super familiar with RemotePort but I have a high level overview of what some companies do to bridge rtl simulators with a PCI bus in Qemu.  
> IIUC, the bus type of the simulator is known, and their bridge allocates an emulated device of the matching type in Qemu so they can call the official APIs as if there was a "real" emulated device.
> 
> In your use case, what kind of devices are you running in the external simulator? PCI I guess?
> 


The most common usage of ATS and remote-port-ats is indeed bound to PCI subsystem.
For reference, in Remote Port subsystem it is used by remote-port-pci-device and remote-port-pcie-root-port in Xilinx tree:
https://github.com/Xilinx/qemu/blob/master/hw/core/remote-port-pci-device.c
https://github.com/Xilinx/qemu/blob/master/hw/core/remote-port-pcie-root-port.c

And since there is already existing 'pci_ats_request_translation' API, I agree it is a cleaner and more correct approach.
I think, ATS device can use PCIDevice created by those models and call pci_ats_request_translation(), which removes the need for physmem-level helper.
Although, the 'ats_request_translation' is currently implemented only by the Intel IOMMU, ARM SMMU don't implement it, so this needs to be done too.

In our case we have a use case where a device on the platform bus, behind SMMU also wants to use ATS requests.
But those likely require separate approach and it belongs to SMMU for platform bus series, such as:
https://lists.nongnu.org/archive/html/qemu-devel/2025-12/msg02637.html

So will drop 'ats_do_translate' for the next revision. 

Thanks for the feedback!

--
Best Regards,
Ruslan

>>
>>> On Tue, 2026-09-15 at 18:00 +0200, Ruslan Ruslichenko wrote:
>>>
>>>> From: Ruslan Ruslichenko <[[Ruslan_Ruslichenko@epam.com](mailto:Ruslan_Ruslichenko@epam.com)](mailto:[Ruslan_Ruslichenko@epam.com](mailto:Ruslan_Ruslichenko@epam.com))>
>>>>
>>>> Add 'ats_do_translate' method to enable manual IOMMU address
>>>> translation.
>>>>
>>>> This allows the Remote Port subsystem to resolve guest virtual
>>>> addresses to physical addresses by querying the QEMU IOMMU
>>>> translation pipeline. This is required for the Remote Port
>>>> subsystem to support translation  requests from external masters
>>>> in a co-simulation environment.
>>>>
>>>> Signed-off-by: Edgar E. Iglesias <[[edgar.iglesias@amd.com](mailto:edgar.iglesias@amd.com)](mailto:[edgar.iglesias@amd.com](mailto:edgar.iglesias@amd.com))>
>>>> Signed-off-by: Takahiro Nakata <[[takahiro.nakata.wr@renesas.com](mailto:takahiro.nakata.wr@renesas.com)](mailto:[takahiro.nakata.wr@renesas.com](mailto:takahiro.nakata.wr@renesas.com))>
>>>> Signed-off-by: Ruslan Ruslichenko <[[Ruslan_Ruslichenko@epam.com](mailto:Ruslan_Ruslichenko@epam.com)](mailto:[Ruslan_Ruslichenko@epam.com](mailto:Ruslan_Ruslichenko@epam.com))>
>>>> ---
>>>>  include/system/memory.h |  8 +++++++
>>>>  system/physmem.c        | 53 +++++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 61 insertions(+)
>>>>
>>>> diff --git a/include/system/memory.h b/include/system/memory.h
>>>> index a7e03fc3e7..2032d3028d 100644
>>>> --- a/include/system/memory.h
>>>> +++ b/include/system/memory.h
>>>> @@ -2583,6 +2583,14 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
>>>>                                addr, xlat, len, is_write, attrs);
>>>>  }
>>>>
>>>> +MemoryRegion *ats_do_translate(AddressSpace *as,
>>>> +    hwaddr addr,
>>>> +    hwaddr *xlat,
>>>> +    hwaddr *plen_out,
>>>> +    AddressSpace **target_as,
>>>> +    int *prot,
>>>> +    MemTxAttrs attrs);
>>>> +
>>>>  /* address_space_access_valid: check for validity of accessing an address
>>>>   * space range
>>>>   *
>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>> index a4a6a4710c..1acda22ede 100644
>>>> --- a/system/physmem.c
>>>> +++ b/system/physmem.c
>>>> @@ -525,6 +525,59 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
>>>>      return *section;
>>>>  }
>>>>
>>>> +/* This function is called from RCU critical section */
>>>> +MemoryRegion *ats_do_translate(AddressSpace *as,
>>>> +                               hwaddr addr,
>>>> +                               hwaddr *xlat,
>>>> +                               hwaddr *plen_out,
>>>> +                               AddressSpace **target_as,
>>>> +                               int *prot,
>>>> +                               MemTxAttrs attrs)
>>>> +{
>>>> +    MemoryRegionSection *section;
>>>> +    IOMMUMemoryRegion *iommu_mr;
>>>> +    hwaddr plen = (hwaddr)(-1);
>>>> +    FlatView *fv = address_space_to_flatview(as);
>>>> +    IOMMUMemoryRegionClass *imrc;
>>>> +    IOMMUTLBEntry iotlb;
>>>> +    int iommu_idx = 0;
>>>> +
>>>> +    if (!plen_out) {
>>>> +        plen_out = &plen;
>>>> +    }
>>>> +
>>>> +    /* This can be MMIO, so setup MMIO bit. */
>>>> +    section = address_space_translate_internal(
>>>> +            flatview_to_dispatch(fv), addr, xlat,
>>>> +            plen_out, true);
>>>> +
>>>> +    /* Illegal translation */
>>>> +    if (section->mr == &io_mem_unassigned) {
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    iommu_mr = memory_region_get_iommu(section->mr);
>>>> +    if (!iommu_mr) {
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
>>>> +
>>>> +    if (imrc->attrs_to_index) {
>>>> +        iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
>>>> +    }
>>>> +
>>>> +    iotlb = imrc->translate(iommu_mr, addr, IOMMU_RO, iommu_idx);
>>>> +
>>>> +    *xlat = ((iotlb.translated_addr & ~iotlb.addr_mask)
>>>> +            | (addr & iotlb.addr_mask));
>>>> +    *plen_out = MIN(*plen_out, (addr | iotlb.addr_mask) - addr + 1);
>>>> +    *prot = iotlb.perm;
>>>> +    *target_as = iotlb.target_as;
>>>> +
>>>> +    return section->mr;
>>>> +}
>>>> +
>>>>  /* Called from RCU critical section */
>>>>  IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
>>>>                                              bool is_write, MemTxAttrs attrs)
>>>
>>


