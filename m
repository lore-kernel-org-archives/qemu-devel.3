Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A900BCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB2q-0001l7-HL; Sat, 17 Oct 2026 16:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB2D-000879-R4; Sat, 17 Oct 2026 16:29:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB2B-00043Y-Tf; Sat, 17 Oct 2026 16:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268855; bh=vs4q4+dnsHZ4gThLVN7SNRSHjlqUmrqJTENefJWFLQg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=I9/ptCAoBs7lrjWnohjvgWpAgdOaep3BITcYs3v2ahQgKN/oPhF2NI2d5gXGE6jSN
 bLnFEgzu/jvW2DWFrqlWVCEdMVeOIFOpT8zvWUPvzU+Y9rSQt7KWdn2rWjQJKGEK+3
 +8ehR7w8netq1kb0iQhFRWAikWbICeWjL5MNau9vw4j+R6liYQW5QZXRWfpr28XLVt
 Tpw3Nb4r6xvMvl3fdI/OP3SbWnGebI/iq5Z5ByYfDcyqv9s/FemTOlpt8fPlGy6YWT
 XfSSinX+HA6Waly+FkMwiCY8ZT6c9JVMM6GMcrHXWdryIMJzstsLFF2Wi96HSzJCFy
 VpkMW5SR6yIGw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 76C121DE75A;
 Sat, 17 Oct 2026 23:27:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5D626443430;
 Sat, 17 Oct 2026 23:27:34 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, y zhou <yzhou.dev@outlook.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 30/73] plugins: fix register handle encoding to
 reserve NULL as invalid
Date: Sat, 17 Oct 2026 23:25:48 +0300
Message-ID: <20261017202638.728621-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

From: y zhou <yzhou.dev@outlook.com>

The opaque register handles returned by qemu_plugin_get_registers()
are currently encoded as:

    handle = (gdb_reg << 1) | read_only_bit

For the first core register of every target -- gdb_reg 0, not
read-only -- this encodes to GINT_TO_POINTER(0), i.e. NULL. That is
x86_64 "rax", aarch64 "x0" and ppc "r0", among others.

A NULL handle is indistinguishable from an invalid one, so any plugin
that defensively checks its handles silently loses access to the
first core register (where the Linux syscall number lives on x86_64,
for example). Passing NULL to qemu_plugin_write_register() instead of
being rejected silently writes register 0.

Restore the invariant that NULL is never a valid handle by keeping an
offset on the gdb register number, as was already done before the
read-only property was packed into the handle (see v10.0.0, where
handles were encoded as GINT_TO_POINTER(gdb_reg + 1)):

    handle = ((gdb_reg + 1) << 1) | read_only_bit

Also assert in tests/tcg/plugins/registers.c that every descriptor
carries a non-NULL handle: the current test passes the handles
straight to read/write without checking them, and a handle encoding
that maps a valid register to NULL goes unnoticed for that reason.

Found while writing a system-mode syscall tracing plugin, which could
read neither the syscall number on x86_64 nor the first argument on
aarch64 (both handles came back NULL). Auditing every
GINT_TO_POINTER/GPOINTER_TO_INT site in the tree shows this is the
only place where a valid entity encodes to NULL.

Fixes: 55327b85ce32c ("plugins: prohibit writing to read-only registers")
Signed-off-by: y zhou <yzhou.dev@outlook.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Alexandre Iooss <erdnaxe@crans.org>
Cc: qemu-stable@nongnu.org
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261005181817.403766-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
(cherry picked from commit 46a8b8b378259a4ddb4bc4b79f88eba7640ad899)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/plugins/api.c b/plugins/api.c
index eb982f9aad..0d02a4f7ad 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -453,7 +453,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
             desc.is_readonly = true;
             plugin_ro_bit = 1;
         }
-        desc.handle = GINT_TO_POINTER((grd->gdb_reg << 1) | plugin_ro_bit);
+        desc.handle = GINT_TO_POINTER(((grd->gdb_reg + 1) << 1) | plugin_ro_bit);
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
     }
@@ -478,7 +478,7 @@ bool qemu_plugin_read_register(struct qemu_plugin_register *reg,
         return false;
     }
 
-    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) >> 1) > 0);
+    return (gdb_read_register(current_cpu, buf, (GPOINTER_TO_INT(reg) >> 1) - 1) > 0);
 }
 
 bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
@@ -495,7 +495,8 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
         return false;
     }
 
-    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) >> 1) > 0);
+    return (gdb_write_register(current_cpu, buf->data,
+                               (GPOINTER_TO_INT(reg) >> 1) - 1) > 0);
 }
 
 void qemu_plugin_set_pc(uint64_t vaddr)
diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
index 0e41734435..02058fe8a8 100644
--- a/tests/tcg/plugins/registers.c
+++ b/tests/tcg/plugins/registers.c
@@ -29,6 +29,14 @@ static void vcpu_init_cb(unsigned int vcpu_index, void *userdata)
     qemu_plugin_reg_descriptor *reg_desc = NULL;
     bool success = false;
 
+    /* NULL must never be a valid register handle */
+    for (size_t i = 0; i < regs->len; i++) {
+        qemu_plugin_reg_descriptor *desc =
+            &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+
+        g_assert(desc->handle != NULL);
+    }
+
     /* Make sure we can read and write a register not marked as readonly */
     for (size_t i = 0; i < regs->len; i++) {
         reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
-- 
2.47.3


