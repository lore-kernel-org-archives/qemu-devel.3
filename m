Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DA4E69E96
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 21:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIDta-0008Ls-V9; Mon, 02 Dec 2024 16:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIDtX-0008Km-Jm
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:23:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIDtV-0001x7-I5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733174626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8bWw/EuoOFQLddvWpl5jyQ9OJipcn33jQHzvzbRi/5A=;
 b=iV6VWlhkQ30RT78hl1dr38LvAz8XAaYEPoIo/5BQWatLLFubkyGDWYYGCzQKF5nZsIDLHy
 iNR4y42Zx7H3Xhq6QG1ZXAGdIetEqeueN+NMI3ge41fHXKvjq+IkuKVmkQmssxt8EaiGwu
 fMT7WYkcLRL2WtquWMIzF0oU17FxqrY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-8hOdV4lxPgm6LsTtGZrX7g-1; Mon, 02 Dec 2024 16:23:44 -0500
X-MC-Unique: 8hOdV4lxPgm6LsTtGZrX7g-1
X-Mimecast-MFC-AGG-ID: 8hOdV4lxPgm6LsTtGZrX7g
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-466bfd1d101so74893761cf.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 13:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733174624; x=1733779424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bWw/EuoOFQLddvWpl5jyQ9OJipcn33jQHzvzbRi/5A=;
 b=w2nWzWMRmcOMOIQt63EWLj7aKtIidjspmevqu2ObdqU8L+wUQ9ANOYergvmedJBnHM
 jFDE2QZPdJIanl43YftilIjRGZXsgcGzc+lgZ8HA8BfV19h3oSphLB4fIA2xxCQik5jB
 pUmFaf4ZT6nkoobrE49Bs3Sd67OEOy9+ttgCpoPJ67Uc8MNQaMs1WLlXJske42J2JmXA
 X97v2qLe/6ltevL2TXbCNouDpkKNYI74aojNTU1xEJKPsOJ1jywEBPIdy3nKJAenXd6q
 goYLPZ/xaB73Du6n60n+DczqfsK0rCNnOMmZlQpG05MI+ZmDSi7k3L08dM9ibUFzra17
 3rMg==
X-Gm-Message-State: AOJu0Yyl3pee65kqgCVrVgVOx2hCNO9J8OQkr3zVhxlvQO6ZGEJLHz3U
 SSfNYdEaNS4/yhsqAuVpkFq8rUDq9K2W/G5SBPeRVm0PQ0YMwCJx7NXK9wBMIE+bzWQ6mV9wq5+
 CHvVrtOq2lm7htxRjMN7vxQB0s2q7rUe2zshSFXlVJmgXw+iFgyoU
X-Gm-Gg: ASbGnct5LYsqFCUWFWqFOIZuD86ynwrcfauujICSTF4dILqLUVUDUkEyNzmvahUwkZU
 ARxgzcDG2IG1LopCawPo17X+C5OUR0v50IH0PtBtkIcaQH/zR+GM95t/3QY/bELBiJ0LQ8ezx3e
 beqINxgCWITMruVAEXeCkPIBmQS66Dq+KWIKmLLx+Fy9cAK9NPhn3eTfxn2X8wG2B2ronxnB7z6
 GhLaIesSk01gFiqyK8+m6ofsphgSvdOPIrsxpnmnk+kQ2ilVBhVrAswXJVI+IgdKcAQQm6xKdRA
 vGp+fHHbPhQ=
X-Received: by 2002:a05:622a:4110:b0:463:4bc7:503c with SMTP id
 d75a77b69052e-466c1be41d5mr348832441cf.19.1733174623710; 
 Mon, 02 Dec 2024 13:23:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLwg+6jYjazzQgBkayHSjMRm2rDHUZygq4KxnOzOnFrYKifuq10S7fTevF1oM4VH+3n55+pA==
X-Received: by 2002:a05:622a:4110:b0:463:4bc7:503c with SMTP id
 d75a77b69052e-466c1be41d5mr348831881cf.19.1733174623217; 
 Mon, 02 Dec 2024 13:23:43 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c40664c8sm53063221cf.30.2024.12.02.13.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 13:23:42 -0800 (PST)
