Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0390EC54E56
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIeY-00053x-05; Wed, 28 Feb 2024 07:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeR-0004qm-La
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:09 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeM-00035S-Jj
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:07 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412a14299a4so30083385e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121781; x=1709726581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cnCNv8y43FexcD7a6Rtr0pLIxQ1zciWAgu6ycEDUXY=;
 b=HQfM91uZaFBNHPv4q42sC2CTcSwBQGZLSkMsUnM1BHvfLYO2vbw/f0hxXadl5gpJq1
 i2/B+7dXrEywiZXBC4YyVaHm4wlCId2BBHCihkIAmGF7AiLZblZRjX8BlCkclCt9a6Wd
 kbUqSm9tM2il2F9FsUTssoVCs+MhWKlU0z9spcoeOLcZH1ztx3lLdfNPi8/6dPp/JoPG
 ao6ZTeRHsygrXaXFImCKACpDcJ6iAd1hWieTjVq/u/plXo7TPBSEv0Qi48dUNZ9o+fF1
 uG/D1YFbUDadMbVXiHSP87LWDwtMfduZoRaaw9O65Db+1T9cxnA8W4Xuq+ZbCb80O3wL
 aDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121781; x=1709726581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cnCNv8y43FexcD7a6Rtr0pLIxQ1zciWAgu6ycEDUXY=;
 b=taJ86oxmDAj8Imqb9wiC9gpp9ixNkTqhbVK9nvmNc9lDMhQ3qeWM4IOlc2J0HBwYP1
 +iUKdSixJ3mQL2+PszyvLKKjo80kXlhx81F2L/XjSh9a4ok8WG5pAu0p+R0Nj4cXDvPM
 wgjKqDhTl/mk45KbYIJIL7LLQ0XgP43PMJBdGybCjF+95dPAWgpUYfKRnu023sX75ygT
 2Dbgk3Q3+m07P3iZ3W7crL81E6nRgRpfGuYZx6qlKPTvPaq4PTIOg2nY86+ewv9guxMR
 a0ePP++5chZkkM6xjUuJYbcvG60ljb4ROTX85EMazLE5adnPx+EgPc0H3piOdbtmEQEd
 wFMw==
X-Gm-Message-State: AOJu0YzaQS5z6cCrl+piyOMDmNjY/IBJvSjV+L4okaoKRdDAcMs0TtQZ
 uUdC5VaLWOPaGzY5KDK9Z6z60EmUX+vs5KiZbM5hkbSqv0KTjqG8EF+mrj13ndA=
X-Google-Smtp-Source: AGHT+IG1n88UEjPJO45t7opgDRZwz7qJrlyZRM6/Fn5rgfBilw2L/RB+y93V2DAati0ZQwrpineQeg==
X-Received: by 2002:a5d:484a:0:b0:33d:b01e:c4d6 with SMTP id
 n10-20020a5d484a000000b0033db01ec4d6mr8741219wrs.17.1709121781204; 
 Wed, 28 Feb 2024 04:03:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bw1-20020a0560001f8100b0033af3a43e91sm14608368wrb.46.2024.02.28.04.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 04:02:59 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3CCA15F92B;
 Wed, 28 Feb 2024 11:57:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 24/29] tests/tcg: expand insn test case to exercise register API
Date: Wed, 28 Feb 2024 11:56:56 +0000
Message-Id: <20240228115701.1416107-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20240227144335.1196131-25-alex.bennee@linaro.org>

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


