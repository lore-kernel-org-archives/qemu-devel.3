Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31789C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuLz-0005wb-1b; Wed, 05 Jun 2024 13:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLx-0005vq-A3
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:13 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLv-0003qn-F6
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:13 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f44b441b08so892215ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608190; x=1718212990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o5Xge3aFlICjGEwQnJKGgTBQ+hnW7Zmp0P/rXCoGoes=;
 b=UX7hDMZ+6cXetkgyZ8o1D2+cnlh4FN7Xa07dIJLjoDMPytBXevgYzx1BTMfTAp7ybZ
 /Tty9WOMn9ZVPf/ru/Rm6fhSL/ky1IG34Z32fe0OWVCqs1ChzaEbaaNu+WCMg6czlQ7w
 RVBqRLO0rsR++5QQWcASmRNsN9GnrWJmPYbEPScyDS41QpbMR1VcSQgirlzkbp4LABT2
 zaQDlowpVB+ePZynM/+E2fG1FjVDWxMzuiQURXePsd6V+bWIVwPZv2kcyV5qRLs5ntHj
 EIOW4pxqddCqkujqnvgYjuvxPl4g4smLlufjNwwD9gppbLb8ryBtMTbIyExHe7wIGf3+
 0q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608190; x=1718212990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5Xge3aFlICjGEwQnJKGgTBQ+hnW7Zmp0P/rXCoGoes=;
 b=BNbPttB4vlXfbxTFOw+lXwttopN3MnS+UX2sqefwR+hnMlP9EjFQoDCqHj+y4xdbui
 7YkTgnTHuQa4BbkWgUXfajDF2fmiB55SatKK1x3vt+dg6bCUjC4SfCe3YpJ+BMLGFKHE
 KRcTIRkeSqIW8QH6MbExXhsH2N6CwfafZ50vwr1FcpA+C3xc9t6uRG07iGmDMtLuI33R
 APfqX+adFdZYAETqg9rW7PR5/ajt3B+0aBqz31mfW577zQ+5ZeiBnAQ7s+fCdj378NBn
 n4INPXznSiE+rdGHybUOvsZi2CluOE+GzYd/31u4RUAarJB7XQlkADm5Hn0NCRBIQcQB
 K57w==
X-Gm-Message-State: AOJu0YxQkChkKsET5YDjkOb/CaEE1H7CCbjNZItQXGTBTmYRSmKVXDyh
 O9VQddaxml9HEcUnvjlQrXgdBWf5EraC90WvMvN3SE5Bq0bjkabo2eY2+6q2VSIhsD59PMc7aK7
 /
X-Google-Smtp-Source: AGHT+IGCO4gFuICyUYY2hjXbmQ1wqgFsqpB3UBrHDEs0za21eEnNYntLicYkn6/AspX5s6a5N5QB3Q==
X-Received: by 2002:a17:90b:f8c:b0:2bd:fa57:b35c with SMTP id
 98e67ed59e1d1-2c27db1b5d7mr2921938a91.28.1717608190022; 
 Wed, 05 Jun 2024 10:23:10 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/38] target/sparc: Implement FLCMP
Date: Wed,  5 Jun 2024 10:22:31 -0700
Message-Id: <20240605172253.356302-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
 target/sparc/helper.h     |  2 ++
 target/sparc/insns.decode |  4 ++++
 target/sparc/fop_helper.c | 46 +++++++++++++++++++++++++++++++++++++++
 target/sparc/translate.c  | 34 +++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 15f0907a1b..ab79954bb5 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -50,6 +50,8 @@ DEF_HELPER_FLAGS_3(fcmpd, TCG_CALL_NO_WG, i32, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmped, TCG_CALL_NO_WG, i32, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmpq, TCG_CALL_NO_WG, i32, env, i128, i128)
 DEF_HELPER_FLAGS_3(fcmpeq, TCG_CALL_NO_WG, i32, env, i128, i128)
+DEF_HELPER_FLAGS_2(flcmps, TCG_CALL_NO_RWG_SE, i32, f32, f32)
+DEF_HELPER_FLAGS_2(flcmpd, TCG_CALL_NO_RWG_SE, i32, f64, f64)
 DEF_HELPER_2(raise_exception, noreturn, env, int)
 
 DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_WG, f64, env, f64, f64)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 6ec3838865..de29996304 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -470,6 +470,10 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FZEROs      10 rd:5  110110 00000 0 0110 0001 00000
     FONEd       10 ..... 110110 00000 0 0111 1110 00000    rd=%dfp_rd
     FONEs       10 rd:5  110110 00000 0 0111 1111 00000
+
+    FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
+    FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
+                rs1=%dfp_rs1 rs2=%dfp_rs2
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 08b5f96f95..1b524c6d3c 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -490,6 +490,52 @@ uint32_t helper_fcmpeq(CPUSPARCState *env, Int128 src1, Int128 src2)
     return finish_fcmp(env, r, GETPC());
 }
 
+uint32_t helper_flcmps(float32 src1, float32 src2)
+{
+    /*
+     * FLCMP never raises an exception nor modifies any FSR fields.
+     * Perform the comparison with a dummy fp environment.
+     */
+    float_status discard = { };
+    FloatRelation r = float32_compare_quiet(src1, src2, &discard);
+
+    switch (r) {
+    case float_relation_equal:
+        if (src2 == float32_zero && src1 != float32_zero) {
+            return 1;  /* -0.0 < +0.0 */
+        }
+        return 0;
+    case float_relation_less:
+        return 1;
+    case float_relation_greater:
+        return 0;
+    case float_relation_unordered:
+        return float32_is_any_nan(src2) ? 3 : 2;
+    }
+    g_assert_not_reached();
+}
+
+uint32_t helper_flcmpd(float64 src1, float64 src2)
+{
+    float_status discard = { };
+    FloatRelation r = float64_compare_quiet(src1, src2, &discard);
+
+    switch (r) {
+    case float_relation_equal:
+        if (src2 == float64_zero && src1 != float64_zero) {
+            return 1;  /* -0.0 < +0.0 */
+        }
+        return 0;
+    case float_relation_less:
+        return 1;
+    case float_relation_greater:
+        return 0;
+    case float_relation_unordered:
+        return float64_is_any_nan(src2) ? 3 : 2;
+    }
+    g_assert_not_reached();
+}
+
 target_ulong cpu_get_fsr(CPUSPARCState *env)
 {
     target_ulong fsr = env->fsr | env->fsr_cexc_ftt;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d81b9ce5a8..db3a153c6e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5207,6 +5207,40 @@ static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
 TRANS(FCMPq, ALL, do_fcmpq, a, false)
 TRANS(FCMPEq, ALL, do_fcmpq, a, true)
 
+static bool trans_FLCMPs(DisasContext *dc, arg_FLCMPs *a)
+{
+    TCGv_i32 src1, src2;
+
+    if (!avail_VIS3(dc)) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    gen_helper_flcmps(cpu_fcc[a->cc], src1, src2);
+    return advance_pc(dc);
+}
+
+static bool trans_FLCMPd(DisasContext *dc, arg_FLCMPd *a)
+{
+    TCGv_i64 src1, src2;
+
+    if (!avail_VIS3(dc)) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    gen_helper_flcmpd(cpu_fcc[a->cc], src1, src2);
+    return advance_pc(dc);
+}
+
 static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-- 
2.34.1


