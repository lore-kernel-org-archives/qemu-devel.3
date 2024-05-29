Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D242EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGK0-0000Fz-Vy; Wed, 29 May 2024 06:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sCGJx-0000En-3H; Wed, 29 May 2024 06:14:13 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sCGJu-0004U7-3z; Wed, 29 May 2024 06:14:12 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 373FE4437F;
 Wed, 29 May 2024 12:14:07 +0200 (CEST)
Message-ID: <5993acdc-f8ec-4fa8-bb97-952c3a56ae6d@proxmox.com>
Date: Wed, 29 May 2024 12:14:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block snapshot issue with RBD
To: Jin Cao <jojing64@gmail.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 pl@kamp.de, hreitz@redhat.com, peterx@redhat.com, farosas@suse.de
References: <8b639179-e567-469c-bd04-ee8dee12d7d2@gmail.com>
 <0e01a8e2-a543-4524-939c-05413fd99e86@gmail.com>
 <756f9dcb-4e9c-4c2f-bc8a-dcc7420a1839@gmail.com>
 <CAOi1vP8nJVsvvsmG5Ac4sd+9NPA8v8t=7Sao0f7-qNb129p=OA@mail.gmail.com>
 <fb2ea759-1a7e-4c0e-ab0d-3ec4c04dc503@gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <fb2ea759-1a7e-4c0e-ab0d-3ec4c04dc503@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

Am 28.05.24 um 20:19 schrieb Jin Cao:
> Hi Ilya
> 
> On 5/28/24 11:13 AM, Ilya Dryomov wrote:
>> On Mon, May 27, 2024 at 9:06 PM Jin Cao <jojing64@gmail.com> wrote:
>>>
>>> Supplementary info: VM is paused after "migrate" command. After being
>>> resumed with "cont", snapshot_delete_blkdev_internal works again, which
>>> is confusing, as disk snapshot generally recommend I/O is paused, and a
>>> frozen VM satisfy this requirement.
>>
>> Hi Jin,
>>
>> This doesn't seem to be related to RBD.  Given that the same error is
>> observed when using the RBD driver with the raw format, I would dig in
>> the direction of migration somehow "installing" the raw format (which
>> is on-disk compatible with the rbd format).
>>
> 
> Thanks for the hint.
> 
>> Also, did you mean to say "snapshot_blkdev_internal" instead of
>> "snapshot_delete_blkdev_internal" in both instances?
> 
> Sorry for my copy-and-paste mistake. Yes, it's snapshot_blkdev_internal.
> 
> -- 
> Sincerely,
> Jin Cao
> 
>>
>> Thanks,
>>
>>                  Ilya
>>
>>>
>>> -- 
>>> Sincerely
>>> Jin Cao
>>>
>>> On 5/27/24 10:56 AM, Jin Cao wrote:
>>>> CC block and migration related address.
>>>>
>>>> On 5/27/24 12:03 AM, Jin Cao wrote:
>>>>> Hi,
>>>>>
>>>>> I encountered RBD block snapshot issue after doing migration.
>>>>>
>>>>> Steps
>>>>> -----
>>>>>
>>>>> 1. Start QEMU with:
>>>>> ./qemu-system-x86_64 -name VM -machine q35 -accel kvm -cpu
>>>>> host,migratable=on -m 2G -boot menu=on,strict=on
>>>>> rbd:image/ubuntu-22.04-server-cloudimg-amd64.raw -net nic -net user
>>>>> -cdrom /home/my/path/of/cloud-init.iso -monitor stdio
>>>>>
>>>>> 2. Do block snapshot in monitor cmd: snapshot_delete_blkdev_internal.
>>>>> It works as expected: the snapshot is visable with command`rbd snap ls
>>>>> pool_name/image_name`.
>>>>>
>>>>> 3. Do pseudo migration with monitor cmd: migrate -d
>>>>> exec:cat>/tmp/vm.out
>>>>>
>>>>> 4. Do block snapshot again with snapshot_delete_blkdev_internal, then
>>>>> I get:
>>>>>      Error: Block format 'raw' used by device 'ide0-hd0' does not
>>>>> support internal snapshots
>>>>>
>>>>> I was hoping to do the second block snapshot successfully, and it
>>>>> feels abnormal the RBD block snapshot function is disrupted after
>>>>> migration.
>>>>>
>>>>> BTW, I get the same block snapshot error when I start QEMU with:
>>>>>       "-drive format=raw,file=rbd:pool_name/image_name"
>>>>>
>>>>> My questions is: how could I proceed with RBD block snapshot after the
>>>>> pseudo migration?
> 
> 

I bisected this issue to d3007d348a ("block: Fix crash when loading
snapshot on inactive node").

> diff --git a/block/snapshot.c b/block/snapshot.c
> index ec8cf4810b..c4d40e80dd 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -196,8 +196,10 @@ bdrv_snapshot_fallback(BlockDriverState *bs)
>  int bdrv_can_snapshot(BlockDriverState *bs)
>  {
>      BlockDriver *drv = bs->drv;
> +
>      GLOBAL_STATE_CODE();
> -    if (!drv || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
> +
> +    if (!drv || !bdrv_is_inserted(bs) || !bdrv_is_writable(bs)) {
>          return 0;
>      }
>  

So I guess the issue is that the blockdev is not writable when
"postmigrate" state?

Best Regards,
Fiona


