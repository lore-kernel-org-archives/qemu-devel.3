Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6BCC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBL-0004BP-V8; Sat, 12 Sep 2026 22:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBG-0003ZH-9J
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:58 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBE-0001z0-LS
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:58 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d90ba1d807so14886145ad.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267375; x=1789872175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hNY1gUIxZV5dYYUYh+m4OSDfwTewfT6kHZGRJwySQMA=;
 b=sREEVDoaxI76o/WVQyhKYhZjMa2wG68mrlR7etRETXgEVdoDfbuk63y9EFwkW5WfxR
 oY1khTgjO64t2Pmld2Z04UE0aHeHu0yOvZEDlGxP8EoFbUvlnf28U1VXIxz5ybb/AqQ9
 J1O5/hnecymBHv8xFlxoutSfZgXDVDamgqDOALMLigQAX6BxPnQVGZHfTYmrcWyZwZSs
 sG8niLULe4iW7tlayhe+O99ZR1yioQVvzHYsc6gvN9UbawkQLHAmg44/goNZxZzpX2QK
 by3ZOecFO4Ie68E48G5cIpzH6kdr9TcARzar0XaCchzZH1JvjcD/0RF4UnKHQXZYIXCw
 hIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267375; x=1789872175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hNY1gUIxZV5dYYUYh+m4OSDfwTewfT6kHZGRJwySQMA=;
 b=Cm1ZPSHw8sXh4Z/0hO6sjyNSwqg2fjZnMVlcHQz4T7rm+CHcq++9O1X9Da+3VNsXzF
 BLNn0QcEChkSW0+5fuZS8nwzO1itv5K8OG7oQcLWJE5ZKPqDXC/UFI/1ajuhY+DlcMhy
 34VzGd+abfY1psll9lmWpEZ/EA1XzZPOM+D60OFQDaMjzH+a/eGAASWt4lDq8FtW804g
 7aFyOCKny64Z5GL62K+gGxHJvq/LdOGEGOxqQ3+VGgSvzepycQuDlB7V4w3m+MyhL+nT
 h+SlIMe8zfTJ9XspJ1JExUpuh3F23it8dObbL9egRIP6D7OFe48vRibF7PaToKTGFbMW
 w0pQ==
X-Gm-Message-State: AFuF++lzNGZM8hhV9lCoNfxYVpXSTGS/IYVLvpk3Loz8ApGupToEHHh9
 eTTMyd0gQ7Y5TuZHLPBIVyAenWV8T4E+U6TkWC4NFeHDIdamtU/OKb3MvgjpABx4EqsSIJBtqlS
 6e+Ik0o8=
X-Gm-Gg: AYBFou204YY4Y7TrbCO3mVGfh+vQrgap+0zzDeWvXN5Qg4qw6ZeGsCWP1YW2vOuVKO0
 4yI2a3+Micvx2mLZ7Tx3ZtD5SmR1qai2Hr0C1xYe1wlHlYvZrKTzcYQ7j+kbcHgCaDKWBgNrCBq
 ragbtVp4Aa/WrznunXm+KIrpsVCuoPpdGZFCKrs63tga4XrL4HZw4xsQo/ij3K3DRcRGL1Og5EW
 Nd8WGEE8L8xWfI8ypqBO9quBlqTD54KpmxA2i2NJTkzDzzMsl6J2AsUs9cYoXmxfE/rrn/tcQLJ
 KFnly3+jm3sWkoUgVyua1ae5GAKAxPcG5j8HQHG2WDNtp8j20WYaWagKigAcj8OPMX1kF2MfITh
 paNDAPE4rgq0cVilrl7mRY5JfVb1sLAkpor/THNn81w84ZuFPe0TmGvT/6gv7jXaQuI2uxLUW+g
 qT7Y0QK5Nv6foTlbwvkRCCQZmOmXxNWjyuk2rYNL5ntDYPM0UYCwK/NUQ4InjevmRwN6Ffcqtaq
 ovfxhZEBeBQD5FqHg==
X-Received: by 2002:a17:902:d551:b0:2d9:4871:393d with SMTP id
 d9443c01a7336-2dd2a45aef6mr209701035ad.21.1789267375302; 
 Sat, 12 Sep 2026 19:42:55 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 69/86] tcg: Generic expansion of tcg_gen_smax_*
Date: Sat, 12 Sep 2026 16:38:20 -1000
Message-ID: <20260913023837.741866-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 5ee14e28439..e2785ca61c7 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -188,7 +187,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 2ccdddc8eeb..a5330ab6a1d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -54,6 +54,7 @@ DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
+DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index dbccb7af811..8dadba7ab95 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1133,6 +1133,15 @@ static void gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_smax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        gen_op_ttt(INDEX_op_smax, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_GT, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_smin, type, 0)) {
@@ -1467,15 +1476,6 @@ void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     }
 }
 
-void tcg_gen_smax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_smax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
@@ -1998,15 +1998,6 @@ void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     }
 }
 
-void tcg_gen_smax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_smax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-- 
2.53.0


