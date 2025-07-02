Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5D4C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hH-0007PQ-GL; Wed, 02 Jul 2025 15:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2g4-0006N2-8e
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fy-00036d-Bm
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so34436075e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482759; x=1752087559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJXngZXoNb3ayqx8JesLlBPxtZzFSrHUe1FnH3EcOyc=;
 b=nurf9l+2I6E7yL70j1qKVpysQZvhNDYYKQNuil9yTjBP4qlDqOHOI5SfLQSg/lXTxR
 KstQrSkgcc6dNnL6dsJSDw+UF11XD/2QN9Rm3unhqg3BUVDIeR9IKil0bjpDsdxyiJXe
 sKqpoAYU+mB6k+AkhjZQwTJ1cmbt0jkMvcbG6Q2/Y/a4iMME09MJwtROnM1HMsTR4d3z
 6HiOCSowbGRZCTg1yWvQAyGmKMRGPnp3dSWEL4DM5zvYFqbP9vOJbG6HqH+VPI1Bbbk5
 LZ8lDbC7UQLKiGALZ0rn3QBW6O8/UNbK1ujGBxAb8xUZ+hsesPCL/jUxnmoAKlcQaeJT
 f8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482759; x=1752087559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJXngZXoNb3ayqx8JesLlBPxtZzFSrHUe1FnH3EcOyc=;
 b=o3DdmospdxW8ySQhB9JxWFavZYPsUkaM2WxURXki0Gcj5klN//4VwtgkuOv6aAu3o5
 zvy70LMr23Kc1paaN+GenJqjq/QKkoutMEPkGn2vaC2/edi/aHlr0IsuOzskPoXLHCjG
 VFPUqGiunxv4u0p/Yitplo8FCRf7eiDhnqse8e1CF5StsBUlrIsuCpIRQwFRtjpuz6T1
 9L36oRbpYlKdKsJhZzTPylh+ipt8lCymRCE5pDwfN33hXTT/kJmF5zLKPgou+fCxCAoc
 bj9ytLTzO+mmwk0C3R4vZTi9F1utVfoapls5xgex3VzPLPOUJ+Icj/nZOVxIuKN45q1p
 1QNA==
X-Gm-Message-State: AOJu0Yy6IF6MCWipLCgfCBhIEAdWn0RP9y0Hz4/AeWvxpz3KDLI1gWof
 jo9/b4Y2luzDoTiQMXBR6RXQOUOgk98D1/sMZowwHFzXS2IKihcO+bzqzYuN8H3jPiuXChQiMCd
 PBBmH
X-Gm-Gg: ASbGnctkdSYWmkvqGR3UoyKvgvzu7yQYSwkmgcIiPhijumm9pg5SZms6Ocz+Ty+FBdt
 a5pmDOI/YSrxctRB9u+7n0g05cPi0iQDyTvRcryhd07WbpIgdb/VWSv39ijeQg7idgDI229zTKp
 UOdpkmRc9EhVmTAHI20HN59mNfmmt0y5SxGPYtkG8EFLOMPjBZamI6tB+FxscUfPBCql+I7gfd+
 lsV32meEBVhoSKysHOIo1J99oC5NXUGeXP90qZe03upwOKl4hFvNM8Eo7LqXxSiICnqOSiAs7Zf
 ajDl5iOtw2q1eXS4p+KzK5888mxzkzdYshGPyWUyyUliwn6ugTz9F79dsG0sRM/qF0zEi7Zhpp5
 JYjnQOlSn5GVVMXTI8I4YZq2Y8Z3xAzozr2ef
X-Google-Smtp-Source: AGHT+IE3WTlBrg79f8JEGuLCHU0UFZS44rNmXX17pQSMB1LxsBRr6tiIwSkJPMQ9jDC7VsiDr5lFPQ==
X-Received: by 2002:a05:600c:a086:b0:450:d568:909b with SMTP id
 5b1f17b1804b1-454a36fbdd6mr44010245e9.14.1751482759507; 
 Wed, 02 Jul 2025 11:59:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a999c8cdsm5790005e9.24.2025.07.02.11.59.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:59:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 48/65] accel/dummy: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Wed,  2 Jul 2025 20:53:10 +0200
Message-ID: <20250702185332.43650-49-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index f412ea346bb..e2ad42c0d18 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -152,7 +152,8 @@ static void xen_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = dummy_start_vcpu_thread;
+    ops->thread_precreate = dummy_thread_precreate;
+    ops->cpu_thread_routine = dummy_cpu_thread_routine;
 }
 
 static const TypeInfo xen_accel_ops_type = {
-- 
2.49.0


