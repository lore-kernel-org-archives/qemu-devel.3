Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF29E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 10:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vseT1-0007Mn-Tw; Wed, 18 Feb 2026 05:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vseSv-0007LW-4o; Wed, 18 Feb 2026 05:07:30 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vseSs-0003BS-OP; Wed, 18 Feb 2026 05:07:28 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1E2B055193;
 Wed, 18 Feb 2026 11:07:24 +0100 (CET)
Message-ID: <4001ff28-5901-404d-bc73-b36bf1af45d8@proxmox.com>
Date: Wed, 18 Feb 2026 11:07:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 0/2] io_uring fixes
To: Jens Axboe <axboe@kernel.dk>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com
References: <20260213143225.161043-1-axboe@kernel.dk>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20260213143225.161043-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1771409235747
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 13.02.26 um 3:33 PM schrieb Jens Axboe:
> Hi,
> 
> Patch 1 here is the real meat of this, patch 2 is just a slight
> improvement. For patch 1, it can literally yield a 50-80x improvement
> on the io_uring side for idle systems, where ppoll() ends up sleeping
> for 500 msec while there's IO to submit! I noticed this running the
> io_uring regression tests in a vm, where I use a variety of block
> devices for some of the tests. They would often randomly time out on
> AHCI devices, while running them on a virtio-blk or nvme device would
> finish in one second or so. I then wrote a reproducer to try and grok
> this and had claude dive into this, which helped me better grasp the
> various event loops.
> 
> Please take a look and tell me what you think. Some variant of patch 1
> should definitely be considered, but let me know if this is the right
> approach. I can easily test anything.
> 
> Also note - this seems to trigger more easily or consistently on
> aarch64, which is where I run most of my local/immediate testing.
> 
>  util/fdmon-io_uring.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 

Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>


