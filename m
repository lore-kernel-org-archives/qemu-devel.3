Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A280C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklD-000309-5M; Sun, 27 Sep 2026 05:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkj-0002ZE-Fv
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:01:03 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkZ-0007TV-Tc
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:51 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398a147688bso1552213a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499643; x=1791104443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tpFLCDbhtqHP2IDEgvQaw4G5ls0czOFggKNjlfHXXy0=;
 b=o1loibvP1iQ/QGiyF8Dqd5xZTM+htAMM+6+Jm6jMiwuz00FO1fWB4lpLOQco1B5mJC
 vBrEao5aBEN3QgdZp+0eZBC7wCCmg8Cz00ExtXDWPHnSnoFHG/bkcm4DdD4UQNL20l4D
 eSlWtRikDW2MmNNnasDr+75yReUVp2NcV7I+/WpLtJc6ZqPucbeGRa1cR2YNfvyEsdp3
 J3vr8l7Wcaloa4JTgJDjwc6S2jasjXgdT9qh4ytrkOLdAAlwHignH6Lfeax04Y3Knrl8
 TlWHXKMYVmP+Ugb6ehueWBedHgN4srweGnqykStN/jP/R+wGqsG8LvLvA18yd5NQ/izP
 7EHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499643; x=1791104443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tpFLCDbhtqHP2IDEgvQaw4G5ls0czOFggKNjlfHXXy0=;
 b=bRxTYLQcTV+pcMVLKa65VhpySV69oxjDiMo6rE0ptwUTmZgeHiif7LB7itbONCT1PV
 TpyspyP6ZdnrvmuReTt3ejDh4iuIT2Pt05klgc5Io/mSMi5LNcpYFE4HRVCODGV5TLwU
 ck1XhjTD7m4b9in0KvhS0EPgGLY/dOu83Tpfx1vYyPrklPmPEz74NRb0E7tBmlW9GHyr
 mwB4HTyHNi0uSNVDa+UgcyjQpShuVVIpsLr73mp+YqUC6U1TEpDGJiX6GRZINX/gTmOC
 3UOQfz/0kDXgQEZRf3PO/jtfJP9fAE77uLXsCfv6upC78tNl50qL2K3QdOyT/eKP/VPG
 BUOQ==
X-Gm-Message-State: AFq9FYKBiiY6deDj9lfO0fAZFi8DbfEJiZ2JPVXrQpP0HdqrhJGtM61f
 vhdYaLPtCshW93ZY85I5FAElXKtcEwjbNdLvaYU3r8+lHaUUSFNdf8CYfYgVFovHxebhNx8PjUy
 fufK9
X-Gm-Gg: AYBFou0Ru3DxTtPGa7NNHzwsZWWyBp14XWrN0azycqhXPs7czGtgApajay2k86/1eQk
 CYGGNswXVOZxtMAi+3vDZ6KqmFn9EaVkrbu1WLYXiCYT68MeNJCfZkQ6gzfLU3TBpmStn8HJpMu
 kpfbJbPO40OI9EcIWsiAcmSia+g3FrXlrPD+2N6leLzcmjzJDoOFCXOmxpC9fE2ubVAxv43YWH3
 /JyyXxxKrM8L3bR/beDcw7Y2Svq3uWs8/CvfXANCaiqsp3sM34MXML+X3Fs8Qh0zHkeVOStcPUf
 85PQ1prPMWOLdBUEGc8flejyWKqOHBBqQq9xhZO1vOJRo/JmwT06kXgdhpbKPzXrtWaU3xelFEU
 qP4f/75p2gzW2DCopzyes+7X7xl9+UqHvkwhfZNufDAsd7VsplFx+18kk7XNRYOgdv3aahtXZAy
 PZagaYzCGWCr9htYesBWTkbuLlCI0VyhOagrbXNJ+AJm8YaZZ/wqIStDRjCYyM3TWQvLcEcf8D+
 PNBx2buVSICWjqCl+SXt0/tzr8S1Tg=
X-Received: by 2002:a17:90b:4d85:b0:39d:f254:4173 with SMTP id
 98e67ed59e1d1-3a098d9612fmr9293823a91.21.1790499643161; 
 Sun, 27 Sep 2026 02:00:43 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 031/101] tcg: Generic expansion of tcg_gen_muli_*
Date: Sun, 27 Sep 2026 01:59:01 -0700
Message-ID: <20260927090011.10724-32-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 33 +++++++++++----------------------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 87aab828112..773dd8db719 100644
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
index b38969478a9..abea00e7e0e 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
+DEF3(muli, TCGV, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 153a759305e..dacdcc68c52 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -428,6 +428,17 @@ void tcg_gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
 }
 
+void tcg_gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        tcg_gen_movi(type, dst, 0);
+    } else if (is_power_of_2(src2)) {
+        tcg_gen_shli(type, dst, src1, ctz64(src2));
+    } else {
+        tcg_gen_mul(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -597,17 +608,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
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
@@ -1536,17 +1536,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
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


