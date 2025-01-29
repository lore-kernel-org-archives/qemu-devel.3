Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C88C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx39-0000zr-MH; Tue, 28 Jan 2025 20:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx37-0000yb-0A
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:25 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx35-0003cd-9W
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:24 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2163b0c09afso115533505ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114762; x=1738719562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q33D6yJnXJXu9dlEjHBd58w+LYInd4Y2qLPYlRCltEc=;
 b=yyCSHKqb3d8RIygFMbXT/KF/Ivrp5GBqXXacDfWKfFa3hv8JWYpL4xJazZwPAkK334
 b1LYpt6HWSGkZ/MKpvHM69RfBy9sAyBc3z9b0oVCzp7D+YZLjmFTfGcK5M7BmaojNr1X
 lGVgZJfDL6t0RgcLWbdsS7MFUUMyIT/D/eLdYI/zE0fqOFtVCh0+NUf7JtnLDe+AGmCB
 cr6As6+eQL1/VDkhn1RqiqQVDr+eK6PGlse/FBDdtem5BanF/Buy83ST5bHglE9GGZ/g
 tTOS97/FIxLva5lOCeqFhnUu3EyxzHQEBzA9eaGmoXeaKAqwMlWB/DkzSsr7j2X493OT
 EmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114762; x=1738719562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q33D6yJnXJXu9dlEjHBd58w+LYInd4Y2qLPYlRCltEc=;
 b=qRV4oN7MpvgTSWTvOrEIee9u56VNWQMk9MDrLHSmcegQk3V1p0omdNquk1urAPGm9R
 N5nQE+XNDKk1RU/Z8j1b1tItBJe/khvghbeLN1wX2de8uXs87NMl8XYOj0WhRVYyNGOA
 Ov9Zud9ZmANdS8Ni5t3/ANCcrWAY28WtG8r8Y3+pypG3jzdyH6E8Foz3usU9wdhvUQkG
 ZVxymlq8h1HOycsTgVsFiDkidDBQ84tKvKJRtPUtav7MZGlAVrW9iSQMu6WfIFZ5Cy6u
 hq4Zslqxv1LUhjpaRtFC6gjbxh664Kpm6Kly9F1dwmAkphIej25ASU3WcyqRE+e4i4ny
 fMIQ==
X-Gm-Message-State: AOJu0YwGrrGxc2PG90/e+Vvl5ZaiUuXS7bHUfTdYD64jDgHyo69vHuZA
 caIjftnANqcvJv60hdjBRY2aIAIHxhiRuM+DVzh2aduHL3AFtzTsR98/3IP1YMiDjoDvp3V9RI0
 s
X-Gm-Gg: ASbGnctdBg9KIj7XGNWENK8vabiuoOQ6pPulOFFxxllt7ypGFpFphc6PXWzuWJJZD8T
 aKeIJdcM47bIilr+HLSEn+10wgnqCB5dQPJ64zC1m14H434twm1vcDl9XVPpeRF0XNd6XyvhH+t
 D4w2ptqEa+l34R+V+Y0J026o/R3JNg4rzfOEn5n5q79f6L527i7JIJqaWoZ+BXUCuWxP4ykqYA6
 mvmZYNbKZDkvv7rjr1Q/jO71W5Ul3qjCiNixUfdWnYBOrVqQRebD23mdQG8/Ola9BGHx2t7qv+y
 jOIlSqlvQec7VXSB3qfX13WaaEn1vuMU5cv3d2au6Zh+VJh7Eg==
X-Google-Smtp-Source: AGHT+IEG+u8ABc9bgjUdLNZvWMRA1hjmls6+I6MJBvDQavjYH362r/ZGH0MBDI9NPEDrtrCsZGf5ww==
X-Received: by 2002:a17:902:d2c5:b0:211:e812:3948 with SMTP id
 d9443c01a7336-21dd7b681dfmr23545015ad.0.1738114761947; 
 Tue, 28 Jan 2025 17:39:21 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 34/34] target/arm: Sink fp_status and fpcr access into
 do_fmlal*
Date: Tue, 28 Jan 2025 17:38:57 -0800
Message-ID: <20250129013857.135256-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Sink common code from the callers into do_fmlal
and do_fmlal_idx.  Reorder the arguments to minimize
the re-sorting from the caller's arguments.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 03b0a6ebed..25ef7af029 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2125,9 +2125,13 @@ static uint64_t load4_f16(uint64_t *ptr, int is_q, int is_2)
  * as there is not yet SVE versions that might use blocking.
  */
 
-static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
-                     uint64_t negx, int negf, uint32_t desc, bool fz16)
+static void do_fmlal(float32 *d, void *vn, void *vm,
+                     CPUARMState *env, uint32_t desc,
+                     ARMFPStatusFlavour fpst_idx,
+                     uint64_t negx, int negf)
 {
+    float_status *fpst = &env->vfp.fp_status[fpst_idx];
+    bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     intptr_t i, oprsz = simd_oprsz(desc);
     int is_2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     int is_q = oprsz == 16;
@@ -2154,8 +2158,7 @@ void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
-    do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
-             env->vfp.fpcr & FPCR_FZ16);
+    do_fmlal(vd, vn, vm, env, desc, FPST_STD, negx, 0);
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
@@ -2172,8 +2175,7 @@ void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
             negx = 0x8000800080008000ull;
         }
     }
-    do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
-             env->vfp.fpcr & FPCR_FZ16);
+    do_fmlal(vd, vn, vm, env, desc, FPST_A64, negx, negf);
 }
 
 void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2205,9 +2207,13 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     }
 }
 
-static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
-                         uint64_t negx, int negf, uint32_t desc, bool fz16)
+static void do_fmlal_idx(float32 *d, void *vn, void *vm,
+                         CPUARMState *env, uint32_t desc,
+                         ARMFPStatusFlavour fpst_idx,
+                         uint64_t negx, int negf)
 {
+    float_status *fpst = &env->vfp.fp_status[fpst_idx];
+    bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     intptr_t i, oprsz = simd_oprsz(desc);
     int is_2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     int index = extract32(desc, SIMD_DATA_SHIFT + 2, 3);
@@ -2235,8 +2241,7 @@ void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
-    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
-                 env->vfp.fpcr & FPCR_FZ16);
+    do_fmlal_idx(vd, vn, vm, env, desc, FPST_STD, negx, 0);
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
@@ -2253,8 +2258,7 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
             negx = 0x8000800080008000ull;
         }
     }
-    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
-                 env->vfp.fpcr & FPCR_FZ16);
+    do_fmlal_idx(vd, vn, vm, env, desc, FPST_A64, negx, negf);
 }
 
 void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
-- 
2.43.0


