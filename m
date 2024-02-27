Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1089BC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reypb-0004HQ-LU; Tue, 27 Feb 2024 09:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reypY-00047m-2u
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:16 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reypH-0004qs-M4
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:15 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412a3371133so17279295e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045578; x=1709650378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v93sjlrKGHF/8PcF+jkx1JshiyYwDWnn08uJwR8C/sE=;
 b=n67yYNZgRu7SyBFr96vQwfAKOmTJnWpfSginPOSNtGfyVbdo2DlKkUbU1wlDSxy0UD
 get9yHYDfUGcSi1q1B8gsES1eWaXDrpPsoEZb0JAwGJ3nV0u3m3GkQUL+G1+7iSJpwHS
 Vl1SYi64rcLrPecZWY69Ea59a2bOySIEDV+HvWPq+CorPDd+thB5AQcE9g4FSpOpwh9D
 9J8R5hP9OqNWNFkGPnukkia7K4DCJVJAc7FMyFiyhnwmKf0d4FN7jvWZdW4grqF7cDOG
 oXttc6XGlVl/oaAcLD2x6dOVCqBl+w3Kqc82yk2spdOvUhrBUyYcsuKRrQQ5O7zUbmOP
 eGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045578; x=1709650378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v93sjlrKGHF/8PcF+jkx1JshiyYwDWnn08uJwR8C/sE=;
 b=KLbg5TIW2aK1CEDeRoX5dpGvvvuHzffvxzo85d/pMYAFPXjQir2JrIqy2eZoNo1sGQ
 z3bfI6QS+mMPZ81UpNWYZunBv95mlepnWIbXQGfVL/9IuSRQHQs8Hw3o1mkMQ43FT+D4
 b8lTRqNs+tsdAvoHHrnSQs6xkALJFE2SL0oGCLLnL7ppeoxCs8fDyqLLsDpVWlUMaPQQ
 +Bnz3dy50enNC0BzAN9k+A0MmAduWwGiiZYElcrBnf0B+pZ27KN0xezk1kEQk9GP/eLw
 nZv0FYssY/DObHYli3r4oV9yS7iPNwcVrbrrzy/Sfx67k8zpNLtaPf+4JBZGq/fdQtTJ
 eP2Q==
X-Gm-Message-State: AOJu0YxRcQ1PQQaLO/c6lGcLfFzXVMOMn0uSp9iI/Fq4eAl6zcvN7lu+
 ixDsPmLAHoA3RvC8PBVbdfpf25tjr5P6U90UqrLthE+2Y0PEPKJvKLZhSQhQXZA=
X-Google-Smtp-Source: AGHT+IH020MKj8UmggWp8hYqds1m+lcpudmih5CLvijKgTE+IPybjsbU9+azdI/oD3UgPB86vaZqRQ==
X-Received: by 2002:a05:600c:4453:b0:412:9450:fe19 with SMTP id
 v19-20020a05600c445300b004129450fe19mr6959954wmn.39.1709045578218; 
 Tue, 27 Feb 2024 06:52:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m24-20020a7bca58000000b0041298c75ae8sm449380wml.1.2024.02.27.06.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:52:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CA7B25F92B;
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
Subject: [PATCH v4 24/29] tests/tcg: expand insn test case to exercise
 register API
Date: Tue, 27 Feb 2024 14:43:30 +0000
Message-Id: <20240227144335.1196131-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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


