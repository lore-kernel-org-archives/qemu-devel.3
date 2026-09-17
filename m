Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94C8C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nq-0002PK-5m; Thu, 17 Sep 2026 00:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nS-0001dl-G3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:38 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nQ-0007Fv-54
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:29 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7f4f0dd550aso116410a34.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619546; x=1790224346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yy3abeA6nUtaEw+wMeETa9hX3DLYO3URccUli7lzrWc=;
 b=hi7sLMVv79wOIn/76f6hClpWR22yCb9KNnwDHEzZYaiH4z7ABnmthWx0DpgAWuAnEy
 e7tm99EI/1AI8cJF5xsBlogbnRg/JzFRxLrVlUW1ju6dY6dgphi+AOD/jodDNyPN9zWh
 +8m+gIYWK3/f/NhaKhnDZ8PoNqK8MhnaxEkOe0GduVyezDIim0eV1v8AACk/IkfPRoU/
 hVBpCYxBotJJPeEzhGvAgFdDhjxXFk0OYiQ0u2ZXMb6XfdvihpMOPVy9qQ7/GHKiu8U9
 8uHfx/5zwXWxbMkspEFKzuUT+mJ4kOyIQJkHQaOc2D+53n4ltdsbOAJtOG5Hfg1Tmlr+
 c/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619546; x=1790224346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yy3abeA6nUtaEw+wMeETa9hX3DLYO3URccUli7lzrWc=;
 b=GoGvIGawg3QcWEcAZqSUdERP12b3+ZiQuHh4FCrOomIwlxc1J/fZcOG6mc8DZfLF9k
 JITbWAiG2EmePpEnb5jH604D1sNiogXXf9Q2OCn1hOfBuxXtrTzVvYBeJk5tGfTMJulh
 DJbM9dFR6iS8OjrA2QEcETWUarwDL/nQaij+KvMDy7uz0LcfZZLRFuSEg8mbh3ImLDiL
 JyPn0MfPiOI9cRQSichhiGBTElMm30CJazhFuijKXytvSdSeGNv3S0g6NpW2blgQfo04
 oi+F+YRy2pbUirkNuN4FonF4K0vMy/cAIROlzT3qiwsIdOqwR1JjfK9ql2VPXWIjG2LW
 EgGw==
X-Gm-Message-State: AFuF++mHUiqCnZf6QbRFIuz1En42mdhDvUdXD+UWd5O21zyMlDJY/isd
 5RvqdbYQAgC99U7RZo+PpCjjTcmnBawGT7ax++4zodu8fms3t5sHsTG5EG49gB38DEWpBPHBVaH
 5ge8uUgU=
X-Gm-Gg: AYBFou0Tt7oF/VFHG+MPCASHd+qu7n+S6ku8WrH8hRjHQv8MSOPxmb7knUfK/qo6J/2
 dB/H/Wf2MbNkpV/i+tUG+j5XPjIAMA6tmpIDMtYxGrQ7ijbGk5cNG/FNNgPwy77qfcFiJJN5Qq4
 pixznMk+tQipGdT94w4Zwe8Us1ANl082hyI9vSD2IQrbbS9xohiOQ1YAIxZOb4e5FX7qJ/eoXrj
 Lvv+ET+fe7yQhj1oWL4qMM9jLTpgYQSFrK0pyFWSM6P/JgeZK6MSvxGGGv0lQpJngWvhEOr74Zp
 vbX8Z4In64a+2vgwF1OszCR6Fq6ttJbBbgc0JU26KF++/lMylvLMP58CRbxcvKlWaa3Fb7TWVW4
 rD692/ZtpOX6oKHe/kvDP3QPVIHQlX+crmUmPc1QgfS93q3p9sX6AMSUDy3+l3x3r74W5EJo1ZZ
 CN7AetGBd6Wo9Wm0YnvR/N4r21h0iVFLG6BfGsc5I99HIVjc+PJQVAiXQg5hFLYtOXLaYG92VST
 KxG1kE=
X-Received: by 2002:a05:6820:f028:b0:6b7:8396:f3da with SMTP id
 006d021491bc7-6c7d47eb175mr5367377eaf.60.1789619545898; 
 Wed, 16 Sep 2026 21:32:25 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 057/101] tcg: Generic expansion of tcg_gen_ctpop_*
Date: Wed, 16 Sep 2026 18:27:39 -1000
Message-ID: <20260917042823.542588-58-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 41 +++++++++++++++---------------------
 3 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b477d980a3e..b3cd4bbf63b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -191,7 +190,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7d0d219918f..2de0aacd93c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
+DEF2(ctpop, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index afab6fd3c82..abc78e480d0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -523,6 +523,23 @@ static void gen_clzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_clz(type, dst, src1, tcg_constant_internal(type, src2));
 }
 
+static void gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_ctpop, type, 0)) {
+        gen_op_tt(INDEX_op_ctpop, type, dst, src);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_ctpop_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(TCG_TYPE_I64);
+
+        gen_extu_i32_i64(tmp, src);
+        gen_op_tt(INDEX_op_ctpop, TCG_TYPE_I64, tmp, src);
+        gen_extrl_i64_i32(dst, tmp);
+    } else {
+        gen_helper_ctpop_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -920,21 +937,6 @@ void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
-{
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_ctpop, ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t, arg1);
-        tcg_gen_ctpop_i64(t, t);
-        tcg_gen_extrl_i64_i32(ret, t);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_helper_ctpop_i32(ret, arg1);
-    }
-}
-
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
@@ -1825,15 +1827,6 @@ void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
-{
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_ctpop, ret, arg1);
-    } else {
-        gen_helper_ctpop_i64(ret, arg1);
-    }
-}
-
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-- 
2.53.0


