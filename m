Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879FCE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWI1f-0002mB-U0; Fri, 10 Jan 2025 11:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1tWI14-0002fW-De; Fri, 10 Jan 2025 11:37:46 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1tWI12-00010f-Et; Fri, 10 Jan 2025 11:37:46 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3ADB348FDB;
 Fri, 10 Jan 2025 17:37:34 +0100 (CET)
Message-ID: <81befe6a-49fb-47bb-88fc-3fde73bb7c8c@proxmox.com>
Date: Fri, 10 Jan 2025 17:37:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block-backend: protect setting block root to NULL with
 block graph write lock
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 qemu-block@nongnu.org
References: <20250108124649.333668-1-f.ebner@proxmox.com>
 <Z3-pTUj66O2nfqc_@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <Z3-pTUj66O2nfqc_@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Am 09.01.25 um 11:47 schrieb Kevin Wolf:
> Am 08.01.2025 um 13:46 hat Fiona Ebner geschrieben:
>> Setting blk->root is a graph change operation and thus needs to be
>> protected by the block graph write lock in blk_remove_bs(). The
>> assignment to blk->root in blk_insert_bs() is already protected by
>> the block graph write lock.
> 
> Hm, if that's the case, then we should also enforce this in the
> declaration of BlockBackend:
> 
>     BdrvChild * GRAPH_RDLOCK_PTR root;
> 
> However, this results in more compiler failures that we need to fix. You
> caught the only remaining writer, but the lock is only fully effective
> if all readers take it, too.

I started giving this a try, but quickly ran into some issues/questions:

1. For global state code, is it preferred to use
GRAPH_RDLOCK_GUARD_MAINLOOP() to cover the whole function or better to
use bdrv_graph_rd(un)lock_main_loop() to keep the locked section as
small as necessary? I feel like the former can be more readable, e.g. in
blk_insert_bs(), blk_new_open(), where blk->root is used in conditionals.

2. In particular, protecting blk->root means that blk_bs() needs to have
the read lock. In fact, blk_bs() is reading blk->root twice in a row, so
it seems like it could suffer from a potential NULL pointer dereference
(or I guess after compiler optimization a potential use-after-free)?

Since blk_bs() is IO_CODE() and not a coroutine, I tried to mark it
GRAPH_RDLOCK and move on to the callers.

However, one caller is blk_nb_sectors() which itself is called by
blk_get_geometry(). Both of these are manually-written coroutine wrappers:

> commit 81f730d4d0e8af9c0211c3fedf406df0046341a9
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Fri Apr 7 17:33:03 2023 +0200
> 
>     block, block-backend: write some hot coroutine wrappers by hand
>     
>     The introduction of the graph lock is causing blk_get_geometry, a hot function
>     used in the I/O path, to create a coroutine.  However, the only part that really
>     needs to run in coroutine context is the call to bdrv_co_refresh_total_sectors,
>     which in turn only happens in the rare case of host CD-ROM devices.
>     
>     So, write by hand the three wrappers on the path from blk_co_get_geometry to
>     bdrv_co_refresh_total_sectors, so that the coroutine wrapper is only created
>     if bdrv_nb_sectors actually calls bdrv_refresh_total_sectors.

Both the blk_bs() and blk_nb_sectors() functions are IO_CODE(), but not
coroutines, and callers of blk_get_geometry are already in the device
code. I'm not sure how to proceed here, happy to hear suggestions :)

---snip---

>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index c93a7525ad..9678615318 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -887,9 +887,9 @@ void blk_remove_bs(BlockBackend *blk)
>>       */
>>      blk_drain(blk);
>>      root = blk->root;
>> -    blk->root = NULL;
>>  
>>      bdrv_graph_wrlock();
>> +    blk->root = NULL;
>>      bdrv_root_unref_child(root);
>>      bdrv_graph_wrunlock();
>>  }
> 
> I think the 'root = blk->root' needs to be inside the locked section,
> too. Otherwise blk->root could change during bdrv_graph_wrlock() (which
> has a nested event loop) and root would be stale. I assume clang would
> complain about this with the added GRAPH_RDLOCK_PTR.

Oh I see, good catch!

Best Regards,
Fiona


