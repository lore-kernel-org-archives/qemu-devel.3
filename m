Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2E5C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 17:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpAJo-0006cv-UF; Tue, 26 Mar 2024 13:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpAJi-0006U1-26
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:10:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpAJe-0006iZ-Lj
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:10:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41490d249e9so3046745e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 10:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711473024; x=1712077824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vawk+LSw2Z6p/aOFRJRkJdEE2smC/bsXUmQB9oTHxK0=;
 b=cZ3suTNG9e/h4HoVLg7oXoqbqoVtdifjmQheYnfWk8KeEH/tTMDeZONo+mqAeoZR3q
 EHFhV6+6X1ZiftsjVhT8MIR2qmqnMFKGWlLY9jI4iEBO2t48TSXen+qMgJ0NdV6KLSoj
 xlRT8gbTx0Af09aIJr7Fb74RYhuRtB3UNwtFMqZxJVkuqSzQKGxruJ+EJXIA5Tnz7BdP
 32WhBqlH3ORD0b1SbrscdZbkb8SV7kSD3zmynM/tCRth8NO2e3aI/jaGcA0n1c6xakdX
 tnEKKaXqaqPA9vHjmAbldbqHFf+9f5HLCADPIVHftptRRJMaSNL3O64toYSYNZ/jSing
 gY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711473024; x=1712077824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vawk+LSw2Z6p/aOFRJRkJdEE2smC/bsXUmQB9oTHxK0=;
 b=vr/5IbD9I6GggUv7kXs7uq5ak4ieJyulPkKqnWlwiUc7+EkwMaLfe1w+B/56PyRAkq
 vpWufFB3I+VJ63SFGT7gNOBCWJxnZXvwlZKXwE6q8eAVIXiPNTgmvtirN4CtmOkF9/5M
 9cKQAIQsJzV0kFPLZmEX8w5tHnmaSCjPBe6U28wxzpmM8zOJ460fF54cYP58TIC3JsOA
 VWSIDZcarGxvuUMFSETfnwmIqTeA/uc7hkSPNu+M9Gqlzy1oNPBqKQ48yMduDuRrjqYW
 YNxmRi5GgPbyjbmWcbePuJsHiRhIIVzIm1uILUqIq831Cm4M6hiPNxqMez5u5ICjmBq/
 dliw==
X-Gm-Message-State: AOJu0YxDHJ4KyNPF9oQH1dEV9Sf+WiPkNmBm8Lp4z1iHK4O8PYoAhmnN
 7Pgizo+GzWXikipnvxDJntkSlwZsFv4Hwbjvco62lhmX9iE0f43Qb3vjyMo2hoiiiSvbiVi4pdE
 f
X-Google-Smtp-Source: AGHT+IGM/rMpQ8tvjUcLuc7wpxw0PrWjMo0YvGkvTuhTiRhPD7BhQAD153EBkA0Kksvi8xG2p4vRog==
X-Received: by 2002:a05:600c:3ca7:b0:414:d95:cc47 with SMTP id
 bg39-20020a05600c3ca700b004140d95cc47mr8419635wmb.30.1711473024252; 
 Tue, 26 Mar 2024 10:10:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a05600c190600b0041480a98bb3sm11430536wmq.15.2024.03.26.10.10.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 10:10:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org
Subject: [PATCH-for-9.0? v2 2/4] accel/hvf: Un-inline
 hvf_arch_supports_guest_debug()
Date: Tue, 26 Mar 2024 18:10:07 +0100
Message-ID: <20240326171009.26696-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326171009.26696-1-philmd@linaro.org>
References: <20240326171009.26696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

See previous commit and commit 9de9fa5cf2 ("Avoid using inlined
functions with external linkage") for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240313184954.42513-3-philmd@linaro.org>
---
 target/arm/hvf/hvf.c  | 2 +-
 target/i386/hvf/hvf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index e5f0f60093..65a5601804 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2246,7 +2246,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
     hvf_arch_set_traps();
 }
 
-inline bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(void)
 {
     return true;
 }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 11ffdd4c69..1ed8ed5154 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -708,7 +708,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
 {
 }
 
-inline bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(void)
 {
     return false;
 }
-- 
2.41.0


