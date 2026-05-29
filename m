Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC81CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwSI-0006S6-T6; Fri, 29 May 2026 08:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wSwSG-0006RY-FY; Fri, 29 May 2026 08:36:48 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wSwSE-0002tR-Q4; Fri, 29 May 2026 08:36:48 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7C7E6059D;
 Fri, 29 May 2026 12:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE841F00898;
 Fri, 29 May 2026 12:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780058204;
 bh=WQz4JUNQBgR2v4OWJ/FkcnTnXqaW5HNRpJvgw36RX6Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MolJnqNDSTeLTvxvMO5wD8Xb0CjG27eNqy8ckcZ+Q5B0VqIUnXrT5/4nbEyv1xyhA
 A2yV6uHDNJ5DHJrI6qJwyA3R4kcu09gh+qXUunBWTo6TzMihsP1CFPAC44Gq73Db5m
 KVD9xBu3lAha2/jVaJ4o/uDH1weig2iX0/dAqgXktJTOUXkRp0d8A5ruTDWwENeyUD
 ME4JKXOdAcCvkRhGWUWt/gWQKTolHceS89lz1UScklcZKmYnSDLlv6a8ehTDV28LhE
 8uuSb1YdOoZlzwQNXLrit6HRhnJQSDh0QTpIo0lpkft3YjUCE+HQ3+H7o9sLUTPmRH
 T14Y71ywBenlA==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Fri, 29 May 2026 14:36:13 +0200
Subject: [PATCH 1/3] dma-helpers: chunk dma_blk_cb at IOV_MAX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-align-nvme-mdts-with-linux-v1-1-221d4d21ab43@samsung.com>
References: <20260529-align-nvme-mdts-with-linux-v1-0-221d4d21ab43@samsung.com>
In-Reply-To: <20260529-align-nvme-mdts-with-linux-v1-0-221d4d21ab43@samsung.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780058199; l=1096;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=i+thYfVMMwlOjiW9+ImbKV4xHn4qvhdkMyleLRHLwU0=;
 b=6cGuoBEpTGoD9x7hW4KRX2saeYNTxf5nEhu2+VD141ubAhlDMlifDCTFzEpvPLiqOE0tdboNj
 vEn2twVSvKvAn0p2RtR9rGzQdPXvdpKPHI56tm7EUoBnwYFxLPxbDdg
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
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

From: Daniel Gomez <da.gomez@samsung.com>

dma_blk_cb() submits dbs->iov to io_func() in one shot, so callers
must keep dbs->iov.niov below IOV_MAX or the host preadv()/pwritev()
rejects the call.

Break the accumulation loop when niov reaches IOV_MAX. The existing
re-entry path resumes mapping and submits a follow-up chunk under
the same AIOCB, so callers no longer carry that constraint.

Suggested-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 system/dma-helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 0d592f64680..c7c0d7aa1b5 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -156,8 +156,9 @@ static void dma_blk_cb(void *opaque, int ret)
                 }
             }
         }
-        if (!mem)
+        if (!mem || dbs->iov.niov >= IOV_MAX) {
             break;
+        }
         qemu_iovec_add(&dbs->iov, mem, cur_len);
         dbs->sg_cur_byte += cur_len;
         if (dbs->sg_cur_byte == dbs->sg->sg[dbs->sg_cur_index].len) {

-- 
2.53.0


