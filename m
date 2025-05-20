Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7158CC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMSb-0000kK-AU; Tue, 20 May 2025 08:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSa-0000k4-A2; Tue, 20 May 2025 08:52:44 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSX-0000iZ-RA; Tue, 20 May 2025 08:52:44 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-30e80f03760so3988330a91.0; 
 Tue, 20 May 2025 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745559; x=1748350359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0PaUQzzHF5lFv29qjDHJ20TRr//FMkUoGozxMxxEDU=;
 b=FS3V0Pvzr2N10i15ejl4MWc5HhSaoGPjbjgxb+gnshBGDqxaR5/mT+w1dzsEfHQyzl
 ssPrxvM44s5qcgTF0+H+VBKrsVOpH1MIpUvTZty7t8Dhte8MnKGFakBgtygxedzNK8NQ
 Qbk0bgzDj8cEoD1/EruOMuViML2FsONiwW8mZ8oG7qP+UxufcdOH+R4C1TR4CWqp2Iv4
 hIk7QftCfBvBOx/M+FahQZNHFia5Zca08k5asF0aAKCkCDaj9FhYT49WWXPF/UmH4bAQ
 xi3XNZFJxWY+e1hR9pH7wtXAhOVmhO8uRnrDXOHrUZD8ZQ+If8gdohYFykSWbFY3DlXD
 bCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745559; x=1748350359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0PaUQzzHF5lFv29qjDHJ20TRr//FMkUoGozxMxxEDU=;
 b=EHAafzbqmC0nfRJD7UXVSw2b6isGgmfSlPlOpt0D5Qg41TgJ6/n8hzSyXQiFJCPVLj
 B9PJSUzu/7loASUw+u/SARxRkCMVFd87W/v5l72DqZlpKF7TUtXL/aKZQ3eraSt5Of0i
 GCy31OALFDzYqAbfm2UJfR8aKRXkhPN7BtnjNdGVq2kOlL/YT71EWeBUd9tx3i2K2+7t
 Q3jnip2xtkwFqgYhEestDIFdmwGPD+MiF8XXLWx4hDp3JuDIT/vDjNMgjnCT3mlr1Cf/
 6I+QzPnIP3vboquP9QdsXyhyJqmufn/YpwG3dzzUQ7Ky3ZQzwKeBlmUoXoqeiQTkVrtP
 nryg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5bjgQMXlDh5qnFCjFznM+WwlUjRx6v8M+sdy8fHaIpa63qTAYirRLkoPPC1ehgQJ9cZUPg4oprZ200A==@nongnu.org,
 AJvYcCVHb+O5FG25BH3j2/0N/b/Xl1gnuaHPuNXZ7UVEaKpDyWPfcBPaV7CdIWsGdrnc6CGsNhnxMTGnrQ==@nongnu.org
X-Gm-Message-State: AOJu0Yzf9gv8G8FaQWQiNpuNcHSm5TF/J/FG5bzONl55XpEgQdZocFq0
 sEiX9IJEOV3zz68rQBtqNKyqQgf+T4as07mGORjFwxSTDlyBCoGT6+NLmrAU9/+b
X-Gm-Gg: ASbGncuKr1e7rZbY7HY5xB5H323UVHn7f85UdkqAJcIgrrWjXY9WZoK3YvxPLC/dp0E
 /0jQdV7uHxytJlO0QDD66JQHfEWefo1QlzcBuVxjRLmicsaMBs+Vm8IME1eE3oe3xglpluUJg6I
 F4YjrmvlG2dbc1rlvQcrDSHvEU4r9qsUQIQcGIFgIT3qLG2CoMxYETYsLQWpSQCYKITETfrCEWV
 ybuDns4gHWiPRr11+W661/znJ3Y7CX67X8Oh76Fc45uhBy9KqFCebpktgbiTJ+McdUQ5EknVoom
 nq/zWLPsY0lE8osv2/Pi1Sj3ijIcZ4YslyZmQXuf1IRTBz32z+w=
