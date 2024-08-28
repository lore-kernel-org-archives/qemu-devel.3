Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33814C54FAA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIoZ-0006pN-D7; Wed, 28 Aug 2024 09:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sjIoX-0006o5-7c; Wed, 28 Aug 2024 09:34:21 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sjIoT-00017i-Qv; Wed, 28 Aug 2024 09:34:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c00:2588:0:640:36aa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 69BD960A01;
 Wed, 28 Aug 2024 16:34:08 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:1221::1:27] (unknown
 [2a02:6b8:b081:1221::1:27])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5YV5qr0XqeA0-gJCqX7bP; Wed, 28 Aug 2024 16:34:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1724852046;
 bh=yL0Z8V+YnfU5bycxhsxPrRIZkNV4V+iHlfQvAsGG5LI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=TG2uMv1TsvvAqclpS/x4BW1e/8MiLfCxhzcYu2L3hEZeci/oPpzw6PV1UGHZbqPvY
 L5CGne25Vrknynrk0u1B3rd+fEDh0WugwuY8FlstApL0o8hrnr5g40e0NeRcPSSQA7
 hd2uq0Hb/S6Pv3W0h64h+6uO40SyEiIjNKV9xucA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <156a5657-25d3-435c-b212-8f42f3ffb786@yandex-team.ru>
Date: Wed, 28 Aug 2024 16:34:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/reqlist: allow adding overlapping requests
To: Michael Tokarev <mjt@tls.msk.ru>, Fiona Ebner <f.ebner@proxmox.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com
References: <20240712140716.517911-1-f.ebner@proxmox.com>
 <fb94e606-73be-4af9-8cb3-52c661fe320e@tls.msk.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <fb94e606-73be-4af9-8cb3-52c661fe320e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11.08.24 20:55, Michael Tokarev wrote:
> 12.07.2024 17:07, Fiona Ebner wrote:
>> Allow overlapping request by removing the assert that made it
>> impossible. There are only two callers:
>>
>> 1. block_copy_task_create()
>>
>> It already asserts the very same condition before calling
>> reqlist_init_req().
>>
>> 2. cbw_snapshot_read_lock()
>>
>> There is no need to have read requests be non-overlapping in
>> copy-before-write when used for snapshot-access. In fact, there was no
>> protection against two callers of cbw_snapshot_read_lock() calling
>> reqlist_init_req() with overlapping ranges and this could lead to an
>> assertion failure [1].
>>
>> In particular, with the reproducer script below [0], two
>> cbw_co_snapshot_block_status() callers could race, with the second
>> calling reqlist_init_req() before the first one finishes and removes
>> its conflicting request.
>>
>> [0]:
>>
>>> #!/bin/bash -e
>>> dd if=/dev/urandom of=/tmp/disk.raw bs=1M count=1024
>>> ./qemu-img create /tmp/fleecing.raw -f raw 1G
>>> (
>>> ./qemu-system-x86_64 --qmp stdio \
>>> --blockdev raw,node-name=node0,file.driver=file,file.filename=/tmp/disk.raw \
>>> --blockdev raw,node-name=node1,file.driver=file,file.filename=/tmp/fleecing.raw \
>>> <<EOF
>>> {"execute": "qmp_capabilities"}
>>> {"execute": "blockdev-add", "arguments": { "driver": "copy-before-write", "file": "node0", "target": "node1", "node-name": "node3" } }
>>> {"execute": "blockdev-add", "arguments": { "driver": "snapshot-access", "file": "node3", "node-name": "snap0" } }
>>> {"execute": "nbd-server-start", "arguments": {"addr": { "type": "unix", "data": { "path": "/tmp/nbd.socket" } } } }
>>> {"execute": "block-export-add", "arguments": {"id": "exp0", "node-name": "snap0", "type": "nbd", "name": "exp0"}}
>>> EOF
>>> ) &
>>> sleep 5
>>> while true; do
>>> ./qemu-nbd -d /dev/nbd0
>>> ./qemu-nbd -c /dev/nbd0 nbd:unix:/tmp/nbd.socket:exportname=exp0 -f raw -r
>>> nbdinfo --map 'nbd+unix:///exp0?socket=/tmp/nbd.socket'
>>> done
>>
>> [1]:
>>
>>> #5  0x000071e5f0088eb2 in __GI___assert_fail (...) at ./assert/assert.c:101
>>> #6  0x0000615285438017 in reqlist_init_req (...) at ../block/reqlist.c:23
>>> #7  0x00006152853e2d98 in cbw_snapshot_read_lock (...) at ../block/copy-before-write.c:237
>>> #8  0x00006152853e3068 in cbw_co_snapshot_block_status (...) at ../block/copy-before-write.c:304
>>> #9  0x00006152853f4d22 in bdrv_co_snapshot_block_status (...) at ../block/io.c:3726
>>> #10 0x000061528543a63e in snapshot_access_co_block_status (...) at ../block/snapshot-access.c:48
>>> #11 0x00006152853f1a0a in bdrv_co_do_block_status (...) at ../block/io.c:2474
>>> #12 0x00006152853f2016 in bdrv_co_common_block_status_above (...) at ../block/io.c:2652
>>> #13 0x00006152853f22cf in bdrv_co_block_status_above (...) at ../block/io.c:2732
>>> #14 0x00006152853d9a86 in blk_co_block_status_above (...) at ../block/block-backend.c:1473
>>> #15 0x000061528538da6c in blockstatus_to_extents (...) at ../nbd/server.c:2374
>>> #16 0x000061528538deb1 in nbd_co_send_block_status (...) at ../nbd/server.c:2481
>>> #17 0x000061528538f424 in nbd_handle_request (...) at ../nbd/server.c:2978
>>> #18 0x000061528538f906 in nbd_trip (...) at ../nbd/server.c:3121
>>> #19 0x00006152855a7caf in coroutine_trampoline (...) at ../util/coroutine-ucontext.c:175
>>
>> Cc: qemu-stable@nongnu.org
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> 
> Hi!
> 
> Has this been forgotten or is it not needed for 9.1?
> 

My apologies, this is forgotten. I think rc4 is too late, I'll send Pull request as soon as 9.2 window open.

-- 
Best regards,
Vladimir


