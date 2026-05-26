Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488B8CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 21:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRzRg-0004FR-4y; Tue, 26 May 2026 17:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRzRd-0004FJ-DU
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRzRR-00076K-Hs
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779831359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YrBRKPt4AoB9fqKY8dFFstw7p2+NWRfv3QZf699GQnM=;
 b=ZsH02V1l4nmaE0lMkZz55/erBPrIvacrrD/bQm4WPOUtpWrtAQpJDLsfVLm297hEE0trUg
 IKt+cQiP7dh/sEaBopEp6mdWtzX+dNyeLlSDCHDVDO3G8FvYi7ciA+MuRHh1HA2FzSGbEo
 Zzcn84q7xtQAK2N3ImZq4nEEUxXQ0M0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-nBO2TLnSPFKBQEurD3BAjA-1; Tue, 26 May 2026 17:35:58 -0400
X-MC-Unique: nBO2TLnSPFKBQEurD3BAjA-1
X-Mimecast-MFC-AGG-ID: nBO2TLnSPFKBQEurD3BAjA_1779831357
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8aca4660827so214796026d6.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779831357; x=1780436157; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YrBRKPt4AoB9fqKY8dFFstw7p2+NWRfv3QZf699GQnM=;
 b=qByneU7hWCoPpOleBXPj84R7yb/nC9xEmrXWZGHxlXrQiwWo6rVdt5T1H1WFdWig2c
 5OkPYl9oDA9Nw9oqMr9u6ohVvqXcnsfn67rEMwaabyo4I4Vixu9Fi2eSJ6cNdH8LpqCT
 5MmJEbshGDCd4qgj0Owd0bwp7ja1H4wXf5XFFTXmP/vJUo4F+Xpm2tDHZtN75PjAuFlS
 +cn3ND/mqGTfreI8OdAmYB5vM8vGKs9Oaq8oHBJgUm7iz1g63Dip8b6F2tdhG/y2JJpt
 oD6BZXtlEtxvht6HMIvTa5IBME8cBMIa+KvEZLz2RIU3Jts625y0BA9Nnc3L1YQgR6KD
 vjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779831357; x=1780436157;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YrBRKPt4AoB9fqKY8dFFstw7p2+NWRfv3QZf699GQnM=;
 b=g1z8GYT//8qKio4kYhaqGW6a5doNimpOTnc20vpC4V/lOS0PSHbLLJVatqyZX6bjia
 sf2Rd1dUkJLI8gr8pQljlPP9fXUekuoQ9mqPjh4RVtpleX99b9/4R0+l/hRA9zonr0WT
 xAqpTlCusRmOifmIBpl0LTAWgfxKcBc4CvNMpF7vhayQdansd8mXGy8j7a6Jtchp+MIx
 4Z/jh5tWbh6IdK0TQBjrflGGHMOxgND4fIHmJLLY2a8CLomWNY3rcHnHtt3a1D3GZ0vp
 il3Sqq+cP0NPcj0XfcBhg79kffxt+q9+8V+sLthAV0781VSqTYqCEYYxyB7+8UEBX6lI
 CSuQ==
X-Gm-Message-State: AOJu0YwKv6aW0xTddtUkLaJZZrd8G2iFMdBzR8TYE3+zI/RbqYvKuHq9
 rkgGZ2GsVojZQG9ajEzu34HAVeQ9ihjBzWPHMSU/Z/ZHVJftEYreopDQI5P3JSG99fETa76SjrK
 9GnfQs137N5IhYz7uHuAdD2KYyVfjllPaZdQY1kyNBv9MLOUT8N2m7mID
X-Gm-Gg: Acq92OE2IS8Eyx1NEs6A2Kkkjr9b1KLf+fMhRzfKEV1DRMeBFCyjRumaQ72iMolFwZp
 uUqlQRetkulpIxR2CQV9hZDvH1IXuqW+2oGmlf82g8SN4ptDY3zRWS9lCRfEUUtYvCff5tunIoU
 jcE0GLaxdaoFvzy28EXHBmZcputXva0J0XTaPor+NxEY51uh76KCipeoOwk1wvwuHOKgB3hYVHr
 FibIXFlx5zu1rG5VIcpnsGpPu6GWJkQk/3aZslZ5bUU5jIFa+AetUeZUtW0ZWUMdWP3cBZQeen0
 jkX53j3m9Y9fRpLH7K1a5iznlaOGJWXt027hHZo58QcmDh/960Ebj3UzsGlJ0gUB2g656LmtqOZ
 KgnHJF4Bb111817mi7GczVtFUnTBYMKLZYA8zxQd+x3szr7E=
