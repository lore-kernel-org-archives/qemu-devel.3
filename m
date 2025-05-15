Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDF8C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVqF-00028h-I7; Thu, 15 May 2025 06:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnr-0005hW-As
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:27:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnk-0008Iy-Jx
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso7151615e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304815; x=1747909615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oDX/L4H6LWozpQuVjGq8Fpv0Kh4dC814yG6ylUtKBIs=;
 b=FO/RMRwkmWYAIBMyTBz1HVHgAjRZ7HjN2Q6IYjoEin7T12oj5fs0P2EVLwcA7uKyE0
 LKJBc9591ScqmjkH+sna6bIiXAoNdRBzmpFeTMbgfOtU2unj4M/E2yodb0C22WyD0a0R
 omntObEVL57PEo/mWcGzIcV5TkCFgReGW0rE7IfIOvYsklQiBu+97fjPdkuQW0Sk3Ww7
 wADIkj7Fq8MTHBQsZO9zHN3RxyBADd5kxLA1sepgqZcXO/p0MSaXFf9bIbn95j+tlL6M
 sblNuUvOmTDGzJuYR8/Pgx94+dVWNoR0xnl/fG5GJpVNYf3hQuYYv4zXE2B5PMQN5Cyq
 x4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304815; x=1747909615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oDX/L4H6LWozpQuVjGq8Fpv0Kh4dC814yG6ylUtKBIs=;
 b=gIW2Bsldw/AqXDoK6fKXsICq2XB5RMcZsIguO4NSIj37mIRSCBlwn8X44d9cKK/82N
 lDYLGwVX10HL6xhAvqnYKwAFmN5OYHn5GeKDfwk/3pa10L4SvC64g6j2CckQMKuhVZVi
 cxmfVRbSLfRUEvQs8L5RrbjKkBNz5J12eqNC04njB00ADn/zy4saLRubUe4waG5DkFyH
 xLOSRQXr1MvdMwbo2THUWiIlLrhrhkzXHoJrA0HM7tNF7i8R7LcK4K2aZhs2Zzo458bF
 8EUiWg4BiD+08phz7TFMCB2TAZ7kW24M2BViLdKF4eszAUVqF2IUQn9PqGo2vpeG4J3Z
 oecA==
X-Gm-Message-State: AOJu0YyMO1dgYkfFsm545GuMKl46ba3cNIwclP/B/miJT3wXTW0jvKP9
 NdHpjnl2OY6yb9giraAPzZ5JLBPMfL9xHub+axG5Kjwb9+Qu+T2Y8Zvb7xv9jjqSGrAIbboOGX7
 FGIY=
X-Gm-Gg: ASbGncu+KSa5A8Esg2y4DbtlfXPCaAI+EjmVaPY2uW2KF1TA32p3kWxAWc+0ozXCUza
 5uI7HbVXMmczKu505rl7+NA9Nml1SCpR6yV+1tcaPOtHpT669OeZVZKK6P4Z1UaG51QrcwA3u7p
 PwTLzApGiAqkIlgRn4y0bxYcYh3M/Nss98fftestut3a5ax6KZw1EY6zPqWQ8UEm+Qy4SvJAnHL
 gEQTIfNyj9pkqV4UCLYhlRYrI3mlFGJ1vX1Mt+jRLd2qHdt9x46anlyh83Gs8qVh2ZwosUzLY+i
 fkPjJagDwhDAbJBrOBu/d7++M6z7G3o7/vJWCnY4JJ1FXOO1cB1mU07Stw==
X-Google-Smtp-Source: AGHT+IF818A/TT2fkzT527nvJH1q4Zfehv+cptKqxGIcMm5XEI/wTfUq/KRAcF3+a3xfRenipHKOVw==
X-Received: by 2002:a05:600c:8414:b0:441:b3eb:574e with SMTP id
 5b1f17b1804b1-442f96e497amr20146555e9.5.1747304814868; 
 Thu, 15 May 2025 03:26:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/58] target/arm/helper: restrict define_tlb_insn_regs to
 system target
Date: Thu, 15 May 2025 11:25:43 +0100
Message-ID: <20250515102546.2149601-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Allows to include target/arm/tcg/tlb-insns.c only for system targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-46-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index aae8554e8f2..76312102879 100644
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
2.43.0


