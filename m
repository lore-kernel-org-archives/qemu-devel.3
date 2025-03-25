Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA93DC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwQ1-0005xK-VS; Tue, 25 Mar 2025 01:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwOC-00042C-Kk
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:50 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO9-0005ym-VY
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:47 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-301c4850194so7515151a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878785; x=1743483585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFUKmZL89sYZSB0AC07VWMO1RZJQlXSAYHwQi6w+77U=;
 b=Xc2FBGEy0wMvdhCHdPPo1/Ozo7HvpIDHPGsmqXwlApP7gNQ572YZahdKkDUXibKYFX
 a3YUMkrhtkEXrW4uQnsVa8EqFB/nj5t4knAhbmFXUt17UIdyyqLkwAYmMugdnW+zz6R5
 dk4IcV+rWsyVelFzAvemIOFqTZhu9Mg7K82Bh2v5rD0kfKt+XYFSF0aGL2llGjSbOJCX
 CpfBVWCareQC+x0oM3sRVAou13uIwAnxJzqjexLd3hAXxC2SkU0v5fCCpmGxB3Cp3EqT
 G9HNzMj7018S0H1hFzXtZx+pIfrDi9LzrM3lj3OIJ8eDur9dyiisheWVnbWmXqlH5lEM
 Bn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878785; x=1743483585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFUKmZL89sYZSB0AC07VWMO1RZJQlXSAYHwQi6w+77U=;
 b=caYsN6o1QGYIiuCqDTxDwART9s1jEmcN96VonxXajO6y1yF7kOZsMvFu2R7pY8tbTA
 Q7mrwzNPehKAf6c7/ED999ufNcMIk/KmR7pQJUcNa0f82mBUJ6O4SkFYD33vLwUFFKbK
 1ShZl9GREBAx5B96q6OTlM0mtYhNKaLWlogT0PTTuKY6WC18VV4gEVwyuIBXLRK9VK9l
 f/MOXrecfCnNAbxJ1tYcUlbru97jL+DO6GKWyorNermMO9puA0vbdMICvK5/XhxG1ORp
 Z8sLPFxwSi6m1Gxv0LDSpLL31gcst/AYleYEdU+ZrQOlgR36thn+A4wqMjn3HrKmMNvg
 AqEg==
X-Gm-Message-State: AOJu0YzTAlrqtyMUW6kX9KJ9dHcv0rZs9Fc38FcYwEpySkysTnVLZTv0
 wAS2XcEndFjAsnbEPclqESR8sc9gGrgv9QMZhD29Ap6ftvips0GNot5LmgTw7QAMJz0JGcm9Vpt
 e
X-Gm-Gg: ASbGnctEa26c7tjFF3y7fXXKlx3rxxyIqlbyPZ1bkX+53Wt8neaGaPAgxK4s0JkReFu
 fnwRfiVVCB121hB3H6wm59L9lPkU/xrMNPkRVgcbLttPtkBg18l45HmLgXvR36R9ljj+a8VhyMM
 9V5JClFvfPD0puRxoDGUV9nW0WK7d1/kYJt2czqJWnft+iN1NJIVxh5qq23T0W6rfs39GHJFtKY
 sEbhf46O98wnQ95dWOrs6MzQXlOH1NRWxOKLj4Y3xY6hev2oS3JAcwrK/Ntt8ftGwWbvvCk9P+X
 w2UnVx430dkT3k9SZxaLxCuhPDB/wSJ+y72Hy9JzcIqf
X-Google-Smtp-Source: AGHT+IGzn0ZGA2yyhJM9CpgiHL9SBWuGcmvmqiHcbR5yuPfCRFgOow8H3weAwCmoy8McjCHWxqFWgA==
X-Received: by 2002:a17:90b:2747:b0:2fe:a336:fe63 with SMTP id
 98e67ed59e1d1-3030ff10879mr26301744a91.24.1742878784581; 
 Mon, 24 Mar 2025 21:59:44 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 24/29] hw/arm/boot: make compilation unit hw common
Date: Mon, 24 Mar 2025 21:59:09 -0700
Message-Id: <20250325045915.994760-25-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

Now we eliminated poisoned identifiers from headers, this file can now
be compiled once for all arm targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/boot.c      | 1 +
 hw/arm/meson.build | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d3811b896fd..f94b940bc31 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -14,6 +14,7 @@
 #include <libfdt.h>
 #include "hw/arm/boot.h"
 #include "hw/arm/linux-boot-if.h"
+#include "cpu.h"
 #include "exec/target_page.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index ac473ce7cda..9e8c96059eb 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,5 +1,5 @@
 arm_ss = ss.source_set()
-arm_ss.add(files('boot.c'))
+arm_common_ss = ss.source_set()
 arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
@@ -75,4 +75,7 @@ system_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 system_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
+arm_common_ss.add(fdt, files('boot.c'))
+
 hw_arch += {'arm': arm_ss}
+hw_common_arch += {'arm': arm_common_ss}
-- 
2.39.5


