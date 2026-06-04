Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9628CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 05:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV0ZD-0003PE-Rl; Thu, 04 Jun 2026 01:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wV0ZB-0003P5-P5
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 01:24:30 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wV0Z8-00077F-8b
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 01:24:29 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6545O7kr008004
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Jun 2026 14:24:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=oSjqDg0OLBA2YIuFg1APu1JREpsGBR3FxtR1vfyVIKo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1780550647; v=1;
 b=PZVQLu7pZp8Zk9FfMlgQ4Twn5HeJbY6Akvjzvbdifa1IcRKzPJPedib8WZ3ktDoQ
 9L/2NJbIDxqjL20Zemb3gTimSB9X1wFvSUUEhVxmaIeBiWWae7KY/oiVXxTVCzAz
 56h1s2IeEoTxwJ8ZLJh8HFYzWk34PtuPeG09fuqwhHYaJE9So5Dc33Agu+lwMyQu
 IasUSry8LRXzqzGDoeDlOxHyiNQ0C7x3QiDT4hlC4cwmTJ5Sdade9JtWRMkCqizu
 x0zRdTjw/VS7Qdh+af43e7+ti4kayUwFM15tiINi6dsxE9tay8xGGGSpfNU9KJGy
 9KNmAXszNfIQXb1psrj6ZA==
Message-ID: <8eadb481-6d3a-459e-9db8-a9cca13d1cf4@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 4 Jun 2026 14:24:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory/ramblock: Fix clear of mru_block on possible race
 condition
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260601205900.1067714-1-peterx@redhat.com>
 <36749195-2c49-4f9c-8445-2e67b2097676@rsg.ci.i.u-tokyo.ac.jp>
 <ah80T6aIns82fspH@x1.local>
 <622da0a8-8101-4816-bf20-b5c3c9547a5f@rsg.ci.i.u-tokyo.ac.jp>
 <aiBl-hXpmXc8ULSJ@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aiBl-hXpmXc8ULSJ@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/06/04 2:35, Peter Xu wrote:
> On Wed, Jun 03, 2026 at 02:11:44PM +0900, Akihiko Odaki wrote:
>> qemu_get_ram_block() may set mru_block during the grace period. Once
>> mru_block is set, RCU readers can still access the ramblock, even if the
>> block is no longer visible in ram_list.
> 
> True..
> 
>>
>> When enriching the comment in reclaim_ramblock_prepare(), I think the phrase
>> “the last reader that can access this ramblock is gone” could be improved.
>> What matters here is that the last reader that could find the block in
>> ram_list is gone. The block is no longer visible in ram_list to any later
>> reader, and clearing the cache at that point ensures that it is no longer
>> visible through an mru_block cache hit either.
> 
> Yes that's ambiguous.
> 
> I updated comments in this patch, removed the 1st reset of mru_block, and
> when at it also touched up the comment in qemu_get_ram_block(), let me know
> if there's further comments before repost.

It looks good. You may repost it with my Reviewed-by added:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

