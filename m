Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC18F54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52zu-0004Zd-0v; Tue, 24 Mar 2026 10:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w52zp-0004Xs-Qw; Tue, 24 Mar 2026 10:44:42 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w52zj-00084n-7Z; Tue, 24 Mar 2026 10:44:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 01B0F807EA;
 Tue, 24 Mar 2026 17:44:29 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:46c::1:35] (unknown
 [2a02:6bf:8080:46c::1:35])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RiUbwL0AVGk0-86wP404A; Tue, 24 Mar 2026 17:44:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1774363468;
 bh=v4nenMEoHzlAkz+SFSx7UbB7ZAHk4o4iN3u9/R+jmAQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=zkgdg8XoGyn5joHriPtp3wwiqEEnTNycVrPbG06DVvYQC2wEjsEZZRhGG+hlZ/CuY
 bHw/AVXT89iHD2x44pIqZoO81eOK4yu1YW5GXMn2Z30VTWjiINuB8B6ixm++/j6ZQ5
 iQTOu+jXH6FXzDg79BSIgjuVHT1oZfIi195LGS9w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <af3bec19-96ee-4de2-b9bf-3875d59aaed1@yandex-team.ru>
Date: Tue, 24 Mar 2026 17:44:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mirror: Fix missed dirty bitmap writes during startup
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, f.ebner@proxmox.com,
 jsnow@redhat.com, jean-louis@dupond.be, dionbosschieter@gmail.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, pbonzini@redhat.com
References: <20260219202446.312493-1-kwolf@redhat.com>
 <d7c3d44a-d42f-4232-b5e5-a7504fb62a73@yandex-team.ru>
 <aaqflohdSVTFpkRZ@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aaqflohdSVTFpkRZ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 06.03.26 12:34, Kevin Wolf wrote:
