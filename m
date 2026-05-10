Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62CECD37B5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwe-00051i-W2; Sun, 10 May 2026 16:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwc-000508-SN
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:10 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwb-0003xZ-Ah
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:10 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-479ef2b78f3so3130945b6e.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445608; x=1779050408; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=npONxRmCOObiUeLQ9Wvq5fljbBHTluS2k89tWvyshpk=;
 b=SuVtNm0J1+sil1gLeh1V55la5p7pTkyl5feW6YebCXc5KnSrM/0q96SUh1gvpEzQpP
 PxaqTKbQyp6rx9H5NhYhcryyuloeJjB7fI5odJmJW2677QrLD3wmS+VmEvWtp03blMfB
 FboSGNLT/hNcDceJW5AiO+vv4ejv/tgJmXQZF933OLSthiJh2S1B7pXJaRk0Vs/Jub3f
 TNpnmSwEqW6N7Gw1Bgg7qaShnPZnLue7cQYq3q4hq2IDi8bl2Txlk9mI/Ffn6QKkUfDh
 sXDVNbGp0s6BSTERsk0to8gxUkH3LSq41Xv7zmb+XnO0WNGYPtFv3HBWlvKCUtOzgp5Y
 r7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445608; x=1779050408;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=npONxRmCOObiUeLQ9Wvq5fljbBHTluS2k89tWvyshpk=;
 b=XWBwbt1BiUWvfT8NuWKjKi9P9KmbbjbFR2ava/y5metw98ZvFodVaTKZxZJPr2Y0V3
 n+i1sempKQGvfL4pplsj+9Djki2U8cr3CR21Gbeadz843+eAdmg0rwBFXotvMyhGrG1Y
 Li3oBSluBDnvmEeUUklEiCnUtMpVypi8fbxJxLc/1C2j3dmDMtyVWe5Rd7K0ig45+jZJ
 syfgdKfyzvRXUDZpqpyHGIyynuH7fOja0+gHE8ICgmK6EIKUQBhHdCWP9GqVLjRWJwdC
 /25+rQwaOh+cDosVBFBZnPvLAzewM/riRDG7qeAw+Otzz4sJ+D8h/Z1d0syuk3cbYXCy
 PvTw==
X-Gm-Message-State: AOJu0YxmrKTEWvLhit7dgD+K/AzuA1+eRubt6D8DeEAtq0hZU1hk+kJa
 wzLOvX1J+S3nfpKjXkPEE6CW2RuAappPMbBzT+SJxwcYfRtPul4U1LdB
X-Gm-Gg: Acq92OFjCjBfzwkFC2N/pw0fLKUyU+koWzRvG7O36t1GQjhEu8wCUztf7D/ZNQMtWKJ
 sV+vh4OgzfOkpb9euTvgjhDaBwoBwn31+VUIYc6uTs0awTvVIB1V0khJeo668kUm/LIXRjlWBZv
 9z0M2JiQ4WXERSy5YC1R4zorh4sAcewfYiefXg5q54tQWmfjs7zNlryzC7LBwkusIjXygTY01lE
 +3M3btv5YS5DYvF0tUNCLt/JQlyl2qoT7nuNq+cLkPs0kdZjeWJxjhZWTOjL2eUywfCcntQSAqb
 0c7ZDGDc4SR3sENNjYvOsrMxCvMcOrMaUIjCzmMKu3sHIxzXBKOdkHkBm/D9zn+mVXCXWLIuxxH
 rq2woJDLDlM+Xt/feYht+BeZ2/BtGPrHhDYZzG0Lrh+fpTZANnS9616ft2uj4SeeyL9w9Cna9aI
 moQLPp1MuYeoFkoNg9Q5Ozn9VmSNxl8qyr7RNFanWWunG2R/0oA1ou6OltscNR89C7vlkSc70L5
 QlJk045yw+voIWq088y3FBW39DD/KQCy/pVaUOEUw0=
X-Received: by 2002:a05:6808:1807:b0:47a:8c2:a54e with SMTP id
 5614622812f47-4807fda52c5mr6709461b6e.34.1778445607772; 
 Sun, 10 May 2026 13:40:07 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:07 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:36 -0600
Subject: [PATCH v5 06/32] target/mips: drop Octeon zero-register fast paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-6-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

EXTS, CINS, and POP route their destination writes through
gen_store_gpr(), which already discards writes to $zero. Remove the
remaining translator fast paths for destination $zero so these Octeon
instructions follow the same shape as BADDU/DMUL and the generic MIPS
translator helpers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Remove the remaining destination $zero fast paths and let
    gen_store_gpr() discard writes to $zero.  (suggested by Richard
    Henderson)
---
 target/mips/tcg/octeon_translate.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e69dd56c8e..1893bf359f 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -74,11 +74,6 @@ static bool trans_EXTS(DisasContext *ctx, arg_EXTS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_sextract_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -90,11 +85,6 @@ static bool trans_CINS(DisasContext *ctx, arg_CINS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_deposit_z_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -106,11 +96,6 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
 {
     TCGv_i64 t0;
 
-    if (a->rd == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     if (!a->dw) {

-- 
2.54.0


