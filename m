Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B7DCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR0n-00085f-QO; Tue, 19 Aug 2025 14:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0l-0007qe-DS; Tue, 19 Aug 2025 14:24:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0j-0003z8-4P; Tue, 19 Aug 2025 14:24:43 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-24458272c00so56799635ad.3; 
 Tue, 19 Aug 2025 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627878; x=1756232678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWNu5ctXTfQFZ5CgldinQ05FNeoPiocV4Ar7WZw/JeE=;
 b=SXUKVxoV5xnRBXamlb8454XPJpoFgw7I/p+CYZEWSRAQJ395B8vnZ2quymdnCXqXkC
 iJ9kzZUhvXGtFPHaS0GHIcriYYR9ti0Z0enQDTJ/WO04igthjZ1XsQEPQrP2XSO3AmgJ
 Dr56ViAhOyzYH3No8vz91W0UzDByEwgRJOO0IUJ50aeCZEZ/WaSI/grovSGC8J9jIP7g
 EmHqY+RoOIFOiMg0HnYWYt4j73l78C01+cQINFC+BSY2E1VUq0ziENhi2tFexRqKBTw7
 E9HZv0aTy/1UZJ6NhU6VKV0n7uQkguip/G4COxPICfMRTB2QonISxxtO+SAGQseN2tqQ
 ZPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627878; x=1756232678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWNu5ctXTfQFZ5CgldinQ05FNeoPiocV4Ar7WZw/JeE=;
 b=YE3cQgCrg6xmDU4hKu3kbQ79oSIHLTx+gcciK/8Bm9IJIsHtQqllc4VAaveXX1S/uM
 8+g4jfhGP95BZFQVeflhwko6qH9q7PnfNd6ut/cqTnDCQQoNzU8LZb26ME//tBDTQ/PU
 Q3TZHul+22C314TXpEbrI7teCH+gyrdEhkVHWNFVST5CHkfX4aEQKPDL6fUWRF0L6ZF0
 TsM78Oa6kZY/N4GTemM2bN37aUAJYMc6NUhiEJg8zpu/IjIbKVbDVhETECh5TvKoMxBg
 JwD3w7hG9f52+eggkvH6TtPgmjPWICVaP8Yq8ngHucRWoozDu/FQ2T20sStO23HgpY7d
 TwWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhL3PVHOo/swlegGQbMHGr+WJPDWActPpqv12W1yPHJM8IxcwoZbb6TaJt4++wx/ok3Q//CxQ8zw==@nongnu.org,
 AJvYcCUqS9hIQdaS5C1IVeQDVhcFB3BpsF5LxN+1QjH71E9KYi2/lbJg8ZgJrCvaJ1IZE7R6LbTvmYneSCqW/A==@nongnu.org
X-Gm-Message-State: AOJu0YxAiP4whYdkZLlYGccCzhrfA5SUxLErOoBaHEoCfKCvtzyycSDX
 WBBJ7LkX61lNdB1DZB0vr+M98hXubyZza0kSrENR8FarZtWgXeOtx/JMAFUVBqN2
X-Gm-Gg: ASbGncvfdcuIeoRm2jzqWrvvkthSYtliSOocV7YgGVQCwItK8+UQ+zCtRng19C+K4W3
 rNPIMAYJOqsOAOCirTSWSMSYS4Hh8WC0+DsLVWg5zErA6FPPFAOdvTFwiTd/LlRQ/8eCViCIwjk
 xHc+jMfGkTDpLrzb+EVV0EeCCN9ygZuCev54QGWCHdc6IBrMAADSuQO0K+Lm0SDs/38cVyxpOEg
 YrOLx+5CDZOynrRTAdYP2PLrxVTTwMsNXB070gI8/OZzA1oRQbHPcLNq6/QKSisrChK4dhJIs04
 9IXgLpW1o5oDanatFYI/YfcbX/VL1ZsaYg1nHM8TumVpFTz03g4TnDYuti1KnT8vMuOK+QPmszW
 mZpfyd3pgrUmA0agWv0I5HA==
