Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF17CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR1s-0002PF-CA; Tue, 19 Aug 2025 14:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1F-0001ax-N7; Tue, 19 Aug 2025 14:25:15 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1C-0004NT-LM; Tue, 19 Aug 2025 14:25:12 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b4746fd4793so2094204a12.1; 
 Tue, 19 Aug 2025 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627907; x=1756232707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38R8q6vawta6VEEn3UhBfaFAfRNcb+fDXcq44g+j6XI=;
 b=ZBvC6rsVgn0EIU70i4l0l2O5X5onSVqxk1umeYVX1Xr1QOjrLEUJYY4wXKpbGudgF5
 qz3B1eGJu/NqeCwTrGvb4Juet0dK+MVloq0U1Cyi3wjtQ4Wgsz1fUOz0XigazjGkU2tL
 GeMiNfb4u6a4fSCRCzASgpQUNpifHxSX+GmXodPMZnUkFWG6HusKNE7NCwuYr7N8ODIv
 z+kYdbQw1k/SesycRC7TxxsikbPHrdGLPLH+zyl/TCM14L+/pHnifRvGVhJ9+FNbAY9n
 3qe6+rzt4ZoBnLBo2lR6U+8Q29nOCXqLYF/5PfM12FuaeEv/mG7KGHL0blOH76QilaZd
 mC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627907; x=1756232707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38R8q6vawta6VEEn3UhBfaFAfRNcb+fDXcq44g+j6XI=;
 b=fK5S+I7+vyYenVn43TLXCRjPJuNfQtR/8WZxX/2Avs+x6EOQNC4eQ8zFjDdYETqrr6
 4ecxqt+Jx7a1HNi2knXI7/CSZA8yGzI/9ozzIWxUI1yQbh10YPkMU0UpmJwrdr3aEg7r
 p/K41B8V9X339qrIfbApKDDx4pigMswZNY/2zaFQKWthA+iYChQFtPncMjNj/eKts7SS
 rjVFvu13EXdt9rhS3CLDMDAiQj21vtRCUqs0NhFQL9OuZdzzcR5MwVneue1NRA/qOaQL
 jtvc6pEe/SjH2hK+V3QIYrrzTPLLJ6tw3RnsKA8cXWJEb5RCciMVT5ItnDos1NyJF/z0
 9VKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTZe2Dc9xzq0EA+k84F4wSNnIXlcQiZ6rzdOnvYNUIlUmkumbDgBxWYxQcE89ja1A2C0DBTBlshg==@nongnu.org,
 AJvYcCUn7VgG/2aHn94zVI9KjdF3YLYLfETImPrxuUS/BvJ2HCVWwp91mqIM6Q6aQOme48je7vr1LFfrTns9aQ==@nongnu.org
X-Gm-Message-State: AOJu0YzmxIyYZ1SNN6yJaw/fW05gTmROyrQTvDi/WiPRYeNVMudimmzO
 kOb9+39ZMuqPb/1oOAZqmgUlNBQ/qxrZS+ADJRzMVun5WCyG1opsQVVazQjwVg==
X-Gm-Gg: ASbGnctAMYU6LDRZ3ng+6hnPepjtGfTWrOMO7JUvp4pRGruyylWoON/4WvYd47CmdCs
 WON+Vtu8NMghJ0KrtSgA9s5T/6u0N3wIhm08UhMIHhwi4bg1tbdaysN0tdCnUxl9MnOdknHv208
 hScY5WgbqjUYYUIfjeIr9dVja3LxhKp7VEjaO9mlEj5Oxj7d8r7NqU7v9Y5JmfGN6jguK2AFuZe
 h41oICV6aC/wIh62YGM3QbJ12AFllc3bIMtpBB5JvUE78SBCSpwBSYihZKbRJZLzdezS9BuAKXe
 OVnrohM36c8/EsSsTrp4OyDp/6CTE6dvr2bpoTBlLruOhuAq3WtgJiGQZrHXh92DxbujFyVu5VV
 AXtyRbHUzlHMWeg7njXNl+tGN1gvm8Yuj
X-Google-Smtp-Source: AGHT+IEtRh5Ys+LvLgNyJJXQQ1tJucdVdrOgQY9Sg8hA3J1OXBf2j4KYbPYpxOJiDhkE0ZXTco6CsQ==
X-Received: by 2002:a17:903:1984:b0:243:47:f61b with SMTP id
 d9443c01a7336-245e04b937dmr44393485ad.45.1755627907160; 
 Tue, 19 Aug 2025 11:25:07 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:25:06 -0700 (PDT)
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
Subject: [PATCH 27/35] tcg/wasm: Mark unimplemented instructions as
 C_NotImplemented
Date: Wed, 20 Aug 2025 03:21:56 +0900
Message-ID: <26484aa71afe4dc97ec21115b8a6063ecef0d7b5.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x535.google.com
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

This commit explicitly marks functions which aren't implemented in the Wasm
backend as C_NotImplemented.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 107 ++++----------------------------------
 1 file changed, 10 insertions(+), 97 deletions(-)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index db92463941..6b8df4e9d7 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -1430,19 +1430,6 @@ static void tcg_out_op_rrrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
     tcg_out32(s, insn);
 }
 
