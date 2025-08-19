Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F130CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoQzy-0005iq-Ip; Tue, 19 Aug 2025 14:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzw-0005hF-Kv; Tue, 19 Aug 2025 14:23:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzu-0003sV-Gz; Tue, 19 Aug 2025 14:23:52 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e2e8e2d2dso3635556b3a.1; 
 Tue, 19 Aug 2025 11:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627828; x=1756232628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7pidbMisoPIBJ7RWKvtdHMzW1in7nxoy5d87oIlaqo=;
 b=cYsh0NM8VE/pV2sODlGGMAHUAkKAikCd73vkcokecHv4epKUX5nMqGJ5sv6YclBD3C
 TpIhtWCKmT1jSvbX9fGM2rwEtgs47PXjXLO6isKIMe6nUTfF0PMvhwXcc3Bx+MLJZ2Uc
 /J0uhkkuuyxUu0gUqxmfHUNFTLqcpIRt/Bpl+9Y/4uA77C3IS3v0LdK0o5SiifEhaqy+
 qaKWU2aMaL6z13N6t1fTV69Ou7qGMx8HaJ4kPX8nw9O91N9eSFwQdbn/3iowjYEt9xKr
 boXQZPxrMG6rFzdBqicv20wk2BrmoFM8OiAsexWqcR4Cam5pmhwH4jEjnRt4QGBFmUd2
 +TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627828; x=1756232628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7pidbMisoPIBJ7RWKvtdHMzW1in7nxoy5d87oIlaqo=;
 b=F06WANXnQuTCYkfhDWlVWklyf61a1DzkP2rvMJccGF2miVwG72UxX3Wp8GS2WxzFaj
 5cih/FcdkwFQNpHh3Q0BQOIKk9yb6cOykBHZOOWA+XbN49IQX6ipmKoAvI4LJef8lfnj
 1Lo2T+lxLorNfcocrOPctsVCTgShOcC7FlXqdDdMG2Di+3O4r0u3sAp3qmjT1oCkEWbo
 wo/oVeVu1PjmfP/KaWK8AUsaeBedlcoLoEFp2fxdvkprbAMXzyr3JDCBU/7SGKSq4KqM
 3gAhRqOnBEppqLtLFWVhLN6UILRfujK296lXOrvlSdEX7+4lqZ1LkCtMHoMsOVO/GYNo
 np2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCURMYsmCwLjVs6DA5X7kHOvDHH9qF6bgyUBT29QEirjtmyWSr68zCbUMZnojNKFDXEK44/y6K0zynTFRA==@nongnu.org,
 AJvYcCWpNypxBNtR1Q7EZ9e1KBH/Lsva9EqA6vK3oMP5SJp2nGxKnTZ1mHekWDyq/1V7/daRk6MrOjWNwQ==@nongnu.org
X-Gm-Message-State: AOJu0YyQNLJAtdmiaL+QRv36f/L0rHtCTBf2cB5bGWmN3UH4MyFJ8HNh
 /TRg9qJELc0LBR1LalFOtIBHITIkyIcXQo6K0VnmyQColA0XswAyfCJtjhaG9SXe
X-Gm-Gg: ASbGncu+Rt2U3QQpd6LfdYclPeeW/ZZEegb3zzQDtboH2c6RSf6RJLSDJ2K5MDSZ737
 511h8Z/8XR5lU0DXyjw6NEbhsHv8Ho4rxyRhZET0JAT8HxOmlbRv4+TZX1j1rGbfy8lJkix5a4z
 7wRo138k7TnzGJJILAHezEMNELZ78Q2enPhcEeAJ/JLMxNWs1CWN21wSURatjsDE36DFYcKlv6C
 fPXRMftNeXc14g0zCrJF406MiCoPrQljCDznPrRkBP1jyJuMMBRgvJLnDmZk/HFeFPHaUh3KSMA
 IXklyTGl/uXCmQ3z6/KQQ4FM4F4EecNbN5f4ReFA+ZfUfGQCSGn4WwhKgoycAwwbLr7H0Dx8noV
 uLgpWleEHAf016Y1GXJtu4w==
X-Google-Smtp-Source: AGHT+IEwVPKyWzyRg9IMeGfXhOTZdVHPlfwIN5f+/d7UPxKYiNnemrPGIPwhSx05r9r028BpoyjUUg==
X-Received: by 2002:a17:903:2449:b0:242:9bc4:f1c9 with SMTP id
 d9443c01a7336-245e0504d60mr50238875ad.56.1755627828182; 
 Tue, 19 Aug 2025 11:23:48 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:23:47 -0700 (PDT)
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
Subject: [PATCH 13/35] tcg/wasm: Add setcond/negsetcond/movcond instructions
Date: Wed, 20 Aug 2025 03:21:42 +0900
Message-ID: <21259acc327a42f7bff3aca6135439ee065d416f.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x436.google.com
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
instructions. Support for TCG_COND_TSTEQ and TCG_COND_TSTNE is not yet
implemented, so TCG_TARGET_HAS_tst is set to 0.

