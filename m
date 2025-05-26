Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B226C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 10:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJV9C-0004hR-ST; Mon, 26 May 2025 06:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uJV9A-0004ge-96; Mon, 26 May 2025 06:33:32 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uJV95-0004Bs-PO; Mon, 26 May 2025 06:33:30 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 357D6444FB;
 Mon, 26 May 2025 12:33:23 +0200 (CEST)
Message-ID: <6c640f56-31b8-408d-b747-6f75cdfa7592@proxmox.com>
Date: Mon, 26 May 2025 12:33:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/24] block/snapshot: move drain outside of
 read-locked bdrv_snapshot_delete()
To: Kevin Wolf <kwolf@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 hreitz@redhat.com, stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-4-f.ebner@proxmox.com>
 <4fdff680-5e77-40f2-812b-70697ad8ae64@virtuozzo.com>
 <aDQwDbJLqPYVxgCN@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aDQwDbJLqPYVxgCN@redhat.com>
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

Am 26.05.25 um 11:10 schrieb Kevin Wolf:
> Am 23.05.2025 um 20:12 hat Andrey Drobyshev geschrieben:
>> Okay, I've got a very simple and naive question to ask.  We've got this
>> pattern recurring throughout the series:
>>
>>> GLOBAL_STATE_CODE();
>>> bdrv_drain_all_begin();
>>> bdrv_graph_rdlock_main_loop();
>>>
>>> ...
>>>
>>> bdrv_graph_rdunlock_main_loop();
>>> bdrv_drain_all_end();
>>
>> bdrv_graph_rdlock_main_loop() doesn't actually take any locks, it
>> asserts that we're running in the main thread and not in a coroutine.
>> bdrv_graph_rdunlock_main_loop() does the same.
>> GRAPH_RDLOCK_GUARD_MAINLOOP() does both those calls, in the beginning of
>> a function and when leaving its scope, so essentially it also just does
>> assert(qemu_in_main_thread() && !qemu_in_coroutine()).
>>
>> Therefore:
>>
>> 1. Is there any real benefit from using those
>> {rdlock/rdunlock}_main_loop() constructions, or they're here due to
>> historical reasons only?
> 
> It's the price we pay for the compiler to verify our locking rules.
> 
>> 2. Would it hurt if we only leave GRAPH_RDLOCK_GUARD_MAINLOOP() in all
>> such occurrences?  At least when it's obvious we can't get out of the
>> main thread.  That would simply deliver us from performing same checks
>> several times, similar to what's done in commit 22/24 ("block/io: remove
>> duplicate GLOBAL_STATE_CODE() in bdrv_do_drained_end()").
> 
> Once bdrv_drain_all_begin() is marked GRAPH_UNLOCKED, calling it after
> GRAPH_RDLOCK_GUARD_MAINLOOP() would be wrong according to TSA rules
> (which don't know anything about this being only a fake lock) and the
> build would fail.

Note that I did not mark bdrv_drain_all_begin() as GRAPH_UNLOCKED in the
series yet. The reason is that I wasn't fully sure if that is okay,
given that it also can be called from a coroutine and does
bdrv_co_yield_to_drain() then. But I suppose that doesn't do anything
with the graph lock, so I'll add the GRAPH_UNLOCKED marker in v3.

I don't see any callers that actually are in coroutine context, except
test_quiesce_co_drain_all() and test_drv_cb_co_drain_all() in
tests/unit/test-bdrv-drain.c

Adding
 GLOBAL_STATE_CODE();
 assert(!qemu_in_coroutine());
to the beginning of the function seems to not cause any test failures
except for the two unit tests already mentioned.

Best Regards,
Fiona