-static void tcg_out_op_rrrr(TCGContext *s, TCGOpcode op,
-                            TCGReg r0, TCGReg r1, TCGReg r2, TCGReg r3)
-{
-    tcg_insn_unit insn = 0;
-
-    insn = deposit32(insn, 0, 8, op);
-    insn = deposit32(insn, 8, 4, r0);
-    insn = deposit32(insn, 12, 4, r1);
-    insn = deposit32(insn, 16, 4, r2);
-    insn = deposit32(insn, 20, 4, r3);
-    tcg_out32(s, insn);
-}
-
 static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
                               TCGReg r0, TCGReg r1, TCGReg r2,
                               TCGReg r3, TCGReg r4, TCGCond c5)
@@ -1699,50 +1686,21 @@ static const TCGOutOpBinary outop_add = {
     .out_rrr = tgen_add,
 };
 
-static TCGConstraintSetIndex cset_addsubcarry(TCGType type, unsigned flags)
-{
-    return type == TCG_TYPE_REG ? C_O1_I2(r, r, r) : C_NotImplemented;
-}
-
-static void tgen_addco(TCGContext *s, TCGType type,
-                       TCGReg a0, TCGReg a1, TCGReg a2)
-{
-    tcg_out_op_rrr(s, INDEX_op_addco, a0, a1, a2);
-}
-
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_Dynamic,
-    .base.dynamic_constraint = cset_addsubcarry,
-    .out_rrr = tgen_addco,
+    .base.static_constraint = C_NotImplemented,
 };
 
-static void tgen_addci(TCGContext *s, TCGType type,
-                       TCGReg a0, TCGReg a1, TCGReg a2)
-{
-    tcg_out_op_rrr(s, INDEX_op_addci, a0, a1, a2);
-}
-
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_Dynamic,
-    .base.dynamic_constraint = cset_addsubcarry,
-    .out_rrr = tgen_addci,
+    .base.static_constraint = C_NotImplemented,
 };
 
-static void tgen_addcio(TCGContext *s, TCGType type,
-                        TCGReg a0, TCGReg a1, TCGReg a2)
-{
-    tcg_out_op_rrr(s, INDEX_op_addcio, a0, a1, a2);
-}
-
 static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_Dynamic,
-    .base.dynamic_constraint = cset_addsubcarry,
-    .out_rrr = tgen_addcio,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    tcg_out_op_v(s, INDEX_op_tci_setcarry);
+    g_assert_not_reached();
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -1886,37 +1844,16 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
-static TCGConstraintSetIndex cset_mul2(TCGType type, unsigned flags)
-{
-    return type == TCG_TYPE_REG ? C_O2_I2(r, r, r, r) : C_NotImplemented;
-}
-
-static void tgen_muls2(TCGContext *s, TCGType type,
-                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
-{
-    tcg_out_op_rrrr(s, INDEX_op_muls2, a0, a1, a2, a3);
-}
-
 static const TCGOutOpMul2 outop_muls2 = {
-    .base.static_constraint = C_Dynamic,
-    .base.dynamic_constraint = cset_mul2,
-    .out_rrrr = tgen_muls2,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static const TCGOutOpBinary outop_mulsh = {
     .base.static_constraint = C_NotImplemented,
 };
 
-static void tgen_mulu2(TCGContext *s, TCGType type,
-                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
-{
-    tcg_out_op_rrrr(s, INDEX_op_mulu2, a0, a1, a2, a3);
-}
-
 static const TCGOutOpMul2 outop_mulu2 = {
-    .base.static_constraint = C_Dynamic,
-    .base.dynamic_constraint = cset_mul2,
-    .out_rrrr = tgen_mulu2,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static const TCGOutOpBinary outop_muluh = {
@@ -2091,45 +2028,21 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
-static void tgen_subbo(TCGContext *s, TCGType type,
-                       TCGReg a0, TCGReg a1, TCGReg a2)
-{
-    tcg_out_op_rrr(s, INDEX_op_subbo, a0, a1, a2);
-}
-
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_Dynamic,
-    .base.dynamic_constraint = cset_addsubcarry,
-    .out_rrr = tgen_subbo,
+    .base.static_constraint = C_NotImplemented,
 };
 
-static void tgen_subbi(TCGContext *s, TCGType type,
-                       TCGReg a0, TCGReg a1, TCGReg a2)
-{
-    tcg_out_op_rrr(s, INDEX_op_subbi, a0, a1, a2);
-}
-
 static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_Dynamic,
-    .base.dynamic_constraint = cset_addsubcarry,
-    .out_rrr = tgen_subbi,
+    .base.static_constraint = C_NotImplemented,
 };
 
-static void tgen_subbio(TCGContext *s, TCGType type,
-                        TCGReg a0, TCGReg a1, TCGReg a2)
-{
-    tcg_out_op_rrr(s, INDEX_op_subbio, a0, a1, a2);
-}
-
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_Dynamic,
-    .base.dynamic_constraint = cset_addsubcarry,
-    .out_rrr = tgen_subbio,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    tcg_out_op_v(s, INDEX_op_tci_setcarry);  /* borrow == carry */
+    g_assert_not_reached();
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


