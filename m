Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A22C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggiv-0007lp-8v; Mon, 06 Jul 2026 06:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggis-0007eP-W1
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiq-0003YW-Jp
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:46 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so21476865e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334323; x=1783939123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R7PJftppVr1IHdKZiJeYYAXnb9UTupGaY68HGzluVjE=;
 b=mUUHq5duMcgpDblKF+rt/WTo27v6gLickbC2ppcJCYqYNHVbL2aYGIF/EkwAsTQ20C
 5DNWEMwz5yoV/GJ6bW/pHjiS8u3hFVK8eMuyN6MJkrz4h1s5K+VFbHSxKBBTnRY1h/SQ
 +Iyk9nbISW9RIS14hqdk3n5TzUuCxk+vluvfRFa+RCKtHj7dwr7/bJYpTzT/zgA28Y2R
 Mt9CuvV5emlJkTcAICDMHIk/5cFLkhNxi0zDtBs7z0dXFWU3KFKLpehgfbo04eGu+fEK
 IaYYoUbKhGZRXTFiYpHjwvboZjof/QF7lIZ/DXOJDS3PAplbb9+cYD8bfregTysVi2XN
 DRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334323; x=1783939123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R7PJftppVr1IHdKZiJeYYAXnb9UTupGaY68HGzluVjE=;
 b=mhzRatUYxKTVmfwk/+5j0/W31w7lfuwyeKeXfYGgKW0XMS3BasJbRnnux8ZN5bnUg9
 htfoaFF5fZa4KMUDyBZFre0xmN0RrGvggKJyNafW8dASKxrZHtvsLA+yyIxT7NRhFOjx
 BtLA6m8WzyzwqnaSIxB8JyYRFxG06OQj4X8e7rKmUVVkSOAc//zvMJBZ3dJxUelwa3P8
 Ely5mC+rp9q7zxTKtKOWf8zsOi+yPwhz2KQzf2W8pn9AvhAQWikq81DaB+Du4BCkgInc
 GLkIIn7m+PW+TTPIIdVmHeMDsRwfhJhyjFq/36lLuiRvNCTA97zR/AqJZZFf4Ekd4UDR
 tneA==
X-Gm-Message-State: AOJu0YxknPVx5gmR7cJg4ECie7Xaf+vm/mB1jUUb0KCdR+MJTYCSvNeP
 Q6mJIMYy31JA5J+B5/bcFnZoQcEJQKkyFK3u91S12O8Vhar80/mq9QeVXK5EXl2Ne4C+QD3nm93
 L+tH581v9mQ==
X-Gm-Gg: AfdE7ckqUPNJofo21Hz6TTIcWQUMau+w83xhQunawvsIOhiigL+KiVftHaLg1xHXA28
 C4kaAlpkfLhrngT0CfuyGUUZvDHoir92KRZWLIE3XyiPI7NuRVDJ9E5ehkAj42jCIeEst94WyhZ
 fZp5rBVWb12lGH4q0o4YcCuBiofpdCk0t3y2Wfepb81IdA8FU9wtwcCV2nkkd9Eycm1NgH53iAu
 1y7eKR0TYFpRtqFEvAMjbe86hI8gebIWndgtEMWikQdzHafydG0Fn/ln4apeTF/BNpZ4wOS2iou
 93UEmjR7gUire6oHypPLPrVnGPqAWnANj9KaCyKTgUNjj35M2ntTP+MGWJHeyTyFiMknG/ID4AG
 EErYeZ0dpFcXzwW1ruEDZogI6CGconL0+c/EI/qpvjKLRIyopPaOUofZqnCYBxX6yro4M4bLDuw
 aWpndXys3KfelfXZzBhMq6ISLG74ic5G/KT3tZ0Qfj9xVN+wEyUWEkKkYzb09KELMkbOjywQzg8
 leRx4msJTiHffghA7AVlQ==
