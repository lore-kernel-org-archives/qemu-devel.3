Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10DAC0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7t-0003ur-1R; Tue, 11 Feb 2025 11:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6P-0007BD-0B
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:13 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6K-0003i9-JC
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:12 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43618283d48so40484925e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291226; x=1739896026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M3tUHrJKXhPgJLvHhPMtmUKu8TibFHHOtysrUtn96z0=;
 b=tf21I+ZUCwBbtH6EkzNAMoh3OviI5BdJV6Xk1mUqaQJByIDrjXcp8qTu8vEiLTQtz9
 FORMoXi2V3sCUXD4VoiEI8/zT6PpDt7egOi9a+J7Ml1imSGpPVMgyUGo8SsQiVvVHnoZ
 3oyExQitR/t+cGYnRg3oy6C4Y1D76XzfSKlDuIycicbw+TSrWwmRWauQOy5+VzQEKNu7
 eVLl2CpbLPoU/aq2OLCn/ypO1qY2/hyHDSZ+eCxUfHp2nl/GxpPNcCu4JRoGGSpaNcYL
 /PttwCS2bXvb2Ec3mwemnfe/cuz6E3DmHujJoJRR1TaU0ozT1Izmfyz7Kp+mMPv0Lvi4
 TPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291226; x=1739896026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3tUHrJKXhPgJLvHhPMtmUKu8TibFHHOtysrUtn96z0=;
 b=iLK1egVTwK1fXBu2fC0KEf1jYda4VIAkn9M4BIoIFvtDA5ZDX8tNO+IFMgjUoimbVH
 w/8i8kE+y4H39N5RwPxoK+dZ0k9ZB+oWw4Khjt+vHdbzN2dkzpgk3oE+HxsZXT0Kqbuy
 Zs1cSTEXXFYcvuBwW1Ftco2w/PGDn+3gULTOr0U5ikQpMvnOqAhDny8xoWmzf2DMdmPG
 aOXUwCCg2CcRXjvB6uRkj4bfftZaKJeXcBInEFqR19yRW67xyptoWirf0iMV8z9FRg3W
 jjhxb0X8b+oW9ndrMK3A3FGT2bd5XNb0ssYDPtUdqi9FViFcksdbbUgb3ZxGhShopVnP
 sFDQ==
X-Gm-Message-State: AOJu0Yz+ezlK9hnh95RrNhrPy0S9jOJ2Uhs57MTff3mcpPH+yQEf8uMy
 3NeV3UEBip9dIvKcHbMnbkKE8JZVYRea3q8wKkc59bEP9E0UgqeC3YXNJje16syy1SZTJNIokoV
 e
X-Gm-Gg: ASbGncsF5sqrU0/21cS4bi52e1RTDULyPWLSIiKGAY6KW/UloM840+I7C05bpk1zB9q
 I8US82w147GaVPZCWnm42C65M+x9QIYjNoBepfX7gS+O+qvERmEIBB+rLpftgBf23TsHyGl8mPg
 +RU0LxyQ/xaSfDMqliY4IDD8WtXawXVnYuxJZd+JwK7pcULJNCJg9Ivgt2QM1o+xY9UmTDxasqu
 a23I9gmV5wuVi2WokmcRJ7dRmZcWHRx8k+OLOlJuny7WSI9c8AKx2A1OS5XsEOxHk4UPpsirWA5
 649ev1An9LtOa4Ivp55o
X-Google-Smtp-Source: AGHT+IGVXWAw4olnu68X+0byIjTbebeUYXoDjcZTgwYniLSgu6fMCnPGwas2OC01bvymFZNWXsjW/Q==
X-Received: by 2002:a05:600c:3147:b0:439:45e2:897f with SMTP id
 5b1f17b1804b1-4394c814388mr57251465e9.11.1739291225698; 
 Tue, 11 Feb 2025 08:27:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.27.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:27:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 67/68] target/arm: Read fz16 from env->vfp.fpcr
Date: Tue, 11 Feb 2025 16:25:53 +0000
Message-Id: <20250211162554.4135349-68-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Read the bit from the source, rather than from the proxy via
get_flush_inputs_to_zero.  This makes it clear that it does
not matter which of the float_status structures is used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250129013857.135256-34-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 2da44ae7102..cc3586f44ac 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2155,7 +2155,7 @@ void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
     do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
+             env->vfp.fpcr & FPCR_FZ16);
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
@@ -2173,7 +2173,7 @@ void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
         }
     }
     do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
+             env->vfp.fpcr & FPCR_FZ16);
 }
 
 void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2183,7 +2183,7 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     float_status *status = &env->vfp.fp_status[FPST_A64];
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
+    bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
     if (is_s) {
@@ -2236,7 +2236,7 @@ void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
+                 env->vfp.fpcr & FPCR_FZ16);
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
@@ -2254,7 +2254,7 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
         }
     }
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
+                 env->vfp.fpcr & FPCR_FZ16);
 }
 
 void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2265,7 +2265,7 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
     float_status *status = &env->vfp.fp_status[FPST_A64];
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
+    bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
     if (is_s) {
-- 
2.34.1


