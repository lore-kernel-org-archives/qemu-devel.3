Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FB4C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMUj-0003Rf-IM; Tue, 20 May 2025 08:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUH-0002OR-9q; Tue, 20 May 2025 08:54:32 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUE-0000zS-W2; Tue, 20 May 2025 08:54:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23229fdaff4so29806875ad.1; 
 Tue, 20 May 2025 05:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745660; x=1748350460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDG0pwUWpFnKg/l7uQqlMEQTPTDfS039RvtWFwYIZBA=;
 b=QNwefYrTCo4Q9vrUasKatJr34MtZdVx0Mpms1c7GT/jtgMnF4yw1vhVHmZb6Abzxjk
 5HTpwNZzr4L2pqFV908xBzKss1OLlqixlOpb1woa9uam3h4cJIZjDDHyAwwflIsmzuUm
 61rK9/GgZOya+XdC5RIFNoBcStXcKPdE8cmwcM7FZ7PmWNfWNptNLu2c29MYqwKg4niN
 4vLIUUZ9gxruQ/6Yu98c8M+kx2NpK90rF19zbL8Y6shvSHhIYB9NhBGDH2v9O16RCR4v
 pODfSICmjJ5JsKtN0jOGfXUZbJwhqAfRLoPJofWvTF/x5w6wt1FT+2Xnl4Ev98yCqXdq
 zADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745660; x=1748350460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDG0pwUWpFnKg/l7uQqlMEQTPTDfS039RvtWFwYIZBA=;
 b=goWktzt2YjOlq/gFk2T+pNK29J01xhZhF1nUMQ+mu72uaZ0CNGmO+K0IDKbZ7jS4pO
 QDHaytiVmATNYcOXmzwSS3pCpRIvqwD2mb0tU8yXa6Zi9tPglxHwfYknOxQU/9itCxAz
 9jlq295D/0/lxvRb/1Fwl56LN0XbeToIXVCOmpTM0vGzIWCvJ7odLyBQkwVm7/Eg3bLk
 jlQ4BHcj95Tu0VdJ2PW+v2+jYUGZ2ML5eG2+su59P80TKpEdaxmsQFPOzFqWagJFu7mw
 K1YEVB1i1uC44lC4+ztstkIgQLohpGrKoUmNFTetaH5HYWR4C+o4cFElQ4L+Zm0oTwxe
 Z70w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvTGkYYMpZlGiFT+Mh90ViZDDeP+jwLKotaVAtxER+IdZgVcAdoeRlejleTD0sI1zUADMivWiM4m+AlQ==@nongnu.org,
 AJvYcCWGJ0H+64r49n5KbgkASVWsrdi1dkBSsg6Eazpj+dpEemh1bUnOOgMMKHzBIFcdaTJoLgjlo0IcOw==@nongnu.org
X-Gm-Message-State: AOJu0YykACIgSbpbCZkBMIEFZc89BWJc5lJOBlsfu+UcC9mRJodN7UMB
 KdB5TbH8a+aGvfifh5gyOsAIjaYM2n6H6mAuKWNZOSuwwXaADMCF/HOvG76A+Jg5
X-Gm-Gg: ASbGnctdAlK1uT9Esi1YB25qsuq0ahAyEtRMz1kXoGdIN+P7WEg70LaikAFFke4oE73
 arkvJUM0dnLws5LrYTP5a1WgaVfmDY5lK2buDNCxSNHeCUhAnTbNDYZEJAE+A8knL6EpTNrywIx
 buo68VbdyACHvjdkPPctcZ8aCs9ZZZXKO4r/8Qww5N5S/JH34Wgi9gCjeREF25ZvH5j4lbMNE/U
 04HMwfeDENPJ/fZ4xwWiQ0kLa4zaBiC/e1cY7zFxvfFIThRwQAYA+UZmsDOAH4yZnuMEVD3UOEM
 eAb8rUe+e/C5YjSS/7ho6B2gARx9Bb5W2fe62L4p+BKK+wqeiKU=
X-Google-Smtp-Source: AGHT+IHsAaRA9611AxQxc5NVjTREuknnJ6IQooXldl0fBT1ED1f+IK7+hrgUEmMdzmSvtkHTD8mfWg==
X-Received: by 2002:a17:90b:2c8c:b0:30e:823f:ef31 with SMTP id
 98e67ed59e1d1-30e823ff071mr24002616a91.29.1747745648991; 
 Tue, 20 May 2025 05:54:08 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:54:08 -0700 (PDT)
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
Subject: [PATCH 20/33] tcg/wasm32: Add exit_tb/goto_tb/goto_ptr instructions
Date: Tue, 20 May 2025 21:51:22 +0900
Message-ID: <021c0cb8cc58c4cb673b38b75d20d27e8dec1c40.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x631.google.com
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

