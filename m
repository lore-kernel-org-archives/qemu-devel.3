Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B8DCA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwHP-00046Y-WF; Tue, 26 Aug 2025 12:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHP-000469-6g; Tue, 26 Aug 2025 12:12:15 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHH-0007sT-1O; Tue, 26 Aug 2025 12:12:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-246181827e9so48686335ad.3; 
 Tue, 26 Aug 2025 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224722; x=1756829522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ysNMR6wcAogwpAx9j5lJ/Tk1NcBMMnOaoAbQHR/1mhc=;
 b=KXr3SgtRIw6kLJnfHWkGr5jCmFMVcRYUjEVdQPcTUATcSHjvV/TXYpRMpu12VtCdTV
 ihHKhG+eamLND+/qNOtIcyfE4Meu+V0/2oRWxLzwZiRWU78V6QXK8b/pII7clN4QBOZE
 ijB0XMjzZwL/CX0Kt1Vu2aGHOzoY55o+9IBNPqRZNUY20u4l/M/x280hyg8xXwtAXQJd
 0Gk9dyvnXUKNWnxBonVkhr+VF01FVwKUqAVE/qx9aQsORg4hiSaMPl63/GrPDuX6hFtZ
 Zo5lxwDy4LQeOcHSS8YuZTOryGuO7Pa4UlxKZkUn3UB1O9ipnJbw3ggNh8FWm7UzNU+u
 P7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224722; x=1756829522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ysNMR6wcAogwpAx9j5lJ/Tk1NcBMMnOaoAbQHR/1mhc=;
 b=K6vbGe0DJeDP76wd5XVZ89gIiqULu96Ofy61HLF8BOB+1okspBB3NmtbWfWZgfpYwR
 DaN/72O7gO8u1t0AX/wimFXOr4bLm+17OQRrzxZhVE8kWZBNqc0OAib+MuyWnXVSHV2Y
 zah9Fre7+Cqvx7vzGoCfHdCmVnIvbUWEu6JT+Ln/562jbAvRTyPF2iZKAh4cmUGjyoI9
 rmxdO0felilK9V928wmaeP5jxiwzh8JamztrgLIfIbqRiW7pJbH4I4biySat+pAzSAJH
 aJdlNsN8Ic4/sqcQvebhmx0tXhf6O+Lm6tYUEo+7WjVBeJYcgZTIMotiwE8+LkPSQfJ5
 v0qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1dvQ51lAqAM2zP0VYYYKUSgnwAEhZtmTgbkY/qCS4I+NBVwkzyobtGge8EvNJUPYb4pNEeKmc9w==@nongnu.org,
 AJvYcCUhexSheE72vvzjMyKBn5k+TsbnfI6qgzYacyIqfRDNZ7+HbgQoULZ9ydoOKwZQPMWXZ10knHtxAMyvyg==@nongnu.org
X-Gm-Message-State: AOJu0YyUlFoCJ8KI6WJwOlYLbztDNQxQv2hxvpZZZ2wIydqneMZzYkd4
 z4ab8FVXYwH42ImEG/kZBCL6IWkAds4KqKMBXYLSQk9xAgBi62NMWGMnCDhkyg==
X-Gm-Gg: ASbGncv4Afb8yFSe48jpTyKcWicjMGvmhLYRRAB0hfRPtdCUrwsZNy7tx693VecCA09
 D9zYYiWx+3Z660YngvavYV/M6CCG7GNxWZ05mwXTYS/8RRQfKp0zi6+OwAwX0ZOJCZ5NuA6mAps
 mObBWO9gcpmIyLdI0kTljHlT8z61dX8qbDMantGl4ozMRkwY102Edj7FJj3SW1Nbxk+H/G3EzSr
 DfsMZmev6KBIZSsb8JXTeJFwO1h6/XAPd42gNBYtR141mqMBGc0FKabpHc6WspzQE4/ENYDIj6q
 TJ4qrJ9KA8Ldg5xMKwKC7c0sOS9TXfxtExUxGkGy3q/sVBAq840dDlHSs0wMZtag+/+g8zLZI4F
 5y+aGnYZ7Oli3FNuMqcSDVQ==
