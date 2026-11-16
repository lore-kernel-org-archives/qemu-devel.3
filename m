Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF8606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=augkdtQs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3MV-0001P1-N0; Mon, 16 Nov 2026 15:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3KV-0007nA-6G; Mon, 16 Nov 2026 15:29:31 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3KT-0001gT-Ga; Mon, 16 Nov 2026 15:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860765; bh=JS3Alo5AWrpJfKeqXr1L1Zh0CEIkNbNY4lmFgKN4nB8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=augkdtQsyY+eP+f7GrsIWVm5VDBv7UOPmHcXcWzA9Q4YqHg2hjG9VMDan1CJDHjAv
 g/N/QqmGPyKgmFSQC6s8GqjADjb6NNqzYzG7h6PlcJHs3GBsXBFTAYkq1M5KrX2m6O
 zgZofgpZiqVSuejksVLagZnfh53h8j6D4uifB2ed9SlhMx8555Z7568YkeIWX0vH/S
 KUuPSPbyDXyfDlKPGMvh93LuA2OB0XNW5RJM55op2g12Yw340RVIJhMKrnGqa59Fdv
 tTtvrXwB+TP5w57m+a0ln89cX7gxt4pdodPqj/JlLunSpXhAdXw64eRmcJDNLEbc6u
 D4xXJCSHEDguQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6A5771E71BD;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 67DBB45FBE9;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3C708B8E96; Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 40/63] target/loongarch: Clear PAGE_READ when PTE.NR
 is set
Date: Mon, 16 Nov 2026 23:25:19 +0300
Message-ID: <20261116202554.535325-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bibo Mao <maobibo@loongson.cn>

On LoongArch the NR bit in a PTE indicates that the page is not
readable, i.e. it is write-only. When translating a PTE to QEMU
protection bits, clear PAGE_READ if PTE.NR is set instead of always
exposing PAGE_READ.

This avoids incorrectly marking a write-only page as readable.

Cc: qemu-stable@nongnu.org
Fixes: 7392cb1c7b24 ("target/loongarch: Add common function loongarch_check_pte()")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
(cherry picked from commit 07a4c09e4c1c9de78b3ee287b3ac7b5badc0277b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 123cad3d930..7ece9d2e542 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -100,7 +100,10 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
 
     context->physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
                         (context->addr & MAKE_64BIT_MASK(0, tlb_ps));
-    context->prot = PAGE_READ;
+    context->prot = 0;
+    if (!tlb_nr) {
+        context->prot |= PAGE_READ;
+    }
     context->mmu_index = tlb_plv;
     if (tlb_d) {
         context->prot |= PAGE_WRITE;
-- 
2.47.3


