Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBEFC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYF-0006QM-Al; Sat, 01 Feb 2025 11:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY9-0006Hl-8t
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:53 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY7-0001AZ-Nn
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:52 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso18602555e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428050; x=1739032850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PiC8b+hxDayGjJ/0/ccDWcMdvLrmbzc3zVuQjWwGjhM=;
 b=g6cZQEK0nD6Hp9l7FrVHt07tb06olo9Dn1+kxvKp/2IDziU/Z1I1EXl7bx74y/pkNh
 Z+EH/+M/twVFBKas1kgR+rFxzVfiqR3OGUdrNqhRJu+3Ni9TjEIWWNUKQr4ytoQ9Waw+
 B89tnDOm32x1oUUA7XFyHzIQBCKD86Rnzmz5AjlfLG3fKvakZVrXQmJEPEY/ZA3fKyh2
 6TBG3iah1+rfg+RR73c1+h6hzKl8C14PxYReqlfFE3ohfRYqUwwsVtc4xuLytQg38KOo
 nxpl/WWzHgtrRBs8hO69qKcDNA2gyyUue5lTPg0a9Ye+MHGwf9OQe79WbBq+3rK8AZMg
 mdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428050; x=1739032850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiC8b+hxDayGjJ/0/ccDWcMdvLrmbzc3zVuQjWwGjhM=;
 b=FMidDx8zS8XLhXyrS0XxZlXRYM38iIOp+kqHGT5sImVfq8V5wr13cOg6VGhIr8FWdA
 pcatZWta0XwHwfvx3nuLjFe2GLwWUHI7Gk++TvKbivryonuHypQPAreiv2uHJQDriWLi
 Ti+1jrNDzUMKOqSe9wlu6iWtSnEzDAhlOwiKlJfu+fsJIDcAW5k7qwnK59YIx4AkzMzJ
 pJWQP43V6wA78UC3N6n3ZpRiT8FKuz6dPvOnxYhBDX8XbgQNIqXGC1iteS8YUr0M30Dm
 fYg/t2o4DEoAa/jwjPLXqM01JL2km8rr+MMXgIK51/FJ1HQf+tDMa1juMfEP4duNsbDo
 2egA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa4I1bcHoxjfbiypQHhOalwzos9kYy6IHZ6cBo+VHMPU6fA+ESD2JRPzgWJj1rh9sGsCvo4lEN7hcu@nongnu.org
X-Gm-Message-State: AOJu0Yz9ZN3XlP2vCZ6w4XkntNIz1/rdBqENINvtdhpVFyVkYiExE6h0
 WG/uS6mGgVzaqsGWW1dLSHIIj5/rUj4je6R6VY55aCAxPwo27JwuUe2XsGC39Km00TbGV8synhk
 G
X-Gm-Gg: ASbGncu3rYE+GjyAY78vVW6lVmFFVqjpvEo0lMatfaAnaLQhMjwoD45psfJR+sCLXcN
 Cz3GcJNS3I5ytR8QeqdWX4VnC5yHtoM7NNnoEZhMCSoycr3Ba80TnsfzJxfhVvFPqMOSzeqF6JV
 /pmdcXdJpynqzMWsA0cKuzNqF6HcZJzioQxUt86A8BF2lMlV5vAaxeOFQtwQDuJe7Jq+3r7nVae
 cCj5JeT/Mo9c43nj5AfYo/J6tVmI0u7c8WVeI/JREQtV1R+bw30JHde89Ai0ySHoIvc4YnFm/xg
 CRM5TbGjG6AXpcwwpFVH
X-Google-Smtp-Source: AGHT+IGlY2m1UwU319OCHUn9+NbPYUXwNmP6/vauJvWKVNVVRyHPA5eVz27sf9GOL6Yq8mMN1TfFmQ==
X-Received: by 2002:a05:600c:45cc:b0:434:e892:1033 with SMTP id
 5b1f17b1804b1-438e6ea8c74mr59945075e9.2.1738428050254; 
 Sat, 01 Feb 2025 08:40:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 26/69] target/arm: Implement FPCR.AH semantics for FMAXV
 and FMINV
Date: Sat,  1 Feb 2025 16:39:29 +0000
Message-Id: <20250201164012.1660228-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
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

Implement the FPCR.AH semantics for FMAXV and FMINV.  These are the
"recursively reduce all lanes of a vector to a scalar result" insns;
we just need to use the _ah_ helper for the reduction step when
FPCR.AH == 1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index cad9883f7dc..80a6562ed51 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7029,27 +7029,35 @@ static TCGv_i32 do_reduction_op(DisasContext *s, int rn, MemOp esz,
 }
 
 static bool do_fp_reduction(DisasContext *s, arg_qrr_e *a,
-                              NeonGenTwoSingleOpFn *fn)
+                            NeonGenTwoSingleOpFn *fnormal,
+                            NeonGenTwoSingleOpFn *fah)
 {
     if (fp_access_check(s)) {
         MemOp esz = a->esz;
         int elts = (a->q ? 16 : 8) >> esz;
         TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-        TCGv_i32 res = do_reduction_op(s, a->rn, esz, 0, elts, fpst, fn);
+        TCGv_i32 res = do_reduction_op(s, a->rn, esz, 0, elts, fpst,
+                                       s->fpcr_ah ? fah : fnormal);
         write_fp_sreg(s, a->rd, res);
     }
     return true;
 }
 
-TRANS_FEAT(FMAXNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_maxnumh)
-TRANS_FEAT(FMINNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_minnumh)
-TRANS_FEAT(FMAXV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_maxh)
-TRANS_FEAT(FMINV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_minh)
+TRANS_FEAT(FMAXNMV_h, aa64_fp16, do_fp_reduction, a,
+           gen_helper_vfp_maxnumh, gen_helper_vfp_maxnumh)
+TRANS_FEAT(FMINNMV_h, aa64_fp16, do_fp_reduction, a,
+           gen_helper_vfp_minnumh, gen_helper_vfp_minnumh)
+TRANS_FEAT(FMAXV_h, aa64_fp16, do_fp_reduction, a,
+           gen_helper_vfp_maxh, gen_helper_vfp_ah_maxh)
+TRANS_FEAT(FMINV_h, aa64_fp16, do_fp_reduction, a,
+           gen_helper_vfp_minh, gen_helper_vfp_ah_minh)
 
-TRANS(FMAXNMV_s, do_fp_reduction, a, gen_helper_vfp_maxnums)
-TRANS(FMINNMV_s, do_fp_reduction, a, gen_helper_vfp_minnums)
-TRANS(FMAXV_s, do_fp_reduction, a, gen_helper_vfp_maxs)
-TRANS(FMINV_s, do_fp_reduction, a, gen_helper_vfp_mins)
+TRANS(FMAXNMV_s, do_fp_reduction, a,
+      gen_helper_vfp_maxnums, gen_helper_vfp_maxnums)
+TRANS(FMINNMV_s, do_fp_reduction, a,
+      gen_helper_vfp_minnums, gen_helper_vfp_minnums)
+TRANS(FMAXV_s, do_fp_reduction, a, gen_helper_vfp_maxs, gen_helper_vfp_ah_maxs)
+TRANS(FMINV_s, do_fp_reduction, a, gen_helper_vfp_mins, gen_helper_vfp_ah_mins)
 
 /*
  * Floating-point Immediate
-- 
2.34.1


