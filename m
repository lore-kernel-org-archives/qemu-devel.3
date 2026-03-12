Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09817FED2F5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 23:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0pq9-0006pi-5t; Thu, 12 Mar 2026 19:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w0pq7-0006pW-DE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 19:53:15 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w0pq4-0000ID-Cj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 19:53:15 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5D1425969EA;
 Fri, 13 Mar 2026 00:53:10 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id uzeQF_F6w9hk; Fri, 13 Mar 2026 00:53:07 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AD233596D8D; Fri, 13 Mar 2026 00:53:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AAF7C596D8B;
 Fri, 13 Mar 2026 00:53:07 +0100 (CET)
Date: Fri, 13 Mar 2026 00:53:07 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Kim Phillips <kim.phillips@amd.com>
cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PULL 08/18] memory: Factor out common ram region initialization
In-Reply-To: <df63fdf0-05ea-4de0-8009-c52703e4b052@amd.com>
Message-ID: <cf2f5867-592e-436c-dca7-eb195ec297f0@eik.bme.hu>
References: <20260309204007.1709441-1-peterx@redhat.com>
 <20260309204007.1709441-9-peterx@redhat.com>
 <df63fdf0-05ea-4de0-8009-c52703e4b052@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-850017568-1773359587=:43678"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-850017568-1773359587=:43678
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 12 Mar 2026, Kim Phillips wrote:
> On 3/9/26 3:39 PM, Peter Xu wrote:
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>> 
>> Introduce internal helper function to remove duplicated code from
>> different memory_region_init_*ram functions. Remove local err and
>> error_propagate and pass errp and check return value instead.
>> Also shorten some function prototypes while at it.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Link: 
>> https://lore.kernel.org/r/d6db01c283149b46023ffeb9c5b368c67f6acc8d.1772924151.git.balaton@eik.bme.hu
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>
> Hi, I bisected master (fff352b9b6) to this patch as the first bad commit that 
> results in this very early qemu error:

Thank you for reporting and sorry for the inconvenience. It's already 
known issue. Here's a proposed patch:

https://lists.nongnu.org/archive/html/qemu-devel/2026-03/msg04431.html

which is being reviewed/discussed.

Regards,
BALATON Zoltan

