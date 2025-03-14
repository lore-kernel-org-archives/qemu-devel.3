Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32823C28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4uF-0005A6-T0; Fri, 14 Mar 2025 09:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uD-00059X-VK
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:53 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uC-000169-3K
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so20110455e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958210; x=1742563010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uuNgLNZaj6en9G9psqN457RUFRID5SO7T7BkCrfJY3g=;
 b=o8R2UbEDMYg27zH+heF52+OXiOpkWoPCePgcDZQFbHIqf82Jd0M81rQvZRq1xpolhh
 t/giiWqpic9ViEM29rxyl+9/SbsiEKqg+j3Uz6q+iO6SLn2sRduUD2BPJhBkC7ciisMC
 HUjveku7adwMhhQxgX/AHeeH7/zqSvw9njv3a0Ul+Ur2aXzo9P0schz7d043ZUf7Hdkq
 zvou2dF9Hb4fKRQB46xjvWPGjpBJE7jqls1skXmyh2OG6QKe8hP8lGqdAcokd3e+4PhD
 VOru4ENJCWBpJ/7+h+8dbevZXQhsUGRbgAxAvi5diBQEYivkH+gJU92pBtFImkpatDo4
 tBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958210; x=1742563010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuNgLNZaj6en9G9psqN457RUFRID5SO7T7BkCrfJY3g=;
 b=Ae8oDal5jP2Pte/bOE1D4FOUvSm8tw24M0uMEM2WobIk/sLM3L6tXDD+iStHyxcS2t
 eWo/ND1oTmocHk/G7ONxJJGWZVqlwcF+JA/HdEQut/wXAJDOQkyyKAUTkCjLF2ctpWov
 1e/m3RIRLH91L0uEVR4ChHz/OpHxZUmnlTYrj6jQhScfdCai6nE60a2xvzT2MCOMo0kT
 5Hf8CHVFCyVDWlBkpBWPniHPBIDEoebSUmpA+uKWwJ+a0IRvUYitz/PDWAicB+Zou6r8
 7+1gxN+RJPxQhftbq5k3JDAp89zmxLfbeasFN7vYaa1jGc9O3Qtg+EEFJhDe/2mU4Gf6
 Z3Ow==
X-Gm-Message-State: AOJu0Yx1kL5hB974m9ho0PtSPJCpznmluKk1QZ5r0aByIdS+GJ4abhTB
 k9qDo5LI4AsNcAyEWjj4TRF62Cr9N52cH9VtJO+JtfTmIzZj/sYfWk6tiheuuygi1x1c4YHgXHU
 C
X-Gm-Gg: ASbGncs4/RilsPV2pR+QUQT0RX70xmF+VgjMYZ0eqevc9xTKKkrsiw6FM2l6r8hoeTV
 NHh1WvtjvgP6Qazxgmxklxm/vF/3wBEWXncHS/QeGFtP9DgS5XyQ28+Ln9PhlQDrNMMgfHpbk1U
 2xp7ouLzJ1xtfcxD08+LvwOmMNQujG7ZdSSYZc07E1zm/AsHkGEwUqbx3LQaWOPpigTcNrFSqUF
 IfyoXUh1lhDQhymNUkmDqz7hZyqXxwG9ibqUJBaFLxfjwwDAj1W1yFBET6tdMWBAZbGhZ1pTROD
 Yo/5lJvMzddZ5p259/vQuoSt7gW4gvhi2Tg51PWhqJbtt6v8Ri8=
X-Google-Smtp-Source: AGHT+IH2qoeygHMlFTATJnHaoj6Ti9yS+JXzwsGkUbBFzyOssSzJTGoHQoxi9CuHBZ9uU9/NLf9g/w==
X-Received: by 2002:a5d:6481:0:b0:391:2889:ade0 with SMTP id
 ffacd0b85a97d-3971d617448mr2863374f8f.18.1741958209617; 
 Fri, 14 Mar 2025 06:16:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/17] target/arm: Forbid return to AArch32 when CPU is
 AArch64-only
Date: Fri, 14 Mar 2025 13:16:30 +0000
Message-ID: <20250314131637.371866-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

In the Arm ARM, rule R_TYTWB states that returning to AArch32
is an illegal exception return if:
 * AArch32 is not supported at any exception level
 * the target EL is configured for AArch64 via SCR_EL3.RW
   or HCR_EL2.RW or via CPU state at reset

We check the second of these, but not the first (which can only be
relevant for the case of a return to EL0, because if AArch32 is not
supported at one of the higher ELs then the RW bits will have an
effective value of 1 and the the "configured for AArch64" condition
will hold also).

Add the missing condition. Although this is technically a bug
(because we have one AArch64-only CPU: a64fx) it isn't worth
backporting to stable because no sensible guest code will
deliberately try to return to a nonexistent execution state
to check that it gets an illegal exception return.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index e2bdf07833d..9244848efed 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -678,6 +678,11 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         goto illegal_return;
     }
 
+    if (!return_to_aa64 && !cpu_isar_feature(aa64_aa32, cpu)) {
+        /* Return to AArch32 when CPU is AArch64-only */
+        goto illegal_return;
+    }
+
     if (new_el == 1 && (arm_hcr_el2_eff(env) & HCR_TGE)) {
         goto illegal_return;
     }
-- 
2.43.0


