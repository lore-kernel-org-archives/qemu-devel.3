Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD35E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPeO-0001Qc-7w; Wed, 11 Dec 2024 11:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdb-0006md-Vk
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:36 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPda-0001U9-7b
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:35 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-467777d7c83so20592161cf.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934753; x=1734539553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9fh0NlbjmdbLKi3RiB0ekN1/PEOAZQ1NU7Dbs3dJ9Q=;
 b=l+6qoJfZc0fL6wo9e0UY/74NJ7XKD463nLUGuf7nj9BsK/+tIuVRBR9Co2UGu9FAmx
 FqRjTwiRK3ToTuV3n4Ug0EIv8dRkmDwXJK5FMOYerLnVUx1TZB7DDHal2sLSgaikDofd
 DgIsutytYqWpS7BLVDwvIrXEuYOlz43UcsGGuSxAgEUlk4n8BnZlXhguTUfm7vnHcjpv
 ySJ66qUu9Q7MIFOe62+vS8nmy/gx8jiFwNNcL21NjWdls95TMv/OFNbYTzUhpAeD69u5
 icIY4hMVmKNMhgTZVSNVBJEw0oWyfLXzTrl6MbmdmezDs9Q9Gyw2zw7S1jW2AvP38fvt
 ea7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934753; x=1734539553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9fh0NlbjmdbLKi3RiB0ekN1/PEOAZQ1NU7Dbs3dJ9Q=;
 b=bi0iKXUfMibNsIFbPV5NFJkmnCTASRB5WdEX/GK93ZDTFFi94441poPJFGuCmBxF32
 ZygwcWvm5oO0sxKeBX2HEjF7Q4HbBnezigCiVyM2bCJluxQTGp7PL8NGSPDvejmElYIP
 E8QjGOPGxU+mxTE04lSE3MeT/iFYC0HmS+uhoHii9RabIxeKL8nUWve4KFFagjWvv13f
 CBzfR/xyF+Yxch5D9qyyk0eh0pgzDDrWCrilUMuzG3uL97rPcpYoj1qP8dXSNhb3PhgO
 tl86T8WB0FQeqoxE1fZPrqJSH+5cnhMERu09c3iQ1EfWS6D1ruGNiuY53fg4+yyoCvlz
 GHuQ==
X-Gm-Message-State: AOJu0YygC3X1twwKyk1HvG9cWXbN9xuEcwQr1hu3yQQWPFG7rvYBiNa3
 iW/u9i76Beabmtt5zbXjjxqNjUIX6ZOoAwebLZ6s8dnXGu+BtWpwIm74PikTagLnQ+rNqR548aC
 UMplTQZ08
X-Gm-Gg: ASbGncs+XPqeSJksfGo2+5PCRR5D2hfAtsWgM8ewllNm5yR+greF7WUT1MSO/cEnpD2
 QNVbDayOUYc3mH+VL2WQLV25j6SganrPVcuNpD8oL6dGl9gvj4NpgXkQNPXswSphSdfXCb9zn4Z
 gzd/ynpz3Q5eGnrZW5gNrm1Rh9SdXyfgCnqzNV+LJ37EgH76jYxo9EgEjDagrizC6yc81WuHKh3
 Jr5+MYr2oqqfG5+7a4z4OaPznpOjAr1hIlOUhhbYOl1dqXcX2bnLxLY+Buxgw==
X-Google-Smtp-Source: AGHT+IETkBqP2kxT+aTn4STefKa1Ufww0G8F2YpfrH2p5rioOIXzTDwdXFoEWRd19aXbbhJq0YwR+A==
X-Received: by 2002:a05:622a:9009:b0:466:ac8d:7341 with SMTP id
 d75a77b69052e-46795423747mr6206131cf.35.1733934753142; 
 Wed, 11 Dec 2024 08:32:33 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 37/69] target/arm: Introduce gen_gvec_cls, gen_gvec_clz
Date: Wed, 11 Dec 2024 10:30:04 -0600
Message-ID: <20241211163036.2297116-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x835.google.com
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

Add gvec interfaces for CLS and CLZ operations.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h      |  5 +++++
 target/arm/tcg/gengvec.c        | 35 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c  | 29 +++++++--------------------
 target/arm/tcg/translate-neon.c | 29 ++-------------------------
 4 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 20cd0e851c..5c6c24f057 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -578,6 +578,11 @@ void gen_gvec_umaxp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_uminp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_cls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_clz(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index f652520b65..834b2961c0 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2358,3 +2358,38 @@ void gen_gvec_urhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     assert(vece <= MO_32);
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &g[vece]);
 }
