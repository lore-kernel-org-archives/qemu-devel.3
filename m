Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A438CA0EFB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoQzg-00058h-53; Tue, 19 Aug 2025 14:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQza-00057H-OH; Tue, 19 Aug 2025 14:23:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzX-0003pk-W3; Tue, 19 Aug 2025 14:23:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2445827be70so62677015ad.3; 
 Tue, 19 Aug 2025 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627806; x=1756232606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oFY77tRx6dazr6YCQwTL9wWp6iPtE6SNv60RdyQaWg=;
 b=mVLcYAjTmHkdNDPg5yv/XEw2mMK10I3i8cJmS58uwzJVW1eJSAf3ea0qwTugXrdSqd
 92BwGzYmiEYodPn/9okflZvt3N2pHKQAE4rmcVreKdH+LU3eArpDJtN5vF6y5l9V7rYh
 Ia3KdC3JUQoig5A323fcspjYzA28LrwVd2R81i+ZuMug7a1IiwFgQxq+KJ8zVKOQ3xyT
 +yavxlYbNR2sTcOnQUkixvolQlV5Wg1KFA81C30q8FWnxm2EF2Ki31HT/p1J7GEqoajv
 SV6ef+uo0eAqfVtXqXDxGrAf+w0OpP4ay1KYZvSCjoirGhg+C9fEyVJoLg9QETs4SFt5
 JKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627806; x=1756232606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oFY77tRx6dazr6YCQwTL9wWp6iPtE6SNv60RdyQaWg=;
 b=ZpDR9S6xqCiY0SGi+NQqZG1WteRB6KB2y4iZKCu3BP23zWKBSHZ748b6qtTbab7i4B
 xlwC9HMD36/PDt+OnY2FUCFblrZMToecxZ9IOHTAG2PT9Ebqn08hTzprPQ+LcVDCd+vE
 dOFSPYf3Tm74WBqidwpPPUaSzwztdOLz667nb+C34UeAFx/Jr9G7v2KfCVIoctwqP2RU
 XXD5O5D/FtkIXuOWIGf2jHizXKuoh8c8yRJytVTi1+6YwDTd9kOJeiJAWLvXsu751PqX
 RC3blyLRLvS183YN3rQK5Ski8j98tQpacEVryey5fHfmQSr+1DiNSpOT8qekXL4UUbFx
 k/FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVanMzxvPjbGIm9PjodaSdNeQ2Ui1ebntsQhZ430Zw8nMqdzwwL/XIwzbQrhMkHo04ynrnkXINZdjuPaw==@nongnu.org,
 AJvYcCVmy7aZmq9e8WzxdrBuaXIDYFs9TjHFU/2BmD94rPWFEPJCq8zGFNuwpreTL75KUBfRiAeZyfzkzg==@nongnu.org
X-Gm-Message-State: AOJu0YzDA/2/P9tzt051/LnqyMK4ZitXjFVYmEMKLjh5kWE1qFKOYazZ
 7FwpAHc8STuBw4qapl4jjFYva34KuD95bsDRdO1M18uM1VI3XQWioY8f2uFcMJTB
X-Gm-Gg: ASbGncsoud1uazpsgnvO9uMIzxSCLl/SAkB60mlt617I5ufNfoTkFFzaYEmM2Ytksan
 enwttVTNPZH9qzLG9rJcGP+lkZX1ax8199BEpZk+4oqqZ2Tb8hvwa/Vzii6NspDxJGq86p5BTcC
 QQqdCiTafnmpjlNf/q/zFUYXVQFH7aOOjQzOtwrClrng9J1lwobsGyE0nVS09ytYEJTiRNOuKMn
 IysOXd1UPCj31B1VjgUThQC6j/hldgEDfE4RnsT+m5VyUrdOa3Nr90M+Afn65n4lhZ4zDyS3902
 iRagUl7ClMZWS4zNhK6IXjRJYRE7WH6tnVpC0PSDCRnP87TwnbHe4Kugl1Vk3PHVikpSEcBMTVo
 a6XfzJpC22mY5Hy/Q25uAJyZfKVsRFrKnWfSNkPeNg1w=
