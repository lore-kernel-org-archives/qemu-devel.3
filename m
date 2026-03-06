Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377A7F0180C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQ4V-0007Nl-NV; Fri, 06 Mar 2026 02:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyQ4U-0007Ma-0a
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:06 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyQ4Q-00062V-9x
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:05 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6267vSlT035766
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Mar 2026 16:57:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ml+9D+qDYCzI6U4w9DtVpkLewIz9/YKGUYpLHigOV6M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772783855; v=1;
 b=sBbI6tj+Xgo4bfpoNx/3/36rCYBvR2AlibrvUzw4qWxWXfCXgF2VLLk8txN3Fy1t
 xbBTcnWK1LUt7k6ZPK/Hm37o1clWR7soHU1vILMrhiZST1FfJy0RO0Vm/8egLDow
 XOP5oKYN9HlQO7PMsSjTyaTPCB7NBuUv+tqGAqkMduMhdg3ET1hmwQHW30BQFFus
 qhQS7AZJlDNkIKLr5ZJYEyvPgOIEHgREae1M+BxuC49YxB/pZN13CIGkyVja7t+w
 Dl11ED02nUL4JiDho6PZvRQb2BeuCxDiFJQLm+Oyrh9GEwBqK/BwOl8ux4ZG7dkK
 2pLcOgA6Bj31j8POEgW3FA==
Message-ID: <564fbd58-8508-4450-9ffa-95bdd7fe02b2@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 6 Mar 2026 16:57:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] memory: Factor out common ram region initialization
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <cover.1772760714.git.balaton@eik.bme.hu>
 <7af26ad5d94b87bed32af860cb3de8a3ca2ced12.1772760714.git.balaton@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <7af26ad5d94b87bed32af860cb3de8a3ca2ced12.1772760714.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/06 10:41, BALATON Zoltan wrote:
