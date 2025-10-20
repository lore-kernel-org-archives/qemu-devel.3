Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B037FCCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyA9-0007pu-3q; Mon, 20 Oct 2025 18:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy9t-0007c2-0K
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:15:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy9p-0006m7-4V
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:15:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso34364375e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998510; x=1761603310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hifM9suh5wepCIBGkBJ4va7j8JgZZOPIRU8jpQmVeDQ=;
 b=AIBepaDzIyUIqOFchuVUYyEjZymgvY0Djhf8cL/DjsrYe79tTSF118SLp5zglxlnfh
 Njp8ppQXbvRLptxrSZkQS/Mvoj30xPLZTxz8SFfdq/oZTXUh4tv3dbT9pmSfBLyBnXIT
 u93gdpI6qyUicjIdVH/jOF9KdRoEL2QHGTuJdfJJiwkDf65Bn2BVbyxH1w4h+1epYVk0
 dP1LnA+ZLyPl9eaOlOGSxPZuzI7aHGG7qYl83JekXMhTNAQbQxJ1suCd/cEiR8Q1EeB8
 WzNoasbacD2+TQXAz0rpz8zdb2yJRsSVy4Lf4m7NtqTdc1SnIIeqjWo6MvaSNx+HyqrM
 RjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998510; x=1761603310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hifM9suh5wepCIBGkBJ4va7j8JgZZOPIRU8jpQmVeDQ=;
 b=au7jpdTNDbBoPlj6g4C4c7tJvW8k37rhabe1N8e426w0zMD6vhLXgZFZpgHEg5+/G3
 yTdl/cdcve45YlyGeauzu4VJYMbddRSnhhGSKuNGvTPiPFANy/NEWVtcvOaUR7D/h7et
 x2F8niKGNJk/MO4zE8xy/syJeAWP8qaBWrO3y+AyLpCxxj+4eabVcykQ0/SofxjCXumw
 kgWaod6w+x1ha8IkW7Fv8mHe5cTMYaNYwC1BR4NUiP3kMevG3tzUMJa7OHGqYphc7G5Q
 E4tVoAq967vn4T9os7l3vKAJAeqwD0uvV9ab0MxNgcooATSEhUdBgzCc5PFKr2EndEhJ
 a8LQ==
X-Gm-Message-State: AOJu0YwhKDnYRpwteqxwKJ1NVHYvcufg1VwgjIJvsNVeyeMgHKssaK5p
 oKiVGTaX+1z+/F2I1t6qxV9lWitTJxCRlx/oKyQVAr6wD9gb0Xy23OaWwtTtHCgTNUwqjm8GegJ
 WbmGUCoc=
X-Gm-Gg: ASbGnctySFhf8umhzk/STr/fxPQiUkSat+r943Tjt/269twy8v3vExsZ2xTN812q+kF
 MTnzXc2XSZj9TRqjDLKZvIjHi9xxlBW93CjEAS6A7U9rKKaQBcu3DKA7XnCWjNw9pNcAjUENpSW
 DdbEMflYWys3q4YR6QGpWMtlrK8ghNdysUk98uKoYaFc/zZHCTRMxXwuQFN3TNtcYkYZjTwiRlb
 PFwyKUu3nAmyTJdmqPwIN4VnUjFQjDlOXHQ/QzspWB5Jmx1eAgrzbLbrvP3Qy4/6ahmts7FY1F3
 r79KIFlQJGu5KV7M1vhyJXoa4A9XtzjAicrgpxR8cEpAK9Ss1kVTasFqgBsdFbwOcmRDPhD0mVh
 usoe7kQ/eCv8iIvONH4ce775bjBzsdR+390hRW1DC5DI4LxfUvu7pbGiQHuLF5qffx2P9nIJbOl
 RjvZZT9uZKsY5sGjihBqIKXq4e4y9uLytuWBFuqiwMJ2y26/jqBA==
X-Google-Smtp-Source: AGHT+IFOrZjMlZ2sNGyYYceBLSbSiyyaBm/koSJZAxswCBVRztwE4rEdZwTKx1UXtnC6iuB+Y5ckBQ==
X-Received: by 2002:a05:600c:3b98:b0:46e:6339:79c5 with SMTP id
 5b1f17b1804b1-4711724b354mr142959405e9.5.1760998510615; 
 Mon, 20 Oct 2025 15:15:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711c487dfesm237090065e9.17.2025.10.20.15.15.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:15:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 16/30] hw/arm/virt: Check accelerator availability at
 runtime
Date: Tue, 21 Oct 2025 00:14:54 +0200
Message-ID: <20251020221508.67413-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/virt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e19da6fd901..d3809754460 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3260,7 +3260,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
 {
     GPtrArray *vct = g_ptr_array_new_with_free_func(g_free);
 
-#ifdef CONFIG_TCG
+    if (tcg_enabled()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
 #ifdef TARGET_AARCH64
@@ -3274,13 +3274,13 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
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
2.51.0


