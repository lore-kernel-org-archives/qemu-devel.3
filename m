Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97087C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hU-0008Ds-Ud; Wed, 02 Jul 2025 15:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gn-0006sd-7T
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:14 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gh-0003RL-RF
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso49489095e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 12:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482805; x=1752087605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9AALSKsiWp+fyxrwu3Q2lSvTY3F2dydfTXpwq/TdYI=;
 b=GJ/1cMq23HNjkDClEg1ofn5RpxSLiYZvXPp+RSb08nKmkiBCR92GAZL+wlGwNAG3q8
 SKrh8lFEA7dblaimphc1s3xAZ3IMC1TKC0Qn2haT4E/bYC0xPp6W9/h+f+or7BvCwkIi
 TujgNlYNCj7Fb8EeuAvJTy/+MlmvSi0GL7xgoDbLKPbPNKvmjJp4jnsD56CzksNi31FB
 ANeOnDo1RDZjSJidXVsa1mHEgZq4J920h716mIF5J6WiEyFChYIkUTeUtFFoIWnbkCWt
 y7SMuhIFbY4Fi0mT+SmAJgfsFafoJphcA5tPtzEVwngA4+hT4yGLedLQKnXK2GaMUTaH
 39Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482805; x=1752087605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9AALSKsiWp+fyxrwu3Q2lSvTY3F2dydfTXpwq/TdYI=;
 b=JOaqKoJFrf/3X8DhfxxcL3eHBLO6eE08XJg5BZXv5nzr2zm4+qbZ3zR4Yzoy9HIgdG
 cen67/4i+Gcju4jkZDKGAqY2d8vpR7GLRzPp1jFaGNbyVrKEpQXuHhVStqfRAF/7Djze
 pWhriisi+CJCaPkHmOZNnBObvMo94PZLfP+sWKp4KRCXlTz4ENTndQ4XC5t28R30a8eP
 o9TbLCiSc/JbXi8gekDpmnl867DpL45qVIxrGJr+aiDbDL48TgWIS68QEJi5rR0RW5w4
 GsOgL26oF79rrh8kF6g41Bho9BVnhxA/nvIEeVHQt+VUmsJzeKFH2DAEcrChWPenkGkx
 IxxQ==
X-Gm-Message-State: AOJu0Yy235xluHUqeqlbOHlfs+tW21l0BSiWNlVIbd3vFWtVNXEZNKhD
 bO8RHodWIH1sPmg0y0O7cT6mcznk0EgVOqacevXYk8pL8we26e886VjUMFkNdbgndJaji19pWtT
 L1woO
X-Gm-Gg: ASbGncuU71BlGi/4uFMFuo3aImcwvFcZzrGyQWCHXeY7P2Fe5wvL2uf4F2HCfo3mtk7
 HlhQa0u7j+QRSLo9A0k7eYD0B2e3slQ1tqfk/b4U/FXW1dTBtBWdzcuYb6Yfj3m9CPq9Lqq3UoA
 cxPyCxOkkGlF4X3dvGiZf/Sc5N1rVGna4/CmxfNvZQQm3HMERPcTQ7uYxaRim6AvuXJDgpMPVMm
 aBbtIEwv6FjoVTFndLhH0ZOli3ZhOGReu5twFrYhjy6gMzUwiIe86ogN+y0/KSoMheOFHnQTKgY
 xdTPYVlx6GxEvS9yODtJ8FJ6HSa6h9JG6scC5E+z8SYAR9B4F+MfXWj5cBBBFaIeK8f1HN2J5KI
 E0tJO7o0xv4hH9n5qrOfeEdp3teKFTNi+e1CX
X-Google-Smtp-Source: AGHT+IHuTxwhhaxfDXpwsGGicEITW9gtMOvw6Tfvz+5/juL51xTCIjaJfAoPglR1/D0PNXoYflj/XQ==
X-Received: by 2002:a05:600c:1c1c:b0:43c:fda5:41e9 with SMTP id
 5b1f17b1804b1-454a562a89fmr36055635e9.31.1751482804732; 
 Wed, 02 Jul 2025 12:00:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7ec69dsm16541953f8f.6.2025.07.02.12.00.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 12:00:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 56/65] accel: Expose and register generic_handle_interrupt()
Date: Wed,  2 Jul 2025 20:53:18 +0200
Message-ID: <20250702185332.43650-57-philmd@linaro.org>
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

