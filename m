Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9515EC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kvc-0005Mm-Ir; Tue, 29 Apr 2025 09:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kuj-00056i-G4
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kud-0005ch-DD
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so39867595e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 06:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745932925; x=1746537725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1K2H3VE4tCQOLcXEpqGHsbFF7wzsGTavlqzL6DY4PxQ=;
 b=f5Qah+i3N+JvYx5hiUjmHxSd3UHW/OLMGzGN5WZBGHNeT9GfjrKhCCx81I7goZb+G6
 jXXXijnfDrhhqFnJOqQ31cp0U2MUrbhm3CIm71o6psPiVJ5GtRgMbPa73/ILREIBx6Yj
 ev3nhu6FYxO4T787YfuT43Fawv8AWGkg3Xkr5xANgpvnnnRzoIhZ/ZuwWGLvjaIHChM0
 WxfFOyoZ+OwDF52u986Xh7rZVCrWeHaW+ITXZnN+AWy1QuW3o/bpj96C+8p2+RLbnkc5
 II5qR1D+IOoQfUU7TjEFiBqwQB58HmVWiWHYtKnsKk94UlmQdSGRqt0o14cmaWTbh7r+
 9HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745932925; x=1746537725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1K2H3VE4tCQOLcXEpqGHsbFF7wzsGTavlqzL6DY4PxQ=;
 b=nr1P4m9cS7qeb5A34ODVZ8bgkYgqlE0oWXBequV9pGvGJSHziRz1F5owJD50MGXj9u
 r7Cj9JOIFSAnorTt7aKlzl2GvBts+TakGQdp/MjaTZp1A6umdfCdRCStKxB/CXDLsvaT
 IZ5VZQWAjY5+HXEcA0XZCW4TaBd3EjehJcUtWDY57mm1sZFqP8Um2ylQ2G3MvP3Bs0vk
 P16Pep3cnDHDrIFcuofm/FTa7YpJWWlZno/m1msWuzzYUlD6Y+d/RpLt0c/i8fC+uHrV
 ZuD6NWTRpEue6FURSNemKRkoH6Eycyn/C/MxspxpMangJRNmt2t3OweruAOAesCQdOOx
 HOfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXji3FzwRkcxMzC8ZUDvz8hDJRFn7kJVayL3OaO5dBoxS4PEIkPLqerdWY2TXYdtZbxjNvV3VeQ0XW@nongnu.org
X-Gm-Message-State: AOJu0Ywhshb40loz9QXe5ut9dSXgBxUU3JdP2rHFFPEy32HjrozSi6LY
 6pcuEaeTYFODKiS0vSfd4uQeNSounQxrcEJwqJMo/khjlgISWs+88Zn5CecWR90=
X-Gm-Gg: ASbGncsOle3CPU9sVgjg+y4/9strMctrEMK9OBWyu1vGf+dVlRuiwKnl6c+mesXbwTH
 8++mbl31E3BAIR24JPHkK3UTkzZv6OOsFt7XG/JMHnhhBl1p5ut4UUWPjJOcWHUmQZxyMecODMd
 U5lM/CzyQAPHrP9EExdTnAo/7uiNPA+mUwbaDaJRNnkBeqrLdMZSPd1DAaHcvyXxmrvxB45pZde
 LEVlxrQxCucD/vlx5fkdp/61UgSJbk38y1NTOofcEP0JBYkniOU+EQaoncWLTzKDITx2Dwm2mp9
 b6K9q8FJGGcDi6UpakKhteffWA4zrTuyAeOj1UnhjJlOgWI=
X-Google-Smtp-Source: AGHT+IFAm531afu8IRUjxFRSRK7e42jZB66aW5MzYUCCRrrg2CmJkLzfBZHk3BEzQnLzx8SWYsk1bA==
X-Received: by 2002:a05:6000:310d:b0:391:2f2f:818 with SMTP id
 ffacd0b85a97d-3a08ad282e0mr2327221f8f.9.1745932924757; 
 Tue, 29 Apr 2025 06:22:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5219sm13729371f8f.27.2025.04.29.06.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:22:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 2/7] target/microblaze: Delay gdb_register_coprocessor() to
 realize
Date: Tue, 29 Apr 2025 14:21:55 +0100
Message-ID: <20250429132200.605611-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132200.605611-1-peter.maydell@linaro.org>
References: <20250429132200.605611-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Currently the microblaze code calls gdb_register_coprocessor() in its
initfn.  This works, but we would like to delay setting up GDB
registers until realize.  All other target architectures only call
gdb_register_coprocessor() in realize, after the call to
cpu_exec_realizefn().

Move the microblaze gdb_register_coprocessor() use, bringing it
in line with other targets.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/microblaze/cpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index d92a43191bd..b8dae83ce0c 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -252,6 +252,11 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    gdb_register_coprocessor(cs, mb_cpu_gdb_read_stack_protect,
+                             mb_cpu_gdb_write_stack_protect,
+                             gdb_find_static_feature("microblaze-stack-protect.xml"),
+                             0);
+
     qemu_init_vcpu(cs);
 
     version = cpu->cfg.version ? cpu->cfg.version : DEFAULT_CPU_VERSION;
@@ -324,13 +329,6 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void mb_cpu_initfn(Object *obj)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(obj);
-
-    gdb_register_coprocessor(CPU(cpu), mb_cpu_gdb_read_stack_protect,
-                             mb_cpu_gdb_write_stack_protect,
-                             gdb_find_static_feature("microblaze-stack-protect.xml"),
-                             0);
-
 #ifndef CONFIG_USER_ONLY
     /* Inbound IRQ and FIR lines */
     qdev_init_gpio_in(DEVICE(obj), microblaze_cpu_set_irq, 2);
-- 
2.43.0


