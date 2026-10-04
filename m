Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8C1CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 06:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDFee-0002AM-3t; Sun, 04 Oct 2026 02:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xDFeb-0002A2-CI; Sun, 04 Oct 2026 02:24:57 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xDFeX-00010A-Pn; Sun, 04 Oct 2026 02:24:57 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6946OOdG021541
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 4 Oct 2026 15:24:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TxbyWlk5Vumq+bIW+30V60zKdk6SZLC88VvGqHRJdAs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791095064; v=1;
 b=rwsMG2388kuy6CM5LSX5b6eKWr1Qf/FAQp0W6GlLihnGMoKCfXdkcfpX4Frn+G9C
 f6Ys4c4+JEPYZ9vVJwPUFR3mFuzGdspV8KseSuAQsbVodp/aj13Zw/Eo1LrPOZc2
 YQy2L4EWw0LtpaWTwPvjR/J9Gc5MDgTlaOnjLISYZdEIgpeTF7k34BnhXKavHiBP
 ei2yXUxxgJFiFXTEvWtZEVKPde7xWbLDYBH4uRiHfMYGDmqiWYef6wytYUcP+c+y
 96SZdIhumZamLrM+hjTMFAKt53YK6Kk5dnMAEkL2d072oTxAsQexdwDY21poStN4
 shGuYK2IBEi1dcGXzAOzlQ==
Message-ID: <2abee80a-430a-4025-a898-006acc03cdd4@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 4 Oct 2026 15:24:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 05/10] vmapple: apple-gfx: make it work on the
 latest macOS release
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
 <20260916100021.73825-6-mohamed@unpredictable.fr>
 <47a7ca78-0dca-4469-9366-3a95e48e61a5@rsg.ci.i.u-tokyo.ac.jp>
 <3AF6E5B2-88AE-467A-B8C3-1D98948C3944@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3AF6E5B2-88AE-467A-B8C3-1D98948C3944@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/09/18 6:49, Mohamed Mediouni wrote:
