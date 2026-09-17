Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4194FC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73p2-00052p-3T; Thu, 17 Sep 2026 00:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nb-0001gW-RJ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:43 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73na-0007Ih-1s
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:39 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b390bcab0cso223101eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619556; x=1790224356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W/VQs3Jn14XjhyrAw70ort8Z0kIwCKyMhJiUF4aHouI=;
 b=KLyCiewCJZERX+NXt3HKzl6kXAe93EQZPr62nKarBlczpnLEi+u8K6ajoh6QcRneNX
 zkCyL8f6xpr8njDmmkoMSIpQwwanay75oLKANfyXnOsXjxHiCos1YfTYRsY//mhxyFnH
 XlS0P5yQQU4YsLGbeexyjli3f1JS/8HCJ3W0sI4ytPHQ3QeQjFD0xLXOcbud+Am81bPA
 wbHAMNTz/GqlWgD+/T6E7uR5eD1cw3PBHlBAsyc82DoStTX5znxD9G6aC/e6UpC47W2H
 ijzgWE851UWUZqirk7xSX3LZS/T62bvoKOp5syS3K/OwawwQdAmSiuth60DkCswK+oDY
 X6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619556; x=1790224356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=W/VQs3Jn14XjhyrAw70ort8Z0kIwCKyMhJiUF4aHouI=;
 b=nOn4HKErR60bG6fiIQz11LCuoh22sr/Wqj7ZejN23ZY+K1u7R2bYhwosLRLy75Uku4
 7GK0flv4bxVqU0/dFM3wnTAq99IJGVVzHUpKhISRunP3bZ/ueXYjioU7bQ8QF7+vPL6M
 Ug9Sg4nZj4O0MdQNSvSh8WUrogr+8C3X9KyFt/qtEZW1quA9X5RqiDldC0PAt3Em0tGs
 /ACR3BHy54NAistIvVPeeGO72KmaAAns0I1aq0NNRm2iugCbYMDzrU95J1E0ywK2b8O5
 cQaDFkTJXKHxgHI0O2sV8RML31S1llfEhNd0DIqCdCdlIFb9BdervJppym3aYfyq54mP
 Tctw==
X-Gm-Message-State: AFuF++lQb5Na/WN7rVtVCnkPQlkZj/GGzkhwhZZPhNXVBQFJn/Om7XJ7
 3kC8BDnr/iKQ428x0yDH+21Ol6QUiw7KOG1wbeJSG9WKfRrTYcn17QcmwQoaoh+wl5VJiMlOONg
 BGVdlsdk=
X-Gm-Gg: AYBFou1MIzLUISTCZpgtwMQt0aQSMqi2vao29yJxVSezmNbEd0mQHhFHVqVSiQT4O4X
 yFAdrwqS1JJTEADy+OKPRKC0Gx8gHMst6/dT3iCV+V5zMU8vGUXhyUPj8YgPBnjd0QN+L9QIBAc
 6x8zm2+1Vmx8hGz4OeQVRdWrgN29zd6lPdto4a49nVJwmCPAxdqEodZa1vGTdIAqW7Wty7C9cKc
 SjriygDvgI9iCVKmeORyKyTazWNdcuBuqZxWSkdfzVF6ah1T1mIemkTenlUZJCkccegHGQRsKHx
 Pv/pRt5zsgqOgGHVEKvVg4fA5/lINDZZMAGCxTvHUA+Hq9xD8JAsT1dl6P4ndNLCXO8ZVtroY7g
 jokz8oLBRD65/iao0XJ7m/KbRe9/bBMHlhlkR0ZUVBjSZwzoi/a08iOh1F8ixYmscYvA8FmUoBF
 aFuES03TvDtMwaqpB7NZBZirwtYUoGWTotlysW7ZIxMCiH191bJtiHjduUPTzDQIr5TgxB1mK5i
 gHoQbg=
X-Received: by 2002:a4a:e909:0:b0:6bd:b927:673d with SMTP id
 006d021491bc7-6c7d11d6583mr4965177eaf.13.1789619556054; 
 Wed, 16 Sep 2026 21:32:36 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 066/101] tcg: Generic expansion of tcg_gen_extract_*
Date: Wed, 16 Sep 2026 18:27:48 -1000
Message-ID: <20260917042823.542588-67-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |   4 --
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 131 ++++++++++++-----------------------
 3 files changed, 46 insertions(+), 90 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b9118a6df08..7973738331a 100644
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
index a2244bedeb2..856338aa0d4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -17,6 +17,7 @@ DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7c5f6ae8e6b..ade5d8bf835 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -692,6 +692,51 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
+                        unsigned int ofs, unsigned int len)
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
+        gen_shri(type, dst, src, ofs);
+        return;
+    }
+
+    if (TCG_TARGET_extract_valid(type, ofs, len)) {
+        gen_op_ttii(INDEX_op_extract, type, dst, src, ofs, len);
+        return;
+    }
+
+    /* Assume that zero-extension, if available, is cheaper than a shift.  */
+    if (TCG_TARGET_extract_valid(type, 0, ofs + len)) {
+        gen_op_ttii(INDEX_op_extract, type, dst, src, 0, ofs + len);
+        gen_shri(type, dst, dst, ofs);
+        return;
+    }
+    if (TCG_TARGET_extract_valid(type, 0, len)) {
+        gen_shri(type, dst, src, ofs);
+        gen_op_ttii(INDEX_op_extract, type, dst, dst, 0, len);
+        return;
+    }
+
+    mask = MAKE_64BIT_MASK(0, len);
+    if (tcg_op_imm_match(INDEX_op_and, type, mask)) {
+        gen_shri(type, dst, src, ofs);
+        /* Do not recurse with gen_andi. */
+        gen_and(type, dst, dst, tcg_constant_internal(type, mask));
+    } else {
+        gen_shli(type, dst, src, width - len - ofs);
+        gen_shri(type, dst, dst, width - len);
+    }
+}
+
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_extrh_i64_i32, TCG_TYPE_I32, dst, src);
@@ -1067,49 +1112,6 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
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
@@ -1814,49 +1816,6 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
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


