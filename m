Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AF5C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYD-0008Oq-Nw; Wed, 24 Apr 2024 20:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXk-0008Ea-BU
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:53 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXf-0006Fr-Pm
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:50 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1eab16dcfd8so1568705ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003246; x=1714608046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ew8D6ehUvWlq0jHPQbRieoCdY1UW1gXumM2QO3oxkyc=;
 b=W9v8YAFu9S36N8jKl0siylA6qWBPZM4RhT2kIu/ERv8zCbcSgIUgNHMSbYWP310wXQ
 k1qHL9hZdIsb6kOkdYAFCdSsqY63Uw9l/9VXocAla4QRbbAi9KhPV3Zq06xt/rWwHENf
 S4mSRTWghjeLKoBpw0jHMUCzORsj64mDUbj3MIkKkFlCZfFVE87I2F7+iWHKrmTHr/MV
 lDSXqfkfSLEh1F8kYYot9AE70DQIWEGMV0PkLt/ql/OXb79R/eMObzP9rmbny0sbXAVg
 EFOzGwUIGjNhZhNMFZt7xGjT/cF97OzFh++Ase57EOtfwO6QI0ldBjvAOWnXV2rx24U0
 Krpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003246; x=1714608046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ew8D6ehUvWlq0jHPQbRieoCdY1UW1gXumM2QO3oxkyc=;
 b=hSptfRxu2NWa/C7NiThfuLlF3uzald5d1aTiTiIm4Aq29KfJ6duDM4sFyejLHVZOcS
 vFjdzl7P9BgbMAE0a26hW3YymJXXyW1FTO8mN/2yD5CQLYMxxn1pOfETrXdkNrAf8Gjp
 k5bHX8O/uoArGyP7mL+s8Cg05GX6FZmMQJ9ML9ayJ/YrJUZnuXByQ7xIASP05Uv6SFNO
 wOs4NgfBPgVCMDGEKHeM2E8KBa6+hZ65M5bX1jIoqApuKCAAa0P2rpKKdBxCMhKJdLx5
 Wk1AGOIlcdkkmwyvXIf+YoB2/PuGhj3YiTLFM89Fq4pQrNjKz0zPMuxGwQzio2RccLkq
 QoLQ==
X-Gm-Message-State: AOJu0Yzy0AAv5s1PhiTU1fCom6HRzcx+E9cYXwvLQW4RGObGoj55zlNv
 QvGffSCO5i1ZzZIVnAzu/wBgKoyRw8ZNcfDH/MLltHfzAu8ZOqJ8s8sHftpPzzt233U1Y3R2LzT
 R
X-Google-Smtp-Source: AGHT+IF2RsjYq+6L2e47nwLCjAmAvHHdrDBv6OCxtWmUNTNq7uQcmEmNrm9taWZ6Xm9R88mKgdL2yQ==
X-Received: by 2002:a17:902:da88:b0:1e4:17e4:3a1f with SMTP id
 j8-20020a170902da8800b001e417e43a1fmr5162028plx.4.1714003246036; 
 Wed, 24 Apr 2024 17:00:46 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/45] target/hppa: Use TCG_COND_TST* in do_log_cond
Date: Wed, 24 Apr 2024 16:59:59 -0700
Message-Id: <20240425000023.1002026-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

We can directly test bits of a 32-bit comparison without
zero or sign-extending an intermediate result.
We can directly test bit 0 for odd/even.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 78 ++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 51 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 85941f191f..1e772bef4d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -913,65 +913,41 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
                              TCGv_i64 res)
 {
     TCGCond tc;
-    bool ext_uns;
+    uint64_t imm;
 
-    switch (cf) {
-    case 0:  /* never */
-    case 9:  /* undef, C */
-    case 11: /* undef, C & !Z */
-    case 12: /* undef, V */
-        return cond_make_f();
-
-    case 1:  /* true */
-    case 8:  /* undef, !C */
-    case 10: /* undef, !C | Z */
-    case 13: /* undef, !V */
-        return cond_make_t();
-
-    case 2:  /* == */
-        tc = TCG_COND_EQ;
-        ext_uns = true;
+    switch (cf >> 1) {
+    case 0:  /* never / always */
+    case 4:  /* undef, C */
+    case 5:  /* undef, C & !Z */
+    case 6:  /* undef, V */
+        return cf & 1 ? cond_make_t() : cond_make_f();
+    case 1:  /* == / <> */
+        tc = d ? TCG_COND_EQ : TCG_COND_TSTEQ;
+        imm = d ? 0 : UINT32_MAX;
         break;
-    case 3:  /* <> */
-        tc = TCG_COND_NE;
-        ext_uns = true;
+    case 2:  /* < / >= */
+        tc = d ? TCG_COND_LT : TCG_COND_TSTNE;
+        imm = d ? 0 : 1ull << 31;
         break;
-    case 4:  /* < */
-        tc = TCG_COND_LT;
-        ext_uns = false;
+    case 3:  /* <= / > */
+        tc = cf & 1 ? TCG_COND_GT : TCG_COND_LE;
+        if (!d) {
+            TCGv_i64 tmp = tcg_temp_new_i64();
+            tcg_gen_ext32s_i64(tmp, res);
+            return cond_make_ti(tc, tmp, 0);
+        }
+        return cond_make_vi(tc, res, 0);
+    case 7: /* OD / EV */
+        tc = TCG_COND_TSTNE;
+        imm = 1;
         break;
-    case 5:  /* >= */
-        tc = TCG_COND_GE;
-        ext_uns = false;
-        break;
-    case 6:  /* <= */
-        tc = TCG_COND_LE;
-        ext_uns = false;
-        break;
-    case 7:  /* > */
-        tc = TCG_COND_GT;
-        ext_uns = false;
-        break;
-
-    case 14: /* OD */
-    case 15: /* EV */
-        return do_cond(ctx, cf, d, res, NULL, NULL);
-
     default:
         g_assert_not_reached();
     }
-
-    if (!d) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-
-        if (ext_uns) {
-            tcg_gen_ext32u_i64(tmp, res);
-        } else {
-            tcg_gen_ext32s_i64(tmp, res);
-        }
-        return cond_make_ti(tc, tmp, 0);
+    if (cf & 1) {
+        tc = tcg_invert_cond(tc);
     }
-    return cond_make_vi(tc, res, 0);
+    return cond_make_vi(tc, res, imm);
 }
 
 /* Similar, but for shift/extract/deposit conditions.  */
-- 
2.34.1


