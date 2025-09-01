Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0634FCA1006
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut30W-0001T1-8k; Mon, 01 Sep 2025 07:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zq-00087t-Rv; Mon, 01 Sep 2025 07:46:50 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zi-0001R6-6A; Mon, 01 Sep 2025 07:46:49 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-77238a3101fso1378496b3a.0; 
 Mon, 01 Sep 2025 04:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727191; x=1757331991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4Hc+d5jiv3JpJF9e+21kAujA1CrZSCAACAVIRk8Zjg=;
 b=PRiO+VKWHGd6KJrhvodqFGoC2OT5Dl4AC36SQFmaVGIQNp2dpvIs5waW7SkRQI2/2Q
 RDaNLZRg4DjWwzOCS0SMN5fqnZowoQUKumSSEwT4yih99BZopmKxhMxv6bUtn9iwvSHf
 9TUcqmC9Ekd+kfg6mOdiL1in4ek/zYcPdE2lsgoB/ljooy6SQNTO2V4DJ2T5OVorbXLK
 gC516bhiZxYwqGNBwzuGI+yiBeHBTUUWrHsROdqCezzKOjQPSSYzrxT0dmQuYiA8RGPx
 CYn+1hzefZm8bVspelfoSfxYExNQ1jJhDZ7YtCpoVZfVyZ3EE+7QlaPrPMtQVqC1OJUc
 2xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727191; x=1757331991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v4Hc+d5jiv3JpJF9e+21kAujA1CrZSCAACAVIRk8Zjg=;
 b=Fkli3kp2kZ7aCIOrV2RgIOGNcQCLgQvk4v7k/Nmj5McHlBuFlCkQDWoo4jF4IrsNZI
 lJoeFYKlRx/EGqe8LF7Y2Tie6MHh/CcRi+om59N7x0vFbGiufxnz28VszbFrtoaiDmwI
 oHUpzlXPsWanHptU2RbajfZ23VU19Zsar5XRt8hW1jy2IGqMvdJY+Peol96DxbCly/p9
 qMqbedi3vSk9uLyReAAcYuy6mMYUMhNXkvhwhvSyyCZ6e/kLImPYITocY1nV2/uaoIDu
 IVLwMWnKtWVkZ/C3FG3v/YlsHuMtGwN5gtEeQFg8M0k13O8JUf03hpS+/TRjzhj/8a8v
 st7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHg+tU/gudDAh5hVYgvJYf9rOjYypg+t4J49XauGANjlxqWgsPFlEGOeIrQNv0YULM7F2Tc4xjXKtGBw==@nongnu.org,
 AJvYcCWUNuJi1FkW6fPFpeAKAD3m10d/uk9P9HCZh7TxYU/w/Pq1q9dd9JZ9HOwp3vKFLHqY81AS/sE1VA==@nongnu.org
X-Gm-Message-State: AOJu0YyAzaW4wJaw/6vidjgxEcvoV2JTPOtoPdFqdi7iGOX/yVeUqFVV
 mOD8OmW9skNO6JYzSkLe+1tkyUy6iHsernZn1CySA5lhlTDn2tZjU6wb9YFGUA==
X-Gm-Gg: ASbGnct18HtN7Y9NZmgPDUmxMGWL9HDlAEqiZsjNH0vdD2pgz8U9QCEdIMQUJ9IiBvG
 KTrszMdS8IU40O2Y92/4BGOQuape1vaVl05VRmmFwy/eWJHphp+WNuVgONbMUstptMyofFuzvtS
 gafYswShmirnDj2609FtO9slwhOsftn+LSWiPobCraH8OWALyr+RB5seBVPBFc2wXjfl4H0OJIg
 8n3dB+uIG8iujl5Yst0V6AbDZiTKS6ItP6JfbNeFpOXWNp1u7LyVlBQWW0GHsnIfHgaN/zlOmy9
 ZG4EzTBCOLIXDNG0L7N2ruxvkdaI0iviMWEZAWU+WOi0KHKf2asnEYOcbU0rrwi5hjZJhi3RMxQ
 CGEHlMgEcBFxWT8npzygVDw==
