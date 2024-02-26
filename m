Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FDFC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeOT-0005eO-Cs; Mon, 26 Feb 2024 12:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeNe-0004PV-BU
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:03:11 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeNN-0000pO-U8
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:03:05 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d28e465655so11979381fa.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 09:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966968; x=1709571768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v93sjlrKGHF/8PcF+jkx1JshiyYwDWnn08uJwR8C/sE=;
 b=P9aEdzqtR5Hy+CkVZofR9lKcj/UbNq1xJzNu+J9orYvOg6HSjeigOdbuX94S8wJnrS
 +proRR1Gu3FhGjD9vTL8B7UB/U2Q86EWIXlZjqun37Soe2NNrNbpAdemMe75bI0N5kNa
 vdrEQJrbRTZltynp+H1C1C+l2+GSzmMeG5+XJAubm4KPfFz1hHZ49xP6z+zPY8pdEe+F
 McbUrAtnAYcemkpTVSY1wrqCAgk82nHruiq9/10n8gZoI1zwv3emaCIn64ELRMAc4Gfk
 rtcEMeoW0ZzHq8kq7FgO/yHqOWLN7UoML679IjdlxIGtEDsRdr9DbY+2pVQu0pPO5jSq
 cFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966968; x=1709571768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v93sjlrKGHF/8PcF+jkx1JshiyYwDWnn08uJwR8C/sE=;
 b=jjAPQVJarlpxDqC4iHCbO4BxnuwWdkXRqOftyma0sadADI9c5mHJWXkBD1Zn5Zn+tN
 fo+l/fN3f9FE7EB3i0vRCYWD7AnrXPf9BzlOmKhi7Izmvo9yBAgFECXjpgtNfhCKtDB7
 25W+XdoQsGD3ldAjHXg2EjLbidRZP6PFpB+ysBtEHU0YyGEIeGfu+6repB38JBrOARrg
 b4O494luqgv24PYcLyFRmeM+UqzLJU5H0bYfE3UKUrBkEXW+/tUnfxzW/8XsQhqns0iy
 etmZ6R14KXrcU5ToTiC3gtjVGboXwVzRDNCrv61bjwED7hCBPJMvS5KPA/nwFIrbHxCx
 Y8CQ==
X-Gm-Message-State: AOJu0Yzi1ufqFMq4cHkJQO4qnR7SJp2cLASsh9fmJf0ebQ1IU+guEeDd
 Vmaz1tqcCUXvM+QV8vX4B7Uyy9X0Pe+NMejs9Snzo5Vgqo7wEPvRkNGWzKkytIs=
X-Google-Smtp-Source: AGHT+IGbDugMR0kDdCrbQaJkrbtleHSHhjIH2zSNNRFtFTPf/4DMzgoMm5ynIOMjVnPd+x1jOaDl1A==
X-Received: by 2002:a2e:bc19:0:b0:2d2:6ed5:e45a with SMTP id
 b25-20020a2ebc19000000b002d26ed5e45amr5648419ljf.12.1708966968037; 
 Mon, 26 Feb 2024 09:02:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 20-20020a05600c22d400b0041069adbd87sm12429148wmg.21.2024.02.26.09.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:02:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DDFA65F92F;
 Mon, 26 Feb 2024 16:56:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Brian Cain <bcain@quicinc.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 22/27] tests/tcg: expand insn test case to exercise
 register API
Date: Mon, 26 Feb 2024 16:56:41 +0000
Message-Id: <20240226165646.425600-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226165646.425600-1-alex.bennee@linaro.org>
References: <20240226165646.425600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x231.google.com
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


