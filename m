Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FA9C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTeA-0003K7-Ez; Tue, 05 Mar 2024 07:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTdL-0001wJ-RP
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:11:04 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTch-0001Sn-Im
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:57 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d3f962a9dfso1389221fa.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640616; x=1710245416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VG+vqVHI2D8wuj5SiQHhSx5sLWIahnozHpwqdxtQshU=;
 b=k9VYLTJHcMSt7lJHxnp5NHbHU/ASoXrvFu/4CEP1nQA8u3HtmJL/uO+RfPdIwHANMt
 saJhf2MCdiKFfrN3aOhdDgSADWO0qqHWRHA1jz3ZqTaGJXcuelYpw9+CQSWvT4P0IaPp
 oOx1MuDoYvGEGatoPdKQoPiodBY0gwCEuootQWzs/Jh1aLznvmxMYLke1411AbqGdmsO
 JCgzLF8MtFilGWwzG0L5yTyhqOtLkFXmPlGcbYfcoJpb7rcoFXWKNKdEg2Uhx2JB/ifc
 p4vNHTunk8o9Vke/G0GAVT21Txp0+pPscSZqX07KrVSzkvb3JgtUI0w0k+uTLm3tITI/
 tpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640616; x=1710245416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VG+vqVHI2D8wuj5SiQHhSx5sLWIahnozHpwqdxtQshU=;
 b=kCU5UXn8dBl+P5P380lBN9P5ZaBk4MaQXZkaWndBAAQjnADcGbPQ1lbnK/cggEHcKD
 5vNukwJs/VBzexEL3knfhGvaUmPUauHY5PFk2qCjLgFtRNhY7v1UHpvHWGa+DHTBrot3
 eQD4hjBiIlr/nKlEnwPy6VTrDcEURYswXeJY1FbdHGWSRv7FzjcDKR8NBAZX0LUOXJS+
 dxPSUcPNpg1c3c9KwcZjUCpRbFANjVQftnAfMwPr8vvmQ6d9/Y7IH99OmAypGG0caAek
 j6P20lwFIWoap+9d8Z6YQoU/8Yo7YLSmARPIN3H7DPBPNbewrSzR2E5Z3y4rMYgmjhzN
 QoKQ==
X-Gm-Message-State: AOJu0Yw9CELJXdeid3mK2jJkIxiwEEN04SiJM96EsOKqmdlW6e7G1Iwn
 hwemRG6+jrCBk3IG/cDRpr4Xsr4weQI32BYPm1WnsdKm4S8xzdbtkraWjnEgc/k=
X-Google-Smtp-Source: AGHT+IHbLe9dOlxbowVsYb7gvtIWO+DzHonkmvTsNX+vIbGtpKbA/Y1Ai2t8AtXAboR/VoVHdJ0i8g==
X-Received: by 2002:ac2:4306:0:b0:513:1cae:4783 with SMTP id
 l6-20020ac24306000000b005131cae4783mr1104721lfh.60.1709640616394; 
 Tue, 05 Mar 2024 04:10:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d7-20020adf9c87000000b0033d640c8942sm14870192wre.10.2024.03.05.04.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D029E5F9DE;
 Tue,  5 Mar 2024 12:10:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 14/29] plugins: scoreboard API
Date: Tue,  5 Mar 2024 12:09:50 +0000
Message-Id: <20240305121005.3528075-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We introduce a cpu local storage, automatically managed (and extended)
by QEMU itself. Plugin allocate a scoreboard, and don't have to deal
with how many cpus are launched.

This API will be used by new inline functions but callbacks can benefit
from this as well. This way, they can operate without a global lock for
simple operations.

At any point during execution, any scoreboard will be dimensioned with
at least qemu_plugin_num_vcpus entries.