X-Google-Smtp-Source: AGHT+IE/9YRmF0fIKwqq/Ec0OTK6g/c88HTWK+x3e7tqQ7arfTajlcpRXhbzkgB7V08qZm6TZlztCQ==
X-Received: by 2002:a17:902:e80f:b0:240:968f:4d64 with SMTP id
 d9443c01a7336-249448f9c33mr102456575ad.11.1756727190902; 
 Mon, 01 Sep 2025 04:46:30 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:46:30 -0700 (PDT)
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
Subject: [PATCH v3 12/35] tcg/wasm: Add setcond/negsetcond/movcond instructions
Date: Mon,  1 Sep 2025 20:44:14 +0900
Message-ID: <9dbeb865a3d0a4cbf9b1e4c4da6c76d977bb927e.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42a.google.com
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

These TCG instructions are implemented by using Wasm's if and else
instructions. TCI instructions are also generated in the same way as the
original TCI backend. Since support for TCG_COND_TSTEQ and TCG_COND_TSTNE is
not yet implemented, TCG_TARGET_HAS_tst is set to 0.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                    | 136 +++++++++++++++++++-
 tcg/wasm/tcg-target-has.h     |   7 ++
 tcg/wasm/tcg-target-opc.h.inc |   8 ++
 tcg/wasm/tcg-target.c.inc     | 230 ++++++++++++++++++++++++++++++++++
 4 files changed, 380 insertions(+), 1 deletion(-)
 create mode 100644 tcg/wasm/tcg-target-has.h
 create mode 100644 tcg/wasm/tcg-target-opc.h.inc

diff --git a/tcg/wasm.c b/tcg/wasm.c
index b63b88e011..183dad10a2 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -21,6 +21,12 @@
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
 
