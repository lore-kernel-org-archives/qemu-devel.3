Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BA6CA0FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwII-0004is-Ht; Tue, 26 Aug 2025 12:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwI5-0004Xt-QR; Tue, 26 Aug 2025 12:12:59 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwI0-00083D-Qy; Tue, 26 Aug 2025 12:12:55 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-324fb2bb099so4356770a91.3; 
 Tue, 26 Aug 2025 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224769; x=1756829569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YqSCW844/j/YS05m4IaJ3nc3QpjXnSjCef6LN7eSUo=;
 b=CBD9kLW+lAQIBr42d18S3QqB4jqIOmJ2gz5vv7NKzotiobA3PtJSyzJNNJ6f1wiC5T
 wzXys/GZvFGm339Uf/ext2jdJDGjrFY9lYoblERkljrW9/CQEG+vHUS63jgEKIK9373C
 kFLidO7QmFgsHmE4fNFSxkfe9e2OQORk2qd8tLkzLlHTxuggnA2s+Zvolt879X16efmu
 DzM9zQtillYKyJxHrq00/LZdRJN8ClJqfQ/rOdnPfcXTU/HsBOrn2rK54SiFZgWGpouW
 AIIYNkS99w3PSGfuk7gxyEkUtB5TYWbniveakY/z6AmEcMLJIqlC7NripwobGZmzbgvb
 UHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224769; x=1756829569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/YqSCW844/j/YS05m4IaJ3nc3QpjXnSjCef6LN7eSUo=;
 b=raCf5jksmZnZ6FUESe13nvCRSD+GNKhTC1+8aiRI55M40UNNnDWbG+x6jr8C52A8u6
 WoHaPk+tr3lm541SVLE3oHTR8Vl1ilrzYWLWnUyM5zEepHeZEABWtUFtU3LRseqk0Stv
 83aDWc3fhif+Jdik8zgnk15zNUBvj584aMMc4xALcSra8pyMc3ZyYYGixfLiTxfPsCi6
 sii5ol7YLA9vWTrXvlgttST4EQWEKeDtT50J5nFRlkohAMctZImr+okQBayL4HQFBjqh
 N1DBYNIz5RUw5+rupfqwOl2iKkj0bsnvn3KjQ6h4f/SdPTMgmOQ5O0jA0BZ2CJsXdf4x
 EJ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU084PwxnCDadyp0P4cmErBWFyu+71zFRkLDrEdjWHg82VjJ1T23R8WlgchvGUeYWAkjzWCOkMjlSWHQw==@nongnu.org,
 AJvYcCUX3ZonRPe+zO3cqmrHjTPBpJwEVu6cSJvfVbgRuHhSYQFeQv7ZJTRZaSf6EqSt3ABOqs8SKAcTmw==@nongnu.org
X-Gm-Message-State: AOJu0Yz7HjrWDakFNdjY2x4tAMf4TBnC+Ez+7Q894temx5ruUv8wBLYH
 Rij5GqhjjGJa+vAPHqB60o3WQ7aORIWZaEubk45qliquc9kJptB7/7pSBn7Psw==
X-Gm-Gg: ASbGncuNQ2Y3YGfxS+4Bfw/+CBlnhTlo6S5zyQX78MC+9KGcILwp505HRjDPml9XKcE
 sYUbPtVuFw+hEv7sx81LPieVm1AMtFeC5wQ03LoeOjD3O1kgiX1FwQI1hoJjfhnwq05QnMK0LEL
 S/GQRee4oTt9qvIMSvepppIwOTeT5jQyJ/Kz8J2PyQCMQGSqGdLgy81QlCNOSMmXGo94BSTZNIi
 Dxw2IHJBw5Ey9tj6ro/Q/DNQkSkcmN2Jn+b3SqmiT058A8LI1GzT0adn+na+/ls8NCPu6ZpEVPN
 KYONbui9vcCNFKIvcRAtR3Vg7M3Yj4eAwOiHdred7/a2Y2e0LwIr0Ebe6kj8YJ2724zNjjxQENI
 77dvVNn13QJsmgSZ3jT0QCZj5h7I6y5JN
