Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566C1C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84y7-0007Rs-D1; Thu, 24 Apr 2025 18:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84y6-0007MK-6w
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84y4-00014T-Gq
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so11460715e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533370; x=1746138170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEEsp3WvcS1IZU1517HV/+srKi3TaTLqQjkTs9SQZOc=;
 b=e+Ty8Y+eRSrd54Xyf6gS99pVTg8KONSDqezKHYKofcnUDiJe6+EyEn/zaKzhsruv0J
 yz/0NjPZlcuXBBFMQ9O9EpN1jf5M0oGGqjQJQ+yu/uAo0i4wxeE3RWMeOsdaYqJw5vP4
 A+YNhUnYrY1+uSBu0Xu/kSTZ7m/HVsZZ6Q7dPNHqyWV6Si/5ZdfOw0uUCAyAGkejTk49
 V8mID3zzyOU4Dngm5icRsDhQy3GGn49U21SjxwooDewZHdk3LMGocssk7bMu/pKtVFwI
 Km2tB4Rs0tZGisUV2M8QrcQY04mGPNKE9aUlaNTSk/D9FHrBj/1d4AoOEBG6px90wWf4
 Le4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533370; x=1746138170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEEsp3WvcS1IZU1517HV/+srKi3TaTLqQjkTs9SQZOc=;
 b=RQwGaYiX6i7BMO8ZdhRzJ3TxN9lvEyrcyQJ0IiAFYjJEUEwb1XbYRaPafzCyoR5GIy
 9sW2M+yyo3AmYnyG9rOmNTrnJ6zxP6RWZYuNzLC263fMQtezrruYh97rtQNU9V77wpOZ
 tqNhR6WA/lcUK2jvqIoc2Ia9AypViI2eFLelfiI0mvrefSRnLEDmo7gDzZ7z+KJC03Te
 nByGp8gJFskNEAlkZ95h+TalH7wf5mUmgMCyMG6QwllU393++bcEJszJy+Z/R9kaEfH3
 QpluXRTZM8vXC26KMaglHBnu4Ns9AatWqKbNDqP87ARjX7npps3XypiYeHhGFtLRuJ09
 Txeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJcHVbNWZTlEwmNzhd+Mx7Zf2FQWsWrHGAgKFRxKi8oWpqKdmWLjk2hD1wvgLueG70tKRHpe4uyTy6@nongnu.org
X-Gm-Message-State: AOJu0Yxk4xCxmbSUheqSOUkVPqbmnC0U63tURTlX/3I35VZbbGO5Vd31
 8qBcPlAws0ChER7h4PG4S9a6UHslWeJQi6Pq0XQeQ1fi5tvRnlvZ65PhapDTj2M=
X-Gm-Gg: ASbGncuViRCNBpGlFj+IZjYzLME7Gsv0VILjH5RoAXzfq3RiRA+hOxNZ4/T41lHvFcK
 eYoBRLgML4VvrfOW12Pc+KTp5pbC2IpasJRbtzzWsZZ4Rra9GnWoJi+UUZdHX1+fEvyQ0uiBAl1
 wAjdMt+dW52juySvbhwaudMDb+A+otZpAsnGGNkXyKRBmEeV1LgzHvvQypaT3QBiSE1qICThO8/
 ejkfraPMkemwKXFaujYfzn4k1IUy80BzqDVkDzt1X9DsPArBSSQ3z7IG3GADLZee/9eDaAPPCi9
 24szL09rzMPt7W+WkK2ci379FjdBzxlsP65RAdkIcSyRBtXooK+D4IFj7u+I4bdruUx0mpJW++z
 A3vhZR5EFJO19fBg=
X-Google-Smtp-Source: AGHT+IFeZ75vFmqeYSS2c0ETGpO5NMiAjsgmuVlTBDOH3KTBhSffvYrKvh5i9H4800kq0mPSJ1Xrow==
X-Received: by 2002:a05:6000:4285:b0:391:952:c728 with SMTP id
 ffacd0b85a97d-3a06cf5007amr3425988f8f.4.1745533369890; 
 Thu, 24 Apr 2025 15:22:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8cd7fsm521991f8f.1.2025.04.24.15.22.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:22:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 19/21] hw/arm/virt: Replace TARGET_AARCH64 ->
 target_aarch64()
Date: Fri, 25 Apr 2025 00:21:10 +0200
Message-ID: <20250424222112.36194-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Replace the target-specific TARGET_AARCH64 definition
by a call to the generic target_aarch64() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/virt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 13aa2f34c6c..566afa4c978 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -32,6 +32,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/option.h"
+#include "qemu/target-info.h"
 #include "monitor/qdev.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
@@ -3133,7 +3134,8 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
     if (tcg_enabled()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
-#ifdef TARGET_AARCH64
+    }
+    if (tcg_enabled() && target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a55")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a72")));
@@ -3143,15 +3145,14 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n1")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
-#endif /* TARGET_AARCH64 */
     }
-#ifdef TARGET_AARCH64
+    if (target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
         if (kvm_enabled() || hvf_enabled()) {
             g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
         }
-#endif /* TARGET_AARCH64 */
+    }
     g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max")));
 
     return vct;
-- 
2.47.1


