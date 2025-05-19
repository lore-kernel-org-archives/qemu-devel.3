Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306BDC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzkL-00020D-9A; Mon, 19 May 2025 08:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uGzkI-0001zU-0i; Mon, 19 May 2025 08:37:30 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uGzkF-00073D-Rc; Mon, 19 May 2025 08:37:29 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4C40E40658;
 Mon, 19 May 2025 14:37:23 +0200 (CEST)
Message-ID: <f47967a3-80c9-4b92-8eed-9f7c469f6afc@proxmox.com>
Date: Mon, 19 May 2025 14:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] blockdev: drain while unlocked in
 internal_snapshot_action()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-7-f.ebner@proxmox.com> <aCTSMfOt1tyJVwt1@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aCTSMfOt1tyJVwt1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Am 14.05.25 um 19:26 schrieb Kevin Wolf:
> Am 08.05.2025 um 16:09 hat Fiona Ebner geschrieben:
>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>> ---
>>
>> Could the bs associated to the device change because of polling
>> when draining? If yes, does that mean we need to drain all in the
>> beginning and not temporarily unlock?
> 
> I'm starting to hate this pattern. :-)
> 
> Maybe it would eventually be a good idea to have some helpers to deal
> with this common problem of "I want to drain all nodes that will be
> affected by the operation, but draining could change which nodes are
> part of it".

Yes, that would be nice :)

> For this specific case, though, I think drain all is right simply
> because we may already rely on it: I suppose qmp_transaction() calls
> bdrv_drain_all() for a reason, but it should actually be a drain
> section. I'm pretty sure we're not just waiting for some requests to
> complete, but want to keep other users away. Maybe the graph lock
> actually covers whatever this drain was initially supposed to solve, but
> bdrv_drain_all() doesn't look right.
>
> So how about making it bdrv_drain_all_begin/end() in qmp_transaction()
> just because that's the safe thing to do, and then we can just drop any
> individual drains in action implementations?

Unfortunately, this does not work on its own. Among others, iotest 096
for qcow2 will hang, because bdrv_img_create() is called by
external_snapshot_action() while drained and then qcow2_co_create()
coroutine will hang in
blk_co_do_pwritev_part()/blk_wait_while_drained(). So it seems having
the more targeted drain here is important.

Would it be sensible to go with the "temporarily unlock" solution, but
adding an extra check that the root bs of the device is still the one we
drained after re-locking? And returning an error if not. At least for
now, because the series is already getting quite big (in particular with
the split of 09/11).

Best Regards,
Fiona


