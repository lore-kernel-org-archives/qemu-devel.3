Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B93DCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 06:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZN7b-0006O8-WF; Tue, 16 Jun 2026 02:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZN7Z-0006N8-R5
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 02:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZN7X-0007pK-Dv
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 02:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781590678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9IzRjMQ4xtrBSxUkY4wxI23oGICvXeEXxGt+AWT/QzE=;
 b=WjL9R8ryDUUTMbksbfSkVwVauQBLHmDTbapREO0XiUPsc90D5yEyInPpNatTwq9CFwe/Ny
 1+e4obOHvAFLz8mwTfGFmdfb/PV0SSKBrFR/j9GvZ4OjNTR/kT02pQVbm0C0Sf7dn2eWZo
 t57Ta1I8u8OnxDKVFIqGyEfGcjd6ofU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-SEbMv_bWMeKwr_Exa0is6w-1; Tue, 16 Jun 2026 02:17:56 -0400
X-MC-Unique: SEbMv_bWMeKwr_Exa0is6w-1
X-Mimecast-MFC-AGG-ID: SEbMv_bWMeKwr_Exa0is6w_1781590675
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490aadb1386so25471555e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 23:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781590675; x=1782195475; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9IzRjMQ4xtrBSxUkY4wxI23oGICvXeEXxGt+AWT/QzE=;
 b=RfVQenLjuvqRHjsq9FbgHgt9BocCZ2j5A13VN784Fe1YEaZ+FchbyZxtp1bwtLty00
 6WjBsCCeFvpemAluEKQemMQ6N+IOIIA5CQvistXEanunkBye5Gtpo5TPgk5SB0sztJKo
 zpQp9zJSvMD1bkemYj9i0XQXVrR50smtzFwVznLb650gQc/ffEjCBRAEgQ7bVn3vrjyf
 pOK23gTcpnCUU9YoffZOn1j+F3RKrr0rUjxPCAuirki0rbc+8/NGbfylmSspxTFtLr8Q
 jrWlqk14H0A/92FnlJkq9DCmfmBjQ29/NYEnFD6gJHD8yY7U3RIQy8MUECW/y49f8hcW
 +y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781590675; x=1782195475;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9IzRjMQ4xtrBSxUkY4wxI23oGICvXeEXxGt+AWT/QzE=;
 b=HTHnw4eGL2HLflsCxIn/MHzaAt25jN7h8qIzDt1tVVsknM+7qY+DM3nUNCuxwd5dKD
 Q63NY+dWJMvhfdR8cbkBHchCfwXq4ANrL7fQi+3MTqphZCfM+PT/+0MYIOwsz19Abine
 Tb/YSfbmb3Y1UYF6jBmyt9lnGUpu0tFlBsh0yotDeuHcv1WWoOYXNOdtaTWJBpJ0GHXh
 w2UXVV/SPBfSe97EUSZUtSEUXBIQzDcjl94R8wf/06WXVHUisg6gm9avSBDKh6iEn1da
 cZxcJrprWAAuJhWafMNFXgnMNY2X0Ms4pzQhQEGLTmtDcf66Nnp1lmRs2kLD6NHs8tFy
 2P5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VvTepxRtY2HTj/F21c/8FRQmEFskhSn8On0XJDXEi+b6R82fdk5mfUIyYJ1O2CdLhO8of5a0ebbUm@nongnu.org
X-Gm-Message-State: AOJu0YzSDGfXibZlUUL0v1rTv31IO7/X/7Lhq2f7ZFnad2/zouREUK+f
 w5OWnmI/U+LFc505GjHp2f0SZz40yWELR4QH1sOvsUvhcvAjGG+Grgm1jm8zOF8X41pNww3JG6V
 j9zyLPC1gnpho7CraG9+Goxw2H8f4LDWgb117Odu+iv2kDQmvuzyTRVyp