> 
> 
>> On 17. Sep 2026, at 22:37, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/09/16 19:00, Mohamed Mediouni wrote:
>>> Follow changes in memory management introduced on macOS 15.4.
>>> The legacy memory management API has been removed for the IOSurface mapper on that macOS version.
>>> Also enable process isolation for a sandboxed GPU process when on a new OS.
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> ---
>>>   hw/display/apple-gfx-mmio.m | 58 ++++++++++++++++++------
>>>   hw/display/apple-gfx.h      | 16 +++++++
>>>   hw/display/apple-gfx.m      | 90 ++++++++++++++++++++++++++++++++-----
>>>   3 files changed, 138 insertions(+), 26 deletions(-)
>>> diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
>>> index 58beaadd1f..19e2d38a1e 100644
>>> --- a/hw/display/apple-gfx-mmio.m
>>> +++ b/hw/display/apple-gfx-mmio.m
>>> @@ -19,6 +19,7 @@
>>>   #include "hw/core/irq.h"
>>>   #include "apple-gfx.h"
>>>   #include "trace.h"
>>> +#include "system/address-spaces.h"
>>>     #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
>>>   @@ -36,12 +37,19 @@ typedef bool(^IOSFCMapMemory)(uint64_t phys, uint64_t len, bool ro, void **va,
>>>     @interface PGDeviceDescriptor (IOSurfaceMapper)
>>>   @property (readwrite, nonatomic) bool usingIOSurfaceMapper;
>>> +@property (readwrite, nonatomic) bool enableArgumentBuffers;
>>> +@property (readwrite, nonatomic) bool enableProcessIsolation;
>>> +@property (readwrite, nonatomic) bool enableProtectedContent;
>>> +
>>> +@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
>>>   @end
>>>     @interface PGIOSurfaceHostDeviceDescriptor : NSObject
>>>   -(PGIOSurfaceHostDeviceDescriptor *)init;
>>>   @property (readwrite, nonatomic, copy, nullable) IOSFCMapMemory mapMemory;
>>>   @property (readwrite, nonatomic, copy, nullable) IOSFCUnmapMemory unmapMemory;
>>> +@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
>>> +@property (readwrite, nonatomic) unsigned long long mmioLength;
>>>   @property (readwrite, nonatomic, copy, nullable) IOSFCRaiseInterrupt raiseInterrupt;
>>>   @end
>>>   @@ -183,19 +191,32 @@ static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
>>>           [PGIOSurfaceHostDeviceDescriptor new];
>>>       PGIOSurfaceHostDevice *iosfc_host_dev;
>>>   -    iosfc_desc.mapMemory =
>>> -        ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
>>> -            *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
>>> -
>>> -            trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
>>> -
>>> -            return *va != NULL;
>>> -        };
>>> -
>>> -    iosfc_desc.unmapMemory =
>>> -        ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
>>> -            return apple_gfx_mmio_unmap_surface_memory(va);
>>> -        };
>>> +    /*
>>> +     * The legacy memory management API is no longer present
>>> +     * for the IOSurface mapper as of macOS 15.4.
>>> +     */
>>> +    if (@available(macOS 15.4, *)) {
>>> +        PGMemoryMapDescriptor *memory_map_descriptor = [PGMemoryMapDescriptor new];
>>> +        FlatView* fv = address_space_to_flatview(&address_space_memory);
>>> +        flatview_for_each_range(fv, apple_gfx_register_memory_cb, memory_map_descriptor);
>>> +        /* the device model defines this as a single-page MMIO region, hence 16KB */
>>> +        iosfc_desc.mmioLength = 0x10000;
>>> +        iosfc_desc.memoryMapDescriptor = memory_map_descriptor;
>>> +    } else {
>>> +        iosfc_desc.mapMemory =
>>> +            ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
>>> +                *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
>>> +
>>> +                trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
>>> +
>>> +                return *va != NULL;
>>> +            };
>>> +
>>> +        iosfc_desc.unmapMemory =
>>> +            ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
>>> +                return apple_gfx_mmio_unmap_surface_memory(va);
>>> +            };
>>> +    }
>>>         iosfc_desc.raiseInterrupt = ^bool(uint32_t vector) {
>>>           trace_apple_gfx_iosfc_raise_irq(vector);
>>> @@ -223,13 +244,22 @@ static void apple_gfx_mmio_realize(DeviceState *dev, Error **errp)
>>>           };
>>>             desc.usingIOSurfaceMapper = true;
>>> -        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
>>> +        /*
>>> +         * Process isolation needs PGMemoryMapDescriptor instead of
>>> +         * the legacy memory management interface present in releases
>>> +         * older than macOS 15.4.
>>> +         */
>>> +        if (@available(macOS 15.4, *)) {
>>> +            desc.enableProcessIsolation = true;
>>> +        }
>>>             if (!apple_gfx_common_realize(&s->common, dev, desc, errp)) {
>>>               [s->pgiosfc release];
>>>               s->pgiosfc = nil;
>>>           }
>>>   +        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
>>> +
>>>           [desc release];
>>>           desc = nil;
>>>       }
>>> diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
>>> index 3197bd853d..384aee0c5f 100644
>>> --- a/hw/display/apple-gfx.h
>>> +++ b/hw/display/apple-gfx.h
>>> @@ -12,6 +12,7 @@
>>>   #include "system/memory.h"
>>>   #include "hw/core/qdev-properties.h"
>>>   #include "ui/surface.h"
>>> +#include "objc/NSObject.h"
>>>     #define TYPE_APPLE_GFX_MMIO         "apple-gfx-mmio"
>>>   #define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
>>> @@ -23,6 +24,17 @@
>>>   @protocol MTLTexture;
>>>   @protocol MTLCommandQueue;
>>>   +typedef struct PGGuestPhysicalRange_s
>>> +{
>>> +    uint64_t physicalAddress;
>>> +    uint64_t physicalLength;
>>> +    void *hostAddress;
>>> +} PGGuestPhysicalRange_t;
>>> +
>>> +@interface PGMemoryMapDescriptor : NSObject
>>> +-(void)addRange:(PGGuestPhysicalRange_t) range;
>>> +@end
>>> +
>>>   typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
>>>     typedef struct AppleGFXDisplayMode {
>>> @@ -68,6 +80,10 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
>>>                                          uint64_t length, bool read_only,
>>>                                          MemoryRegion **mapping_in_region);
>>>   +bool apple_gfx_register_memory_cb(Int128 start, Int128 len,
>>> +                                  const MemoryRegion *mr,
>>> +                                  hwaddr offset_in_region, void *opaque);
>>> +
>>>   extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
>>>     #endif
>>> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
>>> index be0061b9db..4ef8f6dbf3 100644
>>> --- a/hw/display/apple-gfx.m
>>> +++ b/hw/display/apple-gfx.m
>>> @@ -21,6 +21,7 @@
>>>   #include "system/address-spaces.h"
>>>   #include "system/dma.h"
>>>   #include "migration/blocker.h"
>>> +#include "system/memory.h"
>>>   #include "ui/console.h"
>>>   #include "apple-gfx.h"
>>>   #include "trace.h"
>>> @@ -79,6 +80,7 @@ static dispatch_queue_t get_background_queue(void)
>>>       GPtrArray *mapped_regions;
>>>   };
>>>   +API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, 27.0))
>>
>> git am detected trailing whitespaces:
>>
>> $ b4 shazam 20260916100021.73825-1-mohamed@unpredictable.fr
>> Looking up 20260916100021.73825-1-mohamed@unpredictable.fr
>> Checking for newer revisions
>> Grabbing search results from lore.kernel.org
>> Analyzing 15 messages in the thread
>> Looking for additional code-review trailers on lore.kernel.org
>> Analyzing 94 code-review messages
>> Checking attestation on all messages, may take a moment...
>> ---
>>   ✓ [PATCH RFC v8 1/10] target/arm/emulate: add ISV=0 emulation library with load/store immediate
>>   ✓ [PATCH RFC v8 2/10] target/arm/emulate: add load/store register offset
>>   ✓ [PATCH RFC v8 3/10] target/arm/emulate: add load/store pair
>>   ✓ [PATCH RFC v8 4/10] target/arm/hvf, whpx: wire ISV=0 emulation for data aborts
>>   ✓ [PATCH RFC v8 5/10] vmapple: apple-gfx: make it work on the latest macOS release
>>   ✓ [PATCH RFC v8 6/10] hw/vmapple: aes: convert MAX_LEN to a #define
>>   ✓ [PATCH RFC v8 7/10] Revert "hw/arm: Do not build VMapple machine by default"
>>   ✓ [PATCH RFC v8 8/10] vmapple: add gicv2m
>>   ✓ [PATCH RFC v8 9/10] vmapple, gicv2m: add macOS compat quirk
>>   ✓ [PATCH RFC v8 10/10] hw/vmapple: virtio-blk: allow FileVault off
>>   ---
>>   ✓ Signed: DKIM/unpredictable.fr
>> ---
>> Total patches: 10
>> ---
>> Applying: target/arm/emulate: add ISV=0 emulation library with load/store immediate
>> Applying: target/arm/emulate: add load/store register offset
>> Applying: target/arm/emulate: add load/store pair
>> Applying: target/arm/hvf, whpx: wire ISV=0 emulation for data aborts
>> Applying: vmapple: apple-gfx: make it work on the latest macOS release
>> Applying: hw/vmapple: aes: convert MAX_LEN to a #define
>> Applying: Revert "hw/arm: Do not build VMapple machine by default"
>> Applying: vmapple: add gicv2m
>> Applying: vmapple, gicv2m: add macOS compat quirk
>> Applying: hw/vmapple: virtio-blk: allow FileVault off
>> /home/me/q/var/qemu/.git/rebase-apply/patch:90: trailing whitespace.
>>         /*
>> /home/me/q/var/qemu/.git/rebase-apply/patch:166: trailing whitespace.
>> API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, 27.0))
>> /home/me/q/var/qemu/.git/rebase-apply/patch:272: trailing whitespace.
>>     /*
>> /home/me/q/var/qemu/.git/rebase-apply/patch:275: trailing whitespace.
>>      * on macOS 15.4 onwards.
>> warning: 4 lines add whitespace errors.
>>
>>>   static PGTask_t *apple_gfx_new_task(AppleGFXState *s, uint64_t len)
>>>   {
>>>       mach_vm_address_t task_mem;
>>> @@ -102,6 +104,7 @@ static dispatch_queue_t get_background_queue(void)
>>>       return task;
>>>   }
>>>   +API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, 27.0))
>>>   static void apple_gfx_destroy_task(AppleGFXState *s, PGTask_t *task)
>>>   {
>>>       GPtrArray *regions = task->mapped_regions;
>>> @@ -151,6 +154,7 @@ static void apple_gfx_destroy_task(AppleGFXState *s, PGTask_t *task)
>>>       return host_ptr;
>>>   }
>>>   +API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, 27.0))
>>>   static bool apple_gfx_task_map_memory(AppleGFXState *s, PGTask_t *task,
>>>                                         uint64_t virtual_offset,
>>>                                         PGPhysicalMemoryRange_t *ranges,
>>> @@ -207,6 +211,7 @@ static bool apple_gfx_task_map_memory(AppleGFXState *s, PGTask_t *task,
>>>       return success;
>>>   }
>>>   +API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, 27.0))
>>>   static void apple_gfx_task_unmap_memory(AppleGFXState *s, PGTask_t *task,
>>>                                           uint64_t virtual_offset, uint64_t length)
>>>   {
>>> @@ -596,6 +601,36 @@ void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)
>>>       /* TODO: PVG framework supports serialising device state: integrate it! */
>>>   }
>>>   +@interface PGDeviceDescriptor (IOSurfaceMapper)
>>> +@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
>>> +@end
>>> +
>>> +bool apple_gfx_register_memory_cb(Int128 start, Int128 len,
>>> +                                  const MemoryRegion *mr,
>>> +                                  hwaddr offset_in_region, void *opaque) {
>>> +    PGGuestPhysicalRange_t range;
>>> +    PGMemoryMapDescriptor *memory_map_descriptor = opaque;
>>> +    if (memory_access_is_direct(mr, true, MEMTXATTRS_UNSPECIFIED)) {
>>> +        range.physicalAddress = start;
>>
>> Please convert Int128 through its helpers. This assigns Int128 directly into the two uint64_t fields. With CONFIG_TCG_INTERPRETER, QEMU deliberately represents Int128 as a structure, even on hosts supporting native __int128. Both assignments fail compilation. A focused Clang check using the actual QEMU headers reproduced the incompatible-type errors; int128_get64() provides the intended checked conversion.
>>
>>> +        range.physicalLength = len;
>>> +        range.hostAddress = memory_region_get_ram_ptr(mr);
>>
>> The FlatView slice offset, offset_in_region, needs to be honored when registering RAM.
>>
>> For apple-gfx-pci, ordinary PC RAM above 4 GiB aliases machine->ram starting at below_4g_mem_size; GPU accesses to that range now alias low RAM instead. Other clipped FlatView ranges have the same problem. The previous mapping path adds the translated offset correctly.
>>
>>> +        [memory_map_descriptor addRange:range];
>>> +    }
>>> +    return false;
>>> +}
>>> +
>>> +static void apple_gfx_register_memory(AppleGFXState *s,
>>> +                                                     PGDeviceDescriptor *desc)
>>> +{
>>> +    PGMemoryMapDescriptor* memoryMapDescriptor = [PGMemoryMapDescriptor new];
>>> +
>>> +    FlatView* fv = address_space_to_flatview(&address_space_memory);
>>> +    flatview_for_each_range(fv, apple_gfx_register_memory_cb, memoryMapDescriptor);
>>> +
>>> +    desc.memoryMapDescriptor = memoryMapDescriptor;
>>> +}
>>> +
>>> +API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, 27.0))
>>>   static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
>>>                                                        PGDeviceDescriptor *desc)
>>>   {
>>> @@ -667,16 +702,25 @@ static void new_frame_handler_bh(void *opaque)
>>>           BQL_LOCK_GUARD();
>>>           set_mode(s, sizeInPixels.x, sizeInPixels.y);
>>>       };
>>> -    disp_desc.cursorGlyphHandler = ^(NSBitmapImageRep *glyph,
>>> -                                     PGDisplayCoord_t hotspot) {
>>> -        AppleGFXSetCursorGlyphJob *job = g_malloc0(sizeof(*job));
>>> -        job->s = s;
>>> -        job->glyph = glyph;
>>> -        job->hotspot = hotspot;
>>> -        [glyph retain];
>>> -        aio_bh_schedule_oneshot(qemu_get_aio_context(),
>>> -                                set_cursor_glyph, job);
>>> -    };
>>> +
>>> +    if (@available(macOS 27.0, *)) {
>>> +
>>> +    } else {
>>> +#ifndef __MAC_27_0
>>> +        disp_desc.cursorGlyphHandler = ^(NSBitmapImageRep *glyph,
>>> +                                         PGDisplayCoord_t hotspot) {
>>> +            AppleGFXSetCursorGlyphJob *job = g_malloc0(sizeof(*job));
>>> +            job->s = s;
>>> +            job->glyph = glyph;
>>> +            job->hotspot = hotspot;
>>> +            [glyph retain];
>>> +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
>>> +                                    set_cursor_glyph, job);
>>> +        };
>>> +#else
>>> +        abort();
>>> +#endif
>>
>> I wonder what is this #ifdefs for. It tests SDK macro __MAC_27_0, whereas the surrounding @available tests the runtime OS. A binary built with that SDK aborts during display realization on every pre-27 host, including macOS 26. Older hosts also encounter explicit aborts in the memory/device fallback paths. Turning supported runtime fallback paths into unconditional process termination depending when SDK is available does not look correct.
> 
> Hi,
> 
> Obsoleted APIs aren’t accessible from a newer SDK even for targeting older OS versions.
> The compiler blocks it even when I use an if (@available) for the newer version before…
> 
> If you have an idea on how to work around that it’d be great.

