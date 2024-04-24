Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E235C19F4E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYF-0008PB-5P; Wed, 24 Apr 2024 20:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXi-0008Cq-TU
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:52 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXd-0006FT-Fk
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:48 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e2c725e234so12375715ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003243; x=1714608043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qDO8sWnQNbivNt7ZCqaE2Z4gUTvny6k2DjDvVhkGNcE=;
 b=bI6fZUdOgULiuZTm1xQJX807RIPe19m2xHRYQ/Z1mdc79+Kmhky3F80z0XgpzsYj/S
 K8CxPeyRJ/GQgC0tnxFBuiQBhYztmKFd2Fi6D7icrZPWgvY2h0tlTEexP9IuMcgqdkmV
 YH+K+3Ytnq6y1w/8iZ5FWe+ZuhKqzweusDlqf+XCJIMQBtdCoscmSGY8sgoASuAZHAl6
 CUgaWwkcu+D6axH5UTQ6oRMc/JenAMkmACg1skavKKoB1QxPUREkfQJ7Ee/jC6kuvXxr
 GYqmC0EdvzFSSdHorGLnd8vD5Pj8lO27WX/CBq0gJ6jQMXIRsuP94v+QMbLLUyJLkgJr
 7qRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003243; x=1714608043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDO8sWnQNbivNt7ZCqaE2Z4gUTvny6k2DjDvVhkGNcE=;
 b=ZMDjTsN5Qjf7WWcuha4KRkdaj/42Gm6ttpvA50Z6XJA+7aInYZKF4rWx8Z+isO/NN6
 5RuEc87WLzAQkIEj4b1MeLGe35kzGXNFcI6mHp1qosAlumA4mNUwXbxbGUDNYIaROHox
 UY90Db2GWTyUStnvgG5VIGHxfa2ZvGHQrSjAf2Ud6DU61zY9OEfu4NPIbEJoWDykeeaK
 F1LGjg6Tb8U0tPHkl+1mb6V0NdP7zhhIVwg/wZiwtUKleUfhezWeVNKFggoD6CBidRLo
 IWL70/7wleFRDGZlVVfSZrI/LFwXuZ74qdmusdSpNUo0s4aE2EFo2skY39ph4eagO4vu
 ixcA==
X-Gm-Message-State: AOJu0Yy0x9eMWRahWJFFsqlOL45KPonofOnVVjwmUI0wjoMfAjNmmqd4
 gurZhCkGZodePrQE4YLsv8WcZiubHuXNSQW9b61llCk5QW6eCT1VRrvVtR4C9X/rJqvYRIlxVfw
 n
X-Google-Smtp-Source: AGHT+IEsCA2SstKvWWqUWG5h80EKhNbf6tSFy5wy+aHGwo+Ofmg3MwK+pmYzGryLnikkfod7nBsfCA==
X-Received: by 2002:a17:903:228e:b0:1e5:5c69:fcda with SMTP id
 b14-20020a170903228e00b001e55c69fcdamr1832469plh.26.1714003243586; 
 Wed, 24 Apr 2024 17:00:43 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/45] target/hppa: Rename cond_make_* helpers
Date: Wed, 24 Apr 2024 16:59:57 -0700
Message-Id: <20240425000023.1002026-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Use 'v' for a variable that needs copying, 't' for a temp that
doesn't need copying, and 'i' for an immediate, and use this
naming for both arguments of the comparison.  So:

   cond_make_tmp -> cond_make_tt
   cond_make_0_tmp -> cond_make_ti
   cond_make_0 -> cond_make_vi
   cond_make -> cond_make_vv

Pass 0 explictly, rather than implicitly in the function name.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 52 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index dd3921dbf9..a1132c884f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -344,32 +344,32 @@ static DisasCond cond_make_n(void)
     };
 }
 
