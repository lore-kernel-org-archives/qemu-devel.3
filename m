Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094ECC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 08:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgKZg-0005Ma-Ma; Tue, 20 Aug 2024 04:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgKZf-0005LM-7G
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 04:50:43 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgKZd-0007Td-5z
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 04:50:42 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f3e2f5163dso14750941fa.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 01:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724143839; x=1724748639; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eX3cwrzjzCDhT4MDsuL1C4ny20PElaeIEz8RKmMSAHY=;
 b=UfhPoQBuzIF6W9L5s7/TPuSCbwujt5gBSuonzpLfLLKp4Ba0sVvg/tcljj3RRPkEzD
 WT0z/K2kFuO6kqT/SQqnSYkeO2Xcq/OsaR3Nw1oRlkOwpe4m6dKqxm34zf0RlqoZR89I
 QLIY9C+d8Y66jRjuaxm44gYn8BePQiERwcoGjVdtmqMBofkLOizKhWCvNm15QIDS+G4O
 6fk/dH7FdA/SmzLn1WtOOKgUOu3/r7pYb9msXarqfpy81cIaWE2ccZBCon1DC6FWXwU0
 pkV+k8YJV+kHePTQw8WEU4DM/M2fGzIij0ff0fFsVBcSTAHt8QK6ELrVamktdkpeHrBk
 ljwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724143839; x=1724748639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eX3cwrzjzCDhT4MDsuL1C4ny20PElaeIEz8RKmMSAHY=;
 b=glMhv9k1PlJc2q3f/3BtgHUgU+cIB/KBZXu+0uxALhpVpklth3Osxiw6yfV422XVsY
 3sC5KGJF3qzd19gOVavmxMnxoFSRfOFi4bc5qK35E8G4UZj7zSYPkdpkUpkFdiVaXplM
 d8FhSANor08Ccvnl0yYnj7me7TLgebeNulyox/ikeC4CdG8zOhQkWUfMLrzgYLQ3EVtK
 O3o45J666V4+2NS+uAnOB2TOiTwlZ5p5wNo2ReDOsNozt/Kg2yYniSTNuamikRtaw7bN
 0gSCggMT+/MKRjMapvFRwBvehArX4m20HeVHeD/KestaH3uMGH+FLSVAQr0LvxN5tvNQ
 G3zQ==
X-Gm-Message-State: AOJu0Yzp+siVl4HqjYxdG82/K08PjO8osbUOlXb+3ME3Z7hXDw9rx/OL
 99HYD+GCV3dJgdOnV9PAljznmPOo2Try835xACI7Dc/83IKgmx+1+qCuTithqiHfsOKVldQoxCr
 5y6oFAwXHPSkRtu7l1yPs5NzLduqpFMWEZcAVUA==
X-Google-Smtp-Source: AGHT+IEw+tSwsZrzomgrAhz2osUhKecVIeEmTdiQY7qK0oRFF/sq/JFq+HTrpJ5tlvoSvMtu6pANve4YFRYvdGiF+uA=
X-Received: by 2002:a05:651c:1547:b0:2ef:1db2:c02a with SMTP id
 38308e7fff4ca-2f3e9f73060mr9096521fa.6.1724143838955; Tue, 20 Aug 2024
 01:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-k7a+VObGAfCFNygQNfCKL=AfX6A4kScq=VSSK0peqPg@mail.gmail.com>
 <7f3fd493-8652-4bb9-b94a-1484d24dc3f2@redhat.com>
In-Reply-To: <7f3fd493-8652-4bb9-b94a-1484d24dc3f2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2024 09:50:28 +0100
Message-ID: <CAFEAcA-Ka+iPT4mwK6WaAbReJ2egwixyxaXwprY-Lu2Yr1v+RA@mail.gmail.com>
Subject: Re: apparent memory leak from object-add+object-del of
 memory-backend-ram