I checked this with the macOS 27 SDK and confirmed that it no longer 
exports PGNewDeviceWithDescriptor. API_OBSOLETED() is not appropriate 
here: it checks the minimum deployment target, not the SDK version.

Please use __MAC_27_0 consistently to conditionally compile code that 
depends on the SDK version. If a build cannot support the runtime OS 
version, report an error with error_setg() and fail device realization 
instead of calling abort().

Regards,
Akihiko Odaki

> 
>>
>> Regards,
>> Akihiko Odaki
>>
>>> +    }
>>>       disp_desc.cursorShowHandler = ^(BOOL show) {
>>>           trace_apple_gfx_cursor_show(show);
>>>           qatomic_set(&s->cursor_show, show);
>>> @@ -763,11 +807,33 @@ bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
>>>         desc.device = s->mtl;
>>>   -    apple_gfx_register_task_mapping_handlers(s, desc);
>>> +    /*
>>> +     * The legacy memory management interface doesn't allow for
>>> +     * vGPU sandboxing. As such, always use the new interface
>>> +     * on macOS 15.4 onwards.
>>> +     */
>>> +    if (@available(macOS 15.4, *)) {
>>> +        apple_gfx_register_memory(s, desc);
>>> +    } else {
>>> +#ifndef __MAC_27_0
>>> +        apple_gfx_register_task_mapping_handlers(s, desc);
>>> +#else
>>> +        abort();
>>> +#endif
>>> +    }
>>>         s->cursor_show = true;
>>>   -    s->pgdev = PGNewDeviceWithDescriptor(desc);
>>> +    if (@available(macOS 15.2, *)) {
>>> +        s->pgdev = PGCreateDeviceWithDescriptor(desc);
>>> +    }
>>> +    else {
>>> +#ifndef __MAC_27_0
>>> +        s->pgdev = PGNewDeviceWithDescriptor(desc);
>>> +#else
>>> +        abort();
>>> +#endif
>>> +    }
>>>         disp_desc = apple_gfx_prepare_display_descriptor(s);
>>>       /*
> 


