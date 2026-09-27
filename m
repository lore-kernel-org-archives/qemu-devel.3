Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966CBC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmSA-0006zl-Jw; Sun, 27 Sep 2026 06:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRz-0006fu-Ux; Sun, 27 Sep 2026 06:49:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRy-00013a-8a; Sun, 27 Sep 2026 06:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506135; bh=7ulAkzRSrBUpu8+Z4oxLCBWBbZuBzcUKsoIe6P/fFBE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uA7RTV14ls8drMuqDGyrf2f9Pf5KdMbHbs8jJKxKa5EWXpl3DRHv4lOaGAloZWSD0
 tjiBspvLxs9Tu44M+M+/0L/rex9j4eWCuS3OOB70F5kw2HDO8LqV2KuWXqVHmy1ezW
 lfeajHFfsnguxnZOGZdcc8hwrjh0ZUWZg9hafCkoaSVHwyaV2pIpo6ILfy1BT8IvtO
 L9xhJo5UYtv/2o8AZjlvvky9qiu4jilXxIikeEYyQalq0MkVB4mK+F8cz9bb+kQNcK
 pB9T5h9libRoqAn+0zWUrO/JSb+VR7Xdlv517l+q1AA5mLNIK9OwycuhY0MFgxd2YK
 pfnZkfaKSh4wQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E8BB81D8B65;
 Sun, 27 Sep 2026 13:48:55 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E60F543216C;
 Sun, 27 Sep 2026 13:48:55 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CE5745E782; Sun, 27 Sep 2026 13:48:55 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 70/92] accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO
 for system plugins
Date: Sun, 27 Sep 2026 13:47:46 +0300
Message-ID: <20260927104821.196183-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

In b79a9b6e5b, we stopped using TLB_MMIO for user-only plugins,
but erroneously thought we were already doing the same for system.
Do that now.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit cab8663761943141f8fd75dddc99255fe2cb45c4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7f7c208ba12..ae5af014960 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1369,7 +1369,6 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     vaddr page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
-    bool force_mmio = check_mem_cbs && cpu_plugin_mem_cbs_enabled(cpu);
     CPUTLBEntryFull *full;
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
@@ -1399,16 +1398,13 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
 
     *pfull = full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
     flags |= full->slow_flags[access_type];
-
-    /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
-    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED))
-        || (access_type != MMU_INST_FETCH && force_mmio)) {
-        *phost = NULL;
-        return TLB_MMIO;
+    if (check_mem_cbs && cpu_plugin_mem_cbs_enabled(cpu)) {
+        flags |= TLB_FORCE_SLOW;
     }
 
-    /* Everything else is RAM. */
-    *phost = (void *)((uintptr_t)addr + entry->addend);
+    *phost = (flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED)
+              ? NULL
+              : (void *)((uintptr_t)addr + entry->addend));
     return flags;
 }
 
-- 
2.47.3


