Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3B6C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdSx-0007xZ-DE; Fri, 04 Jul 2025 06:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSs-0007nW-1w
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:18 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSp-0006vO-QU
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a6d1369d4eso389469f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624173; x=1752228973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p7fZaNjQsotgFZjH3a21SFT+U7+4VJCz66hjOxfj1Ts=;
 b=kmKAemJszfRUeI8QTICIPb4jmDbTTcbxIBPaFWoGwgrfjO0mDxz7RjWtTJYm43y/ne
 6xHfoj2vlN4H4yVL2E9S3IHaOPA7V4X1/quVdktSODsO/SaE0DiWWRQjjUFDFgXNnipG
 Nvd4L78CtoVi6C6weGYykdY4I2CfSyKj8CZc6jUDU2hPro9ldoYtji8HJI0QmS7RcQMN
 jltH1ahKyP+3Kyrivx+lZIRBoNH6w1jHOj2y33cIVQXhy0fVD8xJtZkLLf4lPZRmHJxy
 wbghYOJgHoRhsR3qvd+TGqHH/do8Wz60CZOXI9lmcZjbVYgrs/gP5FZIg0aEV1deXjHL
 5CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624173; x=1752228973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p7fZaNjQsotgFZjH3a21SFT+U7+4VJCz66hjOxfj1Ts=;
 b=ic6pWt4wtywAtfaZKq/up0urO47hCGR0tt7moqJinaq9RnBneNsB89pKFp4wA2FG9m
 /cwcKFZOMPWp0sjKXilm+hxOnd/HDcbG9c/oskQvt4JmW/f20VNtmKgVtPCMkc/TJn2n
 gbGAdZLQ0CwDxxLSpaEsoMnH5om6eel61ps89XiNYxYbJ/xyq49mGkqNfBWoOaPjXKoO
 J8DCrZidGIlfDPsFBp1gtDyDxtw+iUIaGORuPdK00BAToV2mYv+IeaNqwcP6E4NgdrVc
 Fx8YiPE5isZGN+1nifPTUBjcnbOQM0qCj9siL96i/bq9qI662N4wbzbqQlPVDoSXtPrF
 Gbtg==
X-Gm-Message-State: AOJu0YyM3SmH53fF5hxSERm1xbjfOwQCrm7i2ZtUw28urLbjyp4HVA9y
 O76VKGKZOVU0PahXWXBaKsy4xi+Mv+bcnFxX0zcXPvOWAzEMJYmzykQMdQTZDzQ6Deuer2tI4tW
 pZTQnTUY=
X-Gm-Gg: ASbGncsA2Q/kHRbBnn9ukaAzn8aPG8gGyGvscXZ2Ao6qwBWIWAJjQMERJiA4/fbXfJu
 CjWs24VFkANl32Ec/U0r8CqtTZ9n9C/ukYiTXnGsZad50IXHvzKlHCPFJT2AoR5pCXZ1zuILy9y
 IHRyC7dxGbepDEU37zuDHz7cNFvf//tpP5Zx9jqoH82csJJH7B6Zw9MFLI1DbK8Smvt/QCavKGO
 G26fhznZuZhd/qVNtXc+KYldyEur81Nduy/oU6gxlTSMAEVjRf7aWXSfn6aiNap6CR1YtUSO8Rb
 6AGmegyCNLw4P/9cN0+6ry9GV8s4F6gvnpzi9VP70q6HA18+GWFFmbVxzB3E+IbVMcIEqc77GCc
 DYtLtX57ktancRLx6TJlD/KENfskB1Y/BeOpL
X-Google-Smtp-Source: AGHT+IGYRpo+eZ4WcLWHHZmcPhuk2LH5kNcw/4pLT/n+iGmv40DdPIWKA+KRNunx8y3+4m4dr1FSew==
X-Received: by 2002:a05:6000:2289:b0:3a5:8a68:b815 with SMTP id
 ffacd0b85a97d-3b4965ff60cmr1500033f8f.46.1751624173099; 
 Fri, 04 Jul 2025 03:16:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b470caa1a2sm2074747f8f.42.2025.07.04.03.16.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:16:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/31] accel: Expose and register generic_handle_interrupt()
Date: Fri,  4 Jul 2025 12:14:22 +0200
Message-ID: <20250704101433.8813-22-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
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
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20250703173248.44995-29-philmd@linaro.org>
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
index a4e706b49c9..e775ecc348c 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -62,6 +62,7 @@ struct AccelOpsClass {
     void (*synchronize_pre_loadvm)(CPUState *cpu);
     void (*synchronize_pre_resume)(bool step_pending);
 
+    /* handle_interrupt is mandatory. */
     void (*handle_interrupt)(CPUState *cpu, int mask);
 
     /**
@@ -86,4 +87,6 @@ struct AccelOpsClass {
     void (*remove_all_breakpoints)(CPUState *cpu);
 };
 
+void generic_handle_interrupt(CPUState *cpu, int mask);
+
 #endif /* ACCEL_OPS_H */
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 395b5a8e1c0..be8724ac896 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -353,6 +353,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
+    ops->handle_interrupt = generic_handle_interrupt;
 
     ops->synchronize_post_reset = hvf_cpu_synchronize_post_reset;
     ops->synchronize_post_init = hvf_cpu_synchronize_post_init;
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index e5c15449aa6..0eafc902c3f 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -101,6 +101,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
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
index a43e0e4e796..0d0eec82a2f 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -254,7 +254,7 @@ int64_t cpus_get_elapsed_ticks(void)
     return cpu_get_ticks();
 }
 
-static void generic_handle_interrupt(CPUState *cpu, int mask)
+void generic_handle_interrupt(CPUState *cpu, int mask)
 {
     cpu->interrupt_request |= mask;
 
@@ -267,11 +267,7 @@ void cpu_interrupt(CPUState *cpu, int mask)
 {
     g_assert(bql_locked());
 
-    if (cpus_accel->handle_interrupt) {
-        cpus_accel->handle_interrupt(cpu, mask);
-    } else {
-        generic_handle_interrupt(cpu, mask);
-    }
+    cpus_accel->handle_interrupt(cpu, mask);
 }
 
 /*
@@ -680,6 +676,8 @@ void cpus_register_accel(const AccelOpsClass *ops)
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


