Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F54C28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 23:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqKBy-0006yO-2b; Thu, 06 Mar 2025 17:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqKBv-0006xo-11
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:59:47 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqKBs-000782-Uy
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:59:46 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-223fd89d036so24845655ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 14:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741301983; x=1741906783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p8KBefIIXMpte5eJ7QvBmXbTJoAln2iE1nz6QXgw3LI=;
 b=qTGDZHMvlqS+NB+e5Dtd71VeKNXNqak/n2u5srxyUQWnyCHiv8S/IBudb+w09Z7Wbp
 WPAbDgL8G3IE9euD69L34UQkC6qhLMn0Tuf0AoVoElBwee91Fu37QpHgFyT73w+UpQY1
 rf1vePFrXWBkbJl06hU9CXCTGzVyDiI5URc+brRfMtUa96rDBHsJtOlKoh2Gf2P57c0z
 ThTxaQTSNJWujB2xGPQmlpDPBbAR/WJdDJG8TXHz+0S+Mlhf1DNP5h25nTOqLYr+OXjL
 3p9oi5Igvd30ek6IZmK7XX1An2VzrFaw6+NNSUu5TyXtBQslPF4dEkHfNk6kmoJNI01s
 dEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741301983; x=1741906783;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p8KBefIIXMpte5eJ7QvBmXbTJoAln2iE1nz6QXgw3LI=;
 b=NxOepbPkwKjVqnFXYj2gRehFhwIaLE7nb0c5mTA7C6oE6JoJ9H6o/iDmMUmGciLgM6
 0+JLn6x+shGGbFAh5nAPP6xv2nB3QUgf65eee6efJzzkAQSjh60wMIVlnlRahjBnVOyZ
 2XgMtQilkxNNXV4uVIGPOZbve8KQuiEhK1CvdtIixMuYkedDFcS5gXWgAuH0RbwQxKDS
 3xc5DqA4Iga8OH/wto7pM83EwLnXBS7V3Ej5XAyvUF3TuYDirMXJ6lUlnLxFQ6H11NcD
 t9tKpShTfi0rjBGsKmI7Vyn/RaR4AP+DN0Qeg+IIFQ6gtTBUX8AJwiUIyuWJ9sJUyRMw
 sEbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcdIeVAZR2ml/pxGsDIhkTkqDl3ckqGILERM71EK+HONp4d12MpmfNswe3zasJmITZozQfJnnKAOqQ@nongnu.org
X-Gm-Message-State: AOJu0YwOmlNAtXBR55wY3tLxwhgpZ+rwsWXhmdjVSluKsCI/yw5ey6mK
 E2gpoAGnIP06ibxvbEGHI7HB39ghN/Q1Q6rzTB2eGNrtxk7d/Lq/+pId7EI2+kM=
X-Gm-Gg: ASbGnctgzzcRcnXOFm/74U5XTLGxiNk0qf//LntCSs2cBa7e68UsQN0CpioQxxNTaEC
 73larwRVOCgjDbZsQXOlyfH6Yw4YTHAeZRI1et1I9Yo/qE2nqfhbRc6khgpcyxoVMBsuTGb+iHL
 U3FRVQEk7UpLvo3RmI0ktipM1TnHYZ3DFYpL+XeaER7nKuHedzvb7xMp4QQoaXBySdoA/rOl9tv
 NXCADnQXvFdwza5DexXbZpKLMXzJytr237AhknYF+nTf4ncpPqqtfvbVDLUKVBgM04onM+U917M
 hkqt3Br9VMr29wcEfbGchMlM3YOvuOG/8bgCWu/esy3gXhMNl6iB7ykc6A==
X-Google-Smtp-Source: AGHT+IEKZihSeTW0S6Q19SWxLJku2nuf9r5zJwrbdNHyLjau5lx6gDE+lq9l1J0pmUoDTr96SWb/KQ==
X-Received: by 2002:a17:902:da84:b0:224:10a2:cae7 with SMTP id
 d9443c01a7336-22428c057cemr16855885ad.40.1741301983257; 
 Thu, 06 Mar 2025 14:59:43 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410aa5cdbsm17719985ad.230.2025.03.06.14.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 14:59:42 -0800 (PST)
Message-ID: <9ee1b0aa-27e3-47f9-8276-1158bfa5ad06@linaro.org>
Date: Thu, 6 Mar 2025 14:59:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] hw/hyperv/vmbus: common compilation unit
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: kvm@vger.kernel.org, philmd@linaro.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 richard.henderson@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 alex.bennee@linaro.org
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
 <20250306064118.3879213-4-pierrick.bouvier@linaro.org>
 <adadeb12-9eb7-4338-828e-62e77034b1dd@maciej.szmigiero.name>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <adadeb12-9eb7-4338-828e-62e77034b1dd@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Maciej,

we are currently working toward building a single QEMU binary able to 
emulate all architectures, and one prerequisite is to remove duplication 
of compilation units (some are duplicated per target now, because of 
compile time defines).

So the work here is to replace those compile time defines with runtime 
functions instead, so the same code can be used for various architectures.

Is it more clear for you?

