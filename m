Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B70C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq71R-0007KN-Rc; Mon, 16 Sep 2024 04:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sq71Q-0007Ju-Kc
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:23:48 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sq71O-0000mc-0v
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:23:48 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e040388737so2023966b6e.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726475024; x=1727079824;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVxdkA3m2VW7+j9nkmRXwG5vKvu7eAX47xiixuwv7Ns=;
 b=J2G/8ktx1eygrQ+kVf8V+CxDuOWSBubuVHBgdumYEqrrG1anuQAntxBbPHEIeUt2tW
 6MkWF12qvymU3vkOwDPrzn/Vv/G6cNzL8XMeFGry1p2gJhVWASLRvvKv9ZNGrEM9re2X
 xeWGVRgQJ9Qt+v3Q1R9cmk3tsbwI+nMKhymlYgUX/YelAeMVpHdUCe4JsW9FDpzKg+63
 Ofpg8XBvX++ps/Txyv+J/OEK9Pzzf0VOwUw5VuhbpaIZft2LdikU60aHJQ2AlpaM7bqr
 a6V5mq+zQsAdREuKWlCr97VyzRzODVSQzCRRv4DZ1IoIJDo2foRc70WanFsilhz/lKCG
 kOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726475024; x=1727079824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVxdkA3m2VW7+j9nkmRXwG5vKvu7eAX47xiixuwv7Ns=;
 b=qVYRvIXNsNvmn8aGRIbsQ+mz2ZvjWzGKn3iaAT/3g3GALS3vVVj+Fx8va5q4cB2f9H
 THfvh1UOahcmjFaI2c0mDk7vyxfvzVquiGTe++0h6eco47xiaPqbxgNwxooLf6qp++1y
 Brqv7T4JKYfoeibLwrnuUUBuMoZHSNG6keIpKEr3otSGnx8UZUj6CjNlAZAIsAHguYHU
 ed+cUM7PH8ygqfFsPgkV/L7M7v62vsS71yZokeYWr9BYyqB7nlKF1L9xnKri8gFDvgSQ
 9kqNS2NIVi2N2/5aebl1AO9C2U1c4xMV7eIS2eMKb0JdIx1wr0jDhlsc92bOxWZTzrMs
 wpmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHdRxfy+79KUobfIvLJB8tPRQHp3L8Faj//WOfR8dhj6c2ft+zYjx67xLB2w0cVR64ooAzxaZ5/wsS@nongnu.org
X-Gm-Message-State: AOJu0Yw1I6r2Jwj56+2ZTSDu3NQdyL5Hv95xrozLrYEhER6VFVUMNyDC
 2ow9j2qsccCaPB7mnA3qAT/b1uc7JWAAfbcBHGkUtspBRkbMqdA8xBiZ9UVvgQ//9b3KB85VXlN
 ZBuueSwhR1t/7uMx4zbZtV616UMcuHbQjTXKwLw==
X-Google-Smtp-Source: AGHT+IEQ6gHUAwW18NQKX4C0rj6eURfFzeumDRQ2AV0yqUMVd+vQPmcaPaLkeznsGbB0IO6D2mZNm8x6LDBgfpE2RUE=
X-Received: by 2002:a05:6808:1a1f:b0:3e0:374a:1a60 with SMTP id
 5614622812f47-3e071b0dbedmr8629804b6e.30.1726475024186; Mon, 16 Sep 2024
 01:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240909201147.3761639-1-peterx@redhat.com>
 <20240909201147.3761639-2-peterx@redhat.com>
 <441f797f-a377-45de-bfe6-042542c917d8@kaod.org> <ZuRQirmjwWGj1N2D@x1n>
In-Reply-To: <ZuRQirmjwWGj1N2D@x1n>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Mon, 16 Sep 2024 10:23:33 +0200
Message-ID: <CAGNS4TaDVs9eqb9jO5kgi9bL1t1tmc-GywiyP3xpbgFGgvbkLg@mail.gmail.com>
Subject: Re: [PULL 1/9] softmmu: Support concurrent bounce buffers
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=mnissler@rivosinc.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks for the report, and my apologies for the breakage.

