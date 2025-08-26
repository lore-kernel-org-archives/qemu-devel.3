Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFB4CA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwHt-0004Rx-D3; Tue, 26 Aug 2025 12:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHq-0004Qe-OJ; Tue, 26 Aug 2025 12:12:42 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHo-00080L-6F; Tue, 26 Aug 2025 12:12:42 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b47174aec0eso3797952a12.2; 
 Tue, 26 Aug 2025 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224757; x=1756829557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZULQzqlKElES3XD8fItriC4K1R9xLE/y1KjAMrfpu8=;
 b=VVJj31LNY2ik0fXoH5zcJ0J6yqQRiePbIxWtPiXeiq7WVafYf44eaENfoYlh/fvXvD
 knPGZDHjJZ9z3zYWPIhEKmU2oH5zT+7z3bVsWpEv76LkvLmZlIoxat/9tHOuBmWEwhLo
 TY4oXw9cp6wZDFcBcJajQmqV3MjZN22lJP+TDPa027EMjkoZGdsANIadmHPDUMCrZ3Ju
 zr9X3exzsV0ROySR4lZ6sfFZ5wy20TTX1negEssuSbRPA9BA9DVJ0CLWOOj722nFs0Ap
 WhZl7N0zV4qjgJXafD/UlJRIET1lRFMItHunO0eqUf27vWXC7VVNuxImggXRMiMb+j+G
 Qx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224757; x=1756829557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZULQzqlKElES3XD8fItriC4K1R9xLE/y1KjAMrfpu8=;
 b=vG0hyCQd9qb74p3D4+mTHKZ0IoYyelAUWn/ZSZ8P+QkEWodaUDJ4PSDLh9mmgQJXkc
 N5lepfl3Udjj73sNBDU6tC/3b/aad35O0CuiYqQJmNTSc2hRVz9t6Otz7LATDIGY5b4j
 9P8JO8GOGg2jYXbYk1VIQ1I2pD4IRseRsGSURISxQMtmWhU1tOXlDA7AK70d9LC3Y9/v
 CXAB+lqMmMg4t5ZMr43HaHqAAexpp9AmPUI1TKgvcZhQEYHt4jKSLN9g4Tp4bZJZ/nzh
 yClZ9UWij/A0kRyJuuvRt6zXglZ7GCboi+M2hVK58dU2pnIXr4CWR/Ah+p2LXy4tZA4g
 zDrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCxBVafUbQ1qpF08eZDOyBIQ3XMP0OU4k4XSHoEjbJw/Nqp1ULfrXVRjh23cAFxPmzyILlLJceYzRwvg==@nongnu.org,
 AJvYcCXkF2eH6qt45CUejpe4+G53wa8K2G4O8WQngzEeuoiCHZYjzXqUnBJXlY3RJeD9/0qanzutAUsrxw==@nongnu.org
X-Gm-Message-State: AOJu0YzD/BkJvMfq13YMWu4I5SxKcQrqQGd4ULI0A3nZ+0GqXcTPZeD5
 JOD/fIq+hYSHopYxrVJzgKGn/NImdg30uONIyEMbjUy1Af+mmgqi5teh/5MRNA==
X-Gm-Gg: ASbGncvdHnDMu/xjGggOLz99txseIcDBApAy3gtybREYbaBDf+sD7xYndhUzYo2vZO5
 0a6hhCVkwvTQ12HhiCs8bZQkVCr0p1j4pKVBTrkYflHBEypyzm//7ddBBqgLoX+dx/mOoTxsKL7
 G7bQP1CIHqs1goBdSS4Zx53MPoAGGl0mIfelP47Ih06752XBz+gYBixKr5hxHL32helAjP68rA8
 o6GksXRb5f7vEbtQro5fEHprr/kFsXFOC5zDP20owpxEK5wuNwBxGQ3dbgOd5yTMWFHroPUHAAM
 Fv3YoPavUKGWlD1rNbIowVL32akBGkPgHidCumwciRu/2tCLfIr/r7YmSb6KWYKaKWIOnlgtC42
 PBsMj2amoheGg5W8Lwsppqw==
X-Google-Smtp-Source: AGHT+IGdE1DA6xMewpVYGxKMLhG6dGBY6LFiDRI6++0hAkdWATePBgiM5WfBN0jHDYOY3GW/4DhW8A==
X-Received: by 2002:a17:90b:4f46:b0:312:ffdc:42b2 with SMTP id
 98e67ed59e1d1-32515ea1b15mr18626102a91.23.1756224756855; 
 Tue, 26 Aug 2025 09:12:36 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:12:36 -0700 (PDT)
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
Subject: [PATCH v2 15/35] tcg/wasm: Add mov/movi instructions
Date: Wed, 27 Aug 2025 01:10:20 +0900
Message-ID: <13eb7d5403cdad50342504eb76aef9bc0f8e0996.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
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

Theese operations are implemented using the corresponding instructions in
Wasm. TCI instructions are also generated in the same way as the original
TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                |  4 ++++
 tcg/wasm/tcg-target.c.inc | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

V2:
- This commit generates both Wasm and TCI instrucitons.

diff --git a/tcg/wasm.c b/tcg/wasm.c
index fa7413fc1d..2c8a7b814e 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -260,6 +260,10 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             tmp32 = tci_compare32(regs[r1], regs[r2], condition);
             regs[r0] = regs[tmp32 ? r3 : r4];
             break;
+        case INDEX_op_mov:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = regs[r1];
+            break;
         case INDEX_op_tci_movi:
             tci_args_ri(insn, &r0, &t1);
             regs[r0] = t1;
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 6bab20a6a9..def1f5cd5e 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -501,6 +501,28 @@ static void tcg_wasm_out_st(
     tcg_wasm_out_op_ldst(s, opc, 0, offset);
 }
 
+static void tcg_wasm_out_mov(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_movi(TCGContext *s, TCGType type,
+                              TCGReg ret, tcg_target_long arg)
+{
+   switch (type) {
+   case TCG_TYPE_I32:
+       tcg_wasm_out_op_const(s, OPC_I64_CONST, (int32_t)arg);
+       break;
+   case TCG_TYPE_I64:
+       tcg_wasm_out_op_const(s, OPC_I64_CONST, arg);
+       break;
+   default:
+       g_assert_not_reached();
+   }
+   tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
 static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -798,6 +820,20 @@ static void tcg_tci_out_movi(TCGContext *s, TCGType type,
     }
 }
 
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+{
+    tcg_out_op_rr(s, INDEX_op_mov, ret, arg);
+    tcg_wasm_out_mov(s, ret, arg);
+    return true;
+}
+
+static void tcg_out_movi(TCGContext *s, TCGType type,
+                         TCGReg ret, tcg_target_long arg)
+{
+    tcg_tci_out_movi(s, type, ret, arg);
+    tcg_wasm_out_movi(s, type, ret, arg);
+}
+
 static void stack_bounds_check(TCGReg base, intptr_t offset)
 {
     if (base == TCG_REG_CALL_STACK) {
-- 
2.43.0


