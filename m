Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5304C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcEc-00051O-Dw; Tue, 01 Jul 2025 10:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcE1-0004R4-DM
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:47 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDr-0007Am-CA
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-453643020bdso50252245e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381072; x=1751985872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JG7IVf4lLmqrXEKy3G052dw+Cl/wCwnu6XXEaswVetM=;
 b=AogcnzBxiptzO3zA85iOHtMXV4L8z2Pbu/uCfEJUiyfTOQbdKNnFWWrZJ9jOAQEydD
 JAs1H05GI7g7VAOpDLDlry0rOWQbqVjSXB5k0bDMgugDUWPIsZT7sfriTcWlX7oq7QGx
 Dnce+cec5y+bQKkj0QWxcJb3xVGSdD+ZHPPnpUARfBAJkiGL/EMQjz9IluODEVZ1cQ39
 eKhH+gqo38ebdKN49ivK2oyHNk9o4n3O9YKqZsh0xlgDy9TgkKC/VS9VvDYSzErprWtU
 MQTFI6DslODXHO616Pk/QRM/JwQCxOewKwh9aJSWnmTzqmicrG7FJclfhIq9zN1hF1Hg
 HOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381072; x=1751985872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JG7IVf4lLmqrXEKy3G052dw+Cl/wCwnu6XXEaswVetM=;
 b=wk4k0sgqqg8SuWACMkClHXb5dVJR+VWag28tpW/lRY6eT8xhohw/W/kx3u9g9+vnR2
 CQx4/1P9tRJ+3jjT9LqrseK8Q40E/8STiJa2YbqbiqwSfyEfr2rPQ1swSOpbget/s4oA
 XU5DK2M79g5e+HiFJdpLmWJNFWxTITaXy5/BIgu6T75VvZxUdOwYIwj6vRl/GiqqALyo
 3XGi9fAJvhqdVlNSrYUv8HRhBdKRm0GE3txYm6leM0TKSRnUx17a2xA6B2l1ROx0GpY0
 3e5cbbAfE637CqOaoMPhcKlXAEOpG6ZwPxiQkqejbg71H6DetPyTLJKtbzwdqO7iDvyq
 nX7Q==
X-Gm-Message-State: AOJu0Yw5n2HvKeBaTCIa8F2hewst11iXCnd6vqDlXmEZcCDBMM4yUPwz
 jVYbhJ1Fk9HjacI7tMAHFumf+2JH1luswjKVL4ggqbOqO05EZhOIJ9/GqVfV+oQ42sxB+G8+zQw
 YqLkH
X-Gm-Gg: ASbGncuC9AjyZZ54S7aZJoNjSDrOaO9c6Q2FTAzAwSenrruQ505f9FfFouEKsxITFaS
 TXDcZHSLBAO613izhiPpGpNKJiAHI4hLj+5nuD/J1i5usJjVpoA2lJo3aBtvpO/GjIWWRWvsyuN
 sk17UrXAbXg5ixnsY3azJNl/ZWk/+D6Q9TRgK6siT2Z6IqtFAlwX8bD6cWccpDTAW35yApeqHvO
 /U9aweguxkFNnrJsxAzreBIXEfvGr2jJF6oj0tGJTJ2rUgNh6+UD2YoDki36WpVA1LGdENqNEag
 SyNBn5Mj9eO9uDkOj2R8dFddhlJnoyS9qqzsBZhK4vvTmGgjC+L3G47bLzaNtj52h6reisLVZvJ
 l45TKd/H4fyq0jSMhQxiLVcB3QM1N7q8uMp8A
X-Google-Smtp-Source: AGHT+IHjYmBry/eiqeZse5ixDuJ8XAp29tFdoqGDENAlVadTX8ukBfwUV/2N+2Gh2hhxXYr991fNXQ==
X-Received: by 2002:a05:600c:8712:b0:451:e394:8920 with SMTP id
 5b1f17b1804b1-4539341e446mr154208405e9.27.1751381071728; 
 Tue, 01 Jul 2025 07:44:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a43325asm165949155e9.16.2025.07.01.07.44.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:44:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 48/68] accel/dummy: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Tue,  1 Jul 2025 16:39:56 +0200
Message-ID: <20250701144017.43487-49-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/dummy-cpus.h  |  2 +-
 accel/dummy-cpus.c  | 14 +-------------
 accel/qtest/qtest.c |  3 ++-
 accel/xen/xen-all.c |  3 ++-
 4 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/accel/dummy-cpus.h b/accel/dummy-cpus.h
index c3af710ee8c..c2f9fee164c 100644
--- a/accel/dummy-cpus.h
+++ b/accel/dummy-cpus.h
@@ -10,6 +10,6 @@
 #define ACCEL_DUMMY_CPUS_H
 
 void dummy_thread_precreate(CPUState *cpu);
-void dummy_start_vcpu_thread(CPUState *cpu);
+void *dummy_cpu_thread_routine(void *arg);
 
 #endif
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 2cbc3fecc93..f637ab05e32 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -19,7 +19,7 @@
 #include "hw/core/cpu.h"
 #include "accel/dummy-cpus.h"
 
-static void *dummy_cpu_thread_fn(void *arg)
+void *dummy_cpu_thread_routine(void *arg)
 {
     CPUState *cpu = arg;
 
@@ -71,15 +71,3 @@ void dummy_thread_precreate(CPUState *cpu)
     qemu_sem_init(&cpu->sem, 0);
 #endif
 }
-
-void dummy_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    dummy_thread_precreate(cpu);
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, dummy_cpu_thread_fn, cpu,
-                       QEMU_THREAD_JOINABLE);
-}
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 2606fe97b49..9f30098d133 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -64,7 +64,8 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = dummy_start_vcpu_thread;
+    ops->thread_precreate = dummy_thread_precreate;
+    ops->cpu_thread_routine = dummy_cpu_thread_routine;
     ops->get_virtual_clock = qtest_get_virtual_clock;
     ops->set_virtual_clock = qtest_set_virtual_clock;
 };
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index ba752bbe5de..5ff72d9532c 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -151,7 +151,8 @@ static void xen_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = dummy_start_vcpu_thread;
+    ops->thread_precreate = dummy_thread_precreate;
+    ops->cpu_thread_routine = dummy_cpu_thread_routine;
 }
 
 static const TypeInfo xen_accel_ops_type = {
-- 
2.49.0


