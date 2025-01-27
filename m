Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AD5C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgcG-0005Cc-VC; Tue, 28 Jan 2025 03:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgYz-0006rk-Ht; Tue, 28 Jan 2025 03:03:17 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgYx-0002I5-Q0; Tue, 28 Jan 2025 03:03:13 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E3D15E1B61;
 Tue, 28 Jan 2025 10:57:08 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5F86D1A6314;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 1410D520B9; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 wannacu <wannacu2049@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 26/58] tcg: Reset free_temps before tcg_optimize
Date: Mon, 27 Jan 2025 23:25:12 +0300
Message-Id: <20250127202547.3723716-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When allocating new temps during tcg_optmize, do not re-use
any EBB temps that were used within the TB.  We do not have
any idea what span of the TB in which the temp was live.

Introduce tcg_temp_ebb_reset_freed and use before tcg_optimize,
as well as replacing the equivalent in plugin_gen_inject and
tcg_func_start.

Cc: qemu-stable@nongnu.org
Fixes: fb04ab7ddd8 ("tcg/optimize: Lower TCG_COND_TST{EQ,NE} if unsupported")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2711
Reported-by: wannacu <wannacu2049@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 04e006ab36a8565b92d4e21dd346367fbade7d74)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 99643dd960..e6327d4fe1 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -276,7 +276,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
      * that might be live within the existing opcode stream.
      * The simplest solution is to release them all and create new.
      */
-    memset(tcg_ctx->free_temps, 0, sizeof(tcg_ctx->free_temps));
+    tcg_temp_ebb_reset_freed(tcg_ctx);
 
     QTAILQ_FOREACH_SAFE(op, &tcg_ctx->ops, link, next) {
         switch (op->opc) {
diff --git a/include/tcg/tcg-temp-internal.h b/include/tcg/tcg-temp-internal.h
index 44192c55a9..98f91e68b7 100644
--- a/include/tcg/tcg-temp-internal.h
+++ b/include/tcg/tcg-temp-internal.h
@@ -42,4 +42,10 @@ TCGv_i64 tcg_temp_ebb_new_i64(void);
 TCGv_ptr tcg_temp_ebb_new_ptr(void);
 TCGv_i128 tcg_temp_ebb_new_i128(void);
 
+/* Forget all freed EBB temps, so that new allocations produce new temps. */
+static inline void tcg_temp_ebb_reset_freed(TCGContext *s)
+{
+    memset(s->free_temps, 0, sizeof(s->free_temps));
+}
+
 #endif /* TCG_TEMP_FREE_H */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b1b8b8bba3..e1f6c0f573 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1489,7 +1489,7 @@ void tcg_func_start(TCGContext *s)
     s->nb_temps = s->nb_globals;
 
     /* No temps have been previously allocated for size or locality.  */
-    memset(s->free_temps, 0, sizeof(s->free_temps));
+    tcg_temp_ebb_reset_freed(s);
 
     /* No constant temps have been previously allocated. */
     for (int i = 0; i < TCG_TYPE_COUNT; ++i) {
@@ -6120,6 +6120,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     }
 #endif
 
+    /* Do not reuse any EBB that may be allocated within the TB. */
+    tcg_temp_ebb_reset_freed(s);
+
     tcg_optimize(s);
 
     reachable_code_pass(s);
-- 
2.39.5


