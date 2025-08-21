Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B49CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 12:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4b5-0000gv-If; Thu, 21 Aug 2025 08:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up4b2-0000g7-TD
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 08:40:48 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up4ax-0000He-5t
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 08:40:48 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e94e3c3621fso895031276.0
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755780037; x=1756384837; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=50Xo61dgc01XvULgIJ3q1FeJl2uep3o/+d3L2ggW8Es=;
 b=BTkSAqFbYfK2yGPD1fOpGn5Yrl4cIYWdlt5UIvg3rO9j6LQv10PAD29qHNmn7gHqML
 E2wAVtIgRLWZ0LC19wZAAHmnSytYD+hgwpWTerlzbcf2NCmbfiNjdu7qHlpn5e127GTP
 zuucY8FZ2qRJDETI1wK8IYHwEY7CGe5uviRX+zMtz8XaP2aFhZYJbGarTl1YXSFOFkj/
 s2dn15KBx2pk0VJvgQEVHK57stQKZzHKWFMdm9zybvHEb0PcKWqtjTQvgtx6UCKC0Kuu
 VwcxPe6dTMW3zjg8ZoYpyzyUNs3IiE7HJOtRt8mTJCm2kQ6r5poE+lKF1ZftLFAMGdyv
 AAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755780037; x=1756384837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=50Xo61dgc01XvULgIJ3q1FeJl2uep3o/+d3L2ggW8Es=;
 b=of5Y3OTSndBAUYo2WLDD9t1Ov0KmL/y4UY2CDZOYrMDnwctJqcm5drdic4+uCFjFWa
 NjNVyu2ECsxmtOopfKqcbFz5iCVFtdh7xgTBqpJ3L5pQkcnj/skrNmsShOrRygQyoTku
 eOyb6vzOLJrd5x6uo6qKjPy94a+Q0Cf7vQuS7oFuesdmHxukyyBMjz5BMrs6IvaGYcpS
 RRH8s8fq4HKUxZqrxn5OSA//TaM3ht+yiFIFUEv6JImL6WJVvQVNSz1CXUOHNnc1T9Rv
 zTFBrVe6fN0Lped/7mEcOffaXIaf3joLBguhO1HyW81KGoSMb/3laTEJCzR8aT455J5U
 T4TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+bmLOL5AG+zbZzIB6+hIN7uutC4hZUr0AJrwnq9O0s9UOMmoxf16MViXiZctYptRRt7+GOs2Jym2/@nongnu.org
X-Gm-Message-State: AOJu0Yyb6q/FNbgraRXXJgbry9+P9emDnERlqfe3m1KyzgwvPLtHtCMt
 UCwBz0bbkgxNn0IO/8AyEhPJmILYxbQ95qbCeSn+9BGPkbIXcX3W6hO7RfMqf1Evhc8tc21Q94E
 cf8GaxiYBNA82CZXaHAVtRCF709mYldOAbWMxfDtIMA==
X-Gm-Gg: ASbGncu8u+aJhY/AUy2jnqpczHXj0D8ehrutcVPWwAUASpVqs5KhZ/ocTfVmhvsdLRu
 4bUU3cTp159iGvth8s28bQG7VRn01nZckuJyZ9sIrMhlj0timiXhfJ0YYKDup/XhSBYYltHZM0i
 U7lBKDRYTGxy5hlggspCTVM2hV5pD/8FQ421hINgtE4NM8bADeuddnUXUavb8mMtDDwdRCnTwCO
 2J7jIr3ebFIywlQJz0=
X-Google-Smtp-Source: AGHT+IEav9r8wP3xvUw8RFtNW6eFrCjxY5M/t4M+xa9U7tq1zp+3ULEMxEw1DlnsEuOyTgl3CGLH60A1So/bTA3kNGI=
X-Received: by 2002:a05:6902:2d03:b0:e94:f2ff:823 with SMTP id
 3f1490d57ef6-e95088e66a8mr2538943276.5.1755780037047; Thu, 21 Aug 2025
 05:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
 <20250110-san-v8-2-57a5a1be1bcf@daynix.com>
In-Reply-To: <20250110-san-v8-2-57a5a1be1bcf@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Aug 2025 13:40:25 +0100
X-Gm-Features: Ac12FXxOGkEXhmPRt78klbC7I6ZJBZvpsNhkof1rHScwGSrrnkSdIeVkraRKuFE
Message-ID: <CAFEAcA-aTYebu-5s4AeBfE3oLQfxTwCpeosoj0TU8E_XPu_ZDg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] memory: Do not create circular reference with
 subregion
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 10 Jan 2025 at 09:20, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> memory_region_update_container_subregions() used to call
> memory_region_ref(), which creates a reference to the owner of the
> subregion, on behalf of the owner of the container. This results in a
> circular reference if the subregion and container have the same owner.
>
> memory_region_ref() creates a reference to the owner instead of the
> memory region to match the lifetime of the owner and memory region. We
> do not need such a hack if the subregion and container have the same
> owner because the owner will be alive as long as the container is.
> Therefore, create a reference to the subregion itself instead ot its
> owner in such a case; the reference to the subregion is still necessary
> to ensure that the subregion gets finalized after the container.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Hi; I came back to this patchset because it was never applied,
and so we still have various leaks of MemoryRegion objects
in devices which use the "device owns a container MemoryRegion C
and puts another MemoryRegion X which it owns into that container"
pattern.

