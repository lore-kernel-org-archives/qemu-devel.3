Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19173C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzKB-0002dC-Jj; Mon, 19 May 2025 08:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uGzK8-0002cU-QD; Mon, 19 May 2025 08:10:28 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uGzK5-0003to-Tx; Mon, 19 May 2025 08:10:28 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BBFE343296;
 Mon, 19 May 2025 14:10:12 +0200 (CEST)
Message-ID: <3a777fbd-bd1f-4deb-8d03-e66a58784474@proxmox.com>
Date: Mon, 19 May 2025 14:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] block/graph-lock: add drain flag to
 bdrv_graph_wr{,un}lock
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-11-f.ebner@proxmox.com> <aCT04V_-LtCXryqv@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aCT04V_-LtCXryqv@redhat.com>
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

Am 14.05.25 um 21:54 schrieb Kevin Wolf:
> Am 08.05.2025 um 16:09 hat Fiona Ebner geschrieben:
>> In bdrv_graph_wrlock() there is a comment that it uses
>> bdrv_drain_all_begin_nopoll() to make sure that constantly arriving
>> new I/O doesn't cause starvation. The changes from this series are at
>> odds with that, but there doesn't seem to be any (new) test failures.
> 
> I don't see why they are at odds with it? Draining an already drained
> node isn't a problem, it just increases the counter without doing
> anything else.

What I mean is: the introduction of calls to bdrv_drain_all_begin()
before bdrv_drain_all_begin_nopoll() could introduce potential for
starvation when there is constantly arriving new I/O. Or is this not true?

>> diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
>> index 2c26c72108..f291ccbc97 100644
>> --- a/include/block/graph-lock.h
>> +++ b/include/block/graph-lock.h
>> @@ -108,17 +108,21 @@ void unregister_aiocontext(AioContext *ctx);
>>   *
>>   * The wrlock can only be taken from the main loop, with BQL held, as only the
>>   * main loop is allowed to modify the graph.
>> + *
>> + * @drain whether bdrv_drain_all_begin() should be called before taking the lock
>>   */
>>  void no_coroutine_fn TSA_ACQUIRE(graph_lock) TSA_NO_TSA
>> -bdrv_graph_wrlock(void);
>> +bdrv_graph_wrlock(bool drain);
> 
> I would prefer having two separate functions instead of a bool
> parameter.
> 
> bdrv_graph_wrlock() could stay as it is, and bdrv_graph_wrlock_drained()
> could be the convenience wrapper that drains first.

Will do!

>>  /*
>>   * bdrv_graph_wrunlock:
>>   * Write finished, reset global has_writer to 0 and restart
>>   * all readers that are waiting.
>> + *
>> + * @drain whether bdrv_drain_all_end() should be called after releasing the lock
>>   */
>>  void no_coroutine_fn TSA_RELEASE(graph_lock) TSA_NO_TSA
>> -bdrv_graph_wrunlock(void);
>> +bdrv_graph_wrunlock(bool drain);
> 
> Here I would prefer to only keep the old bdrv_graph_wrunlock() without
> a parameter. Can we just remember @drain from bdrv_graph_wrlock() in a
> global variable? This would prevent callers from mismatching lock and
> unlock variants (which TSA wouldn't be able to catch).

Okay.

Best Regards,
Fiona


