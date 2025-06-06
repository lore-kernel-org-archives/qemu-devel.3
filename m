Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FA1C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaD9-0006aP-TO; Fri, 06 Jun 2025 12:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCo-0006Bh-3O
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:12 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCm-0003SC-EY
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:09 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a35c894313so1946011f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228366; x=1749833166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNDNfI0qG9TUFAdzgUh03+hHn2rhRAOW0ter/WGtavA=;
 b=h48OmWATQoOfb1lCMtfKQhArpGp0k7bJw3bRZGaJzo9Fx3L/G5v3AAjIvUze+60kcH
 UMGdDP3nwg5PD9MOaQ5mU+mBmb0LCDFj6TATlyXNQwkxh7bsg+rWj9b2DlcK9Ovt3HiA
 T4AeF+kjEh5o0Blvv52zde+KIPlfbzr0LnoaGxIFxBNn4EubRb7bz5tIQwtzAAlKDvQF
 YyFhyUtk5fwPj88lcoQhMu/SSYCSNrgQovpUojFnxfbdyizBQv/+8jM2RwdadlGUc8nJ
 6FwlFHYXjc9JnnZM1nQCTPSc7lax+3vptw7QIqV8PFO8xO8dBsN1soMFO2Vt2SnNjFM6
 nHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228366; x=1749833166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hNDNfI0qG9TUFAdzgUh03+hHn2rhRAOW0ter/WGtavA=;
 b=VpjEHvIfkhKgWKgYJf2BgMwK7EM5HrA284KZ1eu3Y55JxK1sXyDKu2Bvw38Bzjqh31
 mJbw/4Aii9T8wgaSEnzL072PVgNRKORsU/iiQfGBGsfR+QeSbOJ/fGr6hFg+JiVkDQis
 UxrjLLx1SV0cmGRKidfltF8CH6rNE0k7TxB0+aqEJwOV0Qzcf99+PADmD6/nDhKX3U8F
 s50egIpE8wAX8cK5IsMT6ZqC5ETnnC88vCrJHcSSNHBKvdqRlmYufdVV4WSrx5Ikajhn
 lXVqTnvWN2YmSPcFKu213cxwYNZheemXdTWxhOD2BJW6iAkmDOisC6y8BGy22Vxfr036
 NGwQ==
X-Gm-Message-State: AOJu0Yx7OY2YPh3buKdxE+0wuB2dX/p7cY3mzKm2fmerwMfpXtlnUPBr
 Ypjha93Y9SumkC61JT8B0Kr3L0V5fG/hnjb+6MJg2lkLw8KBJqGXuHyokjMECu9wT9Kie0N7UIM
 1XcYVRkyFbw==
X-Gm-Gg: ASbGncsMwmcpPb0oSXvyTwT1rletFN5VYf7M5JdDWdA5VDvQxws//OhQibHOClW1mff
 A01lQAT0bKl9z8qSKK/h1Pg4vqubD5DTrGzIgZu0OfCFJHQwRX+gOurJmiMXAhFD2zQm6YR7XNm
 +M74ZNwTu7J+LFHqCjHFmymbDnG8rMQDC2esFOV8dUxPQvvnIxqBrWItKTob7Y3dKDN6IhgJOHA
 4CcgobSOx/Ss4Ohb11bY3DGpYusWh05GbQb9g0QK7qYjlkCitfzddBA7Q06kt4LkNkWFpdNDp57
 hqGsBIy83Cx9jmd1EX7BSLe79KR6ELZN4wwaOfxZgIGjPl4O1WRWfCCrGu3R9x7NFwQfbviey0F
 xfTDPvdUVUFT8b1w9Mxpp0KwIttIkMxV+rs+MXiEXFCL4u1HX
X-Google-Smtp-Source: AGHT+IGb9O9jUeVc8U28MjhJudT9XBh0KuYkIeyLBIkTLVk2gTPSrlfcqytDyUJBTDv8R2vcT2Ja3Q==
X-Received: by 2002:a05:6000:24c7:b0:3a4:f71e:d2e with SMTP id
 ffacd0b85a97d-3a531ce8887mr3630177f8f.56.1749228366439; 
 Fri, 06 Jun 2025 09:46:06 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4521370936esm30071185e9.20.2025.06.06.09.46.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:46:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 14/19] accel/dummy: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Fri,  6 Jun 2025 18:44:13 +0200
Message-ID: <20250606164418.98655-15-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
---
 include/system/cpus.h |  4 +---
 accel/dummy-cpus.c    | 14 +-------------
 accel/qtest/qtest.c   |  3 ++-
 accel/xen/xen-all.c   |  3 ++-
 4 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/include/system/cpus.h b/include/system/cpus.h
index bfaa339dd73..e7ca9f4d684 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -9,9 +9,7 @@ const AccelOpsClass *cpus_get_accel(void);
 
 /* accel/dummy-cpus.c */
 void dummy_thread_precreate(CPUState *cpu);
-
-/* Create a dummy vcpu for AccelOpsClass->create_vcpu_thread */
-void dummy_start_vcpu_thread(CPUState *);
+void *dummy_cpu_thread_routine(void *arg);
 
 /* interface available for cpus accelerator threads */
 
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 7c34e6c0fc5..c6756252550 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -18,7 +18,7 @@
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
 
-static void *dummy_cpu_thread_fn(void *arg)
+void *dummy_cpu_thread_routine(void *arg)
 {
     CPUState *cpu = arg;
 
@@ -70,15 +70,3 @@ void dummy_thread_precreate(CPUState *cpu)
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
index c5a53ecb6dd..6930cc4cf3e 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -63,7 +63,8 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = dummy_start_vcpu_thread;
+    ops->thread_precreate = dummy_thread_precreate;
+    ops->cpu_thread_routine = dummy_cpu_thread_routine;
     ops->get_virtual_clock = qtest_get_virtual_clock;
     ops->set_virtual_clock = qtest_set_virtual_clock;
 };
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index de52a8f882a..3bd91889925 100644
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


