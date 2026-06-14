Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE7DCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYmyT-0001Ho-Mg; Sun, 14 Jun 2026 11:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYmyS-0001HU-2U
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 11:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYmyQ-0005BS-7h
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 11:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781451728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHth61AMnV8KAZ6R6fy19N4iioXaFMs9iX00iwFTPy8=;
 b=GOCF9e6aiRwB8whOhTNopQi0U/L6NtIoQIKthC7sAWyBBoupUpPBlaixbLuHvZMbNgfEF2
 +2Bel66l9ScQu0392qxa5hXFhQuOV/lB204O/3Gq83GZHafcmFtOEx8IP1oS7vu+Z//4wX
 oxYOzX93RRxzQFoiuvBX+WgdK9HOjuY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-p4AsdZIBOUu4SNXfFCtxWA-1; Sun, 14 Jun 2026 11:42:07 -0400
X-MC-Unique: p4AsdZIBOUu4SNXfFCtxWA-1
X-Mimecast-MFC-AGG-ID: p4AsdZIBOUu4SNXfFCtxWA_1781451726
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45ef5e38a18so1131391f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 08:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781451726; x=1782056526; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uHth61AMnV8KAZ6R6fy19N4iioXaFMs9iX00iwFTPy8=;
 b=Rf4wn2gNwaMzz7VR3/GatzXOVVhPPmekgOIwgDBdRnnhfejs2NqMBxPAOINTsvqVWF
 gXcsi2sTZV32XIwD2JTTk6u3JI5O6464bcSYg0D/+iyLNo3zSs2HcoZqOcz0JuutpHq6
 AUue0G/RBlKWqWHCoQBIayQF09wYL0SqYtAzQPw2yxxFASW8O3WVB8+IxD1BPvxIVk8h
 q+fahn6cQOOayNGUSRl1PecfbH9P2tTRr4PvKntlWdmbwckDOLzH6+PVV/ygY2ekCOvU
 pX7DURI5OAU0op98FVfWrRl6je7psuqMurOPaM452noI1jvxfOApPh3ffyN6CeC6AXF5
 Bg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781451726; x=1782056526;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uHth61AMnV8KAZ6R6fy19N4iioXaFMs9iX00iwFTPy8=;
 b=WvMjaYLw3qK7kYF/SKsL2i2u2FaWe2bSNiAcFc+JIFkt/7VzlHD/0cg/mpNdEPxF1A
 2QHbG2U7+h1F7Pxa5VOyy/C29AKqA7vJgKBad3CPrAxmiQn5HMV0ZQ4FpS0bvMdt/A5N
 YZSBRCkjtNIdGU4cI2xv2IIvA/god9w6b0UFKF3olfJgIRkKavrzzDaDoW/Hok5B8zrl
 CBRn+gOVodNZKRJgMTxGIJEkcWxyKVcIA9PfpFyMsKZvMnC8gd9sSPCBMrPSWq0kiv2G
 r3+e7dVeqQYF5YK+7Qo8BbLG80TFYqZklxboNelovrzy6INz6H/gQ/z7nVNxWzG40aoC
 uumQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/R7yDwOrWM+uJH5Z5Nsyt0R4iOfzz3r/jQCYrAeq9lG7EK42y4iMY3iNFFI6pV4Of+eQewHTbFtEQh@nongnu.org
X-Gm-Message-State: AOJu0Yyz3ZHchYn8RpjVh2biPSi8yVRL+PI3XTC+DfXi8+Fehi0gqDrC
 5FM5ID9Qqc/OX9Yt0T6GJQ1gX++ZE1tDMBUwRbGmxphFcmhapEQXSOeHVH+3zvG0Ciggc92Y86C
 r2VX2G+mHgFkLo/fckfj3cNHZmMH4/OeKC7rG8jR8VY6h4TeFyn+OND/s
X-Gm-Gg: Acq92OGcDobCrsdeWMx9e32GCMKlFuDKlJfjgAjAkmj585DzKm9dh//oLACnz/Zw3Bq
 XWoTUfxL4+dHwoLdIP/hi1EZNtW5yokZWn3FwYafyf/NbzEXIyrLfca9yTLCUNXWnazUzmAocos
 y/eGipTK3jaayUOF9M22YRH/cU+TTD0FqaiU7xbMt8oUeh7UXy2Auf4KFRCxG/dJWmNJ+ckGhN3
 8bpQ6m7C6ZPr6mIUYhYELF0lGSo+DA0H+hLpGviPkucAG/UPCIWr7af6JHVNNLutSB+QCxQDwZ0
 dKqh2DuFCUXPb/95c5mL0iOtg/mBrUNnz9yC+tTImfnwiDEJkg5eDWj1KDwo9w2gJEE3CYmE2Cy
 pdE+1NXWqG7JkJBzPJ1McPZHJXACy7iP52WQ2/xPeP3Q=
X-Received: by 2002:a05:6000:2082:b0:45e:8526:7dc8 with SMTP id
 ffacd0b85a97d-46076b18ccbmr8845892f8f.25.1781451725981; 
 Sun, 14 Jun 2026 08:42:05 -0700 (PDT)
X-Received: by 2002:a05:6000:2082:b0:45e:8526:7dc8 with SMTP id
 ffacd0b85a97d-46076b18ccbmr8845841f8f.25.1781451725426; 
 Sun, 14 Jun 2026 08:42:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3782sm22631620f8f.25.2026.06.14.08.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 08:42:04 -0700 (PDT)
