Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA44EC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfOy-0008VI-5j; Fri, 20 Jun 2025 13:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLj-00030l-AN
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLe-0004cq-Eg
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so14821615e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439777; x=1751044577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNDNfI0qG9TUFAdzgUh03+hHn2rhRAOW0ter/WGtavA=;
 b=ZdRVTRYqylTzigbeE90Fqm2ff/wKF45Lr118vGnMMOHWyDys0ZQ4A2EAGVbA+lyVKo
 F1D5WvHcRhLtfCKLsvI8UHHMXXvoRlVy5rcr3OzsaUqDugUMX5mibB8orPFQAD4epmTY
 xmEOFVbISWGQlzBj13W5C9MaOOGzIEPHFByHzll0j33s7rr7p/yfTkTiOmgWj/UHXQYw
 nUk6SH7S5JH0XIPPKLLck9yRo7TOCXCScQc3irJiD+6avNwoPgxeOJUMHRWtD4q646Xc
 eUqz4cuJSULL8CqODpVksRpWzJGUWrJ/LHBUTOKPZ3/II0PnKceETUs3RVeziWQ9kjaO
 tkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439777; x=1751044577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hNDNfI0qG9TUFAdzgUh03+hHn2rhRAOW0ter/WGtavA=;
 b=EMbDlwHQV5kexauUun0GjeDFfuiZeIJ34/aWldKhD3ZPQ01O3/i0o4jKPJmeYqHu1N
 z65A8sp3EljJjpmpq10NyipepgK2Nw6zXEAHzy/0HBZe2tGudqi0AjIYLIVkCOjuIQEN
 CGb7fuD9MsvI9gn0BIn0gDXRUfgj3uFzNhNP3WxDnQX88rhdukyQQtJASLRIguqf+aIW
 V1dDxEL3RC+J1QrmWH8f02Re0AphZoIMwejBfJK5XO7JY+xGn0bAG+0k6dByFGQii7Gb
 NtZ3Srnvuamvydrzo+Wrbjlm3llLDmwYWq7GdY47wbCES4CM9lD6njvFqahQ6xnd3fm8
 pQ5A==
X-Gm-Message-State: AOJu0YxsnJRq0ukVH9+lGBWD5ifh8e1rcxH9ibwNIsNxJSaaKT1z/ad5
 OOqlh+iG2sFE1yzinLCqXIya4nRjyP8/Wxz5jh66uVlwg5uoVXNGb3LrsqQLHG6NzpZLmtAxb/T
 Wd3cmOxs=
X-Gm-Gg: ASbGncuLzjCo6scb9FZ97ZBybO/9AaTlSgo9+LPvRm+TEnMXvgU902DuiNMd26FRMCM
 JozZiH+yq3La9E4i6qwVvBnRMaGQlhglK8GkK0qQkoszXV4g+b2+VV1kCATrKE3Xw3cMsovmROI
 M/nxWF1hxsxkeuN1ZdqpggpDMr1ILK4kwsxQD5+8lgsU49gbYY7cYT/MsfKwmAkDZI9jhbK0hum
 1ig0YReV8l7NwsPRGqkhsvk4bAVfvcxOBwkREzPVod0daS0/K/jbj4wPVjZ1/i5xk885IL24xIN
 ViZ+LCON7TA+8K9HaAGkbwB3dAOckIufsiJr/YhPQUpNSfbIkIA+C65j322sJ6LDTOgo2SiyEaz
 M9Q+hiw8A04+mkhC7sfVOZZ1YK2QIKuUAGaYN
X-Google-Smtp-Source: AGHT+IG0QsA0KR2ebvx+as4irkIxDR/vDNZ/isEc/SJI0uoDR/IjDDpsC66q7Fsxdwz65ppaSdz8GQ==
X-Received: by 2002:a05:600c:6211:b0:453:5a04:b60e with SMTP id
 5b1f17b1804b1-453659f5828mr30237315e9.26.1750439776584; 
 Fri, 20 Jun 2025 10:16:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e97ac4asm64571415e9.3.2025.06.20.10.16.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:16:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 31/48] accel/dummy: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Fri, 20 Jun 2025 19:13:24 +0200
Message-ID: <20250620171342.92678-32-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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