X-Gm-Gg: Acq92OHLj7YtafoLbFz+C5XFoqugofBezGnpm4HfDsON+M0us9L8Kgq6mTCXutxkySx
 dP0Rehjhvgpr9FZOozvIP9aMppqS/FDFJzm8GLAhkQuLYv38kktOorAIEafmRLeHXcR5dlm0c9z
 51Z9GAhDCsWsRV9I4cVicpKDhOtERbjUd1EjwP8gFpYhZGHSgy3YzJs8ySayeKSqCeOuF0kqZSj
 HFv30t0/PTX8hoi9xCjsE/S+E2qspXuFMb9E8z9NyAJuaACMFt6BEmIgm52vX+rY7t8+ltaCyi4
 3vKeKGyXwm25f+gLKz3wqSuRDhUsMk6QBlAA5GEVKL6HxEYg+r4TWX6CmoqrrUzMYiS8zdKjJQ2
 Oqb4i02wYoGR0W7cbBXn9cqY0dgJVnYDHtG7ApLZ6fy4=
X-Received: by 2002:a05:600c:810b:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-4922fac1214mr33440105e9.6.1781590675263; 
 Mon, 15 Jun 2026 23:17:55 -0700 (PDT)
X-Received: by 2002:a05:600c:810b:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-4922fac1214mr33439455e9.6.1781590674723; 
 Mon, 15 Jun 2026 23:17:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a8ebe3sm25224545e9.11.2026.06.15.23.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 23:17:54 -0700 (PDT)
Date: Tue, 16 Jun 2026 02:17:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 alex@shazbot.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260616021153-mutt-send-email-mst@kernel.org>
References: <20260616052552.389021-1-gshan@redhat.com>
 <20260616052552.389021-2-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616052552.389021-2-gshan@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 16, 2026 at 03:25:51PM +1000, Gavin Shan wrote:
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
> +void qemu_ram_copy(void *dest, const void *src, size_t n);
> +
> +/**
> + * qemu_ram_move: move data to ramblock
> + *
> + * @dst: destination where the data is moved to
> + * @src: source where the data is moved from
> + * @n: length of data to be moved
> + *
> + * Move @n bytes from @src to @dst with the assumption that @src and @dst
> + * can overlap. Handles special cases such as uncacheable ramblocks
> + * correctly. Use this for accessing ramblock in response to DMA/VCPU IO,
> + * in preference to memmove().
> + */
> +void qemu_ram_move(void *dest, const void *src, size_t n);
> +
>  MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
>                                      MemTxAttrs attrs, void *buf, hwaddr len);
>  MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
> @@ -2970,7 +3000,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
>              mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
>              if (len == l && memory_access_is_direct(mr, false, attrs)) {
>                  ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> -                memcpy(buf, ptr, len);
> +                qemu_ram_copy(buf, ptr, len);
>              } else {
>                  result = flatview_read_continue(fv, addr, attrs, buf, len,
>                                                  addr1, l, mr);
> diff --git a/system/physmem.c b/system/physmem.c
> index 7bcbf87573..45a17cd580 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3160,6 +3160,177 @@ void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
>      invalidate_and_set_dirty(mr, addr, size);
>  }
>  
> +static void qemu_ram_copy_aligned(void *dst, const void *src, size_t n)
> +{
> +    switch (n) {
> +    case 1:
> +        __builtin_memcpy(dst, src, 1);
> +        break;
> +    case 2:
> +        __builtin_memcpy(dst, src, 2);
> +        break;
> +    case 4:
> +        __builtin_memcpy(dst, src, 4);
> +        break;
> +    case 8:
> +        __builtin_memcpy(dst, src, 8);
> +        break;
> +    default:
> +        memcpy(dst, src, n);
> +    }
> +}
> +
> +static void qemu_ram_move_aligned(void *dst, const void *src, size_t n)
> +{
> +    switch (n) {
> +    case 1:
> +        __builtin_memmove(dst, src, 1);
> +        break;
> +    case 2:
> +        __builtin_memmove(dst, src, 2);
> +        break;
> +    case 4:
> +        __builtin_memmove(dst, src, 4);
> +        break;
> +    case 8:
> +        __builtin_memmove(dst, src, 8);
> +        break;
> +    default:
> +        memmove(dst, src, n);
> +    }
> +}

A weird name for this. You call it for both aligned and unaligned.

maybe this is _unsafe and the "unaligned" below is _safe ?




