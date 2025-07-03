Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A34DC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNqc-0000XG-IR; Thu, 03 Jul 2025 13:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqI-0000Lp-EJ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqF-0001mA-7x
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-454aaade1fbso1244595e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564121; x=1752168921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8Y0CRVizP1zJqDvu7p6UAH96w8jBU8Dg5EX+XjEepo=;
 b=fmnBokGwDUfu/oPx67VSQWogkwzoHRhzlpD/Lea43l5XkXhBn1LIvNdE6h3fuHHCIs
 R83cJ/mOppNrPB5M+yc0/nKDBX3KXbqk9a5dhRsq81ES26WYqF7u/yMH7htrJD7JoDTl
 l6r2FHLeaXezL4gS3Bl2h/iU2x35df0STnA5LB86Ps/Ps8Zpx0orSZai6f4wk8uYelcm
 fYjWV/iD0BYsHUx2TszGAWeGl5cHy7bUq50y8cDDIGT29W9KQaFV1/jTvS2SlAOyHSJ4
 gWns2tPFWsjwyMhNvAHlM3AGJkuvVMlFE4fKn+jEWP+vMK+z6fY0v7XG/98hK5JxnSz8
 nmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564121; x=1752168921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8Y0CRVizP1zJqDvu7p6UAH96w8jBU8Dg5EX+XjEepo=;
 b=n6+kPr7TItOUlcZaGsUZ2RlfNjdHhyhI64c6bNhiC5OlfBdeXLRrt721oHHWejVqOK
 5oxpz1kVlCd3EDqltQnwKyrRWwjNzULL0DUpFxzVWDvqzZ45LQpBz4uD+ryExkU+yshw
 2C4w7YGMoMjQbkp2W/bk233hBcpdIkk9vlY0n8l4HqhG4PEfZ75mxOwO9j1FD3QbTHws
 CaSF/qZ/UEZ8p7Ml4m8maf1ZQWeqnFcAuqwMMZG7/gxZ8JtFXXgnN+ze5qEUnTJwBxVf
 tT2bETkG/KjhorsTTs9lftNrxlOvdyC1xvm/fQQJUQNPlBAHlO7bWB/izczegpXAbKmO
 Hbag==
X-Gm-Message-State: AOJu0Yxn4OjdC0kx4VonG1Puo9/fOi9/d0XM9jgubEyjP52paKEvBMz5
 kpD0qV7H2VLiJFiVzgBDV+MmgihksptOKtKugSZQGmThaRm30GMKy/90nwHrxuTIK/1X1tFsl8D
 /u6+HhFE=
X-Gm-Gg: ASbGncsGEhMyoVpo8KMw+k+HEOWKxEbF33itk5GHW6gcDHJN14mBzrMC2xgO85ylL7I
 /BSeGGccOXAQI+L/xZqEOrwaiIjhPp/+y4BXbgnBzsmDLNTZeV1c0NVdQX54v6msHCZnwR+JgBG
 uny9YV3f1pV0T4BwoMiM+6AkvK8GUjf4Gl0x+AhmQKxM5AMz9uA0T2lbMFzo1zBOIi0dqMuj8/B
 9SseFUCjkoab07sSSKTSLR84UNkmo4QbBLItSEUcFOx3W+4zYxVNA6RnD5UOkomicI1Zaliyy+/
 tRtv5ep9by/Z6upkEdwgBLmGjsoqOnwNZBvdQ0Dxpib92pepdEYukg+DoEaxKnGphSL9TJfdjVE
 doO19xyMeBKdPhRqceWxTEBwXoL2vhApj9t49gvOMNwc/j+w=
X-Google-Smtp-Source: AGHT+IGUIGmRkNOsoFJDwtp7VUBuEXsARIcb9sOIxx6CN5f0AbT6nqsmy0amztwXgQM0zaIcj6KsKw==
X-Received: by 2002:a05:600c:4509:b0:441:ac58:eb31 with SMTP id
 5b1f17b1804b1-454a3705065mr72661285e9.20.1751564121250; 
 Thu, 03 Jul 2025 10:35:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b161e8fcsm3703765e9.7.2025.07.03.10.35.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:35:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
