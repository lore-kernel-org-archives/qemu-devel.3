Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE58CCD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgl-0001cQ-7G; Fri, 29 May 2026 07:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgh-0001Zs-SU
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:40 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgg-0008Cg-4f
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:39 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso8045972f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055257; x=1780660057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i9pCJynB0tUPfa2OetJeRpXDd6u9BIzpuCekF6i5wNU=;
 b=CKGiI7AtK/6EuWdm7LnqeSqqcNjXsJQEpKHkvm01r0R9+d9yXxt8VkZMbLMbhBNFs1
 MVv71fVoHGpq2znTywG5Da++FcBYccwAAdvx1w0yF7pWfhBkzPbovH6MubmAILyvxgB+
 SINJYEuS9fe37sFZR10XbYom1SPP2n13kz0ZE0zKwKUsnCiPNTLxh2noRa0tag0G0a8G
 7/YYIGvs5XO7urTfSTjwnumkMD7qp4s8Fznr2/gGzJCKrAvysE+CrpJG2RL1Hq5SgM0j
 9oQCa2r+8LAjVEPyfMVyJ/GfMwXycyxPVVs6CYmJRWXyMa7c05jgaiWT7aRqZUNS+a5l
 CWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055257; x=1780660057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i9pCJynB0tUPfa2OetJeRpXDd6u9BIzpuCekF6i5wNU=;
 b=BiGgOxJBLLNHUb3pgAE/SQNY1ZQlkQrO1xVBWQB2dJAv6PGavpyywLwdd3a56KYW0i
 xT8yV16ADnN04jTx15bDyvUV5YVTNpNbim06X0v+g667IZ9VGkZX6GFLYTSTw6KzW/9j
 vbWabgjtIY8INmB28h3n74AkZXUt5aYwyfRlXf9FjQCiZToSFE46otbIvoCGNpNZPxm6
 eZ/VHsjnzbHsnF8sJw49IN8zI70ogSATGx8nPHGBWfRGXypHl9nKkorUKXRJ6SdViuzE
 Ooyn6WKp7r4wvH8+PeixItQeqATPqobHqfvwDgP8bMglgJhvnZLzRkIt3dmUsQMuZBP1
 rsZA==
X-Gm-Message-State: AOJu0Yzwm6Vvfao3XqB3pKzMclNiOnB0OmZUsJoJIlFwoEADi6CE5/BX
 sjr6x6YqAGSlBCvJyFzmLg6QGdNnJquzb2VQCyNg9OZcAJf8UpPsPVVNKrYpYYW07Xo6ACil5Fs
 vJLyw
X-Gm-Gg: Acq92OGesM25fQiPnGKGDy7ogV15OuptOEuk+87P3mhPpDvy/CQz1J/Qu12OrgPpNEs
 60L4bJv6LcJN64enEDNCWH7s/kmwlzQx1QQc/pjqyqTMLNu+9uM6MxqPhQA3FimxOr7udiFjP0E
 puM/pQTXP/n2/Uk7ASlCK9zMd8FKhhBqDyGKNRzkD0SPDpJwtUDUdHnt7HB3FXB2Tsqq4GanNrz
 ZG+NoTcOPooIYNMvhI/f3uzQTeiWIb/ws/jgWYev96mue5CRMaAJ6stWDBiucRK4SP1N7yAOp9x
 /De+p0656kLqTOMSjJ+w4bJd99i2MjWUEyVprf2yTNQTdV2JRMNrACzl+3LMSyWHJcltrcR7qc5
 SusgMLwrttwyPe7SWeMCNX0P4hPFciKZuTgzcgzqehelpARd8yzNBKXTh+RvEWjWqtbjAP0pomx
 FSW7MeN44M3b8VAM4PV48Pt6zPowUmpVuhN07XivPwGt2xOUzY81zruWdUCpXkJIVxVL1zHH35/
 vuIDBIaX1GefeC3dS1naAQG50E8JhOiOJBxvyCx8A==
X-Received: by 2002:adf:e010:0:20b0:43c:ef4f:79e4 with SMTP id
 ffacd0b85a97d-45ef145ff50mr3197331f8f.37.1780055256627; 
 Fri, 29 May 2026 04:47:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/21] target/arm: Add feature predicate for FEAT_CMPBR
Date: Fri, 29 May 2026 12:47:12 +0100
Message-ID: <20260529114723.42040-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260518174750.660258-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index f9c979d20b..4e8d844fea 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1061,6 +1061,11 @@ static inline bool isar_feature_aa64_cssc(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, CSSC) != 0;
 }
 
+static inline bool isar_feature_aa64_cmpbr(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, CSSC) >= 2;
+}
+
 static inline bool isar_feature_aa64_lut(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, LUT);
-- 
2.43.0