On Fri, Sep 13, 2024 at 4:47=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Sep 13, 2024 at 04:35:32PM +0200, C=C3=A9dric Le Goater wrote:
> > Hello,
> >
> > +Mark (for the Mac devices)
> >
> > On 9/9/24 22:11, Peter Xu wrote:
> > > From: Mattias Nissler <mnissler@rivosinc.com>
> > >
> > > When DMA memory can't be directly accessed, as is the case when
> > > running the device model in a separate process without shareable DMA
> > > file descriptors, bounce buffering is used.
> > >
> > > It is not uncommon for device models to request mapping of several DM=
A
> > > regions at the same time. Examples include:
> > >   * net devices, e.g. when transmitting a packet that is split across
> > >     several TX descriptors (observed with igb)
> > >   * USB host controllers, when handling a packet with multiple data T=
RBs
> > >     (observed with xhci)
> > >
> > > Previously, qemu only provided a single bounce buffer per AddressSpac=
e
> > > and would fail DMA map requests while the buffer was already in use. =
In
> > > turn, this would cause DMA failures that ultimately manifest as hardw=
are
> > > errors from the guest perspective.
> > >
> > > This change allocates DMA bounce buffers dynamically instead of
> > > supporting only a single buffer. Thus, multiple DMA mappings work
> > > correctly also when RAM can't be mmap()-ed.
> > >
> > > The total bounce buffer allocation size is limited individually for e=
ach
> > > AddressSpace. The default limit is 4096 bytes, matching the previous
> > > maximum buffer size. A new x-max-bounce-buffer-size parameter is
> > > provided to configure the limit for PCI devices.
> > >
> > > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > Acked-by: Peter Xu <peterx@redhat.com>
> > > Link: https://lore.kernel.org/r/20240819135455.2957406-1-mnissler@riv=
osinc.com
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >   include/exec/memory.h       | 14 +++----
> > >   include/hw/pci/pci_device.h |  3 ++
> > >   hw/pci/pci.c                |  8 ++++
> > >   system/memory.c             |  5 ++-
> > >   system/physmem.c            | 82 ++++++++++++++++++++++++++--------=
---
> > >   5 files changed, 76 insertions(+), 36 deletions(-)
> >
> > Here is a report of a segv of the ppc64 mac99+cpu970 machine booting de=
bian.
> > See the stack trace below. Just wanted to let you know. I will digging =
further
> > next week.
> >
> > Thanks,
> >
> > C.
> >
> >
> >
> > Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
> > address_space_unmap (len=3D<optimized out>, access_len=3D0, is_write=3D=
false, buffer=3D0x0,
> >     as=3D0x5555565d45c0 <address_space_memory>) at ../system/physmem.c:=
3333
> > 3333      assert(bounce->magic =3D=3D BOUNCE_BUFFER_MAGIC);
> > (gdb) bt
> > #0  address_space_unmap
> >     (len=3D<optimized out>, access_len=3D0, is_write=3Dfalse, buffer=3D=
0x0, as=3D0x5555565d45c0 <address_space_memory>)
> >     at ../system/physmem.c:3333
> > #1  address_space_unmap
> >     (as=3Das@entry=3D0x5555565d45c0 <address_space_memory>, buffer=3D0x=
0, len=3D<optimized out>, is_write=3D<optimized out>, access_len=3D0) at ..=
/system/physmem.c:3313
> > #2  0x000055555595ea48 in dma_memory_unmap
> >     (access_len=3D<optimized out>, dir=3D<optimized out>, len=3D<optimi=
zed out>, buffer=3D<optimized out>, as=3D<optimized out>) at /home/legoater=
/work/qemu/qemu.git/include/sysemu/dma.h:236
> > #3  pmac_ide_atapi_transfer_cb (opaque=3D0x555556c06470, ret=3D<optimiz=
ed out>) at ../hw/ide/macio.c:122
> > #4  0x00005555559861f3 in DBDMA_run (s=3D0x555556c04c60) at ../hw/misc/=
macio/mac_dbdma.c:546
> > #5  DBDMA_run_bh (opaque=3D0x555556c04c60) at ../hw/misc/macio/mac_dbdm=
a.c:556
> > #6  0x0000555555f19f33 in aio_bh_call (bh=3Dbh@entry=3D0x555556ab5570) =
at ../util/async.c:171
> > #7  0x0000555555f1a0f5 in aio_bh_poll (ctx=3Dctx@entry=3D0x5555566af150=
) at ../util/async.c:218
> > #8  0x0000555555f0269e in aio_dispatch (ctx=3D0x5555566af150) at ../uti=
l/aio-posix.c:423
> > #9  0x0000555555f19d8e in aio_ctx_dispatch
> >     (source=3D<optimized out>, callback=3D<optimized out>, user_data=3D=
<optimized out>) at ../util/async.c:360
> > #10 0x00007ffff7315f4f in g_main_context_dispatch () at /lib64/libglib-=
2.0.so.0
> > #11 0x0000555555f1b488 in glib_pollfds_poll () at ../util/main-loop.c:2=
87
> > #12 os_host_main_loop_wait (timeout=3D2143429) at ../util/main-loop.c:3=
10
> > #13 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at ../util/mai=
n-loop.c:589
> > #14 0x0000555555abeba3 in qemu_main_loop () at ../system/runstate.c:826
> > #15 0x0000555555e63787 in qemu_default_main () at ../system/main.c:37
> > #16 0x00007ffff6e29590 in __libc_start_call_main () at /lib64/libc.so.6
> > #17 0x00007ffff6e29640 in __libc_start_main_impl () at /lib64/libc.so.6
> > #18 0x000055555588d4f5 in _start ()
>
> Thanks for the report!
>
> Mattias,
>
> Would you have time to take a look?

