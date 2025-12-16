Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE01D609CE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 16:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVXt3-0006Oy-98; Tue, 16 Dec 2025 11:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVXt1-0006Ol-PN
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 11:26:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVXsz-0002LC-Po
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 11:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765902410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5/w/b+koP+xIFiBwND2BYBwntrjPiqFe5tK/A0dBBBo=;
 b=PRqa6tebBeuwXAuqfkZPi1r/9bAMPlUXIqsf+i0LrhtMNm6A4PceVdRZ8/kvszM2bzAVqj
 q41Ct2aKJLd13D8QqBJQXP9XhVbOSyzZWp0lOFvlBUAEQyVgbGzSLlNK1leBAjz5Bw98Ou
 8czibceL2xKd68QJfboik7GvnG1Qh5s=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-wOZBPUkyO-a0S7mQxzu48Q-1; Tue, 16 Dec 2025 11:26:49 -0500
X-MC-Unique: wOZBPUkyO-a0S7mQxzu48Q-1
X-Mimecast-MFC-AGG-ID: wOZBPUkyO-a0S7mQxzu48Q_1765902408
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-29da1ea0b97so122275245ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765902408; x=1766507208; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5/w/b+koP+xIFiBwND2BYBwntrjPiqFe5tK/A0dBBBo=;
 b=ssR0wgj8Wz8B2GLbQXq9XpQf/+3Sr7QEgmgT+v+zRre/br4kwfa1lRClLIhVrrxG6u
 4YTDmvhjL5MB3jAZvIx6mlIre7H7dxaHjq5M9pa+WEOBwNi2FPLiFVx0H0dZlw9UXCyO
 713eS88q8iPIxgjUWd7WXt83S0wFD6yYJ6WBRbpLsL+Ea+gSVVlJzbdj6U8PfYcrhA9p
 gZl77wLaJXoFoEGd7rL25vwK/zozLFHJYajxbQmoAD/56nNNymmhb3rXYL9n+kV6ka76
 meQm5C4x+/DwjJ+OZIlzy1vY4BgXeMFpC9vSMpWdZkfmz3zbMkFB2trsttZjXmhESrIj
 /U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765902408; x=1766507208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/w/b+koP+xIFiBwND2BYBwntrjPiqFe5tK/A0dBBBo=;
 b=mR6mnVRZKmSBn+QSEU3bomSyPq/VgKathC/tnmo+B84tjgZPPKMfMfESRlYpe/DX7Q
 Zhvt61XLE6mG/sjBywJDt16zn905Bsr5ZncpuSR7Af49yRcaKdKHvcNDbyR7BUC7lAQx
 kl64txE3Fyr8HrLvB02l9SUfWeyVhNNj8Yy0TlmISkEO5oFDUp6rQCfEc+JJkOja/Rs0
 B/yHp4VHDFOTvojSYbWxcCho3jOTMo1PYp4/9dyNFUM9toSmEL1U7ZU1r5XM+aW4f90U
 GP4ojPD1S/aqTml3gJhcYenEXsSVom068u6cyjubhGIb9sxATzBiuEgNHtEEdnoXNdug
 Xmuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2CfzH+Gv+dy5h3+crmoHXDCw97+FVhv41wvW5c/MuYFpNdjK28nbQC25MKR4A/x47GaXfMEoFAStU@nongnu.org
X-Gm-Message-State: AOJu0Yy2ZRGuphAxsSBBhvJ8u7MgOD2srczKqGPXILC2A9Jh7lFMMEbk
 ah2tACyWanqPF1v7bZteWAZmegj4jpa4R7gC+59qDNB5H/QiDNl3IPvDVILxlD1j0WFzfQznIqf
 xma5C2cM+ScYvCUB47kxOsvBOqKNB/THAFAZpLxrNVX7z9lebWzXtrGbh
X-Gm-Gg: AY/fxX5Dux5qWDFi3MVHzqLh5csdX/LW/SBAZ+e/vaMpRYQyIIXC1k71yVsRVvIbOd/
 rTsTUZuQeCnOwbvaaPXKSYSoM+SQi8ezcby/uWH4JEMv0cXQmiwZ7b1tcsynaK9D/PSqZ5N7OE1
 kDFpZRmwko/4lXjpLexPHQWGgFIM4LBc5GCFVZzOEPb/XYiX4KgQ0v/VMBdKAvnXU+jSAR4M32O
 KP/2V5gi4cLuDAw/Si1iSAx5x9DDx6WFzCajbRBHIIGAvTOpkEhdbL4r4LVxeDDklVF062u9Apf
 IePzeznxNTvUned0QKY1OGxlxf8oyphZhqoX5Oazf3ZHySO5t601Ge3iM0ySbRHTyD8fza5YrWd
 GhRI=
X-Received: by 2002:a17:902:f605:b0:2a0:dd66:d813 with SMTP id
 d9443c01a7336-2a0dd66d8e5mr105863555ad.55.1765902407747; 
 Tue, 16 Dec 2025 08:26:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJpdDfzQg46toth3bE70MGhWIPOFxRi1xW/0fNn+PvnMp5hl91KNikbKhdvryiBMIvSqPw4g==
