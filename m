Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF26D5B84C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 16:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVBUg-0001ns-NQ; Mon, 15 Dec 2025 11:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVBUc-0001lj-Mi
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:32:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVBUY-0001NI-VW
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765816329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KOX0iNXiRn43h3jDbpzxigHOVb/WjXy5CQm1DC9EXJc=;
 b=E6XhH2TK/Jr2VUUMo+4WMrP9O94m262U+b1gwz5CcofdR3wBb+Zks12+NYqlMQIgLk6DGm
 Rvs6BO9U9ymLYReri1Stm/u3mhvLWYMf6e1BW0B1Uuma8SDYF8n4KyBph4rWC8WICDt5Te
 igi4QboFoJcYQaI2wUV1y7+RzfTsiNY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-xLjq9atCM0KpogAJWFCEQA-1; Mon, 15 Dec 2025 11:32:07 -0500
X-MC-Unique: xLjq9atCM0KpogAJWFCEQA-1
X-Mimecast-MFC-AGG-ID: xLjq9atCM0KpogAJWFCEQA_1765816327
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ed74ab4172so81060801cf.1
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 08:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765816327; x=1766421127; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KOX0iNXiRn43h3jDbpzxigHOVb/WjXy5CQm1DC9EXJc=;
 b=MaAVpby5k+cEBbboq3cKpp8wiZjiehnyvz40yvv3QK+iaOWHFRLLhYuH0bfZwJ7FIg
 B76Nd9yaql0VTJ+usd5cltTotZ+xcAS2Y3HFi7ycpocfsjJ8W06+yFkjdv+TYe0mZf26
 LqyzmNkVhSMfxn/Wkyw+msEqcS1B+PZQNKjoFCAAxRlU8xojASdmOSerUB7Im3R4uwg5
 eL+4wa7URQpKdO49SuKBM8IS6QR1DImNm7RQyVBtatxdEyr4xkOi4brG/kBk7REr32EJ
 7or/u9bHQbgY3YUQ/zyQ1Y5SQZAXUG7LqWEqLkRWXUPrsFjuq3y2dcLQnYQ3llvxvMbB
 X+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765816327; x=1766421127;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOX0iNXiRn43h3jDbpzxigHOVb/WjXy5CQm1DC9EXJc=;
 b=w9nj1A5Z1cAqAedKH3RCmoQHB1+o1Mie95qGRpYBGWRwjvuXSgIq6Mn5K6E3gEkcpM
 QL+a5Gl3Is45JW5ukSglW2/sKvTZ4YokBYV5gjInr2ziVeiFRocL2QI+l53zw2NHkzEP
 732dfHZ0SBRKkvPR0L0q+pia/N7/UE5jV2T+nK2JDDp3A/Zo1j2RQKnraViLowyFkljN
 u5MG2NnINJa7kxEM67QHq5OE75CbOoJoEcF8z691D6pdCcSm1f6kuyU1Zy86phOyjbSn
 y9EeHd6SSNjyrwMDao8KxRY+tqeORJQy1DiLQZBWBpeEGAGYxjFqPvwKMdHRAfF+fUKz
 RjIg==
X-Gm-Message-State: AOJu0Yw1FkrIcvaWwFwYr1+Ts8ssO84oBpVpyeiFD6ne7IeyJ3SOx5gQ
 BHgIf0DYbziL0RfQB2Mogxif0E42mGck5H9OrtreX9s8RA9sVDKdDIybpact6tgEX2pHOytVKUU
 6oIRhKC7ycbbI7YyYD0bcyoXZciSneKsfDDd55BaQvS204WCWA3AY+5Gmr/gwi1wm
X-Gm-Gg: AY/fxX4/SeZ9HN6kEwvdZ9lSxYiwv70NKVCwgAnl/8F3ZaSu9xPRCyrjBcpEkUeMvot
 3hmAi5LDzlFR/g76idaIEDtS5Vr0fYSdRRT1HvP2WpdkVlxRefUDNGXEJ4AAnsWA7vpHreT38ds
 8394ShnnnP5xHt2/96E9XcuCUj4qd1UqfFhqxsYoSGAyWQYkIJ75o6LmprGuuxXSq6NX7XEgkr0
 F9dRJLwgb5wW7/YxEkQbYprm00LxB8dqIdtuc/RKcQq0m2VQ8V0ECYbK117WlhpXbe7Ceq7mlcq
 EIgwJmTxEwdgCbEhDqjqlc1XP6H/+Fg+udVPWHzJqnE996ftC4bbNSfOd9KRA0vBRVvy+PpWGf3
 SpCA=
