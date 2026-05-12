Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0714ECD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuO9-000054-A2; Tue, 12 May 2026 17:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuNg-0007p3-AH; Tue, 12 May 2026 17:11:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuNe-00040h-Lg; Tue, 12 May 2026 17:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619303; bh=ulGqDMg7rJbIj1wEVL1WQE/D5E4y5lKp07H1knBt8+I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ex9x/OBOs5cVhPCPgOOcZXGF3dHCI9KSiR8VZw76NfS0t0pY+u8GxYOv6vdz3Ap2y
 jgbYqQwe2rq7pb4Q7YhWM+nfiscRPnR0k91k11IQGFYGbblRGBSfRxT9PjSLaG19gf
 y0HwG5UK/kVyiOlqhvFgukse4EnhzISc6mAmoSQuIXkHAAwWIrbpgUIl0dxLDNLJbN
 RUujLht1WwhWalIrih9ntatelfAXtOLh3ng3+X3NpPkJ7NSgOvyld0QUC55JbLSGMm
 uT/X2MUsee8zBCsEHzZypWPKXAu8VoHMMMVynNJHSl9Av31fM6aFzI9sv+Mbn3Htrn
 O3/4m7/QQCtKw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1CC5E1AA370;
 Tue, 12 May 2026 23:55:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 27C243ABCE0;
 Tue, 12 May 2026 23:55:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Panda Jiang <3160104094@zju.edu.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 051/117] accel/tcg: Fix uninitialized hostp in
 get_page_addr_code_hostp
Date: Tue, 12 May 2026 23:53:53 +0300
Message-ID: <20260512205503.361097-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

This uninitialized value violates the contract in the
documentation comment, and may lead to a SEGV during
translaton with -d in_asm.

Change the documentation to disallow hostp NULL.
Pass hostp to probe_access_internal directly.

Reported-by: Panda Jiang <3160104094@zju.edu.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 0039e5fd22344fec664c980d7a27443568834264)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fd1606c856..2d6f51b68c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1544,18 +1544,18 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
 
     (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
                                 cpu_mmu_index(env_cpu(env), true), false,
-                                &p, &full, 0, false);
+                                hostp, &full, 0, false);
+
+    p = *hostp;
     if (p == NULL) {
         return -1;
     }
 
     if (full->lg_page_size < TARGET_PAGE_BITS) {
+        *hostp = NULL;
         return -1;
     }
 
-    if (hostp) {
-        *hostp = p;
-    }
     return qemu_ram_addr_from_host_nofail(p);
 }
 
diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 0ca13750f9..9e7be2d78d 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -82,7 +82,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
  * See get_page_addr_code() (full-system version) for documentation on the
  * return value.
  *
- * Sets *@hostp (when @hostp is non-NULL) as follows.
+ * Sets *@hostp as follows.
  * If the return value is -1, sets *@hostp to NULL. Otherwise, sets *@hostp
  * to the host address where @addr's content is kept.
  *
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 1800dffa63..f15bdefb1a 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -822,9 +822,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
     flags = probe_access_internal(env, addr, 1, MMU_INST_FETCH, false, 0);
     g_assert(flags == 0);
 
-    if (hostp) {
-        *hostp = g2h_untagged(addr);
-    }
+    *hostp = g2h_untagged(addr);
     return addr;
 }
 
-- 
2.47.3