Date: Mon, 2 Dec 2024 16:23:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/5] system/memory: support unaligned access
Message-ID: <Z04lW_CdYBPJRah3@x1n>
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <20241108032952.56692-3-tomoyuki.hirose@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108032952.56692-3-tomoyuki.hirose@igel.co.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 08, 2024 at 12:29:46PM +0900, Tomoyuki HIROSE wrote:
> The previous code ignored 'impl.unaligned' and handled unaligned
> accesses as is. But this implementation could not emulate specific
> registers of some devices that allow unaligned access such as xHCI
> Host Controller Capability Registers.

I have some comment that can be naive, please bare with me..

Firstly, could you provide an example in the commit message, of what would
start working after this patch?

IIUC things like read(addr=0x2, size=8) should already working before but
it'll be cut into 4 times read() over 2 bytes for unaligned=false, am I
right?

> 
> This commit emulates an unaligned access with multiple aligned
> accesses. Additionally, the overwriting of the max access size is
> removed to retrive the actual max access size.
> 
> Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
> ---
>  system/memory.c  | 147 ++++++++++++++++++++++++++++++++++++++---------
>  system/physmem.c |   8 ---
>  2 files changed, 119 insertions(+), 36 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 85f6834cb3..c2164e6478 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -518,27 +518,118 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
>      return mr->ops->write_with_attrs(mr->opaque, addr, tmp, size, attrs);
>  }
>  
> +typedef MemTxResult (*MemoryRegionAccessFn)(MemoryRegion *mr,
> +                                            hwaddr addr,
> +                                            uint64_t *value,
> +                                            unsigned size,
> +                                            signed shift,
> +                                            uint64_t mask,
> +                                            MemTxAttrs attrs);
> +
> +static MemTxResult access_emulation(hwaddr addr,
> +                                    uint64_t *value,
> +                                    unsigned int size,
> +                                    unsigned int access_size_min,
> +                                    unsigned int access_size_max,
> +                                    MemoryRegion *mr,
> +                                    MemTxAttrs attrs,
> +                                    MemoryRegionAccessFn access_fn_read,
> +                                    MemoryRegionAccessFn access_fn_write,
> +                                    bool is_write)
> +{
> +    hwaddr a;
> +    uint8_t *d;
> +    uint64_t v;
> +    MemTxResult r = MEMTX_OK;
> +    bool is_big_endian = memory_region_big_endian(mr);
> +    void (*store)(void *, int, uint64_t) = is_big_endian ? stn_be_p : stn_le_p;
> +    uint64_t (*load)(const void *, int) = is_big_endian ? ldn_be_p : ldn_le_p;
> +    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
> +    uint64_t access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> +    hwaddr round_down = mr->ops->impl.unaligned && addr + size <= mr->size ?
> +        0 : addr % access_size;
> +    hwaddr start = addr - round_down;
> +    hwaddr tail = addr + size <= mr->size ? addr + size : mr->size;

There're plenty of special considerations on addr+size over mr->size.  It
was confusing to me at the 1st glance, because after we have MR pointer
logically we should have clamped the size to make sure it won't get more
than the mr->size, e.g. for address space accesses it should have happened
in address_space_translate_internal(), translating IOs in flatviews.

Then I noticed b242e0e0e2 ("exec: skip MMIO regions correctly in
cpu_physical_memory_write_rom_internal"), also the special handling of MMIO
in access sizes where it won't be clamped.  Is this relevant to why
mr->size needs to be checked here, and is it intended to allow it to have
addr+size > mr->size?

If it's intended, IMHO it would be nice to add some comment explicitly or
mention it in the commit message.  It might not be very straightforward to
see..

> +    uint8_t data[16] = {0};
> +    g_assert(size <= 8);
> +
> +    for (a = start, d = data, v = 0; a < tail;
> +         a += access_size, d += access_size, v = 0) {
> +        r |= access_fn_read(mr, a, &v, access_size, 0, access_mask,
> +                            attrs);
> +        store(d, access_size, v);

I'm slightly confused on what is the endianess of data[].  It uses store(),
so I think it means it follows the MR's endianess.  But then..

> +    }
> +    if (is_write) {
> +        stn_he_p(&data[round_down], size, load(value, size));

... here stn_he_p() should imply that data[] is using host endianess...
Meanwhile I wonder why value should be loaded by load() - value should
points to a u64 which is, IIUC, host-endian, while load() is using MR's
endianess..

I wonder if we could have data[] using host endianess always, then here:

           stn_he_p(&data[round_down], size, *value);

> +        for (a = start, d = data; a < tail;
> +             a += access_size, d += access_size) {
> +            v = load(d, access_size);
> +            r |= access_fn_write(mr, a, &v, access_size, 0, access_mask,
> +                                 attrs);
> +        }
> +    } else {
> +        store(value, size, ldn_he_p(&data[round_down], size));
> +    }
> +
> +    return r;

Now when unaligned write, it'll read at most 16 byte out in data[], apply
the changes, and write back all 16 bytes down even if only 8 bytes are new.

Is this the intended behavior?  When I was thinking impl.unaligned=true, I
thought the device should be able to process unaligned address in the MR
ops directly.  But I could be totally wrong here, hence more of a pure
question..

> +}
> +
> +static bool is_access_fastpath(hwaddr addr,
> +                               unsigned int size,
> +                               unsigned int access_size_min,
> +                               unsigned int access_size_max,
> +                               MemoryRegion *mr)
> +{
> +    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
> +    hwaddr round_down = mr->ops->impl.unaligned && addr + size <= mr->size ?
> +        0 : addr % access_size;
> +
> +    return round_down == 0 && access_size <= size;

Would it be more readable to rewrite this with some if clauses?  Something
like:

is_access_fastpath()
{
  size_t access_size = MAX(MIN(size, access_size_max), access_size_min);

  if (access_size < access_size_min) {
    return false;
  }
    
  if (mr->ops->impl.unaligned && (addr + size <= mr->size)) {
    return true;
  }

  return addr % access_size;
}

> +}
> +
> +static MemTxResult access_fastpath(hwaddr addr,
> +                                   uint64_t *value,
> +                                   unsigned int size,
> +                                   unsigned int access_size_min,
> +                                   unsigned int access_size_max,
> +                                   MemoryRegion *mr,
> +                                   MemTxAttrs attrs,
> +                                   MemoryRegionAccessFn fastpath)
> +{
> +    MemTxResult r = MEMTX_OK;
> +    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
> +    uint64_t access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> +
> +    if (memory_region_big_endian(mr)) {
> +        for (size_t i = 0; i < size; i += access_size) {
> +            r |= fastpath(mr, addr + i, value, access_size,
> +                          (size - access_size - i) * 8, access_mask, attrs);
> +        }
> +    } else {
> +        for (size_t i = 0; i < size; i += access_size) {
> +            r |= fastpath(mr, addr + i, value, access_size,
> +                          i * 8, access_mask, attrs);
> +        }
> +    }
> +
> +    return r;
> +}
> +
>  static MemTxResult access_with_adjusted_size(hwaddr addr,
>                                        uint64_t *value,
>                                        unsigned size,
>                                        unsigned access_size_min,
>                                        unsigned access_size_max,
> -                                      MemTxResult (*access_fn)
> -                                                  (MemoryRegion *mr,
> -                                                   hwaddr addr,
> -                                                   uint64_t *value,
> -                                                   unsigned size,
> -                                                   signed shift,
> -                                                   uint64_t mask,
> -                                                   MemTxAttrs attrs),
> +                                      MemoryRegionAccessFn access_fn_read,
> +                                      MemoryRegionAccessFn access_fn_write,
> +                                      bool is_write,
>                                        MemoryRegion *mr,
>                                        MemTxAttrs attrs)
>  {
> -    uint64_t access_mask;
> -    unsigned access_size;
> -    unsigned i;
>      MemTxResult r = MEMTX_OK;
>      bool reentrancy_guard_applied = false;
> +    MemoryRegionAccessFn access_fn_fastpath =
> +        is_write ? access_fn_write : access_fn_read;
>  
>      if (!access_size_min) {
>          access_size_min = 1;
> @@ -560,20 +651,16 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>          reentrancy_guard_applied = true;
>      }
>  
> -    /* FIXME: support unaligned access? */
> -    access_size = MAX(MIN(size, access_size_max), access_size_min);
> -    access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> -    if (memory_region_big_endian(mr)) {
> -        for (i = 0; i < size; i += access_size) {
> -            r |= access_fn(mr, addr + i, value, access_size,
> -                        (size - access_size - i) * 8, access_mask, attrs);
> -        }
> +    if (is_access_fastpath(addr, size, access_size_min, access_size_max, mr)) {
> +        r |= access_fastpath(addr, value, size,
> +                             access_size_min, access_size_max, mr, attrs,
> +                             access_fn_fastpath);
>      } else {
> -        for (i = 0; i < size; i += access_size) {
> -            r |= access_fn(mr, addr + i, value, access_size, i * 8,
> -                        access_mask, attrs);
> -        }
> +        r |= access_emulation(addr, value, size,
> +                              access_size_min, access_size_max, mr, attrs,
> +                              access_fn_read, access_fn_write, is_write);
>      }
> +
>      if (mr->dev && reentrancy_guard_applied) {
>          mr->dev->mem_reentrancy_guard.engaged_in_io = false;
>      }
> @@ -1459,13 +1546,15 @@ static MemTxResult memory_region_dispatch_read1(MemoryRegion *mr,
>                                           mr->ops->impl.min_access_size,
>                                           mr->ops->impl.max_access_size,
>                                           memory_region_read_accessor,
> -                                         mr, attrs);
> +                                         memory_region_write_accessor,
> +                                         false, mr, attrs);
>      } else {
>          return access_with_adjusted_size(addr, pval, size,
>                                           mr->ops->impl.min_access_size,
>                                           mr->ops->impl.max_access_size,
>                                           memory_region_read_with_attrs_accessor,
> -                                         mr, attrs);
> +                                         memory_region_write_with_attrs_accessor,
> +                                         false, mr, attrs);
>      }
>  }
>  
> @@ -1553,15 +1642,17 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
>          return access_with_adjusted_size(addr, &data, size,
>                                           mr->ops->impl.min_access_size,
>                                           mr->ops->impl.max_access_size,
> -                                         memory_region_write_accessor, mr,
> -                                         attrs);
> +                                         memory_region_read_accessor,
> +                                         memory_region_write_accessor,
> +                                         true, mr, attrs);
>      } else {
>          return
>              access_with_adjusted_size(addr, &data, size,
>                                        mr->ops->impl.min_access_size,
>                                        mr->ops->impl.max_access_size,
> +                                      memory_region_read_with_attrs_accessor,
>                                        memory_region_write_with_attrs_accessor,
> -                                      mr, attrs);
> +                                      true, mr, attrs);
>      }
>  }
>  
> diff --git a/system/physmem.c b/system/physmem.c
> index dc1db3a384..ff444140a8 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2693,14 +2693,6 @@ int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
>          access_size_max = 4;
>      }
>  
> -    /* Bound the maximum access by the alignment of the address.  */
> -    if (!mr->ops->impl.unaligned) {
> -        unsigned align_size_max = addr & -addr;
> -        if (align_size_max != 0 && align_size_max < access_size_max) {
> -            access_size_max = align_size_max;
> -        }
> -    }

Could you explain why this needs to be removed?

Again, I was expecting the change was for a device that will have
unaligned==true first, so this shouldn't matter.  Then I wonder why this
behavior needs change.  But I could miss something.

Thanks,

> -
>      /* Don't attempt accesses larger than the maximum.  */
>      if (l > access_size_max) {
>          l = access_size_max;
> -- 
> 2.43.0
> 

-- 
Peter Xu


