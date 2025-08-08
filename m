Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AB4C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 02:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukCVz-0008Ie-Gb; Thu, 07 Aug 2025 22:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVr-00087U-8T
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:21 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVl-0003Tq-3I
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:16 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-76bfd457607so1856124b3a.0
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 19:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754618830; x=1755223630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bVGAocy/p30cRQnSJIEIdT0YYjPWtKW5vU1A6Z7uqE=;
 b=omhLPQc9EqfPjm5RzTkoNa5NQFSV2XzQbihRG6bWXxWstRRCM8pfBEzRmHxP3Pb8Vp
 uhHBKJt3vO1cPkYpMnkK851nrGwen6LaYMT6mn+4fY4Q5b2z0A1rTRdioU8dOqkn4ymm
 JglkqDuwb+r7zfywESq9MHXWhvys09eg0BwHMVUcM1am4GdR2/2Z4S47Q4vPOfcCiOcq
 hW8ynFOFJV5Wz60WOCbNhQNm6EI7nFseoI+DFiEiL+awunAYMwBDq2P7CsyQuAAUAJ5k
 b/Mn5AGmoSd6uFwHd921gpNwgRqmXf1C2+IQJ9AXyKXFgq/8W3UJF4FcVMsCwwNS9t5r
 iPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754618830; x=1755223630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bVGAocy/p30cRQnSJIEIdT0YYjPWtKW5vU1A6Z7uqE=;
 b=Zd1CIxvq78gk8n15VHNuCSE07i7zDlDJlpAUK5v4iJbPf9P5XkuZ6EjRRFPP5bOS0N
 hEcBH5/9wz1Jp5C409skk4LpVSgaUX/mTudDuJzodqeN55k9QaBmSppKXYRRPPceq4RW
 lKaf7j2TbQ9c6xMscaGuNc5LXfbwFokbalBQd7Tp9zDd38Yjo1cLcd+5dXm6yC3hxoIw
 VIGsa621CY/mSo3bcY2dShId17WC0WR6NsNmmuvI886gO7pJMi4EEzStq/V7xZHTHvTf
 nUHoV3Yq7mDy9jKqH9jRDKS/FaWDT/DKJcs63Y0J7FlmNY9nCtWsnFCcTKKrnGAULdhL
 4IBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6ELKsAEGya4J28YLYCNcxbBLwde9wWv/xuL3RByy+eLMrVXxnLDuYvZY6wL3Vx1eaxlWFYP6ZSKEx@nongnu.org
X-Gm-Message-State: AOJu0YxFn6iFX+fYWgNxFdgfTcU6YzAFepJCfmH2LTZAeRfwHa+hVsFF
 suGomU3fV3F0S4G/pqQZp2kqD0T0Djm76CeOwE1viw8GbgsL6aQjC+e/Os69MTlnoTc=
X-Gm-Gg: ASbGncucBS1V/bNG3aVeJq5zz1mmz7Uj/31/RB87Zd4DnQKVphZ20M9xrPG9LTa8ge6
 DTU/y17sMdeTZxtHyBTjTZdS8+q3+9aqwUDO0fILo7gBIiChtDoStgwnlshgfbUznlmB6qd00Hy
 FxMt1Bh7MblhhouBAdDH2cMVXLZ0SjDrCxuGwm2BIlgdBeXm4UpF47xOeMb7wZHBd7xVs7gfZ06
 fwBWyxUnuBVjKxY0YqFFcfFf8AXWCCEu7tmg8DLwu9lLqzinvGH0Bfzce9IH7lC+noaQD0IvYD8
 OyJYXm4CBSDDTdUxvF2VLNyU7b6CTEVzAr2NOK6kyDO4giYE8mBHLRhQZ4CIrrSh1liv2BQ2IyA
 VNoAh/LbXdqyftq0YYozq16Uhupi+i0nD
X-Google-Smtp-Source: AGHT+IH3Be9dZzteoUcJfUbVf8jV8IrOozBi+ocNCD/eIP27gXSCLuyIzmuTXFg1JoYVlDQ+vt7Llg==
X-Received: by 2002:a05:6a21:6d96:b0:23f:52dd:2d13 with SMTP id
 adf61e73a8af0-240551f8755mr1785483637.39.1754618829825; 
 Thu, 07 Aug 2025 19:07:09 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b428ba4cf35sm3705433a12.14.2025.08.07.19.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 19:07:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 1/9] contrib/plugins/uftrace: skeleton file
Date: Thu,  7 Aug 2025 19:06:54 -0700
Message-ID: <20250808020702.410109-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c   | 74 +++++++++++++++++++++++++++++++++++++
 contrib/plugins/meson.build |  3 +-
 2 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/uftrace.c

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
new file mode 100644
index 00000000000..d60c1077496
--- /dev/null
+++ b/contrib/plugins/uftrace.c
@@ -0,0 +1,74 @@
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
+    for (int i = 0; i < n_insns; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+
+        uintptr_t pc = qemu_plugin_insn_vaddr(insn);
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
+                QEMU_PLUGIN_CB_R_REGS,
+                (void *) pc);
+
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


