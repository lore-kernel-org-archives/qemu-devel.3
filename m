Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7ECCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cEs-0002cQ-Ah; Wed, 08 Oct 2025 18:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cDT-0001Op-0e
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:01:01 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCZ-0007R4-GA
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:58 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7833765433cso408705b3a.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960799; x=1760565599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JF8VeHAMXnS+KlXHqFd9bhXPg9cRL1eKSmFQYNi3XjE=;
 b=JpTMzFB0A8dvSnVgxkgKX+8zRw+lqSnUD56GqX87ZzTfjYAG30FSF9aih5c/bAIPVu
 DnrDt68UHhxGpOTcuOzbjIEEBdwoFMS+w++yGfvepzkaSG87zlszV0nMdQ28k0OPIHcJ
 qyvJ7Witw4vfr05xjbvpj8EslknoKtE8XBrDUfpVDcBv/6HrmIfsTzUl7C4Y5DLzeH0f
 wSkFMQNwdjjgJHxykLJoXtT/4Ik61AN1/Uvhhot1trJ8zQSYKKQZESLW57R0O9vLhgNg
 9OrBTDXix0sB5WswYdJ0tqZXzo+rI+8zS9INjwTEFd4xGmzVsVIZGD963bqO1MklzjuV
 ohGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960799; x=1760565599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JF8VeHAMXnS+KlXHqFd9bhXPg9cRL1eKSmFQYNi3XjE=;
 b=oMK+qdmgKsYd0xiviPKRCJDIltkGFEIVix+MtGA7mNSidU58HWEL2Y3Z0nh5SL6Jxa
 Xt7vgm8U9ikv6iQHJJL6+CraUvz2ZKFT/rQ0mpoE/KfIDHyvdPJo6SeAKsM0fDQsCDOm
 uArBC2PRZ8vqkhUQrC+PaI8+f8DXIVPWWWAFNwqY6AjxHXkeUfG6JKxivKONpDUl0nPm
 glDJ3RPfsAYPgrcgydbVHKUA+QC5chToFghKuSoAloT5KdrWtp3QwZ2+i6YbB/u1FJfI
 fyrjx497s4lyyiCyX5RKZsHPqdhOXbm6dh7j9qRun2KhvH4MbqpJ2KtpHuqNEBKyudbO
 iOZQ==
X-Gm-Message-State: AOJu0YxlPgpgLO6aYHsMHAU62sW5R//v8hJeoEGHoWk1OtNLIxqL2B8Z
 G2pphyCQamN9PSW5IeKC+WYw9FFRl/Z8WhTtBzbV/ecIn3MS8XC2OFRpGFKqb5uFTb8dvbdLVFI
 LoHGWhQY=
X-Gm-Gg: ASbGnctl+LbYwVNKjETTwhcdbYfd6OUlUM7Gw+/uxTsy32WjX660pKuBRTe6ayxKZ+A
 apo1L/g5bSneYwZp+F86oQsBUxSs0qfzSyfsvr7tmAY41kn7OcrRpZqpy1IHcSWrblZmHWEdJOx
 oIRbcIZsgCVxuHQHwR7O0m+1dFBboITn9d/1/0d7gKtDf7JMxacSoncOsInCXXUdHgTGSJGlw8+
 Nta29KUDhbMhUmaPmG+u1TiU8Psd/5gJaSsrfzGZkLknkcFlVktgDirPXHeCIyfJXn5PD/gwdEf
 nDQ7FeSp8w7CZ+SyJ6/7yiSVzAAwzialKr9StVQW0F4FqZ7eDpy50fEUyv74qJHWC+6Yw6zWiNq
 etasYUrD79GpDw/5ayMDQCPEWwE2ymBJjk8loQNe2B5v0FiD3ZP1brUZh
X-Google-Smtp-Source: AGHT+IGIyg+oA9mlKAcTLf1i8OHTwGFKyoVgiS8XG1UJC57JAAkearSkYVvm2q72NSJ12QW1evtadQ==
X-Received: by 2002:a05:6a20:7286:b0:2b7:949d:63da with SMTP id
 adf61e73a8af0-32da813958emr6611633637.18.1759960799234; 
 Wed, 08 Oct 2025 14:59:59 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 67/73] target/arm: Enable GCSPR_EL0 for read in user-mode
Date: Wed,  8 Oct 2025 14:56:07 -0700
Message-ID: <20251008215613.300150-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