X-Google-Smtp-Source: AGHT+IF5Z2qnYKxxH0S/+OVlJyxliYNWDQv9vpXaRzBHyOaGjRCn9eQjMv89tbMwH1GSWzPk3RYD+A==
X-Received: by 2002:a17:90b:1d06:b0:312:39c1:c9cf with SMTP id
 98e67ed59e1d1-32515eadfc1mr22211613a91.7.1756224768572; 
 Tue, 26 Aug 2025 09:12:48 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:12:47 -0700 (PDT)
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
Subject: [PATCH v2 17/35] tcg/wasm: Add div/rem instructions
Date: Wed, 27 Aug 2025 01:10:22 +0900
Message-ID: <32eaa622a5acc240179be619c09319bbb48f3f14.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
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

The div and rem operations are implemented using the corresponding
instructions in Wasm. TCI instructions are also generated in the same way as
the original TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                    | 32 +++++++++++++++++
 tcg/wasm/tcg-target-opc.h.inc |  4 +++
 tcg/wasm/tcg-target.c.inc     | 68 +++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

V2:
- This commit generates both Wasm and TCI instrucitons.

diff --git a/tcg/wasm.c b/tcg/wasm.c
index 2c8a7b814e..8c8dcb81c7 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -327,6 +327,38 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             ptr = (void *)(regs[r1] + ofs);
             *(uint32_t *)ptr = regs[r0];
             break;
+        case INDEX_op_divs:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int64_t)regs[r1] / (int64_t)regs[r2];
+            break;
+        case INDEX_op_divu:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint64_t)regs[r1] / (uint64_t)regs[r2];
+            break;
+        case INDEX_op_rems:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int64_t)regs[r1] % (int64_t)regs[r2];
+            break;
+        case INDEX_op_remu:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint64_t)regs[r1] % (uint64_t)regs[r2];
+            break;
+        case INDEX_op_tci_divs32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int32_t)regs[r1] / (int32_t)regs[r2];
+            break;
+        case INDEX_op_tci_divu32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint32_t)regs[r1] / (uint32_t)regs[r2];
+            break;
+        case INDEX_op_tci_rems32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int32_t)regs[r1] % (int32_t)regs[r2];
+            break;
+        case INDEX_op_tci_remu32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint32_t)regs[r1] % (uint32_t)regs[r2];
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm/tcg-target-opc.h.inc b/tcg/wasm/tcg-target-opc.h.inc
index 122b45749a..5ed8c67535 100644
--- a/tcg/wasm/tcg-target-opc.h.inc
+++ b/tcg/wasm/tcg-target-opc.h.inc
@@ -8,3 +8,7 @@ DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_setcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_divu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_rems32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_remu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index e41b3a0c27..38459a60d6 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -181,12 +181,20 @@ typedef enum {
     OPC_I64_GE_U = 0x5a,
 
     OPC_I32_ADD = 0x6a,
+    OPC_I32_DIV_S = 0x6d,
+    OPC_I32_DIV_U = 0x6e,
+    OPC_I32_REM_S = 0x6f,
+    OPC_I32_REM_U = 0x70,
     OPC_I32_SHR_S = 0x75,
     OPC_I32_SHR_U = 0x76,
 
     OPC_I64_ADD = 0x7c,
     OPC_I64_SUB = 0x7d,
     OPC_I64_MUL = 0x7e,
+    OPC_I64_DIV_S = 0x7f,
+    OPC_I64_DIV_U = 0x80,
+    OPC_I64_REM_S = 0x81,
+    OPC_I64_REM_U = 0x82,
     OPC_I64_AND = 0x83,
     OPC_I64_OR = 0x84,
     OPC_I64_XOR = 0x85,
@@ -1070,6 +1078,66 @@ static const TCGOutOpUnary outop_extrh_i64_i32 = {
     .out_rr = tgen_extrh_i64_i32,
 };
 
+static void tgen_divs(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_divs32
+                     : INDEX_op_divs);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_DIV_S, OPC_I64_DIV_S, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_divs = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_divs,
+};
+
+static void tgen_divu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_divu32
+                     : INDEX_op_divu);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_DIV_U, OPC_I64_DIV_U, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_divu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_divu,
+};
+
+static void tgen_rems(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_rems32
+                     : INDEX_op_rems);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_REM_S, OPC_I64_REM_S, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_rems = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rems,
+};
+
+static void tgen_remu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_remu32
+                     : INDEX_op_remu);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_REM_U, OPC_I64_REM_U, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_remu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_remu,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


