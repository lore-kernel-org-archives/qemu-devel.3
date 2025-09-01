Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24E7CA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut307-0000OE-NL; Mon, 01 Sep 2025 07:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zp-000803-5o; Mon, 01 Sep 2025 07:46:49 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zk-0001SO-CN; Mon, 01 Sep 2025 07:46:48 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2487a60d649so52456875ad.2; 
 Mon, 01 Sep 2025 04:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727197; x=1757331997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0L45vE0IuF3pvV+AN2AolMd1u+x6bFzT5jaCBTjmB4s=;
 b=Gju9Hd0Sn4B/Xvmb3zBe4yjp+GhcqXKhshTaMOZ4nrdYM1NsohDZkHLg0xQZwsWKCw
 +ndRzjlwkLjI3dUQe2400jpT8xC/6qGoEbefK2bCubR0bcrhm+J8f7IAGoNSGV9jqkhH
 amj2de7oeBflc2ToKBC+6URtez8C9+AhEIrFgOW4JwcfB2y8Rc2CGdYDJgbimab2i4F0
 SMZ/LfS7pekIUjPCTFaValiArXKBY5HYySd6WYVZ6GyNAOvGagnbOmyBMKBBP0DbGw4F
 gtmzsFzANkvM69HEARSk8ut/GyJlmjiP64Lc8EIv2VAf4uBkEPLKhhLgqfXm5WtyiIOh
 /s+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727197; x=1757331997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0L45vE0IuF3pvV+AN2AolMd1u+x6bFzT5jaCBTjmB4s=;
 b=Uk60uierzrpvZOkGpejOlCaKTeGT/q69VyKbZKmd7G3lg36j3zBjsV8q46H7CvOdLD
 1y+BTNaSnTqjuUC9svJ/M+ZKjX7vYwPGXXNYi/zRAn2UW0sOnkiZG1dbeGLizVfgtPeg
 vqjUZCEieQolzT/iaqR8F/FY/4BgZeG1LpHmPcCFV4cnJE/PgegWr/Kgs4ZZzz/EhvVk
 W3ofuC2mYhepaGP4Q6jdlmqI6IrygRjYma8yu2LvStVGjnI1xStz8Tmnd9s8mcNMEJKb
 TDk8/CATZrOLpGIC6GJMlkCQ/FMv+jTU1M8xO2YJeJqSD9zNCThc2cz79EnmSfhVr4vr
 SN7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaJ7eOKRwN0zu8wanjuLl1bFB1eHWaWPmTv/m0c4YrGRcA/A2bJAUMAHCOFkbBHGGOBXBh2AIfQvQBAA==@nongnu.org,
 AJvYcCX+UFrU71LqFhm3aaNlTdc0v/9+qcKYbdyAz86s3hNkIPyMnGuHt5eSeYpB5UxwS05iJa29gpj7fQ==@nongnu.org
X-Gm-Message-State: AOJu0YxnsMz1ZGAgzWbM+VIFterCO4LQHFSurCN3WX6+SSV+O2W5PuKm
 fnT0JJ3ZnM0SljhS2sgE4D1PgD795zYf/nXjfG0uRu4g54Yi7QauByhQ0Rl7FQ==
X-Gm-Gg: ASbGncuvCcb96tSWINn6dnMzjv7XRGcPbJOZ+bgD3jITFDECsIJcw8e9KGXq/kNo4Tn
 E2pvdHA//j5zWuT3VXP69626SWiHlmNtj3qdboHhtu2WgVBAlulnOmOwzvLaRaUpiyxpYWteyVK
 YkkjBdNb4667bGj6A/iSnUnKjfwu6jkyw6Y65uYUA/gxIoK4m8w95c53ynp7rnOzlGKpcR+Iklo
 N6QC5mQFMRQ0g2K+U9QPx70J5ygDXySop2SSPnE1QUMyogU4ie27l9TbwqEvZTeT0xunFoIRLlQ
 qHcfP2OOF7l83HUf7eHu6+E6Wn7M8aanDRIMn4Uvtfnih3Cw0npNpHjBVKgP5CbiGXqiWQHEJei
 0aDTp2GYWsspLtKOMM3hHog==
X-Google-Smtp-Source: AGHT+IGZJnFNBlyYCr+q9R3KmQbgYYftuNln5Mk3YposoQKUyA9Iqmn/kAN/CMUrHccfv7sAbgGNGA==
X-Received: by 2002:a17:902:e750:b0:248:9677:5f33 with SMTP id
 d9443c01a7336-24944873fa1mr119466745ad.3.1756727196756; 
 Mon, 01 Sep 2025 04:46:36 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:46:36 -0700 (PDT)
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
Subject: [PATCH v3 13/35] tcg/wasm: Add sextract instruction
Date: Mon,  1 Sep 2025 20:44:15 +0900
Message-ID: <f4f7a03f63e7d7e63c3449b4521b85b3ca0401e5.1756724464.git.ktokunaga.mail@gmail.com>
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

The sextract operation is genereted only when the corresponding Wasm
instructions are available, as specified by TCG_TARGET_sextract_valid.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target-has.h |  5 +++++
 tcg/wasm/tcg-target.c.inc | 42 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tcg/wasm/tcg-target-has.h b/tcg/wasm/tcg-target-has.h
index 7e3caf8790..cfb85388de 100644
--- a/tcg/wasm/tcg-target-has.h
+++ b/tcg/wasm/tcg-target-has.h
@@ -4,4 +4,9 @@
 
 #define TCG_TARGET_HAS_tst 0
 
+#define TCG_TARGET_extract_valid(type, ofs, len) 0
+#define TCG_TARGET_sextract_valid(type, ofs, len) \
+    ((ofs == 0) && ((len == 8) || (len == 16) || (len == 32)))
+#define TCG_TARGET_deposit_valid(type, ofs, len) 0
+
 #endif
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 70de3bbf83..dd75deecd3 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -182,7 +182,10 @@ typedef enum {
     OPC_I64_SHR_U = 0x88,
 
     OPC_I32_WRAP_I64 = 0xa7,
+    OPC_I64_EXTEND_I32_S = 0xac,
     OPC_I64_EXTEND_I32_U = 0xad,
+    OPC_I64_EXTEND8_S = 0xc2,
+    OPC_I64_EXTEND16_S = 0xc3,
 } WasmInsn;
 
 typedef enum {
@@ -391,6 +394,33 @@ static void tcg_wasm_out_movcond(TCGContext *s, TCGType type, TCGReg ret,
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
 }
 
+static void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg arg1,
+                                  int pos, int len)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+
+    if (pos == 0) {
+        switch (len) {
+        case 8:
+            tcg_wasm_out_op(s, OPC_I64_EXTEND8_S);
+            break;
+        case 16:
+            tcg_wasm_out_op(s, OPC_I64_EXTEND16_S);
+            break;
+        case 32:
+            tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+            tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_S);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        g_assert_not_reached();
+    }
+
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
+}
+
 static void tcg_out_op_rr(TCGContext *s, TCGOpcode op, TCGReg r0, TCGReg r1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -529,6 +559,18 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static void tcg_out_sextract(TCGContext *s, TCGType type, TCGReg rd,
+                             TCGReg rs, unsigned pos, unsigned len)
+{
+    tcg_out_op_rrbb(s, INDEX_op_sextract, rd, rs, pos, len);
+    tcg_wasm_out_sextract(s, rd, rs, pos, len);
+}
+
+static const TCGOutOpExtract outop_sextract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tcg_out_sextract,
+};
+
 static void tgen_shl(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-- 
2.43.0