+
+void gen_gvec_cls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz)
+{
+    static const GVecGen2 g[] = {
+        { .fni4 = gen_helper_neon_cls_s8,
+          .vece = MO_8 },
+        { .fni4 = gen_helper_neon_cls_s16,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_clrsb_i32,
+          .vece = MO_32 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
+}
+
+static void gen_clz32_i32(TCGv_i32 d, TCGv_i32 n)
+{
+    tcg_gen_clzi_i32(d, n, 32);
+}
+
+void gen_gvec_clz(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz)
+{
+    static const GVecGen2 g[] = {
+        { .fni4 = gen_helper_neon_clz_u8,
+          .vece = MO_8 },
+        { .fni4 = gen_helper_neon_clz_u16,
+          .vece = MO_16 },
+        { .fni4 = gen_clz32_i32,
+          .vece = MO_32 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c697f0e944..387bbbf906 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10321,6 +10321,13 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
+    case 0x4: /* CLZ, CLS */
+        if (u) {
+            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clz, size);
+        } else {
+            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cls, size);
+        }
+        return;
     case 0x5:
         if (u && size == 0) { /* NOT */
             gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_not, 0);
@@ -10379,13 +10386,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             if (size == 2) {
                 /* Special cases for 32 bit elements */
                 switch (opcode) {
-                case 0x4: /* CLS */
-                    if (u) {
-                        tcg_gen_clzi_i32(tcg_res, tcg_op, 32);
-                    } else {
-                        tcg_gen_clrsb_i32(tcg_res, tcg_op);
-                    }
-                    break;
                 case 0x2f: /* FABS */
                     gen_vfp_abss(tcg_res, tcg_op);
                     break;
@@ -10450,21 +10450,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                         gen_helper_neon_cnt_u8(tcg_res, tcg_op);
                     }
                     break;
-                case 0x4: /* CLS, CLZ */
-                    if (u) {
-                        if (size == 0) {
-                            gen_helper_neon_clz_u8(tcg_res, tcg_op);
-                        } else {
-                            gen_helper_neon_clz_u16(tcg_res, tcg_op);
-                        }
-                    } else {
-                        if (size == 0) {
-                            gen_helper_neon_cls_s8(tcg_res, tcg_op);
-                        } else {
-                            gen_helper_neon_cls_s16(tcg_res, tcg_op);
-                        }
-                    }
-                    break;
                 default:
                 case 0x7: /* SQABS, SQNEG */
                     g_assert_not_reached();
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 9c8829ad7d..1c89a53272 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3120,6 +3120,8 @@ DO_2MISC_VEC(VCGT0, gen_gvec_cgt0)
 DO_2MISC_VEC(VCLE0, gen_gvec_cle0)
 DO_2MISC_VEC(VCGE0, gen_gvec_cge0)
 DO_2MISC_VEC(VCLT0, gen_gvec_clt0)
+DO_2MISC_VEC(VCLS, gen_gvec_cls)
+DO_2MISC_VEC(VCLZ, gen_gvec_clz)
 
 static bool trans_VMVN(DisasContext *s, arg_2misc *a)
 {
@@ -3227,33 +3229,6 @@ static bool trans_VREV16(DisasContext *s, arg_2misc *a)
     return do_2misc(s, a, gen_rev16);
 }
 
-static bool trans_VCLS(DisasContext *s, arg_2misc *a)
-{
-    static NeonGenOneOpFn * const fn[] = {
-        gen_helper_neon_cls_s8,
-        gen_helper_neon_cls_s16,
-        gen_helper_neon_cls_s32,
-        NULL,
-    };
-    return do_2misc(s, a, fn[a->size]);
-}
-
-static void do_VCLZ_32(TCGv_i32 rd, TCGv_i32 rm)
-{
-    tcg_gen_clzi_i32(rd, rm, 32);
-}
-
-static bool trans_VCLZ(DisasContext *s, arg_2misc *a)
-{
-    static NeonGenOneOpFn * const fn[] = {
-        gen_helper_neon_clz_u8,
-        gen_helper_neon_clz_u16,
-        do_VCLZ_32,
-        NULL,
-    };
-    return do_2misc(s, a, fn[a->size]);
-}
-
 static bool trans_VCNT(DisasContext *s, arg_2misc *a)
 {
     if (a->size != 0) {
-- 
2.43.0


