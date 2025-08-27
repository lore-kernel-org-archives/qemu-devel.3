Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8988FCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4ib-0002R3-TF; Tue, 26 Aug 2025 21:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hl-0001au-2G
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:12:03 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hV-0000Dd-1g
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:56 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76e4f2e4c40so5593416b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257102; x=1756861902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5zRWZgnToutMzLlMb+7iuvcy8Qg5Qy4VHsxh6P34qc=;
 b=qdl5+6BGMG74Q4c004Jaoixp9o5Kjk9ijDDKeID9o2h2e3EZ4bAJcYvT6Ytn43JCyh
 0R6JsEw/ep/nGLYJLcOkQVnVK1lHzpYBwrdtxsQXJpDHWde8lIVHo16oXszVv7BVdxEn
 i6un3tiAbAidrSN1xoewA4Pw8DyNcRXeNT7h+j/7BRxYuEzjSfifINLueapV/xwtg68e
 QZ2GaQEQSQ3Aq/LttsgB9+gErD+J2nzEJprBjIAm74NXX9a8Mf3pBN+0p9s/Nox83XEL
 EV3t1+ahd4gGVqCkvj/NecHE4AQvUxwI4LBt5WX7Qtne8UpiF3Shj1+HV0G3tionecbF
 KzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257102; x=1756861902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5zRWZgnToutMzLlMb+7iuvcy8Qg5Qy4VHsxh6P34qc=;
 b=Dhs2R0fA/JmzPciI8fSKK464bUiGptkkIw6Skmf+Fs5Y071VC3omcR8n+0y00Ds5ru
 15O/AFVyNTfQTwl1J/2WqKgNDzY4HSCk9Tgh4L8GpXoDfldmqg3fzHG1TE5qjwP844oY
 BTeWzJYsBUlhAJTL2MOFL9znGgnRQteLWcmEABMSBt5erkI/7EeRx5xHzfsA1Y09pgp8
 Wcdl61vj17Wpr/rYVYv8N4/vZusA4Z3C469W0XqvtfANBli67H53MDPDuUaZFPxV2gWp
 iRsrQX46D46g1m0cHlIMdMsSJcLs0YTgKGAuiGf8ZW5vGbDgWsfYNih98d85gKYT9sWi
 A0Ng==
X-Gm-Message-State: AOJu0Yx0AQja7r3SzYZmSRxR1yG1b9tkI0J9zxrlerbpvhnkrrBhvYit
 f0FEtsAshQT7kEn9je3xX7f//IEuHrfgGtQxUxeTDXBUFcAE/sw6W386OnZGiPBqxPi6+cSbTRN
 80gL+ojw=
X-Gm-Gg: ASbGncvhgXbZlFzy7VFIfwn2jZKLSaSnL1aR/Xz54YtmVMyAnDAghBAaCA83T1v3Vsi
 UKs8KYxp2XYebeHDDQHuZMD3F3re5C2RJcXsurtvC3OL4ogoVQOs8NQ8Szw5eQJXw4UmipI4K0S
 q6n0qodX2O8G7TGA1bAPAx0yt5jWrwxtRtoY5ulLQ3GeXbJ+x9Cm2xGQQmTafiH0KGiobT+qz67
 +a75OSqCWvk3lGpsfAV7Z7BRRuVBv8OzNr2eEz6Ogajs17977S28I9x6ujPn+2+TmwK0NeCV/Iu
 E5HuZ7lUIm+KOP0sQzZsd/5vfXYnezWeVMqgH/TDtoxCDup64A9lWS+q8Uexn73NvLYRPUG6rfC
 8Q039hzwtLnRvFfI1KrC+EZnovcDH4EJ1DPYE
X-Google-Smtp-Source: AGHT+IHmxIfZbrCHAe35cVtBbSlqOUD07ACd40KHOx2bENw4CzEVyKFFXdDDf88ecJEw6j0jEfCJXg==
X-Received: by 2002:a05:6a00:234b:b0:770:4eff:a300 with SMTP id
 d2e1a72fcca58-7704effa4bamr15895697b3a.8.1756257102401; 
 Tue, 26 Aug 2025 18:11:42 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:11:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 50/61] target/arm: Introduce helper_{get,set}_cp_reg128
Date: Wed, 27 Aug 2025 11:04:41 +1000
Message-ID: <20250827010453.4059782-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Helper functions to invoke the write128fn and read128fn
methods of ARMCPRegInfo.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper.h    |  2 ++
 target/arm/tcg/op_helper.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 4da32db902..82592d070d 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -90,6 +90,8 @@ DEF_HELPER_3(set_cp_reg, void, env, cptr, i32)
 DEF_HELPER_2(get_cp_reg, i32, env, cptr)
 DEF_HELPER_3(set_cp_reg64, void, env, cptr, i64)
 DEF_HELPER_2(get_cp_reg64, i64, env, cptr)
+DEF_HELPER_3(set_cp_reg128, void, env, cptr, i128)
+DEF_HELPER_2(get_cp_reg128, i128, env, cptr)
 
 DEF_HELPER_2(get_r13_banked, i32, env, i32)
 DEF_HELPER_3(set_r13_banked, void, env, i32, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 575e566280..a3ae175a45 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1025,6 +1025,34 @@ uint64_t HELPER(get_cp_reg64)(CPUARMState *env, const void *rip)
     return res;
 }
 
+void HELPER(set_cp_reg128)(CPUARMState *env, const void *rip, Int128 value)
+{
+    const ARMCPRegInfo *ri = rip;
+
+    if (ri->type & ARM_CP_IO) {
+        bql_lock();
+        ri->write128fn(env, ri, value);
+        bql_unlock();
+    } else {
+        ri->write128fn(env, ri, value);
+    }
+}
+
+Int128 HELPER(get_cp_reg128)(CPUARMState *env, const void *rip)
+{
+    const ARMCPRegInfo *ri = rip;
+    Int128 res;
+
+    if (ri->type & ARM_CP_IO) {
+        bql_lock();
+        res = ri->read128fn(env, ri);
+        bql_unlock();
+    } else {
+        res = ri->read128fn(env, ri);
+    }
+    return res;
+}
+
 void HELPER(pre_hvc)(CPUARMState *env)
 {
     ARMCPU *cpu = env_archcpu(env);
-- 
2.43.0


