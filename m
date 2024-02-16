Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AF1C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 16:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb17J-000538-PB; Fri, 16 Feb 2024 11:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb178-0004rw-2t
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 11:31:04 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb16m-0002G8-DJ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 11:31:01 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41244cc3d67so6044545e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 08:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708101039; x=1708705839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9WREwsMrt85roF9DpcRAV7U4Bq5TV/wSmpsUdovSGg=;
 b=l4+Y5CZloaevBoepk4VwH/cDgOY0nWHE0k9EmTIrmNjhfUJXAb+ZwC+RXZE18bUOWA
 Fc54PZgp7R79d2L5xsbNnj4n7ewE2+F8hWaSnJAzXVndiSgnZgXX/f4Fx2btQtaxqdpT
 o74paxbqKo8AM6EdBT+eHfmoW8883gzf9kFgpcmkZ4k70Ajukaew6oNs8NdRsXsS++fZ
 e3nVl4QyD/vnL5Zu2uwnXNK7dKVYA9QijSyoqueIkf1J/VE6MJLCJLKngVOfCYEIfGE/
 qs+KlOJdBzfMVAvHnkFMpSTheaxLCht88byKo6cTv4ajshqMbZj2aKZDhZ8hzAdCBZRT
 0i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708101039; x=1708705839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9WREwsMrt85roF9DpcRAV7U4Bq5TV/wSmpsUdovSGg=;
 b=DDpFT58BU6s2PNmtasgIeKpIZ8P3l5zcP8a6akS+pHzJtATtoqhCP6q2KdhBHkJ+Ll
 vtsJLnG/PmaJmzGmNUycPren/Uvmz6uiF1z7OomdXOuSi7QVXyWuzqUWs6NEALsB7asB
 KM2O7q2uQt6RSDaGA0emnbIabDSYFFkf2fsPR2JBEJWqQB+97i/S21JDbbbUBqToszBS
 +20+84rCYIaN4G8ahd3vsqey7gifpXWFJLHORcsW9eYVJLz3sW2mGwALmclGbiECn5Ep
 uUWaN28CezHNrKfP9oIwW0yNgpnoupG0W4SRat7qDhaGXyfCdlv9xGGxYgydMtQ52b0+
 k0Cg==
X-Gm-Message-State: AOJu0YxWp2sYMnFvjEsD+ZObHFPvF2dMR3Jzk7erd3P2llrTQZxC2T85
 aTUiY48rDws1JDVV3zx9bXloKZ+bN1DEXjbFHG7bzmWtj0KI/P4kCI3SS0VqMPA=
X-Google-Smtp-Source: AGHT+IFLIbtAa0c9RNa/u/6gGY87Xq8Y0z3xpX0SDTf4Ogo77+0XcqOZxX9qWtU5mITWFkzmTyq8Ag==
X-Received: by 2002:adf:ee8b:0:b0:33d:174b:6a3c with SMTP id
 b11-20020adfee8b000000b0033d174b6a3cmr1734119wro.59.1708101039019; 
 Fri, 16 Feb 2024 08:30:39 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n14-20020a5d420e000000b0033d282c7537sm18879wrq.23.2024.02.16.08.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 08:30:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 972985F9DF;
 Fri, 16 Feb 2024 16:30:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Yanan Wang <wangyanan55@huawei.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 13/23] plugins: add qemu_plugin_num_vcpus function
Date: Fri, 16 Feb 2024 16:30:15 +0000
Message-Id: <20240216163025.424857-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216163025.424857-1-alex.bennee@linaro.org>
References: <20240216163025.424857-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

We now keep track of how many vcpus were started. This way, a plugin can
easily query number of any vcpus at any point of execution, which
unifies user and system mode workflows.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213094009.150349-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/qemu-plugin.h   | 3 +++
 plugins/plugin.h             | 4 ++++
 plugins/api.c                | 5 +++++
 plugins/core.c               | 6 ++++++
 plugins/qemu-plugins.symbols | 1 +
 5 files changed, 19 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index e45181c793c..93981f8f89f 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -645,6 +645,9 @@ QEMU_PLUGIN_API
 void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userdata);
 
+/* returns how many vcpus were started at this point */
+int qemu_plugin_num_vcpus(void);
+
 /**
  * qemu_plugin_outs() - output string via QEMU's logging system
  * @string: a string
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 90f3f324ab6..00b3509f708 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -44,6 +44,8 @@ struct qemu_plugin_state {
      * the code cache is flushed.
      */
     struct qht dyn_cb_arr_ht;
+    /* How many vcpus were started */
+    int num_vcpus;
 };
 
 
@@ -97,4 +99,6 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
 
 void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
 
+int plugin_num_vcpus(void);
+
 #endif /* PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index 2926b1961a8..116b8bd603c 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -342,6 +342,11 @@ const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
 #endif
 }
 
+int qemu_plugin_num_vcpus(void)
+{
+    return plugin_num_vcpus();
+}
+
 /*
  * Plugin output
  */
diff --git a/plugins/core.c b/plugins/core.c
index ee2fa41af9e..caa66311351 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -213,6 +213,7 @@ void qemu_plugin_vcpu_init_hook(CPUState *cpu)
     bool success;
 
     qemu_rec_mutex_lock(&plugin.lock);
+    plugin.num_vcpus = MAX(plugin.num_vcpus, cpu->cpu_index + 1);
     plugin_cpu_update__locked(&cpu->cpu_index, NULL, NULL);
     success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
                                   &cpu->cpu_index);
@@ -570,3 +571,8 @@ static void __attribute__((__constructor__)) plugin_init(void)
              QHT_MODE_AUTO_RESIZE);
     atexit(qemu_plugin_atexit_cb);
 }
+
+int plugin_num_vcpus(void)
+{
+    return plugin.num_vcpus;
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index ca806000d54..adb67608598 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -16,6 +16,7 @@
   qemu_plugin_mem_is_sign_extended;
   qemu_plugin_mem_is_store;
   qemu_plugin_mem_size_shift;
+  qemu_plugin_num_vcpus;
   qemu_plugin_outs;
   qemu_plugin_path_to_binary;
   qemu_plugin_register_atexit_cb;
-- 
2.39.2


