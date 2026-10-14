Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB63CC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuFM-00082w-EZ; Wed, 14 Oct 2026 04:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1xGuFK-00082F-Hv
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:21:58 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1xGuFI-00027q-BE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:21:58 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c2e3846d1caso621429166b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791966114; x=1792570914; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kv+VjdbdQL8xwxh6XECL7xWKmLM9OSB3JEyVeKt9p0M=;
 b=jWz8io0yFjuVktPXmsLnVl2TyR3Jb+y0xahu4oZambFdb5UtE9rW5A2Krmu5fFbWwV
 UXad0NdS/wpfFne1SLh6PM7Aozfwjp7SSnkdXMMMpeqGP0XrI3hrvOKDBLOzdAAATOj+
 d/de9VNv9eIWPieVQRZXLQjS99bpqYyA5l6kkbS+pF60DtmqyuvxotvXyVOwAba5o03T
 1tZHcFkJWECfDURAOovczKY3UjJtJzVhVdhivZ4K8L67GI/9FZQ1yvo/8np1I3CUuXXb
 7L78jVOX9HMprQZH5IQiF8MueKlfjpaSemtd3mRfqZB5g76PA7AILXw/FptmCPxwCcbb
 Nczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791966114; x=1792570914;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kv+VjdbdQL8xwxh6XECL7xWKmLM9OSB3JEyVeKt9p0M=;
 b=rODXXuHkA1YO6mSfLn9687WPh3bdRHN/Nb7X+enKbqEHRsWsKTDTyfed37fOA4+qEA
 XuTJB2qzC00ZVSTyCp/xVyPG0R3XPLw2loS9u5HZxQblL4OjBUZA4h9b5RMpYNVbwPQb
 FtNsLPTEz5MKe+fH9TZLbcOquo5IrdkdeER8SqaTuQ9R6esEQl/ooyuRA5aE3AO5TWLa
 lQ082ayB9Hgi2LzL/adA3JRGlBozswaHW6VncGsopBWNyFz4BNW16GpVJFCoFOYoFC4O
 f0xpFgAtKTA31LKKEvLUI4kHXTa1rq2b2EAV4NSd/WJ1arisykXTe1jQkihiCKFFKh8f
 F1sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwrhSQT7TDCJwBm+/t6Ndq/NIpk/kv8FZiDXV5t42iERcAkxPBYh4UhthkuNoUc+KmJo5GtzbVOwtC@nongnu.org
X-Gm-Message-State: AFq9FYIO8y7u8KO78it5I96vh8jplmty8tKbAZ1DvUsPThpJ56KoYt0V
 EwaFOor8xOthd36ETpHVHJbP03f79DqGOh1rFbuGgwM/IFvWneHk41p2
X-Gm-Gg: AYBFou38knUrpomRkBYq9HPmvyboKm11+9MXocR8UwnLJdifa1niR0+FAaxvq2LYHjO
 17E1Q+CZ//W+QLT9QYsCbLQccCS76SAwaZEoJMFAJ3DRTtBcODBf+u92Xx86ThslJmAVoNwaNRK
 q0izy6gWxCT+rz05QD7MI620+djtD3TWmND1/FFSDUqhrLw2bQ+sTQHfs1rpB+/5buJ3eFatlbj
 bswEo5qzvO7/hsSa9DDj46UslZ7EgHkn2fLKRzEM2uaZYopXSsIaMvqS3orzDeClbWa4OAppvoY
 Iw2wiM8Yit1Si+/xcVZMyU3BPfUZqFU6tMuf9k9Q6elvEd9C9VrnVkZn+DC747msJG3yP38+wwQ
 cpKACnAw3in0R+03k6EBoWbbnNszXCNPChJ2OQk2CQNDaSTYmSIMKCOom1s/x/BXMccy7jPFv+v
 rgnUXXkR18ZHcFj3x8cKBTYcboUDAhrxLJ0PIiAw4am47swanFcGWaENKfGOGx2e+Q7l18R9Hnj
 KwdJYVs22krvAZZbhmPZl/90AuAPbaw0b9XNXSVVQ==
X-Received: by 2002:a17:906:dc94:b0:c2d:dbfd:4314 with SMTP id
 a640c23a62f3a-c31a9fff622mr1293814566b.46.1791966114141; 
 Wed, 14 Oct 2026 01:21:54 -0700 (PDT)
