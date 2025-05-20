Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE9AC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMSn-0000nc-9N; Tue, 20 May 2025 08:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSl-0000nH-Og; Tue, 20 May 2025 08:52:55 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSj-0000km-Pv; Tue, 20 May 2025 08:52:55 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b07d607dc83so4408265a12.1; 
 Tue, 20 May 2025 05:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745570; x=1748350370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3aqhzF4R3IS+EMJ/1tKp0zJy/CqsldgOlglF6FuQWs=;
 b=HA1WC3hu4zSh8PAcbUVBiNaz73QcLt7zeNxEOgXIbKK9/bbmHFVHpjbAaNHiNIQXcn
 RPCB2vMCK2k3FIOTtj6FKgrPx7iWZD6+ytMlf2T1GLl1919gs25i6Ygdu1sIGGnhy4bY
 Q5rVYrArWpKXNscFLcQeZXVss7skRSyxIDSvYuhhWPPxmUi4eE3V3ZYhuKkVJ/eJCiPb
 kmpNwGwNoWSKaiFt0vmSh1Vkv5cUpXSK+xbGS+Neifh+QMiKsL1pdZql3d+Rj6r42Sax
 37cSU30Z+VX0bCPK2k2/lKxxcbBW/pP26qmx1skTzTFWOl+p6JgvNQu7qGLvoc/4gz/N
 OqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745570; x=1748350370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3aqhzF4R3IS+EMJ/1tKp0zJy/CqsldgOlglF6FuQWs=;
 b=iJLeB5PtrVjIbLAt3mW900KCrOY8EXZTU7TNW81a3UXlOl+VeChqFEkcA54J2Z+I1h
 L4a2L645e8ZkjptO7aHjk1W7LTplHlAmd3OjYNbD5eqjIbShphmb5jjcyC2/pCW45BXh
 5KLfxjphF6OFgFW9EuLgf6DyI1IHWgu/A4lE8y9LWYsuKhzt17mTGz8BbaT8anUumMGG
 KBsxUKjUiPAAThEbnghUzgAWdLcuRkcm9j/azYmDMceUQ1sU6te+15ilPkwTXOhPQaNW
 8K1hinlyW/2TNaReZUvj15LdP0vUrLZfwKRvuQV46YYsxfLhwia5GQIl+BrwpqXGED/c
 L0lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKJTa6ZkC4bX6b0kXvwQaxq6F8elLd8m7YsKDq8KXBYDR9BuYZIycQGgj7Mt1pE2yB5hOc0ZtmFg==@nongnu.org,
 AJvYcCXwSS8rnIbyQaPiSEw0sGTwY9Zt07FSPrxjG+DyWh0IsEaeRRo6f1lX36UG9MduTRswZPXW+dSPYm6G7w==@nongnu.org
X-Gm-Message-State: AOJu0Yyexx8nL/1VVVHMIE8eRqkeZtKN+W9cyTaIkGHabkZIG30ww5RR
 14vQvYGGYNPi9OkRNfvq6NDWSUD9DEbqhtw7v6RaDRX6Et+hvyiyloBVtC4yrTYR
X-Gm-Gg: ASbGncsHO4h3zs+dSGWqZ/qHH9TNIwZnAfMFAC+5W2HJKXsoBjiV8TlsWt7qGHZvHG2
 VhxubqDvH6od07CnmkZ6mh1TFdik3OXGPGYXR3tSQZdhuaCTmFucbgk1EFtzwQDh6YDeqYn4LBP
 /9NpvsdbYug5uqPH5T6oyE2M5Hs9OiVw+a2IyE5kIb99TUZW63MhjcsvJLm+mOP9l3UJxHEcHFs
 WDsQ1yXnJ6EfEIPCzdtYY0ctQz5GozK6T3chMY4OSOR47O6jLQg/XF0qtCNt5sm7qiP9pFmrFuU
 uWPUbuvQIq2OiySRRZmXFE19Z9UKN0QdlLxw58X3VmmK0hOt5jTE5hUhVG9esg==
X-Google-Smtp-Source: AGHT+IEyrDe8Cdf9g26TH4wCWMETQ0+XWu9RhDQiEyiZTUrrFG1lMyYXyT2WhVrPka++rXuTJgqTBw==
X-Received: by 2002:a17:90b:3e8e:b0:30e:54be:37cc with SMTP id
 98e67ed59e1d1-30e7d5a93a3mr21688031a91.23.1747745569700; 
 Tue, 20 May 2025 05:52:49 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:52:49 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 06/33] tcg/wasm32: Add add/sub/mul instructions
Date: Tue, 20 May 2025 21:51:08 +0900
Message-ID: <a29467e1232fa65417e0d2e4d9038737d8d31d30.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52c.google.com
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

Add, sub and mul operations are implemented using the corresponding
instructions in Wasm.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index e3a35c8415..e4204d3956 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -195,6 +195,18 @@ static void tcg_wasm_out_op_i64_xor(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x85);
 }
+static void tcg_wasm_out_op_i64_add(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x7c);
+}
+static void tcg_wasm_out_op_i64_sub(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x7d);
+}
+static void tcg_wasm_out_op_i64_mul(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x7e);
+}
 static void tcg_wasm_out_op_var(TCGContext *s, uint8_t instr, uint8_t i)
 {
     tcg_wasm_out8(s, instr);
@@ -229,6 +241,9 @@ static void tcg_wasm_out_op_global_set_r(TCGContext *s, TCGReg r0)
 tcg_wasm_out_i64_calc(and);
 tcg_wasm_out_i64_calc(or);
 tcg_wasm_out_i64_calc(xor);
+tcg_wasm_out_i64_calc(add);
+tcg_wasm_out_i64_calc(sub);
+tcg_wasm_out_i64_calc(mul);
 
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
@@ -632,6 +647,7 @@ static void tgen_add(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_add, a0, a1, a2);
+    tcg_wasm_out_i64_calc_add(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_add = {
@@ -810,6 +826,7 @@ static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_mul, a0, a1, a2);
+    tcg_wasm_out_i64_calc_mul(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_mul = {
@@ -1000,6 +1017,7 @@ static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_sub, a0, a1, a2);
+    tcg_wasm_out_i64_calc_sub(s, a0, a1, a2);
 }
 
 static const TCGOutOpSubtract outop_sub = {
-- 
2.43.0


