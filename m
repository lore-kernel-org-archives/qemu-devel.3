Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C39AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvD4d-00059S-Gr; Fri, 12 Apr 2024 05:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sf@sfritsch.de>) id 1rvBwD-0006Ah-PG
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 04:07:11 -0400
Received: from manul.sfritsch.de ([2a01:4f8:262:44c1:112::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sf@sfritsch.de>) id 1rvBwA-0004z3-P6
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 04:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sfritsch.de
 ; s=rsa-1;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:From:Reply-To:Subject:Content-Type:Content-ID:Content-Description:
 In-Reply-To:References:X-Debbugs-Cc;
 bh=IZhTvU1TRRoPdACQE+iV/SSJmbrlIalWzaEBCFoTG8M=; t=1712909224; x=1713773224; 
 b=ubwIvAaloy6swlzOEWGPPHlyPaJo6dg7haQt11BTTb7NEmDSpydu9mSD+AjELBjpOjUnH4T59hc
 3VEct5kz+PQBToGDA6OZX3mLBxXQuwdmF4F7qJw56BIYOSwwyYJhYMb/LIsJKNAz85pf198CjfQHl
 9UBykH211ja2qaF1YOyNUfz8b+vP3SS0b0e1XQaIjmE9L8kv3FB4rFyw2cclA7rxlpXjg62Io9aCV
 IRvzhlNNtr1nTVSn0lDssv4z7r6qyGgmAQQBZlag0DB8r6wo+8NIilnZXE5b9u+ZSoKkuG0nuBGcf
 qdOqvBjgxJrskRy7pHRLabb6k2pOu6n5+Ebg==;
From: Stefan Fritsch <sf@sfritsch.de>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Fritsch <sf@sfritsch.de>
Subject: [PATCH] dma-helpers: Fix iovec alignment
Date: Fri, 12 Apr 2024 10:06:17 +0200
Message-Id: <20240412080617.1299883-1-sf@sfritsch.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:262:44c1:112::2;
 envelope-from=sf@sfritsch.de; helo=manul.sfritsch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 12 Apr 2024 05:19:52 -0400
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

Commit 99868af3d0 changed the hardcoded constant BDRV_SECTOR_SIZE to a
dynamic field 'align' but introduced a bug. qemu_iovec_discard_back()
is now passed the wanted iov length instead of the actually required
amount that should be removed from the end of the iov.

The bug can likely only be hit in uncommon configurations, e.g. with
icount enabled or when reading from disk directly to device memory.

Fixes: 99868af3d0a75cf6 ("dma-helpers: explicitly pass alignment into DMA helpers")
Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
---
 system/dma-helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 9b221cf94e..c9677fd39b 100644
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
2.43.0


