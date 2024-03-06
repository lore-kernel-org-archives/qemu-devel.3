Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E620C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsSF-00081X-6V; Wed, 06 Mar 2024 09:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsSA-0007mg-2O
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:41:06 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS2-0001V3-DB
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:41:05 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412f8bf3718so3790335e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736057; x=1710340857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WeX6qqRx0pytmE8w24sI4eHsdCeMyxlJGMKYFHwnPzA=;
 b=Jrl6vp6FJoF1hfOaItWg19v2bqoONNTZzRqhlV0Qgm70YZ9pUmP21i5Ibgzyu21wzm
 sgXdVsEvo5Aex7jcNXUUotcohsuKgGqSS08msI+z2OhrUCpVT4AxSzGVo4e38HIWB7oV
 C3822CCXxRMmYctOBV4ro1W+Jud4bAiW1th4GL74DGxUUCBZ4TkeaW6G/mtB9OxHw6o1
 Wmowt2Jb6AXWidwTRvLaptbxUdqFuR/fSiplnMqfOw0C/b7b+AVDEm2my3KrvRtSKubO
 1Bs2F78hI8mJjLtgSCjlKyNR63znSf5gsJ4FYojypI9AbZF3qgAy15lLLV8l4nH+gu/H
 LBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736057; x=1710340857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WeX6qqRx0pytmE8w24sI4eHsdCeMyxlJGMKYFHwnPzA=;
 b=Orgfzvpgm3dKZZoClUM0oXMfFkNtW43j70Vb+NiaoYwwniQUTZag3900Pr0Emz/5xr
 Lh2UtqAiu3q7guaCcqCi/AjfmB1ocp+VrKU4tRzGKzAimMg74kx3qTJY059l5kw024Re
 2Jl/gHf2QqRuYOKLB3F1KIyvj3kDhWkNXO206hgcn5yDoxdrlxtANYcA3EHFVPFaorsY
 PfTRZKqqwHuk+ehhtcRbWnt1EuzoReIL3njJvlTqnV/J741YxyU9oJTQdTuX1I06jqFH
 VFxIoqCS1hxsnHp9AMGB54PpG0ELfpiWroDll0MlvWML2f+9ragTTx8HjbA+4p6vBkHH
 jaeA==
X-Gm-Message-State: AOJu0Yzm4GPVk3xBQShuRRxEWyb4J7WpABJh0oA51qEfsa9+OvPdagt+
 r3xryeuNEEC9tHDHsDeNlpzSPWkbmN9VuiioQEmf/j49Vlt/VmPsqsxCXUGVGbul5bMhBSr5U5o
 a
X-Google-Smtp-Source: AGHT+IGKjqxDyhYCDrBbE7jw8x5AzFB43vP4bKaS8fAN6f3X6A8yD93/9zXoml9lT4ckokQuBfftNQ==
X-Received: by 2002:a05:600c:1c9c:b0:412:e675:f807 with SMTP id
 k28-20020a05600c1c9c00b00412e675f807mr5295062wms.31.1709736056647; 
 Wed, 06 Mar 2024 06:40:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o39-20020a05600c512700b00412d60cb914sm14475022wms.5.2024.03.06.06.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5CD1D5F9E0;
 Wed,  6 Mar 2024 14:40:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/29] tests/plugin/mem: migrate to new per_vcpu API
Date: Wed,  6 Mar 2024 14:40:31 +0000
Message-Id: <20240306144041.3787188-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
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

Reviewed-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240304130036.124418-7-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-20-alex.bennee@linaro.org>

diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index 44e91065ba7..b650dddcce1 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -16,9 +16,14 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-static uint64_t inline_mem_count;
-static uint64_t cb_mem_count;
-static uint64_t io_count;
+typedef struct {
+    uint64_t mem_count;
+    uint64_t io_count;
+} CPUCount;
+
+static struct qemu_plugin_scoreboard *counts;
+static qemu_plugin_u64 mem_count;
+static qemu_plugin_u64 io_count;
 static bool do_inline, do_callback;
 static bool do_haddr;
 static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
@@ -27,16 +32,16 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) out = g_string_new("");
 
-    if (do_inline) {
-        g_string_printf(out, "inline mem accesses: %" PRIu64 "\n", inline_mem_count);
-    }
-    if (do_callback) {
-        g_string_append_printf(out, "callback mem accesses: %" PRIu64 "\n", cb_mem_count);
+    if (do_inline || do_callback) {
+        g_string_printf(out, "mem accesses: %" PRIu64 "\n",
+                        qemu_plugin_u64_sum(mem_count));
     }
     if (do_haddr) {
-        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", io_count);
+        g_string_append_printf(out, "io accesses: %" PRIu64 "\n",
+                               qemu_plugin_u64_sum(io_count));
     }
     qemu_plugin_outs(out->str);
+    qemu_plugin_scoreboard_free(counts);
 }
 
 static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
@@ -46,12 +51,12 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
         struct qemu_plugin_hwaddr *hwaddr;
         hwaddr = qemu_plugin_get_hwaddr(meminfo, vaddr);
         if (qemu_plugin_hwaddr_is_io(hwaddr)) {
-            io_count++;
+            qemu_plugin_u64_add(io_count, cpu_index, 1);
         } else {
-            cb_mem_count++;
+            qemu_plugin_u64_add(mem_count, cpu_index, 1);
         }
     } else {
-        cb_mem_count++;
+        qemu_plugin_u64_add(mem_count, cpu_index, 1);
     }
 }
 
@@ -64,9 +69,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
 
         if (do_inline) {
-            qemu_plugin_register_vcpu_mem_inline(insn, rw,
-                                                 QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &inline_mem_count, 1);
+            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+                insn, rw,
+                QEMU_PLUGIN_INLINE_ADD_U64,
+                mem_count, 1);
         }
         if (do_callback) {
             qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
@@ -117,6 +123,16 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         }
     }
 
+    if (do_inline && do_callback) {
+        fprintf(stderr,
+                "can't enable inline and callback counting at the same time\n");
+        return -1;
+    }
+
+    counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
+    mem_count = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, mem_count);
+    io_count = qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount, io_count);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index a4c25908fb7..f21be50d3b2 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -168,7 +168,7 @@ RUN_TESTS+=$(EXTRA_RUNS)
 
 # Some plugins need additional arguments above the default to fully
 # exercise things. We can define them on a per-test basis here.
-run-plugin-%-with-libmem.so: PLUGIN_ARGS=$(COMMA)inline=true$(COMMA)callback=true
+run-plugin-%-with-libmem.so: PLUGIN_ARGS=$(COMMA)inline=true
 
 ifeq ($(filter %-softmmu, $(TARGET)),)
 run-%: %
-- 
2.39.2


