Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F8EC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMah-00089Z-UW; Fri, 24 Jan 2025 11:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYK-0003sE-9W
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:06 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYE-0005Rb-Nn
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:03 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso15006575e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736137; x=1738340937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hvxFIxBSlWCivkIbjXPJQuTkInwCZsZuntD1e414ySM=;
 b=Ndyae6lRTgiJ637HzHBLun3Ik2jdHQCuJW2PaHqT6XcMEJ8TdXoZj2bTD4BofT+4xn
 Rj+Zmkd0Jjcv/tKgbe5Oo7JXVvIfaTyOiAaRMzdJUaiY+5K5WP5/ZXirWIIDXBfNdm+u
 iA5o/DcE6bmQx8e+RrvGbhmDJhUPSPvYuBVttA/cE7mC3ZSIkbfDTWgbvm5N6dwF7gpi
 DQ9WgMvFhZfaNgiyilQWcGNRkLEyy2a4BNHAUTcHQvlDyrNRGulYmnW56YgjcGTEKjoA
 0k1Fla7cdMNk75wHZR2dXEAWNQaYN729DaQwgIXjaPM/6qG5irsiV0qHycdDbrO6dNu2
 20CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736137; x=1738340937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvxFIxBSlWCivkIbjXPJQuTkInwCZsZuntD1e414ySM=;
 b=gItReB+AGyl0xEP0kMQGAh6qkGRjrz8KOGx3YYd6gMyyeA1lveFceFj14xfHO4KxPB
 r/KRuQNK3rFEa5jO3EQi2cjQCprlBSYZZIwYGen6A20t8zptixMsgL2Vnr+zq7NqeARN
 TgO98uNkpd+nGZlFzP4LYtCMeFfsBkYPSpUzDnR/Vne0b65jpEILf00Xvpe9/z18QUnd
 So9Dm3UlENL1/Rl1YaEFxF2VfpdItOaAd0AsKpti+/h/uQ5JSGiwdz97E5GPFt52gZMb
 yCYiM1J8Ubtq5zy2tWq5rr+J9BXL6RRmyOaBnzFy9HdJ+LaqWMhJyNcSGdqMvzWspEG3
 7LoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpjghYDw7kKloneIasKFvdYmeaCmaklp0ruHC3TK5keQP342rzvQEyzxVy21Pa5A9HQeSawf2H0HTO@nongnu.org
X-Gm-Message-State: AOJu0Yye4kUvfF++TMsm/kE0ty7N2PeboKqopuZfTFuFbuyjLDNgJpDx
 SFZfukM+Z55bk7APi3K2VmfVhYPqXb1oKcz0FqJVI7CXgiCuCfTAGH2fF6EDrFo=
X-Gm-Gg: ASbGncsXoLiP/L2w0UQDVVt60OYVYJodff9geigAqUuWlp2CV5Nlc488+paHZmdqF5m
 /m+pCxcYmhsW/t3oc0euB68BbBxI2R88RnxLsoEpn4mnCJ6X2v5FNe1uuKp1FeA1zTseVZgXRnn
 GMHziuJD2aTl1Ih8/SqnN7qBA0G1JCO0Q2lNkjyEXr57IYKyFtTLZyZTXKKULbNsbkrO/ild22u
 NAJvnvHSVoZq+rvKqkJWDnvqdhqf5pCJ7UPkJMVy7FoWHI4bGDtA4Rf9qRGaIFLDg2BLV7Wi5D2
 7upyzpY7t0uydvmu3rZLcA==
X-Google-Smtp-Source: AGHT+IHkj11ak/aiRCSsL59Ka0H/c8s7WxxEkyjfHuLqIVBzwchPuHVw/Td77zA2/32imX1DMJL8zw==
X-Received: by 2002:a05:600c:138f:b0:436:ed50:4f8a with SMTP id
 5b1f17b1804b1-438913caeb9mr326394245e9.10.1737736137213; 
 Fri, 24 Jan 2025 08:28:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 16/76] target/arm: Use FPST_FPCR_F16_A32 in A32 decoder
Date: Fri, 24 Jan 2025 16:27:36 +0000
Message-Id: <20250124162836.2332150-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In the A32 decoder, use FPST_FPCR_F16_A32 rather than FPST_FPCR_F16.
By doing an automated conversion of the whole file we avoid possibly
using more than one fpst value in a set_rmode/op/restore_rmode
sequence.

