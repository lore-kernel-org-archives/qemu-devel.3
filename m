Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511CDC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifpN-0005nK-M9; Sat, 11 Jul 2026 18:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpL-0005g5-Lo; Sat, 11 Jul 2026 18:05:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpJ-0000bY-N1; Sat, 11 Jul 2026 18:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=MI7uRsMIx7P0xMIvgrXGd6plvVl2HxCsSXwG5yiEXxo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uQoMULZdok9Zd2JP+I8WOhjrYdnxW2FkWqYcUh3Jitg20FYp0nO5tIpkz+0w9IRA8
 uvM0NJnvTYGzKlsioEgWbchp3gbink0/wAxPWAA10/9Rt50OoYYK+DokkcrAq07myU
 m1cX5DQXEQQh4bchELVy5cI/as3f6C01MWmE59GKIgu819YKNd+2tXk/wU6Z8baGE5
 9aX0P9zPWfF5LDmfzKHGgN8fZE0xjgTIy+KGL0pxnr1FuXd3gfE9WuVuOkjWRVtSsX
 jNNU8nJZNC7EAilhSQcfPE+P195YSjFb+tZkrIuYwnTLFeskuljKIv20mOQ6A0bNyw
 f4TejL7h2Bu5w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 808A91C0AC8;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 372D63EAF53;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CA1C41335D; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 61/81] accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for
 user-only plugins
Date: Sun, 12 Jul 2026 00:58:39 +0300
Message-ID: <20260711215904.3757-61-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

In 6d03226b422 we set TLB_MMIO to a non-zero value for user-only
so that we could return a non-zero value from probe_* functions
so that we could force callers like Arm SVE vector moves to use
the slow path rather than direct access.  All for the sake of
exposing these accesses to plugins.

Back then, TLB_FORCE_SLOW did not exist, so TLB_MMIO seemed like
a reasonable solution.  However, user-only doesn't really have
MMIO and this has knock-on effects, like forcing Arm SVE first-fault
vector loads to stop.  Better to use TLB_FORCE_SLOW as a more exact
trigger for plugins.

Cc: qemu-stable@nongnu.org
Fixes: 6d03226b422 ("plugins: force slow path when plugins instrument memory ops")
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260702171057.47998-1-richard.henderson@linaro.org>
(cherry picked from commit b79a9b6e5b5657534615dd8e574d58305e16841c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d283d3cc724..dd0bcde4d49 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -768,7 +768,7 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
         if (page_flags & acc_flag) {
             if (access_type != MMU_INST_FETCH
                 && cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
-                return TLB_MMIO;
+                return TLB_FORCE_SLOW;
             }
             return 0; /* success */
         }
@@ -803,7 +803,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
     flags = probe_access_internal(env, addr, size, access_type, false, ra);
-    g_assert((flags & ~TLB_MMIO) == 0);
+    g_assert((flags & ~TLB_FORCE_SLOW) == 0);
 
     return size ? g2h_vaddr(env_cpu(env), addr) : NULL;
 }
diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
index 357e79095c9..e12cddf2345 100644
--- a/include/exec/tlb-flags.h
+++ b/include/exec/tlb-flags.h
@@ -27,12 +27,13 @@
 
 /*
  * Allow some level of source compatibility with softmmu.
- * Invalid is set when the page does not have requested permissions.
- * MMIO is set when we want the target helper to use the functional
+ * INVALID is set when the page does not have requested permissions.
+ * FORCE_SLOW is set when we want the target helper to use the functional
  * interface for load/store so that plugins see the access.
  */
 #define TLB_INVALID_MASK     (1 << 0)
-#define TLB_MMIO             (1 << 1)
+#define TLB_FORCE_SLOW       (1 << 1)
+#define TLB_MMIO             0
 #define TLB_WATCHPOINT       0
 
 #else
-- 
2.47.3


