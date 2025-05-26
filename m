Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96984C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJThu-0000Uf-KS; Mon, 26 May 2025 05:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJThp-0000UI-PI
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJThn-0000CY-DS
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748250070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yii69Htghru3r/FFnGqYFRLxFqTtFhBxIyFBeettNTo=;
 b=gzMk5DsFkKmHsBIbqp6dMjccHkAfOdyix+zwpPN2nVKjD3hFGGmgm/A/zR4joA+pAgO7YY
 llBI7o0t/iS8qEvsOJPlG4ZlZjOZhsvXDmEyi7U33OOj6TJ6thD+ph2R0EKLjY+DsXgs8C
 dIu8w4iMoycP99TC6+AdHgqvojS8S0U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-EQu0TdFzPBqWdr8jm_tzAQ-1; Mon, 26 May 2025 05:01:07 -0400
X-MC-Unique: EQu0TdFzPBqWdr8jm_tzAQ-1
X-Mimecast-MFC-AGG-ID: EQu0TdFzPBqWdr8jm_tzAQ_1748250066
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a375938404so1313074f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748250066; x=1748854866;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Yii69Htghru3r/FFnGqYFRLxFqTtFhBxIyFBeettNTo=;
 b=A8/EtZnqsu4CmljdV9ZAOyAGdXVyC9thBvULxslTJOrqDAFrKnBKVk+RiQioH2dFo7
 XBTjwemnR7f1UT/MkXf6vXsptiASkq6TxaSor1+V+rBZVGSbaEDAqOPmyxW2dmI9SLFu
 xBFZ3Hpd1vZjEQDkyS1kJUSWffkWVf2ib8EussUYE0GEFc9Zi9fqsgp7n4euFYWgWE8x
 ysc/KVvbanrYujrg4SGXKDE0VikgizEOl8I20oe1Znn/rr9xuAnW0ysTC982hRAe/coa
 lljzI343CFxHcj9KRzuxbWXbEGVdMeqo313OD7z2azgSlH8WTZexue/xaZCvWx07S0+M
 ntkQ==
X-Gm-Message-State: AOJu0YwN2CaN+2M2cO85EUZWvdCJpKz9HpNoLb2MtvGXDMWJwCFMGIa6
 uX6fLJxk/HonSX42WROxHD2Scfs+X/nrnr3N9FaTfOrm+Zjg/C6pxBbUUUr3R+yhmBaD8eJCdi7
 uFEcVimh7tgHrKkUj0jbAQaL5ImGUTHaNM9v9NFwWrACyOWjd7OIgchti
X-Gm-Gg: ASbGncvrWhQkIZDAe/aW75m5GO208NfjU2crDFoN3ZEpA/tKhzX2G9JjEO8nlT6Zh5O
 6+VGpSAdWatpNlwR3Ggj8RatMxOSh57ViV9nA3oYn39Iyp68w2vKDheocYBKSFnDeQoHyLhlpjq
 BU+K/UGcO/h4PLjVTSbHi62FUUMu/0JULulTxnf3uvoduabTOuMKDpQYWPWGiH19LcAePDmsaNV
 SVGEYC6pwwUzc+XM550M3O4+E4zyxOb3C98naIi5oot4hxK3Kzh/nmSawYQssQZJuGFFWS8O+dA
 f4x/2pXXOHIz4sD3qYgVPH7jkn00V8L7IL6HVTmkXWi0Lwat6W7PYsZfRtrBCaJEnTMdgu3hBk6
 S1BtMRMPA+whT6E8C+Y6Yp8P6L9P9GIbJjMDy36Y=
X-Received: by 2002:a5d:64c8:0:b0:3a4:dc42:a0ac with SMTP id
 ffacd0b85a97d-3a4dc42a384mr1119874f8f.49.1748250065843; 
 Mon, 26 May 2025 02:01:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbGkjz0lu7X/7b9wLMt2GxP0SvghKFiRjg2CjK0JWY/X67CqTDOAUtK4+to4ckuOKV4tu4mQ==
