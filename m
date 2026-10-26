Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C45606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O65qYMSd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHh0-0006BE-A6; Mon, 26 Oct 2026 06:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHgw-00069H-93; Mon, 26 Oct 2026 06:12:34 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHgu-0001MY-Pg; Mon, 26 Oct 2026 06:12:34 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB3C1601EF;
 Mon, 26 Oct 2026 10:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163E11F01825;
 Mon, 26 Oct 2026 10:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793009544;
 bh=GtaakDyqJlWcbXgiai5QigTA5HyNFHoWsNI8mFqrqM0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=O65qYMSdrTBxoXBUiKF2tabOV/dOksG6gMtuCqXH0II2sfpS+5kA60WNo2EZ8alch
 t3KvyB2Mgn8kBBEqkwTP1CHfFdpi9ldk2UfomhQHTbfvrrIwirL4vVirS/8ZgEYA4D
 8wpF87ugIRGsntAIQhqDA79dPzOYfaiDfXHnrz8DA1CQvXp6A9599Xri3xtcz4Nt7V
 4qYf68KJECfKgQdfkqHGSVi8bqWKIYbPqkmAA1gu4q9JRckkVnQWjDgJqYeXH/+nLl
 cM75zXYkoBPu9UxsRhTibgM8C9Zw6bzOCMxM4/64Kq1HzBvZ4kSpWC5vpECKNn+kUN
 C+OSz8/1v3CBA==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Mon, 26 Oct 2026 11:11:10 +0100
Subject: [PATCH RESEND v3 2/7] dma-helpers: ensure IOV_MAX chunks end aligned
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-align-nvme-mdts-with-linux-v3-2-a33bd7c32df9@samsung.com>
References: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
In-Reply-To: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Daniel Gomez <da.gomez@kernel.org>, 
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793009536; l=1728;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=7C/4NM8aAWfzvmloFVedV8cSKOIzKeiDvAVyqC/Gqxk=;
 b=PGb2OCO8fYDtSF1RvKXKvovBM9yGo6+k2D73Xd1s6BjguxGQJ7VACasBNDLyzE5JYU09BSUbc
 +r5FEV7wnOXBejaVrJX86hF6dAT3lful+StiZUWDBgozysZt2XmWtqO
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=172.105.4.254; envelope-from=da.gomez@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.56.0