X-Google-Smtp-Source: AGHT+IH0be1qXHijSKazkYQXR8wgSHthFWobhAyyLJxEzkcdf0k6n8OsDNtc98oZTaR7o3iSXer8dw==
X-Received: by 2002:a17:903:28e:b0:243:926:b1f3 with SMTP id
 d9443c01a7336-245e030c986mr49966605ad.24.1755627878462; 
 Tue, 19 Aug 2025 11:24:38 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:24:37 -0700 (PDT)
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
Subject: [PATCH 22/35] tcg/wasm: Add rot/clz/ctz instructions
Date: Wed, 20 Aug 2025 03:21:51 +0900
Message-ID: <4698352d4cc892db9b31fa2e6e4c225f789149f4.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x632.google.com
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

This commit implements rot, clz and ctz operations using Wasm instructions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 0ba16e8dce..74f3177753 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -146,6 +146,7 @@ typedef enum {
     OPC_I32_CONST = 0x41,
     OPC_I64_CONST = 0x42,
 
+    OPC_I32_EQZ = 0x45,
     OPC_I32_EQ = 0x46,
     OPC_I32_NE = 0x47,
     OPC_I32_LT_S = 0x48,
@@ -157,6 +158,7 @@ typedef enum {
     OPC_I32_GE_S = 0x4e,
     OPC_I32_GE_U = 0x4f,
 
+    OPC_I64_EQZ = 0x50,
     OPC_I64_EQ = 0x51,
     OPC_I64_NE = 0x52,
     OPC_I64_LT_S = 0x53,
@@ -168,6 +170,8 @@ typedef enum {
     OPC_I64_GE_S = 0x59,
     OPC_I64_GE_U = 0x5a,
 
+    OPC_I32_CLZ = 0x67,
+    OPC_I32_CTZ = 0x68,
     OPC_I32_ADD = 0x6a,
     OPC_I32_DIV_S = 0x6d,
     OPC_I32_DIV_U = 0x6e,
@@ -178,8 +182,11 @@ typedef enum {
     OPC_I32_SHL = 0x74,
     OPC_I32_SHR_S = 0x75,
     OPC_I32_SHR_U = 0x76,
+    OPC_I32_ROTL = 0x77,
     OPC_I32_ROTR = 0x78,
 
+    OPC_I64_CLZ = 0x79,
+    OPC_I64_CTZ = 0x7a,
     OPC_I64_POPCNT = 0x7b,
     OPC_I64_ADD = 0x7c,
     OPC_I64_SUB = 0x7d,
@@ -194,6 +201,7 @@ typedef enum {
     OPC_I64_SHL = 0x86,
     OPC_I64_SHR_S = 0x87,
     OPC_I64_SHR_U = 0x88,
+    OPC_I64_ROTL = 0x89,
     OPC_I64_ROTR = 0x8a,
 
     OPC_I32_WRAP_I64 = 0xa7,
@@ -720,6 +728,42 @@ static void tcg_wasm_out_bswap16(
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
 }
 
+static void tcg_wasm_out_cz(
+    TCGContext *s, TCGType type, WasmInsn opc32, WasmInsn opc64,
+    TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op(s, OPC_I32_EQZ);
+        tcg_wasm_out_op_block(s, OPC_IF, BLOCK_I32);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op(s, OPC_ELSE);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op(s, opc32);
+        tcg_wasm_out_op(s, OPC_END);
+        tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_U);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, OPC_I64_EQZ);
+        tcg_wasm_out_op_block(s, OPC_IF, BLOCK_I64);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+        tcg_wasm_out_op(s, OPC_ELSE);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, opc64);
+        tcg_wasm_out_op(s, OPC_END);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void tcg_wasm_out_mov(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
@@ -1266,6 +1310,7 @@ static void tgen_clz(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_clz32
                      : INDEX_op_clz);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_cz(s, type, OPC_I32_CLZ, OPC_I64_CLZ, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_clz = {
@@ -1280,6 +1325,7 @@ static void tgen_ctz(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_ctz32
                      : INDEX_op_ctz);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_cz(s, type, OPC_I32_CTZ, OPC_I64_CTZ, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_ctz = {
@@ -1496,6 +1542,7 @@ static void tgen_rotl(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_rotl32
                      : INDEX_op_rotl);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_ROTL, OPC_I64_ROTL, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_rotl = {
@@ -1510,6 +1557,7 @@ static void tgen_rotr(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_rotr32
                      : INDEX_op_rotr);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_ROTR, OPC_I64_ROTL, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_rotr = {
-- 
2.43.0