In the Wasm backend, each TB is compiled to a separeted Wasm
module. Control transfer between TBs (i.e. from one Wasm module to
another) is handled by the caller of the module.

The goto_tb and goto_ptr operations are implemented by returning
control to the caller using the return instruction. The destination
TB's pointer is passed to the caller via a shared wasmContext
structure which is accessible from both the Wasm module and the caller. This
wasmContext must be provided to the module as an argument which is
accessible as the local variable at index 0.

If the destination TB is the current TB itself, there is no need to
return control to the caller. Instead, execution can jump directly to
the top of the loop within the TB.

The exit_tb operation sets the pointer in wasmContext to 0, indicating that
there is no destination TB.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 MAINTAINERS                 |   1 +
 tcg/wasm32.h                |  17 ++++++
 tcg/wasm32/tcg-target.c.inc | 111 ++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 tcg/wasm32.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ac5070d058..3ca93f90de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3953,6 +3953,7 @@ M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
 S: Maintained
 F: tcg/wasm32/
 F: tcg/wasm32.c
+F: tcg/wasm32.h
 
 Block drivers
 -------------
diff --git a/tcg/wasm32.h b/tcg/wasm32.h
new file mode 100644
index 0000000000..ffa359b7dc
--- /dev/null
+++ b/tcg/wasm32.h
@@ -0,0 +1,17 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef TCG_WASM32_H
+#define TCG_WASM32_H
+
+/*
+ * wasmContext is a data shared among QEMU and wasm modules.
+ */
+struct wasmContext {
+    /*
+     * Pointer to the TB to be executed.
+     */
+    void *tb_ptr;
+};
+
+#endif
diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index ea0d1ca874..77db50cf85 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -25,6 +25,8 @@
  * THE SOFTWARE.
  */
 
+#include "../wasm32.h"
+
 /* Used for function call generation. */
 #define TCG_TARGET_CALL_STACK_OFFSET    0
 #define TCG_TARGET_STACK_ALIGN          8
@@ -128,6 +130,11 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
  */
 #define BLOCK_PTR_IDX 17
 
+/*
+ * pointer to wasmContext
+ */
+#define CTX_IDX 0
+
 /* Temporary local variables */
 #define TMP32_LOCAL_0_IDX 1
 #define TMP32_LOCAL_1_IDX 2
@@ -334,6 +341,14 @@ static void tcg_wasm_out_op_i32_eqz(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x45);
 }
+static void tcg_wasm_out_op_i32_eq(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x46);
+}
+static void tcg_wasm_out_op_i32_ne(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x47);
+}
 static void tcg_wasm_out_op_i64_lt_u(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x54);
@@ -380,6 +395,10 @@ static void tcg_wasm_out_op_end(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x0b);
 }
+static void tcg_wasm_out_op_return(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x0f);
+}
 static void tcg_wasm_out_op_var(TCGContext *s, uint8_t instr, uint8_t i)
 {
     tcg_wasm_out8(s, instr);
@@ -590,6 +609,16 @@ static void tcg_wasm_out_op_i64_load32_u(TCGContext *s, uint32_t a, uint32_t o)
     tcg_wasm_out_op_loadstore(s, 0x35, a, o);
 }
 
