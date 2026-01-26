Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B37C88E5A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGt9-0004zb-OJ; Mon, 26 Jan 2026 02:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGfZ-0002zM-6M
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:58 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGf3-0004MK-HF
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:37 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8220bd582ddso2075785b3a.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411119; x=1770015919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPrO3MqYxjuyosp2uxkP4V042VRYRHbBi3On28UyzFo=;
 b=JWdOKDjA/FgCy/DW/Z/eqDhouTUD7YldzCD9YPodRMh3S9ArYRnsV7hkhtn+bT4o1i
 BxvNpHyAIjDcU6HLYyfjLweg+Fp3P0rsTZ7REN572usq+cEar4zfqOK5KRoc/Etf0IVI
 B9ALwQDsTk/zuyv5dxS37ZRkHAmcMxV+5B5mjfQXpgt1N6vV6yzDhqh1exMqUg+cc581
 MNkCLVxEum0RR80Kz3kqEdPiDb6b9goHO8ubUeUQvfwsCLzN+uH0TQMHEsyc9ewib/vU
 S3mCbzUnhjM10U2S8Nl5I/3KnpZEeqief45wUduU2U31bXijyVv+68Ucf1kJuc5kI7DJ
 3tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411119; x=1770015919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LPrO3MqYxjuyosp2uxkP4V042VRYRHbBi3On28UyzFo=;
 b=PDkv980QcSPUNVrmVE6VbWcWk9GZCzeAGI9/44zKsddwBBkKmPnpYSHd2mbhnJpaQF
 /JbEGYeVjEvJ68t2qY7HpwzC78VFtCN+Ad7BjAT1cTueIhUPatDVM+n9T9g4yUebABqQ
 94ujx/Oc/xTHEWLfsidiSEmdymBYLk3gPCCQU/jOHp4Q4pAtkIO5UykkyPyQHT31FeXP
 zBZTkb4CSVDuTeLM7/KvZFZ984I7nnc1QVmlOVxib3GDCmxamwPBRvfgVfhdCy7dQPrQ
 BGScPdV7gesBzk9MFkto8HgUWPJCoSR7NLdjJjQ54KfqU02lKNzaDrRL3DYlwVz2SFM2
 VMsg==
X-Gm-Message-State: AOJu0YwGt3s/RifmwEeD9Srpai9WNr/oErDMZCmrpyTpaXUPxaT485el
 Qp8TotPBKTYmcdv3hxJrtqxHf047yrsZCfJWlcKo3Kv1Z3SoRk5u1amQ08twZ0bG
X-Gm-Gg: AZuq6aKlvi/NGySARRuq+PPZ8MUHlI+iWz6K4hmphxAeb/qJZwAIcIfOxEkTJ14B95G
 gzFML1iBCce6hkSMzjSnSs825bHyrLiXZJ+ueVMCM7voB+/yXm8E09BVpvh1ZjWx+sSwv5v9/Q6
 N9fM4zG4xqIAGOcnMRw5WfYXqqsw2H2h3tlJ7fyfRtqcRrNqSXj9A5dCWsb8te2isnzr8J6/WWq
 zTQWG/hqIeeoe6xkLy7CZ4s7YsUccv5ehwb5rRydEFzCzyooSBfQDxBV5zDKaORJxKD3xMtEkgp
 B4BW/9LphAzDUaCYqHVgvSXtr2YJ5La2PGZWZyvRyxC+ikTdnns3C/9iR3JkDkCfGwJRki76HoW
 GQmG9uMx9x8bxItK6l7uj+ZoLq9KKXa5vyFL3O5433CjE9+h4TqylasiTaQ48XE016WNpp+0GOd
 isspcoeBKDxCKk27LDI0k7k/d3C1Hz5ZhjyqTnYDbJxg==
X-Received: by 2002:a05:6a00:1ca2:b0:823:f96:63bb with SMTP id
 d2e1a72fcca58-823412a30c2mr3250724b3a.52.1769411119374; 
 Sun, 25 Jan 2026 23:05:19 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:05:18 -0800 (PST)
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
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 16/33] tcg/wasm64: Add br/brcond instructions
Date: Mon, 26 Jan 2026 07:03:29 +0000
Message-ID: <f51f09b159ab7b6c23318171af530ac6bc1310cb.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Wasm does not support direct jumps to arbitrary code addresses, so br and
brcond are implemented using Wasm's control flow instructions.

