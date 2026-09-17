Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9508AC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73o8-0003d9-1M; Thu, 17 Sep 2026 00:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nL-0001Ul-Fb
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:24 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nH-0007DY-RO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:22 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4c79fso154729a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619538; x=1790224338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h5dzr7U9WMKHt2bDyFr+kGeGhS0c/3K+Cu4eTX7xA2k=;
 b=kp/HykT9DXvI4bORH7HScVBH/8REH0JZCdKCegbkqid6OJeV3Zwn9IvuzYNkVSqbYF
 novxmTnkgf2Wz1jzc90CtunTbUFhIIs473o5U31EmXOuVv2x+SLgoPLSvUeDYC5Du6Pu
 NRsphNINcB3LDxc7oAAqRomN45FPX3Iax8Bu3sLxyGxSFwcaM5D4i/URls14ifSdm+Gg
 dN/Q92u0AsauZfhzQ8yfEWCdv0it7eit5wTi6zzmr6WT4KI5KE8R2x+WnyM8lT1/wHMS
 RIVe1oNxZyHrTs8ZcQb+J00MpPOxI9fIzqjmmgIx0E5z8vFp3Dnioo2F5lgRtuT7K/Ev
 ttIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619538; x=1790224338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=h5dzr7U9WMKHt2bDyFr+kGeGhS0c/3K+Cu4eTX7xA2k=;
 b=0OA/PqrC5S8+da/Z++RE/c9V01vlk43Vv5hhiReJ87wDqcc8ci/u+r+9xd83w81QfL
 sBQ0+zeAuq8WsLkeYAGKre9FM81BGzI3NFP2n5QTW1r0S82j17vZ5jnPpiLGCxxqfu6D
 EmwtOpbOVtNkEy4ivXvmFbFmIh1ZLaOQkA04cmoF3xDZ2Hv6MOklt4HJPnVsKKX0JXKV
 WxuFaVdzIKxVB2Mg0aYzWkcSbPtQkPMoNyeh94etxCz/AF7WibxSPVfAYD1lphLFziHb
 hLJWlzelwiq1llGW78mC7v5ChOIDHH6gRX3leoHcQT5y2GqwHxjOFUorUshDZrs+4S/5
 rvJg==
X-Gm-Message-State: AFuF++naEKTwKtQgzHviN4KR0Z8O6MS2c8ObM9sggji3KRidpDdxRM+T
 KVqdw6OFjvJjMj6ZXUFqJ6jLYcry5YkR02xKC00uzz5o97z1S3VAdPwMaJXqM1PM0xsc50C2wab
 zsO0Vylo=
X-Gm-Gg: AYBFou126JnqvixcCTGG/7wn6BDdSGN7658Ii0AGEmloEK5g3JMSJ7nL+MSH90wJt1a
 Pxq/3NrU5LMoumgdlAqoSJ5++icZx9oke5L8WCSLpvLsAuMGnTXgy+zyepKyxg40APcqLlmK9Bc
 mVCRXbK/IFJ9hgclk2vSs/Du2l2yT/4mrq0wjaJcj21wfNHwfpS8wKSZGoGwQKO3O1QD/++1Hte
 LkBjVFW5Jyo8i1C7mkPf2hNVJiMElaaJTxNFk97VIn676WkaReknOemg/YXqRw+2SCf1MTRpu0Z
 X4JSsmlkWZAHczi/PtDxz26IKn2WJxVyBj/bOtMcQL/cVKh9cAhzRKBACCr7KByBxYjwbq333r9
 9srC0DqJqNO+XoBw+M86Dtp8fpGpKk0kUzDhkDsrUcTV/3qi+zpIUygVu/iwf21YG65ksn8rMzF
 ShqiXcHM+TmxiFHEbCx6SjbPbAgCp1pkTVgh3kCZfRn9B+XZhUcACrgwgmUrgMCAFtGunKztTDt
 6GsqDOgQgs+PMG69w==
X-Received: by 2002:a17:90b:3ccb:b0:398:ba9e:75ff with SMTP id
 98e67ed59e1d1-39e1e52627bmr12538775a91.21.1789619537312; 
 Wed, 16 Sep 2026 21:32:17 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 048/101] tcg: Generic expansion of tcg_gen_negsetcondi_*
Date: Wed, 16 Sep 2026 18:27:30 -1000
Message-ID: <20260917042823.542588-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 18 ++++++------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 6ec53bd7a15..9834a70cac9 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
-                             TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
                          TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -211,8 +209,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
-                             TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
                          TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 8bbbf39f13a..a620c8ad69a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -18,6 +18,7 @@ DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
+DEF4(negsetcondi, TCGCond, TCGV, TCGV, TINT)
 DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4fc8d23e629..334e5569e09 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -587,6 +587,12 @@ static void gen_negsetcond(TCGType type, TCGCond cond, TCGTemp *dst,
     }
 }
 
+static void gen_negsetcondi(TCGType type, TCGCond cond, TCGTemp *dst,
+                            TCGTemp *src1, int64_t src2)
+{
+    gen_negsetcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
+}
+
 static void gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nor, type, 0)) {
@@ -777,12 +783,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
-                             TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
@@ -1537,12 +1537,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
-                             TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_negsetcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


