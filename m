Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D216C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 03:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRO0M-0008Mo-6R; Tue, 09 Jul 2024 23:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0G-0008Bl-UB
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:24 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0C-0003ih-7O
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:23 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70b04cb28acso288615b3a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 20:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720582098; x=1721186898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0cIhWH6OEJemS+kJXsh28axF2DAl58UUDvwEZ1uXTo=;
 b=FwaWKwD6fw41dp84Se4QEk+a9GWDCq/nQiMEe5qQv1dJkAzY0TwkLYh480r+ZXTvLw
 H8QN7tkiSZKkj3Z8II74sG3LjydQVJqLUZiAnP5hF0uuEcoPTzRJlx7ZMvL9Sqh+eiLo
 mHWO8QuwD6USu+6QyGLwmiWKHwmuV3p9MnpxKR3R/X2zdcOt81dvBGapTNQb3oH5RL8y
 vqPjRl/rr0pL5cY5oH750EJvdYrtA/FPQryiRqvG/9/CYAWwQEcD/e7Ap7Z7gM/6H7mG
 gi3lGYy+R5B25Eg7kinsfiI/KJj4eFphc3fMk0ftDoxmxsYl/+lmN5DpVgvAEgHVYJh0
 N+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720582098; x=1721186898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0cIhWH6OEJemS+kJXsh28axF2DAl58UUDvwEZ1uXTo=;
 b=ikoS4eUCYu+ftC+E2FtGieW+UOeIzOEnHCOAadHXq5R5SSinAb6MvrFQEY9Wf0UKXx
 Q8PRu5znoB43XarqLteSjcysHWjSwnQ7E6NLoRlt1EAhK8IzM4LlgFHnv5A6+Us0IqDi
 6gTdYD9NJHonni+3kfrsxDA644PNWJ+AjQD5IlTc4XN9+WauTCjOQNdcoGwMkfldRXxv
 vWEm3H1tkQsCRp2keEQ6bSSKUCH9t9L0Iq13qzWUACjMZYk/bxrSW09fi4BeF+wF6191
 I+dxw/aaFIke9CIEdvFLp4FoRfdHXydaWKltaQ5DZbQsn+LtuN4rNPw3oCM6H2jKQUHu
 dF9w==
X-Gm-Message-State: AOJu0YwVD6Eph04gAahFuO63lQzG8YulXUZmr+lFnXPwNi8L9IMwQ8Sd
 EZmoDoKsxLZkuwuTBcgsUBelHEeGehdsmCW7me+WeOSNVwJSnXLlU3wbEkf7ztm4T7hzQJtlOgl
 zaUE=
X-Google-Smtp-Source: AGHT+IFsBZkeNWprhEiIONDitlnD0lwr0WMurcSFHm6ZQU78bIVQEsuFb0bC6SV9WRRQp+hCtC8Qpw==
X-Received: by 2002:a05:6a00:1da7:b0:707:fa61:1c6a with SMTP id
 d2e1a72fcca58-70b54edbc15mr239348b3a.10.1720582098138; 
 Tue, 09 Jul 2024 20:28:18 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438f5679sm2687280b3a.90.2024.07.09.20.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 20:28:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, max.chou@sifive.com
Subject: [PATCH v2 02/13] target/arm: Use cpu_env in cpu_untagged_addr
Date: Tue,  9 Jul 2024 20:28:03 -0700
Message-ID: <20240710032814.104643-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710032814.104643-1-richard.henderson@linaro.org>
References: <20240710032814.104643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

In a completely artifical memset benchmark object_dynamic_cast_assert
dominates the profile, even above guest address resolution and
the underlying host memset.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d8eb986a04..ccfb9349a3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3309,8 +3309,8 @@ extern const uint64_t pred_esz_masks[5];
  */
 static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    if (cpu->env.tagged_addr_enable) {
+    CPUARMState *env = cpu_env(cs);
+    if (env->tagged_addr_enable) {
         /*
          * TBI is enabled for userspace but not kernelspace addresses.
          * Only clear the tag if bit 55 is clear.
-- 
2.43.0