> Am 05.03.2026 um 19:34 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> On 19.02.26 23:24, Kevin Wolf wrote:
>>> Currently, mirror disables the block layer's dirty bitmap before its own
>>> replacement is working. This means that during startup, there is a
>>> window in which the allocation status of blocks in the source has
>>> already been checked, but new writes coming in aren't tracked yet,
>>> resulting in a corrupted copy:
>>>
>>> 1. Dirty bitmap is disabled in mirror_start_job()
>>> 2. Some request are started in mirror_top_bs while s->job == NULL
>>> 3. mirror_dirty_init() -> bdrv_co_is_allocated_above() runs and because
>>>      the request hasn't completed yet, the block isn't allocated
>>> 4. The request completes, still sees s->job == NULL and skips the
>>>      bitmap, and nothing else will mark it dirty either
>>>
>>> One ingredient is that mirror_top_opaque->job is only set after the
>>> job is fully initialized. For the rationale, see commit 32125b1460
>>> ("mirror: Fix access of uninitialised fields during start").
>>>
>>> Fix this by giving mirror_top_bs access to dirty_bitmap and enabling it
>>> to track writes from the beginning. Disabling the block layer's tracking
>>> and enabling the mirror_top_bs one happens in a drained section, so
>>> there is no danger of races with in-flight requests any more. All of
>>> this happens well before the block allocation status is checked, so we
>>> can be sure that no writes will be missed.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Closes: https://gitlab.com/qemu-project/qemu/-/issues/3273
>>> Fixes: 32125b14606a ('mirror: Fix access of uninitialised fields during start')
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>> Supersedes: <20260212120411.369498-1-f.ebner@proxmox.com>
>>> ---
>>>    block/mirror.c | 48 +++++++++++++++++++++++++++++-------------------
>>>    1 file changed, 29 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index b344182c747..f38636e7457 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -99,6 +99,7 @@ typedef struct MirrorBlockJob {
>>>    typedef struct MirrorBDSOpaque {
>>>        MirrorBlockJob *job;
>>> +    BdrvDirtyBitmap *dirty_bitmap;
>>>        bool stop;
>>>        bool is_commit;
>>>    } MirrorBDSOpaque;
>>> @@ -1672,9 +1673,9 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
>>>            abort();
>>>        }
>>> -    if (!copy_to_target && s->job && s->job->dirty_bitmap) {
>>> +    if (!copy_to_target) {
>>>            qatomic_set(&s->job->actively_synced, false);
>>> -        bdrv_set_dirty_bitmap(s->job->dirty_bitmap, offset, bytes);
>>> +        bdrv_set_dirty_bitmap(s->dirty_bitmap, offset, bytes);
>>>        }
>>>        if (ret < 0) {
>>> @@ -1901,13 +1902,35 @@ static BlockJob *mirror_start_job(
>>>        bdrv_drained_begin(bs);
>>>        ret = bdrv_append(mirror_top_bs, bs, errp);
>>> -    bdrv_drained_end(bs);
>>> -
>>>        if (ret < 0) {
>>> +        bdrv_drained_end(bs);
>>> +        bdrv_unref(mirror_top_bs);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    bs_opaque->dirty_bitmap = bdrv_create_dirty_bitmap(mirror_top_bs,
>>> +                                                       granularity,
>>> +                                                       NULL, errp);
>>> +    if (!bs_opaque->dirty_bitmap) {
>>> +        bdrv_drained_end(bs);
>>>            bdrv_unref(mirror_top_bs);
>>>            return NULL;
>>>        }
>>> +    /*
>>> +     * The mirror job doesn't use the block layer's dirty tracking because it
>>> +     * needs to be able to switch seemlessly between background copy mode (which
>>> +     * does need dirty tracking) and write blocking mode (which doesn't) and
>>> +     * doing that would require draining the node. Instead, mirror_top_bs takes
>>> +     * care of updating the dirty bitmap as appropriate.
>>> +     *
>>> +     * Note that write blocking mode only becomes effective after mirror_run()
>>> +     * sets mirror_top_opaque->job (see should_copy_to_target()). Until then,
>>> +     * we're still in background copy mode irrespective of @copy_mode.
>>> +     */
>>> +    bdrv_disable_dirty_bitmap(bs_opaque->dirty_bitmap);
>>> +    bdrv_drained_end(bs);
>>> +
>>>        /* Make sure that the source is not resized while the job is running */
>>>        s = block_job_create(job_id, driver, NULL, mirror_top_bs,
>>>                             BLK_PERM_CONSISTENT_READ,
>>> @@ -2002,24 +2025,13 @@ static BlockJob *mirror_start_job(
>>>        s->base_overlay = bdrv_find_overlay(bs, base);
>>>        s->granularity = granularity;
>>>        s->buf_size = ROUND_UP(buf_size, granularity);
>>> +    s->dirty_bitmap = bs_opaque->dirty_bitmap;
>>>        s->unmap = unmap;
>>>        if (auto_complete) {
>>>            s->should_complete = true;
>>>        }
>>>        bdrv_graph_rdunlock_main_loop();
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
>>>        bdrv_graph_wrlock_drained();
>>>        ret = block_job_add_bdrv(&s->common, "source", bs, 0,
>>>                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
>>> @@ -2099,9 +2111,6 @@ fail:
>>>            g_free(s->replaces);
>>>            blk_unref(s->target);
>>>            bs_opaque->job = NULL;
>>> -        if (s->dirty_bitmap) {
>>> -            bdrv_release_dirty_bitmap(s->dirty_bitmap);
>>> -        }
>>>            job_early_fail(&s->common.job);
>>>        }
>>> @@ -2115,6 +2124,7 @@ fail:
>>>        bdrv_graph_wrunlock();
>>>        bdrv_drained_end(bs);
>>> +    bdrv_release_dirty_bitmap(bs_opaque->dirty_bitmap);
>>
>>
>> Hmm. Shouldn't we change position of _release_ in mirror_exit_common() too?
>>
>> Now the sequence is:
>>
>> bdrv_release_dirty_bitmap(s->dirty_bitmap);
>>
>>
>> < could mirror_top_bs access dirty_bitmap here, before drained begin? >
>>
>> ...
>>
>> drained begin
>>
>> .. a lot of logic, including actual removing of the mirror_top_bs from the chain ..
>>
>> drained end
>>
>> bdrv_unref(mirror_top_bs)
> 
> I think you're right, but isn't this already a preexisting bug in
> master? After releasing, we don't set s->dirty_bitmap = NULL, which
> could have prevented the access in the code before this patch. So this
> should probably be a separate patch.
> 
> mirror_exit_common() runs in the main loop, so I assume you can
> hit this when using an iothread.
> 
> It seems that initially the release was later, but commit 2119882 moved
> it earlier, without saying why it did that. Paolo, do you remember?
> 
> Kevin
> 

On the other hand, in mirror_exit_common(), we are already in

bdrv_drained_begin(bs); section, started in mirror_run()...

Does bdrv_drained_begin(mirror_top_bs) add something to previous
bdrv_drained_begin(bs) ?

-- 
Best regards,
Vladimir

