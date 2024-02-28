Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46152C54E4A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIZ2-000680-Ev; Wed, 28 Feb 2024 06:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYx-000637-Po
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:27 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYo-0005nU-B8
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:27 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d9c3f36c2so2988901f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121437; x=1709726237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGh0F9vXnLs+GgGKHlkYhRQ+Pky5JpZ1BGhQUHUGXNk=;
 b=dQQJPfnimitOjKVmF51NenK71jBuEvuL2eqhXiycUUfoRlEyvPQ/7BVEqm6NNRBPzl
 2mR6kqbCZaKQtOlVCHV7LScxr6YfI5Zxkyb/arFbQHV5cDjMA5smu1Gk8t6uMj4T3BfS
 NiTAK+yFjcZDIq57pDnDWzzZZ9CnEr3Jnxk/rf2OF6hqfZv5DgFpxap04sVOnINEGpY2
 Rrk0fWjY4FkTQ8+3m7Z/E69s31BgvXW8HKBredOzwmUPDT/0qpg0Mh6njh6hUYI3umos
 w0BaK36yFHeHPG95K6LN49Whz3Hw+df0EXvGb81AdBWxlmV3mufqBxtWspiD+uhikPQj
 BQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121437; x=1709726237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGh0F9vXnLs+GgGKHlkYhRQ+Pky5JpZ1BGhQUHUGXNk=;
 b=SNiDPHeTwQXVnh4c/jHzxLhzIUn2JQpWzj+rlGaSDFv8sQjYSgnFrb3x5PAaN17aUa
 TRNWs8VD0OZWPKBCu7ifK2KDDhVJJE4jVV7viHuJd6qHKehWUEqzetpdPUL4CVOnicbs
 YJQstlXzLdilzw//9+BUZFkBpsRC7iDg07zHdSwmsD/pd5XWfaK7v5j11jjezC4opzxl
 o941GU5h2wnSW1ON5P7Eg3moJcRv4ILxV14Dv1K0m+Oy7uNvR9Q0Ir9fJpACp4OO5Hli
 cMkOYHes22U6OtxDfVribzKOOxdcwbubk4AdVrDKqu30pr0+ugaQD481tWnThGh0QB4u
 bdOQ==
X-Gm-Message-State: AOJu0YzgZdMPjt4xebH2l4IyPT+8tY+C/ULamNHtgJp036bft62hyJNX
 odbf675Mjq0eRJ5SY/NocCWmEZxHMvyduUvgCt2q47Sf5bj7+Fr6gAh4y/KQmbM=
X-Google-Smtp-Source: AGHT+IEX2RX157cS7WGPu3qoUdrMr0O8B5ky2cyTFoTAGhSVdoA38A+eMAhBJNlxPajlWijXaB2QVg==
X-Received: by 2002:adf:f8cd:0:b0:33d:44d8:eacc with SMTP id
 f13-20020adff8cd000000b0033d44d8eaccmr8478871wrq.39.1709121437052; 
 Wed, 28 Feb 2024 03:57:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bp19-20020a5d5a93000000b0033d4c3b0beesm14928545wrb.19.2024.02.28.03.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:57:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D7A65F8F7;
 Wed, 28 Feb 2024 11:57:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 16/29] plugins: add qemu_plugin_num_vcpus function
Date: Wed, 28 Feb 2024 11:56:48 +0000
Message-Id: <20240228115701.1416107-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We now keep track of how many vcpus were started. This way, a plugin can
easily query number of any vcpus at any point of execution, which
unifies user and system mode workflows.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213094009.150349-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-17-alex.bennee@linaro.org>

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


