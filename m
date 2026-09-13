Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3FDC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a89-0001J3-IJ; Sat, 12 Sep 2026 22:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7n-0008Um-GH
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:25 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7j-00015N-Ij
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:22 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3990fe066ebso1791807a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267158; x=1789871958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aTXyLvGnS3jiJsULE7TDFdSYO6gE2G/0/EZQDQjoMRQ=;
 b=T0cHkS6VrhzJQVA3rBGSAwRg1vtWrFlwcZqvD6fdVzPp4KROuZkTygwzLRtaomMUvh
 +3hFuhuBJcIB9QQjRF2azTijUl6RvsGMLYBiuUymk1iMQIXxv9O3lCmMoaLDbPmftTIG
 FlWzIiXXz9TVZ4O/GkCujhPyLu/d5Q7GMJp044VgfFxpKIjw1JiCStgSBOGtviV/uNjB
 Cni1RSZJJobUo5CfvX3AhWv7VAvZPfYmuiTjSu+8VRMj9OEhjC7CD7n98+0Xf5SKZxuJ
 /IxAzpcNGZeRZIvwRMxqIJTCzZuDoeczeUEXh4SXVc/r4EnJuhZ/tYuWDO27kxyysh53
 0fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267158; x=1789871958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aTXyLvGnS3jiJsULE7TDFdSYO6gE2G/0/EZQDQjoMRQ=;
 b=lq+BiP1jZygMHh6EjVUEfSkuk6VjER6oCnnWiYrCz63beSV2eiKyUH8PqMB46w9rYG
 ctFtuepJMBDtcRM4UWFbkB5F7pCXBbLYaO/aQ3vmj6fN2sMC4kkCkiYodQ163MDSCQJ+
 FbcpRdrC3Xn8PBgu1uNOXbO4no0ckfx1AqmkZq4f0olMkSSSg4coey0KBykvFUpA2fr+
 7knyFPFYZpDrfF7JLbT6xeEUsyIw26kytXRairDB2rBi8NLnV30rpG98jm3iI5RwRuUl
 AbyKjt2rAQHX8wcGeUuhjTyJsD69w5hINnL68NvlV+m7s6nkHVN63hbSlXUT7MAs6Ovn
 Sq3w==
X-Gm-Message-State: AFuF++mrj1bd/tT/DoGATb9USbVArISph2K3ZOUR5PxOFPgmZzmA05MD
 Il7ppVIrAnap4nzQw78sid/WZV0PahwVlxViBQc9ZrFFGONZ+zT4rEsezLtL0uzfynn8yr/iuyh
 BtVyuPo8=
X-Gm-Gg: AYBFou2IexlVfaOPrF0uluLZf/eH4B3JsfyMGAxEShfQgNbuhVpPEElyes7G8hAh788
 SaHyNyzU3VpUDbSA5bLMsOipNaCX7Fw6XNTA5DkeJui4AYYjtv/Xs46ydK0PJvF3oAQJ8p845k4
 q0gN0S01JGo7xmtsD5PrJuCnZXfwfuQI7C/qslvI/4wKVEYL1dqklyyVldw6P32uBHF2i5CVF1F
 eYCDCjAKnIRUgRFmqhN64j93mC6P4VKcLK+IWabWUs8rrBQ8Y+RqF6XqGDDYFt3rPMErhQFc1UM
 kK//sYA+LEPHQsp7lSjlLdZJ3HQz8Gcon5vYeS2TAc/ZGytcBFXFnpOuDoxICsjwNHL+bSzy1tt
 cXJeg+hkh4o4dTxeATdrsDBRKBDyccVKPnQh+KD0lXFDi7FW0l6/nU8AJ4hqFQ8MfzgDBgAKETW
 AnXiY/Nzph/3a0aPHNXKpUveYtxUd27rlcePpDSMulenRuwlVkdYPE6NgxkzCsTBCz2VrXAEg7z
 qo/Z2U=
X-Received: by 2002:a17:90b:5605:b0:398:b17b:3bd2 with SMTP id
 98e67ed59e1d1-39d9bbc9177mr18464019a91.4.1789267157996; 
 Sat, 12 Sep 2026 19:39:17 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 33/86] tcg: Generic expansion of tcg_gen_eqv_*
Date: Sat, 12 Sep 2026 16:37:44 -1000
Message-ID: <20260913023837.741866-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ebbdec6cab5..c71eff07f77 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -200,7 +199,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b05a1782513..c1b99a280ac 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF3(andc, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 361c9207b64..b06d6f1455b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -489,6 +489,16 @@ static void gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_eqv, type, 0)) {
+        gen_op_ttt(INDEX_op_eqv, type, dst, src1, src2);
+    } else {
+        gen_xor(type, dst, src1, src2);
+        gen_not(type, dst, dst);
+    }
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -730,16 +740,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_eqv, ret, arg1, arg2);
-    } else {
-        tcg_gen_xor_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
@@ -1777,16 +1777,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_eqv, ret, arg1, arg2);
-    } else {
-        tcg_gen_xor_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
-- 
2.53.0


