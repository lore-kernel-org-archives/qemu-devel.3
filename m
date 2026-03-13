Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10EF106FD66
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 03:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0tKb-0000YQ-Tz; Thu, 12 Mar 2026 23:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1w0tKa-0000YF-8D
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:36:56 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1w0tKX-0007Fr-Ie
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773373014; x=1804909014;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=z+NS8UdiPGQMOY4j+7jUUcnnFzucf28XlBuMEsPh0ZU=;
 b=OYFtgXMjwhFZzfh6JaiEZGff2xnGCppW4l7jQPailwzMxMaHmN0o6/ak
 pDAPLEU3sGnTvT1fsD883AgpwdPzOMRvJHwlZC9dys5UmOrL8mFTTlY+4
 4r01LuAPvdLH29yKg6GHUqtDazlCBFhgJsZ0MDQwWZWCsAYL2XTscPZqS
 AMade1uCwnpfgGxD8b5zCnRKE1BIIakAM/dhlHP9tFCu3Qwi0ylJY9wXV
 tzXcWJThenkCiANkgZ9hUxcMELA8d0sR8FjsALXojB6d82ZEFndoMoujq
 RdLWCy8NyJDkQwolPk6jYuSrzPI9fsmQU7zcocd2F6Cb7jAOsj4ntgybh Q==;
X-CSE-ConnectionGUID: r7dFz7YESI2cACBsGJb/lQ==
X-CSE-MsgGUID: D/ziWcdUQl68ZRZL1FJnQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74374394"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="74374394"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 20:36:51 -0700
X-CSE-ConnectionGUID: U1a/0BGvRoGSYghP7za7+g==
X-CSE-MsgGUID: T3ki7pdIQFWTat0fcUWRfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="258943664"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.178])
 ([10.124.240.178])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 20:36:49 -0700
Message-ID: <7edbc92d-095c-4cfd-b5d3-102eee092b13@intel.com>
Date: Fri, 13 Mar 2026 11:36:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: Set mr->ram before RAM Block allocation
To: BALATON Zoltan <balaton@eik.bme.hu>, Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 chenyi.qiang@intel.com, Farrah Chen <farrah.chen@intel.com>,
 qemu-devel@nongnu.org
References: <20260312063420.973637-1-xiaoyao.li@intel.com>
 <abLf8EW3M7XCBh2K@x1.local> <92fcc6f0-655f-5726-1758-b2429911f0d8@eik.bme.hu>
 <abMIgThCxU1gnMqZ@x1.local> <9594f358-2ef9-08da-355b-69496c6abb0a@eik.bme.hu>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <9594f358-2ef9-08da-355b-69496c6abb0a@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 3/13/2026 2:50 AM, BALATON Zoltan wrote:
> On Thu, 12 Mar 2026, Peter Xu wrote:
>> On Thu, Mar 12, 2026 at 07:04:06PM +0100, BALATON Zoltan wrote:
>>> On Thu, 12 Mar 2026, Peter Xu wrote:
>>>> On Thu, Mar 12, 2026 at 02:34:20PM +0800, Xiaoyao Li wrote:
>>>>> Commit 2fb627ef2f48 ("memory: Factor out common ram region 
>>>>> initialization")
>>>>> introduced a helper function memory_region_set_ram_block(), which 
>>>>> causes
>>>>> mr->ram to be set to true after the RAM Block allocation by
>>>>> qemu_ram_alloc_*().
>>>>>
>>>>> It leads to the assertion
>>>>>
>>>>>   g_assert(memory_region_is_ram(mr));
>>>>>
>>>>> in memory_region_set_ram_discard_manager() being triggered when 
>>>>> creating
>>>>> RAM Block with the RAM_GUEST_MEMFD flag.
>>>>>
>>>>> Fix this by restoring the original behavior of setting mr->ram before
>>>>> RAM Block allocation.
>>>>>
>>>>> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3330
>>>>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>>>>> Fixes: 2fb627ef2f48 ("memory: Factor out common ram region 
>>>>> initialization")
>>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>
>>>> Thanks for the report.  This is fast..
>>>>
>>>> Almost agreed with the fix, except that it duplicates the lines all 
>>>> over
>>>> the places.  Would it be better to introduce memory_region_init_ram()?
>>>
>>> First sorry for breaking this, I checked that qemu_alloc_ram did not 
>>> refer
>>> to these fields but missed this use much deeper in the call stack. The
>>> memory_region_init_ram name is already taken so can't call it like that.
>>> Since all the different memory_region_init variants call different
>>> qemu_ram_alloc variants there does not seem to be a way to set this 
>>> without
>>> addining an additional line. Previous versions of the series had
>>> memory_region_setup_ram() that set these mr fields then 
>>> qemu_alloc_ram and
>>> then error_propagate was called last. We could bring back
>>> memory_region_setup_ram but it's the same additional line everywhere 
>>> so this
>>> seems to be a simpler fix. I don't see a way to avoid this 
>>> duplication other
>>> than maybe changing qemu_ram_alloc to put it somehow within that but 
>>> that
>>> does not seem to be simple. I can try to think about it some more but 
>>> so far
>>> I could not find a simpler fix.
>>
>> We can call it memory_region_init_ram_internal(), or something else.
>>
>> The point is to avoid duplicating the same line all over again.. with 
>> these
>> call sites s/memory_region_init/$NEW_NAME/ where $NEW_NAME set ram=true.
> 
> The point of refactoring was to make memory_region_init on it's own line 
> so it can be replaced with memory_region_new in the follow up series. 
> You can introduce a new function that does init+setup some fields and do 
> the same for new+setup some fields but not sure that's worth it.
> 
> I don't think it would save much lines in the end. This patch adds 6 
> lines. Your proposed function would take at least 5 (or 6 with empty 
> line after) 

> and bring back the mr->ram=false in the romd case 

For romd case, it's not affected since it uses memory_region_init_io().

However, the ram device is affected that is also uses 
memory_region_init_io() which will not be covered by the helper.

Diff attached below. I doubt it is better/simpler than my original fix 
because memory_region_init_ram_device_ptr() still requires the separate

	mr->ram = true;


diff --git a/system/memory.c b/system/memory.c
index 17a7bcd9af7c..1878d4aa843a 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1576,9 +1576,15 @@ void memory_region_init_io(MemoryRegion *mr, 
Object *owner,
      memory_region_set_ops(mr, ops, opaque);
  }

+static void memory_region_init_ram_internal(MemoryRegion *mr, Object 
*owner,
+                                            const char *name, uint64_t 
size)
+{
+    memory_region_init(mr, owner, name, size);
+    mr->ram = true;
+}
+
  static bool memory_region_set_ram_block(MemoryRegion *mr, RAMBlock *rb)
  {
-    mr->ram = true;
      mr->terminates = true;
      mr->destructor = memory_region_destructor_ram;
      mr->ram_block = rb;
@@ -1596,7 +1602,7 @@ bool 
memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
  {
      RAMBlock *rb;

-    memory_region_init(mr, owner, name, size);
+    memory_region_init_ram_internal(mr, owner, name, size);
      rb = qemu_ram_alloc(size, ram_flags, mr, errp);
      return memory_region_set_ram_block(mr, rb);
  }
@@ -1613,7 +1619,7 @@ bool 
memory_region_init_resizeable_ram(MemoryRegion *mr,
  {
      RAMBlock *rb;

-    memory_region_init(mr, owner, name, size);
+    memory_region_init_ram_internal(mr, owner, name, size);
      rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
      return memory_region_set_ram_block(mr, rb);
  }
@@ -1627,7 +1633,7 @@ bool memory_region_init_ram_from_file(MemoryRegion 
*mr, Object *owner,
  {
      RAMBlock *rb;

-    memory_region_init(mr, owner, name, size);
+    memory_region_init_ram_internal(mr, owner, name, size);
      mr->readonly = !!(ram_flags & RAM_READONLY);
      mr->align = align;
      rb = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset, 
errp);
@@ -1641,7 +1647,7 @@ bool memory_region_init_ram_from_fd(MemoryRegion 
*mr, Object *owner,
  {
      RAMBlock *rb;

-    memory_region_init(mr, owner, name, size);
+    memory_region_init_ram_internal(mr, owner, name, size);
      mr->readonly = !!(ram_flags & RAM_READONLY);
      rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, 
offset,
                                  false, errp);
@@ -1662,7 +1668,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr, 
Object *owner,
                                  const char *name, uint64_t size,
                                  void *ptr)
  {
-    memory_region_init(mr, owner, name, size);
+    memory_region_init_ram_internal(mr, owner, name, size);
      memory_region_set_ram_ptr(mr, size, ptr);
  }

@@ -1671,6 +1677,7 @@ void 
memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
                                         void *ptr)
  {
      memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
+    mr->ram = true;
      mr->ram_device = true;
      memory_region_set_ram_ptr(mr, size, ptr);
  }
@@ -3699,7 +3706,6 @@ bool memory_region_init_rom_device(MemoryRegion 
*mr, Object *owner,
      memory_region_init_io(mr, owner, ops, opaque, name, size);
      rb = qemu_ram_alloc(size, 0, mr, errp);
      if (memory_region_set_ram_block(mr, rb)) {
-        mr->ram = false;
          mr->rom_device = true;
          memory_region_register_ram(mr, owner);
          return true;

> so at the 
> end it's about 1 line difference and may even be longer that way. I 
> don't like the duplication either but the alternatives don't seem to be 
> less lines or simpler either.
> 
> But at the end it's your decision so do what you think is better.
> 
> Regards,
> BALATON Zoltan