As illustrated in the pseudo-code below, each TB wraps Wasm instructions
inside a large loop. Each set of codes separated by TCG labels is placed
inside an "if" block. Br is implemented by breaking out of the current block
and entering the target block:

loop
  if
    ... code after the first label
  end
  if
    ... code after the second label
  end
  ...
end

Each block is assigned an unique integer ID. The br implementation sets the
destination block's ID in BLOCK_IDX Wasm variable and breaks from the
current if block. As control flow continues, each if block checks whether
the BLOCK_IDX matches its own ID. If so, execution resumes within that
block.

The tcg_out_tb_start function generates the start of the global loop and the
first if block. To properly close these blocks, this commit also introduces
a new callback tcg_out_tb_end which emits the "end" instructions for the
final if block and the loop.

Another new callback tcg_out_label_cb is used to emit block boundaries,
specifically the end of the previous block and the if of the next block, at
label positions. It also records the mapping between label IDs and block IDs
in a LabelInfo list.

Since the block ID for a label might not be known when a br instruction is
generated, a placeholder is emitted instead. These placeholders are tracked
in a BlockPlaceholder list and resolved later using LabelInfo.

TCI instructions are also generated in the same way as the original TCI
backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/aarch64/tcg-target.c.inc     |  11 ++
 tcg/loongarch64/tcg-target.c.inc |  11 ++
 tcg/mips64/tcg-target.c.inc      |  11 ++
 tcg/ppc64/tcg-target.c.inc       |  11 ++
 tcg/riscv64/tcg-target.c.inc     |  11 ++
 tcg/s390x/tcg-target.c.inc       |  11 ++
 tcg/sparc64/tcg-target.c.inc     |  11 ++
 tcg/tcg.c                        |   7 ++
 tcg/tci/tcg-target.c.inc         |  11 ++
 tcg/wasm64.c                     |  16 +++
 tcg/wasm64/tcg-target.c.inc      | 196 +++++++++++++++++++++++++++++++
 tcg/x86_64/tcg-target.c.inc      |  11 ++
 12 files changed, 318 insertions(+)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index caf79c742d..112659e7b6 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3514,6 +3514,17 @@ static void tcg_out_tb_start(TCGContext *s)
     tcg_out_bti(s, BTI_J);
 }
 
+static int tcg_out_tb_end(TCGContext *s)
+{
+    /* nothing to do */
+    return 0;
+}
+
+static void tcg_out_label_cb(TCGContext *s, TCGLabel *l)
+{
+    /* nothing to do */
+}
+
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 {
     int i;
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index c3350c90fc..2532395f44 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2658,6 +2658,17 @@ static void tcg_out_tb_start(TCGContext *s)
     /* nothing to do */
 }
 
+static int tcg_out_tb_end(TCGContext *s)
+{
+    /* nothing to do */
+    return 0;
+}
+
+static void tcg_out_label_cb(TCGContext *s, TCGLabel *l)
+{
+    /* nothing to do */
+}
+
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 {
     for (int i = 0; i < count; ++i) {
diff --git a/tcg/mips64/tcg-target.c.inc b/tcg/mips64/tcg-target.c.inc
index 60c703a093..4b8dd9393f 100644
--- a/tcg/mips64/tcg-target.c.inc
+++ b/tcg/mips64/tcg-target.c.inc
@@ -2522,6 +2522,17 @@ static void tcg_out_tb_start(TCGContext *s)
     /* nothing to do */
 }
 
+static int tcg_out_tb_end(TCGContext *s)
+{
+    /* nothing to do */
+    return 0;
+}
+
+static void tcg_out_label_cb(TCGContext *s, TCGLabel *l)
+{
+    /* nothing to do */
+}
+
 static void tcg_target_init(TCGContext *s)
 {
     tcg_target_detect_isa();
diff --git a/tcg/ppc64/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
index b54afa0b6d..340a2829f6 100644
--- a/tcg/ppc64/tcg-target.c.inc
+++ b/tcg/ppc64/tcg-target.c.inc
@@ -2643,6 +2643,17 @@ static void tcg_out_tb_start(TCGContext *s)
     }
 }
 
+static int tcg_out_tb_end(TCGContext *s)
+{
+    /* nothing to do */
+    return 0;
+}
+
+static void tcg_out_label_cb(TCGContext *s, TCGLabel *l)
+{
+    /* nothing to do */
+}
+
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
 {
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R3, arg);
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 76dd4fca97..a6f7fbeee2 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -2988,6 +2988,17 @@ static void tcg_out_tb_start(TCGContext *s)
     init_setting_vtype(s);
 }
 
