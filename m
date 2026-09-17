Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E51CC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73ns-0002fV-0C; Thu, 17 Sep 2026 00:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nd-0001hg-DM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:44 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nb-0007Iu-54
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:41 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7f4f0d37f94so273669a34.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619558; x=1790224358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mx75hy8kI5w5KykJneBAF36gtqsh3N+/p4wAKje26Wg=;
 b=ld7pZ1cm4lMVZmhqEjB+QQ7HakMn3MFe0E/EmgpBkwldxKwPegZOILwZwUXNQIafAC
 p8WiSFXXMBaw1TvlC57++7bzXGSejlHgcaGYC9p86n4iNG6zOVMx/InSAwTY4OyLnyru
 iw05Vu223+deSTfmPyKxMExoGJrtO/oURLIK14LnYigf4/3CzZEr9UbRs2M8Aznna4pf
 uCzSTrtSidv4BzG9lG+T/2bq+AEBcvnsj8pffFtmTipXepI2RhLzxhq8t3v9jHoYkNQW
 GW5WuplCCdeYKU/jWDI8R9PmA/PPgM/zY9r9ytBHy/8kzfSDoHYofbUotUt3ttSGn5nM
 ZW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619558; x=1790224358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mx75hy8kI5w5KykJneBAF36gtqsh3N+/p4wAKje26Wg=;
 b=CMLOOXsmpe9Q1gDJ77SNuqE/8hqg+LtybVKHarJHGLgs0jZJN9Pv7oSAzENIE8sTml
 xlP7M03K1tWF8EgVyKwVKzrwMdPr250l/8NShTuzQBYXEXS2SQKpTW6ZXV1l3Smai1zG
 QY0vf1+Q1yXPHnfv7WXWNXpjsaGTGnUiLo1sgFR1LNieAodh+C8bq6zvmIlPwPdrjWHI
 gOTIHdoPGUOSIQ3CbL//As7spVaK2AFiZ8OloAzwvZEawzAVtSRUj+9dV9K6OdSHZLbu
 dajumafE9BSCuHuxmlDp12B739KhqT5yMDoHkmsjuCbQ5HS9vFmx1rnNycIqXrjcyUQa
 hOXQ==
X-Gm-Message-State: AFuF++n0GVT3KHLsCL0VP9Z78tqr8iTbKlG+bogBQH1WA3sq4rgd5RsQ
 32s/vl/GB5ANyDTcvPujztoYr2bokKxCBlSCA75Ajz5HypydPnniYm5AnRGsfdlGOgGsrObo+s8
 hj89iB1I=
X-Gm-Gg: AYBFou211j8dud4uBewU7AFze0jmi100dxAgK1iwwcUVnWwgjhnI+DQNO/kOVrsAatA
 u2XdEy6v0aqCTOXGg0pBoz5itBo2deNvXAjunJ/3+Nsz97fXkhgo42MwS1si30Vx3xG/bQJaI3e
 hQxJQhsY5U4HJklhaGC8Ozd6xKQ2z43I/95iBeyF7ZqXDCvpNzUwcH4VliqSZWOk5FPc5JX0O/1
 9l2rIWKJY7fBTEHeAam9Jq3BJ8lPSXzgaYe44t+bMwPWcCeBcXOkDWO1+HIitok+ZOw8Rk1EADE
 CEg2ZQUpD93qqgWTOgsIvP2VwbjVt+NK5NnwJrGdUmBowyqsA/CyHY+05/T8aVkNA1SyEvV6XRH
 fMfR/+9dLAOFNqcNjUes0pyIWwMsk1ZOSb+Hjrvw8JrvnU51V34VQB3oV3qbAGQq5FNZwhQkwvZ
 KpfTbgXQqa+T+LHGl83yDU+Gc9CoHDcnvsI0yIlp4/jtTJ/V7tF8YDu5cQwzFWTQ8qEBX3eWb+7
 j0TEiQ=
X-Received: by 2002:a05:6820:614:b0:6bd:fbe8:fb95 with SMTP id
 006d021491bc7-6c7d46e65f3mr5559434eaf.60.1789619557992; 
 Wed, 16 Sep 2026 21:32:37 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 068/101] tcg: Generic expansion of tcg_gen_deposit_z_*
Date: Wed, 16 Sep 2026 18:27:50 -1000
Message-ID: <20260917042823.542588-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index ceaa4b7fe01..4838e06f1d4 100644
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
index 21a941f5458..3b44db51f55 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
 DEF3(ctzi, TCGV, TCGV, TINT)
 DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
+DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 599f21470c5..fdcff596a03 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -244,20 +244,6 @@ static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
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
@@ -634,6 +620,26 @@ static void gen_deposit(TCGType type, TCGTemp *dst, TCGTemp *src1,
     }
 }
 
+static void gen_deposit_z(TCGType type, TCGTemp *dst, TCGTemp *src,
+                          unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    if (ofs + len == width) {
+        gen_shli(type, dst, src, ofs);
+    } else if (ofs == 0) {
+        gen_extract(type, dst, src, 0, len);
+    } else {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        gen_op_tttii(INDEX_op_deposit, type, dst, zero, src, ofs, len);
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -1117,24 +1123,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1786,24 +1774,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


