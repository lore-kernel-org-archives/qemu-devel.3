Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65655CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jOs-0002me-Fr; Fri, 03 Oct 2025 13:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jLY-0007YB-GQ
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:35 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jK9-0007sQ-El
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:32 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-781206cce18so2249606b3a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511522; x=1760116322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JF8VeHAMXnS+KlXHqFd9bhXPg9cRL1eKSmFQYNi3XjE=;
 b=HqKRAUo/qb8YS8dXwX0r23ye7NfWcxu0Yiwi+HWKBHNemgcgNoo+9Pdq5ojIcQiutn
 gF0ANBiWL7KgpoT2agaqf1xC3I+PdEqflkdfZlZOy9bq7jGXPoOWohLFsVk2QxBrj56Z
 kwV/foNGHFBvoZD9uY6BSMQAT1V6imqSxtuDPYFKJt+tx1ayVWqTcrLXp9BOTvPDCbDR
 nynWBNiwfDEC91Lx8R0lZmfXUthD1wenb43bZ3R2jgZhDQEBxTFAVpJV2hioD9cxL2fQ
 tPq/y+snjhcttwrpxvODcSVitMQCM9NNq7t1Db4dBx4Fr3n1UW8clnJd2u7p70wFxzFT
 vuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511522; x=1760116322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JF8VeHAMXnS+KlXHqFd9bhXPg9cRL1eKSmFQYNi3XjE=;
 b=PLSY4CRSJ58o1rnLokryt4nzpFm42hXDliEZjzotv+fGPtaG36XnpEEtb5NFAMnXvI
 eZ7y1Z4aR2z2gJge5fOLTOZ2CEAN+3qN3hSdICEG8TAwddY876ySkrFcHE13rATHK+HS
 6V/xcNLv0kNJoTmwda3qjkp0R7+PHIqklqbQwsz1id3IlNH1a83knL2a/skNkpciX7bZ
 A/QdXhVLKYRJKomTqHOLAhMC1Upl5++C+BxTFL39jRvTDEpVuuCkFZqzAeQtbpHNfiyE
 Nf+TOzyamFojIqx9KJiTdAq3MMtDTzTrPKEE+e2/86+RFUkR3mOWhwV+MjQ13qs6djao
 xceg==
X-Gm-Message-State: AOJu0YxVW5fZePRCjJNP2ucCUoLG9zfXpgiC4k4m27cUu3MTfMd6ropE
 SVwJHApPrQkIg/PFVoptdkQ8I+RSXqidsD6M1lOQiu5Ci33MPQv/rsS8aDTdYsPPelsMEHQDZ4n
 kXVHlZrQ=
X-Gm-Gg: ASbGncs+CjtTvwFDmdJfyzNz1MB0VEfIFE5jHK+Wp9iZ85kaFDdTqbljrkYsE+5z9sf
 zOC/fGRzxgF60C957TiffbTHkQBLoyiUeXtp1hI7ERaqHoh1fE57lv1SAZWLmBTnVaodRMxrqOr
 8X2bSpZtoq0LIwaLy6zcNwzBbk1UPK2/pwTiIRx6gsiOVHm9foJdwe5HXxMGeTHWf7XAMmt3nZa
 WulkkVvJ5hSJy6qERKT6zlk4KyUN8+ySLIV30p3S3fThZozruHSPioYxfpz6dVi7Sox00vsD6sZ
 b/MFp7FcP4Xlz/akXhimz0g86zywxT42PM2DDrft5IuNIMO3YHXwPTdqyievrs0jSJNY5VMKKFB
 JQgdae4pBtinZmkNF3Nnev92mPBJxY/96/nW9h3v4mE0RvdFz6cIMj7el
X-Google-Smtp-Source: AGHT+IGKp6Udj4mRZD07nDWrecDrx/uFIoBJCo57u/1eSoZLBx/UjQYXES+FI2lasDrJ4FkjjiLGog==
X-Received: by 2002:a05:6a00:6e9b:b0:781:1af:d3d9 with SMTP id
 d2e1a72fcca58-78b02204bcdmr7109447b3a.4.1759511522057; 
 Fri, 03 Oct 2025 10:12:02 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:12:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 67/73] target/arm: Enable GCSPR_EL0 for read in user-mode
Date: Fri,  3 Oct 2025 10:07:54 -0700
Message-ID: <20251003170800.997167-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8ecf8a5e4d..98da468313 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -311,6 +311,10 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->cp15.mdscr_el1 |= 1 << 12;
         /* Enable FEAT_MOPS */
         env->cp15.sctlr_el[1] |= SCTLR_MSCEN;
+        /* For Linux, GCSPR_EL0 is always readable. */
+        if (cpu_isar_feature(aa64_gcs, cpu)) {
+            env->cp15.gcscr_el[0] = GCSCRE0_NTR;
+        }
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.43.0