Date: Sun, 14 Jun 2026 11:42:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, peter.maydell@linaro.org,
 berrange@redhat.com, david@kernel.org, alex@shazbot.org,
 clg@redhat.com, pbonzini@redhat.com, philmd@mailo.com,
 phrdina@redhat.com, jugraham@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 1/2] system/memory: Use __builtin_mem{cpy, move} in
 accessors of ram device region
Message-ID: <20260614112224-mutt-send-email-mst@kernel.org>
References: <20260612110307.1264798-1-gshan@redhat.com>
 <20260612110307.1264798-2-gshan@redhat.com>
 <223f5f94-b9b7-46b0-8466-5be655203a0e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <223f5f94-b9b7-46b0-8466-5be655203a0e@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jun 12, 2026 at 08:29:34AM -0700, Richard Henderson wrote:
> On 6/12/26 04:03, Gavin Shan wrote:
> > All ram device regions was turned to be indirectly accessible by commit
> > 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
> > to guest hang on compiling 'cuda-samples' as reported by Julia. The guest
> > is started by the following command lines, with a GH100 GPU card.
> > 
> >     host$ lspci | grep GH100
> >     0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
> >     host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64            \
> >           -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
> >           -accel kvm -cpu host -smp cpus=48 -m size=8G                       \
> >           -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
> >           -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
> >           -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0
> >             :
> >     guest$ cd cuda-samples/build
> >     guest$ make -j 20 clean
> >     guest$ make -j 20
> >             :
> >     [ 54%] Linking CUDA executable graphMemoryNodes
> >     [ 54%] Built target graphMemoryNodes
> >     <no more output afterwards, guest becomes frozen here>
> > 
> >     guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resources
> >     [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byte logical blocks (137 GB/128 GiB)
> > 
> > When the GPU's driver (NVidia open driver) is loaded on guest bootup,
> > the memory blocks residing in the PCI BAR#4 can be presented to the
> > guest through memory hot-add. The page cache can be allocated from the
> > hot added memory blocks when cuda-samples is being compiled. Afterwards,
> > the page cache is sent to QEMU's virtio-blk device as part of the DMA
> > request, the bounce buffer has to be used to accomodate the request as
> > the corresponding memory region (MemoryRegion) is a RAM DEVICE region
> > and indirectly accessible in qemu. However, the max bounce bufer size
> > is only 4096 bytes by default. We're running out of that space quickly.
> > 
> >    QEMU
> >    ====
> >    virtio_blk_handle_output
> >      virtio_blk_handle_vq
> >        virtio_blk_get_request
> >          virtqueue_pop
> >            virtqueue_split_pop
> >              virtqueue_map_desc
> >                address_space_map
> >                  memory_access_is_direct         # Return false
> >                    memory_region_supports_direct_access
> > 
> >    (qemu) info mtree
> >    memory-region: pci_bridge_pci
> >      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
> >        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
> >          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
> >            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]
> > 
> > This replaces mem{cpy, move} with __builtin_mem{cpy, move} in the memory
> > accessors to ram device memory region, preparatory work to make ram device
> > region directly accessible and bypass the bounce buffer in the DMA path
> > in next patch.
> 
> memcpy/memmove *always* compile to __builtin_memcpy/memmove, and the
> compiler later decides whether or not to expand inline.

Did some research.

The issue that prompted use of __builtin_memcpy in bswap.h is musl's fortify headers
that Alpine Linux was using back in 2019.

Try this:
git clone --depth=1 https://github.com/jvoisin/fortify-headers /tmp/fortify-headers
git -C /tmp/fortify-headers checkout 5aabc7e~1

now:

musl-gcc -O2 -D_FORTIFY_SOURCE=2 -isystem /tmp/fortify-headers/include -S -o- test.c
where test.c is:

#include <string.h>
#include <stdint.h>

void test_memcpy(void *dst, const void *src) {
    memcpy(dst, src, 4);
}

void test_builtin_memcpy(void *dst, const void *src) {
    __builtin_memcpy(dst, src, 4);
}




On x86:

    test_memcpy:
     .LFB13:
        .cfi_startproc
        cmpq    %rsi, %rdi
        jnb     .L2
        leaq    4(%rdi), %rax
        cmpq    %rax, %rsi
        jb      .L6
     .L4:                                                                                            
        movl    $4, %edx
        jmp     memcpy
        .p2align 4,,10
        .p2align 3
     .L2:
        cmpq    %rdi, %rsi
        jnb     .L4
        leaq    4(%rsi), %rax
        cmpq    %rax, %rdi
        jb      .L3
        movl    $4, %edx
        jmp     memcpy
     .L6:
        jmp     .L3
        .cfi_endproc
        .section        .text.unlikely
        .cfi_startproc
        .type   test_memcpy.cold, @function
     test_memcpy.cold:
     .LFSB13:
     .L3:
        ud2
        .cfi_endproc
     .LFE13:
        .text
        .size   test_memcpy, .-test_memcpy



A jmp so a function call.
While builtin:



     test_builtin_memcpy:
     .LFB14:
        .cfi_startproc
        movl    (%rsi), %eax
        movl    %eax, (%rdi)
        ret
        .cfi_endproc
     .LFE14:
        .size   test_builtin_memcpy, .-test_builtin_memcpy



So it's a fortify headers Version 1.0 bug.  Version 1.1 has the fix.

I guess we should rewrite bswap.h then.


> So, this doesn't do what you think it does.
> My real question is: what are you attempting to achieve?
> 
> (1) is the problem unaligned access to a mapped physical device?
> (2) is the problem vector access to a mapped physical device?
> (3) something else?
> 
> 
> r~


