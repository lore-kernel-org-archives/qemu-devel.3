Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AE3C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwi9r-0005td-G5; Wed, 19 Aug 2026 11:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwi9q-0005t0-69; Wed, 19 Aug 2026 11:24:50 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwi9n-0005kv-Mm; Wed, 19 Aug 2026 11:24:49 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ECFD341253;
 Wed, 19 Aug 2026 15:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6010D1F000E9;
 Wed, 19 Aug 2026 15:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787153078;
 bh=TMLbcdDavsTP+oUGkwK4FxiWsKl3CBvVXOxUHoZbCIY=;
 h=From:Subject:Date:To:Cc;
 b=NHApEWEZHJ3tZlbopfVlfbXTL4NT1BFHxHWl1FsfvTrxwsMyWOgNhiLnR0TJyllGY
 jD3kLNnOkw/N/kjbmldbr9VqKabFBSKGrm1go6I+2CZHKdO/V+aqJ0hBE7hiDP5MJi
 xticwPfyEGJJqt8HoMD39mBi68GcGcK0ChqSEJHq0UdkGQSExJDG67WKLpyeT5r8OO
 bJDTlRtXduE33ZFvlBKxH6zdOZPQ7AEaZsI/s8bNKdFxSAsC+kx1bHxWQFDaiJLpjt
 9XRCQmZzqAJpxiQJKctS5tbHyEe2FffUH52K8UdkOUpA2468fcnaaK2mJQx2wkZVXk
 aniuRkROC3+UA==
From: Daniel Gomez <da.gomez@kernel.org>
Subject: [PATCH v2 0/7] hw/nvme: lift IOV_MAX limit in DMA path
Date: Wed, 19 Aug 2026 17:24:02 +0200
Message-Id: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBCF4auQWTumLVjQlfcwLAotMAktpoWKI
 dzdSuLW5f8W39sgGE8mwC3bwJtIgSaXQpwyaAfleoOkU4NgQrKLqFCN1Dt00Rq0eg74onnAkdy
 yoiy15FUny5w1kICnNx2tB/6oUw8U5sm/j6/Iv+uPvf5jI0eGQnBdaMFVU+T3oGxYXH9uJwv1v
 u8fBoSK4sYAAAA=
X-Change-ID: 20260528-align-nvme-mdts-with-linux-67d618f6730b
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Daniel Gomez <da.gomez@kernel.org>, 
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787153075; l=3347;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=rxvqR3RBdvBpTNj+iPebSuXyoZA9b5a2tK0dISHPWu8=;
 b=uM8CC1ax/n9/RLw6TPwra1ndIiv/YATKkARHT1oaRv6QLLtaJnLw+dPrc331N+nm8z5n3lGhq
 dY9o7uTXVVKCcRjlKITl2+6PHhDZ0L2MIME4QYUYjsStOohhvAmULpN
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

 hw/nvme/ctrl.c       | 21 +++++++++++++--------
 system/dma-helpers.c | 19 ++++++++++++++++---
 2 files changed, 29 insertions(+), 11 deletions(-)
---
base-commit: 7a34f7b8794b29cd1bd4dfa45f7d8e8daba7cff5
change-id: 20260528-align-nvme-mdts-with-linux-67d618f6730b

Best regards,
--  
Daniel Gomez <da.gomez@samsung.com>


