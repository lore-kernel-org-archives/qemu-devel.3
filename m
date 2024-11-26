Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0524D3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw7u-0003pz-JP; Tue, 26 Nov 2024 09:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7t-0003jG-Bj
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:13 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7r-0005KZ-Ix
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:13 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3823cae4be1so3478021f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629670; x=1733234470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1bE2bl0QDf3Rqlq5KlIMVIIKrO5fdUWdjBNe4ZEiQiI=;
 b=J+HOUGdJM0mGnWsz21sa09izLeln3PntqcWhOu1ayLqLmwl9cFQJi8CoqoZHlUEbbt
 U4rxvHRU4WIEtyuNUXYk3fet284TepZUVh5a7Vf/TayGt8lE0RnCrBHMz4gWb9vRCquE
 rKHPR1bGX/CD/NZFlP2ncIIX+cJlax6pibsjbJLdtwmgaVDoRr8kcARUousgenxyMwqj
 cRyIRKZ46PctRoLpgiA41nWsKdm9mBMqoeNrCVF8MhV0a3oiUutJdBXsqWTzY7JJQ/E/
 Dnru0ukdlBOjhF4stxgxqa+XxkXGHjpHyPjrv7E614c+Z49EV9DS+82xXTgmYoeicE+m
 Pb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629670; x=1733234470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1bE2bl0QDf3Rqlq5KlIMVIIKrO5fdUWdjBNe4ZEiQiI=;
 b=nF0h9jUdk5Uf91+QeQVkZJ3b7rCC4d6gGIDy42ExwpeMbKt5onpz5LG/GxBkoDaLeX
 VYBhQhA7frDMgM2v2AzYscR7X0gGnwMf8hMCc+8Sa6dHW1ey/archywUqQV5PcKopaJ/
 KJso2ePwdGJRMGzFz+s6y2aH5tfgOhV9gu/+qEWbq86XXtg4Zt3l/AgZ7247Mg/Ml3c+
 aiEeTFNXfJHZ20Md+iycRoBxCN1gJRK8CLPQ4EPgZ87Lekmkas79vzcHWqC1OWCSNMW0
 XW8tlw4bp7VRyfsctQxp4kHd6r56SJa2aQB0NvViml3kksTtqPg4Tk9h2kfj5zcofBRj
 cXAQ==
X-Gm-Message-State: AOJu0YzL3li07YLYfRCYvrFP4O9cGIqSNLkrXhjSqAxS1gJsKFJAbseo
 iVCMiSQS1ntL5ZdgjlEPQRIXSDsA+WopE/2psU5/Wc+tyuWjm/3aPwn/OrugV9SLQvFurZaE/zj
 H
X-Gm-Gg: ASbGncuuTv71CzRglclo5SeegJvq/SkFFx7pt3V6bjk+USKjI2CAStzBtldtRCs+TyA
 4BS4g2v/aZI6ttZRm4EnUqtRCU/XRtB5SQOFnThPaXJStjvRyGJDM6mfjFs/Drw3K7A+62ZqzCL
 5l2ub7lZlgTB38XgAQzvcsSCdGr8c3Wz8mGH3COEDZBuapki8S+5ajBuAl5vwoZXT5zp1IPaK4b
 4FgFMbdfOeMSfJ2vkKOA5iInFIyXkJdJzug4Zbg32tcpgI7soSDnlHpCgJaSXogKiVM0KYY
X-Google-Smtp-Source: AGHT+IHF9lcoMohsww7OZUAgW01vlBeU7tbq6w6E90DbENBzkfrbiSQeFbU3SzCNXPSiXhjUhqLDyg==
X-Received: by 2002:a05:6000:1866:b0:382:488d:dfc5 with SMTP id
 ffacd0b85a97d-382608a394fmr14984584f8f.0.1732629669688; 
 Tue, 26 Nov 2024 06:01:09 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedebfsm13436096f8f.100.2024.11.26.06.01.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:01:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 10/16] target/mips: Introduce decode tree bindings for
 nanoMIPS ISA
Date: Tue, 26 Nov 2024 14:59:56 +0100
Message-ID: <20241126140003.74871-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Introduce the nanoMIPS decodetree configs for the 16-bit,
32-bit and 48-bit instructions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h              |  3 +++
 target/mips/tcg/nanomips16.decode        |  8 ++++++++
 target/mips/tcg/nanomips32.decode        |  8 ++++++++
 target/mips/tcg/nanomips48.decode        |  8 ++++++++
 target/mips/tcg/nanomips_translate.c     | 15 +++++++++++++++
 target/mips/tcg/nanomips_translate.c.inc | 16 ++++++++++++++++
 target/mips/tcg/meson.build              |  4 ++++
 7 files changed, 62 insertions(+)
 create mode 100644 target/mips/tcg/nanomips16.decode
 create mode 100644 target/mips/tcg/nanomips32.decode
 create mode 100644 target/mips/tcg/nanomips48.decode
 create mode 100644 target/mips/tcg/nanomips_translate.c

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 2a079cb28d9..7fe34a1d891 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -224,6 +224,9 @@ bool decode_64bit_enabled(DisasContext *ctx);
 /* decodetree generated */
 bool decode_isa_micromips16(DisasContext *ctx, uint16_t insn);
 bool decode_isa_micromips32(DisasContext *ctx, uint32_t insn);
