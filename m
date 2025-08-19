Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBF5CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR0K-0006W9-Ij; Tue, 19 Aug 2025 14:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0I-0006Q2-UF; Tue, 19 Aug 2025 14:24:15 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0G-0003vc-UR; Tue, 19 Aug 2025 14:24:14 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-244581c3b43so49726705ad.2; 
 Tue, 19 Aug 2025 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627851; x=1756232651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aldgkhhllwPVwgK3Tprk6u/cv55YnkKoytwWfl/DwwM=;
 b=Ze/3s5G2jw8X++dIukJNQpandAFl5sJ4rnruos6kpwuc4fKs9n6fneu8tafX7Pxgeg
 JtubclVjYJWIv80Jn7JZI9xRXrZ1Ka08vJsSz+POIM7PSFNiD/zYTuYpQllaKr3jWUWS
 iWTG+T/JIWlRqMTONR2V8e7qlDYDmFbM0tCeNPt+N64Fc2Mx/NRVNs6EDkBZLggW8wwU
 2Z/OqfOCOaUBluZ6ddDliyzUfEBNUr37MBFNGVYMHv1t2eUwMCRb3EafBzV2W3lRq2pg
 jcjGqrGy9RO6K5NPHFSdzS59KABvR+TWfJTxlpaXmsTleZzzxJvhHkUQ/gbJe/wC+VM/
 OMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627851; x=1756232651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aldgkhhllwPVwgK3Tprk6u/cv55YnkKoytwWfl/DwwM=;
 b=wIPuODjnBVFId/9OMis9jgjWkdRQS9j4IF0ZJW2B/lY+9SESLmsQNWuMw7ANwnfe+M
 NbsMkEZHDRx3lWKmzAEd9uJoAdGuY5vQnT6J3uwWRBt7g+Er9mXSFNzU1NSh9R9lRekF
 LJiN6xbij/qHRZwV+GVGn0oLlqsRv4eWAKMnjglD1VJQab7APRn6JpIdrtLvXhSsIlSS
 3xmQaxIxNAU4A8Lk0tpOvB0q+jtbIOXIrhTciK6N2SbtwZ3A310LjXJG5K/F7rHwiw9Q
 XmyDM7s6TfCXYwwhzIJe3pnS5Cd/maZwlLWL6GY6/V9zHf8l56jP7thBfLDmOGrA7di9
 S7sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Iy2ij0HQU+zS4p3eLnOIfLL2Mk3J8PNU4r4dSIpSdC9xWTVC1d1Xx5HptAKW2jAaRms5Jjb0pw==@nongnu.org,
 AJvYcCWUyBHW2gYrcoDCIswyRBwur5QQcJI/J530pOaiMy7/C0lu/iCq1+bunFaeQo8KxiqcHpVhZGvgqyOhAg==@nongnu.org
X-Gm-Message-State: AOJu0Yybq5NkFxYUkCN8seHyEPvQi8W9FWsaRSEWcQtggfu2yGYXUY5f
 cIXeBF2u1yLJh2qLm2ODJGE6CZxwJd4ImFSHDSwD44JbRkQGp7C7zzEOiNueFu3e
X-Gm-Gg: ASbGncva6TpdzYPSqYSzD/AoRYpETB/rMEWLRlT1ocBtL1AT0UiROSmUA2oZq3ehXJT
 VdF3FpMZpOcsrS0MQyQ+3Eq/1AAW70c+/wmBiX1yiwreDIvHjPZcZn4Ze9nOFMY61FCdHZGVqeV
 E1qtN2fuhWWF/EaiE0AAPycJLllHRl5DP600jEIP+hVVE+99NmQzLWITLPDnZCTx3039rW8Jx2L
 /HsEHSXt8U+xuOKBFay9Oll93UgBXSBWHBxLVb8/bO+l/O+Qz4zMg1uSnF61Nv2BoaBrUgax7d9
 x4eF0PJPgU0Lub+y4QJnsIaaEcCwGmj44Cisg7tCbvcuaoxLP8/8twLmUc+7vJdCu7Lyk1Du7r1
 RsV4RDXGsvtYe+MyinCaO3dvzaRYnsguq
X-Google-Smtp-Source: AGHT+IGy4zper5z8+c6W3jFkay3BSH10qUQUpUebXInUfpPeXXoPgpXhYD8gnsksDJcoHr2U3RR2nw==
X-Received: by 2002:a17:903:2f90:b0:243:a5:f1f2 with SMTP id
 d9443c01a7336-245e04f7574mr50681395ad.56.1755627850615; 
 Tue, 19 Aug 2025 11:24:10 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:24:10 -0700 (PDT)
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
Subject: [PATCH 17/35] tcg/wasm: Add ext instructions
Date: Wed, 20 Aug 2025 03:21:46 +0900
Message-ID: <d9143780791a975afe6cd087a98756548c2de8ad.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62a.google.com
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

This commit implements the ext operations using Wasm instructions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index ec5c45c69e..afaea76d5c 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -873,33 +873,39 @@ static const TCGOutOpExtract2 outop_extract2 = {
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
     tcg_tci_out_sextract(s, type, rd, rs, 0, 8);
+    tcg_wasm_out_sextract(s, rd, rs, 0, 8);
 }
 
 static void tcg_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_tci_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 8);
+    tcg_wasm_out_extract(s, rd, rs, 0, 8);
 }
 
 static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
     tcg_tci_out_sextract(s, type, rd, rs, 0, 16);
+    tcg_wasm_out_sextract(s, rd, rs, 0, 16);
 }
 
 static void tcg_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_tci_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 16);
+    tcg_wasm_out_extract(s, rd, rs, 0, 16);
 }
 
 static void tcg_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_tci_out_sextract(s, TCG_TYPE_I64, rd, rs, 0, 32);
+    tcg_wasm_out_sextract(s, rd, rs, 0, 32);
 }
 
 static void tcg_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_tci_out_extract(s, TCG_TYPE_I64, rd, rs, 0, 32);
+    tcg_wasm_out_extract(s, rd, rs, 0, 32);
 }
 
 static void tcg_out_exts_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
@@ -916,6 +922,7 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_tci_out_mov(s, TCG_TYPE_I32, rd, rs);
+    tcg_wasm_out_extract(s, rd, rs, 0, 32);
 }
 
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
@@ -1146,6 +1153,7 @@ static const TCGOutOpBinary outop_eqv = {
 static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
 {
     tcg_tci_out_extract(s, TCG_TYPE_I64, a0, a1, 32, 32);
+    tcg_wasm_out_extract(s, a0, a1, 32, 32);
 }
 
 static const TCGOutOpUnary outop_extrh_i64_i32 = {
-- 
2.43.0