On 3/6/25 12:29, Maciej S. Szmigiero wrote:
> On 6.03.2025 07:41, Pierrick Bouvier wrote:
>> Replace TARGET_PAGE.* by runtime calls.
> 
> Seems like this patch subject/title is not aligned
> well with its content, or a least incomplete.
> 
> Also, could you provide more detailed information
> why TARGET_PAGE_SIZE is getting replaced by
> qemu_target_page_size() please?
> 
> I don't see such information in the cover letter either.
> 
> Thanks,
> Maciej
>    
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    hw/hyperv/vmbus.c     | 50 +++++++++++++++++++++----------------------
>>    hw/hyperv/meson.build |  2 +-
>>    2 files changed, 26 insertions(+), 26 deletions(-)
>>
>> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
>> index 12a7dc43128..109ac319caf 100644
>> --- a/hw/hyperv/vmbus.c
>> +++ b/hw/hyperv/vmbus.c
>> @@ -18,7 +18,7 @@
>>    #include "hw/hyperv/vmbus.h"
>>    #include "hw/hyperv/vmbus-bridge.h"
>>    #include "hw/sysbus.h"
>> -#include "cpu.h"
>> +#include "exec/target_page.h"
>>    #include "trace.h"
>>    
>>    enum {
>> @@ -309,7 +309,7 @@ void vmbus_put_gpadl(VMBusGpadl *gpadl)
>>    
>>    uint32_t vmbus_gpadl_len(VMBusGpadl *gpadl)
>>    {
>> -    return gpadl->num_gfns * TARGET_PAGE_SIZE;
>> +    return gpadl->num_gfns * qemu_target_page_size();
>>    }
>>    
>>    static void gpadl_iter_init(GpadlIter *iter, VMBusGpadl *gpadl,
>> @@ -323,14 +323,14 @@ static void gpadl_iter_init(GpadlIter *iter, VMBusGpadl *gpadl,
>>    
>>    static inline void gpadl_iter_cache_unmap(GpadlIter *iter)
>>    {
>> -    uint32_t map_start_in_page = (uintptr_t)iter->map & ~TARGET_PAGE_MASK;
>> -    uint32_t io_end_in_page = ((iter->last_off - 1) & ~TARGET_PAGE_MASK) + 1;
>> +    uint32_t map_start_in_page = (uintptr_t)iter->map & ~qemu_target_page_mask();
>> +    uint32_t io_end_in_page = ((iter->last_off - 1) & ~qemu_target_page_mask()) + 1;
>>    
>>        /* mapping is only done to do non-zero amount of i/o */
>>        assert(iter->last_off > 0);
>>        assert(map_start_in_page < io_end_in_page);
>>    
>> -    dma_memory_unmap(iter->as, iter->map, TARGET_PAGE_SIZE - map_start_in_page,
>> +    dma_memory_unmap(iter->as, iter->map, qemu_target_page_size() - map_start_in_page,
>>                         iter->dir, io_end_in_page - map_start_in_page);
>>    }
>>    
>> @@ -348,17 +348,17 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
>>        assert(iter->active);
>>    
>>        while (len) {
>> -        uint32_t off_in_page = iter->off & ~TARGET_PAGE_MASK;
>> -        uint32_t pgleft = TARGET_PAGE_SIZE - off_in_page;
>> +        uint32_t off_in_page = iter->off & ~qemu_target_page_mask();
>> +        uint32_t pgleft = qemu_target_page_size() - off_in_page;
>>            uint32_t cplen = MIN(pgleft, len);
>>            void *p;
>>    
>>            /* try to reuse the cached mapping */
>>            if (iter->map) {
>>                uint32_t map_start_in_page =
>> -                (uintptr_t)iter->map & ~TARGET_PAGE_MASK;
>> -            uint32_t off_base = iter->off & ~TARGET_PAGE_MASK;
>> -            uint32_t mapped_base = (iter->last_off - 1) & ~TARGET_PAGE_MASK;
>> +                (uintptr_t)iter->map & ~qemu_target_page_mask();
>> +            uint32_t off_base = iter->off & ~qemu_target_page_mask();
>> +            uint32_t mapped_base = (iter->last_off - 1) & ~qemu_target_page_mask();
>>                if (off_base != mapped_base || off_in_page < map_start_in_page) {
>>                    gpadl_iter_cache_unmap(iter);
>>                    iter->map = NULL;
>> @@ -368,10 +368,10 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
>>            if (!iter->map) {
>>                dma_addr_t maddr;
>>                dma_addr_t mlen = pgleft;
>> -            uint32_t idx = iter->off >> TARGET_PAGE_BITS;
>> +            uint32_t idx = iter->off >> qemu_target_page_bits();
>>                assert(idx < iter->gpadl->num_gfns);
>>    
>> -            maddr = (iter->gpadl->gfns[idx] << TARGET_PAGE_BITS) | off_in_page;
>> +            maddr = (iter->gpadl->gfns[idx] << qemu_target_page_bits()) | off_in_page;
>>    
>>                iter->map = dma_memory_map(iter->as, maddr, &mlen, iter->dir,
>>                                           MEMTXATTRS_UNSPECIFIED);
>> @@ -382,7 +382,7 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
>>                }
>>            }
>>    
>> -        p = (void *)(uintptr_t)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
>> +        p = (void *)(uintptr_t)(((uintptr_t)iter->map & qemu_target_page_mask()) |
>>                    off_in_page);
>>            if (iter->dir == DMA_DIRECTION_FROM_DEVICE) {
>>                memcpy(p, buf, cplen);
>> @@ -591,9 +591,9 @@ static void ringbuf_init_common(VMBusRingBufCommon *ringbuf, VMBusGpadl *gpadl,
>>                                    uint32_t begin, uint32_t end)
>>    {
>>        ringbuf->as = as;
>> -    ringbuf->rb_addr = gpadl->gfns[begin] << TARGET_PAGE_BITS;
>> -    ringbuf->base = (begin + 1) << TARGET_PAGE_BITS;
>> -    ringbuf->len = (end - begin - 1) << TARGET_PAGE_BITS;
>> +    ringbuf->rb_addr = gpadl->gfns[begin] << qemu_target_page_bits();
>> +    ringbuf->base = (begin + 1) << qemu_target_page_bits();
>> +    ringbuf->len = (end - begin - 1) << qemu_target_page_bits();
>>        gpadl_iter_init(&ringbuf->iter, gpadl, as, dir);
>>    }
>>    
>> @@ -734,7 +734,7 @@ static int vmbus_channel_notify_guest(VMBusChannel *chan)
>>        unsigned long *int_map, mask;
>>        unsigned idx;
>>        hwaddr addr = chan->vmbus->int_page_gpa;
>> -    hwaddr len = TARGET_PAGE_SIZE / 2, dirty = 0;
>> +    hwaddr len = qemu_target_page_size() / 2, dirty = 0;
>>    
>>        trace_vmbus_channel_notify_guest(chan->id);
>>    
>> @@ -743,7 +743,7 @@ static int vmbus_channel_notify_guest(VMBusChannel *chan)
>>        }
>>    
>>        int_map = cpu_physical_memory_map(addr, &len, 1);
>> -    if (len != TARGET_PAGE_SIZE / 2) {
>> +    if (len != qemu_target_page_size() / 2) {
>>            res = -ENXIO;
>>            goto unmap;
>>        }
>> @@ -1038,14 +1038,14 @@ static int sgl_from_gpa_ranges(QEMUSGList *sgl, VMBusDevice *dev,
>>            }
>>            len -= sizeof(range);
>>    
>> -        if (range.byte_offset & TARGET_PAGE_MASK) {
>> +        if (range.byte_offset & qemu_target_page_mask()) {
>>                goto eio;
>>            }
>>    
>>            for (; range.byte_count; range.byte_offset = 0) {
>>                uint64_t paddr;
>>                uint32_t plen = MIN(range.byte_count,
>> -                                TARGET_PAGE_SIZE - range.byte_offset);
>> +                                qemu_target_page_size() - range.byte_offset);
>>    
>>                if (len < sizeof(uint64_t)) {
>>                    goto eio;
>> @@ -1055,7 +1055,7 @@ static int sgl_from_gpa_ranges(QEMUSGList *sgl, VMBusDevice *dev,
>>                    goto err;
>>                }
>>                len -= sizeof(uint64_t);
>> -            paddr <<= TARGET_PAGE_BITS;
>> +            paddr <<= qemu_target_page_bits();
>>                paddr |= range.byte_offset;
>>                range.byte_count -= plen;
>>    
>> @@ -1804,7 +1804,7 @@ static void handle_gpadl_header(VMBus *vmbus, vmbus_message_gpadl_header *msg,
>>         * anything else and simplify things greatly.
>>         */
>>        if (msg->rangecount != 1 || msg->range[0].byte_offset ||
>> -        (msg->range[0].byte_count != (num_gfns << TARGET_PAGE_BITS))) {
>> +        (msg->range[0].byte_count != (num_gfns << qemu_target_page_bits()))) {
>>            return;
>>        }
>>    
>> @@ -2240,10 +2240,10 @@ static void vmbus_signal_event(EventNotifier *e)
>>            return;
>>        }
>>    
>> -    addr = vmbus->int_page_gpa + TARGET_PAGE_SIZE / 2;
>> -    len = TARGET_PAGE_SIZE / 2;
>> +    addr = vmbus->int_page_gpa + qemu_target_page_size() / 2;
>> +    len = qemu_target_page_size() / 2;
>>        int_map = cpu_physical_memory_map(addr, &len, 1);
>> -    if (len != TARGET_PAGE_SIZE / 2) {
>> +    if (len != qemu_target_page_size() / 2) {
>>            goto unmap;
>>        }
>>    
>> diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
>> index f4aa0a5ada9..c855fdcf04c 100644
>> --- a/hw/hyperv/meson.build
>> +++ b/hw/hyperv/meson.build
>> @@ -1,6 +1,6 @@
>>    specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
>>    specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
>> -specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
>> +system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
>>    specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
>>    specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
>>    system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
> 