X-Google-Smtp-Source: AGHT+IG4z7uH3nJBTNDQfyLfNQV18rt8GBswaQum9LIXlORmpxAC/0+aqvV7Ejz1IYPaI3IHgNwiMg==
X-Received: by 2002:a17:90b:3a48:b0:2ff:72f8:3708 with SMTP id
 98e67ed59e1d1-30e8314fdb5mr30880280a91.17.1747745558661; 
 Tue, 20 May 2025 05:52:38 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:52:38 -0700 (PDT)
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
Subject: [PATCH 04/33] tcg/wasm32: Set TCG_TARGET_INSN_UNIT_SIZE to 1
Date: Tue, 20 May 2025 21:51:06 +0900
Message-ID: <9e2af431443c9b4b70f1fc1ee02e1030318c0b8f.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1035.google.com
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

WebAssembly instructions vary in size, including single-byte
instructions. This commit sets TCG_TARGET_INSN_UNIT_SIZE to 1 and updates
the TCI fork to use "tcg_insn_unit_tci" (a uint32_t) for 4-byte operations.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 40 ++++++++++++++++++++-----------------
 tcg/wasm32/tcg-target.h     |  2 +-
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index 33b81f1fe2..126f9c0de7 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -39,6 +39,8 @@
 #endif
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
+typedef uint32_t tcg_insn_unit_tci;
+
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
@@ -96,16 +98,18 @@ static const char *const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 };
 #endif
 
-static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
+static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
+    tcg_insn_unit_tci *code_ptr = (tcg_insn_unit_tci *)code_ptr_i;
     intptr_t diff = value - (intptr_t)(code_ptr + 1);
 
     tcg_debug_assert(addend == 0);
     tcg_debug_assert(type == 20);
 
     if (diff == sextract32(diff, 0, type)) {
-        tcg_patch32(code_ptr, deposit32(*code_ptr, 32 - type, type, diff));
+        tcg_patch32((tcg_insn_unit *)code_ptr,
+                    deposit32(*code_ptr, 32 - type, type, diff));
         return true;
     }
     return false;
@@ -122,7 +126,7 @@ static void stack_bounds_check(TCGReg base, intptr_t offset)
 
 static void tcg_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_out_reloc(s, s->code_ptr, 20, l0, 0);
     insn = deposit32(insn, 0, 8, op);
