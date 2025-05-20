Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369ECC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMUD-0002Hj-3m; Tue, 20 May 2025 08:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTm-0001Nd-Tg; Tue, 20 May 2025 08:53:59 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTk-0000vM-HZ; Tue, 20 May 2025 08:53:58 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30ed99132abso2201898a91.3; 
 Tue, 20 May 2025 05:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745632; x=1748350432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hDX6tqZfoQbfyom/brX/vCkpGWr5vOfzD19dhVKfxE=;
 b=NW+UhHjncqUV5XRLY1hOMN8fMDnCo9VIdXJSATOzjLCqqR6KNaBPiHR5mDptZ6Zh0u
 jO0ozr73pVv0kxjDNjVF2sqciLF6Bg5ItSrFCFxmFGlWLEsd1AXah9dQvRGyy5XWuEkm
 ZvaHxZQxTOVjILjafrC944bt1Owfz3R3JnyItkwwn23sPZS+nkcEJwUGPmz+myeBqA9f
 DqEFpJO8Zubrr/1jDBG+yM64/NWuJsVqgdq3dBa/eAcH5ITQop5zMja08q0tnYJWJuGF
 /xCZaAXFz6YTG6tkJp9Xsw2ogBsz2mgL05kqLm1nYAGcCrfftvu5bqHu5OIKlhc7xp/3
 moCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745632; x=1748350432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hDX6tqZfoQbfyom/brX/vCkpGWr5vOfzD19dhVKfxE=;
 b=LecCGoflZL8iP4r9Ds8x4MRu//9sYfZyD4qM7hxl9mzDVR/i+m3MWLQ8p5bEVsoUC4
 5I1IJraniYXCRoKhhHu8ERinGWa/qSwPdTwci5U5qs23f4t7gmweTVDij2rxJaceDRVn
 NQce3nHm0izrbkYMrNf+4kLvt7nwmOJbBq98ZswxnsvJWQ9tDsIbP1VVa/a6j6cS9jL1
 HFQNnytrrq24V3ZuW2NahqpGhuP7z4M8pHDgai+/n05Tu08A9uyl2qsCG/BxDcy0+Qn+
 Cuvr/VU21Ki6JbyZZ/51cJCDGOlNjqyj5/FGiDyq/+wWfWMQfcRR6UZS4khsZZ6J9kK2
 kUoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyzpD6RZJiAljswiU+QfLhwP4HJooiOWQfCM/YPp/TkDnPRZSZj9e/KTTTK4GRmAcLlkcySjm/4A==@nongnu.org,
 AJvYcCXPsZtuuhOkymiBDNJFnNCBPp0p4QMEnyANL3alSWSanxVhJc78NsUohNAe44ulSNggsGWkl9vCT4ZccA==@nongnu.org
X-Gm-Message-State: AOJu0YypskfLSarWo5Dki1Io7uNHrEqsGCU529cTXX1qVDrb10Niz84N
 3feO2sixJvfpKryPciiEhmcTFB5PskC/YfXiM4pnHUHJmvps2bWV3YFL6SOiIvPZ
X-Gm-Gg: ASbGncul9OEkHHBY/ieQjtiG8bjUJNO7va5I9ZZ2LlaNM+bMqk8v2HCAeWQ03hedHHx
 AnZH1jNdYK5sSryZpUlkJDnW931KIwvzpa7f8OQkOm7umI623zKiko2xgPg+8A9jei8Axeo3ElN
 b2ue731xkkaLDxwE3kxoxBBPW4ZO5OmHuSMHAfKTvwszrHMDKz94khPQJuY0LcnwJ+FL5weRCKt
 ZwohxF3gdFhpX6mY2J3d4YgeaKHiIcHFSQ1cBngB8zJqzKpezu2PXebbjaURn9KW0cPAUoCEq0y
 tt52CkB3TZR0xrTSsDW8AkSZzG+351yRVy5UgWWcq1BKkoNNX0I=
X-Google-Smtp-Source: AGHT+IE4U2UXF2xs+H6bxIt71NsbCMeWEhfCOMavrX7tJFkvHIkvkiyDXs60OAAtuPGm3U++zpH5Cg==
X-Received: by 2002:a17:90b:28c5:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-30e7d2def4fmr30108178a91.0.1747745632031; 
 Tue, 20 May 2025 05:53:52 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:53:51 -0700 (PDT)
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
Subject: [PATCH 17/33] tcg/wasm32: Add rot/clz/ctz instructions
Date: Tue, 20 May 2025 21:51:19 +0900
Message-ID: <ec4eb2d3ee8f6e880501e51bd496ac3260040d00.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1030.google.com
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

