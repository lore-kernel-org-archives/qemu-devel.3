Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5019606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=KJl3ZZnd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp64-0002Tl-RI; Fri, 27 Nov 2026 01:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp4o-0007LU-MG; Fri, 27 Nov 2026 01:04:59 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp4k-0003fK-W8; Fri, 27 Nov 2026 01:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759043; bh=WZcsg3T7gV+o6mRcxoPMcAb+8k9V20LeO/2QSZBGzc0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KJl3ZZnd7gwd6Qdr5IrM+hEZI1LmclhiWTjrCkDxP12klWnp1cOxpldBlPVqdPRW/
 kiEeCMNr2v/nfM8XAQ4QkwBf/7VbO4EsQMucG8YUBuwHdBPNyaAeZgti/ZqOX2XAJ8
 lN97Am1ymeR4AaN7BxzP9KfaZzRKgv8a1yBZ4toUcxQ6GXmpL+rRpeakwjdD+SYOa2
 iQE7CRv0XEQ7ru/St4b+szRQhXE0e5Q+hp1v2XqVhpOTVaO46r5FSz4gTyYmA597OH
 lXYWd/SeMtJlkHH2cZaA7vD/AWEczd7YTbDDHJV6m34RJ8jGio67FVT8+zuX/lRGO5
 u3A1JDR6us4Tw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B0BCD1EA348;
 Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AE757469973;
 Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9CDC8CF2DE; Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Markku=20Ahvenj=C3=A4rvi?= <mankku@gmail.com>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 086/152] hw/nvme: clear interrupts on controller
 reset
Date: Fri, 27 Nov 2026 08:53:44 +0300
Message-ID: <20261127055709.39630-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Markku Ahvenjärvi <mankku@gmail.com>

Clear stale CQ interrupt state and ensure the interrupt line is
deasserted when resetting an NVMe controller.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4142
Fixes: 83d7ed5c570d ("hw/nvme: fix pin-based interrupt behavior (again)")
Signed-off-by: Markku Ahvenjärvi <mankku@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit ada720d1e8b74f7570d2a3a4052296a4ee234675)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 6baaae7f9f3..45aacf81467 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8106,6 +8106,10 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
     stl_le_p(&n->bar.intmc, 0);
     stl_le_p(&n->bar.cc, 0);
 
+    n->cq_pending = 0;
+    n->irq_status = 0;
+    nvme_irq_check(n);
+
     n->dbbuf_dbs = 0;
     n->dbbuf_eis = 0;
     n->dbbuf_enabled = false;
-- 
2.47.3


