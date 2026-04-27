Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3F6FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH23-000234-WE; Mon, 27 Apr 2026 04:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH20-0001rz-8h
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:28 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1y-00021v-CY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:27 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44261378651so1035171f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277365; x=1777882165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dMU/VWsKmdyzWtFbXIxN14oBh1lK9MG9g4e1e4MZRyI=;
 b=AyVtClKyjIDBKfU8QA/C2R9ZZfQtspU/wEwgILDnne9NSIsOWthdaHyoAO/yEU7LKd
 GmjtQoeVYBi9cwvhxtBZz/kVK+vB2gAKKWB8dyQvBfTrCk0KF66qrNRDi+QmZFShnQoc
 V9sCPcv9J4qCJK+Hqh12zo2wwCEhTlGYpQPk1ZN/gke4oIKbhX3oOL74txM1vhhBqb2f
 SB9VAq9r02mH6HfiiGXKSrBzUQHkFRkX8kqKjGrtF/DNB32X4UWwB4Pi0hoSuzGCrDkb
 go6W3ZPJ79F/Py5FnzXA0YJIctVRleKkPbMlq0lqf7SyRrnUO9j+PBI5f9NTDwDcx2ZL
 IVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277365; x=1777882165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dMU/VWsKmdyzWtFbXIxN14oBh1lK9MG9g4e1e4MZRyI=;
 b=VjB/z9FfVN8uh7nrg0GWr5Cdl1F72+EGsA5pCgnat+gQ3OE0b1b+U4wNyk3W8CMyhv
 YqvwfCXhjwd5bHsOYSKLJjuJU7pVWhZ1UcMNYIydziVqLxfKMd+tG/mICODUwjLp+6q0
 vXywS2YLSTwt60cj9JjrwoLd/jJu7SwsUAzmk3FRAUgPKkCZAk859DGRBKfLNQjddkGS
 NI+HcA6tSKHt4X3Y0z5aoUCMLUKs1oby5cGzbaNlv8HWJsFCcXaW1HYsKbMq5tYr1kaE
 VTFyQjWaqIS3X1k55AZAEnw6x4tLIq0LtUW+DQy2cXR0twX6vAiLShwt9YwxUOANYG1E
 1PnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ98B/czmtkXusivhOcOhcNrlZkQzJvDmLrfScWXrAc+GZ57o6ccSD7TOmqxo9kWhkrmmV8ct+XTTRKR@nongnu.org
X-Gm-Message-State: AOJu0YxozoALbwcDDyCnzhKfkDTQxnzohb/8eOWcFyn7R3nl1bUjPxwM
 qDPfIsv/SSo8rpEZiGGrCGct/2syZoMtmPcS6hLJCM8Esfui86bX+ctcSM9qTXaiwMhGYPR2PBv
 pYfqkcTE=
X-Gm-Gg: AeBDiesEvM6uAGQPla72Z53V2SSvGYHi4Ls3dyQCdr66+WTyXIwmaQ9qmcKJpEG0TE5
 U4cl3XfHW1k5qvuFlZYIbBKkgQ9urKTNhRyVJfBYxzfD534gghO6/ICA50ubX6wkRurRW59Vyj1
 OHD/90Pjv3yff/SlOGkKa2a/bjmGt6O/L7XhvaPWMOPIQmO6HhSAsfl9fvfBtuGbuyCyng18N06
 XqTDwT0HCuvuzT6PI3tdWX/zFVNoE3Q4Dho+mee97iKvBnhwucln070OhE4ZIY5pgaTq14fcmjT
 Lpwh2ZvLn88j4GuT5KKGv0gwquX0bh93q4yUbcq07p0xALZ66E571M38PuLN0BwVhSmC1zwxNTf
 z8e1c0vbP581BR+KBRIZYmrSQvzwsw/AK/HqsOHw65LFChPq3P1gg1WaBd00VFpXTFT5rRcozee
 MLlqgffuAu4MP4g1cNageAvDO2kr47x2dpvTSDK42MTUVQ9BuVrsYGP9d3r1aVxgtm3tUYjB2Wg
 9r+sbq9+uA=
X-Received: by 2002:a5d:5d83:0:b0:43c:fc5c:aa08 with SMTP id
 ffacd0b85a97d-43fe4034413mr65432120f8f.8.1777277364616; 
 Mon, 27 Apr 2026 01:09:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm81205156f8f.35.2026.04.27.01.09.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:09:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 15/32] monitor: Do not check TARGET_I386 to build 'info
 sgx' command
Date: Mon, 27 Apr 2026 10:07:21 +0200
Message-ID: <20260427080738.77138-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This command is filtered at build-time for i386/x86_64 binaries.
By using the recently introduced HMPCommand::arch_bitmask flag
we can filter it at runtime, making it possible to compile
hmp-commands-info.hx once.

Since the method depends on the CONFIG_SGX definition, define it
in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS            |  1 +
 hw/i386/sgx-hmp-stub.c | 16 ++++++++++++++++
 hw/i386/sgx-stub.c     |  5 -----
 hmp-commands-info.hx   |  3 +--
 hw/i386/meson.build    |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 hw/i386/sgx-hmp-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8493b12a342..8f587756cbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -514,6 +514,7 @@ L: kvm@vger.kernel.org
 S: Supported
 F: docs/system/i386/amd-memory-encryption.rst
 F: docs/system/i386/sgx.rst
+F: hw/i386/sgx*
 F: stubs/qmp-i386-sev.c
 F: stubs/qmp-i386-sgx.c
 F: target/i386/kvm/
diff --git a/hw/i386/sgx-hmp-stub.c b/hw/i386/sgx-hmp-stub.c
new file mode 100644
index 00000000000..cf1d9a6344b
--- /dev/null
+++ b/hw/i386/sgx-hmp-stub.c
@@ -0,0 +1,16 @@
+/*
+ * Human Monitor 'info sgx' stub (CONFIG_SGX)
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+
+void hmp_info_sgx(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "SGX is not available in this QEMU\n");
+}
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 1dd8d9afbfa..2b083c77bc1 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -23,11 +23,6 @@ SgxInfo *qmp_query_sgx_capabilities(Error **errp)
     return NULL;
 }
 
-void hmp_info_sgx(Monitor *mon, const QDict *qdict)
-{
-    monitor_printf(mon, "SGX is not available in this QEMU\n");
-}
-
 void pc_machine_init_sgx_epc(PCMachineState *pcms)
 {
     memset(&pcms->sgx_epc, 0, sizeof(SGXEPCState));
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index b575e4ac993..da9fdc0ab7b 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -866,15 +866,14 @@ SRST
     Display the vcpu dirty page limit information.
 ERST
 
-#if defined(TARGET_I386)
     {
         .name       = "sgx",
         .args_type  = "",
         .params     = "",
         .help       = "show intel SGX information",
         .cmd        = hmp_info_sgx,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
-#endif
 
 SRST
   ``info sgx``
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 63ae57baa51..b611fbb5a7f 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -24,6 +24,7 @@ i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
 i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'))
 i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))
+stub_ss.add(files('sgx-hmp-stub.c'))
 
 i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
 i386_ss.add(when: 'CONFIG_PC', if_true: files(
-- 
2.53.0


