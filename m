Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A678BC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAknt-0004bJ-Vh; Sun, 27 Sep 2026 05:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknm-0004RB-Lj
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:09 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknj-0007bp-5s
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:05 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso1120414a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499835; x=1791104635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XlR7Qk+BfMnAouMn5Jgc92VT7YMAdNt0paT1pAJlcus=;
 b=WcJ4B5q9arIXIMF+HVDAFfZphrPa1AANmg5JL5Xgv2rYL/VuZiZynb1+RQVxeuMiFQ
 yjzbx2L2Pe/Pis8zdR/8i8NAr7raz5/gQoDqmGYLDTJf4zxPS+yuAbZ4Zy79tuLGBSAi
 1hzqILPAXhkeFo2GK8XimuwO1sC+HVIzXA3Ou+B5wC+r8km8VFL7l39ZWB5VXoTUE1v7
 f1zsb/wxiddEiBD5/J1jYQ7kXTv3WzU2c7etVlEl1EryEiEVahVAFp7DDq8ky0XJJ7Wk
 vZ+F1z+DjT350MNYY5EeXw3O+1949VLY5NobUuMsE6Kq+ea9sk+EVgh9gbTj3HU8upAO
 eeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499835; x=1791104635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XlR7Qk+BfMnAouMn5Jgc92VT7YMAdNt0paT1pAJlcus=;
 b=eZEfkAyVlF7yQohK8+Rz+yCN+v0uU1zHaOU4klh06wtlo7PjyOg+EvE+58ZBcrA8i0
 sOZ7xcSjK1AV2rbFaMGBSpNKtS/oTQxheZtOOSvPB/aSeAVHjj9TWOv5082f/n4vWAuk
 PxTt6HV3byH4eRFVXZ99ERaHf0BGjNQYklJJOUaNLns/Ic/jHXb6s4w6qicI2KblnJyx
 tGqhVJprEHM3w/wO4CiJN9U2OIqIYKO30ieKBFy6E76jaa/dmCV/OXdQNGThBMvzqHiS
 Oq7YLlxh5/Z6X+pjIwMF3oCHT1fU0DBz1G8MF79aLSNcQe7nVNvRAyCm2Txd0Lg1dl65
 x73w==
X-Gm-Message-State: AFq9FYIRcOhYhWmjZfyDnCMKoMzdLEgwpMaCc4k5byCr6WV5fAMLoCEF
 s4hl2VjVbe4yOoc6TYHD34JZGpf5PgRPgFZDt/L5p4QtM+AG6J6stk+PR+3R6XiBsatNI9EfOgW
 O1TVe
X-Gm-Gg: AYBFou1Qz+Sk8h48cHcy3IZKHKlbzuilbw06bi5h/YMDF8SLkt/Xc/iVglhHthFNC15
 1FV1b5hrOR5xS85A/jXTpXGsfg8r78SocqBsX01H175/F33foC0LK3JBJFLn2k0/wcnP1MZe8MM
 YGhKGulwmC8T3CCUggDmXtSg1ZXV2KcnezmdPJZfymsthSRfLVIktw5puIg/DYTvZeVbcZlCeLT
 qymTfH0gn8I5TxJPVVip8cORSrS+SGD7SMCe1Tpmb/KiaIQZvfBH6FwJzBMzDkZseOp4NBrI5yw
 vQ0q6ZnHsWrMyM09u2tf5trxs1vHUpWE3lWHE2huex0+e8goG3cVxIVbtP437aLFToBSSaJeJYl
 a67WJvbAvGkeCkanEXgLOC65sayPuLr5z4I8vSdXJbUgAdUMdwNNiVaUjU/vt3yocBIRGuHkBnh
 wYUiL46bb9/QbT1BhI61AC/HcutcIX0TtlbG63vnm8VXYo4EC5wepGqwBEh+j32woRTHy3RJoYR
 L5UCGawLPM5SgN5/s+EIdI7tfqLyA==
X-Received: by 2002:a17:90a:e7cf:b0:3a0:e243:28fd with SMTP id
 98e67ed59e1d1-3a0e243355cmr2022786a91.36.1790499835183; 
 Sun, 27 Sep 2026 02:03:55 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:03:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 042/101] tcg: Generic expansion of tcg_gen_orc_*
Date: Sun, 27 Sep 2026 01:59:12 -0700
Message-ID: <20260927090011.10724-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f5bb4d8031f..fadbcbbcde2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
@@ -197,7 +196,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7d94e0cdfeb..fa33d41e3df 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -20,6 +20,7 @@ DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
+DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f06c00f7263..aeac3480754 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -527,6 +527,18 @@ void tcg_gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_orc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_orc, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_orc, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_not(type, tmp, src2);
+        tcg_gen_or(type, dst, src1, tmp);
+    }
+}
+
 void tcg_gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rems, type, 0)) {
@@ -707,18 +719,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_not_i32(t0, arg2);
-        tcg_gen_or_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    }
-}
-
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
@@ -1724,18 +1724,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_not_i64(t0, arg2);
-        tcg_gen_or_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-- 
2.53.0


