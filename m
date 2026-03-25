Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682FCFEC11B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 10:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5LFQ-0007IM-9k; Wed, 25 Mar 2026 06:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1w5LFN-0007Gu-ST; Wed, 25 Mar 2026 06:13:57 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1w5LFL-0003ak-Ti; Wed, 25 Mar 2026 06:13:57 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A29DD49006;
 Wed, 25 Mar 2026 11:13:44 +0100 (CET)
Message-ID: <fbe8115d-13c2-4bc3-9745-e8d34b9df39c@proxmox.com>
Date: Wed, 25 Mar 2026 11:13:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mirror: Fix missed dirty bitmap writes during startup
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, jsnow@redhat.com,
 jean-louis@dupond.be, dionbosschieter@gmail.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, pbonzini@redhat.com
References: <20260219202446.312493-1-kwolf@redhat.com>
 <d7c3d44a-d42f-4232-b5e5-a7504fb62a73@yandex-team.ru>
 <aaqflohdSVTFpkRZ@redhat.com>
 <af3bec19-96ee-4de2-b9bf-3875d59aaed1@yandex-team.ru>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <af3bec19-96ee-4de2-b9bf-3875d59aaed1@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1774433576307
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

Am 24.03.26 um 3:43 PM schrieb Vladimir Sementsov-Ogievskiy:
> On 06.03.26 12:34, Kevin Wolf wrote:
>> Am 05.03.2026 um 19:34 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> On 19.02.26 23:24, Kevin Wolf wrote:
>>>> @@ -2099,9 +2111,6 @@ fail:
>>>>            g_free(s->replaces);
>>>>            blk_unref(s->target);
>>>>            bs_opaque->job = NULL;
>>>> -        if (s->dirty_bitmap) {
>>>> -            bdrv_release_dirty_bitmap(s->dirty_bitmap);
>>>> -        }
>>>>            job_early_fail(&s->common.job);
>>>>        }
>>>> @@ -2115,6 +2124,7 @@ fail:
>>>>        bdrv_graph_wrunlock();
>>>>        bdrv_drained_end(bs);
>>>> +    bdrv_release_dirty_bitmap(bs_opaque->dirty_bitmap);
>>>
>>>
>>> Hmm. Shouldn't we change position of _release_ in
>>> mirror_exit_common() too?
>>>
>>> Now the sequence is:
>>>
>>> bdrv_release_dirty_bitmap(s->dirty_bitmap);
>>>
>>>
>>> < could mirror_top_bs access dirty_bitmap here, before drained begin? >
>>>
>>> ...
>>>
>>> drained begin
>>>
>>> .. a lot of logic, including actual removing of the mirror_top_bs
>>> from the chain ..
>>>
>>> drained end
>>>
>>> bdrv_unref(mirror_top_bs)
>>
>> I think you're right, but isn't this already a preexisting bug in
>> master? After releasing, we don't set s->dirty_bitmap = NULL, which
>> could have prevented the access in the code before this patch. So this
>> should probably be a separate patch.
>>
>> mirror_exit_common() runs in the main loop, so I assume you can
>> hit this when using an iothread.
>>
>> It seems that initially the release was later, but commit 2119882 moved
>> it earlier, without saying why it did that. Paolo, do you remember?
>>
>> Kevin
>>
> 
> On the other hand, in mirror_exit_common(), we are already in
> 
> bdrv_drained_begin(bs); section, started in mirror_run()...
> 
> Does bdrv_drained_begin(mirror_top_bs) add something to previous
> bdrv_drained_begin(bs) ?
> 

Looking at the history, it was added with:

> commit d2da5e288a2e71e82866c8fdefd41b5727300124
> Author: Kevin Wolf <kwolf@redhat.com>
> Date:   Mon Jul 22 17:44:27 2019 +0200
> 
>     mirror: Keep mirror_top_bs drained after dropping permissions
>     
>     mirror_top_bs is currently implicitly drained through its connection to
>     the source or the target node. However, the drain section for target_bs
>     ends early after moving mirror_top_bs from src to target_bs, so that
>     requests can already be restarted while mirror_top_bs is still present
>     in the chain, but has dropped all permissions and therefore runs into an
>     assertion failure like this:
>     
>         qemu-system-x86_64: block/io.c:1634: bdrv_co_write_req_prepare:
>         Assertion `child->perm & BLK_PERM_WRITE' failed.
>     
>     Keep mirror_top_bs drained until all graph changes have completed.

At this time, bdrv_drained_end(target_bs) happened before

(1) bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, ...)

The order of those two operations was later switched, namely in:

> commit ccd6a37947574707613e826e2bf04d55f1d5f238
> Author: Kevin Wolf <kwolf@redhat.com>
> Date:   Fri Oct 27 17:53:25 2023 +0200
> 
>     block: Mark bdrv_replace_node() GRAPH_WRLOCK
>     
>     Instead of taking the writer lock internally, require callers to already
>     hold it when calling bdrv_replace_node(). Its callers may already want
>     to hold the graph lock and so wouldn't be able to call functions that
>     take it internally.

There still is

(2) bdrv_replace_node(to_replace, target_bs, ...)

with the drained section for to_replace ending right afterwards. Looking
at where mirror_top_bs is after (2):

If to_replace == src, then mirror_top_bs will be on top of target_bs.
If to_replace != src, then mirror_top_bs will still be on top of src.

So it shouldn't matter that the drain for to_replace ends before (1).
The drained sections for target_bs and src both end after (1).

If this analysis is correct, it's possible to drop the drain for
mirror_top_bs. Question is if it's not better to stay explicit about it
rather than implicitly relying on src/target being drained.

Best Regards,
Fiona


