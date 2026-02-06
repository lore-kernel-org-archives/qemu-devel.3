Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9B8E9129D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 04:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voDMC-0004OI-Ne; Thu, 05 Feb 2026 23:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDMB-0004Mt-4Z
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:11 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDM8-0003U3-Ei
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:10 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-823f9f81da5so896371b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 20:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770351727; x=1770956527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwB8GQ+jVdd4zLoHgSYFEXrmt93cdA0BGjD0ZGggFvo=;
 b=nWV7jOSdwQ4vRigYhtDfu1g7FjeX5+nQQ65LKc2gyAzPImo5hSTXGWmjLAsQkSICNN
 Oz/Ewr458J9/iC7xTa8NaH22cImeaCZCuM7tVl+pK9u836Is6nanGz3L0404hRNQgQWr
 PLNTuAx0nhddx0t9Zgyh77hqnbyIFFWvymLYYWC+/wUOdDuboso7p3qEHcKo7G+j9EJZ
 2hrYeLgppFQaUE53+kRL2C+n4k3TqyIbHQa1P/vOxtFPTcDUEj8/7edIghOVr56GzDIU
 IXwjYxHl8xjuJGBVqySjQBg0yovog59VD+z8VwwDLSBlf6NlpFo75PV1cmn7e0bZPA+s
 wy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770351727; x=1770956527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kwB8GQ+jVdd4zLoHgSYFEXrmt93cdA0BGjD0ZGggFvo=;
 b=h29CgtI+vyfiP+8IGWlCUC1yacQ83asOTJRbzLGdTnKFPT0b2lkI/MRkNDLanEUmFT
 d4d7ZT2Pg1xYPO1s/aDCfX+vLkJG1Qd3Q4eJWw59uGhZf4KoQIRISi1XYfvjCmKnH8zG
 j7NVLgiJei8/rJZ08CzcK8Bl+L+Z3XTP7AO2tBTf0LO4xt4faXHxgrB12EECpFua7JQK
 J4Y++TtzDQFTEPpd+jq5wOHoZy0veFf3bWNmvVCdsVj3tryRQSKjBZZfa64EdNzWlBRr
 nm163Fk9wL51M1KTX8kC82x7YcpVTcWCHrxCMLn+w/peXL2/LAiFfmFj0f63zbfxXHTH
 JKCA==
X-Gm-Message-State: AOJu0Yw5312eb8/4s/igiqSxNQz9sZ6RniCmOfMq6ySpZhefj01OP0xK
 umb4ifPKKj7ZDNFLI+umTk6SopUA2Co1fkGiuhyIHpgn6ChSE0QdG+OQEr2cbiF/I95PBIfg1pP
 MHTjY
X-Gm-Gg: AZuq6aLWD2hY6ejkEmJ0b/AsecDJ+wZxAMiFqmvQp5NeX975VGYb1IQRAiV86ykFDew
 3kk8D5wbuMl03P14HOfhne7Pw/jh/Q25RQHcH+MxHH2VtawglT1ReyDPs8k4cZarUDgNGXa9gUw
 KLAxQfrvNi9L9Zn58UxgvM5i11YDtG36QW2CxmQvLU1PxANp4ZthIkuzFt27+T47oY0agpQqYkQ
 pSQkqP8mn4O6758X7ZWIUwODNKu12KMi2LklkK2bLW2fRNiA/qbO1ZYspkxRuJAEXVH+mksZuyb
 +VByBU7It4wfcI2m0fjfJ6CVUv0eRQ5QmOlZyeMVlcxUNa0NL+D4wS5Zezy+Pf7PjSieBh0VnyL
 vl31D+WXpKmxfgk8FhVKBej7SWDlASXnz91jVVUvhFrDwFdKZ9MTV0hwnHcR8Xjy24dKqKIkWDD
 3OeXCNxKapQNDSRPibqtnMzqH+1uVuQ7zpC6LwXztrC9tbOe7BG8Xwjeebi+JFxak7
X-Received: by 2002:a05:6a00:94e3:b0:81f:4dc7:d31 with SMTP id
 d2e1a72fcca58-824416f5a0cmr1291419b3a.33.1770351727061; 
 Thu, 05 Feb 2026 20:22:07 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8244168fdf5sm926914b3a.17.2026.02.05.20.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 20:22:06 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Richard Henderson <richard.henderson@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 08/12] target/arm/tcg/psci.c: make compilation unit common
Date: Thu,  5 Feb 2026 20:21:46 -0800
Message-ID: <20260206042150.912578-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

Now that helper.h does not contain TARGET_AARCH64 identifier, we can
move forward with this file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/psci.c      | 2 +-
 target/arm/tcg/meson.build | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index bca6058e41a..56754bde951 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -68,7 +68,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
     uint64_t param[4];
     uint64_t context_id, mpidr;
-    target_ulong entry;
+    uint64_t entry;
     int32_t ret = 0;
     int i;
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 41cf9bad4f1..12f126c02cd 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -49,10 +49,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'sve_helper.c',
 ))
 
-arm_system_ss.add(files(
-  'psci.c',
-))
-
 arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
@@ -64,6 +60,7 @@ arm_common_system_ss.add(files(
   'cpregs-at.c',
   'hflags.c',
   'neon_helper.c',
+  'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
   'vfp_helper.c',
-- 
2.47.3


