Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2667CA0FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwIk-0005Rw-Mc; Tue, 26 Aug 2025 12:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIG-0004li-VA; Tue, 26 Aug 2025 12:13:11 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIB-00083t-Ei; Tue, 26 Aug 2025 12:13:07 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-771e987b4e6so1839156b3a.2; 
 Tue, 26 Aug 2025 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224775; x=1756829575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4g7xgFswCOOOQVtfkqWYJr9zaiKOTEbQZwPy6qzhivk=;
 b=O1zJ3spta1J2kDHImdggvLNdKLXB5BIczWoq7MQn5mNpONpQwcex1GXr2i72DM52Lb
 cMpagXTX0GO+AEDLP9zUVcXb4N6enCSD5mVJ802FZqlVsPqPIPGCWrnxVF0vvaICb1aQ
 MOMpKVnFQC49FyZT8tR5h6gzOqihRxIe6MQkHYuYFnu7W4MF2LV5Yle9+F0HzQRieG6i
 PRFbkARDSDZ4ykR71pNPsjlFk+HM55a1zeUQtUVJ0BghEOetK4No50VbtLiIdmp4v/HS
 at4gu+QBENKTE/masLLVrwrYcUkUPP7hgglgAiOdhl8Gl+0hX+oS/VGOBUR/bWiDjGq8
 g9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224775; x=1756829575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4g7xgFswCOOOQVtfkqWYJr9zaiKOTEbQZwPy6qzhivk=;
 b=nV4anVSr7fAPh4JPHRISDZN9uPtAMfsDj5WBbkCKacPFlLdsOFgoVcVCBsiwfQjeB3
 uImmbJHQv2AO65cXc1c+VsgfhZHjk0zZ3xStb7Zh5WEhtD0A8zw6sNn88KEx/YtR27G5
 JgZnYfBdxE8fQIkyrNxKMfO5UT4B+gy56ihVZNTepsV27Bq40EoKAvqr+PUmwRRYsPqe
 vDm5QjI/8atPWIRWmvV++QJT6c3XXreqN79SY3Wuy8dBmlkYt1Z5jSZeaZhY859KEHSe
 +BU19kQ482G3XrdN8s9a9fyDnWItnprlVYxJ6AKNFyLtd7pw9yNIneQcX+gbYIy4lEgf
 rdvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd4oBjhxnIxNJjLIIBDg5ev+FKC2asqejewW9U6OHiaiFmcahciX1LKGYmDWDNUieF8J1brNYrtTjr/A==@nongnu.org,
 AJvYcCX5ZXcfWX/bQssGBbZTccw78VxtaB+xtCXrC2f44AF0Z7l0/TjS7K2CDhAjEmErzncNm7dqMKdAAw==@nongnu.org
X-Gm-Message-State: AOJu0Yw4ilYgAagh6ex6SCVTlqy/DtV5VTOO9Vk1OB8VJhrqFrJQ3Qq4
 KBs64WtNrZrwaKDiD1BXSrowu6fuk2ZUxDu3ff1TCU9IdjX+hrTtM4nkT47TTw==
X-Gm-Gg: ASbGncsPZjTCe1Y90bKXtx6Rqp9e9DnVB/aIQ5t3PUyCtrFPa3eJ1hTebO0npuBdaxL
 R66d1XW+TMCQ8H0XcoLQc+lrAa9Hw4+mL+P3GL6Gt8WCqrekTBxNxxERChHP/ufFbDja2E6KNnf
 +sk/qe6qGbhXj/hGTNmJMAZoxttZEMqxFQ2x65jPAaKkA4wNYVyMeAhUFdeBB8k8Ptwj8iLYwv2
 n1NyrwE98G/cyMPzFFyizy9wHOncFh4X4F0IPhjzZ01vqPZqJKLRhFrMK2dKyjUNZjABEFGOMDj
 haxi9fMDXMxOoZ2F1mKJ9FSUxGu3ArCLnVrnlt2lS3ux3zxrJy4M9vtEojc8dkg03ZPINtDhsCP
 JRq2ZxRAWIzs7l//sfu5dXA==
X-Google-Smtp-Source: AGHT+IEindR+GI1jxL/plyLy2KCLf0ZcXAh4yHBLPy+7HYlHuVybk9UEHOf9TciF+Z1Ixrs/az4FRg==
X-Received: by 2002:a05:6a20:939f:b0:243:78a:8276 with SMTP id
 adf61e73a8af0-24340e1cafamr21853352637.60.1756224774765; 
 Tue, 26 Aug 2025 09:12:54 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:12:53 -0700 (PDT)
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
Subject: [PATCH v2 18/35] tcg/wasm: Add neg/ctpop instructions
Date: Wed, 27 Aug 2025 01:10:23 +0900
Message-ID: <2cb39a5cb4df42d6a7b3bdc3d6449fb9a60e861f.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x435.google.com
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

The neg/ctpop operations are implemented using the corresponding
instructions in Wasm. TCI instructions are also generated in the same way as
the original TCI backend.

The Wasm backend implements only TCG_TARGET_REG_BITS=64 so the ctpop
instruction is generated only for 64bit operations, as declared in
cset_ctpop. Therefore, this commit adds only the 64bit version of ctpop
implementation.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                |  4 ++++
 tcg/wasm/tcg-target.c.inc | 44 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

V2:
- This commit generates both Wasm and TCI instrucitons.
- Removed the not operation to rely on default expansion.
- Fixed the neg implementation to "ret = 0 - arg"

diff --git a/tcg/wasm.c b/tcg/wasm.c
index 8c8dcb81c7..a5e72d8fe5 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -359,6 +359,10 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint32_t)regs[r1] % (uint32_t)regs[r2];
             break;
+        case INDEX_op_ctpop:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = ctpop64(regs[r1]);
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 38459a60d6..27f3a7414b 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -188,6 +188,7 @@ typedef enum {
     OPC_I32_SHR_S = 0x75,
     OPC_I32_SHR_U = 0x76,
 
+    OPC_I64_POPCNT = 0x7b,
     OPC_I64_ADD = 0x7c,
     OPC_I64_SUB = 0x7d,
     OPC_I64_MUL = 0x7e,
@@ -547,6 +548,21 @@ static void tcg_wasm_out_movi(TCGContext *s, TCGType type,
    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
 }
 
+static void tcg_wasm_out_neg(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
+    tcg_wasm_out_op(s, OPC_I64_SUB);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_ctpop64(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
+    tcg_wasm_out_op(s, OPC_I64_POPCNT);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
 static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -1138,6 +1154,34 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, INDEX_op_neg, a0, a1);
+    tcg_wasm_out_neg(s, a0, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
+static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, INDEX_op_ctpop, a0, a1);
+    tcg_wasm_out_ctpop64(s, a0, a1);
+}
+
+static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctpop,
+    .out_rr = tgen_ctpop,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