+bool decode_isa_nanomips16(DisasContext *ctx, uint16_t insn);
+bool decode_isa_nanomips32(DisasContext *ctx, uint32_t insn);
+bool decode_isa_nanomips48(DisasContext *ctx, uint64_t insn);
 bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
 bool decode_ase_mips16e_16(DisasContext *ctx, uint16_t insn);
 bool decode_ase_mips16e_32(DisasContext *ctx, uint32_t insn);
diff --git a/target/mips/tcg/nanomips16.decode b/target/mips/tcg/nanomips16.decode
new file mode 100644
index 00000000000..81fdc68e98b
--- /dev/null
+++ b/target/mips/tcg/nanomips16.decode
@@ -0,0 +1,8 @@
+# nanoMIPS32 16-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: nanoMIPS32 Instruction Set Technical Reference Manual
+#            (Document Number: MD01247)
diff --git a/target/mips/tcg/nanomips32.decode b/target/mips/tcg/nanomips32.decode
new file mode 100644
index 00000000000..9cecf1e13d3
--- /dev/null
+++ b/target/mips/tcg/nanomips32.decode
@@ -0,0 +1,8 @@
+# nanoMIPS32 32-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: nanoMIPS32 Instruction Set Technical Reference Manual
+#            (Document Number: MD01247)
diff --git a/target/mips/tcg/nanomips48.decode b/target/mips/tcg/nanomips48.decode
new file mode 100644
index 00000000000..696cc15607a
--- /dev/null
+++ b/target/mips/tcg/nanomips48.decode
@@ -0,0 +1,8 @@
+# nanoMIPS32 48-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: nanoMIPS32 Instruction Set Technical Reference Manual
+#            (Document Number: MD01247)
diff --git a/target/mips/tcg/nanomips_translate.c b/target/mips/tcg/nanomips_translate.c
new file mode 100644
index 00000000000..335a32845ed
--- /dev/null
+++ b/target/mips/tcg/nanomips_translate.c
@@ -0,0 +1,15 @@
+/*
+ * MIPS emulation for QEMU - nanoMIPS translation routines
+ *
+ * Copyright (c) 2021 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "translate.h"
+
+/* Include the auto-generated decoders.  */
+#include "decode-nanomips16.c.inc"
+#include "decode-nanomips32.c.inc"
+#include "decode-nanomips48.c.inc"
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index e0a920bdb3a..5d021f01128 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4480,6 +4480,22 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
 
     opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
     ctx->opcode = opcode;
+    if (decode_isa_nanomips16(ctx, opcode)) {
+        return 2;
+    }
+
+    opcode <<= 16;
+    opcode |= translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
+    if (decode_isa_nanomips32(ctx, opcode)) {
+        return 4;
+    }
+
+    opcode <<= 16;
+    opcode |= translator_lduw(env, &ctx->base, ctx->base.pc_next + 4);
+    if (decode_isa_nanomips48(ctx, opcode)) {
+        return 6;
+    }
+
     rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RT3(ctx->opcode));
     rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS3(ctx->opcode));
     rd = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD3(ctx->opcode));
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index ca70769912c..f674819e6a8 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -4,6 +4,9 @@ gen = [
   decodetree.process('micromips16.decode', extra_args: ['--decode=decode_isa_micromips16', '--insnwidth=16']),
   decodetree.process('micromips32.decode', extra_args: ['--decode=decode_isa_micromips32']),
   decodetree.process('rel6.decode', extra_args: ['--decode=decode_isa_rel6']),
+  decodetree.process('nanomips16.decode', extra_args: ['--decode=decode_isa_nanomips16', '--insnwidth=16']),
+  decodetree.process('nanomips32.decode', extra_args: ['--decode=decode_isa_nanomips32']),
+  decodetree.process('nanomips48.decode', extra_args: ['--decode=decode_isa_nanomips48', '--insnwidth=48']),
   decodetree.process('msa.decode', extra_args: '--decode=decode_ase_msa'),
   decodetree.process('tx79.decode', extra_args: '--static-decode=decode_tx79'),
   decodetree.process('vr54xx.decode', extra_args: '--decode=decode_ext_vr54xx'),
@@ -24,6 +27,7 @@ mips_ss.add(files(
   'mips16e_translate.c',
   'msa_helper.c',
   'msa_translate.c',
+  'nanomips_translate.c',
   'op_helper.c',
   'rel6_translate.c',
   'translate.c',
-- 
2.45.2


