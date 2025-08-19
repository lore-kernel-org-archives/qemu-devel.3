Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2D1CA0EF7
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR0g-0007I8-TF; Tue, 19 Aug 2025 14:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0V-0006zA-FL; Tue, 19 Aug 2025 14:24:29 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0T-0003wm-JJ; Tue, 19 Aug 2025 14:24:27 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b471740e488so5268347a12.1; 
 Tue, 19 Aug 2025 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627862; x=1756232662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6GK2cxJ5WGy5SduMQnUpkla/rJ/wahqug23mpIUzYg=;
 b=F4pzXVfLtPXToOgSxi6+YKCgTObB1gJEGZh1iewMxk4G6jyUQV3m0pOXpn+El0Yffz
 TgQk5IIvI0cssC+Vtj9spoJA5aRNo6q7tSHdTAgG0tqAYSal6hOatHBYedaOp038Z1e9
 pVLCktaEyg3gKBNofiay0qpLo2NNG+qsQXzN3kPx+WESwDlh/WQPzvpsYYGyfYfi0C2D
 XuVuMQs5YXq8saKkim63pDPU5wXQdIXljpWE601Mv1T+Rqv0841agaye05fv4OloSQ4Q
 Sp5xGLpkZii6hmI6z9/kGkmSu1rK83HBEIcDpLv2VCkYPx4Nn9Fvzsw4zCL7e3eUdp/2
 pQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627862; x=1756232662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6GK2cxJ5WGy5SduMQnUpkla/rJ/wahqug23mpIUzYg=;
 b=pwiTCoOmJm6VLl2F9vwgc9F4dNspLsptBERG97uCQJLy2TYZsm86uyDrALjuDW3Hob
 ZBEmK3k8TH1+G34KGzRAR9CJ/YikNs0UpU8qCRMrYlqqKqe8cGhULNPUJfWg1rhj2LnP
 f0Jlt1qVSPrPG9mAmgAHIzz0pEtO1F2KtKKVEcJV0mv7fvGWX8vwcP2GFCsGU3EDWTt1
 n0rR82t1cMR1psJxIhGgRZx5UvNm0awSUb4u+nignZ514kjqdZnY2MB+Ye9woHcGU2Zf
 hKXHgENHgFXQS17U0MKyBsvG8l0IKhupH/mwc6OrU2fRM+uMUb81iVu5KlvMtDSlg+ZQ
 FsvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4hF3/tWu94HK37J++HLzWfKMFwWFtQvYzN6cnYG1oVWUjcyiHLyFTV+TGMkSW1OwY2vDnxDfuL6LJFA==@nongnu.org,
 AJvYcCX9UrzEXycbMut9AeLneltAtyN7AkBrvkkf5AHKU3VLs4kV6jR4JEW6DZWmh1a9aYGS4OXm0OBMiw==@nongnu.org
X-Gm-Message-State: AOJu0YzFqTiJn1/7sgf1gm8wYUa/dLnNm0v+pkAz0fcpB1o5S2RLdDcw
 DWz+lAnztSED2GXqIdBFaZZ4C6aRy7ootZ0EevrJFp0tXmqron+IgYW6nXVjIV1w
X-Gm-Gg: ASbGncsv4PLVEHnp1+6rijqMgx9S8qmBa1aJVFcBvtEGHGRsjYBB44CtBe6ulGAxPdQ
 qSw9q9f26pHr+qx1SLYsxXGHhPRj0WJxECO4yoZbPJFyutZphNBqybbwhPWg3GQ+qbxAs4uoNT/
 7Ku9YhSHgEN6hRfeh1n8iOw1aMAWDMjbUiLGDjpd0NW09mqWdaitsm032G+RGY+njeToVZIcBAO
 W7xhUZIwHgW82QSSvjcpZk1K2fbm+5mrIdwjOf7YMI9/xBGnYYv0oyjTzOs9BVGCw1V3eRzjgE0
 HJ+As1g7zoCwiYz0qY0kWGmvUCQgh+57lOU+VCGlLZseTLDG4bpUratk6hjTp9k+Y9Pixzd5MU8
 UvR6he02FGy2CqvqEmgQ3odakLcV9HA2e
X-Google-Smtp-Source: AGHT+IHhFMDhPArlNHUwVnNgnDJMV6cpx6htu16N7Wai7AkC8baHBHwa/9yDMsbh2IgWwF5CV/uzMA==
X-Received: by 2002:a17:903:244b:b0:238:120:134a with SMTP id
 d9443c01a7336-245e02d751dmr52105605ad.22.1755627861991; 
 Tue, 19 Aug 2025 11:24:21 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:24:21 -0700 (PDT)
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
Subject: [PATCH 19/35] tcg/wasm: Add rem/div instructions
Date: Wed, 20 Aug 2025 03:21:48 +0900
Message-ID: <403bca28fa44371d890187cf5b5c0eb59793e812.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52f.google.com
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

This commit implements rem and div operations using Wasm's rem and div
instructions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 7f4ec250ff..01ef7d32f3 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -169,6 +169,10 @@ typedef enum {
     OPC_I64_GE_U = 0x5a,
 
     OPC_I32_ADD = 0x6a,
+    OPC_I32_DIV_S = 0x6d,
+    OPC_I32_DIV_U = 0x6e,
+    OPC_I32_REM_S = 0x6f,
+    OPC_I32_REM_U = 0x70,
     OPC_I32_AND = 0x71,
     OPC_I32_OR = 0x72,
     OPC_I32_SHL = 0x74,
@@ -179,6 +183,10 @@ typedef enum {
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
@@ -1223,6 +1231,7 @@ static void tgen_divs(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_divs32
                      : INDEX_op_divs);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_DIV_S, OPC_I64_DIV_S, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_divs = {
@@ -1241,6 +1250,7 @@ static void tgen_divu(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_divu32
                      : INDEX_op_divu);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_DIV_U, OPC_I64_DIV_U, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_divu = {
@@ -1377,6 +1387,7 @@ static void tgen_rems(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_rems32
                      : INDEX_op_rems);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_REM_S, OPC_I64_REM_S, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_rems = {
@@ -1391,6 +1402,7 @@ static void tgen_remu(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_remu32
                      : INDEX_op_remu);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_REM_U, OPC_I64_REM_U, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_remu = {
-- 
2.43.0