X-Google-Smtp-Source: AGHT+IGKLgmqjAJmEQUg6Jnid/CSW2HNdVpbvUo+ag9zk7QdNfQNMtPvlVnA7R+RaqiT5cbw9TmyPQ==
X-Received: by 2002:a17:903:196b:b0:240:640a:b2e4 with SMTP id
 d9443c01a7336-245e04df64cmr44629585ad.49.1755627805827; 
 Tue, 19 Aug 2025 11:23:25 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:23:25 -0700 (PDT)
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
Subject: [PATCH 09/35] tcg/wasm: Set TCG_TARGET_INSN_UNIT_SIZE to 1
Date: Wed, 20 Aug 2025 03:21:38 +0900
Message-ID: <37c473f501f89041fa180e652bcd8b12dbe8b4db.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62b.google.com
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

WebAssembly instructions vary in size, including single-byte
instructions. This commit sets TCG_TARGET_INSN_UNIT_SIZE to 1 and
updates the TCI fork to use "tcg_insn_unit_tci" (a uint32_t) for
4-byte operations.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 38 +++++++++++++++++++++-----------------
 tcg/wasm/tcg-target.h     |  2 +-
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index efec95e74f..f1c329eabd 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -33,6 +33,8 @@
 #define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
+typedef uint32_t tcg_insn_unit_tci;
+
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
@@ -90,16 +92,18 @@ static const char *const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 };
 #endif
 
-static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
+static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
+    tcg_insn_unit_tci *code_ptr = (tcg_insn_unit_tci *)code_ptr_i;
     intptr_t diff = value - (intptr_t)(code_ptr + 1);
 
     tcg_debug_assert(addend == 0);
     tcg_debug_assert(type == 20);
 
     if (diff == sextract32(diff, 0, type)) {
-        tcg_patch32(code_ptr, deposit32(*code_ptr, 32 - type, type, diff));
+        tcg_patch32((tcg_insn_unit *)code_ptr,
+                    deposit32(*code_ptr, 32 - type, type, diff));
         return true;
     }
     return false;
@@ -116,7 +120,7 @@ static void stack_bounds_check(TCGReg base, intptr_t offset)
 
 static void tcg_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_out_reloc(s, s->code_ptr, 20, l0, 0);
     insn = deposit32(insn, 0, 8, op);
