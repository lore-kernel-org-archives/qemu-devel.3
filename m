Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D80EC54E4F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYhO-0005Uo-7B; Fri, 23 Feb 2024 11:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYQ8-00060T-9a
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:29:08 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYPp-0007GH-Lq
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:29:08 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41279203064so3895505e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708705727; x=1709310527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v93sjlrKGHF/8PcF+jkx1JshiyYwDWnn08uJwR8C/sE=;
 b=P5wmz2KXmq5DA/Wn7dvF6QOh+RJ2/ESv+NFrOJQh/K1/q9lqqqSH4BQ5QgRl+YtqBY
 oOUfQk14A+luaim8vTihVlpqlyZtT+V+lUzE5GDfmvud+Qw5HY+di7ANX9wWDgveG4en
 JFi8KAr2DlsD4zA82DTbA2swHQjmjPyinqs/fQQCJ71BPx8ZA1LvH0m+TfFWRRloeeRE
 NqQkCTZxgKkbqKOq46Oe7b2HECfQD2/JanlB+XZPAsijqm5tJuOcJCDzda9r7D28Hh9x
 5arcZfUxH11PH9y+/M+AGBbnhMW8ahB4FE7NJlWReWOrXckHWGjwtu3ejCP3XIdVN8gU
 rrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708705727; x=1709310527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v93sjlrKGHF/8PcF+jkx1JshiyYwDWnn08uJwR8C/sE=;
 b=kzUO71XSn6aqOBF9pXOafMulZjs9PCq64JqPU8EMFUB2Ta2QzwUYYEqfBH6I8tgQTK
 5hWvIjVOSfWYqsP6oGUDGTbLN24TbAV1rvKBvSGYJks/z1AAyT4kOuBRrfhAINyi+yUj
 zSK1QmoZZrOQmFZYsExhQVpqo/UyeQ8vM7UfeZuQZ4EgwW492wuQM6HpJIOfqR8kd9cA
 5FOz8T5n7dgvJ/XtHrQZ6omGAPuEzktUzdimo7p9wAiGLzrU/oy3sANwWe9ou4A2onYo
 q44izSWwZ5aDYKUG7gIo1k3or140iGOrWIEz0uj+QIq71frcTARZ1IUmPaEjM/gTEbjU
 IFSQ==
X-Gm-Message-State: AOJu0YzUHwq8ps/4FVLwfyWmwV75UKMnRIUP+LVu+O7qGwEduC24Ls9O
 ntMLEYBypJNxZrI33lJhIqcx77r3/1OcFjD7WBuVTSmpM20QE9ZPul4qqAl04Xw=
X-Google-Smtp-Source: AGHT+IFJX3j8WNIiG37f+6z4x20vf6Wilkp11q2CNT6aXatRexEkzJ6uHcRfvDn3gmt2JRDHSg37mw==
X-Received: by 2002:a05:600c:4e11:b0:410:55a:5458 with SMTP id
 b17-20020a05600c4e1100b00410055a5458mr205838wmq.31.1708705727123; 
 Fri, 23 Feb 2024 08:28:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z6-20020a05600c0a0600b0041266f5b041sm2984923wmp.34.2024.02.23.08.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 08:28:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9C7235F938;
 Fri, 23 Feb 2024 16:22:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, qemu-s390x@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bin.meng@windriver.com>, Yanan Wang <wangyanan55@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, John Snow <jsnow@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 22/27] tests/tcg: expand insn test case to exercise
 register API
Date: Fri, 23 Feb 2024 16:21:57 +0000
Message-Id: <20240223162202.1936541-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223162202.1936541-1-alex.bennee@linaro.org>
References: <20240223162202.1936541-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

This ensure we at least read every register the plugin API reports at
least once during the check-tcg checks.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/plugin/insn.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index 5fd3017c2b3..54da06fcf26 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -46,6 +46,25 @@ typedef struct {
     char *disas;
 } Instruction;
 
+/*
+ * Initialise a new vcpu with reading the register list
+ */
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
+    g_autoptr(GByteArray) reg_value = g_byte_array_new();
+
+    if (reg_list) {
+        for (int i = 0; i < reg_list->len; i++) {
+            qemu_plugin_reg_descriptor *rd = &g_array_index(
+                reg_list, qemu_plugin_reg_descriptor, i);
+            int count = qemu_plugin_read_register(rd->handle, reg_value);
+            g_assert(count > 0);
+        }
+    }
+}
+
+
 static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
 {
     unsigned int i = cpu_index % MAX_CPUS;
@@ -212,6 +231,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         sizes = g_array_new(true, true, sizeof(unsigned long));
     }
 
+    /* Register init, translation block and exit callbacks */
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
-- 
2.39.2


