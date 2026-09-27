Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BD5C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkrt-0004SL-N7; Sun, 27 Sep 2026 05:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkqG-0001SN-P9; Sun, 27 Sep 2026 05:06:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkqE-00089P-W5; Sun, 27 Sep 2026 05:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499960; bh=gJ9Y0sf4nRJ1+40uJjivhg0i3ZsqxIBfYVeZGeahDJg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NHy3+VtZSyhg5fsFylm+DmbfdpmNynvk7FGUO6NltUCGNNiCAwX34guy7ljNNMoId
 BgXJAZy4XAXn9ep13hjW4Dt8kkBIzWNR8ZPrJVLRUcpzcu7NXaOiKj7jLLU4gy7s/a
 iDHmMKBR/gRzIsM+z7/mpmfKF0CYEmByBz0VsotKYEBG7A7VI6vsFQALI8mXTS4JL+
 5X0wbpIUwfvs2RMHsdze+rP9MBhzctrnLdt01PQxwqt9xkYjZGZEd/JasyYTFxWZTa
 xl8uVySyFfYM3L9Hqep5ow6DvGp5WvlNTPJ1kqlqZK6BCRsTvSU7bRCWj/MFRFRMmV
 XZNNAY+Y1vYqg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E144E1D8B17;
 Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DE4B94320D0;
 Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C4D565E65F; Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anton Blanchard <antonb@tenstorrent.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 70/86] accel/tcg: Fix TLB_MMIO check in
 tlb_plugin_lookup()
Date: Sun, 27 Sep 2026 12:05:17 +0300
Message-ID: <20260927090540.102811-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
MIME-Version: 1.0
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anton Blanchard <antonb@tenstorrent.com>

Update tlb_plugin_lookup() to check TLB_MMIO in slow_flags.

Cc: qemu-stable@nongnu.org
Fixes: 24b5e0fdb543 ("include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to slow flags")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Message-ID: <20260916123958.1884903-1-antonb@tenstorrent.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit f371388029c9b2afb9c94a2333fa314e8499d409)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 0fc8e42dfee..386ea2b4e10 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1588,7 +1588,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
     data->phys_addr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
 
     /* We must have an iotlb entry for MMIO */
-    if (tlb_addr & TLB_MMIO) {
+    if (full->slow_flags[access_type] & TLB_MMIO) {
         MemoryRegionSection *section = full->section;
         data->is_io = true;
         data->mr = section->mr;
-- 
2.47.3


