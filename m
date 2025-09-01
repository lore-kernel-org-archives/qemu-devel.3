Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0528ECA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2zz-000058-M1; Mon, 01 Sep 2025 07:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zY-0007aM-MH; Mon, 01 Sep 2025 07:46:36 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zP-0001OS-9d; Mon, 01 Sep 2025 07:46:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2445805aa2eso43006445ad.1; 
 Mon, 01 Sep 2025 04:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727179; x=1757331979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZn9qlLs9yOI27f7R6L8FcBRbqHv/U8xQ6luXz9uzYQ=;
 b=BJcrpIVaRARs3trpZlTya3iMpeyJJ4Us7XNQK38j6pWFX00NZsXOaPVKj1UO1g47Pl
 NqAX48BqCL9unTuVz9dT+5VUNn/EYG1tLwiU/6q6mWl47i3ld1MbvljV0SHbSKx31+yK
 YWBYiNvR6llq+9UpetL29Syti4LT1k5II2H8xXluxvLoLG6RevX11t9LAQD1Qdsp1nyH
 a0yk7s3g7zTos2xjJ4PoP5u4rhutGkzXzjLN/n4zJmc6Q79gyjahyVmyi3/eIrGMoDYE
 lp/4ZQQOG5NugS/jOtevrD+5eEO5papFXHibxNUI6dPDYtfWDKr8Ty94OGzZMD5bxejN
 GbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727179; x=1757331979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZn9qlLs9yOI27f7R6L8FcBRbqHv/U8xQ6luXz9uzYQ=;
 b=l5x4B/JIi3pstCgdxfYXbEBm9bWPhFV98aB2P3RYhjGzXgL3rDVruU+QLJMak0Vck2
 ya6EHD/wGPnx30RFG++QIW7WluU9cRtvOp5K97GstFoLTBzaFrxYcvAuzNuaoM8YatyA
 XOPl/LF/vOTqCyf4h+EMYcF+JCwC6u3+92kv6YEWC1nl36VcO4s+C+SuXAkDHRdRFeHh
 9lhOLFDMKkrGzAVBAbmQtEXJvag/4RZxwNtkAtQTtMBNCa9TB+328rSqmP5HJlSSXsZ3
 aeww8LFu3diSIsKGcGFdurMdIyZtSsTYPTgAlEUrQo7mAb5q6u9S/b7marNcjcbayspw
 kf5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcUSs1l9XOajnf7UlxvQofhA5yYqfQJrBffKspWoLl0RTKPD+pD+SnEJtc/6zbUU1o2aVIbNATa18unA==@nongnu.org,
 AJvYcCWVejPjpaIFM2Z7A6VOniwQoTDmVjgPXIepR6cnZbH4ZDxOm8g18GTPBGWJ0+2ArZ6jbrRsOzC9eg==@nongnu.org
X-Gm-Message-State: AOJu0YzicfkWRZNzW3GF5AqWuTxU1mPRvFk/gjRblsEpTo1byl7SJmyk
 8uBQZaZ868CcViF3XuJMlpCqJ07pNHLORtgnP9uWsncBDXjKAHTMnOCXCfogYw==
X-Gm-Gg: ASbGncvdYI15TjrokwVQoCxekZ5o978c2SPgwksffnsmGKmbgZfkyTqL6XHvBhQwEze
 /JEFHcEeo4LJEzXJ3jmlmSO8cqkfmZl1nWHoDWD8gzEMEaVZW80aGV/DFVSxRQTBVKqO1UcGZbG
 rk6agKKuAfoTIdItUyHgzNhimuf+aRa3XXxNaMOdWMmDKx/6zt4CTZjqY8f4U+aJ83bjaSbI0ns
 LhL+AqZUTK6Fw/gWw3CpO9e73522/bsBYWaPVWRMrCMXBcWs/oJCYAZUTrwrWceppJXEu9tyKG/
 iSQdTiRCSaLYYRn8mT1oiEuqK0W6UQMk7Onrz3Zz1mBnjoLJDS/KALme5v5KLtI5tC12nRcDhfz
 vpoUgcZAoOJ8ICvQRHyqd0g==
X-Google-Smtp-Source: AGHT+IGNOGj69YnPJyljEQ3eSAE85qVdseIh+Xg+uwtDUGTZ5WehUZhCZ22VhMbxHvn1wZFdwRgv+w==
X-Received: by 2002:a17:903:3847:b0:248:e3fb:4dc8 with SMTP id
 d9443c01a7336-24944aa2905mr111738315ad.39.1756727179321; 
 Mon, 01 Sep 2025 04:46:19 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:46:18 -0700 (PDT)
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
Subject: [PATCH v3 10/35] tcg/wasm: Add add/sub/mul instructions
Date: Mon,  1 Sep 2025 20:44:12 +0900
Message-ID: <172f143f9806e41742137d975b2b80eb20f98a53.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
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

The add, sub and mul operations are implemented using the corresponding
instructions in Wasm. TCI instructions are also generated in the same way as
the original TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                | 12 ++++++++++++
 tcg/wasm/tcg-target.c.inc | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tcg/wasm.c b/tcg/wasm.c
index 9f3b1344d6..ba8a89d920 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -59,6 +59,18 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ^ regs[r2];
             break;
+        case INDEX_op_add:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] + regs[r2];
+            break;
+        case INDEX_op_sub:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] - regs[r2];
+            break;
+        case INDEX_op_mul:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] * regs[r2];
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index a1757b4db7..d5cf324e7b 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -140,6 +140,9 @@ typedef enum {
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
 
+    OPC_I64_ADD = 0x7c,
+    OPC_I64_SUB = 0x7d,
+    OPC_I64_MUL = 0x7e,
     OPC_I64_AND = 0x83,
     OPC_I64_OR = 0x84,
     OPC_I64_XOR = 0x85,
@@ -265,6 +268,42 @@ static const TCGOutOpBinary outop_xor = {
     .out_rrr = tgen_xor,
 };
 
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_add, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_ADD, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_add,
+};
+
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_sub, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_SUB, a0, a1, a2);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
+static void tgen_mul(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_mul, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_MUL, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_mul = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_mul,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


