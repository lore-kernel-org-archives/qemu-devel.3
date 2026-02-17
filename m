Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B622E68152
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHA2-00017m-Ff; Tue, 17 Feb 2026 04:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vsHA0-000172-1b; Tue, 17 Feb 2026 04:14:24 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vsH9x-00040A-9a; Tue, 17 Feb 2026 04:14:23 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0DBD347079;
 Tue, 17 Feb 2026 10:14:17 +0100 (CET)
Message-ID: <7f026314-0c0b-4b49-b208-90f57e413703@proxmox.com>
Date: Tue, 17 Feb 2026 10:14:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/mirror: disable dirty bitmap only after job init
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-block@nongnu.org,
 hreitz@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 jean-louis@dupond.be, dionbosschieter@gmail.com
References: <20260212120411.369498-1-f.ebner@proxmox.com>
 <aZLwdRhpTHvi1Y1-@redhat.com>
 <66c3fca8-0f64-4cec-a2a9-5959ef67a251@proxmox.com>
 <5f336c06-c675-4d21-8c1c-e1a1ebe8e09f@proxmox.com>
 <aZM4KqW57Sb1l_Pb@redhat.com>
 <811bbd59-df4e-4a60-adba-61cd2ef3016c@proxmox.com>
 <aZNIDFp9OaNBe0NK@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aZNIDFp9OaNBe0NK@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1771319648742
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