> Introduce internal helper function to remove duplicated code from
> different memory_region_init_*ram functions. Remove locall err and
> error_propagate and pass errp and check return values instead.
> Also shorten some function prototypes while at it.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   system/memory.c | 167 +++++++++++++++++-------------------------------
>   1 file changed, 58 insertions(+), 109 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 9a12224555..7781d20d41 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1568,39 +1568,38 @@ static void memory_region_set_ops(MemoryRegion *mr,
>       mr->terminates = true;
>   }
>   
> -void memory_region_init_io(MemoryRegion *mr,
> -                           Object *owner,
> -                           const MemoryRegionOps *ops,
> -                           void *opaque,
> -                           const char *name,
> -                           uint64_t size)
> +void memory_region_init_io(MemoryRegion *mr, Object *owner,
> +                           const MemoryRegionOps *ops, void *opaque,
> +                           const char *name, uint64_t size)
>   {
>       memory_region_init(mr, owner, name, size);
>       memory_region_set_ops(mr, ops, opaque);
>   }
>   
> -bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
> -                                            Object *owner,
> -                                            const char *name,
> -                                            uint64_t size,
> -                                            uint32_t ram_flags,
> -                                            Error **errp)
> +static bool memory_region_set_ram_block(MemoryRegion *mr, RAMBlock *rb)
>   {
> -    Error *err = NULL;
> -    memory_region_init(mr, owner, name, size);
>       mr->ram = true;
>       mr->terminates = true;
>       mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);
> -    if (err) {
> +    mr->ram_block = rb;
> +    if (!rb) {
>           mr->size = int128_zero();
>           object_unparent(OBJECT(mr));
> -        error_propagate(errp, err);
>           return false;
>       }
>       return true;
>   }
>   
> +bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
> +                                            const char *name, uint64_t size,
> +                                            uint32_t ram_flags, Error **errp)
> +{
> +    RAMBlock *rb = qemu_ram_alloc(size, ram_flags, mr, errp);

qemu_ram_alloc() should be called after memory_region_init() since it 
may dereference mr.

Regards,
Akihiko Odaki

> +
> +    memory_region_init(mr, owner, name, size);
> +    return memory_region_set_ram_block(mr, rb);
> +}
> +
>   bool memory_region_init_resizeable_ram(MemoryRegion *mr,
>                                          Object *owner,
>                                          const char *name,
> @@ -1611,116 +1610,70 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
>                                                          void *host),
>                                          Error **errp)
>   {
> -    Error *err = NULL;
> +    RAMBlock *rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
> +
>       memory_region_init(mr, owner, name, size);
> -    mr->ram = true;
> -    mr->terminates = true;
> -    mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc_resizeable(size, max_size, resized,
> -                                              mr, &err);
> -    if (err) {
> -        mr->size = int128_zero();
> -        object_unparent(OBJECT(mr));
> -        error_propagate(errp, err);
> -        return false;
> -    }
> -    return true;
> +    return memory_region_set_ram_block(mr, rb);
>   }
>   
>   #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
> -bool memory_region_init_ram_from_file(MemoryRegion *mr,
> -                                      Object *owner,
> -                                      const char *name,
> -                                      uint64_t size,
> -                                      uint64_t align,
> -                                      uint32_t ram_flags,
> -                                      const char *path,
> -                                      ram_addr_t offset,
> +bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
> +                                      const char *name, uint64_t size,
> +                                      uint64_t align, uint32_t ram_flags,
> +                                      const char *path, ram_addr_t offset,
>                                         Error **errp)
>   {
> -    Error *err = NULL;
> +    RAMBlock *rb = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset,
> +                                            errp);
> +
>       memory_region_init(mr, owner, name, size);
> -    mr->ram = true;
>       mr->readonly = !!(ram_flags & RAM_READONLY);
> -    mr->terminates = true;
> -    mr->destructor = memory_region_destructor_ram;
>       mr->align = align;
> -    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path,
> -                                             offset, &err);
> -    if (err) {
> -        mr->size = int128_zero();
> -        object_unparent(OBJECT(mr));
> -        error_propagate(errp, err);
> -        return false;
> -    }
> -    return true;
> +    return memory_region_set_ram_block(mr, rb);
>   }
>   
> -bool memory_region_init_ram_from_fd(MemoryRegion *mr,
> -                                    Object *owner,
> -                                    const char *name,
> -                                    uint64_t size,
> -                                    uint32_t ram_flags,
> -                                    int fd,
> -                                    ram_addr_t offset,
> -                                    Error **errp)
> +bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
> +                                    const char *name, uint64_t size,
> +                                    uint32_t ram_flags, int fd,
> +                                    ram_addr_t offset, Error **errp)
>   {
> -    Error *err = NULL;
> +    RAMBlock *rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
> +                                          offset, false, errp);
> +
>       memory_region_init(mr, owner, name, size);
> -    mr->ram = true;
>       mr->readonly = !!(ram_flags & RAM_READONLY);
> -    mr->terminates = true;
> -    mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
> -                                           offset, false, &err);
> -    if (err) {
> -        mr->size = int128_zero();
> -        object_unparent(OBJECT(mr));
> -        error_propagate(errp, err);
> -        return false;
> -    }
> -    return true;
> +    return memory_region_set_ram_block(mr, rb);
>   }
>   #endif
>   
> -void memory_region_init_ram_ptr(MemoryRegion *mr,
> -                                Object *owner,
> -                                const char *name,
> -                                uint64_t size,
> +void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
> +                                const char *name, uint64_t size,
>                                   void *ptr)
>   {
> -    memory_region_init(mr, owner, name, size);
> -    mr->ram = true;
> -    mr->terminates = true;
> -    mr->destructor = memory_region_destructor_ram;
> -
>       /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
>       assert(ptr != NULL);
> -    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
> +    RAMBlock *rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
> +
> +    memory_region_init(mr, owner, name, size);
> +    memory_region_set_ram_block(mr, rb);
>   }
>   
> -void memory_region_init_ram_device_ptr(MemoryRegion *mr,
> -                                       Object *owner,
> -                                       const char *name,
> -                                       uint64_t size,
> +void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
> +                                       const char *name, uint64_t size,
>                                          void *ptr)
>   {
> -    memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
> -    mr->ram = true;
> -    mr->ram_device = true;
> -    mr->destructor = memory_region_destructor_ram;
> -
>       /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
>       assert(ptr != NULL);
> -    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
> +    RAMBlock *rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
> +
> +    memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
> +    mr->ram_device = true;
> +    memory_region_set_ram_block(mr, rb);
>   }
>   
> -void memory_region_init_alias(MemoryRegion *mr,
> -                              Object *owner,
> -                              const char *name,
> -                              MemoryRegion *orig,
> -                              hwaddr offset,
> -                              uint64_t size)
> +void memory_region_init_alias(MemoryRegion *mr, Object *owner,
> +                              const char *name, MemoryRegion *orig,
> +                              hwaddr offset, uint64_t size)
>   {
>       memory_region_init(mr, owner, name, size);
>       mr->alias = orig;
> @@ -3732,21 +3685,17 @@ bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
>                                      const char *name, uint64_t size,
>                                      Error **errp)
>   {
> -    Error *err = NULL;
> +    RAMBlock *rb = qemu_ram_alloc(size, 0, mr, errp);
>   
>       assert(ops);
>       memory_region_init_io(mr, owner, ops, opaque, name, size);
> -    mr->rom_device = true;
> -    mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
> -    if (err) {
> -        mr->size = int128_zero();
> -        object_unparent(OBJECT(mr));
> -        error_propagate(errp, err);
> -        return false;
> +    if (memory_region_set_ram_block(mr, rb)) {
> +        mr->ram = false;
> +        mr->rom_device = true;
> +        memory_region_register_ram(mr, owner);
> +        return true;
>       }
> -    memory_region_register_ram(mr, owner);
> -    return true;
> +    return false;
>   }
>   
>   /*


