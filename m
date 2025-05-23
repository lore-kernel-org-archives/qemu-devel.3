Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A8DC3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 07:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uINFg-0007j1-R5; Fri, 23 May 2025 03:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uINFb-0007ia-Aq; Fri, 23 May 2025 03:55:31 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uINFW-0000vE-In; Fri, 23 May 2025 03:55:30 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0DB6B43EA1;
 Fri, 23 May 2025 09:55:22 +0200 (CEST)
Message-ID: <c02139a7-de4a-42da-bff3-525c0679223c@proxmox.com>
Date: Fri, 23 May 2025 09:55:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests: Improve mirror-sparse on various filesystems
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20250522211451.2301791-2-eblake@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20250522211451.2301791-2-eblake@redhat.com>
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

Am 22.05.25 um 23:14 schrieb Eric Blake:
> Fiona reported that an ext4 filesystem on top of LVM can sometimes
> report over-allocation to du (based on the hueristics the filesystem

Typo: heuristics

> is making while observing the contents being mirrored); even though
> the contents and actual size matched, about 50% of the time the size
> reported by disk_usage was too large by 4k, failing the test.
> 
> Similarly, on ZFS where a file is created with preallocation=full, du
> does not see the full allocation until things have had time to settle;
> adding a sync call reduces the chance of catching that async window:
> 
> | [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> qemu-img create my.raw 20M -f
> |w -o preallocation=full
> | Formatting 'my.raw', fmt=raw size=20971520 preallocation=full
> | [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> du --block-size=1 my.raw
> | 512 my.raw
> | [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> du --block-size=1 my.raw
> | 20980224    my.raw
> 
> Fiona also reported that on a compressed ZFS, the filesystem can end
> up reporting smaller disk_usage if it re-compresses a file, despite a
> fully-allocating mirror - but since I don't have a compressed ZFS
> handy for reproducing that test, that may remain a sporadic problem
> for another day.
> 
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Fixes: c0ddcb2c ("tests: Add iotest mirror-sparse for recent patches")
> Signed-off-by: Eric Blake <eblake@redhat.com>

If you drop the hunk with the sync:
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>

> ---
>  tests/qemu-iotests/common.rc           | 2 ++
>  tests/qemu-iotests/tests/mirror-sparse | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 237f746af88..c3fc0bcf02a 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -143,6 +143,8 @@ _optstr_add()
>  # report real disk usage for sparse files
>  disk_usage()
>  {
> +    # ZFS has lazy allocation; sync the file first for best results
> +    sync "$1"

Unfortunately, just syncing the file seems to be not enough. It seems to
be necessary to sync the whole filesystem, but that of course is too
expensive for the helper here:

[I] febner@enia ~> rm my.raw; qemu-img create my.raw 20M -f raw -o
preallocation=full; sync my.raw; du --block-size=1 my.raw
Formatting 'my.raw', fmt=raw size=20971520 preallocation=full
512	my.raw
[I] febner@enia ~> rm my.raw; qemu-img create my.raw 20M -f raw -o
preallocation=full; sync -f my.raw; du --block-size=1 my.raw
Formatting 'my.raw', fmt=raw size=20971520 preallocation=full
20980224	my.raw

There's already quite a few other test failures on ZFS, so I guess it's
not worth it right now if there's no easy fix (mirror-sparse also still
fails, because the file is sparse again after mirroring, ZFS seems very
aggressive trying to reduce allocation):

For -raw:
Failures: 106 109 150 175 221 240 253 308 mirror-sparse write-zeroes-unmap
Failed 10 of 86 iotests


>      du --block-size=1 "$1" | awk '{print $1}'
>  }
> 

Best Regards,
Fiona


