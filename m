Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E225ED12694
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 09:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjHh-0000HG-0t; Wed, 03 Dec 2025 04:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjHf-0000FO-MH; Wed, 03 Dec 2025 04:36:27 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjHd-00074X-Vh; Wed, 03 Dec 2025 04:36:27 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 82BC91708B1;
 Wed, 03 Dec 2025 12:35:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6F0BD32B5A8;
 Wed, 03 Dec 2025 12:36:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 82/96] hw/display/exynos4210_fimd: Account for zero
 length in fimd_update_memory_section()
Date: Wed,  3 Dec 2025 12:35:15 +0300
Message-ID: <20251203093612.2370716-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In fimd_update_memory_section() we attempt ot find and map part of
the RAM MR which backs the framebuffer, based on guest-configurable
size and start address.

If the guest configures framebuffer settings which result in a
zero-sized framebuffer, we hit an assertion(), because
memory_region_find() will return a NULL mem_section.mr.

Explicitly check for the zero-size case and treat this as a
guest error.

Because we now have a code path which can reach error_return without
calling memory_region_find to set w->mem_section, we must NULL out
w->mem_section.mr after the unref of the old MR, so that error_return
does not incorrectly double-unref the old MR.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1407
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251107143913.1341358-1-peter.maydell@linaro.org
(cherry picked from commit 579be921f509fb9d2deccc4233496e36b221abb3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index c61e0280a7..eec874d0b1 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1147,6 +1147,13 @@ static void fimd_update_memory_section(Exynos4210fimdState *s, unsigned win)
     if (w->mem_section.mr) {
         memory_region_set_log(w->mem_section.mr, false, DIRTY_MEMORY_VGA);
         memory_region_unref(w->mem_section.mr);
+        w->mem_section.mr = NULL;
+    }
+
+    if (w->fb_len == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FIMD: Guest config means framebuffer is zero length\n");
+        goto error_return;
     }
 
     w->mem_section = memory_region_find(s->fbmem, fb_start_addr, w->fb_len);
-- 
2.47.3


