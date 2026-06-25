Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D2CCDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wch1i-0003j8-Te; Thu, 25 Jun 2026 06:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wch1h-0003iP-G0
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:09:41 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wch1f-0006ya-7r
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:09:41 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6626cd98209so1935049d50.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 03:09:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782382178; cv=none;
 d=google.com; s=arc-20260327;
 b=UNg3Mlfq0Ru6h/8IVQTM0ekbgE8W4PsDExm+O42veGYfJetHKz1BN1tilcJ1smspwi
 zGdgpUoc8f6oWUetR8L/t4ehnNru16Th0bR0KRWORDXbGDs3aLFQXP5lrliqFOT8Juzq
 6BGFx6Ctl58Llc7fOgzuAIV+RKx0VBy2PvAnw6fCP452Hns5savyUtLV6+jnlp6Pwpc0
 7Nu4DQRDtswp1yTw2hD7nrbJGxshFjxmIIEDWyiFiR4xNvZhxhFMBWGQQxN+K4WcFQUx
 O3/r7jFvpZ3a10v4wyOhedCsJhwKt97ZyFOnxWw51wmUWdNUayOD9hrVbinM4L6pyii6
 uPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2nKcH8qE38wjQVeLh7HJGzQCXcEvMXoIqFdsSAingxM=;
 fh=BAhiOA9ROmGR2A0gLF2uLBewKAHP8+k1YA23nprKIp8=;
 b=KD9eTmEUvskMP/HfkRoHxVlanLQgxaIMecQB0eZnCgXHBRl1AanPj+oLk18jK22ZFH
 YXJQCd/O4DjeVYBqCnft/1JEllV25m5mWT/hMKttFt2s8av51coD+EO45oGwZ2yoP5ZF
 kpbUO8AQpQO4fVyznvzfFw7O1OLB9H8PD/Td/d9U8qJ3jnXUDWC92wIcxsZZpTZowBcH
 vzj/3TDzIpJXXmJsZFfQ+GFJLQDOjvmWAcHiRpPabKt9Qcw9NJcdNtSoh6A6iTvIuuWC
 f2m77AfqufmKTw+1M3tBiLbF70+4rn9gwEWeTJ5LH6zZE48C64W7ju4zEcxopDXev5/5
 R8jg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782382178; x=1782986978; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2nKcH8qE38wjQVeLh7HJGzQCXcEvMXoIqFdsSAingxM=;
 b=tWzxUtfAU0cZ+mddu7gsuvkaNpAwQUMvca980hoW22wZXLuhP8abVWe7FZVBpcfVJF
 9A+l1ZddkQVz4MiaqBpkkVqaxb1r8hgmt1kACQW3sijWB2g8cHLTWqpuj4PAgM71f2n6
 HtdWx1bPYt+kFC1j81UmGMj7P2tTDfNJ763qQdMuHpo0uePkrvb2X7ty1eHqhJKHMWUj
 VYmqbqiNvlguo/dk2+YzztTjRLS1b/KljzQ9qCyiInddD1ZxqEYW2ct62KleHm0TSc2Z
 itHZPvZlzs/ltTl++tRXRe/FHW0zQkFzLg2re1BtYZtRwYxaDHg7EL6SmgmfnoqjmQp+
 E4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782382178; x=1782986978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nKcH8qE38wjQVeLh7HJGzQCXcEvMXoIqFdsSAingxM=;
 b=DWnQAmSvYzU9SJvCy6KfPym0RZggyfgDLgzgqCqxX5gw+R4TLTtRwoFt+1aaAwrDVk
 SbLEbMFiUguNpx/+rXcAYtqMB/XqIgOD342k6Bm4emwvPhAOnNjMfPhHXQLlc3CiVsjT
 Aj2u+jMdMJ1xRG+lEVz8H2Y3vkFKYAPL7gDzcCVW3cjPydbIe5pTCyBAGcotDaZahdJl
 BDveUCBGb5rSsPKsXt3i7qYy7Kmgeukd2i2QU8rckpwOec2O8LbRvpna8Fzg65ZDC8z4
 W3pO585DMvDtYywSiHx/F56QIoCGEkBWTTep/nhFXaORbRSkwqVRJ7G/KSRG4Hr01IM9
 k0Jg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkBXMKd5rMxyPkqf1AL0ZdBTs+SWjW3VupGjvBu9+jpVyHWZBvjiOUNXKLUZwHqqaKPkkGrdgBzqk3@nongnu.org
