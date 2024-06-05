Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A32EC27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuMA-00068u-7D; Wed, 05 Jun 2024 13:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM7-000684-LW
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:23 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM5-0003tt-Tw
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:23 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c28d50f16aso24187a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608200; x=1718213000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/yHY2qZ7v+9tc+IfkleSnGc4R3+srOQoXi8iWYTlukc=;
 b=cGbmNvYWDFmyULfyCUEdG3O+vUDQbX6qInWb5t1KV3gUFrriQktqmPjJ43saiDpLCH
 7cTT64e/+gad7Hv1DNsjzFXx6ddd/439yHtEe1V0lNW4lUr+NybnOosGQg93kKSEyELj
 zPMB+SWVQ7mDHTCsoWoXFDUNZP8yhC2souFIJoGBv3MM+Y3DvIueuPuJB/HsNgZj6yJF
 0rtJWF7nAWIabeCZSoPm5D6xo1MCHz4NLFf+ByWzaVSltWvB8U0gtDbM6JovwBTyVCXN
 fzGQ/1uUdit9b1iuNLhl3d5rbsIwXjQbBgeTbYJdbaHydIk3dlABrAQedS2F0saqbuRB
 WuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608200; x=1718213000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/yHY2qZ7v+9tc+IfkleSnGc4R3+srOQoXi8iWYTlukc=;
 b=EVmEPzrDYG5NvYIED2A3JApEGuLj7sEqh9b9UB9o8nV03hR+/7l5Tgi6M1hdkgyLa1
 ikDK2SwMxJiP0008989DdqktksT8FIdyfEyhDZ2PIU/ud/0Zgz9r9hSVo/B0sGXED70M
 Lbf3n3KKNWW/+zxyuJl6ZlyVZAKsUu5ctAljnfO2fQ7FWahOKCOiNpUodPxtj7C4qAQK
 oYSheBg5qAoVbhJMvB6ngFyBxkHAhGUM6I/FXoPX1ySPaYIUsImZJaltvBStCC81+JZo
 Hnfw2TV/tlJ7XLs1c2WhbJEShDB9EIN0wRhpgP60/cjA0Ap4xK0exmFqJN/eDFEXS/21
 fUWg==
X-Gm-Message-State: AOJu0YxIF9lisHShjSLW2g0wzQgK51JrY8VXVyZUtCopzTicDxA3ez5S
 CXuLvErSFyyfFkQn/gj8m4RhK1hQvtRxNCppgghLCL8nRWtiRaHoBsIR41sI7xPyawxrMDvG/b/
 j
X-Google-Smtp-Source: AGHT+IEeHr8ToOjtPhlIZU0EdMjc+wYY0yYJJF14/nxIofftG6TL965FYWZrDkMox7oCCsrnk5dfAg==
X-Received: by 2002:a17:90a:3045:b0:2bd:d67b:6bf3 with SMTP id
 98e67ed59e1d1-2c299a474admr370524a91.20.1717608200041; 
 Wed, 05 Jun 2024 10:23:20 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/38] target/sparc: Implement XMULX
Date: Wed,  5 Jun 2024 10:22:42 -0700
Message-Id: <20240605172253.356302-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  2 ++
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  |  4 ++++
 target/sparc/vis_helper.c | 11 +++++++++++
 4 files changed, 19 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 4ae97866af..fe0d8bc593 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -135,6 +135,8 @@ DEF_HELPER_FLAGS_2(fcmpeq8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fcmpne8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fcmpule8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fcmpugt8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(xmulx, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(xmulxhi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #endif
 #undef VIS_HELPER
 #undef VIS_CMPHELPER
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 508175eccd..1d54de5367 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -391,6 +391,8 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     ADDXCcc     10 ..... 110110 ..... 0 0001 0011 .....    @r_r_r
     UMULXHI     10 ..... 110110 ..... 0 0001 0110 .....    @r_r_r
     LZCNT       10 ..... 110110 00000 0 0001 0111 .....    @r_r2
+    XMULX       10 ..... 110110 ..... 1 0001 0101 .....    @r_r_r
+    XMULXHI     10 ..... 110110 ..... 1 0001 0110 .....    @r_r_r
 
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
     ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2a38152f58..971e7dae80 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -90,6 +90,8 @@
 # define gen_helper_fxtoq                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_pdist                ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_xmulx                ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_xmulxhi              ({ qemu_build_not_reached(); NULL; })
 # define MAXTL_MASK                             0
 #endif
 
@@ -5088,6 +5090,8 @@ TRANS(FPCMPULE8, VIS3B, do_rdd, a, gen_helper_fcmpule8)
 TRANS(FPCMPUGT8, VIS3B, do_rdd, a, gen_helper_fcmpugt8)
 
 TRANS(PDISTN, VIS3, do_rdd, a, gen_op_pdistn)
+TRANS(XMULX, VIS3, do_rrr, a, gen_helper_xmulx)
+TRANS(XMULXHI, VIS3, do_rrr, a, gen_helper_xmulxhi)
 
 static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index c21522c533..c927a054b8 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "crypto/clmul.h"
 
 target_ulong helper_array8(target_ulong rs1, target_ulong rs2)
 {
@@ -509,3 +510,13 @@ uint64_t helper_fslas32(uint64_t src1, uint64_t src2)
 
     return r.ll;
 }
+
+uint64_t helper_xmulx(uint64_t src1, uint64_t src2)
+{
+    return int128_getlo(clmul_64(src1, src2));
+}
+
+uint64_t helper_xmulxhi(uint64_t src1, uint64_t src2)
+{
+    return int128_gethi(clmul_64(src1, src2));
+}
-- 
2.34.1