+static int tcg_out_tb_end(TCGContext *s)
+{
+    /* nothing to do */
+    return 0;
+}
+
+static void tcg_out_label_cb(TCGContext *s, TCGLabel *l)
+{
+    /* nothing to do */
+}
+
 static bool vtype_check(unsigned vtype)
 {
     unsigned long tmp;
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 84a9e73a46..457e568d30 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3830,6 +3830,17 @@ static void tcg_out_tb_start(TCGContext *s)
     /* nothing to do */
 }
 
+static int tcg_out_tb_end(TCGContext *s)
+{
+    /* nothing to do */
+    return 0;
+}
+
+static void tcg_out_label_cb(TCGContext *s, TCGLabel *l)
+{
+    /* nothing to do */
+}
+
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 {
     memset(p, 0x07, count * sizeof(tcg_insn_unit));
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 5e5c3f1cda..ae695b115b 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1017,6 +1017,17 @@ static void tcg_out_tb_start(TCGContext *s)
     /* nothing to do */
 }
 
+static int tcg_out_tb_end(TCGContext *s)
+{
+    /* nothing to do */
+    return 0;
+}
+
+static void tcg_out_label_cb(TCGContext *s, TCGLabel *l)
+{
+    /* nothing to do */
+}
+
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 {
     int i;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e7bf4dad4e..3c68699138 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -116,6 +116,7 @@ static void tcg_register_jit_int(const void *buf, size_t size,
 
 /* Forward declarations for functions declared and used in tcg-target.c.inc. */
 static void tcg_out_tb_start(TCGContext *s);
+static int tcg_out_tb_end(TCGContext *s);
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1,
                        intptr_t arg2);
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg);
@@ -187,6 +188,7 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target,
 static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot);
 static bool tcg_target_const_match(int64_t val, int ct,
                                    TCGType type, TCGCond cond, int vece);
+static void tcg_out_label_cb(TCGContext *s, TCGLabel *l);
 
 #ifndef CONFIG_USER_ONLY
 #define guest_base  ({ qemu_build_not_reached(); (uintptr_t)0; })
@@ -357,6 +359,7 @@ static void tcg_out_label(TCGContext *s, TCGLabel *l)
     tcg_debug_assert(!l->has_value);
     l->has_value = 1;
     l->u.value_ptr = tcg_splitwx_to_rx(s->code_ptr);
+    tcg_out_label_cb(s, l);
 }
 
 TCGLabel *gen_new_label(void)
@@ -6746,6 +6749,10 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     if (!tcg_resolve_relocs(s)) {
         return -2;
     }
+    i = tcg_out_tb_end(s);
+    if (i < 0) {
+        return i;
+    }
 
 #ifndef CONFIG_TCG_INTERPRETER
     /* flush instruction cache */
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 1b22c70616..940f9f93bb 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1241,6 +1241,17 @@ static void tcg_out_tb_start(TCGContext *s)
     /* nothing to do */
 }
 