X-Google-Smtp-Source: AGHT+IEfiOaF7sYa3tBZZDPql/aIaxskdDh2NWWPnzzqRwTkP0Ses1AgRykRVwrO2a3McTYbjW6gjg==
X-Received: by 2002:a17:902:f54a:b0:246:b285:a3db with SMTP id
 d9443c01a7336-246b285a4eamr112223135ad.45.1756224722336; 
 Tue, 26 Aug 2025 09:12:02 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:12:01 -0700 (PDT)
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
Subject: [PATCH v2 09/35] tcg/wasm: Add and/or/xor instructions
Date: Wed, 27 Aug 2025 01:10:14 +0900
Message-ID: <f8cb9a61b63a69cce422b2964659b0e0472347bc.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
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

This commit adds support for generateing the and, or and xor operations. The
generated Wasm codes will be instantiated and executed in the browser.

Browsers tipycally limit the number of active Wasm instances and the
instantiating Wasm modules introduces overhead. As a result, instantiating
TBs that are rarely called is undesirable. To address this, the Wasm backend
relies on the a forked subset of the TCI interpreter (tcg_qemu_tb_exec_tci
function in tcg/wasm.c) for executing such TBs.

The Wasm backend emits both Wasm and TCI instructions. TCI instructions are
emitted to s->code_ptr, while the corresponding Wasm instructions are
generated into a separate buffer allocated via tcg_malloc(). This buffer
intends to be merged into the TB before tcg_gen_code returns.

In the Wasm code, each TCG variable is mapped to a 64bit Wasm
variable. Execution works by first pushing the operands into the Wasm's
stack using get instructions. The result is left on the stack and this can
be assigned to a variable by popping it using a set instruction. The Wasm
binary format is documented at [1].

Additionally, since the Wasm instuction's index operand must be
LEB128-encoded, this commit introduces an encoder function implemented
following [2].

[1] https://webassembly.github.io/spec/core/binary/index.html
[2] https://en.wikipedia.org/wiki/LEB128

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 MAINTAINERS               |   1 +
 tcg/wasm.c                |  66 ++++++++++++++++
 tcg/wasm/tcg-target.c.inc | 160 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 tcg/wasm.c

V2:
- This commit generates both Wasm and TCI instrucitons.
- Although checkpatch.pl reports the following error in tcg/wasm.c,
  this file is based on the TCI code so it is preserved as-is.
  > New file 'tcg/wasm.c' must not have license boilerplate header text,
  > only the SPDX-License-Identifier, unless this file was copied from
  > existing code already having such text.

diff --git a/MAINTAINERS b/MAINTAINERS
index 89e4b51e22..217bf2066c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4003,6 +4003,7 @@ WebAssembly TCG target
 M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
 S: Maintained
 F: tcg/wasm/
+F: tcg/wasm.c
 
 Block drivers
 -------------
diff --git a/tcg/wasm.c b/tcg/wasm.c
new file mode 100644
index 0000000000..9f3b1344d6
--- /dev/null
+++ b/tcg/wasm.c
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * WebAssembly backend with forked TCI, based on tci.c
+ *
+ * Copyright (c) 2009, 2011, 2016 Stefan Weil
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "tcg/tcg.h"
+
+static void tci_args_rrr(uint32_t insn, TCGReg *r0, TCGReg *r1, TCGReg *r2)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+}
+
+static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
+{
+    const uint32_t *tb_ptr = v_tb_ptr;
+    tcg_target_ulong regs[TCG_TARGET_NB_REGS];
+    uint64_t stack[(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE)
+                   / sizeof(uint64_t)];
+
+    regs[TCG_AREG0] = (tcg_target_ulong)env;
+    regs[TCG_REG_CALL_STACK] = (uintptr_t)stack;
+
+    for (;;) {
+        uint32_t insn;
+        TCGOpcode opc;
+        TCGReg r0, r1, r2;
+
+        insn = *tb_ptr++;
+        opc = extract32(insn, 0, 8);
+
+        switch (opc) {
+        case INDEX_op_and:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] & regs[r2];
+            break;
+        case INDEX_op_or:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] | regs[r2];
+            break;
+        case INDEX_op_xor:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] ^ regs[r2];
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 4bcb594360..a1757b4db7 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -25,6 +25,10 @@
  * THE SOFTWARE.
  */
 