In order to dispatch over AccelOpsClass::handle_interrupt(),
we need it always defined, not calling a hidden handler under
the hood. Make AccelOpsClass::handle_interrupt() mandatory.
Expose generic_handle_interrupt() prototype and register it
for each accelerator.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/accel-ops.h        | 3 +++
 accel/hvf/hvf-accel-ops.c         | 1 +
 accel/kvm/kvm-accel-ops.c         | 1 +
 accel/qtest/qtest.c               | 1 +
 accel/xen/xen-all.c               | 1 +
 system/cpus.c                     | 9 +++------
 target/i386/nvmm/nvmm-accel-ops.c | 1 +
 target/i386/whpx/whpx-accel-ops.c | 1 +
 8 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 6d0791d73a4..dc8df9ba7dd 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -67,6 +67,7 @@ struct AccelOpsClass {
     void (*synchronize_state)(CPUState *cpu);
     void (*synchronize_pre_loadvm)(CPUState *cpu);
 
+    /* handle_interrupt is mandatory. */
     void (*handle_interrupt)(CPUState *cpu, int old_mask, int new_mask);
 
     /* get_vcpu_stats: Append statistics of this @cpu to @buf */
@@ -93,4 +94,6 @@ struct AccelOpsClass {
     void (*remove_all_breakpoints)(CPUState *cpu);
 };
 
+void generic_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
+
 #endif /* ACCEL_OPS_H */
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b61f08330f1..420630773c8 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -355,6 +355,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->cpu_thread_routine = hvf_cpu_thread_fn,
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
+    ops->handle_interrupt = generic_handle_interrupt;
 
     ops->synchronize_post_reset = hvf_cpu_synchronize_post_reset;
     ops->synchronize_post_init = hvf_cpu_synchronize_post_init;
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 841024148e1..b79c04b6267 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -85,6 +85,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_post_init = kvm_cpu_synchronize_post_init;
     ops->synchronize_state = kvm_cpu_synchronize_state;
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
+    ops->handle_interrupt = generic_handle_interrupt;
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 9f30098d133..47fa9e38ce3 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -68,6 +68,7 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->cpu_thread_routine = dummy_cpu_thread_routine;
     ops->get_virtual_clock = qtest_get_virtual_clock;
     ops->set_virtual_clock = qtest_set_virtual_clock;
+    ops->handle_interrupt = generic_handle_interrupt;
 };
 
 static const TypeInfo qtest_accel_ops_type = {
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index e2ad42c0d18..a51f4c5b2ad 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -154,6 +154,7 @@ static void xen_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->thread_precreate = dummy_thread_precreate;
     ops->cpu_thread_routine = dummy_cpu_thread_routine;
+    ops->handle_interrupt = generic_handle_interrupt;
 }
 
 static const TypeInfo xen_accel_ops_type = {
diff --git a/system/cpus.c b/system/cpus.c
index 8c2647f5f19..efe1a5e211b 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -246,7 +246,7 @@ int64_t cpus_get_elapsed_ticks(void)
     return cpu_get_ticks();
 }
 
-static void generic_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
+void generic_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
 {
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
@@ -261,11 +261,7 @@ void cpu_interrupt(CPUState *cpu, int mask)
 
     cpu->interrupt_request |= mask;
 
-    if (cpus_accel->handle_interrupt) {
-        cpus_accel->handle_interrupt(cpu, old_mask, cpu->interrupt_request);
-    } else {
-        generic_handle_interrupt(cpu, old_mask, cpu->interrupt_request);
-    }
+    cpus_accel->handle_interrupt(cpu, old_mask, cpu->interrupt_request);
 }
 
 /*
@@ -674,6 +670,7 @@ void cpus_register_accel(const AccelOpsClass *ops)
 {
     assert(ops != NULL);
     assert(ops->create_vcpu_thread || ops->cpu_thread_routine);
+    assert(ops->handle_interrupt);
     cpus_accel = ops;
 }
 
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index bef6f61b776..d568cc737b1 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -77,6 +77,7 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->cpu_thread_routine = qemu_nvmm_cpu_thread_fn;
     ops->kick_vcpu_thread = nvmm_kick_vcpu_thread;
+    ops->handle_interrupt = generic_handle_interrupt;
 
     ops->synchronize_post_reset = nvmm_cpu_synchronize_post_reset;
     ops->synchronize_post_init = nvmm_cpu_synchronize_post_init;
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index 8cbc6f4e2d8..fbffd952ac4 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -80,6 +80,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->cpu_thread_routine = whpx_cpu_thread_fn;
     ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
     ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
+    ops->handle_interrupt = generic_handle_interrupt;
 
     ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
-- 
2.49.0