Patch created with
  perl -p -i -e 's/FPST_FPCR_F16(?!_)/FPST_FPCR_F16_A32/g' target/arm/tcg/translate-vfp.c

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-vfp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index e1b8243c5d9..8eebba0f272 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -460,7 +460,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
     }
 
     if (sz == 1) {
-        fpst = fpstatus_ptr(FPST_FPCR_F16);
+        fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
     } else {
         fpst = fpstatus_ptr(FPST_FPCR_A32);
     }
@@ -527,7 +527,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
     }
 
     if (sz == 1) {
-        fpst = fpstatus_ptr(FPST_FPCR_F16);
+        fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
     } else {
         fpst = fpstatus_ptr(FPST_FPCR_A32);
     }
@@ -1433,7 +1433,7 @@ static bool do_vfp_3op_hp(DisasContext *s, VFPGen3OpSPFn *fn,
     /*
      * Do a half-precision operation. Functionally this is
      * the same as do_vfp_3op_sp(), except:
-     *  - it uses the FPST_FPCR_F16
+     *  - it uses the FPST_FPCR_F16_A32
      *  - it doesn't need the VFP vector handling (fp16 is a
      *    v8 feature, and in v8 VFP vectors don't exist)
      *  - it does the aa32_fp16_arith feature test
@@ -1456,7 +1456,7 @@ static bool do_vfp_3op_hp(DisasContext *s, VFPGen3OpSPFn *fn,
     f0 = tcg_temp_new_i32();
     f1 = tcg_temp_new_i32();
     fd = tcg_temp_new_i32();
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
 
     vfp_load_reg16(f0, vn);
     vfp_load_reg16(f1, vm);
@@ -2122,7 +2122,7 @@ static bool do_vfm_hp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
         /* VFNMA, VFNMS */
         gen_vfp_negh(vd, vd);
     }
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
     gen_helper_vfp_muladdh(vd, vn, vm, vd, fpst);
     vfp_store_reg32(vd, a->vd);
     return true;
@@ -2424,7 +2424,7 @@ DO_VFP_2OP(VNEG, dp, gen_vfp_negd, aa32_fpdp_v2)
 
 static void gen_VSQRT_hp(TCGv_i32 vd, TCGv_i32 vm)
 {
-    gen_helper_vfp_sqrth(vd, vm, fpstatus_ptr(FPST_FPCR_F16));
+    gen_helper_vfp_sqrth(vd, vm, fpstatus_ptr(FPST_FPCR_F16_A32));
 }
 
 static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
@@ -2706,7 +2706,7 @@ static bool trans_VRINTR_hp(DisasContext *s, arg_VRINTR_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg16(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
     gen_helper_rinth(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
     return true;
@@ -2779,7 +2779,7 @@ static bool trans_VRINTZ_hp(DisasContext *s, arg_VRINTZ_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg16(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
     tcg_rmode = gen_set_rmode(FPROUNDING_ZERO, fpst);
     gen_helper_rinth(tmp, tmp, fpst);
     gen_restore_rmode(tcg_rmode, fpst);
@@ -2859,7 +2859,7 @@ static bool trans_VRINTX_hp(DisasContext *s, arg_VRINTX_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg16(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
     gen_helper_rinth_exact(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
     return true;
@@ -2983,7 +2983,7 @@ static bool trans_VCVT_int_hp(DisasContext *s, arg_VCVT_int_sp *a)
 
     vm = tcg_temp_new_i32();
     vfp_load_reg32(vm, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
     if (a->s) {
         /* i32 -> f16 */
         gen_helper_vfp_sitoh(vm, vm, fpst);
@@ -3105,7 +3105,7 @@ static bool trans_VCVT_fix_hp(DisasContext *s, arg_VCVT_fix_sp *a)
     vd = tcg_temp_new_i32();
     vfp_load_reg32(vd, a->vd);
 
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
     shift = tcg_constant_i32(frac_bits);
 
     /* Switch on op:U:sx bits */
@@ -3273,7 +3273,7 @@ static bool trans_VCVT_hp_int(DisasContext *s, arg_VCVT_sp_int *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
     vm = tcg_temp_new_i32();
     vfp_load_reg16(vm, a->vm);
 
-- 
2.34.1


