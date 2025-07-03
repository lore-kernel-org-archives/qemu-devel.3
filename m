Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A29C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiz-0006FH-K6; Thu, 03 Jul 2025 07:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgw-0000ZN-3E
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgt-00043B-RJ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:21 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so4100176f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540477; x=1752145277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKP0VLAduRG0J485sBOx50Iuc98l/po9P1xQbbf9Dzs=;
 b=KZ67jK23tHuk+hD6jBpkSQIVwRBo4ZDI+g5qC/zL8xZEka5eQKpCGu7ms4HEkNJrwg
 02x/As0thIqipVkV7p78PN1XFeckp0pZJC3Gwew+NTO6TBVEbIjw1baZYl5h9Tr3Wfvb
 Usw7HXJqelfFiXYxa+BCttgfXW91r93xi8+F0YfORfRcnEs+MjnTJA2Q/tYlOdpsNYIl
 aUvVejgFFCOE/37l30a56qG4i5RsssQvO3jhddwc2GFzKh2gKTYYQ2wPu71lO+Vzo61/
 9FTt7MjakUbL6b54EUHtDOYYFPiMZuXJZkk1Ad3CcwpGttf8eme4ZojEF4qlcE/R+k49
 +5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540477; x=1752145277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKP0VLAduRG0J485sBOx50Iuc98l/po9P1xQbbf9Dzs=;
 b=OIkBt6k/b+xUnl70+bJ0eVJbghEa1Xo/IKwknJ1//9eFRUGtLRx9yB6524OH7jpjRS
 QcQjOW3TQhENdnbNp7EQ7khCjEO4gGUNsDpr5G9PhJ4vYbkmYH93tSHlwJeXyiJf9qrD
 o01hDa2McTTq24hMNeNAuDK0cl2WfvPJ+CZ+Ren98dyuEUyjEGCq9H79qCfKdZGnzfxH
 ds1xYUtNJRgmk2RjRKWxySL6Wk0+ugQbkwML0BHt8oqsPo8ZXKeWbMvJYjncpr0GiLnX
 nA9InL9Ip7dyzykQyOqzyYSwrVI8SPDbhh9bAS3m+4+KmV3AFoE335OMsHJ3faf/SJ+w
 RiWQ==
X-Gm-Message-State: AOJu0YxnmqjZF+JiCWVa/85PPbuqlGBl+tfngd04iwaQeUPPnbgoFdAG
 2Yj+nrbxd7t26dKAhUqYYk3d7k53iBorif9y39v1G8Gv0NhVkEQf8m3UiBd9OSP4jepv65ucF6S
 /XgL0t7c=
X-Gm-Gg: ASbGncuShnvrob29ySyprO50X5tJAkXgDaLdRqCQIwrL1hKJmAajx8cUUhPouCK/tw0
 JxHmWECiEOhTBPuWsPgGiFwpZwpFiW8gU4/0jXUNR6ZcFw35mQfGdE4rs20whUCKTibslMXtES1
 HAmjP7dutDOn7f1UWdbp/4YLVQysgyKjBkBishI95/pNMkVoqmClCnrDpklpxOrUsGpPN7wj7Dy
 Oc2YKbNJcq13/55T79+7Ce5bVm8OEnyNDSn0fG0IvdnK1l7Ur40w8qGOnvs4jQtAhc2KzGHvRsH
 OpbQLjNn/vZ1bfAqu9j7YmDGjbdcAVvgDbeNJ3SLEZJ2kIWzizWASBowc7QX4B0qzV6X+w0VBTW
 GgzmJ3AQ6n1I=
X-Google-Smtp-Source: AGHT+IH1waIm5SnslmK1jzYHT2bCe4cwQIZPcz0opPv+3p5nz+zh7l6lVax9Sh2kElftxEKA9kEKhw==
X-Received: by 2002:a05:6000:22c3:b0:3a4:d8f2:d9d with SMTP id
 ffacd0b85a97d-3b200865a0amr5118820f8f.38.1751540475685; 
 Thu, 03 Jul 2025 04:01:15 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e62144sm18640340f8f.92.2025.07.03.04.01.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:01:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, xen-devel@lists.xenproject.org
Subject: [PATCH v5 63/69] accel: Always register
 AccelOpsClass::get_elapsed_ticks() handler
Date: Thu,  3 Jul 2025 12:55:29 +0200
Message-ID: <20250703105540.67664-64-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

In order to dispatch over AccelOpsClass::get_elapsed_ticks(),
we need it always defined, not calling a hidden handler under
the hood. Make AccelOpsClass::get_elapsed_ticks() mandatory.
Register the default cpu_get_ticks() for each accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/system/accel-ops.h        | 1 +
 accel/hvf/hvf-accel-ops.c         | 2 ++
 accel/kvm/kvm-accel-ops.c         | 3 +++
 accel/qtest/qtest.c               | 2 ++
 accel/tcg/tcg-accel-ops.c         | 3 +++
 accel/xen/xen-all.c               | 2 ++
 system/cpus.c                     | 6 ++----
 target/i386/nvmm/nvmm-accel-ops.c | 3 +++
 target/i386/whpx/whpx-accel-ops.c | 3 +++
 9 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index e1e6985a27c..8683cd37716 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -86,6 +86,7 @@ struct AccelOpsClass {
     int64_t (*get_virtual_clock)(void);
     void (*set_virtual_clock)(int64_t time);
 
+    /* get_elapsed_ticks is mandatory. */
     int64_t (*get_elapsed_ticks)(void);
 
     /* gdbstub hooks */
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 420630773c8..17776e700eb 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -54,6 +54,7 @@
 #include "gdbstub/enums.h"
 #include "exec/cpu-common.h"
 #include "system/accel-ops.h"
+#include "system/cpu-timers.h"
 #include "system/cpus.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
@@ -367,6 +368,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
     ops->update_guest_debug = hvf_update_guest_debug;
 
+    ops->get_elapsed_ticks = cpu_get_ticks;
     ops->get_vcpu_stats = hvf_get_vcpu_stats;
 };
 
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index a4bcaa87c8d..f27228d4cd9 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -17,6 +17,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "system/accel-ops.h"
+#include "system/cpu-timers.h"
 #include "system/kvm.h"
 #include "system/kvm_int.h"
 #include "system/runstate.h"