-static DisasCond cond_make_tmp(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
+static DisasCond cond_make_tt(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
 {
     assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
     return (DisasCond){ .c = c, .a0 = a0, .a1 = a1 };
 }
 
-static DisasCond cond_make_0_tmp(TCGCond c, TCGv_i64 a0)
+static DisasCond cond_make_ti(TCGCond c, TCGv_i64 a0, uint64_t imm)
 {
-    return cond_make_tmp(c, a0, tcg_constant_i64(0));
+    return cond_make_tt(c, a0, tcg_constant_i64(imm));
 }
 
-static DisasCond cond_make_0(TCGCond c, TCGv_i64 a0)
+static DisasCond cond_make_vi(TCGCond c, TCGv_i64 a0, uint64_t imm)
 {
     TCGv_i64 tmp = tcg_temp_new_i64();
     tcg_gen_mov_i64(tmp, a0);
-    return cond_make_0_tmp(c, tmp);
+    return cond_make_ti(c, tmp, imm);
 }
 
-static DisasCond cond_make(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
+static DisasCond cond_make_vv(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i64 t1 = tcg_temp_new_i64();
 
     tcg_gen_mov_i64(t0, a0);
     tcg_gen_mov_i64(t1, a1);
-    return cond_make_tmp(c, t0, t1);
+    return cond_make_tt(c, t0, t1);
 }
 
 static void cond_free(DisasCond *cond)
@@ -787,7 +787,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
             tcg_gen_ext32u_i64(tmp, res);
             res = tmp;
         }
-        cond = cond_make_0(TCG_COND_EQ, res);
+        cond = cond_make_vi(TCG_COND_EQ, res, 0);
         break;
     case 2: /* < / >=        (N ^ V / !(N ^ V) */
         tmp = tcg_temp_new_i64();
@@ -795,7 +795,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         if (!d) {
             tcg_gen_ext32s_i64(tmp, tmp);
         }
-        cond = cond_make_0_tmp(TCG_COND_LT, tmp);
+        cond = cond_make_ti(TCG_COND_LT, tmp, 0);
         break;
     case 3: /* <= / >        (N ^ V) | Z / !((N ^ V) | Z) */
         /*
@@ -817,10 +817,10 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
             tcg_gen_sari_i64(tmp, tmp, 63);
             tcg_gen_and_i64(tmp, tmp, res);
         }
-        cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
+        cond = cond_make_ti(TCG_COND_EQ, tmp, 0);
         break;
     case 4: /* NUV / UV      (!UV / UV) */
-        cond = cond_make_0(TCG_COND_EQ, uv);
+        cond = cond_make_vi(TCG_COND_EQ, uv, 0);
         break;
     case 5: /* ZNV / VNZ     (!UV | Z / UV & !Z) */
         tmp = tcg_temp_new_i64();
@@ -828,7 +828,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         if (!d) {
             tcg_gen_ext32u_i64(tmp, tmp);
         }
-        cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
+        cond = cond_make_ti(TCG_COND_EQ, tmp, 0);
         break;
     case 6: /* SV / NSV      (V / !V) */
         if (!d) {
@@ -836,12 +836,12 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
             tcg_gen_ext32s_i64(tmp, sv);
             sv = tmp;
         }
-        cond = cond_make_0(TCG_COND_LT, sv);
+        cond = cond_make_ti(TCG_COND_LT, sv, 0);
         break;
     case 7: /* OD / EV */
         tmp = tcg_temp_new_i64();
         tcg_gen_andi_i64(tmp, res, 1);
-        cond = cond_make_0_tmp(TCG_COND_NE, tmp);
+        cond = cond_make_ti(TCG_COND_NE, tmp, 0);
         break;
     default:
         g_assert_not_reached();
@@ -903,9 +903,9 @@ static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
             tcg_gen_ext32s_i64(t1, in1);
             tcg_gen_ext32s_i64(t2, in2);
         }
-        return cond_make_tmp(tc, t1, t2);
+        return cond_make_tt(tc, t1, t2);
     }
-    return cond_make(tc, in1, in2);
+    return cond_make_vv(tc, in1, in2);
 }
 
 /*
@@ -977,9 +977,9 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
         } else {
             tcg_gen_ext32s_i64(tmp, res);
         }
-        return cond_make_0_tmp(tc, tmp);
+        return cond_make_ti(tc, tmp, 0);
     }
-    return cond_make_0(tc, res);
+    return cond_make_vi(tc, res, 0);
 }
 
 /* Similar, but for shift/extract/deposit conditions.  */
@@ -1038,7 +1038,7 @@ static DisasCond do_unit_zero_cond(unsigned cf, bool d, TCGv_i64 res)
     tcg_gen_andc_i64(tmp, tmp, res);
     tcg_gen_andi_i64(tmp, tmp, sgns);
 
-    return cond_make_0_tmp(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, tmp);
+    return cond_make_ti(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, tmp, 0);
 }
 
 static TCGv_i64 get_carry(DisasContext *ctx, bool d,
@@ -1452,7 +1452,7 @@ static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
         }
 
         tcg_gen_andi_i64(cb, cb, test_cb);
-        cond = cond_make_0_tmp(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, cb);
+        cond = cond_make_ti(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, cb, 0);
     }
 
     if (is_tc) {
@@ -3541,7 +3541,7 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
         tcg_gen_shl_i64(tmp, tcg_r, tmp);
     }
 
-    cond = cond_make_0_tmp(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
+    cond = cond_make_ti(a->c ? TCG_COND_GE : TCG_COND_LT, tmp, 0);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3558,7 +3558,7 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
     p = a->p | (a->d ? 0 : 32);
     tcg_gen_shli_i64(tmp, tcg_r, p);
 
-    cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
+    cond = cond_make_ti(a->c ? TCG_COND_GE : TCG_COND_LT, tmp, 0);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -4362,7 +4362,7 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
         switch (a->c) {
         case 0: /* simple */
             tcg_gen_andi_i64(t, t, 0x4000000);
-            ctx->null_cond = cond_make_0(TCG_COND_NE, t);
+            ctx->null_cond = cond_make_ti(TCG_COND_NE, t, 0);
             goto done;
         case 2: /* rej */
             inv = true;
@@ -4392,16 +4392,16 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
         if (inv) {
             TCGv_i64 c = tcg_constant_i64(mask);
             tcg_gen_or_i64(t, t, c);
-            ctx->null_cond = cond_make(TCG_COND_EQ, t, c);
+            ctx->null_cond = cond_make_tt(TCG_COND_EQ, t, c);
         } else {
             tcg_gen_andi_i64(t, t, mask);
-            ctx->null_cond = cond_make_0(TCG_COND_EQ, t);
+            ctx->null_cond = cond_make_ti(TCG_COND_EQ, t, 0);
         }
     } else {
         unsigned cbit = (a->y ^ 1) - 1;
 
         tcg_gen_extract_i64(t, t, 21 - cbit, 1);
-        ctx->null_cond = cond_make_0(TCG_COND_NE, t);
+        ctx->null_cond = cond_make_ti(TCG_COND_NE, t, 0);
     }
 
  done:
-- 
2.34.1