X-Received: by 2002:ac8:6f1a:0:b0:4ee:1a72:cf84 with SMTP id
 d75a77b69052e-4f1d04c058dmr157448831cf.27.1765816326940; 
 Mon, 15 Dec 2025 08:32:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeClZZLC27MvVgIA0CjbdbzO4AbCimOILCiBLQ9ryElL08qKLztTAfSFPUdhGstYzaIUnByA==
X-Received: by 2002:ac8:6f1a:0:b0:4ee:1a72:cf84 with SMTP id
 d75a77b69052e-4f1d04c058dmr157448231cf.27.1765816326390; 
 Mon, 15 Dec 2025 08:32:06 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f1f38349casm25447531cf.17.2025.12.15.08.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 08:32:05 -0800 (PST)
Date: Mon, 15 Dec 2025 11:32:04 -0500
From: Peter Xu <peterx@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com,
 richard.henderson@linaro.org, pbonzini@redhat.com, david@kernel.org,
 philmd@linaro.org, farosas@suse.de
Subject: Re: [PATCH v2 1/1] migration: merge fragmented clear_dirty ioctls
Message-ID: <aUA4BGW2Faw9CMgs@x1.local>
References: <20251215140611.16180-1-xuchuangxclwt@bytedance.com>
 <20251215140611.16180-2-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215140611.16180-2-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Dec 15, 2025 at 10:06:11PM +0800, Chuang Xu wrote:
