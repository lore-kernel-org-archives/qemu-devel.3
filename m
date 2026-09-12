Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7817EC88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1s-0005a4-Fb; Sat, 12 Sep 2026 06:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1S-0004pJ-HP
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:57 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1R-0007J3-0X
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:50 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469b2e1d5so807499b3a.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209107; x=1789813907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XQ9QNOp6Lq6mUbKDLngPmRtWfpWQNaQ/xgFMeCdFyIk=;
 b=I1vgZrJEtOBpCt2soLvRekCgsJpc7voY2ZHP9sv5pSXWQe6QXKH1OEYG8nW1GljCOt
 XWpcrDBTkD6jW9uqvawZIYnUFB+pGhjyHoh9wpRokmYkpicAZv7RnxhYDHLNvdpFYmv2
 V8UIzc0fJJ0M9OJZ75QjngE5CdItzr/HXh4uZ7jmRuu9Wn8cXBn2vemTfkPhwWqUYef3
 7xhFwQJUV9ODkKSY0Ozlq630os1iZ6Xh+5Izzn3CJ5I6EKbGyBetDC2LUgyzpGVnmMt3
 sGJ5L4UN+svSoknm0Cf7FjStRim+FmOrRvU+xDhOlfaU914kMuWVB0E/jI+1ELPHiH9e
 pbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209107; x=1789813907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XQ9QNOp6Lq6mUbKDLngPmRtWfpWQNaQ/xgFMeCdFyIk=;
 b=JWLN6m9Swxr+NiaQhiz6Ds8IHMewB4zmmAdq58voJrIL4ljwCNWtfkC66jBqcVpi5H
 D6HdgR72oAoXJqLgq3lh+piga9rd519t/ltz7h5rxqg7GSB3gWU5YKn83oDhC1FXO6Yh
 WcntKaaS3K7cdcPFiAyyq3h5qeNQlWCUgJ8fqeobSk9f966J85USdqpVnfq0S+79UWX2
 ScsCkiIToATBX+vySdIq5L1N4cm29jUjbVFSzV5aTGRzW4Hxgs4n/9qCE630xVDtjdar
 8Ynn0/AnGr1fPTFoyX7pLvi5X1W1GzCeVX+w4voCAgpHdnMq66CC9iT1rn8Rp7suV+cA
 W33g==
X-Gm-Message-State: AFuF++kAxgVXl+PWmQW5cag2IUTJ+qK4Ts8BPx2HMSHm3cq6/iMLjkSU
 vQySPgSzAdOLFR/Uay4POZSPM+HVGZ70ivd6ojeK20GCkXVuI1om2ksfxMZtQ3q0pbQZmKWCTGD
 tyFJjs2Y=
X-Gm-Gg: AYBFou34vgEF1+ktxo1o0kSQMmm9wEWwfcB6A8Ba8B/SaD63ZoIM/pcEIyUEOSZksm2
 OvHqXmycnuWB0evWy4ZVfbi2xDU3wc3BcdnGvXZPzxXx87M+lIftT6ckiD/zCiuX8CpNm9cAqen
 DCwKO1DNmkEkc82CPJcUygema5r8tQob+o2GAH7BKACtD8aLQkobCKy6oWS6usHighwXX0kkspe
 aR9twa/CJ6YBQTgJ/Rlg2fIY+woSv9US4CEzZFixF5kI6dqYpZJUyN7IpjIcojJJkXjSHaVVcsn
 nie1abgvK8tj3jQlG0OAVZ1zcY0FqOiA+TU3T+j5gi4lfRPjFRERZ6PzIUPDX4owiFSnH5mHqLV
 V1ml/71lFr2o2GaK4fKvOqn79uttAyCGIhOX7+a4LcHp14XxtywlIQkuZAwXsrnk9qcT80tBNlp
 anMFSn5KNPE3VGCCeN7lWeIhzky8HeRV9Polso7YqGgl+Lt0wpP8sOEJKmTkoGuNH9YAUDeZazU
 aa+/bk=
X-Received: by 2002:a05:6a20:72a4:b0:3da:34a7:6444 with SMTP id
 adf61e73a8af0-3daed3d94abmr14073375637.26.1789209107518; 
 Sat, 12 Sep 2026 03:31:47 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/82] tcg: Generic expansion of tcg_gen_shri_*
Date: Sat, 12 Sep 2026 00:30:24 -1000
Message-ID: <20260912103126.598030-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index fd272b4305c..a09d734e254 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -124,7 +124,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -214,7 +213,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index b0ba4bafc36..0b3f9c0067d 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -7,6 +7,7 @@ DEF_RR(mov)
 DEF_RR(neg)
 DEF_RRI(addi)
 DEF_RRI(shli)
+DEF_RRI(shri)
 DEF_RRI(subi)
 DEF_RRR(add)
 DEF_RRR(and)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c12d0f29a72..011817d9f50 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -429,6 +429,16 @@ static void gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
 }
 
+static void gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_shr(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -557,16 +567,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_shr_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1576,16 +1576,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_shr_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


