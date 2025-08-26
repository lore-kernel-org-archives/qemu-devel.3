Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03D1CA0FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwIs-0005oS-DN; Tue, 26 Aug 2025 12:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIW-0004wq-Jf; Tue, 26 Aug 2025 12:13:26 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIO-000866-Q0; Tue, 26 Aug 2025 12:13:24 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b49d98691faso1920170a12.1; 
 Tue, 26 Aug 2025 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224792; x=1756829592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYa2P9E9ZNRWcMx3CbhL2oKgekq6KEVOJe6OnfXYJT0=;
 b=RFaNzNZf/741GWgP8To4nuKHq5gQ37n1SMjFwEdXq6EYx1M+HmumjGD9t8COeZSL3F
 AGWvzjc11iwK6tOo1g5ZHbtyyFJsMW0fz5H0di1LEymfLWBG4U3XDmDYSWLTqqfgrPkS
 YzptD1QsXA6M5vfd67S8Bkm45jGChc/8iuosR8cYb9NB/yLZTgTN+crJS4e79d05zfLq
 QCwY4LtvB3mtAsEruhR6cPn43sQTLYf0Y1MhINqu0Q9BHvayvJRRLp7viZOPI/p/y7aa
 vszLQZ48kEK13+pPkz7hgJiUSUxSO/4rmcBIAQGCYElftca6IwLa7ig8Y/7fUaA2hqXB
 tc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224792; x=1756829592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XYa2P9E9ZNRWcMx3CbhL2oKgekq6KEVOJe6OnfXYJT0=;
 b=ATU3EtdCWa2xLt0n5xJUehaxkBBJLiox1XiyO4hqf+uvIbOG+5oJLOuC+inzSdipfc
 PYaaL48n538KOi7KpDloSGuTtAp0WUK/+12xXuTkrGyI53DB8ViUqgwBN2guYJsfY2zX
 lOq1Wqmf9oYZPtuv3DPeJ/ySDT0nCR6Yrx6SG5Amlo0s0yd1a6tSwH7Dtt3heZt79NFZ
 YCeel1mQVxA2kMa7vSECWDTVNZ79FD320h6l9+LzvATAFy8oPaI+541GvzNxCSiwMgfw
 8A3sfCrJDdVjYi4TB/CEBngnNXuZQMPYBZLu2FB7xcARbRXbwgjKyPyOIYL1IOfhqhBd
 1R/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD7qhAEtVoh6rT6fP9xcKnfc7QAK4E71GtBR4ilF2sZQEydNDUAc/2LHN65wYfB8PU+qhEV4azk9ohiA==@nongnu.org,
 AJvYcCW8TdAxqJkI679XzCVqvlA3nf7Ov8W6NiuqGXQ9Wxz+xE7eqCCp7YeVwhD8UVUvCEu4zuKj7kCg4w==@nongnu.org
X-Gm-Message-State: AOJu0YzpJvcwo6fe+yqLekKQf8sjYl8DdhlaGMZpmwBpwbLMB4T3v7Nk
 PWkwq6wGqEVfngtDhLy2kKtIDryhOR6aZpw69GQJkgB69ac7mF88geeYfCHtWg==
X-Gm-Gg: ASbGncsvlUrP6YE9Z1qYy+tEYcwIpNbaGSRUbDlYFCQUCCvs64kYwkVMtmB9fvMQDzG
 DUJ/RpGnBnJ2ohTm3GDVQZ/1ZlR/ROB9QESnDKA++et2FttHQoqFuk694HpdnQ+2Ge2hOrqJ76Q
 psy8rKcygdD4IbNZDKWA7WtJyb9HhMRxWK5aiXK51BEm2aPeIkb/XQM6RwrTWgMYDb8Xwd1C055
 dNGSKtYNEZVOnv/d3Hp+R6RCHjdwNnRmwIM2f8ASQ4yDWXS/jzjvWA/EVRISd2usXBZ5Jic5NHW
 dXmA1wYgkGDMl9ans9Ds1xO9jIqyTKdvXvxPT0ZxyScuhJX6k8k27P8HEkjRfSHYvpB73NttTOn
 ea+2IeV8uv5Sux2wEGYfdkQ==
X-Google-Smtp-Source: AGHT+IFRZShRKtY/wnLErUwcOuTgo614YwhVAIgc3idUbH/wwY2sLCmYzGsZze5YAq/6JKMN4JyPZQ==
X-Received: by 2002:a17:90a:d605:b0:312:f2ee:a895 with SMTP id
 98e67ed59e1d1-32515eca646mr18585599a91.31.1756224792126; 
 Tue, 26 Aug 2025 09:13:12 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:13:11 -0700 (PDT)
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
Subject: [PATCH v2 21/35] tcg/wasm: Add exit_tb/goto_tb/goto_ptr instructions
Date: Wed, 27 Aug 2025 01:10:26 +0900
Message-ID: <f15853e3bc8c5e6b3a622de90dd14261cb9c82be.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

