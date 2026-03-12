Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5972C106ACDB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0l7R-0007iN-5E; Thu, 12 Mar 2026 14:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w0l7P-0007i3-0y
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:50:47 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w0l7N-0004fm-8Z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:50:46 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B6A2F5969EA;
 Thu, 12 Mar 2026 19:50:41 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id FeQ231G4RsOc; Thu, 12 Mar 2026 19:50:39 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 504E35969EB; Thu, 12 Mar 2026 19:50:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4EA525966F4;
 Thu, 12 Mar 2026 19:50:39 +0100 (CET)
Date: Thu, 12 Mar 2026 19:50:39 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Xu <peterx@redhat.com>
cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 chenyi.qiang@intel.com, Farrah Chen <farrah.chen@intel.com>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH] memory: Set mr->ram before RAM Block allocation
In-Reply-To: <abMIgThCxU1gnMqZ@x1.local>
Message-ID: <9594f358-2ef9-08da-355b-69496c6abb0a@eik.bme.hu>
References: <20260312063420.973637-1-xiaoyao.li@intel.com>
 <abLf8EW3M7XCBh2K@x1.local> <92fcc6f0-655f-5726-1758-b2429911f0d8@eik.bme.hu>
 <abMIgThCxU1gnMqZ@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

On Thu, 12 Mar 2026, Peter Xu wrote:
> On Thu, Mar 12, 2026 at 07:04:06PM +0100, BALATON Zoltan wrote:
>> On Thu, 12 Mar 2026, Peter Xu wrote:
>>> On Thu, Mar 12, 2026 at 02:34:20PM +0800, Xiaoyao Li wrote:
>>>> Commit 2fb627ef2f48 ("memory: Factor out common ram region initialization")
>>>> introduced a helper function memory_region_set_ram_block(), which causes
>>>> mr->ram to be set to true after the RAM Block allocation by
>>>> qemu_ram_alloc_*().
>>>>
>>>> It leads to the assertion
>>>>
>>>>   g_assert(memory_region_is_ram(mr));
>>>>
>>>> in memory_region_set_ram_discard_manager() being triggered when creating
>>>> RAM Block with the RAM_GUEST_MEMFD flag.
>>>>
>>>> Fix this by restoring the original behavior of setting mr->ram before
>>>> RAM Block allocation.
>>>>
>>>> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3330
>>>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>>>> Fixes: 2fb627ef2f48 ("memory: Factor out common ram region initialization")
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>
>>> Thanks for the report.  This is fast..
>>>
>>> Almost agreed with the fix, except that it duplicates the lines all over
>>> the places.  Would it be better to introduce memory_region_init_ram()?
>>
>> First sorry for breaking this, I checked that qemu_alloc_ram did not refer
>> to these fields but missed this use much deeper in the call stack. The
>> memory_region_init_ram name is already taken so can't call it like that.
>> Since all the different memory_region_init variants call different
>> qemu_ram_alloc variants there does not seem to be a way to set this without
>> addining an additional line. Previous versions of the series had
>> memory_region_setup_ram() that set these mr fields then qemu_alloc_ram and
>> then error_propagate was called last. We could bring back
>> memory_region_setup_ram but it's the same additional line everywhere so this
>> seems to be a simpler fix. I don't see a way to avoid this duplication other
>> than maybe changing qemu_ram_alloc to put it somehow within that but that
>> does not seem to be simple. I can try to think about it some more but so far
>> I could not find a simpler fix.
>
> We can call it memory_region_init_ram_internal(), or something else.
>
> The point is to avoid duplicating the same line all over again.. with these
> call sites s/memory_region_init/$NEW_NAME/ where $NEW_NAME set ram=true.

The point of refactoring was to make memory_region_init on it's own line 
so it can be replaced with memory_region_new in the follow up series. You 
can introduce a new function that does init+setup some fields and do the 
same for new+setup some fields but not sure that's worth it.

I don't think it would save much lines in the end. This patch adds 6 
lines. Your proposed function would take at least 5 (or 6 with empty line 
after) and bring back the mr->ram=false in the romd case so at the end 
it's about 1 line difference and may even be longer that way. I don't like 
the duplication either but the alternatives don't seem to be less lines or 
simpler either.

But at the end it's your decision so do what you think is better.

Regards,
BALATON Zoltan

