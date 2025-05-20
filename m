Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64721C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMTw-0001dL-TT; Tue, 20 May 2025 08:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTS-00018e-Vn; Tue, 20 May 2025 08:53:40 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTO-0000qT-MT; Tue, 20 May 2025 08:53:38 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-306bf444ba2so5434630a91.1; 
 Tue, 20 May 2025 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745609; x=1748350409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rhT21ZbeuAH6PwlwaEXlZP3fAXk3Eqmf4zwdAMPd7KE=;
 b=ky2Nl//34hQZRKz+H2SOibDuVn6PSeebZPvMRa/RVyIIoncR5O+P6sP+V0hAlXlHK6
 Ul98jVm5d4KO3umE3bRmCpMOSPIORA36q0ROcHCPJ6OB8xxMAU8UIYiWOrJ4QAhLoTYJ
 qb7y3VG5Apf6BnEqMfAWD0ygNGmztVGIGuHx/VlTYfVqtFHRpwl8ZpB+0Y+SAdAz+nl1
 BJ45OLUrtUs/3d4xeHbxkfeL/r6PIkkIshUB91hCep3zABl6jY8G7l7N+Xqsh8AjEARD
 aj1+CmYQjMrsXNOBU5wa6SMmxz2egfsO86z9K4b+pXfdq+9r9rWGvijkNOvghnmK1GJM
 j+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745609; x=1748350409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rhT21ZbeuAH6PwlwaEXlZP3fAXk3Eqmf4zwdAMPd7KE=;
 b=i7mLgy0cTkCjiyias/rN7oxUyudhW0SDoAr4gqrnr5t8QYCMXKCBbGmOxN87KvdphN
 L3xX1iFHyWsu8iqGkHJHXNBem6ze3OyFU9YQsvR1RPauBItSYbwFCqZ61SqHqTZb5J1r
 FpTK59S6+gDtypiI7vliohlpQIihJljfvIFaz6V958xivBcT98b8H44gdLNBlwtveLF4
 WWoltPhS6fj97pt7erxprmqXgfG7Z1aVTT0pZGVjFm3RSeNtTaV1uaxPORipdubtHks6
 NWutbfOUjWe71hQcOdmIBDJdudO9ZSEdNP8okDbd/J8xDwD8gW+Cl2eU2Yug4WcTORTD
 yt5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5M3L+DqDNiYRMSq3pVc2mYN6HuBrCjCfiIZ4wwNmK/+WuhO69GALTvLEQ80FqWwUMYaHHjk0DIQ==@nongnu.org,
 AJvYcCVBv5hoZJfFsjzcEDOsK174UBSPJ6ROVyopJjivi3d+eAuMDF6t1ZxpyjW3Yt2NFQ0AT03K0ZPv1A8gHg==@nongnu.org
X-Gm-Message-State: AOJu0YzO7N8xwupb7UvvYE/9wgv9R7sqbcG8zMtwo9zWDe5VRQI7TvSk
 j89PejwA7e3KKnHhMcAzM67Q/p1LICdfZWEipe+/0abLENyk/G6qqdK1xmSGyDQv
X-Gm-Gg: ASbGnctmmbplr2ndAZwEZhhenJiy2jx4eyGvUXdClXDsY1y8X2LuFU+25f6YM28PZTQ
 M0bDH7NQiF81fumkKdXPlM4WIxQw831C2LgAeMSdS4TP+GkE5uGwzRyFazJ4X+iPm9322dAWUgL
 Zus+iCKRgJRMHRc/dpoEymH+piIELdiI734IDGRkMs4Rj78uNnC0yozxtEhYMG2yjs8yhYUZFhH
 sX0RGihEFiLEm04pTckQhRqWW+WFoYVIAqrFtNkNg8FbsBWTlsa3cSHQwL5JVsiPlf36QhDmNbu
 GkvYSvBm4CqwB89mb55MCyzlrf8Ed6nDWzTR6c1KkMUq/A4vchs=
X-Google-Smtp-Source: AGHT+IELYgC8rXzpzxpWLznRI/A+e/6gacRu3KFNEtrvOk6g5j42KY2JurSbdVRhmlxiD4imG3/sXg==
X-Received: by 2002:a17:90b:35cc:b0:30e:54be:37e7 with SMTP id
 98e67ed59e1d1-30e7d5b7521mr27787860a91.24.1747745609377; 
 Tue, 20 May 2025 05:53:29 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:53:28 -0700 (PDT)
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
Subject: [PATCH 13/33] tcg/wasm32: Add bswap instructions
Date: Tue, 20 May 2025 21:51:15 +0900
Message-ID: <b7368a9d3908e494261b838113e5ea479e24e73c.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1034.google.com
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

This commit implements the bswap operation using Wasm instructions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 136 ++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index dff79a9854..1a6069e288 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -118,6 +118,11 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
     15, /* TCG_REG_R15 */
 };
 
+/* Temporary local variables */
+#define TMP32_LOCAL_0_IDX 1
+#define TMP32_LOCAL_1_IDX 2
+#define TMP64_LOCAL_0_IDX 3
+
 #define BUF_SIZE 1024
 typedef struct LinkedBuf {
     struct LinkedBuf *next;
@@ -219,6 +224,10 @@ static void tcg_wasm_out_op_i64_shr_u(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x88);
 }
+static void tcg_wasm_out_op_i64_rotr(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x8a);
+}
 static void tcg_wasm_out_op_i32_wrap_i64(TCGContext *s)
 {
     tcg_wasm_out8(s, 0xa7);
@@ -255,6 +264,18 @@ static void tcg_wasm_out_op_i32_shl(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x74);
 }