> ERROR:../system/memory.c:2042:memory_region_set_ram_discard_manager: 
> assertion failed: (memory_region_is_ram(mr))
>
> It's pointing to this line of code:
>
> int memory_region_set_ram_discard_manager(MemoryRegion *mr,
>                                           RamDiscardManager *rdm)
> {
>     g_assert(memory_region_is_ram(mr));   <<<<<
>
> Qemu then bails out. The command line is:
>
> sudo /usr/bin/qemu-system-x86_64 -enable-kvm \
>  -drive 
> file=/home/amd/ubuntu-22.04-server-cloudimg-amd64-kim.qcow2,if=none,id=disk0,format=qcow2 
> \
>  -device virtio-scsi-pci,id=scsi0,disable-legacy=on,iommu_platform=true \
>  -device scsi-hd,drive=disk0 \
>  -cpu EPYC-v4 \
>  -bios /home/amd/OVMF.fd \
>  -machine memory-encryption=sev0,vmport=off \
>  -object memory-backend-memfd,id=ram1,size=8G,share=true,prealloc=false \
>  -machine memory-backend=ram1  \
>  -object sev-snp-guest,id=sev0,policy=0xb0000,cbitpos=51,reduced-phys-bits=1 
> \
>  -monitor unix:qemu-monitor-socket,server,nowait \
>  -smp 2 -m 8G -nographic -s \
>  --kernel /home/amd/git/linux/arch/x86/boot/bzImage \
>  --append "verbose debug console=ttyS0,115200n8 earlyprintk=ttyS0,115200 
> log_level=8 keep_bootcon root=/dev/sda1" \
>  --initrd /boot/initrd.img \
>  -no-reboot
>
> The host (& guest) kernel version is a vanilla v6.19, with an Ubuntu based 
> config.
>
> Let me know if there's something you'd like me to test on my AMD EPYC system.
> AFAICT, it fails on all Zens that support SEV-SNP (Zen3+).
>
> Thanks,
>
> Kim
>
>>   system/memory.c | 167 ++++++++++++++++++------------------------------
>>   1 file changed, 61 insertions(+), 106 deletions(-)
>> 
>> diff --git a/system/memory.c b/system/memory.c
>> index 9a12224555..2cda814bd6 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -1568,39 +1568,39 @@ static void memory_region_set_ops(MemoryRegion *mr,
>>       mr->terminates = true;
>>   }
>>   -void memory_region_init_io(MemoryRegion *mr,
>> -                           Object *owner,
>> -                           const MemoryRegionOps *ops,
>> -                           void *opaque,
>> -                           const char *name,
>> -                           uint64_t size)
>> +void memory_region_init_io(MemoryRegion *mr, Object *owner,
>> +                           const MemoryRegionOps *ops, void *opaque,
>> +                           const char *name, uint64_t size)
>>   {
>>       memory_region_init(mr, owner, name, size);
>>       memory_region_set_ops(mr, ops, opaque);
>>   }
>>   -bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>> -                                            Object *owner,
>> -                                            const char *name,
>> -                                            uint64_t size,
>> -                                            uint32_t ram_flags,
>> -                                            Error **errp)
>> +static bool memory_region_set_ram_block(MemoryRegion *mr, RAMBlock *rb)
>>   {
>> -    Error *err = NULL;
>> -    memory_region_init(mr, owner, name, size);
>>       mr->ram = true;
>>       mr->terminates = true;
>>       mr->destructor = memory_region_destructor_ram;
>> -    mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);
>> -    if (err) {
>> +    mr->ram_block = rb;
>> +    if (!rb) {
>>           mr->size = int128_zero();
>>           object_unparent(OBJECT(mr));
>> -        error_propagate(errp, err);
>>           return false;
>>       }
>>       return true;
>>   }
>>   +bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object 
>> *owner,
>> +                                            const char *name, uint64_t 
>> size,
>> +                                            uint32_t ram_flags, Error 
>> **errp)
>> +{
>> +    RAMBlock *rb;
>> +
>> +    memory_region_init(mr, owner, name, size);
>> +    rb = qemu_ram_alloc(size, ram_flags, mr, errp);
>> +    return memory_region_set_ram_block(mr, rb);
>> +}
>> +
>>   bool memory_region_init_resizeable_ram(MemoryRegion *mr,
>>                                          Object *owner,
>>                                          const char *name,
>> @@ -1611,116 +1611,74 @@ bool 
>> memory_region_init_resizeable_ram(MemoryRegion *mr,
>>                                                          void *host),
>>                                          Error **errp)
>>   {
>> -    Error *err = NULL;
>> +    RAMBlock *rb;
>> +
>>       memory_region_init(mr, owner, name, size);
>> -    mr->ram = true;
>> -    mr->terminates = true;
>> -    mr->destructor = memory_region_destructor_ram;
>> -    mr->ram_block = qemu_ram_alloc_resizeable(size, max_size, resized,
>> -                                              mr, &err);
>> -    if (err) {
>> -        mr->size = int128_zero();
>> -        object_unparent(OBJECT(mr));
>> -        error_propagate(errp, err);
>> -        return false;
>> -    }
>> -    return true;
>> +    rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
>> +    return memory_region_set_ram_block(mr, rb);
>>   }
>>     #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
>> -bool memory_region_init_ram_from_file(MemoryRegion *mr,
>> -                                      Object *owner,
>> -                                      const char *name,
>> -                                      uint64_t size,
>> -                                      uint64_t align,
>> -                                      uint32_t ram_flags,
>> -                                      const char *path,
>> -                                      ram_addr_t offset,
>> +bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
>> +                                      const char *name, uint64_t size,
>> +                                      uint64_t align, uint32_t ram_flags,
>> +                                      const char *path, ram_addr_t offset,
>>                                         Error **errp)
>>   {
>> -    Error *err = NULL;
>> +    RAMBlock *rb;
>> +
>>       memory_region_init(mr, owner, name, size);
>> -    mr->ram = true;
>>       mr->readonly = !!(ram_flags & RAM_READONLY);
>> -    mr->terminates = true;
>> -    mr->destructor = memory_region_destructor_ram;
>>       mr->align = align;
>> -    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path,
>> -                                             offset, &err);
>> -    if (err) {
>> -        mr->size = int128_zero();
>> -        object_unparent(OBJECT(mr));
>> -        error_propagate(errp, err);
>> -        return false;
>> -    }
>> -    return true;
>> +    rb = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset, 
>> errp);
>> +    return memory_region_set_ram_block(mr, rb);
>>   }
>>   -bool memory_region_init_ram_from_fd(MemoryRegion *mr,
>> -                                    Object *owner,
>> -                                    const char *name,
>> -                                    uint64_t size,
>> -                                    uint32_t ram_flags,
>> -                                    int fd,
>> -                                    ram_addr_t offset,
>> -                                    Error **errp)
>> +bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
>> +                                    const char *name, uint64_t size,
>> +                                    uint32_t ram_flags, int fd,
>> +                                    ram_addr_t offset, Error **errp)
>>   {
>> -    Error *err = NULL;
>> +    RAMBlock *rb;
>> +
>>       memory_region_init(mr, owner, name, size);
>> -    mr->ram = true;
>>       mr->readonly = !!(ram_flags & RAM_READONLY);
>> -    mr->terminates = true;
>> -    mr->destructor = memory_region_destructor_ram;
>> -    mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, 
>> ram_flags, fd,
>> -                                           offset, false, &err);
>> -    if (err) {
>> -        mr->size = int128_zero();
>> -        object_unparent(OBJECT(mr));
>> -        error_propagate(errp, err);
>> -        return false;
>> -    }
>> -    return true;
>> +    rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, 
>> offset,
>> +                                false, errp);
>> +    return memory_region_set_ram_block(mr, rb);
>>   }
>>   #endif
>>   -void memory_region_init_ram_ptr(MemoryRegion *mr,
>> -                                Object *owner,
>> -                                const char *name,
>> -                                uint64_t size,
>> +void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
>> +                                const char *name, uint64_t size,
>>                                   void *ptr)
>>   {
>> -    memory_region_init(mr, owner, name, size);
>> -    mr->ram = true;
>> -    mr->terminates = true;
>> -    mr->destructor = memory_region_destructor_ram;
>> +    RAMBlock *rb;
>>   +    memory_region_init(mr, owner, name, size);
>>       /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
>>       assert(ptr != NULL);
>> -    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
>> +    rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
>> +    memory_region_set_ram_block(mr, rb);
>>   }
>>   -void memory_region_init_ram_device_ptr(MemoryRegion *mr,
>> -                                       Object *owner,
>> -                                       const char *name,
>> -                                       uint64_t size,
>> +void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
>> +                                       const char *name, uint64_t size,
>>                                          void *ptr)
>>   {
>> +    RAMBlock *rb;
>> +
>>       memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, 
>> size);
>> -    mr->ram = true;
>>       mr->ram_device = true;
>> -    mr->destructor = memory_region_destructor_ram;
>> -
>>       /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
>>       assert(ptr != NULL);
>> -    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
>> +    rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
>> +    memory_region_set_ram_block(mr, rb);
>>   }
>>   -void memory_region_init_alias(MemoryRegion *mr,
>> -                              Object *owner,
>> -                              const char *name,
>> -                              MemoryRegion *orig,
>> -                              hwaddr offset,
>> -                              uint64_t size)
>> +void memory_region_init_alias(MemoryRegion *mr, Object *owner,
>> +                              const char *name, MemoryRegion *orig,
>> +                              hwaddr offset, uint64_t size)
>>   {
>>       memory_region_init(mr, owner, name, size);
>>       mr->alias = orig;
>> @@ -3732,21 +3690,18 @@ bool memory_region_init_rom_device(MemoryRegion 
>> *mr, Object *owner,
>>                                      const char *name, uint64_t size,
>>                                      Error **errp)
>>   {
>> -    Error *err = NULL;
>> +    RAMBlock *rb;
>>         assert(ops);
>>       memory_region_init_io(mr, owner, ops, opaque, name, size);
>> -    mr->rom_device = true;
>> -    mr->destructor = memory_region_destructor_ram;
>> -    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
>> -    if (err) {
>> -        mr->size = int128_zero();
>> -        object_unparent(OBJECT(mr));
>> -        error_propagate(errp, err);
>> -        return false;
>> +    rb = qemu_ram_alloc(size, 0, mr, errp);
>> +    if (memory_region_set_ram_block(mr, rb)) {
>> +        mr->ram = false;
>> +        mr->rom_device = true;
>> +        memory_region_register_ram(mr, owner);
>> +        return true;
>>       }
>> -    memory_region_register_ram(mr, owner);
>> -    return true;
>> +    return false;
>>   }
>>     /*
>
>
--3866299591-850017568-1773359587=:43678--