@@ -125,14 +129,14 @@ static void tcg_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
 
 static void tcg_out_op_p(TCGContext *s, TCGOpcode op, void *p0)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
     intptr_t diff;
 
     /* Special case for exit_tb: map null -> 0. */
     if (p0 == NULL) {
         diff = 0;
     } else {
-        diff = p0 - (void *)(s->code_ptr + 1);
+        diff = p0 - (void *)(s->code_ptr + 4);
         tcg_debug_assert(diff != 0);
         if (diff != sextract32(diff, 0, 20)) {
             tcg_raise_tb_overflow(s);
@@ -145,7 +149,7 @@ static void tcg_out_op_p(TCGContext *s, TCGOpcode op, void *p0)
 
 static void tcg_out_op_r(TCGContext *s, TCGOpcode op, TCGReg r0)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     insn = deposit32(insn, 0, 8, op);
     insn = deposit32(insn, 8, 4, r0);
@@ -159,7 +163,7 @@ static void tcg_out_op_v(TCGContext *s, TCGOpcode op)
 
 static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_debug_assert(i1 == sextract32(i1, 0, 20));
     insn = deposit32(insn, 0, 8, op);
@@ -170,7 +174,7 @@ static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 
 static void tcg_out_op_rl(TCGContext *s, TCGOpcode op, TCGReg r0, TCGLabel *l1)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_out_reloc(s, s->code_ptr, 20, l1, 0);
     insn = deposit32(insn, 0, 8, op);
@@ -180,7 +184,7 @@ static void tcg_out_op_rl(TCGContext *s, TCGOpcode op, TCGReg r0, TCGLabel *l1)
 
 static void tcg_out_op_rr(TCGContext *s, TCGOpcode op, TCGReg r0, TCGReg r1)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     insn = deposit32(insn, 0, 8, op);
     insn = deposit32(insn, 8, 4, r0);
@@ -191,7 +195,7 @@ static void tcg_out_op_rr(TCGContext *s, TCGOpcode op, TCGReg r0, TCGReg r1)
 static void tcg_out_op_rrm(TCGContext *s, TCGOpcode op,
                            TCGReg r0, TCGReg r1, TCGArg m2)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_debug_assert(m2 == extract32(m2, 0, 16));
     insn = deposit32(insn, 0, 8, op);
@@ -204,7 +208,7 @@ static void tcg_out_op_rrm(TCGContext *s, TCGOpcode op,
 static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
                            TCGReg r0, TCGReg r1, TCGReg r2)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     insn = deposit32(insn, 0, 8, op);
     insn = deposit32(insn, 8, 4, r0);
@@ -216,7 +220,7 @@ static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
 static void tcg_out_op_rrs(TCGContext *s, TCGOpcode op,
                            TCGReg r0, TCGReg r1, intptr_t i2)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_debug_assert(i2 == sextract32(i2, 0, 16));
     insn = deposit32(insn, 0, 8, op);
@@ -229,7 +233,7 @@ static void tcg_out_op_rrs(TCGContext *s, TCGOpcode op,
 static void tcg_out_op_rrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
                             TCGReg r1, uint8_t b2, uint8_t b3)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_debug_assert(b2 == extract32(b2, 0, 6));
     tcg_debug_assert(b3 == extract32(b3, 0, 6));
@@ -244,7 +248,7 @@ static void tcg_out_op_rrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
 static void tcg_out_op_rrrc(TCGContext *s, TCGOpcode op,
                             TCGReg r0, TCGReg r1, TCGReg r2, TCGCond c3)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     insn = deposit32(insn, 0, 8, op);
     insn = deposit32(insn, 8, 4, r0);
@@ -257,7 +261,7 @@ static void tcg_out_op_rrrc(TCGContext *s, TCGOpcode op,
 static void tcg_out_op_rrrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
                              TCGReg r1, TCGReg r2, uint8_t b3, uint8_t b4)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     tcg_debug_assert(b3 == extract32(b3, 0, 6));
     tcg_debug_assert(b4 == extract32(b4, 0, 6));
@@ -287,7 +291,7 @@ static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
                               TCGReg r0, TCGReg r1, TCGReg r2,
                               TCGReg r3, TCGReg r4, TCGCond c5)
 {
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
 
     insn = deposit32(insn, 0, 8, op);
     insn = deposit32(insn, 8, 4, r0);
@@ -446,7 +450,7 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *func,
                          const TCGHelperInfo *info)
 {
     ffi_cif *cif = info->cif;
-    tcg_insn_unit insn = 0;
+    tcg_insn_unit_tci insn = 0;
     uint8_t which;
 
     if (cif->rtype == &ffi_type_void) {
diff --git a/tcg/wasm/tcg-target.h b/tcg/wasm/tcg-target.h
index 00befa2fcc..b3d540198b 100644
--- a/tcg/wasm/tcg-target.h
+++ b/tcg/wasm/tcg-target.h
@@ -42,7 +42,7 @@
 #define TCG_TARGET_H
 
 #define TCG_TARGET_INTERPRETER 1
-#define TCG_TARGET_INSN_UNIT_SIZE 4
+#define TCG_TARGET_INSN_UNIT_SIZE 1
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
 /* Number of registers available. */
-- 
2.43.0