+static void tcg_wasm_out_op_i32_shr_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x75);
+}
+static void tcg_wasm_out_op_i32_shr_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x76);
+}
+static void tcg_wasm_out_op_i32_rotr(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x78);
+}
 
 static void tcg_wasm_out_op_if_ret_i64(TCGContext *s)
 {
@@ -295,6 +316,14 @@ static void tcg_wasm_out_op_global_get_r_i32(TCGContext *s, TCGReg r0)
     tcg_wasm_out_op_global_get(s, tcg_target_reg_index[r0]);
     tcg_wasm_out_op_i32_wrap_i64(s);
 }
+static void tcg_wasm_out_op_local_get(TCGContext *s, uint8_t i)
+{
+    tcg_wasm_out_op_var(s, 0x20, i);
+}
+static void tcg_wasm_out_op_local_set(TCGContext *s, uint8_t i)
+{
+    tcg_wasm_out_op_var(s, 0x21, i);
+}
 
 #define tcg_wasm_out_i64_calc(op)                                       \
     static void tcg_wasm_out_i64_calc_##op(                             \
@@ -692,6 +721,110 @@ static void tcg_wasm_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
     tcg_wasm_out_op_global_set_r(s, rd);
 }
 
+static void tcg_wasm_out_bswap64(
+    TCGContext *s, TCGReg dest, TCGReg src)
+{
+    tcg_wasm_out_op_global_get_r(s, src);
+    tcg_wasm_out_op_i64_const(s, 32);
+    tcg_wasm_out_op_i64_rotr(s);
+    tcg_wasm_out_op_local_set(s, TMP64_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 0xff000000ff000000);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_i64_const(s, 24);
+    tcg_wasm_out_op_i64_shr_u(s);
+
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 0x00ff000000ff0000);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_i64_const(s, 8);
+    tcg_wasm_out_op_i64_shr_u(s);
+
+    tcg_wasm_out_op_i64_or(s);
+
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 0x0000ff000000ff00);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_i64_const(s, 8);
+    tcg_wasm_out_op_i64_shl(s);
+
+    tcg_wasm_out_op_local_get(s, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_i64_const(s, 0x000000ff000000ff);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_i64_const(s, 24);
+    tcg_wasm_out_op_i64_shl(s);
+
+    tcg_wasm_out_op_i64_or(s);
+
+    tcg_wasm_out_op_i64_or(s);
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
+static void tcg_wasm_out_bswap32(
+    TCGContext *s, TCGReg dest, TCGReg src, int flags)
+{
+    tcg_wasm_out_op_global_get_r(s, src);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_local_set(s, TMP32_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_const(s, 16);
+    tcg_wasm_out_op_i32_rotr(s);
+    tcg_wasm_out_op_local_set(s, TMP32_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_const(s, 0xff00ff00);
+    tcg_wasm_out_op_i32_and(s);
+    tcg_wasm_out_op_i32_const(s, 8);
+    tcg_wasm_out_op_i32_shr_u(s);
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_const(s, 0x00ff00ff);
+    tcg_wasm_out_op_i32_and(s);
+    tcg_wasm_out_op_i32_const(s, 8);
+    tcg_wasm_out_op_i32_shl(s);
+
+    tcg_wasm_out_op_i32_or(s);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+    } else {
+        tcg_wasm_out_op_i64_extend_i32_u(s);
+    }
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
+static void tcg_wasm_out_bswap16(
+    TCGContext *s, TCGReg dest, TCGReg src, int flags)
+{
+    tcg_wasm_out_op_global_get_r(s, src);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_local_set(s, TMP32_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_const(s, 8);
+    tcg_wasm_out_op_i32_rotr(s);
+    tcg_wasm_out_op_local_set(s, TMP32_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_const(s, 0x000000ff);
+    tcg_wasm_out_op_i32_and(s);
+
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_i32_const(s, 0xff000000);
+    tcg_wasm_out_op_i32_and(s);
+    tcg_wasm_out_op_i32_const(s, 16);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_wasm_out_op_i32_shr_s(s);
+    } else {
+        tcg_wasm_out_op_i32_shr_u(s);
+    }
+
+    tcg_wasm_out_op_i32_or(s);
+    tcg_wasm_out_op_i64_extend_i32_u(s);
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
 static void tcg_wasm_out_ld(
     TCGContext *s, TCGType type, TCGReg val, TCGReg base, intptr_t offset)
 {
@@ -1768,6 +1901,7 @@ static void tgen_bswap16(TCGContext *s, TCGType type,
     if (flags & TCG_BSWAP_OS) {
         tcg_tci_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 16);
     }
+    tcg_wasm_out_bswap16(s, a0, a1, flags);
 }
 
 static const TCGOutOpBswap outop_bswap16 = {
@@ -1782,6 +1916,7 @@ static void tgen_bswap32(TCGContext *s, TCGType type,
     if (flags & TCG_BSWAP_OS) {
         tcg_tci_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 32);
     }
+    tcg_wasm_out_bswap32(s, a0, a1, flags);
 }
 
 static const TCGOutOpBswap outop_bswap32 = {
@@ -1793,6 +1928,7 @@ static const TCGOutOpBswap outop_bswap32 = {
 static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_bswap64, a0, a1);
+    tcg_wasm_out_bswap64(s, a0, a1);
 }
 
 static const TCGOutOpUnary outop_bswap64 = {
-- 
2.43.0


