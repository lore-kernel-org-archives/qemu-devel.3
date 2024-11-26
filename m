Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E076DD3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw7o-0003Rc-OO; Tue, 26 Nov 2024 09:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7i-00038u-Je
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:02 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7f-0005Gp-Vl
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:02 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38246333e12so5606248f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629658; x=1733234458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5m5TqC/cPItfIOCXyMZ2ph3/Vk5sDUqZ5fGYzbXuOek=;
 b=ltDAh/S/qcE/ixGO3Tp0Zto9mnB/jVp0Os6HiaWy8J/prTVgfyG7dOeuTiCugDLgAh
 ZKqT6ymvqQvf/n1JSf+8wP9kCwduaVJJqwFRJ9YYSHJC+yWdbI4BJQfmA2xTCemZU5y8
 j5MeXYLt4uwkGHMbKy857UUXEuDxOku/Zd8NcaetdBtYz0Z9S/Gfe0Nywxruq3KDeG01
 xjfVFxkzHx+Aa+I3U2Z7qVzaOBqsziieq7hQ35IeQ8Q0n7pIY2iEqmyB/U/G9QDSQnmm
 tSwS3dsP5we/D57bm2OsEEp84wGtzgpp6B5RERS0RCaAX9KeH6YSj3qD8Pu0S8RWJQKu
 4Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629658; x=1733234458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5m5TqC/cPItfIOCXyMZ2ph3/Vk5sDUqZ5fGYzbXuOek=;
 b=ZTCoPD0UZiWMtTouGwRnYljGdYG83QusedU0dsXVldMOu6N9wruKg4jbTGxc2sudIu
 I/LLymtctjj7S7PS9Q2KD7BZwQjmCdT+6Ed39QIR6yrdhmyy5P+Kb6w/gUEWZ+tw3aCr
 dXnm396CQ7RmEcRiCcZHNmV/5zmEVDa7nYRZleMpQaK541YHm/c8dnWsUZFmWjpcFKiU
 /DHcCJA8HQknLMiEvEmGEwq1yTKwg/gKm529AEqhQ9J/vI4ddlP3viIukKXEsv7eOwlr
 m5S9/z1uQYksEtsF/KTv7Ql3zTDfyANMUiwxFOsZ3uwXfWUbMmiILVxtDHj52lilQwvD
 PQww==
X-Gm-Message-State: AOJu0YxyPLzZ5P8yNYL4YzzTGWFJrFE8uns9W19i0bFAFxqJ5RPhgUbV
 9ycF2EqLMu64Bv1WBZoS9UavB1zjZDJHL5Fs9Mv0gWpg7XX5MLGya4piYnljGEQ5vUhSNUG0hRA
 S
X-Gm-Gg: ASbGncuxmUTB2fC6UccFsu0w5dcfJchD3iqGxkHOakWns5q+ldTEpgR9Wxv5wOZ9dX5
 oL15MnznYJPLg8Q8B9sJSWFoeacojb9FzKmLdxX0hxQrjUUd8cK7bpAbyt24t1pHbP6XYuQd/sP
 FGV2tUsY5XGPTAlX8JYRGoZF+Jst5TsToriQQt3AiA1CQObiukIJacFRZ1F9g2EMbYiHU2lBu22
 pT45a+I58RNQWcHs4RwEfGj+KZNe4fH4xlTgeo12IP170PgEMV2AK0FmdSuK08mz1J2XcfD
X-Google-Smtp-Source: AGHT+IFwHUwdzfZSMqYqBQ6sV2wcMmRVicnWNeF8M/S+UPW6E96sLgD5rmzwGIrqS9GkyLyQ20ZV/g==
X-Received: by 2002:a05:6000:790:b0:385:bc53:b2af with SMTP id
 ffacd0b85a97d-385bc53b2camr6857946f8f.42.1732629657668; 
 Tue, 26 Nov 2024 06:00:57 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad6270sm13318459f8f.14.2024.11.26.06.00.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:00:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v3 08/16] target/mips: Introduce decode tree bindings for
 microMIPS ISA