X-Gm-Message-State: AOJu0YyalTRYIzXhdJqWdQJDRoij/aP2+BJy6ug5CBfCg/gO0MYkoiqz
 rRe0HfdG+sB+HUScDfLdk7mOpCptIqcz+wDwOBcH1eTl+2j3OlyunVHUSWV1Yfqp2bzlHDOvM3f
 EXCxZd2iF9Fh+L2HmCgib5UWHkYl7hT7PADfGMIqxMA==
X-Gm-Gg: AfdE7ck7W+vlOYfnwKEd200KBDnzzz6lhyXBq4Rj8AKK2k9NzuSgDJgGTFYMXwPT8Kq
 uDSL3ePZCu314Uja01LiFeJW66DQgPgOnS8Zz/94KptmZtU+B/uweo7SkKurAJWtUJCtkI5K2Pt
 QQorTAVMX1Y/GR25NuUyuXgXP8855x6wdMS2Q+gYuoxBcYcmNPdhGgoZM+4xeDnwxyP9PKmY/f5
 IgAOTK2Ani3rZgnjC92K16U/caeIcMr6Jj50l7IEUW7rZ/X6ZM101nCOUUcrSHmBhPvVS7I6QJi
 2GEVbu3Bozv+7tyZJLlcepbts0YP0sX1SMbLrzBx1qdfXQaOJkI7opBF
X-Received: by 2002:a05:690e:d45:b0:658:f1c8:eab5 with SMTP id
 956f58d0204a3-66487f3f47dmr1179067d50.5.1782382177644; Thu, 25 Jun 2026
 03:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260616052552.389021-1-gshan@redhat.com>
 <20260616052552.389021-2-gshan@redhat.com>
In-Reply-To: <20260616052552.389021-2-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 11:09:26 +0100
X-Gm-Features: AVVi8CdWV9N7rq0uuq6ckKY00_Ql_SZuCncvodGyVc97tYPyf19w0MvVKl5PK5I
Message-ID: <CAFEAcA-mf14=jpRFHarAbN6AbQwvW=Yu6WB1JiNMsECEdaxD3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com, 
 peterx@redhat.com, alex@shazbot.org, richard.henderson@linaro.org, 
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com, 
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com, 
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, 
 shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 16 Jun 2026 at 06:26, Gavin Shan <gshan@redhat.com> wrote:
>
> All ram device regions were turned to be indirectly accessible by commit
> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
> to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
> guest is started by the following command lines, with GH100 GPU card passed
> from the host.
>
>    host$ lspci | grep GH100
>    0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
>    host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64            \
>          -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
>          -accel kvm -cpu host -smp cpus=48 -m size=8G                       \
>          -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
>          -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
>          -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0
>            :
>    guest$ cd cuda-samples/build
>    guest$ make -j 20 clean
>    guest$ make -j 20
>            :
>    [ 54%] Linking CUDA executable graphMemoryNodes
>    [ 54%] Built target graphMemoryNodes
>    <no more output afterwards, guest becomes frozen here>
>
>    guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resources
>    [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byte logical blocks (137 GB/128 GiB)
>
> When the GPU's driver (NVidia open driver) is loaded on guest bootup,
> the memory blocks residing in the PCI BAR#4 of the GH100 GPU card can
> be presented to the guest through memory hot-add. The page cache can
> then be allocated from the hot added memory blocks when cuda-samples
> is being built. Afterwards, the page cache is sent to QEMU's virtio-blk
> device as part of the DMA request, the bounce buffer has to be used to
> accomodate the request as the corresponding memory region (MemoryRegion)
> is an indirectly accessible ram device region in qemu. However, the max
> bounce bufer size is only 4096 bytes by default and that is exhausted
> quickly, leading to a reset on the virtio-blk device and frozen guest
> eventually.
>
>   QEMU
>   ====
>   virtio_blk_handle_output
>     virtio_blk_handle_vq
>       virtio_blk_get_request
>         virtqueue_pop
>           virtqueue_split_pop
>             virtqueue_map_desc
>               address_space_map
>                 memory_access_is_direct         # Return false
>                   memory_region_supports_direct_access
>
>   (qemu) info mtree
>   memory-region: pci_bridge_pci
>     0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
>       0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
>         0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
>           0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]
>
> This adds qemu_ram_{copy, move}() and replaces {memcpy, memmove}() with
> them in the ram device memory region accessors, similar to what's done
> in commit 4a2e242bbb so that the issue (MMIO access instructions were
> optimized to SSE instructions) covered by that commit is fixed. This
> makes 'ram_device_mem_ops' redundant, paving the way to revert that
> commit to make ram device region directly accessible again in the next
> patch.
>
> Reported-by: Julia Graham <jugraham@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v3: Documentation for qemu_ram_{copy, move}           (Peter/Michael)
>     Support qemu_ram_move() for overlapped src/dest   (Richard)
>     Use {memcpy, memmove} if step is 16-bytes or more (Michael)
>     Code improvements                                 (Richard/Michael)
> ---
>  hw/remote/vfio-user-obj.c |   4 +-
>  include/system/memory.h   |  32 ++++++-
>  system/physmem.c          | 178 +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 207 insertions(+), 7 deletions(-)
>
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 87fa7b6572..97a6c88780 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -375,9 +375,9 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
>          ram_ptr = memory_region_get_ram_ptr(mr);
>
>          if (is_write) {
> -            memcpy((ram_ptr + offset), buf, size);
> +            qemu_ram_copy(ram_ptr + offset, buf, size);
>          } else {
> -            memcpy(buf, (ram_ptr + offset), size);
> +            qemu_ram_copy(buf, ram_ptr + offset, size);
>          }
>
>          return 0;
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 1417132f6d..84203c312d 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -2897,6 +2897,36 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
>  void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
>
>  /* Internal functions, part of the implementation of address_space_read.  */
> +
> +/**
> + * qemu_ram_copy: copy data to ramblock
> + *
> + * @dst: destination where the data is copied to
> + * @src: source where the data is copied from
> + * @n: length of data to be copied
> + *
> + *
> + * Copy @n bytes from @src to @dst with the assumption that @src and @dst
> + * do not overlap. Handles special cases such as uncacheable ramblocks
> + * correctly. Use this for accessing ramblock in response to DMA/VCPU IO,
> + * in preference to memcpy().
> + */

The documentation for these functions needs to say what semantics
the function is providing (e.g. can I rely on it to do a 4 byte aligned
load as a single 4 byte read?). This does not.

> +/* x86 should work with __builtin_{memcpy, memmove}() for IO access */
> +#if defined(__i386__) || defined(__x86_64__)
> +#define HOST_UNALIGNED_MMIO_OK 1
> +#else
> +#define HOST_UNALIGNED_MMIO_OK 0
> +#endif

This is still wrong. We should not have "x86 magically works
and all other hosts do something different" ifdefs. Define what
semantics you need and then we can figure out how to
implement them.

My current thought is that we need to handle accesses of
1, 2, 4 and 8 bytes that are naturally aligned by ensuring that we
do exactly one host load/store of that type, and that anything else
is "the guest isn't relying on specific semantics here, we can just
assume it's plain old RAM and do whatever". That would not
require any architecture specific ifdefs.

thanks
-- PMM