TCI instructions are also generated in the same way as the original TCI
backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 MAINTAINERS               |   1 +
 tcg/wasm.c                |  20 ++++++
 tcg/wasm.h                |  15 +++++
 tcg/wasm/tcg-target.c.inc | 136 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+)
 create mode 100644 tcg/wasm.h

V2:
- This commit generates both Wasm and TCI instrucitons.

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
diff --git a/tcg/wasm.c b/tcg/wasm.c
index ca67436192..c54c5c5b2c 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -28,6 +28,11 @@ static void tci_args_l(uint32_t insn, const void *tb_ptr, void **l0)
     *l0 = diff ? (void *)tb_ptr + diff : NULL;
 }
 
+static void tci_args_r(uint32_t insn, TCGReg *r0)
+{
+    *r0 = extract32(insn, 8, 4);
+}
+
 static void tci_args_rl(uint32_t insn, const void *tb_ptr,
                         TCGReg *r0, void **l1)
 {
@@ -413,6 +418,21 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
                 tb_ptr = ptr;
             }
             break;
+        case INDEX_op_exit_tb:
+            tci_args_l(insn, tb_ptr, &ptr);
+            return (uintptr_t)ptr;
+        case INDEX_op_goto_tb:
+            tci_args_l(insn, tb_ptr, &ptr);
+            tb_ptr = *(void **)ptr;
+            break;
+        case INDEX_op_goto_ptr:
+            tci_args_r(insn, &r0);
+            ptr = (void *)regs[r0];
+            if (!ptr) {
+                return 0;
+            }
+            tb_ptr = ptr;
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm.h b/tcg/wasm.h
new file mode 100644
index 0000000000..9da38e4d0e
--- /dev/null
+++ b/tcg/wasm.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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
index ca10f97ed8..c077c8ad7c 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/queue.h"
+#include "../wasm.h"
 
 typedef uint32_t tcg_insn_unit_tci;
 
@@ -139,6 +140,9 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
 /* Global variable used for storing the current block index */
 #define BLOCK_IDX 16
 
+/* Local variable pointing to WasmContext */
+#define CTX_IDX 0
+
 typedef enum {
     OPC_UNREACHABLE = 0x00,
     OPC_LOOP = 0x03,
@@ -146,6 +150,8 @@ typedef enum {
     OPC_ELSE = 0x05,
     OPC_END = 0x0b,
     OPC_BR = 0x0c,
+    OPC_RETURN = 0x0f,
+    OPC_LOCAL_GET = 0x20,
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
 
@@ -751,6 +757,81 @@ static void tcg_wasm_out_brcond(TCGContext *s, TCGType type,
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
 static void tcg_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
 {
     tcg_insn_unit_tci insn = 0;
@@ -760,6 +841,35 @@ static void tcg_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
     tcg_out32(s, insn);
 }
 
+static void tcg_out_op_p(TCGContext *s, TCGOpcode op, void *p0)
+{
+    tcg_insn_unit_tci insn = 0;
+    intptr_t diff;
+
+    /* Special case for exit_tb: map null -> 0. */
+    if (p0 == NULL) {
+        diff = 0;
+    } else {
+        diff = p0 - (void *)(s->code_ptr + 4);
+        tcg_debug_assert(diff != 0);
+        if (diff != sextract32(diff, 0, 20)) {
+            tcg_raise_tb_overflow(s);
+        }
+    }
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 12, 20, diff);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_r(TCGContext *s, TCGOpcode op, TCGReg r0)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    tcg_out32(s, insn);
+}
+
 static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -1468,6 +1578,32 @@ static void tcg_out_br(TCGContext *s, TCGLabel *l)
     tcg_wasm_out_br(s, l);
 }
 
+static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
+{
+    tcg_out_op_p(s, INDEX_op_exit_tb, (void *)arg);
+    tcg_wasm_out_exit_tb(s, arg);
+}
+
+static void tcg_out_goto_tb(TCGContext *s, int which)
+{
+    /* indirect jump method. */
+    tcg_out_op_p(s, INDEX_op_goto_tb, (void *)get_jmp_target_addr(s, which));
+    set_jmp_reset_offset(s, which);
+    tcg_wasm_out_goto_tb(s, which, (intptr_t)s->code_ptr);
+}
+
+static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
+{
+    tcg_out_op_r(s, INDEX_op_goto_ptr, a0);
+    tcg_wasm_out_goto_ptr(s, a0);
+}
+
+void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
+                              uintptr_t jmp_rx, uintptr_t jmp_rw)
+{
+    /* Always indirect, nothing to do */
+}
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