+static int tcg_out_tb_end(TCGContext *s)
+{
+    /* nothing to do */
+    return 0;
+}
+
+static void tcg_out_label_cb(TCGContext *s, TCGLabel *l)
+{
+    /* nothing to do */
+}
+
 bool tcg_target_has_memory_bswap(MemOp memop)
 {
     return true;
diff --git a/tcg/wasm64.c b/tcg/wasm64.c
index 2688ded58a..ca67436192 100644
--- a/tcg/wasm64.c
+++ b/tcg/wasm64.c
@@ -22,6 +22,12 @@
 #include "tcg/tcg.h"
 #include "tcg/tcg-ldst.h"
 
+static void tci_args_l(uint32_t insn, const void *tb_ptr, void **l0)
+{
+    int diff = sextract32(insn, 12, 20);
+    *l0 = diff ? (void *)tb_ptr + diff : NULL;
+}
+
 static void tci_args_rl(uint32_t insn, const void *tb_ptr,
                         TCGReg *r0, void **l1)
 {
@@ -397,6 +403,16 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ror32(regs[r1], regs[r2] & 31);
             break;
+        case INDEX_op_br:
+            tci_args_l(insn, tb_ptr, &ptr);
+            tb_ptr = ptr;
+            continue;
+        case INDEX_op_brcond:
+            tci_args_rl(insn, tb_ptr, &r0, &ptr);
+            if (regs[r0]) {
+                tb_ptr = ptr;
+            }
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index 1d980fb99f..3fe0ae2381 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -136,10 +136,16 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
 
 #define REG_IDX(r) tcg_target_reg_index[r]
 
+/* Global variable used for storing the current block index */
+#define BLOCK_IDX 16
+
 typedef enum {
+    OPC_UNREACHABLE = 0x00,
+    OPC_LOOP = 0x03,
     OPC_IF = 0x04,
     OPC_ELSE = 0x05,
     OPC_END = 0x0b,
+    OPC_BR = 0x0c,
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
 
@@ -221,6 +227,7 @@ typedef enum {
 } WasmInsn;
 
 typedef enum {
+    BLOCK_NORET = 0x40,
     BLOCK_I64 = 0x7e,
     BLOCK_I32 = 0x7f,
 } WasmBlockType;
@@ -276,6 +283,17 @@ static void linked_buf_out_sleb128(LinkedBuf *p, int64_t v)
     }
 }
 
+static int linked_buf_len(LinkedBuf *p)
+{
+    int total = 0;
+    LinkedBufEntry *e;
+
+    QSIMPLEQ_FOREACH(e, p, entry) {
+        total += e->size;
+    }
+    return total;
+}
+
 /*
  * wasm code is generataed in the dynamically allocated buffer which
  * are managed as a linked list.
@@ -286,6 +304,10 @@ static void init_sub_buf(void)
 {
     QSIMPLEQ_INIT(&sub_buf);
 }
+static int sub_buf_len(void)
+{
+    return linked_buf_len(&sub_buf);
+}
 static void tcg_wasm_out8(TCGContext *s, uint8_t v)
 {
     linked_buf_out8(&sub_buf, v);
@@ -610,6 +632,134 @@ static void tcg_wasm_out_cz(
     }
 }
 
+typedef struct LabelInfo {
+    int label;
+    int block;
+    QSIMPLEQ_ENTRY(LabelInfo) entry;
+} LabelInfo;
+
+static __thread QSIMPLEQ_HEAD(, LabelInfo) label_info;
+
+static void init_label_info(void)
+{
+    QSIMPLEQ_INIT(&label_info);
+}
+
+static void add_label(int label, int block)
+{
+    LabelInfo *e = tcg_malloc(sizeof(LabelInfo));
+    e->label = label;
+    e->block = block;
+    QSIMPLEQ_INSERT_TAIL(&label_info, e, entry);
+}
+
+typedef struct BlockPlaceholder {
+    int label;
+    int pos;
+    QSIMPLEQ_ENTRY(BlockPlaceholder) entry;
+} BlockPlaceholder;
+
+static __thread QSIMPLEQ_HEAD(, BlockPlaceholder) block_placeholder;
+static __thread int64_t cur_block_idx;
+
+static void init_blocks(void)
+{
+    QSIMPLEQ_INIT(&block_placeholder);
+    cur_block_idx = 0;
+}
+
+static void add_block_placeholder(int label, int pos)
+{
+    BlockPlaceholder *e = tcg_malloc(sizeof(BlockPlaceholder));
+    e->label = label;
+    e->pos = pos;
+    QSIMPLEQ_INSERT_TAIL(&block_placeholder, e, entry);
+}
+
+static int get_block_of_label(int label)
+{
+    LabelInfo *e;
+    QSIMPLEQ_FOREACH(e, &label_info, entry) {
+        if (e->label == label) {
+            return e->block;
+        }
+    }
+    return -1;
+}
+
+static void tcg_wasm_out_new_block(TCGContext *s)
+{
+    tcg_wasm_out_op(s, OPC_END); /* close this block */
+
+    /* next block */
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, BLOCK_IDX);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, ++cur_block_idx);
+    tcg_wasm_out_op(s, OPC_I64_LE_U);
+    tcg_wasm_out_op_block(s, OPC_IF, BLOCK_NORET);
+}
+
+static void tcg_out_label_cb(TCGContext *s, TCGLabel *l)
+{
+    add_label(l->id, cur_block_idx + 1);
+    tcg_wasm_out_new_block(s);
+}
+
+static void tcg_wasm_out_br_to_label(TCGContext *s, TCGLabel *l, bool br_if)
+{
+    int toploop_depth = 1;
+    if (br_if) {
+        tcg_wasm_out_op_block(s, OPC_IF, BLOCK_NORET);
+        toploop_depth++;
+    }
+    tcg_wasm_out8(s, OPC_I64_CONST);
+
+    add_block_placeholder(l->id, sub_buf_len());
+
+    tcg_wasm_out8(s, 0x80); /* placeholder for the target block idx */
+    tcg_wasm_out8(s, 0x80);
+    tcg_wasm_out8(s, 0x80);
+    tcg_wasm_out8(s, 0x80);
+    tcg_wasm_out8(s, 0x00);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, BLOCK_IDX);
+    if (get_block_of_label(l->id) != -1) {
+        /*
+         * The label is placed before this br, branch to the top of loop
+         */
+        tcg_wasm_out_op_idx(s, OPC_BR, toploop_depth);
+    } else {
+        /*
+         * The label will be generated after this br,
+         * branch to the end of the current block
+         */
+        tcg_wasm_out_op_idx(s, OPC_BR, toploop_depth - 1);
+    }
+    if (br_if) {
+        tcg_wasm_out_op(s, OPC_END);
+    }
+}
+
+static void tcg_wasm_out_br(TCGContext *s, TCGLabel *l)
+{
+    tcg_wasm_out_br_to_label(s, l, false);
+}
+
+static void tcg_wasm_out_brcond(TCGContext *s, TCGType type,
+                                TCGReg arg1, TCGReg arg2,
+                                TCGCond cond, TCGLabel *l)
+{
+    tcg_wasm_out_cond(s, type, cond, arg1, arg2);
+    tcg_wasm_out_br_to_label(s, l, true);
+}
+
+static void tcg_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    tcg_out_reloc(s, s->code_ptr, 20, l0, 0);
+    insn = deposit32(insn, 0, 8, op);
+    tcg_out32(s, insn);
+}
+
 static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -621,6 +771,16 @@ static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
     tcg_out32(s, insn);
 }
 
