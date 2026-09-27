Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17547C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklE-00034v-4h; Sun, 27 Sep 2026 05:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkp-0002Zj-A3
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:01:05 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkl-0007UB-8J
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:01:01 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccafb752so1084819a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499650; x=1791104450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=woNZxwWEOWqfa67jvN4u4BDj/2f3zqAtYHAtH5MUtOw=;
 b=elQFcf9ZC/QQnIZZVjImvTspinTTIGcA21LG8hcrFlwXOEFx/OX6edjeZTBQT6jR+7
 1VwGfgK308OFeBGJxxbjgW4DqBD52azo6UCJhTCXVHezBhlovOeaoeRn0M4b8Qg3+1Ti
 NQGPbOG8qQsX4SkoC3s9mgpwiVNw+4EADk1GnO9Ahv7c2Z6YkepMnaJhDcWznmhrjcuo
 82bn3QlJh++GJg5L+f/BSB4u5p9BCYSja+cfPRkcdWWr7HvTEgM6bVfWbyl+i9YUP0+s
 9P1ff47G6oP6xn2sL4RnnR2U6IUyBuHian3qHg3xw25LjojIIETkwVVR+Oj75y7/FAlM
 WTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499650; x=1791104450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=woNZxwWEOWqfa67jvN4u4BDj/2f3zqAtYHAtH5MUtOw=;
 b=bksPl+jyjlWu9DcUdRgPifQMwdb4AKEr+BIRIBmSjeeIx22UehWmctJZ7pJpKKLnWN
 kecBnu5zDeJY4Ewf9O594h0W7ygVGZPIIQasItjoHYb/Ti3fRchGwiJXc+K7N1LrDl9z
 Po7taEGV1nrUb+USO7j6VXd6WsfK8G5DHweYTtni7D9qXj8IJ4MQRAUeiGQAQS879uOB
 rSWTlA0wb2yoRDf7BGQZnr3ND/FyApkORNrupLdarWhU5Bl3Np4f/nAziUyv25iwYxOP
 gEuJKSCZ0M990q3Y0aOXqiRdvmVcv7fJ+mnEqOF977thiza10aK9ZvZFoPuLkRXkHM9u
 wTQQ==
X-Gm-Message-State: AFq9FYJVtx1bJprzqK66IkJEaktn1uz55TmMWRBrVuqro/6zeuxy/hgQ
 LdpMHafJiOCzIjZqp3pawtLTqGZbkyXRlAGAJ/QZLepINK2zbH/ThBSBYDGGhnB5iYUPsAaaSRT
 Pt0aC
X-Gm-Gg: AYBFou2MMk8zBGZ4grxfXMcxWfly8MoXiilSZiXyEyIkT6Wv03GkVM4TE7h6ESY4CbF
 mS1a60Z6lla6OoQ70Hxmaia5gJmk3Fm3AXDiHzjjE5bFWUbyylqfjcn1yByZ3mehkaAFr3L2QOf
 PUyaCd+FTjFvkcsONDm8Ihr0SeCi/E1AhFaTmXAJdWjd/XEKXUzIlygMP5LaPpJhuc5NqVwjWzv
 I3bujYEpT6sqigaCKZPgelHnHg60LoQEC2HY6gPtCDkrh/2JcXjnONIIH9F5/15T+78XMxzHwLh
 kkNYojWO7zHGbUtFToWKbKH+9rcpywnU3nS0REgZ96J+cprw4YbrvHGdVe4bBWc0DhmTkRsi/WS
 JKN7/b8GAGIixkRdZqkGooAZossk2Suto1cNsIRU88Nf/M3Hqkho7iz1peALn/EAJu+onJaOjQU
 2so0JApXvr3217ZNRvuHyQKIgJhAe89C9oAukjfgj+v2zjhMos0r+YEnmkRfZj/JAWd7ROovIEj
 4n8mvXWdAIS1Hy+phFuXuMwzT/bPw==
X-Received: by 2002:a17:90b:4d09:b0:3a0:c85a:e602 with SMTP id
 98e67ed59e1d1-3a0c85aeba7mr3731001a91.9.1790499649757; 
 Sun, 27 Sep 2026 02:00:49 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 038/101] tcg: Generic expansion of tcg_gen_andc_*
Date: Sun, 27 Sep 2026 01:59:08 -0700
Message-ID: <20260927090011.10724-39-richard.henderson@linaro.org>
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
index 0fa534f24d0..af50c90eb04 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -201,7 +200,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index cfa19a0a815..7386332658c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -5,6 +5,7 @@ DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
+DEF3(andc, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 39b4bbb659e..e3ae8c2383f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -392,6 +392,18 @@ void tcg_gen_andi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_andc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_andc, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_andc, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_not(type, tmp, src2);
+        tcg_gen_and(type, dst, src1, tmp);
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -665,18 +677,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_andc, ret, arg1, arg2);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_not_i32(t0, arg2);
-        tcg_gen_and_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    }
-}
-
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I32, 0)) {
@@ -1724,18 +1724,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_andc, ret, arg1, arg2);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_not_i64(t0, arg2);
-        tcg_gen_and_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
-- 
2.53.0


