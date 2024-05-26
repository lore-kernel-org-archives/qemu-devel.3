Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FF9C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlw-0008GX-UA; Sun, 26 May 2024 15:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlv-0008FZ-MX
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlt-0007fY-Ax
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:11 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f4851f7c28so4783165ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752588; x=1717357388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8xBT7IiPvp81EhYtYRGvxaJotuyLb9Fd+MeDDxA5Lc=;
 b=ek37G2b5JnQRM9aQCw2/Q7oxmYLCdT1PiZPho4hrHU9FyUgf35t7bjxJ9Sjq1JvKad
 uygS2hNfhovb4M0WikNRo1d/mlk08vOyWtzwry/UxSg7cDPNJJeiCgOdmz6Fw+Xrhvxw
 cb+Md9EKr2soI8gVMZy6RViiw8EWW+tiO1mV+5O0di4aIMuOhDGKX0ozkKyMQr6IQtkk
 wBIzixkjcb8x7cy3+3B5RWXCJpdsbJpuCKwFiv7U0Hzt8ici5x2ryJqT96oZhD7ft3JP
 kLCzJaUsmmWdgg4CFby/Kv6FGfT7eYejlZdy+/YBJTnFDyYz6NoM/fILcCl2LfGg3G0c
 X4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752588; x=1717357388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8xBT7IiPvp81EhYtYRGvxaJotuyLb9Fd+MeDDxA5Lc=;
 b=dOfQmu6/xnqBClLHkfR9t+hmpI7Wq27/bi+wAmc1NZg/t/eQJNTADdiwOBzlGAHGOl
 iDAe5RMxlxSNehKjBG9FX5rTl90MhcXOfc0BOShfldUANFhEDNorSAGgS2bO+E2aANUE
 92KfBBhx/6KlSREbUUtmSyMxABL7mu540u+MhmL8AsYwOAj1vTtKu7pLt/mWRM0q6aj4
 3ThRV0piVnRdQa8HPOMxG8yX0Mt0uZmHOm73yvmEZJT04isS8a9qEc+k4eb5INeOS9A7
 sRvfo8I+Fef24xVYlaOz0YfMMwS+BJ3wRIZRT4oPioztKjaPaEz2SRtoSkO0/1MNKSVV
 lo7Q==
X-Gm-Message-State: AOJu0YzFu66i+MDApPemu2MTuOIrVraOs7TsNuKC+0ehNdhnlNoWbxEF
 U9XJe8e2/58vFw6GVARYIr9Hm/D4kDqmAJo9MDh7lX4/wdPbDxPr/tDKmq7VFoUVVmm2uTPreoX
 k
X-Google-Smtp-Source: AGHT+IEBhZ9CrbJLpB6zWX4muJhPbgpBLUmxLPZ3GtF+kwbr9zju/0NAhbjXsysY2fTMOUisAjICdQ==
X-Received: by 2002:a17:903:8c3:b0:1e5:3d8a:75fd with SMTP id
 d9443c01a7336-1f4498f1757mr81443365ad.69.1716752587834; 
 Sun, 26 May 2024 12:43:07 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 15/37] target/sparc: Implement FLCMP
Date: Sun, 26 May 2024 12:42:32 -0700
Message-Id: <20240526194254.459395-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
index 4515886590..f53ecf7c41 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5203,6 +5203,40 @@ static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
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


