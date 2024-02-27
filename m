Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFB2C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaF-0000hJ-2z; Tue, 27 Feb 2024 08:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaD-0000g9-Dq
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:21 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaB-0002pl-2y
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:21 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso3543412f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040797; x=1709645597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rLfVBib6moPM6Xgbon/d2611Q9D6RHvJCoxeaZ9C+Eo=;
 b=AzT5G/VU/PtEfYVqA2PQNx17QTMUI233vkd6AvAODvP5lqoX6bPeGYElPz77blJInN
 cwf51Xt/3vIeUfJxDKO705r6NfW8G3RipwpSGFoMK/FDBs2eWFBk2kkuuT7x2ze7Aqui
 yshzEwmmWIJTtfOnYSVzkXE6f+d6yovE/TuVobZrptZWisPANojA6L/NLHaof5Wmz55c
 ypu9mITIDFLS3qscRBlQk0D7d8+9Do/HzcFoALd8vegQ5NVc7+3zKjwzTToIy+ExQJ+k
 OyRFcAac/Yq75xM1nmth/cpMEhf+2Km+epbaW+sc8fI/zYlvHudNU5ZiLQusx0wV58mn
 TwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040797; x=1709645597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLfVBib6moPM6Xgbon/d2611Q9D6RHvJCoxeaZ9C+Eo=;
 b=o3kF+Tz28BibIvHRug358I8jmnxriPc0MKfdmea32909LFYDHuFAd9L0EvCWFa4ug7
 /ozQEqXy7o+ed46b1GeX/BOtQ3oo3d2J3XZJNKa1J4dbdK+PNfLsZ6RTBaSbBGMPUr0o
 n9+7uFhRJs33RiEXhrMEGKE/6igJ4v6vlbl1BBqJ9nzTr9/DG9SgLu9g4pq8BhKrN7dv
 aUJ0J/L0L/dNzi2wsX5lQ9nk9vPN7Pkd5MQlqD2raZY5Qm27dvjX1ZhrmWyx/k7605kl
 FFnH4ffzYMufLBqQU3rFWxAfH1TwNkDo07ZIyZXD3EmtvMJ/VsU2s8DJjRAPclmuttyo
 kU/A==
X-Gm-Message-State: AOJu0YxQKW1n2R8TkoKupAIc9PWDhH61+5E000JvUIdyqE6o1umM7OM6
 eQoOiatGOGcM3PgP7la6wPJcZo3DVIm4wLnHLUy4xr6rQkiDhF1I+i7GNbeKEmDBoN6X3bVRDNa
 O
X-Google-Smtp-Source: AGHT+IFAGLqArF5n5oj1D6pl9twQ791m7fR7bMP4bv73XBtSN5UUbsapVF23zYb7B3IpGNeBEIlVqQ==
X-Received: by 2002:a5d:6d85:0:b0:33d:da6e:b7db with SMTP id
 l5-20020a5d6d85000000b0033dda6eb7dbmr4149387wrs.62.1709040797355; 
 Tue, 27 Feb 2024 05:33:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/45] target/arm: Advertise Cortex-A53 erratum #843419 fix via
 REVIDR
Date: Tue, 27 Feb 2024 13:32:31 +0000
Message-Id: <20240227133314.1721857-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ard Biesheuvel <ardb@kernel.org>

The Cortex-A53 r0p4 revision that QEMU emulates is affected by a CatA
erratum #843419 (i.e., the most severe), which requires workarounds in
the toolchain as well as the OS.

Since the emulation is obviously not affected in the same way, we can
indicate this via REVIDR bit #8, which on r0p4 has the meaning that no
workarounds for erratum #843419 are needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240215160202.2803452-1-ardb+git@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 8e30a7993ea..0f7a44a28f5 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -663,7 +663,7 @@ static void aarch64_a53_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A53;
     cpu->midr = 0x410fd034;
-    cpu->revidr = 0x00000000;
+    cpu->revidr = 0x00000100;
     cpu->reset_fpsid = 0x41034070;
     cpu->isar.mvfr0 = 0x10110222;
     cpu->isar.mvfr1 = 0x12111111;
-- 
2.34.1


