Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D40C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8l0-0002Ud-81; Fri, 25 Sep 2026 12:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8kw-0002S9-Ea
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:26:38 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8ku-0001Cp-2h
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:26:38 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccafb751so591740a91.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790353595; x=1790958395; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=buqPiP1niAMqtRUO2sXRVOKBNZMuXhMGAmeBTpLNl7I=;
 b=qnLFqLukd11aZGQ8esnnEFoUfSJ6P71WhMTvtYA1Lcp0YS0XdwzqYIQvoFazd1ydzf
 S4DTUSc4G/orYjenvZVLQIU/gKOtnB8dqf5ZxqYu18peDQDalh/Io92adz0GKNlV8I4V
 LTSJrBZc53cYpiy0IKfh4rAeArXuV3g7F1KOJW8EdzPRRWZZAzdn27X+XoNAx7srQjAf
 T5NpLS+gGVxr2oTME7jrnDU3vwlD75OTWiEa9fgLU4yQDHs//qzxBcVN3L5uTXCEO4Un
 vexMfUAL978G+mMNsXkAzkskx/+5Jf38Vj7VuJaG59mJ6ooDJMOFE2mMBvt00pXrELfM
 szfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790353595; x=1790958395;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=buqPiP1niAMqtRUO2sXRVOKBNZMuXhMGAmeBTpLNl7I=;
 b=QKC/hNF9G8XltGxvhgRRMLq9Wj9tUth6HGS1lulZbwbajG5DwA2Fd9cgPk9xSr9Nkd
 M0ehuHbBq+K4b5X4jNbdifJz3qx4bhEkH/2qD0ZodLitnugguSgI9slYDCTpP1pv6h2c
 rnf4Wd1vYo7Ig4z0lfFcVTYyv25YYm6nK7biD7fs1ph/2vF37KYk7mTKEiUVOnUJmJ7X
 Do0/vSvHEVxu8djlyjXEsp+tRHjF83wGYKYLBuaDLu71zusS0+92FE6mcOlLRixQFvM6
 HRMNWTWpLSIXRu0DAFdGBEtUrHK2U0kRU2FGnDIsfzun9TScyXMbEnkqY/yb+xiIG8NE
 gFGw==
X-Gm-Message-State: AFuF++nj3yomP0ZWJh24fGub80fNrAxp54Cliaw1f+xTMy7r/urwtQyj
 TmKHU/a2CzJ//is7Y4lr5/fa20sBoI1Osae5VKA3hZc70unGAeQ3QuMNGcvdya3YUVOyt+k+LSR
 azhzv
X-Gm-Gg: AYBFou3DsgmG5Tjl4WnmqoZXfDhU+V1ROqEwiOQ2li1ai9ZgvrTn5+dQImmhaMINtOu
 eh82iLBtOfvsK5ju/24Ykg42xeBP3jtsTUFhViF6/RBPLaFvtGdd3JAtkJoak3tAes152YD5fNY
 OGNSzFIwbYL+HV8azt8nbk0BFyN18kEDX1WFfn1RGd3SIQzXyJjJqQHqXSZQkAVkmrLDwmA10ff
 RMaHjRW5sr+QECv6dWK89E1wlFvOTRckEd1UFWkIwHWoCOlVbp4xj5witvSbg11ktbv+lWsbjop
 eYrE5QoghYf0KAgteJJIvBolWgdbt79+5wUUXCCQKABqvQx4FVG4w98n3BQa6Ttwg/biIX7+TcW
 4ONaXnqHPCS9aihGoce85mFx5tMTD3LgY/WSlWGL1kR/3xgHvr4VW+ZaKaIPLgDw23vhfdrgdZ2
 rEnuyNSipr2bbXOsxxPEB3NTpcJERNycWjE8tHLaS3QyU6oWzTztMBWGpxVpzuSliQzfJiMX7Gq
 Ofbi9MGgRz1p/0zqE4mugLqFgRsFkqKwxMwHG4o
X-Received: by 2002:a17:90b:2685:b0:3a0:bda2:d54b with SMTP id
 98e67ed59e1d1-3a0bda2d604mr1846478a91.19.1790353594568; 
 Fri, 25 Sep 2026 09:26:34 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976cacbesm11464809a91.13.2026.09.25.09.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:26:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 1/5] target/arm: Rename isar_feature_aa64_idst
Date: Fri, 25 Sep 2026 09:26:28 -0700
Message-ID: <20260925162632.404001-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925162632.404001-1-richard.henderson@linaro.org>
References: <20260925162632.404001-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rename from isar_feature_aa64_ids to match the feature name: FEAT_IDST.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      | 2 +-
 target/arm/tcg/op_helper.c     | 2 +-
 target/arm/tcg/translate-a64.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index eecbc3b889e..b488cc48b73 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1397,7 +1397,7 @@ static inline bool isar_feature_aa64_fwb(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, FWB) != 0;
 }
 
-static inline bool isar_feature_aa64_ids(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_idst(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, IDS) != 0;
 }
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 643b1482523..bed534c605d 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1134,7 +1134,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
         break;
     case CP_ACCESS_UNDEFINED:
         /* CP_ACCESS_UNDEFINED is never direct to a specified EL */
-        if (cpu_isar_feature(aa64_ids, cpu) && isread &&
+        if (cpu_isar_feature(aa64_idst, cpu) && isread &&
             arm_cpreg_in_idspace(ri)) {
             /*
              * FEAT_IDST says this should be reported as EC_SYSTEMREGISTERTRAP,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c60f4c4103d..cc0820f9df5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2675,7 +2675,7 @@ static void gen_sysreg_undef(DisasContext *s, bool isread,
      */
     uint32_t syndrome;
 
-    if (isread && dc_isar_feature(aa64_ids, s) &&
+    if (isread && dc_isar_feature(aa64_idst, s) &&
         arm_cpreg_encoding_in_idspace(op0, op1, op2, crn, crm)) {
         syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
     } else {
-- 
2.53.0


