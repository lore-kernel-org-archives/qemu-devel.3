Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A288C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73oz-0004ps-R0; Thu, 17 Sep 2026 00:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nX-0001eu-KF
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:40 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nV-0007IC-PK
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:35 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so334613a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619552; x=1790224352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RKxXudSmxkPYoNlX7GcYgI8KVmLrw0LVK31M2bTDPuQ=;
 b=Lt5wrplpSMRACl8cf+9eqkHbBbcI6bDzjagvCnrB37AUQymcNHKS9erOaffSttQEZZ
 p70kz262NC2cOyfUbPr3Dt+Fyb6bT+vY1D/xK6j7+yUbAFbaBfbWT3Ob8KMZxdnYgiPT
 E5pQZeiho4tW6NkuHKf164xDxuIBSTrSWm/+7zIgwtjjn9Q64Rs4uKWQJROjbd1JgZST
 Q4ZZzDDJ0oR4Y6nLi895kZHt+ns5Gp/GQz9kyfY7OAVaRy46IdprdsLq8mKc4aFPkw+B
 wsOo6t+By9bEmxDqG38A8KgEkM6gFo1P+CmmqlAwjg0QVErewffzkwEpNC5+QQYkpDij
 7PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619552; x=1790224352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RKxXudSmxkPYoNlX7GcYgI8KVmLrw0LVK31M2bTDPuQ=;
 b=gfDHhVsdmc9cTScFDA3HKnC94gU0n6lXWaPznuTWsuJVk5xQVI1HLv+EE4sqDDIN7U
 xmIE19/k5kc9A/yaSvbuu+WWUzwMr1KqMTxXPunU1GQpvp+MVHlSZsOvvTJdOAhZQPWD
 VDn5KMbs6H4GyyaBjJtrqWcz9hyQVz/2rcA1xOg5xtsGoM0wUDWestBUQx0Ge2omKlZN
 fLi350grJ7mey8iv5rO/GE0dyT8HDXnhfebM+ymqLY7gC45hvKLzmB2IJhV6gMmJ2jBM
 hcL0Lu8dXdfA8qOV2/CR5Uvzg2Pa05baMw0QX+RU/C4zL6O07brca+Hccwi4PKRZMLsg
 fAmw==
X-Gm-Message-State: AFuF++kA+AgTV2ihhzA879U0oBi27sZUKO6dqwZMvA6bNNTeU8Giolr+
 ET/mt2ohgrHUVMr1o84RLiIa9tYwzQnGs4vppzqRGtLXiLm9cPS72HsXesgp2VMSrZCxkqL8TNc
 8O+oV+kE=
X-Gm-Gg: AYBFou3f4MlxFh0FduLTajBef/cMIrFvK7nS1FAjorcCf3jgaTfTGnASdiypnRZ2fxY
 e3BA5U96a/7Y1tnjlN9ofzR2PYAZQHqsk5sKx104oPMjd+x8ONfp4iCJK1kjjlXsay5GW69+geb
 svk6H46L6X14v9PlDltb5H949jdNObioV4aAxbQHTA8G9Ux2AD77morPRBRd5J7nJwlee7CSqrR
 G2rqqsm+9nDqojouCayYnjJH6383YScBy7q3kFR4fvKdh3E0i6JV46qRn+YqfAIoMF+rbHb6WSX
 wjhmYz7cD9hJ0zXPA+TxWWubUeLlhvTbBsGt51yW4RehGwGZnIs4eba9GfHzM41jWCAOeJa8cA8
 ZaAa6vj9RPJeLeuHWd4dCd5z9DXukRWXiGn6Oqju4rJOnZyVqsdn3S+uwO8TiqwRnOiVZcBMHMu
 CdjzTk4sfcBgX7xb9f/sdKI1SwHB7dfCA/14iv4hRDXh3TDVTrlqrUpd7hau/QUc020650Lsypp
 5e0XKHSZmCNY/oyUJk=
X-Received: by 2002:a17:90b:544e:b0:39e:35e4:d31b with SMTP id
 98e67ed59e1d1-39e35e4d992mr8962887a91.5.1789619551488; 
 Wed, 16 Sep 2026 21:32:31 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 063/101] tcg: Generic expansion of tcg_gen_rotri_*
Date: Wed, 16 Sep 2026 18:27:45 -1000
Message-ID: <20260917042823.542588-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 49 ++++++++++++++----------------------
 3 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a1c32214723..aa5257d9e31 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,7 +130,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -183,7 +182,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 35542e003ef..383a13aa1e9 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -35,6 +35,7 @@ DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
 DEF3(rotr, TCGV, TCGV, TCGV)
+DEF3(rotri, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 925ef8244b7..389cdf22b73 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -878,6 +878,25 @@ static void gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    int width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(src2 >= 0 && src2 < width);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        gen_op_ttt(INDEX_op_rotr, type, dst, src1,
+                   tcg_constant_internal(type, src2));
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1,
+                   tcg_constant_internal(type, width - src2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        gen_op_ttti(INDEX_op_extract2, type, dst, src1, src1, src2);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -991,21 +1010,6 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, tcg_constant_i32(arg2));
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(32 - arg2));
-    } else {
-        /* Do not recurse with the rotri simplification. */
-        tcg_gen_op4i_i32(INDEX_op_extract2, ret, arg1, arg1, arg2);
-    }
-}
-
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
@@ -1780,21 +1784,6 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, tcg_constant_i64(arg2));
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(64 - arg2));
-    } else {
-        /* Do not recurse with the rotri simplification. */
-        tcg_gen_op4i_i64(INDEX_op_extract2, ret, arg1, arg1, arg2);
-    }
-}
-
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


