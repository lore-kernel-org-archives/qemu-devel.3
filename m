Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD3BC282C1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 01:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnp2X-0006Vb-EV; Thu, 27 Feb 2025 20:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tnp2P-0006Sd-8r; Thu, 27 Feb 2025 20:19:38 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tnp2N-0002oR-8j; Thu, 27 Feb 2025 20:19:37 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-521c478d433so743887e0c.0; 
 Thu, 27 Feb 2025 17:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740705573; x=1741310373; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jlK16RNducbvQEuAHjldApuBirP4j8l8j9PAI4j0Xg=;
 b=ZZkd3DghvIY0KBCmL8UBOkZmAIlpgithjc71WhLhgEhYyfQTPWseb18fMGbGd1gix/
 dZQ/rDWRg3BYHxozF8rjxWBi/XuUue55X7/raw9dYSIt87iax6UV2QS5YLwyJ3sH0C1f
 4d0eIHr7skLYW39wh0cvTEfICgo3uEPUiot3fFdFkhnUCK5daJTM41Z2Cs4mg9Kf1W92
 56kORCwA3Ji0DQKwmkyzkHaMrdOzhkBEB6h27wfzmD8P/IOQ+50OIyD0Y7op5LU6OXI3
 0yfa8BvG8ZlLrKTuZ58IlLcI/S2rD9q3d63GjoFNCsrxCI4Y6l4DPaQRtFZTFvmT3Vi6
 hUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740705573; x=1741310373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1jlK16RNducbvQEuAHjldApuBirP4j8l8j9PAI4j0Xg=;
 b=eDVIQHOvRUBlsvIHnH2NjV9PCtmpwLzhjif1AMtU6iPDPu6+x2dCQsjmpQPwa46rAN
 lSg3c/Gh2Sqi7WFk30cnZcEwvVLTBcp1b+fBvCtsT/EvzlhMn4RPEouPLzIN2EEt0Oa4
 ofIHBPnVYUxT+df31UCbhoizcd5el80tPvu16tyHPd8AEpVQS/DoNnFZ+2SpmlwPYxlL
 DV55UPHGx2qiwclPNQl+kaQ60h7sZf8FnteP4TowosNBRcQyyM58gvlqNRnlbkCKkrhe
 0MLaZFBpf2rQNyY1uWkjamLKWXE8BTdR36RnP5It2cHaxrnw1TaKiiM1BlXHTWDOv3JJ
 ewmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNxLHBkh6VGDBk7mPqJpIMqja1NMybOD462K+ZpbFH5/xWm7LNqbPL+mofLR+vXuoIMIqI89rffinZ@nongnu.org
X-Gm-Message-State: AOJu0YyHmbNX31XFBTDGxm5G/WOUG356b62zXOH3dHQTF4giWGhOyDC5
 47CYv6V/6mANcbvCIL/Rh6Uf2W0QMsPTqIBXA4kcARrw4MQf7Jh279IHjP8HN5mbajo0mocg77v
 +Aupu2k1KbRqwBVhOzrqzjZw3puQ=
X-Gm-Gg: ASbGncurmvWUlSvte8SlTU8EhGgMgCPYk7d9TEw3sF6kDGfPBWXiXcXLkYi5wQ32Jzx
 OrDJwOyuWG9E1K1i6360Ojjukk5H5WGuxJBD9LeVxCSiox2LsssKQczT/IKrCLz8Dm6VIXxlTM8
 wsqs0YIrCvlmgvCxv9OD43cpD86vVMZp8Atmvz
X-Google-Smtp-Source: AGHT+IHQDB3esgrs6vxN97UuZohLEKgDOa0nZ/JD8cesdOyf1xwBTZPy5QUdovA4PEmuVdAG8wGbYX3vuXQawdb8kbU=
X-Received: by 2002:a05:6102:3910:b0:4bb:d062:43e with SMTP id
 ada2fe7eead31-4c044528389mr1619854137.0.1740705573090; Thu, 27 Feb 2025
 17:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20250122083617.3940240-1-ethan84@andestech.com>
 <20250122083617.3940240-3-ethan84@andestech.com>
In-Reply-To: <20250122083617.3940240-3-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Feb 2025 11:19:06 +1000
X-Gm-Features: AQ5f1Jo8etBIkHbZrP0bZUwKIvsNqfSkOSFZKCkFWZcM0gkB0ezDBGA4ULr38Y0
Message-ID: <CAKmqyKPQWL=o3FohvdK=re5rwmrN=znZna2=QCB3z9rk_uZWVw@mail.gmail.com>
Subject: Re: [PATCH v10 2/8] memory: Introduce memory region fetch operation
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Jan 22, 2025 at 6:39=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> Allow memory regions to have different behaviors for read and fetch
> operations.
>
> For example, the RISC-V IOPMP could raise an interrupt when the CPU
> tries to fetch from a non-executable region.
>
> If the fetch operation for a memory region is not implemented, the read
> operation will still be used for fetch operations.
>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>

