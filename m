Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6672C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 01:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTsJl-0000cL-Dm; Mon, 23 Jun 2025 21:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJj-0000bu-Iu
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:19 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJh-0005qe-VL
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:19 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6face1d58dcso74005646d6.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 18:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750727956; x=1751332756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbDOcywMqq1dh9LZui16nPkQkSH4+rsckkQuLNP7SO4=;
 b=rrIxR+ybob+ZsnFUD64cvegIQI8fwtbgw6RAB/nJEKilJ8yTAbsDrjJyh7+sm8wNgX
 bXCrcZMFsMGQW+jjE5hS7hlVc4Qq8aARCs5unl1xQAk4uUDojV7uHKVkgCkz9MLEfKAq
 iqdtGHU6D/DTiY/GW8/fLbT8IZqnWRvvS2iN1ZHxPQ1MA/nCCrSp0H5BhBck72aWIiaR
 ZP8i6Ud7VDIDZnt+OV/0I36ZXfWA4cJV+wtA/kEWUoXgWCEiuo6Ac4i+U2+UW33E/mkL
 AF8m0zgXo6HIl0HXPLAk6Au7VLY1zKQw3tZO8G2Bwcc5uThRIZORSK8v86l/gopTXjFH
 qpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750727956; x=1751332756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbDOcywMqq1dh9LZui16nPkQkSH4+rsckkQuLNP7SO4=;
 b=qrrjXA1NPWEoHPSx6LC1q4Z/MobtJ/Ss1x92MOviAHYcTwJiSfN7MkjYT2WmQ7dvvV
 gJ2zxxcrUFyp7/m5fTSgG+WzjQLSaLhzrJv7ftn0i0cSZ+2CpSaUlr9+Bq/CCw2DGKSw
 anRDlmDqmjQH0elnGpSyW67fu5EbBbXXUbLv5EJ9u3SbbQqWmccxo+KzJlx7+Gb9O7Ph
 b5SxKRksI4bkMVeHiKLA14ug0Rmb3dJyJwpmB16+4S8v1VVpI7/ypprUDaAFUEQkq4uv
 q2oJc1Xx1J4SByxvGFqJoHG+S3S9odFuZJMKsuzfzk4U8y0tstMRXLM0OQNwfc1YtcgE
 hHGQ==
X-Gm-Message-State: AOJu0YyRxlREOtoTUMU1AxUey4nbXxHV8++mIG77NZMvWgfNf1Es5v3f
 Q6fDq5kxobbkoX6nJXlO2s+2Ld6dhJ7aYDbORQP2C6rmyMGLy5X037jIR3Hdh+bWVLkj8vmjLEP
 a4hr8eWo=
X-Gm-Gg: ASbGncuRiL4yfConCuXCQGU6SNBDamx2606UIB1KPXCM1lYlR+5ua7/Yr8C18C3vFQ9
 2mK6P2+DWZa+750PH+f7Phuds2v1H+2/374FEzusPZd8nT28ApZpfY+0p7pIJKes0MMsH15J4O8
 /8ibe4XxFM7rnspd2kEbi4JWIxf5IsCD5sdRvsmxvStE9iOrKVnxs96rtwj/kIETVF3TTB+Uv9M
 EodIoeBm4ey+pGpN4d6cRTXt/gAgserDqBgCEdugEsyK5gEt4SOHP7GQT3x8l/SYOS/JO1PA8jB
 Yl36gd/OTUifR/Qnzng5hGTC0jzbTssH68096QXZJuO3PVL1FKaT/lqtembXPfol0rAEd1vh2aI
 ksEGiyK/yV4zPqeo9aJdG
X-Google-Smtp-Source: AGHT+IH6wzCm0v/+kLc+3PWPxJENO7hiIJij2uEkPkftn72SWsVhR29sirNlZZKGwgyfe/u82Nxmzg==
X-Received: by 2002:a05:6a00:4f8c:b0:732:2484:e0ce with SMTP id
 d2e1a72fcca58-7490da9cd1amr32982278b3a.17.1750727945872; 
 Mon, 23 Jun 2025 18:19:05 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d28sm412080b3a.28.2025.06.23.18.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 18:19:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/11] tcg: Split out tcg_gen_gvec_{add,sub}_var
Date: Mon, 23 Jun 2025 18:18:56 -0700
Message-ID: <20250624011859.112010-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624011859.112010-1-richard.henderson@linaro.org>
References: <20250624011859.112010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec-common.h |  9 +++++++++
 tcg/tcg-op-gvec.c                | 32 ++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index b2e797780d..c93d8b2356 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -296,6 +296,15 @@ void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t oprsz, uint32_t maxsz);
 
+void tcg_gen_gvec_add_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          TCGv_ptr bbase, uint32_t bofs,
+                          uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_sub_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          TCGv_ptr bbase, uint32_t bofs,
+                          uint32_t oprsz, uint32_t maxsz);
+
 void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 85e1807580..9714eb902b 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1999,8 +1999,10 @@ void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 
 static const TCGOpcode vecop_list_add[] = { INDEX_op_add_vec, 0 };
 
-void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+void tcg_gen_gvec_add_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          TCGv_ptr bbase, uint32_t bofs,
+                          uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen3 g[4] = {
         { .fni8 = tcg_gen_vec_add8_i64,
@@ -2027,7 +2029,15 @@ void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     tcg_debug_assert(vece <= MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+    tcg_gen_gvec_3_var(dbase, dofs, abase, aofs, bbase, bofs,
+                       oprsz, maxsz, &g[vece]);
+}
+
+void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_add_var(vece, tcg_env, dofs, tcg_env, aofs, tcg_env, bofs,
+                         oprsz, maxsz);
 }
 
 void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -2180,8 +2190,10 @@ void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+void tcg_gen_gvec_sub_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          TCGv_ptr bbase, uint32_t bofs,
+                          uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen3 g[4] = {
         { .fni8 = tcg_gen_vec_sub8_i64,
@@ -2208,7 +2220,15 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     tcg_debug_assert(vece <= MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+    tcg_gen_gvec_3_var(dbase, dofs, abase, aofs, bbase, bofs,
+                       oprsz, maxsz, &g[vece]);
+}
+
+void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_sub_var(vece, tcg_env, dofs, tcg_env, aofs, tcg_env, bofs,
+                         oprsz, maxsz);
 }
 
 static const TCGOpcode vecop_list_mul[] = { INDEX_op_mul_vec, 0 };
-- 
2.43.0


