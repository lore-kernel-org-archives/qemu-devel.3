Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D9AC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 06:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seq67-00076m-Uw; Fri, 16 Aug 2024 02:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1seq65-00076F-OL
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:06:02 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1seq63-0002Gg-79
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:06:01 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fc65329979so16489275ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 23:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723788358; x=1724393158;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Db0RbgpMk9789rCRLh18uSjBnUcu8VNyPlg0EDa+0gY=;
 b=VaAj0WPl2GQigTepGz4Fub40t3Jv5D73l+LZ6QS4HtB2b7okBQ4M0/6RH/kNa3DY6K
 4QHtXBJAKjBFtV/cqytNYYJf30psF/BVh1wmpnDNghjoeOth8ddYO5pUWpelCIAXb3WX
 87KbJB69SnXu9jhEm58DVC/ZqSzkB9k1uGWD6LQJXBd7f4z+GTi3390MOQmM5p0NbfPA
 kVLutcQyFrduMfDjIYQ6YBLyVbEWY0eXsknVoqLYp+YPekCNELZJUwAJH5sX0Q1Iz1Ov
 ugi9vY+1uALjg8d9tp1m7NoJDpPovq4ezKu7rM/7CLlopeCOJsIRIVeAlhqE/fGk4AX3
 SJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723788358; x=1724393158;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Db0RbgpMk9789rCRLh18uSjBnUcu8VNyPlg0EDa+0gY=;
 b=AX8pilBI7etIG5nmLKtwd7dK1bbc626rCOWlnpZISNkLvTJs1iqPUNhGKkHPZvMi7C
 Q1u0nzZWXTirTyz0PVyTKvHPcu35BS/4yJczop9gbzJis3/S0niEfZ0/VVNA7bEbqVw0
 Mv7BUzq5i2yMdOWNSrQfuKX+V9HZxlfPFW5Gxhfqb6SdS4tKmyAUDZzlreR/1E3R/bbd
 yh+XZYFmNsple8qzLz55mmvIcHY/BGrDUoL2z9YdeljXvvkNlv5IzSNQvVlW0Avk80A5
 2L9SST8nzla5d1ynwXB7olNPxPH87yifgmldh4vqF3t30vv3stPcksu/2B+thb52/iyr
 4rKQ==
X-Gm-Message-State: AOJu0Yxlathel8u00f6YVg4lz1hvGznz9CNT/qkerquzumIsAbqnMjbo
 43rZa9BvDuYPxYLMWefTVxfGKzWyix5/cXTLhfksJt4YyqEVK5+cvydmi7qkyWM=
X-Google-Smtp-Source: AGHT+IE4KLoKUIOUL7osPBgEKHF9bgviTPf7qAdOWcvhO60IowiLr+iXJzf1jhu8CLcDW/xSr5WNtw==
X-Received: by 2002:a17:903:32c9:b0:202:bc3:3e6e with SMTP id
 d9443c01a7336-2020bc33fc8mr8377565ad.33.1723788357467; 
 Thu, 15 Aug 2024 23:05:57 -0700 (PDT)
