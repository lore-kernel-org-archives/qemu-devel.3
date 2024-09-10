Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3005DECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1d1-0002o5-OI; Tue, 10 Sep 2024 10:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1cy-0002R2-MX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:13:56 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1ct-0007Sx-Oc
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:13:56 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c26852aff1so6524861a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977630; x=1726582430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6DKrSbtb2UyOkFJWx3GO7dDs+1RREyLEnRKm6VRifM=;
 b=HJo7h8k0x5t/aNeCB1FTtjSocQHCZPj/t0EPjE+nzCfyc4Unvc6TIIJxGzfeHva++w
 aRcAow/vyzbuD60usyl8eyiR/Htp9iyFgVJNLiOIfwO6WIBoGfqzlHXlwFVRj3mc7cmg
 RCDeKO0uPm//yjn7+236/6g9FQzPTFlEp9k2Cf7WjKDUGdQXhH/G6y0+Ccty8wHP65sJ
 puGyho5ZspAEjiyWJfYrm57qAKRTU7Mzml+Sg8XNKhQEZK8t6ssJ8n2+wFAoe2/hpG7q
 HMKgoyDXcYK/516IZ11c+rISmvdNewjXugSxCShvPZhGnKvRcLAM2ZYc7xZ8lyI8LMW+
 +p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977630; x=1726582430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6DKrSbtb2UyOkFJWx3GO7dDs+1RREyLEnRKm6VRifM=;
 b=QbANkH72XSbr7akU3gz2VCIj5wCOfCV0Qf1EFqzjqq0qcKVv/4la3ROrfS8w+RX9R6
 wFsf/zZAbz2oXgZa7LNpTVEwg0slXoaodokJTHucQ2eeDVKyJM9VlRu0uppTCQ9ZfKNV
 flYhywR/+JDG+ncvANxYfRdrYf3SdzZWzFuL97G0tELm1qvX+bNbIkBQh7v1ruRvhM2f
 byts6ItQnoOePhTU4YWZkT+BdYBm2fSpeFlRzkRUbO9jIdXkQEd7khA0Fc3DpgoDmJ2S
 mLpvwRcEnFLXMVUaC6/iFy2c7oPGgP/v3MprDX7xydbUS7omC6f4/oGU2YibLsx99r3a
 VtxQ==
X-Gm-Message-State: AOJu0Yyhk4Jccuwfz3dHfygi3TkpVqo5Op2DeXMhRGDs5JkSoPN9eUoW
 8OUoHYxe9La4tL12C+x/Bs41ThNSq2Acn85AsM48WyzP1YZeeiyj04pSCjRyHuE=
X-Google-Smtp-Source: AGHT+IF5KrELJLIlD3YioUixACIgWYs8AgZ0uiRx0KCPrBRDFcGJOhZt0fYSh0pG54+TAZBbX9ottw==
X-Received: by 2002:a05:6402:4015:b0:5c3:cd88:a0a with SMTP id
 4fb4d7f45d1cf-5c3e963621dmr9118972a12.18.1725977629785; 
 Tue, 10 Sep 2024 07:13:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebce3448sm4368461a12.0.2024.09.10.07.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:13:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F2C9D634A2;
 Tue, 10 Sep 2024 15:07:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yotaro Nada <yotaro.nada@gmail.com>
Subject: [PATCH 23/26] contrib/plugins: Add a plugin to generate basic block
 vectors
Date: Tue, 10 Sep 2024 15:07:30 +0100
Message-Id: <20240910140733.4007719-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240816-bb-v3-1-b9aa4a5c75c5@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/about/emulation.rst |  30 ++++++++
 contrib/plugins/bbv.c    | 158 +++++++++++++++++++++++++++++++++++++++
 contrib/plugins/Makefile |   1 +
 3 files changed, 189 insertions(+)
 create mode 100644 contrib/plugins/bbv.c

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index eea1261baa..a4470127c9 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -272,6 +272,36 @@ Behaviour can be tweaked with the following arguments:
   * - idle=true|false
     - Dump the current execution stats whenever the guest vCPU idles
 
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
 Instruction
 ...........
 
diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
new file mode 100644
index 0000000000..a5256517dd
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
index d4ac599f93..bbddd4800f 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -13,6 +13,7 @@ TOP_SRC_PATH = $(SRC_PATH)/../..
 VPATH += $(SRC_PATH)
 
 NAMES :=
+NAMES += bbv
 NAMES += execlog
 NAMES += hotblocks
 NAMES += hotpages
-- 
2.39.2