+static void tci_args_rr(uint32_t insn, TCGReg *r0, TCGReg *r1)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+}
+
 static void tci_args_rrr(uint32_t insn, TCGReg *r0, TCGReg *r1, TCGReg *r2)
 {
     *r0 = extract32(insn, 8, 4);
@@ -37,6 +43,110 @@ static void tci_args_rrbb(uint32_t insn, TCGReg *r0, TCGReg *r1,
     *i3 = extract32(insn, 22, 6);
 }
 
+static void tci_args_rrrc(uint32_t insn,
+                          TCGReg *r0, TCGReg *r1, TCGReg *r2, TCGCond *c3)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+    *c3 = extract32(insn, 20, 4);
+}
+
+static void tci_args_rrrrrc(uint32_t insn, TCGReg *r0, TCGReg *r1,
+                            TCGReg *r2, TCGReg *r3, TCGReg *r4, TCGCond *c5)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+    *r3 = extract32(insn, 20, 4);
+    *r4 = extract32(insn, 24, 4);
+    *c5 = extract32(insn, 28, 4);
+}
+
+static bool tci_compare32(uint32_t u0, uint32_t u1, TCGCond condition)
+{
+    bool result = false;
+    int32_t i0 = u0;
+    int32_t i1 = u1;
+    switch (condition) {
+    case TCG_COND_EQ:
+        result = (u0 == u1);
+        break;
+    case TCG_COND_NE:
+        result = (u0 != u1);
+        break;
+    case TCG_COND_LT:
+        result = (i0 < i1);
+        break;
+    case TCG_COND_GE:
+        result = (i0 >= i1);
+        break;
+    case TCG_COND_LE:
+        result = (i0 <= i1);
+        break;
+    case TCG_COND_GT:
+        result = (i0 > i1);
+        break;
+    case TCG_COND_LTU:
+        result = (u0 < u1);
+        break;
+    case TCG_COND_GEU:
+        result = (u0 >= u1);
+        break;
+    case TCG_COND_LEU:
+        result = (u0 <= u1);
+        break;
+    case TCG_COND_GTU:
+        result = (u0 > u1);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return result;
+}
+
+static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
+{
+    bool result = false;
+    int64_t i0 = u0;
+    int64_t i1 = u1;
+    switch (condition) {
+    case TCG_COND_EQ:
+        result = (u0 == u1);
+        break;
+    case TCG_COND_NE:
+        result = (u0 != u1);
+        break;
+    case TCG_COND_LT:
+        result = (i0 < i1);
+        break;
+    case TCG_COND_GE:
+        result = (i0 >= i1);
+        break;
+    case TCG_COND_LE:
+        result = (i0 <= i1);
+        break;
+    case TCG_COND_GT:
+        result = (i0 > i1);
+        break;
+    case TCG_COND_LTU:
+        result = (u0 < u1);
+        break;
+    case TCG_COND_GEU:
+        result = (u0 >= u1);
+        break;
+    case TCG_COND_LEU:
+        result = (u0 <= u1);
+        break;
+    case TCG_COND_GTU:
+        result = (u0 > u1);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return result;
+}
+
 static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
 {
     const uint32_t *tb_ptr = v_tb_ptr;
@@ -50,8 +160,10 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
     for (;;) {
         uint32_t insn;
         TCGOpcode opc;
-        TCGReg r0, r1, r2;
+        TCGReg r0, r1, r2, r3, r4;
         uint8_t pos, len;
+        TCGCond condition;
+        uint32_t tmp32;
 
         insn = *tb_ptr++;
         opc = extract32(insn, 0, 8);
@@ -102,6 +214,28 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             regs[r0] = ((tcg_target_long)regs[r1]
                         >> (regs[r2] % TCG_TARGET_REG_BITS));
             break;
+        case INDEX_op_neg:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = -regs[r1];
+            break;
+        case INDEX_op_setcond:
+            tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
+            regs[r0] = tci_compare64(regs[r1], regs[r2], condition);
+            break;
+        case INDEX_op_movcond:
+            tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
+            tmp32 = tci_compare64(regs[r1], regs[r2], condition);
+            regs[r0] = regs[tmp32 ? r3 : r4];
+            break;
+        case INDEX_op_tci_setcond32:
+            tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
+            regs[r0] = tci_compare32(regs[r1], regs[r2], condition);
+            break;
+        case INDEX_op_tci_movcond32:
+            tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
+            tmp32 = tci_compare32(regs[r1], regs[r2], condition);
+            regs[r0] = regs[tmp32 ? r3 : r4];
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm/tcg-target-has.h b/tcg/wasm/tcg-target-has.h
new file mode 100644
index 0000000000..7e3caf8790
--- /dev/null
+++ b/tcg/wasm/tcg-target-has.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: MIT */
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+#define TCG_TARGET_HAS_tst 0
+
+#endif
diff --git a/tcg/wasm/tcg-target-opc.h.inc b/tcg/wasm/tcg-target-opc.h.inc
new file mode 100644
index 0000000000..57274d4569
--- /dev/null
+++ b/tcg/wasm/tcg-target-opc.h.inc
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Based on tci/tcg-target-opc.h.inc
+ *
+ * These opcodes for use between the tci generator and interpreter.
+ */
+DEF(tci_setcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_movcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 3a2a707619..70de3bbf83 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -137,9 +137,37 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
 #define REG_IDX(r) tcg_target_reg_index[r]
 
 typedef enum {
+    OPC_IF = 0x04,
+    OPC_ELSE = 0x05,
+    OPC_END = 0x0b,
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
 
+    OPC_I32_CONST = 0x41,
+    OPC_I64_CONST = 0x42,
+
+    OPC_I32_EQ = 0x46,
+    OPC_I32_NE = 0x47,
+    OPC_I32_LT_S = 0x48,
+    OPC_I32_LT_U = 0x49,
+    OPC_I32_GT_S = 0x4a,
+    OPC_I32_GT_U = 0x4b,
+    OPC_I32_LE_S = 0x4c,
+    OPC_I32_LE_U = 0x4d,
+    OPC_I32_GE_S = 0x4e,
+    OPC_I32_GE_U = 0x4f,
+
+    OPC_I64_EQ = 0x51,
+    OPC_I64_NE = 0x52,
+    OPC_I64_LT_S = 0x53,
+    OPC_I64_LT_U = 0x54,
+    OPC_I64_GT_S = 0x55,
+    OPC_I64_GT_U = 0x56,
+    OPC_I64_LE_S = 0x57,
+    OPC_I64_LE_U = 0x58,
+    OPC_I64_GE_S = 0x59,
+    OPC_I64_GE_U = 0x5a,
+
     OPC_I32_SHR_S = 0x75,
     OPC_I32_SHR_U = 0x76,
 
@@ -157,6 +185,10 @@ typedef enum {
     OPC_I64_EXTEND_I32_U = 0xad,
 } WasmInsn;
 
+typedef enum {
+    BLOCK_I64 = 0x7e,
+} WasmBlockType;
+
 #define BUF_SIZE 1024
 typedef struct LinkedBufEntry {
     uint8_t data[BUF_SIZE];
@@ -191,6 +223,23 @@ static void linked_buf_out_leb128(LinkedBuf *p, uint64_t v)
     } while (v != 0);
 }
 
+static void linked_buf_out_sleb128(LinkedBuf *p, int64_t v)
+{
+    bool more = true;
+    uint8_t b;
+    while (more) {
+        b = v & 0x7f;
+        v >>= 7;
+        if (((v == 0) && ((b & 0x40) == 0)) ||
+            ((v == -1) && ((b & 0x40) != 0))) {
+            more = false;
+        } else {
+            b |= 0x80;
+        }
+        linked_buf_out8(p, b);
+    }
+}
+
 /*
  * wasm code is generataed in the dynamically allocated buffer which
  * are managed as a linked list.
@@ -209,6 +258,10 @@ static void tcg_wasm_out_leb128(TCGContext *s, uint64_t v)
 {
     linked_buf_out_leb128(&sub_buf, v);
 }
+static void tcg_wasm_out_sleb128(TCGContext *s, int64_t v)
+{
+    linked_buf_out_sleb128(&sub_buf, v);
+}
 
 static void tcg_wasm_out_op(TCGContext *s, WasmInsn opc)
 {
@@ -219,6 +272,25 @@ static void tcg_wasm_out_op_idx(TCGContext *s, WasmInsn opc, uint32_t idx)
     tcg_wasm_out8(s, opc);
     tcg_wasm_out_leb128(s, idx);
 }
+static void tcg_wasm_out_op_block(TCGContext *s, WasmInsn opc, WasmBlockType t)
+{
+    tcg_wasm_out8(s, opc);
+    tcg_wasm_out8(s, t);
+}
+static void tcg_wasm_out_op_const(TCGContext *s, WasmInsn opc, int64_t v)
+{
+    tcg_wasm_out8(s, opc);
+    switch (opc) {
+    case OPC_I32_CONST:
+        tcg_wasm_out_sleb128(s, (int32_t)v);
+        break;
+    case OPC_I64_CONST:
+        tcg_wasm_out_sleb128(s, v);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
 
 static void tcg_wasm_out_o1_i2(
     TCGContext *s, WasmInsn opc, TCGReg ret, TCGReg arg1, TCGReg arg2)
@@ -250,6 +322,85 @@ static void tcg_wasm_out_o1_i2_type(
     }
 }
 
+static const struct {
+    WasmInsn i32;
+    WasmInsn i64;
+} tcg_cond_to_inst[] = {
+    [TCG_COND_EQ] =  { OPC_I32_EQ,   OPC_I64_EQ },
+    [TCG_COND_NE] =  { OPC_I32_NE,   OPC_I64_NE },
+    [TCG_COND_LT] =  { OPC_I32_LT_S, OPC_I64_LT_S },
+    [TCG_COND_GE] =  { OPC_I32_GE_S, OPC_I64_GE_S },
+    [TCG_COND_LE] =  { OPC_I32_LE_S, OPC_I64_LE_S },
+    [TCG_COND_GT] =  { OPC_I32_GT_S, OPC_I64_GT_S },
+    [TCG_COND_LTU] = { OPC_I32_LT_U, OPC_I64_LT_U },
+    [TCG_COND_GEU] = { OPC_I32_GE_U, OPC_I64_GE_U },
+    [TCG_COND_LEU] = { OPC_I32_LE_U, OPC_I64_LE_U },
+    [TCG_COND_GTU] = { OPC_I32_GT_U, OPC_I64_GT_U }
+};
+
+static void tcg_wasm_out_cond(
+    TCGContext *s, TCGType type, TCGCond cond, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op(s, tcg_cond_to_inst[cond].i32);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+        tcg_wasm_out_op(s, tcg_cond_to_inst[cond].i64);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_setcond(TCGContext *s, TCGType type, TCGReg ret,
+                                 TCGReg arg1, TCGReg arg2, TCGCond cond)
+{
+    tcg_wasm_out_cond(s, type, cond, arg1, arg2);
+    tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_U);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_negsetcond(TCGContext *s, TCGType type, TCGReg ret,
+                                    TCGReg arg1, TCGReg arg2, TCGCond cond)
+{
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0);
+    tcg_wasm_out_cond(s, type, cond, arg1, arg2);
+    tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_U);
+    tcg_wasm_out_op(s, OPC_I64_SUB);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_movcond(TCGContext *s, TCGType type, TCGReg ret,
+                                 TCGReg c1, TCGReg c2,
+                                 TCGReg v1, TCGReg v2,
+                                 TCGCond cond)
+{
+    tcg_wasm_out_cond(s, type, cond, c1, c2);
+    tcg_wasm_out_op_block(s, OPC_IF, BLOCK_I64);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(v1));
+    tcg_wasm_out_op(s, OPC_ELSE);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(v2));
+    tcg_wasm_out_op(s, OPC_END);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_out_op_rr(TCGContext *s, TCGOpcode op, TCGReg r0, TCGReg r1)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    tcg_out32(s, insn);
+}
+
 static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
                            TCGReg r0, TCGReg r1, TCGReg r2)
 {
@@ -277,6 +428,35 @@ static void tcg_out_op_rrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
     tcg_out32(s, insn);
 }
 
+static void tcg_out_op_rrrc(TCGContext *s, TCGOpcode op,
+                            TCGReg r0, TCGReg r1, TCGReg r2, TCGCond c3)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    insn = deposit32(insn, 20, 4, c3);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
+                              TCGReg r0, TCGReg r1, TCGReg r2,
+                              TCGReg r3, TCGReg r4, TCGCond c5)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    insn = deposit32(insn, 20, 4, r3);
+    insn = deposit32(insn, 24, 4, r4);
+    insn = deposit32(insn, 28, 4, c5);
+    tcg_out32(s, insn);
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -397,6 +577,56 @@ static const TCGOutOpBinary outop_sar = {
     .out_rrr = tgen_sar,
 };
 
+static void tgen_setcond_tci(TCGContext *s, TCGType type, TCGCond cond,
+                             TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_setcond32
+                     : INDEX_op_setcond);
+    tcg_out_op_rrrc(s, opc, dest, arg1, arg2, cond);
+}
+
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tgen_setcond_tci(s, type, cond, dest, arg1, arg2);
+    tcg_wasm_out_setcond(s, type, dest, arg1, arg2, cond);
+}
+
+static const TCGOutOpSetcond outop_setcond = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_setcond,
+};
+
+static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tgen_setcond_tci(s, type, cond, dest, arg1, arg2);
+    tcg_out_op_rr(s, INDEX_op_neg, dest, dest);
+    tcg_wasm_out_negsetcond(s, type, dest, arg1, arg2, cond);
+}
+
+static const TCGOutOpSetcond outop_negsetcond = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_negsetcond,
+};
+
+static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg ret, TCGReg c1, TCGArg c2, bool const_c2,
+                         TCGArg vt, bool const_vt, TCGArg vf, bool consf_vf)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_movcond32
+                     : INDEX_op_movcond);
+    tcg_out_op_rrrrrc(s, opc, ret, c1, c2, vt, vf, cond);
+    tcg_wasm_out_movcond(s, type, ret, c1, c2, vt, vf, cond);
+}
+
+static const TCGOutOpMovcond outop_movcond = {
+    .base.static_constraint = C_O1_I4(r, r, r, r, r),
+    .out = tgen_movcond,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