X-Received: by 2002:a17:902:f605:b0:2a0:dd66:d813 with SMTP id
 d9443c01a7336-2a0dd66d8e5mr105863175ad.55.1765902407153; 
 Tue, 16 Dec 2025 08:26:47 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a0993ab61dsm102998805ad.46.2025.12.16.08.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 08:26:46 -0800 (PST)
Date: Tue, 16 Dec 2025 11:26:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, qemu-devel@nongnu.org,
 mst@redhat.com, sgarzare@redhat.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, david@kernel.org, philmd@linaro.org
Subject: Re: [PATCH v3 1/1] migration: merge fragmented clear_dirty ioctls
Message-ID: <aUGIPj1JNpd8HZ-V@x1.local>
References: <20251216080001.64579-1-xuchuangxclwt@bytedance.com>
 <877bum36ed.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877bum36ed.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Dec 16, 2025 at 10:25:46AM -0300, Fabiano Rosas wrote:
> "Chuang Xu" <xuchuangxclwt@bytedance.com> writes:
> 
> > From: xuchuangxclwt <xuchuangxclwt@bytedance.com>
> >
> > In our long-term experience in Bytedance, we've found that under
> > the same load, live migration of larger VMs with more devices is
> > often more difficult to converge (requiring a larger downtime limit).
> >
> > Through some testing and calculations, we conclude that bitmap sync time
> > affects the calculation of live migration bandwidth.

Side note:

I forgot to mention when replying to the old versions, but we introduced
avail-switchover-bandwidth to partially remedy this problem when we hit it
before - which may or may not be exactly the same reason here on unaligned
syncs as we didn't further investigate (we have VFIO-PCI devices when
testing), but the whole logic should be similar that bw was calculated too
small.

So even if with this patch optimizing sync, bw is always not as accurate.
I wonder if we can still fix it somehow, e.g. I wonder if 100ms is too
short a period to take samples, or at least we should be able to remember
more samples so the reported bw (even if we keep sampling per 100ms) will
cover longer period.

Feel free to share your thoughts if you have any.