Date: Tue, 26 Nov 2024 14:59:54 +0100
Message-ID: <20241126140003.74871-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Introduce the microMIPS decodetree configs for the 16-bit
and 32-bit instructions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h               |  2 ++
 target/mips/tcg/micromips16.decode        | 11 +++++++++++
 target/mips/tcg/micromips32.decode        | 11 +++++++++++
 target/mips/tcg/micromips_translate.c     | 14 ++++++++++++++
 target/mips/tcg/micromips_translate.c.inc |  9 +++++++++
 target/mips/tcg/meson.build               |  3 +++
 6 files changed, 50 insertions(+)
 create mode 100644 target/mips/tcg/micromips16.decode
 create mode 100644 target/mips/tcg/micromips32.decode
 create mode 100644 target/mips/tcg/micromips_translate.c

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index d1aa811cfa1..2a079cb28d9 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -222,6 +222,8 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn);
 bool decode_64bit_enabled(DisasContext *ctx);
 
 /* decodetree generated */
+bool decode_isa_micromips16(DisasContext *ctx, uint16_t insn);
+bool decode_isa_micromips32(DisasContext *ctx, uint32_t insn);
 bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
 bool decode_ase_mips16e_16(DisasContext *ctx, uint16_t insn);
 bool decode_ase_mips16e_32(DisasContext *ctx, uint32_t insn);
diff --git a/target/mips/tcg/micromips16.decode b/target/mips/tcg/micromips16.decode
new file mode 100644
index 00000000000..d341da16b04
--- /dev/null
+++ b/target/mips/tcg/micromips16.decode
@@ -0,0 +1,11 @@
+# microMIPS32 16-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: MIPS Architecture for Programmers, Volume II-B
+#            microMIPS32 Instruction Set
+#            (Document Number: MD00582)
+#            microMIPS64 Instruction Set
+#            (Document Number: MD00594)
diff --git a/target/mips/tcg/micromips32.decode b/target/mips/tcg/micromips32.decode
new file mode 100644
index 00000000000..333ab0969ca
--- /dev/null
+++ b/target/mips/tcg/micromips32.decode
@@ -0,0 +1,11 @@
+# microMIPS32 32-bit instruction set extensions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: MIPS Architecture for Programmers, Volume II-B
+#            microMIPS32 Instruction Set
+#            (Document Number: MD00582)
+#            microMIPS64 Instruction Set
+#            (Document Number: MD00594)
diff --git a/target/mips/tcg/micromips_translate.c b/target/mips/tcg/micromips_translate.c
new file mode 100644
index 00000000000..49e90e7eca2
--- /dev/null
+++ b/target/mips/tcg/micromips_translate.c
@@ -0,0 +1,14 @@
+/*
+ * MIPS emulation for QEMU - microMIPS translation routines
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
+#include "decode-micromips16.c.inc"
+#include "decode-micromips32.c.inc"
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 26006f84df7..7a884222eed 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -3018,6 +3018,15 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
         }
     }
 
+    if (decode_isa_micromips16(ctx, opcode)) {
+        return 2;
+    }
+    opcode <<= 16;
+    opcode |= translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
+    if (decode_isa_micromips32(ctx, opcode)) {
+        return 4;
+    }
+
     switch (op) {
     case POOL16A:
         {
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index bcb64368be8..ca70769912c 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -1,6 +1,8 @@
 gen = [
   decodetree.process('mips16e_16.decode', extra_args: ['--decode=decode_ase_mips16e_16', '--insnwidth=16']),
   decodetree.process('mips16e_32.decode', extra_args: ['--decode=decode_ase_mips16e_32']),
+  decodetree.process('micromips16.decode', extra_args: ['--decode=decode_isa_micromips16', '--insnwidth=16']),
+  decodetree.process('micromips32.decode', extra_args: ['--decode=decode_isa_micromips32']),
   decodetree.process('rel6.decode', extra_args: ['--decode=decode_isa_rel6']),
   decodetree.process('msa.decode', extra_args: '--decode=decode_ase_msa'),
   decodetree.process('tx79.decode', extra_args: '--static-decode=decode_tx79'),
@@ -18,6 +20,7 @@ mips_ss.add(files(
   'fpu_helper.c',
   'ldst_helper.c',
   'lmmi_helper.c',
+  'micromips_translate.c',
   'mips16e_translate.c',
   'msa_helper.c',
   'msa_translate.c',
-- 
2.45.2


