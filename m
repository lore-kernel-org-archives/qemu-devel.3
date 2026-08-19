Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B896BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwiA1-0005yG-O7; Wed, 19 Aug 2026 11:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwi9u-0005uh-6N; Wed, 19 Aug 2026 11:24:54 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwi9r-0005lK-By; Wed, 19 Aug 2026 11:24:52 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E7F6D434A1;
 Wed, 19 Aug 2026 15:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B611F000E9;
 Wed, 19 Aug 2026 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787153081;
 bh=IREy8EB96C1MiD0mEG/d5BXVokkM1ryvcxBbR+GIu9o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Eg0quPQh4YGGkMrExTswW6zAFvK0XnaOo6zb6DbP0X3FcwQfMvgQNl/PA5W7SaFy4
 QEJRKoHVcMvT87KrtYAYVTW4MvCAPoOjG4B20WlGqsCMQF6z/pFJ0g0069YAE7maU8
 65QQ0yvdNumv2o3NbKdqPnc6bH8IVGfJ0FhywTfJt7Rjzsaj4HdKWS7fjEU3z7vGvP
 TfE23y9pIIxxYTgEoy0p6VT7JGplMhogccAOvcsNu9tr2MmPyKAlQnzbFNN2NQJJBR
 freVDSgbQT4Woq3XeyjeZH2aFFg8fGbm7YXmMnL+xEwd2NaLsI35b9lKgy1+rTFd7E
 me4gNX0JgBtKA==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Wed, 19 Aug 2026 17:24:03 +0200
Subject: [PATCH v2 1/7] dma-helpers: fix unaligned discard_back
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-align-nvme-mdts-with-linux-v2-1-351ac2dfed64@samsung.com>
References: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
In-Reply-To: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Daniel Gomez <da.gomez@kernel.org>, 
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787153075; l=1921;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=/MZTHLfOR6cSdrgu2MY61TXisIENUG7f98Jkjp3D4Yc=;
 b=8kQ6hcBxhkTrVCm0N0ipJoGzkIZ2FonDhBEOQZXjh5wN0cpHxaqiMooAIA3ERWO7OMdN7yBlm
 DRsRYPp4IfbCfn1vEJ7fbSdjXT3Bv/Z9FhYNngQPWvkkt4dSJr16Xuj
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=172.234.252.31; envelope-from=da.gomez@kernel.org;
 helo=sea.source.kernel.org
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

From: Daniel Gomez <da.gomez@samsung.com>

Commit 99868af3d0 ("dma-helpers: explicitly pass alignment into DMA
helpers") replaced the sub-sector remainder with the aligned size as the
amount passed to qemu_iovec_discard_back(), effectively discarding the
wrong chunk. Go back to discarding the tail bytes of unaligned IO.

It was found while chunking dma_blk_cb() at IOV_MAX to batch large IO:
a chunk boundary that is not a multiple of the alignment lands here and
dma_blk_cb() submits the wrong bytes.

Reproducer (with dma_blk_cb() chunked at IOV_MAX and mdts >= 10):
fio --name=demo --filename=/dev/nvme0n1 --rw=write --bs=8M --direct=1 \
    --iomem_align=4 --size=64M --verify=crc32c --do_verify=1

Logs:
demo: (g=0): rw=write, bs=(R) 8192KiB-8192KiB, (W) 8192KiB-8192KiB, (T) 8192KiB-8192KiB, ioengine=psync, iodepth=1
fio-3.41
Starting 1 process
crc32c: verify failed at file /dev/nvme0n1 offset 0, length 8388608 (requested block: offset=0, length=8388608, flags=88)
       Expected CRC: db932ec1
       Received CRC: d3b6f2dc
fio: pid=2755, err=84/file:io_u.c:2280, func=io_u_sync_complete, error=Invalid or incomplete multibyte or wide character

Fixes: 99868af3d0 ("dma-helpers: explicitly pass alignment into DMA helpers")
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 system/dma-helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 0d592f64680..8ee83ce9e75 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -174,8 +174,7 @@ static void dma_blk_cb(void *opaque, int ret)
     }
 
     if (!QEMU_IS_ALIGNED(dbs->iov.size, dbs->align)) {
-        qemu_iovec_discard_back(&dbs->iov,
-                                QEMU_ALIGN_DOWN(dbs->iov.size, dbs->align));
+        qemu_iovec_discard_back(&dbs->iov, dbs->iov.size % dbs->align);
     }
 
     dbs->acb = dbs->io_func(dbs->offset, &dbs->iov,

-- 
2.55.0


