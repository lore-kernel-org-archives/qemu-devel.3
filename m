Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7DFF47CD2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFgC-0006cK-2Y; Thu, 05 Mar 2026 15:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg8-0006Zv-FP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:16 -0500
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg6-00067R-4P
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:16 -0500
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-89a0ecbc713so41090136d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772743933; x=1773348733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KvW+mE9q2G2hjiJT9NapT9FyaOUnYHt9L2Yntd6W9g=;
 b=a29PJ3VlYAxP4spLR2hcUAuVACFk7EUdq03YfZuZkUaQ6esmnh3Or+bMixusbQDtRH
 W+X27MAo71PbDgKTNpzZSbce/117rMhK6tb+s/taGKXLr5uSRazwtvwx50HeQke+KOsq
 l4gvkEBWCN2dzGXvueaiw7axJmR5xSY9N8Lrkdvamlld88BP9gUqlFcydzYxP01cvHFq
 Y0TLf+TOr/qtr58JBe/qJ5zExULqmslt+jHExpIrywXt5eneMiDfF5Qcuj554s9muKGY
 c7kXDmQwMsHOCrLHZJGLiNPE8FWexmbckIdzfm90AabUll2/LbveHOqaVxOt7YZ2KJ09
 iNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772743933; x=1773348733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+KvW+mE9q2G2hjiJT9NapT9FyaOUnYHt9L2Yntd6W9g=;
 b=Pj9KLb9CIpUjT0f4rpI+QrNfALNbxqdQVM9hz5JH3AP2O/CsiYCv8BKJqM+RipZNp/
 X0bd3pc91BuvmHUGomQrbbnFnwIFUOAUEs3ZvBVWPX8BPO2myj7NjAjYwwgMd373Y+oD
 i6g9mrhlV5t83rSERkkhtM0P+P+f+Bsejo5UWNU4546Fb+6jIqITASRJmuaCdhRfloGW
 YGz+CeXyIW3alAGlqr4GDZAaAU9GvPWm2IpiUz64m06qiBjnolJBDnr2HRsrP8Qjg4hL
 bgywQaYmHMrv5IjJKJtkQbeASY6v4te5WocabzeROC+lYymJl3fAc8e6cTXmFhiEUsDH
 pRWg==
X-Gm-Message-State: AOJu0Yznj+PiHQ6Otj+eBCQ9eCsQckLNQ+0OuimmGM01vHJgiLm2brWA
 OLSR+9+a0JwNdpXd989tMPZcKL9by/t0K0LFrOCL/vTjwXn96cvvMGb+BQpvCMFmuPjXuh4dGh0
 abUc4
X-Gm-Gg: ATEYQzyaRCfJFxpsEa7hZql3wgWVvM1ZmG4AntCLN6t2W18v1m3FJ7uZXtYZGtZH8FP
 Nu46MTsclUHnswuq34IvaK/F3AsKZv0dmJY0VVVf/cINiFZy7jf9w+wpdczGu5/bY30CsJmv2tM
 D3WqMnLlDSq4EVCAb7QYKbrMg43173BklK/cShLsQnv4j3aDuCpBmslEqDjI7ixJh6UzbdP5aE3
 5/FoMA2KRGCu1NS29hL8X23yhfcORzHKwhVvxZY3bba+lYXsBkuh1DisN2oRgw65xQ4sm1CwDx9
 pRFwrxoaOruDEukfJWjUR8uhEQ5QY3wNa6M36b2sBT+jTCEMxYJ5OiQy5/NMNoLMh9p4i0VxBdl
 Tgb2/qPBPjHiCLbVt1rS4qpe+pKm7kDjEaT2W9G5Dsvlffcc9HpuEMWZIriAk2Jy8Kei5B+tb/R
 GTxrx8d32iZts6J7pdHu4nUWc7oycoGJNYTHuuufGfQ3amoqLS+MRw36SrkXIX45FZJK2vt4Zn9
 Bml
X-Received: by 2002:a05:6214:d45:b0:895:d679:ecde with SMTP id
 6a1803df08f44-89a248099eemr48092416d6.27.1772743932990; 
 Thu, 05 Mar 2026 12:52:12 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0e31b035sm65559396d6.17.2026.03.05.12.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:52:12 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 08/12] tests/tcg/plugins: test register accesses
Date: Thu,  5 Mar 2026 12:51:48 -0800
Message-ID: <20260305205152.2121854-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
References: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Florian Hofhammer <florian.hofhammer@epfl.ch>

The additional plugin tests register accesses, specifically both for
read-only and read-write registers. Writing to a read-only register is
currently not tested, as this would trigger an assertion and fail the
test.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
Link: https://lore.kernel.org/qemu-devel/20260305-setpc-v5-v7-8-4c3adba52403@epfl.ch
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/registers.c | 79 +++++++++++++++++++++++++++++++++++
 tests/tcg/plugins/meson.build |  1 +
 2 files changed, 80 insertions(+)
 create mode 100644 tests/tcg/plugins/registers.c

diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
new file mode 100644
index 00000000000..6d627c70371
--- /dev/null
+++ b/tests/tcg/plugins/registers.c
@@ -0,0 +1,79 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
+ */
+#include "glib.h"
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/*
+ * This plugin tests whether we can read and write registers via the plugin
+ * API. We try to just read/write a single register, as some architectures have
+ * registers that cannot be written to, which would fail the test.
+ * See: https://lists.gnu.org/archive/html/qemu-devel/2026-02/msg07025.html
+ */
+static void vcpu_init_cb(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    g_autoptr(GArray) regs = qemu_plugin_get_registers();
+    g_assert(regs != NULL);
+    g_autoptr(GByteArray) buf = g_byte_array_sized_new(0);
+    qemu_plugin_reg_descriptor *reg_desc = NULL;
+    bool success = false;
+
+    /* Make sure we can read and write a register not marked as readonly */
+    for (size_t i = 0; i < regs->len; i++) {
+        reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (!reg_desc->is_readonly) {
+            g_byte_array_set_size(buf, 0);
+            success = qemu_plugin_read_register(reg_desc->handle, buf);
+            g_assert(success);
+            g_assert(buf->len > 0);
+            success = qemu_plugin_write_register(reg_desc->handle, buf);
+            g_assert(success);
+            break;
+        } else {
+            reg_desc = NULL;
+        }
+    }
+    g_assert(regs->len == 0 || reg_desc != NULL);
+
+    /*
+     * Check whether we can still read a read-only register. On each
+     * architecture, at least the PC should be read-only because it's only
+     * supposed to be modified via the qemu_plugin_set_pc() function.
+     */
+    for (size_t i = 0; i < regs->len; i++) {
+        reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (reg_desc->is_readonly) {
+            g_byte_array_set_size(buf, 0);
+            success = qemu_plugin_read_register(reg_desc->handle, buf);
+            g_assert(success);
+            g_assert(buf->len > 0);
+            break;
+        } else {
+            reg_desc = NULL;
+        }
+    }
+    g_assert(regs->len == 0 || reg_desc != NULL);
+    /*
+     * Note: we currently do not test whether the read-only register can be
+     * written to, because doing so would throw an assert in the plugin API.
+     */
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb);
+    return 0;
+}
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index b3e3a9a6d02..d7f8f0ae0ad 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -6,6 +6,7 @@ test_plugins = [
 'insn.c',
 'mem.c',
 'patch.c',
+'registers.c',
 'reset.c',
 'setpc.c',
 'syscall.c',
-- 
2.47.3


