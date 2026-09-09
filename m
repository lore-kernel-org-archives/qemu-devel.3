Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AA0C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NBn-00060f-1A; Wed, 09 Sep 2026 14:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NBk-0005vI-LM; Wed, 09 Sep 2026 14:38:28 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NBe-00070l-OY; Wed, 09 Sep 2026 14:38:24 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9E27600CB;
 Wed,  9 Sep 2026 18:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF711F000FF;
 Wed,  9 Sep 2026 18:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788979100;
 bh=puURpveyZCNbH2LZQzoqthBvObvEsVxCr5WHv47U2GI=;
 h=From:Subject:Date:To:Cc;
 b=X5xcOmCIi2CwcHI12cD/rBbiKyV/ZUsDmzTSu6pWiVN0BdirsYbai2yp7hF2KbE13
 ADUzWTu5WoXQzi77kCWBTO3JMwQyrt1VgJ18maG+QKchxZLMS9nzN9xTZ6MPhS2ieq
 plrIT3kxavq0pSYB+c0N59o8KH++/Arq7QGxlqfgWgk5GXBdFJznEBzPaiI6XluM3G
 bXY5EZwTDbnpJSI9ucPN2Q0tjd47Rndon3QGbbHKe7cH4djmsTqr2Dr80cflyRfo7J
 5vZnRVS26HiT4EiiDj1ZdUO9SX0gy5SwEOgKk7yD7RJcOUwgRrEWDNAWcr1DBvsRpT
 WQaunAwMrgRZg==
From: Daniel Gomez <da.gomez@kernel.org>
Subject: [PATCH v3 0/7] hw/nvme: lift IOV_MAX limit in DMA path
Date: Wed, 09 Sep 2026 20:36:49 +0200
Message-Id: <20260909-align-nvme-mdts-with-linux-v3-0-1cee970cc8c8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBCF4auQrh1DByjoynsYF4UWmASKaaFiC
 He3kBjjhuX/Ft9bmNOWtGPXaGFWe3I0mBDJKWJVK02jgVRohjGKOMMCZEeNAeN7Db0aHbxobKE
 jM80gciV4UYs8iUsWgKfVNc07fn+EbsmNg33vX55v65e9HLGeQwyIXKUKuSzT5OZk7ybTnKuhZ
 xvs8YcV/BjDgCUZlxWqWiuR/mPrun4A3kv6fxMBAAA=
X-Change-ID: 20260528-align-nvme-mdts-with-linux-67d618f6730b
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Daniel Gomez <da.gomez@kernel.org>, 
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788979097; l=3748;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=wEt7yAnMqaB4YytOHaBGOSNAdalnkYR9aMyKOph9Y2o=;
 b=qQgVjZE5MFII0jAesjYDT6XcdZQ/A3YmOnnGtj9a9TesaiX8HuGN9+dq933J4IEC1U7dtK9ob
 txEacF1ESWjCfuQD0tjKTezARpgamUFIgtk1E9WKTa1qbz0MKIDteBs
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=172.105.4.254; envelope-from=da.gomez@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Raise the QEMU NVMe controller's MDTS beyond the 2 MiB cap.

Commit 53493c1f83 ("hw/nvme: cap MDTS value for internal limitation")
needed the 2 MiB cap because dma_blk_io() submitted the full sglist
in one preadv()/pwritev() call, which the host kernel rejects when the
iovec count exceeds IOV_MAX. This series moves the IOV_MAX bound down to
dma_blk_cb(), where we batch in IOV_MAX chunks when necessary.

dma_blk_cb() now breaks its accumulation at IOV_MAX and submits the
next chunk via the existing re-entry path. With that the DMA-path
nvme_map_addr() guard and the MDTS cap are removed. The cap stays only
for CMB/PMR, whose transfers go through a different path and are still
bounded by IOV_MAX.

This series builds cleanly under ubsan with large mdts and passes the
following fio tests on a 4k LBA QEMU NVMe device:

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

fio --name=demo --filename=/dev/nvme0n1 \
    --rw=write --bs=8M --size=8M --direct=1 \
    --iomem_align=4 --verify=crc32c --do_verify=0

fio --name=demo --filename=/dev/nvme0n1 \
    --rw=write --bs=8M --size=8M --direct=1 \
    --verify=crc32c --verify_only

---
Changes in v3:
- Apply review/ack trailers from Keith and Jesper
- Drop reproducer in commit message from patch 1 as unrelated
- Apply nvme_mdts_max_iovs() helper from Jesper
- Use params local instead of n->params in CMB/PMR check.
- Update commit message from last patch
- Link to v2: https://lore.kernel.org/qemu-devel/20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com

Changes in v2:
- Update cover letter.
- Rebase on top of nvme.next branch, tree:
https://gitlab.com/birkelund/qemu
- Keep the 2 MiB mdts cap for CMB/PMR configurations (Klaus)
- Fix the `mem` leak reported by Keith
- Drop NVME_MDTS_MAX, ie. unlimited mdts as long as Linux host supports
it.
Allowing larger mdts, also meant we needed to:
- Clamp the mdts and zasl shifts to stay within uint64_t
- Cap qemu_iovec_init() to IOV_MAX when the sg list is large
- Keep IO chunks aligned when chunking at IOV_MAX
- Fix the wrong bytes being discarded in the discard path
- Link to v1: https://lore.kernel.org/qemu-devel/20260529-align-nvme-mdts-with-linux-v1-0-221d4d21ab43@samsung.com

To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Klaus Jensen <its@irrelevant.dk>
Cc: Klaus Jensen <k.jensen@samsung.com>
Cc: Jesper Devantier <foss@defmacro.it>
Cc: qemu-block@nongnu.org
Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: Daniel Gomez <da.gomez@samsung.com>
Cc: GOST <gost.dev@samsung.com>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>

---
Daniel Gomez (7):
      dma-helpers: fix unaligned discard_back
      dma-helpers: ensure IOV_MAX chunks end aligned
      dma-helpers: cap iovec allocation at IOV_MAX
      dma-helpers: chunk dma_blk_cb at IOV_MAX
      hw/nvme: clamp mdts and zasl shifts
      hw/nvme: drop DMA-path IOV_MAX guard
      hw/nvme: cap mdts for CMB/PMR-only

 hw/nvme/ctrl.c       | 25 +++++++++++++++++--------
 system/dma-helpers.c | 19 ++++++++++++++++---
 2 files changed, 33 insertions(+), 11 deletions(-)
---
base-commit: 7a34f7b8794b29cd1bd4dfa45f7d8e8daba7cff5
change-id: 20260528-align-nvme-mdts-with-linux-67d618f6730b

Best regards,
--  
Daniel Gomez <da.gomez@samsung.com>


