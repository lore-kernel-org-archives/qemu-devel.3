Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAFFC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMU0-0001iA-FI; Tue, 20 May 2025 08:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTW-0001CB-3i; Tue, 20 May 2025 08:53:42 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTT-0000rK-Vr; Tue, 20 May 2025 08:53:41 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30e8a968b15so3515840a91.3; 
 Tue, 20 May 2025 05:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745615; x=1748350415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2q8jR3NRvJr0acKyFRjELmA4piI07T787KQwfPUSTw=;
 b=X7ANuVPZmKiwXiAzJ/Gh/YDs74dLEFTBO26MalOir7KEy1pqYTQTPH6hyqOosgpVLG
 JDXTVFIdEb0qCfz04fkFZe9Vvx8HHSCYf3bYJFqCLNZPl2yF+/1t26F4Truc06VWxFhh
 ewlyrl9YsrA8U4U374Y5SXnHaN3VvBjS+aUZ9uvJlb3J69wt6Xn8Hw22VbyTPn+wGu+N
 cc75+stSWapEJ5rjelNq1h5PI+RaL0lNSF5rgUeGoxlzMdlJjU+nJ91XaEJ/X9jeGv4d
 CReUu8l8/OZX6PdF/HgmtNkS2AnOw34PngPGaMFdkgIuphXDOBJCg5M/kbFyXgwsmtC1
 SgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745615; x=1748350415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2q8jR3NRvJr0acKyFRjELmA4piI07T787KQwfPUSTw=;
 b=vQCOZNu62tPrmfMEjmXQvAT0Tac3W9GXfy/62RafDarU9dVLPejKPSMPcezHQBECia
 jBxLkJ/kJCZMGNTNi3IJRE7p+dWQmPb132bAy+GsRXY3d3hmOzPZNcUE1ui8/sTbgj2V
 GHoDnBUeBQZdEnfhKVVJMlCBgYlG+OOKi0PedwdMvM880C/7FM3kO2ZeBKxAr9sAweTZ
 GEsJ9xmX96WTwNif3/dY1SjsD/vztVtT+t9InOHC882AtdH/CwqnNwqD65IsYZi2rfjd
 fI8nLsNhVMWm8AWngLDAR+RqO95wGhxxpi5Lso4eQiqQdcZz+W5x9JrISVeuNC4MFLus
 RHUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWymA+yx1fw/twS63bVsSVCKkO+RIaeBqBrQZ5P9mGRNsTAi3PTvScYIsvFJq6G6M6/qNbmhkQwKQ==@nongnu.org,
 AJvYcCXqLJlqS3j1kU0yUJBH9Qxk35CD7qlHg4zsY4OJEZx8Ft3hybOrxi+7YJ+uas0obgfAtcTsC1iUPRNiHQ==@nongnu.org
X-Gm-Message-State: AOJu0YypG1vSg+zqaP/oJ5t9fLAS7yiVjNWgnFww8jOEdnkTlkrEm4/o
 unSa2BbvtyAlMP6NizB4YIu36QtERBiW6Se3uzHyHKVeeSJP2FRCGTJAaTtLrZwa
X-Gm-Gg: ASbGncvSf5wpUtnr9mfqu1zoKmg5fLVXOS5301518qyjliosr4+rGveYurR1x89FXwJ
 E3haPgT1FINFyeooTfFTQuFUJAkaRSUxy7b3wvKxesLeSamMQDNP0M7b2qxFqPteRxEfm9nK2X9
 4S6OabkCl2j3zt36jf576DEy+mfAuKbJMoPYJcu7+RQePye3+tp7Bplc0/fcHCDXLyDC4RqKSD4
 JAffxwFHlWMloVWdRHoa4hWb/FnAfP0XzXB/cAszxKBa98//7d3a7lNhti8H2cp7aL0HMWVNFWN
 oGOPr/esnBVVI+VpY1cY6KmDky3d7nFuVj0nqiGU93HMrvfC8dKOC7weB8afyQ==
X-Google-Smtp-Source: AGHT+IH4pYR+xBvjcKBjbRkQTBRJT8LDwYpUVuUOiwlfPNjevxQmlAFw2Wowy5/kkLk1V1frDu+5lA==
X-Received: by 2002:a17:90a:e70f:b0:2ff:5e4e:864 with SMTP id
 98e67ed59e1d1-30e832162d4mr26751801a91.25.1747745615178; 
 Tue, 20 May 2025 05:53:35 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:53:34 -0700 (PDT)
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
Subject: [PATCH 14/33] tcg/wasm32: Add rem/div instructions
Date: Tue, 20 May 2025 21:51:16 +0900
Message-ID: <46ce312e6bfd409ab1ba882470bf4f1508e545e5.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1036.google.com
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

This commit implements rem and div operations using Wasm's rem/div
instructions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 120 ++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index 1a6069e288..66d3977d31 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -212,6 +212,22 @@ static void tcg_wasm_out_op_i64_mul(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x7e);
 }
+static void tcg_wasm_out_op_i64_div_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x7f);
+}
+static void tcg_wasm_out_op_i64_div_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x80);
+}
+static void tcg_wasm_out_op_i64_rem_s(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x81);
+}
+static void tcg_wasm_out_op_i64_rem_u(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x82);
+}
 static void tcg_wasm_out_op_i64_shl(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x86);
@@ -995,6 +1011,106 @@ static void tcg_wasm_out_movi(TCGContext *s, TCGType type,
    tcg_wasm_out_op_global_set_r(s, ret);
 }
 
+static void tcg_wasm_out_rem_s(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_i64_rem_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_rem_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_rem_u(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i64_const(s, 0xffffffff);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_const(s, 0xffffffff);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_i64_rem_u(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_rem_u(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_div_s(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        tcg_wasm_out_op_i64_extend_i32_s(s);
+        tcg_wasm_out_op_i64_div_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_div_s(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_div_u(
+    TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_i64_const(s, 0xffffffff);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_const(s, 0xffffffff);
+        tcg_wasm_out_op_i64_and(s);
+        tcg_wasm_out_op_i64_div_u(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_global_get_r(s, arg1);
+        tcg_wasm_out_op_global_get_r(s, arg2);
+        tcg_wasm_out_op_i64_div_u(s);
+        tcg_wasm_out_op_global_set_r(s, ret);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -1556,6 +1672,7 @@ static void tgen_divs(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_divs32
                      : INDEX_op_divs);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_div_s(s, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_divs = {
@@ -1574,6 +1691,7 @@ static void tgen_divu(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_divu32
                      : INDEX_op_divu);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_div_u(s, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_divu = {
@@ -1718,6 +1836,7 @@ static void tgen_rems(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_rems32
                      : INDEX_op_rems);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_rem_s(s, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_rems = {
@@ -1732,6 +1851,7 @@ static void tgen_remu(TCGContext *s, TCGType type,
                      ? INDEX_op_tci_remu32
                      : INDEX_op_remu);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_rem_u(s, type, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_remu = {
-- 
2.43.0


