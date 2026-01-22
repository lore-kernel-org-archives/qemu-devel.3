Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96190D3EE6A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 14:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vivQd-0000lL-GW; Thu, 22 Jan 2026 09:12:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vivQb-0000jg-Fr; Thu, 22 Jan 2026 09:12:53 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vivQZ-0002mk-4E; Thu, 22 Jan 2026 09:12:53 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A4FF3404A3;
 Thu, 22 Jan 2026 15:12:40 +0100 (CET)
Message-ID: <9901305b-fbdf-4893-8e80-3bc0d1d645b0@proxmox.com>
Date: Thu, 22 Jan 2026 15:12:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/15] block/io_uring: use aio_add_sqe()
From: Fiona Ebner <f.ebner@proxmox.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com,
 Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 hibriansong@gmail.com
References: <20251104022933.618123-1-stefanha@redhat.com>
 <20251104022933.618123-15-stefanha@redhat.com>
 <57bc5da0-5889-43dd-ab53-635363583b5c@proxmox.com>
Content-Language: en-US
In-Reply-To: <57bc5da0-5889-43dd-ab53-635363583b5c@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1769091101638
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 16.01.26 um 5:44 PM schrieb Fiona Ebner:
> Hi,
> 
> Am 04.11.25 um 5:11 AM schrieb Stefan Hajnoczi:
>> AioContext has its own io_uring instance for file descriptor monitoring.
>> The disk I/O io_uring code was developed separately. Originally I
>> thought the characteristics of file descriptor monitoring and disk I/O
>> were too different, requiring separate io_uring instances.
>>
>> Now it has become clear to me that it's feasible to share a single
>> io_uring instance for file descriptor monitoring and disk I/O. We're not
>> using io_uring's IOPOLL feature or anything else that would require a
>> separate instance.
>>
>> Unify block/io_uring.c and util/fdmon-io_uring.c using the new
>> aio_add_sqe() API that allows user-defined io_uring sqe submission. Now
>> block/io_uring.c just needs to submit readv/writev/fsync and most of the
>> io_uring-specific logic is handled by fdmon-io_uring.c.
>>
>> There are two immediate advantages:
>> 1. Fewer system calls. There is no need to monitor the disk I/O io_uring
>>    ring fd from the file descriptor monitoring io_uring instance. Disk
>>    I/O completions are now picked up directly. Also, sqes are
>>    accumulated in the sq ring until the end of the event loop iteration
>>    and there are fewer io_uring_enter(2) syscalls.
>> 2. Less code duplication.
>>
>> Note that error_setg() messages are not supposed to end with
>> punctuation, so I removed a '.' for the non-io_uring build error
>> message.
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> after commit 047dabef97 ("block/io_uring: use aio_add_sqe()") using
> 'aio=io_uring' for an 'ide-hd' drive becomes prohibitively slow: for me,
> a Debian 12 guest [0] won't even reach the GRUB menu after multiple
> minutes. Using aio=threads makes the issue go away, as does building
> from the previous commit, i.e. 1eebdab3c3 ("aio-posix: add aio_add_sqe()
> API for user-defined io_uring requests"). The issue still exists on
> current master.
> 
> There are lots and lots of 512 byte read requests. MAX_BUFFERED_REQS in
> ide_buffered_readv() is only 16, maybe that has something to do with it?
> Haven't had the time to dig into the issue yet, and wasn't able to
> reproduce with 'qemu-img bench' or something other than 'ide-hd'.

I did some more experimentation and tracing and found the likely issue.
The old implementation had in its ioq_submit():

>     if (s->io_q.in_flight) {
>         /*
>          * We can try to complete something just right away if there are
>          * still requests in-flight.
>          */
>         luring_process_completions(s);
>     }

and thus at the end of luring_co_submit()

>     if (luringcb.ret == -EINPROGRESS) {
>         qemu_coroutine_yield();
>     }
>     return luringcb.ret;

all those small one-sector requests will already be completed right away
and the coroutine won't yield.

But for the new implementation, that doesn't happen and the coroutine
yields for every single request in my testing.

The following patch restores the speed and the coroutine doesn't yield
for all those one-sector requests anymore:

> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index e24b955fd9..acaed8cec3 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -813,5 +813,6 @@ void aio_add_sqe(void (*prep_sqe)(struct io_uring_sqe *sqe, void *opaque),
>  {
>      AioContext *ctx = qemu_get_current_aio_context();
>      ctx->fdmon_ops->add_sqe(ctx, prep_sqe, opaque, cqe_handler);
> +    aio_poll(ctx, false);
>  }
>  #endif /* CONFIG_LINUX_IO_URING */

Does the approach make sense? Might it be better to do this on the call
sites instead? Or add a flag to aio_add_sqe() to control whether it is done?

> 
> Best Regards,
> Fiona
> 
> [0]:
>> ./qemu-system-x86_64 \
>>   -accel kvm \
>>   -chardev 'socket,id=qmp,path=/var/run/qemu-server/500.qmp,server=on,wait=off' \
>>   -mon 'chardev=qmp,mode=control' \
>>   -pidfile /var/run/qemu-server/500.pid \
>>   -nodefaults \
>>   -vnc 'unix:/var/run/qemu-server/500.vnc,password=on' \
>>   -m 4096 \
>>   -device 'VGA,id=vga,bus=pci.0,addr=0x2' \
>>   -drive 'file=/mnt/pve/dir/images/500/vm-500-disk-0.raw,if=none,id=drive-ide0,format=raw,aio=io_uring' \
>>   -device 'ide-hd,bus=ide.0,unit=0,drive=drive-ide0,id=ide0'
> 
> 
> 
> 



