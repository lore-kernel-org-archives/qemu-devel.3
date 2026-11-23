Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2B1606A332
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9U+BNgX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXjx-00062H-0n; Mon, 23 Nov 2026 12:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXju-00061B-Rh
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:02 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXjt-0002kL-8p
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:02 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB169455CC;
 Mon, 23 Nov 2026 17:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5E01F000E0;
 Mon, 23 Nov 2026 17:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795454518;
 bh=UB4oZdQd5la14G958Y2pmIyj5D5jzHVPhjm2HWLVvRo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=i9U+BNgXnxmUVp+60nDYmvEWV1q+FyXFrJBZveCwMIH5TMe/e4M2vy28rlU6vY5EK
 vsNZsk9EuqhWj1xO+1zMu+xPzSPWeZeRzCost7rvbfxpfEXqKugZNErXotSZJcMlhA
 UtfQmmcugZMiXoBuvubeJnbP8Q5w6WysZXBUkgJPm8cMsmEW5K6yK0t5bKGiJM/IVK
 TxnMdDkLL6LwGgS5kcmBcSJucFvZbbt516dyg6dqbeqQCtBMjRJMzhgyU/guYxztNp
 5LR2B8strlJWW3F5aCg+t9VGunRWgKvFCs0r1MrDdD1rXuO14xtpBf1ipZmT93bM4C
 yW0oyQu+m9TkQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 01/14] hw/scsi/ncr53c710: Cancel the in-flight request on soft
 reset
Date: Mon, 23 Nov 2026 18:21:38 +0100
Message-ID: <20261123172151.7605-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123172151.7605-1-deller@kernel.org>
References: <20261123172151.7605-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

ncr710_soft_reset() drops s->current and clears the request's
hba_private without telling the SCSI layer. The request stays queued on
the device and, once it completes or asks for data, the HBA callbacks
find a NULL hba_private (ncr710_transfer_data() asserts on it).

Cancel the request first. scsi_req_cancel() invokes
ncr710_request_cancelled(), which releases the NCR710Request and the
HBA's reference on the request; ncr710_clear_pending_irq() then finds
s->current already NULL and has nothing left to do. If the request is
not enqueued, scsi_req_cancel() does nothing and the previous behaviour
is kept.

AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 57967e7a84..10daa66e84 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -364,6 +364,10 @@ void ncr710_soft_reset(NCR710State *s)
     s->sidl = 0;
     s->sfbr = 0;
     qemu_set_irq(s->irq, 0);
+    if (s->current && s->current->req) {
+        /* Drops hba_private via ncr710_request_cancelled() */
+        scsi_req_cancel(s->current->req);
+    }
     ncr710_clear_pending_irq(s);
     ncr710_scsi_fifo_init(&s->scsi_fifo);
 }
-- 
2.54.0