New functions:
- qemu_plugin_scoreboard_find
- qemu_plugin_scoreboard_free
- qemu_plugin_scoreboard_new

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240304130036.124418-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/plugin.h        |  6 ++++
 include/qemu/qemu-plugin.h   | 31 ++++++++++++++++++++
 plugins/plugin.h             |  6 ++++
 plugins/api.c                | 19 ++++++++++++
 plugins/core.c               | 57 ++++++++++++++++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  3 ++
 6 files changed, 122 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index b3c94a34aa4..bf96d2c2aa3 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -112,6 +112,12 @@ struct qemu_plugin_insn {
     bool mem_only;
 };
 
+/* A scoreboard is an array of values, indexed by vcpu_index */
+struct qemu_plugin_scoreboard {
+    GArray *data;
+    QLIST_ENTRY(qemu_plugin_scoreboard) entry;
+};
+
 /*
  * qemu_plugin_insn allocate and cleanup functions. We don't expect to
  * cleanup many of these structures. They are reused for each fresh
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 45e2ebc8f8f..31c468ddb2c 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -222,6 +222,8 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
 struct qemu_plugin_tb;
 /** struct qemu_plugin_insn - Opaque handle for a translated instruction */
 struct qemu_plugin_insn;
+/** struct qemu_plugin_scoreboard - Opaque handle for a scoreboard */
+struct qemu_plugin_scoreboard;
 
 /**
  * enum qemu_plugin_cb_flags - type of callback
@@ -752,5 +754,34 @@ QEMU_PLUGIN_API
 int qemu_plugin_read_register(struct qemu_plugin_register *handle,
                               GByteArray *buf);
 
+/**
+ * qemu_plugin_scoreboard_new() - alloc a new scoreboard
+ *
+ * @element_size: size (in bytes) for one entry
+ *
+ * Returns a pointer to a new scoreboard. It must be freed using
+ * qemu_plugin_scoreboard_free.
+ */
+QEMU_PLUGIN_API
+struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size);
+
+/**
+ * qemu_plugin_scoreboard_free() - free a scoreboard
+ * @score: scoreboard to free
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
+
+/**
+ * qemu_plugin_scoreboard_find() - get pointer to an entry of a scoreboard
+ * @score: scoreboard to query
+ * @vcpu_index: entry index
+ *
+ * Returns address of entry of a scoreboard matching a given vcpu_index. This
+ * address can be modified later if scoreboard is resized.
+ */
+QEMU_PLUGIN_API
+void *qemu_plugin_scoreboard_find(struct qemu_plugin_scoreboard *score,
+                                  unsigned int vcpu_index);
 
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 00b3509f708..043c740067d 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -31,6 +31,8 @@ struct qemu_plugin_state {
      * but with the HT we avoid adding a field to CPUState.
      */
     GHashTable *cpu_ht;
+    QLIST_HEAD(, qemu_plugin_scoreboard) scoreboards;
+    size_t scoreboard_alloc_size;
     DECLARE_BITMAP(mask, QEMU_PLUGIN_EV_MAX);
     /*
      * @lock protects the struct as well as ctx->uninstalling.
@@ -101,4 +103,8 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
 
 int plugin_num_vcpus(void);
 
+struct qemu_plugin_scoreboard *plugin_scoreboard_new(size_t element_size);
+
+void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
+
 #endif /* PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index e905e995bd6..76b2e652b9c 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -465,3 +465,22 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 
     return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg));
 }
+
+struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
+{
+    return plugin_scoreboard_new(element_size);
+}
+
+void qemu_plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
+{
+    plugin_scoreboard_free(score);
+}
+
+void *qemu_plugin_scoreboard_find(struct qemu_plugin_scoreboard *score,
+                                  unsigned int vcpu_index)
+{
+    g_assert(vcpu_index < qemu_plugin_num_vcpus());
+    /* we can't use g_array_index since entry size is not statically known */
+    char *base_ptr = score->data->data;
+    return base_ptr + vcpu_index * g_array_get_element_size(score->data);
+}
diff --git a/plugins/core.c b/plugins/core.c
index 2db4d31354b..63f4c6c6ce3 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -18,6 +18,7 @@
 #include "qemu/lockable.h"
 #include "qemu/option.h"
 #include "qemu/plugin.h"
