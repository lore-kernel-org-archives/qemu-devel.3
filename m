Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DF6CCF9F7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE69-000704-2y; Wed, 29 Oct 2025 17:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE64-0006xC-5h
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:52:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE5u-0007rv-JH
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:52:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-475dc0ed8aeso2327105e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774747; x=1762379547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnP83I4Pbpr8sS9CrOTJFfkYpAE0M6v2XmUQlH30ozc=;
 b=wNv6fBoH5NN0txuVk/lQxwlmZ4oCYELve6TRP66DRFT6wI50Uf4VOqm5F0i0yoTxc2
 qfycrMjKCjh59+NHig6aQ4tR9qjrfOtMl9AWvT2EoOxU/86JMSam0Dc53G4acDLHInFr
 nKbCEqfqgkObB9aTEgX/Dh9m7nKqPL42HPSVzqZ0Dcwpecsa+ZUbZBHz6w0y5QFC9jsp
 qTLfZhdToyeTtG0h/LGbnQD0MVbmNjWSAi+xrdEeX5WDPYp9B+ug9s1AknrS3t/UaVSl
 /Y/Ei2WvgW1KxhiIPo63Hxr5Qr8j9Nt7HC0ezcMWFLcWKdyAqRICXeWmmnY60XF//lpg
 xi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774747; x=1762379547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnP83I4Pbpr8sS9CrOTJFfkYpAE0M6v2XmUQlH30ozc=;
 b=w0bPBUas9wToKMB+py01ymNiIOlLwaph4OjlGSYsHv4Th5OFaJLXMnRN/tWoy3HGhG
 8XR+SEQmQC1c5xrA83YTH8bu/hHr1eWF7vGWCMm7vwRzWvrKmZX3iGU+gT3SCbCReqF1
 i+hc0p/IkxzWUzxcmdZrRIlHmLn1V6NiC5MYgNESzXUcXLf80Vz8b7W4M3uF0W73q0cd
 Fu+htzOM5FWgpXlQ3EGkp+nwKaFIG1tX68OHN80FMhO3kNTyO/iF3lZZvRYzuFckrosF
 1kZz0VkrXWtCzsog0LjBpKIejWNNc2NC1r2Jm/M6LcXvfSdVhpBB/wqN2fK/u/i3JdCO
 avmg==
X-Gm-Message-State: AOJu0Yzbel0bZ/kmxcWM11FeWfOBhSo5KESMbbqQZ3gIakJXm/U6D/VR
 ZnbDvW5AiDvhnNIL5zdchhe+2wWbyngyNxgul1WXc54szdYIsvsifGtVVAKZ232lrv5wNcLHuVy
 zQzzG1jQ=
X-Gm-Gg: ASbGnculvgSotyAwsTgESycxZ55JqJLeNogeX/dhCSiTGLeUNCeQjkkVDilab34adU6
 W4bAOTTfPwmzbVzIL5Ag6HMlako7JZhhQkMvDK/BaYkrminjxhA3kfegzX0z5mQkKl94GnEbzmD
 1aKLIk2ZyNqRfsBl5pWcK1f9/1/ex+0z1w1Gy4bIJMlH4tmmQ8uQDngss2UeD21QDqpKxaTihhQ
 zvbZXbS9mBvv1f6qrXmO8mRwhHvXKJ+jMm57dnqee3kCkW8J5NsA6TwEBlW8mtfellyr9wLjfaG
 +BFZRj9QoQPir1mq1P6bKArLGTfirgmk20yddbXQO/LiQgOpWjJQs/DwbeE79gFp0Urqa2NUNpR
 gJq4/eRSkt/sfTqOQrCjE0rPIOqvh+DDgYR/9OJpLeMszmHgjWnnZylG0XmrMudC+qEY+Kxe4ZB
 9+P3ct19v/c8Iwn7YLBV8QBxC5TbHCGTx5HlZ31GIDtwAQbJaO9w==
X-Google-Smtp-Source: AGHT+IFcd6kRynCCxxcZRTAiEZ3OdFwV9UPoUU8KHKUZBm3/Dcd0dDlwAd2G33/Db715ibOYStxFMA==
X-Received: by 2002:adf:e19d:0:b0:429:b55d:25e with SMTP id
 ffacd0b85a97d-429b55d20bemr422317f8f.19.1761774746969; 
 Wed, 29 Oct 2025 14:52:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47718493c61sm52654575e9.4.2025.10.29.14.52.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 14:52:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 12/23] hw/arm/virt: Replace TARGET_AARCH64 -> target_aarch64()
Date: Wed, 29 Oct 2025 22:39:49 +0100
Message-ID: <20251029214001.99824-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Replace the target-specific TARGET_AARCH64 definition
by a call to the generic target_aarch64() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021210144.58108-4-philmd@linaro.org>
---
 hw/arm/virt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d3809754460..dda8edb2745 100644
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
@@ -3263,7 +3264,8 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
     if (tcg_enabled()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
-#ifdef TARGET_AARCH64
+    }
+    if (tcg_enabled() && target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a55")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a72")));
@@ -3273,15 +3275,14 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
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
2.51.0


