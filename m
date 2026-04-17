Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57201F4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDhNG-0006Pa-B2; Fri, 17 Apr 2026 07:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wDhND-0006PF-Av
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:28:35 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wDhNB-0004Iw-6L
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:28:35 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35fb166b0c6so881253a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776425311; x=1777030111; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v4Ske4MtxcRcgg1+1VFlOkZsTsGfCwC5BO2o/xButFk=;
 b=hCfREnTZC/ug9j+r3fwUA8pRFWWCgDONsvw8uwloDWysfakxe4Z/TMwvisj7CI9fnC
 x4N5fMFok2vhgjJNjyJYMiRFAw6QfOYLrqGHn+Lt9r0+8dVemWSs6RW+ycPlyj4jCOs9
 Mfh27pMzAzzulkFsqvmkjQabP4zCqUA21WUa6ND96ozzRxYG214UM4pCIWeiKA8cOyaJ
 qqzq41VKGSluyXx6NU3okYE8vkcaaYQmJpHu2ksmNhVAarXlv2N1qvrgzYKEIBBrOZqZ
 P2i0eEFR+BEniK6eRN/7UjndaKK6wGEHUpmn2P5xKPECxYYL+j4cIwMMlkljGGEAvwrc
 WeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776425311; x=1777030111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v4Ske4MtxcRcgg1+1VFlOkZsTsGfCwC5BO2o/xButFk=;
 b=q2NK/EWIrTXunB9mw1UwbktxvP81AZW5D0b8njBVLN3fzzlOueRO8f0SYX4t8b7oLy
 sumOQeUVgUpRxF+8ypByW3ioFCesY5ZbSozGm+dOuPGSheSSP3TTf9D1J7y8pYeDKWZK
 4OnCs8njMKbX6b0oYZXWWzaDZxD5h0ffddSkWzOhcswTLcHCOs9tUVye5e3FtbhzgBUl
 56ry+jCYT1QQTCbvbyloqDqMEkbdKVBODlll+TGbKtGKHPPrHMoZ30IM/dY6TzUykL83
 jwCa3kTALiQIL/KcyfxGlTUL2RMdpbpijezqrao3lxX1WGBTxaIaaHx8bq2L43zMabfe
 KqiA==
X-Gm-Message-State: AOJu0YwZfDd9qmyzI89iTNxZHoLIB++IUk43yi4XMOZP99et5GGZqjTu
 abWHJ4dFsWKIQuHJHvixrAwlbfO8hg2zwdFj2HzaGMQYRlPIKEALMEQs
X-Gm-Gg: AeBDiev0aT0xfKXl0I327moOdxiSHbu6tybVKPppvqw81DDjYS0PTZ9YQ19Mh3Q6opr
 VkXSdXRD+4LKxm6A7YLmmuLoxx4MRODNGEVfpcJ+/L8FNHQQHIqFbgs9qXc0w99HOKUp8qTyr/z
 q4DkRVe35TIuOjA84kxiEynKAJ0cVXfPY+ZbST/KQ5muNPSGptDBd9eUk0BH4XdcWV8sSJdbV/m
 M3TaZltbXlvzIpTCNGCcsQ0e99hJTcqPsparmTr2rt9bQK8lbiKp2VPAKeiTgTiDJhn/ZsIZXZw
 SYtH5etAPk39rIldq3bxPJw6Yhw0F5WbarWT9N+P34AUfTx0vWkr/JnqbIca+xP+aDpF3oeURqa
 8dH629Kdbpro/q5A31dBjhMSktufDzVGT65VZlgGGAttIVEU4GIKbEbACEGATS8h4XvsyvBH3zz
 JsAU5JSqBy0l61Lkeu7CHqXJLh4NM2mpPuZcuHQ71AGsCQRKIsSWpsJ8kVJ3ZXah7CwzlAMhUy+
 6XrpcgwxeBJcn3rpo5mLuasBEM5UdTV+YruexuVAHPM
X-Received: by 2002:a17:90b:55cb:b0:35c:10e8:1a72 with SMTP id
 98e67ed59e1d1-361401f50d9mr2235143a91.7.1776425311398; 
 Fri, 17 Apr 2026 04:28:31 -0700 (PDT)
Received: from
 trieu2-huynh-trieuhpn-ubuntu24.beeworker.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140fc593bsm2402238a91.1.2026.04.17.04.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 04:28:30 -0700 (PDT)
