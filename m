Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3E4C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmUVY-0006OK-Qn; Wed, 22 Jul 2026 06:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wmUVW-0006NN-TB; Wed, 22 Jul 2026 06:48:58 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wmUVU-0000Ku-Ss; Wed, 22 Jul 2026 06:48:58 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CB570C6E99;
 Wed, 22 Jul 2026 12:48:43 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 thuth@redhat.com
Subject: [PATCH v2] hw/ide: replace assert with proper error handling
Date: Wed, 22 Jul 2026 12:41:11 +0200
Message-ID: <20260722104836.351387-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1784717294998
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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

From: Artem Nasonov <anasonov@astralinux.ru>

In ide_dma_cb(), the call to prepare_buf() might return a negative
result and cause an assertion failure. This was found during fuzzing
and can be triggered with some qtest commands. Replace the assert with
proper error handling in case the result is negative, but keep the
assert for failing to respect the limit upon success. If that happens,
it is an implementation error.

Found by Linux Verification Center (linuxtesting.org) with libFuzzer.

Cc: qemu-stable@nongnu.org
Fixes: ed78352a59 ("ide: Fix incorrect handling of some PRDTs in ide_dma_cb()")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2777
Signed-off-by: Artem Nasonov <anasonov@astralinux.ru>
Link: https://lore.kernel.org/qemu-devel/20250116111600.2570490-1-anasonov@astralinux.ru
[FE: improve commit message
     keep assert for failing to respect the limit]
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
* Update the code comment accordingly.
* Keep the assert() when the limit is not respected upon success.

 hw/ide/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index f78b00220b..4c1ee19d8e 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -921,8 +921,12 @@ static void ide_dma_cb(void *opaque, int ret)
     s->io_buffer_index = 0;
     s->io_buffer_size = n * 512;
     prep_size = s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size);
-    /* prepare_buf() must succeed and respect the limit */
-    assert(prep_size >= 0 && prep_size <= n * 512);
+    if (prep_size < 0) {
+        ide_dma_error(s);
+        return;
+    }
+    /* If prepare_buf() succeeds, it must respect the limit. */
+    assert(prep_size <= n * 512);
 
     /*
      * Now prep_size stores the number of bytes in the sglist, and
-- 
2.47.3



