Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F7DCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut31H-0003Bm-K9; Mon, 01 Sep 2025 07:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut30F-0000kR-TD; Mon, 01 Sep 2025 07:47:16 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut309-0001Z4-Ak; Mon, 01 Sep 2025 07:47:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-244582738b5so37721765ad.3; 
 Mon, 01 Sep 2025 04:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727220; x=1757332020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmjKCcJg/XvaXc+knb67SzldxejgqYeqQIRRw4J5fTg=;
 b=OyTMXyIm1xjHCvfRzNdA/Zli8wgTkHyCESheT5ipZ3eCkqUSnmUsJ2biCTLhPQKlLC
 FwKvQMg8sS3dCgBa2EMH1MidwEskFWtlI2M2YhFoSZlLFHRDZkh5NEeWqT8fDQCSfeEi
 vBnP6deO1Z0lGwmPfJP6udonIkQa+KCalfKrmmhUNiFDK0cs4YlisIN1ABtXbTXy0r1r
 evhUns2bMHF6EFL3lxBFGZ9Myfq7+AtxdmHS56UpDB8dPpngom6RuvgKTfhmS6mxF/e+
 bGNcn+R9badhyPSiDinS/i2jP+75KNFF4PcLCaOtW2C+dDC4cNDr6f3oOhhT/e8Z5M7/
 1fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727220; x=1757332020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmjKCcJg/XvaXc+knb67SzldxejgqYeqQIRRw4J5fTg=;
 b=ptT1BCT0RXscdTwn0lIUztPEZEvZhGrAeNR22fkntlpabNLCIm8Ic+BVJ2hkv8D3tG
 BZiYZHX6Kib69+rtIcnoqC8oki7wmQXgGIZx5+mKM09ybIYMAtWOVcD6wbACmrI1xi2Z
 EldFlwUfLkOs7clq0XSVBa91O/9UBecFv7QyRdsbNhety1KcVf0l49rfUMNF6rooxmIp
 YR/p8mfi7tAxE2eHm4WYCSeLAhjhAe7Jofzw2w2rK9lLffUmTf5adNeRt69rhiViAJMy
 1rQm3wfHAOTpIZ/NPvkbDIAWbPxXbvAJbJu7LQqAVHjCWNvzAylUnmsCj4LmE4pqwtH9
 Ryzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrMn2kzBOi7U1iaxGdUlkPjwJwLxyudnQfJamGx6sn3yAJPp2KLD1yI4FzMGpnaIEParBMPMt5Dw==@nongnu.org,
 AJvYcCVfMBzR/6MBF5LqNxcenOOuAOx4DUjv39odKYPSwXXyoV6WICEGl65Xi0hA+sbFB7H8bG1f5UQPE45hlg==@nongnu.org
X-Gm-Message-State: AOJu0YzmxeXim28kg26QdFJewtMyfS7n0sItjJrhnXRJ+RfcPLe96tta
 B3GPZ7hcFPkGZi37t6GHPhelQJX9teBcmBUOoYXzxgMjUfMrS4BHteM0KMS4rQ==
X-Gm-Gg: ASbGncvGIHpA27gLHS6xYjtr1+OhB/Wc/Qit8uvM2JFBPTPR3AxvpXl7p1nkF9sJz1M
 p3jbaw0l4oIgSIGSJMTgWoVM8KF+P98GmO1Av0ujoA7hD/OU4R2t/0J0fZiesPOfV44CkQszQDQ
 siebEvrjXE4DhRoYBtYyzFOT+sZcaT09MnsdwNUDxqGvfyXbDweKCGJH3/2iHbR1NocAMSXwYqA
 T309pClvL7y/0S9SFATWtPV2R4o+pMS+lRz6qWYTqfQ8toX+vTi5Rfi/RXSpU/BF9dq/MiHfdeF
 5whuq00k2lAt/2J7NJa08TNlh3BJGg8cvDJH38zH/Toku3Pc7q057g9DQXQNzoON9EWlaa/7vBu
 j2e9IlCxev14T9ByaN2sQtIP4BGkfmipk
X-Google-Smtp-Source: AGHT+IEOEBT9SP9+zMBLB2es4O64PKaker5iUpH9NqTYKUAPZ7QFIfAnPveOLn60R47NlFU9tx+xYQ==
X-Received: by 2002:a17:903:1a2e:b0:240:52c8:2564 with SMTP id
 d9443c01a7336-24944a0f8fcmr96664405ad.26.1756727219648; 
 Mon, 01 Sep 2025 04:46:59 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:46:58 -0700 (PDT)
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
Subject: [PATCH v3 17/35] tcg/wasm: Add div/rem instructions
Date: Mon,  1 Sep 2025 20:44:19 +0900
Message-ID: <32eaa622a5acc240179be619c09319bbb48f3f14.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x634.google.com
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


