Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DC5CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENXB-0000s7-E2; Wed, 07 Oct 2026 05:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEKja-0001oK-CZ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:02:53 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEKjR-0001Rx-KP
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:02:34 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69761tqN048409
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 7 Oct 2026 15:02:01 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5MEWzOOuMtn+OMFz8oEyKXejR5oSiAq2XWujcAxsJPs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1791352921; v=1;
 b=U42mutAftcCqxgAsAEmQRZjZPyDDyTTLSx1AtdmEmA1U7B1lVxbOd0WPwEzWIm1x
 vJWpJXtUegKvls5nYIowmCjJd3dDhwXy5DRhHG3oxUtF9Y8PpUFC446Dz5U2gESl
 4jnyqq8yBpcpBDtis5+KuJ9I0K2fZ7czlcev4um4Uf7PfPonYXebVpOfncBeZsYv
 THGA3aJ1WD9tmJRvRzMCZsVA0c3MbofkHUaL5uJ8GtGDy8vjPrqR5shHV+jWw4Ul
 85zotzzi8vw7K2l52ooKs4xlPMCsUF7dpbudQ/J55rVV0Ts1mYfXofDfGuzEiBh+
 qUtkOZW7/93Cf24XfaYVig==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 07 Oct 2026 15:01:50 +0900
Subject: [PATCH 2/2] contrib/plugins/bbv.c: Allow selecting ROI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-bbv-v1-2-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
References: <20261007-bbv-v1-0-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261007-bbv-v1-0-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6184;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=Uvk/okHOzcmHgoHxIDVfwHfx+rj2ZYS4xjwGNTIJ8b4=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bRB0GptS+rjac86ZU/cqSE8dduyy13NglrWT7kOHdJf
 QrHs45/HaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABNhvszIcFP9xRLJdXfvn2CI
 8u5z/ODi94vHtzJIkZvr3uGs4q0XPBn+2e1wfPzoTeWnl/wHZglY/A5osyzg/dUr+NSocj3He5Z
 wVgA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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

A region of interest (ROI) often excludes the program startup and exit.
For example, a benchmark may parse a large input and then run a
computation kernel and the former may take longer than the latter;
basic block vectors generated for the whole execution will not properly
represent the latter.

Add options to specify the beginning and the end of the ROI to bound
basic block vector generation to the ROI.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 docs/about/emulation.rst |  8 +++++
 contrib/plugins/bbv.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index c58149086cdd..0566171b517b 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -284,6 +284,14 @@ The bbv plugin allows you to generate basic block vectors for use with the
 
   * - Option
     - Description
+  * - begin=A
+    - The virtual address of the instruction that starts basic block vector
+      generation. Generation starts from the beginning of the execution if
+      not specified.
+  * - end=A
+    - The virtual address of the instruction that ends basic block vector
+      generation. Generation continues until the endo of the execution if
+      not specified.
   * - interval=N
     - The interval to generate a basic block vector specified by the number of
       instructions (Default: N = 100000000)
diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
index e5caf5d9543b..a2a779f7639e 100644
--- a/contrib/plugins/bbv.c
+++ b/contrib/plugins/bbv.c
@@ -5,6 +5,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include <stdbool.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <glib.h>
 
@@ -26,6 +28,10 @@ static GHashTable *bbs;
 static GRWLock bbs_lock;
 static char *filename;
 static struct qemu_plugin_scoreboard *vcpus;
+static bool begin_present;
+static uint64_t begin;
+static bool end_present;
+static uint64_t end;
 static int64_t interval = 100000000;
 
 static void plugin_exit(void *p)
@@ -66,6 +72,7 @@ static void vcpu_init(unsigned int vcpu_index, void *userdata)
     Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
 
     vcpu_filename = g_strdup_printf("%s.%u.bb", filename, vcpu_index);
+    vcpu->count = begin_present ? INT64_MIN : -interval;
     vcpu->file = fopen(vcpu_filename, "w");
 }
 
@@ -102,6 +109,22 @@ static void vcpu_interval_exec(unsigned int vcpu_index, void *udata)
     fputc('\n', vcpu->file);
 }
 
+static void vcpu_begin_insn_exec(unsigned int vcpu_index, void *userdata)
+{
+    GHashTableIter iter;
+    void *value;
+
+    g_rw_lock_reader_lock(&bbs_lock);
+    g_hash_table_iter_init(&iter, bbs);
+
+    while (g_hash_table_iter_next(&iter, NULL, &value)) {
+        qemu_plugin_u64_set(bb_count_u64(value), vcpu_index, 0);
+    }
+
+    g_rw_lock_reader_unlock(&bbs_lock);
+    qemu_plugin_u64_set(count_u64(), vcpu_index, -interval);
+}
+
 static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
@@ -119,6 +142,19 @@ static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
     }
     g_rw_lock_writer_unlock(&bbs_lock);
 
+    for (size_t idx = 0; idx < n_insns; idx++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
+        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
+
+        if (begin_present && insn_vaddr == begin) {
+            qemu_plugin_register_vcpu_insn_exec_cb(
+                insn, vcpu_begin_insn_exec, QEMU_PLUGIN_CB_NO_REGS, NULL);
+        } else if (end_present && insn_vaddr == end) {
+            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_STORE_U64, count_u64(), INT64_MIN);
+        }
+    }
+
     qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
         tb, QEMU_PLUGIN_INLINE_ADD_U64, count_u64(), n_insns);
 
@@ -127,7 +163,32 @@ static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 
     qemu_plugin_register_vcpu_tb_exec_cond_cb(
         tb, vcpu_interval_exec, QEMU_PLUGIN_CB_NO_REGS,
-        QEMU_PLUGIN_COND_GE, count_u64(), interval, NULL);
+        QEMU_PLUGIN_COND_LT, count_u64(), INT64_MIN, NULL);
+}
+
+static bool parse_vaddr(uint64_t *vaddr, const char *opt, const char *token)
+{
+    char *endptr;
+
+    if (!*token) {
+        fprintf(stderr, "value is missing: %s\n", opt);
+        return false;
+    }
+
+    errno = 0;
+    *vaddr = g_ascii_strtoull(token, &endptr, 0);
+
+    if (*endptr) {
+        fprintf(stderr, "malformed integer: %s\n", opt);
+        return false;
+    }
+
+    if (errno) {
+        perror(opt);
+        return false;
+    }
+
+    return true;
 }
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
@@ -137,7 +198,17 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
-        if (g_strcmp0(tokens[0], "interval") == 0) {
+        if (g_strcmp0(tokens[0], "begin") == 0) {
+            if (!parse_vaddr(&begin, opt, tokens[1])) {
+                return -1;
+            }
+            begin_present = true;
+        } else if (g_strcmp0(tokens[0], "end") == 0) {
+            if (!parse_vaddr(&end, opt, tokens[1])) {
+                return -1;
+            }
+            end_present = true;
+        } else if (g_strcmp0(tokens[0], "interval") == 0) {
             char *endptr;
             interval = g_ascii_strtoll(tokens[1], &endptr, 10);
             if (*endptr) {
@@ -157,6 +228,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         }
     }
 
+    if (begin_present && end_present && begin == end) {
+        fprintf(stderr, "begin and end have the same value");
+        return -1;
+    }
+
     if (!filename) {
         fputs("outfile unspecified\n", stderr);
         return -1;

-- 
2.55.0