Received: from [192.168.1.130] (93-143-204-231.adsl.net.t-com.hr.
 [93.143.204.231]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c34feaf0767sm324317466b.40.2026.10.14.01.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 01:21:53 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
X-Google-Original-From: Ruslan Ruslichenko <ruslichenkor@gmail.com>
Message-ID: <011b142e-feae-47e0-9c67-6cc7277c5113@gmail.com>
Date: Wed, 14 Oct 2026 10:21:51 +0200
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
Content-Language: en-US
In-Reply-To: <07181e2fc148dce3c2152f450e9337b4b9a21f16.camel@bull.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x636.google.com
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



On 10/13/26 16:27, Clément MATHIEU--DRIF wrote:
> Do you need to operate at physmem level?  
> We have an API for PCI device for ATS and PRI (see pci_ats_request_translation and pci_pri_unregister_notifier)
> 

This helper is used by Remote-Port-ATS device, which is used for resolving ATS requests from remote masters via RemotePort link and it is TYPE_DEVICE itself.
As it is not a PCI device itself, we cannot use PCI API unfortunately.

> On Tue, 2026-09-15 at 18:00 +0200, Ruslan Ruslichenko wrote:
>> From: Ruslan Ruslichenko <[Ruslan_Ruslichenko@epam.com](mailto:Ruslan_Ruslichenko@epam.com)>
>>
>> Add 'ats_do_translate' method to enable manual IOMMU address  
>> translation.
>>
>> This allows the Remote Port subsystem to resolve guest virtual  
>> addresses to physical addresses by querying the QEMU IOMMU  
>> translation pipeline. This is required for the Remote Port  
>> subsystem to support translation  requests from external masters  
>> in a co-simulation environment.
>>
>> Signed-off-by: Edgar E. Iglesias <[edgar.iglesias@amd.com](mailto:edgar.iglesias@amd.com)>  
>> Signed-off-by: Takahiro Nakata <[takahiro.nakata.wr@renesas.com](mailto:takahiro.nakata.wr@renesas.com)>  
>> Signed-off-by: Ruslan Ruslichenko <[Ruslan_Ruslichenko@epam.com](mailto:Ruslan_Ruslichenko@epam.com)>  
>> ---  
>>  include/system/memory.h |  8 +++++++  
>>  system/physmem.c        | 53 +++++++++++++++++++++++++++++++++++++++++  
>>  2 files changed, 61 insertions(+)
>>
>> diff --git a/include/system/memory.h b/include/system/memory.h  
>> index a7e03fc3e7..2032d3028d 100644  
>> --- a/include/system/memory.h  
>> +++ b/include/system/memory.h  
>> @@ -2583,6 +2583,14 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,  
>>                                addr, xlat, len, is_write, attrs);  
>>  }  
>>    
>> +MemoryRegion *ats_do_translate(AddressSpace *as,  
>> +    hwaddr addr,  
>> +    hwaddr *xlat,  
>> +    hwaddr *plen_out,  
>> +    AddressSpace **target_as,  
>> +    int *prot,  
>> +    MemTxAttrs attrs);  
>> +  
>>  /* address_space_access_valid: check for validity of accessing an address  
>>   * space range  
>>   *  
>> diff --git a/system/physmem.c b/system/physmem.c  
>> index a4a6a4710c..1acda22ede 100644  
>> --- a/system/physmem.c  
>> +++ b/system/physmem.c  
>> @@ -525,6 +525,59 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,  
>>      return *section;  
>>  }  
>>    
>> +/* This function is called from RCU critical section */  
>> +MemoryRegion *ats_do_translate(AddressSpace *as,  
>> +                               hwaddr addr,  
>> +                               hwaddr *xlat,  
>> +                               hwaddr *plen_out,  
>> +                               AddressSpace **target_as,  
>> +                               int *prot,  
>> +                               MemTxAttrs attrs)  
>> +{  
>> +    MemoryRegionSection *section;  
>> +    IOMMUMemoryRegion *iommu_mr;  
>> +    hwaddr plen = (hwaddr)(-1);  
>> +    FlatView *fv = address_space_to_flatview(as);  
>> +    IOMMUMemoryRegionClass *imrc;  
>> +    IOMMUTLBEntry iotlb;  
>> +    int iommu_idx = 0;  
>> +  
>> +    if (!plen_out) {  
>> +        plen_out = &plen;  
>> +    }  
>> +  
>> +    /* This can be MMIO, so setup MMIO bit. */  
>> +    section = address_space_translate_internal(  
>> +            flatview_to_dispatch(fv), addr, xlat,  
>> +            plen_out, true);  
>> +  
>> +    /* Illegal translation */  
>> +    if (section->mr == &io_mem_unassigned) {  
>> +        return NULL;  
>> +    }  
>> +  
>> +    iommu_mr = memory_region_get_iommu(section->mr);  
>> +    if (!iommu_mr) {  
>> +        return NULL;  
>> +    }  
>> +  
>> +    imrc = memory_region_get_iommu_class_nocheck(iommu_mr);  
>> +  
>> +    if (imrc->attrs_to_index) {  
>> +        iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);  
>> +    }  
>> +  
>> +    iotlb = imrc->translate(iommu_mr, addr, IOMMU_RO, iommu_idx);  
>> +  
>> +    *xlat = ((iotlb.translated_addr & ~iotlb.addr_mask)  
>> +            | (addr & iotlb.addr_mask));  
>> +    *plen_out = MIN(*plen_out, (addr | iotlb.addr_mask) - addr + 1);  
>> +    *prot = iotlb.perm;  
>> +    *target_as = iotlb.target_as;  
>> +  
>> +    return section->mr;  
>> +}  
>> +  
>>  /* Called from RCU critical section */  
>>  IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,  
>>                                              bool is_write, MemTxAttrs attrs)


