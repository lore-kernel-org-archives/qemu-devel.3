Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE54C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMSh-0000mQ-Ho; Tue, 20 May 2025 08:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSf-0000lj-HM; Tue, 20 May 2025 08:52:49 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSd-0000jj-40; Tue, 20 May 2025 08:52:49 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb2so4489590a91.3; 
 Tue, 20 May 2025 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745564; x=1748350364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6Z5PLd1E/Owph8lAEt4RDxXTFlaySbmORvNcNjfV1I=;
 b=Q1tT0WNUwH+JTbdmAESN1DVQEuZ9kVJMKfCWJfOL4AwIvBmxjNMedMtm2IvKkdER0c
 OqKfiyfeowoIoxcvDgQVqDjW1ZR4VNJwZLXjFA5+GfMxqVxLYBZV3VMOnFhXmTa6tQBj
 2s0CZIv0JYGL8qfixq/ZN7FVHVGTN2GWHW0KbzyvXdrw6VOtleVUyn5rS/slL5pAgRj7
 Ebqc3UBreBbu3vaxkkohoBp5wqFv5cFmWIg2szcd8X83+3y4SDkN8Ii26DAKgGzKYxR8
 vrRedEGn2sKg21dawM0nneWCyFdMOM/fCS6n8vGzNcvJZWh58WWdWyxBvCgmx/SGYiHa
 +J7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745564; x=1748350364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6Z5PLd1E/Owph8lAEt4RDxXTFlaySbmORvNcNjfV1I=;
 b=W6B0ofh30IyEt1ejo53hSEiOmQ4FjYcicnY/pmoYz7ETE9gWMhESHIj7re+P3Op22c
 jkB9loR1/B86e7A+5uSrRLLdMrjpJxtd8QujYYf5meckQBn8/7UPkWPray1zhM712VTG
 BqeZb7WwpbWhUTryv8RsBR5eUUuCfi4TyUbqwLNNIGXCUZvm89+6e1HSHBhEwwb5RqOZ
 gdkdRRkOb49ZqEd/QlFtGSy7QGF3WMDXOleYXMhXI2i1jri1yIG6Cc9wsuQwNqBuJU1i
 0BJ62/deDnd5wXUJIIlKctgdJ6EZFUEsdtK2Jkzjsgey3tMd23jRM5j5tV/mBEcVwaAY
 uPTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSoVGFtUKP34nT9xGNlUKau+6LtoJ6iBH70I+EwmbldoinIF0aOX9d90xo3UJSNyXgAFs+ddYkYnd0Og==@nongnu.org,
 AJvYcCWuNIJiaJ68+RofakNlBcA668bEmtcXeBDT1Y7YLz7KeTYQA7zBNpQ1rTrE4Oy0AQj3r2ylbuSvFg==@nongnu.org
X-Gm-Message-State: AOJu0Yw3sO7bpIbbFcxyHhdAeUs+PoVIAMfSJ5FnrfRKOCJVQJyHt1NM
 xcLL5b+dSNEhnlPgbYptvXpr3RZ4Z/BYL12cMeSXop9I8/9W/f1GKCpAvR7qcVek
X-Gm-Gg: ASbGncsj+Q00nPmdUcfawA7nMzoizUrh3RbDB1LcAHxun2Bm9qs9V1yAsrTSNscGYNH
 flu9IYqpi5YpSTEfyqduSPxjk4R/bceAUsMpHDlb1Zwh4ZZDE8DFUyXUcYlG3OsrbkYdMSVYDPy
 t1LWAZ/Yw5eCSujUb3jWikjE2oL7OyiSwYPNvXk7yNIPnduyu+siphWCoyJmYL4MVzd8jI0kneM
 lcyq1U8GjMqMFa5kDGr1LQFHfzoVvVvPh6zjLvVoG2IO28G9n5gaDIki62ycyYqfyhSL+YiOqG+
 ZzNgEq5u8g+a7oJM/E6sN1jfpriwfOAjGoz8DlPdMu5Uuv+44ug=
X-Google-Smtp-Source: AGHT+IGav8G7VTphYSuRGrIc749qNZXTTFQq2XCpKhtKKY5hmmw6L/nazwAm2gCLphSuQxNyXadgJA==
X-Received: by 2002:a17:90a:e7cf:b0:30a:9025:84d1 with SMTP id
 98e67ed59e1d1-30e7d558d59mr29217944a91.16.1747745564197; 
 Tue, 20 May 2025 05:52:44 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:52:43 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 05/33] tcg/wasm32: Add and/or/xor instructions
Date: Tue, 20 May 2025 21:51:07 +0900
Message-ID: <582f109d49c5ef294ce7ad55ac75466f3128431a.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102d.google.com
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
and/or/xor instructions operate on values by first pushing the operands into
the Wasm's stack using get instructions. The result is left on the stack and
this can be assigned to a variable by popping it using a set instruction.