+#include "qemu/queue.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/xxhash.h"
 #include "qemu/rcu.h"
@@ -215,6 +216,35 @@ CPUPluginState *qemu_plugin_create_vcpu_state(void)
     return g_new0(CPUPluginState, 1);
 }
 
+static void plugin_grow_scoreboards__locked(CPUState *cpu)
+{
+    if (cpu->cpu_index < plugin.scoreboard_alloc_size) {
+        return;
+    }
+
+    bool need_realloc = FALSE;
+    while (cpu->cpu_index >= plugin.scoreboard_alloc_size) {
+        plugin.scoreboard_alloc_size *= 2;
+        need_realloc = TRUE;
+    }
+
+
+    if (!need_realloc || QLIST_EMPTY(&plugin.scoreboards)) {
+        /* nothing to do, we just updated sizes for future scoreboards */
+        return;
+    }
+
+    /* cpus must be stopped, as tb might still use an existing scoreboard. */
+    start_exclusive();
+    struct qemu_plugin_scoreboard *score;
+    QLIST_FOREACH(score, &plugin.scoreboards, entry) {
+        g_array_set_size(score->data, plugin.scoreboard_alloc_size);
+    }
+    /* force all tb to be flushed, as scoreboard pointers were changed. */
+    tb_flush(cpu);
+    end_exclusive();
+}
+
 void qemu_plugin_vcpu_init_hook(CPUState *cpu)
 {
     bool success;
@@ -225,6 +255,7 @@ void qemu_plugin_vcpu_init_hook(CPUState *cpu)
     success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
                                   &cpu->cpu_index);
     g_assert(success);
+    plugin_grow_scoreboards__locked(cpu);
     qemu_rec_mutex_unlock(&plugin.lock);
 
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
@@ -578,6 +609,8 @@ static void __attribute__((__constructor__)) plugin_init(void)
     qemu_rec_mutex_init(&plugin.lock);
     plugin.id_ht = g_hash_table_new(g_int64_hash, g_int64_equal);
     plugin.cpu_ht = g_hash_table_new(g_int_hash, g_int_equal);
+    QLIST_INIT(&plugin.scoreboards);
+    plugin.scoreboard_alloc_size = 16; /* avoid frequent reallocation */
     QTAILQ_INIT(&plugin.ctxs);
     qht_init(&plugin.dyn_cb_arr_ht, plugin_dyn_cb_arr_cmp, 16,
              QHT_MODE_AUTO_RESIZE);
@@ -588,3 +621,27 @@ int plugin_num_vcpus(void)
 {
     return plugin.num_vcpus;
 }
+
+struct qemu_plugin_scoreboard *plugin_scoreboard_new(size_t element_size)
+{
+    struct qemu_plugin_scoreboard *score =
+        g_malloc0(sizeof(struct qemu_plugin_scoreboard));
+    score->data = g_array_new(FALSE, TRUE, element_size);
+    g_array_set_size(score->data, plugin.scoreboard_alloc_size);
+
+    qemu_rec_mutex_lock(&plugin.lock);
+    QLIST_INSERT_HEAD(&plugin.scoreboards, score, entry);
+    qemu_rec_mutex_unlock(&plugin.lock);
+
+    return score;
+}
+
+void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
+{
+    qemu_rec_mutex_lock(&plugin.lock);
+    QLIST_REMOVE(score, entry);
+    qemu_rec_mutex_unlock(&plugin.lock);
+
+    g_array_free(score->data, TRUE);
+    g_free(score);
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 27fe97239be..3f93e7d6b13 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -37,6 +37,9 @@
   qemu_plugin_register_vcpu_tb_exec_inline;
   qemu_plugin_register_vcpu_tb_trans_cb;
   qemu_plugin_reset;
+  qemu_plugin_scoreboard_free;
+  qemu_plugin_scoreboard_find;
+  qemu_plugin_scoreboard_new;
   qemu_plugin_start_code;
   qemu_plugin_tb_get_insn;
   qemu_plugin_tb_n_insns;
-- 
2.39.2