> From: xuchuangxclwt <xuchuangxclwt@bytedance.com>
> 
> When the addresses processed are not aligned, a large number of
> clear_dirty ioctl occur (e.g. a 4MB misaligned memory can generate
> 2048 clear_dirty ioctls from two different memory_listener),
> which increases the time required for bitmap_sync and makes it
> more difficult for dirty pages to converge.
> 
> Attempt to merge those fragmented clear_dirty ioctls.
> 
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> ---
>  accel/tcg/cputlb.c       |  5 +++--
>  include/system/physmem.h |  7 ++++---
>  migration/ram.c          | 26 ++++++++++++------------
>  system/memory.c          |  2 +-
>  system/physmem.c         | 44 ++++++++++++++++++++++++----------------
>  5 files changed, 48 insertions(+), 36 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index fd1606c856..c8827c8b0d 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -857,8 +857,9 @@ void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
>  void tlb_protect_code(ram_addr_t ram_addr)
>  {
>      physical_memory_test_and_clear_dirty(ram_addr & TARGET_PAGE_MASK,
> -                                             TARGET_PAGE_SIZE,
> -                                             DIRTY_MEMORY_CODE);
> +                                         TARGET_PAGE_SIZE,
> +                                         DIRTY_MEMORY_CODE,
> +                                         NULL);
>  }
>  
>  /* update the TLB so that writes in physical page 'phys_addr' are no longer
> diff --git a/include/system/physmem.h b/include/system/physmem.h
> index 879f6eae38..8eeace9d1f 100644
> --- a/include/system/physmem.h
> +++ b/include/system/physmem.h
> @@ -39,9 +39,10 @@ uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>  
>  void physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
>  
> -bool physical_memory_test_and_clear_dirty(ram_addr_t start,
> -                                          ram_addr_t length,
> -                                          unsigned client);
> +uint64_t physical_memory_test_and_clear_dirty(ram_addr_t start,
> +                                              ram_addr_t length,
> +                                              unsigned client,
> +                                              unsigned long *dest);

Nitpick: please consider adding doc for this function now, both "dest" and
retval may need some explanations.

>  
>  DirtyBitmapSnapshot *
>  physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
> diff --git a/migration/ram.c b/migration/ram.c
> index 29f016cb25..2d5e979211 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -942,7 +942,6 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>                                                    ram_addr_t start,
>                                                    ram_addr_t length)
>  {
> -    ram_addr_t addr;
>      unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
>      uint64_t num_dirty = 0;
>      unsigned long *dest = rb->bmap;
> @@ -995,18 +994,19 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>          }
>      } else {
>          ram_addr_t offset = rb->offset;
> -
> -        for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
> -            if (physical_memory_test_and_clear_dirty(
> -                        start + addr + offset,
> -                        TARGET_PAGE_SIZE,
> -                        DIRTY_MEMORY_MIGRATION)) {
> -                long k = (start + addr) >> TARGET_PAGE_BITS;
> -                if (!test_and_set_bit(k, dest)) {
> -                    num_dirty++;
> -                }
> -            }
> -        }
> +        unsigned long end, start_page;
> +        uint64_t mr_offset, mr_size;
> +
> +        num_dirty = physical_memory_test_and_clear_dirty(
> +                        start + offset,
> +                        length,
> +                        DIRTY_MEMORY_MIGRATION,
> +                        dest);

Thanks for doing this, I think this is better.  Though IIUC you missed a
major benefit of the current API I'm suggesting here, which is to avoid
explicit invokations of memory_region_clear_dirty_bitmap().

IIUC you can remove the "if" check at [1] below, then you can drop the five
lines here afterwards.

So physical_memory_test_and_clear_dirty() should never worry about remote
clears, and it should always be done properly.

> +        end = TARGET_PAGE_ALIGN(start + offset + length) >> TARGET_PAGE_BITS;
> +        start_page = (start + offset) >> TARGET_PAGE_BITS;
> +        mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - offset;
> +        mr_size = (end - start_page) << TARGET_PAGE_BITS;
> +        memory_region_clear_dirty_bitmap(rb->mr, mr_offset, mr_size);
>      }
>  
>      return num_dirty;
> diff --git a/system/memory.c b/system/memory.c
> index 8b84661ae3..666364392d 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2424,7 +2424,7 @@ void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
>  {
>      assert(mr->ram_block);
>      physical_memory_test_and_clear_dirty(
> -        memory_region_get_ram_addr(mr) + addr, size, client);
> +        memory_region_get_ram_addr(mr) + addr, size, client, NULL);
>  }
>  
>  int memory_region_get_fd(MemoryRegion *mr)
> diff --git a/system/physmem.c b/system/physmem.c
> index c9869e4049..d015eb2133 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1090,18 +1090,19 @@ void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
>  }
>  
>  /* Note: start and end must be within the same ram block.  */
> -bool physical_memory_test_and_clear_dirty(ram_addr_t start,
> +uint64_t physical_memory_test_and_clear_dirty(ram_addr_t start,
>                                                ram_addr_t length,
> -                                              unsigned client)
> +                                              unsigned client,
> +                                              unsigned long *dest)
>  {
>      DirtyMemoryBlocks *blocks;
>      unsigned long end, page, start_page;
> -    bool dirty = false;
> +    uint64_t num_dirty = 0;
>      RAMBlock *ramblock;
>      uint64_t mr_offset, mr_size;
>  
>      if (length == 0) {
> -        return false;
> +        return 0;
>      }
>  
>      end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
> @@ -1118,31 +1119,40 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
>          while (page < end) {
>              unsigned long idx = page / DIRTY_MEMORY_BLOCK_SIZE;
>              unsigned long offset = page % DIRTY_MEMORY_BLOCK_SIZE;
> -            unsigned long num = MIN(end - page,
> -                                    DIRTY_MEMORY_BLOCK_SIZE - offset);
>  
> -            dirty |= bitmap_test_and_clear_atomic(blocks->blocks[idx],
> -                                                  offset, num);
> -            page += num;
> +            if (bitmap_test_and_clear_atomic(blocks->blocks[idx], offset, 1)) {
> +                if (dest) {
> +                    unsigned long k = page - (ramblock->offset >> TARGET_PAGE_BITS);
> +                    if (!test_and_set_bit(k, dest)) {
> +                        num_dirty++;
> +                    }
> +                } else {
> +                    num_dirty++;
> +                }
> +            }
> +
> +            page++;
>          }
>  
> -        mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - ramblock->offset;
> -        mr_size = (end - start_page) << TARGET_PAGE_BITS;
> -        memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
> +        if (!dest && num_dirty) {

[1]

> +            mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - ramblock->offset;
> +            mr_size = (end - start_page) << TARGET_PAGE_BITS;
> +            memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
> +        }
>      }
>  
> -    if (dirty) {
> +    if (num_dirty) {
>          physical_memory_dirty_bits_cleared(start, length);
>      }
>  
> -    return dirty;
> +    return num_dirty;
>  }
>  
>  static void physical_memory_clear_dirty_range(ram_addr_t addr, ram_addr_t length)
>  {
> -    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION);
> -    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA);
> -    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE);
> +    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION, NULL);
> +    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA, NULL);
> +    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE, NULL);
>  }
>  
>  DirtyBitmapSnapshot *physical_memory_snapshot_and_clear_dirty
> -- 
> 2.39.3 (Apple Git-146)
> 

-- 
Peter Xu


