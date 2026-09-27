Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9646EC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksW-0008Is-Na; Sun, 27 Sep 2026 05:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrU-0002IC-Go
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:58 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrS-0008HI-Q9
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:56 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc797656e44so468054a12.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500072; x=1791104872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y9pw3OmFbDMZGRxcU3/AveybLavelLjphoam390pneU=;
 b=bWD4gblmG3+8T5x9GRLfGi568GbQTRh0qqCnatBxhFuOpRrMrSUsvdDPh5ex291Kw1
 K+EOeX9K3jheuIL6jiT/BbsGPzMEZgLAfSQVR1SRU9niAcbjcLqWfyq29e7v4C/z+7wU
 Nzjzlrej/cVxsKE1sKV/zbA2fKpKiFoFY55XTgYmtifYVc5BIjIdwg6ihB58NCDfqTXM
 dKJiLQFjML5vPKVcTCgDRn3s+W+9kYERrzh5DouHkAZipylww0R6HO9iYqh98WgVJXSX
 UF1cbAANAE3Ip0/TqOywaNFHkDUZGNB1YbKap7zbj6i/UIsuVYGTLhiyt/txcdinknZm
 FHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500072; x=1791104872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y9pw3OmFbDMZGRxcU3/AveybLavelLjphoam390pneU=;
 b=xD+Bvi9C7BxBNR6X1mUGp2M127EU7knGCu0+Hg+RBzSwslwSje49AljYVlWQ8hgrsW
 nqOXHo3hDi7xi6QrpVTVOOhGY/GYoPZUuU3NcGc/G8iTUiCdWjra/p8G74OoE1SsNBfv
 6Oy6fcbCw6PkhQiW05AhYcf2jPRWrL90L6cM/Iq9PkJvVad6X781bD9lL3TQs1TI4pLf
 oNBn8CvTmCTKhXUt5jigwubw+Ta0wULqi+XxZhSfShPtLqvZzUMQ3xd6XRwVDcema8Cb
 1v46iTjhFFz+oaiDi2kHwdHgbz/M94Z8W3wtdJN26XoCoIw5DLJQ/FYPwAAf+mQDKQsJ
 uSEA==
X-Gm-Message-State: AFq9FYJjPXZf+QafVyJ4JLvcoPPHyfKsO9LUU/LUMsPfm4nwxZBq+ZdZ
 CcvidcCC0rShuQN9jZhrMO7y5M/lRmVkmQr/m5je2ypnRGsKPLreJcPmZD2ZFFderGBzN4EnKDd
 9dBbg
X-Gm-Gg: AYBFou17hoDxH7bodChiroyQlt1FWTE9561i5sp5Cyu8ed1z1tS5LE/ZKZr2dneErQr
 7fhhddnt0mUb1Cmim6L4i56s2Fgbpu/hv35pSmovoCxNWKPN80Uou46eWbmyoFtZIolkeOLu8lM
 v7Z1PGL4RFJ2Jkm+7Bqfwa4fcwizAr+eQ4C3xp6kskXIdAhalr0crcWnzAEaIzBfNk2vzbkSuR/
 QCY/4HY5zxv1tGj6fvqN0BkPr8hpksym47ICB04i881UCgrL+ovMgmuoNxJyuGbAar7s5tzBYwY
 zCzumxmh+wYsMni0Nqh1lp2gXZFUDbbcssUmUvNJcHx1FcodU7D5IiX0gZUtnQ5AnV9Dpc76Ljs
 hg1nC0unZHYtnWu0WruiFEixjwQvO5DFFu7ocFvK+X7pxHyWO7V+ZCft3+5JhYsg5zbzILTu2AD
 TRo/lLw3eYc2Qci/jtrpM3qOmtSp01a3snORtdunHRgrzlDbdJzE3dIwIunimaYOroXHYJPlQEG
 K3cy5pa0D4qI7x862rtwj/sIvFJvg==
X-Received: by 2002:a17:90b:540e:b0:39e:6a7e:ee1a with SMTP id
 98e67ed59e1d1-3a098da41a6mr8394533a91.38.1790500072481; 
 Sun, 27 Sep 2026 02:07:52 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 090/101] tcg: Generic expansion of tcg_gen_ld8u_*
Date: Sun, 27 Sep 2026 02:00:00 -0700
Message-ID: <20260927090011.10724-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 981dfb73019..bf300de4b9f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,7 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
@@ -168,7 +167,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a110e645104..75bb38a07e5 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -33,6 +33,7 @@ DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index cbed2ce790f..608010bb542 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -782,6 +782,12 @@ void tcg_gen_ld8s(TCGType type, TCGTemp *dst,
     tcg_gen_op_tti(INDEX_op_ld8s, type, dst, base, ofs);
 }
 
+void tcg_gen_ld8u(TCGType type, TCGTemp *dst,
+                  TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld8u, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1387,11 +1393,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
@@ -1420,11 +1421,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
 /* 64-bit ops */
 
-void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
-- 
2.53.0


