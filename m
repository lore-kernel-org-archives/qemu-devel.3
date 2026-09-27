Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DB7C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksP-0007i7-K1; Sun, 27 Sep 2026 05:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAko5-00052n-3u
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:27 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAko2-0007fl-Dw
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:24 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccafb751so1006349a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499861; x=1791104661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OscULSjy8wssqzSVr96JdhVkFKqur+1rSjrLAytjFYQ=;
 b=gW8kXC6miZwT90GUMydYpy/b97bGwuZDAiOTVUGBXvI6b1pwUadw8FxwsukUAkgRHc
 vgLMCpLkNsxkhY/FBOVkU6LbxYJdCcqdie+53CQ6KJ2GOmI/9DE4W4y6xuEQpnWj2LVT
 9ETkYT6dBKmnl5P90Hk9Mo/38Qi3KaB9QA4TSMHkogFv1bEKWxArm7/KJZ4RwfEYvH3h
 bLEsBIehd2IjPUGz/C4YxRqNUuBHpJlomFZDuqf1VlzkeiKJb3ocGbsxWXam1MkablZI
 xk0kZg1XO44BuayzGw6DSxe6Umtq8dgNzgDWR5tl2UbX8xE6QQ0JTCZWYcmhHVCTg2R1
 OshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499861; x=1791104661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OscULSjy8wssqzSVr96JdhVkFKqur+1rSjrLAytjFYQ=;
 b=WMSwdvjg4fkDoHY+k5LkL0wIDmolXN3cbq/m8BCHlMDtEzGeNm4U4Co6G1UAqLEF3d
 LY4/bvsBWq3JzSCIj6gXOtwT7spd54OUTl43k7uiB+itNW1gopB8pnDGLQlsCCuWoUx4
 jmgLBesHrZKgcj98hEiye5MEx7Oc5AHTL9OHtlf70nwwLjWDRqWrGGGQ+td4aIPLt4cu
 5qT5MCY+MnUDUaId0aERjQHiGnIqfBkgUJEW/seFNsso3WYKVl0IBRO4nUT6VH5V0Unj
 qz1K1LgLRjmhejtdc/LLQ/gfiPxAV298/uVGgQf02Z84Hej88I/d4WITeMT9OGhF5OhT
 rcOA==
X-Gm-Message-State: AFq9FYLZfWQox3dCvLKO3FD9Q/vGfErcb0zxHd9lCjJIo93UKqnRebv3
 qtYR5XbL1Gh8FKQe+OnjykqbLhqX41VW4Kn3XzgeAlhiwz5f1kFgpgYUwUUTguJ5cwf97nFTnFL
 Ai9T+
X-Gm-Gg: AYBFou2v2zOZJKITNXQD0C6aJpvdZ/5Q74j6gMfyhd/Ec4i8tzzsNdH6Vb2Wiob6A4q
 /S32uTjy1/cae5NoeZuW7fnTCOttgD25T1bjPnyBI7PgRUhDkifwBB60rHLKxxWxQ2cK0a3QMak
 KsF7WmgIaWvNqO8v+lsLDH1548bPP9kQt+8pwM4z0z6r6WV47LrM0rw0+4Z1lsee/MwXONAmhmn
 U/5gW5WGIpBqHgks6PkEFCSbmOm2QYFx1JD9xdNwhj6CcP0KXn2S3rNRqfzXOrsBXglbyzrSKmD
 xwSCuNyv6jijUSKcZ2mP+UmhIeGlO7QCXB3/x9ZXs1PD2T6bRs0iA+gk5NTkfKiRfAKw1QgIt7B
 xveSuPtly9qCf/zeZo9Es/oKYlep/MNFsF/p5CT3EPwXMQkfk3iQHkgA657AEzT8G/0SIsv+WAW
 n0ld1ipPrI/xQW8LQSpgO6hDqfYfq8UKjLoEGMvdHLJM1t5Cn7RUNyN2nfVJ5HRkp9hI9OMI0O6
 1/abRbDMwcGCpUt0uoihTeSUG10ZnuBwxtr2v+n
