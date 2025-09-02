Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5F7CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLnP-00077P-AN; Tue, 02 Sep 2025 03:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnH-00074d-JN
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnB-0001uc-F6
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:07 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7722f8cf9adso3484609b3a.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 00:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756799457; x=1757404257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsrgAwcfXPf60wLi3R10FjsXpsAPM+d7uJ0mGFTRCRw=;
 b=tMSX8xRRGdeOatBYYgof1RALpPvJFmxCpaQDoY6FaqwGyl/fj9dIPU4NiwpiL1iW3n
 B+tW+fLVXyYP7APyOOHimtxtyaeFZnrtvo3y1JD1MjfYfHp8Xv5gx/zrVXYAATkIMExj
 lunPRAA14JuympQWFmUu9s2nzVxgAbcSxi0zDrwwdET+UalonnKBrWUiGmTxHfyUQGGp
 tFTyE+PaJLWkzeLcG3P+n2/OP99OaxJI2tfPYpitadXtUmpoW9W/Uy/OQ4n8OqNKuzg/
 bI2nmkL9g6i1YD1DZVNtvyHaLbfUS3UpOGMDPHfgIf4NHIxuX9bT3PWUCMGYpXjAjBkV
 ZZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756799457; x=1757404257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KsrgAwcfXPf60wLi3R10FjsXpsAPM+d7uJ0mGFTRCRw=;
 b=TvRvnhCd8XtTEXtic82lg5Lnin2F88ObumbMCLIrd7TXuOWBhjjOgGUQPxomUB//lI
 m/EXGahcJy90U/aYer0ablMWtQhMLoqBjtMb7SLFtpvS1e/MTz5K46muM4/rkgD1JCzy
 Qp5McMNXvQW3pJZ4NiIQmWOaHRXFLjZ3D/q0/hgojx7In8ChxI/oyZ9+okRifuQTLew1
 qtJaqtWu4PGNmVtwzyWMpTJGINZRIJav23J5iHfptIbifADnseYrAYwZVgnEKrLLfGHh
 tRPHAqSQIqu06Y3hIjXFWsBm2xYUkRILU66yzHp8f5+eqF7ZedQnGzdJ7gI3Gpc49taa
 yUaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxcBLP6iTqVGwlQn/XoIuCYCVnViS3F7KE+PFo6Dpy9Tm/orslDD7f6N7S41VEpKFIrjnDPTxwUFhQ@nongnu.org
X-Gm-Message-State: AOJu0YyiY4Im3axeuhVMMAf06BQk8bk3CzXC+alW34KDNER7hYa980Hf
 YDv+NXXcIX5k+eqZqEqXiBrxH2yaGPO52IQJXySaJWMmBj44bFiRBTmPv+vIvixwJn8=
X-Gm-Gg: ASbGncunnH++rZVRP9K1PdDvfiBf+Kx5ost8MTiHF4xFrzNyEMrgjxlxdFytrefyGfm
 OTpNrnzGPDC21enZsfF2JSxTofBhkLfK22V0KMoMo2hXU4C5MFNHqw4mkQSL71LmE5YsKYJ1Pa4
 XpRnAwIWTN/KjOzYwc4yE1nLn0I/tmmT8Wbfbo4kWcHHl6aV3+ST5l2EvHMP3MfWVbTPihTJol7
 lLqGFcVNOXMQcTLfR0ZVcewDfGm+07TbMjUSr7CgVUC55+bR7RExyApS9/5sHIzhnDQ6PXZP6Jh
 pusVBTVIhmfHN4Wxfl54ZfyHb3avJdp8wYgsNSfUCFJsugHRC89+8dS0NZBR6URsTeiE+lZP7gn
 CpsMnK5Da0wetuyeyEE26ZF8wEwILuhQZ2X9n2XMGPVc=
X-Google-Smtp-Source: AGHT+IEnwkRQyoajQ+wzO1OBiSDoxbHYacNaBxleMIW05ToiFEKgPiq2iScaYZJlnmLRKoKx53Yw3Q==
X-Received: by 2002:a05:6a21:33a8:b0:243:9b4e:281b with SMTP id
 adf61e73a8af0-243d6f40ef6mr14322782637.49.1756799457122; 
 Tue, 02 Sep 2025 00:50:57 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7723d79fcfesm9642766b3a.16.2025.09.02.00.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 00:50:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v7 1/9] contrib/plugins/uftrace: skeleton file
Date: Tue,  2 Sep 2025 00:50:34 -0700
Message-ID: <20250902075042.223990-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
References: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We define a scoreboard that will hold our data per cpu. As well, we
define a buffer per cpu that will be used to read registers and memories
in a thread-safe way.

For now, we just instrument all instructions with an empty callback.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c   | 73 +++++++++++++++++++++++++++++++++++++
 contrib/plugins/meson.build |  3 +-
 2 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/uftrace.c

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
new file mode 100644
index 00000000000..4af0130b159
--- /dev/null
+++ b/contrib/plugins/uftrace.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright (C) 2025, Pierrick Bouvier <pierrick.bouvier@linaro.org>
+ *
+ * Generates a trace compatible with uftrace (similar to uftrace record).
+ * https://github.com/namhyung/uftrace
+ *
+ * See docs/about/emulation.rst|Uftrace for details and examples.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <qemu-plugin.h>
+#include <glib.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+typedef struct Cpu {
+    GByteArray *buf;
+} Cpu;
+
+static struct qemu_plugin_scoreboard *score;
+
+static void track_callstack(unsigned int cpu_index, void *udata)
+{
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
+
+    for (size_t i = 0; i < n_insns; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+
+        uintptr_t pc = qemu_plugin_insn_vaddr(insn);
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
+                                               QEMU_PLUGIN_CB_R_REGS,
+                                               (void *) pc);
+    }
+}
+
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
+    cpu->buf = g_byte_array_new();
+}
+
+static void vcpu_end(unsigned int vcpu_index)
+{
+    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
+    g_byte_array_free(cpu->buf, true);
+    memset(cpu, 0, sizeof(Cpu));
+}
+
+static void at_exit(qemu_plugin_id_t id, void *data)
+{
+    for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
+        vcpu_end(i);
+    }
+
+    qemu_plugin_scoreboard_free(score);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    score = qemu_plugin_scoreboard_new(sizeof(Cpu));
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_atexit_cb(id, at_exit, NULL);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+
+    return 0;
+}
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 1876bc78438..7eb3629c95d 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,5 +1,6 @@
 contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
-                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
+                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
+                   'uftrace']
 if host_os != 'windows'
   # lockstep uses socket.h
   contrib_plugins += 'lockstep'
-- 
2.47.2


