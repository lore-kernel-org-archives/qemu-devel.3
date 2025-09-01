Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BDDCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut319-0002OT-9k; Mon, 01 Sep 2025 07:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut307-0000Od-Vi; Mon, 01 Sep 2025 07:47:08 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zx-0001Vb-Ci; Mon, 01 Sep 2025 07:47:07 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-24af8cd99ddso1535445ad.0; 
 Mon, 01 Sep 2025 04:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727208; x=1757332008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrwqoR/k34XBU1Ib0AzddvB7H1d7/7mf6zJWPIJvyec=;
 b=AvHfx5/OBRxvczin6dGG1tGa2Hr7Gxk7gXIBunO64uCAaM3pNNwVb5NSECHr3+8/vM
 RS1lIftGsU5dggc1a5ffKp5/GH9lCGavZYoxzxN1herkkUYwOJzBgnGZzTqXziSoclKc
 p3AK8lyQaCGmrHCscFc1Q9wEH24td/VshzQC9O9PK7Gxxa8F5mjv2FhtNL5Rpn7puQe0
 7VKmfS4eNrW9a53Qk/rHCsYZ52Hhz3FHW7t/T9uBs6M0fCS2Wl+2JRTJl+O+WVwzo8+f
 kQyOJCDuTs4GRqlur6Mgoozq4/AJ3EP3buV0GhpgkiWzz4w8vTxVR4NwS3Vq9bOX5FcY
 o3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727208; x=1757332008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PrwqoR/k34XBU1Ib0AzddvB7H1d7/7mf6zJWPIJvyec=;
 b=wcZajMkG/uGd3ybjnxtW791EbyZSlZy0CIJFBwJvpAzqlpRDq6F+mqmybO0uDDq+ZJ
 JIeLVTNFIbdaK1pL4bqSS7n20esmGzWY3Vwb1QZK5bfTEgU48JYzZE7eqkABk6ly5Elf
 uwDUt+HiuCEoujr2rMhMZ6r+P21KqlkW3QdJhJ03shLIj283SPnKVG3qh0Tbmno4znvP
 AlOjwhe+QjmVwXp90gOk/rMaAhIPKvY3/P7xKeCbmbfIJkFEDY6c2wistmR3SmbZvqrw
 zs0cmu2CzG6mUgAzr0f4DgkORvGXKHJj2EcmQu8qNf5oDvBIqrwzbm8Gyfl71wG5Dp75
 LlCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLj9R6V4AqV0DjuZwtCN/YPz+LcP3N6CYeJGm7KZtHD7Cv+V10AFauhvfqiIZRj23A2BwD/1jdj8aXjw==@nongnu.org,
 AJvYcCWN+BWt2WIe50I1bnw26EllQnOwOsMyxwlUsp28sMzGdpVqVd4Hc3NyvxGy6UIX2HdhxbozxMsUtg==@nongnu.org
X-Gm-Message-State: AOJu0Yz4BBQNU/0cdr/njLCseXO8U24S8MzmBkrhxH0OZ5pt6gu8Ll24
 pA+FQ0xOILIa1GHhdw9GKXoopCdAAz0mrC1htjAJ8RkoypMcyXzpqfToCQ4jmQ==
X-Gm-Gg: ASbGnct/iYu/BS7wph4G+70XnSZ5HbT0osbViAGFZCk+qEcopOq4EFsx3rk4z1w5C6T
 KpLmHwXyLpCSIRUtu98k8RkTu6CgD9CAcRNOE6TRtMwRdSWisA221gt9l8AXq+HqwrYOc/sxGKe
 uVP/8touF3il7D9v5PMq/g5kBH4eWm0l7s8pa+VXv15xB9BrNMFIR53DlyT5B1NqblWfJ8Dw4Cu
 3aki2rVbYfAXynoTfUOJ273zVwkk2AYJOr0wXqwi8Iv6Us4nh23eTzFnb4tiCe5TrqNFvPyAxI0
 bR9Kjrt/9AFLZ3+TzwR2HywtSpuZl3A7KfDWW6NTuaTErbPsSniiKB1rz1JGZNGCjoQfMf4Oq6c
 fj5EoQxLDGwj5B+U9O2wg6N5iP9l2J58w
X-Google-Smtp-Source: AGHT+IG7ljqu8UZn0dVIRGtdxeAUbvM2dPs27AAcqRKEiISkiA3ub34IXSaKWOhChg3Kng4jBYfHFA==
X-Received: by 2002:a17:903:f8d:b0:246:255a:1913 with SMTP id
 d9443c01a7336-24944b29d4fmr102537615ad.39.1756727208252; 
 Mon, 01 Sep 2025 04:46:48 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:46:47 -0700 (PDT)
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
Subject: [PATCH v3 15/35] tcg/wasm: Add mov/movi instructions
Date: Mon,  1 Sep 2025 20:44:17 +0900
Message-ID: <13eb7d5403cdad50342504eb76aef9bc0f8e0996.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
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

Theese operations are implemented using the corresponding instructions in
Wasm. TCI instructions are also generated in the same way as the original
TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                |  4 ++++
 tcg/wasm/tcg-target.c.inc | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tcg/wasm.c b/tcg/wasm.c
index fa7413fc1d..2c8a7b814e 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -260,6 +260,10 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             tmp32 = tci_compare32(regs[r1], regs[r2], condition);
             regs[r0] = regs[tmp32 ? r3 : r4];
             break;
+        case INDEX_op_mov:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = regs[r1];
+            break;
         case INDEX_op_tci_movi:
             tci_args_ri(insn, &r0, &t1);
             regs[r0] = t1;
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 6bab20a6a9..def1f5cd5e 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -501,6 +501,28 @@ static void tcg_wasm_out_st(
     tcg_wasm_out_op_ldst(s, opc, 0, offset);
 }
 
+static void tcg_wasm_out_mov(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_movi(TCGContext *s, TCGType type,
+                              TCGReg ret, tcg_target_long arg)
+{
+   switch (type) {
+   case TCG_TYPE_I32:
+       tcg_wasm_out_op_const(s, OPC_I64_CONST, (int32_t)arg);
+       break;
+   case TCG_TYPE_I64:
+       tcg_wasm_out_op_const(s, OPC_I64_CONST, arg);
+       break;
+   default:
+       g_assert_not_reached();
+   }
+   tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
 static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -798,6 +820,20 @@ static void tcg_tci_out_movi(TCGContext *s, TCGType type,
     }
 }
 
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+{
+    tcg_out_op_rr(s, INDEX_op_mov, ret, arg);
+    tcg_wasm_out_mov(s, ret, arg);
+    return true;
+}
+
+static void tcg_out_movi(TCGContext *s, TCGType type,
+                         TCGReg ret, tcg_target_long arg)
+{
+    tcg_tci_out_movi(s, type, ret, arg);
+    tcg_wasm_out_movi(s, type, ret, arg);
+}
+
 static void stack_bounds_check(TCGReg base, intptr_t offset)
 {
     if (base == TCG_REG_CALL_STACK) {
-- 
2.43.0


