Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFB6C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hN-0007ki-1C; Wed, 02 Jul 2025 15:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gF-0006RA-Jx
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:44 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gA-00038m-3w
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:39 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so43550245e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482770; x=1752087570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cde8O5fgh1/x3P/3o29/Z35Bz+QAbkT/6eRH+3hSMk=;
 b=nJQHGe+inoTqfgwmkdzugJTM/BVjIjN9fiBAR8G3ddhjdEA2PNMuftmguyNq/DXCx+
 4vir9VGL93eyat9uW0qoxMlHNDSS+NFAs9dBRllviFYMpaCyzm+RKxQyk/RQ+JYRYK1X
 rlaBML7AGTw9YFFnbcyqif0zb6vgxEbe/6AoPtcyIKh98f3lVFEidKRzNWYX/MQhVicC
 Y9+NkllKRa6BL+h2ifae4+opo5SjBc5NscvI0wgwJgCfzfV1UKI9UNysAthr/gUbfTYQ
 z3gaEu4N6hXPDkwZCVjT5PIaWRctahlsUOLDQwzGxBiJmTV1U9l4kG02Ef09hFfLXnid
 sW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482770; x=1752087570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cde8O5fgh1/x3P/3o29/Z35Bz+QAbkT/6eRH+3hSMk=;
 b=brEj50DJ//0FsMXMIyYUdanFMAD7aU1dnzrlKc+SxQuNJb74GxuJAuI31LRx6kDqjz
 rA3ripxAKM48oxAoMaSLKKd9atwhkLhCQ0OQZqHIDRtXohSgtVnMGNZpeJ8bQ5ZVACEc
 O2FfK0F/HGwegvZAzSExrKsNeJx05oZ86Q6QFKwgeo5AS0aYUzS6PMU5reZ7bCmgkfLw
 JZQmR4YSiIm+8VSPJ1k2YBJMz1uk//u8aW273Y3QGDG2Rq5VX9nxE75BRP/B3GZWPwZK
 J9iC3Qq7qiBUtLQ+b8Gx4KDF07jaMgoc6uW8YESy6QG4B9FC9Bffa/4pSri4joi8cADS
 jPkQ==
X-Gm-Message-State: AOJu0Yzv66E3/nxawuLf+74WRCZ7GpfzQnXW47T21TeFI4xIZuIwUQAC
 gTbkU+Z9RzcShospfy7PsMUs0K1k0Js/VoG4ZLzx1TVKE0nokkBg8gxbIX+QeKSWmpd4VIQ0lcK
 Jsbia
X-Gm-Gg: ASbGnctS7KRtbPsBY07OyM0onAm6sggKI6BjUA+u5bTpnkrclfNPftUJHxszFH/5Oc0
 Eotb5kHG/TG+xI+GvJXdE33hwC3Mu7Co/J+xCz5H+z7VOsQjx7r6yLpX1jVsFqnFnfSTFROVrQ/
 3vG8aENuKFZSZJeoD9ERdzYi+smkLZpYdm9K4LGVtZAp9ZBouwbVQqQeaL5QJa6pujJRqkOtpon
 2eKwPEAeO8xO9BAvDkUkFnVp20X5DCNpgCoFdnfa1qnPB64SuKNOacuZPlCT7YY+bWsZorj8oD6
 9JLOwnOgWmRauKu5sqWDo+WgHrJ3xomGTXND4wrobTTdWyx5S9dsQwKX58qMQDCYGk5aTqp2F6G
 m0s5L65RFOqYi/QlQ/vEfugWpxVfyx2mBARgf
X-Google-Smtp-Source: AGHT+IEION5iJjh0RdDNl7aUNOgbZjk0HJoT8mPdVZ40I/MRJ7FGMZd7B0HmLqh0YANVLN2zhbP0og==
X-Received: by 2002:a05:6000:401e:b0:3a3:6e62:d8e8 with SMTP id
 ffacd0b85a97d-3b200e2a482mr2817628f8f.55.1751482769801; 
 Wed, 02 Jul 2025 11:59:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fab15sm16942979f8f.33.2025.07.02.11.59.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:59:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v4 50/65] accel/hvf: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Wed,  2 Jul 2025 20:53:12 +0200
Message-ID: <20250702185332.43650-51-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index c91e18bc3dd..b61f08330f1 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -207,22 +207,6 @@ static void *hvf_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void hvf_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    /*
-     * HVF currently does not support TCG, and only runs in
-     * unrestricted-guest mode.
-     */
-    assert(hvf_enabled());
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, hvf_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
 {
     struct hvf_sw_breakpoint *bp;
@@ -369,7 +353,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->cpu_target_realize = hvf_arch_cpu_realize;
 
-    ops->create_vcpu_thread = hvf_start_vcpu_thread;
+    ops->cpu_thread_routine = hvf_cpu_thread_fn,
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
 
     ops->synchronize_post_reset = hvf_cpu_synchronize_post_reset;
-- 
2.49.0


