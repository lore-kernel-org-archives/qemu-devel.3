Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C46CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoQzQ-00051B-KD; Tue, 19 Aug 2025 14:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzP-00050d-0g; Tue, 19 Aug 2025 14:23:19 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzM-0003og-Ol; Tue, 19 Aug 2025 14:23:18 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2430c3684d1so1527375ad.0; 
 Tue, 19 Aug 2025 11:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627795; x=1756232595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJZUW5SkPZ1D/2azqNWBfnN/qyeeJFmopfU4EryG5yc=;
 b=WN8/aMAStpeP8aP/KIWb+2MYgvUYQZxmY67zrWfHnDJoQD5bSydS6k8xl8ZieRyBZV
 r2c7wEDvpiLlSby3es1hVicv4QsAEPnNuAA2PQQltcEXekJuT4ZzwlSMNMSvAgbQFpuI
 K41oFbQI4cjcI6VJTmcp8SlKpXfpUcrzbHTXA1Ip8ENZdjp6je96Zn4TChPhwpjhRtZJ
 6A38pVrm5itX1n9Cg+2xO/PZpvF8QULfH3VCvONTGvX9FwP8ke6VA9e9DfGjAWKwlRJ5
 ZtZkL+FvZt2awULUlt1suCNXg3ElD3O68ThdF60md98fY326Pn+mSvamC0ITkZyQQhqH
 h61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627795; x=1756232595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJZUW5SkPZ1D/2azqNWBfnN/qyeeJFmopfU4EryG5yc=;
 b=MdeZWINn7cqpXol8qRgLF2FCPEHo+DN0One+o7kleCz5SbbvHe7mYcGwERpSwti5nM
 j5MWc/efoTiML+yfnLYC/gWIhQl1Ila9BuFcRnjlSgNZdqamsl9fpwqsIlfZn2KAm1Pc
 GFPGgYn9szBtjbVsJJKY6LxeCc/OlLIYx4nTEB86+UDipo3BcbjiTf6vHJdJ9kWB6x9t
 fcgCCjFQGqkxE8rpfJvONDU5JI/OxxajxEjhftHQMV4FDhQEXwttVbzS0l8hDD/VZjhu
 7coLtzS0J/Z9DLieejKLA0fOXb/bmklocShw66rx1qQJbWTXpidoCZLV0E2hdxkzEOff
 JqcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2TCBWAVVNDkY3iJjHez06k4bTJQo90MIuzJ2DZgP5eoewjGxjSabQBgiWoq5H7MC9fHohaZWsJRDrGA==@nongnu.org,
 AJvYcCUwNZmIAoAYG1hFVdYRmm8UsroA9JISkrzaIgLSTmOXSvwnq78M6T9137JHbmEzeVUMBpLig1Nnrg==@nongnu.org
X-Gm-Message-State: AOJu0YzglsJaT18QflQFu4yvS7a/zJca2XYx/ekCBo4XQWop5jcQE+Cp
 1xQnEskOAWvFdkcxO9hBOA8rd56/NSiW++YUB07/xUungkv9U9s9MoC2/sQsjzjs
X-Gm-Gg: ASbGncvZwUyDo7QGKvhne5l6EPpqAJkztxgvxlPC5O3wi3mIuEK+N6jl+/V+ZCWZ1Vs
 /lNFYFs/DdtF4uKQK6hdhUxYf9N/fh6AuKq3i6Mir5GGcaphLoNMqjEHc6L9SUlYr2gBA74rwDS
 wBYojoMhMkDEQvXU6TmQLXSN3rR6RFnqfNKWAAzGrn4EchDMa3yaIURvN7oekd6hjsYlJlT2YG2
 ErM3RpiBxAwk520SoRIBsXkMvRIxzv2Kp4kJrs8Q4efZZAxWqyOnyI9NbuveQKyv/dy4TJ0bTqx
 aniNLkyCXRICGVm9yjauSqiUygiDaeH+ZhmtY+I7PXSdB+322TLVsLve/Z49kdhbFRMlWn4k443
 wB3bmge6FY57Tnbf2o4D4RQ==