@@ -131,14 +135,14 @@ static void tcg_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
 
 static void tcg_out_op_p(TCGContext *s, TCGOpcode op, void *p0)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
     intptr_t diff;
 
     /* Special case for exit_tb: map null -> 0. */
     if (p0 == NULL) {
         diff = 0;
     } else {
-        diff = p0 - (void *)(s->code_ptr + 1);
+        diff = p0 - (void *)(s->code_ptr + 4);
         tcg_debug_assert(diff != 0);
         if (diff != sextract32(diff, 0, 20)) {
             tcg_raise_tb_overflow(s);
@@ -151,7 +155,7 @@ static void tcg_out_op_p(TCGContext *s, TCGOpcode op, void *p0)
 
 static void tcg_out_op_r(TCGContext *s, TCGOpcode op, TCGReg r0)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     insn = deposit32(insn, 0, 8, op);
     insn = deposit32(insn, 8, 4, r0);
@@ -165,7 +169,7 @@ static void tcg_out_op_v(TCGContext *s, TCGOpcode op)
 
 static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_debug_assert(i1 == sextract32(i1, 0, 20));
     insn = deposit32(insn, 0, 8, op);
@@ -176,7 +180,7 @@ static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 
 static void tcg_out_op_rl(TCGContext *s, TCGOpcode op, TCGReg r0, TCGLabel *l1)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_out_reloc(s, s->code_ptr, 20, l1, 0);
     insn = deposit32(insn, 0, 8, op);
@@ -186,7 +190,7 @@ static void tcg_out_op_rl(TCGContext *s, TCGOpcode op, TCGReg r0, TCGLabel *l1)
 
 static void tcg_out_op_rr(TCGContext *s, TCGOpcode op, TCGReg r0, TCGReg r1)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     insn = deposit32(insn, 0, 8, op);
     insn = deposit32(insn, 8, 4, r0);
@@ -197,7 +201,7 @@ static void tcg_out_op_rr(TCGContext *s, TCGOpcode op, TCGReg r0, TCGReg r1)
 static void tcg_out_op_rrm(TCGContext *s, TCGOpcode op,
                            TCGReg r0, TCGReg r1, TCGArg m2)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_debug_assert(m2 == extract32(m2, 0, 16));
     insn = deposit32(insn, 0, 8, op);
@@ -210,7 +214,7 @@ static void tcg_out_op_rrm(TCGContext *s, TCGOpcode op,
 static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
                            TCGReg r0, TCGReg r1, TCGReg r2)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     insn = deposit32(insn, 0, 8, op);
     insn = deposit32(insn, 8, 4, r0);
@@ -222,7 +226,7 @@ static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
 static void tcg_out_op_rrs(TCGContext *s, TCGOpcode op,
                            TCGReg r0, TCGReg r1, intptr_t i2)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_debug_assert(i2 == sextract32(i2, 0, 16));
     insn = deposit32(insn, 0, 8, op);
@@ -235,7 +239,7 @@ static void tcg_out_op_rrs(TCGContext *s, TCGOpcode op,
 static void tcg_out_op_rrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
                             TCGReg r1, uint8_t b2, uint8_t b3)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_debug_assert(b2 == extract32(b2, 0, 6));
     tcg_debug_assert(b3 == extract32(b3, 0, 6));
@@ -250,7 +254,7 @@ static void tcg_out_op_rrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
 static void tcg_out_op_rrrc(TCGContext *s, TCGOpcode op,
                             TCGReg r0, TCGReg r1, TCGReg r2, TCGCond c3)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     insn = deposit32(insn, 0, 8, op);
     insn = deposit32(insn, 8, 4, r0);
@@ -263,7 +267,7 @@ static void tcg_out_op_rrrc(TCGContext *s, TCGOpcode op,
 static void tcg_out_op_rrrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
                              TCGReg r1, TCGReg r2, uint8_t b3, uint8_t b4)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_debug_assert(b3 == extract32(b3, 0, 6));
     tcg_debug_assert(b4 == extract32(b4, 0, 6));
@@ -279,7 +283,7 @@ static void tcg_out_op_rrrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
 static void tcg_out_op_rrrr(TCGContext *s, TCGOpcode op,
                             TCGReg r0, TCGReg r1, TCGReg r2, TCGReg r3)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     insn = deposit32(insn, 0, 8, op);
     insn = deposit32(insn, 8, 4, r0);
@@ -293,7 +297,7 @@ static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
                               TCGReg r0, TCGReg r1, TCGReg r2,
                               TCGReg r3, TCGReg r4, TCGCond c5)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     insn = deposit32(insn, 0, 8, op);
     insn = deposit32(insn, 8, 4, r0);
@@ -452,7 +456,7 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *func,
                          const TCGHelperInfo *info)
 {
     ffi_cif *cif = info->cif;
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
     uint8_t which;
 
     if (cif->rtype == &ffi_type_void) {
diff --git a/tcg/wasm32/tcg-target.h b/tcg/wasm32/tcg-target.h
index bd03aa1bc4..2f0c27c905 100644
--- a/tcg/wasm32/tcg-target.h
+++ b/tcg/wasm32/tcg-target.h
@@ -41,7 +41,7 @@
 #define TCG_TARGET_H
 
 #define TCG_TARGET_INTERPRETER 1
-#define TCG_TARGET_INSN_UNIT_SIZE 4
+#define TCG_TARGET_INSN_UNIT_SIZE 1
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
 /* Number of registers available. */
-- 
2.43.0


