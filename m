Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97389CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2zx-0008NJ-Bg; Mon, 01 Sep 2025 07:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zX-0007aK-62; Mon, 01 Sep 2025 07:46:32 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zS-0001Nl-Bs; Mon, 01 Sep 2025 07:46:30 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b4d1e7d5036so1804776a12.1; 
 Mon, 01 Sep 2025 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727174; x=1757331974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vMZeL4QMsFfiljq1rOi24ctLNCC6JX7BUMH0r5U4zqw=;
 b=fDjexBbhvVlSzHZWYjzoej3TtLVjBtGca4CllNOLjsYC4/BkUYKOW/kcOh0hXWHLvb
 TeH2jEpzNNpctqywP79B940A3LXB7z7XgetkwZskqBaW5mWhXgiNVKwM1WjU2sm0NC1B
 ktLleYqs9Acs+cFQWsS/4ndg0yw08KOAaK05ENSCydOecNk6dWg05m4p++g++yD7wvxu
 96kmXoAXiNHDMlhL5uSKzg0nCeyZjzPUZlc7Z5Z3s1i7AKShNHM63W5DRJ5g2+oXopHD
 DT3suFW/tv+tZ4+LNRFvnmTZHU4eQ7Y7WX2oLqOv/rI2hCmK15FEUbC+jyQUN8HOf2cF
 MsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727174; x=1757331974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vMZeL4QMsFfiljq1rOi24ctLNCC6JX7BUMH0r5U4zqw=;
 b=YcN/ZZLYJIopljQ7C2Uq2QIfocQH9PRD1TUBeAsKKTYSoeBD72V3b6AQPWE++N+EEW
 zbXySDGMJGS+GomeZiAcEfArpedAAnvSVtw+f+SbQ6nPgI3DMFt5cHh/emFPEQL28r4/
 A4bvAj5LFhnch1ifkHvw0I6J66uWSBQyeDqTHWH7RUbgbc66ltPSbbtDsjKxNF95QPPL
 tKPo0gyz7p1Y8Vi2eLZEacw1BbXEf33gD3St9dA8DIg9laNgSbknIsXEMqN1tmLQUk7v
 gyBBhVpUPUufBcEEMbirwcGKeF7m3RgnqA0Q4KVwY6kyBQFtGiiL+WtoLauu8tJSfb3y
 RZOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVayHVhCQYu3083mg5Akqg4aCjzrjWsHRDdvG/48d7fAbjqoy2O4eLTWDIg1V2UI27yWRogaqjSUVIr5A==@nongnu.org,
 AJvYcCXDjF6ARtyizLyiAHvWcvzmuGuHq3za4BpGr3wup4cDMBrRD2dtYMlG1sK5o7uG4KtnaZODzB9ADw==@nongnu.org
X-Gm-Message-State: AOJu0YzzHckFZEi2/WgxYQxKHGyq9eKYGueeIKCWASvLb8YBvL1Eladu
 7IhkyHANzbLOQoitvFwq07ic/PD93UuM9Et5OTDX7Nnsbo42nmfMmVnc4m/CjA==
X-Gm-Gg: ASbGncs74+tgscLpTlLVJHycy4uFKr+Q5NGx2bBbsWmj9D9rDZd5mhQvfiKwbVa4fyD
 I8oIlWQnvCQTo6fPR3wZF8NLiYfv1Q1yiOdWTseWhG3i8Hg00r8fQu4SWijgFQdKP643oN0W0Vp
 0OrRwl4hqwhEnUncVOfoA6HsIAa4Wj6IFhF+fU5vKR8iLBTm3OoooM0CmS1g9J8P52OYbPrumHD
 VnMh+ApHLpF43brOLyKioM3agsKyy4UHBdVqY3nKg2QFu95IKgaT0rjOk7GgqyqgVwobLDB6ie4
 36oaNdE5I2LqdzhK4FJ1Si/G/zzrmNW8Qow7xVn6X2dBmocGyo0JGs6TWSInQqdawxyLMC057KX
 HRlM1r5OczhiF9xNYHLVNRLpN1nWXYogY
X-Google-Smtp-Source: AGHT+IGy3HjJdd+8bZZcRad3yC6ILWjrjkHxEZpRVXjv6dyT3DFv3u2tLi4CIJi/qTWmLCRfCfnTQw==
X-Received: by 2002:a17:902:e80e:b0:248:f2cb:e52 with SMTP id
 d9443c01a7336-24944a6eaf6mr99835365ad.22.1756727173739; 
 Mon, 01 Sep 2025 04:46:13 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:46:13 -0700 (PDT)
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
Subject: [PATCH v3 09/35] tcg/wasm: Add and/or/xor instructions
Date: Mon,  1 Sep 2025 20:44:11 +0900
Message-ID: <f8cb9a61b63a69cce422b2964659b0e0472347bc.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52d.google.com
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

V3:
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


