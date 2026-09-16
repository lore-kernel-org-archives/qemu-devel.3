Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DDBC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNc-0007CV-OF; Wed, 16 Sep 2026 09:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNO-0006mH-DM
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:41 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNI-0001S5-HA
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:37 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b1ae6b1b26so507786eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564111; x=1790168911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kCg8AkOuHKsO98eKWzdK7y3U9Jh0cctJSXstXq47QjE=;
 b=VISivfo7xBjphPovVHARlh8DWA0mg2q7skHJKtdL6S+u1z4zAWv4gHAwFISZHjV8wY
 YqRONndJrKphW7tHlVSePjoEp/MWcdMMkC91eWgqhrxlPbmcK5/XY9O6n4i4ymt9vaQE
 oLkoeXKrFPbRnMd1mFdACPPq4CFV0VIKdrsL9IjZ04S38HLWYDy3uP/ifCTaKDMsbkdi
 gOiOun3k1FRbrcmXMeYuCkhriGMigy2WLJcHSIfbb2R1R1HamCpzM3nLI0SprSSLCqh+
 mx1XOAJJ71pmI3SzDEQUPkHOxrl5T/wsa3FRxTeoPzsmXxfnnFanYOJfXRIV6MjKooJn
 V/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564111; x=1790168911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kCg8AkOuHKsO98eKWzdK7y3U9Jh0cctJSXstXq47QjE=;
 b=LTSulsyCOORnXe83uzbJsEzuVhzeoakIM6aGEIMMG0E+zN1Qq5zlwWfkIVYN05fX8k
 uVZITupysuU6Ou9NbDXKruJeNCifSEx+W6O130JEITrIugWldseB2Q89x0EYUpbQsjk8
 iJ0EMBkT6zrgSkHNWkP/+qzr7lVZFaMRv797HP9msZe5HvYYs1zrWJOH2dAZacFfbd+D
 ZoBFMBwHfKPNT2XYfzGiVtfPkQeV2FxMhkKXDmQpttp2sN/5vnuO2T/2cQNUzn1zqObO
 AoafBk7XtpzZZjiS0sqG1wuhwn+wsZGpXzgCKKYrHuFstsfv5ZZTbfE3Gsi2Gw+WXGyL
 38Mg==
X-Gm-Message-State: AFuF++mDatqIl5wvTlMOt3u+LMFHF89bCZu0vHcm1TBd1IpLTwgCW2du
 9PHCXHNHbNHswsqoBmVbrfX4PS9mG/YZoK8CXwLB2CgNH/CiIvL0nKj/eaR9x9sTIkAxfK9bqTJ
 Na4X8viQ=
X-Gm-Gg: AYBFou1My73RU0udEIvk35x9Su8NU6WjOFcsmF7OhFfcQHTJ0OCAjyy0H6zEWfM+ZLQ
 CZLQsnkZlntnX0GTfX+ZZbDPyYk8Tj0q5QxIt+B+eIyKl2GREb9vbiFZ/pzVFrdhCon7dq/bUA1
 tQmPomHsD8v3qoWRwUhY/f8smztDsiV0zSHy2l/AfHgQRiQDOR8r0pHpUa8as5gHJVub2/RJi77
 bWa5i45eaIjfQDH5x6t2AtBymgdkV8r9yaFWzZfPS3k6Z5rRfL3pQMYX8n1XlkwVKq9PQ1WPJKP
 nU5C3uJRXypZi0BDdWaOMy+5ZBMXYkxxV2YQeb+YOdQBAereXD3i/0ETslL3IyMmK7iYzIVKCaW
 rjg+vnfEqh3jfEtkprB+pEdS0kbe8D3lEZ5a/fRdvOOU2ytsA5Y568jflgzjiyPoTGwzsigQ57j
 XQjeAPQOpojLUrStrAf0J5T7oS1uClkvhvL9dOlWIACXn/394YbP/Lm433ZaiN/C8eGfpdjS8jL
 1Iy/ZU=
X-Received: by 2002:a05:6820:161f:b0:6c1:6940:9a7a with SMTP id
 006d021491bc7-6c7d52f75fdmr2474242eaf.66.1789564110762; 
 Wed, 16 Sep 2026 06:08:30 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 57/92] tcg: Generic expansion of tcg_gen_clrsb_*
Date: Wed, 16 Sep 2026 03:03:32 -1000
Message-ID: <20260916130409.3382710-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x2b.google.com
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
 tcg/tcg-op.c                 | 46 ++++++++++++++----------------------
 3 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 96a8ba3026e..79bb00b4a5d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -185,7 +184,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 9968ca9516f..1bdf9876067 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF2(clrsb, TCGV, TCGV)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 00f6e7983e8..424ee358803 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -496,6 +496,24 @@ static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+static void gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
+        TCGTemp *t = tcg_temp_new_internal(type, TEMP_EBB);
+        int width = tcg_type_size(type) * 8;
+
+        gen_sari(type, t, src, width - 1);
+        gen_xor(type, t, t, src);
+        gen_clzi(type, t, t, width);
+        gen_addi(type, dst, t, -1);
+        tcg_temp_free_internal(t);
+    } else if (type == TCG_TYPE_I32) {
+        gen_helper_clrsb_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    } else {
+        gen_helper_clrsb_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    }
+}
+
 static void gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_clz, type, 0)) {
@@ -934,20 +952,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t, arg, 31);
-        tcg_gen_xor_i32(t, t, arg);
-        tcg_gen_clzi_i32(t, t, 32);
-        tcg_gen_subi_i32(ret, t, 1);
-        tcg_temp_free_i32(t);
-    } else {
-        gen_helper_clrsb_i32(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
@@ -1779,20 +1783,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t, arg, 63);
-        tcg_gen_xor_i64(t, t, arg);
-        tcg_gen_clzi_i64(t, t, 64);
-        tcg_gen_subi_i64(ret, t, 1);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_helper_clrsb_i64(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-- 
2.53.0