> +
> +static void qemu_ram_copy_unaligned(void *dst, const void *src,
> +                                    size_t n, size_t max_step)
> +{
> +    uintptr_t test, step;
> +
> +    /* Aligned maximal step */
> +    max_step = pow2floor(max_step);
> +
> +    while (n) {
> +        test = (uintptr_t)src | (uintptr_t)dst | n | max_step;
> +        step = test & -test;
> +
> +        switch (step) {
> +        case 1:
> +            qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
> +            src += 1;
> +            dst += 1;
> +            n -= 1;
> +            break;
> +        case 2:
> +            qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
> +            src += 2;
> +            dst += 2;
> +            n -= 2;
> +            break;
> +        case 4:
> +            qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
> +            src += 4;
> +            dst += 4;
> +            n -= 4;
> +            break;
> +        case 8:
> +            qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
> +            src += 8;
> +            dst += 8;
> +            n -= 8;
> +            break;
> +        default:
> +            memcpy(dst, src, step);
> +            src += step;
> +            dst += step;
> +            n -= step;
> +        }
> +    }
> +}
> +
> +static void qemu_ram_backwards_copy_unaligned(void *dst, const void *src,
> +                                              size_t n, size_t max_step)
> +{
> +    uintptr_t test, step;
> +
> +    /* Aligned maximal step */
> +    max_step = pow2floor(max_step);
> +
> +    /* End of the blocks */
> +    src += n;
> +    dst += n;
> +
> +    while (n) {
> +        test = (uintptr_t)src | (uintptr_t)dst | n | max_step;
> +        step = test & -test;
> +
> +        switch (step) {
> +        case 1:
> +            src -= 1;
> +            dst -= 1;
> +            n -= 1;
> +            qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
> +            break;
> +        case 2:
> +            src -= 2;
> +            dst -= 2;
> +            n -= 2;
> +            qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
> +            break;
> +        case 4:
> +            src -= 4;
> +            dst -= 4;
> +            n -= 4;
> +            qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
> +            break;
> +        case 8:
> +            src -= 8;
> +            dst -= 8;
> +            n -= 8;
> +            qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
> +            break;
> +        default:
> +            src -= step;
> +            dst -= step;
> +            n -= step;
> +            memmove(dst, src, step);
> +        }
> +    }
> +}
> +
> +/* x86 should work with __builtin_{memcpy, memmove}() for IO access */
> +#if defined(__i386__) || defined(__x86_64__)
> +#define HOST_UNALIGNED_MMIO_OK 1

maybe HOST_UNALIGNED_VECTOR_MMIO_OK ? We also care that vector stores
are safe.

> +#else
> +#define HOST_UNALIGNED_MMIO_OK 0
> +#endif
> +
> +void qemu_ram_copy(void *dst, const void *src, size_t n)
> +{
> +    if (dst == src || n == 0) {
> +        return;
> +    }
> +
> +    if (HOST_UNALIGNED_MMIO_OK) {
> +        qemu_ram_copy_aligned(dst, src, n);
> +    } else {
> +        qemu_ram_copy_unaligned(dst, src, n, 8);
> +    }
> +}
> +
> +void qemu_ram_move(void *dst, const void *src, size_t n)
> +{
> +    if (src == dst || n == 0) {
> +        return;
> +    }
> +
> +    if (HOST_UNALIGNED_MMIO_OK) {
> +        qemu_ram_move_aligned(dst, src, n);
> +    } else if (dst < src) {
> +        qemu_ram_copy_unaligned(dst, src, n, src - dst);
> +    } else {
> +        qemu_ram_backwards_copy_unaligned(dst, src, n, dst - src);
> +    }
> +}
> +
>  int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
>  {
>      unsigned access_size_max = mr->ops->valid.max_access_size;
> @@ -3272,7 +3443,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
>          uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>                                                 false, true);
>  
> -        memmove(ram_ptr, buf, *l);
> +        qemu_ram_move(ram_ptr, buf, *l);
>          invalidate_and_set_dirty(mr, mr_addr, *l);
>  
>          return MEMTX_OK;
> @@ -3365,7 +3536,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
>          uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>                                                 false, false);
>  
> -        memcpy(buf, ram_ptr, *l);
> +        qemu_ram_copy(buf, ram_ptr, *l);
>  
>          return MEMTX_OK;
>      }
> @@ -3503,8 +3674,7 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
>              l = memory_access_size(mr, l, addr1);
>          } else {
>              /* ROM/RAM case */
> -            void *ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> -            memcpy(ram_ptr, buf, l);
> +            qemu_ram_copy(qemu_map_ram_ptr(mr->ram_block, addr1), buf, l);
>              invalidate_and_set_dirty(mr, addr1, l);
>          }
>          len -= l;
> -- 
> 2.54.0