To: David Hildenbrand <david@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 19 Aug 2024 at 20:07, David Hildenbrand <david@redhat.com> wrote:
>
> On 19.08.24 18:24, Peter Maydell wrote:
> > Hi; I'm looking at a memory leak apparently in the host memory backend
> > code that you can see from the qmp-cmd-test. Repro instructions:
>
> Hi Peter,
>
> >
> > (1) build QEMU with '--cc=clang' '--cxx=clang++' '--enable-debug'
> > '--target-list=x86_64-softmmu' '--enable-sanitizers'
> > (2) run 'make check'. More specifically, to get just this
> > failure ('make check' on current head-of-tree produces some
> > other unrelated leak errors) you can run the relevant single test:
> >
> > (cd build/asan && ASAN_OPTIONS="fast_unwind_on_malloc=0"
> > QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/qmp-cmd-test
> > --tap -k -p /x86_64/qmp/object-add-failure-modes)
> >
> > The test case is doing a variety of object-add then object-del
> > of the "memory-backend-ram" object, and this add-del cycle seems
> > to result in a fairly large leak:
> >
> > Direct leak of 1572864 byte(s) in 6 object(s) allocated from:
> >      #0 0x555c1336efd8 in __interceptor_calloc
> > (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x218efd8)
> > (BuildId: fc7566a39db1253aed91d500b5b1784e0c438397)
> >      #1 0x7f5bf3472c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
> >      #2 0x555c155bb134 in bitmap_new
> > /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/bitmap.h:102:12
> >      #3 0x555c155ba4ee in dirty_memory_extend system/physmem.c:1831:37
> >      #4 0x555c15585a2b in ram_block_add system/physmem.c:1907:9
> >      #5 0x555c15589e50 in qemu_ram_alloc_internal system/physmem.c:2109:5
> >      #6 0x555c1558a096 in qemu_ram_alloc system/physmem.c:2129:12
> >      #7 0x555c15518b69 in memory_region_init_ram_flags_nomigrate
> > system/memory.c:1571:21
> >      #8 0x555c1464fd27 in ram_backend_memory_alloc backends/hostmem-ram.c:34:12
> >      #9 0x555c146510ac in host_memory_backend_memory_complete
> > backends/hostmem.c:345:10
> >      #10 0x555c1580bc90 in user_creatable_complete qom/object_interfaces.c:28:9
> >      #11 0x555c1580c6f8 in user_creatable_add_type qom/object_interfaces.c:125:10
> >      #12 0x555c1580ccc4 in user_creatable_add_qapi qom/object_interfaces.c:157:11
> >      #13 0x555c15ff0e2c in qmp_object_add qom/qom-qmp-cmds.c:227:5
> >      #14 0x555c161ce508 in qmp_marshal_object_add
> > /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qapi/qapi-commands-qom.c:337:5
> >      #15 0x555c162a7139 in do_qmp_dispatch_bh qapi/qmp-dispatch.c:128:5
> >      #16 0x555c16387921 in aio_bh_call util/async.c:171:5
> >      #17 0x555c163887fc in aio_bh_poll util/async.c:218:13
> >      #18 0x555c162e1288 in aio_dispatch util/aio-posix.c:423:5
> >      #19 0x555c1638f7be in aio_ctx_dispatch util/async.c:360:5
> >      #20 0x7f5bf3469d3a in g_main_dispatch
> > debian/build/deb/../../../glib/gmain.c:3419:28
> >      #21 0x7f5bf3469d3a in g_main_context_dispatch
> > debian/build/deb/../../../glib/gmain.c:4137:7
> >      #22 0x555c163935c9 in glib_pollfds_poll util/main-loop.c:287:9
> >      #23 0x555c16391f03 in os_host_main_loop_wait util/main-loop.c:310:5
> >      #24 0x555c16391acc in main_loop_wait util/main-loop.c:589:11
> >      #25 0x555c14614917 in qemu_main_loop system/runstate.c:801:9
> >      #26 0x555c16008b8c in qemu_default_main system/main.c:37:14
> >      #27 0x555c16008bd7 in main system/main.c:48:12
> >      #28 0x7f5bf12fbd8f in __libc_start_call_main
> > csu/../sysdeps/nptl/libc_start_call_main.h:58:16
> >
> > My initial suspicion here is that the problem is that
> > TYPE_MEMORY_BACKEND has a UserCreatableClass::complete method which
> > calls HostMemoryBackend::alloc, but there is no corresponding
> > "now free this" in instance_finalize. So ram_backend_memory_alloc()
> > calls memory_region_init_ram_flags_nomigrate(), which allocates
> > RAM, dirty blocks, etc, but nothing ever destroys the MR and the
> > memory is leaked when the TYPE_MEMORY_BACKEND object is finalized.
> >
> > But there isn't a "free" method in HostMemoryBackendClass,
> > only an "alloc", so this looks like an API with "leaks memory"
> > baked into it. How is the freeing of the memory on object
> > deletion intended to work?
>
> I *think* during object_del(), we would be un-refing the contained
> memory-region, which in turn will make the refcount go to 0 and end up
> calling memory_region_finalize().

Oh, yes, I'd forgotten about the MemoryRegions being refcounted.
That explains why the MR itself doesn't show up as a leak, only
these dirty memory bitmaps.

> In memory_region_finalize, we do various things, including calling
> mr->destructor(mr).
>
> For memory_region_init_ram_flags_nomigrate(), the deconstructor is set
> to memory_region_destructor_ram(). This is the place where we call
> qemu_ram_free(mr->ram_block);
>
> There we clean up.
>
> What we *don't* clean up is the allocation you are seeing:
> dirty_memory_extend() will extend the ram_list.dirty_memory bitmap as
> needed. It is not stored in the RAMBlock, it's a global list.
>
> It's not really a leak I think: when we object_del + object_add *I
> think* that bitmap will simply get reused.

I think there probably is a leak here somewhere, though --
lsan will only report if the memory is unreachable from
anywhere on program exit, AIUI. If we still had the global
list available to reuse on the next object-creation
shouldn't it still be reachable from somewhere?

It's possible the leak only happens in some of the
"check failure cases of object-add" code paths that the
test is exercising, of course.

thanks
-- PMM

