Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E25C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFTE-00061p-KR; Fri, 12 Jul 2024 08:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sSFT7-0005dR-Bt; Fri, 12 Jul 2024 08:33:46 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sSFSz-0005L2-AS; Fri, 12 Jul 2024 08:33:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a52d:0:640:f75d:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D234361252;
 Fri, 12 Jul 2024 15:33:29 +0300 (MSK)
Received: from [IPV6:2a02:6b8:0:419:5fb9:9623:463f:792c] (unknown
 [2a02:6b8:0:419:5fb9:9623:463f:792c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id SXf9xZ0Vo8c0-OJ68x16W; Fri, 12 Jul 2024 15:33:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1720787609;
 bh=Dg1XIYi12rYLAeHhglWpQVXh9MGLESu19zeLSS3dBHs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=FP/O92hMJnmXPKh/L2gXESHiXaRzhXEPF9zG2Zp4K8phIZR2AFU1f3KkSyKpZXwNz
 IAcoFtcgEXIfhhHHrixedQ4jFfbk/saDMDvDrg44GnpoCerieo5lecOk+tR3JjPXzY
 bZ9RHiaFaCCYP3B05ouuaUo+Gg5HuiYn8q+s37kE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c41a8353-229b-4dd6-b268-cb9713faaed1@yandex-team.ru>
Date: Fri, 12 Jul 2024 15:33:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/copy-before-write: wait for conflicts when read
 locking to avoid assertion failure
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com
References: <20240711133652.589770-1-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240711133652.589770-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11.07.24 16:36, Fiona Ebner wrote:
> There is no protection against two callers of cbw_snapshot_read_lock()
> calling reqlist_init_req() with overlapping ranges, and
> reqlist_init_req() asserts that there are no conflicting requests.
> 
> In particular, two cbw_co_snapshot_block_status() callers can race,
> with the second calling reqlist_init_req() before the first one
> finishes and removes its conflicting request, leading to an assertion
> failure.
> 
> Reproducer script [0] and backtrace [1] are attached below.


Understand. But seems in case of CBW read-lock, nothing bad in intersecting read requests?

reqlist is shared with backup, where we care to avoid intersecting requests in the list. What about just move the assertion to block_copy_task_create() ? And add comment somewhere that we support intersecting reads in frozen_read_reqs.


> 
> [0]:
> 
>> #!/bin/bash -e
>> dd if=/dev/urandom of=/tmp/disk.raw bs=1M count=1024
>> ./qemu-img create /tmp/fleecing.raw -f raw 1G
>> (
>> ./qemu-system-x86_64 --qmp stdio \
>> --blockdev raw,node-name=node0,file.driver=file,file.filename=/tmp/disk.raw \
>> --blockdev raw,node-name=node1,file.driver=file,file.filename=/tmp/fleecing.raw \
>> <<EOF
>> {"execute": "qmp_capabilities"}
>> {"execute": "blockdev-add", "arguments": { "driver": "copy-before-write", "file": "node0", "target": "node1", "node-name": "node3" } }
>> {"execute": "blockdev-add", "arguments": { "driver": "snapshot-access", "file": "node3", "node-name": "snap0" } }
>> {"execute": "nbd-server-start", "arguments": {"addr": { "type": "unix", "data": { "path": "/tmp/nbd.socket" } } } }
>> {"execute": "block-export-add", "arguments": {"id": "exp0", "node-name": "snap0", "type": "nbd", "name": "exp0"}}
>> EOF
>> ) &
>> sleep 5
>> while true; do
>> ./qemu-nbd -d /dev/nbd0
>> ./qemu-nbd -c /dev/nbd0 nbd:unix:/tmp/nbd.socket:exportname=exp0 -f raw -r
>> nbdinfo --map 'nbd+unix:///exp0?socket=/tmp/nbd.socket'
>> done
> 
> [1]:
> 
>> #5  0x000071e5f0088eb2 in __GI___assert_fail (...) at ./assert/assert.c:101
>> #6  0x0000615285438017 in reqlist_init_req (...) at ../block/reqlist.c:23
>> #7  0x00006152853e2d98 in cbw_snapshot_read_lock (...) at ../block/copy-before-write.c:237
>> #8  0x00006152853e3068 in cbw_co_snapshot_block_status (...) at ../block/copy-before-write.c:304
>> #9  0x00006152853f4d22 in bdrv_co_snapshot_block_status (...) at ../block/io.c:3726
>> #10 0x000061528543a63e in snapshot_access_co_block_status (...) at ../block/snapshot-access.c:48
>> #11 0x00006152853f1a0a in bdrv_co_do_block_status (...) at ../block/io.c:2474
>> #12 0x00006152853f2016 in bdrv_co_common_block_status_above (...) at ../block/io.c:2652
>> #13 0x00006152853f22cf in bdrv_co_block_status_above (...) at ../block/io.c:2732
>> #14 0x00006152853d9a86 in blk_co_block_status_above (...) at ../block/block-backend.c:1473
>> #15 0x000061528538da6c in blockstatus_to_extents (...) at ../nbd/server.c:2374
>> #16 0x000061528538deb1 in nbd_co_send_block_status (...) at ../nbd/server.c:2481
>> #17 0x000061528538f424 in nbd_handle_request (...) at ../nbd/server.c:2978
>> #18 0x000061528538f906 in nbd_trip (...) at ../nbd/server.c:3121
>> #19 0x00006152855a7caf in coroutine_trampoline (...) at ../util/coroutine-ucontext.c:175
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   block/copy-before-write.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/copy-before-write.c b/block/copy-before-write.c
> index 853e01a1eb..376ff3f3e1 100644
> --- a/block/copy-before-write.c
> +++ b/block/copy-before-write.c
> @@ -234,6 +234,7 @@ cbw_snapshot_read_lock(BlockDriverState *bs, int64_t offset, int64_t bytes,
>           *req = (BlockReq) {.offset = -1, .bytes = -1};
>           *file = s->target;
>       } else {
> +        reqlist_wait_all(&s->frozen_read_reqs, offset, bytes, &s->lock);
>           reqlist_init_req(&s->frozen_read_reqs, req, offset, bytes);
>           *file = bs->file;
>       }

-- 
Best regards,
Vladimir


