Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8B3C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NBr-000681-I7; Wed, 09 Sep 2026 14:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NBo-00066W-Pw; Wed, 09 Sep 2026 14:38:32 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NBm-00071Y-1X; Wed, 09 Sep 2026 14:38:32 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26C34600CB;
 Wed,  9 Sep 2026 18:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC601F000FF;
 Wed,  9 Sep 2026 18:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788979108;
 bh=ex788BieU15UIgGrxotsclRXJlLNkO5kYkezLjTWSYo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=K5eXFU2fF+UB6ZsZmFQZk0VcakT3/aiPQSJha/q5Y9KFuJNIG7FAoVwn3zZUG4rfL
 UGhr5XM81gHhgDoqA9JgzISrPedIn14MixuBn1nAIe0yLxwxRyn8v9sKfM5wPh2ICR
 ZZ4GARKWOrixZN9zRr/K0Rrv69clmLWS8NZRRtY+NnKmC8mjSFVMQ3h4xjQWlBrVsz
 /Lb00Bvd/0cahOkOejdZV0hjM2NCxNoZAP2BIEiRDmzIouovzEgyk9OXn5Sq+7/x+L
 iNCQYNdge8WdAz950hveCiA1UVp/5JZRjAjBXOJsqAtXkc9SgnasokrkFoaPKOyCuk
 RhNYrjArmTKkA==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Wed, 09 Sep 2026 20:36:52 +0200
Subject: [PATCH v3 3/7] dma-helpers: cap iovec allocation at IOV_MAX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-align-nvme-mdts-with-linux-v3-3-1cee970cc8c8@samsung.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788979097; l=1024;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=ghcHKmlCHO13Hcl8xPIIL+bQAT/yi3JzQScu8ZdCfnI=;
 b=BwC0JGtJjhVcM81Z/m573Y5tSMn9ax/S42foR0ZzaZvbcpRE/Ln5+NGjREneBOJ9lb//FRNIa
 9CpAICkKk1XAFLaJjIb6ltgQ1mqrt2Tai3zZtPftVudEDjNzqKT0vYa
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

From: Daniel Gomez <da.gomez@samsung.com>

Cap the initial iovec allocation at IOV_MAX instead of sizing it for the
whole sg list, which over-allocates for large IO where the number of sg
entries exceeds IOV_MAX.

This is preparatory work for chunking dma_blk_cb() at IOV_MAX to batch
large IO: once chunked, dbs->iov never holds more than IOV_MAX iovecs.

Acked-by: Jesper Wendel Devantier <foss@defmacro.it>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 system/dma-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 9004ad50ae3..d4fd33a3d4c 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -242,7 +242,7 @@ BlockAIOCB *dma_blk_io(
     dbs->io_func = io_func;
     dbs->io_func_opaque = io_func_opaque;
     dbs->bh = NULL;
-    qemu_iovec_init(&dbs->iov, sg->nsg);
+    qemu_iovec_init(&dbs->iov, MIN(sg->nsg, IOV_MAX));
     dma_blk_cb(dbs, 0);
     return &dbs->common;
 }

-- 
2.55.0