X-Google-Smtp-Source: AGHT+IE1DXsAlifv+0HeHVzjdFhK/fe4e28HAlK/5IlGDcES7xxNfGPbu3ymi3SH6UDYdH1/ttrtRg==
X-Received: by 2002:a17:902:da92:b0:243:afef:cd3a with SMTP id
 d9443c01a7336-245e09d0bfcmr49799055ad.15.1755627794556; 
 Tue, 19 Aug 2025 11:23:14 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:23:13 -0700 (PDT)
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
Subject: [PATCH 07/35] tcg/wasm: Set TCG_TARGET_REG_BITS to 64
Date: Wed, 20 Aug 2025 03:21:36 +0900
Message-ID: <13f715223405247ebedb340123cf8019d0913dd9.1755623521.git.ktokunaga.mail@gmail.com>
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

The Wasm backend targets wasm64 as the host.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target-reg-bits.h |  9 ++---
 tcg/wasm/tcg-target.c.inc      | 69 +++-------------------------------
 2 files changed, 8 insertions(+), 70 deletions(-)

diff --git a/tcg/wasm/tcg-target-reg-bits.h b/tcg/wasm/tcg-target-reg-bits.h
index dcb1a203f8..9b0b7c6c3b 100644
--- a/tcg/wasm/tcg-target-reg-bits.h
+++ b/tcg/wasm/tcg-target-reg-bits.h
@@ -7,12 +7,9 @@
 #ifndef TCG_TARGET_REG_BITS_H
 #define TCG_TARGET_REG_BITS_H
 
-#if UINTPTR_MAX == UINT32_MAX
-# define TCG_TARGET_REG_BITS 32
-#elif UINTPTR_MAX == UINT64_MAX
-# define TCG_TARGET_REG_BITS 64
-#else
-# error Unknown pointer size for tci target
+#if UINTPTR_MAX != UINT64_MAX
+# error Unsupported pointer size for TCG target
 #endif
+# define TCG_TARGET_REG_BITS 64
 
 #endif
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 33b81f1fe2..efec95e74f 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -28,15 +28,9 @@
 /* Used for function call generation. */
 #define TCG_TARGET_CALL_STACK_OFFSET    0
 #define TCG_TARGET_STACK_ALIGN          8
-#if TCG_TARGET_REG_BITS == 32
-# define TCG_TARGET_CALL_ARG_I32        TCG_CALL_ARG_EVEN
-# define TCG_TARGET_CALL_ARG_I64        TCG_CALL_ARG_EVEN
-# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_EVEN
-#else
-# define TCG_TARGET_CALL_ARG_I32        TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_ARG_I64        TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_NORMAL
-#endif
+#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
 static TCGConstraintSetIndex
@@ -1050,39 +1044,6 @@ static const TCGOutOpMovcond outop_movcond = {
     .out = tgen_movcond,
 };
 
-static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
-                         TCGArg bl, bool const_bl,
-                         TCGArg bh, bool const_bh, TCGLabel *l)
-{
-    tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, TCG_REG_TMP,
-                      al, ah, bl, bh, cond);
-    tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, l);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpBrcond2 outop_brcond2 = {
-    .base.static_constraint = C_O0_I4(r, r, r, r),
-    .out = tgen_brcond2,
-};
-
-static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
-                          TCGReg al, TCGReg ah,
-                          TCGArg bl, bool const_bl,
-                          TCGArg bh, bool const_bh)
-{
-    tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, ret, al, ah, bl, bh, cond);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpSetcond2 outop_setcond2 = {
-    .base.static_constraint = C_O1_I4(r, r, r, r, r),
-    .out = tgen_setcond2,
-};
-
 static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     tcg_out_op_v(s, INDEX_op_mb);
@@ -1199,18 +1160,8 @@ static const TCGOutOpQemuLdSt outop_qemu_ld = {
     .out = tgen_qemu_ld,
 };
 
-static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
-                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
-{
-    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
-    tcg_out_op_rrrr(s, INDEX_op_qemu_ld2, datalo, datahi, addr, TCG_REG_TMP);
-}
-
 static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
-    .base.static_constraint =
-        TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O2_I1(r, r, r),
-    .out =
-        TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_ld2,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
@@ -1224,18 +1175,8 @@ static const TCGOutOpQemuLdSt outop_qemu_st = {
     .out = tgen_qemu_st,
 };
 
-static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
-                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
-{
-    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
-    tcg_out_op_rrrr(s, INDEX_op_qemu_st2, datalo, datahi, addr, TCG_REG_TMP);
-}
-
 static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
-    .base.static_constraint =
-        TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O0_I3(r, r, r),
-    .out =
-        TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_st2,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
-- 
2.43.0


