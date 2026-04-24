Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3996AFE5200
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDjU-0004HF-E0; Fri, 24 Apr 2026 06:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wGDjR-00047h-6e; Fri, 24 Apr 2026 06:25:57 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wGDjP-0005mW-7A; Fri, 24 Apr 2026 06:25:56 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E34B34A50C;
 Fri, 24 Apr 2026 12:25:42 +0200 (CEST)
Message-ID: <017dc767-90e3-4983-8417-e541b3fb04f6@proxmox.com>
Date: Fri, 24 Apr 2026 12:25:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
Subject: Excessive IO PSI for iothread when using io_uring since QEMU 10.2
To: "open list:Network Block Dev..." <qemu-block@nongnu.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1777026251746
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

Dear maintainers,

since QEMU 10.2, if io_uring is enabled, it will be used for the event
loop of iothreads and this causes an IO pressure stall value of nearly
100 when idle.

The issue was also reported on the kernel mailing list [0]. The
suggestion from Jens Axboe was to just turn off the iowait accounting
completely. But since (for block/file-posix.c), there is actual IO
submitted via the same ring, I wasn't sure if that is the right approach.

So the idea was to keep track of whether the event loop is otherwise
idle and only use the IORING_ENTER_NO_IOWAIT flag in that case [1].

However, doing so would only help for block/file-posix.c, which submits
IO via luring_co_submit() -> fdmon_io_uring_add_sqe(). For example, for
block/rbd.c, only a poll SQE for the AioHandler node's fd is used. When
submitting that poll SQE in the iothread, we would need to be able to
know if IO for RBD is currently in-flight or not to be able to decide
whether to use the IORING_ENTER_NO_IOWAIT flag or not. Is there a good
way to do this (in a general way)?

Or should the flag really always be used (if supported by the kernel)?
Is there a way to tell io_uring/kernel that we are an event loop and our
waiting should only be accounted for when there is actual IO in-flight?

Happy to hear your opinions and suggestions!

[0]:
https://lore.kernel.org/io-uring/14bc6266-5bc9-4454-9518-d1016bfe417b@proxmox.com/T/

[1]:
https://lore.proxmox.com/pve-devel/525c4dad-6d04-41f0-8a21-9302b0c6baa4@proxmox.com/T/

Best Regards,
Fiona