@@ -94,6 +95,8 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->remove_breakpoint = kvm_remove_breakpoint;
     ops->remove_all_breakpoints = kvm_remove_all_breakpoints;
 #endif
+
+    ops->get_elapsed_ticks = cpu_get_ticks;
 }
 
 static const TypeInfo kvm_accel_ops_type = {
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 8e2379d6e37..b019cf69412 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -20,6 +20,7 @@
 #include "qemu/accel.h"
 #include "system/accel-ops.h"
 #include "system/qtest.h"
+#include "system/cpu-timers.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
 #include "qemu/main-loop.h"
@@ -67,6 +68,7 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->thread_precreate = dummy_thread_precreate;
     ops->cpu_thread_routine = dummy_cpu_thread_routine;
     ops->kick_vcpu_thread = cpus_kick_thread;
+    ops->get_elapsed_ticks = cpu_get_ticks;
     ops->get_virtual_clock = qtest_get_virtual_clock;
     ops->set_virtual_clock = qtest_set_virtual_clock;
     ops->handle_interrupt = generic_handle_interrupt;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index a8c24cf8a4c..f22f5d73abe 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "system/accel-ops.h"
+#include "system/cpu-timers.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "exec/icount.h"
@@ -205,6 +206,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
         ops->cpu_thread_routine = mttcg_cpu_thread_routine;
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
         ops->handle_interrupt = tcg_handle_interrupt;
+        ops->get_elapsed_ticks = cpu_get_ticks;
     } else {
         ops->create_vcpu_thread = rr_start_vcpu_thread;
         ops->kick_vcpu_thread = rr_kick_vcpu_thread;
@@ -215,6 +217,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
             ops->get_elapsed_ticks = icount_get;
         } else {
             ops->handle_interrupt = tcg_handle_interrupt;
+            ops->get_elapsed_ticks = cpu_get_ticks;
         }
     }
 
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 18ae0d82db5..48d458bc4c7 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -20,6 +20,7 @@
 #include "qemu/accel.h"
 #include "accel/dummy-cpus.h"
 #include "system/accel-ops.h"
+#include "system/cpu-timers.h"
 #include "system/cpus.h"
 #include "system/xen.h"
 #include "system/runstate.h"
@@ -156,6 +157,7 @@ static void xen_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->cpu_thread_routine = dummy_cpu_thread_routine;
     ops->kick_vcpu_thread = cpus_kick_thread;
     ops->handle_interrupt = generic_handle_interrupt;
+    ops->get_elapsed_ticks = cpu_get_ticks;
 }
 
 static const TypeInfo xen_accel_ops_type = {
diff --git a/system/cpus.c b/system/cpus.c
index 6c64ffccbb3..d32b89ecf7b 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -240,10 +240,7 @@ void cpus_set_virtual_clock(int64_t new_time)
  */
 int64_t cpus_get_elapsed_ticks(void)
 {
-    if (cpus_accel->get_elapsed_ticks) {
-        return cpus_accel->get_elapsed_ticks();
-    }
-    return cpu_get_ticks();
+    return cpus_accel->get_elapsed_ticks();
 }
 
 void generic_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
@@ -668,6 +665,7 @@ void cpus_register_accel(const AccelOpsClass *ops)
     assert(ops->create_vcpu_thread || ops->cpu_thread_routine);
     assert(ops->kick_vcpu_thread);
     assert(ops->handle_interrupt);
+    assert(ops->get_elapsed_ticks);
     cpus_accel = ops;
 }
 
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index d568cc737b1..4deff57471c 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -11,6 +11,7 @@
 #include "system/kvm_int.h"
 #include "qemu/main-loop.h"
 #include "system/accel-ops.h"
+#include "system/cpu-timers.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
 
@@ -83,6 +84,8 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_post_init = nvmm_cpu_synchronize_post_init;
     ops->synchronize_state = nvmm_cpu_synchronize_state;
     ops->synchronize_pre_loadvm = nvmm_cpu_synchronize_pre_loadvm;
+
+    ops->get_elapsed_ticks = cpu_get_ticks;
 }
 
 static const TypeInfo nvmm_accel_ops_type = {
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index fbffd952ac4..f47033a502c 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -12,6 +12,7 @@
 #include "system/kvm_int.h"
 #include "qemu/main-loop.h"
 #include "system/accel-ops.h"
+#include "system/cpu-timers.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
 
@@ -86,6 +87,8 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
     ops->synchronize_state = whpx_cpu_synchronize_state;
     ops->synchronize_pre_loadvm = whpx_cpu_synchronize_pre_loadvm;
+
+    ops->get_elapsed_ticks = cpu_get_ticks;
 }
 
 static const TypeInfo whpx_accel_ops_type = {
-- 
2.49.0


