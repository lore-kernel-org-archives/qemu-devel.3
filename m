Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C72DCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 00:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6IK2-0001ct-JM; Tue, 07 Oct 2025 20:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1v6F5h-0005ao-0W; Tue, 07 Oct 2025 17:19:26 -0400
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>)
 id 1v6F5f-0006bW-0K; Tue, 07 Oct 2025 17:19:24 -0400
Received: from [0.0.0.0] (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com
 [3.122.114.9]) by csgraf.de (Postfix) with ESMTPSA id A33806080403;
 Tue,  7 Oct 2025 23:19:20 +0200 (CEST)
Message-ID: <1e873f0c-3e1f-4d78-b61b-909443510191@csgraf.de>
Date: Tue, 7 Oct 2025 23:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 3/4] vmapple: apple-gfx: make it work on the latest macOS
 release
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Peter Maydell
 <peter.maydell@linaro.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20251007203153.30136-1-mohamed@unpredictable.fr>
 <20251007203153.30136-4-mohamed@unpredictable.fr>
Content-Language: en-US
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <20251007203153.30136-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Oct 2025 20:46:19 -0400
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


On 07.10.25 22:31, Mohamed Mediouni wrote:
> Follow changes in memory management, and enable process isolation for a sandboxed GPU process when on a new OS.


Please detail here why this is necessary.