> >
> > When the addresses processed are not aligned, a large number of
> > clear_dirty ioctl occur (e.g. a 4MB misaligned memory can generate
> > 2048 clear_dirty ioctls from two different memory_listener),
> > which increases the time required for bitmap_sync and makes it
> > more difficult for dirty pages to converge.
> >
> > For a 64C256G vm with 8 vhost-user-net(32 queue per nic) and
> > 16 vhost-user-blk(4 queue per blk), the sync time is as high as *73ms*
> > (tested with 10GBps dirty rate, the sync time increases as the dirty
> > page rate increases), Here are each part of the sync time:
> >
> > - sync from kvm to ram_list: 2.5ms
> > - vhost_log_sync:3ms
> > - sync aligned memory from ram_list to RAMBlock: 5ms
> > - sync misaligned memory from ram_list to RAMBlock: 61ms
> >
> > Attempt to merge those fragmented clear_dirty ioctls, then syncing
> > misaligned memory from ram_list to RAMBlock takes only about 1ms,
> > and the total sync time is only *12ms*.
> >
> > Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> > ---
> >  accel/tcg/cputlb.c       |  5 ++--
> >  include/system/physmem.h |  7 +++---
> >  migration/ram.c          | 17 ++++----------
> >  system/memory.c          |  2 +-
> >  system/physmem.c         | 49 ++++++++++++++++++++++++++++------------
> >  5 files changed, 47 insertions(+), 33 deletions(-)
> >
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index fd1606c856..c8827c8b0d 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -857,8 +857,9 @@ void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
> >  void tlb_protect_code(ram_addr_t ram_addr)
> >  {
> >      physical_memory_test_and_clear_dirty(ram_addr & TARGET_PAGE_MASK,
> > -                                             TARGET_PAGE_SIZE,
> > -                                             DIRTY_MEMORY_CODE);
> > +                                         TARGET_PAGE_SIZE,
> > +                                         DIRTY_MEMORY_CODE,
> > +                                         NULL);
> >  }
> >  
> >  /* update the TLB so that writes in physical page 'phys_addr' are no longer
> > diff --git a/include/system/physmem.h b/include/system/physmem.h
> > index 879f6eae38..8eeace9d1f 100644
> > --- a/include/system/physmem.h
> > +++ b/include/system/physmem.h
> > @@ -39,9 +39,10 @@ uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
> >  
> >  void physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
> >  
> > -bool physical_memory_test_and_clear_dirty(ram_addr_t start,
> > -                                          ram_addr_t length,
> > -                                          unsigned client);
> > +uint64_t physical_memory_test_and_clear_dirty(ram_addr_t start,
> > +                                              ram_addr_t length,
> > +                                              unsigned client,
> > +                                              unsigned long *dest);
> >  
> >  DirtyBitmapSnapshot *
> >  physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 29f016cb25..a03c9874a2 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -942,7 +942,6 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
> >                                                    ram_addr_t start,
> >                                                    ram_addr_t length)
> >  {
> > -    ram_addr_t addr;
> >      unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
> >      uint64_t num_dirty = 0;
> >      unsigned long *dest = rb->bmap;
> > @@ -996,17 +995,11 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
> >      } else {
> >          ram_addr_t offset = rb->offset;
> >  
> > -        for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
> > -            if (physical_memory_test_and_clear_dirty(
> > -                        start + addr + offset,
> > -                        TARGET_PAGE_SIZE,
> > -                        DIRTY_MEMORY_MIGRATION)) {
> > -                long k = (start + addr) >> TARGET_PAGE_BITS;
> > -                if (!test_and_set_bit(k, dest)) {
> > -                    num_dirty++;
> > -                }
> > -            }
> > -        }
> > +        num_dirty = physical_memory_test_and_clear_dirty(
> > +                        start + offset,
> > +                        length,
> > +                        DIRTY_MEMORY_MIGRATION,
> > +                        dest);
> >      }
> >  
> >      return num_dirty;
> > diff --git a/system/memory.c b/system/memory.c
> > index 8b84661ae3..666364392d 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -2424,7 +2424,7 @@ void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
> >  {
> >      assert(mr->ram_block);
> >      physical_memory_test_and_clear_dirty(
> > -        memory_region_get_ram_addr(mr) + addr, size, client);
> > +        memory_region_get_ram_addr(mr) + addr, size, client, NULL);
> >  }
> >  
> >  int memory_region_get_fd(MemoryRegion *mr)
> > diff --git a/system/physmem.c b/system/physmem.c
> > index c9869e4049..f8b660dafe 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -1089,19 +1089,31 @@ void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
> >      }
> >  }
> >  
> > -/* Note: start and end must be within the same ram block.  */
> > -bool physical_memory_test_and_clear_dirty(ram_addr_t start,
> > +/*
> > + * Note: start and end must be within the same ram block.
> > + *
> > + * @dest usage:
> 
> I'm not sure if it's just me, but I find this "dest" term quite
> confusing. "bmap" might be more straight-forward.
> 
> > + * - When @dest is provided, set bits for newly discovered dirty pages
> > + *   only if the bit wasn't already set in dest, and count those pages
> > + *   in num_dirty.
> 
> Am I misreading the code? I don't see this "set ... only if the bit
> wasn't already set" part. What I see is: "set bits, but only count those
> pages if the bit wasn't already set".

Agrees on both points.. one more thing to mention below.

> 
> > + * - When @dest is NULL, count all dirty pages in the range
> > + *
> > + * @return:
> > + * - Number of dirty guest pages found within [start, start + length).
> > + */
> > +uint64_t physical_memory_test_and_clear_dirty(ram_addr_t start,
> >                                                ram_addr_t length,
> > -                                              unsigned client)
> > +                                              unsigned client,
> > +                                              unsigned long *dest)
> >  {
> >      DirtyMemoryBlocks *blocks;
> >      unsigned long end, page, start_page;
> > -    bool dirty = false;
> > +    uint64_t num_dirty = 0;
> >      RAMBlock *ramblock;
> >      uint64_t mr_offset, mr_size;
> >  
> >      if (length == 0) {
> > -        return false;
> > +        return 0;
> >      }
> >  
> >      end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
> > @@ -1118,12 +1130,19 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
> >          while (page < end) {
> >              unsigned long idx = page / DIRTY_MEMORY_BLOCK_SIZE;
> >              unsigned long offset = page % DIRTY_MEMORY_BLOCK_SIZE;
> > -            unsigned long num = MIN(end - page,
> > -                                    DIRTY_MEMORY_BLOCK_SIZE - offset);
> >  
> > -            dirty |= bitmap_test_and_clear_atomic(blocks->blocks[idx],
> > -                                                  offset, num);
> > -            page += num;
> > +            if (bitmap_test_and_clear_atomic(blocks->blocks[idx], offset, 1)) {
> > +                if (dest) {
> > +                    unsigned long k = page - (ramblock->offset >> TARGET_PAGE_BITS);
> > +                    if (!test_and_set_bit(k, dest)) {
> > +                        num_dirty++;
> > +                    }
> > +                } else {
> > +                    num_dirty++;
> > +                }
> > +            }
> > +
> > +            page++;

Sorry I could have mentioned this in the previous version: IMHO it'll still
be nice to keep the one atomic operations for !dest/!bmap case over "num".
There's no reason we need to introduce even any slightest regression in
those paths.

Thanks,

> >          }
> >  
> >          mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - ramblock->offset;
> > @@ -1131,18 +1150,18 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
> >          memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
> >      }
> >  
> > -    if (dirty) {
> > +    if (num_dirty) {
> >          physical_memory_dirty_bits_cleared(start, length);
> >      }
> >  
> > -    return dirty;
> > +    return num_dirty;
> >  }
> >  
> >  static void physical_memory_clear_dirty_range(ram_addr_t addr, ram_addr_t length)
> >  {
> > -    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION);
> > -    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA);
> > -    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE);
> > +    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION, NULL);
> > +    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA, NULL);
> > +    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE, NULL);
> >  }
> >  
> >  DirtyBitmapSnapshot *physical_memory_snapshot_and_clear_dirty
> 

-- 
Peter Xu


