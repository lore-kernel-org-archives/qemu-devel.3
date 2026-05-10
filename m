Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1C3CD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtg9-00067B-8m; Sat, 09 May 2026 22:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtg7-00066b-Uk
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:13:59 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtg6-0002wX-BF
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:13:59 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7de46b8e432so3076322a34.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379237; x=1778984037; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=npONxRmCOObiUeLQ9Wvq5fljbBHTluS2k89tWvyshpk=;
 b=e4b8e0HXOhI78UFR417bduJph2tU7Iz14Lrcumg65ilNYwZnx2lfyu5gjYa7EciyMx
 yZ08Mq6GhtnSaRiz0nQzp8v11K+zImudvXW4TXtIrT99/jWOpc5+rF2tqSYhbdxOd/fF
 8Q2t1kMba6LRF2zrsGODp6GxjJ2PMMkQW1RR4rHjC/dzg2ES2pgiPMpwPBwpGUjRAple
 ULnPgb44e/3R2anMpJ85poWejDIwI1a1ZPEhsPGTKQOi9j2C2LpQSnVabOc5Q7kmjGLj
 DRHfd24GTQu9wlBVAa2ZF2z/QGW0smAOey7vEprGnLM9l70l4VQB3u45d1X+7iB+2MPN
 J0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379237; x=1778984037;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=npONxRmCOObiUeLQ9Wvq5fljbBHTluS2k89tWvyshpk=;
 b=nJOM5TTbwfbSC1L+LwXuvCnjXvfCPHIA0RLUe4J7uh5BNlTfCAL+dGoZtPl3z6BNJk
 +cmmOaOaMCdFksYr4mTYlKvhAxez5xSnV0KlZfDib2TYezjPKINeBlqaEYLyEDQ0oxo5
 DEU0TY8j+4OyAV7c1NzL3jVFu0/N3BA8d1RA4z1zhlRkm5MT0RIMAA9qEhCYMmz0JSBS
 GQOCkMcOcPV/z9H5yB2PRXPjSxX66AeKtYRmj1EsYQnT+CWxQFhTwlbr2Cv0csn8kEAh
 R5Og9pBaY4v/Nh96hEcX96z49+WgEB8ZkZ8Jn5jBCbSp5gaTtB/Ch6p1E8RpytG5RTIb
 FSBg==
X-Gm-Message-State: AOJu0YxrUyrqeYNO6gzSawZHQhHG7RZYruNqJP8ZIhQUfTS7PYZTxpiP
 PeV/sdA3tN4raWuTo8Q5WsU1FK/XeZ5lYuHa1ibOftibRFN5LVJ981teDiF2WfHB
X-Gm-Gg: Acq92OEhov96jkc8B8z/vqaHd0Phh0hs5yHYGdbt1I99S6As5MXavbp8FOFcA5ljaEE
 ZQeetzdcMGN0t3Gs1heUimA5A+PlU7Av8aUzAKPidAM5LOsZD9T1wLO4vKUB135rbCAwZQjCyww
 PACZ1RomNuX44TuKtCgQKZtP4m6jUsMLIrdJEKQiPdP1Ha5BMgKS7kDfKQNtWTtbul9dXu8QLjq
 3mRCCZohXx7K432kDidFRoHP7TOG2N8U2037UpK3QJvexy9EVD8POX5CI+uA96EEY+RjhA1+A5H
 av79SJ+9ABvoyFSpo4ggp09Uf8wA0G9x9fyDHEG/NAU+l0zG1XXIzbjX/JGflnI7PHxPvUu6F8J
 e7Kz+R+12XAVbr9sA44A1Mut7ByjqtwiXi7yWxcuXtbxF+PR7/f6bILaOk4OzcgZYtmCveT1bwy
 kI1M6/4EkszMCIRMBtZPzU3jeCL1o3Crvx6IdpRT9LJXTOzM2GPaGfJ/EOI2vVi2l4ou2xUTxh4
 eClS/IlVGGRyTiUKnyH795YcidPqXnt1dH2lBx14Mukqwsx5jnGB1vJunVU8UIV0LiX
X-Received: by 2002:a05:6820:1c91:b0:67e:ae5:732e with SMTP id
 006d021491bc7-69998cfe0e9mr9663400eaf.36.1778379237080; 
 Sat, 09 May 2026 19:13:57 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:13:56 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:29 -0600
Subject: [PATCH v4 06/32] target/mips: drop Octeon zero-register fast paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-6-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x332.google.com
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


