Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182DAD3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw7k-0003ER-MQ; Tue, 26 Nov 2024 09:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7e-0002wm-Pq
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:59 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7b-0005FH-EF
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:57 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-382610c7116so3004433f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629653; x=1733234453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6jveqDxIgi93N+jXqdSQZa/NGDVOMeV1ydXtJqSLpU=;
 b=MDWAlgmoJZhkCYg/Gv1MXoF7yBGhh+DMiqUeqsZTkyObedh5rElDx4SFrhvm/QknWV
 vDQ5OJVHcZ/WbvPf0/nYZbyUr2VuHhXELKoMexYOKh01AemPj5XjCBbj4DpaHNeagSKn
 Pd1+FLM17Hh45KaQAlSvJzf5ZpT9qzEPVTWZZ/r1Ykp9Qj3rC6py4rwUXkEwaJjC20Ni
 WhK0V9dbe9yNYnTP3CGFkre+I4V4LLnT5PY03T0dMICPgHPk1ypGj3qVMW88sy5DoycK
 odgrTo5Tr6T4rbhMF0w0W9bJIG/7YlE95unQfs1TUXNTj8bEwMmMzdTmLA0eUqAkW2E9
 DDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629653; x=1733234453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6jveqDxIgi93N+jXqdSQZa/NGDVOMeV1ydXtJqSLpU=;
 b=n/AB6LQxia8bbpRa2Y5ROFhymleTbduPSL4xDaCyylsPWK31vu/O+e/TigQ/EeOmKS
 73OevNl6V3kh8hvf8JXRyLgkuaj/zRXX8biBougVZ7aHDojTxU2E6ICvSHgVJHI1OsAq
 3fw3l5DcMZFtFxVbho1lrYYQ0Xs0QiOX5rOBLRGhD2BBGiodQCQLXX31+7E6BO1+Nj9H
 y0N8crJ2vYkfguBXoNRKoTUvB8RjkI/fOpd36y3VdKLA3hq2vzzGWfejNcrSnGWv05GA
 YBp6Qu5Tj8uvqv5nxj5EUNvgfiifELzgVtiRebzsZzL2tEP2DSi6w7jkPv9SyxuSj/Hm
 7/iw==
X-Gm-Message-State: AOJu0YzouGHxzWE8vdOiV7pFqZwE/MKIJWkmviAalyJJjHtJZ2GCoQI4
 sKmaBiESykSKnZ4iFBi6p6j1h/qKKgpJal0+phKqtKkjUU/vg790ahLLwAqFg+ZepnxVCcZZw6Y
 0
X-Gm-Gg: ASbGncuNuhF5JqsAttiznUO+3feiUujeF3UkxcbCtbQTxDhibh1d2y1E4hq61MA1Wk0
 eyW1JQ1UrQM2TxjrZlO+tFQ5/UC7LkWdc+hbh5r8BOUQQpABIpfASgLxUtiB7l9p+DOOIVQf6ab
 dehyL3CEAQR8SVNeNA0hli7HjbgSW5HxEze6DJDDqXTTOSE4iMEoiHeerKqalWcVY2+2B1ZcPxr
 fKWfjEC71DRYPQWrb8iTkyegCnVKiGudr80ZLKmXRIw2/WmjWmgsOksBtsS4b8tFCvwgebv
X-Google-Smtp-Source: AGHT+IE5UW4DKVIAJJCiER1hTYjtOanYuptPrD72i1uF3fBBLwchRd2Dy/JX93NZeWo+EpkFJ5Qk3w==
X-Received: by 2002:a05:6000:1449:b0:37c:d569:97b with SMTP id
 ffacd0b85a97d-38260b60008mr14060733f8f.19.1732629650662; 
 Tue, 26 Nov 2024 06:00:50 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafeceesm13407142f8f.37.2024.11.26.06.00.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:00:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 07/16] target/mips: Introduce decode tree bindings for
 MIPS16e ASE
