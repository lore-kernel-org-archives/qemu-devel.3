Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E45EC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NBp-000677-MO; Wed, 09 Sep 2026 14:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NBn-00063H-J5; Wed, 09 Sep 2026 14:38:31 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NBk-000718-O4; Wed, 09 Sep 2026 14:38:31 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87F90601EF;
 Wed,  9 Sep 2026 18:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDD21F000FF;
 Wed,  9 Sep 2026 18:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788979103;
 bh=ZvJ6FrMPjn+U502lyxNDEH47T7MEXntaAjN59mhs29w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=T7yXkwe4QI8TDt0+AcJjkO4eHsClFO3JnsI+Nog9ZNgWikoMsIKkdpjIVoPqaCRg4
 mhTUdMlAZoUaGLCb5eYiONWgdR+lNfH/B24tU3uz/iiiMQsL7NkYZjcF3w0jP75FaX
 CuqSkaSNC/sT4+A0tYbDKZFZ67171i9OPGMvKWwSOBfRh0xjHVrv7Odc/h4kBXCikq
 dVFYSo5HrsU0jTTKaHZ7qnHc6YSJEFsOg6UwfYVaLk+jweIP2B29rZ5aFQaP1m6Lc3
 YvhV0OmjkzVfFepZsjrR9CWOErv/v8TvK+KF7Kl6kgSAYy0uQ5lhB+7ZxeD9Z+Rty6
 HdYCSlPr+R81A==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Wed, 09 Sep 2026 20:36:50 +0200
Subject: [PATCH v3 1/7] dma-helpers: fix unaligned discard_back
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-align-nvme-mdts-with-linux-v3-1-1cee970cc8c8@samsung.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788979097; l=1169;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=/LOqtu087vIHIonGTB284w0mpWeAIrIfgwUoZzf8bA4=;
 b=f0d5QoO0I7psSSI0PfaE1mehGMG/c8Glbbque1/INBz0PLaC2FiHVJXVa4JMpaG32pvPanCBw
 7ci309NE2bYA71exd2iPp4Dd5XHPLwhnfhfAGhxZ08EsfsMW1m4WfLP
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

Commit 99868af3d0 ("dma-helpers: explicitly pass alignment into DMA
helpers") replaced the sub-sector remainder with the aligned size as the
amount passed to qemu_iovec_discard_back(), effectively discarding the
wrong chunk. Go back to discarding the tail bytes of unaligned IO.

Fixes: 99868af3d0 ("dma-helpers: explicitly pass alignment into DMA helpers")
Acked-by: Jesper Wendel Devantier <foss@defmacro.it>
Reviewed-by: Keith Busch <kbusch@kernel.org>
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


