Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8145CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR10-00012b-OK; Tue, 19 Aug 2025 14:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0x-0000oG-OZ; Tue, 19 Aug 2025 14:24:56 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0v-00044s-K2; Tue, 19 Aug 2025 14:24:55 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2449978aceaso12733665ad.2; 
 Tue, 19 Aug 2025 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627890; x=1756232690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHtHKkltqbJxqH57j4a6ITgFlcnXNSgJcWlXt3E5jp8=;
 b=ei9hBZGb1nhJPtXYYk8BXS4Npt+AaoMK0d9Qk28YDd9w1vFmGmWF7JUUfNw8QuvIrW
 V4AzPlyPx7IWrbhpUW4dsJFKy4O+fwVVg/GJbaTTA1YkWB7DWbK6mGIKiTUg0AOfFh/k
 +fro+C5uFb90JjtUW99jH7MfS7joDybt8qjoyJX4pY03SIuywOz78e+ns1BzctbEX0qs
 wCSNdt2FvnA8fhUdo5Urj90FKUYIYMsOl/RCbwqn024mtYtIQG10AtCqUZo3N3HDV0a2
 8JDnB22qMRj9NaH9G1YwWrTBJjBi/kAy0SqOFOMlOqAInnd/7kS4Ekj/98l0TV+QqRvW
 dsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627890; x=1756232690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHtHKkltqbJxqH57j4a6ITgFlcnXNSgJcWlXt3E5jp8=;
 b=oouwQw1UXY93wzD81JEC697i+f2ZgJitifumOUDy2rbuC/q81rdvMgpqROKcapxY6/
 sAzWtrOv+3f5FsD4sJs+x5wwoGnRPs3fZaBE3txem62qrrs6dIhLc2CWwvg/pg82PNYz
 HS5ZoPnzdXjgTwPtH/j2Xe9Zonj+Xiy4oqiia4ColUNFbPCM/8uKXyl1zUJRCfQu4kri
 vW2g2d5qyLPcYkg+73XGGc9rGFTuJsNNocOb/Yzr5TRnQPBYryU9iwboG8cLr8QX+ELv
 6vMlq9/2XOIjj0Eu+tj9hTvf+MQq/1OawWXJ1vPrJGilax+1igtWXQHG9wM8ZXoh1EhD
 Tz4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIDEIsBrP0eVpUu0tsjUmv0iaQ4C9kP9EymfqUHgy/mzM6uYd9ioVxA2sRuc1o4imzoDzxV5zN2/FfDw==@nongnu.org,
 AJvYcCXGFsleAr5Wm0YebJ/MyPXMiGn+5AfmNc20W+jLdVz8AAqBPQyxBWBelu0p1K8SS89r81P+W5UMYQ==@nongnu.org
X-Gm-Message-State: AOJu0YxMQiB8j++uQiPlT6mRUJVS1fBBn0wGzkDCJ4xL6K4/oiBzl4Yy
 33/mgO1WtXqoWIJYaAYEzi1G29N+a002C6W0aAj6UPLOuPheQsJWE4YVz+/08brF
X-Gm-Gg: ASbGncuRSnVG8Z+4MaemRhFgnASCrd5MhYVjE5JMn84R4HAGxUpnv8IIvcC9EbgLeWc
 N4pohzZB/L11a9MWwal6cV+hzf+YpKTftzoLBzUp/lYgZwvmHnb37ie2VhtseXcIWfW6pK11Hy2
 hMoKUqmQkxgz3TsdU1U+rGbL3M09dINWs4GWcZh85HgVtJEOeQ4Jh+KRLh7kOaDMIQ4KTDZz+Zq
 dis8eX5wi9H8Jms1B9jxGi3JnjsJseJYztv/MhX4Ik3JtezO/lbjBYW+8RMnBdczATLXvIvqsF0
 esokRTvEnXUf2XWK4wReQyOBZeLuhrOq6hPJwf449XEMWZnzcweOrk5nIjq5N8jLahypODmJhPA
 QCFS2cizt6uaDZoMiZLu04A==
X-Google-Smtp-Source: AGHT+IHVFObN2OZfxz/17D56FXqeV+VEOhsEqc+70KK/t31LD8HxRla2+m00umgKw+aUD82qxKYoPw==
X-Received: by 2002:a17:902:c952:b0:244:9b69:c920 with SMTP id
 d9443c01a7336-245e0307e4dmr41772335ad.14.1755627889862; 
 Tue, 19 Aug 2025 11:24:49 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:24:49 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 24/35] tcg/wasm: Add exit_tb/goto_tb/goto_ptr instructions
Date: Wed, 20 Aug 2025 03:21:53 +0900
Message-ID: <10976da800d72ebd0a91b4898ac40831f85fa827.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

In the Wasm backend, each TB is compiled to a separeted Wasm module. Control
transfer between TBs (i.e. from one Wasm module to another) is handled by
the caller of the module.

The goto_tb and goto_ptr operations are implemented by returning control to
the caller using the return instruction. The destination TB's pointer is
passed to the caller via a shared WasmContext structure which is accessible
from both the Wasm module and the caller. This WasmContext must be provided
to the module as an argument.

If the destination TB is the current TB itself, there is no need to return
control to the caller. Instead, execution can jump directly to the top of
the loop within the TB.

The exit_tb operation sets the pointer in WasmContext to 0, indicating that
there is no destination TB.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 MAINTAINERS               |  1 +
 tcg/wasm.h                | 17 ++++++++
 tcg/wasm/tcg-target.c.inc | 89 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 105 insertions(+), 2 deletions(-)
 create mode 100644 tcg/wasm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 217bf2066c..d528b9ec90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4004,6 +4004,7 @@ M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
 S: Maintained
 F: tcg/wasm/
 F: tcg/wasm.c
