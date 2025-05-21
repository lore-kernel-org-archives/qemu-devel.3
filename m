Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66149C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHg9c-0001rz-Fa; Wed, 21 May 2025 05:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHg9Y-0001hp-QP; Wed, 21 May 2025 05:54:24 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHg9V-0002oq-Ns; Wed, 21 May 2025 05:54:24 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6F3BE43B18;
 Wed, 21 May 2025 11:54:08 +0200 (CEST)
Message-ID: <78bc08dc-5da5-4fcf-804b-1a387f2e9ea8@proxmox.com>
Date: Wed, 21 May 2025 11:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/14] tests: Add iotest mirror-sparse for recent patches
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20250515022904.575509-16-eblake@redhat.com>
 <20250515022904.575509-29-eblake@redhat.com>
Content-Language: de-AT, en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20250515022904.575509-29-eblake@redhat.com>
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

Hi,

Am 15.05.25 um 04:28 schrieb Eric Blake:
> +do_test full ignore off full

for me, this one fails irregularly (more than 50% of the time) with:
-Destination is full; expected full
+Destination is unknown; expected full

My file system is ext4 inside a virtual machine.
> [I] febner@dev8 ~/repos/qemu/build/tests/qemu-iotests (master) [1]> findmnt --target .
> TARGET             SOURCE   FSTYPE OPTIONS
> /home/febner/repos /dev/sdb ext4   rw,relatime

The virtual disk is an LVM image. When the test fails, I consistently
get 20975616 bytes rather than 20971520 bytes as the result of
disk_usage(), i.e. it has one 4 KiB block more. ls -l will still report
20971520 bytes as the length, qemu-img compare succeeds.

After the image creation, i.e. job1, the allocation is still as expected:
> +20971520	/home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw
> +-rw-r--r-- 1 febner febner 20971520 May 21 11:18 /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw

Only after mirroring, i.e. job2, it will be larger:
> +20975616	/home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw
> +-rw-r--r-- 1 febner febner 20971520 May 21 11:18 /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw

Some more information:

> [I] febner@dev8 ~/repos/qemu/tests/qemu-iotests/tests (master)> sudo filefrag /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw -e
> Filesystem type is: ef53
> File size of /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw is 20971520 (5120 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..      15:   36233216..  36233231:     16:            
>    1:       16..    2047:   36233232..  36235263:   2032:             unwritten
>    2:     2048..    2559:   36239360..  36239871:    512:   36235264:
>    3:     2560..    4095:   36239872..  36241407:   1536:             unwritten
>    4:     4096..    5119:   33792000..  33793023:   1024:   36241408: last,unwritten,eof
> /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw: 3 extents found

Note that one of the offsets is not 4KiB-aligned:
> 36239360%4096
> 2048

I suppose that is the reason?

> [I] febner@dev8 ~/repos/qemu/tests/qemu-iotests/tests (master)> stat /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw
>   File: /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw
>   Size: 20971520  	Blocks: 40968      IO Block: 4096   regular file
> Device: 8,16	Inode: 4866541     Links: 1
> Access: (0644/-rw-r--r--)  Uid: ( 1000/  febner)   Gid: ( 1000/  febner)
> Access: 2025-05-21 11:18:37.622692254 +0200
> Modify: 2025-05-21 11:18:37.540686997 +0200
> Change: 2025-05-21 11:18:37.540686997 +0200
>  Birth: 2025-05-21 11:18:37.463682059 +0200

I also tried it on my host, where the filesystem is ZFS using
compression, and there, 'du' will already report a lower value after
creating the image, because of compression. And even without compression
it seems that preallocation=full on ZFS is somehow async :/

> [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> qemu-img create my.raw 20M -f raw -o preallocation=full
> Formatting 'my.raw', fmt=raw size=20971520 preallocation=full
> [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> du --block-size=1 my.raw
> 512	my.raw
> [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> du --block-size=1 my.raw
> 20980224	my.raw

Best Regards,
Fiona


