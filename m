Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B785F106ACD9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0kzc-0006Dj-7d; Thu, 12 Mar 2026 14:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w0kza-0006DU-Fe
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:42:42 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w0kzT-0002Yn-U4
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:42:38 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 192B6596D8B;
 Thu, 12 Mar 2026 19:42:30 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id l025XxY9ZUfr; Thu, 12 Mar 2026 19:42:27 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B64EA596D8C; Thu, 12 Mar 2026 19:42:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B46BD596D8D;
 Thu, 12 Mar 2026 19:42:27 +0100 (CET)
Date: Thu, 12 Mar 2026 19:42:27 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Xu <peterx@redhat.com>
cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 chenyi.qiang@intel.com, Farrah Chen <farrah.chen@intel.com>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH] memory: Set mr->ram before RAM Block allocation
In-Reply-To: <92fcc6f0-655f-5726-1758-b2429911f0d8@eik.bme.hu>
Message-ID: <5cdd055c-eadb-0b67-8093-b4ec1236a4e2@eik.bme.hu>
References: <20260312063420.973637-1-xiaoyao.li@intel.com>
 <abLf8EW3M7XCBh2K@x1.local> <92fcc6f0-655f-5726-1758-b2429911f0d8@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Thu, 12 Mar 2026, BALATON Zoltan wrote:
> On Thu, 12 Mar 2026, Peter Xu wrote:
>> On Thu, Mar 12, 2026 at 02:34:20PM +0800, Xiaoyao Li wrote:
>>> Commit 2fb627ef2f48 ("memory: Factor out common ram region 
>>> initialization")
>>> introduced a helper function memory_region_set_ram_block(), which causes
>>> mr->ram to be set to true after the RAM Block allocation by
>>> qemu_ram_alloc_*().
>>> 
>>> It leads to the assertion
>>>
>>>   g_assert(memory_region_is_ram(mr));
>>> 
>>> in memory_region_set_ram_discard_manager() being triggered when creating
>>> RAM Block with the RAM_GUEST_MEMFD flag.
>>> 
>>> Fix this by restoring the original behavior of setting mr->ram before
>>> RAM Block allocation.
>>> 
>>> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3330
>>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>>> Fixes: 2fb627ef2f48 ("memory: Factor out common ram region 
>>> initialization")
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> 
>> Thanks for the report.  This is fast..
>> 
>> Almost agreed with the fix, except that it duplicates the lines all over
>> the places.  Would it be better to introduce memory_region_init_ram()?
>
> First sorry for breaking this, I checked that qemu_alloc_ram did not refer to 
> these fields but missed this use much deeper in the call stack. The 
> memory_region_init_ram name is already taken so can't call it like that. 
> Since all the different memory_region_init variants call different 
> qemu_ram_alloc variants there does not seem to be a way to set this without 
> addining an additional line. Previous versions of the series had 
> memory_region_setup_ram() that set these mr fields then qemu_alloc_ram and 
> then error_propagate was called last. We could bring back 
> memory_region_setup_ram but it's the same additional line everywhere so this 
> seems to be a simpler fix. I don't see a way to avoid this duplication other 
> than maybe changing qemu_ram_alloc to put it somehow within that but that 
> does not seem to be simple. I can try to think about it some more but so far 
> I could not find a simpler fix.

It seems the assert happens when called with RAM_GUEST_MEMFD flag so maybe 
some of these that can't pass this flag would not need setting it before 
the qemu_ram_alloc call but it may be hard to tell which ones need it so 
doing consistently seems better. If we allow qemu_ram_alloc to set this 
when needed we could move it there but that's too much change for bugfix.

The qemu_alloc_ram* functions from physmem.c seem to be closely entangled 
with memory.c and nothing seems to call these functions outside of 
memory.c so some refactoring may allow to unexport this API and make it 
static or simplify it further but that seems to be a bigger refactoring 
and I don't know why these were separate in the first place. Maybe memory 
regions were added as an additional layer on top of physmem?

For now as a bugfix this seems to be the simplest way.

Regards,
BALATON Zoltan

>>> ---
>>>  system/memory.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/system/memory.c b/system/memory.c
>>> index 17a7bcd9af7c..56f3225b21ad 100644
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -1578,7 +1578,6 @@ void memory_region_init_io(MemoryRegion *mr, Object 
>>> *owner,
>>>
>>>  static bool memory_region_set_ram_block(MemoryRegion *mr, RAMBlock *rb)
>>>  {
>>> -    mr->ram = true;
>>>      mr->terminates = true;
>>>      mr->destructor = memory_region_destructor_ram;
>>>      mr->ram_block = rb;
>>> @@ -1597,6 +1596,7 @@ bool 
>>> memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
>>>      RAMBlock *rb;
>>>
>>>      memory_region_init(mr, owner, name, size);
>>> +    mr->ram = true;
>>>      rb = qemu_ram_alloc(size, ram_flags, mr, errp);
>>>      return memory_region_set_ram_block(mr, rb);
>>>  }
>>> @@ -1614,6 +1614,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion 
>>> *mr,
>>>      RAMBlock *rb;
>>>
>>>      memory_region_init(mr, owner, name, size);
>>> +    mr->ram = true;
>>>      rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
>>>      return memory_region_set_ram_block(mr, rb);
>>>  }
>>> @@ -1628,6 +1629,7 @@ bool memory_region_init_ram_from_file(MemoryRegion 
>>> *mr, Object *owner,
>>>      RAMBlock *rb;
>>>
>>>      memory_region_init(mr, owner, name, size);
>>> +    mr->ram = true;
>>>      mr->readonly = !!(ram_flags & RAM_READONLY);
>>>      mr->align = align;
>>>      rb = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset, 
>>> errp);
>>> @@ -1642,6 +1644,7 @@ bool memory_region_init_ram_from_fd(MemoryRegion 
>>> *mr, Object *owner,
>>>      RAMBlock *rb;
>>>
>>>      memory_region_init(mr, owner, name, size);
>>> +    mr->ram = true;
>>>      mr->readonly = !!(ram_flags & RAM_READONLY);
>>>      rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, 
>>> offset,
>>>                                  false, errp);
>>> @@ -1663,6 +1666,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr, 
>>> Object *owner,
>>>                                  void *ptr)
>>>  {
>>>      memory_region_init(mr, owner, name, size);
>>> +    mr->ram = true;
>>>      memory_region_set_ram_ptr(mr, size, ptr);
>>>  }
>>> 
>>> @@ -1671,6 +1675,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion 
>>> *mr, Object *owner,
>>>                                         void *ptr)
>>>  {
>>>      memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, 
>>> size);
>>> +    mr->ram = true;
>>>      mr->ram_device = true;
>>>      memory_region_set_ram_ptr(mr, size, ptr);
>>>  }
>>> @@ -3699,7 +3704,6 @@ bool memory_region_init_rom_device(MemoryRegion *mr, 
>>> Object *owner,
>>>      memory_region_init_io(mr, owner, ops, opaque, name, size);
>>>      rb = qemu_ram_alloc(size, 0, mr, errp);
>>>      if (memory_region_set_ram_block(mr, rb)) {
>>> -        mr->ram = false;
>>>          mr->rom_device = true;
>>>          memory_region_register_ram(mr, owner);
>>>          return true;
>>> --
>>> 2.43.0
>>> 
>> 
>> 
>
>