X-Received: by 2002:a17:90a:4c85:b0:3a0:aa65:2bb6 with SMTP id
 98e67ed59e1d1-3a0aa65315bmr4409079a91.29.1790499860936; 
 Sun, 27 Sep 2026 02:04:20 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 063/101] tcg: Generic expansion of tcg_gen_extract_*
Date: Sun, 27 Sep 2026 01:59:33 -0700
Message-ID: <20260927090011.10724-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
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
 include/tcg/tcg-op-common.h  |   4 --
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 131 ++++++++++++-----------------------
 3 files changed, 46 insertions(+), 90 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e3d6c9bfd8c..ec4cf775b38 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -134,8 +134,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
@@ -183,8 +181,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 95885d28d83..69f76f1d232 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -18,6 +18,7 @@ DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f5771240803..a7d815b9e16 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -608,6 +608,51 @@ void tcg_gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
+                     unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+    uint64_t mask;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    /* Canonicalize certain special cases, even if extract is supported.  */
+    if (ofs + len == width) {
+        tcg_gen_shri(type, dst, src, ofs);
+        return;
+    }
+
+    if (TCG_TARGET_extract_valid(type, ofs, len)) {
+        tcg_gen_op_ttii(INDEX_op_extract, type, dst, src, ofs, len);
+        return;
+    }
+
+    /* Assume that zero-extension, if available, is cheaper than a shift.  */
+    if (TCG_TARGET_extract_valid(type, 0, ofs + len)) {
+        tcg_gen_op_ttii(INDEX_op_extract, type, dst, src, 0, ofs + len);
+        tcg_gen_shri(type, dst, dst, ofs);
+        return;
+    }
+    if (TCG_TARGET_extract_valid(type, 0, len)) {
+        tcg_gen_shri(type, dst, src, ofs);
+        tcg_gen_op_ttii(INDEX_op_extract, type, dst, dst, 0, len);
+        return;
+    }
+
+    mask = MAKE_64BIT_MASK(0, len);
+    if (tcg_op_imm_match(INDEX_op_and, type, mask)) {
+        tcg_gen_shri(type, dst, src, ofs);
+        /* Do not recurse with gen_andi. */
+        tcg_gen_and(type, dst, dst, tcg_constant_internal(type, mask));
+    } else {
+        tcg_gen_shli(type, dst, src, width - len - ofs);
+        tcg_gen_shri(type, dst, dst, width - len);
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -964,49 +1009,6 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 }
 
-void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                         unsigned int ofs, unsigned int len)
-{
-    uint32_t mask;
-
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 32) {
-        tcg_gen_shri_i32(ret, arg, 32 - len);
-        return;
-    }
-
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, ofs, len);
-        return;
-    }
-
-    mask = (1u << len) - 1;
-    if (ofs == 0) {
-        tcg_gen_andi_i32(ret, arg, mask);
-        return;
-    }
-
-    /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, 0, ofs + len);
-        tcg_gen_shri_i32(ret, ret, ofs);
-        return;
-    }
-
-    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I32, mask)) {
-        tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_andi_i32(ret, ret, mask);
-    } else {
-        tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
-        tcg_gen_shri_i32(ret, ret, 32 - len);
-    }
-}
-
 void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len)
 {
@@ -1711,49 +1713,6 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 }
 
-void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                         unsigned int ofs, unsigned int len)
-{
-    uint64_t mask;
-
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 64) {
-        tcg_gen_shri_i64(ret, arg, 64 - len);
-        return;
-    }
-
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, ofs, len);
-        return;
-    }
-
-    mask = (1ull << len) - 1;
-    if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, mask);
-        return;
-    }
-
-    /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, 0, ofs + len);
-        tcg_gen_shri_i64(ret, ret, ofs);
-        return;
-    }
-
-    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I64, mask)) {
-        tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_andi_i64(ret, ret, mask);
-    } else {
-        tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
-        tcg_gen_shri_i64(ret, ret, 64 - len);
-    }
-}
-
 void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