Unfortunately, with this patch applied, I see a segfault when running
the device-introspect-test for Arm:

$ (cd build/x86 && QTEST_QEMU_BINARY=./qemu-system-arm
./tests/qtest/device-introspect-test -p
/arm/device/introspect/concrete/defaults/none)
[...]
# Testing device 'imx7.analog'
Broken pipe
../../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from
signal 11 (Segmentation fault) (core dumped)

Here's a backtrace collected with gdb:

$ (cd build/x86 && QTEST_QEMU_BINARY="xterm -e gdb --tty $(tty) --args
./qemu-system-arm" ./tests/qtest/device-introspect-test -p
/arm/device/introspect/concrete/defaults/none)
[hit 'r' in the gdb prompt in the new window]

Thread 1 "qemu-system-arm" received signal SIGSEGV, Segmentation fault.
memory_region_unref_subregion (subregion=0x555557d58370) at
../../system/memory.c:1862
1862        if (subregion->container->owner == subregion->owner) {
(gdb) bt
#0  memory_region_unref_subregion (subregion=0x555557d58370) at
../../system/memory.c:1862
#1  0x0000555555d5f97b in memory_region_del_subregion
(mr=0x555557d58150, subregion=0x555557d58370)
    at ../../system/memory.c:2705
#2  0x0000555555d5cc1c in memory_region_finalize (obj=0x555557d58150)
at ../../system/memory.c:1811
#3  0x0000555556197595 in object_deinit (obj=0x555557d58150,
type=0x5555579d2ea0) at ../../qom/object.c:715
#4  0x0000555556197613 in object_finalize (data=0x555557d58150) at
../../qom/object.c:729
#5  0x00005555561988f9 in object_unref (objptr=0x555557d58150) at
../../qom/object.c:1232
#6  0x000055555619a3d6 in object_finalize_child_property
    (obj=0x555557d57e20, name=0x555557c59810 "imx7.analog[0]",
opaque=0x555557d58150) at ../../qom/object.c:1818
#7  0x0000555556197344 in object_property_del_all (obj=0x555557d57e20)
at ../../qom/object.c:667
#8  0x0000555556197600 in object_finalize (data=0x555557d57e20) at
../../qom/object.c:728
#9  0x00005555561988f9 in object_unref (objptr=0x555557d57e20) at
../../qom/object.c:1232
#10 0x00005555562f4600 in qmp_device_list_properties
(typename=0x555557d3ee70 "imx7.analog", errp=0x7fffffffdc00)
    at ../../qom/qom-qmp-cmds.c:237
#11 0x00005555563981ba in qmp_marshal_device_list_properties
(args=0x7fffe00031f0, ret=0x7fffef6afda8, errp=0x7fffef6afda0)
    at qapi/qapi-commands-qdev.c:65
#12 0x00005555563bcb53 in do_qmp_dispatch_bh (opaque=0x7fffef6afe40)
at ../../qapi/qmp-dispatch.c:128
#13 0x00005555563ed87f in aio_bh_call (bh=0x555557d3f540) at
../../util/async.c:172
#14 0x00005555563ed9cb in aio_bh_poll (ctx=0x555557a00770) at
../../util/async.c:219
#15 0x00005555563cd517 in aio_dispatch (ctx=0x555557a00770) at
../../util/aio-posix.c:436
#16 0x00005555563edebe in aio_ctx_dispatch (source=0x555557a00770,
callback=0x0, user_data=0x0) at ../../util/async.c:361
#17 0x00007ffff6e965c5 in ??? () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
#18 0x00007ffff6e96710 in g_main_context_dispatch () at
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#19 0x00005555563ef89e in glib_pollfds_poll () at ../../util/main-loop.c:287
#20 0x00005555563ef930 in os_host_main_loop_wait (timeout=0) at
../../util/main-loop.c:310
#21 0x00005555563efa6b in main_loop_wait (nonblocking=0) at
../../util/main-loop.c:589
#22 0x0000555555d7d181 in qemu_main_loop () at ../../system/runstate.c:905
#23 0x00005555562f94c7 in qemu_default_main (opaque=0x0) at
../../system/main.c:50
#24 0x00005555562f9585 in main (argc=18, argv=0x7fffffffe078) at
../../system/main.c:93


In memory_region_unref_subregion(), subregion->container is NULL.

This is because in memory_region_del_subregion() we do:

    subregion->container = NULL;

and then after that we call
    memory_region_unref_subregion(subregion);
which dereferences subregion->container.

Won't this always SEGV ?

thanks
-- PMM

