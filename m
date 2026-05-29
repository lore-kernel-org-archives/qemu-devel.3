Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D316CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwSI-0006Rl-3U; Fri, 29 May 2026 08:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wSwSF-0006RN-TN; Fri, 29 May 2026 08:36:47 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wSwSE-0002ss-43; Fri, 29 May 2026 08:36:47 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 42F386059A;
 Fri, 29 May 2026 12:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA01B1F00893;
 Fri, 29 May 2026 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780058202;
 bh=23RJfZVgVB0pedU3NEIWH1sI8sC9rSX3P67UaCsmimU=;
 h=From:Subject:Date:To:Cc;
 b=QSpXHeKVnTChALPRfRKQ1Pqu52u1AIwx0d0f43bOQkAU8eCYl+tCoA0qCiFK5ZviQ
 Hxt0XPyDyi8BcIMo4eksLY4XvbQz/maCkcPWlgLSZu0NbuWVtXEskma+Qo4tz0dSHq
 3qUiJbQVjE8iiqIMJz3sKdrly48rM0otuQYFzPCgv5tbQ5fiasxJShvR6ytNxLmd/l
 8/S/j+cfp2AG9oKbAF0RBDZA1ednBcAI79wQSKiyOtREYpksglty2ja1JEbrAekLSE
 eIG2gNSx4XvOTTkJ0ED27YtRRUFihbYh33VM8TFm2LiLxRJzArtMAy5hgJ6nYB5c7s
 bjJnYAbutU7iQ==
From: Daniel Gomez <da.gomez@kernel.org>
Subject: [PATCH 0/3] hw/nvme: lift IOV_MAX limit in DMA path
Date: Fri, 29 May 2026 14:36:12 +0200
Message-Id: <20260529-align-nvme-mdts-with-linux-v1-0-221d4d21ab43@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSw5AMBAA0KvIrE1SFSWuIhalg0kY0vol4u4ay
 7d5DwTyTAHq5AFPJwdeJSJLE+gnKyMhu2jQShtV6ArtzKOgnAvh4vaAF+8TzizHjaZ0JqsGU+a
 qgxhsnga+/7xp3/cDM78XBmwAAAA=
X-Change-ID: 20260528-align-nvme-mdts-with-linux-67d618f6730b
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780058199; l=6078;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=ShEd9SP0MkzMuhcrfLpwslikd7ntVj55Xcmors1nQvI=;
 b=FsBc458V220LggO5CWREv/pUwHm0p79KBX6b2t97EgDBVmhWwL2pElCWoW5GKCQXlTltn1EL8
 evsajXxxA1xDpxtfKEFiS+ewIT8EJk4glKYo79FfIuaVSmv7tN4FrmA
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=172.105.4.254; envelope-from=da.gomez@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Raise the QEMU NVMe controller's MDTS limit from 9 (2 MiB) to 11 (8 MiB)
to match the Linux host driver's NVME_MAX_BYTES.

Commit 53493c1f83 ("hw/nvme: cap MDTS value for internal limitation")
needed the 2 MiB cap because dma_blk_io() submitted the full sglist
in one preadv()/pwritev() call, which the host kernel rejects when the
iovec count exceeds IOV_MAX. This series moves the IOV_MAX bound down to
dma_blk_cb(), where we batch in IOV_MAX chunks when necessary.

dma_blk_cb() now breaks its accumulation at IOV_MAX and submits the
next chunk via the existing re-entry path. With that the DMA-path
nvme_map_addr() guard is removed, MDTS moves to 11 via a new
NVME_MDTS_MAX, and mdts=0 is coerced to the same limit: Linux's host
driver clamps at NVME_MAX_BYTES = 8 MiB regardless of MDTS, so honoring
"unlimited" buys nothing.

Verification with blkalgn and fio:

fio \
    --name=mdts-stress \
    --filename=/mnt/mdts/stress.fio \
    --rw=randwrite \
    --bs=8M \
    --ioengine=psync \
    --direct=0 \
    --numjobs=8 \
    --time_based \
    --runtime=600 \
    --fsync=8 \
    --end_fsync=1 \
    --group_reporting \
    --refill_buffers \
    --norandommap \
    --offset_align=32k

blkalgn-libbpf --disk=nvme3n1 --trace

I/O Granularity Histogram for Device nvme3n1 (lbads: 12 - 4096 bytes)
Total I/Os: 134993
     Bytes         : count    distribution
        0          : 12378    |****                                    |
        32768      : 3622     |*                                       |
        65536      : 2        |                                        |
        1048576    : 71       |                                        |
        2097152    : 827      |                                        |
        2588672    : 50       |                                        |
        3670016    : 62       |                                        |
        4194304    : 357      |                                        |
        4718592    : 62       |                                        |
        5799936    : 50       |                                        |
        6291456    : 644      |                                        |
        7340032    : 71       |                                        |
        8388608    : 116797   |****************************************|

I/O Alignment Histogram for Device nvme3n1
     Bytes               : count    distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 0        |                                        |
        16 -> 31         : 0        |                                        |
        32 -> 63         : 0        |                                        |
        64 -> 127        : 0        |                                        |
       128 -> 255        : 0        |                                        |
       256 -> 511        : 0        |                                        |
       512 -> 1023       : 12378    |**********                              |
      1024 -> 2047       : 0        |                                        |
      2048 -> 4095       : 0        |                                        |
      4096 -> 8191       : 0        |                                        |
      8192 -> 16383      : 0        |                                        |
     16384 -> 32767      : 0        |                                        |
     32768 -> 65535      : 49360    |****************************************|
     65536 -> 131071     : 2        |                                        |
    131072 -> 262143     : 0        |                                        |
    262144 -> 524287     : 0        |                                        |
    524288 -> 1048575    : 36747    |*****************************           |
   1048576 -> 2097151    : 36506    |*****************************           |

/sys/block/nvme3n1/queue/
max_segments           = 256
max_segment_size       = 4294967295
max_hw_sectors_kb      = 8192
max_sectors_kb         = 8192
virt_boundary_mask     = 0
logical_block_size     = 4096
physical_block_size    = 4096
minimum_io_size        = 4096
optimal_io_size        = 0
dma_alignment          = 3
chunk_sectors          = 0
nr_requests            = 1023

nvme id-ctrl /dev/nvme3n1
mdts      : 11
cntrltype : 1
sgls      : 0x80001

xfs_info /mnt/mdts
meta-data=/dev/nvme3n1           isize=512    agcount=4, agsize=163840 blks
         =                       sectsz=32768 attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=1
         =                       exchange=0   metadir=0
data     =                       bsize=32768  blocks=655360, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=32768  ascii-ci=0, ftype=1, parent=0
log      =internal log           bsize=32768  blocks=5446, version=2
         =                       sectsz=32768 sunit=1 blks, lazy-count=1
realtime =none                   extsz=32768  blocks=0, rtextents=0
         =                       rgcount=0    rgsize=0 extents
         =                       zoned=0      start=0 reserved=0

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
Daniel Gomez (3):
      dma-helpers: chunk dma_blk_cb at IOV_MAX
      hw/nvme: drop DMA-path IOV_MAX guard
      hw/nvme: allow mdts up to 8192 KiB

 hw/nvme/ctrl.c       | 15 +++++++++------
 system/dma-helpers.c |  3 ++-
 2 files changed, 11 insertions(+), 7 deletions(-)
---
base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
change-id: 20260528-align-nvme-mdts-with-linux-67d618f6730b

Best regards,
--  
Daniel Gomez <da.gomez@samsung.com>