> 
> Thanks,
> 
> ===8<===
>  From 18789a1136c753a6cdce1ea698cf4c1871121cc9 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Fri, 29 May 2026 12:05:15 -0400
> Subject: [PATCH] memory/ramblock: Fix clear of mru_block on possible race
>   condition
> 
> The race condition was not reported in any real bug, but I found it while
> reviewing some relevant chnages from Akihiko [1].  It's not clear if
> there's any way to reproduce it, so far it's only theoretical.  Hence
> there's also no Fixes tag attached.  There's also no need to copy stable
> until we have a solid reproducer.
> 
> Currently, mru_block might still points to ramblocks that are removed if
> below race condition happens:
> 
>    Reader A                              Writer
>    --------                              ------
>    rcu_read_lock()
>    walk list, find block X
>                                          QLIST_REMOVE_RCU(X)
>                                          qatomic_set(&mru_block, NULL)
>                                          call_rcu(X, reclaim_ramblock)
>    qatomic_set(&mru_block, X)  <----------- overwrites NULL
>    rcu_read_unlock()
>                                          grace period ends, X freed
> 
>    Reader C
>    --------
>    rcu_read_lock()
>    qatomic_rcu_read(&mru_block) -> X
>    Read X's block->offset ...  <----------- UAF
> 
> To fix it, we can introduce a nested RCU free for reset of the mru_block
> field, and only free the ramblock until the 2nd RCU call.
> 
> Since QEMU always: (1) dequeue the RCU node before invoking the
> function, (2) reset all fields in rcu_head in the call_rcu1() call, nested
> RCU will work all fine like what's used in this patch.
> 
> [1] https://lore.kernel.org/r/5fd9e540-cf13-45f5-ba9a-c7faf364035b@rsg.ci.i.u-tokyo.ac.jp
> 
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> Based-on: <5fd9e540-cf13-45f5-ba9a-c7faf364035b@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   system/physmem.c | 46 ++++++++++++++++++++++++++++++----------------
>   1 file changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 9e1ac13e82..c9e5696d6a 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -836,21 +836,14 @@ static RAMBlock *qemu_get_ram_block(ram_addr_t addr)
>       abort();
>   
>   found:
> -    /* It is safe to write mru_block outside the BQL.  This
> -     * is what happens:
> -     *
> -     *     qatomic_set(&mru_block, xxx)
> -     *     rcu_read_unlock()
> -     *                                        xxx removed from list
> -     *                  rcu_read_lock()
> -     *                  read mru_block
> -     *                                        qatomic_set(&mru_block, NULL);
> -     *                                        call_rcu(reclaim_ramblock, xxx);
> -     *                  rcu_read_unlock()
> +    /*
> +     * It is safe to write mru_block outside the BQL, the writer (e.g. when
> +     * QEMU frees a ramblock) is designed to be thread-safe with readers
> +     * updating this field concurrently.  See reclaim_ramblock_prepare().
>        *
> -     * qatomic_rcu_set is not needed here.  The block was already published
> -     * when it was placed into the list.  Here we're just making an extra
> -     * copy of the pointer.
> +     * qatomic_rcu_set() is not needed here, because the block was already
> +     * published when it was placed into the list.  Here we're just making
> +     * an extra copy of the pointer.
>        */
>       qatomic_set(&ram_list.mru_block, block);
>       return block;
> @@ -2590,6 +2583,23 @@ static void reclaim_ramblock(RAMBlock *block)
>       g_free(block);
>   }
>   
> +static void reclaim_ramblock_prepare(RAMBlock *block)
> +{
> +    /*
> +     * After one round of grace period, no more reader can see this
> +     * ramblock via ram_list.  Reset this field making sure it will never
> +     * point to the ramblock being freed.
> +     */
> +    qatomic_set(&ram_list.mru_block, NULL);
> +    /*
> +     * Wait for a second round of grace period to make sure whoever
> +     * accessed the ramblock previously via mru_block has finished using
> +     * it.  Note: this is an intended nested use of rcu_head.  If needed,
> +     * we can provide two rcu_heads for ramblock.
> +     */
> +    call_rcu(block, reclaim_ramblock, rcu);
> +}
> +
>   void qemu_ram_free(RAMBlock *block)
>   {
>       g_autofree char *name = NULL;
> @@ -2607,10 +2617,14 @@ void qemu_ram_free(RAMBlock *block)
>       name = cpr_name(block->mr);
>       cpr_delete_fd(name, 0);
>       QLIST_REMOVE_RCU(block, next);
> -    qatomic_set(&ram_list.mru_block, NULL);
>       /* Write list before version */
>       qatomic_store_release(&ram_list.version, ram_list.version + 1);
> -    call_rcu(block, reclaim_ramblock, rcu);
> +    /*
> +     * Wait for a grace period to make sure no reader can see this ramblock
> +     * via ram_list anymore.  Note that readers can still see and access
> +     * the ramblock via mru_block, so we can't free it yet.
> +     */
> +    call_rcu(block, reclaim_ramblock_prepare, rcu);
>       qemu_mutex_unlock_ramlist();
>   }
>   


