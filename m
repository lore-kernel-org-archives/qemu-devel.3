Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50006C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reyip-00009w-9O; Tue, 27 Feb 2024 09:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reyhI-0006VH-6l
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:44:45 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygT-00026y-19
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:44:43 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d61e39912so2439907f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045031; x=1709649831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9WREwsMrt85roF9DpcRAV7U4Bq5TV/wSmpsUdovSGg=;
 b=AgWPV9pfuvU43azC87ybVbPTU5KbZRDiq5uTZ+PzA2sPMcilpfF04J3cPpnsT431GH
 qY4aflkR0f6X9ITFY8VU1wINjl+VYEtUo/jhQ4N+EbfxktuFjMZlksbmNLUqtA6Gkirt
 xgcM0xZMHdsgy25NKPxDps/pgNf97+gwVhjUFPEK6fFGhxVZjhDsAsl6n05FORl0qfTP
 MfR6oH0Ly5axd6sD/NL3Q0rYlyrmMOwG7AgItTiKFHJsZ9fYEIgpOwXIVlDzLxkUPqLU
 d+H2tWTC3WhAEOUJjcCQjiqaPyq5QqDFdy8yckcJuhSaBnqq0iVpdabanxg8kEwgbkee
 xINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045031; x=1709649831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9WREwsMrt85roF9DpcRAV7U4Bq5TV/wSmpsUdovSGg=;
 b=TuRKioL8DIkjnza5YuaIRdYx/JaEzXX/yHxHxm6+ZOBq2Fq8ZOHwJnEIJkPQvDKFhA
 sFa7cVRwRjIN+WtogXwkNZJHLBeZAXyuTvYnnhR738bC8S15AlGbk2QPam9o6QyGw0RH
 RGBN9FDaWpZWImAKK5SCXE7Ls8F9IufjhgPHA4iZoKOpcasJjMzQHqQp2k8HxRuFqAiJ
 IOEknfLfMB28KzHF5LuHBS4rRqM188Xd6jxbxpEgoYe3QNG63AsPK+z/dmBUh5VaZLYv
 gkgJYmvMqwKZLea3ClJHUtWllgZ7aM59cEYIvxVNXSrmGLucg4SE49x2CKDoT7z/selx
 NlIw==
X-Gm-Message-State: AOJu0YzH2odBX+hn2ymgft6hoZKVDac1gFkCr9F/oSXEvLaAvCBQbNB2
 1OGQpt1ljJHHE3nS5X82ofNp4KMNQBuRkPW6PIrEgzwYK/tY3hZkml9210C2HU8=
X-Google-Smtp-Source: AGHT+IHC2ctZlSxVMNqs7Thj8Bia/Eikbx5IWYxhjKYmf2HaHd+c83+sMztE+z/zJVi9OFYkxvHizg==
X-Received: by 2002:a05:6000:c91:b0:33d:b2ef:aca8 with SMTP id
 dp17-20020a0560000c9100b0033db2efaca8mr6767259wrb.19.1709045031466; 
 Tue, 27 Feb 2024 06:43:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k3-20020adff5c3000000b0033d8ce120f2sm11507653wrp.95.2024.02.27.06.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:43:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 203F75F8F7;
 Tue, 27 Feb 2024 14:43:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-s390x@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 16/29] plugins: add qemu_plugin_num_vcpus function
Date: Tue, 27 Feb 2024 14:43:22 +0000
Message-Id: <20240227144335.1196131-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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