>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/display/apple-gfx-mmio.m | 56 +++++++++++++++++++++++++++----------
>   hw/display/apple-gfx.h      | 13 +++++++++
>   hw/display/apple-gfx.m      | 42 +++++++++++++++++++++++++++-
>   3 files changed, 95 insertions(+), 16 deletions(-)
>
> diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
> index b0b6e2993e..728441d490 100644
> --- a/hw/display/apple-gfx-mmio.m
> +++ b/hw/display/apple-gfx-mmio.m
> @@ -19,6 +19,7 @@
>   #include "hw/irq.h"
>   #include "apple-gfx.h"
>   #include "trace.h"
> +#include "system/address-spaces.h"
>   
>   #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
>   
> @@ -34,14 +35,25 @@
>   typedef bool(^IOSFCMapMemory)(uint64_t phys, uint64_t len, bool ro, void **va,
>                                 void *, void *);
>   
> +@interface PGMemoryMapDescriptor : NSObject
> +-(void)addRange:(struct PGGuestPhysicalRange_s) range;
> +@end
> +
>   @interface PGDeviceDescriptor (IOSurfaceMapper)
>   @property (readwrite, nonatomic) bool usingIOSurfaceMapper;
> +@property (readwrite, nonatomic) bool enableArgumentBuffers;
> +@property (readwrite, nonatomic) bool enableProcessIsolation;
> +@property (readwrite, nonatomic) bool enableProtectedContent;
> +
> +@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
>   @end
>   
>   @interface PGIOSurfaceHostDeviceDescriptor : NSObject
>   -(PGIOSurfaceHostDeviceDescriptor *)init;
>   @property (readwrite, nonatomic, copy, nullable) IOSFCMapMemory mapMemory;
>   @property (readwrite, nonatomic, copy, nullable) IOSFCUnmapMemory unmapMemory;
> +@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
> +@property (readwrite, nonatomic) unsigned long long mmioLength;
>   @property (readwrite, nonatomic, copy, nullable) IOSFCRaiseInterrupt raiseInterrupt;
>   @end
>   
> @@ -182,20 +194,28 @@ static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
>       PGIOSurfaceHostDeviceDescriptor *iosfc_desc =
>           [PGIOSurfaceHostDeviceDescriptor new];
>       PGIOSurfaceHostDevice *iosfc_host_dev;
> -
> -    iosfc_desc.mapMemory =
> -        ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
> -            *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
> -
> -            trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
> -
> -            return *va != NULL;
> -        };
> -
> -    iosfc_desc.unmapMemory =
> -        ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
> -            return apple_gfx_mmio_unmap_surface_memory(va);
> -        };
> +    PGMemoryMapDescriptor* memoryMapDescriptor = [PGMemoryMapDescriptor new];
> +
> +    if (@available(macOS 15.4, *)) {


This needs a big fat comment explaining what this condition is checking 
for, why it's doing that and what the effect of it is. I would also 
recommend to wrap this in something like a static inline bool function 
that gives it a descriptive name.


> +        FlatView* fv = address_space_to_flatview(&address_space_memory);
> +        flatview_for_each_range(fv, apple_gfx_register_memory_cb, memoryMapDescriptor);
> +        iosfc_desc.mmioLength = 0x10000;


Why 0x10000?


> +        iosfc_desc.memoryMapDescriptor = memoryMapDescriptor;
> +    } else {
> +        iosfc_desc.mapMemory =
> +            ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
> +                *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
> +
> +                trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
> +
> +                return *va != NULL;
> +            };
> +
> +        iosfc_desc.unmapMemory =
> +            ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
> +                return apple_gfx_mmio_unmap_surface_memory(va);
> +            };
> +    }
>   
>       iosfc_desc.raiseInterrupt = ^bool(uint32_t vector) {
>           trace_apple_gfx_iosfc_raise_irq(vector);
> @@ -223,13 +243,19 @@ static void apple_gfx_mmio_realize(DeviceState *dev, Error **errp)
>           };
>   
>           desc.usingIOSurfaceMapper = true;
> -        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
> +        desc.enableArgumentBuffers = true;
> +        // Process isolation needs to go through PGMemoryMapDescriptor
> +        if (@available(macOS 15.4, *)) {
> +            desc.enableProcessIsolation = true;
> +        }
>   
>           if (!apple_gfx_common_realize(&s->common, dev, desc, errp)) {
>               [s->pgiosfc release];
>               s->pgiosfc = nil;
>           }
>   
> +        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
> +
>           [desc release];
>           desc = nil;
>       }
> diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
> index a8b1d1efc0..0f7cf33adf 100644
> --- a/hw/display/apple-gfx.h
> +++ b/hw/display/apple-gfx.h
> @@ -23,6 +23,13 @@
>   @protocol MTLTexture;
>   @protocol MTLCommandQueue;
>   
> +typedef struct PGGuestPhysicalRange_s
> +{
> +    uint64_t physicalAddress;
> +    uint64_t physicalLength;
> +    void *hostAddress;
> +} PGGuestPhysicalRange_t;
> +
>   typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
>   
>   typedef struct AppleGFXDisplayMode {
> @@ -68,6 +75,12 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
>                                          uint64_t length, bool read_only,
>                                          MemoryRegion **mapping_in_region);
>   
> +bool apple_gfx_register_memory_cb(Int128 start,
> +                            Int128 len,
> +                            const MemoryRegion *mr,
> +                            hwaddr offset_in_region,
> +                            void *opaque);
> +
>   extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
>   
>   #endif
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> index 174d56ae05..238b227176 100644
> --- a/hw/display/apple-gfx.m
> +++ b/hw/display/apple-gfx.m
> @@ -21,6 +21,7 @@
>   #include "system/address-spaces.h"
>   #include "system/dma.h"
>   #include "migration/blocker.h"
> +#include "system/memory.h"
>   #include "ui/console.h"
>   #include "apple-gfx.h"
>   #include "trace.h"
> @@ -596,6 +597,41 @@ void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)
>       /* TODO: PVG framework supports serialising device state: integrate it! */
>   }
>   
> +@interface PGMemoryMapDescriptor : NSObject
> +-(void)addRange:(struct PGGuestPhysicalRange_s) range;
> +@end
> +
> +@interface PGDeviceDescriptor (IOSurfaceMapper)
> +@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
> +@end
> +
> +bool apple_gfx_register_memory_cb(Int128 start,
> +                            Int128 len,
> +                            const MemoryRegion *mr,
> +                            hwaddr offset_in_region,
> +                            void *opaque) {
> +    PGGuestPhysicalRange_t range;
> +    PGMemoryMapDescriptor* memoryMapDescriptor = opaque;
> +    if (mr->ram) {
> +        range.physicalAddress = start;
> +        range.physicalLength = len;
> +        range.hostAddress = memory_region_get_ram_ptr(mr);
> +        [memoryMapDescriptor addRange:range];
> +    }
> +    return false;
> +}


By creating a full external function for the new isolated case, but 
keeping the inline mapMemory function for the non-isolated case this 
creates an awkward asymmetry. Either move both into functions or keep 
both inline.


Alex

> +
> +static void apple_gfx_register_memory(AppleGFXState *s,
> +                                                     PGDeviceDescriptor *desc)
> +{
> +    PGMemoryMapDescriptor* memoryMapDescriptor = [PGMemoryMapDescriptor new];
> +
> +    FlatView* fv = address_space_to_flatview(&address_space_memory);
> +    flatview_for_each_range(fv, apple_gfx_register_memory_cb, memoryMapDescriptor);
> +
> +    desc.memoryMapDescriptor = memoryMapDescriptor;
> +}
> +
>   static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
>                                                        PGDeviceDescriptor *desc)
>   {
> @@ -763,7 +799,11 @@ bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
>   
>       desc.device = s->mtl;
>   
> -    apple_gfx_register_task_mapping_handlers(s, desc);
> +    if (@available(macOS 15.4, *)) {
> +        apple_gfx_register_memory(s, desc);
> +    } else {
> +        apple_gfx_register_task_mapping_handlers(s, desc);
> +    }
>   
>       s->cursor_show = true;
>   

