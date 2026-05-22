Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14F5CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 13:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQQL4-00018g-Ms; Fri, 22 May 2026 09:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wQQL0-00018R-0x; Fri, 22 May 2026 09:54:54 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wQQKx-0002uS-Oo; Fri, 22 May 2026 09:54:53 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5544CA1056;
 Fri, 22 May 2026 15:54:40 +0200 (CEST)
Message-ID: <b8ee4f3e-b866-4420-b332-0ea2766aeb4f@proxmox.com>
Date: Fri, 22 May 2026 15:54:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcow2: Fix data loss on zero write with
 detect-zeroes=unmap
To: Thomas Lamprecht <t.lamprecht@proxmox.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20260522120638.3992702-1-t.lamprecht@proxmox.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20260522120638.3992702-1-t.lamprecht@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1779458060695
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Am 22.05.26 um 2:06 PM schrieb Thomas Lamprecht:
> Commit b8bfb1478d ("qcow2: Fix corruption on discard during write with
> COW") added a wait_for_dependencies() at the start of
> qcow2_subcluster_zeroize(). That fixes the inconsistency it set out to
> fix, but turns the lock-protected pre-check in the caller,
> qcow2_co_pwrite_zeroes(), into a stale one: the wait yields s->lock,
> so an in-flight allocating write whose QCowL2Meta is already on
> s->cluster_allocs (but whose L2 entry is not yet linked) gets to link
> its entry during the yield. When the zeroize wakes, the cluster is now
> NORMAL, and with BDRV_REQ_MAY_UNMAP the free path in zero_in_l2_slice()
> unmaps the just-written cluster, silently dropping the data write's
> payload.
> 
> This is reachable with detect-zeroes=unmap (the default for VirtIO
> disks with discard on in Proxmox VE), under which the block layer
> auto-promotes all-zero buffers to BDRV_REQ_ZERO_WRITE |
> BDRV_REQ_MAY_UNMAP. One can, for example, setup a memory-constrained
> Debian guest running 'apt full-upgrade' on such a disk reproduces it as
> random SIGSEGVs: swapped-out code pages come back as zero.
> 
> To fix this, wait for in-flight dependencies before the lock-protected
> check in qcow2_co_pwrite_zeroes(). If a write linked its L2 entry during
> the wait, the type check now fails and the block layer falls back to a
> bounce-buffered zero write that only touches the requested subrange,
> preserving the racing write's data. Promote wait_for_dependencies() to
> qcow2_wait_for_dependencies() so qcow2.c can call it.
> 
> Fixes: b8bfb1478d ("qcow2: Fix corruption on discard during write with COW")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>

Good find! It works for me too and looks good to me :)

Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 81fd299b4c..d52002fd80 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4234,10 +4234,16 @@ qcow2_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
>          }
>  
>          qemu_co_mutex_lock(&s->lock);
> -        /* We can have new write after previous check */
>          offset -= head;
>          bytes = s->subcluster_size;
> -        nr = s->subcluster_size;
> +        /*
> +         * Wait for in-flight allocating writes first: otherwise the type

Nit: I'd suggest "otherwise it can happen that the type ..." or
alternatively, using some other kind of conditional tense/form in the
rest of the sentence

> +         * check below passes on UNALLOCATED while a yet-to-link_l2 write
> +         * completes during qcow2_subcluster_zeroize()'s own wait and the
> +         * resumed MAY_UNMAP discards the just-written data.
> +         */
> +        qcow2_wait_for_dependencies(bs, offset, bytes);
> +        nr = bytes;
>          ret = qcow2_get_host_offset(bs, offset, &nr, &off, &type);
>          if (ret < 0 ||
>              (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN &&

---snip 8<---

> diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
> index e03dd40147..2a0429e93a 100755
> --- a/tests/qemu-iotests/046
> +++ b/tests/qemu-iotests/046
> @@ -226,6 +226,25 @@ aio_write -z 0x140000 0x10000
>  resume A
>  aio_flush
>  EOF
> +
> +# Start an allocating write to a previously unallocated cluster and, before
> +# its L2 update is linked, issue a concurrent sub-cluster zero write with
> +# MAY_UNMAP that targets a disjoint range within the same cluster. The zero
> +# write's head/tail are zero (cluster is unallocated), so qcow2_co_pwrite_zeroes
> +# would expand it to the full subcluster. Without the fix the zero write's

While one can look up what the fix is in the commit history, I'd avoid
mentioning just "the fix" here. Maybe "Without waiting for dependencies
before the zero write's stale ..."

> +# stale "unallocated" type check passes, qcow2_subcluster_zeroize then yields
> +# in wait_for_dependencies, the allocating write links its L2 entry, and the
> +# resumed zeroize unmaps the cluster - silently discarding the just-written
> +# data. The fix makes the zero write fall back to a bounce-buffered real
> +# write, which only touches its own subrange.


