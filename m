Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C13ACA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqNw-0001wr-1j; Wed, 17 Sep 2025 07:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uyqNl-0001t3-Jz; Wed, 17 Sep 2025 07:31:29 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uyqNf-0006pX-DL; Wed, 17 Sep 2025 07:31:26 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3B91C4DBAB;
 Wed, 17 Sep 2025 13:31:18 +0200 (CEST)
Message-ID: <c1624212-85c6-416a-b751-53ce3c3dea3d@proxmox.com>
Date: Wed, 17 Sep 2025 13:31:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Fiona Ebner <f.ebner@proxmox.com>
Subject: Re: [PATCH 3/4] block: implement 'resize' callback for child_of_bds
 class
To: Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 fam@euphon.net
References: <20250630113035.820557-1-f.ebner@proxmox.com>
 <20250630113035.820557-4-f.ebner@proxmox.com>
 <18f6275a-dee0-4df4-85e3-efaf81a7724d@redhat.com>
 <aGQboEwTVS5sYxa_@redhat.com>
Content-Language: en-US
In-Reply-To: <aGQboEwTVS5sYxa_@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1758108669229
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

Am 01.07.25 um 7:32 PM schrieb Kevin Wolf:
> Am 01.07.2025 um 16:46 hat Hanna Czenczek geschrieben:
>> On 30.06.25 13:27, Fiona Ebner wrote:
>>> If a node below a filter node is resized, the size of the filter node
>>> is now also refreshed (recursively for filter parents).
>>>
>>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>>> ---
>>>   block.c                          | 12 ++++++++++++
>>>   include/block/block_int-common.h |  2 +-
>>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> What does this do for block job filter nodes, like mirror?  If they changed
>> their length, we might have to consider whether the job also needs to be
>> amended somehow.
> 
> mirror doesn't share BLK_PERM_RESIZE in its block_job_create() call, so
> can this even happen? (If yes, that sounds bad.)

Yes, for mirror, it cannot happen. There is a blocker that prevents
block_resize: "block device is in use by block job: mirror".

>> However, I assume it’s a safe (conservative) change for them because such
>> drivers don’t implement bdrv_co_getlength(), so
>> bdrv_co_refresh_total_sectors() will not change anything.  Is that right and
>> intended?

I can see block_job_add_bdrv() uses bdrv_op_block_all(), so resize for
the nodes used directly by the job cannot happen via QMP block_resize
while a job is running.

However, if we go with checking for BDRV_CHILD_FILTERED like you brought
up, there also is the possibility that a 'raw' node gets resized,
because its filtered 'file' node is resized (via QMP block_resize).

But it seems like resizing the 'file' node already is prohibited too
(tested mirror, backup, commit and stream):  "Permission conflict on
node 'file0': permissions 'resize' are both required by an unnamed block
device (uses node 'file0' as 'root' child) and unshared by node 'node0'
(uses node 'file0' as 'file' child)."

The only other case where .bdrv_co_getlength() is not implemented, but
.is_filter = true, is copy-before-write. There, the patch does not
change the behavior.

I'll this to the commit message in v2.

>>
>> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
>>
>> (Babbling below.)
>>
>>> diff --git a/block.c b/block.c
>>> index bfd4340b24..449f814ebe 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -1497,6 +1497,17 @@ static void GRAPH_WRLOCK bdrv_child_cb_detach(BdrvChild *child)
>>>       }
>>>   }
>>> +static void coroutine_fn GRAPH_RDLOCK bdrv_child_cb_resize(BdrvChild *child)
>>> +{
>>> +    BlockDriverState *bs = child->opaque;
>>> +
>>> +    if (bs->drv && bs->drv->is_filter) {
>>
>> Checking the role for BDRV_CHILD_FILTERED would be more generic; but it
>> would cause 'raw' nodes to be updated, too.  But I don’t know whether we
>> want that or not, and excluding raw (i.e. not changing behavior there) is
>> certainly the safe option.
> 
> If the size is not explicitly overridden in the node configuration, I
> would certainly expect that a raw node reflects the size of its file
> node.
> 
> Seems this is exactly the condition that makes it use
> BDRV_CHILD_FILTERED, so it would probably be a good change?

I agree that updating the size in the 'raw' parent node seems good. I'll
go with this in v2 and add a test for it too :)

>>> +        /* Best effort, ignore errors. */
>>> +        bdrv_co_refresh_total_sectors(bs, bs->total_sectors);
>>> +        bdrv_co_parent_cb_resize(bs);
>>
>> This makes me wonder whether bdrv_co_refresh_total_sectors() should itself
>> call bdrv_co_parent_cb_resize().  Still not quite sure; if the underlying
>> image file is resized by an external party (and we notice this by accident,
>> more or less), maybe the guest device should be informed.
>>
>> (One thing to consider, maybe, are nodes that unshare the resize permission
>> for a child.  It’s probably not clever to call the resize CB if that
>> permission is unshared, so maybe just from that perspective, we should keep
>> that CB strictly inside of that explicit truncate path that checks that
>> permission (at least when growing images...).)
>>
>> Anyway, again, this is the safe option.
> 
> The traditional solution for nodes that unshare resize, but get resized
> in the background anyway would be bs->drv = NULL, and we probably still
> aren't certain what happens after that. :-)
> 
> Kevin

Best Regards,
Fiona


