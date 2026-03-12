Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F53F106ACEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ooO-0002fi-JY; Thu, 12 Mar 2026 18:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0ooD-0002Zt-Pn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:47:13 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0ooC-0003Zq-7e
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:47:13 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-829781b2b01so1073647b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773355631; x=1773960431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFvmr/rrzoLHUjOFxspMh0UbKJXeRxAJ0yXljP/5wCg=;
 b=s9Fmy7oln6ve0b7r5FHR19LYB5J+flOt4uKyKDtV9hB4KfjHVM8Bs18nJpy+79uH31
 2cnC1Uo3Rf1JILqKFtgpdcx0LSXlZMZO32k7wQ/GaXy+f8n6B4dvAf7oTrg+g78uTJdR
 IwrBrmpF9RdlUWGpZf8sFrVaqQxytH8p5Gc7tpXLuKNYim2Z1mACq3ALSjrLGlUbjpsY
 cu0E8wanbzuwdFygql9gPgNvtxiYxcPjPEeLsnp5y5KbtiRG7O9HWXnhK2bwo/kSrISe
 Z3V0QTeMya6jwCgA2C8lFK+zxPrrS0JXzDZfexgKEIj+u3hbbW6YTSjXT9q9ELxDwWoc
 Gd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355631; x=1773960431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PFvmr/rrzoLHUjOFxspMh0UbKJXeRxAJ0yXljP/5wCg=;
 b=gZzB86KVYa5IAyB1JkeFo0oNTv8fURvGbTUtJAjqdC7dozkBZJHRrN1S5qXGCWgOXR
 J8UyUHrohd/KSpYKXZT6KIi0oK3f7KIfXOZIbnIVmPZszhJHg4+s44UYn9dNNDT+Hh5N
 beV1PY1wR7PxQW215NnJDGoOt7ndUFgO6Oo9BJJmzVxZMvfmj0AdUP5D4nm8Je1tjT3D
 Sur2uP10DI/59qPvgoTFhnl5Xs/WS18ag21JIqHESxxiANAeAzK+/jy3C8cmeu405zWB
 pmtDwb1uADpM3tygZf3rTd73Hzkx43FOQ1r9Ik/l20JSfi8UoLSfvxMJvKZ5qYecJYcw
 ZRVQ==
X-Gm-Message-State: AOJu0YxZ4ho3Y40sNtW4GpdamKVFah//yZafqHtIZ7kCfoLevxz3OdwN
 hkPwFWA1o+iJoz77K0QQU/WhLZm2S5IxzscvHWC2Nx0uXOH3/CugFar0YwNCaenfcT+KzyqR6eQ
 3YMrp+do=
X-Gm-Gg: ATEYQzyUA7O+7yJc2EbbPTgLxT5L7QFUvV1JIiZ+nZxajhgpgjxNfyRDHwDYQ0OQlek
 I2QgQ+3P50pWk24q/oHxDda0m8ATiIx4IdJggrGW4zP2o/ZvIVvEYx0Q5ZqMHsEOQ02xAMqQykA
 x2+A9R5khbqOguxHaZbODgH0DpFVjWsyGsgqiP6HDcoinwIyNATJVSluo/jNiap/5W2oPWOeZg3
 PMNF9MADypoN4MN6tjoen3uX5l2rm3G0+ps59dRsM4MEsDCDgRip0JpXImxQfest7pypYXjtkYq
 mcN/C01HMLV+pU73TjEN4Cgl2oJJjtvOu9q6pEnTatD+KgNfiUcM2N1HjeZcUKdtdeSIP2OKDJ9
 Vj5Ykj+1a/X5TTq3P1YRMpSfk/j18ok77Ly9m+3x01vqMSpX9fwn84Z7i0BBF1H4/KnXfw/yOnZ
 VkAtTc3cgEVAj9+pPxxY/kpytsqZVdNKWFZh3gFraAnOJKjhhwLzqf9cGBWdHv3o2ioc2gJvOVq
 uJK
X-Received: by 2002:a05:6a00:1992:b0:823:16b2:2498 with SMTP id
 d2e1a72fcca58-82a198ac1ffmr768489b3a.36.1773355630699; 
 Thu, 12 Mar 2026 15:47:10 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0725be23sm3992698b3a.15.2026.03.12.15.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:47:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 philmd@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/2] hw/misc/allwinner-cpucfg.c: make compilation unit common
Date: Thu, 12 Mar 2026 15:47:02 -0700
Message-ID: <20260312224702.1608408-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312224702.1608408-1-pierrick.bouvier@linaro.org>
References: <20260312224702.1608408-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

include "target/arm/cpu.h" is needed because of:
bool target_aa64 = arm_feature(cpu_env(target_cpu), ARM_FEATURE_AARCH64);

This file is reused between various allwinner boards, including 32 and
64 bits cpus.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/misc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 96b6705b7d0..392d30b1423 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -46,7 +46,7 @@ system_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true: files('allwinner-sramc.c'
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_CCM', if_true: files('allwinner-a10-ccm.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_DRAMC', if_true: files('allwinner-a10-dramc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-ccu.c'))
-specific_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-cpucfg.c'))
+system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-cpucfg.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-dramc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-sysctrl.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sid.c'))
-- 
2.47.3