I noticed that the backtrace indicates address_space_unmap is called
with buffer=3D0x0, len=3D0. This wasn't really correct before my
concurrent bounce buffering change either, but it looks like the
previous code would have tolerated this to a certain extent (at least
no immediate crashes). Original code in question:

    if (is_write) {
        address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIED,
                            as->bounce.buffer, access_len);
    }
    qemu_vfree(as->bounce.buffer);
    as->bounce.buffer =3D NULL;
    memory_region_unref(as->bounce.mr);
    /* Clear in_use before reading map_client_list.  */
    qatomic_set_mb(&as->bounce.in_use, false);
    address_space_notify_map_clients(as);

address_space_write and qemu_vfree are safe to call with NULL/0
parameters. as->bounce.buffer =3D NULL would leak the buffer if one is
allocated, and memory_region_unref(as->bounce.mr) is only OK if the
bounce buffer hasn't been used before, otherwise we'd erroneously drop
a memory region reference.

We have two options here: Either we fix the caller to not call
address_space_unmap with buffer=3DNULL. Or alternatively we make
address_space_unmap NULL-safe by putting a check to return immediately
when being passed a NULL buffer parameter.

Looking at the code, the dma_memory_unmap calls in hw/ide/macio.c seem
to be passing buffer=3DNULL unconditionally, since the dma_mem field in
struct DBDMA_io is never set to anything non-zero. In fact, I believe
after commit be1e343995ef81fc05d9a4e1ec263ca171d842e7 "macio: switch
over to new byte-aligned DMA helpers", the dma_memory_unmap calls in
hw/ide/macio.c aren't doing anything and should probably have been
removed together with the dma_mem, dma_len and dir fields in struct
DBDMA_io. Speculative patch:

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index e84bf2c9f6..15dd40138e 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -119,9 +119,6 @@ static void pmac_ide_atapi_transfer_cb(void
*opaque, int ret)
     return;

 done:
-    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
-                     io->dir, io->dma_len);
-
     if (ret < 0) {
         block_acct_failed(blk_get_stats(s->blk), &s->acct);
     } else {
@@ -202,9 +199,6 @@ static void pmac_ide_transfer_cb(void *opaque, int ret)
     return;

 done:
-    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
-                     io->dir, io->dma_len);
-
     if (s->dma_cmd =3D=3D IDE_DMA_READ || s->dma_cmd =3D=3D IDE_DMA_WRITE)=
 {
         if (ret < 0) {
             block_acct_failed(blk_get_stats(s->blk), &s->acct);
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index 4a3f644516..c774f6bf84 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -44,10 +44,6 @@ struct DBDMA_io {
     DBDMA_end dma_end;
     /* DMA is in progress, don't start another one */
     bool processing;
-    /* DMA request */
-    void *dma_mem;
-    dma_addr_t dma_len;
-    DMADirection dir;
 };

 /*

C=C3=A9dric, can you try with the above patch and/or share more details of
your setup so I can verify (I tried booting a ppc64el-pseries dqib
image but didn't see the issue)?

Thanks,
Mattias

