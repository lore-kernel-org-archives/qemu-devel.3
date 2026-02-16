Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AB6E7BDB0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 13:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vryEu-0000fV-FA; Mon, 16 Feb 2026 08:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vryEa-0000QI-5z; Mon, 16 Feb 2026 08:01:55 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vryEV-0000rM-Px; Mon, 16 Feb 2026 08:01:50 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 86F3049211;
 Mon, 16 Feb 2026 14:01:43 +0100 (CET)
Message-ID: <5f336c06-c675-4d21-8c1c-e1a1ebe8e09f@proxmox.com>
Date: Mon, 16 Feb 2026 14:01:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/mirror: disable dirty bitmap only after job init
From: Fiona Ebner <f.ebner@proxmox.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-block@nongnu.org,
 hreitz@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 jean-louis@dupond.be, dionbosschieter@gmail.com
References: <20260212120411.369498-1-f.ebner@proxmox.com>
 <aZLwdRhpTHvi1Y1-@redhat.com>
 <66c3fca8-0f64-4cec-a2a9-5959ef67a251@proxmox.com>
Content-Language: en-US
In-Reply-To: <66c3fca8-0f64-4cec-a2a9-5959ef67a251@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1771246896108
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 16.02.26 um 1:48 PM schrieb Fiona Ebner:
> Am 16.02.26 um 11:25 AM schrieb Kevin Wolf:
>> Am 12.02.2026 um 13:02 hat Fiona Ebner geschrieben:
>>> Currently, the dirty bitmap is disabled too early and the following
>>> bad scenario is possible:
>>>
>>> 1. Dirty bitmap is disabled in mirror_start_job()
>>> 2. Some request are started in mirror_top_bs while s->job == NULL
>>> 3. mirror_dirty_init() -> bdrv_co_is_allocated_above() runs and because
>>>    the request hasn't completed yet, the block isn't allocated
>>> 4. The request completes, still sees s->job == NULL and skips the
>>>    bitmap, and nothing else will mark it dirty either
>>>
>>> One ingredient is that mirror_top_opaque->job is only set after the
>>> job is fully initialized. For the rationale, see commit 32125b1460
>>> ("mirror: Fix access of uninitialised fields during start").
>>>
>>> Disabling the dirty bitmap is safe once bdrv_mirror_top_do_write()
>>> sees that the job is set, because then:
>>>
>>> 1. When not using MIRROR_COPY_MODE_WRITE_BLOCKING, the dirty bitmap
>>>    will be set by bdrv_mirror_top_do_write().
>>>
>>> 2. When using MIRROR_COPY_MODE_WRITE_BLOCKING, writes will be done
>>>    synchronously to the target.
>>>
>>> At least with virtio-blk using iothread-vq-mapping, mirror_run() and
>>> bdrv_mirror_top_do_write() might be called in different threads.
>>> bdrv_disable_dirty_bitmap() acquires and releases the dirty bitmap
>>> mutex, so the memory is synchronized between threads.
>>>
>>> Many thanks to Kevin Wolf for discussing the issue and solutions with
>>> me! [0]
>>>
>>> [0]: https://lore.kernel.org/qemu-devel/4853b0e5-8ec3-41e9-9a53-b1912b8e4449@dupond.be/T/
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Closes: https://gitlab.com/qemu-project/qemu/-/issues/3273
>>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>>> ---
>>>  block/mirror.c | 21 +++++++++++++++------
>>>  1 file changed, 15 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index b344182c74..eadd4501e8 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -1123,6 +1123,21 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>>>       */
>>>      mirror_top_opaque->job = s;
>>>  
>>> +    /*
>>> +     * Disabling the dirty bitmap is safe once bdrv_mirror_top_do_write() sees
>>> +     * that the job is set, because then:
>>> +     *
>>> +     * 1. When not using MIRROR_COPY_MODE_WRITE_BLOCKING, the dirty bitmap will
>>> +     * be set by bdrv_mirror_top_do_write().
>>> +     *
>>> +     * 2. When using MIRROR_COPY_MODE_WRITE_BLOCKING, writes will be done
>>> +     * synchronously to the target.
>>> +     *
>>> +     * bdrv_disable_dirty_bitmap() acquires and releases the dirty bitmap mutex,
>>> +     * so the memory is synchronized between threads.
>>> +     */
>>> +    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
>>> +
>>>      assert(!s->dbi);
>>>      s->dbi = bdrv_dirty_iter_new(s->dirty_bitmap);
>>>      for (;;) {
>>> @@ -2014,12 +2029,6 @@ static BlockJob *mirror_start_job(
>>>          goto fail;
>>>      }
>>>  
>>> -    /*
>>> -     * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
>>> -     * mode.
>>> -     */
>>> -    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
>>> -
>>>      bdrv_graph_wrlock_drained();
>>>      ret = block_job_add_bdrv(&s->common, "source", bs, 0,
>>>                               BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
>>
>> The thing I meant in the other thread is if we don't need something like
>> this additionally:
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index b344182c747..159954158ba 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -1672,9 +1672,17 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
>>          abort();
>>      }
>>  
>> -    if (!copy_to_target && s->job && s->job->dirty_bitmap) {
>> +    if (!copy_to_target) {
>>          qatomic_set(&s->job->actively_synced, false);
>> -        bdrv_set_dirty_bitmap(s->job->dirty_bitmap, offset, bytes);
>> +        if (s->job && s->job->dirty_bitmap) {
>> +            bdrv_set_dirty_bitmap(s->job->dirty_bitmap, offset, bytes);
>> +        } else {
>> +            /*
>> +             * Avoid race in the case that mirror_run() disables the bitmap
>> +             * between here and bdrv_co_write_req_finish().
>> +             */
>> +            bdrv_set_dirty(bs, offset, bytes);
>> +        }
>>      }
>>  
>>      if (ret < 0) {
> 
> You're right! It's not enough to ensure that the job is set before the
> bitmap is disabled, because both could happen after the check for job here.
> 
> Isn't this change enough by itself? After the change,
> bdrv_mirror_top_do_write() ensures that:
> 
> 1. When copy_to_target == true, the write is done synchronously to the
> target, no need to set the dirty bitmap.
> 
> 2. When copy_to_target == false, the dirty bitmap is set.
> 
> So it doesn't really matter at which point the dirty bitmap is disabled?
> Or am I missing something again?

Ah right, bdrv_set_dirty() only sets it if still enabled :)

> 
>> By the way, can it ever happen that s->job && !s->job->dirty_bitmap or
>> is that second part of the condition redundant?
> 
> In mirror_exit_common(), we do call bdrv_release_dirty_bitmap() before
> the drained section replacing the node and before setting
> bs_opaque->job = NULL; But AFAICS, we do not actually set
> bs_opaque->job->dirty_bitmap = NULL anywhere. So yes, the second part of
> the condition seems redundant to me too. I think the fact that we don't
> set bs_opaque->job->dirty_bitmap = NULL can't lead to a use-after-free
> either, because mirror_exit_common() happens while drained, because
> mirror_run() drains the source (and thus also the filter on top) before
> returning.
> 
> Best Regards,
> Fiona



