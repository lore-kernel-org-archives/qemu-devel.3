Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AED0D5E14E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 13:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVV40-0006eA-IR; Tue, 16 Dec 2025 08:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVV3x-0006dt-GS
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 08:26:01 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVV3s-0002Lw-Fm
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 08:26:01 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41E9A336A9;
 Tue, 16 Dec 2025 13:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765891550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zBqH/2CzaclBHnD6OtBYRwcSxnoD54C9OaI7Cftq/Bs=;
 b=kRLRtczUBzi/l3d3XzHQr/q/uI/HUljX+k2Y8hI+iq8rrsIpC0uJoji0D5jShP6bmSjDPO
 UILS5rGEh9PmstKfcwZh0dmFzPfQgM6ZwBKCdUojNpSS8i0ApuHtoodDn4JlmDPS2a8421
 wzJ55ckxnS9IyBNaZ30exwxMOIQPxEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765891550;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zBqH/2CzaclBHnD6OtBYRwcSxnoD54C9OaI7Cftq/Bs=;
 b=3SgpLyYTViDxrnntNNDd7yf/bTqjUtv96lO0GBSWfJmAf4vUOSHO6LYznBqYVT705omjbv
 3KjcyG0l0IhbfFDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765891550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zBqH/2CzaclBHnD6OtBYRwcSxnoD54C9OaI7Cftq/Bs=;
 b=kRLRtczUBzi/l3d3XzHQr/q/uI/HUljX+k2Y8hI+iq8rrsIpC0uJoji0D5jShP6bmSjDPO
 UILS5rGEh9PmstKfcwZh0dmFzPfQgM6ZwBKCdUojNpSS8i0ApuHtoodDn4JlmDPS2a8421
 wzJ55ckxnS9IyBNaZ30exwxMOIQPxEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765891550;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zBqH/2CzaclBHnD6OtBYRwcSxnoD54C9OaI7Cftq/Bs=;
 b=3SgpLyYTViDxrnntNNDd7yf/bTqjUtv96lO0GBSWfJmAf4vUOSHO6LYznBqYVT705omjbv
 3KjcyG0l0IhbfFDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF24B3EA63;
 Tue, 16 Dec 2025 13:25:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2707G91dQWl5EQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 16 Dec 2025 13:25:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Chuang Xu <xuchuangxclwt@bytedance.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, peterx@redhat.com, david@kernel.org,
 philmd@linaro.org, xuchuangxclwt <xuchuangxclwt@bytedance.com>
Subject: Re: [PATCH v3 1/1] migration: merge fragmented clear_dirty ioctls
In-Reply-To: <20251216080001.64579-1-xuchuangxclwt@bytedance.com>
References: <20251216080001.64579-1-xuchuangxclwt@bytedance.com>
Date: Tue, 16 Dec 2025 10:25:46 -0300
Message-ID: <877bum36ed.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

"Chuang Xu" <xuchuangxclwt@bytedance.com> writes:

> From: xuchuangxclwt <xuchuangxclwt@bytedance.com>
>
> In our long-term experience in Bytedance, we've found that under
> the same load, live migration of larger VMs with more devices is
> often more difficult to converge (requiring a larger downtime limit).
>
> Through some testing and calculations, we conclude that bitmap sync time
> affects the calculation of live migration bandwidth.
>
> When the addresses processed are not aligned, a large number of
> clear_dirty ioctl occur (e.g. a 4MB misaligned memory can generate
> 2048 clear_dirty ioctls from two different memory_listener),
> which increases the time required for bitmap_sync and makes it
> more difficult for dirty pages to converge.
>
> For a 64C256G vm with 8 vhost-user-net(32 queue per nic) and
> 16 vhost-user-blk(4 queue per blk), the sync time is as high as *73ms*
> (tested with 10GBps dirty rate, the sync time increases as the dirty
> page rate increases), Here are each part of the sync time:
>
> - sync from kvm to ram_list: 2.5ms
> - vhost_log_sync:3ms
> - sync aligned memory from ram_list to RAMBlock: 5ms
> - sync misaligned memory from ram_list to RAMBlock: 61ms
>
> Attempt to merge those fragmented clear_dirty ioctls, then syncing
> misaligned memory from ram_list to RAMBlock takes only about 1ms,
> and the total sync time is only *12ms*.
>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> ---
>  accel/tcg/cputlb.c       |  5 ++--
>  include/system/physmem.h |  7 +++---
>  migration/ram.c          | 17 ++++----------
>  system/memory.c          |  2 +-
>  system/physmem.c         | 49 ++++++++++++++++++++++++++++------------
>  5 files changed, 47 insertions(+), 33 deletions(-)
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
>  
>  DirtyBitmapSnapshot *
>  physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
> diff --git a/migration/ram.c b/migration/ram.c
> index 29f016cb25..a03c9874a2 100644
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
> @@ -996,17 +995,11 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>      } else {
>          ram_addr_t offset = rb->offset;
>  
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
> +        num_dirty = physical_memory_test_and_clear_dirty(
> +                        start + offset,
> +                        length,
> +                        DIRTY_MEMORY_MIGRATION,
> +                        dest);
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
> index c9869e4049..f8b660dafe 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1089,19 +1089,31 @@ void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
>      }
>  }
>  
> -/* Note: start and end must be within the same ram block.  */
> -bool physical_memory_test_and_clear_dirty(ram_addr_t start,
> +/*
> + * Note: start and end must be within the same ram block.
> + *
> + * @dest usage:

I'm not sure if it's just me, but I find this "dest" term quite
confusing. "bmap" might be more straight-forward.

> + * - When @dest is provided, set bits for newly discovered dirty pages
> + *   only if the bit wasn't already set in dest, and count those pages
> + *   in num_dirty.

Am I misreading the code? I don't see this "set ... only if the bit
wasn't already set" part. What I see is: "set bits, but only count those
pages if the bit wasn't already set".

> + * - When @dest is NULL, count all dirty pages in the range
> + *
> + * @return:
> + * - Number of dirty guest pages found within [start, start + length).
> + */
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
> @@ -1118,12 +1130,19 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
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
>          mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - ramblock->offset;
> @@ -1131,18 +1150,18 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
>          memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
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

