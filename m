Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBC3CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwHl-0004Mw-PC; Tue, 26 Aug 2025 12:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHk-0004LW-A4; Tue, 26 Aug 2025 12:12:36 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHf-0007wv-DS; Tue, 26 Aug 2025 12:12:36 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b4c3d8bd21eso174147a12.2; 
 Tue, 26 Aug 2025 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224745; x=1756829545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1Mrv8IdjyEjKBO75Bk7pV9xRPj8VZ5rAZiJXPeO20c=;
 b=UwG6CecOoTM+xee+nwYvDi2hxqLUw42S7cKIAranXKgHt6Y0fvGXhmSDWajBu0CVx/
 JtOL6ezDNvZhBV8CwUvkiLVywFJniUiXnID7WnZKzTEiHIC7jcg2BMicb6/TOcQ0NGjv
 b8MiqXxrch8txCLeidv6baH2/atjHg6WGof7Ot5KUf9MS/FLPhuZDZ2ofs3MkjqeIJ7Q
 C851S8Uo8D9N6cG0H5nTlTW6DFU384yKiD1A83704xdwKdXNlfHThkN1mwhVgdBCqpei
 qIRFbo7LRv0FSgrnC8bR+TgD9DjEbC0UR+FvCdOgR/dvNhfzPnjmdLY5Hzg4PT8zgx/f
 B5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224745; x=1756829545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1Mrv8IdjyEjKBO75Bk7pV9xRPj8VZ5rAZiJXPeO20c=;
 b=rOiTyNga3clUqk3MbWN55DotDViTspTE42Hr89+G0QRaGtzLS5K2FbTd+/E0DWvNJ2
 b6tWxy/tOU0ZxFE0ea6jmR36zXfJptW4ZDg/C9xiJTeKUT5NQTQ2yCKGPSBiXD6koVVn
 xgpq9NlxkDfrFJ0ePJpGKrlRPnTy3MiOuKSL82LfT8z1YromU8AwmOrPkNTj9vOiZVNF
 8sqVSU6qEq8y/q6VnK6//rvsqec1yXE3ns0DR4EXtY1uZxnBJ1bN83lYZzidz0yPdX8u
 zZNNC5SnrV/GQgud0QueSFuiZGX5injfsvhMlD74C+DUb7yq3H/tykgPx3/uoguG6hS8
 dbRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRCkZwyqyzmnjD+lYXIVxfC+xnQ4SV+TsZysv233u740YhdLyi07iNCoRryQKjgYhB8CRNHKuBxg==@nongnu.org,
 AJvYcCWVmYKpKE9uPoLHHgwz1nBp6J5st6M1YfS4vylXESw5EgjOf+XD79uAvTcb6EH0LjMgHyMl7uY0z68czw==@nongnu.org
X-Gm-Message-State: AOJu0YyVL4fUsixN9NOIdT8wlNqhKHS+4ZEZr90aa0StzvvzxCG0EFu7
 +jtp+r0W8Hg/cEsRb9urR5j7inHhDA6mGD6XsRwlOiHAsFJCC02PuKICoG47Iw==
X-Gm-Gg: ASbGnctxq3ss+CxUqgv9h3Ue9oFi7QJDQNp1+Id+DfezOXcwwIuoPk2ON38jQ4NAzZ8
 VkuKZkL9PTS99BC5S+5W7Cy3XNIOXU6dlN0tn9HYEsh97JT6e7YyNXDDddIPbuvYgxFoVBgAu/d
 tf3hO+ug1g4aWmrObZaiwBBNudEzP10auq2MTxX6QTubH4iPPsjetfSSN7I9YPZrW470/0hNdhh
 AW+DCHhAq9e7e7ncPpaAGbMh97BiFarcSxk/dDEmYl+0xQSJkNlcf+1/QkGstGobzMX7eLgC7W1
 MdiC6PDUs5CXRtf0ezyRVCDpk8BROQRQbxcsPB8DpWmM1QHjjS8Cd1qbOmPJKZNFkqF/kQxFbBz
 iOe/kjbYCSUmAVCuooOYJCQ==
X-Google-Smtp-Source: AGHT+IGmLo4P2FYovo+0AnthvHUBbHqwVsxoLx7Ip7n7xxl0XNhyBRphntUztNpt6v3UjIUDAcByvw==
X-Received: by 2002:a17:90b:3d01:b0:31f:32f:3a87 with SMTP id
 98e67ed59e1d1-32517742c53mr21098642a91.26.1756224745353; 
 Tue, 26 Aug 2025 09:12:25 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:12:24 -0700 (PDT)
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
Subject: [PATCH v2 13/35] tcg/wasm: Add sextract instruction
Date: Wed, 27 Aug 2025 01:10:18 +0900
Message-ID: <f4f7a03f63e7d7e63c3449b4521b85b3ca0401e5.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52a.google.com
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

V2:
- This commit generates both Wasm and TCI instrucitons.
- Removed the extract and deposit oprations to use default expansion.
- Updated the sextract to emit only when the corresponding Wasm instruction
  is available

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


