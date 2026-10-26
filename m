Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1371606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxYMK84Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHgv-00068x-8R; Mon, 26 Oct 2026 06:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHgs-00068F-30; Mon, 26 Oct 2026 06:12:31 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHgq-0001Mg-Dt; Mon, 26 Oct 2026 06:12:29 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FEF7602C4;
 Mon, 26 Oct 2026 10:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEA91F01825;
 Mon, 26 Oct 2026 10:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793009547;
 bh=KGWtwz3xC8u90JIVdlolK6lg7fvk5s3vGz5DOClx6uI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TxYMK84YFZMuoGGIP4nEotOdjW9dAsAzVsfolNydw59WHEcE3FQokBgVDMQ3e0PRb
 J+fth7zgPvGoGQyTMfC8AoLdu+fNU+/1toYDbD/WgMHd+LmfSTJSvPBiApZLCSpdFN
 P/5pxgnVF2V6NwPM1SZGjmbKdeJMvHEYmiuk7jWxTv6u/YYg9aRY0uW6Uodx8qqaLx
 vcI5HJa1LptpZdWpjD6w4Uc6SqVndc1ANRQxyUzpzNt8cMYezMkCzEXiC54LzEx17S
 SYFPviQgm5XgbHkJp4bYgmExsh3ezNwqIddMkkSOEQxRSd35uPwAxXmvCVJW2GqQ57
 lcEPaIxzwfdSQ==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Mon, 26 Oct 2026 11:11:11 +0100
Subject: [PATCH RESEND v3 3/7] dma-helpers: cap iovec allocation at IOV_MAX
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-align-nvme-mdts-with-linux-v3-3-a33bd7c32df9@samsung.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793009536; l=1024;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=x6u5bggiiKR7mJohXkrnb5pJYR2J7BbeZstV+6BXxd0=;
 b=jrGP+3PYc8AV9TN9VZX3PQoqNVgPF8amllggvOV7BDfj3OVPbQqceerpmZg0hkoOHLfHs/KBA
 lUKgCcJ8ZYkDvTXP7E4a/gUofuYAmn0Za7Veh/QMfMJWU/xElcD5elr
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
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
2.56.0