+static void tcg_wasm_out_op_i32_load(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x28, a, o);
+}
+
+static void tcg_wasm_out_op_i32_store(TCGContext *s, uint32_t a, uint32_t o)
+{
+    tcg_wasm_out_op_loadstore(s, 0x36, a, o);
+}
+
 static void tcg_wasm_out_op_not(TCGContext *s)
 {
     tcg_wasm_out_op_i64_const(s, -1);
@@ -1518,6 +1547,85 @@ static void tcg_wasm_out_brcond(TCGContext *s, TCGType type,
     tcg_wasm_out_op_br_to_label(s, l, true);
 }
 
+#define tcg_wasm_out_ctx_i32_store_const(s, f, v)                       \
+    do {                                                                \
+        tcg_wasm_out_op_local_get(s, CTX_IDX);                          \
+        tcg_wasm_out_op_i32_const(s, v);                                \
+        tcg_wasm_out_op_i32_store(s, 0, offsetof(struct wasmContext, f)); \
+    } while (0)
+
+#define tcg_wasm_out_ctx_i32_store_r(s, f, r)                           \
+    do {                                                                \
+        tcg_wasm_out_op_local_get(s, CTX_IDX);                          \
+        tcg_wasm_out_op_global_get_r(s, r);                             \
+        tcg_wasm_out_op_i32_wrap_i64(s);                                \
+        tcg_wasm_out_op_i32_store(s, 0, offsetof(struct wasmContext, f)); \
+    } while (0)
+
+#define tcg_wasm_out_ctx_i32_store_local32(s, f, var)                   \
+    do {                                                                \
+        tcg_wasm_out_op_local_get(s, CTX_IDX);                          \
+        tcg_wasm_out_op_local_get(s, var);                              \
+        tcg_wasm_out_op_i32_store(s, 0, offsetof(struct wasmContext, f)); \
+    } while (0)
+
+#define tcg_wasm_out_ctx_i32_load(s, f)                                 \
+    do {                                                                \
+        tcg_wasm_out_op_local_get(s, CTX_IDX);                          \
+        tcg_wasm_out_op_i32_load(s, 0, offsetof(struct wasmContext, f)); \
+    } while (0)
+
+static void tcg_wasm_out_exit_tb(TCGContext *s, uintptr_t arg)
+{
+    tcg_wasm_out_ctx_i32_store_const(s, tb_ptr, 0);
+    tcg_wasm_out_op_i32_const(s, (int32_t)arg);
+    tcg_wasm_out_op_return(s);
+}
+
+static void tcg_wasm_out_goto_ptr(TCGContext *s, TCGReg arg)
+{
+    tcg_wasm_out_op_global_get_r(s, arg);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_ctx_i32_load(s, tb_ptr);
+    tcg_wasm_out_op_i32_eq(s);
+    tcg_wasm_out_op_if_noret(s);
+    tcg_wasm_out_op_i64_const(s, 0);
+    tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+    tcg_wasm_out_op_br(s, 2); /* br to the top of loop */
+    tcg_wasm_out_op_end(s);
+
+    tcg_wasm_out_ctx_i32_store_r(s, tb_ptr, arg);
+    tcg_wasm_out_op_i32_const(s, 0);
+    tcg_wasm_out_op_return(s);
+}
+
+static void tcg_wasm_out_goto_tb(
+    TCGContext *s, int which, uint32_t cur_reset_ptr)
+{
+    tcg_wasm_out_op_i32_const(s, (int32_t)get_jmp_target_addr(s, which));
+    tcg_wasm_out_op_i32_load(s, 0, 0);
+    tcg_wasm_out_op_local_set(s, TMP32_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_const(s, cur_reset_ptr);
+    tcg_wasm_out_op_i32_ne(s);
+    tcg_wasm_out_op_if_noret(s);
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_ctx_i32_load(s, tb_ptr);
+    tcg_wasm_out_op_i32_eq(s);
+    tcg_wasm_out_op_if_noret(s);
+    tcg_wasm_out_op_i64_const(s, 0);
+    tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+    tcg_wasm_out_op_br(s, 3); /* br to the top of loop */
+    tcg_wasm_out_op_end(s);
+
+    tcg_wasm_out_ctx_i32_store_local32(s, tb_ptr, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_const(s, 0);
+    tcg_wasm_out_op_return(s);
+    tcg_wasm_out_op_end(s);
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -1931,6 +2039,7 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *func,
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
 {
     tcg_out_op_p(s, INDEX_op_exit_tb, (void *)arg);
+    tcg_wasm_out_exit_tb(s, arg);
 }
 
 static void tcg_out_goto_tb(TCGContext *s, int which)
@@ -1938,11 +2047,13 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     /* indirect jump method. */
     tcg_out_op_p(s, INDEX_op_goto_tb, (void *)get_jmp_target_addr(s, which));
     set_jmp_reset_offset(s, which);
+    tcg_wasm_out_goto_tb(s, which, (uint32_t)s->code_ptr);
 }
 
 static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
 {
     tcg_out_op_r(s, INDEX_op_goto_ptr, a0);
+    tcg_wasm_out_goto_ptr(s, a0);
 }
 
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
-- 
2.43.0


