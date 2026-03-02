Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5347FE9B376
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 12:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx2nT-0002we-K0; Mon, 02 Mar 2026 07:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vx2nK-0002pH-Ky; Mon, 02 Mar 2026 07:54:44 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vx2n6-000108-Vr; Mon, 02 Mar 2026 07:54:30 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 00D734825A;
 Mon, 02 Mar 2026 13:54:18 +0100 (CET)
Message-ID: <bf9ccb3f-29e3-4c14-8e66-0e16d81da865@proxmox.com>
Date: Mon, 2 Mar 2026 13:54:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Fiona Ebner <f.ebner@proxmox.com>
Subject: Re: [PATCH] hw/block/block: add 'throttle-group' property
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 jsnow@redhat.com
References: <20260116143946.1031006-1-f.ebner@proxmox.com>
 <aZ23DELMG6CycbQ8@redhat.com>
 <7f1754b9-61a7-4413-9a97-1f47958da3e4@proxmox.com>
 <aaB1SXNFxiHlS08u@redhat.com>
Content-Language: en-US
In-Reply-To: <aaB1SXNFxiHlS08u@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1772456033622
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 26.02.26 um 5:31 PM schrieb Kevin Wolf:
> Am 26.02.2026 um 16:20 hat Fiona Ebner geschrieben:
>> Am 24.02.26 um 3:34 PM schrieb Kevin Wolf:
>>> Am 16.01.2026 um 15:39 hat Fiona Ebner geschrieben:
>>>> With '-drive', it is possible to specify the throttle configuration
>>>> directly on the commandline. Add the possibility to do the same when
>>>> using the modern way with '-blockdev' and a front-end device. Using a
>>>> throttle filter block node is not always an option: in particular, the
>>>> mirror block job operates on a root block node and it might be desired
>>>> to throttle only the guest IO, but not to the block job.
>>>
>>> Hm, is there still a reason why we require a root node for the source?

Do you happen to know what the original reason for the restriction was?
From git history I cannot really see anything special, just:

> commit 07eec652722f3d12b07c5b28d0671ddfc22fe6a5
> Author: Kevin Wolf <kwolf@redhat.com>
> Date:   Thu Jun 23 14:20:24 2016 +0200
> 
>     block: Accept node-name for blockdev-mirror
>     
>     In order to remove the necessity to use BlockBackend names in the
>     external API, we want to allow node-names everywhere. This converts
>     blockdev-mirror to accept a node-name without lifting the restriction
>     that we're operating at a root node.

For operations like backup and stream, the same restriction was lifted:
930fe17f99 ("blockdev: enable non-root nodes for backup source")
554b614765 ("block: Add QMP support for streaming to an intermediate layer")

We have the following code snippet in blockdev_mirror_common():

>     if (!replaces) {
>         /* We want to mirror from @bs, but keep implicit filters on top */
>         unfiltered_bs = bdrv_skip_implicit_filters(bs);
>         if (unfiltered_bs != bs) {
>             replaces = unfiltered_bs->node_name;
>         }
>     }

Doing this as well for non-root nodes would still match the documentation:

> # @replaces: with sync=full graph node name to be replaced by the new
> #     image when a whole image copy is done.  This can be used to
> #     repair broken Quorum files.  By default, @device is replaced,
> #     although implicitly created filters on it are kept.

But I guess we could also do something like

> diff --git a/blockdev.c b/blockdev.c
> index 6e6932ddea..0ff058bed0 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2931,7 +2931,14 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
>          /* We want to mirror from @bs, but keep implicit filters on top */
>          unfiltered_bs = bdrv_skip_implicit_filters(bs);
>          if (unfiltered_bs != bs) {
> -            replaces = unfiltered_bs->node_name;
> +            if (bdrv_is_root_node(bs)) {
> +                replaces = unfiltered_bs->node_name;
> +            } else {
> +                error_setg(errp, "Detected non-root block node which is an"
> +                                 " implicit filter, please specify @replaces"
> +                                 " parameter explicitly");
> +                return;
> +            }
>          }
>      }
>  

to avoid any surprises for people who explicitly specify a non-root
implicit filter as the source? Or what do you think?

Reading through the code, I don't see any other issues with using a
non-root node as the source and an initial test case for a node below a
throttle node seems to work fine too :)

>>
>> I'm not sure if the restriction could be lifted. But AFAICS, that
>> doesn't help in my case with a throttle node as the root node:
>>
>> Say I'm mirroring the node below throttle and the job is ready to be
>> completed. Further, assume that requests pile up for the root node,
>> while the node below is mostly idle, which can easily happen with low
>> throttle limits:
>>
>> At some moment, there might be no IO in-flight for the node below
>> throttle and thus the mirror can complete, while all the in-flight
>> requests for the throttle node are currently being intercepted by the
>> throttle group and waiting for the timer to wake them. Because, the call
>> to bdrv_inc_in_flight() for the node below throttle only happens after
>> the intercepted requests are woken. Mirror and the node below do not
>> know about the parent's in flight requests. Is this interpretation correct?
> 
> Well, mirror doesn't just complete by itself, but let's assume it
> already was ready and you told it to complete. Then yes, if there is no
> more activity and both sides are in sync, the mirror job can complete.
> 
> However, is this any different from a mirror job completing when the
> guest has already put a request in the virtio-blk virtqueue, but the
> device model hasn't processed it yet? From the guest's perspective, the
> request is in flight in both cases, and from the mirror job's
> perspective it hasn't started yet in both cases.
> 
> I think the only difference is that with throttling you might hit this
> case more often, but it's not a case that is fundamentally impossible
> without throttling.
> 
>> There are scenarios where we finish the job via block-job-cancel after
>> freezing the guest filesystem to ensure consistency, so having
>> intercepted requests as described above would mess it up.
> 
> Why? You got a copy that was in sync at the time that the mirror job
> completed. The job doesn't promise the exact point of time that the copy
> matches, it's just some arbitrary time after you request completion when
> both sides are in sync. This implies that requests after this arbitrary
> point in time will not be included in the copy.
> 
> Though I'm also wondering, if you successfully froze the file system (as
> opposed to still trying to freeze it), why are we getting write
> requests? Shouldn't freezing involve waiting for completion of all
> in-flight requests?

Ah, yes, you're right! There won't be any in-flight requests anymore
once it's frozen. The throttling just means that the guest has to wait
longer for completion first.

Also, the parent throttle node is drained too when the mirror finishes :)

Best Regards,
Fiona