X-Received: by 2002:a05:600c:a305:b0:493:d1e0:a4f1 with SMTP id
 5b1f17b1804b1-493d1e0a802mr80481415e9.0.1783334323199; 
 Mon, 06 Jul 2026 03:38:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/49] target/arm: Separate syndrome functions for A32 and A64
Date: Mon,  6 Jul 2026 11:37:50 +0100
Message-ID: <20260706103752.320511-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Currently we have one syn_fp_access_trap() which we use for fp
traps from A64 and from VFP and Neon A32. This means that A64
has to specify arguments that are always fixed for it (coproc
and is_16bit) and A32 can't specify arguments it needs to (TA).

Split it up into syn_a64_fp_access_trap() and
syn_a32_fp_access_trap(). This is a refactor with no
behavioural change.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260702184019.3431139-3-peter.maydell@linaro.org
---
 target/arm/syndrome.h          | 28 ++++++++++++++++++++++------
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate-vfp.c |  2 +-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 0eb54c15ce..2a6fa903f2 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -345,21 +345,37 @@ static inline uint32_t syn_cp15_rrt_trap(int cv, int cond, int opc1, int crm,
 
 /*
  * ISS encoding for an exception from an access to a register of
- * instruction resulting from the FPEN or TFP traps.
+ * instruction resulting from the FPEN or TFP traps. Note that
+ * the TA and COPROC fields are only valid when an AArch32 insn
+ * traps to AArch32 EL2; they are RES0 for traps to AArch64.
  */
-FIELD(FP_ISS, COPROC, 0, 4) /* ARMv7 only */
+FIELD(FP_ISS, COPROC, 0, 4)
+FIELD(FP_ISS, TA, 5, 1)
 FIELD(FP_ISS, COND, 20, 4)
 FIELD(FP_ISS, CV, 24, 1)
 
-static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit,
-                                          int coproc)
+static inline uint32_t syn_a64_fp_access_trap(int cv, int cond)
 {
-    /* AArch32 FP trap or any AArch64 FP/SIMD trap: TA == 0 */
+    /* AArch64 FP/SIMD trap: TA and coproc are RES0, insn is 64 bits */
     uint32_t res = syn_set_ec(0, EC_ADVSIMDFPACCESSTRAP);
-    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
 
     res = FIELD_DP32(res, FP_ISS, CV, cv);
     res = FIELD_DP32(res, FP_ISS, COND, cond);
+
+    return res;
+}
+
+static inline uint32_t syn_a32_fp_access_trap(int cv, int cond,
+                                              int ta, int coproc)
+{
+    /* AArch32 VFP or Neon trap: TA and coproc valid, insn is 64 bits */
+    uint32_t res = syn_set_ec(0, EC_ADVSIMDFPACCESSTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, FP_ISS, CV, cv);
+    res = FIELD_DP32(res, FP_ISS, COND, cond);
+    res = FIELD_DP32(res, FP_ISS, TA, ta);
     res = FIELD_DP32(res, FP_ISS, COPROC, coproc);
 
     return res;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 69648ad94b..1780490065 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1439,7 +1439,7 @@ static bool fp_access_check_only(DisasContext *s)
         s->fp_access_checked = -1;
 
         gen_exception_insn_el(s, 0, EXCP_UDEF,
-                              syn_fp_access_trap(1, 0xe, false, 0),
+                              syn_a64_fp_access_trap(1, 0xe),
                               s->fp_excp_el);
         return false;
     }
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 6f6b234c9a..7474973952 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -228,7 +228,7 @@ static bool vfp_access_check_a(DisasContext *s, bool ignore_vfp_enabled)
          * this field to 0xA.
          */
         int coproc = arm_dc_feature(s, ARM_FEATURE_V8) ? 0 : 0xa;
-        uint32_t syn = syn_fp_access_trap(1, 0xe, false, coproc);
+        uint32_t syn = syn_a32_fp_access_trap(1, 0xe, 0, coproc);
 
         gen_exception_insn_el(s, 0, EXCP_UDEF, syn, s->fp_excp_el);
         return false;
-- 
2.43.0


