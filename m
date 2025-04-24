Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB429C369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84xr-0006EJ-Fp; Thu, 24 Apr 2025 18:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xp-00063W-JY
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:37 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xm-00012J-Qk
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:37 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso1319443f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533353; x=1746138153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1th2JfqQOr0WO6PQb5KrWdqhbU6h1BSraSzp4IJpkdg=;
 b=X+tzVQIlJvLgkXIsfHlWaIyk2sleU3U19vW13tixokP3o5p9cIgQeqOwUjI9tNFmVW
 uOxBJArbosqUylvbhwn7A2TIiBndykaPz+IYTW68rj2ivBeLINPxHv+jcBZA6tqLhskz
 ShK7i7I3NIBKp6gf4N4WdMqp1NcQPO5BXADLROolIn4HUPvYbSQyTMmAciA0dbZmaWVB
 RcKkyjL1UVsK+ybK4bL0VkMzIS/gcKQtzjFTZmeNy/nTzWDc07YiVAkI/NQp7cGpHut+
 eI1pTaKHC9Ic6KPP8alvt2kbFyR78Rhw7VT/2YlqKx/b5u2HNYDaj7y6G+FrLac27JdU
 YvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533353; x=1746138153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1th2JfqQOr0WO6PQb5KrWdqhbU6h1BSraSzp4IJpkdg=;
 b=IMvPDaUnEYOReXqYMduBkFMTq0+hjSnJ8IZCdHsARM5qfrHD2g7NZkZZkaoBu03ZBx
 dC8CakzM2WvFGAlSUmEBpUk8PtPTAXMHBJ3Lj7k+wZHDZ4WBqkph6/P21rFYsYh7QeF0
 ciqDlXjtU+LBaynvYEcxCo1oql9fnepuZtN4MZ/yEC8sq5NmyS8HvxBKZ+nstxpEY/VA
 WQm7N/Az8C2FrLHb74ELo3PnFAIUaFrKQzFwwpgvtivGQnH++9StayhkvWuZbWmzjDz9
 9Ydal6/hMz11yOCO8wGcDew3ULT1qMNIXz/dL2+1O9oQKqwzkEaKFryMp0eBBDesP55B
 yq3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDTHkXnszKBmXU2hQhtGzWBCCiTu+A6HIE4/6XUkHb5jVqQeyUzggx/WVedCGgZp9NtnFViSWHlx3C@nongnu.org
X-Gm-Message-State: AOJu0YyKZ2NgmY6mymUL6DdvezyeFTyMHUkDE8jHTl8Idvx/ZQvB3FPA
 J6x1KXG5WctluUQO/hphZNyCMoxCcB3jdumuWJu+E6vMvcs8+ky+QjNJzq4VHv8mNLG4B9eN5ZO
 C
X-Gm-Gg: ASbGnctGT7RD++9ujS7Tf0vYTHPb8iBYWBLrizd3aP1BQZpHT06WkahGwveyaReIvS6
 z7tn9mMvcpLFhuZLWpOk2lF7pUk3z+4eiq4RpRhDiXP7VoiLv2fgAAYywu9gTqhci2EIRneqcql
 aM6AoF6yOF3blx5HplDPHLfAIeVs+Rs8YYCZ/36VG3850yV2HjPld7hGh02ws8u/sGg7lEtxIhg
 XA/sUl5dD2cOTtk/Tm9PW0rgP/p8Ruc2IBdawA6Dklj/pFBQUdlgyCyMfXHBdXXWzSSGA1ty91h
 0j9YdkMG7N6lbTtg7J5fxHJKJc2qh5SJJ1DvPksbbK0svZQtt1pbGd6yEkveezzNUsLoQqrMtNe
 TT4slgBhWMSw61LY=
X-Google-Smtp-Source: AGHT+IEWoC4UStBSaHjQVGa4AvT0dRkJPUUK6C5WkTDalnYOLuEvPZHdztZq2WVwXKjARGe6fjYTyw==
X-Received: by 2002:a5d:6da8:0:b0:399:737f:4e02 with SMTP id
 ffacd0b85a97d-3a072bbed5bmr763576f8f.39.1745533353129; 
 Thu, 24 Apr 2025 15:22:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2a2386sm36668235e9.14.2025.04.24.15.22.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:22:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 16/21] hw/arm/virt: Check accelerator availability at
 runtime
Date: Fri, 25 Apr 2025 00:21:07 +0200
Message-ID: <20250424222112.36194-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

It is not possible to call accelerator runtime helpers
when QOM types are registered, because they depend on
the parsing of the '-accel FOO' command line option,
which happens after main().

Now than get_valid_cpu_types() is called after
accelerator initializations, it is safe to call the
accelerator helpers:

  main
   + configure_accelerators
   + qmp_x_exit_preconfig
     + qemu_init_board
       + machine_run_board_init
         + is_cpu_type_supported

Replace compile-time check on CONFIG_{ACCEL} by
runtime check on {accel}_enabled() helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/virt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f29f541ea93..13aa2f34c6c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3130,7 +3130,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
 {
     GPtrArray *vct = g_ptr_array_new_with_free_func(g_free);
 
-#ifdef CONFIG_TCG
+    if (tcg_enabled()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
 #ifdef TARGET_AARCH64
@@ -3144,13 +3144,13 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
 #endif /* TARGET_AARCH64 */
-#endif /* CONFIG_TCG */
+    }
 #ifdef TARGET_AARCH64
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+        if (kvm_enabled() || hvf_enabled()) {
             g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
-#endif /* CONFIG_KVM || CONFIG_HVF */
+        }
 #endif /* TARGET_AARCH64 */
     g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max")));
 
-- 
2.47.1


