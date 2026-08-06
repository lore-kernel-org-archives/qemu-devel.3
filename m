Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE11C5AC7C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws1wI-0004lG-IY; Thu, 06 Aug 2026 13:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1wH-0004kV-Cg
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:31:29 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1wF-0001eQ-Ct
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:31:29 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so2702316a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786037486; x=1786642286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fLSidquFtzkmrlA4AxhDV8k9o/vrgWYTWzw/anpyq3A=;
 b=GEO4JW19f5orfVhiTQffJQdVj6nYQ3ewk4V2azSHfVhKZb6A2/bHH6f0MKP1sv5Kgx
 0PEQcKfxXrYtRkFTAHQ08LYND/PKKjHK2r5O73KjyKFZUBJB6aw5pKl8Z+xIcF/34gBx
 RhW/nK3qJifNk3biiBg0ZVuciS3mHQq7nLL4vZZcpaRwRHIzgfWZWYI+IZdVz7F88tqZ
 C4T7nvrTKF1J6bHu9UVT1yIAMQZH+pJY8rsTdEg1RUdAKCiKBlSTgm1Y+zDBqs0ZYrll
 a3d8XlBqfckf7eUV39YJUpAhgq9djL1JHuTtZT2DXn7ayeoa7FfhWnSRKP6tsC+IVIUX
 oQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037486; x=1786642286;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fLSidquFtzkmrlA4AxhDV8k9o/vrgWYTWzw/anpyq3A=;
 b=HuSDshJz+WkH+0He4HoMlWdpk+Up/o4nMS9ogjrjcHPE21elJcWtwf9Cx8KsItOrag
 2EoxDnUH+w5M5uEgeVTAuhhf+Rh7CzaMp4f7wXPdwE+cOrTxsThNtA+p8ZvbCFWFdEOh
 EUGWtQOo1+Vv2BCcpkY+qilsUOMMsGWf8KAaGpqgocBbr/qIAqANMLISwF7NFAFPrn3O
 YJ9XG7mloYGg4xQH7wFQ76ggAIybmDxq1poszxjlSdosQN9CUyEkk1cIfQL8go5TYsu9
 OKlXI9u6+kH2ILB+xpaOdfrwIDBvWGVD/boZwuvQpE3xjZkKVCaZSTDrs8N7DwjHdl2f
 tdlQ==
X-Gm-Message-State: AOJu0YyBqZjBB5ADiiq84d5CqpYsEycwSsxmyNif3WJwXJR1TuLL0HcA
 mxo4TOiuF0so6iccmjPseTRS7Oq51qndq8SVdh9azKTWAORNW6/BzB9oStX9YhMlljXjmCNVx+C
 vN3zJ
X-Gm-Gg: AR+sD13C3Qn6O2Mh6q1w2KvnjTQEUZHyvjKa1+7C3UKzw3Z/P8iaxIT6XYkd7cKJjdd
 c1wleKlVo26uAZBRdzhETObMUmaLx/bPOoe/aFdwmdKAUAHVTTPOuf03TLpBTi6AJo6E39PgkqD
 qBrHfuNdQLVWIZAKSzOFY1pbSZOyb42HjniBbkRpd4KKDG8eV6kdClAwoqqJc9WdZrjqdX79CmF
 hsLcEzA6LN87VfNTqh5C670vheRrrET0kKyGFm/vI6Ne4g8LnJEMfOwYm9Uk8/VnBy96BbuQ266
 I1YYFeJrAbqXqj14Lh+JH7AKYU4YkoxB6GA4vq33aywhPWk9T7gkhRo7c70QM+GrJMFkRYikPSl
 YiJhI0F6Qslkn/rO9oxlCf19/iMn5DtJlQQhOhUShQibPfPDRvk+aSjkHKJqL1SJmT3N9XmFoW9
 COU2IT4S6XpUrjONmP5f67E6CBykvE0z4lOPCchSFjgGauwQBdt1WClnouM+CyZI03KxYUWcM8a
 0TjckmNu0cX+6mZcRKV8s40SslOiwJv
X-Received: by 2002:a17:90b:2745:b0:381:3b5d:30f4 with SMTP id
 98e67ed59e1d1-3903c535d84mr18421785a91.1.1786037485868; 
 Thu, 06 Aug 2026 10:31:25 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085e4a2a5sm1983711a91.14.2026.08.06.10.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:31:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 1/6] target/arm: Rename isar_feature_aa64_idst
Date: Thu,  6 Aug 2026 10:31:18 -0700
Message-ID: <20260806173123.333423-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806173123.333423-1-richard.henderson@linaro.org>
References: <20260806173123.333423-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
index 75f0fc4169..d6f8b4d065 100644
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
index 73cae9b9ad..9fc4f86825 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1139,7 +1139,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
         break;
     case CP_ACCESS_UNDEFINED:
         /* CP_ACCESS_UNDEFINED is never direct to a specified EL */
-        if (cpu_isar_feature(aa64_ids, cpu) && isread &&
+        if (cpu_isar_feature(aa64_idst, cpu) && isread &&
             arm_cpreg_in_idspace(ri)) {
             /*
              * FEAT_IDST says this should be reported as EC_SYSTEMREGISTERTRAP,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0931c92307..8c7a0294ee 100644
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
2.43.0


