Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20F7CF34D3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 15:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLkJF-0006pq-Fb; Wed, 19 Nov 2025 10:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vLkJ0-0006bE-Dl; Wed, 19 Nov 2025 10:41:14 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vLkIw-0000tA-Qo; Wed, 19 Nov 2025 10:41:14 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8A1A287389;
 Wed, 19 Nov 2025 16:40:59 +0100 (CET)
Message-ID: <72665cb8-88df-4223-8f43-91bd60552bc9@proxmox.com>
Date: Wed, 19 Nov 2025 16:40:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] block: use pwrite_zeroes_alignment when writing
 first sector
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Jean-Louis Dupond <jean-louis@dupond.be>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>
References: <20251007141700.71891-1-stefanha@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20251007141700.71891-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1763566828059
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

Am 07.10.25 um 6:07 PM schrieb Stefan Hajnoczi:
> v2:
> - Simplify condition to if (!s->needs_alignment) in patch 1 [Vladimir]
> 
> This series fixes a bug I introduced in commit 5634622bcb33 ("file-posix: allow
> BLKZEROOUT with -t writeback"). The Linux fallocate(2) and ioctl(BLKZEROOUT)
> syscalls require logical block size alignment of the offset and length, even
> when the file is opened in buffered I/O mode where read/write operations do not
> require alignment.
> 
> The fix is to populate the pwrite_zeroes_alignment block limits field and to
> use that limit in create_file_fallback_zero_first_sector().
> 
> One issue I want to raise is that pwrite_zeroes_alignment is an "optimal
> alignment" hint. Hence create_file_fallback_zero_first_sector() had to be
> modified to honor the limit explicitly. The block layer doesn't automatically
> apply padding in order to align requests. This is different from how QEMU's
> block layer pwrite/pread works, where it does automatically apply padding and
> read/modify/write as necessary. If you want consistency, please let me know.
> 
> Stefan Hajnoczi (3):
>   file-posix: populate pwrite_zeroes_alignment
>   block: use pwrite_zeroes_alignment when writing first sector
>   iotests: add Linux loop device image creation test
> 
>  include/system/block-backend-io.h             |  1 +
>  block.c                                       |  3 +-
>  block/block-backend.c                         | 11 ++++
>  block/file-posix.c                            | 16 +++++
>  tests/qemu-iotests/tests/loop-create-file     | 59 +++++++++++++++++++
>  tests/qemu-iotests/tests/loop-create-file.out |  8 +++
>  6 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100755 tests/qemu-iotests/tests/loop-create-file
>  create mode 100644 tests/qemu-iotests/tests/loop-create-file.out
> 

Thank you for the fix!

Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>



