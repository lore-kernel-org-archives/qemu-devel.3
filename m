Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199A1C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoVL-0003rH-Iq; Wed, 07 May 2025 19:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTc-0000bX-24
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:47:02 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTa-00039M-BL
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:46:59 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so4082345ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661617; x=1747266417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iy4NKdbqFEoI1LwuiWAT6ispFyw4zHMXwGZpZSKm4tQ=;
 b=EhKiiLMJRoOkdOIY3mQLSaE1DAlwg0PxeFgd9OECAg4q7HYm2C621sBi056KTD/g4c
 tuo0CzRap/pv/mdzecuTRohKq+obubW15wLn7Zh7hrOyqqt7xHO+rPhhbV+HNFTwqrIM
 TDKRKMMYVe+ccnEa+WKqmc/ObE9lwPbtTFQlq027uzZRsN0t8V9Fzl6qSIAb+RxZIeMq
 v/XA97gsG+oAIoXyFuKhvn48KXBWAoWnIdrkZqKqSaoFS5TU0CisywK3Ame98ZF7k60j
 nAJLMedCnqYhqNPAN9HEBl9mwu8a+M7MY7TSe2bD19Pmo9DrPWYiKwb7GD5/hp284g9p
 dfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661617; x=1747266417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iy4NKdbqFEoI1LwuiWAT6ispFyw4zHMXwGZpZSKm4tQ=;
 b=V40LJ6dSieBHngrNvXUF4yGpJCLn+dm6eCd9RC/rEGCkjYFUCo0M1L2N1tgdLT4D67
 7/mVmcBVXwibkEeyB+hCax7F6NtsM7x/o1yXzfbJ4zO/faVIncrzajpqegHBwW+W/A4y
 97yiZKtbMEVY9pfFzqpAErIzwUqlTFHbyQnaTInamHafVP09oyyyRl9rJhuceI/Xof7O
 AF9QU2JQUNlerQTEQagv0MdqS7/CNNInfUv0++tsrxkJRC6H+Pdd2XpxGcL7XYARZFwf
 hwJ73Ev1hIQ7hocoIPWN72YvWXvainYI1ukgMo79I/qgeTbv97H6qO9jejmKAN+ys69c
 Ckbg==
X-Gm-Message-State: AOJu0YxWDSYGTLND0+dxClytb72RkzOh/f/oVITEf0wLNMc/W7dlFGTR
 JFCHr7Ep58WnW/1ISoomGtB0BFN/t45+w5Ahd0c7wRrb5pWXt4bKp8gZMD6ND41PqEpCEREKTM8
 qBRJINw==
X-Gm-Gg: ASbGncsTD8didGWQvQ0U8cD+N5ToXxctAQopfE5gcdv8reBHweMLf1u+ZLo9UJUF71L
 eijzsP3c/QWaASalf7CuT+NVtoydV2T4RrxwxpFby6tvNTorjJk64ZXJ+QYiQL/nvsVF1yyuCA9
 CyWsbEUexA6tCma3mShdjlDSowjcwh9FMtFLK2ZhTZsVT7HyZRkkUJFCIT/dTE0jfkrNozp9vG2
 W/9G3NgKyTskG4YrCJoUa3lHCTQTdn/mu/CcvyF86golhWsO425zIaQaoR0sAXwFx8BxQZeXq7g
 4YS7QTWfhU/xo1/rzWLJBKKnYFwl3KyvcRGiLtv2
X-Google-Smtp-Source: AGHT+IHof0yGRKomWjIKigklmtvQ5jmLC5TJCNDejIRDGpUvjaUrG8dHyZvJSvt3A8FELVtsKi1m3Q==
X-Received: by 2002:a17:902:f607:b0:224:10a2:cad9 with SMTP id
 d9443c01a7336-22e865f74aamr20930515ad.41.1746661616957; 
 Wed, 07 May 2025 16:46:56 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e97absm100792435ad.62.2025.05.07.16.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:46:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 46/49] target/arm/helper: restrict define_tlb_insn_regs to
 system target
Date: Wed,  7 May 2025 16:42:37 -0700
Message-ID: <20250507234241.957746-47-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Allows to include target/arm/tcg/tlb-insns.c only for system targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e3ca4f5187d..0f3d11b0e12 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7764,7 +7764,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, not_v8_cp_reginfo);
     }
 
+#ifndef CONFIG_USER_ONLY
     define_tlb_insn_regs(cpu);
+#endif
 
     if (arm_feature(env, ARM_FEATURE_V6)) {
         /* The ID registers all have impdef reset values */
-- 
2.47.2


