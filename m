Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BFECD4F39
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 15:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNBVz-0007HV-8V; Wed, 13 May 2026 11:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wNBVm-00078p-Ko; Wed, 13 May 2026 11:28:39 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wNBVi-0003Vk-I2; Wed, 13 May 2026 11:28:38 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D9BFCA499E;
 Wed, 13 May 2026 17:28:10 +0200 (CEST)
Message-ID: <f0475800-5c2d-429b-a98f-8016aad048b4@proxmox.com>
Date: Wed, 13 May 2026 17:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] commit: Drain nodes across all of bdrv_commit()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, den@openvz.org,
 stefanha@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org
References: <20260427170520.101242-1-kwolf@redhat.com>
 <20260427170520.101242-2-kwolf@redhat.com>
 <c0e3fe09-6491-4a36-ae81-41c0de0befd2@proxmox.com>
 <agMaEZFmV5WlU5Y6@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <agMaEZFmV5WlU5Y6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1778686086434
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

Hi Kevin,

Am 12.05.26 um 2:14 PM schrieb Kevin Wolf:
> Am 29.04.2026 um 17:06 hat Fiona Ebner geschrieben:
>> Am 27.04.26 um 7:43 PM schrieb Kevin Wolf:
>>> The whole implementation of bdrv_commit() is only correct if no new
>>> writes come in while it's running: It has only a single loop checking
>>> the allocation status for each block and finally calls bdrv_make_empty()
>>> without checking if that throws away any new changes.
>>>
>>> We already have to drain while taking the graph write lock. Just extend
>>> the drained section to all of bdrv_commit() to make sure that we don't
>>> get any inconsistencies.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  block/commit.c | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/commit.c b/block/commit.c
>>> index 0d9e1a16d7a..c5e3ef03a21 100644
>>> --- a/block/commit.c
>>> +++ b/block/commit.c
>>> @@ -518,6 +518,7 @@ int bdrv_commit(BlockDriverState *bs)
>>>      if (!drv)
>>>          return -ENOMEDIUM;
>>>  
>>> +    bdrv_drain_all_begin();
>>
>> I suppose we could instead drain only the affected BDSs? Blocking all
>> for the whole duration of the blk_pread+blk_pwrite loop seems a bit much.
> 
> Possible, but I'm not completely sure. Basically what I did here is just
> moving the drain part of bdrv_graph_wrlock_drained() earlier, which also
> drains all nodes.
> 
> I think when you introduced it, the idea was that just draining
> everything is acceptable and easier to verify. Which means that it might
> not be strictly necessary, but I don't want to prove that now either.
> 
> Ultimately this drain_all goes back to commit 91ba0e1, in which you
> stated:
> 
>     More granular draining is not trivially possible, because
>     bdrv_change_aio_context() can recursively call itself e.g. via
>     bdrv_child_change_aio_context().
> 

oh, right. I had forgotten about that recursion.

>> Independently of that, I wonder if blk_commit_all() should drain all?
>> I'm not familiar with it, but it seems that the intent is to have a
>> point-in-time state which is consistent between different BDSs? That
>> intent could be made explicit by draining all.
> 
> Hm, I suppose that would make sense, yes. Do you want to send a patch on
> top of this? Bonus points for a test case that shows the inconsistency.

I'll add it to my TODO pile, but it'll be a few weeks, as I'm quite busy
with other work at the moment.

Best Regards,
Fiona


