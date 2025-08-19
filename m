Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A39CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoQzr-0005RP-Kf; Tue, 19 Aug 2025 14:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzf-00058x-OJ; Tue, 19 Aug 2025 14:23:36 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzd-0003qA-Kh; Tue, 19 Aug 2025 14:23:35 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2445826fd9dso66421275ad.3; 
 Tue, 19 Aug 2025 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627811; x=1756232611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WhEVncf4NDGTpSVsEeHM/Vwx8xoF4Yy1hqyc+pyiVsI=;
 b=HywhTC2urmDNhS3yk8wY6Q6LIGHMPP4OsZ3WHvVWCTVugH9pk/AceFjRozv3dq1TaG
 ATjchglw6FcC+V/fkGu5ia51aFY3+2T/QxJ7o2JUb/+BmmUdKKYyuK+Jz19kdpFkjLU8
 M7AqsQMZ+yHikKa6qZ3S6aKQLcuK8pLjBG2HCXqzvtLLJeuy73JH0iFkxL3zXzr/hQ9B
 +kirEIytCyh2zoRisdHK25DLPnYqalsoFvPnTz4Fhlt3+/U0A53jwdk52UhHuLiyyGxy
 gx5hnsHf5yC+WaJr+Wjn0Kpxf2L7Kf1jvNEZSJHORbuI2bFqNl7S6OINYEnnPyS+d6sb
 eAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627811; x=1756232611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WhEVncf4NDGTpSVsEeHM/Vwx8xoF4Yy1hqyc+pyiVsI=;
 b=J4r+6oMEK7iAgExTN7wcQw5QZbo8+z8Alz/sPAWapfV1rUu5AemLWQWnD2WWe1/5oJ
 Cl/GhGIHL78Rw3DubFD7LT739djNrD+jDQouoOvq2aSF006NHMKzXHCtldSsKOsDiNJR
 ey35siqsyHHwQzb/KEZhJjqGplDbIAaig95GgAguN7clc7nQWfcw6K9jqVECtTyZmmnx
 n8hHHnymToRsmV4PuE0JHy78KdqnDJf78MObOiXcR90coYHZeBfGcR6llv/6vL72pXOa
 VRPUsWyQ8xYKUvSc/5qMUq0JMas71QE3JNzkKdVFxC+TvQMmuAk+pB5zsrpRvjC1OkiP
 4q3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcUpBfet3ragMTp3g0k/eBTlSisjvEouT5Uw0o7WkF+NcQxSODitIfMThOpOQ+d82q6OJp0W1eOQ==@nongnu.org,
 AJvYcCXyizsUCOjqd2fvlR/ULarlv0lrByVZ63L5JsItcR222g6ULJdLvmLt4lPE+ciQO6VvNy+y4KIrdoTnvA==@nongnu.org
X-Gm-Message-State: AOJu0YzTxIEuubgUGy3zMk/tO6D8Esj9xUcjiBdRTFSGohmcxGFWdLWa
 BpcIjZIARkTAt9cG0K++aNtpARASoS0BjG9h6q9mDpZI9ohOk7qbq5UvIokivWVj
X-Gm-Gg: ASbGnct2o5onrbBdkmHGAHXtQdbS10WQvm7VNUk6a61lxAEnBkcy2Wb3/olohY4My8X
 0tqGda8VzFTxb85ylOUBp/ClRDlsUUoYyr1EV4nD4xvFwfVj2s8Z8YWapNB1rr83NFL/Ro6eX6X
 02vSilR6Nu1zdcq8DhNkfoO2yvUv713vz5zYPYM0U+3+L7kwmgh0ng9T0aQcXIsHB6ZyPrH4V3S
 xeV/bBccTrPcDJfQkJmbANY82kOMcFbS9hvNGEHWeSbwGhsOR/yThhugEKfV9ZkP8o1uBWzjZfV
 GnkfL+3bAs557qjJU0a+FIBZpjMak9J6SFiB0rWaxjTAR5MC5fhiY5Pe/fBU1KuPA3mzmb07UQE
 jp8YhTr6t6mPcmHEJaJ80TQ==
X-Google-Smtp-Source: AGHT+IF71gLDQSPGnuG33RBH3DrItmDEU1rYVFkDKy9aqdKKfsQe2uL3bj/ENFiMeeysCK+kYocgDA==
X-Received: by 2002:a17:903:3bc6:b0:240:4faa:75cd with SMTP id
 d9443c01a7336-245e04d6698mr47334125ad.48.1755627811457; 
 Tue, 19 Aug 2025 11:23:31 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:23:30 -0700 (PDT)
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
Subject: [PATCH 10/35] tcg/wasm: Add and/or/xor instructions
Date: Wed, 20 Aug 2025 03:21:39 +0900
Message-ID: <8a445f65e74dc24aa68273bfb43377b52be830d0.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x632.google.com
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

This commit implements and, or and xor operations using Wasm
instructions. Each TCG variable is mapped to a 64bit Wasm variable. In Wasm,
these instructions work by first pushing the operands into the Wasm's stack
using get instructions. The result is left on the stack and this can be
assigned to a variable by popping it using a set instruction. The Wasm
binary format is documented at [1].

In this backend, TCI instructions are emitted to s->code_ptr, while the
corresponding Wasm instructions are generated into a separate buffer
allocated via tcg_malloc(). This buffer is intended to be merged into the TB
before tcg_gen_code returns.

Additionally, since the Wasm instuction's index operand must be
LEB128-encoded, this commit introduces an encoder function implemented
following [2].

[1] https://webassembly.github.io/spec/core/binary/index.html
[2] https://en.wikipedia.org/wiki/LEB128

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 110 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index f1c329eabd..8f7ead5e69 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -25,6 +25,8 @@
  * THE SOFTWARE.
  */
 
+#include "qemu/queue.h"
+
 /* Used for function call generation. */
 #define TCG_TARGET_CALL_STACK_OFFSET    0
 #define TCG_TARGET_STACK_ALIGN          8
@@ -92,6 +94,109 @@ static const char *const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 };
 #endif
 
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
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -551,6 +656,7 @@ static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_and, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_AND, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_and = {
@@ -741,6 +847,7 @@ static void tgen_or(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_or, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_OR, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_or = {
@@ -912,6 +1019,7 @@ static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_xor, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_XOR, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_xor = {
@@ -1246,7 +1354,7 @@ static inline void tcg_target_qemu_prologue(TCGContext *s)
 
 static void tcg_out_tb_start(TCGContext *s)
 {
-    /* nothing to do */
+    init_sub_buf();
 }
 
 bool tcg_target_has_memory_bswap(MemOp memop)
-- 
2.43.0