+F: tcg/wasm.h
 
 Block drivers
 -------------
diff --git a/tcg/wasm.h b/tcg/wasm.h
new file mode 100644
index 0000000000..bd12f1039b
--- /dev/null
+++ b/tcg/wasm.h
@@ -0,0 +1,17 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef TCG_WASM_H
+#define TCG_WASM_H
+
+/*
+ * WasmContext is a data shared among QEMU and wasm modules.
+ */
+struct WasmContext {
+    /*
+     * Pointer to the TB to be executed.
+     */
+    void *tb_ptr;
+};
+
+#endif
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index a9fad306cb..c907a18d9e 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/queue.h"
+#include "../wasm.h"
 
 /* Used for function call generation. */
 #define TCG_TARGET_CALL_STACK_OFFSET    0
@@ -121,9 +122,14 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
  */
 #define BLOCK_IDX 16
 
+/*
+ * pointer to WasmContext
+ */
+#define CTX_IDX 0
+
 /* Temporary local variables */
-#define TMP32_LOCAL_0_IDX 0
-#define TMP64_LOCAL_0_IDX 1
+#define TMP32_LOCAL_0_IDX 1
+#define TMP64_LOCAL_0_IDX 2
 
 typedef enum {
     OPC_UNREACHABLE = 0x00,
@@ -132,6 +138,7 @@ typedef enum {
     OPC_ELSE = 0x05,
     OPC_END = 0x0b,
     OPC_BR = 0x0c,
+    OPC_RETURN = 0x0f,
     OPC_LOCAL_GET = 0x20,
     OPC_LOCAL_SET = 0x21,
     OPC_GLOBAL_GET = 0x23,
@@ -928,6 +935,81 @@ static void tcg_wasm_out_brcond(TCGContext *s, TCGType type,
     tcg_wasm_out_br_to_label(s, l, true);
 }
 
+#define CTX_OFFSET(f) offsetof(struct WasmContext, f)
+
+static intptr_t tcg_wasm_out_get_ctx(TCGContext *s, intptr_t off)
+{
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, CTX_IDX);
+    return tcg_wasm_out_norm_ptr(s, off);
+}
+
+static void tcg_wasm_out_exit_tb(TCGContext *s, uintptr_t arg)
+{
+    intptr_t ofs;
+
+    /* Store ctx.tb_ptr = 0 which indicates there is no next TB */
+    ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(tb_ptr));
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0);
+    tcg_wasm_out_op_ldst(s, OPC_I64_STORE, 0, ofs);
+
+    /* Return the control to the caller */
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, arg);
+    tcg_wasm_out_op(s, OPC_RETURN);
+}
+
+static void tcg_wasm_out_goto(TCGContext *s, TCGReg target, int block_depth)
+{
+    intptr_t ofs;
+
+    /* Check if the target TB is the same as the current TB */
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(target));
+    ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(tb_ptr));
+    tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+    tcg_wasm_out_op(s, OPC_I64_EQ);
+
+    /*
+     * If the target TB is the same as the current TB, no need to return to the
+     * caller. Just branch to the top of the current TB.
+     */
+    tcg_wasm_out_op_block(s, OPC_IF, BLOCK_NORET);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, BLOCK_IDX);
+    tcg_wasm_out_op_idx(s, OPC_BR, block_depth); /* br to the top of loop */
+    tcg_wasm_out_op(s, OPC_END);
+
+    /* Store the target TB to ctx.tb_ptr and return */
+    ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(tb_ptr));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(target));
+    tcg_wasm_out_op_ldst(s, OPC_I64_STORE, 0, ofs);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0);
+    tcg_wasm_out_op(s, OPC_RETURN);
+}
+
+static void tcg_wasm_out_goto_ptr(TCGContext *s, TCGReg arg)
+{
+    tcg_wasm_out_goto(s, arg, 2);
+}
+
+static void tcg_wasm_out_goto_tb(
+    TCGContext *s, int which, uintptr_t cur_reset_ptr)
+{
+    intptr_t ofs;
+
+    /* Set the target TB in the tmp variable. */
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, get_jmp_target_addr(s, which));
+    ofs = tcg_wasm_out_norm_ptr(s, 0);
+    tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_TMP));
+
+    /* Goto the target TB if it's registered. */
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_REG_TMP));
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, cur_reset_ptr);
+    tcg_wasm_out_op(s, OPC_I64_NE);
+    tcg_wasm_out_op_block(s, OPC_IF, BLOCK_NORET);
+    tcg_wasm_out_goto(s, TCG_REG_TMP, 3);
+    tcg_wasm_out_op(s, OPC_END);
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -1343,6 +1425,7 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *func,
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
 {
     tcg_out_op_p(s, INDEX_op_exit_tb, (void *)arg);
+    tcg_wasm_out_exit_tb(s, arg);
 }
 
 static void tcg_out_goto_tb(TCGContext *s, int which)
@@ -1350,11 +1433,13 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     /* indirect jump method. */
     tcg_out_op_p(s, INDEX_op_goto_tb, (void *)get_jmp_target_addr(s, which));
     set_jmp_reset_offset(s, which);
+    tcg_wasm_out_goto_tb(s, which, (intptr_t)s->code_ptr);
 }
 
 static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
 {
     tcg_out_op_r(s, INDEX_op_goto_ptr, a0);
+    tcg_wasm_out_goto_ptr(s, a0);
 }
 
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
-- 
2.43.0