Date: Fri, 17 Apr 2026 20:28:26 +0900
From: Trieu Huynh <vikingtc4@gmail.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Li Zhijian <lizhijian@fujitsu.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] migration/ram: avoid page population in ram_handle_zero
 via madvise
Message-ID: <zuuwkva3hc6tnpcmd6lobhaol52dr6ud7qs5burilp3qra5btd@emny7pbv43hv>
References: <20260328130110.166469-1-vikingtc4@gmail.com>
 <ad5uUqgY1IDvq37g@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad5uUqgY1IDvq37g@x1.local>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=vikingtc4@gmail.com; helo=mail-pj1-x102a.google.com
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

On Tue, Apr 14, 2026 at 12:41:54PM -0400, Peter Xu wrote:
> On Sat, Mar 28, 2026 at 10:01:10PM +0900, Trieu Huynh wrote:
> > When the destination receives a zero page during precopy migration,
> > ram_handle_zero() calls buffer_is_zero() which reads the page. For
> > anonymous mmap this is benign (reads map to the shared zero page), but
> > for memory-backend-memfd (mmap(MAP_SHARED) of a memfd) even a read
> > commits a physical page in the tmpfs page cache.
> > 
> > As a result, after migration all zero pages of the guest are committed
> > on the destination, turning a sparse RSS into a fully-populated one
> > (see GitLab issue #2839: a 256 GB VM went from ~4 GB RSS before
> > migration to ~256 GB after).
> > 
> > Add a bool can_discard parameter and call madvise(MADV_DONTNEED) when
> > it is true. This releases tmpfs/anonymous pages back to the kernel's
> > zero-page pool without reading the mapping at all. The madvise is
> > issued before any read or write, preventing the initial page fault
> > entirely.
> 
> Trieu,
> 
> Thanks again for the patch.
> 
It's always my pleasure. Thanks.
> > 
> > Callers pass can_discard = !(block->flags & RAM_PREALLOC) so that
> 
> I wonder if this will be enough.  E.g. see ram_block_discard_range() where
> it special cased RAM_READONLY_FD.
Worth cheking. Thanks for the point.
> 
> > backends with prealloc=on are unaffected: deliberately pre-faulted pages
> > must not be discarded. On the destination side vCPUs are paused
> > (RUN_STATE_INMIGRATE) while precopy pages are loaded, so madvise is
> > race-free.
> > 
> > After migration for VM with 4GB RAM, the RSS on destination was reduced
> > to 247 MB (vs 4148 MB before change), measured via VmRSS in
> > /proc/$PID/status.
> > 
> > Relates-to: https://wiki.qemu.org/ToDo/LiveMigration#Avoid_page_population_when_page_is_not_populated
> > See-also: https://gitlab.com/qemu-project/qemu/-/issues/2839
> 
> Please always loop in people that were involved in the discussions.  I'm
> adding Dan here.
> 
Noted, will add him and related people in v2.
> > 
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> > ---
> >  migration/ram.c  | 16 +++++++++++++---
> >  migration/ram.h  |  2 +-
> >  migration/rdma.c |  9 ++++++++-
> >  3 files changed, 22 insertions(+), 5 deletions(-)
> > 
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 2a7e958e87..e57613e29d 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3638,9 +3638,13 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
> >   *
> >   * @host: host address for the zero page
> >   * @size: size of the zero page
> > + * @can_discard: check whether RAMBlock was created with prealloc=on
> 
> This is fine, but let's avoid mentioning "prealloc=on" details.  It may not
> always be the case. As a helper function, we should normally describe what
> it implies when can_discard is set, not when it will be set.
Agreed. Will reword to focus on the behavior.
> 
> >   */
> > -void ram_handle_zero(void *host, uint64_t size)
> > +void ram_handle_zero(void *host, uint64_t size, bool can_discard)
> >  {
> > +    if (can_discard && qemu_madvise(host, size, QEMU_MADV_DONTNEED) == 0) {
> 
> I also don't know if DONTNEED will always work as expected.  E.g. when
> there're shared mappings and if the same page/folio is mapped elsewhere,
> DONTNEED may not be enough.  Again, see ram_block_discard_range() on the
> cases where ramblock is shared, or fd>0.
> 
> I wonder if we should just pass in ramblock itself as parameter with offset
> to zero..  then we can do all the checks here and directly invoke
> ram_block_discard_range() when it's applicable.
That makes a lot of sense. I will refactor ram_handle_zero() to take the
RAMBlock pointer and offset. This way, I can directly invoke
ram_block_discard_range(), which already handles the complex edge cases.
> 
> > +        return;
> > +    }
> >      if (!buffer_is_zero(host, size)) {
> >          memset(host, 0, size);
> >      }
> > @@ -4086,7 +4090,7 @@ static bool handle_zero_mapped_ram(RAMBlock *block, unsigned long from_bit_idx,
> >                     block->idstr);
> >          return false;
> >      }
> > -    ram_handle_zero(host, size);
> > +    ram_handle_zero(host, size, !(block->flags & RAM_PREALLOC));
> >  
> >      return true;
> >  }
> > @@ -4421,7 +4425,13 @@ static int ram_load_precopy(QEMUFile *f)
> >                  ret = -EINVAL;
> >                  break;
> >              }
> > -            ram_handle_zero(host, TARGET_PAGE_SIZE);
> > +            {
> > +                ram_addr_t ram_offset;
> > +                RAMBlock *rb = qemu_ram_block_from_host(host, false,
> > +                                                        &ram_offset);
> > +                bool can_discard = rb && !(rb->flags & RAM_PREALLOC);
> 
> IMHO there's no need to redo the lookup, we can extend the lifespan of the
> "block" variable right above when calculating the host address.
Agreed.
> 
> > +                ram_handle_zero(host, TARGET_PAGE_SIZE, can_discard);
> > +            }
> >              break;
> >  
> >          case RAM_SAVE_FLAG_PAGE:
> > diff --git a/migration/ram.h b/migration/ram.h
> > index 41697a7599..faa80f27d1 100644
> > --- a/migration/ram.h
> > +++ b/migration/ram.h
> > @@ -90,7 +90,7 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
> >  int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp);
> >  int ram_load_postcopy(QEMUFile *f, int channel);
> >  
> > -void ram_handle_zero(void *host, uint64_t size);
> > +void ram_handle_zero(void *host, uint64_t size, bool can_discard);
> >  
> >  void ram_transferred_add(uint64_t bytes);
> >  void ram_release_page(const char *rbname, uint64_t offset);
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index 55ab85650a..d4c36af5b9 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -28,6 +28,7 @@
> >  #include "qemu/error-report.h"
> >  #include "qemu/main-loop.h"
> >  #include "qemu/module.h"
> > +#include "system/ramblock.h"
> >  #include "qemu/rcu.h"
> >  #include "qemu/sockets.h"
> >  #include "qemu/bitmap.h"
> > @@ -3413,7 +3414,13 @@ int rdma_registration_handle(QEMUFile *f)
> >                               comp->value);
> >                  goto err;
> >              }
> > -            ram_handle_zero(host_addr, comp->length);
> > +            {
> > +                ram_addr_t ram_offset;
> > +                RAMBlock *rb = qemu_ram_block_from_host(host_addr, false,
> > +                                                        &ram_offset);
> 
> Similar here, a slight difference is RDMA manages ramblocks with its own
> internal data structure, so I wonder if we want to simply cache the block
> pointer somewhere in qemu_rdma_init_one_block() if we want to make
> ram_handle_zero() take the ramblock ptr directly.
Understood. I'll cache the RAMBlock pointer in the RDMA block structure
during init rather than doing a lookup per zero page.
> 
> The other thing is I'm not yet sure if you have tested this code.  Please
> keep that in mind whatever patches one posted need to be properly tested.
> It's definitely not good to send whatever not tested for merging.  Here,
> this changes RDMA code path.  You can have a look at our RDMA unit tests,
> but you'll also need to setup it.  There's a helper you can use, see
> scripts/rdma-migration-helper.sh.
You're right to be concerned. I haven't been able to test RDMA path
since env.
Thanks for the point again. Will try to set up right env for validation
avoid breaking that path and hopefully the patch can work with same
behavior. Alternatively, I might think can split the patch so the core fix
can be reviewed independently if needed.
> 
> > +                bool can_discard = rb && !(rb->flags & RAM_PREALLOC);
> > +                ram_handle_zero(host_addr, comp->length, can_discard);
> > +            }
> >              break;
> >  
> >          case RDMA_CONTROL_REGISTER_FINISHED:
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Peter Xu
> 
Thanks for your kind review again.

BRs,
Trieu Huynh