+static void tcg_out_op_rl(TCGContext *s, TCGOpcode op, TCGReg r0, TCGLabel *l1)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    tcg_out_reloc(s, s->code_ptr, 20, l1, 0);
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    tcg_out32(s, insn);
+}
+
 static void tcg_out_op_rr(TCGContext *s, TCGOpcode op, TCGReg r0, TCGReg r1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -1289,7 +1449,43 @@ static const TCGOutOpBinary outop_ctz = {
     .out_rrr = tgen_ctz,
 };
 
+static void tgen_brcond(TCGContext *s, TCGType type, TCGCond cond,
+                        TCGReg arg0, TCGReg arg1, TCGLabel *l)
+{
+    tgen_setcond_tci(s, type, cond, TCG_REG_TMP, arg0, arg1);
+    tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, l);
+    tcg_wasm_out_brcond(s, type, arg0, arg1, cond, l);
+}
+
+static const TCGOutOpBrcond outop_brcond = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_rr = tgen_brcond,
+};
+
+static void tcg_out_br(TCGContext *s, TCGLabel *l)
+{
+    tcg_out_op_l(s, INDEX_op_br, l);
+    tcg_wasm_out_br(s, l);
+}
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
+    init_blocks();
+    init_label_info();
+
+    tcg_wasm_out_op_block(s, OPC_LOOP, BLOCK_NORET);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, BLOCK_IDX);
+    tcg_wasm_out_op(s, OPC_I64_EQZ);
+    tcg_wasm_out_op_block(s, OPC_IF, BLOCK_NORET);
+}
+
+static int tcg_out_tb_end(TCGContext *s)
+{
+    tcg_wasm_out_op(s, OPC_END); /* end if */
+    tcg_wasm_out_op(s, OPC_END); /* end loop */
+    tcg_wasm_out_op(s, OPC_UNREACHABLE);
+    tcg_wasm_out_op(s, OPC_END); /* end func */
+
+    return 0;
 }
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 92251f8327..61e70b337b 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -4504,6 +4504,17 @@ static void tcg_out_tb_start(TCGContext *s)
     /* nothing to do */
 }
 
+static int tcg_out_tb_end(TCGContext *s)
+{
+    /* nothing to do */
+    return 0;
+}
+
+static void tcg_out_label_cb(TCGContext *s, TCGLabel *l)
+{
+    /* nothing to do */
+}
+
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 {
     memset(p, 0x90, count);
-- 
2.43.0


