Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96F2C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 17:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT3RN-00022k-S3; Thu, 25 Jan 2024 12:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rT3RL-00021q-Pz; Thu, 25 Jan 2024 12:22:59 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rT3RJ-0004zX-4k; Thu, 25 Jan 2024 12:22:59 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 02EBF60F64;
 Thu, 25 Jan 2024 20:22:52 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b678::1:5] (unknown
 [2a02:6b8:b081:b678::1:5])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oMYf0a1Ia4Y0-YDrWZ69I; Thu, 25 Jan 2024 20:22:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1706203371;
 bh=he7/7V67C8DnpZfWMcnxki0x44ylfp3C6rUz8QKldCA=;
 h=In-Reply-To:Cc:References:To:From:Subject:Date:Message-ID;
 b=FsaCjB9RAHQas6NJ5f6wTkyu/4w3C8mV45oLqYsFS6eYBibmY4RtcNUGTizyBniou
 O2MMTq4ww9yGBH4nJ25G63/AinmfQvq7hiBEiLyfJratBsNPRKfp90IPjvy7pmXS3z
 kjsaL61IQlsJYcw2baBnxS0WW02p9KlThBfDnmKM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ee7438e8-ba86-40cc-b24e-5ea6160ba564@yandex-team.ru>
Date: Thu, 25 Jan 2024 20:22:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] qapi: blockdev-backup: add discard-source parameter
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com
References: <20240117160737.1057513-1-vsementsov@yandex-team.ru>
 <20240117160737.1057513-4-vsementsov@yandex-team.ru>
 <d0cbb4ed-bdb9-4487-ab7b-4b5e72a36e7e@proxmox.com>
 <36a903e5-c646-4596-a6e1-a7b1e2571c43@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <36a903e5-c646-4596-a6e1-a7b1e2571c43@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 25.01.24 15:47, Fiona Ebner wrote:
> Am 24.01.24 um 16:03 schrieb Fiona Ebner:
>> Am 17.01.24 um 17:07 schrieb Vladimir Sementsov-Ogievskiy:
>>> Add a parameter that enables discard-after-copy. That is mostly useful
>>> in "push backup with fleecing" scheme, when source is snapshot-access
>>> format driver node, based on copy-before-write filter snapshot-access
>>> API:
>>>
>>> [guest]      [snapshot-access] ~~ blockdev-backup ~~> [backup target]
>>>     |            |
>>>     | root       | file
>>>     v            v
>>> [copy-before-write]
>>>     |             |
>>>     | file        | target
>>>     v             v
>>> [active disk]   [temp.img]
>>>
>>> In this case discard-after-copy does two things:
>>>
>>>   - discard data in temp.img to save disk space
>>>   - avoid further copy-before-write operation in discarded area
>>>
>>> Note that we have to declare WRITE permission on source in
>>> copy-before-write filter, for discard to work.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>
>> Ran into another issue when the cluster_size of the fleecing image is
>> larger than for the backup target, e.g.
>>
>>> #!/bin/bash
>>> rm /tmp/fleecing.qcow2
>>> ./qemu-img create /tmp/disk.qcow2 -f qcow2 1G
>>> ./qemu-img create /tmp/fleecing.qcow2 -o cluster_size=2M -f qcow2 1G
>>> ./qemu-img create /tmp/backup.qcow2 -f qcow2 1G
>>> ./qemu-system-x86_64 --qmp stdio \
>>> --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 \
>>> --blockdev qcow2,node-name=node1,file.driver=file,file.filename=/tmp/fleecing.qcow2,discard=unmap \
>>> --blockdev qcow2,node-name=node2,file.driver=file,file.filename=/tmp/backup.qcow2 \
>>> <<EOF
>>> {"execute": "qmp_capabilities"}
>>> {"execute": "blockdev-add", "arguments": { "driver": "copy-before-write", "file": "node0", "target": "node1", "node-name": "node3" } }
>>> {"execute": "blockdev-add", "arguments": { "driver": "snapshot-access", "file": "node3", "discard": "unmap", "node-name": "snap0" } }
>>> {"execute": "blockdev-backup", "arguments": { "device": "snap0", "target": "node2", "sync": "full", "job-id": "backup0", "discard-source": true } }
>>> EOF
>>
>> will fail with
>>
>>> qemu-system-x86_64: ../util/hbitmap.c:570: hbitmap_reset: Assertion `QEMU_IS_ALIGNED(count, gran) || (start + count == hb->orig_size)' failed.
>>
>> Backtrace shows the assert happens while discarding, when resetting the
>> BDRVCopyBeforeWriteState access_bitmap
>>   > #6  0x0000555556142a2a in hbitmap_reset (hb=0x555557e01b80, start=0,
>> count=1048576) at ../util/hbitmap.c:570
>>> #7  0x0000555555f80764 in bdrv_reset_dirty_bitmap_locked (bitmap=0x55555850a660, offset=0, bytes=1048576) at ../block/dirty-bitmap.c:563
>>> #8  0x0000555555f807ab in bdrv_reset_dirty_bitmap (bitmap=0x55555850a660, offset=0, bytes=1048576) at ../block/dirty-bitmap.c:570
>>> #9  0x0000555555f7bb16 in cbw_co_pdiscard_snapshot (bs=0x5555581a7f60, offset=0, bytes=1048576) at ../block/copy-before-write.c:330
>>> #10 0x0000555555f8d00a in bdrv_co_pdiscard_snapshot (bs=0x5555581a7f60, offset=0, bytes=1048576) at ../block/io.c:3734
>>> #11 0x0000555555fd2380 in snapshot_access_co_pdiscard (bs=0x5555582b4f60, offset=0, bytes=1048576) at ../block/snapshot-access.c:55
>>> #12 0x0000555555f8b65d in bdrv_co_pdiscard (child=0x5555584fe790, offset=0, bytes=1048576) at ../block/io.c:3144
>>> #13 0x0000555555f78650 in block_copy_task_entry (task=0x555557f588f0) at ../block/block-copy.c:597
>>
>> My guess for the cause is that in block_copy_calculate_cluster_size() we
>> only look at the target. But now that we need to discard the source,
>> we'll also need to consider that for the calculation?
>>
> 
> Just querying the source and picking the maximum won't work either,
> because snapshot-access does not currently implement .bdrv_co_get_info
> and because copy-before-write (doesn't implement .bdrv_co_get_info and
> is a filter) will just return the info of its file child. But the
> discard will go to the target child.
> 
> If I do
> 
> 1. .bdrv_co_get_info in snapshot-access: return info from file child
> 2. .bdrv_co_get_info in copy-before-write: return maximum cluster_size
> from file child and target child
> 3. block_copy_calculate_cluster_size: return maximum from source and target
> 
> then the issue does go away, but I don't know if that's not violating
> any assumptions and probably there's a better way to avoid the issue?
> 


Hmm. Taking maximum is not optimal for usual case without discard-source: user may want to work in smaller granularity than source, to save disk space.

In case with discarding we have two possibilities:

- either take larger granularity for the whole process like you propose (but this will need and option for CBW?)
- or, fix discarding bitmap in CBW to work like normal discard: it should be aligned down. This will lead actually to discard-source option doing nothing..

==
But why do you want fleecing image with larger granularity? Is that a real case or just experimenting? Still we should fix assertion anyway.

I think:

1. fix discarding bitmap to make aligning-down (will do that for v3)

2. if we need another logic for block_copy_calculate_cluster_size() it should be an option. May be explicit "copy-cluster-size" or "granularity" option for CBW driver and for backup job. And we'll just check that given cluster-size is power of two >= target_size.


-- 
Best regards,
Vladimir