The Wasm binary format is documented at [1]. In this backend, TCI
instructions are emitted to s->code_ptr, while the corresponding Wasm
instructions are generated into a separated buffer allocated via
tcg_malloc(). These two code buffers must be merged into the final code
buffer before tcg_gen_code returns.

[1] https://webassembly.github.io/spec/core/binary/index.html

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 137 +++++++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 1 deletion(-)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index 126f9c0de7..e3a35c8415 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -98,6 +98,138 @@ static const char *const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
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
+#define BUF_SIZE 1024
+typedef struct LinkedBuf {
+    struct LinkedBuf *next;
+    uint8_t data[BUF_SIZE];
+    uint32_t size;
+} LinkedBuf;
+
+static LinkedBuf *new_linked_buf(void)
+{
+    LinkedBuf *p = tcg_malloc(sizeof(LinkedBuf));
+    p->size = 0;
+    p->next = NULL;
+    return p;
+}
+
+static inline LinkedBuf *linked_buf_out8(LinkedBuf *buf, uint8_t v)
+{
+    if (buf->size == BUF_SIZE) {
+        buf->next = new_linked_buf();
+        buf = buf->next;
+    }
+    buf->data[buf->size++] = v;
+    return buf;
+}
+
+static inline int linked_buf_len(LinkedBuf *buf)
+{
+    int total = 0;
+    for (LinkedBuf *p = buf; p; p = p->next) {
+        total += p->size;
+    }
+    return total;
+}
+
+static inline void linked_buf_write(LinkedBuf *buf, void *dst)
+{
+    for (LinkedBuf *p = buf; p; p = p->next) {
+        memcpy(dst, p->data, p->size);
+        dst += p->size;
+    }
+}
+
+/*
+ * wasm code is generataed in the dynamically allocated buffer which
+ * are managed as a linked list.
+ */
+__thread LinkedBuf *sub_buf_root;
+__thread LinkedBuf *sub_buf_cur;
+
+static void init_sub_buf(void)
+{
+    sub_buf_root = new_linked_buf();
+    sub_buf_cur = sub_buf_root;
+}
+
+static inline int sub_buf_len(void)
+{
+    return linked_buf_len(sub_buf_root);
+}
+
+static inline void tcg_wasm_out8(TCGContext *s, uint32_t v)
+{
+    sub_buf_cur = linked_buf_out8(sub_buf_cur, v);
+}
+
+static void tcg_wasm_out_op_i64_and(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x83);
+}
+static void tcg_wasm_out_op_i64_or(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x84);
+}
+static void tcg_wasm_out_op_i64_xor(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x85);
+}
+static void tcg_wasm_out_op_var(TCGContext *s, uint8_t instr, uint8_t i)
+{
+    tcg_wasm_out8(s, instr);
+    tcg_wasm_out8(s, i);
+}
+static void tcg_wasm_out_op_global_get(TCGContext *s, uint8_t i)
+{
+    tcg_wasm_out_op_var(s, 0x23, i);
+}
+static void tcg_wasm_out_op_global_set(TCGContext *s, uint8_t i)
+{
+    tcg_wasm_out_op_var(s, 0x24, i);
+}
+static void tcg_wasm_out_op_global_get_r(TCGContext *s, TCGReg r0)
+{
+    tcg_wasm_out_op_global_get(s, tcg_target_reg_index[r0]);
+}
+static void tcg_wasm_out_op_global_set_r(TCGContext *s, TCGReg r0)
+{
+    tcg_wasm_out_op_global_set(s, tcg_target_reg_index[r0]);
+}
+
+#define tcg_wasm_out_i64_calc(op)                                       \
+    static void tcg_wasm_out_i64_calc_##op(                             \
+        TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)            \
+    {                                                                   \
+        tcg_wasm_out_op_global_get_r(s, arg1);                          \
+        tcg_wasm_out_op_global_get_r(s, arg2);                          \
+        tcg_wasm_out_op_i64_##op(s);                                    \
+        tcg_wasm_out_op_global_set_r(s, ret);                           \
+    }
+tcg_wasm_out_i64_calc(and);
+tcg_wasm_out_i64_calc(or);
+tcg_wasm_out_i64_calc(xor);
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -557,6 +689,7 @@ static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_and, a0, a1, a2);
+    tcg_wasm_out_i64_calc_and(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_and = {
@@ -747,6 +880,7 @@ static void tgen_or(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_or, a0, a1, a2);
+    tcg_wasm_out_i64_calc_or(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_or = {
@@ -918,6 +1052,7 @@ static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_xor, a0, a1, a2);
+    tcg_wasm_out_i64_calc_xor(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_xor = {
@@ -1305,7 +1440,7 @@ static inline void tcg_target_qemu_prologue(TCGContext *s)
 
 static void tcg_out_tb_start(TCGContext *s)
 {
-    /* nothing to do */
+    init_sub_buf();
 }
 
 bool tcg_target_has_memory_bswap(MemOp memop)
-- 
2.43.0