Received: from localhost ([157.82.207.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-201f0302d28sm18967115ad.31.2024.08.15.23.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 23:05:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 16 Aug 2024 15:05:35 +0900
Subject: [PATCH v3] contrib/plugins: Add a plugin to generate basic block
 vectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-bb-v3-1-b9aa4a5c75c5@daynix.com>
X-B4-Tracking: v=1; b=H4sIAC7svmYC/1XMQQ6CMBCF4auQWVtDp0KLK+9hXDB0Kl0IpDUNh
 HB3C250+U/meytEDp4jXIsVAicf/TjkUKcCur4dniy8zQ1Y4qWspRFEolHKaGudriuC/DgFdn4
 +Ru6P3L2P7zEsx2aS+/XLjVQ7T1JIwc4RaW1bJnez7TL4+dyNL9h9wl9THQazqRGRuTHYaPoz2
 7Z9AETCDSrJAAAA
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>
Cc: qemu-devel@nongnu.org, Yotaro Nada <yotaro.nada@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SimPoint is a widely used tool to find the ideal microarchitecture
simulation points so Valgrind[2] and Pin[3] support generating basic
block vectors for use with them. Let's add a corresponding plugin to
QEMU too.

Note that this plugin has a different goal with tests/plugin/bb.c.

This plugin creates a vector for each constant interval instead of
counting the execution of basic blocks for the entire run and able to
describe the change of execution behavior. Its output is also
syntactically simple and better suited for parsing, while the output of
tests/plugin/bb.c is more human-readable.

[1] https://cseweb.ucsd.edu/~calder/simpoint/
[2] https://valgrind.org/docs/manual/bbv-manual.html
[3] https://www.intel.com/content/www/us/en/developer/articles/tool/pin-a-dynamic-binary-instrumentation-tool.html

Signed-off-by: Yotaro Nada <yotaro.nada@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- Protect the entire operation with bbs in vcpu_tb_trans().
- Reduce memory allocations.
- Link to v2: https://lore.kernel.org/r/20240815-bb-v2-1-6222ee98297b@daynix.com

Changes in v2:
- Merged files variable into the global scoreboard.
- Added a lock for bbs.
- Added a summary to contrib/plugins/bbv.c.
- Rebased.
- Link to v1: https://lore.kernel.org/r/20240813-bb-v1-1-effbb77daebf@daynix.com
---
 docs/about/emulation.rst |  30 +++++++++
 contrib/plugins/bbv.c    | 158 +++++++++++++++++++++++++++++++++++++++++++++++
 contrib/plugins/Makefile |   1 +
 3 files changed, 189 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index c03033e4e956..72d7846ab6f8 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -381,6 +381,36 @@ run::
   160          1      0
   135          1      0
 
+Basic Block Vectors
+...................
+
+``contrib/plugins/bbv.c``
+
+The bbv plugin allows you to generate basic block vectors for use with the
+`SimPoint <https://cseweb.ucsd.edu/~calder/simpoint/>`__ analysis tool.
+
+.. list-table:: Basic block vectors arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - interval=N
+    - The interval to generate a basic block vector specified by the number of
+      instructions (Default: N = 100000000)
+  * - outfile=PATH
+    - The path to output files.
+      It will be suffixed with ``.N.bb`` where ``N`` is a vCPU index.
+
+Example::
+
+  $ qemu-aarch64 \
+    -plugin contrib/plugins/libbbv.so,interval=100,outfile=sha1 \
+    tests/tcg/aarch64-linux-user/sha1
+  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
+  $ du sha1.0.bb
+  23128   sha1.0.bb
+
 Hot Blocks
 ..........
 
diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
new file mode 100644
index 000000000000..a5256517dd44
--- /dev/null
+++ b/contrib/plugins/bbv.c
@@ -0,0 +1,158 @@
+/*
+ * Generate basic block vectors for use with the SimPoint analysis tool.
+ * SimPoint: https://cseweb.ucsd.edu/~calder/simpoint/
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <glib.h>
+
+#include <qemu-plugin.h>
+
+typedef struct Bb {
+    uint64_t vaddr;
+    struct qemu_plugin_scoreboard *count;
+    unsigned int index;
+} Bb;
+
+typedef struct Vcpu {
+    uint64_t count;
+    FILE *file;
+} Vcpu;
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+static GHashTable *bbs;
+static GRWLock bbs_lock;
+static char *filename;
+static struct qemu_plugin_scoreboard *vcpus;
+static uint64_t interval = 100000000;
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    for (int i = 0; i < qemu_plugin_num_vcpus(); i++) {
+        fclose(((Vcpu *)qemu_plugin_scoreboard_find(vcpus, i))->file);
+    }
+
+    g_hash_table_unref(bbs);
+    g_free(filename);
+    qemu_plugin_scoreboard_free(vcpus);
+}
+
+static void free_bb(void *data)
+{
+    qemu_plugin_scoreboard_free(((Bb *)data)->count);
+    g_free(data);
+}
+
+static qemu_plugin_u64 count_u64(void)
+{
+    return qemu_plugin_scoreboard_u64_in_struct(vcpus, Vcpu, count);
+}
+
+static qemu_plugin_u64 bb_count_u64(Bb *bb)
+{
+    return qemu_plugin_scoreboard_u64(bb->count);
+}
+
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    g_autofree gchar *vcpu_filename = NULL;
+    Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
+
+    vcpu_filename = g_strdup_printf("%s.%u.bb", filename, vcpu_index);
+    vcpu->file = fopen(vcpu_filename, "w");
+}
+
+static void vcpu_interval_exec(unsigned int vcpu_index, void *udata)
+{
+    Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
+    GHashTableIter iter;
+    void *value;
+
+    if (!vcpu->file) {
+        return;
+    }
+
+    vcpu->count -= interval;
+
+    fputc('T', vcpu->file);
+
+    g_rw_lock_reader_lock(&bbs_lock);
+    g_hash_table_iter_init(&iter, bbs);
+
+    while (g_hash_table_iter_next(&iter, NULL, &value)) {
+        Bb *bb = value;
+        uint64_t bb_count = qemu_plugin_u64_get(bb_count_u64(bb), vcpu_index);
+
+        if (!bb_count) {
+            continue;
+        }
+
+        fprintf(vcpu->file, ":%u:%" PRIu64 " ", bb->index, bb_count);
+        qemu_plugin_u64_set(bb_count_u64(bb), vcpu_index, 0);
+    }
+
+    g_rw_lock_reader_unlock(&bbs_lock);
+    fputc('\n', vcpu->file);
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
+    uint64_t vaddr = qemu_plugin_tb_vaddr(tb);
+    Bb *bb;
+
+    g_rw_lock_writer_lock(&bbs_lock);
+    bb = g_hash_table_lookup(bbs, &vaddr);
+    if (!bb) {
+        bb = g_new(Bb, 1);
+        bb->vaddr = vaddr;
+        bb->count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
+        bb->index = g_hash_table_size(bbs);
+        g_hash_table_replace(bbs, &bb->vaddr, bb);
+    }
+    g_rw_lock_writer_unlock(&bbs_lock);
+
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_ADD_U64, count_u64(), n_insns);
+
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_ADD_U64, bb_count_u64(bb), n_insns);
+
+    qemu_plugin_register_vcpu_tb_exec_cond_cb(
+        tb, vcpu_interval_exec, QEMU_PLUGIN_CB_NO_REGS,
+        QEMU_PLUGIN_COND_GE, count_u64(), interval, NULL);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "interval") == 0) {
+            interval = g_ascii_strtoull(tokens[1], NULL, 10);
+        } else if (g_strcmp0(tokens[0], "outfile") == 0) {
+            filename = tokens[1];
+            tokens[1] = NULL;
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    if (!filename) {
+        fputs("outfile unspecified\n", stderr);
+        return -1;
+    }
+
+    bbs = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, free_bb);
+    vcpus = qemu_plugin_scoreboard_new(sizeof(Vcpu));
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+
+    return 0;
+}
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index edf256cd9d11..6936591b1022 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -13,6 +13,7 @@ TOP_SRC_PATH = $(SRC_PATH)/../..
 VPATH += $(SRC_PATH)
 
 NAMES :=
+NAMES += bbv
 NAMES += execlog
 NAMES += hotblocks
 NAMES += hotpages

---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20240618-bb-93387ddf765b

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


