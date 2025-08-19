Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF25CA0EF5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoQzt-0005To-OD; Tue, 19 Aug 2025 14:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzm-0005Jm-3O; Tue, 19 Aug 2025 14:23:43 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzi-0003r4-WF; Tue, 19 Aug 2025 14:23:41 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-244580523a0so50335025ad.1; 
 Tue, 19 Aug 2025 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627817; x=1756232617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwwpP8Qm6yRdkuHPQNpOEFmILh0DyGgQsAD0yWxqZSw=;
 b=L9oHCiibe1LRZIMjGYtigaA9rLQELAclSy7AYAAwoIIs8NFw8YmruwWqQ9tTv1JMLP
 aKQkin7X+IrJ6xoiFRbgpw+dRcqTURJ8sYU+GdW2wuxh2E0vWXAbQC8guozIJCtX4hXI
 fBWBLLYFA2Dpl+g+a/FB0XdHgdZP4hVWztmAYGuIPdH21t6zuYxiAHxJkXJr+Z1gMeSM
 g07Ho0cJtcHqbxM2n9H+7/BKsweK2g9OP3eOcIqNL6O6qBsVYowcFcbllQO7Ubn5tHqS
 1xMqt6dqtVMZPUeuXvzRxm9dXIkyIxxlkjmIXC8vRahEeh82FFE8eyeOx7Fq5RrtwZpS
 /G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627817; x=1756232617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwwpP8Qm6yRdkuHPQNpOEFmILh0DyGgQsAD0yWxqZSw=;
 b=lSTSIWNjuHK6YWKbsPi1lsCCq3fPkXPHeP5HmFdr4yFtIvH8sH3ijjS+ESt90gMDm2
 Djti+8ualbRHMirZZXJm/gsKpCd13p29K2fkyOv9mqo73nmjtjWkvhONNRhzQdq4kD3F
 sh6abrMzP9/oDNKdZQ/smh8DcSqlEc/ccDQEOYXA/k8C07zBXzjVlY4WVCkGHOL70qnN
 jwfPy1WLhGUhH+uJOrMp4nqgZ/E6+mKAhCg1U7Qspc5KYInneKPpoChESs5+qwHtOKc/
 rSNtgPQDycvDwOdbupscYa8pX8ryAiZZbofHIqappReLnxfcG/fbh1SxhrUnKGjnxFD9
 0iUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK2U+fBbwWkrBRvR78hK4ljyydN9BhpHW8cIV8GgS5Qi7k3616JU97HtSuOHS+Dhe4PqShFF4KCQ==@nongnu.org,
 AJvYcCWdk6rqGs7CtuiYDmGVUhIpDexHZQIcBgqncyuK9kzBCAdWv2AfsW9WfLvqJDWmCVqcebiqukI6hXJPfA==@nongnu.org
X-Gm-Message-State: AOJu0Ywu3+GoLDKyXJhEMdl5/5+Z+FySnz9dZAayTZ88FfXcJ6Z2SaNA
 /FKFgb+46yZ0CRRXChCRPh2Ft1oBiqAGjxQhkyF6mnjglimT3Oc3aIrX95YExUHN
X-Gm-Gg: ASbGncuIy7gNxPRSZT+eblXRO7RiBXWWpYRHLDS4U8pPu1RCIWqH0WteojD2iCC3qLK
 OEnxOUwpFDsYrfONhrWM4G7daYFaC1JzI15k6MXA1IDMhhLpGL65YXVHSWuy49FIUadpf9urm3H
 8kgE77EklvuOtU1PmpWtfM8coqI0TsPKIRvWglU/FElCk5+dkOL4Lfi90c0lZLwe5ckSfd4KxMc
 kbW0sutDFrc3ne4eYa84qr9CvZIRLiwvLq+5i/Q3s9qijmMruM3/As0fWH9zaLyfcYxQ05ZQqtP
 RSIn7xHSCQ6WqaZ18ZavbRBGolIeBllJl/3QgZnUt/YeRrIFYj1SG3HX4TMztmoopgU5+Bo9MBa
 0VFIX/BOQ2ju6N2vWCdzSwgRsH1jM6P8k
X-Google-Smtp-Source: AGHT+IG037rj1DjmMOxlhC8+jtmYSnV8dQpyxDZN9Hkh7deiTmKhgUFXJ8d8hTtaZsexdVYt8Sj01g==
X-Received: by 2002:a17:902:ce0b:b0:23d:d0e7:754b with SMTP id
 d9443c01a7336-245e04919bfmr42930885ad.18.1755627816944; 
 Tue, 19 Aug 2025 11:23:36 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:23:36 -0700 (PDT)
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
Subject: [PATCH 11/35] tcg/wasm: Add add/sub/mul instructions
Date: Wed, 20 Aug 2025 03:21:40 +0900
Message-ID: <b02d10668c683fc541c563be03b4e9bfc8bc5ff0.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
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

Add, sub and mul operations are implemented using the corresponding
instructions in Wasm.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 8f7ead5e69..e1b10c57b0 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -120,6 +120,9 @@ typedef enum {
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
 
+    OPC_I64_ADD = 0x7c,
+    OPC_I64_SUB = 0x7d,
+    OPC_I64_MUL = 0x7e,
     OPC_I64_AND = 0x83,
     OPC_I64_OR = 0x84,
     OPC_I64_XOR = 0x85,
@@ -599,6 +602,7 @@ static void tgen_add(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_add, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_ADD, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_add = {
@@ -777,6 +781,7 @@ static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_mul, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_MUL, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_mul = {
@@ -967,6 +972,7 @@ static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_sub, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_SUB, a0, a1, a2);
 }
 
 static const TCGOutOpSubtract outop_sub = {
-- 
2.43.0