X-Received: by 2002:a5d:64c8:0:b0:3a4:dc42:a0ac with SMTP id
 ffacd0b85a97d-3a4dc42a384mr1119818f8f.49.1748250065345; 
 Mon, 26 May 2025 02:01:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:6500:e1c1:8216:4c25:efe4?
 (p200300d82f196500e1c182164c25efe4.dip0.t-ipconnect.de.
 [2003:d8:2f19:6500:e1c1:8216:4c25:efe4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4481ca9f2d9sm234163805e9.19.2025.05.26.02.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:01:04 -0700 (PDT)
Message-ID: <e2e5c4ef-6647-49b2-a044-0634abd6a74e@redhat.com>
Date: Mon, 26 May 2025 11:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] ram-block-attribute: Introduce RamBlockAttribute
 to manage RAMBlock with guest_memfd
To: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-5-chenyi.qiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250520102856.132417-5-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 20.05.25 12:28, Chenyi Qiang wrote:
> Commit 852f0048f3 ("RAMBlock: make guest_memfd require uncoordinated
> discard") highlighted that subsystems like VFIO may disable RAM block
> discard. However, guest_memfd relies on discard operations for page
> conversion between private and shared memory, potentially leading to
> stale IOMMU mapping issue when assigning hardware devices to
> confidential VMs via shared memory. To address this and allow shared
> device assignement, it is crucial to ensure VFIO system refresh its
> IOMMU mappings.
> 
> RamDiscardManager is an existing interface (used by virtio-mem) to
> adjust VFIO mappings in relation to VM page assignment. Effectively page
> conversion is similar to hot-removing a page in one mode and adding it
> back in the other. Therefore, similar actions are required for page
> conversion events. Introduce the RamDiscardManager to guest_memfd to
> facilitate this process.
> 
> Since guest_memfd is not an object, it cannot directly implement the
> RamDiscardManager interface. Implementing it in HostMemoryBackend is
> not appropriate because guest_memfd is per RAMBlock, and some RAMBlocks
> have a memory backend while others do not. Notably, virtual BIOS
> RAMBlocks using memory_region_init_ram_guest_memfd() do not have a
> backend.
> 
> To manage RAMBlocks with guest_memfd, define a new object named
> RamBlockAttribute to implement the RamDiscardManager interface. This
> object can store the guest_memfd information such as bitmap for shared
> memory, and handles page conversion notification. In the context of
> RamDiscardManager, shared state is analogous to populated and private
> state is treated as discard. The memory state is tracked at the host
> page size granularity, as minimum memory conversion size can be one page
> per request. Additionally, VFIO expects the DMA mapping for a specific
> iova to be mapped and unmapped with the same granularity. Confidential
> VMs may perform partial conversions, such as conversions on small
> regions within larger regions. To prevent such invalid cases and until
> cut_mapping operation support is available, all operations are performed
> with 4K granularity.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
> Changes in v5:
>      - Revert to use RamDiscardManager interface instead of introducing
>        new hierarchy of class to manage private/shared state, and keep
>        using the new name of RamBlockAttribute compared with the
>        MemoryAttributeManager in v3.
>      - Use *simple* version of object_define and object_declare since the
>        state_change() function is changed as an exported function instead
>        of a virtual function in later patch.
>      - Move the introduction of RamBlockAttribute field to this patch and
>        rename it to ram_shared. (Alexey)
>      - call the exit() when register/unregister failed. (Zhao)
>      - Add the ram-block-attribute.c to Memory API related part in
>        MAINTAINERS.
> 
> Changes in v4:
>      - Change the name from memory-attribute-manager to
>        ram-block-attribute.
>      - Implement the newly-introduced PrivateSharedManager instead of
>        RamDiscardManager and change related commit message.
>      - Define the new object in ramblock.h instead of adding a new file.
> 
> Changes in v3:
>      - Some rename (bitmap_size->shared_bitmap_size,
>        first_one/zero_bit->first_bit, etc.)
>      - Change shared_bitmap_size from uint32_t to unsigned
>      - Return mgr->mr->ram_block->page_size in get_block_size()
>      - Move set_ram_discard_manager() up to avoid a g_free() in failure
>        case.
>      - Add const for the memory_attribute_manager_get_block_size()
>      - Unify the ReplayRamPopulate and ReplayRamDiscard and related
>        callback.
> 
> Changes in v2:
>      - Rename the object name to MemoryAttributeManager
>      - Rename the bitmap to shared_bitmap to make it more clear.
>      - Remove block_size field and get it from a helper. In future, we
>        can get the page_size from RAMBlock if necessary.
>      - Remove the unncessary "struct" before GuestMemfdReplayData
>      - Remove the unncessary g_free() for the bitmap
>      - Add some error report when the callback failure for
>        populated/discarded section.
>      - Move the realize()/unrealize() definition to this patch.
> ---
>   MAINTAINERS                  |   1 +
>   include/system/ramblock.h    |  20 +++
>   system/meson.build           |   1 +
>   system/ram-block-attribute.c | 311 +++++++++++++++++++++++++++++++++++
>   4 files changed, 333 insertions(+)
>   create mode 100644 system/ram-block-attribute.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dacd6d004..3b4947dc74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3149,6 +3149,7 @@ F: system/memory.c
>   F: system/memory_mapping.c
>   F: system/physmem.c
>   F: system/memory-internal.h
> +F: system/ram-block-attribute.c
>   F: scripts/coccinelle/memory-region-housekeeping.cocci
>   
>   Memory devices
> diff --git a/include/system/ramblock.h b/include/system/ramblock.h
> index d8a116ba99..09255e8495 100644
> --- a/include/system/ramblock.h
> +++ b/include/system/ramblock.h
> @@ -22,6 +22,10 @@
>   #include "exec/cpu-common.h"
>   #include "qemu/rcu.h"
>   #include "exec/ramlist.h"
> +#include "system/hostmem.h"
> +
> +#define TYPE_RAM_BLOCK_ATTRIBUTE "ram-block-attribute"
> +OBJECT_DECLARE_SIMPLE_TYPE(RamBlockAttribute, RAM_BLOCK_ATTRIBUTE)
>   
>   struct RAMBlock {
>       struct rcu_head rcu;
> @@ -42,6 +46,8 @@ struct RAMBlock {
>       int fd;
>       uint64_t fd_offset;
>       int guest_memfd;
> +    /* 1-setting of the bitmap in ram_shared represents ram is shared */

That comment looks misplaced, and the variable misnamed.

The commet should go into RamBlockAttribute and the variable should 
likely be named "attributes".

Also, "ram_shared" is not used at all in this patch, it should be moved 
into the corresponding patch.

> +    RamBlockAttribute *ram_shared;
>       size_t page_size;
>       /* dirty bitmap used during migration */
>       unsigned long *bmap;
> @@ -91,4 +97,18 @@ struct RAMBlock {
>       ram_addr_t postcopy_length;
>   };
>   
> +struct RamBlockAttribute {

Should this actually be "RamBlockAttributes" ?

> +    Object parent;
> +
> +    MemoryRegion *mr;


Should we link to the parent RAMBlock instead, and lookup the MR from there?


-- 
Cheers,

David / dhildenb


