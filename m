Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81D7C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHEU-0007qc-Vi; Mon, 14 Jul 2025 07:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzD-0000da-Dx
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGz6-0001YN-Jn
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3x4MUcqLXlcLNlNqAnlK7RqHXSqmeDVXTbJiZ/Tc8c=;
 b=bozquUh0W5wquILfB/+jhwqn+DMe72skEgRpEIPUpimLN4uMPqCtahedCgpxIrqiaRUiTx
 XoNZwHClWS98LG1r5b+Q/zif3uoQGzeUppf+WDyWKMrp45bk96ZSJoU95Bly02LcqED2qY
 K0p77Tf8oD6VDgvXKTCv4/iQaZAmuSY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-dc4gQr8QO66R0gGQvkbs4Q-1; Mon, 14 Jul 2025 07:04:34 -0400
X-MC-Unique: dc4gQr8QO66R0gGQvkbs4Q-1
X-Mimecast-MFC-AGG-ID: dc4gQr8QO66R0gGQvkbs4Q_1752491073
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b5fe97af5fso421125f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491073; x=1753095873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3x4MUcqLXlcLNlNqAnlK7RqHXSqmeDVXTbJiZ/Tc8c=;
 b=dhPefBYqdG45GsuOCkEs8tglUTLPcTfrF0DXPkW4jxsZu5dbFlKLeloudnqgOg6/sC
 yaeZG+B6Zj3Z79EarNdbdHhAOza1zNmqCSa6WN7/HoXVB3AUsQiVsYKp1odyNR4mAvi4
 e2hLT4QPdu2RnhLFW7V29r/+t1o/R62+MO/vFcOpO+8mldZlzh1/YwoI+HWeT8SZZXk1
 h07/h7YQPwktFIFv0VoHThwSTCBMqHQJR5kImKgZ6d8obOCLtiaqS+15vSvtjZd8iM6D
 LWONRXtelL/muSBVeTidHMCZGfYMy7xJ2/bgG0GrbM3Aq6sHudLW3AL3Q3mxWq2UkQqL
 gC1A==
X-Gm-Message-State: AOJu0YwgE1O4ko3fz7yh7Rn2aNqv89DaJU0TyDSD57+/ubSXUSBkeyzN
 VJFUIftRQs2dc13DB8dZEwlhjwAkLzUeGlveGDHhgIGVV1fHUxhjeA6hqbKM9f1LuX7ZV2J+XT9
 Oyh3bIlj9XmPcGgABsXWlbvLQgDY1+KS2PoENsMQfPxoba2TJUdT9eZQYHnSsVnCRq4JOwGOcU8
 uGMBvIN+y73ak+APALfAK3Zoi1NldfjxhnN3hRQ20u
X-Gm-Gg: ASbGnctL+dQNydsqTMdC7IqDkkutT0/5LHHfK1znYmH3D41yKY7vM7RjQIS5XTjGN/J
 8zJI28ENn8vMC24ldjGAhP+aNEQpqgeOqNwVP9uAURIPU1MyaKhrHdFdwdDlhQ+wgQQNtqwpZ/e
 5myL5BDW3xTk91ddQkkcY8w5swomOF+vSt646WEUx8BAmkjDMG3afmNZ8hz9EPYLPzajAhbHpiM
 naLHqBTdQLmKsYHWcMfOa3OJyD0qL3VtTX9cV8YGlxe9JhZd/4tx7IqH5yBYoZSugM6/Ud+CefK
 Foj778JjLr5q1QlRVe9b3BDpPxtXKDFx5OntCIYFGBY=
X-Received: by 2002:adf:e18c:0:b0:3a5:2cb5:642f with SMTP id
 ffacd0b85a97d-3b5f18dc494mr11353834f8f.34.1752491072616; 
 Mon, 14 Jul 2025 04:04:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmxXO4/G4BUjMNpGvCBwoYe32V7chip4duu+HFBVzVwgbIm8LyAaG3gSLmRm6maIg0ch2rnw==
X-Received: by 2002:adf:e18c:0:b0:3a5:2cb5:642f with SMTP id
 ffacd0b85a97d-3b5f18dc494mr11353809f8f.34.1752491072103; 
 Mon, 14 Jul 2025 04:04:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc91d8sm11906809f8f.42.2025.07.14.04.04.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/77] target/i386: nvmm,
 whpx: add accel/CPU class that sets host vendor
