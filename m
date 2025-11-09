Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BA1CCF9F8
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 22:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIDYx-0007dG-Uv; Sun, 09 Nov 2025 17:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYv-0007ac-37
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:05 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYs-0005sP-Sc
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:04 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C264C60008;
 Sun,  9 Nov 2025 22:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F28DC4CEF8;
 Sun,  9 Nov 2025 22:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762726019;
 bh=FjRRjfXkVql2NimzOsvAxPczRCiES2X1ZlT8g/OPtes=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=g79Fbf9pK10YZpxp0yRqjdUmiGLfXS43ceIdgeK7AQpisuxr7sUpvDAlE07muDju/
 eBkL22bFfWbZvhel1ssNyqt2KgzktOiRnqOcmF3fMzY5GFrHQDu9LWt/yGiQSq4bvk
 kWOmDucMb3S3uTH5sVPA8ufnbtLqZCq/S2UI03d0jfvdUXJZXtKxJo/5G6yaujrwQf
 tt+AtZ2P1pJRxVf4jMM2It6CPlqqREQECsvsqja27MdHAAFX0pKJmqCA/2zq0HDkNL
 i3O5ixxFxa1Vo25nMQzWaP7+j6ZDc7bt4MYBDg2g7qu2T2RTsekinWjmd8DI1a2vue
 LcoGM1NyWiHVA==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 1/7] ncr710: Fix potential null pointer dereference
Date: Sun,  9 Nov 2025 23:06:48 +0100
Message-ID: <20251109220654.46718-2-deller@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109220654.46718-1-deller@kernel.org>
References: <20251109220654.46718-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

The code dereferences s->current before checking if it is NULL. Move the
null check before the dereference to prevent potential crashes.

This issue could occur if s->current is NULL when the function reaches
the "Host adapter (re)connected" path, though this should not normally
happen during correct operation.

Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
Reported-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Suggested-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index ade951b1d1..a35c41b67f 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -832,12 +832,11 @@ void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
     }
 
     /* Host adapter (re)connected */
-    s->current->dma_len = len;
     s->command_complete = NCR710_CMD_DATA_READY;
-
     if (!s->current) {
         return;
     }
+    s->current->dma_len = len;
 
     if (s->waiting) {
         s->scntl1 |= NCR710_SCNTL1_CON;
-- 
2.51.1


