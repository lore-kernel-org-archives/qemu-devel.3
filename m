Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4110AC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmk-0005fM-AX; Sun, 16 Feb 2025 18:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmY-0005aL-ES
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:38 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmV-0005Gk-JX
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:38 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2212a930001so11541965ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747434; x=1740352234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KJKLOxYlbWUQUrUX1FKT90J+CBs5fOLKLGjdvCXZZ7k=;
 b=B2CXMveUqyVAXxesQ+87ujtPWVcZV+DwCqEIhX12XlVW2Pn52ec5NGnGkZq68Z0Sut
 wxPUBCHtSQZ9LZmjKjeVgHs1wGjszp7Rq+DuuhtqC36KTG61WPF4t9sVl3C5xQ/viDl4
 J0ffPEtpUFsgwI+YegGMxj9L9bzLtmutzWw6vpxYLu7Jr2TzlhV5MDioYMDXCtcSLR5R
 tpqMP+Zw7YgEGzkSjHJveAwvgdZwRHUsYeF8WRo/LDrtEd5VR+0Um5ax2q5YRanCHVO2
 +pEWB2BNwSSKfB5+AphBYYKjR7NHcAeWbbVCuBoxVIxJK6v1BcK/VnQ92jH0sEUdpb+O
 sWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747434; x=1740352234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJKLOxYlbWUQUrUX1FKT90J+CBs5fOLKLGjdvCXZZ7k=;
 b=LBaGb4WzFordk70UW3+hDEOjtuV7fcG6bC49g5z7CJkObwAdQUgOD+3w8iLlMT4qZI
 VbZG6+bF8BDmVzfPog6k6tSlLr0CAFBc1mQjR22X2dFlbeD07rjIIwI7+g6zmAPX4Uoe
 KffP0TUWqtUdin9HZm4xGdFvNlqtEX0lTzMCJZpBbXwVpKibgKgtnC+jzGUKJbzNsrIm
 aseYagsTDmQmdqtiA0VpwNkm3RRiWOT94X0Q1muBJR1jjzQU1DyBaKTPphqTuEsqYZYh
 qOhVoKtiF+KES/he12cv1sW+txR5q6UY/EIg/FTp69o/et9rt6V8pKoafGrAkLcmTqwH
 T6tg==
X-Gm-Message-State: AOJu0YxVm7VgVcHtpl74PkiJP5cbtFhDfnLSHuhftkJNWQuJZMgdgKzN
 U5VKPIE1TbFKFXRv6R8FNkjPaHzm+/zdN8+nGqYZzVA7cC4RLAorDefCQBRnG46eJC2g/oXycvP
 z
X-Gm-Gg: ASbGncthxm3qqWXF22WRBMW10mhZRet44f9/F+xeisTJXHCTa4Yiu9rNAVNqQVtQL/Y
 SrsK88gYry48lqnev96BCUCQKoi/3KOcw4MoyddvRtmfjil/zc8GYDX7GhPxiB3e1N2oCN8Bwv6
 cLq2VoOzowW51wVo1cxlSB5Ys0UWj3nghczR1NLzMrfsLZR/Z7JNuFkiQzSlDEX4S+NAz9w4Kau
 zsISLgKQlDKMz4mIauseGQbWP9JZWh66nb/cQMGpONFfgfUwX0OHGpwsUmi1p8QMuEk6PsoV8Uz
 5uRiR5lNckccUfiR5UqDB0xHLzTjc/x8Ex52+JTfXGsntO8=
X-Google-Smtp-Source: AGHT+IG/R1c5PCVTCl2zQBWOFNoP3jM3eaNqQZRSWLKcTUKuBNETpWJjZ0RQCctxy3yTyaNZ/BxKMw==
X-Received: by 2002:a17:903:2288:b0:220:caf9:d027 with SMTP id
 d9443c01a7336-2210404dfccmr107033225ad.23.1739747434137; 
 Sun, 16 Feb 2025 15:10:34 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 027/162] tcg/arm: Fix constraints for sub
Date: Sun, 16 Feb 2025 15:07:56 -0800
Message-ID: <20250216231012.2808572-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

In 7536b82d288 we lost the rI constraint that allowed the use of
RSB to perform reg = imm - reg.  At the same time, drop support
for reg = reg - imm, which is now transformed generically to
addition, and need not be handled by the backend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target-con-set.h |  1 +
 tcg/arm/tcg-target.c.inc     | 11 ++++-------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tcg/arm/tcg-target-con-set.h b/tcg/arm/tcg-target-con-set.h
index 229ae258ac..f46a8444fb 100644
--- a/tcg/arm/tcg-target-con-set.h
+++ b/tcg/arm/tcg-target-con-set.h
@@ -30,6 +30,7 @@ C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rIK)
 C_O1_I2(r, r, rIN)
 C_O1_I2(r, r, ri)
+C_O1_I2(r, rI, r)
 C_O1_I2(r, rZ, rZ)
 C_O1_I2(w, 0, w)
 C_O1_I2(w, w, w)
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 156f2df7d5..59c131c4a8 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1990,12 +1990,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
     case INDEX_op_sub_i32:
         if (const_args[1]) {
-            if (const_args[2]) {
-                tcg_out_movi32(s, COND_AL, args[0], args[1] - args[2]);
-            } else {
-                tcg_out_dat_rI(s, COND_AL, ARITH_RSB,
-                               args[0], args[2], args[1], 1);
-            }
+            tcg_out_dat_imm(s, COND_AL, ARITH_RSB,
+                            args[0], args[2], encode_imm_nofail(args[1]));
         } else {
             tcg_out_dat_rIN(s, COND_AL, ARITH_SUB, ARITH_ADD,
                             args[0], args[1], args[2], const_args[2]);
@@ -2240,10 +2236,11 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i32:
         return C_O0_I2(r, r);
 
-    case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
     case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
+    case INDEX_op_sub_i32:
+        return C_O1_I2(r, rI, r);
 
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
-- 
2.43.0