X-Received: by 2002:a05:6214:242a:b0:8cc:c85:8aac with SMTP id
 6a1803df08f44-8cc7b57ee02mr348365266d6.21.1779831357324; 
 Tue, 26 May 2026 14:35:57 -0700 (PDT)
X-Received: by 2002:a05:6214:242a:b0:8cc:c85:8aac with SMTP id
 6a1803df08f44-8cc7b57ee02mr348364736d6.21.1779831356754; 
 Tue, 26 May 2026 14:35:56 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc812e2018sm153739336d6.28.2026.05.26.14.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 14:35:56 -0700 (PDT)
Date: Tue, 26 May 2026 17:35:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] system/physmem: Synchronize ram_list accesses
Message-ID: <ahYSO98JgdYJrP2e@x1.local>
References: <20260523-tsan-v1-1-07d5eb9dcaa2@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260523-tsan-v1-1-07d5eb9dcaa2@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, May 23, 2026 at 09:38:28PM +0900, Akihiko Odaki wrote:
> Alex Bennée reported a ThreadSanitizer warning about a plain concurrent
> access to ram_list [1]. Ensure the concurrent accesses to ram_list are
> properly synchronized with atomic accesses, mutexes, or RCU.
> 
> First, the plain assignments of ram_list.mru_block are replaced with
> qatomic_set(). A comment in qemu_get_ram_block() explains why the
> ordering requirement is relaxed, but it still needs to be atomically
> accessed. include/qemu/atomic.h says:
> 
> > The C11 memory model says that variables that are accessed from
> > different threads should at least be done with __ATOMIC_RELAXED
> > primitives or the result is undefined. Generally this has little to
> > no effect on the generated code but not using the atomic primitives
> > will get flagged by sanitizers as a violation.
> 
> Second, ram_list.version accesses are replaced with atomic operations
> or protected with a mutex. Unlike ram_list.mru_block, ram_list.version
> has tighter ordering requirements for one of its goals: ensuring that
> the reader-held rs->last_seen_block value is invalidated whenever a RAM
> block is reclaimed between two RCU reader critical sections. Below are
> steps a reader and an updater follow:
> 
> Reader:
> 
> R-1. Enter the first RCU read-side critical section:
> R-1-1. rs->last_version = qatomic_load_acquire(&ram_list.version)
> R-1-2. rs->last_seen_block = an element of ram_list.blocks
> R-2. Enter the second RCU read-side critical section:
> R-2-1. if (qatomic_read(&ram_list.version) != rs->last_version)
> R-2-2.     rs->last_seen_block = NULL
> 
> Updater:
> 
> W-1. Enter a ram_list.mutex critical section
> W-1-1. Update ram_list.blocks
> W-1-2. qatomic_store_release(&ram_list.version, ram_list.version + 1)
> W-2. Enter another ram_list.mutex critical section
> W-2-1. QLIST_REMOVE_RCU(block, next)
> W-2-2. qatomic_store_release(&ram_list.version, ram_list.version + 1)
> W-2-3. call_rcu(block, reclaim_ramblock, rcu)
> 
> W-1-2 represents the write observed by R-1-1.
> 
> ram_list.version is read non-atomically on the update side because the
> update side is serialized with ram_list.mutex. The other ram_list
> accesses in these steps are reasoned about in two cases.
> 
> When the grace period of W-2-3 contains R-2:
>     qatomic_load_acquire() at R-1-1 and qatomic_store_release() at W-1-2
>     enforce the following ordering:
>         W-1-1 -> W-1-2 -> R-1-1 -> R-1-2
>     The value of ram_list.blocks stored by W-1-1 or a newer value that
>     was loaded by R-1-2 is still valid because of the grace period.
> 
> When the grace period of W-2-3 ends before R-2:
>     call_rcu() at W-2-3 and the read-side critical section at R-2 ensure
>     the following ordering:
>         W-2-2 -> W-2-3 -> the grace period -> R-2 -> R-2-1
>     The value of ram_list.version stored by W-2-2 or a newer value that
>     was loaded by R-2-1 differs from rs->last_version and the reader
>     invalidates rs->last_seen_block.
> 
> Together, these steps ensure that rs->last_seen_block is invalidated
> whenever necessary. With added atomic operations, pre-existing memory
> barriers are no longer necessary and are removed.
> 
> Any other ram_list accesses are already properly synchronized.
> 
> [1] https://lore.kernel.org/qemu-devel/878q9fbmap.fsf@draig.linaro.org/
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Above link [1] also mentioned about a hang.  Just to double check: we're
only trying to silent the TSAN warning (which is a false positive), right?

