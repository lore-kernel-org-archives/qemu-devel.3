Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0E5C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwiA0-0005wF-0m; Wed, 19 Aug 2026 11:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwi9r-0005tk-Iz; Wed, 19 Aug 2026 11:24:51 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwi9o-0005lg-1r; Wed, 19 Aug 2026 11:24:50 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 08CD960A92;
 Wed, 19 Aug 2026 15:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495FC1F000E9;
 Wed, 19 Aug 2026 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787153084;
 bh=mzD3z/pk9Zs6BYJt8B/2je9gOLBN9kfdU7oHdLKxVBU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iu35lgsthINtwTrVbGZYww4a0X+zwxovQdMgY3mzQnZ6dri8X48hoM/crQlo/XNYn
 MdI7/Jj48kpp9vJnWUfR79XjjpdMvuNHyy+ZKULCcXXJSTdUZcdj89nrXfKfNpTDpz
 wxDerlF8X6lcoIoYx4aSXDtMe7se1+mets5j/XVS1uLHc1Mr8wzQld/6MxUICtL+uN
 1Kf7io8Q0tLaAhQphpF/BbSYC8jpWWYdbWcUAM1x/sjCc2DruT1/fDaKZ1nsejacXA
 +FSgXnUtiO8O7Z0sljPnzxXADprBYd/Ln1e3Tvq5ptfdFisWMnSt5fSFkPC+66Wj0W
 lm8MWb1sqECXQ==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Wed, 19 Aug 2026 17:24:04 +0200
Subject: [PATCH v2 2/7] dma-helpers: ensure IOV_MAX chunks end aligned
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-align-nvme-mdts-with-linux-v2-2-351ac2dfed64@samsung.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787153075; l=1682;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=0ojqGEoe2usyhxOfOLEvmAi0XG8/nb35wK6rygUtG5I=;
 b=uWuw5nDw5p5kLE0/qRepyT2yp6XAbq/W4R+G1H8dV9d83bLduEO+9TYK+z3z7EX9YX+dR8lJn
 YNQVhlfeKRRDiP9eoU92Lh2vbkuf7DbPISjhBGfs9c7sUSB3baSQ+1e
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
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

When submitting large IO beyond IOV_MAX, ensure the last dma mapped
chunk ends on an aligned boundary and unmap the remainder so the next
chunk submission takes it. Otherwise the discard path at the end of
dma_blk_cb() drops the unaligned tail and those bytes are lost.

Reproducer: Write 8 MiB through unaligned path and read it back using
the aligned path:

fio --name=demo --filename=/dev/nvme0n1 --rw=write --bs=8M --size=8M \
    --direct=1 --iomem_align=4 --verify=crc32c

fio --name=demo --filename=/dev/nvme0n1 --rw=write --bs=8M --size=8M \
    --direct=1 --verify=crc32c --verify_only

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 system/dma-helpers.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 8ee83ce9e75..9004ad50ae3 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -158,6 +158,17 @@ static void dma_blk_cb(void *opaque, int ret)
         }
         if (!mem)
             break;
+
+        /* Ensure the last slot in the chunk ends on an aligned boundary */
+        if (dbs->iov.niov == IOV_MAX - 1) {
+            dma_addr_t aligned = QEMU_ALIGN_DOWN(dbs->iov.size + cur_len,
+                                                 dbs->align);
+            if (aligned <= dbs->iov.size) {
+                dma_memory_unmap(dbs->sg->as, mem, cur_len, dbs->dir, 0);
+                break;
+          }
+          cur_len = aligned - dbs->iov.size;
+        }
         qemu_iovec_add(&dbs->iov, mem, cur_len);
         dbs->sg_cur_byte += cur_len;
         if (dbs->sg_cur_byte == dbs->sg->sg[dbs->sg_cur_index].len) {

-- 
2.55.0


