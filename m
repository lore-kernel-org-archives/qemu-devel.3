Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2D3FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHhGd-0003y9-11; Tue, 28 Apr 2026 08:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wHhGb-0003xg-04; Tue, 28 Apr 2026 08:10:17 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wHhGY-0003N7-KZ; Tue, 28 Apr 2026 08:10:16 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 219C6874CD;
 Tue, 28 Apr 2026 14:10:03 +0200 (CEST)
Message-ID: <317ab384-f8c2-49af-89c4-407bb2f5617c@proxmox.com>
Date: Tue, 28 Apr 2026 14:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Excessive IO PSI for iothread when using io_uring since QEMU 10.2
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>,
 Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <017dc767-90e3-4983-8417-e541b3fb04f6@proxmox.com>
 <20260427191343.GD218226@fedora>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20260427191343.GD218226@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1777378106004
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Stefan,

Am 27.04.26 um 9:12 PM schrieb Stefan Hajnoczi:
> On Fri, Apr 24, 2026 at 12:25:41PM +0200, Fiona Ebner wrote:
>> Dear maintainers,
>>
>> since QEMU 10.2, if io_uring is enabled, it will be used for the event
>> loop of iothreads and this causes an IO pressure stall value of nearly
>> 100 when idle.
>>
>> The issue was also reported on the kernel mailing list [0]. The
>> suggestion from Jens Axboe was to just turn off the iowait accounting
>> completely. But since (for block/file-posix.c), there is actual IO
>> submitted via the same ring, I wasn't sure if that is the right approach.
>>
>> So the idea was to keep track of whether the event loop is otherwise
>> idle and only use the IORING_ENTER_NO_IOWAIT flag in that case [1].
>>
>> However, doing so would only help for block/file-posix.c, which submits
>> IO via luring_co_submit() -> fdmon_io_uring_add_sqe(). For example, for
>> block/rbd.c, only a poll SQE for the AioHandler node's fd is used. When
>> submitting that poll SQE in the iothread, we would need to be able to
>> know if IO for RBD is currently in-flight or not to be able to decide
>> whether to use the IORING_ENTER_NO_IOWAIT flag or not. Is there a good
>> way to do this (in a general way)?
>>
>> Or should the flag really always be used (if supported by the kernel)?
>> Is there a way to tell io_uring/kernel that we are an event loop and our
>> waiting should only be accounted for when there is actual IO in-flight?
>>
>> Happy to hear your opinions and suggestions!
>>
>> [0]:
>> https://lore.kernel.org/io-uring/14bc6266-5bc9-4454-9518-d1016bfe417b@proxmox.com/T/
> 
> Hi Fiona,
> Jens replied yesterday confirmed your suspicion that the number of
> inflight requests is not being tracked correctly.
> 
> Is there still a problem after fixing the kernel's inflight counting? If
> not, then no QEMU change is necessary and that seems like the cleanest
> solution anyway. The kernel should know whether there is I/O in flight
> and so it doesn't seem right that userspace needs to hint this.


unfortunately, yes. Even with the kernel fix [2], the real problem with
poll SQEs described above remains. I'm still seeing high IO pressure
stall values when using QEMU. In add_poll_add_sqe(), QEMU submits poll
SQEs for the AioHandler node fd, and that does count as pending IO. A
small reproducer modeling this [3].

So the question from above, how to deal with this for block drivers not
going through file-posix.c remains.

Best Regards,
Fiona

[2]:
https://lore.kernel.org/io-uring/b4d2aa36-8301-4e58-be3e-1451267b8c43@proxmox.com/T/

[3]:

#include <assert.h>
#include <errno.h>
#include <stdio.h>
#include <unistd.h>
#include <liburing.h>
#include <sys/eventfd.h>

int main(void) {
    int fd;
    int ret;
    struct io_uring ring;
    struct io_uring_sqe *sqe;

    fd = eventfd(0, 0);
    assert(fd >= 0);

    ret = io_uring_queue_init(128, &ring, 0);
    assert(ret == 0);

    sqe = io_uring_get_sqe(&ring);
    assert(sqe);

    io_uring_prep_poll_add(sqe, fd, 1);

    ret = io_uring_submit_and_wait(&ring, 1);
    printf("got ret %d\n", ret);

    io_uring_queue_exit(&ring);

    return 0;
}



