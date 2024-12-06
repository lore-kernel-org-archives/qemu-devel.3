Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47DAE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 10:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJVFf-0007tu-VC; Fri, 06 Dec 2024 05:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tJVFd-0007tf-Pu
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:07:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tJVFZ-0007r2-Fh
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733479670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iZPt/g3xPeiN68YASYa3KBDWzIS1V3NtfETKBGXK8UM=;
 b=iETBJx3GHiHDDhlEV+y5578PZMiaSKhIF4Fvs+jVTBDyJgMNRJbYXbPmrdxXZ5je3mE/8f
 t9bBDIBfAwWzay6vdUIMbIcj0u/yI7OTnFD01gXqPkP1L+XU5VH4L1yRWbo/axkVWUSgRn
 ku9gVZQh1mK524XCE3bkO4tSbbeY4hE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-UgIntaYyNIG_34zPRrJE1A-1; Fri, 06 Dec 2024 05:07:46 -0500
X-MC-Unique: UgIntaYyNIG_34zPRrJE1A-1
X-Mimecast-MFC-AGG-ID: UgIntaYyNIG_34zPRrJE1A
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4349eeeb841so12285555e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 02:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733479665; x=1734084465;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZPt/g3xPeiN68YASYa3KBDWzIS1V3NtfETKBGXK8UM=;
 b=o9/ETmvpO3dsfkGv7n112H1M+Vsck33wigZXXHol8S3qSg7jaPidWZaHwqC0BPlFSq
 mvBwHEDntVk+3gk4Ps/Zy6V1T0JjCp7aoL3silSQaOPmUVLsc8a0xUqTratXv4rZ30hT
 j00Y9KPQC5lMu+KF4ZzXiRzoGK5uasdv3pTVYJEml86O7qfl/Ky77kzvmtR7GzOtC6QY
 32wvk9s+15frFbk/W+8M5NFpVCCCzRSbdYNGW6mAJE6JnguhtLFD8MQ/KzgrEWGrjQM1
 cstOB9teqKgz9teeRJ8W1fInFSWj5YIJXGmaoXHus1gfj/IIJK+3G4ik+h8xUsAP+Wef
 AJ4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVfkIYV4nwYR+ZnM8oMpVkQo7YKWXH8m+8Mv938EYsrE65edFrpq1Qp7y9tGsLgoM3hSlCD5aXiazR@nongnu.org
X-Gm-Message-State: AOJu0YxrsZTXQxL4CTK7SWnq+nGh30gGuiu0Q6MJfOTLBkAdCSGY2Vju
 xvHbKYPom39UxK6U1smTqDknCd+8/PdCkIrL6mVQQjDxS2eLIf3G16KOYumVdGdjUudNzPCwCyj
 OJrMj8I+cJQn3kGWck+HCK4tJ4G7FLEuEKQ+KThQLmlF44bLI7HAh
X-Gm-Gg: ASbGncs1fmOxBmdIvvJIBYcvFlDDY50qrEFTOJJmbMXxa/xIf26YVBahATQII3w62GB
 msWcZsUCPUC2pDRptkIVcw/t/IE0F9uHt73TdZ+a7LPo8jQHlpscJTA0utQA/tf/bAHYFcIhzyp
 ydqJLEw9hl8LHWayA7U5ATYd6+XWPF3ryMOhpJMVuqKfrZD+oJLvZR6Nm2FmA510g+OvU7baBk1
 YjPA1FgtA7e8hhwIUOIJFxpuiVyT7QnkZDdeoYMUMqZLfpGp6u22QpOn82AYPk9wJvBN7KU1uVb
 uNgimrZ7GYnvpAHZOj3GEDBOeFjcssTSoE1O4/TAkvrCoOrWRNvhNiG+5RjYu2JosOTiovS9/To
 rGg==
X-Received: by 2002:a05:600c:1d85:b0:431:5ce4:bcf0 with SMTP id
 5b1f17b1804b1-434ddeb8ce0mr22284805e9.15.1733479665610; 
 Fri, 06 Dec 2024 02:07:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnc0oXPxaNmXdvN4umXmT7I/0QIkFWij00Lf5qECh1yfnMSP5jQWWdi7S2DIgash/phzni0g==