+#include "qemu/queue.h"
+
+typedef uint32_t tcg_insn_unit_tci;
+
 static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_R2,
     TCG_REG_R3,
@@ -109,3 +113,159 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     }
     return false;
 }
+
+/* converts a TCG register to a wasm variable index */
+static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
+    0,  /* TCG_REG_R0 */
+    1,  /* TCG_REG_R1 */
+    2,  /* TCG_REG_R2 */
+    3,  /* TCG_REG_R3 */
+    4,  /* TCG_REG_R4 */
+    5,  /* TCG_REG_R5 */
+    6,  /* TCG_REG_R6 */
+    7,  /* TCG_REG_R7 */
+    8,  /* TCG_REG_R8 */
+    9,  /* TCG_REG_R9 */
+    10, /* TCG_REG_R10 */
+    11, /* TCG_REG_R11 */
+    12, /* TCG_REG_R12 */
+    13, /* TCG_REG_R13 */
+    14, /* TCG_REG_R14 */
+    15, /* TCG_REG_R15 */
+};
+
+#define REG_IDX(r) tcg_target_reg_index[r]
+
+typedef enum {
+    OPC_GLOBAL_GET = 0x23,
+    OPC_GLOBAL_SET = 0x24,
+
+    OPC_I64_AND = 0x83,
+    OPC_I64_OR = 0x84,
+    OPC_I64_XOR = 0x85,
+} WasmInsn;
+
+#define BUF_SIZE 1024
+typedef struct LinkedBufEntry {
+    uint8_t data[BUF_SIZE];
+    uint32_t size;
+    QSIMPLEQ_ENTRY(LinkedBufEntry) entry;
+} LinkedBufEntry;
+
+typedef QSIMPLEQ_HEAD(, LinkedBufEntry) LinkedBuf;
+
+static void linked_buf_out8(LinkedBuf *linked_buf, uint8_t v)
+{
+    LinkedBufEntry *buf = QSIMPLEQ_LAST(linked_buf, LinkedBufEntry, entry);
+    if (!buf || (buf->size == BUF_SIZE)) {
+        LinkedBufEntry *e = tcg_malloc(sizeof(LinkedBufEntry));
+        e->size = 0;
+        QSIMPLEQ_INSERT_TAIL(linked_buf, e, entry);
+        buf = e;
+    }
+    buf->data[buf->size++] = v;
+}
+
+static void linked_buf_out_leb128(LinkedBuf *p, uint64_t v)
+{
+    uint8_t b;
+    do {
+        b = v & 0x7f;
+        v >>= 7;
+        if (v != 0) {
+            b |= 0x80;
+        }
+        linked_buf_out8(p, b);
+    } while (v != 0);
+}
+
+/*
+ * wasm code is generataed in the dynamically allocated buffer which
+ * are managed as a linked list.
+ */
+static __thread LinkedBuf sub_buf;
+
+static void init_sub_buf(void)
+{
+    QSIMPLEQ_INIT(&sub_buf);
+}
+static void tcg_wasm_out8(TCGContext *s, uint8_t v)
+{
+    linked_buf_out8(&sub_buf, v);
+}
+static void tcg_wasm_out_leb128(TCGContext *s, uint64_t v)
+{
+    linked_buf_out_leb128(&sub_buf, v);
+}
+
+static void tcg_wasm_out_op(TCGContext *s, WasmInsn opc)
+{
+    tcg_wasm_out8(s, opc);
+}
+static void tcg_wasm_out_op_idx(TCGContext *s, WasmInsn opc, uint32_t idx)
+{
+    tcg_wasm_out8(s, opc);
+    tcg_wasm_out_leb128(s, idx);
+}
+
+static void tcg_wasm_out_o1_i2(
+    TCGContext *s, WasmInsn opc, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+    tcg_wasm_out_op(s, opc);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
+                           TCGReg r0, TCGReg r1, TCGReg r2)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    tcg_out32(s, insn);
+}
+
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_and, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_AND, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_and,
+};
+
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_or, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_OR, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_or,
+};
+
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_xor, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_XOR, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_xor,
+};
+
+static void tcg_out_tb_start(TCGContext *s)
+{
+    init_sub_buf();
+}
-- 
2.43.0