The tgen_setcond function was used by several other functions
(e.g. tgen_negsetcond) and intended specifically for emitting TCI code. So
it has been renamed to tgen_negsetcond_tci.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target-has.h |   2 +-
 tcg/wasm/tcg-target.c.inc | 166 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 163 insertions(+), 5 deletions(-)

diff --git a/tcg/wasm/tcg-target-has.h b/tcg/wasm/tcg-target-has.h
index ab07ce1fcb..1eaa8f65f6 100644
--- a/tcg/wasm/tcg-target-has.h
+++ b/tcg/wasm/tcg-target-has.h
@@ -13,7 +13,7 @@
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
-#define TCG_TARGET_HAS_tst              1
+#define TCG_TARGET_HAS_tst              0
 
 #define TCG_TARGET_extract_valid(type, ofs, len)   1
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 81e83a8bdf..03cb3b2f46 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -117,9 +117,37 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
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
     OPC_I32_SHL = 0x74,
     OPC_I32_SHR_S = 0x75,
     OPC_I32_SHR_U = 0x76,
@@ -138,6 +166,12 @@ typedef enum {
     OPC_I64_EXTEND_I32_U = 0xad,
 } WasmInsn;
 
+typedef enum {
+    BLOCK_NORET = 0x40,
+    BLOCK_I64 = 0x7e,
+    BLOCK_I32 = 0x7f,
+} WasmBlockType;
+
 #define BUF_SIZE 1024
 typedef struct LinkedBufEntry {
     uint8_t data[BUF_SIZE];
@@ -172,6 +206,23 @@ static void linked_buf_out_leb128(LinkedBuf *p, uint64_t v)
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
@@ -190,6 +241,10 @@ static void tcg_wasm_out_leb128(TCGContext *s, uint64_t v)
 {
     linked_buf_out_leb128(&sub_buf, v);
 }
+static void tcg_wasm_out_sleb128(TCGContext *s, int64_t v)
+{
+    linked_buf_out_sleb128(&sub_buf, v);
+}
 
 static void tcg_wasm_out_op(TCGContext *s, WasmInsn opc)
 {
@@ -200,6 +255,30 @@ static void tcg_wasm_out_op_idx(TCGContext *s, WasmInsn opc, uint32_t idx)
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
+static void tcg_wasm_out_op_not(TCGContext *s)
+{
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, -1);
+    tcg_wasm_out_op(s, OPC_I64_XOR);
+}
 
 static void tcg_wasm_out_o1_i2(
     TCGContext *s, WasmInsn opc, TCGReg ret, TCGReg arg1, TCGReg arg2)
@@ -231,6 +310,76 @@ static void tcg_wasm_out_o1_i2_type(
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
+    tcg_wasm_out_cond(s, type, cond, arg1, arg2);
+    tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_U);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 1);
+    tcg_wasm_out_op(s, OPC_I64_ADD);
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
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -1147,8 +1296,8 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
-static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
-                         TCGReg dest, TCGReg arg1, TCGReg arg2)
+static void tgen_setcond_tci(TCGContext *s, TCGType type, TCGCond cond,
+                             TCGReg dest, TCGReg arg1, TCGReg arg2)
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_setcond32
@@ -1156,6 +1305,13 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
     tcg_out_op_rrrc(s, opc, dest, arg1, arg2, cond);
 }
 
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tgen_setcond_tci(s, type, cond, dest, arg1, arg2);
+    tcg_wasm_out_setcond(s, type, dest, arg1, arg2, cond);
+}
+
 static const TCGOutOpSetcond outop_setcond = {
     .base.static_constraint = C_O1_I2(r, r, r),
     .out_rrr = tgen_setcond,
@@ -1164,8 +1320,9 @@ static const TCGOutOpSetcond outop_setcond = {
 static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
                             TCGReg dest, TCGReg arg1, TCGReg arg2)
 {
-    tgen_setcond(s, type, cond, dest, arg1, arg2);
+    tgen_setcond_tci(s, type, cond, dest, arg1, arg2);
     tgen_neg(s, type, dest, dest);
+    tcg_wasm_out_negsetcond(s, type, dest, arg1, arg2, cond);
 }
 
 static const TCGOutOpSetcond outop_negsetcond = {
@@ -1176,7 +1333,7 @@ static const TCGOutOpSetcond outop_negsetcond = {
 static void tgen_brcond(TCGContext *s, TCGType type, TCGCond cond,
                         TCGReg arg0, TCGReg arg1, TCGLabel *l)
 {
-    tgen_setcond(s, type, cond, TCG_REG_TMP, arg0, arg1);
+    tgen_setcond_tci(s, type, cond, TCG_REG_TMP, arg0, arg1);
     tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, l);
 }
 
@@ -1193,6 +1350,7 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
                      ? INDEX_op_tci_movcond32
                      : INDEX_op_movcond);
     tcg_out_op_rrrrrc(s, opc, ret, c1, c2, vt, vf, cond);
+    tcg_wasm_out_movcond(s, type, ret, c1, c2, vt, vf, cond);
 }
 
 static const TCGOutOpMovcond outop_movcond = {
-- 
2.43.0


