Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F93CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 08:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxj4L-0000MO-GA; Mon, 07 Oct 2024 04:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxj4I-0000L0-BM
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:26:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxj3c-0003th-Mh
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:26:14 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20b7eb9e81eso48465975ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 01:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728289530; x=1728894330;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2qboBk8CKgTGJT0fcokN9GamQR3fe6dHyEjQZYzibiU=;
 b=Fgu7rQUn3CcOPToBPDE89qicDWHsqZh5nXKIR5CgblFD1CZlWFDfNDJiUp1o3/jvxa
 ULjNXm0jtDS/jXHJQuPYtWVPDsOlcDpwe2+S487qwWVCJvo0ka03M8ZguUs9upoqPafL
 H8T0OPuDCaY2YSTZOTVxGqcjw2ZThpBK4fJohlHDCVO1cloLFQ5LPiamPcG4PuqrGh9t
 YlXtAzapOhC6AU57EqoyQpcLg94yb+kMkmfiSEYyXEkxu5w/AzMiW+H0ASoKGXbecPj/
 //+lDuVeBBvbYhD2hhBfmgG+tCXQsq4OLQBxaZnh2h2812FXig/+7JryTTV3OHqvjwzb
 611w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728289530; x=1728894330;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2qboBk8CKgTGJT0fcokN9GamQR3fe6dHyEjQZYzibiU=;
 b=EdQqgItNg8NBE0LQ/OT1707gp7SefGtff52nQiNa0O9WUChS8lsMbvwhJoUoCHzdW+
 5zqdUuUuRqNewJgqyAr6Bl+7ndxMfiAzLoxFmGru+NTn+AMXkV97k03t2IOUc0lLevEp
 CgtqvrOKShdoRJKthuxBhhd1y4ShMRepQSxXT/TcW3GEWmccseMDWtv6ZIiyQI+roCA+
 C+0p1MIP/Mz7gop3s89GG1+6uzmiGemUioMgWsfHgJxPYAow7DqKkq0YrINKU/RscWED
 O+iW/pR8iOTV2M1KZgh/xCSsn7eqrxS1Xry14BnhQls/FVyqFoVRd6RvbzSQ5EiTJoje
 L97w==
X-Gm-Message-State: AOJu0Yyc3aPIyIZQ1PSlFW/GQxF6mykBlpECfNjbvl1IhYzz09v5BTfh
 nXXM3mhaph4jxD+NnhrsCDZ4Wic2j6uD8Hxyvr+rWOYBl9CcZETaTqCgrpqM0BQ=
X-Google-Smtp-Source: AGHT+IHkKf+Db67/CR3FWljLJ3a5VIruCoC+GqeZWQnILEpRntpfU2BFMwOu84YUwlJNgL3tVSQ06w==
X-Received: by 2002:a17:902:e74c:b0:206:9a3f:15e5 with SMTP id
 d9443c01a7336-20bfe043018mr166884305ad.32.1728289529831; 
 Mon, 07 Oct 2024 01:25:29 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1393075dsm35071675ad.160.2024.10.07.01.25.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 01:25:29 -0700 (PDT)
Message-ID: <12f22415-4079-4211-86ab-29f048de1923@daynix.com>
Date: Mon, 7 Oct 2024 17:25:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-2-phil@philjordan.eu>
 <7f3a1a60-a2f3-433c-8f2e-a2dfe0afdcb5@daynix.com>
 <CAAibmn1+Z0zcB-vQ3ZbrY0o7wtev+YtV1EOCH-4s=PfQg_Pd8A@mail.gmail.com>
 <ae0f5ef7-c714-40e1-be5a-1aa12df518c8@daynix.com>
 <CAAibmn3dmBRCpVBDF07jx+_s0A_i5SAhnSinRyKyD5-jcL134g@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAibmn3dmBRCpVBDF07jx+_s0A_i5SAhnSinRyKyD5-jcL134g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/06 19:39, Phil Dennis-Jordan wrote:
> 
> 
> On Thu, 3 Oct 2024 at 09:09, Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2024/10/02 22:33, Phil Dennis-Jordan wrote:
>      >
>      >
>      >      > +#include "apple-gfx.h"
>      >      > +#include "monitor/monitor.h"
>      >      > +#include "hw/sysbus.h"
>      >      > +#include "hw/irq.h"
>      >      > +#include "trace.h"
>      >      > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
>      >      > +
>      >      > +_Static_assert(__aarch64__, "");
>      >
>      >     I don't think this assertion is worthwhile. This assertion
>     will trigger
>      >     if you accidentally remove depends on AARCH64 from Kconfig,
>     but I don't
>      >     think such code change happens by accident, and there is no
>     reason to
>      >     believe that this assertion won't be removed in such a case.
>      >
>      >
>      > As far as I'm aware the Kconfig AARCH64 dependency is for the /
>     target/
>      > architecture, not the /host/ architecture? The static assert
>     checks for
>      > the latter. The PGIOSurfaceHostDeviceDescriptor type isn't
>     available at
>      > all on non-aarch64 macOS hosts. I've not had any luck with using
>     this
>      > variant of the device on x86-64 hosts simply by disabling any
>     surface
>      > mapper code.
>      >
>      > Incidentally, if you know of a way to depend on a specific /host/
>      > architecture in the Kconfig, that would be even better. I
>     couldn't spot
>      > a way of doing that though.
> 
>     I got your intention now. The correct way to do that is to check for
>     cpu
>     == 'aarch64'. Having assertion will break qemu-system-aarch64 on
>     Intel Macs.
> 
> 
> OK, looks Iike that needs to be done at the meson.build level not 
> Kconfig, but this seems to work:
> 
> if cpu == 'aarch64'
>    system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true: [files('apple- 
> gfx-mmio.m'), pvg, metal])
> endif
> 
>      >
>      >     It is dangerous to unlock BQL at an arbitrary place. Instead of
>      >     unlocking, I suggest:
>      >     - running [s->pgiosfc mmioReadAtOffset:offset] on another thread
>      >     - using a bottom half to request operations that require BQL
>     from the
>      >     thread running [s->pgiosfc mmioReadAtOffset:offset]
>      >     - calling AIO_WAIT_WHILE() to process the bottom half and to
>     wait for
>      >     the completion of [s->pgiosfc mmioReadAtOffset:offset]
>      >
>      >
>      > OK, I think I see what you mean, I'll try to rework things around
>     that
>      > pattern. Any preference on how I kick off the job on the other
>     thread?
>      > As we necessarily need to use libdispatch in a bunch of places in
>     this
>      > code anyway, I guess dispatch_async() would probably be the simplest?
> 
>     Perhaps so. The QEMU way is to use a bottom half with AioContext, but
>     you can't simultaneously run a dispatch queue and AioContext in one
>     thread so you have to use the dispatch queue if you need one.
> 
>      >
>      >      > +    res = [s->pgiosfc mmioReadAtOffset:offset];
>      >      > +    bql_lock();
>      >      > +
>      >      > +    trace_apple_iosfc_read(offset, res);
>      >      > +
>      >      > +    return res;
>      >      > +}
>      >      > +
>      >      > +static void apple_iosfc_write(
>      >      > +    void *opaque, hwaddr offset, uint64_t val, unsigned size)
>      >      > +{
>      >      > +    AppleGFXVmappleState *s = opaque;
>      >      > +
>      >      > +    trace_apple_iosfc_write(offset, val);
>      >      > +
>      >      > +    [s->pgiosfc mmioWriteAtOffset:offset value:val];
>      >      > +}
>      >      > +
>      >      > +static const MemoryRegionOps apple_iosfc_ops = {
>      >      > +    .read = apple_iosfc_read,
>      >      > +    .write = apple_iosfc_write,
>      >      > +    .endianness = DEVICE_LITTLE_ENDIAN,
>      >      > +    .valid = {
>      >      > +        .min_access_size = 4,
>      >      > +        .max_access_size = 8,
>      >      > +    },
>      >      > +    .impl = {
>      >      > +        .min_access_size = 4,
>      >      > +        .max_access_size = 8,
>      >      > +    },
>      >      > +};
>      >      > +
>      >      > +static PGIOSurfaceHostDevice
>      >     *apple_gfx_prepare_iosurface_host_device(
>      >      > +    AppleGFXVmappleState *s)
>      >      > +{
>      >      > +    PGIOSurfaceHostDeviceDescriptor *iosfc_desc =
>      >      > +        [PGIOSurfaceHostDeviceDescriptor new];
>      >      > +    PGIOSurfaceHostDevice *iosfc_host_dev = nil;
>      >      > +
>      >      > +    iosfc_desc.mapMemory =
>      >      > +        ^(uint64_t phys, uint64_t len, bool ro, void
>     **va, void
>      >     *e, void *f) {
>      >      > +            trace_apple_iosfc_map_memory(phys, len, ro,
>     va, e, f);
>      >      > +            MemoryRegion *tmp_mr;
>      >      > +            *va = gpa2hva(&tmp_mr, phys, len, NULL);
>      >
>      >     Use: dma_memory_map()
>      >
>      >
>      > That doesn't seem to be a precisely equivalent operation. It also
>     says
>      > in its headerdoc,
>      >
>      >     Use only for reads OR writes - not for read-modify-write
>     operations.
>      >
>      > which I don't think we can guarantee here at all.
>      >
>      > I guess I can call it twice, once for writing and once for
>     reading, but
>      > given that the dma_memory_unmap operation marks the area dirty,
>     I'm not
>      > it's intended for what I understand the use case here to be: As
>     far as I
>      > can tell, the PV graphics device uses (some) of this memory to
>     exchange
>      > data in a cache-coherent way between host and guest, e.g. as a
>     lock-free
>      > ring buffer, using atomic operations as necessary. (This works
>     because
>      > it's a PV device: it "knows" the other end just another CPU core (or
>      > even the same one) executing in a different hypervisor context.)
>     This
>      > doesn't really match "traditional" DMA patterns where there's
>     either a
>      > read or a write happening.
> 
>     I think the story is a bit different for this VMApple variant. Probably
>     the CPU and GPU in Apple Silicon is cache-coherent so you can map
>     normal
>     memory for GPU without any kind of cache maintenance.
> 
>     Cache conherency of CPU and GPU in Apple Silicon is implied with
>     Apple's
>     documentation; it says you don't need to synchronize resources for
>     MTLStorageModeShared, which is the default for Apple Silicon.
>     https://developer.apple.com/documentation/metal/
>     resource_fundamentals/synchronizing_a_managed_resource_in_macos
>     <https://developer.apple.com/documentation/metal/
>     resource_fundamentals/synchronizing_a_managed_resource_in_macos>
> 
>     The name "IOSurface" also implies it is used not only for e.g., ring
>     buffer but also for real data.
> 
> Note that the PGTask map/unmap callbacks appear to have equivalent 
> semantics, so it's not just the surface mapping.
> 
>      >
>      > Hunting around some more for alternative APIs, there's also
>      > memory_region_get_ram_ptr(), but I'm not sure its restrictions apply
>      > here either.
> 
>     I think you can call memory_access_is_direct() to check if the
>     requirement is satisfied.
> 
>     It will still break dirty page tracking implemented by
>     dma_memory_unmap() and others, but it's broken for hvf, which does not
>     implement dirty page tracking either.
> 
> 
> 
> 
>      >
>      >      > +            return (bool)true;
>      >
>      >     Why cast?
>      >
>      >
>      > Good question. Not originally my code, so I've fixed all the
>     instances I
>      > could find now.
> 
> 
> OK, it turns out the reason for this is that C treats 'true' as an int, 
> which then becomes the block's inferred return type - and the callbacks 
> are expecting bool-returning blocks.
> 
> I've fixed it by explicitly specifying the block return type and 
> removing the cast in the return statement:
> 
> iosfc_desc.unmapMemory =
>         ^bool(…) {
>             …
>             return true;
>         };
> 
>      >      > +
>      >      > +    iosfc_desc.unmapMemory =
>      >      > +        ^(void *a, void *b, void *c, void *d, void *e,
>     void *f) {
>      >      > +            trace_apple_iosfc_unmap_memory(a, b, c, d, e, f);
>      >      > +            return (bool)true;
>      >      > +        };
>      >      > +
>      >      > +    iosfc_desc.raiseInterrupt = ^(uint32_t vector) {
>      >      > +        trace_apple_iosfc_raise_irq(vector);
>      >      > +        bool locked = bql_locked();
>      >      > +        if (!locked) {
>      >      > +            bql_lock();
>      >      > +        }
>      >       > +        qemu_irq_pulse(s->irq_iosfc);> +        if (!
>     locked) {
>      >      > +            bql_unlock();
>      >      > +        }
>      >      > +        return (bool)true;
>      >      > +    };
>      >      > +
>      >      > +    iosfc_host_dev =
>      >      > +        [[PGIOSurfaceHostDevice alloc]
>      >     initWithDescriptor:iosfc_desc];
>      >      > +    [iosfc_desc release];
>      >      > +    return iosfc_host_dev;
>      >      > +}
>      >      > +
>      >      > +static void apple_gfx_vmapple_realize(DeviceState *dev, Error
>      >     **errp)
>      >      > +{
>      >      > +    @autoreleasepool {
>      >
>      >     This autoreleasepool is not used.
>      >
>      >
>      > It is definitely used inside the apple_gfx_common_realize() call.
>     It's
>      > also impossible to say whether [PGDeviceDescriptor new] uses
>     autorelease
>      > semantics internally, so it seemed safer to wrap the whole thing
>     in an
>      > outer pool.
> 
>     Theoretically, It should be safe to assume the callee creates
>     autoreleasepool by themselves as needed in general. We have bunch of
>     code to call Objective-C APIs without creating autoreleasepool in the
>     caller. Practically, [PGDeviceDescriptor new] is likely to be
>     implemented with ARC, which wraps methods in autoreleasepool as
>     necessary.
> 
> 
> As far as I'm aware, ARC does NOT automatically insert autorelease pool 
> blocks. The reason you rarely need to create autoreleasepool blocks in 
> "plain" Objective-C programming is that Cocoa/CFRunloop/libdispatch 
> event handlers run each event in an autoreleasepool. So you don't need 
> to create them explicitly when using dispatch_async and similar, or when 
> running code on the main thread (which runs inside NSApplicationMain/ 
> CFRunloopRun/dispatch_main).

My statement regarding ARC was wrong; It seems ARC just retains a value 
annoted as autoreleased.

> 
> As far as I'm aware, if you don't explicitly define autoreleasepools in 
> raw threads created with the pthreads API, any autoreleased objects will 
> leak. At least I've not found any specification/documentation 
> contradicting this. And most code in Qemu runs on such raw threads, so 
> we need to play it safe with regard to autorelease semantics.

I decided to dig deeper and found this documentation:
https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/mmAutoreleasePools.html

It says:
 > Cocoa always expects code to be executed within an autorelease pool
 > block, otherwise autoreleased objects do not get released and your
 > application leaks memory.

So yes, we must wrap everything in @autoreleasepool at least for Cocoa. 
It is probably a good practice to wrap all Objective-C code in 
@autoreleasepool.

> 
> Whether the existing Qemu Objective-C code is safe in this regard I 
> don't know for certain, but I've certainly paid attention to this aspect 
> when modifying ui/cocoa.m in the past, and indeed most of that code runs 
> on the main thread. Note also how I wrap the apple_gfx_render_new_frame 
> call in a pool when it can't be guaranteed it's running on a dispatch 
> queue because the command buffer inside that uses autorelease semantics.

It is more about event loop rather than thread. Resources allocated 
before [NSApp run] will leak even if they are autoreleased in the main 
thread. apple_gfx_common_realize() is one of such functions that run in 
the main thread before [NSApp run]. In ui/cocoa, cocoa_display_init() 
runs before [NSApp run]. Fortunately we already have NSAutoreleasePool 
for this function.

> 
>     Functions that uses a method that returns autorelease resources should
>     be wrapped with autoreleasepool instead of assuming the caller creates
>     autoreleasepool for them.
> 
> 
> I'm treating apple_gfx_common_realize as an internal API, and I don't 
> think expecting its callers to wrap it in an autoreleasepool block is 
> unreasonable. I can certainly explicitly document this in a comment.

We don't have a comment for cocoa_display_init() and it's more about 
generic macOS programming so it's not necessary.

 > >      >      > diff --git a/hw/display/apple-gfx.m 
b/hw/display/apple-gfx.m
>      >      > new file mode 100644
>      >      > index 00000000000..837300f9cd4
>      >      > --- /dev/null
>      >      > +++ b/hw/display/apple-gfx.m
>      >      > @@ -0,0 +1,536 @@
>      >      > +/*
>      >      > + * QEMU Apple ParavirtualizedGraphics.framework device
>      >      > + *
>      >      > + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All
>      >     Rights Reserved.
>      >      > + *
>      >      > + * This work is licensed under the terms of the GNU GPL,
>     version
>      >     2 or later.
>      >      > + * See the COPYING file in the top-level directory.
>      >      > + *
>      >      > + * ParavirtualizedGraphics.framework is a set of
>     libraries that
>      >     macOS provides
>      >      > + * which implements 3d graphics passthrough to the host
>     as well as a
>      >      > + * proprietary guest communication channel to drive it. This
>      >     device model
>      >      > + * implements support to drive that library from within QEMU.
>      >      > + */
>      >      > +
>      >      > +#include "apple-gfx.h"
>      >      > +#include "trace.h"
>      >      > +#include "qemu/main-loop.h"
>      >      > +#include "ui/console.h"
>      >      > +#include "monitor/monitor.h"
>      >      > +#include "qapi/error.h"
>      >      > +#include "migration/blocker.h"
>      >      > +#include <mach/mach_vm.h>
>      >      > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
>      >      > +
>      >      > +static const PGDisplayCoord_t apple_gfx_modes[] = {
>      >      > +    { .x = 1440, .y = 1080 },
>      >      > +    { .x = 1280, .y = 1024 },
>      >      > +};
>      >      > +
>      >      > +typedef struct PGTask_s { // Name matches forward
>     declaration in
>      >     PG header
>      >
>      >     Let's name it AppleGFXTask. It is a common practice to have
>     the same
>      >     tag
>      >     name and typedef in QEMU.
>      >
>      >
>      > This is defining a forward-declared type from framework headers
>     which is
>      > opaque from the framework's point of view. We do not get to
>     choose its
>      > struct name. The alternative is having casts wherever these
>     objects are
>      > being passed between our code and the framework. (See the
>     original v1/v2
>      > vmapple patch series for how messy this is.)
> 
>     I got the idea. Let's not avoid the typedef then to clarify the naming
>     is not under our control.
> 
> 
> I'm not sure what you mean by this double negative. Are you saying, 
> don't add our own typedef for struct PGTask_s at all, just use the 
> framework-supplied PGTask_t where appropriate?

Yes.

> 
> 
>      >
>      >      > +static void
>     apple_gfx_render_frame_completed(AppleGFXState *s,
>      >     void *vram,
>      >      > +                                           
>       id<MTLTexture> texture)
>      >      > +{
>      >      > +    --s->pending_frames;
>      >      > +    assert(s->pending_frames >= 0);
>      >      > +
>      >      > +    if (vram != s->vram) {
>      >      > +        /* Display mode has changed, drop this old frame. */
>      >      > +        assert(texture != s->texture);
>      >      > +        g_free(vram);
>      >
>      >     This management of buffers looks a bit convoluted. I suggest
>      >     remembering
>      >     the width and height instead of pointers and comparing them.
>     This way
>      >     you can free resources in set_mode().
>      >
>      >
>      > Yeah, I suppose that works, I can change that around.
>      >
>      >      > +    } else {
>      >      > +        copy_mtl_texture_to_surface_mem(texture, vram);
>      >
>      >     Writing vram outside BQL may result in tearing.
>      >
>      >
>      > As far as I can tell(*), QXL does the same. I couldn't find any
>     examples
>      > of double-buffering in any of the existing display devices, which
>     would
>      > be the only way to do async updates efficiently and without
>     tearing. In
>      > any case, this solution is still vastly better than a regular VGA
>      > device, which suffers from very visible tearing with macOS on the
>     guest
>      > side anyway. And in an ideal world, we'd pass through the rendered
>      > texture directly to the Cocoa UI code rather than copying out
>     only for
>      > the CPU to draw it back into a window surface which is then
>     passed to
>      > the GPU for host side rendering. But I felt this patch is already
>     very,
>      > very large, and if anyone cares, we can fix imperfections in
>     subsequent
>      > updates.
>      >
>      > (*)The rendering code in that device is also fairly complex, so I
>     may be
>      > misreading it.
> 
>     QXL always modifies the surface with BQL. The surface is modified with
>     qxl_blit(), which is called by qxl_render_update_area_unlocked().
>     qxl_render_update_area_unlocked() is called by either of
>     qxl_render_update() and qxl_render_update_area_bh(). Both of them are
>     called with BQL. The name includes "unlocked", but it means it is
>     called
>     without holding QXL-internal lock.
> 
>     Most devices works entirely with BQL so they don't perform double
>     buffering. apple-gfx can do the same.
> 
> 
> I think we can safely move apple-gfx's framebuffer state management back 
> inside the BQL, yes. I just figured that copying dozens of megabytes of 
> framebuffer data on every frame while holding the lock was not going to 
> help BQL contention. Especially as PVG does not have a concept of dirty 
> areas, so we must copy the whole framebuffer every time. (Unless we were 
> to implement dirty area detection ourselves.)
> 
> Unfortunately, implementing double-buffering would require a major 
> rework of Qemu's whole surface management, console code, and probably 
> most of the UI implementations. I'm guessing the OpenGL fast-path 
> sidesteps all of this, so replicating that with Metal would probably be 
> the easier way forward. (Although doing all this graphics stuff inside 
> the BQL generally seems like a major architectural flaw; I suppose most 
> enterprise use of Qemu does not involve the framebuffer, so it's not 
> shown up in BQL contention profiling there. It certainly does in desktop 
> use, although at least on macOS hosts there are far worse culprits in 
> that regard.)

We don't need double-buffering; instead we can have one thread that 
renders the UI and also
[PGDisplay -encodeCurrentFrameToCommandBuffer:texture:region:]. 
Rendering the UI in machine event loop in one thread is a bad idea in 
the first place so it will make sense to extract all UI work into a 
separate thread. This still requires a lot of work because the UI code 
assumes BQL everywhere.

In my understanding BQL is less problematic for KVM users because QEMU 
can (sometimes) avoid locking BQL in the vCPU threads.

> 
>      >
>      >      > +        if (s->gfx_update_requested) {
>      >      > +            s->gfx_update_requested = false;
>      >      > +            dpy_gfx_update_full(s->con);
>      >      > +            graphic_hw_update_done(s->con);
>      >       > +            s->new_frame_ready = false;
>      >
>      >     This assignment is unnecessary as s->new_frame_ready is
>     always false
>      >     when s->gfx_update_requested. If you want to make sure
>      >     s->gfx_update_requested and s->new_frame_ready are mutually
>     exclusive,
>      >     use one enum value instead of having two bools.
>      >
>      >
>      > I'll need to refresh my memory and get back to you on this one, it's
>      > been so many months since I actively worked on this code.
>      >
>      >      > +        } else {
>      >      > +            s->new_frame_ready = true;
>      >      > +        }
>      >      > +    }
>      >      > +    if (s->pending_frames > 0) {
>      >      > +        apple_gfx_render_new_frame(s);
>      >      > +    }
>      >      > +}
>      >      > +
>      >      > +static void apple_gfx_fb_update_display(void *opaque)
>      >      > +{
>      >      > +    AppleGFXState *s = opaque;
>      >      > +
>      >      > +    dispatch_async(s->render_queue, ^{
>      >      > +        if (s->pending_frames > 0) {
>      >
>      >     It should check for s->new_frame_ready as
>      >     apple_gfx_render_frame_completed() doesn't check if
>      >     s->pending_frames > 0 before calling
>     graphic_hw_update_done(), which is
>      >     inconsistent.
>      >
>      >
>      > pending_frames is about guest-side frames that are queued to be
>     rendered
>      > by the host GPU.
>      > new_frame_ready being true indicates that the contents of the Qemu
>      > console surface has been updated with new frame data since the last
>      > gfx_update.
>      > gfx_update_requested indicates that gfx_update is currently
>     awaiting an
>      > async completion (graphic_hw_update_done) but the surface has not
>      > received a new frame content, but the GPU is stily busy drawing one.
>      >
>      > apple_gfx_render_frame_completed is scheduled exactly once per
>     pending
>      > frame, so pending_frames > 0 is an invariant there. (Hence the
>     assert.)> > I don't think there is any inconsistency here, but I'll
>     double check.
>      > It's possible that there's an easier way to express the state
>     machine,
>      > and I'll take a look at that.
> 
>     I meant that apple_gfx_render_frame_completed() does not check if the
>     frame is the last one currently pending. apple_gfx_fb_update_display()
>     ignores a new ready frame when there is a more pending frame, but
>     apple_gfx_render_frame_completed() unconditionally fires
>     graphic_hw_update_done() even if there is a more pending frame. And I
>     think apple_gfx_render_frame_completed() is right and
>     apple_gfx_fb_update_display() is wrong in such a situation.
> 
> 
> OK, got it. And yes, I agree.
> 
>      >
>      >     Checking if s->pending_frames > 0 both in
>     apple_gfx_fb_update_display()
>      >     and apple_gfx_render_frame_completed() is also problematic as
>     that can
>      >     defer graphic_hw_update_done() indefinitely if we are getting new
>      >     frames
>      >     too fast.
>      >
>      >
>      > I see what you mean about this part. I'll have to test it, but I
>     guess
>      > we should reverse the priority, like this:
>      >
>      >          if (s->new_frame_ready) {
>      >              dpy_gfx_update_full(s->con);
>      >              s->new_frame_ready = false;
>      >              graphic_hw_update_done(s->con);
>      >          } else if (s->pending_frames > 0) {
>      >              s->gfx_update_requested = true;
>      >          } else {
>      >              graphic_hw_update_done(s->con);
>      >          }
>      >
>      > 1. If we already have a frame, ready to be displayed, return it
>     immediately.
>      > 2. If the guest has reported that it's completed a frame and the
>     GPU is
>      > currently busy rendering it, defer graphic_hw_update_done until
>     it's done.
>      > 3. If the guest reports no changes to its display, indicate this
>     back to
>      > Qemu as a no-op display update graphic_hw_update_done() with no
>      > dpy_gfx_update* call.
> 
>     Yes, that looks correct.
> 
>      >
>      >      > +            s->gfx_update_requested = true;
>      >      > +        } else {
>      >      > +            if (s->new_frame_ready) {
>      >      > +                dpy_gfx_update_full(s->con);
>      >      > +                s->new_frame_ready = false;
>      >      > +            }
>      >      > +            graphic_hw_update_done(s->con);
>      >       > +        }> +    });
>      >      > +}
>      >      > +
>      >      > +static const GraphicHwOps apple_gfx_fb_ops = {
>      >      > +    .gfx_update = apple_gfx_fb_update_display,
>      >      > +    .gfx_update_async = true,
>      >      > +};
>      >      > +
>      >      > +static void update_cursor(AppleGFXState *s)
>      >      > +{
>      >      > +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
>      >      > +                  s->pgdisp.cursorPosition.y, s-
>      >cursor_show);
>      >      > +}
>      >      > +
>      >      > +static void set_mode(AppleGFXState *s, uint32_t width,
>     uint32_t
>      >     height)
>      >      > +{
>      >      > +    void *vram = NULL;
>      >      > +    DisplaySurface *surface;
>      >      > +    MTLTextureDescriptor *textureDescriptor;
>      >      > +    id<MTLTexture> texture = nil;
>      >      > +    __block bool no_change = false;
>      >      > +
>      >      > +    dispatch_sync(s->render_queue,
>      >
>      >     Calling dispatch_sync() while holding BQL may result in deadlock.
>      >
>      > Only if any code executed on the same dispatch queue acquires the
>     lock
>      > either directly or transitively. I believe I have ensure this is not
>      > done on the reqnder_queue, have you found anywhere this is the case?
> 
>     The documentation is not clear what threads a dispatch queue runs
>     on. We
>     can have a deadlock if they lock the BQL.
> 
> 
> dispatch_sync is a synchronisation primitive (it waits for and asserts 
> exclusive access to the given queue), it doesn't actually do any thread 
> scheduling. Work scheduled asynchronously to non-main dispatch queues 
> will otherwise run on libdispatch pool threads. Running blocks on 
> dispatch queues will not preempt and schedule it on other threads which 
> may or may not be holding some locks.

What if all pool threads are waiting for BQL?

> 
> So the only way this code will deadlock is if any code scheduled to 
> render_queue directly or transitively acquires the BQL. None of it does, 
> although updating the console while holding the BQL rather complicates this.
> 
>      >
>      >      > +        ^{
>      >      > +            if (s->surface &&
>      >      > +                width == surface_width(s->surface) &&
>      >      > +                height == surface_height(s->surface)) {
>      >      > +                no_change = true;
>      >      > +            }
>      >      > +        });
>      >      > +
>      >      > +    if (no_change) {
>      >      > +        return;
>      >      > +    }
>      >      > +
>      >      > +    vram = g_malloc0(width * height * 4);
>      >      > +    surface = qemu_create_displaysurface_from(width, height,
>      >     PIXMAN_LE_a8r8g8b8,
>      >      > +                                              width * 4,
>     vram);
>      >      > +
>      >      > +    @autoreleasepool {
>      >      > +        textureDescriptor =
>      >      > +            [MTLTextureDescriptor
>      >      > +
>      >     texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
>      >      > +                                             width:width
>      >      > +                                            height:height
>      >      > +                                         mipmapped:NO];
>      >      > +        textureDescriptor.usage = s-
>      >pgdisp.minimumTextureUsage;
>      >      > +        texture = [s->mtl
>      >     newTextureWithDescriptor:textureDescriptor];
>      >      > +    }
>      >      > +
>      >      > +    s->using_managed_texture_storage =
>      >      > +        (texture.storageMode == MTLStorageModeManaged);
>      >      > +
>      >      > +    dispatch_sync(s->render_queue,
>      >      > +        ^{
>      >      > +            id<MTLTexture> old_texture = nil;
>      >      > +            void *old_vram = s->vram;
>      >      > +            s->vram = vram;
>      >      > +            s->surface = surface;
>      >      > +
>      >      > +            dpy_gfx_replace_surface(s->con, surface);
>      >      > +
>      >      > +            old_texture = s->texture;
>      >      > +            s->texture = texture;
>      >      > +            [old_texture release];
>      >
>      >     You can just do:
>      >     [s->texture release];
>      >     s->texture = texture;
>      >
>      >     This will make s->texture dangling between the two
>     statements, but that
>      >     don't matter since s->texture is not an atomic variable that
>     can be
>      >     safely observed from another thread anyway.
>      >
>      >      > +
>      >      > +            if (s->pending_frames == 0) {
>      >      > +                g_free(old_vram);
>      >      > +            }
>      >      > +        });
>      >      > +}
>      >      > +
>      >      > +static void create_fb(AppleGFXState *s)
>      >      > +{
>      >      > +    s->con = graphic_console_init(NULL, 0,
>     &apple_gfx_fb_ops, s);
>      >      > +    set_mode(s, 1440, 1080);
>      >      > +
>      >      > +    s->cursor_show = true;
>      >      > +}
>      >      > +
>      >      > +static size_t apple_gfx_get_default_mmio_range_size(void)
>      >      > +{
>      >      > +    size_t mmio_range_size;
>      >      > +    @autoreleasepool {
>      >      > +        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
>      >      > +        mmio_range_size = desc.mmioLength;
>      >      > +        [desc release];
>      >      > +    }
>      >      > +    return mmio_range_size;
>      >      > +}
>      >      > +
>      >      > +void apple_gfx_common_init(Object *obj, AppleGFXState *s,
>     const
>      >     char* obj_name)
>      >
>      >     This function can be merged into apple_gfx_common_realize().
>      >
>      >
>      > Probably. I'll try it.
> 
> 
> Upon further inspection, we need to call 
> cocoa_enable_runloop_on_main_thread() during the init phase, not 
> realize(). So we can't get rid of this entirely. Is there any value in 
> moving the other init code into _realize()?

Calling cocoa_enable_runloop_on_main_thread() should be avoided even in 
apple_gfx_common_init(). QEMU can plug a device at runtime instead of 
initialization time, and in such a case, apple_gfx_common_init() will 
run after calling qemu_main.

I had a closer look and found it has a memory_region_init_io() call, 
which should remain in apple_gfx_common_init(). This leads to the same 
conclusion that we cannot remove this function so let's only move 
migrate_add_blocker() to apple_gfx_common_realize() to report its error.

>  
>      >      > +{
>      >      > +    Error *local_err = NULL;
>      >      > +    int r;
>      >      > +    size_t mmio_range_size =
>      >     apple_gfx_get_default_mmio_range_size();
>      >      > +
>      >      > +    trace_apple_gfx_common_init(obj_name, mmio_range_size);
>      >      > +    memory_region_init_io(&s->iomem_gfx, obj,
>     &apple_gfx_ops, s,
>      >     obj_name,
>      >      > +                          mmio_range_size);
>      >      > +    s->iomem_gfx.disable_reentrancy_guard = true;
>      >
>      >     Why do you disable reentrancy guard?
>      >
>      >
>      > Perhaps with the proposed AIO_WAIT_WHILE based I/O scheme, this
>     won't be
>      > an issue anymore, but the guard would otherwise keep dropping MMIOs
>      > which immediately caused the PV graphics device to stop making
>     progress.
>      > The MMIO APIs in the PVG framework are thread- and reentrancy-
>     safe, so
>      > we certainly don't need to serialise them on our side.
> 
>     It's better to understand why such reentrancy happens. Reentrancy
>     itself
>     is often a sign of bug.
> 
>      >
>      >      > +
>      >      > +    /* TODO: PVG framework supports serialising device state:
>      >     integrate it! */
>      >      > +    if (apple_gfx_mig_blocker == NULL) {
>      >      > +        error_setg(&apple_gfx_mig_blocker,
>      >      > +                  "Migration state blocked by apple-gfx
>     display
>      >     device");
>      >      > +        r = migrate_add_blocker(&apple_gfx_mig_blocker,
>     &local_err);
>      >      > +        if (r < 0) {
>      >      > +            error_report_err(local_err);
>      >
>      >     Please report the error to the caller of
>     apple_gfx_common_realize()
>      >     instead.
>      >
>      >      > +        }
>      >      > +    }
>      >       > +}> +
>      >      > +static void
>      >     apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
>      >      > +
>      >       PGDeviceDescriptor *desc)
>      >      > +{
>      >      > +    desc.createTask = ^(uint64_t vmSize, void * _Nullable *
>      >     _Nonnull baseAddress) {
>      >      > +        AppleGFXTask *task = apple_gfx_new_task(s, vmSize);
>      >      > +        *baseAddress = (void*)task->address;
>      >
>      >     nit: please write as (void *) instead of (void*).
>      >
>      >      > +        trace_apple_gfx_create_task(vmSize, *baseAddress);
>      >      > +        return task;
>      >      > +    };
>      >      > +
>      >
>      >      > +{
>      >      > +    PGDisplayDescriptor *disp_desc = [PGDisplayDescriptor
>     new];
>      >      > +
>      >      > + disp_desc.name <http://disp_desc.name> <http://
>     disp_desc.name <http://disp_desc.name>> = @"QEMU display";
>      >      > +    disp_desc.sizeInMillimeters = NSMakeSize(400.,
>     300.); /* A
>      >     20" display */
>      >      > +    disp_desc.queue = dispatch_get_main_queue();
>      >      > +    disp_desc.newFrameEventHandler = ^(void) {
>      >      > +        trace_apple_gfx_new_frame();
>      >      > +        dispatch_async(s->render_queue, ^{
>      >      > +            /* Drop frames if we get too far ahead. */
>      >      > +            if (s->pending_frames >= 2)
>      >      > +                return;
>      >      > +            ++s->pending_frames;
>      >      > +            if (s->pending_frames > 1) {
>      >      > +                return;
>      >      > +            }
>      >      > +            @autoreleasepool {
>      >      > +                apple_gfx_render_new_frame(s);
>      >      > +            }
>      >      > +        });
>      >      > +    };
>      >      > +    disp_desc.modeChangeHandler = ^(PGDisplayCoord_t
>     sizeInPixels,
>      >      > +                                    OSType pixelFormat) {
>      >      > +        trace_apple_gfx_mode_change(sizeInPixels.x,
>     sizeInPixels.y);
>      >      > +        set_mode(s, sizeInPixels.x, sizeInPixels.y);
>      >      > +    };
>      >      > +    disp_desc.cursorGlyphHandler = ^(NSBitmapImageRep *glyph,
>      >      > +                                     PGDisplayCoord_t
>     hotSpot) {
>      >      > +        uint32_t bpp = glyph.bitsPerPixel;
>      >      > +        size_t width = glyph.pixelsWide;
>      >      > +        size_t height = glyph.pixelsHigh;
>      >      > +        size_t padding_bytes_per_row = glyph.bytesPerRow
>     - width
>      >     * 4;
>      >      > +        const uint8_t* px_data = glyph.bitmapData;
>      >      > +
>      >      > +        trace_apple_gfx_cursor_set(bpp, width, height);
>      >      > +
>      >      > +        if (s->cursor) {
>      >      > +            cursor_unref(s->cursor);
>      >      > +            s->cursor = NULL;
>      >      > +        }
>      >      > +
>      >      > +        if (bpp == 32) { /* Shouldn't be anything else,
>     but just
>      >     to be safe...*/
>      >      > +            s->cursor = cursor_alloc(width, height);
>      >      > +            s->cursor->hot_x = hotSpot.x;
>      >      > +            s->cursor->hot_y = hotSpot.y;
>      >      > +
>      >      > +            uint32_t *dest_px = s->cursor->data;
>      >      > +
>      >      > +            for (size_t y = 0; y < height; ++y) {
>      >      > +                for (size_t x = 0; x < width; ++x) {
>      >      > +                    /* NSBitmapImageRep's red & blue channels
>      >     are swapped
>      >      > +                     * compared to QEMUCursor's. */
>      >      > +                    *dest_px =
>      >      > +                        (px_data[0] << 16u) |
>      >      > +                        (px_data[1] <<  8u) |
>      >      > +                        (px_data[2] <<  0u) |
>      >      > +                        (px_data[3] << 24u);
>      >      > +                    ++dest_px;
>      >      > +                    px_data += 4;
>      >      > +                }
>      >      > +                px_data += padding_bytes_per_row;
>      >      > +            }
>      >      > +            dpy_cursor_define(s->con, s->cursor);
>      >      > +            update_cursor(s);
>      >      > +        }
>      >      > +    };
>      >      > +    disp_desc.cursorShowHandler = ^(BOOL show) {
>      >      > +        trace_apple_gfx_cursor_show(show);
>      >      > +        s->cursor_show = show;
>      >      > +        update_cursor(s);
>      >      > +    };
>      >      > +    disp_desc.cursorMoveHandler = ^(void) {
>      >      > +        trace_apple_gfx_cursor_move();
>      >      > +        update_cursor(s);
>      >      > +    };
>      >      > +
>      >      > +    return disp_desc;
>      >      > +}
>      >      > +
>      >      > +static NSArray<PGDisplayMode*>*
>      >     apple_gfx_prepare_display_mode_array(void)
>      >      > +{
>      >      > +    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
>      >      > +    NSArray<PGDisplayMode*>* mode_array = nil;
>      >      > +    int i;
>      >      > +
>      >      > +    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
>      >      > +        modes[i] =
>      >      > +            [[PGDisplayMode alloc]
>      >     initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
>      >      > +    }
>      >      > +
>      >      > +    mode_array = [NSArray arrayWithObjects:modes
>      >     count:ARRAY_SIZE(apple_gfx_modes)];
>      >      > +
>      >      > +    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
>      >      > +        [modes[i] release];
>      >      > +        modes[i] = nil;
>      >      > +    }
>      >      > +
>      >      > +    return mode_array;
>      >      > +}
>      >      > +
>      >      > +static id<MTLDevice> copy_suitable_metal_device(void)
>      >      > +{
>      >      > +    id<MTLDevice> dev = nil;
>      >      > +    NSArray<id<MTLDevice>> *devs = MTLCopyAllDevices();
>      >      > +
>      >      > +    /* Prefer a unified memory GPU. Failing that, pick a non-
>      >     removable GPU. */
>      >      > +    for (size_t i = 0; i < devs.count; ++i) {
>      >      > +        if (devs[i].hasUnifiedMemory) {
>      >      > +            dev = devs[i];
>      >      > +            break;
>      >      > +        }
>      >      > +        if (!devs[i].removable) {
>      >      > +            dev = devs[i];
>      >      > +        }
>      >      > +    }
>      >      > +
>      >      > +    if (dev != nil) {
>      >      > +        [dev retain];
>      >      > +    } else {
>      >      > +        dev = MTLCreateSystemDefaultDevice();
>      >      > +    }
>      >      > +    [devs release];
>      >      > +
>      >      > +    return dev;
>      >      > +}
>      >      > +
>      >      > +void apple_gfx_common_realize(AppleGFXState *s,
>      >     PGDeviceDescriptor *desc)
>      >      > +{
>      >      > +    PGDisplayDescriptor *disp_desc = nil;
>      >      > +
>      >      > +    QTAILQ_INIT(&s->tasks);
>      >      > +    s->render_queue = dispatch_queue_create("apple-
>     gfx.render",
>      >      > +                                           
>     DISPATCH_QUEUE_SERIAL);
>      >      > +    s->mtl = copy_suitable_metal_device();
>      >      > +    s->mtl_queue = [s->mtl newCommandQueue];
>      >      > +
>      >      > +    desc.device = s->mtl;
>      >      > +
>      >      > +    apple_gfx_register_task_mapping_handlers(s, desc);
>      >      > +
>      >      > +    s->pgdev = PGNewDeviceWithDescriptor(desc);
>      >      > +
>      >      > +    disp_desc = apple_gfx_prepare_display_handlers(s);
>      >      > +    s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc
>      >      > +                                              port:0
>      >     serialNum:1234];
>      >      > +    [disp_desc release];
>      >      > +    s->pgdisp.modeList =
>     apple_gfx_prepare_display_mode_array();
>      >      > +
>      >      > +    create_fb(s);
>      >      > +}
>      >      > diff --git a/hw/display/meson.build b/hw/display/meson.build
>      >      > index 7db05eace97..70d855749c0 100644
>      >      > --- a/hw/display/meson.build
>      >      > +++ b/hw/display/meson.build
>      >      > @@ -65,6 +65,8 @@ system_ss.add(when: 'CONFIG_ARTIST',
>     if_true:
>      >     files('artist.c'))
>      >      >
>      >      >   system_ss.add(when: 'CONFIG_ATI_VGA', if_true:
>     [files('ati.c',
>      >     'ati_2d.c', 'ati_dbg.c'), pixman])
>      >      >
>      >      > +system_ss.add(when: 'CONFIG_MAC_PVG',         if_true:
>      >     [files('apple-gfx.m'), pvg, metal])
>      >      > +system_ss.add(when: 'CONFIG_MAC_PVG_VMAPPLE', if_true:
>      >     [files('apple-gfx-vmapple.m'), pvg, metal])
>      >      >
>      >      >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>      >      >     virtio_gpu_ss = ss.source_set()
>      >      > diff --git a/hw/display/trace-events b/hw/display/trace-events
>      >      > index 781f8a33203..1809a358e36 100644
>      >      > --- a/hw/display/trace-events
>      >      > +++ b/hw/display/trace-events
>      >      > @@ -191,3 +191,29 @@ dm163_bits_ppi(unsigned dest_width)
>      >     "dest_width : %u"
>      >      >   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
>      >      >   dm163_channels(int channel, uint8_t value) "channel %d:
>     0x%x"
>      >      >   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
>      >      > +
>      >      > +# apple-gfx.m
>      >      > +apple_gfx_read(uint64_t offset, uint64_t res)
>      >     "offset=0x%"PRIx64" res=0x%"PRIx64
>      >      > +apple_gfx_write(uint64_t offset, uint64_t val)
>      >     "offset=0x%"PRIx64" val=0x%"PRIx64
>      >      > +apple_gfx_create_task(uint32_t vm_size, void *va)
>     "vm_size=0x%x
>      >     base_addr=%p"
>      >      > +apple_gfx_destroy_task(void *task) "task=%p"
>      >      > +apple_gfx_map_memory(void *task, uint32_t range_count,
>     uint64_t
>      >     virtual_offset, uint32_t read_only) "task=%p range_count=0x%x
>      >     virtual_offset=0x%"PRIx64" read_only=%d"
>      >      > +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr,
>      >     uint64_t phys_len) "[%d] phys_addr=0x%"PRIx64"
>     phys_len=0x%"PRIx64
>      >      > +apple_gfx_remap(uint64_t retval, uint64_t source, uint64_t
>      >     target) "retval=%"PRId64" source=0x%"PRIx64" target=0x%"PRIx64
>      >      > +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset,
>      >     uint64_t length) "task=%p virtual_offset=0x%"PRIx64"
>     length=0x%"PRIx64
>      >      > +apple_gfx_read_memory(uint64_t phys_address, uint64_t length,
>      >     void *dst) "phys_addr=0x%"PRIx64" length=0x%"PRIx64" dest=%p"
>      >      > +apple_gfx_raise_irq(uint32_t vector) "vector=0x%x"
>      >      > +apple_gfx_new_frame(void) ""
>      >      > +apple_gfx_mode_change(uint64_t x, uint64_t y) "x=%"PRId64"
>      >     y=%"PRId64
>      >      > +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t
>      >     height) "bpp=%d width=%"PRId64" height=0x%"PRId64
>      >      > +apple_gfx_cursor_show(uint32_t show) "show=%d"
>      >      > +apple_gfx_cursor_move(void) ""
>      >      > +apple_gfx_common_init(const char *device_name, size_t
>     mmio_size)
>      >     "device: %s; MMIO size: %zu bytes"
>      >      > +
>      >      > +# apple-gfx-vmapple.m
>      >      > +apple_iosfc_read(uint64_t offset, uint64_t res)
>      >     "offset=0x%"PRIx64" res=0x%"PRIx64
>      >      > +apple_iosfc_write(uint64_t offset, uint64_t val)
>      >     "offset=0x%"PRIx64" val=0x%"PRIx64
>      >      > +apple_iosfc_map_memory(uint64_t phys, uint64_t len,
>     uint32_t ro,
>      >     void *va, void *e, void *f) "phys=0x%"PRIx64" len=0x%"PRIx64"
>     ro=%d
>      >     va=%p e=%p f=%p"
>      >      > +apple_iosfc_unmap_memory(void *a, void *b, void *c, void *d,
>      >     void *e, void *f) "a=%p b=%p c=%p d=%p e=%p f=%p"
>      >      > +apple_iosfc_raise_irq(uint32_t vector) "vector=0x%x"
>      >      > +
>      >      > diff --git a/meson.build b/meson.build
>      >      > index 10464466ff3..f09df3f09d5 100644
>      >      > --- a/meson.build
>      >      > +++ b/meson.build
>      >      > @@ -741,6 +741,8 @@ socket = []
>      >      >   version_res = []
>      >      >   coref = []
>      >      >   iokit = []
>      >      > +pvg = []
>      >      > +metal = []
>      >      >   emulator_link_args = []
>      >      >   midl = not_found
>      >      >   widl = not_found
>      >      > @@ -762,6 +764,8 @@ elif host_os == 'darwin'
>      >      >     coref = dependency('appleframeworks', modules:
>     'CoreFoundation')
>      >      >     iokit = dependency('appleframeworks', modules: 'IOKit',
>      >     required: false)
>      >      >     host_dsosuf = '.dylib'
>      >      > +  pvg = dependency('appleframeworks', modules:
>      >     'ParavirtualizedGraphics')
>      >      > +  metal = dependency('appleframeworks', modules: 'Metal')
>      >      >   elif host_os == 'sunos'
>      >      >     socket = [cc.find_library('socket'),
>      >      >               cc.find_library('nsl'),
>      >
> 


