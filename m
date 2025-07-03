Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037D4C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiz-0006JR-MB; Thu, 03 Jul 2025 07:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgq-0000OP-2f
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgm-00042E-OI
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:14 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451d54214adso56295545e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540471; x=1752145271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jox9I/hc4IW12DCVXl2QtoaQase5UN3XaHbWxSzsiYo=;
 b=MDVjIvFCRztjdN6jd2bcXh4CTaIDwxsgGtkFhXf3uXO7qoD0Hr7kktRWOeMx5+I6L7
 XSCu7i0IR8HQg20bhNWQV0VJKyedH6baRU8XwUJkN0Y2WO58vom2yv0v+zxVJ63iiPnF
 6JswjxuLsv3RP2OYPnMQG71FMdfNsELEd4lfr4fabr5gQIMZP+78+7XIJNlPF9cpWQry
 k8Lfvqc/90ShR299cinR1CXSMWYhTjk8S+9P3PzYldDZW5ZJlHrkkPbEEJW49+dwWs0n
 aoCJTCrTiuhVD+SMEBwtFIBdt0YtWq0lzYoQvcLgdzyaMPnOUNllEtdkvjVYCues9sz0
 zHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540471; x=1752145271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jox9I/hc4IW12DCVXl2QtoaQase5UN3XaHbWxSzsiYo=;
 b=REpAhmQ7LM5BCMbSVkzneTr5kiqkxPNLJQHY9Lz0OT9wsNnQakrwycMDUXZkhQPL3M
 pd+iXQcdkCNOHwg4L1tdMjp0AF+NNy1kTxNrj56sVlJEJlPlCk2WciFGz50yBicunbM9
 drYGeWBPqLY76eZc8brjO0fDBNlWCew8nopru3HsZ96JCAnjRPkuA254ea1Uk8avPsL7
 PYd3skBFh0AgZm7/XqObjeSsCH2vBafbX6A6DcQrG7Zi269LmfzMi/0urvsvkNdrNT6Z
 +JqAJu3mP9zNR+oatcvdgpiw/w5xZw45zshphwGB9NP5mvX2WyXhFt0KD2C28AbiMQHF
 m87Q==
X-Gm-Message-State: AOJu0Yw7xEmfP04kjLk1wr4s561WIrMliBWVBmG5vGZ67tDMxVqooLk8
 +ZzMwX88J3+Pu3hPCK2nBxLf/Z0Yyz2pnkd8XPgDL1ta4ewc3TmyV4x4op/owyMstafDfhFaq2r
 THUExLpI=
X-Gm-Gg: ASbGnctuvS+xAeSmrafye8X4pKDc9Fh4puDtQAk9+2lzgJsOSWc2onSGrJCX9D/Bt00
 n+uEV7TfkAELKMQg2YY5PpG9LQKM8+YTb3HQp9//7R0EZDUitsURXtT27B1iIxspG2YXPLHtZ3h
 e7cGfpU7hhUynfCjzH+FAO7WHkqWSFc4Yule0Kxm+MRkpC0QxPcys0/KCjnYzvRC6NNOg7InAcr
 v5PuP8B8fVIEje/tycAQp+u9NmYUM147vQ8VlqzCt72H8qPU6XqxhnAumexGqsQuV/fyN6FEcOS
 lPpeDcO6dzqxOyqx5+Q7LtuJfev3ZWEplaumawWYFowcemjji0uJ5LbwZHeL7fpRXYGxDzcJIQO
 2+8il2dBA84I=
X-Google-Smtp-Source: AGHT+IHAtbR+hufxeMURDPAweaVvkz8bA98tXT/yfuO0i+zP0XtJFFoPdGy8SpZsMLysHsZr5JSWzg==
X-Received: by 2002:a05:600c:8b43:b0:453:6424:48a2 with SMTP id
 5b1f17b1804b1-454a3d23106mr69823115e9.10.1751540469774; 
 Thu, 03 Jul 2025 04:01:09 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997e24bsm23541895e9.16.2025.07.03.04.01.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:01:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v5 62/69] accel: Always register
 AccelOpsClass::kick_vcpu_thread() handler
Date: Thu,  3 Jul 2025 12:55:28 +0200
Message-ID: <20250703105540.67664-63-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
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

In order to dispatch over AccelOpsClass::kick_vcpu_thread(),
we need it always defined, not calling a hidden handler under
the hood. Make AccelOpsClass::kick_vcpu_thread() mandatory.
Register the default cpus_kick_thread() for each accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/system/accel-ops.h | 1 +
 accel/kvm/kvm-accel-ops.c  | 1 +
 accel/qtest/qtest.c        | 1 +
 accel/xen/xen-all.c        | 1 +
 system/cpus.c              | 7 ++-----
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index dc8df9ba7dd..e1e6985a27c 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -43,6 +43,7 @@ struct AccelOpsClass {
     void *(*cpu_thread_routine)(void *);
     void (*thread_precreate)(CPUState *cpu);
     void (*create_vcpu_thread)(CPUState *cpu);
+    /* kick_vcpu_thread is mandatory. */
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
 
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index b79c04b6267..a4bcaa87c8d 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -81,6 +81,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->cpu_thread_routine = kvm_vcpu_thread_fn;
     ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
+    ops->kick_vcpu_thread = cpus_kick_thread;
     ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
     ops->synchronize_post_init = kvm_cpu_synchronize_post_init;
     ops->synchronize_state = kvm_cpu_synchronize_state;
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 47fa9e38ce3..8e2379d6e37 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -66,6 +66,7 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->thread_precreate = dummy_thread_precreate;
     ops->cpu_thread_routine = dummy_cpu_thread_routine;
+    ops->kick_vcpu_thread = cpus_kick_thread;
     ops->get_virtual_clock = qtest_get_virtual_clock;
     ops->set_virtual_clock = qtest_set_virtual_clock;
     ops->handle_interrupt = generic_handle_interrupt;
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index a51f4c5b2ad..18ae0d82db5 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -154,6 +154,7 @@ static void xen_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->thread_precreate = dummy_thread_precreate;
     ops->cpu_thread_routine = dummy_cpu_thread_routine;
+    ops->kick_vcpu_thread = cpus_kick_thread;
     ops->handle_interrupt = generic_handle_interrupt;
 }
 
diff --git a/system/cpus.c b/system/cpus.c
index efe1a5e211b..6c64ffccbb3 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -486,11 +486,7 @@ void cpus_kick_thread(CPUState *cpu)
 void qemu_cpu_kick(CPUState *cpu)
 {
     qemu_cond_broadcast(cpu->halt_cond);
-    if (cpus_accel->kick_vcpu_thread) {
-        cpus_accel->kick_vcpu_thread(cpu);
-    } else { /* default */
-        cpus_kick_thread(cpu);
-    }
+    cpus_accel->kick_vcpu_thread(cpu);
 }
 
 void qemu_cpu_kick_self(void)
@@ -670,6 +666,7 @@ void cpus_register_accel(const AccelOpsClass *ops)
 {
     assert(ops != NULL);
     assert(ops->create_vcpu_thread || ops->cpu_thread_routine);
+    assert(ops->kick_vcpu_thread);
     assert(ops->handle_interrupt);
     cpus_accel = ops;
 }
-- 
2.49.0


