Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6023BC5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wppyM-0004nM-9P; Fri, 31 Jul 2026 12:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wppyK-0004kd-LH
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:20:32 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wppyJ-0000Rs-0C
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:20:32 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47de008b020so839921f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 09:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785514829; x=1786119629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BHKzpHIUye2WTFtFvbffFyBvvLiRS1+zoQg46eAos8Q=;
 b=m3w9Z9XyRhpR+k0npkOsoX1pAjdGVndhYlOeCXidyhWsd8IpiYCvLUYFh5+9AwSvJ2
 bdWOkxeGr8ckdM5d+EiAh1s3K5rY+8gQE/vtor834BCCoJyBudjaOmaf+Fw7ih3s3bOr
 w7s661T6KZnpVADVNwOLdxGBf4R+G9bFtvhfGJlnR8LTqligtZvcXencnCKVBaEPYd6Z
 S8Gz2WyC7V0VLkgsgFA9mkTLYEuu4uKnwW+mv1IdA5sA2AOk+gZF07TOP/w4F7HyQNc9
 B6HPie+oroXGU9UsthM70BcZNV5eAzaKCeYaDj3izVDL8wd9SYPZN9IL4Dp9YOfH4Ic7
 +bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785514829; x=1786119629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BHKzpHIUye2WTFtFvbffFyBvvLiRS1+zoQg46eAos8Q=;
 b=BTkY/MIHuZh/ZMwMG3r8V7TbnjI9UCxrgwDocMgNWlEk3jsDewscoQqMqCTMvWIVPA
 2hPY73sb+ptT04BTq/GkQR55G85DSvnG1Y7SeZsJKuO5mMP94wypFEeaqbQGm/EloTN/
 CQDzL06XAgKr3tiRabscg/UpMZpnyhDvV5doHwAykMoaINr84C0Ens7bEmM2IedlbHce
 yNcbwLLwuGGqBuO0qnV7980fZ4RjSwfbXdOVSSlXgF3TGyYnoA66vmmBsn4GtXJ4qHFh
 gtUM0Eqn5UZlRtFsyBXWjhPUERPu4bKZVcW3FK1lGcCzXZvxdioP7J2THoT7KOHX5xLK
 YxXg==
X-Gm-Message-State: AOJu0YwqGVTTlixxgpo9YrZoBOmeraHeJyrIj0d79qkvcid/715pSR4C
 ke5h7yrnBRi8qM5wd2gFCcNsiwNDTLJ0x6J6GXrnMF2w2YtUDdl23ezDmierSwTvVMndmfnHm3a
 ptf/x
X-Gm-Gg: AR+sD12+utTgNFM3jIa5EZFsjxFzKExnvGXxHT6zkY1qM2c5sdEoxYg9PxkndnEfUzj
 eVy4kMgCgykNfZf/eaIysU4DNSVHeaURL3N7Xt6lnjXRz2jaNW6tnAXBMr5UMuKOvD/3Uj7hKBB
 2el9sHRHEq1jV06tE89rFXO4rG4GUOOxphwWmckOffFsoYElHCZ7jwGOjKc4HLp81lzdP/wXOkO
 z0UOOOvUpauGKT3JJRoHDR4mjvraCTaRVk0sTNwQecJgLJSNpir5RT3DQDzMIN3VV9wimEk5EOo
 0X5iCer571TK7+WBx+OBp1JojDDcYUGHWq54SKoPYht5AAksHO75TMTlrFQ+LPeDeqbmmhm4sot
 ahms3q3Y2uM40HfDxVXTNEKkRXCZOThu0LXtPLyzEkdDRkQeVFfhAWGh5IDMOnRZI+4gOSdphnN
 +BgDu/oIsYmIKVHjPzb6xZw4Xv8ezvkp3wPuxVUWpGn2Jp2igTZyRldCiF75S2z3n9vmE/EDdlK
 yVeowO58upYZhqNQeMUkLq0+IyVT9QN8FzxMx+bpwgW7P98reXz9u/FdjyuIxuF4o6r7g==
X-Received: by 2002:a05:6000:4698:b0:47f:96e3:5322 with SMTP id
 ffacd0b85a97d-47fd7264c9amr486451f8f.7.1785514828873; 
 Fri, 31 Jul 2026 09:20:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm6328593f8f.34.2026.07.31.09.20.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:20:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] target/arm: Fix b16b16 feature test for SME2 BFCLAMP, BFMAX,
 BFMIN
Date: Fri, 31 Jul 2026 17:20:21 +0100
Message-ID: <20260731162024.3097467-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731162024.3097467-1-peter.maydell@linaro.org>
References: <20260731162024.3097467-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

These are controlled by FEAT_SVE_B16B16 not FEAT_SME_B16B16.

Cc: qemu-stable@nongnu.org
Fixes: bc65d2bd1cb ("target/arm: Implement SME2 Multiple and Single SVE Destructive")
Fixes: 930760eb753 ("target/arm: Implement SME2 Multiple Vectors SVE Destructive")
Fixes: 8b61eff8e72 ("target/arm: Implement SME2 FCLAMP, SCLAMP, UCLAMP")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index dcc4690fba..0794794e3d 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -756,7 +756,7 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
         return false;
     }
     /* These insns use MO_8 to encode BFloat16. */
-    if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
+    if (esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
         return false;
     }
     if (!sme_sm_enabled_check(s)) {
@@ -793,7 +793,7 @@ static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
     if (fn == NULL) {
         return false;
     }
-    if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
+    if (esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
         return false;
     }
     if (!sme_sm_enabled_check(s)) {
@@ -1850,7 +1850,7 @@ static bool trans_FCLAMP(DisasContext *s, arg_zzz_en *a)
         return false;
     }
     /* This insn uses MO_8 to encode BFloat16. */
-    if (a->esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
+    if (a->esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
         return false;
     }
     if (!sme_sm_enabled_check(s)) {
-- 
2.43.0


