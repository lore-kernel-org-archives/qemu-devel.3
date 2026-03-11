Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837A3FCC9B1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 06:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Cf7-00030Y-6e; Wed, 11 Mar 2026 02:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w0Cf5-0002zr-8D; Wed, 11 Mar 2026 02:03:15 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w0Cf1-0000RF-EM; Wed, 11 Mar 2026 02:03:14 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62B628Nt065995
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 11 Mar 2026 15:02:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Gq84KcuthkR85EwZsQAdZjPBPNAvSQUW+eLJxTU94Hg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1773208937; v=1;
 b=PjHspEPmqa/ZhtvRQ80HuNHHke6xmrDLPIlMG+rtAXKsX6JJPff0/Lp7WmCoY8Kt
 +tyB8Pvf2IdrzUEAuXQsCB7+WoO62LXeKpjozVHnJZ9Jc0iWAecsPbE0/+HaQFBT
 +L1cHajrehJFIaP4E0agRmv8Nz63gm6DPCxyd+ZSrA0XZWGQvO9dlMTrY3gAIRum
 mCkuSHueiROb4G8hx/4PLYOLhHK/KPRabiE5PDHWmzo1i1LBfpU+Ro6iRlCos4ly
 TqsCGBj+3bgCjvpAB08VYLXaPewXYlvYr8pZK9+1vdhfzbIXl2yktRQX/EnToAyl
 YrPn4sUxo1ezhBYjkeYBbA==
Message-ID: <f4fa986c-b7d7-4784-a846-ccf58a33a87f@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 11 Mar 2026 15:02:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] vmapple: apple-gfx: make it work on the latest
 macOS release
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>
References: <20260306145246.10274-1-mohamed@unpredictable.fr>
 <20260306145246.10274-2-mohamed@unpredictable.fr>
 <8908689a-f5c1-490e-925d-7a664093963f@rsg.ci.i.u-tokyo.ac.jp>
 <a24c76d0-4106-4d49-b032-35f7f6310e69@linaro.org>
 <f94bebf5-a452-46cf-ad46-acb71c619917@rsg.ci.i.u-tokyo.ac.jp>
 <abBE6NuYJIJgM0rj@x1.local>
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <abBE6NuYJIJgM0rj@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On 2026/03/11 1:20, Peter Xu wrote:
> On Tue, Mar 10, 2026 at 03:55:41PM +0900, Akihiko Odaki wrote:
>> On 2026/03/10 7:21, Philippe Mathieu-Daudé wrote:
>>> +Peter/Paolo
>>>
>>> On 7/3/26 04:08, Akihiko Odaki wrote:
>>>> On 2026/03/06 23:52, Mohamed Mediouni wrote:
>>>>> Follow changes in memory management introduced on macOS 15.4.
>>>>>
>>>>> The legacy memory management API has been removed for the
>>>>> IOSurface mapper on that macOS version.
>>>>>
>>>>> Also enable process isolation for a sandboxed GPU process when
>>>>> on a new OS.
>>>>>
>>>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>>>> ---
>>>>>    hw/display/apple-gfx-mmio.m | 62 ++++++++++++++++++++++++++++---------
>>>>>    hw/display/apple-gfx.h      | 18 +++++++++++
>>>>>    hw/display/apple-gfx.m      | 43 ++++++++++++++++++++++++-
>>>>>    3 files changed, 107 insertions(+), 16 deletions(-)
>>>
>>>
>>>>> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
>>>>> index e0a765fcb1..92404d20bf 100644
>>>>> --- a/hw/display/apple-gfx.m
>>>>> +++ b/hw/display/apple-gfx.m
>>>>> @@ -21,6 +21,7 @@
>>>>>    #include "system/address-spaces.h"
>>>>>    #include "system/dma.h"
>>>>>    #include "migration/blocker.h"
>>>>> +#include "system/memory.h"
>>>>>    #include "ui/console.h"
>>>>>    #include "apple-gfx.h"
>>>>>    #include "trace.h"
>>>>> @@ -596,6 +597,37 @@ void apple_gfx_common_init(Object *obj,
>>>>> AppleGFXState *s, const char* obj_name)
>>>>>        /* TODO: PVG framework supports serialising device state:
>>>>> integrate it! */
>>>>>    }
>>>>> +@interface PGDeviceDescriptor (IOSurfaceMapper)
>>>>> +@property (readwrite, nonatomic, copy, nullable)
>>>>> PGMemoryMapDescriptor* memoryMapDescriptor;
>>>>> +@end
>>>>> +
>>>>> +bool apple_gfx_register_memory_cb(Int128 start, Int128 len,
>>>>> +                                  const MemoryRegion *mr_const,
>>>>> +                                  hwaddr offset_in_region, void
>>>>> *opaque) {
>>>>> +    MemoryRegion *mr = (MemoryRegion *)mr_const;
>>>>
>>>> flatview_for_each_range() should be changed to pass non-const
>>>> pointers instead.
>>>
>>> flatview_for_each_range() was added in commit fb5ef4eeecd ("memory: Add
>>> FlatView foreach function") with memory fuzzing in mind, so const MR was
>>> the correct choice then IMO.
>>>
>>> FlatView is more of an internal memory API, I'm not sure it should be
>>> used by hw/ layer.
>>>
>>> $ git grep -w flatview_for_each_range
>>> hw/core/loader.c:1656:    flatview_for_each_range(fv, find_rom_cb,
>>> &cbdata);
>>> semihosting/arm-compat-semi.c:158:    flatview_for_each_range(fv,
>>> find_ram_cb, &info);
>>> tests/qtest/fuzz/generic_fuzz.c:310: flatview_for_each_range(view,
>>> get_io_address_cb , &cb_info);
>>>
>>> Semihosting is special, as it the ROM loader helper, and fuzzing code.
>>>
>>>
>>> We provide MemoryRegionSection, MemoryListener and RamDiscardListener
>>> APIs. Maybe one of them is more appropriate here? See:
>>>
>>>    * A #RamDiscardManager coordinates which parts of specific RAM
>>>    * #MemoryRegion regions are currently populated to be used/accessed
>>>    * by the VM, notifying after parts were discarded (freeing up memory)
>>>    * and before parts will be populated (consuming memory), to be used/
>>>    * accessed by the VM.
>>>
>>> Could this be what this code needs to do?
>>
>> The problem here is that the reverse-engineered interface is insufficient to
>> keep the memory map synchronized so it can only populate the memory map
>> during initialization. flatview_for_each_range() fits for this purpose.
>>
>> Ideally the interface may be reverse-engineered more thoroughly to
>> synchronize the memory map at runtime but that needs more work.
> 
> IIUC we could still use memory_listener_register(), and I agree with Phil
> it might be good to avoid exporting flatview API further to hw/ if ever
> possible.
> 
> memory_listener_register() will properly replay all the memory regions
> similarly when adding the new listener, via region_add().

That makes a point but calling memory_listener_register() and 
memory_listener_unregister() immediately after that (since we don't want 
be notified for future updates) is a bit weird.

It's practically not a problem, so if Phil agrees with using 
memory_listener_register() then I guess it's the way to go.

Regards,
Akihiko Odaki

