Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF16C021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7c-0003Bv-7e; Tue, 11 Feb 2025 11:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6P-0007BE-2x
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:13 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6K-0003ik-Je
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:12 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43932b9b09aso36107665e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291227; x=1739896027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u/2K8Z3pwUQ/oXE8NyEXdkhcGga/r0RB0mzMV+vu/gw=;
 b=Bbl/cP/OuU4cbIMYi1B+fQ7jeDBlz8YfRQcgI0YYQKfa7HzD/LCCCZ7cTb/poTykN5
 6bEbt3PYmDI77owMNsLq/db4P4egTXamdjl5gBBgj1Zuj+q5oHGA5NcxBDqb6+BT9bOb
 x2u8sObu/cQ+9WTGJp8n2zkBlECJ2Dpm4SqchGzppkEYEF/OVAB8Qv0Q8egMgZq3CQD9
 RdPoXWw1LtB2q9v96Vgx9rVcQxwBR5k14o8DXfEdi1QLiG/YJ+TpKN/qjaQy7lUFrDe7
 c5AL3hhjsMRq60AOlLvOkIRxuz/v28XKrfljfmU6o2IqqBY9TcrYg2w7NpzU4g53tco/
 SNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291227; x=1739896027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/2K8Z3pwUQ/oXE8NyEXdkhcGga/r0RB0mzMV+vu/gw=;
 b=masioIjP78Fh76mpUpNucinOHjy9ssPiluSpGn7EbPmo/6+UrccQdyKLni9yIjaEy1
 y2ymambgpANl+KoZRC3gsGZcZZWfunE4CfkrRMavk71e/uRb9t2tUkzpIZzmIqH88sGJ
 LXS5hxwvnWWFg9mub8wu6GkJV9hCvCXqODLga8OcOj7/EeakS73c8GA75jY7VhPLumMR
 aNdQ22siYUo4nuxhM625wWQW3R5rbmArpHXWOOUG1z+mAFIOytfhgJWWj/kZiCFDMRaG
 kaqJHXHcl4LxrwahWLJGP5dA20Oz9DlFmk5QiECN9A88Q+A1MOsXbs9eHVb5WOnJUv7s
 TacQ==
X-Gm-Message-State: AOJu0YwT8Vyb2AF5wGwnMwbdX8aSs5OFVSUcsnnH1fn7rUsUX1oPJl0s
 GWSYGimXIs3Dk8per5XIHDBGa3XGBNwcHHouxVtmi2UsNiOJjyM9s/48WnH8h3QNQKwluhj+Ht3
 6
X-Gm-Gg: ASbGncueY9H3NxzePdFcIvQKL+F13yf4hwmiCqIAcsNAwwPuZEmhVj/+zPLbpa/IEMl
 I9L75lGPa0WS8sb/+tXzAL12oG0OlGOnDjwTtArT4IPMJOUPj5E996F2Ig10If7xHNLptRDEFNn
 HQ/lf+KTV9+wgTyr5CTEYzDYelhDcNVKbpxAw9QhNSW3nPrDiRJQ7dUnkiVSqZu0hQ1hgxSMN56
 DuG350Yndy5bogrXavuLJDpx9pluK9sHv4+cEYbbUEqZXdNzG37dTIWG9VnRECkHx4YxhyDJV2F
 HIqGHCuxL/k72gAP7SFy
X-Google-Smtp-Source: AGHT+IGQVNoVgPgtv+C44c1Eah9sK80E2Iq7gvISK5DvWHWO4M2H/rrL1ea6sVgiXWPEbO+/ALg+0Q==
X-Received: by 2002:a05:600c:1f0f:b0:439:553c:2a34 with SMTP id
 5b1f17b1804b1-439553c2b7dmr31003325e9.4.1739291226714; 
 Tue, 11 Feb 2025 08:27:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.27.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:27:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 68/68] target/arm: Sink fp_status and fpcr access into do_fmlal*
Date: Tue, 11 Feb 2025 16:25:54 +0000
Message-Id: <20250211162554.4135349-69-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
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

Sink common code from the callers into do_fmlal
and do_fmlal_idx.  Reorder the arguments to minimize
the re-sorting from the caller's arguments.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250129013857.135256-35-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index cc3586f44ac..986eaf8ffa4 100644
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
2.34.1