Date: Mon, 14 Jul 2025 13:02:57 +0200
Message-ID: <20250714110406.117772-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

NVMM and WHPX are virtualizers, and therefore they need to use
(at least by default) the host vendor for the guest CPUID.
Add a cpu_instance_init implementation to these accelerators.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c           |  3 ++-
 target/i386/nvmm/nvmm-all.c | 25 +++++++++++++++++++++++++
 target/i386/whpx/whpx-all.c | 25 +++++++++++++++++++++++++
 target/i386/meson.build     |  2 ++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4d4e5234246..8fb74b56ddd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -44,6 +44,7 @@
 #include "hw/boards.h"
 #include "hw/i386/sgx-epc.h"
 #endif
+#include "system/qtest.h"
 #include "tcg/tcg-cpu.h"
 
 #include "disas/capstone.h"
@@ -1943,7 +1944,7 @@ uint32_t xsave_area_size(uint64_t mask, bool compacted)
 
 static inline bool accel_uses_host_cpuid(void)
 {
-    return kvm_enabled() || hvf_enabled();
+    return !tcg_enabled() && !qtest_enabled();
 }
 
 static inline uint64_t x86_cpu_xsave_xcr0_components(X86CPU *cpu)
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index b4a4d50e860..11c263004d5 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -19,6 +19,8 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/queue.h"
+#include "accel/accel-cpu-target.h"
+#include "host-cpu.h"
 #include "migration/blocker.h"
 #include "strings.h"
 
@@ -1207,10 +1209,33 @@ static const TypeInfo nvmm_accel_type = {
     .class_init = nvmm_accel_class_init,
 };
 
+static void nvmm_cpu_instance_init(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    host_cpu_instance_init(cpu);
+}
+
+static void nvmm_cpu_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+
+    acc->cpu_instance_init = nvmm_cpu_instance_init;
+}
+
+static const TypeInfo nvmm_cpu_accel_type = {
+    .name = ACCEL_CPU_NAME("nvmm"),
+
+    .parent = TYPE_ACCEL_CPU,
+    .class_init = nvmm_cpu_accel_class_init,
+    .abstract = true,
+};
+
 static void
 nvmm_type_init(void)
 {
     type_register_static(&nvmm_accel_type);
+    type_register_static(&nvmm_cpu_accel_type);
 }
 
 type_init(nvmm_type_init);
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index faf56e19722..22ac609070d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -26,6 +26,8 @@
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
 #include "migration/blocker.h"
+#include "host-cpu.h"
+#include "accel/accel-cpu-target.h"
 #include <winerror.h>
 
 #include "whpx-internal.h"
@@ -2500,6 +2502,28 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
     }
 }
 
+static void whpx_cpu_instance_init(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    host_cpu_instance_init(cpu);
+}
+
+static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+
+    acc->cpu_instance_init = whpx_cpu_instance_init;
+}
+
+static const TypeInfo whpx_cpu_accel_type = {
+    .name = ACCEL_CPU_NAME("whpx"),
+
+    .parent = TYPE_ACCEL_CPU,
+    .class_init = whpx_cpu_accel_class_init,
+    .abstract = true,
+};
+
 /*
  * Partition support
  */
@@ -2726,6 +2750,7 @@ static const TypeInfo whpx_accel_type = {
 static void whpx_type_init(void)
 {
     type_register_static(&whpx_accel_type);
+    type_register_static(&whpx_cpu_accel_type);
 }
 
 bool init_whp_dispatch(void)
diff --git a/target/i386/meson.build b/target/i386/meson.build
index c1aacea6135..092af34e2d8 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -11,6 +11,8 @@ i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c', 'confidential-guest
 # x86 cpu type
 i386_ss.add(when: 'CONFIG_KVM', if_true: files('host-cpu.c'))
 i386_ss.add(when: 'CONFIG_HVF', if_true: files('host-cpu.c'))
+i386_ss.add(when: 'CONFIG_WHPX', if_true: files('host-cpu.c'))
+i386_ss.add(when: 'CONFIG_NVMM', if_true: files('host-cpu.c'))
 
 i386_system_ss = ss.source_set()
 i386_system_ss.add(files(
-- 
2.50.0