This looks ok to me, but I would like someone who knows this better to
review it as well

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/tcg/cputlb.c    |   9 +++-
>  include/exec/memory.h |  27 +++++++++++
>  system/memory.c       | 104 ++++++++++++++++++++++++++++++++++++++++++
>  system/trace-events   |   2 +
>  4 files changed, 140 insertions(+), 2 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index b4ccf0cdcb..71c16a1ac1 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1947,8 +1947,13 @@ static uint64_t int_ld_mmio_beN(CPUState *cpu, CPU=
TLBEntryFull *full,
>          this_size =3D 1 << this_mop;
>          this_mop |=3D MO_BE;
>
> -        r =3D memory_region_dispatch_read(mr, mr_offset, &val,
> -                                        this_mop, full->attrs);
> +        if (type =3D=3D MMU_INST_FETCH) {
> +            r =3D memory_region_dispatch_fetch(mr, mr_offset, &val,
> +                                             this_mop, full->attrs);
> +        } else {
> +            r =3D memory_region_dispatch_read(mr, mr_offset, &val,
> +                                            this_mop, full->attrs);
> +        }
>          if (unlikely(r !=3D MEMTX_OK)) {
>              io_failed(cpu, full, addr, this_size, type, mmu_idx, r, ra);
>          }
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 3ee1901b52..6166d697d9 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -273,6 +273,11 @@ struct MemoryRegionOps {
>                    hwaddr addr,
>                    uint64_t data,
>                    unsigned size);
> +    /* Fetch from the memory region. @addr is relative to @mr; @size is
> +     * in bytes. */
> +    uint64_t (*fetch)(void *opaque,
> +                      hwaddr addr,
> +                      unsigned size);
>
>      MemTxResult (*read_with_attrs)(void *opaque,
>                                     hwaddr addr,
> @@ -284,6 +289,11 @@ struct MemoryRegionOps {
>                                      uint64_t data,
>                                      unsigned size,
>                                      MemTxAttrs attrs);
> +    MemTxResult (*fetch_with_attrs)(void *opaque,
> +                                    hwaddr addr,
> +                                    uint64_t *data,
> +                                    unsigned size,
> +                                    MemTxAttrs attrs);
>
>      enum device_endian endianness;
>      /* Guest-visible constraints: */
> @@ -2604,6 +2614,23 @@ MemTxResult memory_region_dispatch_write(MemoryReg=
ion *mr,
>                                           MemOp op,
>                                           MemTxAttrs attrs);
>
> +
> +/**
> + * memory_region_dispatch_fetch: perform a fetch directly to the specifi=
ed
> + * MemoryRegion.
> + *
> + * @mr: #MemoryRegion to access
> + * @addr: address within that region
> + * @pval: pointer to uint64_t which the data is written to
> + * @op: size, sign, and endianness of the memory operation
> + * @attrs: memory transaction attributes to use for the access
> + */
> +MemTxResult memory_region_dispatch_fetch(MemoryRegion *mr,
> +                                         hwaddr addr,
> +                                         uint64_t *pval,
> +                                         MemOp op,
> +                                         MemTxAttrs attrs);
> +
>  /**
>   * address_space_init: initializes an address space
>   *
> diff --git a/system/memory.c b/system/memory.c
> index b17b5538ff..7f26f681f9 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -477,6 +477,51 @@ static MemTxResult memory_region_read_with_attrs_acc=
essor(MemoryRegion *mr,
>      return r;
>  }
>
> +static MemTxResult memory_region_fetch_accessor(MemoryRegion *mr,
> +                                                hwaddr addr,
> +                                                uint64_t *value,
> +                                                unsigned size,
> +                                                signed shift,
> +                                                uint64_t mask,
> +                                                MemTxAttrs attrs)
> +{
> +    uint64_t tmp;
> +
> +    tmp =3D mr->ops->fetch(mr->opaque, addr, size);
> +    if (mr->subpage) {
> +        trace_memory_region_subpage_fetch(get_cpu_index(), mr, addr, tmp=
, size);
> +    } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_FE=
TCH)) {
> +        hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
> +        trace_memory_region_ops_fetch(get_cpu_index(), mr, abs_addr, tmp=
, size,
> +                                     memory_region_name(mr));
> +    }
> +    memory_region_shift_read_access(value, shift, mask, tmp);
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult memory_region_fetch_with_attrs_accessor(MemoryRegion =
*mr,
> +                                                          hwaddr addr,
> +                                                          uint64_t *valu=
e,
> +                                                          unsigned size,
> +                                                          signed shift,
> +                                                          uint64_t mask,
> +                                                          MemTxAttrs att=
rs)
> +{
> +    uint64_t tmp =3D 0;
> +    MemTxResult r;
> +
> +    r =3D mr->ops->fetch_with_attrs(mr->opaque, addr, &tmp, size, attrs)=
;
> +    if (mr->subpage) {
> +        trace_memory_region_subpage_fetch(get_cpu_index(), mr, addr, tmp=
, size);
> +    } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_FE=
TCH)) {
> +        hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
> +        trace_memory_region_ops_fetch(get_cpu_index(), mr, abs_addr, tmp=
, size,
> +                                      memory_region_name(mr));
> +    }
> +    memory_region_shift_read_access(value, shift, mask, tmp);
> +    return r;
> +}
> +
>  static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
>                                                  hwaddr addr,
>                                                  uint64_t *value,
> @@ -1493,6 +1538,65 @@ MemTxResult memory_region_dispatch_read(MemoryRegi=
on *mr,
>      return r;
>  }
>
> +static MemTxResult memory_region_dispatch_fetch1(MemoryRegion *mr,
> +                                                hwaddr addr,
> +                                                uint64_t *pval,
> +                                                unsigned size,
> +                                                MemTxAttrs attrs)
> +{
> +    *pval =3D 0;
> +
> +    if (mr->ops->fetch) {
> +        return access_with_adjusted_size(addr, pval, size,
> +                                         mr->ops->impl.min_access_size,
> +                                         mr->ops->impl.max_access_size,
> +                                         memory_region_fetch_accessor,
> +                                         mr, attrs);
> +    } else if (mr->ops->fetch_with_attrs) {
> +        return access_with_adjusted_size(addr, pval, size,
> +            mr->ops->impl.min_access_size,
> +            mr->ops->impl.max_access_size,
> +            memory_region_fetch_with_attrs_accessor,
> +            mr, attrs);
> +    } else if (mr->ops->read) {
> +        return access_with_adjusted_size(addr, pval, size,
> +                                         mr->ops->impl.min_access_size,
> +                                         mr->ops->impl.max_access_size,
> +                                         memory_region_read_accessor,
> +                                         mr, attrs);
> +    } else {
> +        return access_with_adjusted_size(addr, pval, size,
> +                                         mr->ops->impl.min_access_size,
> +                                         mr->ops->impl.max_access_size,
> +                                         memory_region_read_with_attrs_a=
ccessor,
> +                                         mr, attrs);
> +    }
> +}
> +
> +MemTxResult memory_region_dispatch_fetch(MemoryRegion *mr,
> +                                        hwaddr addr,
> +                                        uint64_t *pval,
> +                                        MemOp op,
> +                                        MemTxAttrs attrs)
> +{
> +    unsigned size =3D memop_size(op);
> +    MemTxResult r;
> +
> +    if (mr->alias) {
> +        return memory_region_dispatch_fetch(mr->alias,
> +                                           mr->alias_offset + addr,
> +                                           pval, op, attrs);
> +    }
> +    if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
> +        *pval =3D unassigned_mem_read(mr, addr, size);
> +        return MEMTX_DECODE_ERROR;
> +    }
> +
> +    r =3D memory_region_dispatch_fetch1(mr, addr, pval, size, attrs);
> +    adjust_endianness(mr, pval, op);
> +    return r;
> +}
> +
>  /* Return true if an eventfd was signalled */
>  static bool memory_region_dispatch_write_eventfds(MemoryRegion *mr,
>                                                      hwaddr addr,
> diff --git a/system/trace-events b/system/trace-events
> index 5bbc3fbffa..4e78bb515b 100644
> --- a/system/trace-events
> +++ b/system/trace-events
> @@ -18,8 +18,10 @@ cpu_out(unsigned int addr, char size, unsigned int val=
) "addr 0x%x(%c) value %u"
>  # memory.c
>  memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t =
value, unsigned size, const char *name) "cpu %d mr %p addr 0x%"PRIx64" valu=
e 0x%"PRIx64" size %u name '%s'"
>  memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t=
 value, unsigned size, const char *name) "cpu %d mr %p addr 0x%"PRIx64" val=
ue 0x%"PRIx64" size %u name '%s'"
> +memory_region_ops_fetch(int cpu_index, void *mr, uint64_t addr, uint64_t=
 value, unsigned size, const char *name) "cpu %d mr %p addr 0x%"PRIx64" val=
ue 0x%"PRIx64" size %u name '%s'"
>  memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uin=
t64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx=
64" size %u"
>  memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, ui=
nt64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRI=
x64" size %u"
> +memory_region_subpage_fetch(int cpu_index, void *mr, uint64_t offset, ui=
nt64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRI=
x64" size %u"
>  memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, ui=
nt64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx6=
4" size %u"
>  memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, u=
int64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx=
64" size %u"
>  memory_region_sync_dirty(const char *mr, const char *listener, int globa=
l) "mr '%s' listener '%s' synced (global=3D%d)"
> --
> 2.34.1
>
>

