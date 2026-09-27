Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E25C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkod-0006HJ-A7; Sun, 27 Sep 2026 05:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoA-0005Be-LL
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:31 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAko4-0007g4-37
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:26 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4aa0f1766so1170595a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499863; x=1791104663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PEW1fBHbl6Kzb2BexrggggMaWEl2U+jNwnahw5LdGpo=;
 b=faqDXxWlDBHPaePl5p3Vzt3WqU/C8GPOXfZOeF73gCdUj0UTNULSznfxAF5zACbox9
 CUqlOz4SvRidqfpR5/IbI/bbspDwn3hho8LKjqdGfcx+2cyB6dXDxxRS+a0P6f7/YNSr
 0mr49qbBtnrX1FIfjKbQk7N0VXYdDJh2QkMdmtOMPJ4vUp/aguDsCSXhWw01sXdA2Mdj
 4N4pKxVIZEmoglM3SHpa3567SV1Y/4ViJ4JEDy6WMNtLtZKlJYzx/GcV9F3bK3qTAJM4
 jz7tEqXUUt5D5GVRdgPtGoQIIEmSkYAgVIV5hsJjXpPYvqb7lamTyVmfStwqKgRM3Zih
 Skcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499863; x=1791104663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PEW1fBHbl6Kzb2BexrggggMaWEl2U+jNwnahw5LdGpo=;
 b=LONH7+4b5nqDi5fKvcoPixBscY2u46LmDEqZOLF5fnC5lc5w4YI6DOriQxfzsz9ULu
 DLgjSYW2xqlgcRwCVT/t8UaR/59hFIZUYE0iDZlwu8Oc09UhrWlZAZXIxvciQ7y5WGAB
 Hu9ZuM65dP32cFAfXJMfjajkUa/Qi08c++eTfoPv5iWSaL2XGhPsdFfaTl9sdaYHlHRx
 1BBQM6sP9tLIxzxOV+Btx2PqOR2iDeDsMRazX2XmRS85k8Eby/mruRPzqJmRaNewwEvi
 ie52Y5R8mgdIuzDDmm8FQFBywrCMghHy4PNOb6n9iaFvFx5kC9U2iCGbRkMSFwdGgkHh
 lBXA==
X-Gm-Message-State: AFq9FYIRMepXoPEj1R29GYx+TIjST+VRO4DCxxFrwvljt+0ioi2yaRSy
 p8koaeiVVgRBBIcUJYQ7IyI/5zmNGmvTEjpo+jWFarday6+iKxQ+lZUo5m8JqqvqWzK7teiS9G6
 uY25B
X-Gm-Gg: AYBFou2qCxV/djkTnamhz5f8fEnY4kYDyy5kzqA/tRXGojmZlwBRQCvoOa1MT2Hxcr5
 XLtPsWLDOlLD5xoiIDfkxy8kGwWJtrji108S6VlI5a+6wJzKusVWNXQcJEO+Dt+RyuX/PpokRHo
 2CwaqhAinp+QH1F+/fSSBsFIn2WkYeQgldJrA06J7s80dirPGXdNGXKdvHeupCn3isKjUwO5XrG
 lHAh1ZsUICVVPSgYEigt7W1HkLLKmd/muUFVRtHImLwlaFR9luO3pxWe/PRwcEO+6I8cF9k4LAh
 5EcO77VwEG4PlZDgsuNkstKS3UXTNotGGhb+sQAN1GSBQ9e1mwqlIRbzrBVHhGWy6dWyljundfs
 GsuTMt9MTiWwWCPH/aLUu87P2k4AkqtULrgv8mL8zyC0oMpu7GCVORH22zQK29TOIDUcgRFjRYC
 iGSEgnB3ugDlrusfqtUfPmQF2/Vwy2X47IbQoPG+bMWVgY95XVwb5cP70bVihdmutzbFcZofJsW
 3xGk2BQd7e8c4CaYMQ5AqU73GJHoA==
X-Received: by 2002:a17:90b:3c4a:b0:3a2:a145:ac7a with SMTP id
 98e67ed59e1d1-3a2a145deebmr1361073a91.36.1790499862519; 
 Sun, 27 Sep 2026 02:04:22 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 065/101] tcg: Generic expansion of tcg_gen_deposit_z_*
Date: Sun, 27 Sep 2026 01:59:35 -0700
Message-ID: <20260927090011.10724-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 70 +++++++++++-------------------------
 3 files changed, 21 insertions(+), 54 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ef47b704bc9..f80e9dc2e29 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
-                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -177,8 +175,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
-                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 338ecce6fce..88e87ebc2f6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -15,6 +15,7 @@ DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
 DEF3(ctzi, TCGV, TCGV, TINT)
 DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
+DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8fbf07d045e..2e5bc1e8200 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -197,20 +197,6 @@ static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4);
 }
 
-static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                  TCGv_i32 a3, TCGArg a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), a4, a5);
-}
-
-static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                  TCGv_i64 a3, TCGArg a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), a4, a5);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -550,6 +536,26 @@ void tcg_gen_deposit(TCGType type, TCGTemp *dst, TCGTemp *src1,
     }
 }
 
+void tcg_gen_deposit_z(TCGType type, TCGTemp *dst, TCGTemp *src,
+                       unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    if (ofs + len == width) {
+        tcg_gen_shli(type, dst, src, ofs);
+    } else if (ofs == 0) {
+        tcg_gen_extract(type, dst, src, 0, len);
+    } else {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        tcg_gen_op_tttii(INDEX_op_deposit, type, dst, zero, src, ofs, len);
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -1014,24 +1020,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
-                           unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    if (ofs + len == 32) {
-        tcg_gen_shli_i32(ret, arg, ofs);
-    } else if (ofs == 0) {
-        tcg_gen_extract_i32(ret, arg, 0, len);
-    } else {
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, zero, arg, ofs, len);
-    }
-}
-
 /*
  * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
@@ -1683,24 +1671,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
-                           unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    if (ofs + len == 64) {
-        tcg_gen_shli_i64(ret, arg, ofs);
-    } else if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-    } else {
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, zero, arg, ofs, len);
-    }
-}
-
 /*
  * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
-- 
2.53.0


