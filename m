Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9631C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NBq-00067C-2h; Wed, 09 Sep 2026 14:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NBn-00063n-Li; Wed, 09 Sep 2026 14:38:31 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NBk-00071H-PY; Wed, 09 Sep 2026 14:38:31 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 55602601F0;
 Wed,  9 Sep 2026 18:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0451F000FF;
 Wed,  9 Sep 2026 18:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788979106;
 bh=fY7VhNjS+YS66fqCEYppapw54Dwmf31D2fpqlwzq12w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iyvwwa13Ae+wfZ8j46v5T3xva4NLDFvetHCdZoTxmCItSgL2MOUw6RND2aFkTdmae
 dhlJj3QZMsRFEyeB0OGGdNi9xCrBdKPEsAr3jTu0yRpZSOYJ8byvjnXZI6d91O9uYJ
 324A5lzgGG6qZ5++1i6CL3c2oJGVy28bun7qFKDH6Ds58FngPIJlKNKaP/+pdcOYSu
 19tCKO2juXQP2L6R3USkLdx7vKoHLLdnAT07OMx8NDmRuWz+7AKgaqUEqKIqFHdEok
 4al2GPr6217hD8lVkd75Bk1flyWO9n2Ak5LLpZotXitoy0tlb6S4UDeNN8eTeU6I09
 gVHvCfxtq0e4w==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Wed, 09 Sep 2026 20:36:51 +0200
Subject: [PATCH v3 2/7] dma-helpers: ensure IOV_MAX chunks end aligned
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-align-nvme-mdts-with-linux-v3-2-1cee970cc8c8@samsung.com>
References: <20260909-align-nvme-mdts-with-linux-v3-0-1cee970cc8c8@samsung.com>
In-Reply-To: <20260909-align-nvme-mdts-with-linux-v3-0-1cee970cc8c8@samsung.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Daniel Gomez <da.gomez@kernel.org>, 
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788979097; l=1728;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=MqX1Q8SVcAFaPh9zrzIYsRFs+ouywqJFwg4bJ9LZBzQ=;
 b=bXVKtQqPGkZLJThFpOAd6XVvcm15mRUgHaTU2pR53vKPF2j68PepJEkXz8I2D9buv3Mg3HvDv
 WJfO/ffRnxsAlx6m78s5zipX/W3bIw/FVRq0fBNRnxmHy9qCngS35mP
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
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

Reviewed-by: Keith Busch <kbusch@kernel.org>
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


