Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2A4C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 12:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSz8f-0006Z1-QL; Thu, 25 Jan 2024 07:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSz8a-0006YH-2e; Thu, 25 Jan 2024 07:47:20 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSz8Y-0007wA-56; Thu, 25 Jan 2024 07:47:19 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id AF44F4928A;
 Thu, 25 Jan 2024 13:47:14 +0100 (CET)
Message-ID: <36a903e5-c646-4596-a6e1-a7b1e2571c43@proxmox.com>
Date: Thu, 25 Jan 2024 13:47:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] qapi: blockdev-backup: add discard-source parameter
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com
References: <20240117160737.1057513-1-vsementsov@yandex-team.ru>
 <20240117160737.1057513-4-vsementsov@yandex-team.ru>
 <d0cbb4ed-bdb9-4487-ab7b-4b5e72a36e7e@proxmox.com>
In-Reply-To: <d0cbb4ed-bdb9-4487-ab7b-4b5e72a36e7e@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Am 24.01.24 um 16:03 schrieb Fiona Ebner:
> Am 17.01.24 um 17:07 schrieb Vladimir Sementsov-Ogievskiy:
>> Add a parameter that enables discard-after-copy. That is mostly useful
>> in "push backup with fleecing" scheme, when source is snapshot-access
>> format driver node, based on copy-before-write filter snapshot-access
>> API:
>>
>> [guest]      [snapshot-access] ~~ blockdev-backup ~~> [backup target]
>>    |            |
>>    | root       | file
>>    v            v
>> [copy-before-write]
>>    |             |
>>    | file        | target
>>    v             v
>> [active disk]   [temp.img]
>>
>> In this case discard-after-copy does two things:
>>
>>  - discard data in temp.img to save disk space
>>  - avoid further copy-before-write operation in discarded area
>>
>> Note that we have to declare WRITE permission on source in
>> copy-before-write filter, for discard to work.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Ran into another issue when the cluster_size of the fleecing image is
> larger than for the backup target, e.g.
> 
>> #!/bin/bash
>> rm /tmp/fleecing.qcow2
>> ./qemu-img create /tmp/disk.qcow2 -f qcow2 1G
>> ./qemu-img create /tmp/fleecing.qcow2 -o cluster_size=2M -f qcow2 1G
>> ./qemu-img create /tmp/backup.qcow2 -f qcow2 1G
>> ./qemu-system-x86_64 --qmp stdio \
>> --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 \
>> --blockdev qcow2,node-name=node1,file.driver=file,file.filename=/tmp/fleecing.qcow2,discard=unmap \
>> --blockdev qcow2,node-name=node2,file.driver=file,file.filename=/tmp/backup.qcow2 \
>> <<EOF
>> {"execute": "qmp_capabilities"}
>> {"execute": "blockdev-add", "arguments": { "driver": "copy-before-write", "file": "node0", "target": "node1", "node-name": "node3" } }
>> {"execute": "blockdev-add", "arguments": { "driver": "snapshot-access", "file": "node3", "discard": "unmap", "node-name": "snap0" } }
>> {"execute": "blockdev-backup", "arguments": { "device": "snap0", "target": "node2", "sync": "full", "job-id": "backup0", "discard-source": true } }
>> EOF
> 
> will fail with
> 
>> qemu-system-x86_64: ../util/hbitmap.c:570: hbitmap_reset: Assertion `QEMU_IS_ALIGNED(count, gran) || (start + count == hb->orig_size)' failed.
> 
> Backtrace shows the assert happens while discarding, when resetting the
> BDRVCopyBeforeWriteState access_bitmap
>  > #6  0x0000555556142a2a in hbitmap_reset (hb=0x555557e01b80, start=0,
> count=1048576) at ../util/hbitmap.c:570
>> #7  0x0000555555f80764 in bdrv_reset_dirty_bitmap_locked (bitmap=0x55555850a660, offset=0, bytes=1048576) at ../block/dirty-bitmap.c:563
>> #8  0x0000555555f807ab in bdrv_reset_dirty_bitmap (bitmap=0x55555850a660, offset=0, bytes=1048576) at ../block/dirty-bitmap.c:570
>> #9  0x0000555555f7bb16 in cbw_co_pdiscard_snapshot (bs=0x5555581a7f60, offset=0, bytes=1048576) at ../block/copy-before-write.c:330
>> #10 0x0000555555f8d00a in bdrv_co_pdiscard_snapshot (bs=0x5555581a7f60, offset=0, bytes=1048576) at ../block/io.c:3734
>> #11 0x0000555555fd2380 in snapshot_access_co_pdiscard (bs=0x5555582b4f60, offset=0, bytes=1048576) at ../block/snapshot-access.c:55
>> #12 0x0000555555f8b65d in bdrv_co_pdiscard (child=0x5555584fe790, offset=0, bytes=1048576) at ../block/io.c:3144
>> #13 0x0000555555f78650 in block_copy_task_entry (task=0x555557f588f0) at ../block/block-copy.c:597
> 
> My guess for the cause is that in block_copy_calculate_cluster_size() we
> only look at the target. But now that we need to discard the source,
> we'll also need to consider that for the calculation?
> 

Just querying the source and picking the maximum won't work either,
because snapshot-access does not currently implement .bdrv_co_get_info
and because copy-before-write (doesn't implement .bdrv_co_get_info and
is a filter) will just return the info of its file child. But the
discard will go to the target child.

If I do

1. .bdrv_co_get_info in snapshot-access: return info from file child
2. .bdrv_co_get_info in copy-before-write: return maximum cluster_size
from file child and target child
3. block_copy_calculate_cluster_size: return maximum from source and target

then the issue does go away, but I don't know if that's not violating
any assumptions and probably there's a better way to avoid the issue?

Best Regards,
Fiona


