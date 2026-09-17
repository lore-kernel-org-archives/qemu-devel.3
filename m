Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94906C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73pK-00069h-Ms; Thu, 17 Sep 2026 00:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nT-0001dq-Ue
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:40 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nR-0007Gf-61
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:31 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae7166ebso227740eaf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619548; x=1790224348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HXwU/5j4KtERak6jo70M49+VKCzt9WL6aEjpNt669Ys=;
 b=Tm9vnad2q28sIAM6txGV3q+wRAyprhKCpJk+f3jMqAt3TEBE7DLo0sXssao+/HjsEM
 t3oi575rAseyhnEjQcv6pdACprV8HKwNWD8cVOjUV/0ebXno4ZLF5OWppL8cGKZbzzAk
 JoynBJtMClfthABwaHfledvWzpiYglNg1QOaqS3loRzBlO6+x99D3jqHer/WMcEpynY5
 5UDx85S0RWwicAFeHrfIkSYdikOAGWR+UJWP6Gbu+b3R/cyWyOW6IaHJK2/qV58SzSeY
 iUcBmOWRkyPKwjq+Ub/uIwY8WIhbiA9AMppr1gesZ7i9o7nExQhcwwVHC09JoztSK7ol
 ee7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619548; x=1790224348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HXwU/5j4KtERak6jo70M49+VKCzt9WL6aEjpNt669Ys=;
 b=VpGNu85DFbdQSrjHHYXSpVtvrrsEfVtLiAu2SNjicb4tFbqwzB9c5PYHDNpsz+swKJ
 dF8bqJoNBvVzF0U/LYgX0EgSkDO+0vqFco25twNQphONTMQpyG3GCcYXMbEkz841AvCA
 91TEfA0bfaNjNhIUsnVHr3BR7jIUJXy8agCgUfFNS7U/nd37XSN8n1F8YZEFOgudY6Xv
 PDSpiT3SzGmfN4ozDc00pltm8WBgq4nkEIeDjEa9C3J/qnMvzo4gj21yufvkx1em2rwV
 Q1uyw99kGCFvRWHbehCVspBC/emAJbcsttRJq+R0O+ZMDpDmcAbabQGTGILR8CieVOxu
 BIqA==
X-Gm-Message-State: AFuF++mBQrCreyEMgVMbTmeeg9d2ApChYD4TYhWqPRXLNXskV+4L/w2r
 MJvKUOvp+1N9pVYbNcBLZaVd/5CVkHX6tYxzFjImfDFz8PCM2QZ3vMLKyYO7ClfZmqWEvVsGdqU
 +u+m5ywM=
X-Gm-Gg: AYBFou3tNbaPE+EX86xlwVSwkMHHKgWOCTqoNJ96Ti0NgSDsZ2RcpzzigPgHA1ije/B
 MTR+k6TI2WOAY9nq2VdOE7lM70AhD497lArPi4Y6rcwiGdFH54nKvQ0FqnbLdbfDLGrH5E9cM4V
 KS5sk1rvb3xk4x51NOamuwNBMB1LDe8UvJxFOJBG+WIo7tcm6AQuTwUeN6eSDCLjO/XFXNREDdu
 U7XVGy+stD7oVEC0H3f3XobG2dPojOMv/zkI8P4XdrmUKgks/455erYWTE61n5KJj6huzGbaRJg
 Q+jvU3K2CKMEHKDmrk0voYdrRAAOyLEPyuifw7199lnY7wd6tRAq4ypArsp6cCOCQ9veGkmO1jY
 OdAk9mGU0c/TL8P7bEgLhPzl08KetZ7JwexYykazpOWB9MrNTwPd+LfgT3T53RAtqQplDSreUzU
 qXS0o1zXIpyrr0QSGFaW32ThzBZvd0ytEGhgX5UoPL88nXg0a85hkgW/5rRoRqe7bzWbd6y85W9
 A/pd4Eo6wqstkryHQ==
X-Received: by 2002:a05:6820:614:b0:6bd:fbe8:fb95 with SMTP id
 006d021491bc7-6c7d46e65f3mr5558996eaf.60.1789619547746; 
 Wed, 16 Sep 2026 21:32:27 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 059/101] tcg: Generic expansion of tcg_gen_ctzi_*
Date: Wed, 16 Sep 2026 18:27:41 -1000
Message-ID: <20260917042823.542588-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0d.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 45 +++++++++---------------------------
 3 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1f31253263e..96a8ba3026e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -186,7 +185,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 47627a343d3..9968ca9516f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
+DEF3(ctzi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2767748ae79..ad738316293 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -543,6 +543,7 @@ static void gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
 static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     g_autoptr(TCGTemp) t1 = NULL;
+    int width = tcg_type_size(type) * 8;
 
     if (tcg_op_supported(INDEX_op_ctz, type, 0)) {
         gen_op_ttt(INDEX_op_ctz, type, dst, src1, src2);
@@ -552,10 +553,13 @@ static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
         t1 = tcg_temp_new_ebb(type);
         gen_addi(type, t1, src1, -1);
         gen_andc(type, t1, t1, src1);
+        if (src2->kind == TEMP_CONST && src2->val == width) {
+            /* No fixup required. */
+            gen_ctpop(type, dst, t1);
+            return;
+        }
         gen_ctpop(type, t1, t1);
     } else if (tcg_op_supported(INDEX_op_clz, type, 0)) {
-        int width = tcg_type_size(type) * 8;
-
         t1 = tcg_temp_new_ebb(type);
         gen_neg(type, t1, src1);
         gen_and(type, t1, t1, src1);
@@ -586,6 +590,11 @@ static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
                 src1, tcg_constant_internal(type, 0), src2, t1);
 }
 
+static void gen_ctzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    gen_ctz(type, dst, src1, tcg_constant_internal(type, src2));
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -913,22 +922,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    if (arg2 == 32
-        && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
-        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
-        /* This equivalence has the advantage of not requiring a fixup.  */
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_subi_i32(t, arg1, 1);
-        tcg_gen_andc_i32(t, t, arg1);
-        tcg_gen_ctpop_i32(ret, t);
-        tcg_temp_free_i32(t);
-    } else {
-        tcg_gen_ctz_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
@@ -1774,22 +1767,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    if (arg2 == 64
-        && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
-        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        /* This equivalence has the advantage of not requiring a fixup.  */
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_subi_i64(t, arg1, 1);
-        tcg_gen_andc_i64(t, t, arg1);
-        tcg_gen_ctpop_i64(ret, t);
-        tcg_temp_free_i64(t);
-    } else {
-        tcg_gen_ctz_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-- 
2.53.0


