Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98C5C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pKZ-0002MN-8g; Wed, 16 Sep 2026 09:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJt-0001Gi-C5
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:01 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJr-0000So-HC
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:01 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a3688a2so735009b6e.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563898; x=1790168698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pXBzmLKK2kYI0+zni+gpeQfaJhIUyxpRdoQvDQizyiE=;
 b=xO9MiM5tYbW1SdDuKiAqu7cTAbnr5eRGED46hLdv/I6jIYy6pDYLa9xTe5Cnpddo/M
 Hb/4cpvNHzmerjbu/vImKn3AGlGc3X+2atQgzyZyBcEg16PAlJh+8KVgpbBCGVh62BRi
 I6GHYDD6eDwRlJ9a35lQQ7jobsRuzNwO6aNHjo68KOGrVAOaNWq3zauyuerYQrWMt59j
 bUn89fum0TvO3C+7GF6oYgBTmy51kXhO6u91ndS02rM9xvZhFfpnG8jh68wQhMZMk9Aw
 HTtKF2oJQb1oVwjinK5DSADKE/hjNp9cmw5RItKLAhBXQydceKAs+Z6AqaoTzSoXZHiz
 bYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563898; x=1790168698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pXBzmLKK2kYI0+zni+gpeQfaJhIUyxpRdoQvDQizyiE=;
 b=bi2FtecYg81FSvxD14XMlGSId7v38KhOIS370h5L4tAHbt7xS/FEyj4GYx+jEqiCQP
 rzAekU+WjBI+/rfgw5Q/c3rswzEPFYFWGXYXh45z2/RpOu+mLcWdXcCpivz5cPoo99Zp
 i8DiqYBfOzUCitSBNZHGR4XKaRgOaVPdqZaZ04Qs5DsizxzEYtj9Nj7/q3Rav/j7sTnP
 yMI/kU3D0IpUZvMktggSApG8hHtHHx6T40fV+u6zq8y9dWvYX47kmzndnoZaT3mwwUue
 4LSI2RG1tp8YlGF2NM36u5ZDCUz2k1jj3J3S2TbfQ2tzOpWXE/jmk7FvLw/uIIZdaaHl
 bqaw==
X-Gm-Message-State: AFuF++mOIJIUpDuNpAdCOeOBpA3webnSXNboQLDH0JqqZkJfimcWC3Ex
 LcatXsiOZdM4i9amNq7stTdm6++0Lw6mc3fLZBLgkAL3TIl/rhbVMSvIxBy29UeB0O3rThGuE7q
 sWVeG5UY=
X-Gm-Gg: AYBFou3shEjZu2akAvKkavO09Oj2gaTj1tIF6TOqz+IS8uL6/ITCNwXVZiY4hTUDE6X
 WT5V6wnPRXVXAyVDQEUjQ22/XWJAOFLN6xyIFpExQXzQ24zFqlX7apG4C9FQdbEcUXkPEJdjnIL
 aOOudYHV7jW4VpUQccKbVl6cr4JgMdD3L1KF1mzNn3xBWpKmO4grvxJNFbH/vkXx8EDV0qb2pU1
 Zj0bTk6FXRFBzUPLEh/SXZknHB8I0lZutlo7+GfgFJYQUrDM69WbEbgSCyOD7UmYk7WCJ98meCb
 OZBUdFhmA2r1jGT5fqP6ZaVLUc0m6mnLvxJAHyNa4A0Et+V8dSgxv8fQthmPXByme5nSOd4rPqS
 gPq8v66ryyKHZztoQCdT3uazs81kBbRmmvhWMVtluRggetJQXJVUDpHd+xwg8a2zRr5POe7U9VL
 kbeqjEp3hpbEzD4PfbS0Lia57mPZwjopEj3XRZSNRHOh93jOS3PJuz5L9ayH3l7WeDM+7DmA0Ol
 O9J4oY=
X-Received: by 2002:a05:6820:1ca7:b0:6bd:cd33:b885 with SMTP id
 006d021491bc7-6c7d3af445dmr2772011eaf.42.1789563898177; 
 Wed, 16 Sep 2026 06:04:58 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 28/92] tcg: Generic expansion of tcg_gen_muli_*
Date: Wed, 16 Sep 2026 03:03:03 -1000
Message-ID: <20260916130409.3382710-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 33 +++++++++++----------------------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cd651d6e427..25e8d27a54f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -208,7 +207,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b620a314480..8e97c1b37d8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
+DEF3(muli, TCGV, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e1338fcbc50..db47364ce78 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -468,6 +468,17 @@ static void gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
 }
 
+static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        gen_movi(type, dst, 0);
+    } else if (is_power_of_2(src2)) {
+        gen_shli(type, dst, src1, ctz64(src2));
+    } else {
+        gen_mul(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -637,17 +648,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    if (arg2 == 0) {
-        tcg_gen_movi_i32(ret, 0);
-    } else if (is_power_of_2(arg2)) {
-        tcg_gen_shli_i32(ret, arg1, ctz32(arg2));
-    } else {
-        tcg_gen_mul_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
@@ -1576,17 +1576,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    if (arg2 == 0) {
-        tcg_gen_movi_i64(ret, 0);
-    } else if (is_power_of_2(arg2)) {
-        tcg_gen_shli_i64(ret, arg1, ctz64(arg2));
-    } else {
-        tcg_gen_mul_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-- 
2.53.0


