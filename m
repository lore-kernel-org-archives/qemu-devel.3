Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ED5C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 12:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqAbl-0006Ei-La; Mon, 16 Sep 2024 08:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CK3F=QO=kaod.org=clg@ozlabs.org>)
 id 1sqAbi-0006Dx-0f
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:13:31 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CK3F=QO=kaod.org=clg@ozlabs.org>)
 id 1sqAbe-000088-Kc
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:13:29 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X6kMj28Cvz4xVR;
 Mon, 16 Sep 2024 22:13:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X6kMf1624z4x8D;
 Mon, 16 Sep 2024 22:13:17 +1000 (AEST)
Message-ID: <881df54b-c98c-4ce0-a434-05d055cc27bb@kaod.org>
Date: Mon, 16 Sep 2024 14:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/9] softmmu: Support concurrent bounce buffers
To: Mattias Nissler <mnissler@rivosinc.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240909201147.3761639-1-peterx@redhat.com>
 <20240909201147.3761639-2-peterx@redhat.com>
 <441f797f-a377-45de-bfe6-042542c917d8@kaod.org> <ZuRQirmjwWGj1N2D@x1n>
 <CAGNS4TaDVs9eqb9jO5kgi9bL1t1tmc-GywiyP3xpbgFGgvbkLg@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CAGNS4TaDVs9eqb9jO5kgi9bL1t1tmc-GywiyP3xpbgFGgvbkLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=CK3F=QO=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/16/24 10:23, Mattias Nissler wrote:
> Thanks for the report, and my apologies for the breakage.
> 
> On Fri, Sep 13, 2024 at 4:47 PM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Fri, Sep 13, 2024 at 04:35:32PM +0200, Cédric Le Goater wrote:
>>> Hello,
>>>
>>> +Mark (for the Mac devices)
>>>
>>> On 9/9/24 22:11, Peter Xu wrote:
>>>> From: Mattias Nissler <mnissler@rivosinc.com>
>>>>
>>>> When DMA memory can't be directly accessed, as is the case when
>>>> running the device model in a separate process without shareable DMA
>>>> file descriptors, bounce buffering is used.
>>>>
>>>> It is not uncommon for device models to request mapping of several DMA
>>>> regions at the same time. Examples include:
>>>>    * net devices, e.g. when transmitting a packet that is split across
>>>>      several TX descriptors (observed with igb)
>>>>    * USB host controllers, when handling a packet with multiple data TRBs
>>>>      (observed with xhci)
>>>>
>>>> Previously, qemu only provided a single bounce buffer per AddressSpace
>>>> and would fail DMA map requests while the buffer was already in use. In
>>>> turn, this would cause DMA failures that ultimately manifest as hardware
>>>> errors from the guest perspective.
>>>>
>>>> This change allocates DMA bounce buffers dynamically instead of
>>>> supporting only a single buffer. Thus, multiple DMA mappings work
>>>> correctly also when RAM can't be mmap()-ed.
>>>>
>>>> The total bounce buffer allocation size is limited individually for each
>>>> AddressSpace. The default limit is 4096 bytes, matching the previous
>>>> maximum buffer size. A new x-max-bounce-buffer-size parameter is
>>>> provided to configure the limit for PCI devices.
>>>>
>>>> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Acked-by: Peter Xu <peterx@redhat.com>
>>>> Link: https://lore.kernel.org/r/20240819135455.2957406-1-mnissler@rivosinc.com
>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>> ---
>>>>    include/exec/memory.h       | 14 +++----
>>>>    include/hw/pci/pci_device.h |  3 ++
>>>>    hw/pci/pci.c                |  8 ++++
>>>>    system/memory.c             |  5 ++-
>>>>    system/physmem.c            | 82 ++++++++++++++++++++++++++-----------
>>>>    5 files changed, 76 insertions(+), 36 deletions(-)
>>>
>>> Here is a report of a segv of the ppc64 mac99+cpu970 machine booting debian.
>>> See the stack trace below. Just wanted to let you know. I will digging further
>>> next week.
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>
>>> Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
>>> address_space_unmap (len=<optimized out>, access_len=0, is_write=false, buffer=0x0,
>>>      as=0x5555565d45c0 <address_space_memory>) at ../system/physmem.c:3333
>>> 3333      assert(bounce->magic == BOUNCE_BUFFER_MAGIC);
>>> (gdb) bt
>>> #0  address_space_unmap
>>>      (len=<optimized out>, access_len=0, is_write=false, buffer=0x0, as=0x5555565d45c0 <address_space_memory>)
>>>      at ../system/physmem.c:3333
>>> #1  address_space_unmap
>>>      (as=as@entry=0x5555565d45c0 <address_space_memory>, buffer=0x0, len=<optimized out>, is_write=<optimized out>, access_len=0) at ../system/physmem.c:3313
>>> #2  0x000055555595ea48 in dma_memory_unmap
>>>      (access_len=<optimized out>, dir=<optimized out>, len=<optimized out>, buffer=<optimized out>, as=<optimized out>) at /home/legoater/work/qemu/qemu.git/include/sysemu/dma.h:236
>>> #3  pmac_ide_atapi_transfer_cb (opaque=0x555556c06470, ret=<optimized out>) at ../hw/ide/macio.c:122
>>> #4  0x00005555559861f3 in DBDMA_run (s=0x555556c04c60) at ../hw/misc/macio/mac_dbdma.c:546
>>> #5  DBDMA_run_bh (opaque=0x555556c04c60) at ../hw/misc/macio/mac_dbdma.c:556
>>> #6  0x0000555555f19f33 in aio_bh_call (bh=bh@entry=0x555556ab5570) at ../util/async.c:171
>>> #7  0x0000555555f1a0f5 in aio_bh_poll (ctx=ctx@entry=0x5555566af150) at ../util/async.c:218
>>> #8  0x0000555555f0269e in aio_dispatch (ctx=0x5555566af150) at ../util/aio-posix.c:423
>>> #9  0x0000555555f19d8e in aio_ctx_dispatch
>>>      (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at ../util/async.c:360
>>> #10 0x00007ffff7315f4f in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
>>> #11 0x0000555555f1b488 in glib_pollfds_poll () at ../util/main-loop.c:287
>>> #12 os_host_main_loop_wait (timeout=2143429) at ../util/main-loop.c:310
>>> #13 main_loop_wait (nonblocking=nonblocking@entry=0) at ../util/main-loop.c:589
>>> #14 0x0000555555abeba3 in qemu_main_loop () at ../system/runstate.c:826
>>> #15 0x0000555555e63787 in qemu_default_main () at ../system/main.c:37
>>> #16 0x00007ffff6e29590 in __libc_start_call_main () at /lib64/libc.so.6
>>> #17 0x00007ffff6e29640 in __libc_start_main_impl () at /lib64/libc.so.6
>>> #18 0x000055555588d4f5 in _start ()
>>
>> Thanks for the report!
>>
>> Mattias,
>>
>> Would you have time to take a look?
> 
> I noticed that the backtrace indicates address_space_unmap is called
> with buffer=0x0, len=0. This wasn't really correct before my
> concurrent bounce buffering change either, but it looks like the
> previous code would have tolerated this to a certain extent (at least
> no immediate crashes). Original code in question:
> 
>      if (is_write) {
>          address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIED,
>                              as->bounce.buffer, access_len);
>      }
>      qemu_vfree(as->bounce.buffer);
>      as->bounce.buffer = NULL;
>      memory_region_unref(as->bounce.mr);
>      /* Clear in_use before reading map_client_list.  */
>      qatomic_set_mb(&as->bounce.in_use, false);
>      address_space_notify_map_clients(as);
> 
> address_space_write and qemu_vfree are safe to call with NULL/0
> parameters. as->bounce.buffer = NULL would leak the buffer if one is
> allocated, and memory_region_unref(as->bounce.mr) is only OK if the
> bounce buffer hasn't been used before, otherwise we'd erroneously drop
> a memory region reference.
> 
> We have two options here: Either we fix the caller to not call
> address_space_unmap with buffer=NULL. Or alternatively we make
> address_space_unmap NULL-safe by putting a check to return immediately
> when being passed a NULL buffer parameter.
> 
> Looking at the code, the dma_memory_unmap calls in hw/ide/macio.c seem
> to be passing buffer=NULL unconditionally, since the dma_mem field in
> struct DBDMA_io is never set to anything non-zero. In fact, I believe
> after commit be1e343995ef81fc05d9a4e1ec263ca171d842e7 "macio: switch
> over to new byte-aligned DMA helpers", the dma_memory_unmap calls in
> hw/ide/macio.c aren't doing anything and should probably have been
> removed together with the dma_mem, dma_len and dir fields in struct
> DBDMA_io. Speculative patch:
> 
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index e84bf2c9f6..15dd40138e 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -119,9 +119,6 @@ static void pmac_ide_atapi_transfer_cb(void
> *opaque, int ret)
>       return;
> 
>   done:
> -    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
> -                     io->dir, io->dma_len);
> -
>       if (ret < 0) {
>           block_acct_failed(blk_get_stats(s->blk), &s->acct);
>       } else {
> @@ -202,9 +199,6 @@ static void pmac_ide_transfer_cb(void *opaque, int ret)
>       return;
> 
>   done:
> -    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
> -                     io->dir, io->dma_len);
> -
>       if (s->dma_cmd == IDE_DMA_READ || s->dma_cmd == IDE_DMA_WRITE) {
>           if (ret < 0) {
>               block_acct_failed(blk_get_stats(s->blk), &s->acct);
> diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
> index 4a3f644516..c774f6bf84 100644
> --- a/include/hw/ppc/mac_dbdma.h
> +++ b/include/hw/ppc/mac_dbdma.h
> @@ -44,10 +44,6 @@ struct DBDMA_io {
>       DBDMA_end dma_end;
>       /* DMA is in progress, don't start another one */
>       bool processing;
> -    /* DMA request */
> -    void *dma_mem;
> -    dma_addr_t dma_len;
> -    DMADirection dir;
>   };
> 
>   /*
> 
> Cédric, can you try with the above patch and/or 

crash seems gone.

> share more details of your setup so I can verify

You will need a Linnux powerpc or powerpc64 image for mac machines,
which are not common now days, or MacOS images. My debian images
are big. I will try to build you a small one for more tests.

> (I tried booting a ppc64el-pseries dqib
> image but didn't see the issue)?

pseriers is a very different type of machine, the equivalent of the virt
machine on ARM and RISCV. The HW is completely different.

Thanks,

C.




