Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F45FEF8FE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmuF-0001wl-68; Wed, 04 Mar 2026 09:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vxmuC-0001vT-Ey; Wed, 04 Mar 2026 09:08:52 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vxmu8-0003qh-2D; Wed, 04 Mar 2026 09:08:50 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id EDD1A43DEB;
 Wed, 04 Mar 2026 15:08:44 +0100 (CET)
Message-ID: <9f516c2f-7dd3-446a-8495-56adac267cfe@proxmox.com>
Date: Wed, 4 Mar 2026 15:08:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block/block: add 'throttle-group' property
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 jsnow@redhat.com
References: <20260116143946.1031006-1-f.ebner@proxmox.com>
 <aZ23DELMG6CycbQ8@redhat.com>
 <7f1754b9-61a7-4413-9a97-1f47958da3e4@proxmox.com>
 <aaB1SXNFxiHlS08u@redhat.com>
 <bf9ccb3f-29e3-4c14-8e66-0e16d81da865@proxmox.com>
 <aagtde8OV1Y3fXFw@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aagtde8OV1Y3fXFw@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1772633298133
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

Am 04.03.26 um 2:02 PM schrieb Kevin Wolf:
> Am 02.03.2026 um 13:54 hat Fiona Ebner geschrieben:
>> Am 26.02.26 um 5:31 PM schrieb Kevin Wolf:
>>> Am 26.02.2026 um 16:20 hat Fiona Ebner geschrieben:
>>>> Am 24.02.26 um 3:34 PM schrieb Kevin Wolf:
>>>>> Am 16.01.2026 um 15:39 hat Fiona Ebner geschrieben:
>>>>>> With '-drive', it is possible to specify the throttle configuration
>>>>>> directly on the commandline. Add the possibility to do the same when
>>>>>> using the modern way with '-blockdev' and a front-end device. Using a
>>>>>> throttle filter block node is not always an option: in particular, the
>>>>>> mirror block job operates on a root block node and it might be desired
>>>>>> to throttle only the guest IO, but not to the block job.
>>>>>
>>>>> Hm, is there still a reason why we require a root node for the source?
>>
>> Do you happen to know what the original reason for the restriction was?
>> From git history I cannot really see anything special, just:
> 
> No, I don't remember. Maybe some mailing list archaeology could help,
> but I'm not planning to do that right now.
> 
>>> commit 07eec652722f3d12b07c5b28d0671ddfc22fe6a5
>>> Author: Kevin Wolf <kwolf@redhat.com>
>>> Date:   Thu Jun 23 14:20:24 2016 +0200
>>>
>>>     block: Accept node-name for blockdev-mirror
>>>     
>>>     In order to remove the necessity to use BlockBackend names in the
>>>     external API, we want to allow node-names everywhere. This converts
>>>     blockdev-mirror to accept a node-name without lifting the restriction
>>>     that we're operating at a root node.
>>
>> For operations like backup and stream, the same restriction was lifted:
>> 930fe17f99 ("blockdev: enable non-root nodes for backup source")
>> 554b614765 ("block: Add QMP support for streaming to an intermediate layer")
>>
>> We have the following code snippet in blockdev_mirror_common():
>>
>>>     if (!replaces) {
>>>         /* We want to mirror from @bs, but keep implicit filters on top */
>>>         unfiltered_bs = bdrv_skip_implicit_filters(bs);
>>>         if (unfiltered_bs != bs) {
>>>             replaces = unfiltered_bs->node_name;
>>>         }
>>>     }
>>
>> Doing this as well for non-root nodes would still match the documentation:
>>
>>> # @replaces: with sync=full graph node name to be replaced by the new
>>> #     image when a whole image copy is done.  This can be used to
>>> #     repair broken Quorum files.  By default, @device is replaced,
>>> #     although implicitly created filters on it are kept.
> 
> Yes, I think this would be the expected behaviour.
> 
>> But I guess we could also do something like
>>
>>> diff --git a/blockdev.c b/blockdev.c
>>> index 6e6932ddea..0ff058bed0 100644
>>> --- a/blockdev.c
>>> +++ b/blockdev.c
>>> @@ -2931,7 +2931,14 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
>>>          /* We want to mirror from @bs, but keep implicit filters on top */
>>>          unfiltered_bs = bdrv_skip_implicit_filters(bs);
>>>          if (unfiltered_bs != bs) {
>>> -            replaces = unfiltered_bs->node_name;
>>> +            if (bdrv_is_root_node(bs)) {
>>> +                replaces = unfiltered_bs->node_name;
>>> +            } else {
>>> +                error_setg(errp, "Detected non-root block node which is an"
>>> +                                 " implicit filter, please specify @replaces"
>>> +                                 " parameter explicitly");
>>> +                return;
>>> +            }
>>>          }
>>>      }
>>>  
>>
>> to avoid any surprises for people who explicitly specify a non-root
>> implicit filter as the source? Or what do you think?
> 
> What would the surprise be? That the filters are kept instead of being
> replaced? But wouldn't it be inconsistent then that the same setup works
> if it's a root node?
> 
> I suppose what would have been consistent is if BlockBackend names kept
> implicit filters, but node names didn't. It's too late for that, though.

I was thinking along those lines, but agreed, it is too late for that.

>> Reading through the code, I don't see any other issues with using a
>> non-root node as the source and an initial test case for a node below a
>> throttle node seems to work fine too :)
> 
> That sounds promising.
> 
> Given that the 11.0 freeze is on Tuesday, do we still want to move
> forward with a v2 of this patch, or do you think we should rather focus
> on making throttle nodes usable in all of the cases we care about, even
> if that means delaying it to 11.1?

I'd like to do the latter. The users of qmp_get_root_bs() where having a
throttle node on top might potentially be an issue are:

qmp_blockdev_snapshot_delete_internal_sync() and
internal_snapshot_action() - these are using bdrv_snapshot_fallback() to
skip filters on top.

qmp_block_commit() - here it's already possible to specific a dedicated
top node for the operation and not use the filter.

qmp_{blockdev,drive}_mirror() - which is the case I'm already looking into.

qmp_change_backing_file() - operates on the specified image-node-name.

So it seems mirror is the only place where a change is actually needed?

Best Regards,
Fiona


