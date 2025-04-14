Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F23BC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Llr-0000e1-Nc; Mon, 14 Apr 2025 11:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4Lln-0000ce-MB
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:30:47 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4Llj-0005X5-Ii
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:30:46 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224019ad9edso58174255ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744644638; x=1745249438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DOhwcP3937IV4/I3AUCZub2ArCcFcEQmAAV0iFEFVrI=;
 b=mfOCG3j5jT2KAgpvqulZ5Qp3FsIdsha2oUSj3kBX8qS0ZBNGDbrdpR1S2vNhAYxTtc
 RTF0y6HA0Xz9OrTtlwh2EuRVoBk6Ii39J4dFjyBJSQhAEQGbejbfSZnPA2zbCotcQK3U
 I6JBDG91GfJ+aEkZ9NhBwk7YbVfKegFvMV5W8KYpcmE/cB2tUd7N59vlMvxGhbHcNTpF
 YqaIBXtdVjoxikEJdhZrQQzMlqrbizecEpwWF9WRkxTwiQs9zfuhndSGyQD/QKEKt6RR
 Zir+QLpoSEEhR4QjCCs9PLRB5jnPqzr6M6ZiJxXSISZawp/tJrWwM1kRTC0Key+qmpCS
 NWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744644638; x=1745249438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DOhwcP3937IV4/I3AUCZub2ArCcFcEQmAAV0iFEFVrI=;
 b=MknPoqTlSVu30Psx/qG0a7kcy+sOjvQC9+PWDby7mkxbMTtlYIn+T5ZY4akLCXSGic
 20w71L0nLGuq83WAtF1j1w5ygQkK05RjNdR0+DOa70DjDE49KByRWbQS5QFPd1pv7xzL
 mTEcpB5XxgwaWtcfyeFp1A9u/AzfvOfMJauQvvhq3qwp6P4jwEb5nL+YsD1hh+1+cZ9C
 iAQUXZe3A9Gt7iD0tIS0+TuPyZg8j+LdBfExDgbzWr9fZIGDBc7sLIlatIXrOuslmW31
 c/4J7f6XFN1DBRfTlLdwn6ieUH/7NM0SBJplEjfyJ/g0iA7GHsAowtU7o+o+l6D1zdOy
 7DAQ==
X-Gm-Message-State: AOJu0YzXdx/7mQcO9fi6cfe/14rIEJMwFPZzCBRMdDZpWYPF0Px4hTeJ
 gtNOxpErHSWmuGN61M/b4gZCk4lxlSmyVDGuZlF/3mFM26kRW/KmK+SitxT+zLKxgytIRTFH8eQ
 U
X-Gm-Gg: ASbGncuerw3HsYoL04MuoKQR5iL6nTqKuzrthn+d3hnOKZ/icaoqKzJU79RNP0gtILm
 cI4vUbSWTZn8vSKQgDaK1y4CYGCN1gjgM3TijRksTLx421vKbN2WO8h9Kf0oi+MTJP0Y88lKxay
 oz94UDTAlkcdCSCqQGBKpgKpeLSzLGRnY7ywPP02fZP4eNThFzSvIafLUc2Q5PkGjef0PIErNMF
 t7Be0kZrsBxoZpjsMpJqVZGdDTJ1vQCXPJUgtnyAbDezwrmqULLsxwT49I286FzaJSi4TP3seLl
 gY3vqegWUAwNHGQL64A0v0o4auANCGiRMFZEkT+v
X-Google-Smtp-Source: AGHT+IHNJgD2U+K0t5vYeZYvHWnfRgisCyObJFOaeoJMMd/KKVj5+ZOqdLPI4BXOV/Nqm83Dl9Eiug==
X-Received: by 2002:a17:902:f712:b0:21f:35fd:1b6c with SMTP id
 d9443c01a7336-22bea4fc93emr191716465ad.45.1744644638076; 
 Mon, 14 Apr 2025 08:30:38 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm100735235ad.248.2025.04.14.08.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 08:30:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 Yannis Bolliger <yannis.bolliger@protonmail.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/4] target/arm/ptw: get current security_space for current
 mmu_idx
Date: Mon, 14 Apr 2025 08:30:25 -0700
Message-Id: <20250414153027.1486719-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414153027.1486719-1-pierrick.bouvier@linaro.org>
References: <20250414153027.1486719-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

It should be equivalent to previous code.
Allow to call common function to get a page address later.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index fdc575ec8c7..c3e4390175e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3635,7 +3635,7 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    ARMSecuritySpace ss = arm_security_space(env);
+    ARMSecuritySpace ss = arm_mmu_idx_to_security_space(env, mmu_idx);
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = ss,
-- 
2.39.5