Subject: [PATCH v6 28/39] accel: Expose and register generic_handle_interrupt()
Date: Thu,  3 Jul 2025 19:32:34 +0200
Message-ID: <20250703173248.44995-29-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/accel-ops.h        |  3 +++
 accel/hvf/hvf-accel-ops.c         |  1 +
 accel/kvm/kvm-accel-ops.c         |  1 +
 accel/qtest/qtest.c               |  1 +
 accel/xen/xen-all.c               |  1 +
 system/cpus.c                     | 10 ++++------
 target/i386/nvmm/nvmm-accel-ops.c |  1 +
 target/i386/whpx/whpx-accel-ops.c |  1 +
 8 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index d84eaa376c2..95a0f402cde 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -61,6 +61,7 @@ struct AccelOpsClass {
     void (*synchronize_pre_loadvm)(CPUState *cpu);
     void (*synchronize_pre_resume)(bool step_pending);
 
+    /* handle_interrupt is mandatory. */
     void (*handle_interrupt)(CPUState *cpu, int old_mask, int new_mask);
 
     /**
@@ -84,4 +85,6 @@ struct AccelOpsClass {
     void (*remove_all_breakpoints)(CPUState *cpu);
 };
 
+void generic_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
+
 #endif /* ACCEL_OPS_H */
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 2944e350ca9..a0248942f3a 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -353,6 +353,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
+    ops->handle_interrupt = generic_handle_interrupt;
 
     ops->synchronize_post_reset = hvf_cpu_synchronize_post_reset;
     ops->synchronize_post_init = hvf_cpu_synchronize_post_init;
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 99f61044da5..2a744092749 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -95,6 +95,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_post_init = kvm_cpu_synchronize_post_init;
     ops->synchronize_state = kvm_cpu_synchronize_state;
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
+    ops->handle_interrupt = generic_handle_interrupt;
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 612cede160b..5474ce73135 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -67,6 +67,7 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->create_vcpu_thread = dummy_start_vcpu_thread;
     ops->get_virtual_clock = qtest_get_virtual_clock;
     ops->set_virtual_clock = qtest_set_virtual_clock;
+    ops->handle_interrupt = generic_handle_interrupt;
 };
 
 static const TypeInfo qtest_accel_ops_type = {
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index c150dd43cab..c12c22de785 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -153,6 +153,7 @@ static void xen_accel_ops_class_init(ObjectClass *oc, const void *data)
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
     ops->create_vcpu_thread = dummy_start_vcpu_thread;
+    ops->handle_interrupt = generic_handle_interrupt;
 }
 
 static const TypeInfo xen_accel_ops_type = {
diff --git a/system/cpus.c b/system/cpus.c
index 13535a74e6f..f90b8be9eee 100644
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
@@ -674,6 +670,8 @@ void cpus_register_accel(const AccelOpsClass *ops)
 {
     assert(ops != NULL);
     assert(ops->create_vcpu_thread != NULL); /* mandatory */
+    assert(ops->handle_interrupt);
+
     cpus_accel = ops;
 }
 
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 21443078b72..a5517b0abf3 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -87,6 +87,7 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->create_vcpu_thread = nvmm_start_vcpu_thread;
     ops->kick_vcpu_thread = nvmm_kick_vcpu_thread;
+    ops->handle_interrupt = generic_handle_interrupt;
 
     ops->synchronize_post_reset = nvmm_cpu_synchronize_post_reset;
     ops->synchronize_post_init = nvmm_cpu_synchronize_post_init;
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index b8bebe403c9..31cf15f0045 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -90,6 +90,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->create_vcpu_thread = whpx_start_vcpu_thread;
     ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
     ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
+    ops->handle_interrupt = generic_handle_interrupt;
 
     ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
-- 
2.49.0