X-Received: by 2002:a05:600c:1d85:b0:431:5ce4:bcf0 with SMTP id
 5b1f17b1804b1-434ddeb8ce0mr22284545e9.15.1733479665218; 
 Fri, 06 Dec 2024 02:07:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:d000:1d1f:238e:aeaf:dbf7?
 (p200300cbc71bd0001d1f238eaeafdbf7.dip0.t-ipconnect.de.
 [2003:cb:c71b:d000:1d1f:238e:aeaf:dbf7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d04e7380sm101877835e9.0.2024.12.06.02.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 02:07:43 -0800 (PST)
Message-ID: <5d4019cd-a3fb-4bed-8bab-e0388ccffee7@redhat.com>
Date: Fri, 6 Dec 2024 11:07:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostmem-file: add the 'hmem' option
To: Zhigang Luo <Zhigang.Luo@amd.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Igor Mammedov <imammedo@redhat.com>
References: <20241204171114.20033-1-Zhigang.Luo@amd.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241204171114.20033-1-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 04.12.24 18:11, Zhigang Luo wrote:
> This boolean option 'hmem' allows users to set a memory region from
> memory-backend-file as heterogeneous memory. If 'hmem=on', QEMU will
> set the flag RAM_HMEM in the RAM block of the corresponding memory
> region and set the e820 type to E820_SOFT_RESERVED for this region.
> 

Hi,

./scripts/get_maintainer.pl is your friend to figure out whom to CC on 
patches.

In general: not a fan. You seem to be abusing memory backend properties 
+ RAM flags to merely modify how memory is going to be exposed in the 
memory map on x86.

It's not even clear why heterogeneous memory should be exposed like 
that, and how reasonable it is to essentially expose all of guest RAM as 
E820_SOFT_RESERVED.


Note that the whole "pmem=on" case was very different, because it 
required mmap() modifications.

> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
> ---
>   backends/hostmem-file.c      | 23 +++++++++++++++++++++++
>   hw/i386/e820_memory_layout.h |  1 +
>   hw/i386/pc.c                 | 16 ++++++++++++++++
>   include/exec/cpu-common.h    |  1 +
>   include/exec/memory.h        |  3 +++
>   qapi/qom.json                |  4 ++++
>   system/physmem.c             |  7 ++++++-
>   7 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 7e5072e33e..5ddfdbaf86 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -32,6 +32,7 @@ struct HostMemoryBackendFile {
>       uint64_t offset;
>       bool discard_data;
>       bool is_pmem;
> +    bool is_hmem;
>       bool readonly;
>       OnOffAuto rom;
>   };
> @@ -88,6 +89,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
>       ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
>       ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
> +    ram_flags |= fb->is_hmem ? RAM_HMEM : 0;
>       ram_flags |= RAM_NAMED_FILE;
>       return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
>                                               backend->size, fb->align, ram_flags,
> @@ -256,6 +258,25 @@ static void file_memory_backend_set_rom(Object *obj, Visitor *v,
>       visit_type_OnOffAuto(v, name, &fb->rom, errp);
>   }
>   
> +static bool file_memory_backend_get_hmem(Object *o, Error **errp)
> +{
> +    return MEMORY_BACKEND_FILE(o)->is_hmem;
> +}
> +
> +static void file_memory_backend_set_hmem(Object *o, bool value, Error **errp)
> +{
> +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
> +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
> +
> +    if (host_memory_backend_mr_inited(backend)) {
> +        error_setg(errp, "cannot change property 'hmem' of %s.",
> +                   object_get_typename(o));
> +        return;
> +    }
> +
> +    fb->is_hmem = value;
> +}
> +
>   static void file_backend_unparent(Object *obj)
>   {
>       HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> @@ -295,6 +316,8 @@ file_backend_class_init(ObjectClass *oc, void *data)
>       object_class_property_add_bool(oc, "pmem",
>           file_memory_backend_get_pmem, file_memory_backend_set_pmem);
>   #endif
> +    object_class_property_add_bool(oc, "hmem",
> +        file_memory_backend_get_hmem, file_memory_backend_set_hmem);
>       object_class_property_add_bool(oc, "readonly",
>           file_memory_backend_get_readonly,
>           file_memory_backend_set_readonly);
> diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
> index b50acfa201..8af6a9cfac 100644
> --- a/hw/i386/e820_memory_layout.h
> +++ b/hw/i386/e820_memory_layout.h
> @@ -15,6 +15,7 @@
>   #define E820_ACPI       3
>   #define E820_NVS        4
>   #define E820_UNUSABLE   5
> +#define E820_SOFT_RESERVED  0xEFFFFFFF
>   
>   struct e820_entry {
>       uint64_t address;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 317aaca25a..41e9cc276c 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -785,6 +785,21 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
>       return pc_above_4g_end(pcms) - 1;
>   }
>   
> +static int pc_update_hmem_memory(RAMBlock *rb, void *opaque)
> +{
> +    X86MachineState *x86ms = opaque;
> +    ram_addr_t offset;
> +    ram_addr_t length;
> +
> +    if (qemu_ram_is_hmem(rb)) {
> +        offset = qemu_ram_get_offset(rb) + (0x100000000ULL - x86ms->below_4g_mem_size);
> +        length = qemu_ram_get_used_length(rb);
> +        e820_add_entry(offset, length, E820_SOFT_RESERVED);
> +    }

I am pretty sure this will break in NUMA setups, where we have multiple 
memory backends mapped in different locations.

The whole "(0x100000000ULL - x86ms->below_4g_mem_size)" looks hacky.

-- 
Cheers,

David / dhildenb


