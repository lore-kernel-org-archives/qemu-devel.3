Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA31C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQl-0001r3-3I; Wed, 07 May 2025 19:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoQ3-0000Yg-2o
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:19 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoQ1-0002dH-48
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:18 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224171d6826so6182525ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661396; x=1747266196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjvN9GkUlSXmzEXtUb9+tptKE6zBbBhkZRx0p6n3iY0=;
 b=txFAaBVqqQj93cnKjk17pjGyjxiddgqaaTts/KZf7jldEDpNH78sLfAlenSZVf10qI
 WJW4qgDzkNhVvIKUjbBH1m1gMo40GUJO+qCpJ2rCFZ8GkL4FpfUB0T3OiL66r7gKlHTr
 7XZY0vM2ddYdAiyuZZBlwNPxGq6cx5HYLP066UFLyy4ygXFRV434RgSuoJ9cx5yjcosv
 n2aoPVakhIKWjx7cg9VyNg+59zbH3f6iI2iKc/YXuAZSCCIUOEERh7jPomu4qO1mF6J2
 +xULkTms5npkKN0MouT88LhFJQd7Rm2Wec/qqD7R6iE6jKff6VlILZQR6FGjQOYQt6LB
 ygUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661396; x=1747266196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fjvN9GkUlSXmzEXtUb9+tptKE6zBbBhkZRx0p6n3iY0=;
 b=Cl9KTQWSNaQTDz4TLWXg9oD9tLT8EoySDwNW6eZBd2fLsqxVt1GWftNuiRWRgAKhnL
 ZNrrHzY0zBx3c3aTkFqrheiuWiylDwObA8HzGtqUB54vmUXqViMoVcVpMZLLl1TMZaxn
 ZkmY7HwR/Bp5svJVrKqyvNMTuZn1RnVezJpc0wW7Gw3zg2kP3Js0RIADOwVpqlGdPDcA
 BkIDQKxLhZo/ePq9Q3c1mRshRjOnO2baNhXe1b1pY8O/kauamW7SD7vw4fRw3zjVYBIY
 +L9KwixMOVGHwqUDnXhPEv42M50iVkK9Ht27cLWtiJCiwSCWgc6GMwJFVrqgbW58dEMe
 +hKg==
X-Gm-Message-State: AOJu0Ywm9orN9SE74hRLLR/PcbQjLAHiFYBBir+WezyOSrXYYnyAU9W7
 n2coebPkjQvF5xSsYkdu5O9zfeHXjGSAK5TUlK2OuWZdyhEYbxvNEikY1qCyh/e7HBSVGAcUUGG
 VMR0WYw==
X-Gm-Gg: ASbGncvoG0JvSsJbOTVM0hQGGXH5lywCNtkals8DvoIS2QP+nX1hvS7duq0/yoon2N5
 9tnuxjbhPy8jCuQ1ek2YpLLiwJgFHuIuLMHp1Z6TY6NOzP8kJCvELrQ48Ln/r0uVQha1HzsyozE
 Pk28xd3J1ukb/pKZE1HrJ0D5dLUCWe0BXi1ot7PtAyUj6J69LDfqq6KnEGrwTp4sqYR3dsyqIOG
 GTqS/YGeZjeOaqPKcpbcq3vYZsL31ga1BOyxu2mLMDuFYsa+3040llpBk8ufuzhZfWDXbb18QvV
 hpw06juvpwlrzo8cTqP/18VKnN50OtnPGQAlcQkQ
X-Google-Smtp-Source: AGHT+IEuW/a8CQcTYfwo7IA2UdMnmDxumG/5lG8CAIvP1ZR+VlXIRxuwUzfmpdZQuGHUomKTI4zmHg==
X-Received: by 2002:a17:902:daca:b0:223:5379:5e4e with SMTP id
 d9443c01a7336-22e5ea70aedmr96320185ad.10.1746661395849; 
 Wed, 07 May 2025 16:43:15 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 38/49] target/arm/kvm-stub: add missing stubs
Date: Wed,  7 May 2025 16:42:29 -0700
Message-ID: <20250507234241.957746-39-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Those become needed once kvm_enabled can't be known at compile time.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-stub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 4806365cdc5..34e57fab011 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -109,3 +109,13 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_cpu_pre_save(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+bool kvm_arm_cpu_post_load(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.47.2