> ---
>  migration/ram.c  | 10 +++++-----
>  system/physmem.c | 16 +++++++---------
>  2 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index fc38ffbf8af1..6da24d725861 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2495,7 +2495,10 @@ static void ram_state_reset(RAMState *rs)
>  
>      rs->last_seen_block = NULL;
>      rs->last_page = 0;
> -    rs->last_version = ram_list.version;
> +
> +    /* Read version before ram_list.blocks */
> +    rs->last_version = qatomic_load_acquire(&ram_list.version);
> +
>      rs->xbzrle_started = false;
>  
>      ram_page_hint_reset(&rs->page_hint);
> @@ -3270,13 +3273,10 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>       */
>      WITH_QEMU_LOCK_GUARD(&rs->bitmap_mutex) {
>          WITH_RCU_READ_LOCK_GUARD() {
> -            if (ram_list.version != rs->last_version) {
> +            if (qatomic_read(&ram_list.version) != rs->last_version) {
>                  ram_state_reset(rs);
>              }

Not directly relevant to this patch, but I never thought into why this few
lines are needed at all, and then I found I don't have an answer..

Here, ram_list version change should only happen during ramblock
add/remove.  I can think of a few special cases:

a) device add/remove (e.g. dimms) causing new / removing ramblocks, should
   never happen as qdev code fails any device add/remove attempt during
   migration (qdev_device_add_from_qdict, qdev_unplug)

b) virtio-mem, which only manages one memory backend, hence one ramblock,
   no add/remove

c) virtio-gpu, will do random add/remove with memory_region_init_ram_ptr()
   which means ramblocks are not migratable

PS: I recall we have other special cases like ROM sizes can change on dest
QEMU, but it's about used_length, not about version boosts, so doesn't
matter here.

Both a) and b) should make sure no change on version, c) will change
version, but in a case where the ramblock is destined to be not migratable,
hence not visible to migration core.

The patch itself looks all fine, but I'm just wondering if we should just
remove this check completely or even try to somehow trap it from happening
(if we can rule out things like virtio-gpu): if something really changed,
it'll be a serious problem because we sync ramblock list already during
ram_save_setup.

Thanks,

>  
> -            /* Read version before ram_list.blocks */
> -            smp_rmb();
> -
>              ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
>              if (ret < 0) {
>                  qemu_file_set_error(f, ret);
> diff --git a/system/physmem.c b/system/physmem.c
> index 7bcbf8757361..9e1ac13e8259 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -839,12 +839,12 @@ found:
>      /* It is safe to write mru_block outside the BQL.  This
>       * is what happens:
>       *
> -     *     mru_block = xxx
> +     *     qatomic_set(&mru_block, xxx)
>       *     rcu_read_unlock()
>       *                                        xxx removed from list
>       *                  rcu_read_lock()
>       *                  read mru_block
> -     *                                        mru_block = NULL;
> +     *                                        qatomic_set(&mru_block, NULL);
>       *                                        call_rcu(reclaim_ramblock, xxx);
>       *                  rcu_read_unlock()
>       *
> @@ -852,7 +852,7 @@ found:
>       * when it was placed into the list.  Here we're just making an extra
>       * copy of the pointer.
>       */
> -    ram_list.mru_block = block;
> +    qatomic_set(&ram_list.mru_block, block);
>      return block;
>  }
>  
> @@ -2260,11 +2260,10 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>      } else { /* list is empty */
>          QLIST_INSERT_HEAD_RCU(&ram_list.blocks, new_block, next);
>      }
> -    ram_list.mru_block = NULL;
> +    qatomic_set(&ram_list.mru_block, NULL);
>  
>      /* Write list before version */
> -    smp_wmb();
> -    ram_list.version++;
> +    qatomic_store_release(&ram_list.version, ram_list.version + 1);
>      qemu_mutex_unlock_ramlist();
>  
>      physical_memory_set_dirty_range(new_block->offset,
> @@ -2608,10 +2607,9 @@ void qemu_ram_free(RAMBlock *block)
>      name = cpr_name(block->mr);
>      cpr_delete_fd(name, 0);
>      QLIST_REMOVE_RCU(block, next);
> -    ram_list.mru_block = NULL;
> +    qatomic_set(&ram_list.mru_block, NULL);
>      /* Write list before version */
> -    smp_wmb();
> -    ram_list.version++;
> +    qatomic_store_release(&ram_list.version, ram_list.version + 1);
>      call_rcu(block, reclaim_ramblock, rcu);
>      qemu_mutex_unlock_ramlist();
>  }
> 
> ---
> base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
> change-id: 20260520-tsan-c6f1aa909a90
> 
> Best regards,
> --  
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 

-- 
Peter Xu


