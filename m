Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6198CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX22R-0003dh-D8; Tue, 09 Jun 2026 15:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21C-0003Cg-Bw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:21:58 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX20t-0003zw-DW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:21:35 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2c0c2c7d45eso53589555ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032875; x=1781637675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxJlZl6n8F/qIy1kJwiEnWFNrPr1p3ske2PZwKnmD7Q=;
 b=xC9sfD4wz33+MK2lSFcwryHr3uSrufASx2/X6y3/hsmu3AvZTL6y3yyC4RSQOIxuB8
 HimgpsY0EzA0/JknNyZXQUwZH9sBOqTTu8sPB7BTg1LfJboZiNQWHtAMg5/eiNyA+ZmK
 nCRWiVtRA1k1ZNAx8lbbeAShwbAyntON/7Y8V4IeXyZ79wpoifQuIX0jGclqhPExWilv
 f0LfAOEQA9+kRYwYtq4k8auJ3TSU0F/GP+55wzhkdchpRcK/IJ1QPwHJErohcwWtoAgK
 lNfqYcvbBKw+Fi9vg01pp6umlnRmI7iR5NPlgjYsHpB6TGLuIzN+nO+//1OCjGvN77gH
 Maag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032875; x=1781637675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qxJlZl6n8F/qIy1kJwiEnWFNrPr1p3ske2PZwKnmD7Q=;
 b=QAp6SSaB8sfagBzIq2DhGTBmugC2HfjlnJpPv+4sUJDwIBRPGQYG0us6yh9Y+kgdNu
 vlzdd07m2fUEYE9PP1l0VhxivXULtiEysfc33K1sIh/u122Vg/JJHDfTsbac5ECNfTAT
 spQrCJr3DbpxvM9T33EQyfMK4vKEpnLiIGorLgH38toAJo8MmrQQL8Ey9tov2536/jQ4
 w7YIw3e6Hqn1rQfHc0yp/ha/OkpHtewgfWOvnh7Ex4hkmyGUUZmOTTs91+c4F/1Df7GV
 EQTEhM51MH3Sh6dEjXZJLArHrGyhz7ndJt3eWa59t2LER1OUp0+W77btTM0R5RcVwIxp
 KzLA==
X-Gm-Message-State: AOJu0YytZVJPm/Jv60jRUWz6f9+rtOTdwZRW83MCvTb8WtQM7uqhyiia
 VIG9FFvspebM/f3s8DwYc5bhv7YzSD73ffzy+Xvzwu+ZUlqa1OVOslQxnsEZIGufxw1cZXyK6uE
 +iFybgnY=
X-Gm-Gg: Acq92OHhAVmCQuhuyA4/zJubCHM9HNCv/gvsHqNOn1u3oWiytQDyqqqeKQj/cVi8qjN
 CAeF7Y4tmb+sxabu9cj7aZEXM7Oz4sIdGRF47pf8bwGsIAqOilEYmtTrgVgYl99H+QA65xsYmya
 SHzSziZ/ROEirrLhTU/vxe9Zbc3cfMxH3PIIPxW6bm49RS4VBhrGKUaTWrjgd/ziR+tRk8AHkeL
 GVPpxyymXtVq4aoGWYJw92W3+87/kOZiO4mwv74We6bMhMysZMb+Poc7sQnwAp7E2WX3ZipOBxv
 m4Eezz1NeL96VdYNYWi0uwCT2LYaU+DlDShC87PdgAYr/hasfm9OgmWaypDzwSOn3nAbaqquiBa
 IMMk9usnZV0DgehbPVpIX9Gru3PMFHmL83m/98vr3bRF8bAFlttByq8OZtgRUyOrSfOiBD7WY7x
 SPqIVhgKxcJIJ1I+R0XDgWY8u/Eoar+NN0y3KZ7wo=
X-Received: by 2002:a17:903:3bc7:b0:2bd:c925:3a16 with SMTP id
 d9443c01a7336-2c1e80e3bcbmr254403755ad.2.1781032874861; 
 Tue, 09 Jun 2026 12:21:14 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 05/45] target/arm: Introduce arm_init_fp_status
Date: Tue,  9 Jun 2026 12:20:29 -0700
Message-ID: <20260609192110.752384-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Create a function to set all default controls for a float_status.
Other settings for specific FPST will be set afterward.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a13e6dae2a..b75c6a6622 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -304,6 +304,13 @@ static void cp_reg_check_reset(gpointer key, gpointer value,  gpointer opaque)
     assert(oldvalue == newvalue);
 }
 
+static void arm_init_fp_status(float_status *s)
+{
+    memset(s, 0, sizeof(*s));
+    arm_set_default_fp_behaviours(s);
+    /* We want 0 for all other settings. */
+}
+
 static void arm_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -626,20 +633,16 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->sau.ctrl = 0;
     }
 
+    for (int i = 0; i < FPST_COUNT; i++) {
+        arm_init_fp_status(&env->vfp.fp_status[i]);
+    }
+
     set_flush_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
     set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_AH]);
-- 
2.43.0