This commit implements rot, clz and ctz operations using Wasm instructions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 155 ++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index e5de2f69bd..75e47f8c8c 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -200,6 +200,14 @@ static void tcg_wasm_out_op_i64_xor(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x85);
 }
+static void tcg_wasm_out_op_i64_clz(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x79);
+}
+static void tcg_wasm_out_op_i64_ctz(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x7a);
+}
 static void tcg_wasm_out_op_i64_popcnt(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x7b);
@@ -244,6 +252,10 @@ static void tcg_wasm_out_op_i64_shr_u(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x88);
 }
+static void tcg_wasm_out_op_i64_rotl(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x89);
+}
 static void tcg_wasm_out_op_i64_rotr(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x8a);
@@ -268,6 +280,14 @@ static void tcg_wasm_out_op_i64_extend16_s(TCGContext *s)
 {
     tcg_wasm_out8(s, 0xc3);
 }
+static void tcg_wasm_out_op_i32_clz(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x67);
+}
+static void tcg_wasm_out_op_i32_ctz(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x68);
+}
 static void tcg_wasm_out_op_i32_add(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x6a);
@@ -292,16 +312,33 @@ static void tcg_wasm_out_op_i32_shr_u(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x76);
 }
+static void tcg_wasm_out_op_i32_rotl(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x77);
+}
 static void tcg_wasm_out_op_i32_rotr(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x78);
 }
+static void tcg_wasm_out_op_i32_eqz(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x45);
+}
+static void tcg_wasm_out_op_i64_eqz(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x50);
+}
 
 static void tcg_wasm_out_op_if_ret_i64(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x04);
     tcg_wasm_out8(s, 0x7e);
 }
+static void tcg_wasm_out_op_if_ret_i32(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x04);
+    tcg_wasm_out8(s, 0x7f);
+}
 static void tcg_wasm_out_op_else(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x05);
@@ -360,6 +397,8 @@ tcg_wasm_out_i64_calc(xor);
 tcg_wasm_out_i64_calc(add);
 tcg_wasm_out_i64_calc(sub);
 tcg_wasm_out_i64_calc(mul);
+tcg_wasm_out_i64_calc(rotl);
+tcg_wasm_out_i64_calc(rotr);
 
 static const struct {
     uint8_t i32;
@@ -918,6 +957,118 @@ static void tcg_wasm_out_bswap16(
     tcg_wasm_out_op_global_set_r(s, dest);
 }
 
+static void tcg_wasm_out_rotl(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i32_rotl(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_i64_calc_rotl(s, ret, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_rotr(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i32_rotr(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_i64_calc_rotr(s, ret, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_clz(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i32_eqz(s);
+        tcg_wasm_out_op_if_ret_i32(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_else(s);
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i32_clz(s);
+        tcg_wasm_out_op_end(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i64_eqz(s);
+        tcg_wasm_out_op_if_ret_i64(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_else(s);
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i64_clz(s);
+        tcg_wasm_out_op_end(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_ctz(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i32_eqz(s);
+        tcg_wasm_out_op_if_ret_i32(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_else(s);
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i32_ctz(s);
+        tcg_wasm_out_op_end(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i64_eqz(s);
+        tcg_wasm_out_op_if_ret_i64(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_else(s);
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i64_ctz(s);
+        tcg_wasm_out_op_end(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void tcg_wasm_out_ld(
     TCGContext *s, TCGType type, TCGReg val, TCGReg base, intptr_t offset)
 {
@@ -1710,6 +1861,7 @@ static void tgen_clz(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_clz32
                      : INDEX_op_clz);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_clz(s, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_clz = {
@@ -1724,6 +1876,7 @@ static void tgen_ctz(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_ctz32
                      : INDEX_op_ctz);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_ctz(s, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_ctz = {
@@ -1948,6 +2101,7 @@ static void tgen_rotl(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_rotl32
                      : INDEX_op_rotl);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_rotl(s, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_rotl = {
@@ -1962,6 +2116,7 @@ static void tgen_rotr(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_rotr32
                      : INDEX_op_rotr);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_rotr(s, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_rotr = {
-- 
2.43.0


