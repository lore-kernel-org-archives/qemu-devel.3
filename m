Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F17C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwiA2-0005yr-Vc; Wed, 19 Aug 2026 11:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwi9w-0005v8-A0; Wed, 19 Aug 2026 11:24:57 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwi9s-0005mb-35; Wed, 19 Aug 2026 11:24:54 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0305E60DC0;
 Wed, 19 Aug 2026 15:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A171F000E9;
 Wed, 19 Aug 2026 15:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787153090;
 bh=GAblJtoF1ite2nCaZlx6g3pEY9g6y0mrLZhXuRuNLnA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cCUtwdV+iF4zexxzawMydBF/OdtWEPkwuC5O+zMOsij5sn6LcON20ghGPZHxa3eTU
 9XVc/v4mw10WC8e1nP7SlzrQSfpE9Czi5befPlNBNCmg4j48hFzGdaIOtLapICC08H
 sAgHZWfO2wTSauC3ImrYOv57cMCyC+XJsGlY/2CgAdHQRA9d2G+b1xKl5/YW0quD0g
 yMyhiJOM/6z2rRugOXtC62Fl5a37ECIYwPozbu8kdwnRVrrxSAz+Gr4JgsUAZfRNjY
 yG5r4+Vr2l1dU7WtVNYpFSKb/U3IDGX+BR1DIAnnwT2EkX5tdeVyx7kplmLuTv8Xw+
 3ae5/1gXgd6bA==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Wed, 19 Aug 2026 17:24:06 +0200
Subject: [PATCH v2 4/7] dma-helpers: chunk dma_blk_cb at IOV_MAX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-align-nvme-mdts-with-linux-v2-4-351ac2dfed64@samsung.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787153075; l=969;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=PlgFs9C/2C5N/Yk2iUBNUFtNgCYAxRiq7T7jRH6XWbg=;
 b=A59Ufv+0QaSmycUHol4UBil+QOn+nexDIQr3jY7NN8mny9aQ2/grsRjRxcdZQQ5s+WBnFXHio
 ef+gsJkmqNjAGHyCyGEHiqJCEEepF8adoVc2t5nlbFgsIBpn4nVXLxP
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

dma_blk_cb() submits dbs->iov to io_func() in one shot, so callers
must keep dbs->iov.niov below IOV_MAX or the host preadv()/pwritev()
rejects the call.

Break the accumulation loop when niov reaches IOV_MAX. The existing
re-entry path resumes mapping and submits a follow-up chunk under
the same AIOCB, so callers no longer carry that constraint.

Suggested-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 system/dma-helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index d4fd33a3d4c..613fa548669 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -175,6 +175,9 @@ static void dma_blk_cb(void *opaque, int ret)
             dbs->sg_cur_byte = 0;
             ++dbs->sg_cur_index;
         }
+        if (dbs->iov.niov >= IOV_MAX) {
+            break;
+        }
     }
 
     if (dbs->iov.size == 0) {

-- 
2.55.0


