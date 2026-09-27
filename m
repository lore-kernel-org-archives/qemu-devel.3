Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D376FC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkqx-0001n1-9D; Sun, 27 Sep 2026 05:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoJ-0005c7-SX
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:40 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoI-0007iq-58
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:39 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf02so1090326a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499877; x=1791104677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RMEAXlsTa7TeoQW/m8y8mJaD79gFnvCFZjybF+jgecE=;
 b=sd/WNqOyJUhI600kogoSnHU702usy5J3VNqobFzEYJAaTsgL401Mc0cltlIN1txp1A
 0g2Zxuuw4YUmA+3Fw9uY3kP/AbvhdgXoVReuOXSwOVNn2YePRiASrywSy2nlTmqFrRWh
 IinuFCf8pJ5EAelab5iQhl7q1ONA1+G5YP564N7PkuheoSYC+Vem0VTCKdKID0hHm5S0
 IaaFqQ2baBcUM1eQtmLGLmI9kj/C8uVO0eVtnLP1EgWl/3qaiMaCGr0opwbqS3HgoINL
 GB4cfwV8NQelii0A3vrvwjIS8mJvSwDAdTsRKpXL4chZGM3koywHOmxjhg7a00DMu8kk
 WBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499877; x=1791104677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RMEAXlsTa7TeoQW/m8y8mJaD79gFnvCFZjybF+jgecE=;
 b=2yc6wjwQhaU5ajGo4Ik8VNBRGzCifiwIDQONcISU5vWO3EWbitcUExRViANCzEqd94
 eEM3nVgCH1uhKI+uj2BbVhIYH/JPETeqFmcpLtFl/S18A18tjQMMbB/YmmEBnh7yWuPF
 JvAZaltiMrcZ6Olqh+weFTe8B2Z82/vJATEsKgrNDPOA816EjGxc7G1G5H1asugcd1fx
 NtWE6FBYaMalzAWgQmIVBRi4nddF1eNTBr4AO8pguBt7HFCIwlvAg1/dHLLd3DRjFynd
 Vtm1e7jdlDjBO012cprjyAhjK6NqRl1x5qFX71sBqSbB1r7Q8g0F/Ra4XPzABjs0L5w1
 vrPw==
X-Gm-Message-State: AFq9FYIKWhAsvs0qZ0c696ZEl9ETC53adwsFJvRh+OgDKnBWcs1Lm33A
 cHKPVZAcfmhHtROvdttdr4p8O8MHMBKoEpBkKgqvJO8f069FwE3Z2zIVUBarRmBGdycazG/Zvs2
 xOR19
X-Gm-Gg: AYBFou2bXuSgFAZGEkdXbSwWUpvGn86DtnvqSYfRhi4HA8iBXnwxwIIlpI7+RrYgdYx
 Aaa3KMxS11O5LB9aqRoQWVVkOKIXSocDBJ+kwa4DP+5TPmBHN/uQz5+qBIiDonoieN84jZHym+r
 YCz7nI+sgOkPpISZrXl3YUOLv5VUMI5bEwyEAPvWISpLWJeGaQId1l+gX+lb6Z01IPwZCdrtdoX
 BgIbP3uCOvAVGcQtzTYzk8JeklAzlGTghiqEJRk57RjHOuwlw7aMN+HWdxjmkTnvs4VFbl9nolO
 pIS0Ie2Z2JE1aocPfvQ/H22sdwZmU3qvdF0vmK9kllVq5mKo93GQX9EPYOvwWhYD93kKMoD2JTm
 gZu0OgK2jLlLBLdmb/Ubh2TvrWBDLiJLz4XBKuJ6DN4ffk9Y8F4J4Zz7Mzu8Fvp9VOEDgdE2Dqw
 eWm4O2ni1o+SpmZfp4+6LVMh7WE6po8lfIRNEstUM7YLQOQ6Ijiwk/R1LNUqCtd78QKP/yRCv7N
 nlamHJuf+LCxRjkkiXu7jyB4JaFkQ==
X-Received: by 2002:a17:90b:1b0c:b0:39e:6c69:f46e with SMTP id
 98e67ed59e1d1-3a098cf46damr8586059a91.45.1790499876714; 
 Sun, 27 Sep 2026 02:04:36 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 078/101] tcg: Generic expansion of tcg_gen_extract2_*
Date: Sun, 27 Sep 2026 01:59:48 -0700
Message-ID: <20260927090011.10724-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0e.google.com
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
 tcg/tcg-op.c                 | 69 +++++++++---------------------------
 3 files changed, 18 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 040bdbd24a0..9fbf582e413 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
-                          unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -164,8 +162,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
-                          unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 82dfc90009c..a237ccd0c51 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -26,6 +26,7 @@ DEF2(ext8u, TCGV, TCGV)
 DEF2(ext16s, TCGV, TCGV)
 DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
+DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b7b3451a4f8..98f21004a84 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -183,20 +183,6 @@ static void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4));
 }
 
-static void DNI tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                 TCGv_i32 a3, TCGArg a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), a4);
-}
-
-static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                 TCGv_i64 a3, TCGArg a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), a4);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -693,6 +679,23 @@ void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
     }
 }
 
+void tcg_gen_extract2(TCGType type, TCGTemp *dst, TCGTemp *lo, TCGTemp *hi,
+                      unsigned int ofs)
+{
+    unsigned width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(ofs <= width);
+    if (ofs == 0) {
+        tcg_gen_mov(type, dst, lo);
+    } else if (ofs == width) {
+        tcg_gen_mov(type, dst, hi);
+    } else if (lo == hi) {
+        tcg_gen_rotri(type, dst, lo, ofs);
+    } else {
+        tcg_gen_op_ttti(INDEX_op_extract2, type, dst, lo, hi, ofs);
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1122,25 +1125,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-/*
- * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
- * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
- */
-void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
-                          unsigned int ofs)
-{
-    tcg_debug_assert(ofs <= 32);
-    if (ofs == 0) {
-        tcg_gen_mov_i32(ret, al);
-    } else if (ofs == 32) {
-        tcg_gen_mov_i32(ret, ah);
-    } else if (al == ah) {
-        tcg_gen_rotri_i32(ret, al, ofs);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
-    }
-}
-
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1677,25 +1661,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-/*
- * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
- * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
- */
-void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
-                          unsigned int ofs)
-{
-    tcg_debug_assert(ofs <= 64);
-    if (ofs == 0) {
-        tcg_gen_mov_i64(ret, al);
-    } else if (ofs == 64) {
-        tcg_gen_mov_i64(ret, ah);
-    } else if (al == ah) {
-        tcg_gen_rotri_i64(ret, al, ofs);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
-    }
-}
-
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-- 
2.53.0


