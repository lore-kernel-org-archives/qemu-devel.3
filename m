Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C768DC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 12:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH0JP-0003QS-3Q; Tue, 11 Jun 2024 08:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sH0JM-0003Py-Eg
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:09:12 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sH0JK-0004ZN-1k
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:09:11 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7226F45A56;
 Tue, 11 Jun 2024 14:08:57 +0200 (CEST)
Message-ID: <6d64f07d-1638-44dc-848b-b307c0ebd0ad@proxmox.com>
Date: Tue, 11 Jun 2024 14:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] migration/savevm: do not schedule
 snapshot_save_job_bh in qemu_aio_context
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 pbonzini@redhat.com
References: <20240605120848.358654-1-f.ebner@proxmox.com>
 <20240606183638.GC198201@fedora.redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240606183638.GC198201@fedora.redhat.com>
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

Am 06.06.24 um 20:36 schrieb Stefan Hajnoczi:
> On Wed, Jun 05, 2024 at 02:08:48PM +0200, Fiona Ebner wrote:
>> The fact that the snapshot_save_job_bh() is scheduled in the main
>> loop's qemu_aio_context AioContext means that it might get executed
>> during a vCPU thread's aio_poll(). But saving of the VM state cannot
>> happen while the guest or devices are active and can lead to assertion
>> failures. See issue #2111 for two examples. Avoid the problem by
>> scheduling the snapshot_save_job_bh() in the iohandler AioContext,
>> which is not polled by vCPU threads.
>>
>> Solves Issue #2111.
>>
>> This change also solves the following issue:
>>
>> Since commit effd60c878 ("monitor: only run coroutine commands in
>> qemu_aio_context"), the 'snapshot-save' QMP call would not respond
>> right after starting the job anymore, but only after the job finished,
>> which can take a long time. The reason is, because after commit
>> effd60c878, do_qmp_dispatch_bh() runs in the iohandler AioContext.
>> When do_qmp_dispatch_bh() wakes the qmp_dispatch() coroutine, the
>> coroutine cannot be entered immediately anymore, but needs to be
>> scheduled to the main loop's qemu_aio_context AioContext. But
>> snapshot_save_job_bh() was scheduled first to the same AioContext and
>> thus gets executed first.
>>
>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/2111
>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>> ---
>>
>> While initial smoke testing seems fine, I'm not familiar enough with
>> this to rule out any pitfalls with the approach. Any reason why
>> scheduling to the iohandler AioContext could be wrong here?
> 
> If something waits for a BlockJob to finish using aio_poll() from
> qemu_aio_context then a deadlock is possible since the iohandler_ctx
> won't get a chance to execute. The only suspicious code path I found was
> job_completed_txn_abort_locked() -> job_finish_sync_locked() but I'm not
> sure whether it triggers this scenario. Please check that code path.
> 

Sorry, I don't understand. Isn't executing the scheduled BH the only
additional progress that the iohandler_ctx needs to make compared to
before the patch? How exactly would that cause issues when waiting for a
BlockJob?

Or do you mean something waiting for the SnapshotJob from
qemu_aio_context before snapshot_save_job_bh had the chance to run?

Best Regards,
Fiona