Am 16.02.26 um 5:38 PM schrieb Kevin Wolf:
> Am 16.02.2026 um 17:12 hat Fiona Ebner geschrieben:
>> Am 16.02.26 um 4:31 PM schrieb Kevin Wolf:
>>> Am 16.02.2026 um 14:01 hat Fiona Ebner geschrieben:
>>>> Am 16.02.26 um 1:48 PM schrieb Fiona Ebner:
>>>>> Am 16.02.26 um 11:25 AM schrieb Kevin Wolf:
>>>>>> Am 12.02.2026 um 13:02 hat Fiona Ebner geschrieben:
>>>>>>> Currently, the dirty bitmap is disabled too early and the following
>>>>>>> bad scenario is possible:
>>>>>>>
>>>>>>> 1. Dirty bitmap is disabled in mirror_start_job()
>>>>>>> 2. Some request are started in mirror_top_bs while s->job == NULL
>>>>>>> 3. mirror_dirty_init() -> bdrv_co_is_allocated_above() runs and because
>>>>>>>    the request hasn't completed yet, the block isn't allocated
>>>>>>> 4. The request completes, still sees s->job == NULL and skips the
>>>>>>>    bitmap, and nothing else will mark it dirty either
>>>>>>>
>>>>>>> One ingredient is that mirror_top_opaque->job is only set after the
>>>>>>> job is fully initialized. For the rationale, see commit 32125b1460
>>>>>>> ("mirror: Fix access of uninitialised fields during start").
>>>>>>>
>>>>>>> Disabling the dirty bitmap is safe once bdrv_mirror_top_do_write()
>>>>>>> sees that the job is set, because then:
>>>>>>>
>>>>>>> 1. When not using MIRROR_COPY_MODE_WRITE_BLOCKING, the dirty bitmap
>>>>>>>    will be set by bdrv_mirror_top_do_write().
>>>>>>>
>>>>>>> 2. When using MIRROR_COPY_MODE_WRITE_BLOCKING, writes will be done
>>>>>>>    synchronously to the target.
>>>>>>>
>>>>>>> At least with virtio-blk using iothread-vq-mapping, mirror_run() and
>>>>>>> bdrv_mirror_top_do_write() might be called in different threads.
>>>>>>> bdrv_disable_dirty_bitmap() acquires and releases the dirty bitmap
>>>>>>> mutex, so the memory is synchronized between threads.
>>>>>>>
>>>>>>> Many thanks to Kevin Wolf for discussing the issue and solutions with
>>>>>>> me! [0]
>>>>>>>
>>>>>>> [0]: https://lore.kernel.org/qemu-devel/4853b0e5-8ec3-41e9-9a53-b1912b8e4449@dupond.be/T/
>>>>>>>
>>>>>>> Cc: qemu-stable@nongnu.org
>>>>>>> Closes: https://gitlab.com/qemu-project/qemu/-/issues/3273
>>>>>>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>>>>>>> ---
>>>>>>>  block/mirror.c | 21 +++++++++++++++------
>>>>>>>  1 file changed, 15 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/block/mirror.c b/block/mirror.c
>>>>>>> index b344182c74..eadd4501e8 100644
>>>>>>> --- a/block/mirror.c
>>>>>>> +++ b/block/mirror.c
>>>>>>> @@ -1123,6 +1123,21 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>>>>>>>       */
>>>>>>>      mirror_top_opaque->job = s;
>>>>>>>  
>>>>>>> +    /*
>>>>>>> +     * Disabling the dirty bitmap is safe once bdrv_mirror_top_do_write() sees
>>>>>>> +     * that the job is set, because then:
>>>>>>> +     *
>>>>>>> +     * 1. When not using MIRROR_COPY_MODE_WRITE_BLOCKING, the dirty bitmap will
>>>>>>> +     * be set by bdrv_mirror_top_do_write().
>>>>>>> +     *
>>>>>>> +     * 2. When using MIRROR_COPY_MODE_WRITE_BLOCKING, writes will be done
>>>>>>> +     * synchronously to the target.
>>>>>>> +     *
>>>>>>> +     * bdrv_disable_dirty_bitmap() acquires and releases the dirty bitmap mutex,
>>>>>>> +     * so the memory is synchronized between threads.
>>>>>>> +     */
>>>>>>> +    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
>>>>>>> +
>>>>>>>      assert(!s->dbi);
>>>>>>>      s->dbi = bdrv_dirty_iter_new(s->dirty_bitmap);
>>>>>>>      for (;;) {
>>>>>>> @@ -2014,12 +2029,6 @@ static BlockJob *mirror_start_job(
>>>>>>>          goto fail;
>>>>>>>      }
>>>>>>>  
>>>>>>> -    /*
>>>>>>> -     * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
>>>>>>> -     * mode.
>>>>>>> -     */
>>>>>>> -    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
>>>>>>> -
>>>>>>>      bdrv_graph_wrlock_drained();
>>>>>>>      ret = block_job_add_bdrv(&s->common, "source", bs, 0,
>>>>>>>                               BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
>>>>>>
>>>>>> The thing I meant in the other thread is if we don't need something like
>>>>>> this additionally:
>>>>>>
>>>>>> diff --git a/block/mirror.c b/block/mirror.c
>>>>>> index b344182c747..159954158ba 100644
>>>>>> --- a/block/mirror.c
>>>>>> +++ b/block/mirror.c
>>>>>> @@ -1672,9 +1672,17 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
>>>>>>          abort();
>>>>>>      }
>>>>>>  
>>>>>> -    if (!copy_to_target && s->job && s->job->dirty_bitmap) {
>>>>>> +    if (!copy_to_target) {
>>>>>>          qatomic_set(&s->job->actively_synced, false);
>>>>>> -        bdrv_set_dirty_bitmap(s->job->dirty_bitmap, offset, bytes);
>>>>>> +        if (s->job && s->job->dirty_bitmap) {
>>>>>> +            bdrv_set_dirty_bitmap(s->job->dirty_bitmap, offset, bytes);
>>>>>> +        } else {
>>>>>> +            /*
>>>>>> +             * Avoid race in the case that mirror_run() disables the bitmap
>>>>>> +             * between here and bdrv_co_write_req_finish().
>>>>>> +             */
>>>>>> +            bdrv_set_dirty(bs, offset, bytes);
>>>>>> +        }
>>>>>>      }
>>>>>>  
>>>>>>      if (ret < 0) {
>>>>>
>>>>> You're right! It's not enough to ensure that the job is set before the
>>>>> bitmap is disabled, because both could happen after the check for job here.
>>>>>
>>>>> Isn't this change enough by itself? After the change,
>>>>> bdrv_mirror_top_do_write() ensures that:
>>>>>
>>>>> 1. When copy_to_target == true, the write is done synchronously to the
>>>>> target, no need to set the dirty bitmap.
>>>>>
>>>>> 2. When copy_to_target == false, the dirty bitmap is set.
>>>>>
>>>>> So it doesn't really matter at which point the dirty bitmap is disabled?
>>>>> Or am I missing something again?
>>>>
>>>> Ah right, bdrv_set_dirty() only sets it if still enabled :)
>>>
>>> Yes, exactly.
>>>
>>> If that's still too confusing, how about just giving mirror_top_bs
>>> access to its dirty bitmap right from the start while it's drained? I
>>> didn't try to reproduce the bug with it yet, though.
>>
>> You beat me to it :) Was thinking about this too, inspired by your
>> initial suggestion for the alternate approach to avoid relying on the
>> block layer for dirty tracking, but mine ended up needlessly involved,
>> because I removed the dirty_bitmap from the MirrorBlockJob object and
>> had to add a helper function for getting the dirty bitmap back from the
>> job, which is less than ideal :P
>>>
>>> Kevin
>>>
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index b344182c747..c11aca1366c 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -99,6 +99,7 @@ typedef struct MirrorBlockJob {
>>>  
>>>  typedef struct MirrorBDSOpaque {
>>>      MirrorBlockJob *job;
>>> +    BdrvDirtyBitmap *dirty_bitmap;
>>>      bool stop;
>>>      bool is_commit;
>>>  } MirrorBDSOpaque;
>>> @@ -1672,9 +1673,9 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
>>>          abort();
>>>      }
>>>  
>>> -    if (!copy_to_target && s->job && s->job->dirty_bitmap) {
>>> +    if (!copy_to_target) {
>>
>> I put an assert(s->dirty_bitmap) here, but maybe it's not worth it?
> 
> The difference is SIGABRT here vs. SIGSEGV two lines later. I don't think
> it matters much, either way is fine with me.

Right.

>>>          qatomic_set(&s->job->actively_synced, false);
>>> -        bdrv_set_dirty_bitmap(s->job->dirty_bitmap, offset, bytes);
>>> +        bdrv_set_dirty_bitmap(s->dirty_bitmap, offset, bytes);
>>>      }
>>>  
>>>      if (ret < 0) {
>>> @@ -1901,13 +1902,28 @@ static BlockJob *mirror_start_job(
>>
>> I created and disabled the dirty bitmap here already before the drained
>> section. It seems slightly more readable. Do you see any downside to that?
> 
> Hm... I think it's okay in practice because a drain comes after it, so
> while there may be a race initially, we don't care when exactly we start
> tracking as long as it's before checking the block status. But that's a
> bit subtle.
> 
> We could keep creating the bitmap outside of the drain if that improves
> things, but I would leave bdrv_disable_dirty_bitmap() inside the drained
> section just to be very clear that there can't be a race with a request.

Okay, agreed.

>>>  
>>>      bdrv_drained_begin(bs);
>>>      ret = bdrv_append(mirror_top_bs, bs, errp);
>>> -    bdrv_drained_end(bs);
>>> -
>>>      if (ret < 0) {
>>> +        bdrv_drained_end(bs);
>>>          bdrv_unref(mirror_top_bs);
>>>          return NULL;
>>>      }
>>>  
>>> +    bs_opaque->dirty_bitmap = bdrv_create_dirty_bitmap(mirror_top_bs,
>>> +                                                       granularity,
>>> +                                                       NULL, errp);
>>> +    if (!bs_opaque->dirty_bitmap) {
>>> +        bdrv_drained_end(bs);
>>> +        bdrv_unref(mirror_top_bs);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    /*
>>> +     * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
>>> +     * mode.
>>> +     */
>>
>> This comment could become:
>>
>> +    /*
>> +     * Disabling the dirty bitmap is safe, because:
>> +     *
>> +     * 1. If should_copy_to_target() == true, writes will be done
>> synchronously
>> +     * to the target, no need to set the bitmap.
>> +     *
>> +     * 2. If should_copy_to_target() == false, the dirty bitmap will be
>> set by
>> +     * bdrv_mirror_top_do_write().
>> +     */
> 
> Feels verbose to me because the implications of the existing comment
> seem obvious to me, but if you think it's useful, it probably isn't as
> obvious as I thought.

The thing that might not be immediately obvious is that "active mode"
only starts once the job reference is set in the opaque object.

>>> +    bdrv_disable_dirty_bitmap(bs_opaque->dirty_bitmap);
>>> +    bdrv_drained_end(bs);
>>> +
>>>      /* Make sure that the source is not resized while the job is running */
>>>      s = block_job_create(job_id, driver, NULL, mirror_top_bs,
>>>                           BLK_PERM_CONSISTENT_READ,
>>> @@ -2002,24 +2018,13 @@ static BlockJob *mirror_start_job(
>>>      s->base_overlay = bdrv_find_overlay(bs, base);
>>>      s->granularity = granularity;
>>>      s->buf_size = ROUND_UP(buf_size, granularity);
>>> +    s->dirty_bitmap = bs_opaque->dirty_bitmap;
>>>      s->unmap = unmap;
>>>      if (auto_complete) {
>>>          s->should_complete = true;
>>>      }
>>>      bdrv_graph_rdunlock_main_loop();
>>>  
>>> -    s->dirty_bitmap = bdrv_create_dirty_bitmap(s->mirror_top_bs, granularity,
>>> -                                               NULL, errp);
>>> -    if (!s->dirty_bitmap) {
>>> -        goto fail;
>>> -    }
>>> -
>>> -    /*
>>> -     * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
>>> -     * mode.
>>> -     */
>>> -    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
>>> -
>>>      bdrv_graph_wrlock_drained();
>>>      ret = block_job_add_bdrv(&s->common, "source", bs, 0,
>>>                               BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
>>> @@ -2099,9 +2104,6 @@ fail:
>>>          g_free(s->replaces);
>>>          blk_unref(s->target);
>>>          bs_opaque->job = NULL;
>>> -        if (s->dirty_bitmap) {
>>> -            bdrv_release_dirty_bitmap(s->dirty_bitmap);
>>> -        }
>>>          job_early_fail(&s->common.job);
>>>      }
>>>  
>>> @@ -2115,6 +2117,7 @@ fail:
>>>      bdrv_graph_wrunlock();
>>>      bdrv_drained_end(bs);
>>>  
>>> +    bdrv_release_dirty_bitmap(bs_opaque->dirty_bitmap);
>>>      bdrv_unref(mirror_top_bs);
>>>  
>>>      return NULL;

Are you going to send this as a proper patch?

Best Regards,
Fiona