Date: Tue, 26 Nov 2024 14:59:53 +0100
Message-ID: <20241126140003.74871-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Introduce the MIPS16e decodetree configs for the 16-bit
and 32-bit instructions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h             |  2 ++
 target/mips/tcg/mips16e_16.decode       |  9 +++++++++
 target/mips/tcg/mips16e_32.decode       |  9 +++++++++
 target/mips/tcg/mips16e_translate.c     | 14 ++++++++++++++
 target/mips/tcg/mips16e_translate.c.inc |  8 ++++++++
 target/mips/tcg/meson.build             |  3 +++
 6 files changed, 45 insertions(+)
 create mode 100644 target/mips/tcg/mips16e_16.decode
 create mode 100644 target/mips/tcg/mips16e_32.decode
 create mode 100644 target/mips/tcg/mips16e_translate.c

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index a65ab4a747c..d1aa811cfa1 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -223,6 +223,8 @@ bool decode_64bit_enabled(DisasContext *ctx);
 
 /* decodetree generated */
 bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
+bool decode_ase_mips16e_16(DisasContext *ctx, uint16_t insn);
+bool decode_ase_mips16e_32(DisasContext *ctx, uint32_t insn);
 bool decode_ase_msa(DisasContext *ctx, uint32_t insn);
 bool decode_ext_txx9(DisasContext *ctx, uint32_t insn);
 bool decode_ext_loongson(DisasContext *ctx, uint32_t insn);
diff --git a/target/mips/tcg/mips16e_16.decode b/target/mips/tcg/mips16e_16.decode
new file mode 100644
index 00000000000..82586493f68
--- /dev/null
+++ b/target/mips/tcg/mips16e_16.decode
@@ -0,0 +1,9 @@
+# MIPS16e 16-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: MIPS Architecture for Programmers, Volume IV-a
+#            The MIPS16e Application Specific Extension
+#            (Document Number: MD00076)
diff --git a/target/mips/tcg/mips16e_32.decode b/target/mips/tcg/mips16e_32.decode
new file mode 100644
index 00000000000..fc429049e18
--- /dev/null
+++ b/target/mips/tcg/mips16e_32.decode
@@ -0,0 +1,9 @@
+# MIPS16e 32-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: MIPS Architecture for Programmers, Volume IV-a
+#            The MIPS16e Application Specific Extension
+#            (Document Number: MD00076)
diff --git a/target/mips/tcg/mips16e_translate.c b/target/mips/tcg/mips16e_translate.c
new file mode 100644
index 00000000000..6de9928b37e
--- /dev/null
+++ b/target/mips/tcg/mips16e_translate.c
@@ -0,0 +1,14 @@
+/*
+ * MIPS emulation for QEMU - MIPS16e translation routines
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
+#include "decode-mips16e_16.c.inc"
+#include "decode-mips16e_32.c.inc"
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index defef3ce559..a57ae4e95b1 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -657,6 +657,14 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
     int n_bytes;
 
     ctx->opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
+
+    if (decode_ase_mips16e_16(ctx, ctx->opcode)) {
+        return 2;
+    }
+    if (decode_ase_mips16e_32(ctx, ctx->opcode)) {
+        return 4;
+    }
+
     op = (ctx->opcode >> 11) & 0x1f;
     sa = (ctx->opcode >> 2) & 0x7;
     sa = sa == 0 ? 8 : sa;
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index 7b18e6c4c8b..bcb64368be8 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -1,4 +1,6 @@
 gen = [
+  decodetree.process('mips16e_16.decode', extra_args: ['--decode=decode_ase_mips16e_16', '--insnwidth=16']),
+  decodetree.process('mips16e_32.decode', extra_args: ['--decode=decode_ase_mips16e_32']),
   decodetree.process('rel6.decode', extra_args: ['--decode=decode_isa_rel6']),
   decodetree.process('msa.decode', extra_args: '--decode=decode_ase_msa'),
   decodetree.process('tx79.decode', extra_args: '--static-decode=decode_tx79'),
@@ -16,6 +18,7 @@ mips_ss.add(files(
   'fpu_helper.c',
   'ldst_helper.c',
   'lmmi_helper.c',
+  'mips16e_translate.c',
   'msa_helper.c',
   'msa_translate.c',
   'op_helper.c',
-- 
2.45.2


