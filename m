Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4BEC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilgk-0001nU-Ny; Sun, 12 Jul 2026 00:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilgj-0001gO-CY; Sun, 12 Jul 2026 00:21:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilgh-000761-JZ; Sun, 12 Jul 2026 00:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=GGl6GRvdpGpHwh79NUY1VdcPFATPO+2uyHh7V8lOcJw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ROj06CfWlM1/F6Sh1t4ihFA6eG6L6PYHUYO+CCZOx73H3W4dUJvMjp33M5RQtyR13
 KHSWOsVxyw0BaPWv84+QtTivEGglxS1MJEOdp07uHJBG5AH3VWEtBJAKZKyd1pPdO2
 UPBBSKg20JvfLhyUnnG2DqcVNvjS5vleDDk9pJdbKughhKRI7Jqpsp2JAalLEaNxcu
 kx5zy/TxIcMT7wNg6wpQr6JaM1290bWHHcJC8SthEFq6mjcUfEIZ23CJjFce8jxeTn
 vUpKIKQLKnwdBT0ryNRticu6f5ih274h3jabPfVezFnXim7OfC09oE7yvo/BpZLwt8
 pTlJYyNyo2VxA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F1D7D1C0C10;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 30CCE3EB970;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 921CC13423; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 53/75] accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for
 user-only plugins
Date: Sun, 12 Jul 2026 07:15:11 +0300
Message-ID: <20260712041539.108341-53-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
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
(Mjt: backport to 10.0.x, move changes from include/exec/tlb-flags.h to cpu-all.h
 across v10.0.0-145-g4d43552abe "exec/cpu-all: extract tlb flags defines to exec/tlb-flags.h"
 and adjust for lack of subsequent changes in this area)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 2322181b151..b3a2b0697ef 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -807,7 +807,7 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
         if (page_flags & acc_flag) {
             if (access_type != MMU_INST_FETCH
                 && cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
-                return TLB_MMIO;
+                return TLB_FORCE_SLOW;
             }
             return 0; /* success */
         }
@@ -842,7 +842,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
     flags = probe_access_internal(env, addr, size, access_type, false, ra);
-    g_assert((flags & ~TLB_MMIO) == 0);
+    g_assert((flags & ~TLB_FORCE_SLOW) == 0);
 
     return size ? g2h(env_cpu(env), addr) : NULL;
 }
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 47b14446b8f..808f79663a4 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -105,12 +105,14 @@ CPUArchState *cpu_copy(CPUArchState *env);
 static inline int cpu_mmu_index(CPUState *cs, bool ifetch);
 
 /*
- * Allow some level of source compatibility with softmmu.  We do not
- * support any of the more exotic features, so only invalid pages may
- * be signaled by probe_access_flags().
+ * Allow some level of source compatibility with softmmu.
+ * Invalid is set when the page does not have requested permissions.
+ * MMIO is set when we want the target helper to use the functional
+ * interface for load/store so that plugins see the access.
  */
 #define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
-#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
+#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 2))
+#define TLB_MMIO            0
 #define TLB_WATCHPOINT      0
 
 static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
-- 
2.47.3


